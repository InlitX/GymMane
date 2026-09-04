import 'package:flutter_test/flutter_test.dart';
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
    fit.setUnits('kg');
  });

  void startChestSession() {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    for (final id in fit.sessionPicks.toList().skip(1)) {
      fit.togglePick(id);
    }
    fit.startSession();
  }

  test('a warm-up set stays out of the volume and the set count', () {
    startChestSession();
    fit.addSet(0);

    fit.setSetKind(0, 0, SetKind.warmup);
    fit.setSessionReps(0, 0, 10);
    fit.setSessionWeight(0, 0, 20);
    fit.toggleSet(0, 0);

    fit.setSessionReps(0, 1, 5);
    fit.setSessionWeight(0, 1, 100);
    fit.toggleSet(0, 1);

    fit.finishSession();

    expect(fit.session!.summarySets, 1, reason: 'solo cuenta la efectiva');
    expect(fit.session!.summaryVolume, 500);

    final logged = fit.sessions.single.exercises.single;
    expect(logged.sets, hasLength(2), reason: 'el calentamiento se guarda igual');
    expect(logged.workingSets, hasLength(1));
    expect(logged.volume, closeTo(500, 0.01));
    expect(logged.topWeight, 100, reason: 'el calentamiento no marca récord');
    expect(fit.sessions.single.setCount, 1);
  });

  test('an exercise that is only warm-up does not blow up the records', () {
    startChestSession();
    fit.setSetKind(0, 0, SetKind.warmup);
    fit.setSessionReps(0, 0, 10);
    fit.setSessionWeight(0, 0, 20);
    fit.toggleSet(0, 0);
    fit.finishSession();

    final logged = fit.sessions.single.exercises.single;
    expect(logged.topWeight, 0);
    expect(logged.bestOneRm, 0);
    expect(logged.volume, 0);
  });

  test('drop and failure sets still count as work', () {
    startChestSession();
    fit.setSetKind(0, 0, SetKind.failure);
    fit.setSessionReps(0, 0, 8);
    fit.setSessionWeight(0, 0, 60);
    fit.toggleSet(0, 0);
    fit.finishSession();

    expect(fit.session!.summarySets, 1);
    expect(fit.sessions.single.exercises.single.volume, closeTo(480, 0.01));
  });

  test('the kind survives a save and a reload of the live session', () {
    startChestSession();
    fit.setSetKind(0, 0, SetKind.drop);
    fit.persistNow();

    fit.session = null;
    fit.loadFromStore();
    expect(fit.session!.exercises.first.sets.first.kind, SetKind.drop);
  });

  test('a new set copies the kind of the one above it', () {
    startChestSession();
    final last = fit.session!.exercises.first.sets.length - 1;
    fit.setSetKind(0, last, SetKind.warmup);
    fit.addSet(0);
    expect(fit.session!.exercises.first.sets.last.kind, SetKind.warmup);
  });

  test('an old backup with no kind reads as a working set', () {
    final set = LoggedSet.fromJson({'r': 8, 'w': 60.0});
    expect(set.kind, SetKind.normal);
    expect(set.counts, true);
  });

  group('automatic warm-up', () {
    test('it lays three ramp sets before the working ones', () {
      startChestSession();
      fit.setSessionWeight(0, 0, 100);
      final before = fit.session!.exercises.first.sets.length;

      fit.addWarmupSets(0);
      final sets = fit.session!.exercises.first.sets;

      expect(sets, hasLength(before + 3));
      expect(sets.take(3).every((s) => s.kind == SetKind.warmup), true);
      expect(sets.take(3).map((s) => s.weight), [40, 60, 80]);
      expect(sets.take(3).map((s) => s.reps), [10, 5, 3]);
      expect(sets[3].kind, SetKind.normal);
    });

    test('it will not stack a second ramp on top', () {
      startChestSession();
      fit.setSessionWeight(0, 0, 100);
      fit.addWarmupSets(0);
      final after = fit.session!.exercises.first.sets.length;
      fit.addWarmupSets(0);
      expect(fit.session!.exercises.first.sets, hasLength(after));
    });

    test('with no weight on the bar there is nothing to ramp up to', () {
      startChestSession();
      for (var i = 0; i < fit.session!.exercises.first.sets.length; i++) {
        fit.setSessionWeight(0, i, 0);
      }
      fit.addWarmupSets(0);
      expect(fit.hasWarmup(0), false);
    });

    test('the ramp rounds to the plates you actually have', () {
      startChestSession();
      fit.setUnits('kg');
      fit.setSessionWeight(0, 0, 62.5);
      fit.addWarmupSets(0);
      expect(fit.session!.exercises.first.sets.first.weight, 25);
    });
  });

  group('plates per side', () {
    test('a barbell weight is broken down, in kilos and in pounds', () {
      fit.setUnits('kg');
      expect(fit.plateHint('Barbell', 100), '25 · 15');
      expect(fit.plateHint('Barbell', 20), isNull, reason: 'la barra sola no lleva discos');
      expect(fit.plateHint('Dumbbell', 100), isNull);

      fit.setUnits('lb');
      expect(fit.plateHint('Barbell', 100), isNotNull);
      fit.setUnits('kg');
    });

    test('an odd weight is broken down as far as the plates allow', () {
      fit.setUnits('kg');
      expect(fit.plateHint('Barbell', 62.5), '20 · 1.25');
    });
  });

  group('rest per exercise', () {
    test('falls back to the global rest until you change it', () {
      fit.setRestSeconds(90);
      expect(fit.restFor('anything'), 90);
      expect(fit.hasCustomRest('anything'), false);

      fit.setExerciseRest('anything', 180);
      expect(fit.restFor('anything'), 180);
      expect(fit.hasCustomRest('anything'), true);
      expect(fit.restFor('another'), 90);
    });

    test('it is clamped to something sane and can be handed back', () {
      fit.setExerciseRest('x', 5);
      expect(fit.restFor('x'), 15);
      fit.setExerciseRest('x', 9000);
      expect(fit.restFor('x'), 600);

      fit.setExerciseRest('x', null);
      expect(fit.hasCustomRest('x'), false);
    });

    test('it survives a save and a reload', () {
      fit.setExerciseRest('bench', 150);
      fit.persistNow();

      fit.exerciseRest.clear();
      fit.loadFromStore();
      expect(fit.restFor('bench'), 150);
    });

    test('the session rest timer uses the exercise value', () {
      startChestSession();
      final id = fit.session!.exercises.first.id;
      fit.setRestSeconds(60);
      fit.setExerciseRest(id, 210);

      fit.startRest();
      expect(fit.session!.restRemaining, 210);
      fit.skipRest();
    });
  });
}
