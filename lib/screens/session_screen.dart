import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/live_session.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/celebration.dart';
import '../widgets/dialogs.dart';
import '../widgets/entrance.dart';
import '../widgets/exercise_media.dart';
import '../widgets/exercise_preview.dart';
import '../widgets/glass.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/set_kind.dart';
import '../widgets/share_cards.dart';
import '../widgets/rolling_text.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/svg_icon.dart';
import '../widgets/timer_panel.dart';
import '../widgets/ui_kit.dart';
import 'exercises_screen.dart';
import 'tool_detail_screen.dart';
import 'share_sheet.dart';
import 'sticker_screen.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: fit.isSessionComplete ? _complete(context, gc) : _active(context, gc),
      ),
    );
  }

  Widget _active(BuildContext context, GymColors gc) {
    final s = fit.session!;
    final ex = fit.currentExercise;
    final exIdx = s.currentIndex;
    final def = fit.exerciseById(ex?.id ?? '') ?? fit.allExercises.first;
    final repsOnly = ex != null && fit.isRepsOnly(ex.id);
    final locked = fit.sessionLocked && !s.manual;
    final demo = ex == null ? 'off' : fit.demoSize;
    final loops = fit.demoLoop == 'short' ? 6 : null;
    final mode = ex == null ? '' : fit.modeOf(ex.id);
    final second = _secondAction(gc, ex, exIdx, mode, repsOnly);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        s.manual ? _manualBar(context, gc, s) : _liveBar(gc, locked),
        const SizedBox(height: 14),
        _progressStrip(context, gc, s, locked),
        const SizedBox(height: 16),
        _ExerciseStage(
          index: exIdx,
          haptic: true,
          autoMoves: fit.autoMoves,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (demo == 'small')
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _exerciseHeader(context, gc, ex)),
                    const SizedBox(width: 14),
                    SizedBox(
                      width: 104,
                      child: _guard(
                        locked,
                        GestureDetector(
                          onTap: () => showExercisePreview(context, def),
                          child: ExerciseMedia(
                              ex: def, height: 104, radius: 18, live: true, loops: loops),
                        ),
                      ),
                    ),
                  ],
                )
              else
                _exerciseHeader(context, gc, ex),
              if (demo == 'large') ...[
                const SizedBox(height: 14),
                _guard(
                  locked,
                  GestureDetector(
                    onTap: () => showExercisePreview(context, def),
                    child: ExerciseMedia(ex: def, height: 170, live: true, loops: loops),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        AnimatedSize(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: fit.holding && fit.holdEx == exIdx
              ? Padding(padding: const EdgeInsets.only(bottom: 16), child: _holdCard(gc))
              : s.restRemaining != null
                  ? Padding(padding: const EdgeInsets.only(bottom: 16), child: _restCard(gc, s))
                  : const SizedBox(width: double.infinity),
        ),
        _ExerciseStage(
          index: exIdx,
          child: Container(
            padding: const EdgeInsets.fromLTRB(_cardPad, 16, _cardPad, 16),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(_rowPad, 0, _rowPad, 10),
                  child: _setsHeader(gc, mode, repsOnly),
                ),
                for (int j = 0; j < (ex?.sets.length ?? 0); j++) ...[
                  _swipeToDelete(context, gc, exIdx, j, ex!.sets[j], locked,
                      _setRow(gc, exIdx, j, ex.sets[j], repsOnly, locked)),
                ],
                if (!repsOnly && mode.isEmpty && ex != null) _guard(locked, _plateRow(context, gc, ex)),
                const SizedBox(height: 10),
                _guard(
                  locked,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _rowPad),
                    child: Row(
                      children: [
                        Expanded(child: _dashedAction(gc, t.addSet, () => fit.addSet(exIdx))),
                        if (second != null) ...[
                          const SizedBox(width: 8),
                          Expanded(child: second),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        _guard(
          locked,
          Row(
          children: [
            Expanded(
              child: GhostButton(
                label: t.addExercise,
                icon: PhosphorIconsRegular.plus,
                onTap: () => showAddToSessionSheet(context),
              ),
            ),
            const SizedBox(width: 10),
            Semantics(
              button: true,
              label: t.addNote,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => fit.openNoteEditor(exerciseId: ex?.id ?? ''),
                child: Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(PhosphorIconsRegular.notePencil, size: 17, color: gc.ember),
                ),
              ),
            ),
          ],
          ),
        ),
        const SizedBox(height: 16),
        Row(children: [
          _circleBtn(gc, Ic.chevronLeft, fit.prevExercise, enabled: !locked && exIdx > 0),
          const SizedBox(width: 10),
          Expanded(child: _mainAction(gc, ex, exIdx, s.exercises.length, locked)),
          const SizedBox(width: 10),
          _circleBtn(gc, Ic.chevronRightBold, fit.nextExercise,
              enabled: !locked && exIdx < s.exercises.length - 1),
        ]),
        const SizedBox(height: 10),
        _guard(
          locked,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (ex != null && s.exercises.length > 1) ...[
              Flexible(
                child: _textAction(gc, t.dropExerciseAction,
                    () => _confirmDrop(context, exIdx, t.catalogName(ex.id, ex.name))),
              ),
              Container(width: 1, height: 12, color: gc.border),
            ],
            Flexible(child: _textAction(gc, titleCase(t.finishSession), fit.finishSession)),
          ]),
        ),
      ],
    );
  }

  Widget? _secondAction(GymColors gc, SessionExercise? ex, int exIdx, String mode, bool repsOnly) {
    if (mode == 'cardio') return null;
    if (ex != null && repsOnly) {
      return _dashedAction(gc, t.addWeightAction.toUpperCase(), () => fit.toggleRepsOnly(ex.id));
    }
    if (mode.isNotEmpty) return null;
    if (fit.hasWarmup(exIdx)) {
      return _dashedAction(gc, t.removeWarmup.toUpperCase(), () => fit.removeWarmupSets(exIdx));
    }
    return _dashedAction(gc, t.addWarmup, () => fit.addWarmupSets(exIdx));
  }

  Widget _exerciseHeader(BuildContext context, GymColors gc, SessionExercise? ex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fit.inSuperset) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(PhosphorIconsRegular.link, size: 11, color: gc.brass),
              const SizedBox(width: 5),
              Text(t.superset,
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.brass, letterSpacing: 0.5)),
            ]),
          ),
          const SizedBox(height: 8),
        ],
        Text(ex == null ? '' : t.catalogName(ex.id, ex.name),
            style: AppTheme.f(26, weight: FontWeight.w700, color: gc.text)),
        const SizedBox(height: 8),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(100)),
            child: Text(muscleLabel(ex?.primary ?? ''),
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.ember)),
          ),
          if (ex != null && !fit.sessionPaused && fit.session?.manual != true) ...[
            const SizedBox(width: 8),
            Semantics(
              button: true,
              label: t.swapExercise,
              child: Pressable(
                scale: 0.94,
                onTap: () => showSwapExerciseSheet(context, fit.session!.currentIndex),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: gc.border),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(PhosphorIconsRegular.arrowsLeftRight, size: 12, color: gc.textSecondary),
                    const SizedBox(width: 5),
                    Text(t.swapShort, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
                  ]),
                ),
              ),
            ),
          ],
        ]),
        if (ex != null && fit.lastSummaryFor(ex.id) != null) ...[
          const SizedBox(height: 10),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => showExerciseHistorySheet(context, ex.id),
            child: Row(children: [
              Text(t.last,
                  style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.4)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(fit.lastSummaryFor(ex.id)!,
                    style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
              ),
              const SizedBox(width: 4),
              Icon(PhosphorIconsRegular.caretRight, size: 11, color: gc.textTertiary),
            ]),
          ),
          if (fit.nextTargetLabel(ex.id) != null) _nextRow(gc, ex.id),
        ],
      ],
    );
  }

  Widget _progressStrip(BuildContext context, GymColors gc, WorkoutSession s, bool locked) {
    final n = s.exercises.length;
    return Semantics(
      button: true,
      label: t.workoutOverview,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: locked ? null : () => showSessionOverview(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              Expanded(
                child: Text(fit.sessionProgressLabel,
                    style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
              ),
              if (!locked)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(PhosphorIconsRegular.listBullets, size: 14, color: gc.textSecondary),
                  const SizedBox(width: 5),
                  Text(t.allExercisesShort,
                      style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
                ]),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              for (var i = 0; i < n; i++) ...[
                if (i > 0) SizedBox(width: n > 12 ? 2 : 4),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    height: i == s.currentIndex ? 6 : 4,
                    decoration: BoxDecoration(
                      color: _stripColor(gc, s, i),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ]),
          ],
        ),
      ),
    );
  }

  Color _stripColor(GymColors gc, WorkoutSession s, int i) {
    final sets = s.exercises[i].sets;
    final done = sets.isNotEmpty && sets.every((st) => st.done);
    if (i == s.currentIndex) return done ? gc.sage : gc.ember;
    if (done) return gc.sage;
    if (sets.any((st) => st.done)) return Color.lerp(gc.bgRaised2, gc.sage, 0.45)!;
    return gc.bgRaised2;
  }

  Widget _swipeToDelete(BuildContext context, GymColors gc, int exIdx, int j, SessionSet st,
      bool locked, Widget child) {
    if (locked) return child;
    return Dismissible(
      key: ObjectKey(st),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.only(right: 18),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: gc.danger.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(PhosphorIconsRegular.trash, size: 18, color: gc.danger),
      ),
      onDismissed: (_) => _deleteSet(context, exIdx, j),
      child: child,
    );
  }

  void _deleteSet(BuildContext context, int exIdx, int j) {
    final gone = fit.removeSet(exIdx, j);
    if (gone == null) return;
    HapticFeedback.mediumImpact();
    showNotchToast(
      context,
      t.setDeleted,
      icon: PhosphorIconsFill.trash,
      accent: context.gc.danger,
      action: t.undo,
      onTap: () => fit.insertSet(exIdx, j, gone),
      duration: const Duration(milliseconds: 3200),
    );
  }

  Widget _guard(bool locked, Widget child) => _LockGuard(locked: locked, child: child);

  void _setLock(bool on) {
    if (fit.sessionLocked == on) return;
    HapticFeedback.mediumImpact();
    fit.toggleSessionLock();
  }

  Widget _nextRow(GymColors gc, String id) {
    final target = fit.nextTarget(id)!;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.nextTime,
              style: AppTheme.f(11, weight: FontWeight.w600, color: gc.brass, letterSpacing: 0.4)),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(builder: (context, box) {
              final main = TextSpan(
                text: fit.nextTargetLabel(id),
                style: AppTheme.f(12,
                    weight: FontWeight.w600, color: target.up ? gc.ember : gc.textSecondary),
              );
              if (target.up) return Text.rich(main);
              final holdStyle = AppTheme.f(11.5, weight: FontWeight.w400, color: gc.textTertiary);
              final both = TextSpan(children: [main, TextSpan(text: ' · ${t.nextHold}', style: holdStyle)]);
              final painter = TextPainter(
                text: both,
                textDirection: Directionality.of(context),
                textScaler: MediaQuery.textScalerOf(context),
                maxLines: 1,
              )..layout(maxWidth: box.maxWidth);
              final fits = !painter.didExceedMaxLines;
              painter.dispose();
              if (fits) return Text.rich(both);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(main),
                  const SizedBox(height: 2),
                  Text(t.nextHold, style: holdStyle),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDrop(BuildContext context, int exIdx, String name) async {
    final ok = await askConfirm(
      context,
      title: t.dropExercise,
      body: t.dropExerciseBody(name),
      confirmLabel: t.drop,
    );
    if (ok) fit.removeSessionExercise(exIdx);
  }

  static const _numCol = 26.0;
  static const _checkCol = 40.0;
  static const _gap = 10.0;
  static const _tightGap = 6.0;
  static const _effortCol = 36.0;
  static const _cardPad = 8.0;
  static const _rowPad = 14.0;

  Widget _setsHeader(GymColors gc, String mode, bool repsOnly) {
    final s = AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4);

    Widget label(String t) => FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(t, maxLines: 1, softWrap: false, style: s),
        );
    final effort = _showsEffort(mode);
    final gap = effort ? _tightGap : _gap;
    return Row(children: [
      SizedBox(width: _numCol, child: label(t.setCol)),
      for (final h in _headers(mode, repsOnly)) ...[
        SizedBox(width: gap),
        Expanded(child: label(h)),
      ],
      if (effort) ...[
        SizedBox(width: gap),
        SizedBox(width: _effortCol, child: label(fit.usesRir ? 'RIR' : 'RPE')),
      ],
      SizedBox(width: gap),
      const SizedBox(width: _checkCol),
    ]);
  }

  Widget _liveBar(GymColors gc, bool locked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (locked)
          Flexible(child: _lockedChip(gc))
        else
          Flexible(
            child: Row(children: [
              _stepOutButton(gc),
              const SizedBox(width: 10),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: fit.sessionPaused ? gc.textTertiary : gc.ember, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  fit.sessionPaused ? t.paused : t.inProgress,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(12,
                      weight: FontWeight.w600,
                      color: fit.sessionPaused ? gc.textTertiary : gc.ember,
                      letterSpacing: 0.4),
                ),
              ),
            ]),
          ),
        Row(children: [
          _ticking(() => RollingText(fit.elapsedLabel,
              style: AppTheme.f(18,
                  weight: FontWeight.w700, color: fit.sessionPaused ? gc.textSecondary : gc.text))),
          const SizedBox(width: 2),
          if (!locked)
            Semantics(
              button: true,
              label: t.lockWorkout,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _setLock(true),
                child: SizedBox(
                  width: 44,
                  height: 48,
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: gc.bgRaised2,
                        shape: BoxShape.circle,
                        border: Border.all(color: gc.border),
                      ),
                      child: Icon(PhosphorIconsRegular.fingerprint, size: 17, color: gc.text),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 2),
          _guard(
            locked,
            Semantics(
            button: true,
            label: fit.sessionPaused ? t.resumeWorkout : t.pauseWorkout,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: fit.toggleSessionPause,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: fit.sessionPaused ? gc.ember : gc.bgRaised2,
                      shape: BoxShape.circle,
                      border: Border.all(color: fit.sessionPaused ? gc.ember : gc.border),
                    ),
                    child: Icon(
                      fit.sessionPaused ? PhosphorIconsFill.play : PhosphorIconsFill.pause,
                      size: 16,
                      color: fit.sessionPaused ? gc.onEmber : gc.text,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ),
        ]),
      ],
    );
  }

  Widget _lockedChip(GymColors gc) => _HoldToUnlock(onUnlock: () => _setLock(false));

  Widget _stepOutButton(GymColors gc) => RoundAction(
        label: t.stepOutOfWorkout,
        onTap: fit.stepOutOfSession,
        child: Icon(PhosphorIconsBold.caretDown, size: 15, color: gc.text),
      );

  Widget _manualBar(BuildContext context, GymColors gc, WorkoutSession s) {
    final start = fit.manualStart ?? s.loggedAt ?? DateTime.now();
    final minutes = fit.manualMinutes;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        _stepOutButton(gc),
        const SizedBox(width: 12),
        Icon(PhosphorIconsRegular.calendarPlus, size: 15, color: gc.brass),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '${t.logging} · ${t.longDate(start)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.brass, letterSpacing: 0.6),
          ),
        ),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        _manualChip(
          gc,
          PhosphorIconsRegular.clock,
          TimeOfDay.fromDateTime(start).format(context),
          t.manualStartTime,
          () async {
            final v = await askRuler(context,
                title: t.manualStartTime,
                value: (start.hour * 60 + start.minute).toDouble(),
                min: 0,
                max: 24 * 60 - 5,
                step: 5,
                majorEvery: 12,
                format: (v) => TimeOfDay(hour: v.round() ~/ 60, minute: v.round() % 60).format(context),
                tickLabel: (v) => '${v.round() ~/ 60}');
            if (v != null) fit.setManualStart(v.round());
          },
        ),
        const SizedBox(width: 8),
        _manualChip(
          gc,
          PhosphorIconsRegular.timer,
          minutes == 0 ? t.manualDurationUnset : '$minutes min',
          t.manualDuration,
          () async {
            final v = await askRuler(context,
                title: t.manualDuration,
                value: (minutes == 0 ? 60 : minutes).toDouble(),
                min: 5,
                max: 240,
                step: 5,
                majorEvery: 6,
                format: (v) => '${v.round()} min',
                tickLabel: (v) => '${v.round()}');
            if (v != null) fit.setManualMinutes(v.round());
          },
        ),
      ]),
    ]);
  }

  Widget _manualChip(GymColors gc, IconData icon, String value, String label, VoidCallback onTap) => Semantics(
        button: true,
        label: label,
        child: Pressable(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: gc.border),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, size: 15, color: gc.brass),
              const SizedBox(width: 8),
              Text(value, style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
            ]),
          ),
        ),
      );

  List<Widget> _cells(GymColors gc, int exIdx, int j, SessionSet st, String mode, bool repsOnly) {
    final cardio = mode == 'cardio';
    Widget reps() => _miniStepper(
          gc,
          '${st.reps}',
          () => fit.bumpSessionReps(exIdx, j, -1),
          () => fit.bumpSessionReps(exIdx, j, 1),
          22,
          onEdit: (context) => _ruler(
            context,
            title: t.repsTitle,
            value: st.reps.toDouble(),
            max: 100,
            step: 1,
            majorEvery: 5,
            onSave: (v) => fit.setSessionReps(exIdx, j, v.round()),
          ),
        );
    Widget weight() => _miniStepper(
          gc,
          fit.weightValue(st.weight),
          () => fit.bumpSessionWeight(exIdx, j, -1),
          () => fit.bumpSessionWeight(exIdx, j, 1),
          26,
          onEdit: (context) => _ruler(
            context,
            title: t.weightTitle(fit.units.toUpperCase()),
            value: fit.toDisplayWeight(st.weight),
            max: fit.isLb ? 660 : 300,
            step: fit.isLb ? 1 : 0.5,
            majorEvery: 10,
            unit: fit.units,
            onSave: (v) => fit.setSessionWeightShown(exIdx, j, v),
          ),
        );
    Widget time() => _miniStepper(
          gc,
          durationLabel(st.sec ?? 0),
          () => fit.bumpSessionSeconds(exIdx, j, cardio ? -60 : -15),
          () => fit.bumpSessionSeconds(exIdx, j, cardio ? 60 : 15),
          34,
          onEdit: (context) => cardio
              ? _ruler(
                  context,
                  title: t.timeMinutesTitle,
                  value: ((st.sec ?? 0) / 60).roundToDouble(),
                  max: 300,
                  step: 1,
                  majorEvery: 5,
                  unit: 'min',
                  onSave: (v) => fit.setSessionSeconds(exIdx, j, (v * 60).round()),
                )
              : _ruler(
                  context,
                  title: t.timeSecondsTitle,
                  value: (st.sec ?? 0).toDouble(),
                  max: 900,
                  step: 5,
                  majorEvery: 6,
                  format: (v) => clockLabel(v.round()),
                  onSave: (v) => fit.setSessionSeconds(exIdx, j, v.round()),
                ),
        );
    Widget distance() => _miniStepper(
          gc,
          fit.distanceValue(st.km ?? 0),
          () => fit.bumpSessionDistance(exIdx, j, -1),
          () => fit.bumpSessionDistance(exIdx, j, 1),
          30,
          onEdit: (context) => _ruler(
            context,
            title: t.distanceTitle(fit.distanceUnit),
            value: fit.toDisplayKm(st.km ?? 0),
            max: 100,
            step: 0.1,
            majorEvery: 10,
            unit: fit.distanceUnit,
            onSave: (v) => fit.setSessionDistanceShown(exIdx, j, v),
          ),
        );
    return switch (mode) {
      'cardio' => [distance(), time()],
      'time' => [time(), if (!repsOnly) weight()],
      _ => [reps(), if (!repsOnly) weight()],
    };
  }

  List<String> _headers(String mode, bool repsOnly) => switch (mode) {
        'cardio' => [t.distanceCol(fit.distanceUnit.toUpperCase()), t.timeCol],
        'time' => [t.timeCol, if (!repsOnly) t.weightCol(fit.units.toUpperCase())],
        _ => [t.repsCol, if (!repsOnly) t.weightCol(fit.units.toUpperCase())],
      };

  Widget _setRow(GymColors gc, int exIdx, int j, SessionSet st, bool repsOnly, bool locked) {
    final mode = fit.modeOf(fit.session?.exercises[exIdx].id ?? '');
    return Builder(
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onLongPress: locked
            ? null
            : () {
                HapticFeedback.mediumImpact();
                _kindSheet(ctx, exIdx, j, st.kind);
              },
        child: _setRowBody(gc, exIdx, j, st, repsOnly, locked, mode),
      ),
    );
  }

  Widget _setRowBody(GymColors gc, int exIdx, int j, SessionSet st, bool repsOnly, bool locked, String mode) {
    final effort = _showsEffort(mode);
    final gap = effort ? _tightGap : _gap;
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: _rowPad, vertical: 10),
      decoration: BoxDecoration(
        color: st.done ? gc.sageSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        SizedBox(
          width: _numCol,
          child: Builder(
            builder: (ctx) => Semantics(
              button: true,
              label: t.setType,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: locked ? null : () => _kindSheet(ctx, exIdx, j, st.kind),
                child: _setBadge(gc, exIdx, j, st),
              ),
            ),
          ),
        ),
        for (final cell in _cells(gc, exIdx, j, st, mode, repsOnly)) ...[
          SizedBox(width: gap),
          Expanded(child: cell),
        ],
        if (effort) ...[
          SizedBox(width: gap),
          SizedBox(width: _effortCol, child: _effortCell(gc, exIdx, j, st, mode, locked)),
        ],
        SizedBox(width: gap),
        Semantics(
          button: true,
          checked: st.done,
          label: t.markSet(j + 1),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => fit.toggleSet(exIdx, j),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(
                child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: st.done ? gc.sage : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: st.done ? gc.sage : gc.textTertiary, width: 2),
                ),
                  child: st.done
                      ? Center(child: SvgPathIcon(Ic.checkBold, size: 14, color: Colors.white))
                      : null,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  bool _asksEffort(SessionExercise ex, int j, String mode) {
    if (!fit.logRpe || mode == 'cardio') return false;
    final st = ex.sets[j];
    return st.done && st.counts && st.rpe == null && ex.sets.lastIndexWhere((x) => x.done) == j;
  }

  bool _showsEffort(String mode) => fit.logRpe && mode != 'cardio';

  Widget _effortCell(GymColors gc, int exIdx, int j, SessionSet st, String mode, bool locked) {
    final ex = fit.session?.exercises[exIdx];
    final waiting = ex != null && _asksEffort(ex, j, mode);
    final rpe = st.rpe;
    return Builder(
      builder: (ctx) => Semantics(
        button: true,
        label: fit.usesRir ? 'RIR' : 'RPE',
        value: rpe == null ? null : fmt(fit.usesRir ? 10 - rpe : rpe),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: locked ? null : () => _editEffort(ctx, exIdx, j, rpe),
          child: SizedBox(
            height: 44,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: rpe == null ? Colors.transparent : gc.bgRaised2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: waiting ? gc.ember : (rpe == null ? gc.border : Colors.transparent),
                    width: waiting ? 1.6 : 1,
                  ),
                ),
                child: Text(
                  rpe == null ? '–' : fmt(fit.usesRir ? 10 - rpe : rpe),
                  style: AppTheme.f(14,
                      weight: FontWeight.w700, color: rpe == null ? gc.textTertiary : gc.text),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editEffort(BuildContext context, int exIdx, int j, double? rpe) async {
    final rir = fit.usesRir;
    final v = await askRuler(context,
        title: rir ? 'RIR' : 'RPE',
        value: rir ? 10 - (rpe ?? 8) : rpe ?? 8,
        min: rir ? 0 : 1,
        max: rir ? 9 : 10,
        step: 0.5,
        majorEvery: 2,
        format: (v) => fmt(v),
        hint: rir ? t.rirHint : t.rpeHint,
        clearLabel: rpe == null ? null : t.none);
    if (v == null) return;
    fit.setSessionRpe(exIdx, j, v.isNaN ? null : (rir ? 10 - v : v));
  }

  Widget _dashedAction(GymColors gc, String label, VoidCallback onTap) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label,
                maxLines: 1,
                style: AppTheme.f(13,
                    weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
          ),
        ),
      );

  Widget _plateRow(BuildContext context, GymColors gc, SessionExercise ex) {
    final exercise = fit.exerciseById(ex.id);
    if (exercise == null || ex.sets.isEmpty) return const SizedBox.shrink();
    final next = ex.sets.firstWhere((s) => !s.done, orElse: () => ex.sets.last);
    final hint = fit.plateHint(exercise.equipment, next.weight, id: ex.id);
    if (hint == null) return const SizedBox.shrink();

    return Semantics(
      button: true,
      label: t.toolTitle('plate'),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => showPlateSheet(context, fit.toDisplayWeight(next.weight),
            startBar: fit.barFor(ex.id, equipment: exercise.equipment)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(_rowPad, 8, _rowPad, 0),
          child: Row(
            children: [
              Icon(PhosphorIconsRegular.circlesThree, size: 13, color: gc.textTertiary),
              const SizedBox(width: 7),
              Expanded(
                child: Text(t.platesPerSide(hint),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
              ),
              const SizedBox(width: 6),
              Icon(PhosphorIconsRegular.caretRight, size: 12, color: gc.textTertiary),
            ],
          ),
        ),
      ),
    );
  }

  Color _kindColor(GymColors gc, SetKind kind) => setKindColor(gc, kind);

  Widget _setBadge(GymColors gc, int exIdx, int j, SessionSet st) {
    final sets = fit.session?.exercises[exIdx].sets ?? const <SessionSet>[];
    var working = 0;
    for (var i = 0; i <= j && i < sets.length; i++) {
      if (sets[i].counts) working++;
    }
    final tag = setKindTag(st.kind);
    final base = st.kind == SetKind.warmup
        ? tag
        : tag.isEmpty
            ? '$working'
            : '$working·$tag';
    final text = st.rpe == null || fit.logRpe ? base : '$base${fit.effortTag(st.rpe!)}';
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text,
          maxLines: 1,
          softWrap: false,
          style: AppTheme.f(16, weight: FontWeight.w700, color: _kindColor(gc, st.kind))),
    );
  }

  Future<void> _kindSheet(BuildContext context, int exIdx, int j, SetKind current) async {
    final gc = context.gc;
    await showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) => StatefulBuilder(
        builder: (sheet, setSheet) {
          final live = fit.session?.exercises[exIdx].sets[j];
          final kindNow = live?.kind ?? current;
          return Container(
            padding: sheetPad(sheet),
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
                  Text(t.setType,
                      style: AppTheme.f(12,
                          weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
                  const SizedBox(height: 12),
                  SetKindOptions(
                    current: kindNow,
                    onPick: (kind) => setSheet(() => fit.setSetKind(exIdx, j, kind)),
                  ),
                  const SizedBox(height: 18),
                  PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
                  const SizedBox(height: 4),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(sheet).pop();
                      _deleteSet(context, exIdx, j);
                    },
                    child: SizedBox(
                      height: 48,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(PhosphorIconsRegular.trash, size: 16, color: gc.danger),
                        const SizedBox(width: 8),
                        Text(t.deleteSet,
                            style: AppTheme.f(14, weight: FontWeight.w600, color: gc.danger)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _miniStepper(
    GymColors gc,
    String value,
    VoidCallback dec,
    VoidCallback inc,
    double minW, {
    required void Function(BuildContext) onEdit,
  }) {
    Widget b(String g, String semantic, VoidCallback t) => Semantics(
          button: true,
          label: semantic,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: t,
            child: SizedBox(
              width: 34,
              height: 44,
              child: Center(
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: Text(g, style: TextStyle(color: gc.text, fontSize: 17, height: 1)),
                ),
              ),
            ),
          ),
        );
    return Builder(
      builder: (context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            b('–', t.decrease, dec),
            const SizedBox(width: 3),
            GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onEdit(context),
            child: Container(
              constraints: BoxConstraints(minWidth: minW),
              padding: const EdgeInsets.symmetric(vertical: 4),
              alignment: Alignment.center,
              child: RollingText(value,
                  style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
            ),
          ),
          const SizedBox(width: 3),
          b('+', t.increase, inc),
        ],
        ),
      ),
    );
  }

  Future<void> _ruler(
    BuildContext context, {
    required String title,
    required double value,
    required double max,
    required double step,
    required void Function(double) onSave,
    int majorEvery = 10,
    String unit = '',
    String Function(double)? format,
  }) async {
    final v = await askRuler(context,
        title: title,
        value: value,
        min: 0,
        max: max,
        step: step,
        unit: unit,
        majorEvery: majorEvery,
        format: format,
        tickLabel: format);
    if (v != null) onSave(v);
  }

  Widget _ticking(Widget Function() build) =>
      ValueListenableBuilder<int>(valueListenable: fit.clock, builder: (_, _, _) => build());

  Widget _holdCard(GymColors gc) => _ticking(() => _holdPanel(gc));

  Widget _holdPanel(GymColors gc) {
    final count = fit.sessionSetCount;
    final lead = fit.holdLead;
    return TimerPanel(
      label: lead > 0 ? t.getReady : t.holdLabel,
      remaining: lead > 0 ? lead : fit.holdRemaining ?? 0,
      total: lead > 0 ? WorkoutState.holdLeadIn : fit.holdTotal,
      elapsed: fit.elapsedLabel,
      elapsedLabel: t.elapsedCaps,
      sets: '${count.done}/${count.total}',
      setsLabel: t.setsCaps,
      hint: fit.holdPaused ? t.holdPausedHint : t.tapToPause,
      color: gc.accent,
      onTap: fit.toggleHoldPause,
    );
  }

  Widget _restCard(GymColors gc, WorkoutSession s) => _ticking(() => _restPanel(gc, s));

  Widget _restPanel(GymColors gc, WorkoutSession s) {
    final count = fit.sessionSetCount;
    return TimerPanel(
      label: t.liveResting,
      remaining: s.restRemaining ?? 0,
      total: fit.restTotal,
      elapsed: fit.elapsedLabel,
      elapsedLabel: t.elapsedCaps,
      sets: '${count.done}/${count.total}',
      setsLabel: t.setsCaps,
      hint: t.tapToSkip,
      onTap: fit.skipRest,
      onMinus: () => fit.nudgeRest(-15),
      onPlus: () => fit.nudgeRest(15),
    );
  }

  Widget _mainAction(GymColors gc, SessionExercise? ex, int exIdx, int total, bool locked) {
    final pending = ex == null ? -1 : ex.sets.indexWhere((st) => !st.done);
    if (pending >= 0 && ex != null && fit.isTimed(ex.id)) {
      if (fit.holding && fit.holdEx == exIdx) {
        return _ticking(() => PrimaryButton(
              label: fit.holdPaused
                  ? t.finishHoldNow
                  : '${t.stopLabel} · ${durationLabel(fit.holdRemaining ?? 0)}',
              onTap: fit.holdPaused ? fit.completeHold : fit.stopHold,
              height: 56,
            ));
      }
      return PrimaryButton(
        label: t.startHold(durationLabel(ex.sets[pending].sec ?? 30)),
        icon: Ic.play,
        onTap: () => fit.startHold(exIdx, pending),
        height: 56,
      );
    }
    if (pending >= 0) {
      return PrimaryButton(label: t.setDone, onTap: () => fit.toggleSet(exIdx, pending), height: 56);
    }
    if (fit.pendingAfter(exIdx) != null) {
      return PrimaryButton(label: t.nextExercise, onTap: fit.goNextPending, height: 56);
    }
    if (exIdx < total - 1) {
      return _guard(
          locked, PrimaryButton(label: t.nextExercise, onTap: fit.nextExercise, height: 56));
    }
    return _guard(
        locked, PrimaryButton(label: t.finishSession, onTap: fit.finishSession, height: 56));
  }

  Widget _textAction(GymColors gc, String label, VoidCallback onTap) => Semantics(
        button: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Text(label,
                textAlign: TextAlign.center,
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
          ),
        ),
      );

  Widget _circleBtn(GymColors gc, List<IconPath> icon, VoidCallback onTap, {bool enabled = true}) {
    return Semantics(
      button: true,
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: enabled ? gc.bgRaised : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPathIcon(icon, size: 18, color: enabled ? gc.text : gc.textTertiary),
          ),
        ),
      ),
    );
  }

  Widget _complete(BuildContext context, GymColors gc) {
    final prs = fit.gamification ? fit.summaryPrs : 0;
    final streak = fit.currentStreak;
    final goalHit = fit.goalPct >= 100;
    final vsLast = fit.summaryVsLast;
    final vol = fit.summaryVolumeKg;
    final sets = fit.session?.summarySets ?? 0;
    final next = fit.nextRoutineToday;

    return _Celebrate(
      active: sets > 0 && fit.gamification,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Rise(index: 0, child: _finishHero(gc, prs: prs, streak: streak, goalHit: goalHit)),
            const SizedBox(height: 18),
            Rise(
              index: 1,
              child: Row(children: [
                Expanded(child: _sumCard(gc, t.duration, fit.summaryDurationLabel)),
                const SizedBox(width: 10),
                Expanded(child: _countUp(sets.toDouble(), (v) => _sumCard(gc, t.setsCaps, '${v.round()}'))),
                const SizedBox(width: 10),
                Expanded(child: _countUp(vol, (v) => _sumCard(gc, t.volume, fit.volumeLabel(v)))),
              ]),
            ),
            if (vsLast == null || vsLast > 0) ...[
              const SizedBox(height: 10),
              Rise(
                index: 2,
                child: vsLast != null ? _vsLastCard(gc, vol, vsLast) : _firstTimeCard(gc),
              ),
            ],
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: fit.summaryLevelUp == null
                  ? const SizedBox(width: double.infinity)
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Rise(index: 3, child: _levelUpCard(context, gc, fit.summaryLevelUp!)),
                    ),
            ),
            if (next != null) ...[
              const SizedBox(height: 18),
              Rise(index: 3, child: _nextRoutineCard(gc, next)),
            ],
            const SizedBox(height: 18),
            Rise(
              index: 3,
              child: Row(children: [
                Expanded(
                  child: next == null
                      ? PrimaryButton(label: t.done, onTap: fit.saveAndExit)
                      : PrimaryButton(label: t.done, bg: gc.bgRaised, fg: gc.text, onTap: fit.saveAndExit),
                ),
                const SizedBox(width: 10),
                Semantics(
                  button: true,
                  label: t.share,
                  child: GestureDetector(
                    onTap: () => showShareSheet(context, initial: ShareKind.streak),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
                      child: Icon(PhosphorIconsRegular.shareNetwork, size: 20, color: gc.text),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            Rise(
              index: 4,
              child: GhostButton(
                label: t.keepTraining,
                icon: PhosphorIconsRegular.arrowCounterClockwise,
                onTap: fit.continueSession,
              ),
            ),
            if (sets > 0 && fit.sessions.isNotEmpty) ...[
              const SizedBox(height: 10),
              Rise(
                index: 5,
                child: GhostButton(
                  label: t.stickerOpen,
                  icon: PhosphorIconsRegular.imageSquare,
                  onTap: () => showStickerEditor(context, fit.sessions.last, prs: prs),
                ),
              ),
            ],
            if (fit.sessionRoutine == null || fit.sessionEditedRoutine) ...[
              const SizedBox(height: 10),
              Rise(
                index: 6,
                child: GhostButton(
                  label: fit.sessionRoutine == null ? t.saveAsRoutine : t.saveToRoutine,
                  icon: PhosphorIconsRegular.listChecks,
                  onTap: () => _saveRoutine(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _nextRoutineCard(GymColors gc, Routine next) {
    final today = fit.routinesOn(DateTime.now());
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: gc.accent.withValues(alpha: 0.35), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.nextToday.toUpperCase(),
              style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.accent, letterSpacing: 1.4)),
          const SizedBox(height: 7),
          Text(fit.routineTitle(next),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text, height: 1.15)),
          const SizedBox(height: 5),
          Text(
              [
                t.exerciseCount(next.exerciseIds.length),
                if (today.length > 1) t.routineOfDay(today.indexOf(next) + 1, today.length),
              ].join(' · '),
              style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
          const SizedBox(height: 16),
          PrimaryButton(label: t.startWorkout, icon: Ic.play, height: 52, onTap: fit.startNextRoutine),
        ],
      ),
    );
  }

  Future<void> _saveRoutine(BuildContext context) async {
    final accent = context.gc.sage;
    final routine = fit.sessionRoutine;
    if (routine != null) {
      if (!await _confirmRoutineChanges(context, routine) || !context.mounted) return;
      fit.saveSessionIntoRoutine();
      showNotchToast(context, t.routineUpdated, icon: PhosphorIconsFill.listChecks, accent: accent);
      return;
    }
    final name = await askText(context, title: t.routineName, initial: t.newRoutineName);
    if (name == null || !context.mounted || fit.saveSessionAsRoutine(name).isEmpty) return;
    showNotchToast(context, t.savedAsRoutine, icon: PhosphorIconsFill.listChecks, accent: accent);
  }

  Future<bool> _confirmRoutineChanges(BuildContext context, Routine routine) async {
    final gc = context.gc;
    final changes = fit.sessionRoutineChanges;
    Widget row(IconData icon, Color color, String text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.16), shape: BoxShape.circle),
              child: Icon(icon, size: 13, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
            ),
          ]),
        );
    final ok = await showAppDialog<bool>(
      context: context,
      builder: (dctx) => appDialog(
        gc,
        title: Text(t.saveChangesTitle(fit.routineTitle(routine)),
            style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(dctx).height * 0.45),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.saveChangesBody,
                    style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
                const SizedBox(height: 12),
                for (final e in changes.added) row(PhosphorIconsBold.plus, gc.sage, exerciseName(e)),
                for (final e in changes.removed) row(PhosphorIconsBold.minus, gc.danger, exerciseName(e)),
                if (changes.reordered) row(PhosphorIconsBold.arrowsDownUp, gc.brass, t.routineOrderChanged),
              ],
            ),
          ),
        ),
        actions: [
          dialogAction(t.cancel, gc.textSecondary, () => Navigator.of(dctx).pop(false), strong: false),
          dialogAction(t.save, gc.accent, () => Navigator.of(dctx).pop(true)),
        ],
      ),
    );
    return ok ?? false;
  }

  Widget _countUp(double to, Widget Function(double v) builder) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: to),
        duration: const Duration(milliseconds: 1100),
        curve: Curves.easeOutCubic,
        builder: (context, v, _) => builder(v),
      );

  Widget _finishHero(GymColors gc, {required int prs, required int streak, required bool goalHit}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: gc.bgRaised,

          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -45,
              bottom: -45,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              right: -14,
              top: -6,
              bottom: -6,
              child: Opacity(
                opacity: 0.45,
                child: Image.asset('assets/img/runner.png', fit: BoxFit.fitHeight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(t.sessionComplete.toUpperCase(),
                        style: AppTheme.f(11, weight: FontWeight.w600, color: gc.brass, letterSpacing: 1.4)),
                    if (prs > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration:
                            BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(100)),
                        child: Text(t.prCount(prs),
                            style: AppTheme.f(10, weight: FontWeight.w700, color: gc.accent)),
                      ),
                    ],
                  ]),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 210),
                    child: Text(t.finishHeadline(prs: prs, streak: streak, goalHit: goalHit),
                        style: AppTheme.f(28, weight: FontWeight.w700, color: gc.text, height: 1.05)),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 230),
                    child: Text(t.finishBody(prs: prs, streak: streak, goalHit: goalHit),
                        style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vsLastCard(GymColors gc, double now, double before) {
    final diff = now - before;
    final up = diff >= 0;
    final pct = ((diff / before) * 100).round();
    return SoftCard(
      radius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        SvgPathIcon(Ic.trendUp, size: 16, color: up ? gc.sage : gc.textTertiary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(t.vsLastTime,
              style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
        ),
        Text('${up ? '+' : ''}$pct%',
            style: AppTheme.f(16, weight: FontWeight.w700, color: up ? gc.sage : gc.textSecondary)),
      ]),
    );
  }

  Widget _levelUpCard(BuildContext context, GymColors gc, ({Exercise from, Exercise to, int reps}) level) {
    final inRoutine = fit.levelUpInRoutine;
    Widget link(String label, VoidCallback onTap) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Text(label, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
          ),
        );
    return SoftCard(
      radius: 20,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Semantics(
              button: true,
              label: t.levelUpSee,
              child: GestureDetector(
                onTap: () => showExercisePreview(context, level.to),
                child: SizedBox(width: 64, child: ExerciseMedia(ex: level.to, height: 64, radius: 14)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(PhosphorIconsBold.trendUp, size: 13, color: gc.sage),
                  const SizedBox(width: 6),
                  Text(t.levelUpKicker,
                      style: AppTheme.f(10.5, weight: FontWeight.w800, color: gc.sage, letterSpacing: 1.3)),
                ]),
                const SizedBox(height: 4),
                Text(exerciseName(level.to),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
                const SizedBox(height: 3),
                Text(t.levelUpBody(level.reps, exerciseName(level.from)),
                    style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
              ]),
            ),
          ]),
          const SizedBox(height: 12),
          Pressable(
            onTap: () {
              if (!inRoutine) {
                showExercisePreview(context, level.to);
                return;
              }
              final name = exerciseName(level.to);
              final routine = fit.levelUpSwap();
              if (routine == null) return;
              HapticFeedback.lightImpact();
              showNotchToast(context, t.levelUpSwapped(name, routine),
                  icon: PhosphorIconsFill.checkCircle, accent: gc.sage);
            },
            child: Container(
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: gc.sageSoft, borderRadius: BorderRadius.circular(100)),
              child: Text(inRoutine ? t.levelUpSwap(fit.routineTitle(fit.sessionRoutine!)) : t.levelUpSee,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w700, color: gc.sage)),
            ),
          ),
          const SizedBox(height: 2),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            link(t.levelUpLater, fit.levelUpLater),
            Text('·', style: AppTheme.f(13, color: gc.textTertiary)),
            link(t.levelUpStay, () {
              final undo = fit.levelUpStay();
              if (undo == null) return;
              showNotchToast(context, t.levelUpStayed,
                  icon: PhosphorIconsRegular.bellSlash,
                  accent: gc.accent,
                  action: t.undo,
                  onTap: undo,
                  duration: const Duration(milliseconds: 3600));
            }),
          ]),
        ],
      ),
    );
  }

  Widget _firstTimeCard(GymColors gc) {
    return SoftCard(
      radius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        SvgPathIcon(Ic.flame, size: 16, color: gc.accent),
        const SizedBox(width: 12),
        Expanded(child: Text(t.firstTime, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary))),
      ]),
    );
  }

  Widget _sumCard(GymColors gc, String label, String value) {
    return SoftCard(
      radius: 16,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitText(label,
              style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
          const SizedBox(height: 4),
          FitText(value, style: AppTheme.f(18, weight: FontWeight.w700, color: gc.text)),
        ],
      ),
    );
  }
}

