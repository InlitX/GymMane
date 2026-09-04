import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final pullUp = kExercises.firstWhere((e) => e.equipment == 'Bodyweight');
  final bench = kExercises.firstWhere((e) => e.equipment == 'Barbell');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.saveAndExit();
    fit.sessions.clear();
    fit.repsOnly.clear();
    fit.repsOnlyOff.clear();
    fit.exEquipmentFilter = null;
    fit.clearExFilters();
  });

  void log(String id, double kg) => fit.sessions.add(LoggedSession(DateTime.now(), 600, [
        LoggedExercise(id, 'x', 'chest', [LoggedSet(8, kg)])
      ]));

  test('a bodyweight exercise starts without weight, a barbell one does not', () {
    expect(fit.isRepsOnly(pullUp.id), true);
    expect(fit.isRepsOnly(bench.id), false);
  });

  test('history with lastre wins over the guess', () {
    log(pullUp.id, 20);
    expect(fit.isRepsOnly(pullUp.id), false, reason: 'ya lo ha cargado con peso');
  });

  test('the toggle sticks in both directions and survives a restart', () async {
    fit.toggleRepsOnly(bench.id);
    expect(fit.isRepsOnly(bench.id), true);

    fit.toggleRepsOnly(pullUp.id);
    expect(fit.isRepsOnly(pullUp.id), false, reason: 'desmarcarlo manda sobre el material');

    fit.persistNow();
    fit.repsOnly.clear();
    fit.repsOnlyOff.clear();
    fit.loadFromStore();
    expect(fit.isRepsOnly(bench.id), true);
    expect(fit.isRepsOnly(pullUp.id), false);
  });

  test('a fresh session opens reps-only exercises at zero weight', () {
    fit.sessionPicks
      ..clear()
      ..addAll([pullUp.id, bench.id]);
    fit.startSession();

    final sets = {for (final e in fit.session!.exercises) e.id: e.sets};
    expect(sets[pullUp.id]!.every((s) => s.weight == 0), true);
    expect(sets[bench.id]!.every((s) => s.weight > 0), true);
  });

  test('adding one mid-session respects the flag too', () {
    fit.sessionPicks
      ..clear()
      ..add(bench.id);
    fit.startSession();
    fit.addExerciseToSession(pullUp.id);

    final added = fit.session!.exercises.last;
    expect(added.id, pullUp.id);
    expect(added.sets.every((s) => s.weight == 0), true);
    expect(fit.inSession(pullUp.id), true);
  });

  test('the same exercise is never added twice', () {
    fit.sessionPicks
      ..clear()
      ..add(bench.id);
    fit.startSession();
    fit.addExerciseToSession(bench.id);
    expect(fit.session!.exercises.length, 1);
  });

  test('the equipment filter narrows the library and clears with the rest', () {
    fit.setEquipmentFilter('Bodyweight');
    final list = fit.exercisesFiltered;
    expect(list, isNotEmpty);
    expect(list.every((e) => e.equipment == 'Bodyweight'), true);
    expect(list.length, lessThan(fit.allExercises.length));

    fit.setEquipmentFilter('Bodyweight');
    expect(fit.exEquipmentFilter, isNull, reason: 'el mismo chip lo quita');

    fit.setEquipmentFilter('Barbell');
    fit.clearExFilters();
    expect(fit.exEquipmentFilter, isNull);
  });
}
