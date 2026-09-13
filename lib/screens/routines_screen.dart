import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/program_templates.dart';
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
            ScreenHeader(title: t.routines, onBack: fit.backFromRoutines, titleSize: 22),
            const SizedBox(height: 22),
            Text(t.weeklyPlan, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1.5)),
            const SizedBox(height: 10),
            SoftCard(
              radius: 18,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Column(children: [for (int i = 0; i < 7; i++) _dayRow(context, gc, i)]),
            ),
            const SizedBox(height: 26),
            Text(t.yourRoutines, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1.5)),
            const SizedBox(height: 10),
            if (fit.routines.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: Text(t.noRoutines,
                    textAlign: TextAlign.center, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
              )
            else ...[
              for (final group in fit.routineGroups) ...[
                _groupHeader(gc, group, fit.routinesInGroup(group).length),
                for (final r in fit.routinesInGroup(group)) _routineCard(gc, r),
                const SizedBox(height: 8),
              ],
              for (final r in fit.routinesInGroup('')) _routineCard(gc, r),
            ],
            const SizedBox(height: 16),
            PrimaryButton(
              label: t.newRoutine,
              onTap: () => fit.openRoutine(fit.createRoutine()),
            ),
            const SizedBox(height: 10),
            GhostButton(
              label: t.templates,
              icon: PhosphorIconsRegular.stack,
              onTap: () => _openTemplates(context),
            ),
            const SizedBox(height: 10),
            GhostButton(
              label: t.aiRoutine,
              icon: PhosphorIconsRegular.sparkle,
              onTap: fit.goAiPlan,
            ),
          ],
        ),
      ),
    );
  }

  void _openTemplates(BuildContext context) {
    final gc = context.gc;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) => Container(
        padding: sheetPad(sheet),
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.85),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 18),
              Text(t.templates,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text, letterSpacing: 0.4)),
              const SizedBox(height: 6),
              Text(t.templatesHint,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
              const SizedBox(height: 18),
              for (final template in kProgramTemplates)
                _templateCard(context, gc, sheet, template),
            ],
          ),
        ),
      ),
    );
  }

  Widget _templateCard(
      BuildContext context, GymColors gc, BuildContext sheet, ProgramTemplate template) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final made = fit.applyTemplate(template);
        Navigator.pop(sheet);
        if (made == 0 || !context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.templateAdded(made)), behavior: SnackBarBehavior.floating),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: gc.bgRaised2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(12)),
              child: Icon(PhosphorIconsRegular.stack, size: 20, color: gc.ember),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.name,
                      style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text, letterSpacing: 0.5)),
                  const SizedBox(height: 2),
                  Text(t.templateBlurb(template.id),
                      style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
                  const SizedBox(height: 4),
                  Text(t.dayCount(template.days.length),
                      style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(PhosphorIconsRegular.plus, size: 16, color: gc.textSecondary),
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
            Text(t.weekdayShort(weekday),
                maxLines: 1,
                softWrap: false,
                style: AppTheme.f(14, weight: FontWeight.w600, color: isToday ? gc.ember : gc.text)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(assigned == null ? t.restDayShort : fit.routineTitle(assigned),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w500, color: assigned != null ? gc.text : gc.textTertiary)),
            ),
            const SizedBox(width: 8),
            SvgPathIcon(Ic.chevronRight, size: 14, color: gc.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _groupHeader(GymColors gc, String name, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.folderSimple, size: 15, color: gc.brass),
          const SizedBox(width: 8),
          Expanded(
            child: Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text, letterSpacing: 1)),
          ),
          Text('$count', style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
        ],
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
                  Text(fit.routineTitle(r), style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(t.exerciseCount(n), style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
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
                  style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text, letterSpacing: 0.4)),
              const SizedBox(height: 14),
              _sheetItem(context, gc, t.restDayShort, fit.weeklyPlan[weekday] == null, () {
                fit.assignRoutineToDay(weekday, null);
                Navigator.pop(context);
              }),
              for (final r in [
                for (final group in fit.routineGroups) ...fit.routinesInGroup(group),
                ...fit.routinesInGroup(''),
              ])
                _sheetItem(
                    context,
                    gc,
                    r.group.isEmpty ? fit.routineTitle(r) : '${r.group} · ${fit.routineTitle(r)}',
                    fit.weeklyPlan[weekday] == r.id, () {
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
                  style: AppTheme.f(14, weight: FontWeight.w600, color: selected ? gc.ember : gc.text)),
            ),
            if (selected) SvgPathIcon(Ic.checkBold, size: 16, color: gc.ember),
          ],
        ),
      ),
    );
  }
}
