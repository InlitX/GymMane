import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/live_session.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#177 saltar dentro de una superserie', () {
    late List<String> ids;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      ids = fit.allExercises.take(6).map((e) => e.id).toList();
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    String routineWith(String name, List<String> exs) {
      final r = fit.createRoutine(name);
      for (final id in exs) {
        fit.toggleRoutineExercise(r, id);
      }
      return r;
    }

    void finish(int exIdx) {
      for (final st in fit.session!.exercises[exIdx].sets) {
        st.done = true;
      }
    }

    test('la flecha sale de la cadena como al completar la serie', () {
      routineWith('Cadena', ids);
      fit.startRoutine(fit.routines.single);
      final s = fit.session!;
      for (var i = 0; i < 4; i++) {
        s.exercises[i].linkedNext = true;
      }
      for (final i in [0, 1, 3, 4]) {
        finish(i);
      }
      s.currentIndex = 2;

      fit.nextExercise();
      expect(s.currentIndex, 5);
    });

    test('dentro de la cadena va al siguiente que aún tiene series', () {
      routineWith('Cadena', ids);
      fit.startRoutine(fit.routines.single);
      final s = fit.session!;
      for (var i = 0; i < 4; i++) {
        s.exercises[i].linkedNext = true;
      }
      finish(1);
      s.currentIndex = 0;

      fit.nextExercise();
      expect(s.currentIndex, 2);
    });

    test('fuera de una cadena sigue yendo al siguiente de la lista', () {
      routineWith('Suelta', ids.take(3).toList());
      fit.startRoutine(fit.routines.single);
      fit.nextExercise();
      expect(fit.session!.currentIndex, 1);
    });
  });

  group('#266 superserie sin rutina', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      fit.autoAdvance = false;
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    test('se encadena y se separa dentro de la sesión libre', () {
      fit.startWorkout();
      fit.toggleMuscle('chest');
      fit.trainContinue();
      fit.startSession();
      fit.addExerciseToSession(fit.matchExerciseByName('Barbell Squat')!.id);
      final s = fit.session!;
      expect(s.routineId, isNull);
      final last = s.exercises.length - 1;
      fit.toggleSessionLink(last - 1);
      expect(s.exercises[last - 1].linkedNext, isTrue);
      fit.toggleSessionLink(last);
      expect(s.exercises[last].linkedNext, isFalse);
      fit.toggleSessionLink(last - 1);
      expect(s.exercises[last - 1].linkedNext, isFalse);
    });
  });

  group('superseries', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    String bench() => fit.matchExerciseByName('Barbell Bench Press')!.id;

    Routine routineWith(List<String> ids) {
      final id = fit.createRoutine('Push');
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    ({Routine routine, String a, String b}) chainedPair() {
      final squat = fit.matchExerciseByName('Barbell Squat')!.id;
      final r = routineWith([bench(), squat]);
      fit.bumpRoutineSets(r.id, bench(), -1);
      fit.bumpRoutineSets(r.id, squat, -1);
      fit.toggleChain(r.id, bench());
      return (routine: r, a: bench(), b: squat);
    }

    test('el encadenado se guarda y se lee', () {
      final pair = chainedPair();
      expect(fit.chainsToNext(pair.routine, pair.a), isTrue);
      expect(fit.chainsToNext(pair.routine, pair.b), isFalse);

      final saved = fit.toJson();
      fit.resetAllData();
      fit.applyBackup(saved);
      expect(fit.routines.single.chained, {pair.a});
    });

    test('marcar una serie salta al encadenado sin descanso', () {
      final pair = chainedPair();
      fit.startRoutine(pair.routine);
      expect(fit.inSuperset, isTrue);

      fit.toggleSet(0, 0);
      expect(fit.session!.currentIndex, 1);
      expect(fit.session!.restRemaining, isNull);
    });

    test('al cerrar la vuelta descansa y vuelve al primero', () {
      final pair = chainedPair();
      fit.startRoutine(pair.routine);
      fit.session!.exercises[0].sets.add(SessionSet(10, 60, false));
      fit.session!.exercises[1].sets.add(SessionSet(10, 60, false));

      fit.toggleSet(0, 0);
      fit.toggleSet(1, 0);
      expect(fit.session!.restRemaining, isNotNull);
      expect(fit.session!.currentIndex, 0);
    });

    test('sin encadenar sigue el comportamiento de siempre', () async {
      final squat = fit.matchExerciseByName('Barbell Squat')!.id;
      final r = routineWith([bench(), squat]);
      fit.bumpRoutineSets(r.id, bench(), -2);
      fit.startRoutine(r);
      expect(fit.inSuperset, isFalse);
      fit.toggleSet(0, 0);
      expect(fit.session!.restRemaining, isNotNull);
      expect(fit.session!.currentIndex, 0, reason: 'el tic se ve antes de saltar');

      await Future<void>.delayed(WorkoutState.advanceDelay + const Duration(milliseconds: 200));
      expect(fit.session!.currentIndex, 1);
    });
  });
}
