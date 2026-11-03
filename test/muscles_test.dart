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
      fit.sessions.add(LoggedSession(DateTime(now.year, now.month, now.day - 9, 12), 600, [
        LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(8, 60)]),
      ]));
      final days = fit.daysSinceTrained();
      expect(days['chest'], 9);
      expect(days['quads'], isNull);
      expect(fit.untrainedLongest(), isNot(contains('chest')));
      expect(fit.untrainedLongest().length, 3);
    });

    test('#300 el cardio no suma series al músculo aunque lleve uno', () {
      final run = fit.addCustomExercise(name: 'Escaladora', primary: 'quads', equipment: 'Machine', mode: 'cardio');
      final walk = fit.addCustomExercise(name: 'Cinta', primary: 'quads', equipment: 'Machine', kind: 'cardio');
      final now = DateTime.now();
      fit.sessions.add(LoggedSession(now, 1800, [
        LoggedExercise(run, 'Escaladora', 'quads', [LoggedSet(1, 0, sec: 1200)]),
        LoggedExercise(walk, 'Cinta', 'quads', [LoggedSet(1, 0, sec: 900)]),
        LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(8, 60), LoggedSet(8, 60)]),
      ]));
      final sets = fit.muscleSetsOver(7);
      expect(sets['quads'], isNull);
      expect(sets['chest'], 2);
      expect(fit.countsForMuscles(bench()), isTrue);
      expect(fit.countsForMuscles(run), isFalse);
      final treadmill = fit.allExercises.firstWhere((e) => fit.kindOf(e) == 'cardio');
      expect(fit.countsForMuscles(treadmill.id), isFalse);
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

    test('dice cuándo pasa a recuperando y cuándo a listo', () {
      final now = DateTime(2026, 9, 18, 18);
      fit.sessions.add(LoggedSession(now.subtract(const Duration(hours: 1)), 3600, [
        LoggedExercise(idOf('Barbell Bench Press'), 'Bench', 'chest',
            [for (var i = 0; i < 8; i++) LoggedSet(8, 80, rpe: 9)]),
      ]));
      final mid = fit.hoursUntilRecovery('chest', 0.5, now: now)!;
      final ready = fit.hoursUntilRecovery('chest', 0.8, now: now)!;
      expect(ready, greaterThan(mid));
      expect(ready, fit.hoursUntilRecovered('chest', now: now));
      expect(fit.muscleRecovery(now: now.add(Duration(hours: mid)))['chest'], greaterThanOrEqualTo(0.5));
      expect(fit.muscleRecovery(now: now.add(Duration(hours: ready)))['chest'], greaterThanOrEqualTo(0.8));
      expect(fit.hoursUntilRecovery('quads', 0.8, now: now), isNull);
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
