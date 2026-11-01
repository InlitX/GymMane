import 'package:flutter/material.dart';

import '../catalog/body_art.dart';
import '../catalog/body_svg.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import 'svg_icon.dart';

const double kBodyAspect = bodyViewH / bodyViewW;

BodyArt get currentBody => bodyArtFor(fit.profile.sex);

String? muscleAt(Offset p) {
  final art = currentBody;
  for (final id in art.fills.keys) {
    final hits = art.hits[id];
    final probes = (hits != null && hits.isNotEmpty) ? hits : art.fills[id]!;
    for (final d in probes) {
      if (svgPath(d).contains(p)) return id;
    }
  }
  return null;
}

void paintBodyBase(Canvas canvas, BodyArt art, Color main, Color lite) {
  final paint = Paint()..isAntiAlias = true;
  final cut = art.head.isNotEmpty;
  if (cut) {
    canvas.save();
    canvas.clipRect(Rect.fromLTRB(-bodyViewW, art.headCut, bodyViewW * 2, bodyViewH * 2));
  }
  for (final d in art.base) {
    canvas.drawPath(svgPath(d), paint..color = main);
  }
  for (final d in art.lite) {
    canvas.drawPath(svgPath(d), paint..color = lite);
  }
  if (cut) {
    canvas.restore();
    for (final d in art.head) {
      canvas.drawPath(svgPath(d), paint..color = lite);
    }
  }
}

final Map<String, Path> _muscleClips = {};

void clipMuscles(Canvas canvas, BodyArt art) {
  if (art.headInner.isEmpty) return;
  canvas.clipPath(_muscleClips.putIfAbsent(art.id, () {
    final p = Path()..addRect(Rect.fromLTRB(-bodyViewW, art.headCut, bodyViewW * 2, bodyViewH * 2));
    for (final d in art.headInner) {
      p.addPath(svgPath(d), Offset.zero);
    }
    return p;
  }));
}

Color idleMuscle(GymColors gc) => Color.lerp(gc.bgRaised2, gc.textSecondary, 0.32)!;

const Map<String, List<Color>> kHeatRampsDark = {
  'ember': [Color(0xFF7A4028), Color(0xFFB4632C), Color(0xFFE38B3A), Color(0xFFFFC168)],
  'green': [Color(0xFF1B4B2C), Color(0xFF2C7A44), Color(0xFF3FA95C), Color(0xFF63D67F)],
  'blue': [Color(0xFF1E3A5C), Color(0xFF2C5E96), Color(0xFF3D86C9), Color(0xFF6EB4F0)],
  'mono': [Color(0xFF3A3A3A), Color(0xFF5E5E5E), Color(0xFF8C8C8C), Color(0xFFD8D8D8)],
};

const Map<String, List<Color>> kHeatRampsLight = {
  'ember': [Color(0xFFD9B48A), Color(0xFFC07A3C), Color(0xFF9E4A24), Color(0xFF6E2A16)],
  'green': [Color(0xFFBBD9BE), Color(0xFF7FB88A), Color(0xFF488C58), Color(0xFF255E32)],
  'blue': [Color(0xFFBACFE8), Color(0xFF7EA5D2), Color(0xFF3F74AE), Color(0xFF1F4876)],
  'mono': [Color(0xFFCFC8BC), Color(0xFF9C958A), Color(0xFF6B655C), Color(0xFF3A352F)],
};

const List<String> kHeatTones = ['ember', 'green', 'blue', 'mono'];

List<Color> heatRamp(GymColors gc, String tone) {
  final table = gc.bg.computeLuminance() < 0.5 ? kHeatRampsDark : kHeatRampsLight;
  return table[tone] ?? table['ember']!;
}

Color heatLevelColor(GymColors gc, int level, {String? tone}) {
  if (level <= 0) return idleMuscle(gc);
  final ramp = heatRamp(gc, tone ?? fit.heatTone);
  return ramp[(level - 1).clamp(0, heatLevels - 1)];
}

Color heatColor(GymColors gc, double v) => heatLevelColor(gc, heatLevel(v));

