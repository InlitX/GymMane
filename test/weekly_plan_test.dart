import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('mover la sesión de hoy', () {
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

    DateTime day(int offset) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day + offset, 10);
    }

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

  group('mover el día a fondo', () {
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

    DateTime day(int offset, [int hour = 10]) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day + offset, hour);
    }

    test('a un día que ya tiene rutina se suman las dos', () {
      final a = routine('A'), b = routine('B');
      final today = DateTime.now();
      fit.toggleMultiPlan();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.assignRoutineToDay(day(1).weekday, b.id);
      fit.moveRoutineDay(a.id, today, day(1));
      expect(fit.routinesOn(day(1)).map((r) => r.id), [b.id, a.id]);
      expect(fit.routinesOn(today), isEmpty);
      expect(fit.routinesOn(day(8)).map((r) => r.id), [b.id]);
    });

    test('mover dos veces y deshacer la segunda deja la primera', () {
      final a = routine('A');
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.moveRoutineDay(a.id, today, day(1));
      final undo = fit.moveRoutineDay(a.id, day(1), day(2))!;
      expect(fit.routinesOn(day(2)).single.id, a.id);
      expect(fit.routinesOn(day(1)), isEmpty);
      undo();
      expect(fit.routinesOn(day(1)).single.id, a.id);
      expect(fit.routinesOn(day(2)), isEmpty);
    });

    test('no mueve lo que no está ese día ni al mismo día', () {
      final a = routine('A');
      final today = DateTime.now();
      expect(fit.moveRoutineDay(a.id, today, day(1)), isNull);
      fit.assignRoutineToDay(today.weekday, a.id);
      expect(fit.moveRoutineDay(a.id, today, DateTime.now()), isNull);
      expect(fit.planMoves, isEmpty);
    });

    test('los cambios viejos se borran solos', () {
      final a = routine('A');
      fit.planMoves['2001-01-01'] = [a.id];
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.moveRoutineDay(a.id, today, day(1));
      expect(fit.planMoves.containsKey('2001-01-01'), isFalse);
    });

    test('borrar la rutina la quita también de los días movidos', () {
      final a = routine('A');
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.moveRoutineDay(a.id, today, day(1));
      fit.deleteRoutine(a.id);
      expect(fit.routinesOn(day(1)), isEmpty);
    });
  });

  group('#158 planes guardados', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    late String a, b, c;
    setUp(() {
      a = fit.createRoutine('A');
      b = fit.createRoutine('B');
      c = fit.createRoutine('C');
      fit.assignRoutineToDay(1, a);
      fit.assignRoutineToDay(3, b);
    });

    test('guardar la semana y cambiar a otra sin perder la primera', () {
      fit.savePlanAs('Invierno');
      fit.savePlanAs('Verano', empty: true);
      expect(fit.weeklyPlan, isEmpty);
      fit.assignRoutineToDay(2, c);
      fit.switchPlan(fit.savedPlans.first.id);
      expect(fit.weeklyPlan, {1: a, 3: b});
      fit.switchPlan(fit.savedPlans.last.id);
      expect(fit.weeklyPlan, {2: c});
    });

    test('los cambios en la semana van al plan elegido', () {
      fit.savePlanAs('Invierno');
      fit.assignRoutineToDay(5, c);
      fit.savePlanAs('Viaje', empty: true);
      fit.switchPlan(fit.savedPlans.first.id);
      expect(fit.weeklyPlan, {1: a, 3: b, 5: c});
    });

    test('empezar vacío sin haber guardado conserva la semana como «Mi plan»', () {
      fit.savePlanAs('Reddit', empty: true);
      expect(fit.savedPlans.map((p) => p.name), [t.planMine, 'Reddit']);
      fit.switchPlan(fit.savedPlans.first.id);
      expect(fit.weeklyPlan, {1: a, 3: b});
    });

    test('borrar una rutina la quita de todos los planes', () {
      fit.savePlanAs('Invierno');
      fit.savePlanAs('Verano');
      fit.deleteRoutine(a);
      for (final p in fit.savedPlansLive) {
        expect(p.uses(a), isFalse);
      }
      fit.switchPlan(fit.savedPlans.first.id);
      expect(fit.weeklyPlan, {3: b});
    });

    test('borrar un plan deja la semana como está', () {
      fit.savePlanAs('Invierno');
      fit.deletePlan(fit.savedPlans.first.id);
      expect(fit.savedPlans, isEmpty);
      expect(fit.currentPlanId, '');
      expect(fit.weeklyPlan, {1: a, 3: b});
    });

    test('los planes, el elegido y sus cambios se guardan al reabrir', () async {
      fit.savePlanAs('Invierno');
      fit.savePlanAs('Verano', empty: true);
      fit.assignRoutineToDay(6, c);
      fit.renamePlan(fit.currentPlanId, 'Verano 2027');
      fit.persistNow();
      await pumpEventQueue();
      fit.loadFromStore();
      expect(fit.savedPlans.map((p) => p.name), ['Invierno', 'Verano 2027']);
      expect(fit.currentPlanId, fit.savedPlans.last.id);
      expect(fit.weeklyPlan, {6: c});
      fit.switchPlan(fit.savedPlans.first.id);
      expect(fit.weeklyPlan, {1: a, 3: b});
      fit.switchPlan(fit.savedPlans.last.id);
      expect(fit.weeklyPlan, {6: c});
    });

    test('un nombre vacío no crea nada', () {
      fit.savePlanAs('   ');
      expect(fit.savedPlans, isEmpty);
    });
  });

  group('#86 varias rutinas al día', () {
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

    Routine routineOf(List<String> names) {
      final id = fit.createRoutine('Push');
      for (final name in names) {
        fit.toggleRoutineExercise(id, idOf(name));
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = 'push', String primary = 'chest'}) =>
        LoggedSession(at, 600, [LoggedExercise(id, id, primary, sets)]);

    test('apagado, un día solo tiene una rutina', () {
      final a = routineOf(['Barbell Bench Press']);
      final b = routineOf(['Barbell Squat']);
      final today = DateTime.now().weekday;
      fit.togglePlanDay(today, a.id);
      fit.togglePlanDay(today, b.id);
      expect(fit.planIdsOn(today), [b.id]);
    });

    test('encendido, van en orden y el día acaba cuando se hacen todas', () {
      fit.toggleMultiPlan();
      final a = routineOf(['Barbell Bench Press']);
      final b = routineOf(['Barbell Squat']);
      final today = DateTime.now().weekday;
      fit.togglePlanDay(today, a.id);
      fit.togglePlanDay(today, b.id);
      expect(fit.todayRoutine, same(a));
      expect(fit.todayPlanDone, isFalse);

      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 60)]));
      expect(fit.todayRoutine, same(b));
      expect(fit.todayPlanDone, isFalse);

      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 100)]));
      expect(fit.todayPlanDone, isTrue);
    });

    test('#157 repetir una rutina no cuenta como hacer la otra', () {
      fit.toggleMultiPlan();
      final a = routineOf(['Barbell Bench Press']);
      final b = routineOf(['Barbell Squat']);
      final c = routineOf(['Barbell Deadlift']);
      final today = DateTime.now().weekday;
      fit.togglePlanDay(today, a.id);
      fit.togglePlanDay(today, b.id);
      LoggedSession done(String id) => LoggedSession(DateTime.now(), 1800, const [], routineId: id);

      fit.sessions.add(done(a.id));
      fit.sessions.add(done(a.id));
      fit.sessions.add(done(c.id));
      expect(fit.todayPlanDone, isFalse);
      expect(fit.todayRoutine, same(b));

      fit.sessions.add(done(b.id));
      expect(fit.todayPlanDone, isTrue);
      expect(LoggedSession.fromJson(done(b.id).toJson()).routineId, b.id);
    });

    test('#156 al acabar una rutina ofrece la siguiente del día', () {
      fit.toggleMultiPlan();
      final a = routineOf(['Barbell Bench Press']);
      final b = routineOf(['Barbell Squat']);
      final today = DateTime.now().weekday;
      fit.togglePlanDay(today, a.id);
      fit.togglePlanDay(today, b.id);

      fit.startRoutine(a);
      fit.toggleSet(0, 0);
      fit.finishSession();
      expect(fit.sessions.last.routineId, a.id);
      expect(fit.nextRoutineToday, same(b));

      fit.startNextRoutine();
      expect(fit.session?.routineId, b.id);
      expect(fit.session?.complete, isFalse);
      fit.toggleSet(0, 0);
      fit.finishSession();
      expect(fit.nextRoutineToday, isNull);
      expect(fit.todayPlanDone, isTrue);
    });

    test('#157 hacer la segunda primero deja pendiente la primera', () {
      fit.toggleMultiPlan();
      final a = routineOf(['Barbell Bench Press']);
      final b = routineOf(['Barbell Squat']);
      final today = DateTime.now().weekday;
      fit.togglePlanDay(today, a.id);
      fit.togglePlanDay(today, b.id);
      fit.sessions.add(LoggedSession(DateTime.now(), 1800, const [], routineId: b.id));
      expect(fit.todayRoutine, same(a));
      expect(fit.todayPlanDone, isFalse);
    });

    test('borrar la primera deja la segunda y se guarda', () {
      fit.toggleMultiPlan();
      final a = routineOf(['Barbell Bench Press']);
      final b = routineOf(['Barbell Squat']);
      final c = routineOf(['Barbell Deadlift']);
      fit.togglePlanDay(1, a.id);
      fit.togglePlanDay(1, b.id);
      fit.togglePlanDay(1, c.id);
      fit.deleteRoutine(a.id);
      expect(fit.planIdsOn(1), [b.id, c.id]);
      expect(fit.toJson()['planExtras'], {'1': [c.id]});
      fit.toggleMultiPlan();
      expect(fit.planIdsOn(1), [b.id], reason: 'apagado se ignoran las extra');
    });
  });
}
