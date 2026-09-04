import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
import '../widgets/exercise_media.dart';
import '../widgets/stopwatch_card.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

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
    final pr = fit.exercisePr(ex.id);
    final oneRm = fit.oneRmSeries(ex.id);
    final history = fit.exerciseHistory(ex.id);
    final hasMedia = fit.hasCustomMedia(ex.id);
    final repsOnly = fit.isRepsOnly(ex.id);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundBtn(icon: Ic.chevronLeft, onTap: fit.closeExerciseDetail),
                  Row(children: [
                    if (fit.isCustom(ex.id)) ...[
                      GestureDetector(
                        onTap: () {
                          fit.closeExerciseDetail();
                          fit.deleteCustomExercise(ex.id);
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: gc.bgRaised,
                            shape: BoxShape.circle,
                            border: Border.all(color: gc.border),
                          ),
                          child: Icon(PhosphorIconsRegular.trash, size: 16, color: gc.textSecondary),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    GestureDetector(
                      onTap: () => fit.toggleFavorite(ex.id),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: gc.bgRaised,
                          shape: BoxShape.circle,
                          border: Border.all(color: gc.border),
                        ),
                        child: Center(child: _star(gc, fav)),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ExerciseMedia(ex: ex, height: 210, live: true),
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
                  Text(exerciseName(ex), style: AppTheme.d(24, weight: FontWeight.w700, color: gc.text)),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _meta(gc, t.primaryLabel, muscleLabel(ex.primary), gc.ember),
                      const SizedBox(width: 20),
                      _meta(gc, t.secondaryLabel, secondary, gc.text),
                      const SizedBox(width: 20),
                      _meta(gc, t.equipmentLabel, t.equipment(ex.equipment), gc.text),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _repsOnlyRow(gc, ex.id, repsOnly),
                  const SizedBox(height: 10),
                  _restRow(gc, ex.id),
                  const SizedBox(height: 20),
                  const StopwatchCard(),
                  const SizedBox(height: 20),
                  if (pr != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: gc.bgRaised,
                        border: Border.all(color: gc.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPathIcon(Ic.trendUp, size: 18, color: gc.accent),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(t.personalRecord,
                                    style: AppTheme.d(13, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(fit.weightLabel(pr.topWeight),
                                      style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
                                  Text(t.oneRmEst(fit.weightLabel(pr.oneRm)),
                                      style: AppTheme.s(11, color: gc.textSecondary)),
                                ],
                              ),
                            ],
                          ),
                          if (oneRm.length > 2) ...[
                            const SizedBox(height: 14),
                            Sparkline(values: oneRm, height: 52, color: gc.accent),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  Text(t.history, style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                  const SizedBox(height: 12),
                  if (history.isEmpty)
                    Text(t.noHistory,
                        style: AppTheme.s(13, color: gc.textSecondary))
                  else
                    for (int i = 0; i < history.length && i < 8; i++)
                      _historyRow(gc, history[i], i < history.length - 1 && i < 7),
                  const SizedBox(height: 24),
                  _notesRow(gc, ex.id),
                  const SizedBox(height: 24),
                  if (steps.isNotEmpty) ...[
                    Text(t.howTo, style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                    const SizedBox(height: 12),
                    for (int i = 0; i < steps.length; i++) ...[
                      _step(gc, i + 1, steps[i]),
                      if (i < steps.length - 1) const SizedBox(height: 14),
                    ],
                  ],
                  if (fit.alternativesHere(ex, 3).isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _notHere(gc, ex),
                  ],
                  if (fit.similarExercises(ex, 4).isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(t.similar, style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                    const SizedBox(height: 12),
                    for (final s in fit.similarExercises(ex, 4)) _similarRow(gc, s),
                  ],
                ],
              ),
            ),
          ],
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
        borderRadius: BorderRadius.circular(18),
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
                    style: AppTheme.s(13.5, weight: FontWeight.w600, color: gc.text)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(t.notHereWhy, style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.4)),
          ),
          const SizedBox(height: 14),
          Text(t.altHere,
              style: AppTheme.s(10,
                  weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
          const SizedBox(height: 6),
          for (final alt in fit.alternativesHere(ex, 3)) _similarRow(gc, alt),
        ],
      ),
    );
  }

  Widget _historyRow(GymColors gc, ({DateTime date, LoggedExercise ex}) h, bool border) {
    final e = h.ex;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: border ? Border(bottom: BorderSide(color: gc.border)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_fmtDate(h.date), style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 2),
              Text(t.setCount(e.sets.length), style: AppTheme.s(12, color: gc.textSecondary)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(fit.weightLabel(e.topWeight),
                  style: AppTheme.d(16, weight: FontWeight.w700, color: gc.text)),
              Text(t.volumeSuffix(fit.volumeLabel(e.volume)), style: AppTheme.s(11, color: gc.textSecondary)),
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
        onTap: () => fit.goNotes(exerciseId: exId),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            border: Border.all(color: n > 0 ? gc.ember : gc.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(PhosphorIconsRegular.notebook,
                  size: 18, color: n > 0 ? gc.ember : gc.textSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.notes,
                        style: AppTheme.s(12,
                            weight: FontWeight.w600, color: gc.text, letterSpacing: 0.5)),
                    const SizedBox(height: 2),
                    Text(n == 0 ? t.noteNoneForExercise : t.noteCount(n),
                        style: AppTheme.s(11, color: gc.textSecondary)),
                  ],
                ),
              ),
              Icon(PhosphorIconsRegular.caretRight, size: 16, color: gc.textSecondary),
            ],
          ),
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            SizedBox(width: 48, child: ExerciseMedia(ex: s, height: 48, radius: 10)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exerciseName(s), style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(t.equipment(s.equipment), style: AppTheme.s(12, color: gc.textSecondary)),
                ],
              ),
            ),
            SvgPathIcon(Ic.chevronRight, size: 16, color: gc.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _meta(GymColors gc, String label, String value, Color valueColor) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(value, style: AppTheme.s(14, weight: FontWeight.w600, color: valueColor)),
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
          child: Text('$n', style: AppTheme.s(12, weight: FontWeight.w700, color: gc.ember)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: AppTheme.s(14, color: gc.textSecondary, height: 1.5))),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: custom ? gc.ember : gc.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.timer, size: 18, color: custom ? gc.ember : gc.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.restForExercise,
                    style: AppTheme.s(12, weight: FontWeight.w600, color: gc.text, letterSpacing: 0.5)),
                const SizedBox(height: 2),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: custom ? () => fit.setExerciseRest(id, null) : null,
                  child: Text(custom ? t.restCustom : t.restUsingDefault,
                      style: AppTheme.s(11, color: custom ? gc.accent : gc.textSecondary)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          StepperControl(
            value: '${seconds}s',
            minWidth: 44,
            btnSize: 30,
            gap: 3,
            fontSize: 14,
            btnRadius: 10,
            onDec: () => fit.setExerciseRest(id, seconds - 15),
            onInc: () => fit.setExerciseRest(id, seconds + 15),
          ),
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            border: Border.all(color: on ? gc.ember : gc.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(PhosphorIconsRegular.scales, size: 18, color: on ? gc.ember : gc.textSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.repsOnly, style: AppTheme.s(13.5, weight: FontWeight.w600, color: gc.text)),
                    const SizedBox(height: 2),
                    Text(t.repsOnlyHint, style: AppTheme.s(11, color: gc.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                width: 44,
                height: 26,
                padding: const EdgeInsets.all(3),
                alignment: on ? Alignment.centerRight : Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: on ? gc.ember : gc.bgRaised2,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: on ? gc.ember : gc.border),
                ),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: on ? gc.onEmber : gc.textTertiary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
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
