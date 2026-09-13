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
                      RoundAction(
                        onTap: () {
                          fit.closeExerciseDetail();
                          fit.deleteCustomExercise(ex.id);
                        },
                        child: Icon(PhosphorIconsRegular.trash, size: 16, color: gc.textSecondary),
                      ),
                      const SizedBox(width: 10),
                    ],
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
                  SizedBox(
                    width: double.infinity,
                    child: ExerciseMedia(
                        ex: ex, height: 220, radius: 22, live: true, bordered: false),
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
                  Text(exerciseName(ex),
                      style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text, height: 1.1)),
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
                  _group(gc, [
                    _repsOnlyRow(gc, ex.id, repsOnly),
                    _restRow(gc, ex.id),
                    if (!repsOnly) ...[
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
                                    Text(fit.weightLabel(pr.topWeight),
                                        style: AppTheme.f(30,
                                            weight: FontWeight.w800, color: gc.text, height: 1)),
                                  ],
                                ),
                              ),
                              Text(t.oneRmEst(fit.weightLabel(pr.oneRm)),
                                  style: AppTheme.f(12,
                                      weight: FontWeight.w500, color: gc.textSecondary)),
                            ],
                          ),
                          if (oneRm.length > 2) ...[
                            const SizedBox(height: 16),
                            Sparkline(values: oneRm, height: 52, color: gc.accent),
                          ],
                        ],
                      ),
                    ),
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
                      _historyRow(gc, history[i], i < history.length - 1 && i < 7),
                  const SizedBox(height: 24),
                  _notesRow(gc, ex.id),
                  const SizedBox(height: 24),
                  if (steps.isNotEmpty) ...[
                    _section(gc, t.howTo),
                    const SizedBox(height: 14),
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
                    _section(gc, t.similar),
                    const SizedBox(height: 10),
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
    return '$sets · RPE ${fmt(rpe.reduce((a, b) => a > b ? a : b))}';
  }

  Widget _historyRow(GymColors gc, ({DateTime date, LoggedExercise ex}) h, bool border) {
    final e = h.ex;
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
        onTap: () => fit.goNotes(exerciseId: exId),
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

  Widget _cardLabel(GymColors gc, String label) => Text(label.toUpperCase(),
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
            value: seconds == 0 ? t.restOff : '${seconds}s',
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

  Widget _rowIcon(GymColors gc, IconData icon, bool on) => Padding(
        padding: const EdgeInsets.only(right: 14),
        child: SizedBox(
          width: 22,
          child: Icon(icon, size: 19, color: on ? gc.text : gc.textSecondary),
        ),
      );

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
