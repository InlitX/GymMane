import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart' show shiftDays;
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'body_map.dart';
import 'svg_icon.dart';

class GoalRing extends StatelessWidget {
  const GoalRing({super.key, required this.pct, this.size = 40, this.color});
  final double pct;
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: pct),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        builder: (context, v, _) => CustomPaint(painter: _RingPainter(v, gc.bgRaised2, color ?? gc.accent)),
      ),
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
    final t = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = track;
    canvas.drawCircle(center, r, t);
    final a = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = accent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      -math.pi / 2,
      pct / 100 * 2 * math.pi,
      false,
      a,
    );
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
                        child: Text(
                          f == 1 ? '${label(top)} $unit'.trim() : label(top * f),
                          maxLines: 1,
                          style: style,
                        ),
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

    Offset m(int i) =>
        Offset(size.width * i / (points.length - 1), bottom - (bottom - top) * (points[i] / maxV));

    final line = Path()..moveTo(m(0).dx, m(0).dy);
    for (var i = 1; i < points.length; i++) {
      line.lineTo(m(i).dx, m(i).dy);
    }

    final area = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      area,
      Paint()
        ..color = gc.accentSoft
        ..style = PaintingStyle.fill,
    );
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
    canvas.drawCircle(
      end,
      5,
      Paint()
        ..color = gc.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(_VolumePainter o) => o.gc != gc || o.points != points;
}

(double, double) niceBounds(List<double> values) {
  var lo = values.reduce(math.min), hi = values.reduce(math.max);
  if ((hi - lo).abs() < 1e-9) {
    final pad = lo.abs() < 1e-9 ? 1.0 : lo.abs() * 0.1;
    lo -= pad;
    hi += pad;
  }
  final rough = (hi - lo) / 4;
  final mag = math.pow(10, (math.log(rough) / math.ln10).floor()).toDouble();
  final r = rough / mag;
  final step =
      (r <= 1
          ? 1
          : r <= 2
          ? 2
          : r <= 2.5
          ? 2.5
          : r <= 5
          ? 5
          : 10) *
      mag;
  final a = (lo / step).floorToDouble() * step;
  var n = (((hi / step).ceilToDouble() * step - a) / step).round();
  if (n < 2) n = 2;
  if (n.isOdd) n++;
  return (a, a + n * step);
}

class ChartScale extends StatelessWidget {
  const ChartScale({
    super.key,
    required this.bounds,
    required this.stops,
    required this.label,
    required this.child,
    this.fontSize = 10,
  });

