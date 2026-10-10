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

  tearDown(() {
    if (fit.session != null) fit.saveAndExit();
  });

  String idOf(String name) => fit.matchExerciseByName(name)!.id;

  LoggedSession day(int ago, List<LoggedExercise> exs) =>
      LoggedSession(DateTime.now().subtract(Duration(days: ago)), 1800, exs);

  group('salto de peso', () {
    test('los botones suman el salto elegido', () {
      final bench = idOf('Barbell Bench Press');
      fit.sessionPicks
        ..clear()
        ..add(bench);
      fit.startSession();
      fit.setSessionWeight(0, 0, 60);

      fit.setWeightStep(2);
      fit.bumpSessionWeight(0, 0, 1);
      expect(fit.session!.exercises[0].sets[0].weight, 62);
    });

    test('kg y lb guardan su propio salto y uno raro no entra', () {
      fit.setWeightStep(1);
      fit.setWeightStep(3);
      expect(fit.weightStep, 1);

      fit.setUnits('lb');
      expect(fit.weightStep, 5);
      fit.setWeightStep(10);
      expect(fit.weightStep, 10);

      fit.setUnits('kg');
      expect(fit.weightStep, 1);
      expect(fit.toJson()['stepKg'], 1);
      expect(fit.toJson()['stepLb'], 10);
    });

    test('los calentamientos siguen redondeando a discos', () {
      fit.setWeightStep(1);
      expect(fit.plateStep, 2.5);
    });
  });

  group('mejor serie y mejor entreno', () {
    test('la mejor serie es la de más 1RM y el mejor entreno el de más volumen', () {
      final bench = idOf('Barbell Bench Press');
      fit.sessions.addAll([
        day(3, [LoggedExercise(bench, 'Bench', 'chest', [LoggedSet(13, 16), LoggedSet(5, 18)])]),
        day(1, [LoggedExercise(bench, 'Bench', 'chest', [LoggedSet(10, 17), LoggedSet(10, 17), LoggedSet(10, 17)])]),
      ]);

      final set = fit.bestSet(bench)!;
      expect((set.set.weight, set.set.reps), (16, 13));

      final work = fit.bestWorkout(bench, PrKind.weight)!;
      expect(work.score, 510);
    });

    test('en un ejercicio de repeticiones el mejor entreno suma repeticiones', () {
      final pull = idOf('Pull Up');
      fit.sessions.add(day(1, [LoggedExercise(pull, 'Pull', 'back', [LoggedSet(8, 0), LoggedSet(6, 0)])]));
      expect(fit.bestWorkout(pull, PrKind.reps)!.score, 14);
      expect(fit.bestSet(pull), isNull);
    });
  });

  group('fusionar ejercicios', () {
    test('el historial pasa al otro y el propio se queda en la biblioteca', () {
      final mine = fit.addCustomExercise(name: 'Mi press', primary: 'chest', equipment: 'Barbell');
      final bench = idOf('Barbell Bench Press');
      fit.sessions.addAll([
        day(2, [LoggedExercise(mine, 'Mi press', 'chest', [LoggedSet(10, 50)])]),
        day(1, [
          LoggedExercise(bench, 'Bench', 'chest', [LoggedSet(8, 60)]),
          LoggedExercise(mine, 'Mi press', 'chest', [LoggedSet(6, 70)]),
        ]),
      ]);

      fit.mergeExerciseInto(mine, bench);

      expect(fit.exerciseHistory(mine), isEmpty);
      expect(fit.exerciseHistory(bench), hasLength(2));
      expect(fit.sessions[1].exercises, hasLength(1), reason: 'el mismo día se juntan las series');
      expect(fit.sessions[1].exercises.single.sets.map((s) => s.reps), [8, 6]);
      expect(fit.exerciseById(mine), isNotNull);
    });

    test('solo se fusiona un ejercicio propio con otro del mismo tipo', () {
      final bench = idOf('Barbell Bench Press');
      final squat = idOf('Barbell Squat');
      fit.sessions.add(day(1, [LoggedExercise(bench, 'Bench', 'chest', [LoggedSet(8, 60)])]));
      fit.mergeExerciseInto(bench, squat);
      expect(fit.exerciseHistory(bench), hasLength(1));

      final run = fit.addCustomExercise(name: 'Mi carrera', primary: 'quads', equipment: 'Bodyweight', mode: 'cardio');
      expect(fit.mergeTargets(run).every((e) => fit.modeOf(e.id) == 'cardio'), isTrue);
      fit.sessions.add(day(2, [LoggedExercise(run, 'Run', 'quads', [LoggedSet(0, 0, sec: 600)])]));
      fit.mergeExerciseInto(run, bench);
      expect(fit.exerciseHistory(run), hasLength(1));
    });
  });
}
