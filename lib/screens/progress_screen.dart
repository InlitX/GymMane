import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/progress_shot.dart';
import '../models/workout.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_map.dart';
import '../widgets/charts.dart';
import '../widgets/dialogs.dart';
import '../widgets/ui_kit.dart';
import 'share_sheet.dart';
import 'start_sheet.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final change = fit.volumeChangePct;
    final split = fit.muscleSplit;
    final prs = fit.personalRecords;
    final bw = fit.bodyweightSeries;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(t.progressTitle,
                      style: AppTheme.f(27, weight: FontWeight.w800, color: gc.text)),
                ),
                Semantics(
                  button: true,
                  label: t.share,
                  child: GestureDetector(
                    onTap: () => showShareSheet(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
                      child: Icon(PhosphorIconsRegular.shareNetwork, size: 17, color: gc.text),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (fit.sessions.isEmpty) ...[
              _setupCard(context, gc),
              const SizedBox(height: 12),
            ],
            _heroRow(context, gc, change, bw),
            if (fit.sessions.isNotEmpty) ...[
              const SizedBox(height: 12),
              _consistency(context, gc),
            ],
            const SizedBox(height: 12),
            _totals(gc),
            const SizedBox(height: 12),
            const _MuscleMapCard(),
            for (final block in _blocks(context, gc, bw, split, prs)) ...[
              const SizedBox(height: 12),
              block,
            ],
            if (fit.sessions.isNotEmpty && _missing.isNotEmpty) ...[
              const SizedBox(height: 12),
              _setupCard(context, gc),
            ],
          ],
        ),
      ),
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
              child: Text(label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(10,
                      weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
            ),
            ?badge,
          ]),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(value, style: AppTheme.f(28, weight: FontWeight.w800, color: gc.text)),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 5),
                  Text(unit, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ],
            ),
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
                  : Sparkline(values: fit.volumeChartPoints, height: 40, color: gc.textSecondary),
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
                        : Sparkline(values: bw, height: 40, color: gc.textSecondary),
                    onTap: () => _logBodyweight(context),
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
                  style: AppTheme.f(10,
                      weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
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
                        margin: const EdgeInsets.only(left: 3),
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
          Heatmap(levels: fit.heatmapLevels, onTapDay: (i) => _showDay(context, i)),
          const SizedBox(height: 14),
          Row(children: [
            Icon(PhosphorIconsFill.fire, size: 14, color: gc.accent),
            const SizedBox(width: 7),
            Text(t.streakDays(fit.currentStreak),
                style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.text)),
            const Spacer(),
            Text(t.weekOfGoal(fit.sessionsThisWeek, fit.weeklyTarget),
                style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
          ]),
        ],
      ),
    );
  }

  Widget _totals(GymColors gc) {
    final hours = fit.totalTime.inHours;
    final cells = <(String, String, String)>[
      (t.allTimeSessions, '${fit.totalSessions}', ''),
      (t.allTimeSets, '${fit.totalSets}', ''),
      (
        t.allTimeTime,
        hours >= 1 ? '$hours' : '${fit.totalTime.inMinutes}',
        hours >= 1 ? t.unitHours : 'min'
      ),
    ];
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cells.length; i++) ...[
            Expanded(child: _tile(gc, label: cells[i].$1, value: cells[i].$2, unit: cells[i].$3)),
            if (i < cells.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }

  Widget _thisWeek(GymColors gc) {
    final start = fit.weekStartDate;
    final sets = List<int>.filled(7, 0);
    for (final session in fit.sessions) {
      final day = DateTime(session.date.year, session.date.month, session.date.day);
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
                style: AppTheme.f(10,
                    weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
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
                    t.weekdayInitial((t.firstWeekday - 1 + i) % 7 + 1),
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
        ],
      ),
    );
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
    List<({String id, String name, double topWeight, double oneRm})> prs,
  ) {
    return [
      if (fit.sessions.isNotEmpty) _thisWeek(gc),
      if (fit.trackedExercises.isNotEmpty) _StrengthCard(),
      if (prs.isNotEmpty) _prCard(gc, prs),
      if (fit.shotCount > 0) _timelineCard(gc),
      if (fit.measures.isNotEmpty) _measuresCard(gc),
    ];
  }

  Widget _prCard(
      GymColors gc, List<({String id, String name, double topWeight, double oneRm})> prs) {
    return SoftCard(
      radius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.personalRecords,
              style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
          const SizedBox(height: 14),
          if (prs.isEmpty)
            Text(t.prEmpty,
                style: AppTheme.s(13, color: gc.textSecondary))
          else
            for (int i = 0; i < prs.length; i++) _prRow(gc, prs[i], i < prs.length - 1),
        ],
      ),
    );
  }


  Widget _timelineCard(GymColors gc) {
    final pair = fit.comparePair;
    final last = fit.lastEntry;
    final left = fit.daysUntilPhoto;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: fit.goTimeline,
      child: SoftCard(
        radius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(t.timeline,
                      style: AppTheme.d(14,
                          weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                ),
                if (last != null && left != null)
                  Text(fit.photoDue ? t.photoDueNow : t.photoNextIn(left),
                      style: AppTheme.s(11.5,
                          weight: FontWeight.w600,
                          color: fit.photoDue ? gc.accent : gc.textTertiary)),
                const SizedBox(width: 8),
                Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
              ],
            ),
            const SizedBox(height: 14),
            if (last == null)
              Text(t.timelineHint, style: AppTheme.s(13, color: gc.textSecondary, height: 1.5))
            else
              Row(
                children: [
                  if (pair != null) ...[
                    Expanded(child: _shotThumb(gc, pair.from)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(PhosphorIconsBold.arrowRight, size: 14, color: gc.accent),
                    ),
                    Expanded(child: _shotThumb(gc, pair.to)),
                    const SizedBox(width: 14),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.daysApart(fit.compareDays),
                              style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
                          const SizedBox(height: 2),
                          Text(t.photoCount(fit.shotCount),
                              style: AppTheme.s(12, color: gc.textSecondary)),
                        ],
                      ),
                    ),
                  ] else ...[
                    Expanded(child: _shotThumb(gc, last)),
                    const SizedBox(width: 14),
                    Expanded(
                      flex: 3,
                      child: Text(t.compareNeedTwo,
                          style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.45)),
                    ),
                  ],
                ],
              ),
          ],
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
          border: Border.all(color: gc.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: path == null
            ? Icon(PhosphorIconsRegular.imageSquare, size: 16, color: gc.textTertiary)
            : Image.file(File(path), fit: BoxFit.cover, gaplessPlayback: true,
                errorBuilder: (_, _, _) =>
                    Icon(PhosphorIconsRegular.imageSquare, size: 16, color: gc.textTertiary)),
      ),
    );
  }

  Widget _measuresCard(GymColors gc) {
    final tracked = fit.trackedMeasures;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: fit.goMeasures,
      child: SoftCard(
        radius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(t.measures,
                      style: AppTheme.d(14,
                          weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
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
          Text(t.measureName(key),
              style: AppTheme.s(10.5, weight: FontWeight.w600, color: gc.textTertiary)),
          const SizedBox(height: 3),
          Text(fit.measureLabel(key, latest.value),
              style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
        ],
      ),
    );
  }

  Widget _prRow(GymColors gc, ({String id, String name, double topWeight, double oneRm}) pr, bool border) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: border ? Border(bottom: BorderSide(color: gc.border)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(t.catalogName(pr.id, pr.name),
                  style: AppTheme.s(14, weight: FontWeight.w500, color: gc.text))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(fit.weightLabel(pr.topWeight), style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
              Text(t.oneRmEst(fit.weightLabel(pr.oneRm)), style: AppTheme.s(11, color: gc.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget bwRow(BuildContext context, GymColors gc, BodyweightEntry e) {
    return Row(
      children: [
        Expanded(child: Text(t.shortDateYear(e.date), style: AppTheme.s(12, color: gc.textSecondary))),
        Text(fit.weightLabel(e.kg), style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text)),
        Semantics(
          button: true,
          label: '${t.delete} ${fit.weightLabel(e.kg)}',
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => fit.deleteBodyweight(e),
            child: SizedBox(
              width: 44,
              height: 40,
              child: Icon(PhosphorIconsRegular.trash, size: 14, color: gc.textTertiary),
            ),
          ),
        ),
      ],
    );
  }

  void _showDay(BuildContext context, int index) {
    final date = fit.heatmapDate(index);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _DaySheet(date: date),
    );
  }

  void _logBodyweight(BuildContext context) {
    final start = fit.latestBodyweight?.kg ?? fit.profile.weightKg;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _LogBodyweightSheet(start: start),
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

  void _setDays(int d) => setState(() {
        _days = d;
        _focus = null;
      });

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final sets = fit.muscleSetsOver(_days);
    final heat = fit.muscleHeatOver(_days);
    final focus = _focus;
    final behind = fit.neglectedMuscles(_days);

    return SoftCard(
      radius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t.muscleMap,
                  style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
              SegToggle(
                [
                  SegOption(t.days7, _days == 7, () => _setDays(7)),
                  SegOption(t.days30, _days == 30, () => _setDays(30)),
                ],
                hPad: 11,
                vPad: 5,
                fontSize: 11,
              ),
            ],
          ),
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
        ],
      ),
    );
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
      radius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.strength1rm,
              style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
          const SizedBox(height: 14),
          if (id == null)
            Text(t.strengthEmpty,
                style: AppTheme.s(13, color: gc.textSecondary))
          else
            ..._chart(gc, id, tracked),
        ],
      ),
    );
  }

  List<Widget> _chart(
    GymColors gc,
    String id,
    List<({String id, String name, int sessions})> tracked,
  ) {
    final series = fit.oneRmSeries(id);
    final first = series.first, last = series.last;
    final delta = last - first;
    final up = delta >= 0;

    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
              text: fit.weightValue(last),
              style: AppTheme.d(32, weight: FontWeight.w700, color: gc.text),
              children: [
                TextSpan(
                    text: ' ${fit.units}',
                    style: AppTheme.d(15, weight: FontWeight.w700, color: gc.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (delta.abs() >= 0.1)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: up ? gc.sageSoft : gc.accentSoft, borderRadius: BorderRadius.circular(8)),
                child: Text('${up ? '+' : ''}${fit.weightLabel(delta)}',
                    style: AppTheme.s(11, weight: FontWeight.w600, color: up ? gc.sage : gc.accent)),
              ),
            ),
        ],
      ),
      const SizedBox(height: 12),
      Sparkline(values: series, height: 56, color: gc.textSecondary),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          for (final e in tracked.take(8)) ...[
            Pill(
              label: t.catalogName(e.id, e.name),
              bg: e.id == id ? gc.ember : gc.bgRaised2,
              fg: e.id == id ? gc.onEmber : gc.textSecondary,
              onTap: () => fit.setStrengthExercise(e.id),
              hPad: 12,
              vPad: 7,
              fontSize: 12,
            ),
            const SizedBox(width: 8),
          ],
        ]),
      ),
    ];
  }
}

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
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${t.setCount(s.setCount)} · ${fit.volumeLabel(s.volume)}',
              style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1),
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
    final detail = e.sets.map((x) => '${fit.weightValue(x.weight)}×${x.reps}').join(' · ');
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
      radius: 14,
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

  void _bump(double d) => setState(() => _shown = ((_shown + d) * 10).round() / 10);

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom + MediaQuery.paddingOf(context).bottom),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHandle(),
          const SizedBox(height: 18),
          Text(t.logBodyweight,
              style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 2)),
          const SizedBox(height: 4),
          Text(t.trackWeight, style: AppTheme.s(13, color: gc.textSecondary)),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _round(gc, '–', () => _bump(-0.1)),
              const SizedBox(width: 22),
              SizedBox(
                width: 130,
                child: Text('${fmt(_shown)} ${fit.units}',
                    textAlign: TextAlign.center,
                    style: AppTheme.d(40, weight: FontWeight.w700, color: gc.text)),
              ),
              const SizedBox(width: 22),
              _round(gc, '+', () => _bump(0.1)),
            ],
          ),
          const SizedBox(height: 22),
          PrimaryButton(
            label: t.save,
            onTap: () {
              fit.addBodyweight(fit.fromDisplayWeight(_shown));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _round(GymColors gc, String glyph, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(glyph, style: TextStyle(color: gc.text, fontSize: 26, height: 1)),
      ),
    );
  }
}

