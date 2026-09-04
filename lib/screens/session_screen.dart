import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/live_session.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/exercise_media.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';
import '../widgets/share_cards.dart';
import 'exercises_screen.dart';
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
    final def = fit.exerciseById(ex?.id ?? '') ?? kExercises.first;
    final repsOnly = ex != null && fit.isRepsOnly(ex.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
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
                style: AppTheme.d(12,
                    weight: FontWeight.w600,
                    color: fit.sessionPaused ? gc.textTertiary : gc.ember,
                    letterSpacing: 2),
              ),
            ]),
            Row(children: [
              Text(fit.elapsedLabel,
                  style: AppTheme.d(18,
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
        ),
        const SizedBox(height: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fit.sessionProgressLabel,
                style: AppTheme.s(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
            const SizedBox(height: 4),
            Text(ex == null ? '' : t.catalogName(ex.id, ex.name), style: AppTheme.d(26, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(100)),
              child: Text(muscleLabel(ex?.primary ?? ''),
                  style: AppTheme.s(12, weight: FontWeight.w600, color: gc.ember)),
            ),
            if (ex != null && fit.lastSummaryFor(ex.id) != null) ...[
              const SizedBox(height: 10),
              Row(children: [
                Text(t.last,
                    style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(fit.lastSummaryFor(ex.id)!,
                      style: AppTheme.s(12, weight: FontWeight.w600, color: gc.textSecondary)),
                ),
              ]),
            ],
          ],
        ),
        const SizedBox(height: 14),
        if (ex != null) ExerciseMedia(ex: def, height: 170, live: true),
        const SizedBox(height: 18),
        if (s.restRemaining != null) ...[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              border: Border.all(color: gc.ember),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              Text(t.rest, style: AppTheme.s(12, weight: FontWeight.w600, color: gc.brass, letterSpacing: 2)),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _restNudge(gc, '−15', t.decrease, () => fit.nudgeRest(-15)),
                const SizedBox(width: 14),
                Text('${s.restRemaining}s', style: AppTheme.d(48, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(width: 14),
                _restNudge(gc, '+15', t.increase, () => fit.nudgeRest(15)),
              ]),
              const SizedBox(height: 4),
              Text(t.restDefault(fit.restSeconds), style: AppTheme.s(11, color: gc.textTertiary)),
              const SizedBox(height: 8),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: fit.skipRest,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
                  child: Text(t.skip, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 18),
        ],
        Container(
          padding: const EdgeInsets.fromLTRB(_cardPad, 16, _cardPad, 16),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            border: Border.all(color: gc.border),
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
              if (!repsOnly && ex != null) _plateRow(gc, ex),
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
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => showAddToSessionSheet(context),
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: gc.border),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(PhosphorIconsRegular.plus, size: 16, color: gc.ember),
                      const SizedBox(width: 8),
                      Text(t.addExercise,
                          style: AppTheme.d(13, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                    ],
                  ),
                ),
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
                    border: Border.all(color: gc.border),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(PhosphorIconsRegular.notePencil, size: 17, color: gc.ember),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (ex != null && s.exercises.length > 1)
          Center(
            child: Semantics(
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _confirmDrop(context, exIdx, t.catalogName(ex.id, ex.name)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(t.dropExercise,
                      style: AppTheme.s(12, weight: FontWeight.w600, color: gc.textTertiary)),
                ),
              ),
            ),
          ),
        const SizedBox(height: 6),
        Row(children: [
          _circleBtn(gc, Ic.chevronLeft, fit.prevExercise),
          const SizedBox(width: 10),
          Expanded(child: PrimaryButton(label: t.finishSession, onTap: fit.finishSession, height: 56)),
          const SizedBox(width: 10),
          _circleBtn(gc, Ic.chevronRightBold, fit.nextExercise),
        ]),
      ],
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
              child: Text(glyph, style: AppTheme.s(12, weight: FontWeight.w600, color: gc.text)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDrop(BuildContext context, int exIdx, String name) async {
    final gc = context.gc;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.dropExercise, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.dropExerciseBody(name), style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(t.cancel, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text(t.drop, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
        ],
      ),
    );
    if (ok == true) fit.removeSessionExercise(exIdx);
  }

  static const _numCol = 24.0;
  static const _checkCol = 40.0;
  static const _gap = 6.0;
  static const _cardPad = 8.0;
  static const _rowPad = 8.0;

  Widget _setsHeader(GymColors gc, bool repsOnly) {
    final s = AppTheme.s(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1);

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

  Widget _setRow(GymColors gc, int exIdx, int j, SessionSet st, bool repsOnly) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: _rowPad, vertical: 8),
      decoration: BoxDecoration(
        color: st.done ? gc.sageSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
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
                  border: Border.all(color: st.done ? gc.sage : gc.border, width: 2),
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
            border: Border.all(color: gc.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label,
                maxLines: 1,
                style: AppTheme.s(13,
                    weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
          ),
        ),
      );

  Widget _plateRow(GymColors gc, SessionExercise ex) {
    final exercise = fit.exerciseById(ex.id);
    if (exercise == null) return const SizedBox.shrink();
    final next = ex.sets.firstWhere((s) => !s.done, orElse: () => ex.sets.last);
    final hint = fit.plateHint(exercise.equipment, next.weight);
    if (hint == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(_rowPad, 8, _rowPad, 0),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.circlesThree, size: 13, color: gc.textTertiary),
          const SizedBox(width: 7),
          Expanded(
            child: Text(t.platesPerSide(hint),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.s(11.5, color: gc.textTertiary)),
          ),
        ],
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
    final text = st.kind == SetKind.warmup
        ? 'W'
        : switch (st.kind) {
            SetKind.drop => '$working·D',
            SetKind.failure => '$working·F',
            _ => '$working',
          };
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text,
          maxLines: 1,
          softWrap: false,
          style: AppTheme.d(16, weight: FontWeight.w700, color: _kindColor(gc, st.kind))),
    );
  }

  Future<void> _kindSheet(BuildContext context, int exIdx, int j, SetKind current) async {
    final gc = context.gc;
    final picked = await showModalBottomSheet<SetKind>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration:
                    BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 18),
            Text(t.setType,
                style: AppTheme.d(12,
                    weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 2)),
            const SizedBox(height: 12),
            for (final kind in SetKind.values) ...[
              if (kind != SetKind.values.first) const SizedBox(height: 8),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(sheet).pop(kind),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kind == current ? gc.bgRaised2 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: kind == current ? _kindColor(gc, kind) : gc.border),
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
                          style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
                    ),
                    if (kind == current)
                      Icon(PhosphorIconsBold.check, size: 14, color: _kindColor(gc, kind)),
                  ]),
                ),
              ),
            ],
            const SizedBox(height: 14),
            Text(t.setTypeHint,
                style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4)),
          ],
        ),
      ),
    );
    if (picked != null) fit.setSetKind(exIdx, j, picked);
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
      builder: (context) => Row(
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
    );
  }

  Future<void> _editValue(
    BuildContext context, {
    required String title,
    required String initial,
    required bool decimal,
    required void Function(double) onSave,
  }) async {
    final gc = context.gc;
    final controller = TextEditingController(text: initial)
      ..selection = TextSelection(baseOffset: 0, extentOffset: initial.length);

    final raw = await showDialog<String>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: AppTheme.d(14, weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.numberWithOptions(decimal: decimal),
          textAlign: TextAlign.center,
          style: AppTheme.d(32, weight: FontWeight.w700, color: gc.text),
          cursorColor: gc.accent,
          onSubmitted: (v) => Navigator.of(dctx).pop(v),
          decoration: InputDecoration(
            filled: true,
            fillColor: gc.bgRaised2,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(),
            child: Text(t.cancel, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(controller.text),
            child: Text(t.set, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
        ],
      ),
    );

    final parsed = double.tryParse((raw ?? '').trim().replaceAll(',', '.'));
    if (parsed != null) onSave(parsed);
  }

  Widget _circleBtn(GymColors gc, List<IconPath> icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: gc.bgRaised,
          shape: BoxShape.circle,
          border: Border.all(color: gc.border),
        ),
        child: Center(child: SvgPathIcon(icon, size: 18, color: gc.text)),
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
                    border: Border.all(color: gc.border),
                  ),
                  child: Icon(PhosphorIconsRegular.shareNetwork, size: 20, color: gc.text),
                ),
              ),
            ),
          ]),
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
          border: Border.all(color: prs > 0 ? gc.accent : gc.border),
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
                    Text(t.sessionComplete,
                        style: AppTheme.d(11, weight: FontWeight.w600, color: gc.brass, letterSpacing: 3)),
                    if (prs > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration:
                            BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(100)),
                        child: Text(t.prCount(prs),
                            style: AppTheme.s(10, weight: FontWeight.w700, color: gc.accent)),
                      ),
                    ],
                  ]),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 210),
                    child: Text(t.finishHeadline(prs: prs, streak: streak, goalHit: goalHit),
                        style: AppTheme.d(28, weight: FontWeight.w700, color: gc.text, height: 1.05)),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 230),
                    child: Text(t.finishBody(prs: prs, streak: streak, goalHit: goalHit),
                        style: AppTheme.s(13, color: gc.textSecondary, height: 1.35)),
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
              style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
        ),
        Text('${up ? '+' : ''}$pct%',
            style: AppTheme.d(16, weight: FontWeight.w700, color: up ? gc.sage : gc.textSecondary)),
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
        Expanded(child: Text(t.firstTime, style: AppTheme.s(13, color: gc.textSecondary))),
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
          Text(label, style: AppTheme.s(10, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(value, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
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
                            style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
                        const SizedBox(height: 14),
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: gc.bgRaised2,
                            border: Border.all(color: gc.border),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(children: [
                            SvgPathIcon(Ic.search, size: 16, color: gc.textSecondary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: search,
                                autofocus: false,
                                onChanged: (_) => setSheet(() {}),
                                style: AppTheme.s(14, color: gc.text),
                                cursorColor: gc.accent,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                  hintText: t.searchExercises,
                                  hintStyle: AppTheme.s(14, color: gc.textSecondary),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 12),
                        Text(q.isEmpty ? t.suggested.toUpperCase() : t.results.toUpperCase(),
                            style: AppTheme.s(11,
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
                            child: Text(t.noMatches, style: AppTheme.s(13, color: gc.textSecondary)),
                          ),
                        for (final ex in list) _addRow(sheetCtx, gc, ex),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 18),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(sheetCtx);
                        showCreateExerciseSheet(context, onCreated: fit.addExerciseToSession);
                      },
                      child: Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: gc.border),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(PhosphorIconsRegular.plus, size: 16, color: gc.ember),
                            const SizedBox(width: 8),
                            Text(t.newExercise,
                                style: AppTheme.d(13,
                                    weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                          ],
                        ),
                      ),
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
            border: Border.all(color: gc.border),
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
                      style: AppTheme.s(13.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(muscleLabel(ex.primary), style: AppTheme.s(11, color: gc.textSecondary)),
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
