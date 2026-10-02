import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
import '../widgets/dialogs.dart';
import '../widgets/entrance.dart';
import '../widgets/exercise_media.dart';
import '../widgets/exercise_preview.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/glass.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/stopwatch_card.dart';
import '../widgets/svg_icon.dart';
import '../widgets/timer_panel.dart';
import '../widgets/ui_kit.dart';
import 'exercises_screen.dart' show showCreateExerciseSheet;

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({super.key});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late final String _exId = fit.activeExerciseId ?? fit.activeExercise.id;

  String _fmtDate(DateTime d) => t.shortDate(d);

  Future<void> _pickMedia() async {
    try {
      final res = await FilePicker.platform.pickFiles(type: FileType.media);
      final path = res?.files.single.path;
      if (path != null) await fit.attachExerciseMedia(_exId, path);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final ex = fit.activeExercise;
    final fav = fit.favorites[ex.id] ?? false;
    final secondary =
        ex.secondary.map(muscleLabel).join(', ').isEmpty ? t.none : ex.secondary.map(muscleLabel).join(', ');
    final steps = fit.activeExerciseSteps(ex);
    final pr = fit.exerciseRecord(ex.id);
    final oneRm = fit.oneRmSeries(ex.id);
    final bestReps = fit.bestRepsSeries(ex.id);
    final history = fit.exerciseHistory(ex.id);
    final hasMedia = fit.hasCustomMedia(ex.id);
    final repsOnly = fit.isRepsOnly(ex.id);
    final mode = fit.modeOf(ex.id);
    final custom = fit.isCustom(ex.id);
    final archived = fit.isArchived(ex.id);

    return RiseScope(
      id: 'exercise',
      once: false,
      child: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.only(top: 12, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: riseAll([
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundBtn(icon: Ic.chevronLeft, onTap: fit.closeExerciseDetail),
                  Row(children: [
                    if (custom) ...[
                      RoundAction(
                        label: t.delete,
                        onTap: () => _confirmDelete(context, ex),
                        child: Icon(PhosphorIconsRegular.trash, size: 16, color: gc.textSecondary),
                      ),
                      const SizedBox(width: 10),
                      Semantics(
                        button: true,
                        label: t.editExercise,
                        child: RoundAction(
                          onTap: () => showCreateExerciseSheet(context, editing: ex),
                          child: Icon(PhosphorIconsRegular.pencilSimple, size: 16, color: gc.textSecondary),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    RoundAction(
                      label: archived ? t.restoreExercise : t.archiveExercise,
                      onTap: () => _toggleArchived(context, ex),
                      child: Icon(archived ? PhosphorIconsFill.archive : PhosphorIconsRegular.archive,
                          size: 16, color: archived ? gc.accent : gc.textSecondary),
                    ),
                    const SizedBox(width: 10),
                    RoundAction(
                      onTap: () => fit.toggleFavorite(ex.id),
                      child: _star(gc, fav),
                    ),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () => showExercisePreview(context, ex),
                    child: SizedBox(
                      width: double.infinity,
                      child: ExerciseMedia(
                          ex: ex, height: 220, radius: 22, live: true, bordered: false),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        if (hasMedia) ...[
                          _mediaBtn(gc, PhosphorIconsRegular.arrowCounterClockwise, t.useDefaultArt,
                              () => fit.clearExerciseMedia(ex.id)),
                          const SizedBox(width: 8),
                        ],
                        _mediaBtn(
                          gc,
                          hasMedia ? PhosphorIconsRegular.pencilSimple : PhosphorIconsRegular.uploadSimple,
                          hasMedia ? t.changeMedia : t.addMedia,
                          _pickMedia,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: archived
                        ? Padding(padding: const EdgeInsets.only(bottom: 16), child: _archivedBanner(gc, ex))
                        : const SizedBox(width: double.infinity),
                  ),
                  Text(exerciseName(ex),
                      style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text, height: 1.1)),
                  if (ex.aliases.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(t.alsoCalled(ex.aliases.join(', ')),
                        style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
                  ],
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _meta(gc, t.primaryLabel, muscleLabel(ex.primary)),
                      const SizedBox(width: 20),
                      _meta(gc, t.secondaryLabel, secondary),
                      const SizedBox(width: 20),
                      _meta(gc, t.equipmentLabel, t.equipment(ex.equipment)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _addToRoutineRow(context, gc, ex),
                  const SizedBox(height: 20),
                  if (pr != null) ...[
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: gc.bgRaised,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _cardLabel(gc, t.personalRecord),
                                    const SizedBox(height: 8),
                                    Text(fit.recordLabel(pr),
                                        style: AppTheme.f(30,
                                            weight: FontWeight.w800, color: gc.text, height: 1)),
                                  ],
                                ),
                              ),
                              Text(fit.recordDetail(pr),
                                  style: AppTheme.f(12,
                                      weight: FontWeight.w500, color: gc.textSecondary)),
                            ],
                          ),
                          if (pr.kind == PrKind.weight && oneRm.length > 2) ...[
                            const SizedBox(height: 16),
                            TrendChart(values: [for (final v in oneRm) fit.toDisplayWeight(v)], height: 84, scale: fmt),
                          ],
                          if (pr.kind == PrKind.reps && bestReps.length > 2) ...[
                            const SizedBox(height: 16),
                            TrendChart(values: bestReps, height: 84, scale: (v) => '${v.round()}'),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (fit.goalFits(ex.id)) ...[
                    _goalCard(context, gc, ex.id),
                    const SizedBox(height: 20),
                  ],
                  if (fit.nextTargetLabel(ex.id) != null) ...[
                    _nextCard(gc, ex.id),
                    const SizedBox(height: 20),
                  ],
                  _section(gc, t.history),
                  const SizedBox(height: 6),
                  if (history.isEmpty)
                    Text(t.noHistory,
                        style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary))
                  else
                    for (int i = 0; i < history.length && i < 8; i++)
                      _historyRow(gc, history[i], i < history.length - 1 && i < 7, mode),
                  const SizedBox(height: 24),
                  _notesRow(gc, ex.id),
                  const SizedBox(height: 24),
                  if (steps.isNotEmpty || custom) ...[
                    Row(children: [
                      Expanded(child: _section(gc, t.howTo)),
                      if (custom && steps.isNotEmpty)
                        Semantics(
                          button: true,
                          label: t.editExercise,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => showCreateExerciseSheet(context, editing: ex),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Icon(PhosphorIconsRegular.pencilSimple, size: 17, color: gc.textTertiary),
                            ),
                          ),
                        ),
                    ]),
                    const SizedBox(height: 14),
                    if (steps.isEmpty) ...[
                      Text(t.noStepsYet,
                          style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Pill(
                          label: t.addSteps,
                          bg: gc.bgRaised2,
                          fg: gc.accent,
                          onTap: () => showCreateExerciseSheet(context, editing: ex),
                        ),
                      ),
                    ],
                    for (int i = 0; i < steps.length; i++) ...[
                      _step(gc, i + 1, steps[i]),
                      if (i < steps.length - 1) const SizedBox(height: 14),
                    ],
                  ],
                  const SizedBox(height: 28),
                  _section(gc, t.exerciseSettings),
                  const SizedBox(height: 12),
                  _group(gc, [
                    _modeRow(context, gc, ex.id, mode),
                    if (mode != 'cardio') _repsOnlyRow(gc, ex.id, repsOnly),
                    _restRow(gc, ex.id),
                    if (ex.equipment == 'Barbell' || ex.equipment == 'Machine') _barRow(gc, ex),
                    _switchRow(
                      gc,
                      PhosphorIconsRegular.sparkle,
                      t.suggestInWorkouts,
                      t.suggestInWorkoutsHint,
                      fit.suggests(ex.id),
                      () => fit.toggleSuggest(ex.id),
                    ),
                    if (!repsOnly && mode.isEmpty) ...[
                      _progressRow(gc, ex.id),
                      _switchRow(
                        gc,
                        PhosphorIconsRegular.fire,
                        t.autoWarmup,
                        t.autoWarmupHint,
                        fit.warmsUp(ex.id),
                        () => fit.toggleAutoWarmup(ex.id),
                      ),
                    ],
                  ]),
                  const SizedBox(height: 20),
                  const StopwatchCard(),
                  if (fit.alternativesHere(ex, 3).isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _notHere(gc, ex),
                  ],
                  if (fit.similarExercises(ex, 4).isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _section(gc, t.similar),
                    const SizedBox(height: 10),
                    for (final s in fit.similarExercises(ex, 4)) _similarRow(gc, s),
                  ],
                ],
              ),
            ),
          ]),
        ),
      ),
      ),
    );
  }

  Widget _notHere(GymColors gc, Exercise ex) {
    final place = fit.activePlace!;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.warn.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(PhosphorIconsRegular.mapPin, size: 16, color: gc.warn),
              const SizedBox(width: 10),
              Expanded(
                child: Text(t.notHere(t.equipment(ex.equipment).toLowerCase(), place.name),
                    style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(t.notHereWhy, style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
          ),
          const SizedBox(height: 14),
          Text(t.altHere,
              style: AppTheme.f(10.5,
                  weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
          const SizedBox(height: 6),
          for (final alt in fit.alternativesHere(ex, 3)) _similarRow(gc, alt),
        ],
      ),
    );
  }

  String _setsLine(LoggedExercise e) {
    final rpe = e.sets.map((s) => s.rpe).whereType<double>().toList();
    final sets = t.setCount(e.sets.length);
    if (rpe.isEmpty) return sets;
    return '$sets · ${fit.effortLabel(rpe.reduce((a, b) => a > b ? a : b))}';
  }

  String _bestOf(LoggedExercise e, String mode) {
    final working = e.workingSets;
    if (working.isEmpty) return '';
    if (mode == 'cardio') {
      final km = working.fold<double>(0, (s, x) => s + (x.km ?? 0));
      return km > 0
          ? fit.distanceLabel(km)
          : durationLabel(working.fold<int>(0, (s, x) => s + (x.sec ?? 0)));
    }
    return durationLabel(working.fold<int>(0, (s, x) => (x.sec ?? 0) > s ? x.sec! : s));
  }

  Widget _historyRow(GymColors gc, ({DateTime date, LoggedExercise ex}) h, bool border, String mode) {
    final e = h.ex;
    if (mode.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          border: border ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.55))) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_fmtDate(h.date), style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 3),
                  Text(fit.setsSummary(e.sets),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(_bestOf(e, mode), style: AppTheme.f(17, weight: FontWeight.w700, color: gc.text)),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: border
            ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.55)))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_fmtDate(h.date),
                  style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 3),
              Text(_setsLine(e),
                  style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(fit.weightLabel(e.topWeight),
                  style: AppTheme.f(17, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(height: 3),
              Text(t.volumeSuffix(fit.volumeLabel(e.volume)),
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _notesRow(GymColors gc, String exId) {
    final n = fit.notesFor(exId).length;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => fit.goNotes(exerciseId: exId, all: true),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _rowIcon(gc, PhosphorIconsRegular.notebook, n > 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleCase(t.notes),
                        style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                    const SizedBox(height: 3),
                    Text(n == 0 ? t.noteNoneForExercise : t.noteCount(n),
                        style: AppTheme.f(11.5,
                            weight: FontWeight.w500, color: gc.textSecondary)),
                  ],
                ),
              ),
              Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addToRoutineRow(BuildContext context, GymColors gc, Exercise ex) {
    final n = fit.routinesWith(ex.id);
    return Semantics(
      button: true,
      child: Pressable(
        onTap: () => _pickRoutine(context, ex),
        scale: 0.98,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _rowIcon(gc, PhosphorIconsRegular.listPlus, n > 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.addToRoutine, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                    const SizedBox(height: 3),
                    Text(t.inRoutines(n),
                        style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary)),
                  ],
                ),
              ),
              Icon(PhosphorIconsRegular.plus, size: 16, color: gc.textTertiary),
            ],
          ),
        ),
      ),
    );
  }

  void _pickRoutine(BuildContext context, Exercise ex) {
    final gc = context.gc;
    final routines = [
      for (final group in fit.routineGroups) ...fit.routinesInGroup(group),
      ...fit.routinesInGroup(''),
    ];
    void pick(BuildContext sheet, String? id) {
      Navigator.pop(sheet);
      fit.addToRoutineAndEdit(id, ex.id);
    }

    showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheet) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.72),
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
            SheetTitle(titleCase(t.addToRoutine)),
            const SizedBox(height: 4),
            Text(exerciseName(ex),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
            const SizedBox(height: 14),
            Flexible(
              child: OptionGroup(
                scroll: true,
                [
                  OptionItem(
                    t.newRoutineName,
                    icon: PhosphorIconsRegular.plus,
                    onTap: () => pick(sheet, null),
                  ),
                  for (final r in routines)
                    OptionItem(
                      fit.routineTitle(r),
                      detail: fit.routineHas(r.id, ex.id)
                          ? t.alreadyInRoutine
                          : (r.group.isEmpty ? null : r.group),
                      selected: fit.routineHas(r.id, ex.id),
                      onTap: () => pick(sheet, r.id),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _similarRow(GymColors gc, Exercise s) {
    return GestureDetector(
      onTap: () => fit.openExercise(s.id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.fromLTRB(12, 9, 14, 9),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              child: ExerciseMedia(ex: s, height: 48, radius: 14, bordered: false),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exerciseName(s),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 4),
                  Text(t.equipment(s.equipment),
                      style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ),
            ),
            SvgPathIcon(Ic.chevronRight, size: 15, color: gc.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _meta(GymColors gc, String label, String value) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardLabel(gc, label),
          const SizedBox(height: 5),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Exercise ex) async {
    final ok = await askConfirm(
      context,
      title: t.deleteExerciseTitle,
      body: t.deleteExerciseBody(exerciseName(ex)),
      confirmLabel: t.delete,
      danger: true,
    );
    if (!ok) return;
    fit.closeExerciseDetail();
    fit.deleteCustomExercise(ex.id);
  }

  void _toggleArchived(BuildContext context, Exercise ex) {
    fit.toggleArchived(ex.id);
    if (!fit.isArchived(ex.id)) return;
    showNotchToast(
      context,
      t.archivedToast,
      subtitle: t.archivedToastHint,
      icon: PhosphorIconsFill.archive,
      accent: context.gc.accent,
      action: t.undo,
      onTap: () => fit.toggleArchived(ex.id),
      duration: const Duration(milliseconds: 3600),
    );
  }

  Widget _archivedBanner(GymColors gc, Exercise ex) => Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        decoration: BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Icon(PhosphorIconsFill.archive, size: 17, color: gc.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(t.archivedBanner,
                style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.text, height: 1.35)),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => fit.toggleArchived(ex.id),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(t.restoreExercise,
                  style: AppTheme.f(13, weight: FontWeight.w700, color: gc.accent)),
            ),
          ),
        ]),
      );

  Widget _cardLabel(GymColors gc, String label) => FitText(label.toUpperCase(),
      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3));

  Widget _section(GymColors gc, String label) => Text(titleCase(label),
      style: AppTheme.f(18, weight: FontWeight.w700, color: gc.text));

  Widget _group(GymColors gc, List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i < rows.length - 1)
              Container(
                height: 1,
                margin: const EdgeInsets.only(left: 16),
                color: gc.border.withValues(alpha: 0.55),
              ),
          ],
        ],
      ),
    );
  }

  Widget _step(GymColors gc, int n, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: gc.emberSoft, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text('$n', style: AppTheme.f(12, weight: FontWeight.w700, color: gc.ember)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text,
              style: AppTheme.f(14, weight: FontWeight.w500, color: gc.textSecondary, height: 1.5)),
        ),
      ],
    );
  }

  Widget _star(GymColors gc, bool fav) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Stack(children: [
        if (fav)
          SvgPathIcon(const [IconPath('M12 2l3.09 6.26L22 9.27l-5 4.87L18.18 21 12 17.77 5.82 21 7 14.14l-5-4.87 6.91-1.01z', fill: true)], size: 18, color: gc.accent),
        SvgPathIcon(Ic.star, size: 18, color: fav ? gc.accent : gc.textSecondary),
      ]),
    );
  }

  Widget _restRow(GymColors gc, String id) {
    final custom = fit.hasCustomRest(id);
    final seconds = fit.restFor(id);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _rowIcon(gc, PhosphorIconsRegular.timer, custom),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titleCase(t.restForExercise),
                    style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                const SizedBox(height: 3),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: custom ? () => fit.setExerciseRest(id, null) : null,
                  child: Text(custom ? t.restCustom : t.restUsingDefault,
                      style: AppTheme.f(11.5,
                          weight: FontWeight.w500,
                          color: custom ? gc.accent : gc.textSecondary)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          StepperControl(
            value: seconds == 0 ? t.restOff : clockLabel(seconds),
            minWidth: 44,
            btnSize: 30,
            gap: 3,
            fontSize: 14,
            btnRadius: 10,
            onDec: () => fit.setExerciseRest(id, seconds - 15),
            onInc: () => fit.setExerciseRest(id, seconds + 15),
            onEdit: () async {
              final v = await askRuler(context,
                  title: t.restForExercise,
                  value: seconds.toDouble(),
                  min: 0,
                  max: 600,
                  step: 5,
                  majorEvery: 6,
                  format: (v) => clockLabel(v.round()),
                  tickLabel: (v) => clockLabel(v.round()));
              if (v != null) fit.setExerciseRest(id, v.round());
            },
          ),
        ],
      ),
    );
  }

  Widget _barRow(GymColors gc, Exercise ex) {
    final own = fit.hasOwnBar(ex.id);
    final bar = fit.barFor(ex.id, equipment: ex.equipment);
    final step = fit.weightStep;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _rowIcon(gc, PhosphorIconsRegular.barbell, own),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titleCase(t.barWeightExercise), style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                const SizedBox(height: 3),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: own ? () => fit.setExerciseBar(ex.id, null) : null,
                  child: Text(own ? t.barWeightCustom : t.barWeightHint,
                      style: AppTheme.f(11.5, weight: FontWeight.w500, color: own ? gc.accent : gc.textSecondary)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          StepperControl(
            value: '${fmt(bar)} ${fit.units}',
            minWidth: 56,
            btnSize: 30,
            gap: 3,
            fontSize: 14,
            btnRadius: 10,
            onDec: () => fit.setExerciseBar(ex.id, bar - step),
            onInc: () => fit.setExerciseBar(ex.id, bar + step),
            onEdit: () async {
              final v = await askNumber(context, title: t.barWeightExercise, initial: fmt(bar), decimal: true);
              if (v != null) fit.setExerciseBar(ex.id, v);
            },
          ),
        ],
      ),
    );
  }

  Widget _rowIcon(GymColors gc, IconData icon, bool on) => Padding(
        padding: const EdgeInsets.only(right: 14),
        child: SizedBox(
          width: 22,
          child: Icon(icon, size: 19, color: on ? gc.text : gc.textSecondary),
        ),
      );

  Widget _goalCard(BuildContext context, GymColors gc, String id) {
    final goal = fit.exerciseGoals[id];
    if (goal == null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _editGoal(context, id),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: gc.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(children: [
            Icon(PhosphorIconsRegular.target, size: 18, color: gc.textSecondary),
            const SizedBox(width: 12),
            Expanded(child: Text(t.goalSet, style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text))),
            Icon(PhosphorIconsRegular.plus, size: 15, color: gc.textTertiary),
          ]),
        ),
      );
    }
    final best = fit.goalBest(id);
    final done = best >= goal.target;
    final share = goal.target <= 0 ? 1.0 : (best / goal.target).clamp(0.0, 1.0);
    final due = goal.due;
    final today = DateTime.now();
    final days = due == null ? null : DateTime(due.year, due.month, due.day).difference(DateTime(today.year, today.month, today.day)).inDays;
    final when = done || due == null
        ? null
        : days! < 0
            ? t.goalOverdue
            : '${t.goalDaysLeft(days)} · ${t.shortDate(due)}';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _editGoal(context, id),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: done ? gc.ember : Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cardLabel(gc, t.goal),
                      const SizedBox(height: 8),
                      Text(fit.goalLabel(id, goal.target),
                          style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text, height: 1)),
                    ],
                  ),
                ),
                Text(done ? t.goalReached : t.goalToGo(fit.goalLabel(id, goal.target - best)),
                    style: AppTheme.f(12.5, weight: FontWeight.w600, color: done ? gc.ember : gc.textSecondary)),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: share,
                minHeight: 6,
                backgroundColor: gc.bgRaised2,
                valueColor: AlwaysStoppedAnimation(done ? gc.ember : gc.accent),
              ),
            ),
            if (when != null) ...[
              const SizedBox(height: 10),
              Text(when,
                  style: AppTheme.f(11.5,
                      weight: FontWeight.w500, color: days! < 0 ? gc.ember : gc.textTertiary)),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _editGoal(BuildContext context, String id) async {
    final reps = fit.goalKind(id) == PrKind.reps;
    final current = fit.exerciseGoals[id];
    final best = fit.goalBest(id);
    var target = current?.target ??
        (reps ? math.max(best + 5, 10.0) : fit.fromDisplayWeight(fit.toDisplayWeight(best) + fit.weightStep * 4));
    DateTime? due = current?.due;
    String shown() => reps ? '${target.round()}' : '${fit.weightValue(target)} ${fit.units}';
    await showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) => StatefulBuilder(
        builder: (sheet, setSheet) {
          final gc = sheet.gc;
          void bump(int dir) => setSheet(() {
                target = reps
                    ? math.max(1, target + dir).toDouble()
                    : math.max(0, target + dir * fit.fromDisplayWeight(fit.weightStep)).toDouble();
              });
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
                const SizedBox(height: 16),
                SheetTitle(titleCase(t.goal)),
                const SizedBox(height: 18),
                ToolGroup([
                  ToolRow(
                    label: reps ? t.goalTargetReps : t.targetWeight,
                    control: StepperControl(
                      value: shown(),
                      onDec: () => bump(-1),
                      onInc: () => bump(1),
                      onEdit: () async {
                        final v = await askNumber(sheet,
                            title: reps ? t.goalTargetReps : t.targetWeight,
                            initial: reps ? '${target.round()}' : fit.weightValue(target),
                            decimal: !reps);
                        if (v != null && v > 0) setSheet(() => target = reps ? v.roundToDouble() : fit.fromDisplayWeight(v));
                      },
                    ),
                  ),
                  ToolRow(
                    label: t.goalDeadline,
                    control: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: sheet,
                          initialDate: due ?? now.add(const Duration(days: 90)),
                          firstDate: now,
                          lastDate: now.add(const Duration(days: 365 * 3)),
                        );
                        if (picked != null) setSheet(() => due = picked);
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(due == null ? t.goalNoDeadline : t.shortDateYear(due!),
                            style: AppTheme.f(14, weight: FontWeight.w700, color: due == null ? gc.textTertiary : gc.text)),
                        if (due != null) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => setSheet(() => due = null),
                            child: Icon(PhosphorIconsRegular.x, size: 14, color: gc.textTertiary),
                          ),
                        ],
                      ]),
                    ),
                  ),
                ]),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: t.save,
                  onTap: () {
                    fit.setExerciseGoal(id, target, due);
                    Navigator.pop(sheet);
                  },
                ),
                if (current != null) ...[
                  const SizedBox(height: 6),
                  Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        fit.clearExerciseGoal(id);
                        Navigator.pop(sheet);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(t.goalRemove,
                            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _nextCard(GymColors gc, String id) {
    final target = fit.nextTarget(id)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: target.up ? gc.ember : gc.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SvgPathIcon(Ic.trendUp, size: 18, color: target.up ? gc.ember : gc.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.nextTime,
                    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3)),
                if (!target.up) ...[
                  const SizedBox(height: 2),
                  Text(t.nextHold, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(fit.nextTargetLabel(id)!,
              style: AppTheme.f(20, weight: FontWeight.w800, color: target.up ? gc.ember : gc.text)),
        ],
      ),
    );
  }

  Widget _switchRow(GymColors gc, IconData icon, String title, String hint, bool on,
      VoidCallback onTap) {
    return Semantics(
      button: true,
      toggled: on,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _rowIcon(gc, icon, on),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                    const SizedBox(height: 3),
                    Text(hint,
                        style: AppTheme.f(11.5,
                            weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              TinySwitch(on: on),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressRow(GymColors gc, String id) {
    final on = fit.hasProgress(id);
    final step = fit.weightLabel(fit.progressFor(id) ?? 0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Semantics(
            button: true,
            toggled: on,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => fit.toggleProgress(id),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: SizedBox(
                      width: 22,
                      child: SvgPathIcon(Ic.trendUp,
                          size: 19, color: on ? gc.text : gc.textSecondary),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.autoProgress,
                            style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                        const SizedBox(height: 3),
                        Text(
                            on
                                ? t.autoProgressHint(step)
                                : t.autoProgressHint(
                                    fit.weightLabel(fit.fromDisplayWeight(fit.weightStep))),
                            style: AppTheme.f(11.5,
                                weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  TinySwitch(on: on),
                ],
              ),
            ),
          ),
          if (on) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardLabel(gc, t.weightLabel),
                StepperControl(
                  value: step,
                  minWidth: 62,
                  btnSize: 30,
                  gap: 6,
                  fontSize: 14,
                  btnRadius: 10,
                  onDec: () => fit.bumpProgressStep(id, -1),
                  onInc: () => fit.bumpProgressStep(id, 1),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _repsOnlyRow(GymColors gc, String id, bool on) {
    return Semantics(
      button: true,
      toggled: on,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => fit.toggleRepsOnly(id),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _rowIcon(gc, PhosphorIconsRegular.scales, on),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.repsOnly,
                        style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                    const SizedBox(height: 3),
                    Text(t.repsOnlyHint,
                        style: AppTheme.f(11.5,
                            weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              TinySwitch(on: on),
            ],
          ),
        ),
      ),
    );
  }

  String _modeName(String mode) => switch (mode) {
        'cardio' => t.typeCardio,
        'time' => t.typeTime,
        _ => t.typeReps,
      };

  Widget _modeRow(BuildContext context, GymColors gc, String id, String mode) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _pickMode(context, id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _rowIcon(gc, mode == 'cardio' ? PhosphorIconsRegular.personSimpleRun : PhosphorIconsRegular.listNumbers,
                mode.isNotEmpty),
            Expanded(
              child: Text(t.exerciseTypeLabel,
                  style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
            ),
            Text(_modeName(mode), style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
            const SizedBox(width: 6),
            Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
          ],
        ),
      ),
    );
  }

  void _pickMode(BuildContext context, String id) {
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) => AnimatedBuilder(
        animation: fit,
        builder: (sheet, _) {
          final gc = sheet.gc;
          final now = fit.modeOf(id);
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
                const SizedBox(height: 16),
                SheetTitle(t.exerciseTypeLabel),
                const SizedBox(height: 14),
                OptionGroup([
                  for (final (value, icon) in [
                    ('', PhosphorIconsRegular.barbell),
                    ('time', PhosphorIconsRegular.timer),
                    ('cardio', PhosphorIconsRegular.personSimpleRun),
                  ])
                    OptionItem(
                      _modeName(value),
                      icon: icon,
                      selected: now == value,
                      onTap: () {
                        fit.setExerciseMode(id, value);
                        Navigator.of(sheet).pop();
                      },
                    ),
                ]),
                const SizedBox(height: 12),
                Text(t.exerciseTypeHint,
                    textAlign: TextAlign.center,
                    style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _mediaBtn(GymColors gc, IconData icon, String semantic, VoidCallback onTap) {
    return Semantics(
      button: true,
      label: semantic,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: gc.bg.withValues(alpha: 0.82),
            shape: BoxShape.circle,
            border: Border.all(color: gc.border),
          ),
          child: Icon(icon, size: 16, color: gc.text),
        ),
      ),
    );
  }
}
