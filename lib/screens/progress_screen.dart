import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../app/desktop.dart';
import '../l10n/l10n.dart';
import '../models/progress_shot.dart';
import '../models/workout.dart';
import '../services/food_library.dart' show foldText;
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_map.dart';
import '../widgets/check_in.dart';
import '../widgets/charts.dart';
import '../widgets/dialogs.dart';
import '../widgets/entrance.dart';
import '../widgets/exercise_history_sheet.dart';
import '../widgets/exercise_media.dart';
import '../widgets/file_thumb.dart';
import '../widgets/glass.dart';
import '../widgets/health_cards.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/report_sheet.dart';
import '../widgets/muscle_radar.dart';
import '../widgets/nutrition_art.dart' show ValueLineChart;
import '../widgets/rolling_text.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/set_kind.dart';
import '../widgets/ui_kit.dart';
import 'session_photos.dart';
import 'share_sheet.dart';
import 'start_sheet.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (fit.minimalMode) return const _MinimalProgressScreen();
    final gc = context.gc;
    final change = fit.volumeChangePct;
    final split = fit.muscleSplit;
    final prs = fit.personalRecords;
    final bw = fit.bodyweightSeries;
    final header = Row(
      children: [
        Expanded(
          child: Text(t.progressTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(30, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.8, height: 1.1)),
        ),
        const SizedBox(width: 12),
        _headerActions(context, gc),
      ],
    );
    final cards = <Widget>[
      if (fit.sessions.isEmpty) _setupCard(context, gc),
      _heroRow(context, gc, change, bw),
      _consistency(context, gc),
      _totals(gc),
      const _MuscleMapCard(),
      if (fit.sessions.isNotEmpty) const MuscleRadarCard(),
      ..._blocks(context, gc, bw, split, prs),
      if (fit.sessions.isNotEmpty && _missing.isNotEmpty) _setupCard(context, gc),
    ];
    if (DesktopScope.of(context)) {
      return RiseScope(
        id: 'progress',
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.fromLTRB(32, 30, 32, 48),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Rise(index: 0, child: header),
            const SizedBox(height: 24),
            CardFlow(minColumn: 360, gap: 18, children: riseAll(cards, from: 1)),
          ]),
        ),
      );
    }

    return RiseScope(
      id: 'progress',
      child: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: riseAll([
            Row(
              children: [
                Expanded(
                  child: Text(t.progressTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(30, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.8, height: 1.1)),
                ),
                const SizedBox(width: 12),
                _headerActions(context, gc),
              ],
            ),
            const SizedBox(height: 20),
            if (fit.sessions.isEmpty) ...[
              _setupCard(context, gc),
              const SizedBox(height: 12),
            ],
            _heroRow(context, gc, change, bw),
            const SizedBox(height: 12),
            _consistency(context, gc),
            const SizedBox(height: 12),
            _totals(gc),
            const SizedBox(height: 12),
            const _MuscleMapCard(),
            if (fit.sessions.isNotEmpty) ...[
              const SizedBox(height: 12),
              const MuscleRadarCard(),
            ],
            for (final block in _blocks(context, gc, bw, split, prs)) ...[
              const SizedBox(height: 12),
              block,
            ],
            if (fit.sessions.isNotEmpty && _missing.isNotEmpty) ...[
              const SizedBox(height: 12),
              _setupCard(context, gc),
            ],
          ]),
        ),
      ),
      ),
    );
  }

  Widget _headerActions(BuildContext context, GymColors gc) {
    Widget half(String label, VoidCallback onTap, List<Widget> children, EdgeInsets pad) => Semantics(
          button: true,
          label: label,
          child: Pressable(
            scale: 0.92,
            onTap: onTap,
            child: Padding(
              padding: pad,
              child: Row(mainAxisSize: MainAxisSize.min, children: children),
            ),
          ),
        );
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: gc.border.withValues(alpha: 0.6)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (fit.sessions.isNotEmpty) ...[
          half(sentenceCase(t.historyTitle), fit.goHistory, [
            Icon(PhosphorIconsBold.clockCounterClockwise, size: 16, color: gc.textSecondary),
          ], const EdgeInsets.fromLTRB(14, 0, 12, 0)),
          Container(width: 1, height: 18, color: gc.border),
          half(t.reportTitle, () => showReportSheet(context), [
            Icon(PhosphorIconsBold.fileText, size: 16, color: gc.textSecondary),
          ], const EdgeInsets.fromLTRB(12, 0, 12, 0)),
          Container(width: 1, height: 18, color: gc.border),
        ],
        half(t.share, () => showShareSheet(context), [
          Icon(PhosphorIconsBold.export, size: 15, color: gc.accent),
          const SizedBox(width: 7),
          Text(sentenceCase(t.share), style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)),
        ], EdgeInsets.fromLTRB(fit.sessions.isNotEmpty ? 12 : 14, 0, 16, 0)),
      ]),
    );
  }

  Widget _tile(
    GymColors gc, {
    required String label,
    required String value,
    String unit = '',
    String? note,
    Widget? chart,
    Widget? badge,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: FitText(label.toUpperCase(),
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
            ),
            ?badge,
          ]),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Ltr(child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                RollIn(value, style: AppTheme.f(28, weight: FontWeight.w800, color: gc.text)),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 5),
                  Text(unit, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ],
            )),
          ),
          if (note != null) ...[
            const SizedBox(height: 4),
            Text(note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
          ],
          if (chart != null) ...[
            const SizedBox(height: 12),
            chart,
          ],
        ],
      ),
      ),
    );
  }

  Widget _delta(GymColors gc, int pct) {
    final up = pct >= 0;
    final color = up ? gc.sage : gc.accent;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(up ? PhosphorIconsBold.trendUp : PhosphorIconsBold.trendDown, size: 11, color: color),
      const SizedBox(width: 3),
      Text('${pct.abs()}%', style: AppTheme.f(11, weight: FontWeight.w700, color: color)),
    ]);
  }

  Widget _heroRow(BuildContext context, GymColors gc, int? change, List<double> bw) {
    final weight = fit.latestBodyweight;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _tile(
              gc,
              label: t.tileVolume30,
              value: fit.volumeValue(fit.volume30dKg),
              unit: fit.volumeUnit,
              badge: change == null ? null : _delta(gc, change),
              chart: fit.sessions.isEmpty
                  ? const SizedBox(height: 40)
                  : Sparkline(
                      values: [for (final v in fit.volumeChartPoints) fit.toDisplayWeight(v) / 1000],
                      height: 40,
                      color: gc.textSecondary,
                      scale: fmt,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: weight == null
                ? _tile(gc,
                    label: t.weightLabel,
                    value: '—',
                    note: t.tileAddWeight,
                    onTap: () => _logBodyweight(context))
                : _tile(
                    gc,
                    label: t.weightLabel,
                    value: fit.weightValue(weight.kg),
                    unit: fit.units,
                    note: t.shortDate(weight.date),
                    chart: bw.length < 2
                        ? const SizedBox(height: 40)
                        : Sparkline(
                            values: [for (final v in bw) fit.toDisplayWeight(v)],
                            height: 40,
                            color: gc.textSecondary,
                            scale: fmt,
                          ),
                    onTap: () => showBodyweightSheet(context),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _consistency(BuildContext context, GymColors gc) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(t.consistency.toUpperCase(),
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => showHeatToneSheet(context),
                child: Semantics(
                  button: true,
                  label: t.heatToneTitle,
                  child: Row(children: [
                    for (final c in heatRamp(gc, fit.heatTone).skip(1))
                      Container(
                        width: 9,
                        height: 9,
                        margin: const EdgeInsetsDirectional.only(start: 3),
                        decoration:
                            BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)),
                      ),
                    const SizedBox(width: 7),
                    Icon(PhosphorIconsRegular.caretDown, size: 11, color: gc.textTertiary),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (fit.heatmapYear)
            HeatmapYear(
              levels: fit.heatmapShown,
              firstDay: fit.heatmapShownDate(0),
              weekdays: fit.heatmapLabels,
              onTapDay: (i) => _showDay(context, i),
            )
          else
            Heatmap(
              levels: fit.heatmapWeeks,
              firstDay: fit.heatmapWeekDate(0),
              labels: fit.heatmapLabels,
              onTapDay: (i) => _showDay(context, i),
            ),
          const SizedBox(height: 14),
          Row(children: [
            Icon(PhosphorIconsFill.fire, size: 14, color: gc.accent),
            const SizedBox(width: 7),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(t.streakDays(fit.currentStreak),
                    maxLines: 1, style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.text)),
              ),
            ),
            const SizedBox(width: 12),
            const Spacer(),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerEnd,
                child: Text(t.weekOfGoal(fit.daysDoneThisWeek, fit.weeklyTarget),
                    maxLines: 1, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _totals(GymColors gc) {
    final hours = fit.totalTime.inHours;
    final lifted = fit.liftedSpanOf(fit.totalVolumeKg);
    final cells = <(String, String, String)>[
      (t.allTimeSessions, groupedInt(fit.totalSessions), ''),
      (t.allTimeSets, groupedInt(fit.totalSets), ''),
      (
        t.allTimeTime,
        hours >= 1 ? groupedInt(hours) : '${fit.totalTime.inMinutes}',
        hours >= 1 ? t.unitHours : 'min'
      ),
      (t.allTimeLifted, lifted.$1, lifted.$2),
    ];
    Widget row(int from) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = from; i < from + 2; i++) ...[
                Expanded(child: _tile(gc, label: cells[i].$1, value: cells[i].$2, unit: cells[i].$3)),
                if (i == from) const SizedBox(width: 12),
              ],
            ],
          ),
        );
    return Column(children: [row(0), const SizedBox(height: 12), row(2)]);
  }

  Widget _thisWeek(GymColors gc) {
    final start = fit.weekStartDate;
    final sets = List<int>.filled(7, 0);
    for (final session in fit.sessions) {
      final day = DateTime(session.day.year, session.day.month, session.day.day);
      final i = day.difference(start).inDays;
      if (i >= 0 && i < 7) sets[i] += session.setCount;
    }
    final top = sets.fold(0, (m, v) => v > m ? v : m);
    final todayIndex = fit.todayIndex;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(t.thisWeekTitle.toUpperCase(),
                style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
            const Spacer(),
            Text(t.setsThisWeek(sets.fold(0, (a, b) => a + b)),
                style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
          ]),
          const SizedBox(height: 18),
          SizedBox(
            height: 92,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < 7; i++) ...[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(sets[i] > 0 ? '${sets[i]}' : '',
                            style: AppTheme.f(11,
                                weight: FontWeight.w700,
                                color: i == todayIndex ? gc.text : gc.textSecondary)),
                        const SizedBox(height: 6),
                        Container(
                          height: top == 0 ? 6 : (8 + 52 * sets[i] / top),
                          decoration: BoxDecoration(
                            color: sets[i] == 0
                                ? gc.bgRaised2
                                : (i == todayIndex ? gc.text : gc.text.withValues(alpha: 0.32)),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < 6) const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (var i = 0; i < 7; i++) ...[
                Expanded(
                  child: Text(
                    t.weekdayInitial(fit.weekdayAt(i)),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(11,
                        weight: i == todayIndex ? FontWeight.w700 : FontWeight.w500,
                        color: i == todayIndex ? gc.text : gc.textTertiary),
                  ),
                ),
                if (i < 6) const SizedBox(width: 8),
              ],
            ],
          ),
          for (final (i, note) in fit.weekInsights.indexed) ...[
            SizedBox(height: i == 0 ? 18 : 10),
            _insight(gc, note),
          ],
        ],
      ),
    );
  }

  Widget _insight(GymColors gc, ({String kind, String text, String? exerciseId}) note) {
    final id = note.exerciseId;
    final row = Row(children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.07), shape: BoxShape.circle),
        child: Icon(
          switch (note.kind) {
            'load' => PhosphorIconsRegular.gauge,
            'muscle' => PhosphorIconsRegular.clockCounterClockwise,
            'balance' => PhosphorIconsRegular.scales,
            _ => PhosphorIconsRegular.trendUp,
          },
          size: 15,
          color: note.kind == 'up' ? gc.sage : gc.textSecondary,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(note.text,
            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text, height: 1.35)),
      ),
      if (id != null) ...[
        const SizedBox(width: 8),
        Icon(PhosphorIconsBold.caretRight, size: 12, color: gc.textTertiary),
      ],
    ]);
    if (id == null) return row;
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => fit.openExercise(id), child: row);
  }

  List<({String label, bool done, String route})> _steps() => [
        (label: t.setupWorkout, done: fit.sessions.isNotEmpty, route: 'train'),
        (label: t.setupWeight, done: fit.bodyweight.isNotEmpty, route: 'weight'),
        (label: t.setupMeasures, done: fit.measures.isNotEmpty, route: 'measures'),
        (label: t.setupPhoto, done: fit.shotCount > 0, route: 'timeline'),
      ];

  List<String> get _missing =>
      [for (final s in _steps()) if (!s.done) s.label];

  void _goStep(BuildContext context, String route) {
    switch (route) {
      case 'train':
        fit.startWorkout();
      case 'weight':
        _logBodyweight(context);
      case 'measures':
        fit.goMeasures();
      case 'timeline':
        fit.goTimeline();
    }
  }

  Widget _setupCard(BuildContext context, GymColors gc) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: gc.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.setupTitle, style: AppTheme.f(15.5, color: gc.text)),
          const SizedBox(height: 4),
          Text(t.setupHint,
              style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
          const SizedBox(height: 14),
          for (final step in _steps())
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: step.done ? null : () => _goStep(context, step.route),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: Row(children: [
                  Icon(
                    step.done ? PhosphorIconsFill.checkCircle : PhosphorIconsRegular.circleDashed,
                    size: 17,
                    color: step.done ? gc.sage : gc.textTertiary,
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(step.label,
                        style: AppTheme.f(13,
                            weight: FontWeight.w500,
                            color: step.done ? gc.textTertiary : gc.text)),
                  ),
                  if (!step.done)
                    Icon(PhosphorIconsBold.caretRight, size: 13, color: gc.textTertiary),
                ]),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _blocks(
    BuildContext context,
    GymColors gc,
    List<double> bw,
    List<({String name, int pct})> split,
    List<PersonalRecord> prs,
  ) {
    return [
      if (fit.sessions.isNotEmpty) _thisWeek(gc),
      if (fit.trackedExercises.isNotEmpty) _StrengthCard(),
      if (fit.structuralBalance != null) const _BalanceCard(),
      if (fit.readinessRecent.rated > 0) _ReadinessCard(),
      if (prs.isNotEmpty) _PrCard(prs),
      if (fit.shotCount > 0) _timelineCard(gc),
      if (fit.measures.isNotEmpty) _measuresCard(gc),
      if (fit.healthShown.isNotEmpty) const HealthCard(),
    ];
  }

  Widget _timelineCard(GymColors gc) {
    final pair = fit.comparePair;
    final last = fit.lastEntry;
    final left = fit.daysUntilPhoto;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: fit.goTimeline,
      child: SoftCard(
        radius: 22,
        borderColor: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
                  child: Icon(PhosphorIconsBold.clockCounterClockwise, size: 16, color: gc.accent),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.timeline,
                          style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
                      if (last != null && left != null) ...[
                        const SizedBox(height: 3),
                        Text(fit.photoDue ? t.photoDueNow : t.photoNextIn(left),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.s(11.5,
                                weight: FontWeight.w600,
                                color: fit.photoDue ? gc.accent : gc.textTertiary)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
              ],
            ),
            const SizedBox(height: 16),
            if (last == null)
              Text(t.timelineHint, style: AppTheme.s(13, color: gc.textSecondary, height: 1.5))
            else if (pair == null)
              Row(
                children: [
                  SizedBox(width: 66, child: _shotThumb(gc, last)),
                  const SizedBox(width: 12),
                  Expanded(child: _track(gc, [last.date], last.date, last.date, null)),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 66,
                    child: AspectRatio(
                      aspectRatio: 0.78,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: gc.border, width: 1.4),
                        ),
                        child: Icon(PhosphorIconsRegular.plus, size: 16, color: gc.textTertiary),
                      ),
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  SizedBox(width: 66, child: _shotThumb(gc, pair.from)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _track(
                      gc,
                      [for (final e in fit.timelineAsc) e.date],
                      pair.from.date,
                      pair.to.date,
                      t.daysApart(fit.compareDays),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(width: 66, child: _shotThumb(gc, pair.to)),
                ],
              ),
            if (last != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 66,
                    child: Text(t.shortDate((pair?.from ?? last).date),
                        textAlign: TextAlign.center,
                        style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary)),
                  ),
                  Expanded(
                    child: pair == null
                        ? Column(mainAxisSize: MainAxisSize.min, children: [
                            Text(t.compareNeedTwo,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.s(11, weight: FontWeight.w500, color: gc.textTertiary)),
                            const SizedBox(height: 4),
                            _hideShotsBtn(gc),
                          ])
                        : _hideShotsBtn(gc),
                  ),
                  SizedBox(
                    width: 66,
                    child: pair == null
                        ? null
                        : Text(t.shortDate(pair.to.date),
                            textAlign: TextAlign.center,
                            style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _track(GymColors gc, List<DateTime> dates, DateTime from, DateTime to, String? label) {
    final span = to.difference(from).inMinutes.abs();
    final spots = [
      for (final d in dates)
        if (!d.isBefore(from) && !d.isAfter(to)) span == 0 ? 0.0 : d.difference(from).inMinutes / span,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.d(13.5, weight: FontWeight.w700, color: gc.text)),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: 14,
          child: CustomPaint(
            size: const Size(double.infinity, 14),
            painter: _TrackPainter(spots, gc.accent, gc.border, gc.bgRaised, open: label == null),
          ),
        ),
      ],
    );
  }

  Widget _hideShotsBtn(GymColors gc) {
    final hidden = fit.hideShots;
    return Semantics(
      button: true,
      toggled: hidden,
      label: hidden ? t.showPhotos : t.hidePhotos,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          fit.toggleHideShots();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(hidden ? PhosphorIconsRegular.eyeSlash : PhosphorIconsRegular.eye,
                  size: 15, color: hidden ? gc.accent : gc.textTertiary),
              const SizedBox(width: 6),
              Flexible(
                child: Text(t.photoCount(fit.shotCount),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.s(11, weight: FontWeight.w500, color: gc.textTertiary)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shotThumb(GymColors gc, ProgressEntry entry) {
    final name = entry.media.isEmpty ? null : entry.media.first;
    final path = name == null ? null : MediaStore.pathFor(name);
    return AspectRatio(
      aspectRatio: 0.78,
      child: Container(
        decoration: BoxDecoration(
          color: gc.bgRaised2,
          borderRadius: BorderRadius.circular(12),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: gc.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: path == null
            ? Icon(PhosphorIconsRegular.imageSquare, size: 16, color: gc.textTertiary)
            : TweenAnimationBuilder<double>(
                tween: Tween(end: fit.hideShots ? 1 : 0),
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                builder: (_, v, _) => Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      left: -28 * v,
                      top: -28 * v,
                      right: -28 * v,
                      bottom: -28 * v,
                      child: ImageFiltered(
                        enabled: v > 0.01,
                        imageFilter: ui.ImageFilter.blur(sigmaX: 14 * v, sigmaY: 14 * v, tileMode: TileMode.mirror),
                        child: Transform.scale(
                          scale: 1 + 0.8 * v,
                          child: FileThumb(path,
                              errorBuilder: (_, _, _) =>
                                  Icon(PhosphorIconsRegular.imageSquare, size: 16, color: gc.textTertiary)),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: v,
                      child: ColoredBox(
                        color: gc.bgRaised2.withValues(alpha: 0.35),
                        child: Icon(PhosphorIconsRegular.eyeSlash, size: 18, color: gc.text),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _measuresCard(GymColors gc) {
    final tracked = fit.trackedMeasures;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: fit.goMeasures,
      child: SoftCard(
        radius: 22,
        borderColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(t.measures.toUpperCase(),
                      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                ),
                Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
              ],
            ),
            const SizedBox(height: 12),
            if (tracked.isEmpty)
              Text(t.measuresHint, style: AppTheme.s(13, color: gc.textSecondary, height: 1.5))
            else
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final key in tracked.take(6)) _measureChip(gc, key),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _measureChip(GymColors gc, String key) {
    final latest = fit.latestMeasure(key)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: gc.bgRaised2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fit.measureTitle(key),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.s(10.5, weight: FontWeight.w600, color: gc.textTertiary)),
          const SizedBox(height: 3),
          Text(fit.measureLabel(key, latest.value),
              style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
        ],
      ),
    );
  }

  void _showDay(BuildContext context, int index) => showDaySheet(context, fit.heatmapShownDate(index));

  void _logBodyweight(BuildContext context) => showLogBodyweightSheet(context);
}

void showLogBodyweightSheet(BuildContext context) {
  final start = fit.latestBodyweight?.kg ?? fit.profile.weightKg;
  showAppSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _LogBodyweightSheet(start: start),
  );
}

void showBodyweightSheet(BuildContext context) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _BodyweightSheet(),
    );

class _BodyweightSheet extends StatefulWidget {
  const _BodyweightSheet();

  @override
  State<_BodyweightSheet> createState() => _BodyweightSheetState();
}

class _BodyweightSheetState extends State<_BodyweightSheet> {
  int _days = 90;

  Future<void> _editGoal() async {
    final goal = fit.weightGoalKg;
    final v = await askNumber(
      context,
      title: t.weightGoalTitle(fit.units),
      initial: goal > 0 ? fit.weightValue(goal) : '',
      decimal: true,
    );
    if (v == null) return;
    fit.setWeightGoal(v <= 0 ? 0 : fit.fromDisplayWeight(v));
  }

  String _signed(double kg) => '${kg > 0 ? '+' : kg < 0 ? '−' : ''}${fit.weightLabel(kg.abs())}';

  String _pct(double v) => '${v > 0 ? '+' : v < 0 ? '−' : ''}${decimalText(v.abs().toStringAsFixed(2))} %';

  Future<void> _pickAim() async {
    final gc = context.gc;
    await showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) => Container(
        padding: sheetPad(sheet),
        decoration: sheetDecoration(gc),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(t.paceAimTitle, subtitle: t.paceAimHint),
          const SizedBox(height: 14),
          OptionGroup([
            for (final (aim, label, detail) in [
              ('lose', t.paceLose, t.paceLoseRange),
              ('hold', t.paceHold, t.paceHoldRange),
              ('gain', t.paceGain, t.paceGainRange),
              ('', t.paceAuto, t.paceAutoHint),
            ])
              OptionItem(label,
                  detail: detail,
                  selected: fit.weightAim == aim,
                  onTap: () {
                    fit.setWeightAim(aim);
                    Navigator.pop(sheet);
                  }),
          ]),
        ]),
      ),
    );
  }

  Widget _paceCard(GymColors gc) {
    final pace = fit.weightPace!;
    final status = fit.weightPaceStatus;
    final aim = fit.effectiveWeightAim;
    final band = NutritionState.paceCorridors[aim];
    final (text, color) = switch (status) {
      'onPace' => (t.paceOn, gc.sage),
      'tooFast' => (t.paceTooFast, gc.warn),
      'tooSlow' => (t.paceTooSlow, gc.brass),
      'wrongWay' => (t.paceWrongWay, gc.danger),
      'drifting' => (t.paceDrifting, gc.warn),
      _ => (t.paceSetAim, gc.textSecondary),
    };
    const span = 1.5;
    double at(double v) => ((v + span) / (span * 2)).clamp(0.0, 1.0);
    return Pressable(
      scale: 0.98,
      onTap: _pickAim,
      child: SoftCard(
        radius: 22,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${_signed(pace.kgPerWeek)}/${t.weekShort}',
                style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text)),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(_pct(pace.pctPerWeek),
                  style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textSecondary)),
            ),
            const Spacer(),
            Icon(PhosphorIconsRegular.slidersHorizontal, size: 16, color: gc.textTertiary),
          ]),
          const SizedBox(height: 14),
          LayoutBuilder(builder: (context, box) {
            final w = box.maxWidth;
            return SizedBox(
              height: 16,
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 5,
                  height: 6,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(3))),
                ),
                if (band != null)
                  Positioned(
                    left: w * at(band.$1),
                    width: w * (at(band.$2) - at(band.$1)),
                    top: 5,
                    height: 6,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: gc.sage.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                Positioned(
                  left: w / 2 - 0.75,
                  top: 2,
                  width: 1.5,
                  height: 12,
                  child: ColoredBox(color: gc.textTertiary.withValues(alpha: 0.5)),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: at(pace.pctPerWeek)),
                  duration: const Duration(milliseconds: 520),
                  curve: Curves.easeOutCubic,
                  builder: (_, v, _) => Positioned(
                    left: (w * v - 8).clamp(0.0, w - 16),
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: gc.bgRaised, width: 3),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          }),
          const SizedBox(height: 12),
          Row(children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(text, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)),
            ),
            Text(
                switch (aim) {
                  'lose' => t.paceLose,
                  'gain' => t.paceGain,
                  'hold' => t.paceHold,
                  _ => '',
                },
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
          ]),
          const SizedBox(height: 4),
          Text(t.paceBasis, style: AppTheme.s(11.5, color: gc.textTertiary)),
        ]),
      ),
    );
  }

  List<(DateTime, double)> _weeks(List<BodyweightEntry> all) {
    final sums = <DateTime, (double, int)>{};
    for (final e in all) {
      final d = DateTime(e.date.year, e.date.month, e.date.day);
      final start = shiftDays(d, -((d.weekday - fit.weekStartDay + 7) % 7));
      final (sum, n) = sums[start] ?? (0.0, 0);
      sums[start] = (sum + e.kg, n + 1);
    }
    final keys = sums.keys.toList()..sort();
    return [for (final k in keys) (k, sums[k]!.$1 / sums[k]!.$2)];
  }

  Widget _kicker(GymColors gc, String text) => Padding(
        padding: const EdgeInsets.only(left: 4, top: 22, bottom: 10),
        child: Text(text.toUpperCase(),
            style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return AnimatedBuilder(
      animation: fit,
      builder: (context, _) {
        final all = [...fit.bodyweight]..sort((a, b) => a.date.compareTo(b.date));
        final trend = fit.bodyweightTrend;
        final from = _days == 0 ? null : shiftDays(DateTime.now(), -_days);
        bool inRange(BodyweightEntry e) => from == null || !e.date.isBefore(from);
        final shown = all.where(inRange).toList();
        final trendShown = trend.where(inRange).toList();
        final latest = fit.latestBodyweight;
        final kg = latest?.kg ?? 0.0;
        final goal = fit.weightGoalKg;
        final diff = goal > 0 && kg > 0 ? goal - kg : 0.0;
        final weeks = _weeks(all);
        final recentWeeks = weeks.length > 8 ? weeks.sublist(weeks.length - 8) : weeks;
        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
          decoration: sheetDecoration(gc),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.paddingOf(context).bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SheetHandle(),
                const SizedBox(height: 16),
                SheetTitle(t.bodyweightLabel, subtitle: latest == null ? null : t.shortDateYear(latest.date)),
                const SizedBox(height: 14),
                Center(
                  child: Ltr(child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      RollingText(kg > 0 ? decimalText(fit.weightValue(kg)) : '—',
                          style: AppTheme.f(46, weight: FontWeight.w800, color: gc.text, height: 1.1)),
                      const SizedBox(width: 6),
                      Text(fit.units, style: AppTheme.f(17, weight: FontWeight.w700, color: gc.textSecondary)),
                    ],
                  )),
                ),
                if (trendShown.length >= 2) ...[
                  const SizedBox(height: 4),
                  Text(
                    t.weightChangeRange(_signed(trendShown.last.kg - trendShown.first.kg)),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textSecondary),
                  ),
                ],
                const SizedBox(height: 16),
                Center(
                  child: SegToggle([
                    SegOption(t.days30, _days == 30, () => setState(() => _days = 30)),
                    SegOption(t.days90, _days == 90, () => setState(() => _days = 90)),
                    SegOption(t.days365, _days == 365, () => setState(() => _days = 365)),
                    SegOption(t.daysAll, _days == 0, () => setState(() => _days = 0)),
                  ]),
                ),
                const SizedBox(height: 16),
                if (shown.length >= 2)
                  TrendChart(
                    values: [for (final e in shown) fit.toDisplayWeight(e.kg)],
                    height: 130,
                    color: gc.info,
                    scale: fmt,
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(t.trackWeight,
                        textAlign: TextAlign.center, style: AppTheme.s(13, color: gc.textSecondary)),
                  ),
                const SizedBox(height: 16),
                ToolGroup([
                  ToolRow(
                    label: t.weightGoalLabel,
                    control: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _editGoal,
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(goal > 0 ? fit.weightLabel(goal) : '—',
                            style: AppTheme.f(14, weight: FontWeight.w800, color: gc.accent)),
                        const SizedBox(width: 6),
                        Icon(PhosphorIconsBold.pencilSimple, size: 13, color: gc.accent),
                      ]),
                    ),
                  ),
                ]),
                if (goal > 0 && kg > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    diff.abs() < 0.05
                        ? t.weightGoalReached
                        : diff < 0
                            ? t.weightToLose(fit.weightLabel(-diff))
                            : t.weightToGain(fit.weightLabel(diff)),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(12.5, weight: FontWeight.w700, color: diff.abs() < 0.05 ? gc.sage : gc.textSecondary),
                  ),
                ],
                if (fit.weightPace != null) ...[
                  _kicker(gc, t.paceTitle),
                  _paceCard(gc),
                ],
                if (recentWeeks.length >= 2) ...[
                  _kicker(gc, t.weeklyAvgTitle),
                  SoftCard(
                    radius: 22,
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 10),
                    child: ValueLineChart(
                      values: [for (final w in recentWeeks) fit.toDisplayWeight(w.$2)],
                      labels: [for (final w in recentWeeks) t.shortDate(w.$1)],
                      format: (v) => fmt((v * 10).round() / 10),
                      color: gc.info,
                      goal: goal > 0 ? fit.toDisplayWeight(goal) : null,
                      fromZero: false,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SoftCard(
                    radius: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(children: [
                      for (var i = recentWeeks.length - 1; i >= 0; i--)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(children: [
                            Expanded(
                              child: Text(t.weekOfDate(t.shortDate(recentWeeks[i].$1)),
                                  style: AppTheme.s(12.5, color: gc.textSecondary)),
                            ),
                            Text(fit.weightLabel(recentWeeks[i].$2),
                                style: AppTheme.f(13.5, weight: FontWeight.w800, color: gc.text)),
                            SizedBox(
                              width: 74,
                              child: i == 0
                                  ? const SizedBox.shrink()
                                  : Text(
                                      _signed(recentWeeks[i].$2 - recentWeeks[i - 1].$2),
                                      textAlign: TextAlign.right,
                                      style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textTertiary),
                                    ),
                            ),
                          ]),
                        ),
                    ]),
                  ),
                ],
                if (all.isNotEmpty) ...[
                  _kicker(gc, t.bodyweightHistory),
                  SoftCard(
                    radius: 22,
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(children: [
                      for (final e in all.reversed.take(30))
                        Row(children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t.shortDateYear(e.date), style: AppTheme.s(12.5, color: gc.textSecondary)),
                                if (e.note.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2, bottom: 6, right: 8),
                                    child: Text(e.note,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.3)),
                                  ),
                              ],
                            ),
                          ),
                          Text(fit.weightLabel(e.kg), style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
                          Semantics(
                            button: true,
                            label: '${t.delete} ${fit.weightLabel(e.kg)}',
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => fit.deleteBodyweight(e),
                              child: SizedBox(
                                width: 46,
                                height: 42,
                                child: Icon(PhosphorIconsRegular.trash, size: 14, color: gc.textTertiary),
                              ),
                            ),
                          ),
                        ]),
                    ]),
                  ),
                ],
                const SizedBox(height: 18),
                PrimaryButton(label: sentenceCase(t.logBodyweight), onTap: () => showLogBodyweightSheet(context)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MuscleMapCard extends StatefulWidget {
  const _MuscleMapCard();

  @override
  State<_MuscleMapCard> createState() => _MuscleMapCardState();
}

class _MuscleMapCardState extends State<_MuscleMapCard> {
  int _days = 7;
  String? _focus;
  bool _list = false;

  void _setDays(int d) => setState(() {
        _days = d;
        _focus = null;
      });

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    if (_days == 0) return _recoveryCard(gc);
    if (_days < 0) return _untrainedCard(gc);
    final week = _days == 7;
    final sets = week ? fit.muscleSetsThisWeek : fit.muscleSetsOver(_days);
    final heat = week ? fit.muscleHeatThisWeek : fit.muscleHeatOver(_days);
    final focus = _focus;
    final behind = week ? fit.neglectedThisWeek : fit.neglectedMuscles(_days);

    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(gc),
          const SizedBox(height: 16),
          BodyHeatMap(
            intensity: heat,
            focus: focus,
            onTap: (id) => setState(() => _focus = focus == id ? null : id),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Text(t.heatLow, style: AppTheme.s(11, color: gc.textTertiary)),
            const SizedBox(width: 8),
            for (int i = 0; i <= heatLevels; i++) ...[
              if (i > 0) const SizedBox(width: 3),
              Expanded(
                child: Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: heatLevelColor(gc, i),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
            const SizedBox(width: 8),
            Text(t.heatHigh, style: AppTheme.s(11, color: gc.textTertiary)),
          ]),
          const SizedBox(height: 14),
          Container(
            constraints: const BoxConstraints(minHeight: 36),
            alignment: Alignment.centerLeft,
            child: focus != null
                ? _readout(gc, focus, sets[focus] ?? 0, heat[focus] ?? 0)
                : Text(
                    sets.isEmpty
                        ? t.muscleMapEmpty
                        : behind.isEmpty
                            ? t.muscleMapHint
                            : t.muscleMapBehind(behind.map(t.muscle).join(' · ')),
                    style: AppTheme.s(13, color: gc.textSecondary),
                  ),
          ),
          if (sets.isNotEmpty) ..._muscleList(gc, sets, heat),
        ],
      ),
    );
  }

  List<Widget> _muscleList(GymColors gc, Map<String, double> sets, Map<String, double> heat) {
    final ids = sets.keys.toList()..sort((a, b) => sets[b]!.compareTo(sets[a]!));
    return [
      const SizedBox(height: 10),
      Divider(height: 1, thickness: 1, color: gc.border),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _list = !_list),
        child: SizedBox(
          height: 44,
          child: Row(children: [
            Expanded(
              child: Text(t.muscleSetsList,
                  style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text)),
            ),
            AnimatedRotation(
              turns: _list ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(PhosphorIconsBold.caretDown, size: 13, color: gc.textTertiary),
            ),
          ]),
        ),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: !_list
            ? const SizedBox(width: double.infinity)
            : Column(children: [
                for (final id in ids)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _focus = _focus == id ? null : id),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(color: heatColor(gc, heat[id] ?? 0), shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(t.muscle(id),
                              style: AppTheme.f(14,
                                  weight: _focus == id ? FontWeight.w800 : FontWeight.w600, color: gc.text)),
                        ),
                        SizedBox(
                          width: 64,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: LinearProgressIndicator(
                              value: heat[id] ?? 0,
                              minHeight: 5,
                              color: heatColor(gc, heat[id] ?? 0),
                              backgroundColor: gc.bgRaised2,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 44,
                          child: Text(fmt((sets[id]! * 2).round() / 2),
                              textAlign: TextAlign.end,
                              style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
                        ),
                      ]),
                    ),
                  ),
              ]),
      ),
    ];
  }

  Widget _header(GymColors gc) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.muscleMap,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SegToggle(
                [
                  SegOption(t.weekTab, _days == 7, () => _setDays(7)),
                  SegOption(t.days30, _days == 30, () => _setDays(30)),
                  SegOption(t.recoveryTab, _days == 0, () => _setDays(0)),
                  SegOption(t.untrainedTab, _days < 0, () => _setDays(-1)),
                ],
                hPad: 10,
                vPad: 5,
                fontSize: 11,
              ),
            ),
          ),
        ],
      );

  Widget _untrainedCard(GymColors gc) {
    final days = fit.daysSinceTrained();
    final focus = _focus;
    final empty = fit.sessions.isEmpty;
    final waiting = fit.untrainedLongest();
    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(gc),
          const SizedBox(height: 16),
          BodyUntrainedMap(
            days: days,
            focus: focus,
            onTap: (id) => setState(() => _focus = focus == id ? null : id),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Text(t.untrainedRecent, style: AppTheme.s(11, color: gc.textTertiary)),
            const SizedBox(width: 8),
            for (final (i, d) in const [1, 5, 9, 15].indexed) ...[
              if (i > 0) const SizedBox(width: 3),
              Expanded(
                child: Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: untrainedColor(gc, d),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
            const SizedBox(width: 8),
            Text(t.untrainedLong, style: AppTheme.s(11, color: gc.textTertiary)),
          ]),
          const SizedBox(height: 14),
          Container(
            constraints: const BoxConstraints(minHeight: 36),
            alignment: Alignment.centerLeft,
            child: focus != null
                ? Row(children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: untrainedColor(gc, days[focus]), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text(t.muscle(focus), style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(days[focus] == null ? t.neverTrained : t.trainedAgo(days[focus]!),
                          style: AppTheme.s(13, color: gc.textSecondary)),
                    ),
                  ])
                : Text(
                    empty
                        ? t.muscleMapEmpty
                        : waiting.isEmpty
                            ? t.untrainedAllRecent
                            : t.untrainedWaiting(waiting.map(t.muscle).join(' · ')),
                    style: AppTheme.s(13, color: gc.textSecondary),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _recoveryCard(GymColors gc) {
    final recovery = fit.muscleRecovery();
    final overall = fit.overallRecovery();
    final tired = fit.stillRecovering();
    final focus = _focus;
    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(gc),
          const SizedBox(height: 14),
          Row(children: [
            SizedBox(
              width: 46,
              height: 46,
              child: Stack(alignment: Alignment.center, children: [
                SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: overall / 100,
                    strokeWidth: 4.5,
                    strokeCap: StrokeCap.round,
                    backgroundColor: gc.bgRaised2,
                    color: recoveryColor(gc, overall / 100),
                  ),
                ),
                Text('$overall', style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text)),
              ]),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.recoveryOverall(overall),
                      style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(tired.isEmpty ? t.recoveryAllFresh : t.recoveryStill(tired.take(3).map(t.muscle).join(' · ')),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.s(12, color: gc.textSecondary)),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 16),
          BodyRecoveryMap(
            recovery: recovery,
            focus: focus,
            onTap: (id) => setState(() => _focus = focus == id ? null : id),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Text(t.recoveryTired, style: AppTheme.s(11, color: gc.textTertiary)),
            const SizedBox(width: 8),
            for (var i = 0; i <= 4; i++) ...[
              if (i > 0) const SizedBox(width: 3),
              Expanded(
                child: Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: recoveryColor(gc, i / 4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
            const SizedBox(width: 8),
            Text(t.recoveryFresh, style: AppTheme.s(11, color: gc.textTertiary)),
          ]),
          const SizedBox(height: 14),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(minHeight: 36),
              alignment: Alignment.centerLeft,
              child: focus == null
                  ? Text(t.recoveryHint, style: AppTheme.s(13, color: gc.textSecondary))
                  : _recoveryReadout(gc, focus, recovery[focus] ?? 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recoveryReadout(GymColors gc, String id, double value) {
    final toMid = value < 0.5 ? fit.hoursUntilRecovery(id, 0.5) : null;
    final toReady = value < 0.8 ? fit.hoursUntilRecovery(id, 0.8) : null;
    final (label, color) = value < 0.5
        ? (t.recoveryTired, gc.danger)
        : value < 0.8
            ? (t.recoveryStateMid, gc.warn)
            : (t.recoveryStateReady, gc.sage);
    String when(int h) => h < 48 ? '$h h' : '${(h / 24).round()} ${t.unitDays}';
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Text(t.muscle(id), style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(100)),
          child: Text(label, style: AppTheme.f(11, weight: FontWeight.w700, color: color)),
        ),
        const Spacer(),
        Text('${(value * 100).round()}%', style: AppTheme.d(20, weight: FontWeight.w800, color: gc.text)),
      ]),
      const SizedBox(height: 10),
      LayoutBuilder(builder: (context, box) {
        final w = box.maxWidth;
        Widget zone(double from, double to, Color c) => Positioned(
              left: w * from + (from > 0 ? 2 : 0),
              width: w * (to - from) - (from > 0 ? 2 : 0),
              top: 3,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(color: c.withValues(alpha: 0.28), borderRadius: BorderRadius.circular(4)),
              ),
            );
        return SizedBox(
          height: 14,
          child: Stack(clipBehavior: Clip.none, children: [
            zone(0, 0.5, gc.danger),
            zone(0.5, 0.8, gc.warn),
            zone(0.8, 1, gc.sage),
            TweenAnimationBuilder<double>(
              tween: Tween(end: value.clamp(0.0, 1.0)),
              duration: const Duration(milliseconds: 420),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => Positioned(
                left: (w * v - 7).clamp(0.0, w - 14),
                top: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: recoveryColor(gc, v),
                    shape: BoxShape.circle,
                    border: Border.all(color: gc.bgRaised, width: 2.5),
                  ),
                ),
              ),
            ),
          ]),
        );
      }),
      const SizedBox(height: 10),
      Text(
        [
          if (toMid != null) t.recoveringIn(when(toMid)),
          if (toReady != null) t.readyIn(when(toReady)),
          if (toReady == null) t.recoveryReadyNow,
        ].join(' · '),
        style: AppTheme.s(12.5, color: gc.textSecondary),
      ),
    ]);
  }

  Widget _readout(GymColors gc, String id, double sets, double heat) {
    return Row(children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: heatColor(gc, heat), shape: BoxShape.circle),
      ),
      const SizedBox(width: 8),
      Text(t.muscle(id), style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text)),
      const SizedBox(width: 8),
      Expanded(
        child: Text('${t.setCount(sets.round())} · ${t.ofTarget((heat * 100).round())}',
            style: AppTheme.s(13, color: gc.textSecondary)),
      ),
    ]);
  }
}

