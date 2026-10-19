import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/note.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import 'glass.dart';
import 'ui_kit.dart';

class WorkoutNoteStrip extends StatelessWidget {
  const WorkoutNoteStrip({super.key, required this.exerciseId, this.onDark = false});

  final String exerciseId;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final notes = fit.workoutNotesFor(exerciseId);
    if (notes.isEmpty) return const SizedBox.shrink();
    final gc = context.gc;
    return Semantics(
      button: true,
      label: t.workoutNotesTitle,
      child: Pressable(
        scale: 0.98,
        onTap: () => showWorkoutNotesSheet(context, exerciseId),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
          decoration: BoxDecoration(
            color: onDark ? gc.bgRaised2 : gc.bgRaised,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < notes.length; i++) ...[
                if (i > 0) const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 1.5),
                      child: Icon(_iconOf(notes[i]), size: 13, color: gc.accent),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        notes[i].text.trim().replaceAll(RegExp(r'\s*\n\s*'), ' · '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(
                          12.5,
                          weight: FontWeight.w600,
                          color: gc.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

IconData _iconOf(GymNote n) => n.pinned ? PhosphorIconsFill.pushPin : PhosphorIconsFill.arrowBendDownRight;

Widget _sheetBox(BuildContext context, List<Widget> children) {
  final gc = context.gc;
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
      padding: sheetPad(context),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [const SheetHandle(), const SizedBox(height: 16), ...children],
        ),
      ),
    ),
  );
}

String _exerciseTitle(String id) {
  final ex = fit.exerciseById(id);
  return ex == null ? '' : t.catalogName(ex.id, ex.name);
}

Future<void> showWorkoutNotesSheet(BuildContext context, String exerciseId) => showAppSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (sheet) => AnimatedBuilder(
    animation: fit,
    builder: (sheet, _) {
      final gc = sheet.gc;
      final notes = fit.workoutNotesFor(exerciseId);
      return _sheetBox(sheet, [
        SheetTitle(t.workoutNotesTitle, subtitle: _exerciseTitle(exerciseId)),
        const SizedBox(height: 16),
        for (final n in notes) ...[
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(_iconOf(n), size: 12, color: gc.accent),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              n.pinned
                                  ? t.workoutNoteEvery
                                  : DateUtils.isSameDay(n.date, DateTime.now())
                                  ? t.workoutNoteNext
                                  : t.workoutNoteFromLast(t.shortDate(n.date)),
                              style: AppTheme.f(
                                11,
                                weight: FontWeight.w700,
                                color: gc.accent,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n.text.trim(),
                        style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text, height: 1.4),
                      ),
                    ],
                  ),
                ),
                RoundAction(
                  label: t.editNote,
                  onTap: () => showWorkoutNoteEditor(sheet, exerciseId, note: n),
                  child: Icon(PhosphorIconsRegular.pencilSimple, size: 15, color: gc.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 4),
        GhostButton(
          label: t.newNote,
          icon: PhosphorIconsRegular.plus,
          onTap: () => showWorkoutNoteEditor(sheet, exerciseId),
        ),
      ]);
    },
  ),
);

Future<void> showWorkoutNoteEditor(BuildContext context, String exerciseId, {GymNote? note}) =>
    showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkoutNoteEditor(exerciseId: exerciseId, note: note),
    );

class _WorkoutNoteEditor extends StatefulWidget {
  const _WorkoutNoteEditor({required this.exerciseId, this.note});

  final String exerciseId;
  final GymNote? note;

  @override
  State<_WorkoutNoteEditor> createState() => _WorkoutNoteEditorState();
}

class _WorkoutNoteEditorState extends State<_WorkoutNoteEditor> {
  late final _text = TextEditingController(text: widget.note?.text ?? '');
  late bool _every = widget.note == null || widget.note!.pinned || widget.note!.kind != NoteKind.plan;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _save() {
    if (_text.text.trim().isEmpty) {
      HapticFeedback.heavyImpact();
      return;
    }
    final old = widget.note;
    fit.saveNote(
      id: old?.id,
      exerciseId: widget.exerciseId,
      date: old?.date ?? DateTime.now(),
      kind: _every
          ? (old?.kind == NoteKind.plan ? NoteKind.note : old?.kind ?? NoteKind.note)
          : NoteKind.plan,
      text: _text.text,
      media: old?.media ?? const [],
      pinned: _every,
    );
    HapticFeedback.lightImpact();
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final note = widget.note;
    if (note == null) return;
    final ok = await askConfirm(
      context,
      title: t.deleteNoteTitle,
      body: t.deleteNoteBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (!ok || !mounted) return;
    fit.deleteNote(note.id);
    Navigator.of(context).pop();
  }

  Widget _choice(GymColors gc, bool every) {
    final on = _every == every;
    return Expanded(
      child: Semantics(
        selected: on,
        button: true,
        child: Pressable(
          scale: 0.97,
          onTap: () {
            if (on) return;
            HapticFeedback.selectionClick();
            setState(() => _every = every);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
            decoration: BoxDecoration(
              color: on ? gc.accentSoft : gc.bgRaised2,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: on ? gc.accent : gc.border, width: on ? 1.4 : 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      every ? PhosphorIconsFill.pushPin : PhosphorIconsFill.arrowBendDownRight,
                      size: 14,
                      color: on ? gc.accent : gc.textTertiary,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        every ? t.workoutNoteEvery : t.workoutNoteNext,
                        style: AppTheme.f(
                          13,
                          weight: FontWeight.w800,
                          color: on ? gc.text : gc.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  every ? t.workoutNoteEveryHint : t.workoutNoteNextHint,
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return _sheetBox(context, [
      SheetTitle(widget.note == null ? t.newNote : t.editNote, subtitle: _exerciseTitle(widget.exerciseId)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: TextField(
          controller: _text,
          autofocus: widget.note == null,
          minLines: 2,
          maxLines: 6,
          maxLength: 1000,
          textCapitalization: TextCapitalization.sentences,
          cursorColor: gc.accent,
          style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text, height: 1.4),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: t.workoutNoteHint,
            hintStyle: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.textTertiary),
            counterText: '',
          ),
        ),
      ),
      const SizedBox(height: 12),
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_choice(gc, true), const SizedBox(width: 8), _choice(gc, false)],
        ),
      ),
      const SizedBox(height: 18),
      PrimaryButton(label: t.save, onTap: _save),
      if (widget.note != null) ...[
        const SizedBox(height: 6),
        Center(
          child: TextButton(
            onPressed: _delete,
            child: Text(
              t.delete,
              style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger),
            ),
          ),
        ),
      ],
    ]);
  }
}
