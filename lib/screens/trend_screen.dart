import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../services/trend_math.dart';
import '../state/fit_state.dart';
import '../app/desktop.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/charts.dart';
import '../widgets/rolling_text.dart';
import '../widgets/ui_kit.dart';

typedef TrendPoint = ({DateTime date, double value});

class TrendSeries {
  const TrendSeries({
    required this.name,
    required this.unit,
    required this.points,
    required this.format,
    this.lowerIsBetter = false,
    this.judged = true,
    this.color,
  });

  final String name;
  final String unit;
  final List<TrendPoint> points;
  final String Function(double) format;
  final bool lowerIsBetter;
  final bool judged;
  final Color? color;
}

Future<void> openTrendScreen(
  BuildContext context, {
  required String title,
  String? subtitle,
  required List<TrendSeries> series,
  int initial = 0,
  List<int> ranges = const [30, 90, 365, 0],
}) {
  final shown = [for (final s in series) if (s.points.length >= 2) s];
  if (shown.isEmpty) return Future.value();
  final pick = shown.indexOf(series[initial.clamp(0, series.length - 1)]);
  HapticFeedback.selectionClick();
  return Navigator.of(context).push(PageRouteBuilder<void>(
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, _, _) => TrendScreen(
      title: title,
      subtitle: subtitle,
      series: shown,
      initial: pick < 0 ? 0 : pick,
      ranges: ranges,
    ),
    transitionsBuilder: (_, a, _, child) {
      final curve = CurvedAnimation(parent: a, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(curve),
          child: child,
        ),
      );
    },
  ));
}

List<TrendSeries> exerciseTrendSeries(String id) {
  final weight = fit.unitsFor(id);
  final reps = t.repsCol.toLowerCase();
  String one(double v) => fmt((v * 10).round() / 10);
  String whole(double v) => groupedInt(v.round());
  List<TrendPoint> shown(List<TrendPoint> pts, double Function(double) f) => [
        for (final p in pts) (date: p.date, value: f(p.value)),
      ];
  return [
    for (final kind in fit.trendKindsFor(id))
      switch (kind) {
        TrendKind.oneRm => TrendSeries(
            name: t.estOneRm,
            unit: weight,
            points: shown(fit.exerciseSeries(id, kind), (v) => fit.toShownFor(id, v)),
            format: one,
          ),
        TrendKind.top => TrendSeries(
            name: fit.isAssisted(id) ? t.trendTopAssisted : t.trendTop,
            unit: weight,
            points: shown(fit.exerciseSeries(id, kind), (v) => fit.toShownFor(id, v)),
            format: one,
            lowerIsBetter: fit.isAssisted(id),
          ),
        TrendKind.reps => TrendSeries(
            name: t.trendReps,
            unit: reps,
            points: fit.exerciseSeries(id, kind),
            format: whole,
          ),
        TrendKind.volume => fit.isRepsOnly(id)
            ? TrendSeries(name: t.trendTotalReps, unit: reps, points: fit.exerciseSeries(id, kind), format: whole)
            : TrendSeries(
                name: t.trendVolume,
                unit: weight,
                points: shown(fit.exerciseSeries(id, kind), (v) => fit.toShownFor(id, v)),
                format: whole,
              ),
        TrendKind.sets => TrendSeries(name: t.statSets, unit: '', points: fit.exerciseSeries(id, kind), format: whole),
        TrendKind.time => TrendSeries(
            name: t.recapTickTime,
            unit: '',
            points: fit.exerciseSeries(id, kind),
            format: (v) => durationLabel(v.round()),
          ),
        TrendKind.distance => TrendSeries(
            name: t.healthDistance,
            unit: fit.distanceUnitFor(id),
            points: shown(fit.exerciseSeries(id, kind), (v) => fit.toDisplayKmFor(id, v)),
            format: (v) => fmt((v * 100).round() / 100),
          ),
      },
  ];
}

class TrendScreen extends StatefulWidget {
  const TrendScreen({
    super.key,
    required this.title,
    this.subtitle,
    required this.series,
    this.initial = 0,
    this.ranges = const [30, 90, 365, 0],
  });