class _StrengthCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final tracked = fit.trackedExercises;
    final id = fit.activeStrengthId;

    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.strength1rm,
              style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
          const SizedBox(height: 14),
          if (id == null)
            Text(t.strengthEmpty, style: AppTheme.s(13, color: gc.textSecondary))
          else
            ..._chart(context, gc, id, tracked),
        ],
      ),
    );
  }

  List<Widget> _chart(
    BuildContext context,
    GymColors gc,
    String id,
    List<({String id, String name, int sessions})> tracked,
  ) {
    final history = fit.exerciseHistory(id).reversed.toList();
    final recent = history.length > 24 ? history.sublist(history.length - 24) : history;
    final series = [for (final h in recent) (h.ex.bestOneRm * 10).round() / 10];
    final first = series.first, last = series.last;
    final delta = last - first;
    final up = delta >= 0;
    final name = tracked.firstWhere((e) => e.id == id, orElse: () => tracked.first).name;
    final pickable = tracked.length > 1;

    return [
      Semantics(
        button: pickable,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: pickable ? () => _pick(context, id, tracked) : null,
          child: Row(
            children: [
              _PrThumb(id: id, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Text(t.catalogName(id, name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
              ),
              if (pickable) ...[
                const SizedBox(width: 8),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
                  child: Icon(PhosphorIconsBold.caretDown, size: 13, color: gc.textSecondary),
                ),
              ],
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
              text: fit.weightValue(last),
              style: AppTheme.d(34, weight: FontWeight.w800, color: gc.text),
              children: [
                TextSpan(
                    text: ' ${fit.units}',
                    style: AppTheme.d(15, weight: FontWeight.w700, color: gc.textSecondary)),
              ],
            ),
          ),
          const Spacer(),
          if (delta.abs() >= 0.1)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                    color: up ? gc.sageSoft : gc.accentSoft, borderRadius: BorderRadius.circular(100)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(up ? PhosphorIconsBold.trendUp : PhosphorIconsBold.trendDown,
                      size: 12, color: up ? gc.sage : gc.accent),
                  const SizedBox(width: 4),
                  Text('${up ? '+' : ''}${fit.weightLabel(delta)}',
                      style: AppTheme.s(11.5, weight: FontWeight.w700, color: up ? gc.sage : gc.accent)),
                ]),
              ),
            ),
        ],
      ),
      if (fit.relativeStrength(id) case final rel?) ...[
        const SizedBox(height: 10),
        _relative(gc, rel),
      ],
      const SizedBox(height: 12),
      TrendChart(values: [for (final v in series) fit.toDisplayWeight(v)], height: 96, scale: fmt),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(t.shortDate(recent.first.date),
              style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary)),
          const Spacer(),
          Text(t.sessionCount(series.length),
              style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary)),
          const Spacer(),
          Text(t.shortDate(recent.last.date),
              style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary)),
        ],
      ),
    ];
  }

  Widget _relative(GymColors gc, ({double ratio, int level, double toNext}) rel) {
    return Semantics(
      label: '${t.timesBodyweight(decimalText(rel.ratio.toStringAsFixed(2)))} · ${t.dotsLevelName(rel.level)}',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Expanded(
              child: Text(t.timesBodyweight(decimalText(rel.ratio.toStringAsFixed(2))),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.s(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
            ),
            const SizedBox(width: 8),
            Text(t.dotsLevelName(rel.level),
                style: AppTheme.f(12, weight: FontWeight.w700, color: gc.brass)),
          ]),
          const SizedBox(height: 7),
          Row(children: [
            for (var i = 0; i < 5; i++) ...[
              if (i > 0) const SizedBox(width: 3),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: SizedBox(
                    height: 4,
                    child: ColoredBox(
                      color: gc.bgRaised2,
                      child: FractionallySizedBox(
                        alignment: AlignmentDirectional.centerStart,
                        widthFactor: i < rel.level ? 1 : (i == rel.level ? rel.toNext : 0),
                        heightFactor: 1,
                        child: ColoredBox(color: gc.brass),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ]),
        ],
      ),
    );
  }

  void _pick(BuildContext context, String current, List<({String id, String name, int sessions})> tracked) {
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) {
        final gc = sheet.gc;
        return Container(
          padding: sheetPad(sheet),
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.8),
          decoration: sheetDecoration(gc),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 16),
              SheetTitle(sentenceCase(t.strength1rm)),
              const SizedBox(height: 14),
              Flexible(
                child: OptionGroup(
                  [
                    for (final e in tracked)
                      OptionItem(
                        t.catalogName(e.id, e.name),
                        leading: _PrThumb(id: e.id, size: 34),
                        detail: t.sessionCount(e.sessions),
                        selected: e.id == current,
                        onTap: () {
                          fit.setStrengthExercise(e.id);
                          Navigator.of(sheet).pop();
                        },
                      ),
                  ],
                  scroll: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PrThumb extends StatelessWidget {
  const _PrThumb({required this.id, this.size = 44});

  final String id;
  final double size;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final ex = fit.exerciseById(id);
    return SizedBox(
      width: size,
      height: size,
      child: ex == null
          ? Container(
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(size * 0.28)),
              child: Icon(PhosphorIconsRegular.barbell, size: size * 0.45, color: gc.textTertiary),
            )
          : ExerciseMedia(ex: ex, height: size, radius: size * 0.28, bordered: false),
    );
  }
}

class _PrCard extends StatefulWidget {
  const _PrCard(this.prs);

  final List<PersonalRecord> prs;

  @override
  State<_PrCard> createState() => _PrCardState();
}

class _PrCardState extends State<_PrCard> {
  static const _shown = 5;
  bool _all = false;
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final prs = widget.prs;
    final q = foldText(_query.trim());
    final found = !_all || q.isEmpty
        ? prs
        : [for (final pr in prs) if (foldText(t.catalogName(pr.id, pr.name)).contains(q)) pr];
    final rows = _all ? found : prs.take(_shown).toList();
    final hidden = prs.length - (_all ? prs.length : rows.length);
    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(PhosphorIconsFill.trophy, size: 14, color: gc.accent),
            const SizedBox(width: 7),
            Expanded(
              child: Text(t.personalRecords,
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
            ),
            Text('${prs.length}', style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary)),
          ]),
          const SizedBox(height: 8),
          AnimatedSize(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                if (_all && prs.length > _shown) ...[
                  const SizedBox(height: 4),
                  SearchField(
                    controller: _search,
                    hint: t.searchExercises,
                    onChanged: (v) => setState(() => _query = v),
                  ),
                  const SizedBox(height: 6),
                ],
                for (var i = 0; i < rows.length; i++)
                  _row(gc, rows[i], prs.indexOf(rows[i]), i < rows.length - 1 || prs.length > _shown),
              ],
            ),
          ),
          if (prs.length > _shown)
            Semantics(
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() {
                  _all = !_all;
                  if (!_all) {
                    _search.clear();
                    _query = '';
                  }
                }),
                child: SizedBox(
                  height: 44,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (!_all)
                      Text('+$hidden',
                          style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textSecondary)),
                    const SizedBox(width: 6),
                    AnimatedRotation(
                      turns: _all ? 0.5 : 0,
                      duration: const Duration(milliseconds: 240),
                      child: Icon(PhosphorIconsBold.caretDown, size: 13, color: gc.textSecondary),
                    ),
                  ]),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(GymColors gc, PersonalRecord pr, int rank, bool border) {
    final medal = rank < 3 ? [gc.brass, gc.textSecondary, gc.accent][rank] : null;
    return Pressable(
      onTap: () => showExerciseHistorySheet(context, pr.id),
      scale: 0.98,
      child: Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        border: border ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.6))) : null,
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _PrThumb(id: pr.id),
              if (medal != null)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: medal,
                      shape: BoxShape.circle,
                      border: Border.all(color: gc.bgRaised, width: 2),
                    ),
                    child: Text('${rank + 1}', style: AppTheme.f(9, weight: FontWeight.w800, color: gc.bgRaised)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.catalogName(pr.id, pr.name),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text, height: 1.25)),
                const SizedBox(height: 3),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(fit.recordDetail(pr),
                      maxLines: 1,
                      style: AppTheme.s(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(fit.recordLabel(pr), style: AppTheme.d(19, weight: FontWeight.w800, color: gc.text)),
        ],
      ),
      ),
    );
  }
}

