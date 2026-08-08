import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              RoundBtn(icon: Ic.chevronLeft, onTap: fit.backFromRoutines),
              const SizedBox(width: 12),
              ScreenTitle(t.routines),
            ]),
            const SizedBox(height: 22),
            Text(t.weeklyPlan, style: AppTheme.d(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 3)),
            const SizedBox(height: 10),
            SoftCard(
              radius: 18,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Column(children: [for (int i = 0; i < 7; i++) _dayRow(context, gc, i)]),
            ),
            const SizedBox(height: 26),
            Text(t.yourRoutines, style: AppTheme.d(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 3)),
            const SizedBox(height: 10),
            if (fit.routines.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: Text(t.noRoutines,
                    textAlign: TextAlign.center, style: AppTheme.s(13, color: gc.textSecondary)),
              )
            else
              for (final r in fit.routines) _routineCard(gc, r),
            const SizedBox(height: 16),
            PrimaryButton(
              label: t.newRoutine,
              onTap: () => fit.openRoutine(fit.createRoutine()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dayRow(BuildContext context, GymColors gc, int i) {
    final weekday = i + 1;
    final r = fit.routines.where((x) => x.id == fit.weeklyPlan[weekday]);
    final assigned = r.isNotEmpty ? r.first : null;
    final isToday = DateTime.now().weekday == weekday;
    return GestureDetector(
      onTap: () => _pickRoutine(context, weekday),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 92,
              child: Text(t.weekday(i + 1),
                  style: AppTheme.s(14, weight: FontWeight.w600, color: isToday ? gc.ember : gc.text)),
            ),
            Expanded(
              child: Text(assigned == null ? t.restDayShort : fit.routineTitle(assigned),
                  textAlign: TextAlign.right,
                  style: AppTheme.s(14, color: assigned != null ? gc.text : gc.textTertiary)),
            ),
            const SizedBox(width: 8),
            SvgPathIcon(Ic.chevronRight, size: 14, color: gc.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _routineCard(GymColors gc, Routine r) {
    final n = r.exerciseIds.length;
    return GestureDetector(
      onTap: () => fit.openRoutine(r.id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(12)),
              child: Icon(PhosphorIconsRegular.listChecks, size: 22, color: gc.ember),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fit.routineTitle(r), style: AppTheme.s(15, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(t.exerciseCount(n), style: AppTheme.s(12, color: gc.textSecondary)),
                ],
              ),
            ),
            if (n > 0)
              GestureDetector(
                onTap: () => fit.startRoutine(r),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
                  child: Icon(PhosphorIconsFill.play, size: 18, color: gc.onEmber),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _pickRoutine(BuildContext context, int weekday) {
    final gc = context.gc;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: gc.bgRaised,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(t.setDay(t.weekday(weekday).toUpperCase()),
                  style: AppTheme.d(14, weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
              const SizedBox(height: 14),
              _sheetItem(context, gc, t.restDayShort, fit.weeklyPlan[weekday] == null, () {
                fit.assignRoutineToDay(weekday, null);
                Navigator.pop(context);
              }),
              for (final r in fit.routines)
                _sheetItem(context, gc, fit.routineTitle(r), fit.weeklyPlan[weekday] == r.id, () {
                  fit.assignRoutineToDay(weekday, r.id);
                  Navigator.pop(context);
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheetItem(BuildContext context, GymColors gc, String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? gc.emberSoft : gc.bgRaised2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? gc.ember : Colors.transparent),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: AppTheme.s(14, weight: FontWeight.w600, color: selected ? gc.ember : gc.text)),
            ),
            if (selected) SvgPathIcon(Ic.checkBold, size: 16, color: gc.ember),
          ],
        ),
      ),
    );
  }
}
