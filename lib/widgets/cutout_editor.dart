import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/sticker_cutout.dart';
import '../theme/app_colors.dart';
import 'glass.dart';
import 'ui_kit.dart';

Future<({Uint8List png, Uint8List mask})?> showCutoutEditor(BuildContext context, CutoutDraft draft) =>
    showAppSheet<({Uint8List png, Uint8List mask})>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _CutoutEditor(draft: draft),
    );

class _Stroke {
  _Stroke(this.erase, this.width);

  final bool erase;
  final double width;
  final points = <Offset>[];
}

class _CutoutEditor extends StatefulWidget {
  const _CutoutEditor({required this.draft});

  final CutoutDraft draft;

  @override
  State<_CutoutEditor> createState() => _CutoutEditorState();
}

class _CutoutEditorState extends State<_CutoutEditor> {
  static const _brushes = [16.0, 30.0, 54.0];

  late Uint8List _mask = Uint8List.fromList(widget.draft.mask);
  final _history = <Uint8List>[];
  final _live = <_Stroke>[];
  ui.Image? _photo;
  ui.Image? _maskImage;
  int _gen = 0;
  bool _erase = true;
  int _brush = 1;
  bool _busy = false;

  double _scale = 1;
  Offset _offset = Offset.zero;
  double _startScale = 1;
  Offset _startOffset = Offset.zero;
  Offset _startFocal = Offset.zero;
  _Stroke? _current;
  bool _pinched = false;
  Size _box = Size.zero;

  @override
  void initState() {
    super.initState();
    final d = widget.draft;
    ui.decodeImageFromPixels(d.rgba, d.width, d.height, ui.PixelFormat.rgba8888, (img) {
      if (mounted) {
        setState(() => _photo = img);
      } else {
        img.dispose();
      }
    });
    _rebuildMask();
  }

  @override
  void dispose() {
    _photo?.dispose();
    _maskImage?.dispose();
    super.dispose();
  }

  void _rebuildMask() {
    final d = widget.draft;
    final gen = ++_gen;
    final rgba = Uint8List(d.width * d.height * 4);
    for (var i = 0; i < _mask.length; i++) {
      if (_mask[i] == 0) continue;
      final o = i * 4;
      rgba[o] = 255;
      rgba[o + 1] = 255;
      rgba[o + 2] = 255;
      rgba[o + 3] = 255;
    }
    ui.decodeImageFromPixels(rgba, d.width, d.height, ui.PixelFormat.rgba8888, (img) {
      if (!mounted || gen != _gen) {
        img.dispose();
        return;
      }
      setState(() {
        _maskImage?.dispose();
        _maskImage = img;
        _live.clear();
      });
    });
  }

  Rect get _fitted {
    final d = widget.draft;
    final k = math.min(_box.width / d.width, _box.height / d.height);
    final w = d.width * k, h = d.height * k;
    return Rect.fromLTWH((_box.width - w) / 2, (_box.height - h) / 2, w, h);
  }

  Offset _toImage(Offset local) {
    final r = _fitted;
    final view = (local - _offset) / _scale;
    final k = widget.draft.width / r.width;
    return (view - r.topLeft) * k;
  }

  double get _brushPx => _brushes[_brush] / _scale * widget.draft.width / _fitted.width;

  void _stamp(_Stroke s) {
    final d = widget.draft;
    final r = s.width / 2;
    final value = s.erase ? 0 : 1;
    void disc(Offset c) {
      final x0 = math.max(0, (c.dx - r).floor()), x1 = math.min(d.width - 1, (c.dx + r).ceil());
      final y0 = math.max(0, (c.dy - r).floor()), y1 = math.min(d.height - 1, (c.dy + r).ceil());
      for (var y = y0; y <= y1; y++) {
        for (var x = x0; x <= x1; x++) {
          final dx = x + 0.5 - c.dx, dy = y + 0.5 - c.dy;
          if (dx * dx + dy * dy <= r * r) _mask[y * d.width + x] = value;
        }
      }
    }

    final pts = s.points;
    for (var i = 0; i < pts.length; i++) {
      if (i == 0) {
        disc(pts[0]);
        continue;
      }
      final a = pts[i - 1], b = pts[i];
      final steps = math.max(1, ((b - a).distance / math.max(1.0, r / 2)).ceil());
      for (var k = 1; k <= steps; k++) {
        disc(Offset.lerp(a, b, k / steps)!);
      }
    }
  }

  void _onStart(ScaleStartDetails d) {
    _startScale = _scale;
    _startOffset = _offset;
    _startFocal = d.localFocalPoint;
    if (d.pointerCount >= 2) _pinched = true;
    if (d.pointerCount == 1 && !_pinched) {
      final s = _Stroke(_erase, _brushPx)..points.add(_toImage(d.localFocalPoint));
      setState(() {
        _current = s;
        _live.add(s);
      });
    }
  }

  void _onUpdate(ScaleUpdateDetails d) {
    if (d.pointerCount >= 2) {
      _pinched = true;
      final s = _current;
      if (s != null) {
        _live.remove(s);
        _current = null;
      }
      final scale = (_startScale * d.scale).clamp(1.0, 6.0);
      setState(() {
        _scale = scale;
        _offset = d.localFocalPoint - (_startFocal - _startOffset) * (scale / _startScale);
      });
      return;
    }
    final s = _current;
    if (s == null) return;
    setState(() => s.points.add(_toImage(d.localFocalPoint)));
  }

  void _onEnd(ScaleEndDetails d) {
    final s = _current;
    _current = null;
    if (d.pointerCount == 0) _pinched = false;
    if (s == null) return;
    if (d.pointerCount > 0) {
      setState(() => _live.remove(s));
      return;
    }
    _remember();
    _stamp(s);
    _rebuildMask();
  }

