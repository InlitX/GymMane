import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/screens/exercise_detail_screen.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';

Widget _host() => MaterialApp(
      theme: AppTheme.dark,
      home: AnimatedBuilder(
        animation: fit,

        builder: (_, _) => Scaffold(body: ExerciseDetailScreen()),
      ),
    );

const _exId = 'barbell-bench-press';

void main() {
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
    fit.exNotes.remove(exId);
    fit.openExercise(exId);
  });

  tearDown(() {
    fit.exNotes.remove(exId);
    fit.persistNow();
  });

  void addNotes(int n) {
    for (int i = 1; i <= n; i++) {
      fit.addNote(exId, 'nota $i');
    }
    fit.persistNow();
  }

  testWidgets('a handful of notes shows them all, with no toggle to get in the way',
      (tester) async {
    addNotes(3);
    await tester.pumpWidget(_host());
    expect(find.text('nota 1'), findsOneWidget);
    expect(find.text('nota 3'), findsOneWidget);
    expect(find.textContaining('note', findRichText: true), findsNothing,
        reason: 'sin desbordar no hay nada que desplegar');
  });

  testWidgets('past the limit only the newest survive on screen', (tester) async {
    addNotes(10);
    await tester.pumpWidget(_host());

    expect(find.text('nota 10'), findsOneWidget);
    expect(find.text('nota 8'), findsOneWidget);
    expect(find.text('nota 7'), findsNothing, reason: 'la cuarta ya no cabe en el resumen');
    expect(find.text('nota 1'), findsNothing);
  });

  testWidgets('the toggle opens every note and closes back down', (tester) async {
    addNotes(10);
    await tester.pumpWidget(_host());

    await tapVisible(tester, find.text(t.showAllNotes(10)));
    expect(find.text('nota 1'), findsOneWidget, reason: 'la más vieja tiene que ser alcanzable');

    await tapVisible(tester, find.text(t.showFewerNotes));
    expect(find.text('nota 1'), findsNothing);
    expect(find.text(t.showAllNotes(10)), findsOneWidget);
  });

  testWidgets('opening the notes does not stretch the page without bound', (tester) async {
    addNotes(40);
    await tester.pumpWidget(_host());
    await tapVisible(tester, find.text(t.showAllNotes(40)));

    expect(find.text('nota 1'), findsOneWidget, reason: 'se ha desplegado de verdad');

    final box = tester.getSize(find.byType(Scrollbar));
    expect(box.height, lessThanOrEqualTo(260.0),
        reason: 'las notas scrollean dentro de su caja en vez de estirar la ficha');
  });

  testWidgets('deleting hits the note you pointed at, not another one', (tester) async {
    addNotes(5);
    await tester.pumpWidget(_host());
    expect(find.text('nota 5'), findsOneWidget);

    fit.deleteNote(exId, 0);
    fit.persistNow();
    await tester.pumpAndSettle();

    expect(find.text('nota 5'), findsNothing);
    expect(find.text('nota 4'), findsOneWidget);
  });
}