  final (double, double) bounds;
  final (double, double) stops;
  final String Function(double) label;
  final Widget child;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final (lo, hi) = bounds;
    final (top, bottom) = stops;
    final marks = [
      (top, label(hi)),
      if (fontSize >= 10) ((top + bottom) / 2, label((hi + lo) / 2)),
      (bottom, label(lo)),
    ];
    final style = AppTheme.f(fontSize, weight: FontWeight.w600, color: gc.textTertiary, height: 1);
    final scaler = MediaQuery.textScalerOf(context);
    final width = marks
        .map(
          (m) => (TextPainter(
            text: TextSpan(text: m.$2, style: style),
            textDirection: TextDirection.ltr,
            textScaler: scaler,
          )..layout()).width,
        )
        .reduce(math.max);
    return LayoutBuilder(
      builder: (context, box) => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: child),
          SizedBox(width: fontSize),
          SizedBox(
            width: width + 1,
            child: LayoutBuilder(
              builder: (context, col) => Stack(
                clipBehavior: Clip.none,
                children: [
                  for (final (y, text) in marks)
                    Positioned(
                      right: 0,
                      top: col.maxHeight * y - fontSize * scaler.scale(1) / 2,
                      child: Text(text, maxLines: 1, style: style),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Sparkline extends StatelessWidget {
  const Sparkline({super.key, required this.values, this.height = 48, this.color, this.scale});
  final List<double> values;
  final double height;
  final Color? color;
  final String Function(double)? scale;
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final label = scale;
    final bounds = label == null || values.length < 2 ? null : niceBounds(values);
    final chart = CustomPaint(painter: _SparkPainter(values, color ?? gc.accent, gc.bgRaised, bounds));
    return SizedBox(
      height: height,
      width: double.infinity,
      child: label == null || bounds == null
          ? chart
          : ChartScale(bounds: bounds, stops: (0.15, 0.85), label: label, fontSize: 9, child: chart),
    );
  }
}

class _SparkPainter extends CustomPainter {
  _SparkPainter(this.values, this.color, this.dotBg, [this.bounds]);
  final List<double> values;
  final Color color;
  final Color dotBg;
  final (double, double)? bounds;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final maxV = bounds?.$2 ?? values.reduce(math.max);
    final minV = bounds?.$1 ?? values.reduce(math.min);
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
    canvas.drawCircle(
      end,
      4,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(_SparkPainter o) => o.values != values || o.color != color || o.bounds != bounds;
}

class TrendChart extends StatelessWidget {
  const TrendChart({super.key, required this.values, this.height = 90, this.color, this.scale});
  final List<double> values;
  final double height;
  final Color? color;
  final String Function(double)? scale;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final label = scale;
    final bounds = label == null || values.length < 2 ? null : niceBounds(values);
    final chart = CustomPaint(
      painter: _TrendPainter(values, color ?? gc.accent, gc.bgRaised, gc.border, bounds),
    );
    return SizedBox(
      height: height,
      width: double.infinity,
      child: label == null || bounds == null
          ? chart
          : ChartScale(bounds: bounds, stops: (0.12, 0.88), label: label, child: chart),
    );
  }
}

class _TrendPainter extends CustomPainter {
  _TrendPainter(this.values, this.color, this.dotBg, this.grid, [this.bounds]);
  final List<double> values;
  final Color color;
  final Color dotBg;
  final Color grid;
  final (double, double)? bounds;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = grid.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    for (final f in const [0.12, 0.5, 0.88]) {
      final y = size.height * f;
      for (var x = 0.0; x < size.width; x += 7) {
        canvas.drawLine(Offset(x, y), Offset(math.min(x + 3, size.width), y), gridPaint);
      }
    }
    if (values.length < 2) return;
    final maxV = bounds?.$2 ?? values.reduce(math.max);
    final minV = bounds?.$1 ?? values.reduce(math.min);
    final range = (maxV - minV).abs() < 1e-6 ? 1.0 : (maxV - minV);
    const inset = 6.0;
    final pts = [
      for (var i = 0; i < values.length; i++)
        Offset(
          inset + (size.width - inset * 2) * i / (values.length - 1),
          size.height * (0.88 - (values[i] - minV) / range * 0.76),
        ),
    ];
    final n = pts.length;
    final slope = [for (var i = 0; i < n - 1; i++) (pts[i + 1].dy - pts[i].dy) / (pts[i + 1].dx - pts[i].dx)];
    final tangent = List<double>.filled(n, 0);
    tangent[0] = slope.first;
    tangent[n - 1] = slope.last;
    for (var i = 1; i < n - 1; i++) {
      tangent[i] = slope[i - 1] * slope[i] <= 0 ? 0 : (slope[i - 1] + slope[i]) / 2;
    }
    for (var i = 0; i < n - 1; i++) {
      if (slope[i] == 0) {
        tangent[i] = 0;
        tangent[i + 1] = 0;
        continue;
      }
      final a = tangent[i] / slope[i], b = tangent[i + 1] / slope[i];
      final h = a * a + b * b;
      if (h > 9) {
        final k = 3 / math.sqrt(h);
        tangent[i] = k * a * slope[i];
        tangent[i + 1] = k * b * slope[i];
      }
    }
    final line = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 0; i < n - 1; i++) {
      final dx = (pts[i + 1].dx - pts[i].dx) / 3;
      line.cubicTo(
        pts[i].dx + dx,
        pts[i].dy + tangent[i] * dx,
        pts[i + 1].dx - dx,
        pts[i + 1].dy - tangent[i + 1] * dx,
        pts[i + 1].dx,
        pts[i + 1].dy,
      );
    }
    final area = Path.from(line)
      ..lineTo(pts.last.dx, size.height)
      ..lineTo(pts.first.dx, size.height)
      ..close();
    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.28), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    final end = pts.last;
    canvas.drawCircle(end, 8, Paint()..color = color.withValues(alpha: 0.22));
    canvas.drawCircle(end, 4.5, Paint()..color = dotBg);
    canvas.drawCircle(
      end,
      4.5,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(_TrendPainter o) =>
      o.values != values || o.color != color || o.grid != grid || o.bounds != bounds;
}

class Heatmap extends StatelessWidget {
  const Heatmap({
    super.key,
    required this.levels,
    this.onTapDay,
    this.firstDay,
    this.labels = false,
    this.cellSize,
    this.weekdays = true,
  });
  final List<int> levels;
  final void Function(int index)? onTapDay;
  final DateTime? firstDay;
  final bool labels;
  final double? cellSize;
  final bool weekdays;

  Color _color(int level, GymColors gc) => level <= 0 ? gc.heatEmpty : heatLevelColor(gc, level);

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    const rows = 7, gap = 4.0;
    final cols = (levels.length / rows).ceil();
    final start = firstDay;
    final named = labels && start != null;
    final side = named && weekdays ? 16.0 : 0.0;
    final top = named ? 16.0 : 0.0;
    final labelStyle = AppTheme.f(9, weight: FontWeight.w600, color: gc.textTertiary);
    final yearStyle = AppTheme.f(9, weight: FontWeight.w800, color: gc.textSecondary);
    return LayoutBuilder(
      builder: (context, c) {
        var cell = cellSize ?? (c.maxWidth - side - gap * (cols - 1)) / cols;
        if (cellSize == null && c.hasBoundedHeight) {
          cell = math.min(cell, (c.maxHeight - top - gap * (rows - 1)) / rows);
        }
        Widget box(int i) {
          final level = i < levels.length ? levels[i] : -1;
          if (level < 0) return SizedBox(width: cell, height: cell);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTapDay == null ? null : () => onTapDay!(i),
            child: Container(
              width: cell,
              height: cell,
              decoration: BoxDecoration(color: _color(level, gc), borderRadius: BorderRadius.circular(3)),
            ),
          );
        }

        Widget spaced(Axis axis, List<Widget> items) {
          final out = <Widget>[];
          for (var i = 0; i < items.length; i++) {
            if (i > 0) {
              out.add(
                SizedBox(width: axis == Axis.horizontal ? gap : 0, height: axis == Axis.vertical ? gap : 0),
              );
            }
            out.add(items[i]);
          }
          return axis == Axis.horizontal
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: out,
                )
              : Column(mainAxisSize: MainAxisSize.min, children: out);
        }

        final grid = spaced(Axis.horizontal, [
          for (var col = 0; col < cols; col++)
            spaced(Axis.vertical, [for (var r = 0; r < rows; r++) box(col * rows + r)]),
        ]);
        if (!named) return grid;

        final months = <Widget>[];
        int? lastMonth;
        for (var col = 0; col < cols; col++) {
          final day = shiftDays(start, col * rows);
          final month = day.month;
          if (month != lastMonth && (col > 0 || shiftDays(start, 0).day <= 7)) {
            final year = cellSize != null && month == 1;
            months.add(
              Positioned(
                left: side + col * (cell + gap),
                top: 0,
                child: Text(year ? '${day.year}' : t.monthShort(month), style: year ? yearStyle : labelStyle),
              ),
            );
          }
          lastMonth = month;
        }
        return SizedBox(
          width: side + cols * cell + (cols - 1) * gap,
          height: top + rows * cell + (rows - 1) * gap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ...months,
              if (weekdays)
                Positioned(
                  left: 0,
                  top: top,
                  child: spaced(Axis.vertical, [
                    for (var r = 0; r < rows; r++)
                      SizedBox(
                        width: side,
                        height: cell,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(t.weekdayInitial(shiftDays(start, r).weekday), style: labelStyle),
                        ),
                      ),
                  ]),
                ),
              Positioned(left: side, top: top, child: grid),
            ],
          ),
        );
      },
    );
  }
}

