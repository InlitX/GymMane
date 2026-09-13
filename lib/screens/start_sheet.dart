import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_kit.dart';

void showStartSheet(BuildContext context, {DateTime? day}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => StartSheet(day: day),
  );
}

class StartSheet extends StatelessWidget {
  const StartSheet({super.key, this.day});

  final DateTime? day;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final planned = day == null ? fit.todayRoutine : fit.routineOn(day!);
    final others = [
      for (final group in fit.routineGroups) ...fit.routinesInGroup(group),
      ...fit.routinesInGroup(''),
    ].where((r) => r.id != planned?.id && r.exerciseIds.isNotEmpty).toList();
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.82),
      padding: sheetPad(context),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          Text(day == null ? t.startTitle : t.logTitle,
              style: AppTheme.f(21, weight: FontWeight.w700, color: gc.text)),
          const SizedBox(height: 4),
          Text(t.longDate(day ?? DateTime.now()),
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
          if (day != null) ...[
            const SizedBox(height: 12),
            Text(t.logHint, style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textTertiary)),
          ],
          const SizedBox(height: 18),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (planned != null && planned.exerciseIds.isNotEmpty) ...[
                    _plannedCard(context, gc, planned),
                    const SizedBox(height: 10),
                  ],
                  if (others.isNotEmpty) ...[
                    _label(gc, t.yourRoutines),
                    for (final r in others) ...[
                      _routineRow(context, gc, r),
                      const SizedBox(height: 8),
                    ],
                    const SizedBox(height: 6),
                  ],
                  _label(gc, t.orStartFrom),
                  _option(context, gc, PhosphorIconsRegular.listPlus, t.pickExercisesOption,
                      () => fit.startPicking(on: day)),
                  const SizedBox(height: 8),
                  _option(context, gc, PhosphorIconsRegular.person, t.chooseFocusOption,
                      () => fit.startWorkout(null, day)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(GymColors gc, String text) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(text.toUpperCase(),
            style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.2)),
      );

  Widget _plannedCard(BuildContext context, GymColors gc, Routine r) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _go(context, () => fit.startRoutine(r, on: day)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: gc.emberSoft,
          border: Border.all(color: gc.ember.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day == null ? t.todaysRoutine : t.plannedRoutine,
                    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.brass, letterSpacing: 1.2)),
                const SizedBox(height: 6),
                Text(fit.routineTitle(r),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(18, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(height: 2),
                Text(t.exerciseCount(r.exerciseIds.length),
                    style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
            child: Icon(PhosphorIconsFill.play, size: 18, color: gc.onEmber),
          ),
        ]),
      ),
    );
  }

  Widget _routineRow(BuildContext context, GymColors gc, Routine r) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _go(context, () => fit.startRoutine(r, on: day)),
      child: SoftCard(
        radius: 16,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.group.isEmpty ? fit.routineTitle(r) : '${r.group} · ${fit.routineTitle(r)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 2),
                Text(t.exerciseCount(r.exerciseIds.length),
                    style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(PhosphorIconsFill.play, size: 14, color: gc.textSecondary),
        ]),
      ),
    );
  }

  Widget _option(
      BuildContext context, GymColors gc, IconData icon, String label, VoidCallback action) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _go(context, action),
      child: SoftCard(
        radius: 16,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(children: [
          Icon(icon, size: 19, color: gc.textSecondary),
          const SizedBox(width: 13),
          Expanded(child: Text(label, style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text))),
        ]),
      ),
    );
  }

  void _go(BuildContext context, VoidCallback action) {
    Navigator.of(context).pop();
    action();
  }
}
