import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#167 músculos secundarios', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

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

  group('músculos sin entrenar', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    String bench() => fit.matchExerciseByName('Bench Press')!.id;

    test('cuenta los días desde la última serie del músculo principal', () {
      final now = DateTime.now();
      fit.sessions.add(LoggedSession(now.subtract(const Duration(days: 9)), 600, [
        LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(8, 60)]),
      ]));
      final days = fit.daysSinceTrained();
      expect(days['chest'], 9);
      expect(days['quads'], isNull);
      expect(fit.untrainedLongest(), isNot(contains('chest')));
      expect(fit.untrainedLongest().length, 3);
    });
  });

  group('recovery', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    String idOf(String name) => fit.matchExerciseByName(name)!.id;

    test('nothing trained means fully recovered', () {
      expect(fit.overallRecovery(), 100);
      expect(fit.stillRecovering(), isEmpty);
    });

    test('a hard chest day tires the chest and it recovers in a few days', () {
      final now = DateTime(2026, 9, 18, 18);
      fit.sessions.add(LoggedSession(now.subtract(const Duration(hours: 1)), 3600, [
        LoggedExercise(idOf('Barbell Bench Press'), 'Bench', 'chest',
            [for (var i = 0; i < 8; i++) LoggedSet(8, 80, rpe: 9)]),
      ]));
      final fresh = fit.muscleRecovery(now: now);
      expect(fresh['chest'], lessThan(0.3));
      expect(fresh['quads'], 1);
      expect(fit.hoursUntilRecovered('chest', now: now), greaterThan(12));
      final later = fit.muscleRecovery(now: now.add(const Duration(days: 4)));
      expect(later['chest'], greaterThan(0.8));
      expect(fit.stillRecovering(now: now), contains('chest'));
    });
  });

  group('músculos de la prensa', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    test('#238 la prensa de piernas trabaja sobre todo cuádriceps', () {
      final press = kExercises.firstWhere((e) => e.name == 'Leg Press');
      expect(press.primary, 'quads');
      expect(press.secondary, containsAll(['glutes', 'hamstrings']));
    });
  });
}
