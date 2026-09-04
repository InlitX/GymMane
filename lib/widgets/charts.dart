import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'body_map.dart';
import 'svg_icon.dart';

class GoalRing extends StatelessWidget {
  const GoalRing({super.key, required this.pct, this.size = 40});
  final double pct;
  final double size;
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _RingPainter(pct, gc.bgRaised2, gc.accent)),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.pct, this.track, this.accent);
  final double pct;
  final Color track, accent;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 40);
    const center = Offset(20, 20);
    const r = 16.0;
    final t = Paint()..style = PaintingStyle.stroke..strokeWidth = 4..color = track;
    canvas.drawCircle(center, r, t);
    final a = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = accent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: r), -math.pi / 2, pct / 100 * 2 * math.pi, false, a);
  }

  @override
  bool shouldRepaint(_RingPainter o) => o.pct != pct || o.accent != accent || o.track != track;
}

class VolumeChart extends StatelessWidget {
  const VolumeChart({
    super.key,
    required this.points,
    required this.label,
    this.unit = '',
    this.xLabels = const [],
    this.height = 116,
  });

  final List<double> points;
  final String Function(double value) label;
  final String unit;
  final List<String> xLabels;
  final double height;

  static const double _pad = 7;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final top = points.isEmpty ? 0.0 : points.reduce(math.max);
    final style = AppTheme.d(10, weight: FontWeight.w600, color: gc.textTertiary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 34,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final f in [1.0, 0.5, 0.0])
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(f == 1 ? '${label(top)} $unit'.trim() : label(top * f),
                            maxLines: 1, style: style),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Expanded(child: CustomPaint(painter: _VolumePainter(gc, points, _pad))),
            ],
          ),
        ),
        if (xLabels.isNotEmpty) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [for (final x in xLabels) Text(x, style: style)],
            ),
          ),
        ],
      ],
    );
  }
}

class _VolumePainter extends CustomPainter {
  _VolumePainter(this.gc, this.points, this.pad);
  final GymColors gc;
  final List<double> points;
  final double pad;

  @override
  void paint(Canvas canvas, Size size) {
    final top = pad, bottom = size.height - pad;
    final grid = Paint()
      ..color = gc.border
      ..strokeWidth = 1;
    for (final f in [0.0, 0.5, 1.0]) {
      final y = bottom - (bottom - top) * f;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    if (points.length < 2) return;
    final maxV = points.reduce(math.max);
    if (maxV <= 0) return;

    Offset m(int i) => Offset(
          size.width * i / (points.length - 1),
          bottom - (bottom - top) * (points[i] / maxV),
        );

    final line = Path()..moveTo(m(0).dx, m(0).dy);
    for (var i = 1; i < points.length; i++) {
      line.lineTo(m(i).dx, m(i).dy);
    }

    final area = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(area, Paint()..color = gc.accentSoft..style = PaintingStyle.fill);
    canvas.drawPath(
      line,
      Paint()
        ..color = gc.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    final end = m(points.length - 1);
    canvas.drawCircle(end, 5, Paint()..color = gc.bgRaised);
    canvas.drawCircle(end, 5, Paint()..color = gc.accent..style = PaintingStyle.stroke..strokeWidth = 3);
  }

  @override
  bool shouldRepaint(_VolumePainter o) => o.gc != gc || o.points != points;
}

class Sparkline extends StatelessWidget {
  const Sparkline({super.key, required this.values, this.height = 48, this.color});
  final List<double> values;
  final double height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _SparkPainter(values, color ?? gc.accent, gc.bgRaised)),
    );
  }
}

class _SparkPainter extends CustomPainter {
  _SparkPainter(this.values, this.color, this.dotBg);
  final List<double> values;
  final Color color;
  final Color dotBg;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final maxV = values.reduce(math.max);
    final minV = values.reduce(math.min);
    final range = (maxV - minV).abs() < 1e-6 ? 1.0 : (maxV - minV);
    Offset m(int i) {
      final x = size.width * i / (values.length - 1);
      final norm = (values[i] - minV) / range;
      final y = size.height * (0.85 - norm * 0.7);
      return Offset(x, y);
    }

    final line = Path()..moveTo(m(0).dx, m(0).dy);
    for (var i = 1; i < values.length; i++) {
      line.lineTo(m(i).dx, m(i).dy);
    }
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    final end = m(values.length - 1);
    canvas.drawCircle(end, 4, Paint()..color = dotBg);
    canvas.drawCircle(end, 4, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2.5);
  }

  @override
  bool shouldRepaint(_SparkPainter o) => o.values != values || o.color != color;
}

