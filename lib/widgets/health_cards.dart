import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/health_metrics.dart';
import '../services/health_steps.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'charts.dart';
import 'entrance.dart';
import 'glass.dart';
import 'liquid_notch.dart';
import 'nutrition_art.dart' show ValueLineChart;
import 'steps_card.dart' show showStepsSheet;
import 'ui_kit.dart';

String healthName(HealthMetric m) => switch (m) {
      HealthMetric.restingHr => t.healthRestingHr,
      HealthMetric.heartRate => t.healthHeartRate,
      HealthMetric.hrv => t.healthHrv,
      HealthMetric.spo2 => t.healthSpo2,
      HealthMetric.respiration => t.healthRespiration,
      HealthMetric.bloodPressure => t.healthBloodPressure,
      HealthMetric.temperature => t.healthTemperature,
      HealthMetric.sleep => t.healthSleep,
      HealthMetric.distance => t.healthDistance,
      HealthMetric.floors => t.healthFloors,
      HealthMetric.elevation => t.healthElevation,
      HealthMetric.activeKcal => t.healthActiveKcal,
    };

String healthGroupName(HealthGroup g) => switch (g) {
      HealthGroup.heart => t.healthGroupHeart,
      HealthGroup.vitals => t.healthGroupVitals,
      HealthGroup.sleep => t.healthSleep,
      HealthGroup.activity => t.healthGroupActivity,
    };

IconData healthIcon(HealthMetric m) => switch (m) {
      HealthMetric.restingHr => PhosphorIconsRegular.heart,
      HealthMetric.heartRate => PhosphorIconsRegular.heartbeat,
      HealthMetric.hrv => PhosphorIconsRegular.waveform,
      HealthMetric.spo2 => PhosphorIconsRegular.drop,
      HealthMetric.respiration => PhosphorIconsRegular.wind,
      HealthMetric.bloodPressure => PhosphorIconsRegular.gauge,
      HealthMetric.temperature => PhosphorIconsRegular.thermometer,
      HealthMetric.sleep => PhosphorIconsRegular.moonStars,
      HealthMetric.distance => PhosphorIconsRegular.path,
      HealthMetric.floors => PhosphorIconsRegular.stairs,
      HealthMetric.elevation => PhosphorIconsRegular.mountains,
      HealthMetric.activeKcal => PhosphorIconsRegular.fire,
    };

Color healthTone(GymColors gc, HealthGroup g) => switch (g) {
      HealthGroup.heart => gc.accent,
      HealthGroup.vitals => gc.info,
      HealthGroup.sleep => gc.warn,
      HealthGroup.activity => gc.sage,
    };

double healthShown(HealthMetric m, double v) => switch (m) {
      HealthMetric.temperature => fit.isLb ? v * 9 / 5 + 32 : v,
      HealthMetric.distance => fit.toDisplayKm(v / 1000),
      HealthMetric.elevation => fit.isLb ? v * 3.28084 : v,
      HealthMetric.sleep => v / 60,
      _ => v,
    };

String healthNumber(HealthMetric m, double v) {
  final shown = healthShown(m, v);
  return switch (m) {
    HealthMetric.sleep => '${v.round() ~/ 60}:${(v.round() % 60).toString().padLeft(2, '0')}',
    HealthMetric.distance => fmt((shown * 100).round() / 100),
    HealthMetric.spo2 || HealthMetric.respiration || HealthMetric.temperature => fmt((shown * 10).round() / 10),
    _ => '${shown.round()}',
  };
}

String healthValue(HealthMetric m, List<double> v) => m == HealthMetric.bloodPressure && v.length > 1
    ? '${v[0].round()}/${v[1].round()}'
    : healthNumber(m, v.first);

String healthUnit(HealthMetric m) => switch (m) {
      HealthMetric.restingHr || HealthMetric.heartRate => t.healthBpm,
      HealthMetric.hrv => 'ms',
      HealthMetric.spo2 => '%',
      HealthMetric.respiration => t.healthBreaths,
      HealthMetric.bloodPressure => 'mmHg',
      HealthMetric.temperature => fit.isLb ? '°F' : '°C',
      HealthMetric.sleep => t.unitHours,
      HealthMetric.distance => fit.distanceUnit,
      HealthMetric.elevation => fit.isLb ? 'ft' : 'm',
      HealthMetric.activeKcal => 'kcal',
      HealthMetric.floors => '',
    };

