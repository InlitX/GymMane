import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/screens/notes_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _host(Widget Function() screen) => MaterialApp(
      theme: AppTheme.dark,
      home: AnimatedBuilder(
        animation: fit,
        builder: (_, _) => Scaffold(body: screen()),
      ),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    setAppLanguage('es');
    fit.notes.clear();
    fit.goNotes();
  });

  tearDown(() {
    fit.notes.clear();
    fit.persistNow();
  });

  void note(DateTime day, String text, {NoteKind kind = NoteKind.note}) {
    fit.saveNote(exerciseId: '', date: day, kind: kind, text: text);
    fit.persistNow();
  }

  test('the notes of a day are the ones written that day', () {
    final today = DateTime.now();
    note(today, 'de hoy');
    note(today.subtract(const Duration(days: 1)), 'de ayer');

    expect(fit.notesOn(today).map((n) => n.text), ['de hoy']);
    expect(fit.notesOn(today.subtract(const Duration(days: 1))).map((n) => n.text), ['de ayer']);
  });

  test('a day carries one dot per kind, never repeated', () {
    final day = DateTime.now();
    note(day, 'una', kind: NoteKind.note);
    note(day, 'otra', kind: NoteKind.note);
    note(day, 'molesta', kind: NoteKind.pain);

    expect(fit.noteKindsOn(day), [NoteKind.note, NoteKind.pain]);
    expect(fit.noteKindsOn(day.subtract(const Duration(days: 2))), isEmpty);
  });

  test('saving a note lands on its own day and month', () {
    final day = DateTime(2026, 3, 14);
    note(day, 'del catorce');

    expect(fit.noteDay, DateTime(2026, 3, 14));
    expect(fit.noteMonth, DateTime(2026, 3));
  });

  test('the month moves without dragging the selected day along', () {
    fit.selectNoteDay(DateTime(2026, 3, 14));
    fit.showNoteMonth(-1);

    expect(fit.noteMonth, DateTime(2026, 2));
    expect(fit.noteDay, DateTime(2026, 3, 14));
  });

  testWidgets('the calendar shows the day you picked, not the rest', (tester) async {
    final today = DateTime.now();
    note(today, 'de hoy');
    note(today.subtract(const Duration(days: 2)), 'de anteayer');
    fit.selectNoteDay(today);

    await tester.pumpWidget(_host(NotesScreen.new));
    expect(find.text('de hoy'), findsOneWidget);
    expect(find.text('de anteayer'), findsNothing);

    fit.selectNoteDay(today.subtract(const Duration(days: 2)));
    await tester.pumpAndSettle();
    expect(find.text('de anteayer'), findsOneWidget);
    expect(find.text('de hoy'), findsNothing);
  });

  testWidgets('tapping a day in the grid selects it', (tester) async {
    fit.selectNoteDay(DateTime(2026, 3, 14));
    await tester.pumpWidget(_host(NotesScreen.new));

    await tester.tap(find.text('21').first);
    await tester.pumpAndSettle();
    expect(fit.noteDay, DateTime(2026, 3, 21));
  });

  testWidgets('the list view puts every day on the page, split by day', (tester) async {
    final today = DateTime.now();
    note(today, 'de hoy');
    note(today.subtract(const Duration(days: 1)), 'de ayer');

    fit.setNotesAllView(true);
    await tester.pumpWidget(_host(NotesScreen.new));

    expect(find.text('de hoy'), findsOneWidget);
    expect(find.text('de ayer'), findsOneWidget);
    expect(find.text(t.noteToday.toUpperCase()), findsOneWidget);
    expect(find.text(t.noteYesterday.toUpperCase()), findsOneWidget);
  });

  testWidgets('back from the list view lands on the calendar, not out of the journal',
      (tester) async {
    fit.goNotes(all: true);
    await tester.pumpWidget(_host(NotesScreen.new));

    fit.backFromNotes();
    expect(fit.route, 'notes');
    expect(fit.notesAllView, false);

    fit.backFromNotes();
    expect(fit.route, isNot('notes'));
  });
}