void showAddToSessionSheet(BuildContext context) {
  final gc = context.gc;
  final search = TextEditingController();
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: gc.bgRaised,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (sheetCtx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(sheetCtx).viewInsets.bottom),
      child: StatefulBuilder(
        builder: (sheetCtx, setSheet) {
          final q = search.text.trim();
          final list = q.isEmpty ? fit.sessionSuggestions() : fit.trainSearchResults(q);
          return SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(sheetCtx).size.height * 0.82),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(t.addExercise,
                            style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text, letterSpacing: 0.4)),
                        const SizedBox(height: 14),
                        SearchField(
                          controller: search,
                          hint: t.searchExercises,
                          color: gc.bgRaised2,
                          onChanged: (_) => setSheet(() {}),
                        ),
                        const SizedBox(height: 12),
                        Text(q.isEmpty ? t.suggested.toUpperCase() : t.results.toUpperCase(),
                            style: AppTheme.f(11,
                                weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                      shrinkWrap: true,
                      children: [
                        if (list.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Text(t.noMatches, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                          ),
                        for (final ex in list) _addRow(sheetCtx, gc, ex),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 18),
                    child: GhostButton(
                      label: t.newExercise,
                      icon: PhosphorIconsRegular.plus,
                      onTap: () {
                        Navigator.pop(sheetCtx);
                        showCreateExerciseSheet(context, initialName: q, onCreated: fit.addExerciseToSession);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

void showSwapExerciseSheet(BuildContext context, int exIdx) {
  final gc = context.gc;
  final from = fit.session?.exercises[exIdx];
  if (from == null) return;
  final search = TextEditingController();
  final started = from.sets.any((st) => st.done);
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: gc.bgRaised,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (sheetCtx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(sheetCtx).viewInsets.bottom),
      child: StatefulBuilder(
        builder: (sheetCtx, setSheet) {
          final q = search.text.trim();
          final list = q.isEmpty
              ? fit.swapOptions(from.id)
              : fit.trainSearchResults(q).where((e) => !fit.inSession(e.id)).toList();
          void pick(Exercise ex) {
            Navigator.pop(sheetCtx);
            fit.swapSessionExercise(exIdx, ex.id);
          }

          return SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(sheetCtx).size.height * 0.82),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(titleCase(t.swapExercise),
                            style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
                        const SizedBox(height: 4),
                        Text(started ? t.swapKeepsDone : t.swapHint(t.catalogName(from.id, from.name)),
                            style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                        const SizedBox(height: 14),
                        SearchField(
                          controller: search,
                          hint: t.searchExercises,
                          color: gc.bgRaised2,
                          onChanged: (_) => setSheet(() {}),
                        ),
                        const SizedBox(height: 12),
                        Text(q.isEmpty ? t.swapSameMuscle(muscleLabel(from.primary)).toUpperCase() : t.results.toUpperCase(),
                            style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
                      shrinkWrap: true,
                      children: [
                        if (list.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Text(t.noMatches,
                                style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                          ),
                        for (final ex in list) _swapRow(sheetCtx, gc, ex, () => pick(ex)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget _swapRow(BuildContext sheetCtx, GymColors gc, Exercise ex, VoidCallback onTap) {
  final away = !fit.fitsHere(ex);
  final detail = [
    t.equipment(ex.equipment),
    if (fit.lastSetsFor(ex.id).isNotEmpty) t.swapDoneBefore,
  ].join(' · ');
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Pressable(
      scale: 0.98,
      onTap: onTap,
      onLongPress: () => showExercisePreview(sheetCtx, ex),
      child: Opacity(
        opacity: away ? 0.55 : 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            GestureDetector(
              onTap: () => showExercisePreview(sheetCtx, ex),
              child: SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 10)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exerciseName(ex),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ),
            ),
            if (fit.favorites[ex.id] == true) ...[
              Icon(PhosphorIconsFill.star, size: 13, color: gc.accent),
              const SizedBox(width: 8),
            ],
            Icon(PhosphorIconsRegular.arrowsLeftRight, size: 15, color: gc.textSecondary),
          ]),
        ),
      ),
    ),
  );
}

Widget _addRow(BuildContext sheetCtx, GymColors gc, Exercise ex) {
  final already = fit.inSession(ex.id);
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: already
          ? null
          : () {
              fit.addExerciseToSession(ex.id);
              Navigator.pop(sheetCtx);
            },
      onLongPress: () => showExercisePreview(sheetCtx, ex),
      child: Opacity(
        opacity: already ? 0.45 : 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: gc.bgRaised2,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: [
            GestureDetector(
              onTap: () => showExercisePreview(sheetCtx, ex),
              child: SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 10)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exerciseName(ex),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(muscleLabel(ex.primary), style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ),
            ),
            Icon(already ? PhosphorIconsRegular.check : PhosphorIconsRegular.plus,
                size: 16, color: gc.textSecondary),
          ]),
        ),
      ),
    ),
  );
}

class _ExerciseStage extends StatefulWidget {
  const _ExerciseStage({required this.index, required this.child, this.haptic = false, this.autoMoves});

  final int index;
  final Widget child;
  final bool haptic;
  final int? autoMoves;

  @override
  State<_ExerciseStage> createState() => _ExerciseStageState();
}

class _ExerciseStageState extends State<_ExerciseStage> {
  double _dir = 1;

  @override
  void didUpdateWidget(_ExerciseStage old) {
    super.didUpdateWidget(old);
    if (old.index == widget.index) return;
    _dir = widget.index > old.index ? 1 : -1;
    if (!widget.haptic) return;
    HapticFeedback.selectionClick();
    if (widget.autoMoves != old.autoMoves) _announce();
  }

  void _announce() {
    final ex = fit.currentExercise;
    if (ex == null) return;
    final gc = context.gc;
    final where = fit.inSuperset ? '${t.superset} · ${fit.sessionProgressLabel}' : fit.sessionProgressLabel;
    HapticFeedback.mediumImpact();
    showNotchToast(context, t.catalogName(ex.id, ex.name),
        subtitle: where,
        icon: fit.inSuperset ? PhosphorIconsBold.link : PhosphorIconsBold.arrowRight,
        accent: fit.inSuperset ? gc.brass : gc.ember,
        duration: const Duration(milliseconds: 1900));
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.index;
    final dir = _dir;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 520),
      switchInCurve: const Interval(0.3, 1, curve: Curves.easeOutCubic),
      switchOutCurve: const Interval(0.55, 1, curve: Curves.easeInCubic),
      transitionBuilder: (child, animation) {
        final incoming = (child.key as ValueKey?)?.value == current;
        final from = Offset(incoming ? 0.5 * dir : -0.5 * dir, 0);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(begin: from, end: Offset.zero).animate(animation),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.94, end: 1).animate(animation),
              child: child,
            ),
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topCenter,
        children: [
          ...previousChildren,
          ?currentChild,
        ],
      ),
      child: KeyedSubtree(key: ValueKey(current), child: widget.child),
    );
  }
}

