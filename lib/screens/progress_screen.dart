import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_map.dart';
import '../widgets/charts.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

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
            ScreenTitle(t.progress),
            const SizedBox(height: 22),
            SoftCard(
              radius: 24,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.totalVolume30d,
                      style: AppTheme.d(12, weight: FontWeight.w600, color: gc.brass, letterSpacing: 3)),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: fit.volumeValue(fit.volume30dKg),
                          style: AppTheme.d(44, weight: FontWeight.w700, color: gc.text),
                          children: [
                            TextSpan(text: ' ${fit.volumeUnit}', style: AppTheme.d(20, weight: FontWeight.w700, color: gc.textSecondary)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (change != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: change >= 0 ? gc.sageSoft : gc.accentSoft,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              SvgPathIcon(Ic.trendUp, size: 12, color: change >= 0 ? gc.sage : gc.accent),
                              const SizedBox(width: 4),
                              Text(t.vsLastMonth(change),
                                  style: AppTheme.s(11, weight: FontWeight.w600, color: change >= 0 ? gc.sage : gc.accent)),
                            ]),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  VolumeChart(points: fit.volumeChartPoints),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SoftCard(
              radius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t.consistency,
                          style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                      Text(t.sessionsLogged(fit.totalSessions),
                          style: AppTheme.s(12, color: gc.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Heatmap(levels: fit.heatmapLevels, onTapDay: (i) => _showDay(context, i)),
                  const SizedBox(height: 14),
                  Row(children: [
                    SvgPathIcon(Ic.flame, size: 14, color: gc.accent),
                    const SizedBox(width: 6),
                    Text(t.streakDays(fit.currentStreak),
                        style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text)),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SoftCard(
              radius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.bodyweight,
                              style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                          const SizedBox(height: 4),
                          if (fit.latestBodyweight != null)
                            RichText(
                              text: TextSpan(
                                text: fit.weightValue(fit.latestBodyweight!.kg),
                                style: AppTheme.d(26, weight: FontWeight.w700, color: gc.text),
                                children: [
                                  TextSpan(
                                      text: ' ${fit.units}',
                                      style: AppTheme.d(14, weight: FontWeight.w700, color: gc.textSecondary)),
                                ],
                              ),
                            )
                          else
                            Text(t.notLoggedYet, style: AppTheme.s(13, color: gc.textSecondary)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _logBodyweight(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(100)),
                          child: Text(t.logShort,
                              style: AppTheme.d(13, weight: FontWeight.w600, color: gc.ember, letterSpacing: 1)),
                        ),
                      ),
                    ],
                  ),
                  if (bw.length >= 2) ...[
                    const SizedBox(height: 14),
                    Sparkline(values: bw),
                  ],
                  if (fit.bodyweight.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    for (final e in fit.bodyweightHistory.take(5)) _bwRow(context, gc, e),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 22),
            _StrengthCard(),
            const SizedBox(height: 22),
            const _MuscleMapCard(),
            const SizedBox(height: 22),
            SoftCard(
              radius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.muscleSplit,
                      style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                  const SizedBox(height: 14),
                  if (split.isEmpty)
                    Text(t.splitEmpty,
                        style: AppTheme.s(13, color: gc.textSecondary))
                  else
                    SplitBars(entries: split),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SoftCard(
              radius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.personalRecords,
                      style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                  const SizedBox(height: 14),
                  if (prs.isEmpty)
                    Text(t.prEmpty,
                        style: AppTheme.s(13, color: gc.textSecondary))
                  else
                    for (int i = 0; i < prs.length; i++) _prRow(gc, prs[i], i < prs.length - 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _prRow(GymColors gc, ({String name, double topWeight, double oneRm}) pr, bool border) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: border ? Border(bottom: BorderSide(color: gc.border)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(pr.name, style: AppTheme.s(14, weight: FontWeight.w500, color: gc.text))),
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

  Widget _bwRow(BuildContext context, GymColors gc, BodyweightEntry e) {
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
                  style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
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
              style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
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
      Sparkline(values: series, height: 56, color: up ? gc.sage : gc.accent),
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
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
            ),
          ),
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
            Text(t.tapToDelete, style: AppTheme.s(11, color: gc.textTertiary)),
            const SizedBox(height: 8),
            for (final logged in fit.sessionsOn(date))
              for (final ex in [...logged.exercises])
                _loggedRow(context, gc, logged, ex),
          ],
        ],
      ),
    );
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
            label: '${t.deleteCaps} ${t.catalogName(e.id, e.name)}',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _confirmDelete(context, s, e),
              child: SizedBox(
                width: 44,
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
    final gc = context.gc;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.deleteEntry, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.deleteEntryBody(t.catalogName(e.id, e.name)), style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(t.cancel, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text(t.delete, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
        ],
      ),
    );
    if (ok == true) fit.deleteLoggedExercise(s, e);
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
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
          ),
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
