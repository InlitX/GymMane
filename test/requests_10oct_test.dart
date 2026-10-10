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
}
