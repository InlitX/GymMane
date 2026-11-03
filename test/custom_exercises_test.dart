import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('fusionar ejercicios', () {
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

  group('your own exercises', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    test('a catalogue id starting with c is not taken for yours', () {
      expect(fit.isCustom('cycling'), isFalse);
      final mine = fit.addCustomExercise(name: 'Cable thing', primary: 'chest', equipment: 'Barbell');
      expect(fit.isCustom(mine), isTrue);
    });

    test('yours always show up, whatever place is active', () {
      final mine = fit.addCustomExercise(name: 'Mi press raro', primary: 'chest', equipment: 'Barbell');
      final home = fit.addPresetPlace('home');
      fit.setActivePlace(home);
      expect(fit.exercisesMatching('raro').map((e) => e.id), contains(mine));
    });

    test('steps and type travel through a save and back', () {
      final mine = fit.addCustomExercise(
        name: 'Row a la valla',
        primary: 'back',
        equipment: 'Other',
        steps: ['1. Grab the rail', '- Pull', '', 'Lower slowly'],
        mode: 'time',
      );
      final ex = fit.exerciseById(mine)!;
      expect(ex.steps, ['Grab the rail', 'Pull', 'Lower slowly']);
      expect(ex.mode, 'time');
      final back = Exercise.fromJson(ex.toJson());
      expect(back.steps, ex.steps);
      expect(back.mode, 'time');
      fit.updateCustomExercise(mine,
          name: 'Row', primary: 'back', equipment: 'Other', difficulty: 'Beginner', steps: ['Only'], mode: '');
      expect(fit.exerciseById(mine)!.steps, ['Only']);
      expect(fit.modeOf(mine), '');
    });
  });

  group('#99 músculos secundarios propios', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = 'push', String primary = 'chest'}) =>
        LoggedSession(at, 600, [LoggedExercise(id, id, primary, sets)]);

    test('se guardan, viajan en la copia y cuentan en las series', () {
      final id = fit.addCustomExercise(
          name: 'Thruster', primary: 'quads', equipment: 'Dumbbell', secondary: ['shoulders', 'quads', 'triceps']);
      final ex = fit.exerciseById(id)!;
      expect(ex.secondary, ['shoulders', 'triceps'], reason: 'sin repetir el principal');
      final json = ex.toJson();
      expect(json['s'], ['shoulders', 'triceps']);
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(8, 20), LoggedSet(8, 20)], id: id, primary: 'quads'));
      expect(fit.muscleSetsOver(7)['shoulders'], 1);
    });
  });

  group('ejercicios propios en la rutina', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    test('el que te creas aparece al montar la rutina', () {
      final id = fit.addCustomExercise(name: 'Sentadilla búlgara', primary: 'quads', equipment: 'Bodyweight');
      expect(fit.exercisesMatching('').map((e) => e.id), contains(id));
      expect(fit.exercisesMatching('bulgara').map((e) => e.id), contains(id));
    });

    test('el selector de la rutina respeta los filtros de la biblioteca', () {
      fit.setEquipmentFilter('Bodyweight');
      expect(fit.exercisesMatching('').every((e) => e.equipment == 'Bodyweight'), isTrue);
      fit.clearExFilters();
    });
  });
}