String heatToken(Map<String, double> intensity) {
  final keys = intensity.keys.toList()..sort();
  return keys.map((k) => '$k${(intensity[k]! * 100).round()}').join(',');
}

class BodyMap extends StatelessWidget {
  const BodyMap({super.key, required this.selected, required this.onToggle});

  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final muscle = idleMuscle(gc);
    return _BodyCanvas(
      onTap: onToggle,
      painter: BodyPainter(
        gc: gc,
        token: (selected.toList()..sort()).join(','),
        color: (id) => selected.contains(id) ? gc.ember : muscle,
      ),
    );
  }
}

class BodyHeatMap extends StatelessWidget {
  const BodyHeatMap({super.key, required this.intensity, this.focus, this.onTap});

  final Map<String, double> intensity;
  final String? focus;
  final ValueChanged<String>? onTap;

  String get _token => heatToken(intensity);

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return _BodyCanvas(
      onTap: onTap,
      painter: BodyPainter(
        gc: gc,
        token: _token,
        color: (id) => heatColor(gc, intensity[id] ?? 0),
        outline: focus,
      ),
    );
  }
}

Color recoveryColor(GymColors gc, double recovered) {
  final v = recovered.clamp(0.0, 1.0);
  final fresh = Color.lerp(idleMuscle(gc), gc.sage, 0.62)!;
  if (v < 0.5) return Color.lerp(gc.danger, gc.warn, v / 0.5)!;
  return Color.lerp(gc.warn, fresh, (v - 0.5) / 0.5)!;
}

class BodyRecoveryMap extends StatelessWidget {
  const BodyRecoveryMap({super.key, required this.recovery, this.focus, this.onTap});

  final Map<String, double> recovery;
  final String? focus;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return _BodyCanvas(
      onTap: onTap,
      painter: BodyPainter(
        gc: gc,
        token: 'r${heatToken(recovery)}',
        color: (id) => recoveryColor(gc, recovery[id] ?? 1),
        outline: focus,
      ),
    );
  }
}

class BodyHeatArt extends StatelessWidget {
  const BodyHeatArt({super.key, required this.gc, required this.intensity, required this.width});

  final GymColors gc;
  final Map<String, double> intensity;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, width * kBodyAspect),
      painter: BodyPainter(
        gc: gc,
        token: heatToken(intensity),
        color: (id) => heatColor(gc, intensity[id] ?? 0),
      ),
    );
  }
}

class _BodyCanvas extends StatelessWidget {
  const _BodyCanvas({required this.painter, this.onTap});

  final BodyPainter painter;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth;
      final scale = w / bodyViewW;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: onTap == null
            ? null
            : (d) {
                final p = Offset(d.localPosition.dx / scale, d.localPosition.dy / scale);
                final id = muscleAt(p);
                if (id != null) onTap!(id);
              },
        child: CustomPaint(size: Size(w, w * kBodyAspect), painter: painter),
      );
    });
  }
}

class BodyPainter extends CustomPainter {
  BodyPainter({required this.gc, required this.color, required this.token, this.outline, this.crop, this.quiet = false, BodyArt? art})
      : art = art ?? currentBody;

  final BodyArt art;
  final bool quiet;
  final GymColors gc;
  final Color Function(String id) color;
  final String token;
  final String? outline;
  final Rect? crop;