  final String title;
  final String? subtitle;
  final List<TrendSeries> series;
  final int initial;
  final List<int> ranges;

  @override
  State<TrendScreen> createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen> {
  late int _pick = widget.initial;
  late int _range = _bestRange();
  int? _touch;
  late final List<GlobalKey> _chips = [for (final _ in widget.series) GlobalKey()];

  @override
  void initState() {
    super.initState();
    if (_pick > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final chip = _chips[_pick].currentContext;
        if (chip != null && chip.mounted) Scrollable.ensureVisible(chip, alignment: 0.5);
      });
    }
  }

  TrendSeries get _series => widget.series[_pick];

  int _bestRange() {
    final now = DateTime.now();
    for (final r in widget.ranges) {
      if (pointsSince(widget.series[_pick].points, r, now).length >= 3) return r;
    }
    return widget.ranges.last;
  }

  String _rangeLabel(int r) => switch (r) {
        7 => t.days7,
        30 => t.days30,
        90 => t.days90,
        365 => t.days365,
        _ => t.daysAll,
      };

  String _withUnit(TrendSeries s, String v) => s.unit.isEmpty ? v : '$v ${s.unit}';

  void _setPick(int i) {
    if (i == _pick) return;
    HapticFeedback.selectionClick();
    setState(() {
      _pick = i;
      _touch = null;
      if (pointsSince(_series.points, _range, DateTime.now()).length < 2) _range = _bestRange();
    });
  }

  void _setRange(int r) {
    if (r == _range) return;
    HapticFeedback.selectionClick();
    setState(() {
      _range = r;
      _touch = null;
    });
  }

  void _setTouch(int? i) {
    if (i == _touch) return;
    if (i != null) HapticFeedback.selectionClick();
    setState(() => _touch = i);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final s = _series;
    final color = s.color ?? gc.accent;
    final points = pointsSince(s.points, _range, DateTime.now());
    final enough = points.length >= 2;
    final line = enough ? fitTrend(points) : null;
    final touch = _touch == null || _touch! >= points.length ? null : _touch;
    final focus = points.isEmpty ? null : points[touch ?? points.length - 1];
    final values = [for (final p in points) p.value];
    final best = values.isEmpty ? null : (s.lowerIsBetter && s.judged ? values.reduce(math.min) : values.reduce(math.max));
    final avg = values.isEmpty ? null : values.reduce((a, b) => a + b) / values.length;
    final spanDays = enough ? points.last.date.difference(points.first.date).inDays : 0;
    final monthly = _range == 0 || _range >= 90 || spanDays > 45;
    final flat = line == null || trendIsFlat(line, points);
    final rate = line == null ? 0.0 : line.slopePerDay * (monthly ? 30 : 7);
    final rateText = _withUnit(s, s.format(rate.abs()));
    final sentence = !enough
        ? t.trendNeedMore
        : flat
            ? t.trendFlatLine
            : rate > 0
                ? (monthly ? t.trendUpMonth(rateText) : t.trendUpWeek(rateText))
                : (monthly ? t.trendDownMonth(rateText) : t.trendDownWeek(rateText));
    final delta = enough ? points.last.value - points.first.value : 0.0;

    final lowest = values.isEmpty ? null : values.reduce(math.min);
    final highest = values.isEmpty ? null : values.reduce(math.max);
    final height = MediaQuery.sizeOf(context).height;
    final chartH = (height * 0.3).clamp(190.0, 280.0);
    Color tone(double d) => !s.judged || d.abs() < 1e-9
        ? gc.textSecondary
        : ((s.lowerIsBetter ? d < 0 : d > 0) ? gc.sage : gc.textSecondary);
    String signed(double d) => '${d >= 0 ? '+' : '−'}${_withUnit(s, s.format(d.abs()))}';
    final head = <Widget>[
      if (widget.series.length > 1) ...[
        const SizedBox(height: 4),
        SizedBox(
          height: 36,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (var i = 0; i < widget.series.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Pill(
                  key: _chips[i],
                  label: widget.series[i].name,
                  bg: i == _pick ? gc.ember : gc.bgRaised,
                  fg: i == _pick ? gc.onEmber : gc.textSecondary,
                  vPad: 0,
                  onTap: () => _setPick(i),
                ),
              ],
            ]),
          ),
        ),
      ],
      const SizedBox(height: 18),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Ltr(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  RollingText(focus == null ? '—' : s.format(focus.value),
                      style: AppTheme.d(40, weight: FontWeight.w800, color: gc.text, height: 1.05)),
                  if (s.unit.isNotEmpty && focus != null) ...[
                    const SizedBox(width: 6),
                    Text(s.unit, style: AppTheme.f(16, weight: FontWeight.w700, color: gc.textSecondary)),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(children: [
              if (touch == null && enough && delta.abs() > 1e-9)
                TextSpan(
                  text: '${ltr(signed(delta))}  ',
                  style: AppTheme.f(13, weight: FontWeight.w700, color: tone(delta)),
                ),
              TextSpan(
                text: touch == null ? _rangeLabel(_range) : (focus == null ? '' : _day(focus.date)),
                style: AppTheme.f(13, weight: FontWeight.w600, color: touch == null ? gc.textTertiary : gc.text),
              ),
            ]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]),
      ),
      const SizedBox(height: 14),
      SizedBox(
        height: chartH,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: KeyedSubtree(
            key: ValueKey((_pick, _range)),
            child: enough
                ? _BigTrend(
                    points: points,
                    fit: line,
                    color: color,
                    format: s.format,
                    touch: touch,
                    onTouch: _setTouch,
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(t.trendNeedMore,
                          textAlign: TextAlign.center,
                          style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                    ),
                  ),
          ),
        ),
      ),
      const SizedBox(height: 12),
      Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SegToggle([
            for (final r in widget.ranges) SegOption(_rangeLabel(r), r == _range, () => _setRange(r)),
          ]),
        ),
      ),
      const SizedBox(height: 22),
    ];
    final summary = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 4, bottom: 10),
        child: Text(sentence, style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text, height: 1.3)),
      ),
      _card(gc, [
        _row(
          gc,
          t.trendSlope,
          !enough || flat
              ? t.trendFlat
              : '${rate > 0 ? '+' : '−'}${monthly ? t.trendPerMonth(s.format(rate.abs())) : t.trendPerWeek(s.format(rate.abs()))}',
        ),
        _row(gc, t.trendChange, enough ? signed(delta) : '—', color: enough ? tone(delta) : null),
        _row(gc, s.judged ? t.recapBest : t.healthHigh, best == null ? '—' : _withUnit(s, s.format(best))),
        if (!s.judged && lowest != null && highest != lowest) _row(gc, t.trendLow, _withUnit(s, s.format(lowest))),
        _row(gc, t.recapAvgLabel, avg == null ? '—' : _withUnit(s, s.format(avg))),
        _row(gc, t.trendCount, groupedInt(points.length)),
      ]),
      if (enough) ...[
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4),
          child: Text(t.trendLineHint, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.35)),
        ),
      ],
    ]);
    final historyTitle = Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, bottom: 10),
      child: Text(sentenceCase(t.historyTitle), style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text)),
    );
    final total = math.min(points.length, 120);
    Widget historyAt(int k) {
      final idx = points.length - 1 - k;
      final p = points[idx];
      final prev = idx > 0 ? points[idx - 1].value : null;
      return _historyRow(
        gc,
        p,
        prev == null ? null : p.value - prev,
        tone,
        signed,
        first: k == 0,
        last: k == total - 1,
        on: touch == idx,
        onTap: () => _setTouch(touch == idx ? null : idx),
      );
    }

    final wide = DesktopScope.wideFor(MediaQuery.sizeOf(context).width);
    if (wide) {
      head.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: summary),
          const SizedBox(width: 24),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              if (points.isNotEmpty) historyTitle,
              for (var k = 0; k < total; k++) historyAt(k),
            ]),
          ),
        ]),
      ));
    } else {
      head
        ..add(Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: summary))
        ..add(points.isEmpty
            ? const SizedBox.shrink()
            : Padding(padding: const EdgeInsets.fromLTRB(20, 22, 20, 0), child: historyTitle));
    }
    final shownRows = wide ? 0 : total;

    return Material(
      color: gc.bg,
      child: Stack(children: [
        Positioned.fill(child: AppBackground(pattern: fit.bgPattern, photo: fit.bgPhotoPath, dim: fit.bgDim)),
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                child: ScreenHeader(
                  title: widget.title,
                  subtitle: widget.subtitle,
                  onBack: () => Navigator.of(context).maybePop(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 24 + MediaQuery.paddingOf(context).bottom),
                  itemCount: head.length + shownRows,
                  itemBuilder: (context, i) {
                    if (i < head.length) return head[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: historyAt(i - head.length),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  String _day(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(d.year, d.month, d.day);
    if (day == today) return t.noteToday;
    if (day == DateTime(today.year, today.month, today.day - 1)) return t.noteYesterday;
    return d.year == now.year ? t.shortDate(d) : t.shortDateYear(d);
  }

  Widget _card(GymColors gc, List<Widget> rows) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
        child: Column(children: [
          for (final (i, r) in rows.indexed) ...[
            if (i > 0) Divider(height: 1, thickness: 1, color: gc.border.withValues(alpha: 0.6)),
            r,
          ],
        ]),
      );

  Widget _row(GymColors gc, String label, String value, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(children: [
          Expanded(
            child: Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14, weight: FontWeight.w500, color: gc.textSecondary)),
          ),
          const SizedBox(width: 12),
          Text(ltr(value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: AppTheme.f(14.5, weight: FontWeight.w800, color: color ?? gc.text)),
        ]),
      );

  Widget _historyRow(
    GymColors gc,
    TrendPoint p,
    double? change,
    Color Function(double) tone,
    String Function(double) signed, {
    required bool first,
    required bool last,
    required bool on,
    required VoidCallback onTap,
  }) {
    final s = _series;
    const r = Radius.circular(22);
    return Pressable(
      scale: 0.99,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: on ? gc.bgRaised2 : gc.bgRaised,
          borderRadius: BorderRadius.vertical(top: first ? r : Radius.zero, bottom: last ? r : Radius.zero),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: first ? null : Border(top: BorderSide(color: gc.border.withValues(alpha: 0.6))),
          ),
          child: Row(children: [
            Expanded(
              child: Text(_day(p.date),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
            ),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(ltr(_withUnit(s, s.format(p.value))),
                  style: AppTheme.f(14.5, weight: FontWeight.w800, color: gc.text)),
              if (change != null && change.abs() > 1e-9)
                Text(ltr(signed(change)), style: AppTheme.f(11.5, weight: FontWeight.w700, color: tone(change))),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _BigTrend extends StatelessWidget {
  const _BigTrend({
    required this.points,
    required this.fit,
    required this.color,
    required this.format,
    required this.touch,
    required this.onTouch,
  });

  final List<TrendPoint> points;
  final TrendFit? fit;
  final Color color;
  final String Function(double) format;
  final int? touch;
  final ValueChanged<int?> onTouch;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final scaler = MediaQuery.textScalerOf(context);
    final f = fit;
    final first = points.first.date, last = points.last.date;
    final span = last.difference(first).inMinutes.toDouble();
    final long = last.difference(first).inDays > 300;
    final scale = _Scale.of([
      for (final p in points) p.value,
      if (f != null) f.at(first),
      if (f != null) f.at(last),
    ]);
    final label = AppTheme.f(10.5, weight: FontWeight.w600, color: gc.textTertiary);
    return LayoutBuilder(builder: (context, box) {
      final width = box.maxWidth;
      final plotRight = width;
      double xOf(DateTime d) => span <= 0 ? width / 2 : width * d.difference(first).inMinutes / span;
      final xs = [for (final p in points) xOf(p.date)];
      final count = width < 340 ? 3 : 4;
      String day(DateTime d) => long ? t.shortMonthYear(d) : t.shortDate(d);
      final ticks = span <= 0
          ? [(x: width / 2, text: day(first))]
          : [
              for (var i = 0; i < count; i++)
                (
                  x: xOf(first.add(Duration(minutes: (span * i / (count - 1)).round()))),
                  text: day(first.add(Duration(minutes: (span * i / (count - 1)).round()))),
                ),
            ];
      int nearest(double x) {
        var best = 0;
        var gap = double.infinity;
        for (var i = 0; i < xs.length; i++) {
          final g = (xs[i] - x).abs();
          if (g < gap) {
            gap = g;
            best = i;
          }
        }
        return best;
      }

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => onTouch(nearest(d.localPosition.dx)),
        onTapUp: (_) => onTouch(null),
        onTapCancel: () => onTouch(null),
        onHorizontalDragStart: (d) => onTouch(nearest(d.localPosition.dx)),
        onHorizontalDragUpdate: (d) => onTouch(nearest(d.localPosition.dx)),
        onHorizontalDragEnd: (_) => onTouch(null),
        onHorizontalDragCancel: () => onTouch(null),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 520),
          curve: Curves.easeOutCubic,
          builder: (_, reveal, _) => CustomPaint(
            size: Size.infinite,
            painter: _BigTrendPainter(
              xs: xs,
              values: [for (final p in points) p.value],
              trend: f == null ? null : (f.at(first), f.at(last)),
              scale: scale,
              ticks: ticks,
              format: format,
              reveal: reveal,
              color: color,
              dotBg: gc.bg,
              grid: gc.border,
              label: label,
              plotRight: plotRight,
              trendColor: gc.textSecondary,
              scaler: scaler,
              touch: touch,
            ),
          ),
        ),
      );
    });
  }
}

class _Scale {
  const _Scale(this.lo, this.hi, this.lines);

  final double lo;
  final double hi;
  final List<double> lines;

  static _Scale of(List<double> values) {
    var lo = values.reduce(math.min), hi = values.reduce(math.max);
    if ((hi - lo).abs() < 1e-9) {
      final pad = lo.abs() < 1e-9 ? 1.0 : lo.abs() * 0.05;
      lo -= pad;
      hi += pad;
    }
    final mid = (hi + lo) / 2;
    final least = mid.abs() * 0.04;
    if (hi - lo < least) {
      lo = mid - least / 2;
      hi = mid + least / 2;
    }
    final pad = (hi - lo) * 0.08;
    lo -= pad;
    hi += pad;
    if (values.every((v) => v >= 0) && lo < 0) lo = 0;
    final mag = math.pow(10, (math.log((hi - lo) / 4) / math.ln10).floor() + 1).toDouble();
    var lines = <double>[];
    for (final f in const [1.0, 0.5, 0.25, 0.2, 0.1, 0.05, 0.025, 0.02, 0.01]) {
      final step = mag * f;
      lines = [
        for (var k = (lo / step).ceil(); k * step <= hi + 1e-9; k++) k * step,
      ];
      if (lines.length >= 4) break;
    }
    return _Scale(lo, hi, lines.length > 6 ? [for (var i = 0; i < lines.length; i += 2) lines[i]] : lines);
  }
}

class _BigTrendPainter extends CustomPainter {
  _BigTrendPainter({
    required this.xs,
    required this.values,
    required this.trend,
    required this.scale,
    required this.ticks,
    required this.format,
    required this.reveal,
    required this.color,
    required this.dotBg,
    required this.grid,
    required this.label,
    required this.plotRight,
    required this.trendColor,
    required this.scaler,
    required this.touch,
  });

  final List<double> xs;
  final List<double> values;
  final (double, double)? trend;
  final _Scale scale;
  final List<({double x, String text})> ticks;
  final String Function(double) format;
  final double reveal;
  final Color color;
  final Color dotBg;
  final Color grid;
  final TextStyle label;
  final double plotRight;
  final Color trendColor;
  final TextScaler scaler;
  final int? touch;

  TextPainter _text(String s) =>
      TextPainter(text: TextSpan(text: s, style: label), textDirection: TextDirection.ltr, textScaler: scaler)..layout();

  @override
  void paint(Canvas canvas, Size size) {
    final labelH = _text('0').height;
    final top = labelH / 2 + 10;
    final bottom = size.height - labelH - 16;
    final range = scale.hi - scale.lo;
    double yOf(double v) => bottom - (v - scale.lo) / range * (bottom - top);
    final full = Offset.zero & size;

    final gridPaint = Paint()
      ..color = grid.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    canvas.saveLayer(full, Paint());
    for (final v in scale.lines) {
      final y = yOf(v);
      if (y > size.height - 2 || y < 0) continue;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    final cols = (size.width / 64).round().clamp(4, 9);
    for (var i = 1; i < cols; i++) {
      final x = size.width * i / cols;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    const fade = [Colors.transparent, Colors.black, Colors.black, Colors.transparent];
    const edges = [0.0, 0.14, 0.86, 1.0];
    canvas.drawRect(
      full,
      Paint()
        ..blendMode = BlendMode.dstIn
        ..shader = const LinearGradient(colors: fade, stops: edges).createShader(full),
    );
    canvas.drawRect(
      full,
      Paint()
        ..blendMode = BlendMode.dstIn
        ..shader = const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: fade, stops: edges)
            .createShader(full),
    );
    canvas.restore();

    final pts = [for (var i = 0; i < values.length; i++) Offset(xs[i], yOf(values[i]))];
    final edge = xs.first + (xs.last - xs.first) * reveal;
    canvas.save();
    if (reveal < 1) canvas.clipRect(Rect.fromLTRB(0, 0, edge + 1, size.height));

    final line = smoothPath(pts);
    if (pts.length > 1) {
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
            colors: [color.withValues(alpha: 0.24), color.withValues(alpha: 0.06), color.withValues(alpha: 0)],
            stops: const [0, 0.6, 1],
          ).createShader(Rect.fromLTRB(0, top, size.width, size.height)),
      );
    }

    final tr = trend;
    if (tr != null) {
      final a = Offset(xs.first, yOf(tr.$1)), b = Offset(xs.last, yOf(tr.$2));
      final len = (b - a).distance;
      if (len > 1) {
        final dir = (b - a) / len;
        final dash = Paint()
          ..color = trendColor.withValues(alpha: 0.55)
          ..strokeWidth = 1.4
          ..strokeCap = StrokeCap.round;
        for (var d = 0.0; d < len; d += 9) {
          canvas.drawLine(a + dir * d, a + dir * math.min(d + 4, len), dash);
        }
      }
    }

    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.restore();

    for (final v in scale.lines) {
      final y = yOf(v);
      if (y > bottom - labelH || y < labelH / 2) continue;
      final tp = _text(format(v));
      final box = Rect.fromLTWH(size.width - tp.width - 22, y - tp.height / 2 - 4, tp.width + 14, tp.height + 8);
      canvas.drawRRect(RRect.fromRectAndRadius(box, const Radius.circular(8)), Paint()..color = dotBg.withValues(alpha: 0.92));
      tp.paint(canvas, Offset(box.left + 7, box.top + 4));
    }

    if (ticks.length > 1) {
      final dim = label.copyWith(color: label.color?.withValues(alpha: 0.8));
      TextPainter small(String t) =>
          TextPainter(text: TextSpan(text: t, style: dim), textDirection: TextDirection.ltr, textScaler: scaler)..layout();
      final a = small(ticks.first.text), b = small(ticks.last.text);
      final y = size.height - a.height - 2;
      a.paint(canvas, Offset(16, y));
      b.paint(canvas, Offset(size.width - b.width - 16, y));
    }

    if (touch == null) return;
    final at = pts[touch!];
    canvas.drawLine(
      Offset(at.dx, 0),
      Offset(at.dx, size.height),
      Paint()
        ..color = trendColor.withValues(alpha: 0.45)
        ..strokeWidth = 1,
    );
    canvas.drawCircle(at, 10, Paint()..color = color.withValues(alpha: 0.2));
    canvas.drawCircle(at, 5.5, Paint()..color = dotBg);
    canvas.drawCircle(
        at,
        5.5,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.6);
  }

  @override
  bool shouldRepaint(_BigTrendPainter o) =>
      o.touch != touch ||
      o.reveal != reveal ||
      o.values != values ||
      o.xs != xs ||
      o.color != color ||
      o.trend != trend ||
      o.dotBg != dotBg ||
      o.label != label;
}