void showDaySheet(BuildContext context, DateTime date) => showAppSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _DaySheet(date: date),
    );

class _DaySheet extends StatelessWidget {
  const _DaySheet({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: fit, builder: (context, _) => _body(context));
  }

  Widget _body(BuildContext context) {
    final gc = context.gc;
    final s = fit.daySummary(date);
    return Container(
      decoration: sheetDecoration(gc),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        padding: sheetPad(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHandle(),
            const SizedBox(height: 18),
            Text(t.longDate(date),
                style: AppTheme.d(20, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 14),
            if (s == null)
              Text(t.restDay, style: AppTheme.s(14, color: gc.textSecondary))
            else ...[
              Row(children: [
                Expanded(child: _stat(gc, t.exercisesCaps, '${s.exercises}')),
                const SizedBox(width: 10),
                Expanded(child: _stat(gc, t.setsCaps, '${s.sets}')),
                const SizedBox(width: 10),
                Expanded(child: _stat(gc, t.volume, fit.volumeLabel(s.volume))),
                if (s.durationSec > 0) ...[
                  const SizedBox(width: 10),
                  Expanded(child: _stat(gc, t.timeCaps, '${s.durationSec ~/ 60}m')),
                ],
              ]),
              const SizedBox(height: 16),
              Text(t.tapToEdit, style: AppTheme.s(11, color: gc.textTertiary)),
              const SizedBox(height: 10),
              for (final logged in fit.sessionsOn(date)) ...[
                _sessionHeader(context, gc, logged),
                for (final ex in [...logged.exercises]) _loggedRow(context, gc, logged, ex),
                const SizedBox(height: 6),
              ],
            ],
            if (!fit.isSessionActive && !_isFuture) ...[
              const SizedBox(height: 14),
              GhostButton(
                label: t.logWorkoutAction,
                icon: PhosphorIconsRegular.plus,
                onTap: () {
                  Navigator.of(context).pop();
                  showStartSheet(context, day: date);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool get _isFuture {
    final now = DateTime.now();
    return date.isAfter(DateTime(now.year, now.month, now.day, 23, 59));
  }

  Widget _sessionHeader(BuildContext context, GymColors gc, LoggedSession s) {
    final title = fit.sessionTitle(s);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: t.sessionName,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _renameSession(context, s),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(children: [
                Expanded(
                  child: Row(children: [
                    Flexible(
                      child: Text(
                        title ?? t.nameWorkout,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: title == null
                            ? AppTheme.f(13, weight: FontWeight.w600, color: gc.textTertiary)
                            : AppTheme.f(16, weight: FontWeight.w700, color: gc.text),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(PhosphorIconsRegular.pencilSimple, size: 13, color: gc.textTertiary),
                  ]),
                ),
                if (fit.askCheckIn || s.sleep != null || s.energy != null) ...[
                  const SizedBox(width: 8),
                  _checkInPill(context, gc, s),
                ],
              ]),
            ),
          ),
        ),
        _sessionMeta(context, gc, s),
        if (fit.momentsOf(s).isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10),
            child: SessionPhotos(s, framed: false),
          ),
      ],
    );
  }

  void _showCheckIn(BuildContext context, LoggedSession s) => showAppSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (sheetCtx) {
          final gc = sheetCtx.gc;
          return Container(
            decoration: sheetDecoration(gc),
            padding: sheetPad(sheetCtx),
            child: AnimatedBuilder(
              animation: fit,
              builder: (_, _) => Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const SheetHandle(),
                const SizedBox(height: 18),
                CheckInCard(s, flat: true),
                const SizedBox(height: 8),
              ]),
            ),
          );
        },
      );