String healthWhen(DateTime day) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final d = today.difference(DateTime(day.year, day.month, day.day)).inDays;
  return d == 0
      ? t.noteToday
      : d == 1
          ? t.noteYesterday
          : t.shortDate(day);
}

class HealthCard extends StatelessWidget {
  const HealthCard({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final top = fit.healthTop;
    return Pressable(
      onTap: () => fit.pushRoute('health'),
      scale: 0.98,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(26)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              Icon(PhosphorIconsFill.heartbeat, size: 15, color: gc.accent),
              const SizedBox(width: 7),
              Expanded(
                child: Text(t.healthTitle.toUpperCase(),
                    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
              ),
              RoundAction(
                label: t.healthPinTitle,
                size: 32,
                onTap: () => showHealthPins(context),
                child: Icon(PhosphorIconsBold.pencilSimple, size: 14, color: gc.textSecondary),
              ),
            ]),
            const SizedBox(height: 14),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < top.length; i++) ...[
                    if (i > 0)
                      Container(
                        width: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        color: gc.border.withValues(alpha: 0.7),
                      ),
                    Expanded(child: _HealthFigure(top[i])),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(height: 1, color: gc.border.withValues(alpha: 0.6)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: Text(health(t.healthFrom),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
              ),
              Text('${t.healthSeeAll} · ${fit.healthShown.length}',
                  style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(width: 4),
              Icon(PhosphorIconsBold.caretRight, size: 12, color: gc.text),
            ]),
          ],
        ),
      ),
    );
  }
}

class _HealthFigure extends StatelessWidget {
  const _HealthFigure(this.metric);

  final HealthMetric metric;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final tone = healthTone(gc, metric.group);
    final latest = fit.healthLatest(metric);
    final unit = healthUnit(metric);
    final series = [for (final v in fit.healthSeries(metric, 14)) if (v != null) healthShown(metric, v)];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(healthIcon(metric), size: 15, color: tone),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Ltr(child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              RollIn(latest == null ? '—' : healthValue(metric, latest.values),
                  style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text)),
              if (latest != null && unit.isNotEmpty) ...[
                const SizedBox(width: 3),
                Text(unit, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary)),
              ],
            ],
          )),
        ),
        const SizedBox(height: 2),
        Text(healthName(metric),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary, height: 1.2)),
        const Spacer(),
        const SizedBox(height: 10),
        series.length < 2 ? const SizedBox(height: 22) : Sparkline(values: series, height: 22, color: tone),
      ],
    );
  }
}

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final shown = fit.healthMetrics;
    return RiseScope(
      id: 'health',
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: riseAll([
              Row(children: [
                RoundAction(
                  label: t.back,
                  onTap: fit.popRoute,
                  child: Icon(PhosphorIconsBold.caretLeft, size: 16, color: gc.text),
                ),
                const Spacer(),
                RoundAction(
                  label: t.healthPickTitle,
                  onTap: () => showHealthPicker(context),
                  child: Icon(PhosphorIconsBold.slidersHorizontal, size: 16, color: gc.text),
                ),
              ]),
              const SizedBox(height: 18),
              Text(t.healthTitle,
                  style: AppTheme.f(32, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.9, height: 1.05)),
              const SizedBox(height: 4),
              Text(health(t.healthFrom), style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
              for (final g in HealthGroup.values)
                if (shown.any((m) => m.group == g) || (g == HealthGroup.activity && fit.stepsOn))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 24, 0, 10),
                        child: Text(healthGroupName(g).toUpperCase(),
                            style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                      ),
                      ..._rows([
                        if (g == HealthGroup.activity && fit.stepsOn) const _StepsTile(),
                        for (final m in shown) if (m.group == g) HealthTile(m),
                      ]),
                    ],
                  ),
            ]),
          ),
        ),
      ),
    );
  }

  List<Widget> _rows(List<Widget> tiles) => [
        for (var i = 0; i < tiles.length; i += 2) ...[
          if (i > 0) const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: tiles[i]),
                if (i + 1 < tiles.length) ...[
                  const SizedBox(width: 12),
                  Expanded(child: tiles[i + 1]),
                ],
              ],
            ),
          ),
        ],
      ];
}

