import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/screens/exercises_screen.dart';
import 'package:gymmane/services/exercise_match.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/ui_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
  });

  String calfLifts() => fit.addCustomExercise(
        name: 'Calf lifts',
        primary: 'calves',
        equipment: 'Bodyweight',
        aliases: [' Toe lifts ', '', 'calf lifts', 'Toe Lifts', 'Heel raises'],
      );

  test('los alias se limpian: sin vacíos, sin repetir y sin el propio nombre', () {
    final id = calfLifts();
    expect(fit.exerciseById(id)!.aliases, ['Toe lifts', 'Heel raises']);
  });

  test('buscar por alias encuentra el ejercicio propio', () {
    final id = calfLifts();
    expect(fit.exercisesMatching('toe lift').map((e) => e.id), contains(id));
    expect(fit.exercisesMatching('heel raises').map((e) => e.id), contains(id));
  });

  test('importar con un alias casa con el ejercicio propio', () {
    final id = calfLifts();
    expect(matchExercise('Toe Lifts', fit.customExercises)?.id, id);
  });

  test('los alias sobreviven a la copia de seguridad', () {
    final id = calfLifts();
    final back = Exercise.fromJson(fit.exerciseById(id)!.toJson());
    expect(back.aliases, ['Toe lifts', 'Heel raises']);
    expect(Exercise.fromJson({'id': 'x', 'n': 'Old', 'p': 'chest'}).aliases, isEmpty);
  });

  test('editar sin tocar los alias los conserva', () {
    final id = calfLifts();
    final ex = fit.exerciseById(id)!;
    fit.updateCustomExercise(id,
        name: 'Calf raise', primary: ex.primary, equipment: ex.equipment, difficulty: ex.difficulty, steps: [], mode: '');
    expect(fit.exerciseById(id)!.aliases, ['Toe lifts', 'Heel raises']);
    fit.updateCustomExercise(id,
        name: 'Calf raise', primary: ex.primary, equipment: ex.equipment, difficulty: ex.difficulty, steps: [], mode: '', aliases: []);
    expect(fit.exerciseById(id)!.aliases, isEmpty);
  });

  test('añadir a rutina desde la ficha mete el ejercicio una vez y volver regresa a la ficha', () {
    final ex = fit.allExercises.first.id;
    final r = fit.createRoutine('Pierna');
    fit.goExercises();
    fit.openExercise(ex);
    fit.addToRoutineAndEdit(r, ex);
    expect(fit.route, 'routine-edit');
    expect(fit.activeRoutineId, r);
    fit.closeRoutineEdit();
    expect(fit.route, 'exercise-detail');
    fit.addToRoutineAndEdit(r, ex);
    expect(fit.routines.single.exerciseIds, [ex]);
    expect(fit.routinesWith(ex), 1);
    fit.closeRoutineEdit();
    fit.closeExerciseDetail();
    expect(fit.route, 'exercises');
  });

  test('añadir a una rutina nueva la crea con el ejercicio', () {
    final ex = fit.allExercises.first.id;
    fit.openExercise(ex);
    fit.addToRoutineAndEdit(null, ex);
    expect(fit.routines.single.exerciseIds, [ex]);
    expect(fit.activeRoutineId, fit.routines.single.id);
  });

  test('abrir una rutina desde la lista sigue volviendo a la lista', () {
    final r = fit.createRoutine('A');
    fit.goRoutines();
    fit.openRoutine(r);
    fit.closeRoutineEdit();
    expect(fit.route, 'routines');
  });

  testWidgets('crear sin nombre avisa y no crea nada', (tester) async {
    fit.onboarded = true;
    fit.pendingAwards.clear();
    fit.goExercises();
    await tester.pumpWidget(const GymManeApp());
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 80));
    }
    showCreateExerciseSheet(tester.element(find.byKey(const PageStorageKey('exercises'))));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 80));
    }
    expect(find.text(t.exerciseNameMissing), findsNothing);
    final add = find.byType(PrimaryButton).last;
    await tester.ensureVisible(add);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(add);
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 80));
    }
    expect(find.text(t.exerciseNameMissing), findsOneWidget);
    expect(fit.customExercises, isEmpty);

    await tester.enterText(find.widgetWithText(TextField, t.exerciseName), 'Calf lifts');
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(t.exerciseNameMissing), findsNothing);
  });
}