  Widget _checkInPill(BuildContext context, GymColors gc, LoggedSession s) {
    Widget part(IconData icon, int? v, Color color) => Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 12, color: v == null ? gc.textTertiary : color),
          const SizedBox(width: 4),
          Text(v == null ? '–' : '$v', style: AppTheme.s(11, weight: FontWeight.w700, color: gc.textSecondary)),
        ]);
    return Semantics(
      button: true,
      label: t.checkInTitle,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showCheckIn(context, s),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            part(PhosphorIconsRegular.moon, s.sleep, gc.sage),
            const SizedBox(width: 8),
            part(PhosphorIconsRegular.lightning, s.energy, gc.brass),
          ]),
        ),
      ),
    );
  }

  Future<void> _renameSession(BuildContext context, LoggedSession s) async {
    final current = fit.sessionTitle(s) ?? '';
    final name = await askText(context, title: t.sessionName, initial: current, hint: t.sessionNameHint);
    if (name != null && name != current) fit.renameSession(s, name);
  }

  Widget _sessionMeta(BuildContext context, GymColors gc, LoggedSession s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(children: [
              Flexible(
                child: Text(
                  '${t.setCount(s.setCount)} · ${fit.volumeLabel(s.volume)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1),
                ),
              ),
              const SizedBox(width: 8),
              Semantics(
                button: true,
                label: t.editDuration,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _editDuration(context, s),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: gc.bgRaised2,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(PhosphorIconsRegular.timer, size: 12, color: gc.textSecondary),
                      const SizedBox(width: 5),
                      Text(s.durationSec > 0 ? '${(s.durationSec / 60).round()} min' : '– min',
                          style: AppTheme.s(11, weight: FontWeight.w700, color: gc.textSecondary)),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
          Semantics(
            button: true,
            label: t.copyWorkout,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Clipboard.setData(ClipboardData(text: fit.workoutText(s)));
                showNotchToast(context, t.copiedDone, icon: PhosphorIconsRegular.copy, accent: gc.accent);
              },
              child: SizedBox(
                width: 40,
                height: 36,
                child: Icon(PhosphorIconsRegular.copy, size: 16, color: gc.textTertiary),
              ),
            ),
          ),
          Semantics(
            button: true,
            label: t.deleteWorkout,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _confirmDeleteWorkout(context, s),
              child: SizedBox(
                width: 40,
                height: 36,
                child: Icon(PhosphorIconsRegular.trash, size: 16, color: gc.textTertiary),
              ),
            ),
          ),
          if (!fit.isSessionActive)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _confirmResume(context, s),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: gc.emberSoft,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(PhosphorIconsFill.play, size: 11, color: gc.ember),
                  const SizedBox(width: 6),
                  Text(t.continueWorkout,
                      style: AppTheme.d(11, weight: FontWeight.w700, color: gc.ember, letterSpacing: 1)),
                ]),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _editDuration(BuildContext context, LoggedSession s) async {
    final v = await askRuler(
      context,
      title: t.editDuration,
      value: s.durationSec > 0 ? (s.durationSec / 60).roundToDouble() : 60,
      min: 1,
      max: 300,
      step: 1,
      unit: 'min',
    );
    if (v != null) fit.setSessionDuration(s, v.round() * 60);
  }

  Future<void> _confirmDeleteWorkout(BuildContext context, LoggedSession s) async {
    final ok = await askConfirm(
      context,
      title: t.deleteWorkout,
      body: t.deleteWorkoutBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (!ok) return;
    fit.deleteSession(s);
    if (context.mounted && fit.sessionsOn(date).isEmpty) Navigator.of(context).pop();
  }

  Future<void> _confirmResume(BuildContext context, LoggedSession s) async {
    final ok = await askConfirm(
      context,
      title: t.continueWorkout,
      body: t.continueWorkoutBody,
      confirmLabel: t.continueWorkout,
    );
    if (!ok || !context.mounted) return;
    Navigator.of(context).pop();
    fit.resumeLoggedSession(s);
  }

  Widget _loggedRow(BuildContext context, GymColors gc, LoggedSession s, LoggedExercise e) {
    final detail = fit.setsSummary(e.sets);
    final kcal = fit.cardioKcal(s, e);
    final records = fit.recordSets;
    final broke = [for (final st in e.workingSets) if (records.contains(st)) st];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(color: gc.accent, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.catalogName(e.id, e.name), style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 2),
                Text(detail, style: AppTheme.s(11, color: gc.textSecondary)),
                if (broke.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(children: [
                    RecordBadge(label: sentenceCase(t.personalRecord), size: 16),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(broke.map(fit.loggedSetLabel).join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.s(11, weight: FontWeight.w700, color: gc.brass)),
                    ),
                  ]),
                ],
                if (kcal != null) ...[
                  const SizedBox(height: 2),
                  Text('${kcal.own ? '' : '≈ '}${fit.energyOf(kcal.active)} ${fit.energyUnit} ${t.kcalActive}',
                      style: AppTheme.s(11, weight: FontWeight.w600, color: gc.warn)),
                ],
                for (var i = 0; i < e.sets.length; i++)
                  if (e.sets[i].note.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Icon(PhosphorIconsFill.notePencil, size: 11, color: gc.textTertiary),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(t.setNoteLine(i + 1, e.sets[i].note),
                            style: AppTheme.s(11, color: gc.textSecondary, height: 1.3)),
                      ),
                    ]),
                  ],
              ],
            ),
          ),
          Semantics(
            button: true,
            label: '${t.editEntry} ${t.catalogName(e.id, e.name)}',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showEditLoggedSheet(context, s, e),
              child: SizedBox(
                width: 40,
                height: 44,
                child: Icon(PhosphorIconsRegular.pencilSimple, size: 16, color: gc.textTertiary),
              ),
            ),
          ),
          if (s.exercises.length > 1)
          Semantics(
            button: true,
            label: '${t.deleteCaps} ${t.catalogName(e.id, e.name)}',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _confirmDelete(context, s, e),
              child: SizedBox(
                width: 40,
                height: 44,
                child: Icon(PhosphorIconsRegular.trash, size: 16, color: gc.textTertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, LoggedSession s, LoggedExercise e) async {
    final ok = await askConfirm(
      context,
      title: t.deleteEntry,
      body: t.deleteEntryBody(t.catalogName(e.id, e.name)),
      confirmLabel: t.delete,
    );
    if (ok) fit.deleteLoggedExercise(s, e);
  }

  Widget _stat(GymColors gc, String label, String value) {
    Widget fit1(Widget child) =>
        FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: child);
    return SoftCard(
      radius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fit1(Text(label,
              maxLines: 1,
              softWrap: false,
              style: AppTheme.s(9, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1))),
          const SizedBox(height: 4),
          fit1(Text(value,
              maxLines: 1, softWrap: false, style: AppTheme.d(17, weight: FontWeight.w700, color: gc.text))),
        ],
      ),
    );
  }
}

