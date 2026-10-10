import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
  });

  group('#179 filtro de trapecio', () {
    test('trapecio, antebrazo y oblicuos salen en el filtro y encuentran ejercicios', () {
      for (final m in ['trapezius', 'forearm', 'obliques']) {
        expect(kFilterMuscles, contains(m));
        fit.setMuscleFilter(m);
        expect(fit.exercisesFiltered, isNotEmpty, reason: m);
        expect(
            fit.exercisesFiltered.every((e) => e.primary == m || e.secondary.contains(m)), isTrue);
        fit.setMuscleFilter(m);
      }
    });
  });

  group('#183 ejercicio por tiempo sin peso', () {
    test('uno propio por tiempo con barra empieza sin peso', () {
      final id = fit.addCustomExercise(
          name: 'Sweep', primary: 'abdomen', equipment: 'Barbell', mode: 'time');
      expect(fit.isRepsOnly(id), isTrue);
    });

    test('si ya lo hizo con peso, el peso sigue', () {
      final id = fit.addCustomExercise(
          name: 'Sweep', primary: 'abdomen', equipment: 'Barbell', mode: 'time');
      fit.sessions.add(LoggedSession(DateTime.now(), 600, [
        LoggedExercise(id, 'Sweep', 'abdomen', [LoggedSet(0, 10, sec: 30)]),
      ]));
      expect(fit.isRepsOnly(id), isFalse);
    });

    test('se puede volver a poner el peso', () {
      final id = fit.addCustomExercise(
          name: 'Sweep', primary: 'abdomen', equipment: 'Barbell', mode: 'time');
      fit.toggleRepsOnly(id);
      expect(fit.isRepsOnly(id), isFalse);
    });

    test('los de carga siguen con peso y los de reps no cambian', () {
      expect(fit.isRepsOnly('kettlebell-farmer-carry'), isFalse);
      expect(fit.isRepsOnly('cable-pallof-hold'), isFalse);
      expect(fit.isRepsOnly('jump-rope'), isTrue);
      final barbell = fit.allExercises.firstWhere((e) => e.equipment == 'Barbell' && fit.modeOf(e.id).isEmpty);
      expect(fit.isRepsOnly(barbell.id), isFalse);
    });
  });

  group('#180 duración de la sesión', () {
    test('se corrige y se guarda', () {
      final s = LoggedSession(DateTime.now(), 108 * 60, [
        LoggedExercise('x', 'x', 'chest', [LoggedSet(8, 60)]),
      ]);
      fit.sessions.add(s);
      fit.setSessionDuration(s, 45 * 60);
      expect(fit.daySummary(DateTime.now())!.durationSec, 45 * 60);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.sessions.single.durationSec, 45 * 60);
    });
  });

  group('#181 negro AMOLED', () {
    test('es un tema oscuro aparte y se recuerda', () {
      fit.setThemePref('amoled');
      expect(fit.dark, isTrue);
      expect(fit.themeMode, ThemeMode.dark);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.themePref, 'amoled');
      fit.setThemePref('dark');
      expect(fit.themePref, 'dark');
    });
  });

  group('#167 músculos secundarios', () {
    test('se cambian en un ejercicio de la app, se guardan y se pueden restablecer', () {
      final ex = fit.allExercises.firstWhere((e) => e.secondary.length == 1 && e.primary == 'chest');
      final before = [...ex.secondary];
      fit.setSecondary(ex.id, [...before, 'shoulders']);
      expect(fit.exerciseById(ex.id)!.secondary, containsAll([...before, 'shoulders']));
      fit.setMuscleFilter('shoulders');
      expect(fit.exercisesFiltered.map((e) => e.id), contains(ex.id));
      fit.setMuscleFilter('shoulders');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.exerciseById(ex.id)!.secondary, contains('shoulders'));
      fit.resetSecondary(ex.id);
      expect(fit.exerciseById(ex.id)!.secondary, before);
      expect(fit.hasSecondaryOverride(ex.id), isFalse);
    });

    test('volver a lo de siempre no deja nada guardado y el primario no cuenta', () {
      final ex = fit.allExercises.firstWhere((e) => e.secondary.isNotEmpty);
      fit.setSecondary(ex.id, [...ex.secondary, ex.primary]);
      expect(fit.hasSecondaryOverride(ex.id), isFalse);
      expect(fit.exerciseById(ex.id)!.secondary, isNot(contains(ex.primary)));
    });

    test('en uno propio cambia el ejercicio', () {
      final id = fit.addCustomExercise(name: 'Mío', primary: 'chest', equipment: 'Dumbbell');
      fit.setSecondary(id, ['triceps']);
      expect(fit.exerciseById(id)!.secondary, ['triceps']);
      expect(fit.hasSecondaryOverride(id), isFalse);
    });
  });
}