  @override
  void paint(Canvas canvas, Size size) {
    final view = crop ?? const Rect.fromLTWH(0, 0, bodyViewW, bodyViewH);
    canvas.clipRect(Offset.zero & size);
    canvas.scale(size.width / view.width);
    canvas.translate(-view.left, -view.top);

    final bodyMain = quiet ? Color.lerp(gc.bgRaised2, gc.textTertiary, 0.1)! : gc.bgRaised2;
    final bodyLite = Color.lerp(gc.bgRaised2, gc.textTertiary, quiet ? 0.22 : 0.14)!;

    void fill(String d, Color c) =>
        canvas.drawPath(svgPath(d), Paint()..color = c..style = PaintingStyle.fill..isAntiAlias = true);

    paintBodyBase(canvas, art, bodyMain, bodyLite);
    canvas.save();
    clipMuscles(canvas, art);
    for (final entry in art.fills.entries) {
      final c = color(entry.key);
      for (final d in entry.value) {
        fill(d, c);
      }
    }

    final id = outline;
    if (id != null) {
      final stroke = Paint()
        ..color = gc.text
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..isAntiAlias = true;
      for (final d in art.fills[id] ?? const <String>[]) {
        canvas.drawPath(svgPath(d), stroke);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(BodyPainter old) =>
      old.gc != gc ||
      old.token != token ||
      old.outline != outline ||
      old.crop != crop ||
      old.quiet != quiet ||
      old.art != art;
}

Color untrainedColor(GymColors gc, int? days) {
  final idle = idleMuscle(gc);
  if (days == null || days >= 14) return gc.danger;
  if (days >= 7) return Color.lerp(gc.warn, gc.danger, (days - 7) / 7)!;
  if (days >= 4) return Color.lerp(idle, gc.warn, 0.35 + (days - 4) * 0.2)!;
  return Color.lerp(idle, gc.sage, 0.35)!;
}

class BodyUntrainedMap extends StatelessWidget {
  const BodyUntrainedMap({super.key, required this.days, this.focus, this.onTap});

  final Map<String, int?> days;
  final String? focus;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final keys = days.keys.toList()..sort();
    return _BodyCanvas(
      onTap: onTap,
      painter: BodyPainter(
        gc: gc,
        token: 'u${keys.map((k) => '$k${days[k] ?? 'n'}').join(',')}',
        color: (id) => untrainedColor(gc, days[id]),
        outline: focus,
      ),
    );
  }
}

final Map<String, Rect> _zoneViews = {};

Rect bodyViewFor(List<String> muscles) => _zoneViews.putIfAbsent('${currentBody.id}${muscles.join(',')}', () {
      const half = bodyViewW / 2;
      var front = false, back = false;
      for (final id in muscles) {
        for (final d in currentBody.fills[id] ?? const <String>[]) {
          if (svgPath(d).getBounds().center.dx < half) {
            front = true;
          } else {
            back = true;
          }
        }
      }
      if (front == back) return const Rect.fromLTWH(0, 0, bodyViewW, bodyViewH);
      return Rect.fromLTWH(front ? 0 : half, 0, half, bodyViewH);
    });

class BodyZoneArt extends StatelessWidget {
  const BodyZoneArt({super.key, required this.muscles, required this.height, this.color});

  final List<String> muscles;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final view = bodyViewFor(muscles);
    final idle = idleMuscle(gc);
    final on = color ?? heatRamp(gc, fit.heatTone)[2];
    return CustomPaint(
      size: Size(height * view.width / view.height, height),
      painter: BodyPainter(
        gc: gc,
        token: 'z${muscles.join(',')}$on',
        crop: view,
        color: (id) => muscles.contains(id) ? on : idle,
      ),
    );
  }
}

class MiniBody extends StatelessWidget {
  const MiniBody({super.key, required this.sets, this.done, required this.height});

  final Map<String, double> sets;
  final Map<String, double>? done;
  final double height;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final top = sets.values.fold(0.0, (a, b) => b > a ? b : a);
    final idle = idleMuscle(gc);
    final ramp = heatRamp(gc, fit.heatTone);
    final faint = Color.lerp(idle, ramp[1], 0.55)!;
    final ticked = done;
    Color colorOf(String id) {
      final n = sets[id] ?? 0;
      if (n <= 0 || top <= 0) return idle;
      if (ticked == null) return ramp[((n / top) * (heatLevels - 1)).round().clamp(0, heatLevels - 1)];
      final d = ticked[id] ?? 0;
      if (d <= 0) return faint;
      return Color.lerp(faint, ramp[heatLevels - 1], (d / n).clamp(0.0, 1.0))!;
    }

    final keys = sets.keys.toList()..sort();
    final token = 'm${keys.map((k) => '$k${sets[k]!.toStringAsFixed(1)}/${ticked?[k]?.toStringAsFixed(1) ?? '-'}').join(',')}';
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(height / kBodyAspect, height),
        painter: BodyPainter(gc: gc, token: '$token${fit.heatTone}', color: colorOf, quiet: true),
      ),
    );
  }
}