class _LogBodyweightSheet extends StatefulWidget {
  const _LogBodyweightSheet({required this.start});
  final double start;
  @override
  State<_LogBodyweightSheet> createState() => _LogBodyweightSheetState();
}

class _LogBodyweightSheetState extends State<_LogBodyweightSheet> {
  late double _shown = ((fit.toDisplayWeight(widget.start)) * 10).round() / 10;
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom + MediaQuery.paddingOf(context).bottom),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHandle(),
          const SizedBox(height: 18),
          Text(t.logBodyweight,
              style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 2)),
          const SizedBox(height: 4),
          Text(t.trackWeight, style: AppTheme.s(13, color: gc.textSecondary)),
          const SizedBox(height: 18),
          Ltr(child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              RollingText(decimalText(_shown.toStringAsFixed(1)),
                  style: AppTheme.f(52, weight: FontWeight.w800, color: gc.text, height: 1.1)),
              const SizedBox(width: 6),
              Text(fit.units, style: AppTheme.f(18, weight: FontWeight.w700, color: gc.textSecondary)),
            ],
          )),
          const SizedBox(height: 16),
          RulerPicker(
            value: _shown,
            min: fit.isLb ? 60 : 25,
            max: fit.isLb ? 660 : 300,
            step: 0.1,
            majorEvery: 10,
            label: (v) => '${v.round()}',
            onChanged: (v) => setState(() => _shown = v),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              Icon(PhosphorIconsRegular.notePencil, size: 16, color: gc.textTertiary),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _note,
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 200,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: gc.accent,
                  style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: t.bodyweightNoteHint,
                    hintStyle: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textTertiary),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: t.save,
            onTap: () {
              fit.addBodyweight(fit.fromDisplayWeight(_shown), note: _note.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}

void showEditLoggedSheet(BuildContext context, LoggedSession s, LoggedExercise e) {
  final gc = context.gc;
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetCtx) => AnimatedBuilder(
      animation: fit,
      builder: (sheetCtx, _) {
        if (!s.exercises.contains(e)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (sheetCtx.mounted) Navigator.of(sheetCtx).pop();
          });
        }
        final repsOnly = fit.isRepsOnly(e.id);
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(sheetCtx).viewInsets.bottom),
          decoration: sheetDecoration(gc),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SheetHandle(),
                  const SizedBox(height: 18),
                  Text(t.catalogName(e.id, e.name), style: AppTheme.d(20, weight: FontWeight.w700, color: gc.text)),
                  const SizedBox(height: 4),
                  Text(t.editEntryHint, style: AppTheme.s(12, color: gc.textSecondary)),
                  const SizedBox(height: 16),
                  for (int i = 0; i < e.sets.length; i++) ...[
                    _editSetRow(gc, s, e, i, repsOnly),
                    const SizedBox(height: 8),
                  ],
                  const SizedBox(height: 4),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => fit.addLoggedSet(e),
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: gc.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(t.addSet,
                          style: AppTheme.s(13,
                              weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
                    ),
                  ),
                  if (fit.loggedDistance(e) && fit.walksOrRuns(e)) ...[
                    const SizedBox(height: 12),
                    _cardioKcalCard(sheetCtx, gc, s, e),
                  ],
                  const SizedBox(height: 16),
                  PrimaryButton(label: t.done, onTap: () => Navigator.pop(sheetCtx), height: 52),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget _cardioKcalCard(BuildContext context, GymColors gc, LoggedSession s, LoggedExercise e) {
  final kcal = fit.cardioKcal(s, e);
  final incline = e.incline ?? 0;
  Widget link(String label, VoidCallback onTap) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(label, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.accent)),
        ),
      );
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(PhosphorIconsFill.fire, size: 18, color: gc.warn),
            const SizedBox(width: 8),
            if (kcal == null)
              Expanded(child: Text(t.kcalNeedsData, style: AppTheme.s(13, color: gc.textSecondary)))
            else ...[
              Text('${kcal.own ? '' : '≈ '}${fit.energyOf(kcal.active)} ${fit.energyUnit}',
                  style: AppTheme.d(20, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(width: 6),
              Expanded(
                child: Text('${t.kcalActive} · ${kcal.own ? t.kcalYours : t.kcalEstimated}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.s(12, color: gc.textSecondary)),
              ),
            ],
          ],
        ),
        if (kcal != null) ...[
          const SizedBox(height: 4),
          Text(t.kcalTotalRest('${fit.energyOf(kcal.total)} ${fit.energyUnit}'),
              style: AppTheme.s(11.5, color: gc.textTertiary)),
        ],
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: Text(t.inclineLabel, style: AppTheme.s(13, weight: FontWeight.w500, color: gc.text))),
            StepperControl(
              value: '${fmt(incline)} %',
              onDec: () => fit.setLoggedIncline(e, incline - 0.5),
              onInc: () => fit.setLoggedIncline(e, incline + 0.5),
              onEdit: () async {
                final v = await askNumber(context, title: t.inclineLabel, initial: fmt(incline), decimal: true);
                if (v != null) fit.setLoggedIncline(e, v);
              },
              minWidth: 52,
              btnSize: 26,
              gap: 8,
              fontSize: 14,
            ),
          ],
        ),
        if (kcal != null && !kcal.own) ...[
          const SizedBox(height: 6),
          Text(t.kcalHowEstimated, style: AppTheme.s(11, color: gc.textTertiary, height: 1.35)),
        ],
        Row(
          children: [
            link(t.kcalUseOwn, () async {
              final v = await askNumber(context,
                  title: t.kcalOwnTitle, initial: kcal == null ? '' : '${fit.energyOf(kcal.active)}', decimal: false);
              if (v != null) fit.setLoggedKcal(e, fit.kcalFromShown(v).round());
            }),
            if (e.kcal != null) ...[
              const SizedBox(width: 18),
              link(t.kcalBackToEstimate, () => fit.setLoggedKcal(e, null)),
            ],
          ],
        ),
      ],
    ),
  );
}