void showEditLoggedSheet(BuildContext context, LoggedSession s, LoggedExercise e) {
  final gc = context.gc;
  showModalBottomSheet<void>(
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
          decoration: BoxDecoration(
            color: gc.bgRaised,
            border: Border.all(color: gc.border),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
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

Widget _editSetRow(GymColors gc, LoggedSession s, LoggedExercise e, int i, bool repsOnly) {
  final set = e.sets[i];
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
    child: Row(
      children: [
        SizedBox(
          width: 22,
          child: Text('${i + 1}', style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
        ),
        Expanded(
          child: Column(
            children: [
              Text(t.repsCol,
                  style: AppTheme.s(9.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1)),
              const SizedBox(height: 2),
              StepperControl(
                value: '${set.reps}',
                onDec: () => fit.bumpLoggedReps(e, i, -1),
                onInc: () => fit.bumpLoggedReps(e, i, 1),
                minWidth: 30,
                btnSize: 26,
                gap: 8,
                fontSize: 14,
              ),
            ],
          ),
        ),
        if (!repsOnly)
          Expanded(
            child: Column(
              children: [
                Text(t.weightCol(fit.units.toUpperCase()),
                    style:
                        AppTheme.s(9.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1)),
                const SizedBox(height: 2),
                StepperControl(
                  value: fit.weightValue(set.weight),
                  onDec: () => fit.bumpLoggedWeight(e, i, -1),
                  onInc: () => fit.bumpLoggedWeight(e, i, 1),
                  minWidth: 34,
                  btnSize: 26,
                  gap: 8,
                  fontSize: 14,
                ),
              ],
            ),
          ),
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
  showModalBottomSheet<void>(
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
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
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
                      margin: const EdgeInsets.only(right: 6),
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
