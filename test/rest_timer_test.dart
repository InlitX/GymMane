import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#204 descanso a mano', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    Routine routineOf(List<String> ids) {
      final id = fit.createRoutine('Core');
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    void rest() {
      final bench = fit.matchExerciseByName('Bench Press')!.id;
      fit.startRoutine(routineOf([bench]));
      fit.endCountdown();
      fit.toggleSet(0, 0);
      expect(fit.session!.restRemaining, isNotNull);
    }

    test('una serie puede llevar su propio descanso solo hoy', () {
      final bench = fit.matchExerciseByName('Bench Press')!.id;
      fit.startRoutine(routineOf([bench]));
      fit.endCountdown();
      final normal = fit.normalRestAfter(0, 0);
      fit.setSetRest(0, 0, 240);
      fit.toggleSet(0, 0);
      expect(fit.restTotal, 240);
      fit.skipRest();
      fit.setSetRest(0, 1, 0);
      fit.toggleSet(0, 1);
      expect(fit.session!.restRemaining, isNull);
      fit.setSetRest(0, 2, 30);
      fit.setSetRest(0, 2, null);
      fit.toggleSet(0, 2);
      expect(fit.restTotal, normal);
      fit.skipRest();
      final saved = fit.session!.toJson();
      expect(((saved['ex'] as List).first['s'] as List).first['rs'], 240);
      fit.saveAndExit();
    });

    test('#346 descanso al cambiar de ejercicio tras la última serie', () {
      final bench = fit.matchExerciseByName('Bench Press')!.id;
      final squat = fit.matchExerciseByName('Squat')!.id;
      fit.startRoutine(routineOf([bench, squat]));
      fit.endCountdown();
      fit.setChangeRest(150);
      final n = fit.session!.exercises[0].sets.length;
      final normal = fit.normalRestAfter(0, 0);
      expect(normal, isNot(150));
      for (var i = 0; i < n - 1; i++) {
        fit.toggleSet(0, i);
        expect(fit.restTotal, normal);
        fit.skipRest();
      }
      expect(fit.normalRestAfter(0, n - 1), 150);
      fit.toggleSet(0, n - 1);
      expect(fit.restTotal, 150);
      fit.skipRest();
      fit.setChangeRest(0);
      fit.saveAndExit();
    });

    test('#357 descanso entre lados: el primer check cierra un lado', () {
      final curl = fit.matchExerciseByName('Dumbbell Curl')!.id;
      if (!fit.isSidedReps(curl)) fit.toggleSidedReps(curl);
      fit.startRoutine(routineOf([curl]));
      fit.endCountdown();
      fit.setSideRest(30);
      final st = fit.session!.exercises[0].sets.firstWhere((x) => x.repsR != null);
      final j = fit.session!.exercises[0].sets.indexOf(st);
      fit.toggleSet(0, j);
      expect(st.half, isTrue);
      expect(st.done, isFalse);
      expect(fit.restTotal, 30);
      expect(fit.session!.restSwitch, isTrue);
      fit.toggleSet(0, j);
      expect(st.done, isTrue);
      expect(st.half, isFalse);
      expect(fit.session!.restSwitch, isFalse);
      fit.skipRest();
      fit.setSideRest(0);
      fit.toggleSet(0, j);
      fit.toggleSet(0, j);
      expect(st.done, isTrue);
      expect(st.half, isFalse);
      fit.toggleSidedReps(curl);
      fit.saveAndExit();
    });

    test('fija el descanso al tiempo elegido', () {
      rest();
      fit.setRest(200);
      expect(fit.restTotal, 200);
      expect(fit.session!.restRemaining, inInclusiveRange(199, 200));
      fit.skipRest();
    });

    test('cero lo salta y el tope es de diez minutos', () {
      rest();
      fit.setRest(5000);
      expect(fit.session!.restRemaining, inInclusiveRange(599, 600));
      fit.setRest(0);
      expect(fit.session!.restRemaining, isNull);
    });

    test('con la sesión en pausa se queda congelado en el tiempo nuevo', () {
      rest();
      fit.toggleSessionPause();
      fit.setRest(90);
      expect(fit.session!.restFrozen, 90);
      expect(fit.session!.restRemaining, 90);
      fit.toggleSessionPause();
      expect(fit.session!.restRemaining, inInclusiveRange(89, 90));
      fit.skipRest();
    });
  });

  group('descanso', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    String bench() => fit.matchExerciseByName('Bench Press')!.id;

    Routine routine(String name, [List<String>? ids]) {
      final id = fit.createRoutine(name);
      for (final e in ids ?? [bench()]) {
        fit.toggleRoutineExercise(id, e);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    test('quitar segundos baja la barra y sumar la alarga', () {
      final r = routine('A');
      fit.setRoutineRest(r.id, bench(), 120);
      fit.startRoutine(r);
      fit.endCountdown();
      fit.toggleSet(0, 0);
      expect(fit.restTotal, 120);
      fit.nudgeRest(-15);
      fit.nudgeRest(-15);
      expect(fit.restTotal, 120);
      expect(fit.session!.restRemaining, lessThanOrEqualTo(90));
      fit.nudgeRest(60);
      expect(fit.restTotal, greaterThanOrEqualTo(fit.session!.restRemaining!));
      fit.skipRest();
    });

    test('cuando el aviso nativo dice que acabó, se cierra el descanso', () {
      final r = routine('A');
      fit.startRoutine(r);
      fit.endCountdown();
      fit.toggleSet(0, 0);
      final s = fit.session!;
      s.restEndsAt = DateTime.now().subtract(const Duration(seconds: 1));
      final tick = fit.restDoneTick;
      fit.restElapsed();
      expect(s.restEndsAt, isNull);
      expect(fit.restDoneTick, tick + 1);
      fit.restElapsed();
      expect(fit.restDoneTick, tick + 1);
    });
  });

  group('#218 segundo aviso', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('solo acepta las opciones de la hoja y se guarda', () {
      expect(fit.trainAgainMin, 0);
      fit.setTrainAgain(45);
      expect(fit.trainAgainMin, 0);
      fit.setTrainAgain(120);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.resetAllData();
      expect(fit.trainAgainMin, 0);
      fit.applyBackup(data);
      expect(fit.trainAgainMin, 120);
    });
  });

  group('#286 descanso corto en rest-pause y cluster', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setRestSeconds(120);
    });

    void start() {
      final id = fit.createRoutine('RP');
      fit.toggleRoutineExercise(id, fit.matchExerciseByName('Bench Press')!.id);
      fit.startRoutine(fit.routines.firstWhere((r) => r.id == id));
      fit.endCountdown();
      fit.addSet(0);
    }

    test('antes de una serie rest-pause usa el descanso corto', () {
      fit.setMiniRest(25);
      start();
      final last = fit.session!.exercises[0].sets.length - 1;
      fit.setSetKind(0, last, SetKind.restPause);
      fit.toggleSet(0, last - 1);
      expect(fit.restTotal, 25);
    });

    test('las series normales siguen con el descanso de siempre', () {
      start();
      fit.toggleSet(0, 0);
      expect(fit.restTotal, 120);
    });

    test('a cero, el cluster usa el descanso normal', () {
      fit.setMiniRest(0);
      start();
      final last = fit.session!.exercises[0].sets.length - 1;
      fit.setSetKind(0, last, SetKind.cluster);
      fit.toggleSet(0, last - 1);
      expect(fit.restTotal, 120);
    });
  });
}