void showHealthPins(BuildContext context) {
  final gc = context.gc;
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => ListenableBuilder(
      listenable: fit,
      builder: (sheet, _) {
        final top = fit.healthTop;
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.85),
          child: Container(
            padding: sheetPad(sheet),
            decoration: sheetDecoration(gc),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SheetHandle(),
                const SizedBox(height: 20),
                Text(t.healthPinTitle, textAlign: TextAlign.center, style: AppTheme.f(19, color: gc.text)),
                const SizedBox(height: 6),
                Text(t.healthPinHint,
                    textAlign: TextAlign.center,
                    style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                const SizedBox(height: 16),
                Flexible(
                  child: FloatingActions(
                    actions: PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
                    child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 84),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
                      child: Column(children: [
                        for (final (i, m) in fit.healthMetrics.indexed) ...[
                          if (i > 0) Divider(height: 1, thickness: 1, color: gc.border),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => fit.toggleHealthPin(m),
                            child: SizedBox(
                              height: 52,
                              child: Row(children: [
                                Icon(healthIcon(m), size: 17, color: healthTone(gc, m.group)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(healthName(m),
                                      style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                                ),
                                AnimatedScale(
                                  scale: top.contains(m) ? 1 : 0.7,
                                  duration: const Duration(milliseconds: 240),
                                  curve: Curves.easeOutBack,
                                  child: Icon(
                                    top.contains(m) ? PhosphorIconsFill.checkCircle : PhosphorIconsRegular.circle,
                                    size: 22,
                                    color: top.contains(m) ? gc.accent : gc.textTertiary,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ]),
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

class HealthTile extends StatelessWidget {
  const HealthTile(this.metric, {super.key});

  final HealthMetric metric;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final tone = healthTone(gc, metric.group);
    final latest = fit.healthLatest(metric);
    final granted = fit.healthGranted.contains(metric);
    final series = [for (final v in fit.healthSeries(metric, 14)) if (v != null) healthShown(metric, v)];
    final unit = healthUnit(metric);
    return Pressable(
      onTap: granted ? () => showHealthDetail(context, metric) : () => _allow(metric),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(healthIcon(metric), size: 13, color: tone),
              const SizedBox(width: 6),
              Expanded(
                child: FitText(healthName(metric).toUpperCase(),
                    style: AppTheme.f(9.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.8)),
              ),
            ]),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Ltr(child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  RollIn(latest == null ? '—' : healthValue(metric, latest.values),
                      style: AppTheme.f(25, weight: FontWeight.w800, color: gc.text)),
                  if (latest != null && unit.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Text(unit, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                  ],
                ],
              )),
            ),
            const SizedBox(height: 3),
            Text(
              !granted
                  ? t.healthAllow
                  : latest == null
                      ? (fit.healthFailed.contains(metric) ? t.healthReadFailed : t.healthNoData)
                      : healthWhen(latest.day),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(11.5, weight: FontWeight.w500, color: granted ? gc.textTertiary : tone),
            ),
            const Spacer(),
            const SizedBox(height: 10),
            series.length < 2
                ? const SizedBox(height: 26)
                : Sparkline(values: series, height: 26, color: tone),
          ],
        ),
      ),
    );
  }
}

class _StepsTile extends StatelessWidget {
  const _StepsTile();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final tone = healthTone(gc, HealthGroup.activity);
    final now = DateTime.now();
    final series = [
      for (var i = 13; i >= 0; i--) fit.stepsOnDay(DateTime(now.year, now.month, now.day - i)).toDouble(),
    ];
    final today = fit.stepsToday;
    return Pressable(
      onTap: () => showStepsSheet(context),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(PhosphorIconsRegular.footprints, size: 13, color: tone),
              const SizedBox(width: 6),
              Expanded(
                child: FitText(t.homeCardSteps.toUpperCase(),
                    style: AppTheme.f(9.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.8)),
              ),
            ]),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: RollIn(MaterialLocalizations.of(context).formatDecimal(today),
                  style: AppTheme.f(25, weight: FontWeight.w800, color: gc.text)),
            ),
            const SizedBox(height: 3),
            Text(t.stepsOfGoal(MaterialLocalizations.of(context).formatDecimal(fit.stepsGoal)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
            const Spacer(),
            const SizedBox(height: 10),
            series.where((v) => v > 0).length < 2
                ? const SizedBox(height: 26)
                : Sparkline(values: series, height: 26, color: tone),
          ],
        ),
      ),
    );
  }
}

Future<void> _allow(HealthMetric m) async {
  if (!await fit.setHealthMetric(m, true)) await HealthSteps.openSettings();
}

