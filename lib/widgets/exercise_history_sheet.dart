import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'charts.dart';
import 'glass.dart';
import 'ui_kit.dart';

void showExerciseHistorySheet(BuildContext context, String exerciseId) {
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ExerciseHistorySheet(exerciseId: exerciseId),
  );
}

class ExerciseHistorySheet extends StatefulWidget {
  const ExerciseHistorySheet({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  State<ExerciseHistorySheet> createState() => _ExerciseHistorySheetState();
}

class _ExerciseHistorySheetState extends State<ExerciseHistorySheet> {
  static const _page = 12;
  static const _ranges = [30, 90, 365, 0];

  String get _id => widget.exerciseId;
  late final _history = fit.exerciseHistory(_id);
  late final bool _charted = fit.modeOf(_id).isEmpty && fit.exerciseTrend(_id).length > 1;
  late final _ladder = fit.repRecords(_id);
  late final _record = fit.exerciseRecord(_id);
  late int _range = _pickRange();
  bool _relative = false;
  int _shown = _page;

  int _pickRange() {
    for (final r in _ranges) {
      if (fit.exerciseTrend(_id, days: r).length >= 3) return r;
    }
    return 0;
  }

  String _rangeLabel(int r) => switch (r) {
        30 => t.days30,
        90 => t.days90,
        365 => t.days365,
        _ => t.daysAll,
      };

  bool get _plain => fit.isRepsOnly(_id) || _relative;

  String _value(double v) => _plain ? '${v.round()}' : fit.weightValueFor(_id, v);

  String get _unit => _relative ? '%' : fit.isRepsOnly(_id) ? t.repsCol.toLowerCase() : fit.unitsFor(_id);

  String _summary(List<LoggedSet> sets) => sets
      .map((s) => s.rpe == null
          ? fit.loggedSetLabel(s, id: _id)
          : '${fit.loggedSetLabel(s, id: _id)} ${fit.effortTag(s.rpe!)}')
      .join(' · ');

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final ex = fit.exerciseById(_id);
    final rows = _history.take(_shown).toList();
    return Container(
      padding: sheetPad(context),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.86),
      decoration: sheetDecoration(gc),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 18),
            Text(ex == null ? '' : exerciseName(ex), style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
            const SizedBox(height: 4),
            Text('${titleCase(t.history)} · ${t.sessionCount(_history.length)}',
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
            if (_record != null) ...[
              const SizedBox(height: 16),
              _records(gc, _record),
            ],
            if (_charted) ...[
              const SizedBox(height: 18),
              _trend(gc),
            ],
            const SizedBox(height: 14),
            if (_history.isEmpty)
              Text(t.noHistory, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                for (var i = 0; i < rows.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: i < rows.length - 1
                          ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.55)))
                          : null,
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(
                        width: 92,
                        child: Text(t.shortDate(rows[i].date),
                            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text)),
                      ),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(_summary(rows[i].ex.sets),
                              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                          for (var k = 0; k < rows[i].ex.sets.length; k++)
                            if (rows[i].ex.sets[k].note.isNotEmpty) ...[
                              const SizedBox(height: 3),
                              Text(t.setNoteLine(k + 1, rows[i].ex.sets[k].note),
                                  style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.35)),
                            ],
                        ]),
                      ),
                    ]),
                  ),
              ]),
            ),
            if (_history.length > _shown) ...[
              const SizedBox(height: 10),
              Center(
                child: Pressable(
                  scale: 0.95,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _shown += _page);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
                    child: Text(t.historyMore((_history.length - _shown).clamp(0, _page)),
                        style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _when(DateTime d) => d.year == DateTime.now().year ? t.shortDate(d) : t.shortMonthYear(d);

  Widget _records(GymColors gc, PersonalRecord pr) {
    final kind = _ladder.isNotEmpty
        ? PrKind.weight
        : pr.kind == PrKind.weight && fit.isAssisted(_id)
            ? PrKind.reps
            : pr.kind;
    final work = kind == PrKind.weight || kind == PrKind.reps ? fit.bestWorkout(_id, kind) : null;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (_ladder.isNotEmpty) ...[
          SectionLabel('${t.repRecordsTitle} · ${fit.unitsFor(_id)}'),
          const SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (var i = 0; i < _ladder.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(child: _rung(gc, _ladder[i])),
            ],
          ]),
        ] else ...[
          SectionLabel(t.personalRecord),
          const SizedBox(height: 8),
          FitText(fit.recordLabel(pr), style: AppTheme.d(22, weight: FontWeight.w800, color: gc.text)),
        ],
        if (work != null) ...[
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: Text(t.prBestWorkout,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
            ),
            const SizedBox(width: 10),
            Text(
                kind == PrKind.weight
                    ? '${groupedInt(fit.toShownFor(_id, work.score).round())} ${fit.unitsFor(_id)}'
                    : t.repCount(work.score.round()),
                style: AppTheme.d(13.5, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(width: 8),
            Text(_when(work.date), style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
          ]),
        ],
      ]),
    );
  }

  Widget _rung(GymColors gc, ({int reps, double kg, DateTime date}) r) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitText(fit.weightValueFor(_id, r.kg), style: AppTheme.d(20, weight: FontWeight.w800, color: gc.text)),
          const SizedBox(height: 5),
          FitText(t.repCount(r.reps), style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
          const SizedBox(height: 2),
          FitText(_when(r.date), style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary)),
        ],
      );

  Widget _trend(GymColors gc) {
    final points = fit.exerciseTrend(_id, days: _range, relative: _relative);
    final values = [
      for (final p in points) _plain ? p.value : fit.toShownFor(_id, p.value),
    ];
    final last = points.isEmpty ? null : points.last.value;
    final delta = points.length < 2 ? 0.0 : points.last.value - points.first.value;
    final lowerIsBetter = fit.isAssisted(_id);
    final up = lowerIsBetter ? delta <= 0 : delta >= 0;
    final shownDelta = _plain ? delta.round().toDouble() : fit.toShownFor(_id, delta);
    final caption = _relative ? t.ofBodyweight : fit.isRepsOnly(_id) || lowerIsBetter ? null : t.estOneRm;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Center(
        child: SegToggle([
          for (final r in _ranges)
            SegOption(_rangeLabel(r), r == _range, () {
              HapticFeedback.selectionClick();
              setState(() => _range = r);
            }),
        ]),
      ),
      if (fit.canShowRelative(_id)) ...[
        const SizedBox(height: 10),
        Center(
          child: SegToggle([
            SegOption(fit.unitsFor(_id), !_relative, () {
              HapticFeedback.selectionClick();
              setState(() => _relative = false);
            }),
            SegOption(t.pctBodyweight, _relative, () {
              HapticFeedback.selectionClick();
              setState(() => _relative = true);
            }),
          ], fontSize: 11.5, vPad: 5),
        ),
      ],
      const SizedBox(height: 16),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: const Interval(0.6, 1),
        child: KeyedSubtree(
          key: ValueKey((_range, _relative)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              if (last != null)
                RichText(
                  text: TextSpan(
                    text: _value(last),
                    style: AppTheme.d(30, weight: FontWeight.w800, color: gc.text),
                    children: [
                      TextSpan(text: ' $_unit', style: AppTheme.d(14, weight: FontWeight.w700, color: gc.textSecondary)),
                    ],
                  ),
                ),
              if (caption != null) ...[
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(caption, style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
                ),
              ],
              const Spacer(),
              if (shownDelta.abs() >= 0.1)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                        color: up ? gc.sageSoft : gc.accentSoft, borderRadius: BorderRadius.circular(100)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(delta >= 0 ? PhosphorIconsBold.trendUp : PhosphorIconsBold.trendDown,
                          size: 12, color: up ? gc.sage : gc.accent),
                      const SizedBox(width: 4),
                      Text('${delta >= 0 ? '+' : ''}${fmt((shownDelta * 10).round() / 10)}${_relative ? ' %' : ''}',
                          style: AppTheme.s(11.5, weight: FontWeight.w700, color: up ? gc.sage : gc.accent)),
                    ]),
                  ),
                ),
            ]),
            const SizedBox(height: 12),
            if (values.length >= 2)
              TrendChart(values: values, height: 120, scale: (v) => _plain ? '${v.round()}' : fmt(v))
            else
              SizedBox(
                height: 120,
                child: Center(
                  child: Text(t.noHistory,
                      textAlign: TextAlign.center,
                      style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textTertiary)),
                ),
              ),
          ]),
        ),
      ),
    ]);
  }
}
