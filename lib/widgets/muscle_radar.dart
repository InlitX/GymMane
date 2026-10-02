import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../catalog/body_svg.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'svg_icon.dart';
import 'ui_kit.dart';

const _axes = [
  'chest',
  'shoulders',
  'trapezius',
  'back',
  'triceps',
  'biceps',
  'forearm',
  'abdomen',
  'quads',
  'calves',
  'hamstrings',
  'glutes',
];

const _backView = {'trapezius', 'back', 'triceps', 'glutes', 'hamstrings', 'calves'};

class MuscleRadarCard extends StatefulWidget {
  const MuscleRadarCard({super.key});

  @override
  State<MuscleRadarCard> createState() => _MuscleRadarCardState();
}

class _MuscleRadarCardState extends State<MuscleRadarCard> {
  String? _picked;

  Map<String, double> _month() {
    final now = DateTime.now();
    final raw = fit.muscleSetsBetween(DateTime(now.year, now.month, now.day - 29), now.add(const Duration(minutes: 1)));
    return {
      for (final id in _axes) id: (raw[id] ?? 0) + (id == 'abdomen' ? raw['obliques'] ?? 0 : 0),
    };
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final sets = _month();
    final top = sets.values.fold<double>(0, math.max);
    final picked = _picked;
    final behind = [
      for (final id in [..._axes]..sort((a, b) => sets[a]!.compareTo(sets[b]!)))
        if (top > 0 && sets[id]! < top * 0.5) id,
    ].take(3).toList();

    return SoftCard(
      radius: 20,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.radarTitle, style: AppTheme.f(21, weight: FontWeight.w800, color: gc.text)),
          const SizedBox(height: 4),
          Text(t.radarHint, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(builder: (context, c) {
              final side = c.maxWidth;
              final icon = side * 0.165;
              final radius = side / 2 - _gap - icon;
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 950),
                curve: Curves.easeOutCubic,
                builder: (context, grow, _) => Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _RadarPainter(
                          gc: gc,
                          values: [for (final id in _axes) top <= 0 ? 0 : sets[id]! / top * grow],
                          radius: radius,
                          picked: picked == null ? -1 : _axes.indexOf(picked),
                        ),
                      ),
                    ),
                    for (var i = 0; i < _axes.length; i++)
                      _figure(gc, i, side, radius, icon, sets),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: Text(
              key: ValueKey(picked ?? behind.join()),
              picked != null
                  ? '${t.muscle(picked)} · ${t.setCount(sets[picked]!.round())}'
                  : top <= 0
                      ? t.radarEmpty
                      : behind.isEmpty
                          ? t.radarBalanced
                          : t.radarFocus(behind.map(t.muscle).join(', ')),
              textAlign: TextAlign.center,
              style: AppTheme.f(13, weight: FontWeight.w600, color: picked != null ? gc.text : gc.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  static const _gap = 6.0;

  Widget _figure(GymColors gc, int i, double side, double radius, double size, Map<String, double> sets) {
    final a = -math.pi / 2 + i * 2 * math.pi / _axes.length;
    final id = _axes[i];
    final on = _picked == id;
    final crop = MuscleFigurePainter.crop(id);
    final body = MuscleFigurePainter.content(id);
    final k = size / crop.width;
    final reach = radius + _gap + (math.cos(a).abs() * body.width + math.sin(a).abs() * body.height) * k / 2;
    return Positioned(
      left: side / 2 + math.cos(a) * reach - (body.center.dx - crop.left) * k,
      top: side / 2 + math.sin(a) * reach - (body.center.dy - crop.top) * k,
      width: size,
      height: size,
      child: Semantics(
        button: true,
        label: '${t.muscle(id)} · ${t.setCount(sets[id]!.round())}',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => _picked = on ? null : id),
          child: AnimatedScale(
            scale: on ? 1.14 : 1,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            child: CustomPaint(painter: MuscleFigurePainter(gc: gc, muscle: id)),
          ),
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.gc, required this.values, required this.radius, required this.picked});

  final GymColors gc;
  final List<double> values;
  final double radius;
  final int picked;

  Offset _at(Offset c, int i, double r) {
    final a = -math.pi / 2 + i * 2 * math.pi / values.length;
    return c + Offset(math.cos(a) * r, math.sin(a) * r);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final n = values.length;
    final grid = Paint()
      ..color = gc.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var ring = 1; ring <= 4; ring++) {
      final r = radius * ring / 4;
      canvas.drawPath(Path()..addPolygon([for (var i = 0; i < n; i++) _at(c, i, r)], true), grid);
    }
    for (var i = 0; i < n; i++) {
      canvas.drawLine(c, _at(c, i, radius), grid);
    }

    final pts = [for (var i = 0; i < n; i++) _at(c, i, radius * values[i].clamp(0.0, 1.0))];
    final shape = Path()..addPolygon(pts, true);
    canvas.drawPath(shape, Paint()..color = gc.accent.withValues(alpha: 0.22));
    canvas.drawPath(
      shape,
      Paint()
        ..color = gc.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round,
    );
    for (var i = 0; i < n; i++) {
      canvas.drawCircle(pts[i], i == picked ? 5 : 3, Paint()..color = i == picked ? gc.text : gc.accent);
    }
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.gc != gc || old.radius != radius || old.picked != picked || !_same(old.values, values);

  static bool _same(List<double> a, List<double> b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return a.length == b.length;
  }
}

class MuscleFigurePainter extends CustomPainter {
  MuscleFigurePainter({required this.gc, required this.muscle});

  final GymColors gc;
  final String muscle;

  static Rect _half(String id) =>
      _backView.contains(id) ? const Rect.fromLTRB(270, 0, 540, 462) : const Rect.fromLTRB(0, 0, 262, 462);

  static Rect crop(String id) {
    final cx = _backView.contains(id) ? 411.0 : 115.0;
    if (id == 'calves') return Rect.fromCenter(center: Offset(cx, 362), width: 200, height: 200);
    final top = id == 'quads' || id == 'hamstrings' || id == 'glutes' ? 160.0 : -4.0;
    return Rect.fromLTWH(cx - 135, top, 270, 270);
  }

  static final _content = <String, Rect>{};

  static Rect content(String id) => _content.putIfAbsent(id, () {
        final box = crop(id).intersect(_half(id));
        var l = double.infinity, t = double.infinity, r = -double.infinity, b = -double.infinity;
        for (final d in [...bodyBaseMain, ...bodyBaseLite]) {
          for (final m in svgPath(d).computeMetrics()) {
            for (var at = 0.0; at < m.length; at += 2) {
              final p = m.getTangentForOffset(at)?.position;
              if (p == null || !box.contains(p)) continue;
              l = math.min(l, p.dx);
              t = math.min(t, p.dy);
              r = math.max(r, p.dx);
              b = math.max(b, p.dy);
            }
          }
        }
        return l.isFinite ? Rect.fromLTRB(l, t, r, b) : box;
      });

  @override
  void paint(Canvas canvas, Size size) {
    final crop = MuscleFigurePainter.crop(muscle);
    final dark = gc.bg.computeLuminance() < 0.5;
    final skin = dark ? const Color(0xFFE4E1DC) : const Color(0xFFB9B1A8);
    final rest = Color.lerp(skin, gc.bgRaised, 0.22)!;
    final lit = {muscle, if (muscle == 'abdomen') 'obliques'};

    canvas.clipRect(Offset.zero & size);
    final k = size.width / crop.width;
    canvas.scale(k);
    canvas.translate(-crop.left, -crop.top);
    canvas.clipRect(_half(muscle));
    final paint = Paint()..isAntiAlias = true;
    for (final d in [...bodyBaseMain, ...bodyBaseLite]) {
      canvas.drawPath(svgPath(d), paint..color = skin);
    }
    for (final e in muscleFills.entries) {
      paint.color = lit.contains(e.key) ? gc.accent : rest;
      for (final d in e.value) {
        canvas.drawPath(svgPath(d), paint);
      }
    }
  }

  @override
  bool shouldRepaint(MuscleFigurePainter old) => old.gc != gc || old.muscle != muscle;
}
