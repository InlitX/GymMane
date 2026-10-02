import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String ex;
  late String r;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    ex = fit.allExercises.firstWhere((e) => fit.modeOf(e.id).isEmpty).id;
    r = fit.createRoutine('Fuerza');
    fit.toggleRoutineExercise(r, ex);
  });

  test('sin ajuste usa el del ejercicio, y con ajuste manda la rutina', () {
    fit.setExerciseRest(ex, 90);
    expect(fit.routineRest(r, ex), isNull);
    fit.setRoutineRest(r, ex, 180);
    expect(fit.routineRest(r, ex), 180);
    expect(fit.restFor(ex), 90);
    fit.setRoutineRest(r, ex, null);
    expect(fit.routineRest(r, ex), isNull);
  });

  test('el descanso arranca con el de la rutina del entreno', () {
    fit.setRestSeconds(90);
    fit.setRoutineRest(r, ex, 240);
    fit.startRoutine(fit.routines.single);
    fit.startRest();
    expect(fit.restTotal, 240);
  });

  test('se guarda en la copia y las copias viejas cargan sin él', () {
    fit.setRoutineRest(r, ex, 150);
    final back = Routine.fromJson(fit.routines.single.toJson());
    expect(back.rest[ex], 150);
    expect(Routine.fromJson({'id': 'x', 'n': 'Old', 'ex': [ex]}).rest, isEmpty);
  });

  test('viaja al duplicar, se va al quitar y vuelve al deshacer', () {
    fit.setRoutineRest(r, ex, 120);
    final copy = fit.duplicateRoutine(r);
    expect(fit.routineRest(copy, ex), 120);
    final undo = fit.removeRoutineExercise(r, ex)!;
    expect(fit.routineRest(r, ex), isNull);
    undo();
    expect(fit.routineRest(r, ex), 120);
  });

  test('apagado en la rutina es cero y no se recorta a 15', () {
    fit.setRoutineRest(r, ex, 0);
    expect(fit.routineRest(r, ex), 0);
    fit.setRoutineRest(r, ex, 5);
    expect(fit.routineRest(r, ex), 15);
  });
}
