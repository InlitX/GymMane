import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/plan_share.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const pushUp = 'I4hDWkc';
  const diamond = 'x6KpKpq';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.setUnits('kg');
    fit.autoAdvance = false;
  });

  tearDown(() {
    if (fit.session != null) fit.saveAndExit();
  });

  Routine routineWith(List<String> ids) {
    final id = fit.createRoutine('Calistenia');
    for (final ex in ids) {
      fit.toggleRoutineExercise(id, ex);
    }
    return fit.routines.firstWhere((r) => r.id == id);
  }

  void workout(Routine r, int reps, {int sets = 3}) {
    fit.startRoutine(r);
    fit.endCountdown();
    final ex = fit.session!.exercises.first;
    expect(ex.sets.length, greaterThanOrEqualTo(sets));
    for (var i = 0; i < sets; i++) {
      fit.setSessionReps(0, i, reps);
      fit.toggleSet(0, i);
    }
    fit.finishSession();
  }

  test('las cadenas no repiten ejercicios y todos existen', () {
    final all = [for (final c in kProgressions) ...c];
    expect(all.toSet().length, all.length);
    for (final id in all) {
      expect(fit.exerciseById(id), isNotNull, reason: id);
    }
    expect(nextStepOf(pushUp), diamond);
    expect(nextStepOf('pseudo-planche-push-up'), isNull);
  });

  test('un solo buen día no basta: hacen falta dos entrenos seguidos', () {
    final r = routineWith([pushUp]);
    workout(r, 8);
    expect(fit.summaryLevelUp, isNull);
    fit.saveAndExit();
    workout(r, 9);
    expect(fit.summaryLevelUp?.to.id, diamond);
  });

  test('si una de las veces no llega a 3×8 no se sugiere', () {
    final r = routineWith([pushUp]);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 7);
    expect(fit.summaryLevelUp, isNull);
  });

  test('las negativas suben con 3×5', () {
    final r = routineWith(['negative-pull-up']);
    workout(r, 5);
    fit.saveAndExit();
    workout(r, 5);
    expect(fit.summaryLevelUp?.to.id, 'lBDjFxJ');
  });

  test('cambiarlo en la rutina lo pone en el mismo sitio con sus series', () {
    final r = routineWith([pushUp, '6YUfHPL']);
    fit.bumpRoutineSets(r.id, pushUp, 1);
    final sets = fit.routineSets(r, pushUp);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.levelUpInRoutine, isTrue);
    expect(fit.levelUpSwap(), 'Calistenia');
    expect(r.exerciseIds, [diamond, '6YUfHPL']);
    expect(fit.routineSets(r, diamond), sets);
    expect(fit.summaryLevelUp, isNull);
  });

  test('después de verlo no vuelve a salir en una semana', () {
    final r = routineWith([pushUp]);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.summaryLevelUp, isNotNull);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.summaryLevelUp, isNull);
  });

  test('borrar el entreno que la sacó la deja volver a salir', () {
    final r = routineWith([pushUp]);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.summaryLevelUp, isNotNull);
    fit.saveAndExit();
    fit.deleteSession(fit.sessions.last);
    workout(r, 8);
    expect(fit.summaryLevelUp?.to.id, diamond);
  });

  test('borrar otro entreno no la vuelve a sacar', () {
    final r = routineWith([pushUp]);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.summaryLevelUp, isNotNull);
    fit.saveAndExit();
    fit.deleteSession(fit.sessions.first);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.summaryLevelUp, isNull);
  });

  test('«Me quedo con este» lo silencia para siempre y se puede deshacer', () {
    final r = routineWith([pushUp]);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    final undo = fit.levelUpStay()!;
    expect(fit.levelStay, contains(pushUp));
    undo();
    expect(fit.levelStay, isNot(contains(pushUp)));
    expect(fit.summaryLevelUp?.to.id, diamond);
  });

  test('seguir entrenando no gasta la sugerencia', () {
    final r = routineWith([pushUp]);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.summaryLevelUp, isNotNull);
    fit.continueSession();
    expect(fit.summaryLevelUp, isNull);
    fit.finishSession();
    expect(fit.summaryLevelUp?.to.id, diamond);
  });

  test('con el ajuste apagado nunca sale', () {
    fit.toggleLevelHints();
    final r = routineWith([pushUp]);
    workout(r, 8);
    fit.saveAndExit();
    workout(r, 8);
    expect(fit.summaryLevelUp, isNull);
  });

  test('se guarda y vuelve con la copia', () {
    fit.levelStay.add(pushUp);
    fit.levelSeen['negative-dip'] = 123;
    fit.toggleLevelHints();
    final saved = fit.toJson();
    fit.resetAllData();
    fit.applyBackup(saved);
    expect(fit.levelStay, {pushUp});
    expect(fit.levelSeen['negative-dip'], 123);
    expect(fit.levelHints, isFalse);
  });

  group('#262 progresión propia de la rutina', () {
    test('un ejercicio sin cadena de la app sube por la de la rutina', () {
      final bench = fit.matchExerciseByName('Barbell Bench Press')!.id;
      final incline = fit.matchExerciseByName('Barbell Incline Bench Press')!.id;
      expect(nextStepOf(bench), isNull);
      final r = routineWith([bench]);
      fit.setLadder(r.id, bench, [bench, incline]);
      expect(fit.nextStepIn(r, bench), incline);

      workout(r, 8);
      fit.saveAndExit();
      workout(r, 8);
      expect(fit.summaryLevelUp?.to.id, incline);
      fit.levelUpSwap();
      expect(r.exerciseIds, [incline]);
      expect(fit.ladderIn(r, incline), [bench, incline], reason: 'la cadena sigue ahí tras subir');
    });

    test('la de la rutina manda sobre la de la app y puede meter un paso que falta', () {
      final r = routineWith(['uTBt1HV']);
      final hang = fit.matchExerciseByName('Dead Hang')?.id ?? fit.allExercises.firstWhere((e) => e.primary == 'back').id;
      fit.setLadder(r.id, 'uTBt1HV', ['uTBt1HV', hang, 'negative-pull-up']);
      expect(nextStepOf('uTBt1HV'), 'negative-pull-up');
      expect(fit.nextStepIn(r, 'uTBt1HV'), hang);
      expect(fit.nextStepIn(null, 'uTBt1HV'), 'negative-pull-up', reason: 'fuera de la rutina, la de la app');
    });

    test('se guarda, se copia al duplicar y una cadena de un paso no cuenta', () {
      final r = routineWith([pushUp]);
      fit.setLadder(r.id, pushUp, [pushUp, diamond]);
      fit.persistNow();
      fit.loadFromStore();
      final back = fit.routineById(r.id)!;
      expect(back.ladders, [[pushUp, diamond]]);
      final copy = fit.routineById(fit.duplicateRoutine(r.id))!;
      expect(copy.ladders, [[pushUp, diamond]]);
      fit.setLadder(r.id, pushUp, [pushUp]);
      expect(fit.routineById(r.id)!.ladders, isEmpty);
    });

    test('viaja en el JSON de compartir rutinas', () {
      final r = routineWith([pushUp]);
      fit.setLadder(r.id, pushUp, [pushUp, diamond]);
      final json = fit.exportPlanJson([r]);
      expect(json, contains('"progression"'));
      fit.resetAllData();
      fit.applyPlan(parsePlan(json));
      final made = fit.routines.single;
      expect(fit.ladderIn(made, pushUp), [pushUp, diamond]);
    });
  });
}
