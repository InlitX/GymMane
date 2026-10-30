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