void showSessionOverview(BuildContext context) {
  final gc = context.gc;
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => AnimatedBuilder(
      animation: fit,
      builder: (sheet, _) {
        final s = fit.session;
        if (s == null || s.complete) return const SizedBox.shrink();
        return Container(
          padding: sheetPad(sheet),
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.86),
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
              Text(titleCase(t.workoutOverview),
                  style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
              const SizedBox(height: 4),
              ValueListenableBuilder<int>(
                valueListenable: fit.clock,
                builder: (_, _, _) => Text('${t.exerciseCount(s.exercises.length)} · ${fit.elapsedLabel}',
                    style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  buildDefaultDragHandles: false,
                  itemCount: s.exercises.length,
                  onReorder: fit.reorderSessionExercise,
                  onReorderStart: reorderPicked,
                  onReorderEnd: reorderDropped,
                  proxyDecorator: liftedRow(16),
                  itemBuilder: (context, i) => _overviewRow(sheet, gc, s, i),
                ),
              ),
              const SizedBox(height: 6),
              Text(t.dragToReorder,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary)),
            ],
          ),
        );
      },
    ),
  );
}

Widget _overviewRow(BuildContext sheet, GymColors gc, WorkoutSession s, int i) {
  final e = s.exercises[i];
  final def = fit.exerciseById(e.id);
  final done = e.sets.where((st) => st.done).length;
  final all = e.sets.isNotEmpty && done == e.sets.length;
  final current = i == s.currentIndex;
  final linked = e.linkedNext || (i > 0 && s.exercises[i - 1].linkedNext);
  return Container(
    key: ObjectKey(e),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: current ? gc.bgRaised2 : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
          color: current ? gc.ember.withValues(alpha: 0.6) : gc.border.withValues(alpha: 0.6)),
    ),
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        fit.goToExercise(i);
        Navigator.of(sheet).pop();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 4, 8),
        child: Row(children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: all ? gc.sage : (current ? gc.ember : gc.bgRaised2),
              shape: BoxShape.circle,
            ),
            child: all
                ? SvgPathIcon(Ic.checkBold, size: 12, color: Colors.white)
                : Text('${i + 1}',
                    style: AppTheme.f(11.5,
                        weight: FontWeight.w700, color: current ? gc.onEmber : gc.textSecondary)),
          ),
          const SizedBox(width: 10),
          if (def != null) ...[
            SizedBox(width: 40, child: ExerciseMedia(ex: def, height: 40, radius: 10, bordered: false)),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.catalogName(e.id, e.name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 2),
                Row(children: [
                  Text(t.setsDoneOf(done, e.sets.length),
                      style: AppTheme.f(11.5,
                          weight: FontWeight.w500, color: all ? gc.sage : gc.textSecondary)),
                  if (current) ...[
                    Text(' · ', style: AppTheme.f(11.5, color: gc.textTertiary)),
                    Text(t.nowLabel,
                        style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.ember)),
                  ],
                  if (linked) ...[
                    const SizedBox(width: 6),
                    Icon(PhosphorIconsRegular.link, size: 12, color: gc.brass),
                  ],
                ]),
              ],
            ),
          ),
          ReorderableDragStartListener(
            index: i,
            child: SizedBox(
              width: 40,
              height: 44,
              child: Icon(PhosphorIconsRegular.dotsSixVertical, size: 18, color: gc.textTertiary),
            ),
          ),
        ]),
      ),
    ),
  );
}

