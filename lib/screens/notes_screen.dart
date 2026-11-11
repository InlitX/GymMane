import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../app/desktop.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/note.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/note_folder.dart';
import '../widgets/note_kit.dart';
import '../widgets/ui_kit.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final scoped = fit.noteScope.isEmpty ? null : fit.exerciseById(fit.noteScope);
    final all = fit.notesAllView;
    final folder = fit.openFolder;
    final wide = DesktopScope.of(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: wide ? const EdgeInsets.fromLTRB(32, 30, 32, 0) : const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: ScreenHeader(
              title: folder != null
                  ? folder.name.toUpperCase()
                  : (scoped == null ? t.journal : exerciseName(scoped).toUpperCase()),
              subtitle: all || wide ? t.noteCount(fit.notesInScope.length) : t.noteMonthCount(fit.notesInMonth),
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
                if (folder != null)
                  _action(
                    gc,
                    icon: PhosphorIconsBold.dotsThreeVertical,
                    label: t.moreOptions,
                    onTap: () => showNoteFolderMenu(context, folder),
                  )
                else if (!wide)
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
              child: wide
                  ? _desktop(context, gc, scoped == null, folders: scoped == null && folder == null)
                  : all
                      ? _allNotes(context, gc, scoped == null, folders: scoped == null && folder == null)
                      : _calendar(context, gc, scoped == null)),
        ],
      ),
    );
  }

  Widget _desktop(BuildContext context, GymColors gc, bool showExercise, {required bool folders}) {
    final visible = fit.notesFiltered;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 380, child: _calendar(context, gc, showExercise)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(children: [
            if (folders) _folders(context, gc),
            if (fit.notesInScope.isNotEmpty)
              NoteFilterBar(
                selected: fit.noteFilter,
                counts: fit.noteKindCounts,
                onPick: fit.setNoteFilter,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            Expanded(
              child: visible.isEmpty
                  ? _empty(gc)
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
                      children: _groupedGrid(gc, visible, showExercise: showExercise),
                    ),
            ),
          ]),
        ),
      ]),
    );
  }

  List<Widget> _groupedGrid(GymColors gc, List<GymNote> notes, {required bool showExercise}) {
    final out = <Widget>[];
    final groups = <(DateTime, List<GymNote>)>[];
    for (final n in notes) {
      final d = DateTime(n.date.year, n.date.month, n.date.day);
      if (groups.isEmpty || groups.last.$1 != d) groups.add((d, []));
      groups.last.$2.add(n);
    }
    for (final (d, list) in groups) {
      out.add(_dayHeading(gc, d, first: out.isEmpty));
      out.add(CardFlow(minColumn: 320, maxColumns: 3, gap: 12, children: [
        for (final n in list) NoteCard(note: n, showExercise: showExercise, showDate: false),
      ]));
    }
    return out;
  }

  Widget _dayHeading(GymColors gc, DateTime d, {required bool first}) => Padding(
        padding: EdgeInsets.only(top: first ? 0 : 18, bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(noteDayLabel(d).toUpperCase(),
                    style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text, letterSpacing: 0.4)),
                const SizedBox(height: 3),
                Text(t.fullDate(d), style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Container(height: 1, color: gc.border),
            )),
          ],
        ),
      );

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
                      style: AppTheme.f(10.5,
                          weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                  const SizedBox(height: 3),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(t.fullDate(day),
                        maxLines: 1, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
                  ),
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
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsRegular.notebook, size: 20, color: gc.textTertiary),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(t.noteNoneOnDay,
                      style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                ),
              ],
            ),
          )
        else
          for (final n in notes) NoteCard(note: n, showExercise: showExercise, showDate: false),
      ],
    );
  }

  Widget _folders(BuildContext context, GymColors gc) {
    if (fit.noteFolders.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
        child: Pressable(
          scale: 0.98,
          onTap: () => showNoteFolderEditor(context),
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: gc.border, width: 1.2),
            ),
            child: Row(children: [
              Icon(PhosphorIconsRegular.folderPlus, size: 17, color: gc.textSecondary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(t.noteFolderNew,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.textSecondary)),
              ),
              Icon(PhosphorIconsBold.plus, size: 13, color: gc.textTertiary),
            ]),
          ),
        ),
      );
    }
    final byFolder = <String, List<GymNote>>{};
    for (final n in fit.notesSorted) {
      if (n.folder.isNotEmpty) (byFolder[n.folder] ??= []).add(n);
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SectionLabel(t.noteFolders),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: noteFolderHeight(context),
            child: ListView.separated(
              key: const PageStorageKey('h-notes_screen-285'),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: fit.noteFolders.length + 1,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                if (i == fit.noteFolders.length) {
                  return NewNoteFolderCard(onTap: () => showNoteFolderEditor(context));
                }
                final f = fit.noteFolders[i];
                return NoteFolderCard(
                  folder: f,
                  notes: byFolder[f.id] ?? const [],
                  onTap: () => fit.openNoteFolder(f.id),
                  onMenu: () => showNoteFolderMenu(context, f),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
        ],
      );
  }

  Widget _allNotes(BuildContext context, GymColors gc, bool showExercise, {bool folders = false}) {
    final visible = fit.notesFiltered;

    return Column(
      children: [
        if (folders) _folders(context, gc),
        if (fit.notesInScope.isNotEmpty)
          NoteFilterBar(
            selected: fit.noteFilter,
            counts: fit.noteKindCounts,
            onPick: fit.setNoteFilter,
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      style: AppTheme.f(12.5,
                          weight: FontWeight.w700, color: gc.text, letterSpacing: 0.4)),
                  const SizedBox(height: 3),
                  Text(t.fullDate(d), style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
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
                  style: AppTheme.f(17, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 8),
              Text(t.noteEmptyBody,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.5)),
            ],
          ),
        ),
      );
}