  Future<void> _onTap(TapUpDetails d) async {
    if (_busy) return;
    final p = _toImage(d.localPosition);
    final dr = widget.draft;
    if (p.dx < 0 || p.dy < 0 || p.dx >= dr.width || p.dy >= dr.height) return;
    setState(() => _busy = true);
    final region = await regionAt(dr, p.dx.floor(), p.dy.floor());
    if (!mounted) return;
    _remember();
    final value = _erase ? 0 : 1;
    for (var i = 0; i < region.length; i++) {
      if (region[i] != 0) _mask[i] = value;
    }
    HapticFeedback.selectionClick();
    setState(() => _busy = false);
    _rebuildMask();
  }

  void _remember() {
    _history.add(Uint8List.fromList(_mask));
    if (_history.length > 15) _history.removeAt(0);
  }

  void _undo() {
    if (_history.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() => _mask = _history.removeLast());
    _rebuildMask();
  }

  void _reset() {
    HapticFeedback.selectionClick();
    _remember();
    _mask = Uint8List.fromList(widget.draft.auto);
    setState(() {
      _scale = 1;
      _offset = Offset.zero;
    });
    _rebuildMask();
  }

  Future<void> _done() async {
    if (_busy) return;
    setState(() => _busy = true);
    final png = await renderSticker(widget.draft, _mask);
    if (!mounted) return;
    if (png == null) {
      HapticFeedback.heavyImpact();
      setState(() => _busy = false);
      return;
    }
    Navigator.of(context).pop((png: png, mask: Uint8List.fromList(_mask)));
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final media = MediaQuery.of(context);
    final photo = _photo, mask = _maskImage;
    return Container(
      height: media.size.height * 0.94,
      padding: sheetPad(context, bottom: 16),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(t.cutoutEdit, subtitle: t.cutoutEditHint),
          const SizedBox(height: 14),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: ColoredBox(
                color: gc.bg,
                child: LayoutBuilder(
                  builder: (context, box) {
                    _box = box.biggest;
                    if (photo == null || mask == null) {
                      return Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2.2, color: gc.accent),
                        ),
                      );
                    }
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onScaleStart: _onStart,
                      onScaleUpdate: _onUpdate,
                      onScaleEnd: _onEnd,
                      onTapUp: _onTap,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _CutoutPainter(
                                photo: photo,
                                mask: mask,
                                strokes: [..._live],
                                fitted: _fitted,
                                scale: _scale,
                                offset: _offset,
                                imageWidth: widget.draft.width,
                                dim: gc.bg,
                                edge: gc.accent,
                              ),
                            ),
                          ),
                          if (_busy)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: gc.accent),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SegToggle([
                SegOption(t.cutoutErase, _erase, () => setState(() => _erase = true)),
                SegOption(t.cutoutRestore, !_erase, () => setState(() => _erase = false)),
              ], fontSize: 13),
              const Spacer(),
              for (var i = 0; i < _brushes.length; i++)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _brush = i);
                  },
                  child: SizedBox(
                    width: 34,
                    height: 40,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        width: 8.0 + i * 7,
                        height: 8.0 + i * 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _brush ? gc.accent : gc.textTertiary.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              RoundAction(
                label: t.undo,
                size: 50,
                onTap: _undo,
                child: Icon(
                  PhosphorIconsBold.arrowCounterClockwise,
                  size: 18,
                  color: _history.isEmpty ? gc.textTertiary : gc.text,
                ),
              ),
              const SizedBox(width: 10),
              RoundAction(
                label: t.cutoutReset,
                size: 50,
                onTap: _reset,
                child: Icon(PhosphorIconsBold.sparkle, size: 18, color: gc.textSecondary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(label: t.done, height: 50, onTap: _done),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CutoutPainter extends CustomPainter {
  _CutoutPainter({
    required this.photo,
    required this.mask,
    required this.strokes,
    required this.fitted,
    required this.scale,
    required this.offset,
    required this.imageWidth,
    required this.dim,
    required this.edge,
  });

  final ui.Image photo;
  final ui.Image mask;
  final List<_Stroke> strokes;
  final Rect fitted;
  final double scale;
  final Offset offset;
  final int imageWidth;
  final Color dim;
  final Color edge;

  @override
  void paint(Canvas canvas, Size size) {
    final src = Rect.fromLTWH(0, 0, photo.width.toDouble(), photo.height.toDouble());
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);
    canvas.drawImageRect(photo, src, fitted, Paint()..filterQuality = FilterQuality.medium);
    canvas.drawRect(fitted, Paint()..color = dim.withValues(alpha: 0.82));
    canvas.saveLayer(fitted, Paint());
    canvas.drawImageRect(mask, src, fitted, Paint());
    canvas.save();
    canvas.translate(fitted.left, fitted.top);
    final k = fitted.width / imageWidth;
    canvas.scale(k);
    for (final s in strokes) {
      if (s.points.isEmpty) continue;
      final path = Path()..moveTo(s.points.first.dx, s.points.first.dy);
      for (final p in s.points.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      if (s.points.length == 1) path.lineTo(s.points.first.dx + 0.1, s.points.first.dy);
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = s.width
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.white
          ..blendMode = s.erase ? BlendMode.clear : BlendMode.srcOver,
      );
    }
    canvas.restore();
    canvas.drawImageRect(
      photo,
      src,
      fitted,
      Paint()
        ..filterQuality = FilterQuality.medium
        ..blendMode = BlendMode.srcIn,
    );
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CutoutPainter o) => true;
}
