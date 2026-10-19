import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/health_steps.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'entrance.dart';
import 'glass.dart';
import 'ui_kit.dart';

String stepCount(int n) => NumberFormat.decimalPattern(intlLocale).format(n);

class StepsCard extends StatelessWidget {
  const StepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final granted = fit.stepsAccess == HealthAccess.granted;
    return Pressable(
      onTap: granted ? () => showStepsSheet(context) : fit.askStepsAccess,
      child: SoftCard(
        radius: 22,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: granted ? _counts(gc) : _locked(gc),
      ),
    );
  }

  Widget _locked(GymColors gc) {
    return Row(
      children: [
        Icon(PhosphorIconsRegular.footprints, size: 19, color: gc.accent),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.stepsNoAccess, style: AppTheme.f(14.5, color: gc.text)),
              const SizedBox(height: 2),
              Text(
                t.stepsGrant,
                style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary),
              ),
            ],
          ),
        ),
        Icon(PhosphorIconsBold.caretRight, size: 14, color: gc.textTertiary),
      ],
    );
  }

  Widget _counts(GymColors gc) {
    final today = fit.stepsToday;
    final goal = fit.stepsGoal;
    final pct = (today / goal).clamp(0.0, 1.0);
    final days = fit.stepsWeekDays;
    final counts = [for (final d in days) fit.stepsOnDay(d)];
    final top = [goal, ...counts].reduce((a, b) => a > b ? a : b);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FitText(
                t.stepsToday.toUpperCase(),
                style: AppTheme.f(9.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9),
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: RollIn(
                        stepCount(today),
                        style: AppTheme.f(23, weight: FontWeight.w800, color: gc.text),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    t.stepsOfGoal(stepCount(goal)),
                    style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 5,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(child: ColoredBox(color: gc.bgRaised2)),
                      FractionallySizedBox(
                        widthFactor: pct,
                        heightFactor: 1,
                        child: ColoredBox(color: gc.ember),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var i = 0; i < days.length; i++) ...[
              if (i > 0) const SizedBox(width: 5),
              _bar(gc, days[i], counts[i], top, i == days.length - 1),
            ],
          ],
        ),
      ],
    );
  }

  Widget _bar(GymColors gc, DateTime day, int n, int top, bool today) {
    final reached = n >= fit.stepsGoal;
    final h = n <= 0 ? 3.0 : (34 * n / top).clamp(3.0, 34.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: h,
          decoration: BoxDecoration(
            color: reached ? gc.ember : (today ? gc.accent : gc.mutedFill),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          t.weekdayInitial(day.weekday),
          style: AppTheme.f(9, weight: FontWeight.w700, color: today ? gc.text : gc.textTertiary),
        ),
      ],
    );
  }
}

void showStepsSheet(BuildContext context) {
  final gc = context.gc;
  final points = [
    (PhosphorIconsRegular.footprints, t.stepsInfoRead),
    (PhosphorIconsRegular.deviceMobile, t.stepsInfoLocal),
    (PhosphorIconsRegular.toggleLeft, t.stepsInfoOff),
  ];
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => StatefulBuilder(
      builder: (sheet, setSheet) => Container(
        padding: sheetPad(sheet),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 20),
            Text(
              t.stepsGoal,
              textAlign: TextAlign.center,
              style: AppTheme.f(19, color: gc.text),
            ),
            const SizedBox(height: 6),
            Text(
              t.stepsTodayCount(stepCount(fit.stepsToday)),
              textAlign: TextAlign.center,
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary),
            ),
            const SizedBox(height: 20),
            Center(
              child: StepperControl(
                value: stepCount(fit.stepsGoal),
                minWidth: 148,
                onDec: () => setSheet(() => fit.setStepsGoal(fit.stepsGoal - 500)),
                onInc: () => setSheet(() => fit.setStepsGoal(fit.stepsGoal + 500)),
              ),
            ),
            const SizedBox(height: 22),
            for (final (icon, text) in points)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, size: 16, color: gc.accent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        text,
                        style: AppTheme.f(
                          12.5,
                          weight: FontWeight.w500,
                          color: gc.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            if (fit.stepsAvailable) ...[
              Center(
                child: GhostButton(
                  label: t.stepsManage,
                  icon: PhosphorIconsRegular.shieldCheck,
                  onTap: HealthSteps.openSettings,
                ),
              ),
              const SizedBox(height: 12),
            ],
            PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
          ],
        ),
      ),
    ),
  );
}
