import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'svg_icon.dart';
import 'ui_kit.dart';

Future<Uint8List?> showPhotoCrop(BuildContext context, String path, {String? title, String? hint}) async {
  final image = await loadCropImage(path);
  if (image == null || !context.mounted) return null;
  final out = await Navigator.of(context).push<Uint8List>(PageRouteBuilder<Uint8List>(
    opaque: false,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, animation, _) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      child: _PhotoCrop(image: image, title: title, hint: hint),
    ),
  ));
  return out;
}

Future<ui.Image?> loadCropImage(String path, {int maxSide = 2400}) async {
  ui.ImmutableBuffer? buffer;
  ui.ImageDescriptor? descriptor;
  try {
    buffer = await ui.ImmutableBuffer.fromUint8List(await File(path).readAsBytes());
    descriptor = await ui.ImageDescriptor.encoded(buffer);
    final long = math.max(descriptor.width, descriptor.height);
    final scale = long > maxSide ? maxSide / long : 1.0;
    final codec = await descriptor.instantiateCodec(
      targetWidth: (descriptor.width * scale).round(),
      targetHeight: (descriptor.height * scale).round(),
    );
    final frame = await codec.getNextFrame();
    codec.dispose();
    return frame.image;
  } catch (_) {
    return null;
  } finally {
    descriptor?.dispose();
    buffer?.dispose();
  }
}

ui.Image rotateQuarter(ui.Image src) {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder)
    ..translate(src.height.toDouble(), 0)
    ..rotate(math.pi / 2);
  canvas.drawImage(src, Offset.zero, Paint()..filterQuality = FilterQuality.high);
  return recorder.endRecording().toImageSync(src.height, src.width);
}

Future<Uint8List?> cropToPng(ui.Image src, Rect unit, {int maxSide = 1600}) async {
  final r = Rect.fromLTRB(
    (unit.left * src.width).clamp(0, src.width.toDouble()),
    (unit.top * src.height).clamp(0, src.height.toDouble()),
    (unit.right * src.width).clamp(0, src.width.toDouble()),
    (unit.bottom * src.height).clamp(0, src.height.toDouble()),
  );
  if (r.width < 4 || r.height < 4) return null;
  final scale = math.min(1.0, maxSide / math.max(r.width, r.height));
  final w = math.max(1, (r.width * scale).round()), h = math.max(1, (r.height * scale).round());
  final recorder = ui.PictureRecorder();
  Canvas(recorder).drawImageRect(src, r, Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()),
      Paint()..filterQuality = FilterQuality.high);
  final out = await recorder.endRecording().toImage(w, h);
  final data = await out.toByteData(format: ui.ImageByteFormat.png);
  out.dispose();
  return data?.buffer.asUint8List();
}

enum _Grip { tl, tr, bl, br, body }

class _PhotoCrop extends StatefulWidget {
  const _PhotoCrop({required this.image, this.title, this.hint});

  final ui.Image image;
  final String? title;
  final String? hint;

  @override
  State<_PhotoCrop> createState() => _PhotoCropState();
}

class _PhotoCropState extends State<_PhotoCrop> {
  late ui.Image _image = widget.image;
  final List<ui.Image> _made = [];
  Rect _crop = const Rect.fromLTRB(0.08, 0.3, 0.92, 0.7);
  _Grip? _grip;
  bool _busy = false;

  static const _min = 0.06;

  @override
  void dispose() {
    widget.image.dispose();
    for (final i in _made) {
      i.dispose();
    }
    super.dispose();
  }

  void _rotate() {
    HapticFeedback.selectionClick();
    final next = rotateQuarter(_image);
    _made.add(next);
    setState(() {
      _image = next;
      final c = _crop;
      _crop = Rect.fromLTRB(1 - c.bottom, c.left, 1 - c.top, c.right);
    });
  }

  Future<void> _use() async {
    if (_busy) return;
    setState(() => _busy = true);
    final png = await cropToPng(_image, _crop);
    if (!mounted) return;
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop(png);
  }

  _Grip _gripAt(Offset p, Rect box) {
    final c = _toBox(_crop, box);
    const reach = 34.0;
    final corners = {
      _Grip.tl: c.topLeft,
      _Grip.tr: c.topRight,
      _Grip.bl: c.bottomLeft,
      _Grip.br: c.bottomRight,
    };
    _Grip? best;
    var bestD = reach;
    for (final e in corners.entries) {
      final d = (e.value - p).distance;
      if (d < bestD) {
        best = e.key;
        bestD = d;
      }
    }
    return best ?? _Grip.body;
  }

