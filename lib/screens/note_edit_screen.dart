import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/note.dart';
import '../services/exercise_match.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/note_kit.dart';
import '../widgets/ui_kit.dart';

const int _kNoteMaxLength = 1000;

class NoteEditScreen extends StatefulWidget {
  const NoteEditScreen({super.key});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late final GymNote? _note = fit.editingNote;
  late final TextEditingController _text = TextEditingController(text: _note?.text ?? '');
  late NoteKind _kind = _note?.kind ?? fit.noteDraftKind;
  late DateTime _date = _note?.date ?? fit.noteDraftDate;
  late String _exerciseId = _note?.exerciseId ?? fit.noteDraftExercise;
  late final List<String> _media = [...?_note?.media];
  final List<String> _added = [];
  bool _saved = false;

  bool get _canSave => _text.text.trim().isNotEmpty;

  @override
  void dispose() {
    for (final name in _added) {
      if (!_saved || !_media.contains(name)) MediaStore.delete(name);
    }
    _text.dispose();
    super.dispose();
  }

  void _save() {
    if (!_canSave) return;
    _saved = true;
    fit.saveNote(
      id: _note?.id,
      exerciseId: _exerciseId,
      date: _date,
      kind: _kind,
      text: _text.text,
      media: _media,
    );
    fit.closeNoteEditor();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _addMedia() async {
    try {
      final res = await FilePicker.platform.pickFiles(type: FileType.media, allowMultiple: true);
      for (final f in res?.files ?? const <PlatformFile>[]) {
        final path = f.path;
        if (path == null) continue;
        final saved = await fit.importNoteMedia(path);
        if (saved == null) continue;
        _added.add(saved);
        if (mounted) setState(() => _media.add(saved));
      }
    } catch (_) {}
  }

  Future<void> _confirmDelete() async {
    final note = _note;
    if (note == null) return;
    final ok = await askConfirm(
      context,
      title: t.deleteNoteTitle,
      body: t.deleteNoteBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (!ok) return;
    fit.deleteNote(note.id);
    fit.closeNoteEditor();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final exercise = _exerciseId.isEmpty ? null : fit.exerciseById(_exerciseId);

    return SafeArea(
      bottom: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        excludeFromSemantics: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: ScreenHeader(
                title: _note == null ? t.newNote : t.editNote,
                onBack: fit.closeNoteEditor,
                actions: [
                  if (_note != null)
                    RoundAction(
                      label: t.delete,
                      onTap: _confirmDelete,
                      child: Icon(PhosphorIconsRegular.trash, size: 16, color: gc.danger),
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  _label(gc, t.noteKindLabel),
                  NoteKindPicker(selected: _kind, onChanged: (k) => setState(() => _kind = k)),
                  const SizedBox(height: 22),
                  _label(gc, t.noteTextLabel),
                  Container(
                    decoration: BoxDecoration(
                      color: gc.bgRaised,
                      border: Border.all(color: gc.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                    child: TextField(
                      controller: _text,
                      autofocus: _note == null,
                      minLines: 4,
                      maxLines: 10,
                      maxLength: _kNoteMaxLength,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (_) => setState(() {}),
                      cursorColor: gc.accent,
                      style: AppTheme.s(14.5, color: gc.text, height: 1.45),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: t.notePlaceholder,
                        hintStyle: AppTheme.s(14.5, color: gc.textTertiary),
                        counterStyle: AppTheme.s(11, color: gc.textTertiary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  _label(gc, t.noteDateLabel),
                  _row(
                    gc,
                    icon: PhosphorIconsRegular.calendarBlank,
                    value: t.shortDateYear(_date),
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 14),
                  _label(gc, t.noteExerciseLabel),
                  _row(
                    gc,
                    icon: PhosphorIconsRegular.barbell,
                    value: exercise == null ? t.noteGeneral : exerciseName(exercise),
                    muted: exercise == null,
                    trailing: exercise == null
                        ? null
                        : Semantics(
                            button: true,
                            label: t.noteGeneral,
                            child: GestureDetector(
                              onTap: () => setState(() => _exerciseId = ''),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(PhosphorIconsBold.x, size: 14, color: gc.textTertiary),
                              ),
                            ),
                          ),
                    onTap: _pickExercise,
                  ),
                  const SizedBox(height: 22),
                  _label(gc, t.noteMediaLabel),
                  _mediaGrid(gc),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    label: t.save,
                    onTap: _save,
                    bg: _canSave ? gc.ember : gc.mutedFill,
                    fg: _canSave ? gc.onEmber : gc.textTertiary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(GymColors gc, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: AppTheme.d(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 2)),
      );

  Widget _row(
    GymColors gc, {
    required IconData icon,
    required String value,
    required VoidCallback onTap,
    Widget? trailing,
    bool muted = false,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SoftCard(
          radius: 14,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 17, color: gc.textSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.s(14,
                        weight: FontWeight.w500, color: muted ? gc.textTertiary : gc.text)),
              ),
              trailing ??
                  Icon(PhosphorIconsRegular.caretRight, size: 14, color: gc.textTertiary),
            ],
          ),
        ),
      );

  Widget _mediaGrid(GymColors gc) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (int i = 0; i < _media.length; i++)
          GestureDetector(
            onTap: () => showNoteMedia(context, _media, i),
            child: NoteThumb(
              name: _media[i],
              size: 74,
              onRemove: () => setState(() => _media.removeAt(i)),
            ),
          ),
        Semantics(
          button: true,
          label: t.noteAttach,
          child: GestureDetector(
            onTap: _addMedia,
            child: Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: gc.bgRaised,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gc.border),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(PhosphorIconsRegular.images, size: 20, color: gc.textSecondary),
                  const SizedBox(height: 5),
                  Text(t.noteAttach, style: AppTheme.s(10.5, color: gc.textTertiary)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickExercise() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ExercisePickerSheet(),
    );
    if (picked != null && mounted) setState(() => _exerciseId = picked);
  }
}

class _ExercisePickerSheet extends StatefulWidget {
  const _ExercisePickerSheet();

  @override
  State<_ExercisePickerSheet> createState() => _ExercisePickerSheetState();
}

class _ExercisePickerSheetState extends State<_ExercisePickerSheet> {
  final TextEditingController _q = TextEditingController();

  @override
  void dispose() {
    _q.dispose();
    super.dispose();
  }

  List<Exercise> get _results {
    final all = fit.allExercises;
    if (_q.text.trim().isEmpty) return all.take(40).toList();
    return all.where(exerciseSearch(_q.text)).take(60).toList();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final results = _results;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.72,
        decoration: BoxDecoration(
          color: gc.bg,
          border: Border.all(color: gc.border),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SheetHandle(color: gc.border, margin: const EdgeInsets.symmetric(vertical: 12)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: TextField(
                controller: _q,
                autofocus: true,
                onChanged: (_) => setState(() {}),
                cursorColor: gc.accent,
                style: AppTheme.s(14, color: gc.text),
                decoration: InputDecoration(
                  hintText: t.searchAllExercises,
                  hintStyle: AppTheme.s(14, color: gc.textTertiary),
                  filled: true,
                  fillColor: gc.bgRaised,
                  prefixIcon: Icon(PhosphorIconsRegular.magnifyingGlass, size: 17, color: gc.textTertiary),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.border)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.accent)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: results.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return _tile(gc, t.noteGeneral, muted: true, onTap: () => Navigator.of(context).pop(''));
                  }
                  final ex = results[i - 1];
                  return _tile(gc, exerciseName(ex), onTap: () => Navigator.of(context).pop(ex.id));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(GymColors gc, String label, {required VoidCallback onTap, bool muted = false}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: gc.border))),
          child: Text(label,
              style: AppTheme.s(14,
                  weight: FontWeight.w500, color: muted ? gc.textTertiary : gc.text)),
        ),
      );
}