Widget _editSetRow(GymColors gc, LoggedSession s, LoggedExercise e, int i, bool repsOnly) {
  final set = e.sets[i];
  final distance = fit.loggedDistance(e);
  final timed = !distance && fit.loggedTimed(e);
  Widget cell(String label, String value, VoidCallback onDec, VoidCallback onInc,
          {double minWidth = 30, Future<void> Function(BuildContext)? edit}) =>
      Expanded(
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label,
                  maxLines: 1,
                  style: AppTheme.s(9.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1)),
            ),
            const SizedBox(height: 2),
            Builder(
              builder: (ctx) => StepperControl(
                value: value,
                onDec: onDec,
                onInc: onInc,
                onEdit: edit == null ? null : () => edit(ctx),
                minWidth: minWidth,
                btnSize: 26,
                gap: 8,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
  final time = cell(t.timeCol, durationLabel(set.sec ?? 0), () => fit.bumpLoggedSec(e, i, -1),
      () => fit.bumpLoggedSec(e, i, 1),
      minWidth: 40);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
    child: Row(
      children: [
        SizedBox(
          width: 22,
          child: Text('${i + 1}', style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
        ),
        if (distance) ...[
          cell(t.distanceCol(fit.distanceUnitFor(e.id)).replaceAll(RegExp(r'\s*\(.*\)'), ''), fit.distanceValueFor(e.id, set.km ?? 0),
              () => fit.bumpLoggedKm(e, i, -1), () => fit.bumpLoggedKm(e, i, 1),
              minWidth: 36, edit: (ctx) async {
            final v = await askNumber(ctx,
                title: t.distanceCol(fit.distanceUnitFor(e.id)).replaceAll(RegExp(r'\s*\(.*\)'), ''),
                initial: fit.distanceValueFor(e.id, set.km ?? 0),
                decimal: true);
            if (v != null) fit.setLoggedKmShown(e, i, v);
          }),
          time,
        ] else ...[
          if (timed)
            time
          else if (set.sided) ...[
            cell(t.repsLeftCol, '${set.left}', () => fit.bumpLoggedSide(e, i, true, -1),
                () => fit.bumpLoggedSide(e, i, true, 1),
                minWidth: 22, edit: (ctx) async {
              final v = await askNumber(ctx, title: t.repsLeftCol, initial: '${set.left}', decimal: false);
              if (v != null) fit.setLoggedSide(e, i, true, v.round());
            }),
            cell(t.repsRightCol, '${set.right}', () => fit.bumpLoggedSide(e, i, false, -1),
                () => fit.bumpLoggedSide(e, i, false, 1),
                minWidth: 22, edit: (ctx) async {
              final v = await askNumber(ctx, title: t.repsRightCol, initial: '${set.right}', decimal: false);
              if (v != null) fit.setLoggedSide(e, i, false, v.round());
            }),
          ] else
            cell(t.repsCol, '${set.reps}', () => fit.bumpLoggedReps(e, i, -1), () => fit.bumpLoggedReps(e, i, 1),
                edit: (ctx) async {
              final v = await askNumber(ctx, title: t.repsCol, initial: '${set.reps}', decimal: false);
              if (v != null) fit.setLoggedReps(e, i, v.round());
            }),
          if (!repsOnly && (!timed || set.weight > 0))
            cell(t.weightCol(fit.units.toUpperCase()), fmt((fit.toDisplayWeight(set.weight) * 100).round() / 100),
                () => fit.bumpLoggedWeight(e, i, -1),
                () => fit.bumpLoggedWeight(e, i, 1),
                minWidth: 34, edit: (ctx) async {
              final shown = (fit.toDisplayWeight(set.weight) * 100).round() / 100;
              final v = await askNumber(ctx,
                  title: t.weightCol(fit.units.toUpperCase()), initial: fmt(shown), decimal: true);
              if (v != null) fit.setLoggedWeightShown(e, i, v);
            }),
        ],
        Semantics(
          button: true,
          label: t.removeSet,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => fit.removeLoggedSet(s, e, i),
            child: SizedBox(
              width: 36,
              height: 40,
              child: Icon(PhosphorIconsRegular.x, size: 14, color: gc.textTertiary),
            ),
          ),
        ),
      ],
    ),
  );
}

