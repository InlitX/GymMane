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
}
