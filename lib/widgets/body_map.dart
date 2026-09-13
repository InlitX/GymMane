import 'package:flutter/material.dart';

import '../catalog/body_svg.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import 'svg_icon.dart';

const double kBodyAspect = bodyViewH / bodyViewW;

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
  BodyPainter({required this.gc, required this.color, required this.token, this.outline});

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
  bool shouldRepaint(BodyPainter old) =>
      old.gc != gc || old.token != token || old.outline != outline;
}