void showHealthPicker(BuildContext context) {
  final gc = context.gc;
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => ListenableBuilder(
      listenable: fit,
      builder: (sheet, _) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.9),
        child: Container(
          padding: sheetPad(sheet),
          decoration: sheetDecoration(gc),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 20),
              Text(t.healthPickTitle, textAlign: TextAlign.center, style: AppTheme.f(19, color: gc.text)),
              const SizedBox(height: 6),
              Text(health(t.healthPickHint),
                  textAlign: TextAlign.center,
                  style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
              const SizedBox(height: 16),
              if (fit.healthShown.length < HealthMetric.values.length)
                Center(
                  child: Pressable(
                    onTap: () async {
                      if (!await fit.allowAllHealth()) await HealthSteps.openSettings();
                    },
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: gc.text, borderRadius: BorderRadius.circular(100)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(PhosphorIconsBold.checks, size: 16, color: gc.bg),
                        const SizedBox(width: 8),
                        Text(t.healthAllowAll, style: AppTheme.f(14, weight: FontWeight.w800, color: gc.bg)),
                      ]),
                    ),
                  ),
                ),
              const SizedBox(height: 6),
              Flexible(
                child: FloatingActions(
                  actions: Row(children: [
                    Expanded(
                      child: Pressable(
                        onTap: HealthSteps.openSettings,
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: gc.bgRaised2,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(PhosphorIconsRegular.shieldCheck, size: 17, color: gc.text),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(t.stepsManage,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(width: 112, child: PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop())),
                  ]),
                  child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 84),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final g in HealthGroup.values) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 10, 4, 6),
                          child: Text(healthGroupName(g).toUpperCase(),
                              style: AppTheme.f(10,
                                  weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
                          child: Column(children: [
                            if (g == HealthGroup.activity && fit.stepsAvailable) ...[
                              _stepsPickRow(gc),
                              Divider(height: 1, thickness: 1, color: gc.border),
                            ],
                            for (final (i, m) in HealthMetric.values.where((m) => m.group == g).indexed) ...[
                              if (i > 0) Divider(height: 1, thickness: 1, color: gc.border),
                              _pickRow(gc, m),
                            ],
                          ]),
                        ),
                      ],
                      const _HealthLinks(),
                    ],
                  ),
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _stepsPickRow(GymColors gc) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (!await fit.setStepsOn(!fit.stepsOn)) await HealthSteps.openSettings();
      },
      child: SizedBox(
        height: 52,
        child: Row(children: [
          Icon(PhosphorIconsRegular.footprints, size: 17, color: healthTone(gc, HealthGroup.activity)),
          const SizedBox(width: 12),
          Expanded(child: Text(t.homeCardSteps, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text))),
          TinySwitch(on: fit.stepsOn),
        ]),
      ),
    );

Widget _pickRow(GymColors gc, HealthMetric m) {
  final on = fit.healthShown.contains(m);
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () async {
      if (!await fit.setHealthMetric(m, !on)) await HealthSteps.openSettings();
    },
    child: SizedBox(
      height: 52,
      child: Row(children: [
        Icon(healthIcon(m), size: 17, color: healthTone(gc, m.group)),
        const SizedBox(width: 12),
        Expanded(child: Text(healthName(m), style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text))),
        TinySwitch(on: on),
      ]),
    ),
  );
}

