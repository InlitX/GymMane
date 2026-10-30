import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/note.dart';
import '../services/exercise_match.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/glass.dart';
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
  late bool _pinned = _note?.pinned ?? false;
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
      pinned: _pinned,
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
                      style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text, height: 1.45),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: t.notePlaceholder,
                        hintStyle: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.textTertiary),
                        counterStyle: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ColoredBox(
                      color: gc.bgRaised,
                      child: Column(children: [
                        _row(
                          gc,
                          icon: PhosphorIconsRegular.calendarBlank,
                          label: t.noteDateLabel,
                          value: t.shortDateYear(_date),
                          onTap: _pickDate,
                        ),
                        Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: gc.border),
                        _row(
                          gc,
                          icon: PhosphorIconsRegular.barbell,
                          label: t.noteExerciseLabel,
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
                                      child: Icon(PhosphorIconsBold.x, size: 13, color: gc.textTertiary),
                                    ),
                                  ),
                                ),
                          onTap: _pickExercise,
                        ),
                        if (exercise != null) ...[
                          Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: gc.border),
                          _row(
                            gc,
                            icon: PhosphorIconsRegular.pushPin,
                            label: t.notePinWorkout,
                            value: '',
                            trailing: TinySwitch(on: _pinned),
                            onTap: () => setState(() => _pinned = !_pinned),
                          ),
                        ],
                      ]),
                    ),
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
            style: AppTheme.f(11,
                weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
      );

  Widget _row(
    GymColors gc, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    Widget? trailing,
    bool muted = false,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 54,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, size: 19, color: gc.textSecondary),
                const SizedBox(width: 14),
                Flexible(
                  child: Text(sentenceCase(label),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: AppTheme.f(13,
                          weight: FontWeight.w600, color: muted ? gc.textTertiary : gc.textSecondary)),
                ),
                const SizedBox(width: 6),
                trailing ?? Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
              ],
            ),
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
            onTap: () => showNoteMedia(context, _media, i, scope: 'edit'),
            child: NoteThumb(
              name: _media[i],
              size: 74,
              natural: true,
              scope: 'edit',
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
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(PhosphorIconsRegular.images, size: 20, color: gc.textSecondary),
                  const SizedBox(height: 5),
                  Text(t.noteAttach, style: AppTheme.f(10.5, weight: FontWeight.w500, color: gc.textTertiary)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickExercise() async {
    final picked = await showAppSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ExercisePickerSheet(current: _exerciseId),
    );
    if (picked != null && mounted) setState(() => _exerciseId = picked);
  }
}

class _ExercisePickerSheet extends StatefulWidget {
  const _ExercisePickerSheet({required this.current});

  final String current;

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
        padding: sheetPad(context, bottom: 16),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            SheetTitle(sentenceCase(t.noteExerciseLabel)),
            const SizedBox(height: 14),
            SearchField(
              controller: _q,
              hint: t.searchAllExercises,
              color: gc.bgRaised2,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: OptionGroup(
                scroll: true,
                [
                  OptionItem(
                    t.noteGeneral,
                    icon: PhosphorIconsRegular.notebook,
                    selected: widget.current.isEmpty,
                    onTap: () => Navigator.of(context).pop(''),
                  ),
                  for (final ex in results)
                    OptionItem(
                      exerciseName(ex),
                      selected: widget.current == ex.id,
                      onTap: () => Navigator.of(context).pop(ex.id),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
