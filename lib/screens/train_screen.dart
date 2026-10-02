import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_map.dart';
import '../widgets/exercise_media.dart';
import '../widgets/exercise_preview.dart';
import '../widgets/svg_icon.dart';
import '../widgets/glass.dart';
import '../widgets/ui_kit.dart';
import 'exercises_screen.dart' show showCreateExerciseSheet;

class TrainScreen extends StatefulWidget {
  const TrainScreen({super.key});

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _q = '';
  String? _gear;

  void _clearSearch() {
    _searchCtrl.clear();
    setState(() => _q = '');
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final review = fit.trainStep == 'review';
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundBtn(icon: Ic.closeThin, onTap: fit.closeTrain),
                Text(titleCase(t.train), style: AppTheme.f(18, weight: FontWeight.w800, color: gc.text)),
                const SizedBox(width: 36),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, review ? 112 : 12),
                    child: review ? _review(context, gc) : _select(context, gc),
                  ),
                ),
                if (review) ...[
                  const Positioned(left: 0, right: 0, bottom: 0, child: EdgeBlur(top: false, height: 112, sigma: 11, shade: 0.35)),
                  Positioned(left: 0, right: 0, bottom: 0, child: _startBar(context, gc)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _startBar(BuildContext context, GymColors gc) {
    final n = fit.sessionPicks.length;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 14 + MediaQuery.of(context).padding.bottom),
      child: PrimaryButton(
        label: n == 0 ? t.pickAnExercise : t.startCount(n),
        bg: n == 0 ? gc.bgRaised2 : gc.ember,
        fg: n == 0 ? gc.textTertiary : gc.onEmber,
        onTap: fit.startSession,
      ),
    );
  }

  Widget _select(BuildContext context, GymColors gc) {
    final hasSel = fit.selectedMuscles.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.step1.toUpperCase(),
            style: AppTheme.f(10.5,
                weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
        const SizedBox(height: 4),
        Text(t.chooseFocus, style: AppTheme.f(28, weight: FontWeight.w800, color: gc.text)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(24),
          ),
          child: BodyMap(
            selected: fit.selectedMuscles.toSet(),
            onToggle: fit.toggleMuscle,
          ),
        ),
        const SizedBox(height: 6),
        Text(t.tapMuscles,
            textAlign: TextAlign.center, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
        const SizedBox(height: 14),
        Container(
          constraints: const BoxConstraints(minHeight: 38),
          alignment: Alignment.centerLeft,
          child: hasSel
              ? Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [for (final id in fit.selectedMuscles) _chip(gc, id)],
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: t.continueBtn,
          bg: hasSel ? gc.ember : gc.bgRaised2,
          fg: hasSel ? gc.onEmber : gc.textTertiary,
          onTap: fit.trainContinue,
        ),
        const SizedBox(height: 26),
        Text(t.orStartWith.toUpperCase(),
            style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
        const SizedBox(height: 10),
        IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: _kindCard(gc, 'warmup', PhosphorIconsRegular.fire, t.warmupFocus, t.warmupFocusHint),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _kindCard(gc, 'cardio', PhosphorIconsRegular.heartbeat, t.cardioFocus, t.cardioFocusHint),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _kindCard(GymColors gc, String kind, IconData icon, String title, String hint) => Pressable(
        onTap: () => fit.startKindWorkout(kind),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, size: 19, color: gc.accent),
            ),
            const SizedBox(height: 14),
            Text(title, style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 3),
            Text(hint, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
          ]),
        ),
      );

  Widget _chip(GymColors gc, String id) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(100)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(t.muscle(id), style: AppTheme.f(13, weight: FontWeight.w600, color: gc.ember)),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () => fit.toggleMuscle(id),
          child: SvgPathIcon(Ic.closeThin, size: 12, color: gc.ember),
        ),
      ]),
    );
  }

  Widget _review(BuildContext context, GymColors gc) {
    final searching = _q.trim().isNotEmpty;

    final all = searching ? fit.trainSearchResults(_q) : fit.reviewExercises();
    final gearHere = <String>[
      for (final e in kFilterEquipment)
        if (all.any((x) => x.equipment == e)) e,
    ];
    final gear = gearHere.contains(_gear) ? _gear : null;
    final exercises = gear == null ? all : all.where((e) => e.equipment == gear).toList();
    final seeded = searching ? const <Exercise>[] : exercises.where((e) => fit.pickSeed.contains(e.id)).toList();
    final others = searching ? exercises : exercises.where((e) => !fit.pickSeed.contains(e.id)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: fit.trainBack,
              child: SvgPathIcon(Ic.chevronLeft, size: 20, color: gc.textSecondary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.step2.toUpperCase(),
                      style: AppTheme.f(10.5,
                          weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                  Text(t.buildSession, style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _searchRow(context, gc),
        const SizedBox(height: 12),
        if (gearHere.length > 1) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _gearChip(gc, t.allExercisesShort, gear == null, null),
              for (final e in gearHere) _gearChip(gc, t.equipment(e), gear == e, e),
            ]),
          ),
          const SizedBox(height: 14),
        ],
        if (!searching && all.isNotEmpty) ...[
          Text(t.pickedHint(all.length),
              style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
          const SizedBox(height: 12),
        ],
        if (exercises.isEmpty)
          _emptyReview(context, gc, searching)
        else ...[
          if (seeded.isNotEmpty) ...[
            _sectionLabel(gc, t.suggestedPicks),
            for (final ex in seeded) ...[
              _pickRow(context, gc, ex),
              const SizedBox(height: 10),
            ],
            if (others.isNotEmpty) ...[
              const SizedBox(height: 10),
              _sectionLabel(gc, t.moreOptions),
            ],
          ],
          for (final ex in others) ...[
            _pickRow(context, gc, ex),
            const SizedBox(height: 10),
          ],
        ],
      ],
    );
  }

  Widget _sectionLabel(GymColors gc, String label) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 2),
        child: Text(label.toUpperCase(),
            style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3)),
      );

  Widget _gearChip(GymColors gc, String label, bool on, String? value) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Pill(
          label: label,
          bg: on ? gc.ember : gc.bgRaised2,
          fg: on ? gc.onEmber : gc.textSecondary,
          onTap: () => setState(() => _gear = value),
          hPad: 12,
          vPad: 6,
          fontSize: 12,
        ),
      );

  Widget _searchRow(BuildContext context, GymColors gc) {
    final hasQuery = _q.isNotEmpty;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(children: [
              SvgPathIcon(Ic.search, size: 16, color: gc.textSecondary),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _q = v),
                  style: AppTheme.f(14, weight: FontWeight.w500, color: gc.text),
                  cursorColor: gc.accent,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: t.searchAllExercises,
                    hintStyle: AppTheme.f(14, weight: FontWeight.w500, color: gc.textSecondary),
                  ),
                ),
              ),
              if (hasQuery)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _clearSearch,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: SvgPathIcon(Ic.closeThin, size: 14, color: gc.textSecondary),
                  ),
                ),
            ]),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => setState(() => fit.toggleResetPicks()),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: fit.sessionPicks.isNotEmpty ? gc.emberSoft : gc.bgRaised,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: fit.sessionPicks.isNotEmpty ? gc.ember.withValues(alpha: 0.3) : gc.border,
              ),
            ),
            child: Icon(
              PhosphorIconsRegular.arrowCounterClockwise,
              size: 20,
              color: fit.sessionPicks.isNotEmpty ? gc.ember : gc.textTertiary,
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => showCreateExerciseSheet(context, initialName: _q, onCreated: (id) {
            fit.togglePick(id);
            _clearSearch();
          }),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: gc.emberSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(PhosphorIconsRegular.plus, size: 20, color: gc.ember),
          ),
        ),
      ],
    );
  }

  Widget _emptyReview(BuildContext context, GymColors gc, bool searching) {
    if (searching) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
        child: Column(
          children: [
            Text(t.noExercisesMatch,
                style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text)),
            const SizedBox(height: 10),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showCreateExerciseSheet(context, initialName: _q, onCreated: (id) {
                fit.togglePick(id);
                _clearSearch();
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(t.createItInstead,
                    style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
      child: Column(
        children: [
          Text(t.nothingForFocus,
              style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text)),
          const SizedBox(height: 4),
          Text(t.goBackPick,
              textAlign: TextAlign.center, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
        ],
      ),
    );
  }

  Widget _pickRow(BuildContext context, GymColors gc, Exercise ex) {
    final picked = fit.isPicked(ex.id);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => fit.togglePick(ex.id),
      onLongPress: () => showExercisePreview(context, ex, suggestions: true),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: picked ? gc.ember : gc.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: () => showExercisePreview(context, ex, suggestions: true),
            child: SizedBox(width: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 12)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exerciseName(ex), style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 2),
                Text(fit.lastSummaryFor(ex.id) ?? muscleLabel(ex.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: picked ? gc.ember : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: picked ? gc.ember : gc.textTertiary, width: 2),
            ),
            child: picked ? Center(child: SvgPathIcon(Ic.checkBold, size: 13, color: gc.onEmber)) : null,
          ),
        ]),
      ),
    );
  }
}
