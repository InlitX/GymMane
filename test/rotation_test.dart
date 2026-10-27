import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('rotación', () {
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

  group('rotación a fondo', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    String bench() => fit.matchExerciseByName('Bench Press')!.id;

    Routine routine(String name, [List<String>? ids]) {
      final id = fit.createRoutine(name);
      for (final e in ids ?? [bench()]) {
        fit.toggleRoutineExercise(id, e);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    void train(Routine r) {
      fit.startRoutine(r);
      fit.endCountdown();
      fit.toggleSet(0, 0);
      fit.finishSession();
    }

    void close() => fit.saveAndExit();

    DateTime day(int offset, [int hour = 10]) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day + offset, hour);
    }

    Routine rotate(List<Routine> list) {
      fit.setRotation(true);
      for (final r in list) {
        if (!fit.rotationIds.contains(r.id)) fit.toggleRotationRoutine(r.id);
      }
      return list.first;
    }

    test('A, B, C seguidas en días distintos dan la vuelta entera', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      rotate([a, b, c]);
      final seen = <String>[];
      for (var i = 0; i < 4; i++) {
        final next = fit.rotationNext!;
        seen.add(next.name);
        train(next);
        close();
      }
      expect(seen, ['A', 'B', 'C', 'A']);
      expect(fit.rotationNext?.id, b.id);
    });

    test('hoy enseña la hecha y mañana la siguiente', () {
      final a = routine('A'), b = routine('B');
      rotate([a, b]);
      train(a);
      close();
      expect(fit.routinesOn(DateTime.now()).single.id, a.id);
      expect(fit.pendingRoutinesOn(DateTime.now()), isEmpty);
      expect(fit.routinesOn(day(1)).single.id, b.id);
      expect(fit.routinesOn(day(-1)), isEmpty);
    });

    test('una rutina fuera de la rotación no la mueve', () {
      final a = routine('A'), b = routine('B'), x = routine('X');
      rotate([a, b]);
      train(x);
      close();
      expect(fit.rotationNext?.id, a.id);
    });

    test('hacer la B cuando tocaba la A salta a la C', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      rotate([a, b, c]);
      train(b);
      close();
      expect(fit.rotationNext?.id, c.id);
    });

    test('volver al entreno desde el resumen no avanza dos veces', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      rotate([a, b, c]);
      train(a);
      expect(fit.rotationNext?.id, b.id);
      fit.continueSession();
      expect(fit.rotationNext?.id, a.id);
      fit.finishSession();
      expect(fit.rotationNext?.id, b.id);
      close();
      expect(fit.sessions.length, 1);
    });

    test('quitar la que tocaba pasa a la primera y vaciarla vuelve a la semana', () {
      final a = routine('A'), b = routine('B');
      fit.assignRoutineToDay(DateTime.now().weekday, a.id);
      rotate([a, b]);
      fit.setRotationNext(b.id);
      fit.toggleRotationRoutine(b.id);
      expect(fit.rotationNext?.id, a.id);
      fit.toggleRotationRoutine(a.id);
      expect(fit.rotating, isFalse);
      expect(fit.routinesOn(DateTime.now()).single.id, a.id);
    });

    test('nada de rutinas vacías ni ids sueltos al cargar', () {
      final a = routine('A'), b = routine('B');
      rotate([a, b]);
      fit.rotationIds.add('no-existe');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.rotationRoutines.map((r) => r.id), [a.id, b.id]);
    });
  });

  group('días de descanso en la rotación', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
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
      fit.saveAndExit();
    }

    DateTime day(int offset) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day + offset, 10);
    }

    List<String> cycle(List<Object> steps) {
      fit.setRotation(true);
      for (final s in steps) {
        if (s is Routine) {
          fit.toggleRotationRoutine(s.id);
        } else {
          fit.addRotationRest();
        }
      }
      return [...fit.rotationIds];
    }

    test('el día después de la última toca descanso y al otro sigue la siguiente', () {
      final legs = routine('Legs'), push = routine('Push');
      cycle([legs, 'rest', push]);
      train(legs, on: day(-1));

      expect(fit.restingToday, isTrue);
      expect(fit.todayRoutine, isNull);
      expect(fit.rotationNext, isNull);
      expect(fit.rotationUpcoming?.id, push.id);
      expect(fit.rotationStep, 1);
      expect(fit.isTrainingDay(DateTime.now()), isFalse);
      expect(fit.routinesOn(day(1)).single.id, push.id);
      expect(fit.rotationRestOn(day(1)), isFalse);
    });

    test('el descanso pasa solo cuando acaba su día', () {
      final legs = routine('Legs'), push = routine('Push');
      cycle([legs, 'rest', push]);
      train(legs, on: day(-2));

      expect(fit.restingToday, isFalse);
      expect(fit.rotationNext?.id, push.id);
      expect(fit.todayRoutine?.id, push.id);
    });

    test('dos descansos seguidos son dos días', () {
      final legs = routine('Legs'), push = routine('Push');
      cycle([legs, 'rest', 'rest', push]);
      train(legs, on: day(-1));

      expect(fit.restingToday, isTrue);
      expect(fit.rotationRestOn(day(1)), isTrue);
      expect(fit.routinesOn(day(1)), isEmpty);
      expect(fit.routinesOn(day(2)).single.id, push.id);
    });

    test('hoy entrenado y mañana descanso', () {
      final legs = routine('Legs'), push = routine('Push');
      cycle([legs, 'rest', push]);
      train(legs);

      expect(fit.restingToday, isFalse);
      expect(fit.todayPlanDone, isTrue);
      expect(fit.rotationRestOn(day(1)), isTrue);
      expect(fit.routinesOn(day(2)).single.id, push.id);
    });

    test('entrenar en un día de descanso sigue la rueda desde esa rutina', () {
      final legs = routine('Legs'), push = routine('Push'), pull = routine('Pull');
      cycle([legs, 'rest', push, pull]);
      train(legs, on: day(-1));
      expect(fit.restingToday, isTrue);

      train(push);
      expect(fit.restingToday, isFalse);
      expect(fit.rotationNext?.id, pull.id);
    });

    test('saltar el descanso pone hoy la siguiente', () {
      final legs = routine('Legs'), push = routine('Push');
      cycle([legs, 'rest', push]);
      train(legs, on: day(-1));

      fit.skipRotation();
      expect(fit.restingToday, isFalse);
      expect(fit.todayRoutine?.id, push.id);
    });

    test('elegir un descanso como siguiente lo deja para hoy', () {
      final push = routine('Push'), pull = routine('Pull');
      final ids = cycle([push, pull, 'rest']);
      fit.setRotationNext(ids[2]);
      expect(fit.restingToday, isTrue);
      expect(fit.rotationUpcoming?.id, push.id);
    });

    test('quitar el descanso de hoy pasa al siguiente paso', () {
      final legs = routine('Legs'), push = routine('Push');
      final ids = cycle([legs, 'rest', push]);
      train(legs, on: day(-1));

      fit.removeRotationRest(ids[1]);
      expect(fit.rotationIds, [legs.id, push.id]);
      expect(fit.todayRoutine?.id, push.id);
    });

    test('varios descansos, se mueven y se guardan con su día', () {
      final legs = routine('Legs'), push = routine('Push');
      final ids = cycle([legs, 'rest', push, 'rest']);
      expect(ids[1], isNot(ids[3]));
      train(legs, on: day(-1));

      fit.persistNow();
      fit.rotationIds.clear();
      fit.rotationRestDay = null;
      fit.loadFromStore();
      expect(fit.rotationIds, ids);
      expect(fit.restingToday, isTrue);

      fit.reorderRotation(3, 0);
      expect(fit.rotationIds, [ids[3], legs.id, ids[1], push.id]);
      expect(fit.restingToday, isTrue);
      expect(fit.rotationStep, 2);
    });

    test('solo descansos no es una rotación', () {
      fit.setRotation(true);
      fit.addRotationRest();
      expect(fit.rotating, isFalse);
      expect(fit.restingToday, isFalse);
      expect(fit.todayRoutine, isNull);
    });

    test('sin descansos todo sigue como antes', () {
      final a = routine('A'), b = routine('B');
      cycle([a, b]);
      train(a, on: day(-3));
      expect(fit.rotationNext?.id, b.id);
      expect(fit.routinesOn(day(4)).single.id, b.id);
      expect(fit.rotationRestOn(day(1)), isFalse);
    });

    test('con rotación el aviso vale para cualquier día', () {
      final a = routine('A');
      fit.assignRoutineToDay(DateTime.monday, a.id);
      expect(fit.reminderWeekdays, {DateTime.monday});
      cycle([]);
      expect(fit.reminderWeekdays, isEmpty);
    });

    test('volver al entreno desde el resumen deja el descanso como estaba', () {
      final legs = routine('Legs'), push = routine('Push');
      cycle([legs, 'rest', push]);
      train(legs, on: day(-1));
      expect(fit.restingToday, isTrue);

      fit.startRoutine(push);
      fit.endCountdown();
      fit.toggleSet(0, 0);
      fit.finishSession();
      expect(fit.restingToday, isFalse);
      fit.continueSession();
      expect(fit.restingToday, isTrue);
    });
  });
}