void showHeatToneSheet(BuildContext context) {
  showAppSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const _HeatToneSheet(),
  );
}

class _HeatToneSheet extends StatefulWidget {
  const _HeatToneSheet();

  @override
  State<_HeatToneSheet> createState() => _HeatToneSheetState();
}

class _HeatToneSheetState extends State<_HeatToneSheet> {
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: sheetPad(context),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          Text(t.heatToneTitle, style: AppTheme.f(19, color: gc.text)),
          const SizedBox(height: 8),
          Text(t.heatToneHint,
              textAlign: TextAlign.center,
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
          const SizedBox(height: 20),
          for (final tone in kHeatTones)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => fit.setHeatTone(tone)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: gc.bgRaised2,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: fit.heatTone == tone ? gc.text : Colors.transparent, width: 1.4),
                ),
                child: Row(children: [
                  for (final c in heatRamp(gc, tone))
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsetsDirectional.only(end: 6),
                      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(6)),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(t.heatToneName(tone),
                        style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                  ),
                  if (fit.heatTone == tone) Icon(PhosphorIconsBold.check, size: 16, color: gc.text),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}

class _TrackPainter extends CustomPainter {
  _TrackPainter(this.spots, this.color, this.rail, this.bg, {this.open = false});
  final List<double> spots;
  final Color color;
  final Color rail;
  final Color bg;
  final bool open;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    final line = Paint()
      ..color = rail
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    if (open) {
      for (var x = 0.0; x < size.width; x += 8) {
        canvas.drawLine(Offset(x, y), Offset(math.min(x + 4, size.width), y), line);
      }
      canvas.drawCircle(Offset(5, y), 5, Paint()..color = color);
      return;
    }
    canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    const inset = 5.0;
    final w = size.width - inset * 2;
    canvas.drawLine(
      Offset(inset, y),
      Offset(inset + w, y),
      Paint()
        ..shader = LinearGradient(colors: [color.withValues(alpha: 0.25), color])
            .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
    for (final s in spots) {
      final c = Offset(inset + w * s, y);
      final edge = s <= 0.001 || s >= 0.999;
      canvas.drawCircle(c, edge ? 5 : 3.5, Paint()..color = bg);
      canvas.drawCircle(
          c,
          edge ? 5 : 3.5,
          Paint()
            ..color = edge ? color : color.withValues(alpha: 0.7)
            ..style = edge ? PaintingStyle.fill : PaintingStyle.stroke
            ..strokeWidth = 2);
    }
  }

  @override
  bool shouldRepaint(_TrackPainter o) =>
      o.spots != spots || o.color != color || o.rail != rail || o.open != open;
}

class _BalanceCard extends StatefulWidget {
  const _BalanceCard();

  @override
  State<_BalanceCard> createState() => _BalanceCardState();
}

class _ReadinessCard extends StatelessWidget {
  const _ReadinessCard();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final effect = fit.readinessEffect;
    final recent = fit.readinessRecent;
    final String headline;
    if (effect == null) {
      headline = t.readinessWaiting;
    } else if (effect.pct.abs() < 3) {
      headline = effect.sleep ? t.readinessSleepNone : t.readinessEnergyNone;
    } else if (effect.pct < 0) {
      headline = effect.sleep ? t.readinessSleepLess(-effect.pct) : t.readinessEnergyLess(-effect.pct);
    } else {
      headline = effect.sleep ? t.readinessSleepMore(effect.pct) : t.readinessEnergyMore(effect.pct);
    }
    Widget avg(IconData icon, String label, double? v, Color color) => Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
            child: Row(children: [
              Icon(icon, size: 15, color: v == null ? gc.textTertiary : color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
              ),
              Text(v == null ? '–' : checkInWord(v.round()),
                  style: AppTheme.f(12.5, weight: FontWeight.w700, color: v == null ? gc.textTertiary : gc.text)),
            ]),
          ),
        );
    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(t.readinessTitle.toUpperCase(),
            style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
        const SizedBox(height: 8),
        Text(headline, style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text, height: 1.3)),
        const SizedBox(height: 4),
        Text(effect == null ? t.readinessWaitingHint : t.readinessHint,
            style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.4)),
        const SizedBox(height: 14),
        Text(t.readinessLast30, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary)),
        const SizedBox(height: 8),
        Row(children: [
          avg(PhosphorIconsRegular.moon, t.checkInSleep, recent.sleep, gc.sage),
          const SizedBox(width: 8),
          avg(PhosphorIconsRegular.lightning, t.checkInEnergy, recent.energy, gc.brass),
        ]),
      ]),
    );
  }
}

class _BalanceCardState extends State<_BalanceCard> {
  bool _why = false;

  String _name(String id) {
    final ex = fit.exerciseById(id);
    return ex == null ? id : t.catalogName(ex.id, ex.name);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final data = fit.structuralBalance;
    if (data == null) return const SizedBox.shrink();
    final behind = data.behind;
    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(
            child: Text(t.balanceTitle.toUpperCase(),
                style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
          ),
          Semantics(
            button: true,
            label: t.balanceWhy,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _why = !_why),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(_why ? PhosphorIconsFill.info : PhosphorIconsRegular.info, size: 17, color: gc.textSecondary),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Text(
          behind == null
              ? t.balanceGood
              : t.balanceBehind(_name(behind),
                  fit.weightLabel(data.lifts.firstWhere((l) => l.id == behind).target - data.lifts.firstWhere((l) => l.id == behind).kg)),
          style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text, height: 1.3),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: _why
              ? Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(t.balanceHint, style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.4)),
                )
              : const SizedBox(width: double.infinity),
        ),
        const SizedBox(height: 14),
        for (final l in data.lifts) _row(gc, l, l.id == behind),
        const SizedBox(height: 4),
        Row(children: [
          Text(t.balanceBehindShort, style: AppTheme.s(11, color: gc.textTertiary)),
          const Spacer(),
          Text(t.balanceAheadShort, style: AppTheme.s(11, color: gc.textTertiary)),
        ]),
      ]),
    );
  }

  Widget _row(GymColors gc, ({String id, double kg, double target, double score}) l, bool behind) {
    final gap = l.target - l.kg;
    final even = l.score >= 0.95 && l.score <= 1.05;
    final color = behind ? gc.warn : (l.score < 0.95 ? Color.lerp(gc.textSecondary, gc.warn, 0.4)! : gc.sage);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(
            child: Text(_name(l.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text)),
          ),
          const SizedBox(width: 8),
          Text(
              even
                  ? t.balanceEven
                  : gap > 0
                      ? '−${fit.weightLabel(gap)}'
                      : '+${fit.weightLabel(-gap)}',
              style: AppTheme.f(12, weight: FontWeight.w700, color: even ? gc.textSecondary : color)),
        ]),
        const SizedBox(height: 6),
        LayoutBuilder(builder: (context, box) {
          final w = box.maxWidth;
          final pos = ((l.score - 0.6) / 0.8).clamp(0.0, 1.0);
          return SizedBox(
            height: 12,
            child: Stack(clipBehavior: Clip.none, children: [
              Positioned(
                left: 0,
                right: 0,
                top: 4,
                height: 4,
                child: DecoratedBox(
                    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2))),
              ),
              Positioned(
                left: w / 2 - 1,
                top: 0,
                width: 2,
                height: 12,
                child: ColoredBox(color: gc.textTertiary.withValues(alpha: 0.6)),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(end: pos),
                duration: const Duration(milliseconds: 520),
                curve: Curves.easeOutCubic,
                builder: (_, v, _) {
                  final x = w * v, mid = w / 2;
                  return Positioned(
                    left: x < mid ? x : mid,
                    width: (x - mid).abs(),
                    top: 4,
                    height: 4,
                    child: DecoratedBox(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
                  );
                },
              ),
            ]),
          );
        }),
      ]),
    );
  }
}

