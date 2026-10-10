import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/exercise_media.dart';
import '../widgets/exercise_preview.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/glass.dart';
import '../widgets/routine_folder.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/set_kind.dart';
import '../widgets/svg_icon.dart';
import '../widgets/timer_panel.dart';
import '../widgets/ui_kit.dart';
import 'exercises_screen.dart';
import 'plan_import_sheet.dart';

class RoutineEditScreen extends StatefulWidget {
  const RoutineEditScreen({super.key});

  @override
  State<RoutineEditScreen> createState() => _RoutineEditScreenState();
}

class _RoutineEditScreenState extends State<RoutineEditScreen> {
  late final String _id = fit.activeRoutineId!;
  late final TextEditingController _name =
      TextEditingController(text: fit.activeRoutine?.name ?? '');
  final TextEditingController _search = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _name.dispose();
    _search.dispose();
    super.dispose();
  }

  List<Exercise> get _filtered => fit.exercisesMatching(_q);

  void _clearSearch() {
    _search.clear();
    setState(() => _q = '');
  }

  void _createExercise() => showCreateExerciseSheet(
        context,
        initialName: _q,
        onCreated: (id) {
          fit.toggleRoutineExercise(_id, id);
          _clearSearch();
        },
      );

  Widget _createLink(GymColors gc) => Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _createExercise,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(t.createNamed(_q.trim()),
                textAlign: TextAlign.center,
                style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final routine = fit.activeRoutine;
    if (routine == null) {
      return const SizedBox.shrink();
    }
    final list = _filtered;
    final start = routine.exerciseIds.isNotEmpty && MediaQuery.viewInsetsOf(context).bottom == 0;
    final create = _q.trim().isNotEmpty && list.isNotEmpty;
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20, 12, 20, start ? 104 : 20),
              itemCount: (list.isEmpty ? 1 : list.length) + (create ? 2 : 1),
              itemBuilder: (context, i) {
                if (i == 0) return _header(gc, routine.exerciseIds.length);
                if (list.isEmpty) return _noMatches(gc);
                if (i > list.length) return _createLink(gc);
                return _pickRow(gc, list[i - 1]);
              },
            ),
          ),
          if (start) ...[
            const Positioned(left: 0, right: 0, bottom: 0, child: EdgeBlur(top: false, height: 112, sigma: 11, shade: 0.35)),
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Pressable(
                    onTap: fit.closeRoutineEdit,
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: gc.bgRaised2,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: gc.textTertiary.withValues(alpha: 0.45), width: 1.2),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.28), blurRadius: 14, offset: const Offset(0, 4))],
                      ),
                      child: Text(titleCase(t.save), style: AppTheme.f(15.5, weight: FontWeight.w700, color: gc.text)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: PrimaryButton(
                    label: t.startWorkout,
                    icon: Ic.play,
                    onTap: () => fit.startRoutine(routine),
                  ),
                ),
              ]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _colors(GymColors gc, Routine routine) {
    final current = folderHue(routine);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < kFolderHues.length; i++)
          Semantics(
            button: true,
            selected: kFolderHues[i] == current,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => fit.setRoutineColor(_id, i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40,
                height: 40,
                padding: EdgeInsets.all(kFolderHues[i] == current ? 4 : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kFolderHues[i] == current ? gc.text : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: kFolderHues[i], shape: BoxShape.circle),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _header(GymColors gc, int count) {
    final routine = fit.activeRoutine!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          RoundBtn(icon: Ic.chevronLeft, onTap: fit.closeRoutineEdit),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _name,
              autofocus: fit.activeRoutine?.name.isEmpty ?? false,
              style: AppTheme.f(22, weight: FontWeight.w700, color: gc.text, letterSpacing: 0.5),
              cursorColor: gc.accent,
              textCapitalization: TextCapitalization.words,
              onChanged: (v) => fit.renameRoutine(_id, v),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: t.routineName,
                hintStyle: AppTheme.f(22, weight: FontWeight.w700, color: gc.textTertiary),
              ),
            ),
          ),
          if (routine.exerciseIds.isNotEmpty)
            Semantics(
              button: true,
              label: t.shareRoutine,
              child: GestureDetector(
                onTap: () => _shareIntro(routine),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(PhosphorIconsRegular.shareNetwork, size: 19, color: gc.textTertiary),
                ),
              ),
            ),
          const SizedBox(width: 4),
          Semantics(
            button: true,
            label: t.duplicateRoutine,
            child: GestureDetector(
              onTap: () => fit.openRoutine(fit.duplicateRoutine(_id)),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(PhosphorIconsRegular.copySimple, size: 19, color: gc.textTertiary),
              ),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: _confirmDelete,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(PhosphorIconsRegular.trash, size: 20, color: gc.textTertiary),
            ),
          ),
        ]),
        const SizedBox(height: 18),
        _colors(gc, routine),
        const SizedBox(height: 22),
        Text(t.schedule, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1.5)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [for (int i = 0; i < 7; i++) _dayToggle(gc, i)],
        ),
        const SizedBox(height: 18),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _pickGroup(routine),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsRegular.folderSimple, size: 17, color: gc.textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(t.routineGroup,
                      style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text)),
                ),
                Text(routine.group.isEmpty ? t.noGroup : routine.group,
                    style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
                const SizedBox(width: 6),
                Icon(PhosphorIconsRegular.caretRight, size: 14, color: gc.textTertiary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(t.exercisesWithCount(count), style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1.5)),
        const SizedBox(height: 10),
        if (routine.exerciseIds.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(t.addFromList, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textTertiary)),
          )
        else ...[
          Text(t.setsPlannedHint, style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary)),
          const SizedBox(height: 8),
          ReorderableListView(
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            physics: const NeverScrollableScrollPhysics(),
            proxyDecorator: liftedRow(14),
            onReorderStart: reorderPicked,
            onReorderEnd: reorderDropped,
            onReorder: (from, to) => fit.reorderRoutineExercise(routine.id, from, to),
            children: [
              for (int i = 0; i < fit.routineExercises(routine).length; i++)
                _chosenRow(gc, routine, fit.routineExercises(routine)[i], i),
            ],
          ),
        ],
        const SizedBox(height: 20),
        SearchField(
          controller: _search,
          hint: t.addExercises,
          onChanged: (v) => setState(() => _q = v),
        ),
        const SizedBox(height: 10),
        _filterChips(gc),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _filterChips(GymColors gc) {
    Widget chip(String label, bool active, VoidCallback onTap) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Pill(
            label: label,
            bg: active ? gc.ember : gc.bgRaised2,
            fg: active ? gc.onEmber : gc.textSecondary,
            onTap: onTap,
            hPad: 12,
            vPad: 6,
            fontSize: 12,
          ),
        );
    final picked = (fit.exMuscleFilter == null ? 0 : 1) +
        (fit.exEquipmentFilter == null ? 0 : 1) +
        (fit.exDifficultyFilter == null ? 0 : 1);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(children: [
        chip(picked > 0 ? '${t.filters} · $picked' : t.filters, picked > 0,
            () => showExerciseFilters(context, onClear: _clearSearch)),
        chip(t.favouritesOnly, fit.exFavouritesOnly, fit.toggleFavouritesFilter),
        chip(t.noGearOnly, fit.exNoGearOnly, fit.toggleNoGearFilter),
        if (fit.customExercises.isNotEmpty || fit.exMineOnly)
          chip(t.mineOnly, fit.exMineOnly, fit.toggleMineFilter),
        for (final id in kFilterMuscles)
          chip(muscleLabel(id), fit.exMuscleFilter == id, () => fit.setMuscleFilter(id)),
      ]),
    );
  }

  Widget _noMatches(GymColors gc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        children: [
          Text(t.noExercisesFound, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pill(
                label: t.clearFilters,
                bg: gc.bgRaised2,
                fg: gc.accent,
                onTap: () {
                  _clearSearch();
                  fit.clearExFilters();
                },
              ),
              const SizedBox(width: 10),
              Pill(
                label: t.newExercise,
                bg: gc.bgRaised2,
                fg: gc.textSecondary,
                onTap: _createExercise,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayToggle(GymColors gc, int i) {
    final weekday = fit.weekdayAt(i);
    final on = fit.plannedOn(weekday, _id);
    return GestureDetector(
      onTap: () => fit.togglePlanDay(weekday, _id),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: on ? gc.ember : gc.bgRaised2,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(t.weekdayInitial(weekday),
            style: AppTheme.f(14, weight: FontWeight.w700, color: on ? gc.onEmber : gc.textSecondary)),
      ),
    );
  }

  Widget _rail(GymColors gc, {required bool top, required bool bottom}) => Center(
        child: Container(
          width: 4,
          margin: EdgeInsets.only(top: top ? 10 : 0, bottom: bottom ? 10 : 0),
          decoration: BoxDecoration(
            color: gc.brass,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(top ? 4 : 0),
              bottom: Radius.circular(bottom ? 4 : 0),
            ),
          ),
        ),
      );

  String _planLine(List<PlannedSet> plan) {
    final warm = plan.where((p) => p.kind == SetKind.warmup).length;
    final work = plan.where((p) => p.kind != SetKind.warmup).toList();
    String one(PlannedSet p) {
      final load = [
        if (p.km != null) fit.distanceValue(p.km!),
        if (p.sec != null) durationLabel(p.sec!),
        if (p.reps != null) '${p.reps}',
        if (p.weightKg != null) fit.weightValue(p.weightKg!),
      ].join(' × ');
      final tag = setKindTag(p.kind);
      return [if (tag.isNotEmpty) tag, if (load.isNotEmpty) load].join(' ');
    }

    final parts = <String>[
      if (warm > 0) '$warm ${setKindTag(SetKind.warmup)}',
      for (final p in work.take(4)) one(p),
      if (work.length > 4) '…',
    ].where((s) => s.trim().isNotEmpty).toList();
    final unit = plan.any((p) => p.weightKg != null)
        ? fit.units
        : plan.any((p) => p.km != null)
            ? fit.distanceUnit
            : '';
    return unit.isEmpty ? parts.join(' · ') : '${parts.join(' · ')} $unit';
  }

  void _remove(Exercise ex) {
    final undo = fit.removeRoutineExercise(_id, ex.id);
    if (undo == null) return;
    HapticFeedback.lightImpact();
    showNotchToast(
      context,
      t.removedFromRoutine,
      subtitle: exerciseName(ex),
      icon: PhosphorIconsFill.trash,
      accent: context.gc.warn,
      action: t.undo,
      onTap: undo,
    );
  }

  void _shareIntro(Routine routine) {
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) {
        final gc = sheet.gc;
        return Container(
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
              const SizedBox(height: 22),
              Center(child: _ShareArt(gc: gc)),
              const SizedBox(height: 18),
              Text(t.shareIntroTitle,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(21, weight: FontWeight.w800, color: gc.text)),
              const SizedBox(height: 8),
              Text(t.shareIntroBody,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
                  Icon(PhosphorIconsFill.listChecks, size: 20, color: gc.ember),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(fit.routineTitle(routine),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                  ),
                  Text(t.exerciseCount(routine.exerciseIds.length),
                      style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
                ]),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: t.shareRoutine,
                onTap: () {
                  Navigator.of(sheet).pop();
                  sharePlan([routine]);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _chosenRow(GymColors gc, Routine routine, Exercise ex, int index) {
    final linksNext = fit.chainsToNext(routine, ex.id);
    final fromPrev = index > 0 && fit.chainsToNext(routine, routine.exerciseIds[index - 1]);
    final inChain = linksNext || fromPrev;
    final plan = fit.plannedSets(routine, ex.id);
    final anyChain = [
      for (var i = 0; i < routine.exerciseIds.length - 1; i++) fit.chainsToNext(routine, routine.exerciseIds[i]),
    ].any((x) => x);
    return Padding(
      key: ValueKey(ex.id),
      padding: EdgeInsets.only(bottom: linksNext ? 0 : 8),
      child: Dismissible(
        key: ValueKey('swipe-${ex.id}'),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => _remove(ex),
        background: Container(
          margin: EdgeInsets.only(bottom: linksNext ? 4 : 0),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 22),
          decoration: BoxDecoration(color: gc.warn.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(14)),
          child: Icon(PhosphorIconsFill.trash, size: 20, color: gc.warn),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (anyChain)
                SizedBox(
                  width: 12,
                  child: inChain ? _rail(gc, top: !fromPrev, bottom: !linksNext) : null,
                ),
              Expanded(child: _chosenCard(gc, routine, ex, index, inChain, plan, linksNext)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chosenCard(GymColors gc, Routine routine, Exercise ex, int index, bool inChain,
      List<PlannedSet> plan, bool linksNext) {
    return Container(
      margin: EdgeInsets.only(bottom: linksNext ? 4 : 0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        ReorderableDragStartListener(
          index: index,
          child: Semantics(
            label: t.reorderHandle(exerciseName(ex)),
            child: SizedBox(
              width: 34,
              height: 44,
              child: Icon(PhosphorIconsRegular.dotsSixVertical, size: 18, color: gc.textTertiary),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _openPlan(ex),
          child: SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 10)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                button: true,
                label: t.planSets,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _openPlan(ex),
                  child: Row(children: [
                    Flexible(
                      child: Text(exerciseName(ex),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                    ),
                    const SizedBox(width: 5),
                    Icon(PhosphorIconsRegular.slidersHorizontal,
                        size: 13, color: plan.isEmpty ? gc.textTertiary : gc.ember),
                  ]),
                ),
              ),
              if (inChain) ...[
                const SizedBox(height: 2),
                Text(t.superset.toUpperCase(),
                    style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.brass, letterSpacing: 1)),
              ],
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: StepperControl(
                  value: t.setCount(fit.routineSets(routine, ex.id)),
                  minWidth: 62,
                  btnSize: 24,
                  gap: 8,
                  fontSize: 12,
                  btnRadius: 7,
                  onDec: () => fit.bumpRoutineSets(_id, ex.id, -1),
                  onInc: () => fit.bumpRoutineSets(_id, ex.id, 1),
                ),
              ),
              if (plan.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(_planLine(plan),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary)),
              ],
            ],
          ),
        ),
        if (index < routine.exerciseIds.length - 1)
          Semantics(
            button: true,
            toggled: routine.chained.contains(ex.id),
            label: t.supersetLink,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                fit.toggleChain(_id, ex.id);
                if (!routine.chained.contains(ex.id)) return;
                HapticFeedback.selectionClick();
                showNotchToast(context, t.superset,
                    subtitle: t.supersetHint, icon: PhosphorIconsFill.link, accent: gc.brass);
              },
              child: SizedBox(
                width: 38,
                height: 44,
                child: Center(
                  child: Icon(
                    routine.chained.contains(ex.id)
                        ? PhosphorIconsFill.link
                        : PhosphorIconsRegular.link,
                    size: 17,
                    color: routine.chained.contains(ex.id) ? gc.ember : gc.textTertiary,
                  ),
                ),
              ),
            ),
          ),
        Semantics(
          button: true,
          label: t.removeFromRoutine,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _remove(ex),
            child: SizedBox(
              width: 38,
              height: 44,
              child: Center(child: Icon(PhosphorIconsRegular.trash, size: 18, color: gc.textTertiary)),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _pickRow(GymColors gc, Exercise ex) {
    final inRoutine = fit.routineHas(_id, ex.id);
    return GestureDetector(
      onTap: () => fit.toggleRoutineExercise(_id, ex.id),
      onLongPress: () => showExercisePreview(context, ex),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: inRoutine ? gc.ember : gc.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: () => showExercisePreview(context, ex),
            child: SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 10)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exerciseName(ex), style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 2),
                Text('${muscleLabel(ex.primary)} · ${t.equipment(ex.equipment)}', style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
              ],
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: inRoutine ? gc.ember : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: inRoutine ? gc.ember : gc.border, width: 2),
            ),
            child: inRoutine
                ? SvgPathIcon(Ic.checkBold, size: 14, color: gc.onEmber)
                : Icon(PhosphorIconsRegular.plus, size: 15, color: gc.textSecondary),
          ),
        ]),
      ),
    );
  }

  void _openPlan(Exercise ex) {
    showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheet) => AnimatedBuilder(
        animation: fit,
        builder: (sheet, _) {
          final gc = sheet.gc;
          final routine = fit.routines.where((r) => r.id == _id).firstOrNull;
          if (routine == null || !routine.exerciseIds.contains(ex.id)) return const SizedBox.shrink();
          final mode = fit.modeOf(ex.id);
          final repsOnly = fit.isRepsOnly(ex.id);
          final plan = fit.hasPlan(routine, ex.id)
              ? fit.plannedSets(routine, ex.id)
              : List.generate(fit.routineSets(routine, ex.id), (_) => const PlannedSet());
          void save(List<PlannedSet> next) => fit.setPlannedSets(_id, ex.id, next);
          void edit(int i, PlannedSet p) => save([...plan]..[i] = p);
          var working = 0;
          return Container(
            padding: sheetPad(sheet),
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.9),
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
                  Text(exerciseName(ex), style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
                  const SizedBox(height: 4),
                  Text(
                      switch (mode) {
                        'cardio' => t.planHintCardio,
                        'time' => repsOnly ? t.planHintTime : t.planHintTimeWeight,
                        _ => repsOnly ? t.planHintReps : t.planSetsHint,
                      },
                      style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                  const SizedBox(height: 16),
                  _planHeader(gc, mode, repsOnly),
                  const SizedBox(height: 8),
                  for (var i = 0; i < plan.length; i++)
                    _planRow(sheet, gc, plan, i, plan[i].kind == SetKind.warmup ? 0 : ++working, mode,
                        repsOnly, edit, save),
                  const SizedBox(height: 8),
                  Row(children: [
                    Expanded(
                      child: GhostButton(
                        label: t.addSet.replaceFirst(RegExp(r'^\+\s*'), ''),
                        icon: PhosphorIconsRegular.plus,
                        onTap: () => save([
                          ...plan,
                          plan.lastWhere((p) => p.kind != SetKind.warmup, orElse: () => const PlannedSet())
                              .copyWith(kind: SetKind.normal),
                        ]),
                      ),
                    ),
                    if (mode.isEmpty) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: GhostButton(
                          label: t.addWarmup,
                          icon: PhosphorIconsRegular.fire,
                          onTap: () => save([const PlannedSet(reps: 10, kind: SetKind.warmup), ...plan]),
                        ),
                      ),
                    ],
                  ]),
                  if (fit.hasPlan(routine, ex.id))
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => save(const []),
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        child: Text(t.clearPlan,
                            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
                      ),
                    ),
                  const SizedBox(height: 10),
                  _restRow(sheet, gc, routine, ex),
                  const SizedBox(height: 14),
                  PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _restRow(BuildContext sheet, GymColors gc, Routine routine, Exercise ex) {
    final own = fit.routineRest(routine.id, ex.id);
    final seconds = own ?? fit.restFor(ex.id);
    String label(int s) => s == 0 ? t.restOff : clockLabel(s);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
      child: Row(children: [
        Icon(PhosphorIconsRegular.timer, size: 19, color: own != null ? gc.text : gc.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleCase(t.restInRoutine), style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 3),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: own != null ? () => fit.setRoutineRest(routine.id, ex.id, null) : null,
                child: Text(own != null ? t.restInRoutineReset : t.restInRoutineHint,
                    style: AppTheme.f(11.5,
                        weight: FontWeight.w500, color: own != null ? gc.accent : gc.textSecondary, height: 1.3)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        StepperControl(
          value: label(seconds),
          minWidth: 48,
          btnSize: 30,
          gap: 3,
          fontSize: 14,
          btnRadius: 10,
          onDec: () => fit.setRoutineRest(routine.id, ex.id, seconds - 15),
          onInc: () => fit.setRoutineRest(routine.id, ex.id, seconds + 15),
          onEdit: () async {
            final v = await askRuler(sheet,
                title: t.restInRoutine,
                value: seconds.toDouble(),
                min: 0,
                max: 600,
                step: 5,
                majorEvery: 6,
                format: (v) => clockLabel(v.round()),
                tickLabel: (v) => clockLabel(v.round()));
            if (v != null) fit.setRoutineRest(routine.id, ex.id, v.round());
          },
        ),
      ]),
    );
  }

  Widget _planHeader(GymColors gc, String mode, bool repsOnly) {
    final labels = switch (mode) {
      'cardio' => [t.distanceCol(fit.distanceUnit.toUpperCase()), t.timeCol],
      'time' => [t.timeCol, if (!repsOnly) t.weightCol(fit.units.toUpperCase())],
      _ => [t.repsCol, if (!repsOnly) t.weightCol(fit.units.toUpperCase())],
    };
    final style = AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1);
    return Row(children: [
      SizedBox(width: 40, child: Center(child: Text(t.setCol, style: style))),
      const SizedBox(width: 8),
      for (final l in labels) ...[
        Expanded(
          child: Center(
            child: FittedBox(fit: BoxFit.scaleDown, child: Text(l, maxLines: 1, style: style)),
          ),
        ),
        const SizedBox(width: 6),
      ],
      const SizedBox(width: 30),
    ]);
  }

  Widget _planRow(
    BuildContext sheet,
    GymColors gc,
    List<PlannedSet> plan,
    int i,
    int number,
    String mode,
    bool repsOnly,
    void Function(int, PlannedSet) edit,
    void Function(List<PlannedSet>) save,
  ) {
    final p = plan[i];
    final auto = t.autoValue;
    Widget cell(String value, VoidCallback dec, VoidCallback inc, VoidCallback onEdit) => Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: StepperControl(
              value: value,
              minWidth: 44,
              btnSize: 26,
              gap: 4,
              fontSize: 13,
              btnRadius: 8,
              onDec: dec,
              onInc: inc,
              onEdit: onEdit,
            ),
          ),
        );
    Future<void> ask(String title, double value, double max, double step, int major, String unit,
        void Function(double) apply,
        {String Function(double)? format}) async {
      final v = await askRuler(sheet,
          title: title,
          value: value,
          min: 0,
          max: max,
          step: step,
          unit: unit,
          majorEvery: major,
          format: format,
          tickLabel: format);
      if (v != null) apply(v);
    }

    final weight = cell(
      p.weightKg == null ? auto : fit.weightValue(p.weightKg!),
      () {
        final shown = p.weightKg == null ? 0.0 : fit.toDisplayWeight(p.weightKg!) - fit.weightStep;
        edit(i, shown <= 0 ? p.copyWith(autoWeight: true) : p.copyWith(weightKg: fit.fromDisplayWeight(shown)));
      },
      () {
        final shown = p.weightKg == null ? fit.weightStep * 8 : fit.toDisplayWeight(p.weightKg!) + fit.weightStep;
        edit(i, p.copyWith(weightKg: fit.fromDisplayWeight(shown)));
      },
      () => ask(
          t.weightTitle(fit.units.toUpperCase()),
          p.weightKg == null ? (fit.isLb ? 45 : 20) : fit.toDisplayWeight(p.weightKg!),
          fit.isLb ? 660 : 300,
          fit.isLb ? 1 : 0.5,
          10,
          fit.units,
          (v) => edit(i, v <= 0 ? p.copyWith(autoWeight: true) : p.copyWith(weightKg: fit.fromDisplayWeight(v)))),
    );
    final reps = cell(
      p.reps == null ? auto : '${p.reps}',
      () => edit(i, p.copyWith(reps: ((p.reps ?? 10) - 1).clamp(1, 999))),
      () => edit(i, p.copyWith(reps: ((p.reps ?? 10) + 1).clamp(1, 999))),
      () => ask(t.repsTitle, (p.reps ?? 10).toDouble(), 100, 1, 5, '',
          (v) => edit(i, p.copyWith(reps: v.round().clamp(1, 999)))),
    );
    final cardio = mode == 'cardio';
    final step = cardio ? 60 : 15;
    final time = cell(
      p.sec == null ? auto : durationLabel(p.sec!),
      () => edit(i, p.copyWith(sec: ((p.sec ?? (cardio ? 1200 : 30)) - step).clamp(step, 24 * 3600))),
      () => edit(i, p.copyWith(sec: ((p.sec ?? (cardio ? 1200 : 30)) + step).clamp(step, 24 * 3600))),
      () => cardio
          ? ask(t.timeMinutesTitle, ((p.sec ?? 1200) / 60).roundToDouble(), 300, 1, 5, 'min',
              (v) => edit(i, p.copyWith(sec: (v * 60).round())))
          : ask(t.timeSecondsTitle, (p.sec ?? 30).toDouble(), 900, 5, 6, '',
              (v) => edit(i, p.copyWith(sec: v.round())),
              format: (v) => clockLabel(v.round())),
    );
    final distance = cell(
      p.km == null ? auto : fit.distanceValue(p.km!),
      () => edit(i, p.copyWith(km: fit.fromDisplayKm((fit.toDisplayKm(p.km ?? 0) - 0.5).clamp(0, 1000)))),
      () => edit(i, p.copyWith(km: fit.fromDisplayKm(fit.toDisplayKm(p.km ?? 0) + 0.5))),
      () => ask(t.distanceTitle(fit.distanceUnit), fit.toDisplayKm(p.km ?? 5), 100, 0.1, 10, fit.distanceUnit,
          (v) => edit(i, p.copyWith(km: fit.fromDisplayKm(v)))),
    );
    final cells = switch (mode) {
      'cardio' => [distance, time],
      'time' => [time, if (!repsOnly) weight],
      _ => [reps, if (!repsOnly) weight],
    };
    final tag = setKindTag(p.kind);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Semantics(
          button: true,
          label: '${t.setType} · ${setKindLabel(p.kind)}',
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              final kind = await askSetKind(sheet, p.kind);
              if (kind != null) edit(i, p.copyWith(kind: kind));
            },
            child: Container(
              width: 40,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: gc.bgRaised2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: p.kind == SetKind.normal ? Colors.transparent : setKindColor(gc, p.kind)),
              ),
              child: Text(p.kind == SetKind.warmup ? tag : (tag.isEmpty ? '$number' : '$number$tag'),
                  style: AppTheme.f(12.5, weight: FontWeight.w700, color: setKindColor(gc, p.kind))),
            ),
          ),
        ),
        const SizedBox(width: 8),
        for (final c in cells) ...[c, const SizedBox(width: 6)],
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: plan.length > 1 ? () => save([...plan]..removeAt(i)) : null,
          child: SizedBox(
            width: 30,
            height: 34,
            child: Icon(PhosphorIconsRegular.x,
                size: 14, color: plan.length > 1 ? gc.textTertiary : Colors.transparent),
          ),
        ),
      ]),
    );
  }

  void _pickGroup(Routine routine) {
    final gc = context.gc;
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) => Container(
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
            const SizedBox(height: 16),
            SheetTitle(t.routineGroup),
            const SizedBox(height: 14),
            OptionGroup([
              OptionItem(
                t.noGroup,
                selected: routine.group.isEmpty,
                onTap: () {
                  fit.setRoutineGroup(_id, '');
                  Navigator.pop(sheet);
                },
              ),
              for (final group in fit.routineGroups)
                OptionItem(
                  group,
                  selected: routine.group == group,
                  onTap: () {
                    fit.setRoutineGroup(_id, group);
                    Navigator.pop(sheet);
                  },
                ),
            ]),
            const SizedBox(height: 12),
            GhostButton(
              label: t.newGroup,
              icon: PhosphorIconsRegular.plus,
              onTap: () {
                Navigator.pop(sheet);
                _newGroup();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _newGroup() async {
    final gc = context.gc;
    final controller = TextEditingController();
    final name = await showAppDialog<String>(
      context: context,
      builder: (dctx) => appDialog(
        gc,
        title: Text(t.newGroup, style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          style: AppTheme.f(15, weight: FontWeight.w500, color: gc.text),
          cursorColor: gc.accent,
          decoration: InputDecoration(
            hintText: t.groupNameHint,
            hintStyle: AppTheme.f(15, weight: FontWeight.w500, color: gc.textTertiary),
            filled: true,
            fillColor: gc.bgRaised2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          ),
          onSubmitted: (v) => Navigator.of(dctx).pop(v),
        ),
        actions: [
          dialogAction(t.cancel, gc.textSecondary, () => Navigator.of(dctx).pop(), strong: false),
          dialogAction(t.save, gc.accent, () => Navigator.of(dctx).pop(controller.text)),
        ],
      ),
    );
    controller.dispose();
    if (name != null && name.trim().isNotEmpty) fit.setRoutineGroup(_id, name);
  }

  void _confirmDelete() {
    final gc = context.gc;
    showAppSheet<void>(
      context: context,
      backgroundColor: gc.bgRaised,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(t.deleteRoutine, style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 18),
              PrimaryButton(
                label: t.deleteCaps,
                bg: gc.accent,
                onTap: () {
                  Navigator.pop(context);
                  fit.deleteRoutine(_id);
                  fit.closeRoutineEdit();
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: Text(t.cancelCaps,
                      style: AppTheme.f(14, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareArt extends StatelessWidget {
  const _ShareArt({required this.gc});

  final GymColors gc;

  Widget _bubble(IconData icon, Color bg, Color fg, double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle, border: Border.all(color: gc.bgRaised, width: 3)),
        child: Icon(icon, size: size * 0.44, color: fg),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 86,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 0, top: 20, child: _bubble(PhosphorIconsFill.heart, gc.bgRaised2, gc.textSecondary, 50)),
          Positioned(right: 0, top: 20, child: _bubble(PhosphorIconsFill.usersThree, gc.bgRaised2, gc.textSecondary, 50)),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: gc.emberSoft,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: gc.bgRaised, width: 3),
            ),
            child: Icon(PhosphorIconsFill.paperPlaneTilt, size: 34, color: gc.ember),
          ),
        ],
      ),
    );
  }
}
