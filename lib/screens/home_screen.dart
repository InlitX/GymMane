import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'history_screen.dart';
import '../widgets/body_map.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../app/desktop.dart';
import '../widgets/medal.dart' show Medal;
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
import '../widgets/day_off_sheet.dart';
import '../widgets/entrance.dart';
import '../widgets/exercise_media.dart';
import '../widgets/glass.dart';
import '../widgets/home_folder.dart';
import '../widgets/routine_folder.dart';
import '../widgets/scroll_away.dart';
import '../widgets/steps_card.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';
import 'progress_screen.dart';
import 'routines_screen.dart';
import 'start_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final recommended = fit.recommendedExercises(8);
    final routines = fit.routinesByLastDone;
    if (fit.minimalMode) return _minimalHome(context, gc, routines);
    if (DesktopScope.of(context)) return _desktop(context, gc, routines, recommended);

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
              ScrollAway(radius: 26, child: _hero(context, gc)),
              const SizedBox(height: 14),
            ],
            if (fit.photoDue) ...[
              const SizedBox(height: 14),
              _away(_photoNudge(gc)),
            ],
            ..._homeBlocks(context, gc, routines, recommended),
          ]),
        ),
      ),
      ),
    );
  }


  Widget _minimalHome(BuildContext context, GymColors gc, List<Routine> routines) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: now.weekday - DateTime.monday));
    final dates = List<DateTime>.generate(7, (i) => monday.add(Duration(days: i)));
    final trainedDays = <int>{
      for (final session in fit.sessions)
        DateTime(session.day.year, session.day.month, session.day.day).millisecondsSinceEpoch,
    };
    final recent = [...fit.sessions]..sort((a, b) => b.date.compareTo(a.date));
    final active = fit.isSessionActive;
    final last = recent.isEmpty ? null : recent.first;
    const weekdayMarks = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    Widget sectionTitle(String title, {String? action, VoidCallback? onTap}) => Padding(
          padding: const EdgeInsets.fromLTRB(2, 18, 2, 7),
          child: Row(children: [
            Expanded(
              child: Text(title,
                  style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
            ),
            if (action != null && onTap != null)
              TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  minimumSize: const Size(0, 28),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: gc.accent,
                ),
                child: Text(action, style: AppTheme.f(11, weight: FontWeight.w700)),
              ),
          ]),
        );

    Widget routineRow(Routine routine) => Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: gc.border)),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 4),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            visualDensity: VisualDensity.compact,
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            iconColor: gc.textSecondary,
            collapsedIconColor: gc.textTertiary,
            title: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(fit.routineTitle(routine),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(t.exerciseCount(routine.exerciseIds.length),
                      style: AppTheme.f(10.5, weight: FontWeight.w500, color: gc.textSecondary)),
                ]),
              ),
              TextButton(
                onPressed: () => fit.startRoutine(routine),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: gc.accent,
                ),
                child: Text(t.startWorkout, style: AppTheme.f(11, weight: FontWeight.w700)),
              ),
            ]),
            children: [
              for (final id in routine.exerciseIds)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      t.catalogName(id, fit.exerciseById(id)?.name ?? id),
                      style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary),
                    ),
                  ),
                ),
            ],
          ),
        );

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        key: const PageStorageKey('home-minimal'),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, children: [
            Expanded(
              child: Text(t.today,
                  style: AppTheme.f(17, weight: FontWeight.w700, color: gc.text)),
            ),
            Text(t.longDate(now),
                style: AppTheme.f(10.5, weight: FontWeight.w500, color: gc.textSecondary)),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            for (var i = 0; i < dates.length; i++) ...[
              if (i > 0) const SizedBox(width: 5),
              Expanded(
                child: Column(children: [
                  Text(weekdayMarks[i],
                      style: AppTheme.f(9, weight: FontWeight.w700, color: gc.textTertiary)),
                  const SizedBox(height: 4),
                  Container(
                    height: 19,
                    decoration: BoxDecoration(
                      color: dates[i].isAtSameMomentAs(today) ||
                              trainedDays.contains(dates[i].millisecondsSinceEpoch)
                          ? gc.accent
                          : gc.bgRaised,
                      border: Border.all(
                        color: dates[i].isAtSameMomentAs(today)
                            ? gc.accent
                            : gc.border,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ]),
              ),
            ],
          ]),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: active ? fit.stepBackIntoSession : () => fit.startWorkout(null),
              icon: Icon(active ? PhosphorIconsRegular.play : PhosphorIconsRegular.plus, size: 16),
              label: Text(active ? t.keepTraining : 'Start empty workout',
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              style: FilledButton.styleFrom(
                backgroundColor: gc.ember,
                foregroundColor: gc.onEmber,
                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                textStyle: AppTheme.f(12, weight: FontWeight.w800),
              ),
            ),
          ),
          sectionTitle(t.routines, action: '+ New', onTap: fit.goRoutines),
          if (routines.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Text('No routines yet',
                  style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary)),
            )
          else
            for (final routine in routines) routineRow(routine),
          sectionTitle('Last workout'),
          if (last == null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text('No workouts yet',
                  style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary)),
            )
          else
            Container(
              padding: const EdgeInsets.fromLTRB(4, 9, 4, 10),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: gc.border)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    last.name?.trim().isNotEmpty == true ? last.name! : 'Workout',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(height: 3),
                Text(
                  t.longDate(last.day) + '  ·  ' + fit.volumeLabel(last.volume) + '  ·  ' +
                      (last.durationSec / 60).round().toString() + ' min  ·  ' + t.setCount(last.setCount),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(10.5, weight: FontWeight.w500, color: gc.textSecondary),
                ),
              ]),
            ),
        ]),
      ),
    );
  }

  Widget _desktop(BuildContext context, GymColors gc, List<Routine> routines, List<Exercise> recommended) {
    Medal.warm(context);
    final blocks = _blockMap(context, gc, routines, recommended);
    Widget one(List<Widget> b) =>
        b.length == 1 ? b.single : Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: b);
    final year = fit.heatmapYear;
    const slots = {'weekdays': 1, 'routines': 1, 'folders': 0, 'week': 2, 'nutrition': 2, 'steps': 2, 'activity': 2};
    final hero = fit.showFocus || fit.todayRoutine?.exerciseIds.isNotEmpty == true;
    bool shown(String id) => blocks[id]?.isNotEmpty ?? false;
    final fixed = hero &&
        listEquals(fit.homeOrderShown, kHomeBlocks) &&
        const ['weekdays', 'week', 'routines', 'folders', 'nutrition', 'activity'].every(shown);
    final tiles = <Widget>[];
    final wraps = <Widget Function(Widget)>[];
    void add(Widget w, Widget Function(Widget) wrap) {
      tiles.add(w);
      wraps.add(wrap);
    }
    if (hero) add(_hero(context, gc), (c) => FlowSlot(column: fixed ? 0 : null, child: c));
    if (fit.photoDue) add(_photoNudge(gc), (c) => FlowSlot(column: fixed ? 0 : null, child: c));
    final ids = fixed
        ? [
            for (final id in fit.homeOrderShown)
              if (id != 'recommended' && id != 'activity') id,
            if (!year) 'activity',
            'recommended',
            if (year) 'activity',
          ]
        : fit.homeOrderShown;
    for (final id in ids) {
      if (blocks[id] case final b? when b.isNotEmpty) {
        add(one(b), switch (id) {
          'recommended' => year ? (c) => FlowWide(child: c) : (c) => FlowSlot(span: 2, child: c),
          'activity' when year => (c) => FlowWide(child: c),
          _ => fixed
              ? (c) => FlowSlot(column: slots[id], lift: id == 'week' ? 44 : 0, child: c)
              : (c) => FlowSlot(child: c),
        });
      }
    }
    final risen = riseAll(tiles, from: 1);
    return RiseScope(
      id: 'home',
      child: SingleChildScrollView(
        key: const PageStorageKey('home'),
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(32, 30, 32, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Rise(index: 0, child: _topBar(gc)),
            const SizedBox(height: 26),
            CardFlow(minColumn: 340, gap: 22, children: [
              for (var i = 0; i < risen.length; i++) wraps[i](risen[i]),
            ]),
            if (fit.sessions.isNotEmpty) ...[
              const SizedBox(height: 30),
              Rise(index: risen.length + 1, child: _lastWorkouts(gc)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _lastWorkouts(GymColors gc) {
    final last = [...fit.sessions]..sort((a, b) => b.day.compareTo(a.day));
    final shown = last.take(3).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _heading(gc, t.historyTitle, onMore: fit.goHistory),
      const SizedBox(height: 14),
      LayoutBuilder(builder: (context, box) {
        final n = CardFlow.columnsFor(box.maxWidth, minColumn: 340, gap: 22);
        final items = shown.take(n).toList();
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var i = 0; i < n; i++) ...[
            if (i > 0) const SizedBox(width: 22),
            Expanded(child: i < items.length ? WorkoutHistoryCard(session: items[i]) : const SizedBox.shrink()),
          ],
        ]);
      }),
    ]);
  }

  List<Widget> _homeBlocks(BuildContext context, GymColors gc, List<Routine> routines, List<Exercise> recommended) {
    final blocks = _blockMap(context, gc, routines, recommended);
    final out = <Widget>[];
    String? last;
    for (final id in fit.homeOrderShown) {
      final b = blocks[id];
      if (b == null || b.isEmpty) continue;
      final card = id == 'weekdays' || id == 'steps';
      final gap = last == null
          ? (fit.photoDue ? (card ? 14.0 : 30.0) : (card ? 0.0 : 16.0))
          : (card && (last == 'weekdays' || last == 'steps'))
              ? 14.0
              : id == 'nutrition' && last == 'folders'
                  ? 12.0
                  : 30.0;
      out.add(SizedBox(height: gap));
      out.addAll(b);
      last = id;
    }
    return out;
  }

  Map<String, List<Widget>> _blockMap(
      BuildContext context, GymColors gc, List<Routine> routines, List<Exercise> recommended) {
    return <String, List<Widget>>{
      'weekdays': [_away(_weekCard(context, gc))],
      'steps': [
            if (fit.stepsOn && fit.stepsAvailable) _away(StepsCard()),
      ],
      'week': [
            if (fit.showWeekStats) ...[
              _section(gc, t.thisWeek, null, _weekStats(context, gc)),
            ],
      ],
      'routines': [
            if (fit.showRoutineRow && routines.isNotEmpty) ...[
              _section(gc, t.routines, fit.goRoutines, LayoutBuilder(
                builder: (context, box) => SizedBox(
                  height: routineFolderHeight(context),
                  child: ListView.separated(
                    key: const PageStorageKey('home-routines'),
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
              )),
            ],
      ],
      'activity': [
            _section(gc, t.activityLabel, fit.goProgress, SoftCard(
              radius: 22,
              borderColor: Colors.transparent,
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
            )),
      ],
      'recommended': [
            if (fit.showRecommended && recommended.isNotEmpty) ...[
              _section(gc, t.recommended, fit.goExercises, SizedBox(
                height: 158,
                child: ListView.separated(
                  key: const PageStorageKey('home-recommended'),
                  scrollDirection: Axis.horizontal,
                  itemCount: recommended.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => _recCard(gc, recommended[i]),
                ),
              )),
            ],
      ],
      'folders': [
            _away(Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: HomeFolder(
                    title: _tc(t.routines),
                    detail: t.routineCount(fit.activeRoutines.length),
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
            ), dim: 0),
      ],
      'nutrition': [
            if (fit.nutritionBeta) ...[
              HomeFolder(
                title: _tc(t.nutrition),
                detail: _nutritionDetail,
                peek: const NutritionPeek(),
                badge: BetaTag(t.sectionBeta, small: true),
                onTap: fit.goNutrition,
              ),
            ],
      ],
    };
  }

  Widget _away(Widget child, {double dim = 0.45}) => ScrollAway(radius: 22, dim: dim, child: child);

  Widget _section(GymColors gc, String title, VoidCallback? onMore, Widget child) => _away(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heading(gc, title, onMore: onMore),
            const SizedBox(height: 14),
            child,
          ],
        ),
        dim: 0,
      );

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
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(t.longDate(DateTime.now()),
                    maxLines: 1,
                    style: AppTheme.f(30, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.8, height: 1.1)),
              ),
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
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 4),
        child: SizedBox(
          height: 30,
          child: Row(
            children: [
              Text(titleCase(title),
                  style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0)),
              const Spacer(),
              if (onMore != null)
                Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(14)),
                  child: Text(t.healthSeeAll, style: AppTheme.f(12, weight: FontWeight.w700, color: gc.text)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hero(BuildContext context, GymColors gc) {
    final resting = fit.restingToday;
    final next = resting && !fit.rotating ? fit.nextPlannedAfter(DateTime.now()) : null;
    final rest = !resting ? null : next?.routine ?? fit.rotationUpcoming;
    final routine = fit.rotating ? rest ?? fit.todayRoutine : fit.todayRoutine;
    final focus = fit.suggestedFocus;
    final isRoutine = routine != null && routine.exerciseIds.isNotEmpty;
    final label = rest != null
        ? (fit.rotating ? t.rotationTitle : t.weeklyPlan)
        : isRoutine
            ? t.todaysRoutine
            : t.todaysFocus;
    final title = rest != null
        ? t.restDayShort
        : isRoutine
            ? fit.routineTitle(routine)
            : focus.title;
    final today = fit.routinesOn(DateTime.now());
    final done = rest == null && isRoutine && fit.pendingRoutinesOn(DateTime.now()).isEmpty;
    final subtitle = rest != null
        ? [
            t.rotationRestUpNext(fit.routineTitle(rest)),
            if (next != null)
              t.weekdayShort(next.day.weekday)
            else
              t.rotationPlace(fit.rotationStep + 1, fit.rotationSteps.length),
          ].join(' · ')
        : done
        ? t.routineDoneToday
        : isRoutine
        ? [
            t.exerciseCount(routine.exerciseIds.length),
            if (fit.rotating)
              t.rotationPlace(fit.rotationStep + 1, fit.rotationSteps.length)
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
                    if (rest != null) ...[
                      Icon(PhosphorIconsFill.bed, size: 14, color: gc.sage),
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
                  Row(children: [
                    if (isRoutine && rest == null && fit.showMiniBody) ...[
                      MiniBody(sets: fit.routineMuscleSets(routine), height: 38),
                      const SizedBox(width: 10),
                    ],
                    Flexible(
                      child: Text(subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                    ),
                  ]),
                  const SizedBox(height: 18),
                  Row(children: [
                    Expanded(
                      child: PrimaryButton(
                        label: rest != null
                            ? t.trainAnyway
                            : done
                                ? t.trainAgain
                                : t.startWorkout,
                        icon: Ic.play,
                        height: 52,
                        bg: done || rest != null ? gc.bgRaised2 : null,
                        fg: done || rest != null ? gc.text : null,
                        onTap: next != null
                            ? () => showStartSheet(context)
                            : isRoutine
                                ? () => fit.startRoutine(routine)
                                : fit.startFocusWorkout,
                      ),
                    ),
                    if (isRoutine && !done && rest == null) ...[
                      const SizedBox(width: 10),
                      RoundAction(
                        label: t.moreOptions,
                        size: 52,
                        onTap: () => showTodayPlanMenu(context, routine),
                        child: Icon(PhosphorIconsBold.dotsThree, size: 22, color: gc.textSecondary),
                      ),
                    ],
                  ]),
                ],
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
      borderColor: Colors.transparent,
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
    final date = fit.dateForWeekday(i);
    final off = fit.dayOffOn(date);
    final session = fit.isSessionDay(i);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: session
          ? () => showDaySheet(context, date)
          : isToday && off == null
              ? () => fit.toggleCheckin(i)
              : fit.isCheckedIn(date)
                  ? () => fit.toggleCheckin(i)
                  : () => showDayOffSheet(context, date),
      onLongPress: session ? null : () => showDayOffSheet(context, date),
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
              child: done
                  ? Center(child: SvgPathIcon(Ic.checkBold, size: 13, color: gc.onEmber))
                  : off != null
                      ? Icon(dayOffIcon(off), size: 15, color: gc.textSecondary)
                      : fit.restOn(date)
                          ? Icon(PhosphorIconsFill.bed, size: 14, color: gc.sage)
                          : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _weekStats(BuildContext context, GymColors gc) {
    return SoftCard(
      radius: 22,
      borderColor: Colors.transparent,
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
        Ltr(child: Row(
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
        )),
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
        borderColor: Colors.transparent,
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
        decoration: sheetDecoration(gc),
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

