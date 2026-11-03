import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/profile.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String a, b, c;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.saveAndExit();
    fit.sessions.clear();
    fit.routines.clear();
    fit.onboarded = true;
    final ids = fit.allExercises.take(3).map((e) => e.id).toList();
    a = ids[0];
    b = ids[1];
    c = ids[2];
  });

  String routineWithThree() {
    final r = fit.createRoutine('Test');
    for (final id in [a, b, c]) {
      fit.toggleRoutineExercise(r, id);
    }
    return r;
  }

  group('reordering a routine', () {
    test('moving an exercise down lands it where you dropped it', () {
      final r = routineWithThree();
      fit.reorderRoutineExercise(r, 0, 3);
      expect(fit.routines.single.exerciseIds, [b, c, a]);
    });

    test('moving an exercise up lands it where you dropped it', () {
      final r = routineWithThree();
      fit.reorderRoutineExercise(r, 2, 0);
      expect(fit.routines.single.exerciseIds, [c, a, b]);
    });

    test('the new order is what you actually train', () {
      final r = routineWithThree();
      fit.reorderRoutineExercise(r, 2, 0);
      fit.startRoutine(fit.routines.single);
      expect(fit.session!.exercises.map((e) => e.id), [c, a, b]);
      fit.saveAndExit();
    });

    test('the order survives a restart', () async {
      final r = routineWithThree();
      fit.reorderRoutineExercise(r, 0, 3);
      await pumpEventQueue();
      fit.loadFromStore();
      expect(fit.routines.single.exerciseIds, [b, c, a]);
    });

    test('nonsense indices are ignored instead of crashing', () {
      final r = routineWithThree();
      fit.reorderRoutineExercise(r, 9, 0);
      fit.reorderRoutineExercise(r, -1, 0);
      fit.reorderRoutineExercise('no-existe', 0, 1);
      expect(fit.routines.single.exerciseIds, [a, b, c]);
    });
  });

  group('editing a workout in progress', () {
    void start() => fit.startRoutine(fit.routines.first);

    test('an exercise can be dropped mid-workout', () {
      routineWithThree();
      start();
      expect(fit.session!.exercises.length, 3);

      fit.removeSessionExercise(1);
      expect(fit.session!.exercises.map((e) => e.id), [a, c]);
      fit.saveAndExit();
    });

    test('dropping the one you are on does not leave you out of bounds', () {
      routineWithThree();
      start();
      fit.nextExercise();
      fit.nextExercise();
      expect(fit.session!.currentIndex, 2);

      fit.removeSessionExercise(2);
      expect(fit.session!.currentIndex, 1, reason: 'el índice se recoloca');
      expect(fit.currentExercise, isNotNull);
      fit.saveAndExit();
    });

    test('dropping the last one ends the workout instead of leaving it empty', () {
      routineWithThree();
      start();
      fit.removeSessionExercise(0);
      fit.removeSessionExercise(0);
      fit.removeSessionExercise(0);
      expect(fit.session, isNull);
      expect(fit.route, 'home');
    });

    test('an exercise can be added to a workout already going', () {
      final r = fit.createRoutine('Solo uno');
      fit.toggleRoutineExercise(r, a);
      fit.startRoutine(fit.routines.single);
      expect(fit.session!.exercises.length, 1);

      fit.addExerciseToSession(b);
      expect(fit.session!.exercises.map((e) => e.id), [a, b]);
      expect(fit.session!.currentIndex, 1, reason: 'te lleva al que acabas de añadir');
      fit.saveAndExit();
    });

    test('an added exercise comes right after the current one', () {
      final r = fit.createRoutine('Dos');
      fit.toggleRoutineExercise(r, a);
      fit.toggleRoutineExercise(r, c);
      fit.startRoutine(fit.routines.single);

      fit.addExerciseToSession(b);
      expect(fit.session!.exercises.map((e) => e.id), [a, b, c]);
      expect(fit.session!.currentIndex, 1);
      fit.saveAndExit();
    });

    test('an added exercise never splits a superset', () {
      final r = fit.createRoutine('Dos');
      fit.toggleRoutineExercise(r, a);
      fit.toggleRoutineExercise(r, b);
      fit.startRoutine(fit.routines.single);
      fit.session!.exercises[0].linkedNext = true;

      fit.addExerciseToSession(c);
      expect(fit.session!.exercises.map((e) => e.id), [a, b, c]);
      expect(fit.session!.exercises[0].linkedNext, isTrue);
      expect(fit.session!.currentIndex, 2);
      fit.saveAndExit();
    });

    test('the same exercise cannot be added twice', () {
      routineWithThree();
      start();
      fit.addExerciseToSession(a);
      expect(fit.session!.exercises.length, 3);
      fit.saveAndExit();
    });

    test('a dropped exercise stays dropped after a kill', () async {
      routineWithThree();
      start();
      fit.removeSessionExercise(0);
      fit.persistNow();

      fit.session = null;
      fit.loadFromStore();
      expect(fit.session!.exercises.map((e) => e.id), [b, c]);
      fit.saveAndExit();
    });
  });

  group('deleting everything', () {
    test('reset wipes the lot and puts you back at the welcome', () async {
      routineWithThree();
      fit.addBodyweight(75);
      fit.saveNote(
          exerciseId: a, date: DateTime.now(), kind: NoteKind.note, text: 'una nota');
      fit.toggleFavorite(a);
      fit.updateProfile(name: 'Alex');
      fit.startRoutine(fit.routines.single);

      fit.resetAllData();

      expect(fit.sessions, isEmpty);
      expect(fit.routines, isEmpty);
      expect(fit.bodyweight, isEmpty);
      expect(fit.notesFor(a), isEmpty);
      expect(fit.favorites, isEmpty);
      expect(fit.session, isNull);
      expect(fit.profile.name, kDefaultName);
      expect(fit.onboarded, false, reason: 'vuelve a estar recién instalada');
      expect(fit.route, 'home');
    });

    test('the wipe reaches the disk', () async {
      routineWithThree();
      fit.addBodyweight(75);
      fit.resetAllData();
      await pumpEventQueue();

      fit.loadFromStore();
      expect(fit.routines, isEmpty, reason: 'no puede resucitar al reabrir');
      expect(fit.bodyweight, isEmpty);
      expect(fit.onboarded, false);
    });
  });

  group('nuevo en este entreno', () {
    test('un ejercicio metido de más se puede añadir solo y en su sitio, con sus series', () {
      final r = fit.createRoutine('Test');
      fit.toggleRoutineExercise(r, a);
      fit.toggleRoutineExercise(r, c);
      fit.startRoutine(fit.routines.single);
      fit.addExerciseToSession(b);
      final s = fit.session!;
      for (var i = 0; i < s.exercises.length; i++) {
        fit.toggleSet(i, 0);
      }
      s.exercises[1].sets.first
        ..reps = 12
        ..weight = 30;
      fit.finishSession();
      expect(s.exercises.map((e) => e.id), [a, b, c]);
      expect(fit.sessionExtras.map((e) => e.id), [b]);
      expect(fit.addExtraToRoutine(b), isTrue);
      expect(fit.routines.single.exerciseIds, [a, b, c]);
      final plan = fit.plannedSets(fit.routines.single, b);
      expect(plan.length, 1);
      expect((plan.single.reps, plan.single.weightKg), (12, 30.0));
      expect(fit.sessionExtras, isEmpty);
      expect(fit.addExtraToRoutine(b), isFalse);
      fit.saveAndExit();
    });

    test('sin series hechas o sin rutina no hay nada que ofrecer', () {
      final r = fit.createRoutine('Test');
      fit.toggleRoutineExercise(r, a);
      fit.startRoutine(fit.routines.single);
      fit.addExerciseToSession(b);
      fit.toggleSet(0, 0);
      fit.finishSession();
      expect(fit.sessionExtras, isEmpty);
      fit.saveAndExit();
    });
  });

  group('ajustar series por músculo', () {
    late String chest, legs, r;

    setUp(() {
      fit.muscleTune = true;
      final free = fit.allExercises.where((e) => fit.modeOf(e.id).isEmpty && !fit.isAssisted(e.id));
      chest = free.firstWhere((e) => e.primary == 'chest').id;
      legs = free.firstWhere((e) => e.primary == 'quads').id;
      r = fit.createRoutine('Torso');
      fit.toggleRoutineExercise(r, chest);
      fit.toggleRoutineExercise(r, legs);
    });

    tearDown(fit.saveAndExit);

    void trainChest(int sets) {
      fit.startRoutine(fit.routines.single);
      fit.endCountdown();
      final ex = fit.session!.exercises.first;
      var done = 0;
      for (var i = 0; i < ex.sets.length && done < sets; i++) {
        if (!ex.sets[i].counts) continue;
        fit.toggleSet(0, i);
        done++;
      }
      fit.finishSession();
    }

    test('solo pregunta por los músculos con al menos dos series', () {
      trainChest(2);
      expect(fit.tuneTargets.map((m) => m.muscle), ['chest']);
    });

    test('me faltó suma una serie, me pasé la quita y cambiar de idea lo deshace', () {
      final routine = fit.routines.single;
      final before = fit.routineSets(routine, chest);
      trainChest(2);
      fit.voteMuscle('chest', 1);
      expect(fit.routineSets(routine, chest), before + 1);
      expect(fit.sessionEditedRoutine, isFalse, reason: 'no propone deshacerlo al guardar');
      fit.voteMuscle('chest', -1);
      expect(fit.routineSets(routine, chest), before - 1);
      fit.voteMuscle('chest', 0);
      expect(fit.routineSets(routine, chest), before);
      expect(fit.muscleVote('chest'), 0);
      fit.voteMuscle('chest', null);
      expect(fit.muscleVote('chest'), isNull);
    });

    test('seguir entrenando deshace lo votado', () {
      final routine = fit.routines.single;
      final before = fit.routineSets(routine, chest);
      trainChest(2);
      fit.voteMuscle('chest', 1);
      fit.continueSession();
      expect(fit.routineSets(routine, chest), before);
    });

    test('apagado, no pregunta', () {
      fit.muscleTune = false;
      trainChest(2);
      expect(fit.tuneTargets, isEmpty);
      fit.muscleTune = true;
    });
  });
}
