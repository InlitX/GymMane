import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
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
  final TextEditingController _notes = TextEditingController();
  bool _allNotes = false;

  String _fmtDate(DateTime d) => t.shortDate(d);
  String _fmtDateYear(DateTime d) => t.shortDateYear(d);

  void _saveNote() {
    final t = _notes.text.trim();
    if (t.isEmpty) return;
    fit.addNote(_exId, t);
    _notes.clear();
    FocusScope.of(context).unfocus();
  }

  Future<void> _pickMedia() async {
    try {
      final res = await FilePicker.platform.pickFiles(type: FileType.media);
      final path = res?.files.single.path;
      if (path != null) await fit.attachExerciseMedia(_exId, path);
    } catch (_) {}
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
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
    final history = fit.exerciseHistory(ex.id);

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
                  if (fit.isCustom(ex.id))
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        children: [
                          if (ex.media.isNotEmpty) ...[
                            _mediaBtn(gc, PhosphorIconsRegular.trash, () => fit.clearExerciseMedia(ex.id)),
                            const SizedBox(width: 8),
                          ],
                          _mediaBtn(
                            gc,
                            ex.media.isEmpty ? PhosphorIconsRegular.uploadSimple : PhosphorIconsRegular.pencilSimple,
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
                      child: Row(
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
                  Text(t.notes, style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _notes,
                          maxLines: null,
                          minLines: 1,
                          style: AppTheme.s(14, color: gc.text, height: 1.4),
                          cursorColor: gc.accent,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: t.notePlaceholder,
                            hintStyle: AppTheme.s(14, color: gc.textTertiary),
                            hintMaxLines: 1,
                            filled: true,
                            fillColor: gc.bgRaised,
                            contentPadding: const EdgeInsets.all(14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.border)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.accent)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Semantics(
                        button: true,
                        label: t.save,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _saveNote,
                          child: Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(color: gc.ember, borderRadius: BorderRadius.circular(14)),
                            child: Icon(PhosphorIconsFill.paperPlaneRight, size: 18, color: gc.onEmber),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _notesList(gc, ex.id),
                  const SizedBox(height: 24),
                  if (steps.isNotEmpty) ...[
                    Text(t.howTo, style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                    const SizedBox(height: 12),
                    for (int i = 0; i < steps.length; i++) ...[
                      _step(gc, i + 1, steps[i]),
                      if (i < steps.length - 1) const SizedBox(height: 14),
                    ],
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

  static const _notesPreview = 3;
  static const _notesMaxHeight = 260.0;

  Widget _notesList(GymColors gc, String exId) {
    final notes = fit.notesFor(exId);
    if (notes.isEmpty) return const SizedBox.shrink();

    final overflow = notes.length - _notesPreview;
    if (overflow <= 0 || _allNotes) {
      final rows = [for (int i = 0; i < notes.length; i++) _noteRow(gc, exId, i, notes[i])];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_allNotes && notes.length > _notesPreview)

            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: _notesMaxHeight),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows),
                ),
              ),
            )
          else
            ...rows,
          if (notes.length > _notesPreview) _notesToggle(gc, notes.length, expanded: true),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < _notesPreview; i++) _noteRow(gc, exId, i, notes[i]),
        _notesToggle(gc, notes.length, expanded: false),
      ],
    );
  }

  Widget _notesToggle(GymColors gc, int total, {required bool expanded}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _allNotes = !_allNotes),
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(expanded ? t.showFewerNotes : t.showAllNotes(total),
                style: AppTheme.s(13, weight: FontWeight.w600, color: gc.accent)),
            const SizedBox(width: 6),
            Icon(expanded ? PhosphorIconsRegular.caretUp : PhosphorIconsRegular.caretDown,
                size: 13, color: gc.accent),
          ],
        ),
      ),
    );
  }

  Widget _noteRow(GymColors gc, String exId, int i, ExerciseNote n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_fmtDateYear(n.date),
                    style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Text(n.text, style: AppTheme.s(14, color: gc.text, height: 1.4)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => fit.deleteNote(exId, i),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SvgPathIcon(Ic.close, size: 14, color: gc.textTertiary),
            ),
          ),
        ],
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

  Widget _mediaBtn(GymColors gc, IconData icon, VoidCallback onTap) {
    return GestureDetector(
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
    );
  }
}
