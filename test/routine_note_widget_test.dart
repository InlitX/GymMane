import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/screens/plan_import_sheet.dart';
import 'package:gymmane/screens/routine_edit_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:gymmane/widgets/workout_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('routine notes in the UI', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    testWidgets('create a note in the routine and see it only in that workout', (tester) async {
      final ex = fit.matchExerciseByName('Dumbbell Hammer Curl')!;
      final id = fit.createRoutine('Arms');
      fit.toggleRoutineExercise(id, ex.id);
      fit.openRoutine(id);
      await tester.binding.setSurfaceSize(const Size(400, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.dark,
        home: AnimatedBuilder(
          animation: fit,
          builder: (_, _) => const Scaffold(body: RoutineEditScreen()),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text(ex.name).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.routineExerciseNote));
      await tester.pumpAndSettle();
      const cue = 'Log reps per arm.';
      await tester.enterText(find.byType(TextField).last, cue);
      await tester.tap(find.widgetWithText(TextButton, t.save));
      await tester.pumpAndSettle();
      expect(find.text(cue), findsOneWidget);

      Widget strip() => MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: WorkoutNoteStrip(exerciseId: ex.id)),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      fit.startRoutine(fit.routineById(id)!);
      await tester.pumpWidget(strip());
      expect(find.text(cue), findsOneWidget);
      fit.resetAllData();
      final other = fit.createRoutine('Other');
      fit.toggleRoutineExercise(other, ex.id);
      fit.startRoutine(fit.routineById(other)!);
      await tester.pumpWidget(strip());
      expect(find.text(cue), findsNothing);
      fit.resetAllData();
      await tester.pumpAndSettle();
    });

    testWidgets('an owned routine offers to import missing notes without a copy', (tester) async {
      final ex = fit.matchExerciseByName('Dumbbell Hammer Curl')!;
      final id = fit.createRoutine('Arms');
      fit.toggleRoutineExercise(id, ex.id);
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: Builder(builder: (ctx) {
          context = ctx;
          return const SizedBox();
        })),
      ));
      showPlanImportSheet(context, text: '''
        {"name":"Arms","exercises":[
          {"name":"Dumbbell Hammer Curl","logging_note":"Log reps per arm."}
        ]}
      ''');
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.importRoutineNotes));
      await tester.pumpAndSettle();
      expect(fit.routines.single.id, id);
      expect(fit.routineExerciseNote(id, ex.id), 'Log reps per arm.');
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 3));
    });
  });

  group('#378 repetir un ejercicio desde el editor', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    testWidgets('anadir otra vez crea el segundo bloque con su etiqueta y su nota propia', (tester) async {
      final bench = fit.matchExerciseByName('Barbell Bench Press')!;
      final ext = fit.matchExerciseByName('Leg Extension')!;
      final id = fit.createRoutine('Blocks');
      fit.toggleRoutineExercise(id, bench.id);
      fit.toggleRoutineExercise(id, ext.id);
      fit.openRoutine(id);
      await tester.binding.setSurfaceSize(const Size(400, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.dark,
        home: AnimatedBuilder(
          animation: fit,
          builder: (_, _) => Scaffold(body: RoutineEditScreen(key: ValueKey(fit.activeRoutineId))),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text(bench.name).first);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text(t.routineAddAgain), 200, scrollable: find.byType(Scrollable).last);
      await tester.tap(find.text(t.routineAddAgain));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final r = fit.routineById(id)!;
      expect(r.exerciseIds, [bench.id, ext.id, '${bench.id}#2']);
      expect(find.text(t.routineRepeatTag(1, 2).toUpperCase()), findsOneWidget);
      expect(find.text(t.routineRepeatTag(2, 2).toUpperCase()), findsOneWidget);
      final card = find.ancestor(of: find.text(t.routineRepeatTag(2, 2).toUpperCase()), matching: find.byType(Column)).first;
      await tester.tap(find.descendant(of: card, matching: find.text(bench.name)));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.routineExerciseNote));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'Lighter');
      await tester.tap(find.widgetWithText(TextButton, t.save));
      await tester.pumpAndSettle();
      expect(fit.routineExerciseNote(id, '${bench.id}#2'), 'Lighter');
      expect(fit.routineExerciseNote(id, bench.id), isNull);
      await tester.pump(const Duration(seconds: 5));
      fit.resetAllData();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    });
  });
}
