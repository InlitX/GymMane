import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final bench = kExercises.firstWhere((e) => e.equipment == 'Barbell');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.saveAndExit();
    fit.sessions.clear();
    fit.repsOnly.clear();
    fit.repsOnlyOff.clear();
    fit.setUnits('kg');
  });

  LoggedSession log({int daysAgo = 0, List<LoggedSet>? sets}) {
    final s = LoggedSession(
      DateTime.now().subtract(Duration(days: daysAgo)),
      1800,
      [
        LoggedExercise(bench.id, bench.name, bench.primary,
            sets ?? [LoggedSet(10, 60), LoggedSet(8, 70)])
      ],
    );
    fit.sessions.add(s);
    return s;
  }

  group('fixing a workout that was already saved', () {
    test('reps and weight can be corrected and the volume follows', () {
      final s = log();
      final e = s.exercises.single;
      fit.setLoggedReps(e, 0, 12);
      fit.setLoggedWeightShown(e, 0, 65);

      expect(e.sets[0].reps, 12);
      expect(e.sets[0].weight, 65);
      expect(s.volume, 12 * 65 + 8 * 70);
    });

    test('a set can be added and removed, and the last one takes the exercise', () {
      final s = log(sets: [LoggedSet(10, 60)]);
      final e = s.exercises.single;

      fit.addLoggedSet(e);
      expect(e.sets.length, 2);
      expect(e.sets[1].reps, 10, reason: 'copia la última serie');

      fit.removeLoggedSet(s, e, 1);
      expect(e.sets.length, 1);

      fit.removeLoggedSet(s, e, 0);
      expect(fit.sessions, isEmpty, reason: 'sin series no queda ejercicio ni sesión');
    });

    test('the correction survives a restart', () async {
      final s = log();
      fit.setLoggedReps(s.exercises.single, 1, 6);
      fit.persistNow();

      fit.sessions.clear();
      fit.loadFromStore();
      expect(fit.sessions.single.exercises.single.sets[1].reps, 6);
    });

    test('in pounds the typed number is converted, not stored raw', () {
      final s = log();
      fit.setUnits('lb');
      fit.setLoggedWeightShown(s.exercises.single, 0, 100);
      expect(s.exercises.single.sets[0].weight, closeTo(45.36, 0.01));
      expect(fit.weightValue(s.exercises.single.sets[0].weight), '100');
    });
  });

  group('picking a finished workout back up', () {
    test('it becomes the live session again with its sets already ticked', () {
      final s = log();
      fit.resumeLoggedSession(s);

      expect(fit.sessions, isEmpty, reason: 'sale del historial mientras se retoma');
      expect(fit.isSessionActive, true);
      expect(fit.route, 'session');
      final live = fit.session!.exercises.single;
      expect(live.sets.map((x) => x.done), everyElement(true));
      expect(live.sets.length, 2);
      expect(fit.sessionElapsed, greaterThanOrEqualTo(1800));
    });

    test('finishing it again files it on its original day, not today', () {
      final s = log(daysAgo: 3);
      final day = s.date;
      fit.resumeLoggedSession(s);
      fit.addSet(0);
      fit.toggleSet(0, 2);
      fit.finishSession();

      final saved = fit.sessions.single;
      expect(saved.date, day);
      expect(saved.exercises.single.sets.length, 3);
    });

    test('the history stays in order after finishing an older workout', () {
      log(daysAgo: 1);
      final old = log(daysAgo: 5);
      fit.resumeLoggedSession(old);
      fit.finishSession();

      final dates = fit.sessions.map((s) => s.date).toList();
      expect(dates, orderedEquals([...dates]..sort()));
      expect(fit.sessions.length, 2);
    });

    test('a workout in progress is never overwritten by a resume', () {
      fit.startWorkout();
      fit.toggleMuscle('chest');
      fit.trainContinue();
      fit.startSession();
      final live = fit.session;

      final s = log(daysAgo: 2);
      fit.resumeLoggedSession(s);
      expect(identical(fit.session, live), true);
      expect(fit.sessions.single, s);
    });
  });
}