void showExerciseHistorySheet(BuildContext context, String exerciseId) {
  final gc = context.gc;
  final history = fit.exerciseHistory(exerciseId).take(8).toList();
  final ex = fit.exerciseById(exerciseId);
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => Container(
      padding: sheetPad(sheet),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.8),
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
            Text(ex == null ? '' : exerciseName(ex),
                style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
            const SizedBox(height: 4),
            Text(titleCase(t.history),
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
            const SizedBox(height: 14),
            if (history.isEmpty)
              Text(t.noHistory, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
            for (var i = 0; i < history.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: i < history.length - 1
                      ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.55)))
                      : null,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 92,
                      child: Text(t.shortDate(history[i].date),
                          style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text)),
                    ),
                    Expanded(
                      child: Text(fit.setsSummary(history[i].ex.sets),
                          style: AppTheme.f(12.5,
                              weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

void _showLockHint(BuildContext context) {
  HapticFeedback.heavyImpact();
  showNotchToast(
    context,
    t.screenLocked,
    subtitle: t.lockedHint,
    icon: PhosphorIconsFill.fingerprint,
    accent: context.gc.accent,
  );
}

class _LockGuard extends StatefulWidget {
  const _LockGuard({required this.locked, required this.child});

  final bool locked;
  final Widget child;

  @override
  State<_LockGuard> createState() => _LockGuardState();
}

class _LockGuardState extends State<_LockGuard> {
  DateTime? _last;
  int _taps = 0;

  void _tap() {
    final now = DateTime.now();
    if (_last == null || now.difference(_last!) > const Duration(milliseconds: 1500)) _taps = 0;
    _last = now;
    if (++_taps >= 2) {
      _taps = 0;
      _showLockHint(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.locked ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: widget.locked ? _tap : null,
      child: IgnorePointer(
        ignoring: widget.locked,
        child: AnimatedOpacity(
          opacity: widget.locked ? 0.35 : 1,
          duration: const Duration(milliseconds: 220),
          child: widget.child,
        ),
      ),
    );
  }
}

class _HoldToUnlock extends StatefulWidget {
  const _HoldToUnlock({required this.onUnlock});

  final VoidCallback onUnlock;

  @override
  State<_HoldToUnlock> createState() => _HoldToUnlockState();
}

class _HoldToUnlockState extends State<_HoldToUnlock> with SingleTickerProviderStateMixin {
  late final AnimationController _hold = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
    reverseDuration: const Duration(milliseconds: 220),
  )..addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        HapticFeedback.mediumImpact();
        widget.onUnlock();
      }
    });
  DateTime? _last;
  int _taps = 0;

  void _down() {
    HapticFeedback.selectionClick();
    _hold.forward();
  }

  void _up() {
    if (_hold.isCompleted) return;
    _hold.reverse();
    final now = DateTime.now();
    if (_last == null || now.difference(_last!) > const Duration(milliseconds: 1500)) _taps = 0;
    _last = now;
    if (++_taps >= 2) {
      _taps = 0;
      _showLockHint(context);
    }
  }

  @override
  void dispose() {
    _hold.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      label: t.unlockWorkout,
      hint: t.holdToUnlock,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _down(),
        onTapUp: (_) => _up(),
        onTapCancel: _up,
        child: AnimatedBuilder(
          animation: _hold,
          builder: (context, _) {
            final v = _hold.value;
            return Transform.scale(
              scale: 1 - 0.04 * v,
              child: Container(
                padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),
                decoration: BoxDecoration(
                  color: gc.emberSoft,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: Stack(alignment: Alignment.center, children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: v,
                          strokeWidth: 2.4,
                          strokeCap: StrokeCap.round,
                          color: gc.ember,
                          backgroundColor: gc.ember.withValues(alpha: 0.15),
                        ),
                      ),
                      Icon(PhosphorIconsFill.fingerprint, size: 14, color: gc.ember),
                    ]),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      t.holdToUnlock,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(12, weight: FontWeight.w800, color: gc.ember),
                    ),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Celebrate extends StatefulWidget {
  const _Celebrate({required this.active, required this.child});

  final bool active;
  final Widget child;

  @override
  State<_Celebrate> createState() => _CelebrateState();
}

class _CelebrateState extends State<_Celebrate> {
  static Object? _shownFor;

  @override
  void initState() {
    super.initState();
    final s = fit.session;
    if (!widget.active || s == null || identical(_shownFor, s)) return;
    _shownFor = s;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final gc = context.gc;
      celebrate(context, colors: [gc.accent, gc.brass, gc.sage, gc.text]);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
