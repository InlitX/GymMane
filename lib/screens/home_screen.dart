import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
import '../widgets/entrance.dart';
import '../widgets/exercise_media.dart';
import '../widgets/glass.dart';
import '../widgets/home_folder.dart';
import '../widgets/routine_folder.dart';
import '../widgets/steps_card.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';
import 'progress_screen.dart';
import 'routines_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final recommended = fit.recommendedExercises(8);
    final routines = fit.routinesByLastDone;

    return RiseScope(
      id: 'home',
      child: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        key: const PageStorageKey('home'),
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 116),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: riseAll([
            _topBar(gc),
            const SizedBox(height: 20),
            if (fit.showFocus || fit.todayRoutine?.exerciseIds.isNotEmpty == true) ...[
              _hero(context, gc),
              const SizedBox(height: 14),
            ],
            _weekCard(context, gc),
            if (fit.stepsOn && fit.stepsAvailable) ...[
              const SizedBox(height: 14),
              StepsCard(),
            ],
            if (fit.photoDue) ...[
              const SizedBox(height: 14),
              _photoNudge(gc),
            ],
            if (fit.showWeekStats) ...[
              const SizedBox(height: 30),
              _heading(gc, t.thisWeek),
              const SizedBox(height: 14),
              _weekStats(context, gc),
            ],
            if (fit.showRoutineRow && routines.isNotEmpty) ...[
              const SizedBox(height: 30),
              _heading(gc, t.routines, onMore: fit.goRoutines),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, box) => SizedBox(
                  height: 196,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: routines.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (_, i) => SizedBox(
                      width: (box.maxWidth - 12) / 2,
                      child: RoutineFolder(
                        routine: routines[i],
                        lastDone: true,
                        onMenu: () => showRoutineMenu(context, routines[i]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 30),
            _heading(gc, t.activityLabel, onMore: fit.goProgress),
            const SizedBox(height: 14),
            SoftCard(
              radius: 22,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              child: fit.heatmapYear
                  ? HeatmapYear(
                      levels: fit.heatmapShown,
                      firstDay: fit.heatmapShownDate(0),
                      weekdays: fit.heatmapLabels,
                      onTapDay: (i) => showDaySheet(context, fit.heatmapShownDate(i)),
                    )
                  : Heatmap(
                      levels: fit.heatmapWeeks,
                      firstDay: fit.heatmapWeekDate(0),
                      labels: fit.heatmapLabels,
                      onTapDay: (i) => showDaySheet(context, fit.heatmapWeekDate(i)),
                    ),
            ),
            if (fit.showRecommended && recommended.isNotEmpty) ...[
              const SizedBox(height: 30),
              _heading(gc, t.recommended, onMore: fit.goExercises),
              const SizedBox(height: 14),
              SizedBox(
                height: 158,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommended.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => _recCard(gc, recommended[i]),
                ),
              ),
            ],
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: HomeFolder(
                    title: _tc(t.routines),
                    detail: t.routineCount(fit.routines.length),
                    peek: const RoutinesPeek(),
                    onTap: fit.goRoutines,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: HomeFolder(
                    title: _tc(t.tools),
                    detail: t.calculatorsInside,
                    peek: const ToolsPeek(),
                    onTap: fit.goTools,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: HomeFolder(
                    title: _tc(t.journal),
                    detail: t.noteCount(fit.notes.length),
                    peek: const NotesPeek(),
                    onTap: fit.goNotes,
                  ),
                ),
              ],
            ),
            if (fit.nutritionBeta) ...[
              const SizedBox(height: 12),
              HomeFolder(
                title: _tc(t.nutrition),
                detail: _nutritionDetail,
                peek: const NutritionPeek(),
                badge: BetaTag(t.sectionBeta, small: true),
                onTap: fit.goNutrition,
              ),
            ],
          ]),
        ),
      ),
      ),
    );
  }

  Widget _topBar(GymColors gc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.today.toUpperCase(),
                  style: AppTheme.f(10.5,
                      weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
              const SizedBox(height: 3),
              Text(t.longDate(DateTime.now()),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(21, color: gc.text)),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: fit.goProgress,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
            child: Row(
              children: [
                SvgPathIcon(Ic.flame, size: 15, color: gc.accent),
                const SizedBox(width: 6),
                Text('${fit.currentStreak}',
                    style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _tc(String s) => titleCase(s);

  String get _nutritionDetail {
    final now = DateTime.now();
    final total = fit.totalOn(now);
    final water = fit.waterOn(now);
    if (total.isEmpty && water == 0) return t.nutritionHomeEmpty;
    return t.nutritionHomeDetail('${fit.energyOf(total.kcal)} ${fit.energyUnit}', total.protein.round());
  }

  Widget _heading(GymColors gc, String title, {VoidCallback? onMore}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onMore,
      child: Row(
        children: [
          Text(_tc(title), style: AppTheme.f(19, color: gc.text)),
          const Spacer(),
          if (onMore != null)
            Icon(PhosphorIconsBold.caretRight, size: 14, color: gc.textTertiary),
        ],
      ),
    );
  }

  Widget _hero(BuildContext context, GymColors gc) {
    final routine = fit.todayRoutine;
    final focus = fit.suggestedFocus;
    final isRoutine = routine != null && routine.exerciseIds.isNotEmpty;
    final label = isRoutine ? t.todaysRoutine : t.todaysFocus;
    final title = isRoutine ? fit.routineTitle(routine) : focus.title;
    final today = fit.routinesOn(DateTime.now());
    final done = isRoutine && fit.pendingRoutinesOn(DateTime.now()).isEmpty;
    final subtitle = done
        ? t.routineDoneToday
        : isRoutine
        ? [
            t.exerciseCount(routine.exerciseIds.length),
            if (fit.rotating)
              t.rotationPlace(fit.rotationStep + 1, fit.rotationRoutines.length)
            else if (today.length > 1)
              t.routineOfDay(today.indexOf(routine) + 1, today.length),
          ].join(' · ')
        : (fit.hasData
            ? '${focus.subtitle} · ${t.exerciseCount(fit.getFilteredExercises(focus.muscles).length)}'
            : t.firstSessionHint);

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -52,
              top: 34,
              child: Container(
                width: 176,
                height: 176,
                decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              left: 150,
              top: -44,
              child: Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(color: gc.emberSoft, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              right: 4,
              top: 12,
              bottom: 76,
              child: Opacity(
                opacity: 0.6,
                child: Image.asset('assets/img/runner.png', fit: BoxFit.fitHeight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    if (done) ...[
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
                        child: Center(child: SvgPathIcon(Ic.checkBold, size: 8, color: gc.onEmber)),
                      ),
                      const SizedBox(width: 7),
                    ],
                    Text(label.toUpperCase(),
                        style: AppTheme.f(10.5,
                            weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                  ]),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.only(right: 96),
                    child: Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(30,
                            weight: FontWeight.w800, color: gc.text, height: 1.1)),
                  ),
                  const SizedBox(height: 7),
                  Text(subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: done ? t.trainAgain : t.startWorkout,
                    icon: Ic.play,
                    height: 52,
                    bg: done ? gc.bgRaised2 : null,
                    fg: done ? gc.text : null,
                    onTap: isRoutine ? () => fit.startRoutine(routine) : fit.startFocusWorkout,
                  ),
                ],
              ),
            ),
            if (isRoutine && !done)
              Positioned(
                right: 10,
                top: 10,
                child: RoundAction(
                  label: t.moreOptions,
                  size: 34,
                  onTap: () => showTodayPlanMenu(context, routine),
                  child: Icon(PhosphorIconsBold.dotsThree, size: 16, color: gc.textSecondary),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _weekCard(BuildContext context, GymColors gc) {
    return SoftCard(
      radius: 22,
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [for (int i = 0; i < 7; i++) _weekDay(context, gc, i)],
      ),
    );
  }

  Widget _weekDay(BuildContext context, GymColors gc, int i) {
    final done = fit.isDayDone(i) && !fit.isDayPartial(i);
    final isToday = i == fit.todayIndex;
    final isFuture = i > fit.todayIndex;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isFuture
          ? null
          : fit.isSessionDay(i)
              ? () => showDaySheet(context, fit.dateForWeekday(i))
              : () => fit.toggleCheckin(i),
      child: Opacity(
        opacity: isFuture ? 0.5 : 1,
        child: Column(
          children: [
            Text(t.weekdayInitial(fit.weekdayAt(i)),
                style: AppTheme.f(10,
                    weight: FontWeight.w700,
                    color: isToday ? gc.text : gc.textTertiary,
                    letterSpacing: 0.5)),
            const SizedBox(height: 9),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: done ? gc.ember : gc.bgRaised2,
                shape: BoxShape.circle,
                border: isToday && !done ? Border.all(color: gc.ember, width: 2) : null,
              ),
              child: done ? Center(child: SvgPathIcon(Ic.checkBold, size: 13, color: gc.onEmber)) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _weekStats(BuildContext context, GymColors gc) {
    return SoftCard(
      radius: 22,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _stat(gc, t.volume, fit.volumeValue(fit.volumeThisWeekKg),
                      unit: fit.volumeUnit),
                ),
                Expanded(child: _stat(gc, t.statSets, '${fit.weekSetCount}')),
                Expanded(child: _stat(gc, t.prs, '${fit.prsThisWeek}')),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => showWeeklyGoalSheet(context),
            child: Column(
              children: [
                GoalRing(pct: fit.goalPct.toDouble(), size: 44),
                const SizedBox(height: 7),
                Text(t.goalDaysShort(fit.daysDoneThisWeek, fit.weeklyTarget),
                    style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(GymColors gc, String label, String value, {String unit = ''}) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FitText(label.toUpperCase(),
            style: AppTheme.f(9.5,
                weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: RollIn(value, style: AppTheme.f(23, weight: FontWeight.w800, color: gc.text)),
              ),
            ),
            if (unit.isNotEmpty) ...[
              const SizedBox(width: 3),
              Text(unit,
                  style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary)),
            ],
          ],
        ),
      ],
      ),
    );
  }

  Widget _photoNudge(GymColors gc) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: fit.goMoments,
      child: SoftCard(
        radius: 22,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: Row(
          children: [
            Icon(PhosphorIconsRegular.camera, size: 19, color: gc.accent),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.photoDueNow, style: AppTheme.f(14.5, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(t.photoInterval(fit.photoIntervalDays),
                      style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ),
            ),
            Icon(PhosphorIconsBold.caretRight, size: 14, color: gc.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _recCard(GymColors gc, Exercise ex) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => fit.openExercise(ex.id),
      child: Container(
        width: 132,
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExerciseMedia(ex: ex, height: 88, radius: 12),
            const SizedBox(height: 9),
            Expanded(
              child: Text(exerciseName(ex),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(12, weight: FontWeight.w600, color: gc.text, height: 1.25)),
            ),
          ],
        ),
      ),
    );
  }
}

void showWeeklyGoalSheet(BuildContext context) {
  final gc = context.gc;
  showAppSheet<void>(
    context: context,
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
            Text(t.weeklyGoal,
                textAlign: TextAlign.center,
                style: AppTheme.f(19, color: gc.text)),
            const SizedBox(height: 6),
            Text(t.sessionsLogged(fit.sessionsThisWeek),
                textAlign: TextAlign.center,
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
            const SizedBox(height: 20),
            Center(
              child: StepperControl(
                value: t.perWeek(fit.profile.weeklyGoal),
                minWidth: 148,
                onDec: () => setSheet(() => fit.updateProfile(weeklyGoalDelta: -1)),
                onInc: () => setSheet(() => fit.updateProfile(weeklyGoalDelta: 1)),
              ),
            ),
            const SizedBox(height: 16),
            Text(t.onbGoalWhy,
                textAlign: TextAlign.center,
                style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
            const SizedBox(height: 22),
            PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
          ],
        ),
      ),
    ),
  );
}
