import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/live_session.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/exercise_media.dart';
import '../widgets/share_cards.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';
import 'exercises_screen.dart';
import 'tool_detail_screen.dart';
import 'share_sheet.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        s.manual ? _manualBar(gc, s) : _liveBar(gc),
        const SizedBox(height: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(fit.sessionProgressLabel,
                  style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
              if (fit.inSuperset) ...[
                const SizedBox(width: 8),
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
              ],
            ]),
            const SizedBox(height: 4),
            Text(ex == null ? '' : t.catalogName(ex.id, ex.name), style: AppTheme.f(26, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(100)),
              child: Text(muscleLabel(ex?.primary ?? ''),
                  style: AppTheme.f(12, weight: FontWeight.w600, color: gc.ember)),
            ),
            if (ex != null && fit.lastSummaryFor(ex.id) != null) ...[
              const SizedBox(height: 10),
              Row(children: [
                Text(t.last,
                    style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.4)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(fit.lastSummaryFor(ex.id)!,
                      style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
                ),
              ]),
              if (fit.nextTargetLabel(ex.id) != null) _nextRow(gc, ex.id),
            ],
          ],
        ),
        const SizedBox(height: 14),
        if (ex != null) ExerciseMedia(ex: def, height: 170, live: true),
        const SizedBox(height: 18),
        if (s.restRemaining != null) ...[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                _restNudge(gc, '−15', t.decrease, () => fit.nudgeRest(-15)),
                Expanded(
                  child: Column(
                    children: [
                      Text(t.rest.toUpperCase(),
                          style: AppTheme.f(9.5,
                              weight: FontWeight.w700,
                              color: gc.textTertiary,
                              letterSpacing: 1.5)),
                      const SizedBox(height: 3),
                      Text('${s.restRemaining}s',
                          style: AppTheme.f(30, weight: FontWeight.w800, color: gc.text)),
                    ],
                  ),
                ),
                _restNudge(gc, '+15', t.increase, () => fit.nudgeRest(15)),
                const SizedBox(width: 4),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: fit.skipRest,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                    decoration:
                        BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
                    child: Text(titleCase(t.skip),
                        style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        Container(
          padding: const EdgeInsets.fromLTRB(_cardPad, 16, _cardPad, 16),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(_rowPad, 0, _rowPad, 10),
                child: _setsHeader(gc, repsOnly),
              ),
              for (int j = 0; j < (ex?.sets.length ?? 0); j++)
                _setRow(gc, exIdx, j, ex!.sets[j], repsOnly),
              if (!repsOnly && ex != null) _plateRow(context, gc, ex),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _rowPad),
                child: Row(
                  children: [
                    Expanded(child: _dashedAction(gc, t.addSet, () => fit.addSet(exIdx))),
                    if (!repsOnly && !fit.hasWarmup(exIdx)) ...[
                      const SizedBox(width: 8),
                      Expanded(
                          child: _dashedAction(
                              gc, t.addWarmup, () => fit.addWarmupSets(exIdx))),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
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
        const SizedBox(height: 16),
        Row(children: [
          _circleBtn(gc, Ic.chevronLeft, fit.prevExercise, enabled: exIdx > 0),
          const SizedBox(width: 10),
          Expanded(child: _mainAction(gc, ex, exIdx, s.exercises.length)),
          const SizedBox(width: 10),
          _circleBtn(gc, Ic.chevronRightBold, () => _goNext(context, ex),
              enabled: exIdx < s.exercises.length - 1),
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (ex != null && s.exercises.length > 1) ...[
            _textAction(gc, t.dropExerciseAction,
                () => _confirmDrop(context, exIdx, t.catalogName(ex.id, ex.name))),
            Container(width: 1, height: 12, color: gc.border),
          ],
          _textAction(gc, t.finishSession, fit.finishSession),
        ]),
      ],
    );
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
            child: RichText(
              text: TextSpan(
                text: fit.nextTargetLabel(id),
                style: AppTheme.f(12,
                    weight: FontWeight.w600, color: target.up ? gc.ember : gc.textSecondary),
                children: [
                  if (!target.up)
                    TextSpan(
                        text: ' · ${t.nextHold}',
                        style: AppTheme.f(11.5, weight: FontWeight.w400, color: gc.textTertiary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _restNudge(GymColors gc, String glyph, String semantic, VoidCallback onTap) {
    return Semantics(
      button: true,
      label: semantic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(8)),
              child: Text(glyph, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.text)),
            ),
          ),
        ),
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
  static const _cardPad = 8.0;
  static const _rowPad = 14.0;

  Widget _setsHeader(GymColors gc, bool repsOnly) {
    final s = AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4);

    Widget label(String t) => FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(t, maxLines: 1, softWrap: false, style: s),
        );
    return Row(children: [
      SizedBox(width: _numCol, child: label(t.setCol)),
      const SizedBox(width: _gap),
      Expanded(child: label(t.repsCol)),
      if (!repsOnly) ...[
        const SizedBox(width: _gap),
        Expanded(child: label(t.weightCol(fit.units.toUpperCase()))),
      ],
      const SizedBox(width: _gap),
      const SizedBox(width: _checkCol),
    ]);
  }

  Widget _liveBar(GymColors gc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: fit.sessionPaused ? gc.textTertiary : gc.ember, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            fit.sessionPaused ? t.paused : t.inProgress,
            style: AppTheme.f(12,
                weight: FontWeight.w600,
                color: fit.sessionPaused ? gc.textTertiary : gc.ember,
                letterSpacing: 0.4),
          ),
        ]),
        Row(children: [
          Text(fit.elapsedLabel,
              style: AppTheme.f(18,
                  weight: FontWeight.w700, color: fit.sessionPaused ? gc.textSecondary : gc.text)),
          const SizedBox(width: 10),
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
        ]),
      ],
    );
  }

  Widget _manualBar(GymColors gc, WorkoutSession s) {
    return Row(children: [
      Icon(PhosphorIconsRegular.calendarPlus, size: 15, color: gc.brass),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          '${t.logging} · ${t.longDate(s.loggedAt ?? DateTime.now())}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.brass, letterSpacing: 0.6),
        ),
      ),
    ]);
  }

  Widget _setRow(GymColors gc, int exIdx, int j, SessionSet st, bool repsOnly) {
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
                onTap: () => _kindSheet(ctx, exIdx, j, st.kind),
                child: _setBadge(gc, exIdx, j, st),
              ),
            ),
          ),
        ),
        const SizedBox(width: _gap),
        Expanded(
          child: _miniStepper(
            gc,
            '${st.reps}',
            () => fit.bumpSessionReps(exIdx, j, -1),
            () => fit.bumpSessionReps(exIdx, j, 1),
            22,
            onEdit: (context) => _editValue(
              context,
              title: t.repsTitle,
              initial: '${st.reps}',
              decimal: false,
              onSave: (v) => fit.setSessionReps(exIdx, j, v.round()),
            ),
          ),
        ),
        if (!repsOnly) ...[
          const SizedBox(width: _gap),
          Expanded(
            child: _miniStepper(
              gc,
              fit.weightValue(st.weight),
              () => fit.bumpSessionWeight(exIdx, j, -1),
              () => fit.bumpSessionWeight(exIdx, j, 1),
              26,
              onEdit: (context) => _editValue(
                context,
                title: t.weightTitle(fit.units.toUpperCase()),
                initial: fit.weightValue(st.weight),
                decimal: true,
                onSave: (v) => fit.setSessionWeightShown(exIdx, j, v),
              ),
            ),
          ),
        ],
        const SizedBox(width: _gap),
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
    final hint = fit.plateHint(exercise.equipment, next.weight);
    if (hint == null) return const SizedBox.shrink();

    return Semantics(
      button: true,
      label: t.toolTitle('plate'),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => showPlateSheet(context, fit.toDisplayWeight(next.weight)),
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

  Color _kindColor(GymColors gc, SetKind kind) => switch (kind) {
        SetKind.warmup => gc.warn,
        SetKind.drop => gc.info,
        SetKind.failure => gc.danger,
        SetKind.normal => gc.text,
      };

  String _kindLabel(SetKind kind) => switch (kind) {
        SetKind.warmup => t.setTypeWarmup,
        SetKind.drop => t.setTypeDrop,
        SetKind.failure => t.setTypeFailure,
        SetKind.normal => t.setTypeNormal,
      };

  Widget _setBadge(GymColors gc, int exIdx, int j, SessionSet st) {
    final sets = fit.session?.exercises[exIdx].sets ?? const <SessionSet>[];
    var working = 0;
    for (var i = 0; i <= j && i < sets.length; i++) {
      if (sets[i].counts) working++;
    }
    final base = st.kind == SetKind.warmup
        ? 'W'
        : switch (st.kind) {
            SetKind.drop => '$working·D',
            SetKind.failure => '$working·F',
            _ => '$working',
          };
    final text = st.rpe == null ? base : '$base@${fmt(st.rpe!)}';
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
    await showModalBottomSheet<void>(
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
                  for (final kind in SetKind.values) ...[
                    if (kind != SetKind.values.first) const SizedBox(height: 8),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setSheet(() => fit.setSetKind(exIdx, j, kind)),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: kind == kindNow ? gc.bgRaised2 : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border:
                              Border.all(color: kind == kindNow ? _kindColor(gc, kind) : gc.border),
                        ),
                        child: Row(children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration:
                                BoxDecoration(color: _kindColor(gc, kind), shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(_kindLabel(kind),
                                style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                          ),
                          if (kind == kindNow)
                            Icon(PhosphorIconsBold.check, size: 14, color: _kindColor(gc, kind)),
                        ]),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Text(t.setTypeHint, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                  if (fit.logRpe) ...[
                    const SizedBox(height: 20),
                    Text(t.rpeTitle,
                        style: AppTheme.f(12,
                            weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
                    const SizedBox(height: 10),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      Pill(
                        label: t.none,
                        bg: live?.rpe == null ? gc.ember : gc.bgRaised2,
                        fg: live?.rpe == null ? gc.onEmber : gc.textSecondary,
                        onTap: () => setSheet(() => fit.setSessionRpe(exIdx, j, null)),
                        hPad: 12,
                        vPad: 7,
                        fontSize: 12.5,
                      ),
                      for (final value in _rpeSteps)
                        Pill(
                          label: fmt(value),
                          bg: live?.rpe == value ? gc.ember : gc.bgRaised2,
                          fg: live?.rpe == value ? gc.onEmber : gc.textSecondary,
                          onTap: () => setSheet(() => fit.setSessionRpe(exIdx, j, value)),
                          hPad: 12,
                          vPad: 7,
                          fontSize: 12.5,
                        ),
                    ]),
                    const SizedBox(height: 10),
                    Text(t.rpeHint, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                  ],
                  const SizedBox(height: 18),
                  PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static const _rpeSteps = [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0];

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
              child: Text(value,
                  style: TextStyle(fontWeight: FontWeight.w600, color: gc.text, fontSize: 14)),
            ),
          ),
          const SizedBox(width: 3),
          b('+', t.increase, inc),
        ],
        ),
      ),
    );
  }

  Future<void> _editValue(
    BuildContext context, {
    required String title,
    required String initial,
    required bool decimal,
    required void Function(double) onSave,
  }) async {
    final parsed = await askNumber(context, title: title, initial: initial, decimal: decimal);
    if (parsed != null) onSave(parsed);
  }

  Widget _mainAction(GymColors gc, SessionExercise? ex, int exIdx, int total) {
    final pending = ex == null ? -1 : ex.sets.indexWhere((st) => !st.done);
    if (pending >= 0) {
      return PrimaryButton(label: t.setDone, onTap: () => fit.toggleSet(exIdx, pending), height: 56);
    }
    if (exIdx < total - 1) {
      return PrimaryButton(label: t.nextExercise, onTap: fit.nextExercise, height: 56);
    }
    return PrimaryButton(label: t.finishSession, onTap: fit.finishSession, height: 56);
  }

  Future<void> _goNext(BuildContext context, SessionExercise? ex) async {
    if (ex != null && ex.sets.isNotEmpty && !ex.sets.any((st) => st.done)) {
      final ok = await askConfirm(
        context,
        title: t.skipExercise,
        body: t.skipExerciseBody(t.catalogName(ex.id, ex.name)),
        confirmLabel: t.skip2,
      );
      if (!ok) return;
    }
    fit.nextExercise();
  }

  Widget _textAction(GymColors gc, String label, VoidCallback onTap) => Semantics(
        button: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Text(label,
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
    final prs = fit.summaryPrs;
    final streak = fit.currentStreak;
    final goalHit = fit.goalPct >= 100;
    final vsLast = fit.summaryVsLast;
    final vol = fit.summaryVolumeKg;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _finishHero(gc, prs: prs, streak: streak, goalHit: goalHit),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _sumCard(gc, t.duration, fit.summaryDurationLabel)),
            const SizedBox(width: 10),
            Expanded(child: _sumCard(gc, t.setsCaps, '${fit.session?.summarySets ?? 0}')),
            const SizedBox(width: 10),
            Expanded(child: _sumCard(gc, t.volume, fit.volumeLabel(vol))),
          ]),
          const SizedBox(height: 10),
          if (vsLast != null && vsLast > 0) _vsLastCard(gc, vol, vsLast) else _firstTimeCard(gc),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: PrimaryButton(label: t.saveAndExit, onTap: fit.saveAndExit)),
            const SizedBox(width: 10),
            Semantics(
              button: true,
              label: t.share,
              child: GestureDetector(
                onTap: () => showShareSheet(context, initial: ShareKind.streak),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: gc.bgRaised,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(PhosphorIconsRegular.shareNetwork, size: 20, color: gc.text),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          GhostButton(
            label: t.saveAsRoutine,
            icon: PhosphorIconsRegular.listChecks,
            onTap: () {
              if (fit.saveSessionAsRoutine().isEmpty) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t.savedAsRoutine), behavior: SnackBarBehavior.floating),
              );
            },
          ),
        ],
      ),
    );
  }

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
          Text(label, style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4)),
          const SizedBox(height: 4),
          Text(value, style: AppTheme.f(18, weight: FontWeight.w700, color: gc.text)),
        ],
      ),
    );
  }
}

void showAddToSessionSheet(BuildContext context) {
  final gc = context.gc;
  final search = TextEditingController();
  showModalBottomSheet<void>(
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
                        showCreateExerciseSheet(context, onCreated: fit.addExerciseToSession);
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
      child: Opacity(
        opacity: already ? 0.45 : 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: gc.bgRaised2,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: [
            SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 10)),
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
