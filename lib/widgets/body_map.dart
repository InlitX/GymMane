import 'package:flutter/material.dart';

import '../catalog/body_svg.dart';
import '../theme/app_colors.dart';
import 'svg_icon.dart';

const double _bodyAspect = bodyViewH / bodyViewW;

String? muscleAt(Offset p) {
  for (final id in muscleFills.keys) {
    final hits = muscleHits[id];
    final probes = (hits != null && hits.isNotEmpty) ? hits : muscleFills[id]!;
    for (final d in probes) {
      if (svgPath(d).contains(p)) return id;
    }
  }
  return null;
}

Color idleMuscle(GymColors gc) => Color.lerp(gc.bgRaised2, gc.textSecondary, 0.32)!;

const List<Color> _heatDark = [
  Color(0xFF7A4028),
  Color(0xFFB4632C),
  Color(0xFFE38B3A),
  Color(0xFFFFC168),
];

const List<Color> _heatLight = [
  Color(0xFFD9B48A),
  Color(0xFFC07A3C),
  Color(0xFF9E4A24),
  Color(0xFF6E2A16),
];

const int heatLevels = 4;

/// 0 = untouched, 4 = at or over the target volume for the period.
int heatLevel(double v) {
  if (v <= 0) return 0;
  if (v < 0.25) return 1;
  if (v < 0.5) return 2;
  if (v < 0.75) return 3;
  return 4;
}

Color heatLevelColor(GymColors gc, int level) {
  if (level <= 0) return idleMuscle(gc);
  final ramp = gc.bg.computeLuminance() < 0.5 ? _heatDark : _heatLight;
  return ramp[(level - 1).clamp(0, heatLevels - 1)];
}

Color heatColor(GymColors gc, double v) => heatLevelColor(gc, heatLevel(v));

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
      painter: _BodyPainter(
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

  String get _token {
    final keys = intensity.keys.toList()..sort();
    return keys.map((k) => '$k${(intensity[k]! * 100).round()}').join(',');
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return _BodyCanvas(
      onTap: onTap,
      painter: _BodyPainter(
        gc: gc,
        token: _token,
        color: (id) => heatColor(gc, intensity[id] ?? 0),
        outline: focus,
      ),
    );
  }
}

class _BodyCanvas extends StatelessWidget {
  const _BodyCanvas({required this.painter, this.onTap});

  final _BodyPainter painter;
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
        child: CustomPaint(size: Size(w, w * _bodyAspect), painter: painter),
      );
    });
  }
}

class _BodyPainter extends CustomPainter {
  _BodyPainter({required this.gc, required this.color, required this.token, this.outline});

  final GymColors gc;
  final Color Function(String id) color;
  final String token;
  final String? outline;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / bodyViewW);

    final bodyMain = gc.bgRaised2;
    final bodyLite = Color.lerp(gc.bgRaised2, gc.textTertiary, 0.14)!;

    void fill(String d, Color c) =>
        canvas.drawPath(svgPath(d), Paint()..color = c..style = PaintingStyle.fill..isAntiAlias = true);

    for (final d in bodyBaseMain) {
      fill(d, bodyMain);
    }
    for (final d in bodyBaseLite) {
      fill(d, bodyLite);
    }
    for (final entry in muscleFills.entries) {
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
      for (final d in muscleFills[id] ?? const <String>[]) {
        canvas.drawPath(svgPath(d), stroke);
      }
    }
  }

  @override
  bool shouldRepaint(_BodyPainter old) =>
      old.gc != gc || old.token != token || old.outline != outline;
}