class Heatmap extends StatelessWidget {
  const Heatmap({super.key, required this.levels, this.onTapDay});
  final List<int> levels;
  final void Function(int index)? onTapDay;

  Color _color(int level, GymColors gc) =>
      level <= 0 ? gc.heatEmpty : heatLevelColor(gc, level);

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    const cols = 12, gap = 4.0;
    return LayoutBuilder(builder: (context, c) {
      final cell = (c.maxWidth - gap * (cols - 1)) / cols;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (int i = 0; i < levels.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTapDay == null ? null : () => onTapDay!(i),
              child: Container(
                width: cell,
                height: cell,
                decoration:
                    BoxDecoration(color: _color(levels[i], gc), borderRadius: BorderRadius.circular(3)),
              ),
            ),
        ],
      );
    });
  }
}

class SplitBars extends StatelessWidget {
  const SplitBars({super.key, required this.entries});
  final List<({String name, int pct})> entries;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Column(
      children: [
        for (final e in entries) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: gc.text)),
              Text('${e.pct}%', style: TextStyle(fontSize: 13, color: gc.textSecondary)),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: e.pct / 100,
              minHeight: 6,
              backgroundColor: gc.bgRaised2,
              valueColor: AlwaysStoppedAnimation(gc.accent),
            ),
          ),
          if (e != entries.last) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

enum EmblemVariant { settings, complete, about }

class Emblem extends StatelessWidget {
  const Emblem({super.key, required this.size, this.variant = EmblemVariant.complete, this.ringEmber = false});
  final double size;
  final EmblemVariant variant;
  final bool ringEmber;
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _EmblemPainter(gc, variant, ringEmber)),
    );
  }
}

class _EmblemPainter extends CustomPainter {
  _EmblemPainter(this.gc, this.variant, this.ringEmber);
  final GymColors gc;
  final EmblemVariant variant;
  final bool ringEmber;

  static const _cardinal = [
    'M50 8 L56 26 L50 20 L44 26 Z',
    'M50 92 L44 74 L50 80 L56 74 Z',
    'M8 50 L26 44 L20 50 L26 56 Z',
    'M92 50 L74 56 L80 50 L74 44 Z',
  ];
  static const _diagonal = [
    'M17 17 L33 28 L25 28 L28 33 Z',
    'M83 83 L67 72 L75 72 L72 67 Z',
    'M83 17 L72 33 L72 25 L67 28 Z',
    'M17 83 L28 67 L28 75 L33 72 Z',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 100);
    final starColor = variant == EmblemVariant.about ? gc.ember : gc.accent;

    if (variant != EmblemVariant.settings) {
      final ringColor = variant == EmblemVariant.about ? gc.border : gc.accent;
      canvas.drawCircle(const Offset(50, 50), 47,
          Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = ringColor);
    }

    final starPaint = Paint()..color = variant == EmblemVariant.settings ? gc.accent : starColor;
    for (final d in _cardinal) {
      canvas.drawPath(svgPath(d), starPaint);
    }
    if (variant == EmblemVariant.about) {
      for (final d in _diagonal) {
        canvas.drawPath(svgPath(d), starPaint);
      }
    }

    final innerR = variant == EmblemVariant.settings ? 22.0 : 24.0;
    canvas.drawCircle(const Offset(50, 50), innerR, Paint()..color = gc.bgRaised2);
    if (variant != EmblemVariant.settings) {
      canvas.drawCircle(const Offset(50, 50), 24,
          Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = gc.accent);
    }

    final facePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..color = gc.text;
    final eye = Paint()..color = gc.text;
    if (variant == EmblemVariant.complete) {
      canvas.drawPath(svgPath('M39 44 Q50 52 61 44'), facePaint);
      canvas.drawCircle(const Offset(42, 46), 2.5, eye);
      canvas.drawCircle(const Offset(58, 46), 2.5, eye);
    } else if (variant == EmblemVariant.about) {
      canvas.drawPath(svgPath('M39 46 Q50 38 61 46 M42 58 Q50 63 58 58'), facePaint);
      canvas.drawCircle(const Offset(42, 48), 2.5, eye);
      canvas.drawCircle(const Offset(58, 48), 2.5, eye);
    }
  }

  @override
  bool shouldRepaint(_EmblemPainter o) => o.gc != gc || o.variant != variant;
}