class HeatmapYear extends StatelessWidget {
  const HeatmapYear({
    super.key,
    required this.levels,
    required this.firstDay,
    this.onTapDay,
    this.weekdays = true,
  });
  final List<int> levels;
  final DateTime firstDay;
  final void Function(int index)? onTapDay;
  final bool weekdays;

  static const cell = 13.0;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final labelStyle = AppTheme.f(9, weight: FontWeight.w600, color: gc.textTertiary);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (weekdays)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                for (var r = 0; r < 7; r++)
                  Container(
                    width: 16,
                    height: cell,
                    margin: EdgeInsets.only(top: r == 0 ? 0 : 4),
                    alignment: Alignment.centerLeft,
                    child: Text(t.weekdayInitial(shiftDays(firstDay, r).weekday), style: labelStyle),
                  ),
              ],
            ),
          ),
        Expanded(
          child: ShaderMask(
            shaderCallback: (r) => const LinearGradient(
              colors: [Color(0x00FFFFFF), Color(0xFFFFFFFF)],
              stops: [0, 0.08],
            ).createShader(r),
            blendMode: BlendMode.dstIn,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              padding: const EdgeInsets.only(left: 18),
              child: Heatmap(
                levels: levels,
                firstDay: firstDay,
                labels: true,
                weekdays: false,
                cellSize: cell,
                onTapDay: onTapDay,
              ),
            ),
          ),
        ),
      ],
    );
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
              Text(
                e.name,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: gc.text),
              ),
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
  const Emblem({
    super.key,
    required this.size,
    this.variant = EmblemVariant.complete,
    this.ringEmber = false,
  });
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
      canvas.drawCircle(
        const Offset(50, 50),
        47,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = ringColor,
      );
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
      canvas.drawCircle(
        const Offset(50, 50),
        24,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = gc.accent,
      );
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
