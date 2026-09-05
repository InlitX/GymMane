import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/note.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/note_kit.dart';
import '../widgets/ui_kit.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final scoped = fit.noteScope.isEmpty ? null : fit.exerciseById(fit.noteScope);
    final all = fit.notesAllView;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: ScreenHeader(
              title: scoped == null ? t.journal : exerciseName(scoped).toUpperCase(),
              subtitle: all ? t.noteCount(fit.notesInScope.length) : t.noteMonthCount(fit.notesInMonth),
              onBack: fit.backFromNotes,
              actions: [
                _action(
                  gc,
                  icon: PhosphorIconsBold.plus,
                  label: t.addNote,
                  filled: true,
                  onTap: () => fit.openNoteEditor(
                    exerciseId: fit.noteScope,
                    date: all ? DateTime.now() : fit.noteDay,
                  ),
                ),
                const SizedBox(width: 8),
                _action(
                  gc,
                  icon: all ? PhosphorIconsRegular.calendarBlank : PhosphorIconsRegular.listBullets,
                  label: all ? t.noteCalendar : t.noteAllNotes,
                  onTap: () => fit.setNotesAllView(!all),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
              child: all
                  ? _allNotes(gc, scoped == null)
                  : _calendar(context, gc, scoped == null)),
        ],
      ),
    );
  }

  Widget _action(
    GymColors gc, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool filled = false,
  }) =>
      RoundAction(
        label: label,
        onTap: onTap,
        size: 38,
        filled: filled,
        child: Icon(icon, size: 16, color: filled ? gc.onEmber : gc.text),
      );

  Widget _calendar(BuildContext context, GymColors gc, bool showExercise) {
    final day = fit.noteDay;
    final notes = fit.notesOn(day);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        SoftCard(
          radius: 22,
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
          child: NoteCalendar(
            month: fit.noteMonth,
            selected: day,
            kindsOn: fit.noteKindsOn,
            onPick: fit.selectNoteDay,
            onHold: (day) {
              fit.selectNoteDay(day);
              showNoteDaySheet(context, day);
            },
            onMonth: fit.showNoteMonth,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(noteDayLabel(day).toUpperCase(),
                      style: AppTheme.d(12,
                          weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
                  const SizedBox(height: 3),
                  Text(t.fullDate(day), style: AppTheme.s(12, color: gc.textTertiary)),
                ],
              ),
            ),
            Pill(
              label: t.noteAddOnDay,
              bg: gc.bgRaised,
              fg: gc.text,
              fontSize: 12,
              onTap: () => fit.openNoteEditor(exerciseId: fit.noteScope, date: day),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (notes.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
            decoration: BoxDecoration(
              color: gc.bgRaised.withValues(alpha: 0.5),
              border: Border.all(color: gc.border),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsRegular.notebook, size: 20, color: gc.textTertiary),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(t.noteNoneOnDay,
                      style: AppTheme.s(13, color: gc.textSecondary, height: 1.4)),
                ),
              ],
            ),
          )
        else
          for (final n in notes) NoteCard(note: n, showExercise: showExercise, showDate: false),
      ],
    );
  }

  Widget _allNotes(GymColors gc, bool showExercise) {
    final visible = fit.notesFiltered;

    return Column(
      children: [
        if (fit.notesInScope.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NoteFilterBar(
              selected: fit.noteFilter,
              counts: fit.noteKindCounts,
              onPick: fit.setNoteFilter,
            ),
          ),
        Expanded(
          child: visible.isEmpty
              ? _empty(gc)
              : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                  children: _grouped(gc, visible, showExercise: showExercise),
                ),
        ),
      ],
    );
  }

  List<Widget> _grouped(GymColors gc, List<GymNote> notes, {required bool showExercise}) {
    final out = <Widget>[];
    DateTime? day;
    for (final n in notes) {
      final d = DateTime(n.date.year, n.date.month, n.date.day);
      if (day == null || d != day) {
        day = d;
        out.add(Padding(
          padding: EdgeInsets.only(top: out.isEmpty ? 0 : 14, bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(noteDayLabel(d).toUpperCase(),
                      style: AppTheme.d(12.5,
                          weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
                  const SizedBox(height: 3),
                  Text(t.fullDate(d), style: AppTheme.s(11.5, color: gc.textTertiary)),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(height: 1, color: gc.border),
              )),
            ],
          ),
        ));
      }
      out.add(NoteCard(note: n, showExercise: showExercise, showDate: false));
    }
    return out;
  }

  Widget _empty(GymColors gc) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(PhosphorIconsRegular.notebook, size: 38, color: gc.textTertiary),
              const SizedBox(height: 16),
              Text(t.noteEmptyTitle,
                  textAlign: TextAlign.center,
                  style: AppTheme.d(17, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 8),
              Text(t.noteEmptyBody,
                  textAlign: TextAlign.center,
                  style: AppTheme.s(13, color: gc.textSecondary, height: 1.5)),
            ],
          ),
        ),
      );
}
