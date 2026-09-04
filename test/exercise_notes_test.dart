import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/screens/exercise_detail_screen.dart';
import 'package:gymmane/screens/notes_screen.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:gymmane/widgets/note_kit.dart';

Widget _host(Widget Function() screen) => MaterialApp(
      theme: AppTheme.dark,
      home: AnimatedBuilder(
        animation: fit,
        builder: (_, _) => Scaffold(body: screen()),
      ),
    );

const _exId = 'barbell-bench-press';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String exId;

  Future<void> tapVisible(WidgetTester tester, Finder f) async {
    await tester.ensureVisible(f);
    await tester.pumpAndSettle();
    await tester.tap(f);
    await tester.pumpAndSettle();
  }

  setUp(() {
    setAppLanguage('en');
    exId = fit.allExercises.any((e) => e.id == _exId) ? _exId : fit.allExercises.first.id;
    fit.notes.clear();
    fit.noteScope = '';
    fit.noteFilter = null;
    fit.openExercise(exId);
  });

  tearDown(() {
    fit.notes.clear();
    fit.persistNow();
  });

  void addNotes(int n, {NoteKind kind = NoteKind.note, String? on}) {
    for (int i = 1; i <= n; i++) {
      fit.saveNote(
        exerciseId: on ?? exId,
        date: DateTime.now().subtract(Duration(days: n - i)),
        kind: kind,
        text: 'nota $i',
      );
    }
    fit.persistNow();
  }

  testWidgets('the exercise sheet counts its notes instead of piling them up', (tester) async {
    addNotes(3);
    await tester.pumpWidget(_host(ExerciseDetailScreen.new));

    expect(find.text(t.noteCount(3)), findsOneWidget);
    expect(find.text('nota 3'), findsNothing);
    expect(find.text('nota 1'), findsNothing);
    expect(find.text(t.noteNoneForExercise), findsNothing);
  });

  testWidgets('with none written the sheet says so instead of showing an empty list',
      (tester) async {
    await tester.pumpWidget(_host(ExerciseDetailScreen.new));
    expect(find.text(t.noteNoneForExercise), findsOneWidget);
  });

  testWidgets('the notes button opens the journal of that exercise', (tester) async {
    addNotes(10);
    await tester.pumpWidget(_host(ExerciseDetailScreen.new));

    expect(find.text('nota 10'), findsNothing);

    await tapVisible(tester, find.text(t.notes));
    expect(fit.route, 'notes');
    expect(fit.noteScope, exId);
    expect(fit.notesAllView, isFalse);
  });

  testWidgets('the journal scoped to one exercise leaves the rest out', (tester) async {
    final other = fit.allExercises.firstWhere((e) => e.id != exId).id;
    addNotes(2);
    fit.saveNote(
        exerciseId: other, date: DateTime.now(), kind: NoteKind.note, text: 'de otro sitio');
    fit.persistNow();

    fit.goNotes(exerciseId: exId, all: true);
    await tester.pumpWidget(_host(NotesScreen.new));

    expect(find.text('nota 1'), findsOneWidget);
    expect(find.text('de otro sitio'), findsNothing);
  });

  testWidgets('the kind filter narrows the journal down', (tester) async {
    addNotes(2);
    fit.saveNote(
        exerciseId: exId, date: DateTime.now(), kind: NoteKind.pain, text: 'me tira el hombro');
    fit.persistNow();

    fit.goNotes(all: true);
    await tester.pumpWidget(_host(NotesScreen.new));
    expect(find.text('nota 1'), findsOneWidget);

    await tapVisible(tester, find.textContaining(noteKindLabel(NoteKind.pain)).first);
    expect(find.text('me tira el hombro'), findsOneWidget);
    expect(find.text('nota 1'), findsNothing);
  });

  test('deleting hits the note you pointed at, not another one', () {
    addNotes(5);
    final newest = fit.notesFor(exId).first;
    expect(newest.text, 'nota 5');

    fit.deleteNote(newest.id);
    expect(fit.notesFor(exId).map((n) => n.text), isNot(contains('nota 5')));
    expect(fit.notesFor(exId).first.text, 'nota 4');
  });

  test('editing a note keeps its place instead of adding a second one', () {
    addNotes(1);
    final note = fit.notes.single;
    fit.saveNote(
      id: note.id,
      exerciseId: exId,
      date: note.date,
      kind: NoteKind.plan,
      text: 'subir a 82.5',
    );

    expect(fit.notes, hasLength(1));
    expect(fit.notes.single.kind, NoteKind.plan);
    expect(fit.notes.single.text, 'subir a 82.5');
  });

  test('an empty note is not worth saving', () {
    fit.saveNote(exerciseId: exId, date: DateTime.now(), kind: NoteKind.note, text: '   ');
    expect(fit.notes, isEmpty);
  });

  test('the title is the first line and the body the rest', () {
    fit.saveNote(
        exerciseId: exId,
        date: DateTime.now(),
        kind: NoteKind.note,
        text: 'Codos dentro\ny bajar despacio');
    final n = fit.notes.single;
    expect(n.title, 'Codos dentro');
    expect(n.body, 'y bajar despacio');
  });

  test('notes with no exercise live in the journal all the same', () {
    fit.saveNote(exerciseId: '', date: DateTime.now(), kind: NoteKind.done, text: 'peso a 74 kg');
    expect(fit.notes.single.isGeneral, true);
    expect(fit.notesFor(exId), isEmpty);
    fit.noteScope = '';
    expect(fit.notesInScope, hasLength(1));
  });
}