GymColors _minimalProgressColors(GymColors base) => base.copyWith(
      pageBg: const Color(0xFF0E0E0D),
      bg: const Color(0xFF141413),
      bgRaised: const Color(0xFF1B1B1A),
      bgRaised2: const Color(0xFF222221),
      border: const Color(0xFF2C2C2A),
      navBg: const Color(0xEE141413),
      text: const Color(0xFFE9E7E2),
      textSecondary: const Color(0xFF8D8A84),
      textTertiary: const Color(0xFF5F5D58),
      ember: const Color(0xFFC8A45F),
      emberDeep: const Color(0xFFA88647),
      onEmber: const Color(0xFF141413),
      emberSoft: const Color(0x35C8A45F),
      accent: const Color(0xFFC8A45F),
      accentSoft: const Color(0x35C8A45F),
      brass: const Color(0xFFC8A45F),
      sage: const Color(0xFFC8A45F),
      sageSoft: const Color(0x35C8A45F),
      mutedFill: const Color(0xFF222221),
      heatEmpty: const Color(0xFF222221),
    );

class _MinimalProgressScreen extends StatefulWidget {
  const _MinimalProgressScreen();

  @override
  State<_MinimalProgressScreen> createState() => _MinimalProgressScreenState();
}

class _MinimalProgressScreenState extends State<_MinimalProgressScreen> {
  int _rangeWeeks = 12;
  String? _exerciseId;

  DateTime? _lastRecordDate(PersonalRecord record) {
    var best = 0.0;
    DateTime? date;
    for (final entry in fit.exerciseHistory(record.id).reversed) {
      var current = 0.0;
      for (final set in entry.ex.workingSets) {
        final score = record.kind == PrKind.weight && fit.isAssisted(record.id)
            ? fit.liftScore(record.id, set)
            : record.kind.score(set);
        current = math.max(current, score);
      }
      if (current > best + 0.0001) {
        best = current;
        date = entry.date;
      }
    }
    return date;
  }

  String _ageLabel(DateTime? date) {
    if (date == null) return '—';
    final now = DateUtils.dateOnly(DateTime.now());
    final day = DateUtils.dateOnly(date);
    final age = now.difference(day).inDays;
    return age == 0 ? 'Today' : '${age}d ago';
  }

  Widget _sectionLabel(GymColors gc, String label, {Widget? trailing}) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Expanded(
            child: Text(
              label.toUpperCase(),
              style: AppTheme.f(10, weight: FontWeight.w800, color: gc.textTertiary, letterSpacing: 1.25),
            ),
          ),
          if (trailing != null) trailing,
        ]),
      );

  Widget _metric(GymColors gc, String label, String value, {String? note}) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(9, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.9)),
            const SizedBox(height: 3),
            Text(value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(18, weight: FontWeight.w800, color: gc.text, height: 1.05)),
            if (note != null) ...[
              const SizedBox(height: 2),
              Text(note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(10, weight: FontWeight.w500, color: gc.textTertiary)),
            ],
          ]),
        ),
      );

  Widget _flatSection(GymColors gc, String label, List<Widget> children, {Widget? trailing}) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: gc.border))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _sectionLabel(gc, label, trailing: trailing),
          ...children,
        ]),
      );

  Widget _rangeChip(GymColors gc, int weeks) {
    final selected = _rangeWeeks == weeks;
    final label = weeks == 0 ? 'All' : '${weeks}W';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _rangeWeeks = weeks),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? gc.accentSoft : Colors.transparent,
          border: Border.all(color: selected ? gc.accent : gc.border),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(label,
            style: AppTheme.f(10, weight: FontWeight.w700, color: selected ? gc.accent : gc.textSecondary)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = _minimalProgressColors(context.gc);
    final theme = Theme.of(context).copyWith(extensions: [gc]);
    final sessions = fit.sessions;
    final volumeChange = fit.volumeChangePct;
    final trackedNames = <String, String>{};
    for (final session in sessions) {
      for (final exercise in session.exercises) {
        trackedNames[exercise.id] = exercise.name;
      }
    }
    final exerciseIds = trackedNames.keys.toList()
      ..sort((a, b) => trackedNames[a]!.compareTo(trackedNames[b]!));
    if (_exerciseId == null || !exerciseIds.contains(_exerciseId)) {
      _exerciseId = fit.activeStrengthId != null && exerciseIds.contains(fit.activeStrengthId)
          ? fit.activeStrengthId
          : (exerciseIds.isEmpty ? null : exerciseIds.first);
    }
    final id = _exerciseId;
    final trend = id == null ? const <({DateTime date, double value})>[] : fit.exerciseTrend(
      id,
      days: _rangeWeeks == 0 ? 0 : _rangeWeeks * 7,
    );
    final muscleSets = fit.muscleSetsOver(30).entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maxMuscleSets = muscleSets.isEmpty ? 0.0 : muscleSets.first.value;
    final records = fit.personalRecords;
    final lifted = fit.liftedSpanOf(fit.totalVolumeKg);
    final volume = fit.volumeValue(fit.volume30dKg);
    final heatLevels = fit.heatmapWeeksFor(16);
    final heatStart = fit.heatmapWeekDate(0, weeks: 16);

    return Theme(
      data: theme,
      child: ColoredBox(
        color: gc.bg,
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 104),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Row(children: [
                Expanded(
                  child: Text(t.progressTitle,
                      style: AppTheme.f(20, weight: FontWeight.w800, color: gc.text)),
                ),
                IconButton(
                  tooltip: sentenceCase(t.historyTitle),
                  visualDensity: VisualDensity.compact,
                  onPressed: () => fit.goHistory(),
                  icon: Icon(PhosphorIconsRegular.clockCounterClockwise, size: 17, color: gc.textSecondary),
                ),
                IconButton(
                  tooltip: t.reportTitle,
                  visualDensity: VisualDensity.compact,
                  onPressed: () => showReportSheet(context),
                  icon: Icon(PhosphorIconsRegular.fileText, size: 17, color: gc.textSecondary),
                ),
                IconButton(
                  tooltip: sentenceCase(t.share),
                  visualDensity: VisualDensity.compact,
                  onPressed: () => showShareSheet(context),
                  icon: Icon(PhosphorIconsRegular.export, size: 17, color: gc.textSecondary),
                ),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                _metric(gc, t.tileVolume30, volume, note: fit.volumeUnit),
                Container(width: 1, height: 42, color: gc.border),
                _metric(gc, t.allTimeSessions, groupedInt(fit.totalSessions)),
                Container(width: 1, height: 42, color: gc.border),
                _metric(gc, t.allTimeSets, groupedInt(fit.totalSets)),
              ]),
              Row(children: [
                _metric(gc, t.allTimeTime, fit.totalTime.inHours > 0
                    ? '${fit.totalTime.inHours}h'
                    : '${fit.totalTime.inMinutes}m'),
                Container(width: 1, height: 42, color: gc.border),
                _metric(gc, t.allTimeLifted, lifted.$1, note: lifted.$2),
                Container(width: 1, height: 42, color: gc.border),
                _metric(gc, '30d change', volumeChange == null ? '—' : '${volumeChange > 0 ? '+' : ''}${volumeChange}%',
                    note: t.tileVolume30),
              ]),
              _flatSection(gc, 'Weekly volume · 30 days', [
                if (fit.volumeChartPoints.length > 1)
                  Sparkline(
                    values: [for (final v in fit.volumeChartPoints) fit.toDisplayWeight(v) / 1000],
                    height: 58,
                    color: gc.accent,
                    scale: fmt,
                  )
                else
                  Text(t.noHistory, style: AppTheme.f(11.5, color: gc.textTertiary)),
              ]),
              _flatSection(
                gc,
                t.personalRecords,
                [
                  if (records.isEmpty)
                    Text(t.noHistory, style: AppTheme.f(11.5, color: gc.textTertiary))
                  else
                    for (final record in records.take(7))
                      Builder(builder: (context) {
                        final date = _lastRecordDate(record);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(children: [
                            Expanded(
                              child: Text(t.catalogName(record.id, record.name),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.text)),
                            ),
                            const SizedBox(width: 8),
                            Text(fit.recordLabel(record),
                                style: AppTheme.f(11.5, weight: FontWeight.w800, color: gc.accent)),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 56,
                              child: Text(_ageLabel(date),
                                  textAlign: TextAlign.end,
                                  style: AppTheme.f(9.5, weight: FontWeight.w600, color: gc.textTertiary)),
                            ),
                          ]),
                        );
                      }),
                ],
              ),
              _flatSection(
                gc,
                'Estimated strength trend',
                [
                  if (exerciseIds.isEmpty)
                    Text(t.noHistory, style: AppTheme.f(11.5, color: gc.textTertiary))
                  else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(border: Border.all(color: gc.border), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: id,
                          isExpanded: true,
                          isDense: true,
                          dropdownColor: gc.bgRaised,
                          style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.text),
                          items: [
                            for (final exerciseId in exerciseIds)
                              DropdownMenuItem(
                                value: exerciseId,
                                child: Text(t.catalogName(exerciseId, trackedNames[exerciseId]!),
                                    maxLines: 1, overflow: TextOverflow.ellipsis),
                              ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => _exerciseId = value);
                            fit.setStrengthExercise(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(children: [
                      _rangeChip(gc, 4),
                      const SizedBox(width: 5),
                      _rangeChip(gc, 8),
                      const SizedBox(width: 5),
                      _rangeChip(gc, 12),
                      const SizedBox(width: 5),
                      _rangeChip(gc, 0),
                    ]),
                    const SizedBox(height: 8),
                    if (trend.length > 1)
                      TrendChart(
                        values: [for (final point in trend) point.value],
                        height: 76,
                        scale: (v) => fit.isRepsOnly(id!) ? '${v.round()}' : fit.weightLabel(v),
                      )
                    else
                      Text(t.noHistory, style: AppTheme.f(11.5, color: gc.textTertiary)),
                    if (trend.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text('${trend.length} sessions',
                          style: AppTheme.f(9.5, weight: FontWeight.w600, color: gc.textTertiary)),
                    ],
                  ],
                ],
              ),
              _flatSection(gc, t.consistency, [
                Heatmap(
                  levels: heatLevels,
                  firstDay: heatStart,
                  cellSize: 10,
                  weekdays: false,
                  onTapDay: (index) {
                    final day = heatStart.add(Duration(days: index));
                    fit.goHistory(month: day);
                  },
                ),
                const SizedBox(height: 5),
                Row(children: [
                  Icon(PhosphorIconsFill.fire, size: 12, color: gc.accent),
                  const SizedBox(width: 5),
                  Text(t.streakDays(fit.currentStreak),
                      style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textSecondary)),
                  const Spacer(),
                  Text(t.weekOfGoal(fit.daysDoneThisWeek, fit.weeklyTarget),
                      style: AppTheme.f(9.5, weight: FontWeight.w500, color: gc.textTertiary)),
                ]),
              ]),
              _flatSection(gc, 'Sets per muscle · 30 days', [
                if (muscleSets.isEmpty)
                  Text(t.noHistory, style: AppTheme.f(11.5, color: gc.textTertiary))
                else
                  for (final item in muscleSets.take(8))
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(children: [
                        SizedBox(
                          width: 78,
                          child: Text(t.muscle(item.key),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.f(10.5, weight: FontWeight.w600, color: gc.textSecondary)),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: maxMuscleSets <= 0 ? 0 : (item.value / maxMuscleSets).clamp(0.0, 1.0),
                              minHeight: 5,
                              backgroundColor: gc.bgRaised2,
                              color: gc.accent,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 25,
                          child: Text(item.value.toStringAsFixed(item.value % 1 == 0 ? 0 : 1),
                              textAlign: TextAlign.end,
                              style: AppTheme.f(10, weight: FontWeight.w700, color: gc.text)),
                        ),
                      ]),
                    ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