void showHealthDetail(BuildContext context, HealthMetric metric) {
  final gc = context.gc;
  final tone = healthTone(gc, metric.group);
  final latest = fit.healthLatest(metric);
  final week = fit.healthLastDays(7);
  final month = [for (final v in fit.healthSeries(metric, HealthState.healthDays)) ?v];
  final unit = healthUnit(metric);
  final pressure = metric == HealthMetric.bloodPressure;
  final lows = pressure
      ? [for (final d in fit.healthLastDays(HealthState.healthDays)) if ((fit.healthOnDay(metric, d)?.length ?? 0) > 1) fit.healthOnDay(metric, d)![1]]
      : const <double>[];
  String avg(List<double> xs) => xs.isEmpty ? '—' : healthNumber(metric, xs.reduce((a, b) => a + b) / xs.length);
  String one(List<double> xs, double Function(double, double) pick) =>
      xs.isEmpty ? '—' : healthNumber(metric, xs.reduce(pick));
  String pair(String a, String b) => pressure ? '$a/$b' : a;
  final stats = [
    (t.healthAvg30, pair(avg(month), avg(lows))),
    (t.healthLow, pair(one(month, math.min), one(lows, math.min))),
    (t.healthHigh, pair(one(month, math.max), one(lows, math.max))),
  ];
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => Container(
      padding: sheetPad(sheet),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(healthIcon(metric), size: 16, color: tone),
            const SizedBox(width: 8),
            Flexible(child: Text(healthName(metric), style: AppTheme.f(19, color: gc.text))),
          ]),
          const SizedBox(height: 14),
          Ltr(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(latest == null ? '—' : healthValue(metric, latest.values),
                  style: AppTheme.f(40, weight: FontWeight.w800, color: gc.text, height: 1.05)),
              if (latest != null && unit.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(unit, style: AppTheme.f(15, weight: FontWeight.w600, color: gc.textSecondary)),
              ],
            ],
          )),
          const SizedBox(height: 4),
          Text(latest == null ? (fit.healthFailed.contains(metric) ? t.healthReadFailed : t.healthNoData) : healthWhen(latest.day),
              textAlign: TextAlign.center,
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textTertiary)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(t.healthLast7.toUpperCase(),
                style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
          ),
          SoftCard(
            radius: 22,
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 10),
            child: ValueLineChart(
              values: [
                for (final d in week)
                  if (fit.healthOnDay(metric, d)?.first case final v?) healthShown(metric, v) else null,
              ],
              labels: [for (final d in week) t.weekdayInitial(d.weekday)],
              tags: pressure
                  ? [
                      for (final d in week)
                        if (fit.healthOnDay(metric, d) case final v? when v.length > 1) healthValue(metric, v) else null,
                    ]
                  : null,
              format: (v) => switch (metric) {
                HealthMetric.sleep => healthNumber(metric, v * 60),
                HealthMetric.spo2 ||
                HealthMetric.respiration ||
                HealthMetric.temperature ||
                HealthMetric.distance =>
                  fmt((v * 10).round() / 10),
                _ => '${v.round()}',
              },
              color: tone,
              highlight: 6,
              fromZero: metric.summed,
              height: 150,
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            for (final (i, (label, value)) in stats.indexed) ...[
              if (i > 0) const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    FitText(label.toUpperCase(),
                        style: AppTheme.f(9, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.8)),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(value, style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
                    ),
                  ]),
                ),
              ),
            ],
          ]),
          const SizedBox(height: 10),
          Text(health(t.healthFrom),
              textAlign: TextAlign.center,
              style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
          const SizedBox(height: 16),
          PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
        ],
      ),
    ),
  );
}

class _HealthLinks extends StatefulWidget {
  const _HealthLinks();

  @override
  State<_HealthLinks> createState() => _HealthLinksState();
}

class _HealthLinksState extends State<_HealthLinks> {
  final _asking = <String, bool>{};

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget row(IconData icon, String title, String hint, bool saved, Future<bool> Function(bool) set) {
      final on = _asking[title] ?? saved;
      return Pressable(
          scale: 0.98,
          onTap: () async {
            if (_asking.containsKey(title)) return;
            HapticFeedback.selectionClick();
            setState(() => _asking[title] = !saved);
            final ok = await set(!saved);
            if (mounted) setState(() => _asking.remove(title));
            if (!ok && context.mounted) {
              showNotchToast(context, health(t.healthLinkDenied),
                  icon: PhosphorIconsFill.warningCircle, accent: gc.warn, action: t.healthOpenSettings,
                  onTap: () => HealthSteps.openSettings());
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(children: [
              Icon(icon, size: 18, color: on ? gc.accent : gc.textSecondary),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(hint, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                ]),
              ),
              const SizedBox(width: 10),
              TinySwitch(on: on),
            ]),
          ),
        );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(4, 10, 4, 6),
        child: Text(t.healthLinksTitle.toUpperCase(),
            style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
      ),
      Container(
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
        child: Column(children: [
          row(PhosphorIconsRegular.heartbeat, t.healthLinkHeart, t.healthLinkHeartHint, fit.hcHeart, fit.setHcHeart),
          Divider(height: 1, thickness: 1, color: gc.border, indent: 14, endIndent: 14),
          row(PhosphorIconsRegular.scales, t.healthLinkWeight, t.healthLinkWeightHint, fit.hcWeights, fit.setHcWeights),
          Divider(height: 1, thickness: 1, color: gc.border, indent: 14, endIndent: 14),
          row(PhosphorIconsRegular.barbell, t.healthLinkWrite, health(t.healthLinkWriteHint), fit.hcWrite, fit.setHcWrite),
        ]),
      ),
    ]);
  }
}
