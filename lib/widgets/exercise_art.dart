import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_drawing/path_drawing.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../theme/app_colors.dart';
import 'shimmer.dart';

class ExerciseArtData {
  const ExerciseArtData(this.frames, this.bounds);
  final List<Path> frames;
  final Rect bounds;
}

const _cacheLimit = 32;
final _cache = <String, ExerciseArtData>{};
final _pending = <String, Future<ExerciseArtData>>{};

Future<ExerciseArtData> loadExerciseArt(String slug, {bool still = false}) {
  final key = still ? '$slug#still' : slug;
  final hit = _cache.remove(key) ?? (still ? _cache[slug] : null);
  if (hit != null) {
    _cache[key] = hit;
    return SynchronousFuture(hit);
  }
  return _pending.putIfAbsent(key, () async {
    try {
      final raw = await rootBundle.loadString('assets/art/$slug.txt');
      final lines = [
        for (final d in raw.split('\n'))
          if (d.trim().isNotEmpty) d.trim(),
      ];
      final frames = [
        for (final d in still ? lines.take(1) : lines) parseSvgPathData(d)..fillType = PathFillType.evenOdd,
      ];
      if (frames.isEmpty) throw StateError('sin frames');
      var bounds = frames.first.getBounds();
      for (final f in frames.skip(1)) {
        bounds = bounds.expandToInclude(f.getBounds());
      }
      final data = ExerciseArtData(frames, bounds);
      _cache[key] = data;
      if (_cache.length > _cacheLimit) _cache.remove(_cache.keys.first);
      return data;
    } finally {
      _pending.remove(key);
    }
  });
}

const _stillLimit = 160;
final _stills = <(ExerciseArtData, int, int, Color), ui.Image>{};

ui.Image _still(ExerciseArtData art, Size size, double dpr, Color color) {
  final w = (size.width * dpr).round();
  final h = (size.height * dpr).round();
  final key = (art, w, h, color);
  final hit = _stills.remove(key);
  if (hit != null) return _stills[key] = hit;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder)..scale(dpr);
  _ArtPainter(art, color, null).paint(canvas, size);
  final picture = recorder.endRecording();
  final image = picture.toImageSync(w, h);
  picture.dispose();
  _stills[key] = image;
  if (_stills.length > _stillLimit) _stills.remove(_stills.keys.first)?.dispose();
  return image;
}

class ExerciseArt extends StatefulWidget {
  const ExerciseArt({
    super.key,
    required this.slug,
    this.height = 210,
    this.radius = 20,
    this.live = false,
    this.bordered = true,
    this.loops,
  });

  final String slug;
  final double height;
  final double radius;
  final bool live;
  final bool bordered;
  final int? loops;

  @override
  State<ExerciseArt> createState() => _ExerciseArtState();
}

class _ExerciseArtState extends State<ExerciseArt> with SingleTickerProviderStateMixin {
  static const _cycle = Duration(milliseconds: 1560);

  AnimationController? _c;
  ExerciseArtData? _art;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void didUpdateWidget(ExerciseArt old) {
    super.didUpdateWidget(old);
    if (old.slug != widget.slug || old.loops != widget.loops) {
      _c?.reset();
      _sync();
    }
    if (old.slug != widget.slug) {
      _art = null;
      _failed = false;
      _fetch();
    }
    if (old.live != widget.live) {
      if (widget.live && (_art?.frames.length ?? 0) < 2) {
        _fetch();
      } else {
        _sync();
      }
    }
  }

  Future<void> _fetch() async {
    if (widget.slug.isEmpty) return;
    final slug = widget.slug;
    try {
      final data = await loadExerciseArt(slug, still: !widget.live);
      if (!mounted || slug != widget.slug) return;
      setState(() {
        _art = data;
        _sync();
      });
    } catch (_) {
      if (mounted && slug == widget.slug) setState(() => _failed = true);
    }
  }

  void _sync() {
    if (widget.live && (_art?.frames.length ?? 0) > 1) {
      final c = _c ??= AnimationController(vsync: this, duration: _cycle);
      if (!c.isAnimating && (widget.loops == null || c.value == 0)) c.repeat(count: widget.loops);
    } else {
      _c?.stop();
    }
  }

  @override
  void dispose() {
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final art = _art;
    Widget child;
    if (widget.slug.isEmpty || _failed) {
      child = _fallback(gc, widget.height);
    } else if (art == null) {
      child = Shimmer(radius: widget.radius);
    } else if (widget.live && art.frames.length > 1 && _c != null) {
      final c = _c!;
      child = RepaintBoundary(
        child: CustomPaint(painter: _ArtPainter(art, gc.text, c), size: Size.infinite),
      );
    } else {
      child = LayoutBuilder(
        builder: (context, box) {
          final size = box.biggest;
          if (!size.isFinite || size.isEmpty) return const SizedBox.shrink();
          return RawImage(
            image: _still(art, size, MediaQuery.devicePixelRatioOf(context), gc.text).clone(),
            width: size.width,
            height: size.height,
          );
        },
      );
    }

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: gc.bgRaised2,
        borderRadius: BorderRadius.circular(widget.radius),
        border: widget.bordered ? Border.all(color: gc.border) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _fallback(GymColors gc, double height) => Center(
    child: Icon(PhosphorIconsRegular.barbell, size: height * 0.32, color: gc.textTertiary),
  );
}

class _ArtPainter extends CustomPainter {
  _ArtPainter(this.art, this.color, this.anim) : super(repaint: anim);

  final ExerciseArtData art;
  final Color color;
  final Animation<double>? anim;

  @override
  void paint(Canvas canvas, Size size) {
    final b = art.bounds;
    if (b.isEmpty || size.isEmpty) return;
    final pad = size.shortestSide * 0.07;
    final scale = math.min((size.width - pad * 2) / b.width, (size.height - pad * 2) / b.height);
    if (scale <= 0) return;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale);
    canvas.translate(-b.center.dx, -b.center.dy);

    final t = anim?.value ?? 0;
    final n = art.frames.length;
    if (n < 2) {
      _draw(canvas, art.frames.first, 1);
      canvas.restore();
      return;
    }
    final steps = (n - 1) * 2;
    final pos = t * steps;
    final step = pos.floor() % steps;
    final f = pos - pos.floor();
    final ascending = step < n - 1;
    final from = ascending ? step : steps - step;
    final to = ascending ? from + 1 : from - 1;
    final blend = f < 0.72 ? 0.0 : Curves.easeInOut.transform((f - 0.72) / 0.28);

    _draw(canvas, art.frames[from], 1 - blend);
    if (blend > 0) _draw(canvas, art.frames[to], blend);
    canvas.restore();
  }

  void _draw(Canvas canvas, Path path, double opacity) {
    if (opacity <= 0.01) return;
    canvas.drawPath(path, Paint()..color = color.withValues(alpha: opacity));
  }

  @override
  bool shouldRepaint(_ArtPainter old) => old.art != art || old.color != color || old.anim != anim;
}
