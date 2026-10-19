import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/nutrition.dart';
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
    fit.onboarded = true;
  });

  String bench() => fit.matchExerciseByName('Bench Press')!.id;

  Routine routine(String name) {
    final id = fit.createRoutine(name);
    fit.toggleRoutineExercise(id, bench());
    return fit.routines.firstWhere((r) => r.id == id);
  }

  void train(Routine r, {DateTime? on}) {
    fit.startRoutine(r, on: on);
    fit.endCountdown();
    fit.toggleSet(0, 0);
    fit.finishSession();
  }

  DateTime day(int offset) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day + offset, 10);
  }

  group('rotación', () {
    test('la siguiente es la que sigue a la última, sin mirar el día', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      fit.setRotation(true);
      for (final r in [a, b, c]) {
        fit.toggleRotationRoutine(r.id);
      }
      expect(fit.rotating, isTrue);
      expect(fit.todayRoutine?.id, a.id);
      expect(fit.routinesOn(day(3)).single.id, a.id);

      train(a);
      expect(fit.rotationNext?.id, b.id);
      expect(fit.rotationStep, 1);
      expect(fit.todayPlanDone, isTrue);
      expect(fit.routinesOn(day(1)).single.id, b.id);

      fit.skipRotation();
      expect(fit.rotationNext?.id, c.id);
      fit.restartRotation();
      expect(fit.rotationNext?.id, a.id);
    });

    test('al terminar la última vuelve a la primera', () {
      final a = routine('A'), b = routine('B');
      fit.setRotation(true);
      fit.toggleRotationRoutine(a.id);
      fit.toggleRotationRoutine(b.id);
      fit.setRotationNext(b.id);
      train(b);
      expect(fit.rotationNext?.id, a.id);
      expect(fit.rotationStep, 0);
    });

    test('se guarda, y borrar una rutina pasa a la siguiente', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      fit.setRotation(true);
      for (final r in [a, b, c]) {
        fit.toggleRotationRoutine(r.id);
      }
      fit.setRotationNext(b.id);
      fit.reorderRotation(2, 0);
      expect(fit.rotationIds, [c.id, a.id, b.id]);

      fit.persistNow();
      fit.rotationIds.clear();
      fit.rotation = false;
      fit.loadFromStore();
      expect(fit.rotating, isTrue);
      expect(fit.rotationIds, [c.id, a.id, b.id]);
      expect(fit.rotationNext?.id, b.id);

      fit.deleteRoutine(b.id);
      expect(fit.rotationIds, [c.id, a.id]);
      expect(fit.rotationNext?.id, c.id);
    });

    test('al encenderla se llena con el plan semanal y al apagarla vuelve la semana', () {
      final a = routine('A'), b = routine('B');
      fit.assignRoutineToDay(DateTime.monday, a.id);
      fit.assignRoutineToDay(DateTime.thursday, b.id);
      fit.setRotation(true);
      expect(fit.rotationIds, [a.id, b.id]);
      fit.setRotation(false);
      expect(fit.weeklyPlan[DateTime.monday], a.id);
      expect(fit.weeklyPlan[DateTime.thursday], b.id);
    });
  });

  group('mover la sesión de hoy', () {
    test('pasa a otro día sin tocar el plan semanal y se deshace', () {
      final a = routine('A');
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      final undo = fit.moveRoutineDay(a.id, today, day(2));
      expect(undo, isNotNull);
      expect(fit.routinesOn(today), isEmpty);
      expect(fit.routinesOn(day(2)).single.id, a.id);
      expect(fit.weeklyPlan[today.weekday], a.id);
      expect(fit.movedOn(today), isTrue);
      expect(fit.isTrainingDay(today), isFalse);

      fit.persistNow();
      fit.planMoves.clear();
      fit.loadFromStore();
      expect(fit.routinesOn(day(2)).single.id, a.id);

      undo!();
      expect(fit.routinesOn(today).single.id, a.id);
      expect(fit.movedOn(day(2)), isFalse);
    });

    test('volver al plan quita el cambio de ese día', () {
      final a = routine('A');
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.moveRoutineDay(a.id, today, day(1));
      fit.undoMoves(today);
      expect(fit.routinesOn(today).single.id, a.id);
    });
  });

  group('músculos sin entrenar', () {
    test('cuenta los días desde la última serie del músculo principal', () {
      final now = DateTime.now();
      fit.sessions.add(
        LoggedSession(now.subtract(const Duration(days: 9)), 600, [
          LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(8, 60)]),
        ]),
      );
      final days = fit.daysSinceTrained();
      expect(days['chest'], 9);
      expect(days['quads'], isNull);
      expect(fit.untrainedLongest(), isNot(contains('chest')));
      expect(fit.untrainedLongest().length, 3);
    });
  });

  group('vista en lista', () {
    test('el ajuste se guarda y por defecto son tarjetas', () {
      expect(fit.sessionLayout, 'cards');
      fit.setSessionLayout('list');
      fit.persistNow();
      fit.sessionLayout = 'cards';
      fit.loadFromStore();
      expect(fit.listLayout, isTrue);
    });

    test('marcar una serie de otro ejercicio lo pone delante y descansa con su tiempo', () {
      final id = fit.createRoutine('L');
      final squat = fit.matchExerciseByName('Barbell Squat')!.id;
      fit.toggleRoutineExercise(id, bench());
      fit.toggleRoutineExercise(id, squat);
      fit.setRoutineRest(id, squat, 200);
      fit.startRoutine(fit.routines.firstWhere((r) => r.id == id));
      fit.endCountdown();
      fit.toggleSetAt(1, 0);
      expect(fit.session!.currentIndex, 1);
      expect(fit.restTotal, 200);
      fit.skipRest();
    });

    test('copiar la serie anterior y mover ejercicios', () {
      fit.sessions.add(
        LoggedSession(day(-2), 600, [
          LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(6, 82.5)]),
        ]),
      );
      final r = routine('P');
      fit.startRoutine(r);
      fit.endCountdown();
      fit.copyPreviousSet(0, 0);
      final st = fit.session!.exercises.first.sets.first;
      expect(st.reps, 6);
      expect(st.weight, 82.5);

      fit.addExerciseToSession(fit.matchExerciseByName('Barbell Squat')!.id);
      final first = fit.session!.exercises.first.id;
      fit.moveSessionExercise(0, 1);
      expect(fit.session!.exercises[1].id, first);
      fit.moveSessionExercise(1, -1);
      expect(fit.session!.exercises[0].id, first);
    });
  });
  group('widgets de nutrición', () {
    test('lo tocado en el widget se apunta con su hora y lo de otro día se ignora', () {
      final now = DateTime.now();
      final ms = now.subtract(const Duration(minutes: 5)).millisecondsSinceEpoch;
      final old = now.subtract(const Duration(days: 2)).millisecondsSinceEpoch;
      final food = fit.saveFood(name: 'Batido', macros: const Macros(kcal: 120, protein: 24));
      final before = fit.waterOn(now);
      final n = fit.takeWidgetLog('w,$ms,250;w,$old,250;s,$ms,${food.id};x,1,2;w,bad,3');
      expect(n, 2);
      expect(fit.waterOn(now), before + 250);
      expect(fit.totalOn(now).protein.round(), 24);
      expect(fit.waterSipsOn(now).last.at.millisecondsSinceEpoch, ms);
    });
  });
}
