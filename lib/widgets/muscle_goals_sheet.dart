import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

String muscleLevelName(int sets) => switch (sets) {
      6 => t.muscleLevelKeep,
      10 => t.muscleLevelLight,
      12 => t.muscleLevelStandard,
      16 => t.muscleLevelHigh,
      20 => t.muscleLevelMax,
      _ => '',
    };

Future<void> showMuscleGoalsSheet(BuildContext context) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _MuscleGoalsSheet(),
    );

class _MuscleGoalsSheet extends StatefulWidget {
  const _MuscleGoalsSheet();

  @override
  State<_MuscleGoalsSheet> createState() => _MuscleGoalsSheetState();
}

class _MuscleGoalsSheetState extends State<_MuscleGoalsSheet> {
  bool _month = false;

  String _shown(int week) => '${_month ? (week * 30 / 7).round() : week}';

  void _step(String? id, int by) {
    HapticFeedback.selectionClick();
    if (id == null) {
      fit.setMuscleGoalAll(fit.muscleGoalAll + by);
    } else {
      fit.setMuscleGoal(id, (fit.muscleGoalWeek(id) + by).clamp(0, StatsState.muscleGoalMax));
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return ListenableBuilder(
      listenable: fit,
      builder: (context, _) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.88),
        child: Container(
          padding: sheetPad(context),
          decoration: sheetDecoration(gc),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 18),
              SheetTitle(t.muscleSetsList, subtitle: t.muscleGoalsHint),
              const SizedBox(height: 16),
              Center(
                child: SegToggle([
                  SegOption(t.muscleGoalsWeek, !_month, () => setState(() => _month = false)),
                  SegOption(t.muscleGoalsMonth, _month, () => setState(() => _month = true)),
                ]),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: FloatingActions(
                  actions: PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 84),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      _allCard(gc),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
                        child: Column(children: [
                          for (final (i, m) in kMuscles.indexed) ...[
                            if (i > 0) Divider(height: 1, thickness: 1, color: gc.border.withValues(alpha: 0.6)),
                            _muscleRow(gc, m.id),
                          ],
                        ]),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _allCard(GymColors gc) => Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.muscleGoalsAll,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text)),
                if (muscleLevelName(fit.muscleGoalAll).isNotEmpty)
                  Text(muscleLevelName(fit.muscleGoalAll),
                      style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
              ]),
            ),
            StepperControl(
              value: _shown(fit.muscleGoalAll),
              minWidth: 44,
              gap: 10,
              onDec: () => _step(null, -1),
              onInc: () => _step(null, 1),
            ),
          ]),
          const SizedBox(height: 12),
          Wrap(spacing: 6, runSpacing: 6, children: [
            for (final p in StatsState.muscleGoalPresets)
              Pill(
                label: '${muscleLevelName(p)} · ${_shown(p)}',
                bg: fit.muscleGoalAll == p ? gc.ember : gc.bgRaised,
                fg: fit.muscleGoalAll == p ? gc.onEmber : gc.textSecondary,
                hPad: 11,
                vPad: 6,
                fontSize: 12,
                onTap: () {
                  HapticFeedback.selectionClick();
                  fit.setMuscleGoalAll(p);
                },
              ),
          ]),
        ]),
      );

  Widget _muscleRow(GymColors gc, String id) {
    final custom = fit.muscleGoalCustom(id);
    final goal = fit.muscleGoalWeek(id);
    return SizedBox(
      height: 58,
      child: Row(children: [
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.muscle(id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
            if (goal == 0)
              Text(t.muscleGoalOff, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary))
            else if (custom)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  HapticFeedback.selectionClick();
                  fit.setMuscleGoal(id, null);
                },
                child: Text(t.muscleGoalReset,
                    style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.accent)),
              ),
          ]),
        ),
        StepperControl(
          value: _shown(goal),
          minWidth: 40,
          gap: 8,
          btnSize: 28,
          fontSize: 15,
          onDec: () => _step(id, -1),
          onInc: () => _step(id, 1),
        ),
      ]),
    );
  }
}

Future<void> showMuscleRecoverySheet(BuildContext context) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _MuscleRecoverySheet(),
    );

class _MuscleRecoverySheet extends StatelessWidget {
  const _MuscleRecoverySheet();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget label(String text) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(text, style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
        );
    void pick(VoidCallback f) {
      HapticFeedback.selectionClick();
      f();
    }

    return ListenableBuilder(
      listenable: fit,
      builder: (context, _) => Container(
        padding: sheetPad(context),
        decoration: sheetDecoration(gc),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 18),
            SheetTitle(t.recoverySpeedTitle, subtitle: t.recoverySpeedHint),
            const SizedBox(height: 22),
            label(t.recoverySpeedLabel),
            Align(alignment: AlignmentDirectional.centerStart, child: SegToggle([
              for (final (i, name) in [t.recoverySpeedFast, t.recoverySpeedNormal, t.recoverySpeedSlow].indexed)
                SegOption(name, fit.recoverySpeed == i, () => pick(() => fit.setRecoverySpeed(i))),
            ])),
            const SizedBox(height: 22),
            label(t.effortSetting),
            Align(alignment: AlignmentDirectional.centerStart, child: SegToggle([
              SegOption(t.restOff, fit.effortMode.isEmpty, () => pick(() => fit.setEffortMode(''))),
              SegOption('RPE', fit.effortMode == 'rpe', () => pick(() => fit.setEffortMode('rpe'))),
              SegOption('RIR', fit.effortMode == 'rir', () => pick(() => fit.setEffortMode('rir'))),
            ])),
            const SizedBox(height: 16),
            Text(t.recoveryHowItWorks, style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.45)),
            const SizedBox(height: 22),
            PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }
}
