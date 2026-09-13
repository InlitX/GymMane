import 'package:flutter/material.dart';
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
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';
import 'exercises_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final routine = fit.activeRoutine;
    if (routine == null) {
      return const SizedBox.shrink();
    }
    final list = _filtered;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              itemCount: (list.isEmpty ? 1 : list.length) + 1,
              itemBuilder: (context, i) {
                if (i == 0) return _header(gc, routine.exerciseIds.length);
                if (list.isEmpty) return _noMatches(gc);
                return _pickRow(gc, list[i - 1]);
              },
            ),
          ),
          if (routine.exerciseIds.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: PrimaryButton(
                label: t.startWorkout,
                icon: Ic.play,
                onTap: () => fit.startRoutine(routine),
              ),
            ),
        ],
      ),
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
        const SizedBox(height: 20),
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
          const SizedBox(height: 6),
          if (routine.exerciseIds.length > 1) ...[
            Text(t.supersetHint, style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary)),
            const SizedBox(height: 6),
          ],
          if (routine.exerciseIds.length > 1) ...[
            Text(t.dragToReorder, style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary)),
            const SizedBox(height: 8),
          ],
          ReorderableListView(
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            physics: const NeverScrollableScrollPhysics(),
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
      child: Row(children: [
        chip(picked > 0 ? '${t.filters} · $picked' : t.filters, picked > 0,
            () => showExerciseFilters(context, onClear: _clearSearch)),
        chip(t.favouritesOnly, fit.exFavouritesOnly, fit.toggleFavouritesFilter),
        chip(t.noGearOnly, fit.exNoGearOnly, fit.toggleNoGearFilter),
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
                onTap: () => showCreateExerciseSheet(
                  context,
                  onCreated: (id) => fit.toggleRoutineExercise(_id, id),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayToggle(GymColors gc, int i) {
    final weekday = i + 1;
    final on = fit.weeklyPlan[weekday] == _id;
    return GestureDetector(
      onTap: () => fit.assignRoutineToDay(weekday, on ? null : _id),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: on ? gc.ember : gc.bgRaised2,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(t.weekdayInitial(i + 1),
            style: AppTheme.f(14, weight: FontWeight.w700, color: on ? gc.onEmber : gc.textSecondary)),
      ),
    );
  }

  Widget _chosenRow(GymColors gc, Routine routine, Exercise ex, int index) {
    return Container(
      key: ValueKey(ex.id),
      margin: const EdgeInsets.only(bottom: 8),
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
        SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 10)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exerciseName(ex),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 2),
              StepperControl(
                value: t.setCount(fit.routineSets(routine, ex.id)),
                minWidth: 62,
                btnSize: 24,
                gap: 8,
                fontSize: 12,
                btnRadius: 7,
                onDec: () => fit.bumpRoutineSets(_id, ex.id, -1),
                onInc: () => fit.bumpRoutineSets(_id, ex.id, 1),
              ),
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
              onTap: () => fit.toggleChain(_id, ex.id),
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
            onTap: () => fit.toggleRoutineExercise(_id, ex.id),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
                  child: SvgPathIcon(Ic.close, size: 14, color: gc.textSecondary),
                ),
              ),
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
          SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 10)),
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

  void _pickGroup(Routine routine) {
    final gc = context.gc;
    showModalBottomSheet<void>(
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
            const SizedBox(height: 18),
            Text(t.routineGroup,
                textAlign: TextAlign.center,
                style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text, letterSpacing: 0.4)),
            const SizedBox(height: 16),
            _groupOption(gc, t.noGroup, routine.group.isEmpty, () {
              fit.setRoutineGroup(_id, '');
              Navigator.pop(sheet);
            }),
            for (final group in fit.routineGroups)
              _groupOption(gc, group, routine.group == group, () {
                fit.setRoutineGroup(_id, group);
                Navigator.pop(sheet);
              }),
            const SizedBox(height: 6),
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

  Widget _groupOption(GymColors gc, String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
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

  Future<void> _newGroup() async {
    final gc = context.gc;
    final controller = TextEditingController();
    final name = await showDialog<String>(
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
    showModalBottomSheet<void>(
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