  Rect _toBox(Rect unit, Rect box) => Rect.fromLTRB(
        box.left + unit.left * box.width,
        box.top + unit.top * box.height,
        box.left + unit.right * box.width,
        box.top + unit.bottom * box.height,
      );

  void _drag(Offset delta, Rect box) {
    final dx = delta.dx / box.width, dy = delta.dy / box.height;
    var c = _crop;
    switch (_grip) {
      case _Grip.tl:
        c = Rect.fromLTRB((c.left + dx).clamp(0, c.right - _min), (c.top + dy).clamp(0, c.bottom - _min), c.right, c.bottom);
      case _Grip.tr:
        c = Rect.fromLTRB(c.left, (c.top + dy).clamp(0, c.bottom - _min), (c.right + dx).clamp(c.left + _min, 1), c.bottom);
      case _Grip.bl:
        c = Rect.fromLTRB((c.left + dx).clamp(0, c.right - _min), c.top, c.right, (c.bottom + dy).clamp(c.top + _min, 1));
      case _Grip.br:
        c = Rect.fromLTRB(c.left, c.top, (c.right + dx).clamp(c.left + _min, 1), (c.bottom + dy).clamp(c.top + _min, 1));
      case _Grip.body:
        final mx = dx.clamp(-c.left, 1 - c.right), my = dy.clamp(-c.top, 1 - c.bottom);
        c = c.shift(Offset(mx, my));
      case null:
        return;
    }
    setState(() => _crop = c);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Material(
      color: gc.bg,
      child: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(children: [
              RoundBtn(icon: Ic.close, onTap: () => Navigator.of(context).pop()),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.title ?? t.cropTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(18, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.3)),
                  const SizedBox(height: 2),
                  Text(widget.hint ?? t.cropHint,
                      maxLines: 2,
                      style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                ]),
              ),
              const SizedBox(width: 10),
              RoundAction(
                label: t.rotatePhoto,
                onTap: _rotate,
                child: Icon(PhosphorIconsRegular.arrowClockwise, size: 17, color: gc.text),
              ),
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
              child: LayoutBuilder(builder: (context, area) {
                final iw = _image.width.toDouble(), ih = _image.height.toDouble();
                final s = math.min(area.maxWidth / iw, area.maxHeight / ih);
                final size = Size(iw * s, ih * s);
                final box = Rect.fromLTWH(
                    (area.maxWidth - size.width) / 2, (area.maxHeight - size.height) / 2, size.width, size.height);
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (d) {
                    _grip = _gripAt(d.localPosition, box);
                    HapticFeedback.selectionClick();
                  },
                  onPanUpdate: (d) => _drag(d.delta, box),
                  onPanEnd: (_) => _grip = null,
                  child: CustomPaint(
                    size: Size(area.maxWidth, area.maxHeight),
                    painter: _CropPainter(
                      image: _image,
                      box: box,
                      crop: _toBox(_crop, box),
                      shade: gc.bg.withValues(alpha: 0.72),
                      line: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: _busy ? 0.5 : 1,
              child: PrimaryButton(label: t.useValue, onTap: _use),
            ),
          ),
        ]),
      ),
    );
  }
}

class _CropPainter extends CustomPainter {
  const _CropPainter({
    required this.image,
    required this.box,
    required this.crop,
    required this.shade,
    required this.line,
  });

  final ui.Image image;
  final Rect box;
  final Rect crop;
  final Color shade;
  final Color line;

  @override
  void paint(Canvas canvas, Size size) {
    final src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    canvas.drawImageRect(image, src, box, Paint()..filterQuality = FilterQuality.medium);
    final outside = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(box)
      ..addRRect(RRect.fromRectAndRadius(crop, const Radius.circular(6)));
    canvas.drawPath(outside, Paint()..color = shade);
    canvas.drawRRect(
      RRect.fromRectAndRadius(crop, const Radius.circular(6)),
      Paint()
        ..color = line.withValues(alpha: 0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );
    final grip = Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final l = math.min(22.0, math.min(crop.width, crop.height) / 3);
    for (final (p, sx, sy) in [
      (crop.topLeft, 1.0, 1.0),
      (crop.topRight, -1.0, 1.0),
      (crop.bottomLeft, 1.0, -1.0),
      (crop.bottomRight, -1.0, -1.0),
    ]) {
      canvas.drawPath(
        Path()
          ..moveTo(p.dx, p.dy + sy * l)
          ..lineTo(p.dx, p.dy)
          ..lineTo(p.dx + sx * l, p.dy),
        grip,
      );
    }
  }

  @override
  bool shouldRepaint(_CropPainter old) =>
      old.image != image || old.box != box || old.crop != crop || old.shade != shade || old.line != line;
}
