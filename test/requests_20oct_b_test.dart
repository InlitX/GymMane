import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/l10n.dart';
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
    setAppLanguage('en');
  });

  test('#238 la prensa de piernas trabaja sobre todo cuádriceps', () {
    final press = kExercises.firstWhere((e) => e.name == 'Leg Press');
    expect(press.primary, 'quads');
    expect(press.secondary, containsAll(['glutes', 'hamstrings']));
  });

  group('#240 barra propia', () {
    test('sin elegir nada, la barra es la olímpica', () {
      expect(fit.plateBarDisplay, 20);
      expect(fit.defaultBar, 20);
    });

    test('una barra de otro peso calcula los discos sobre ella', () {
      fit.setPlateBar(12.5);
      fit.plateTarget = 52.5;
      expect(fit.plateBreakdown.map((p) => '${fmt(p.weight)}x${p.count}'), ['20x1']);
    });

    test('la barra elegida se recuerda al reabrir y vale para toda la app', () async {
      fit.setPlateBar(7);
      fit.persistNow();
      await pumpEventQueue();
      fit.loadFromStore();
      expect(fit.plateBarDisplay, 7);
      expect(fit.defaultBar, 7);
      expect(fit.barFor('x'), 7);
    });

    test('borrar los datos vuelve a la barra de 20', () {
      fit.setPlateBar(15);
      fit.resetAllData();
      expect(fit.plateBarDisplay, 20);
    });
  });

  group('#219 calorías de caminar y correr', () {
    LoggedSession walk(String id, double km, int sec, {int dur = 0, double? incline}) {
      final s = LoggedSession(DateTime.now().copyWith(hour: 12), dur == 0 ? sec : dur, [
        LoggedExercise(id, id, 'quads', [LoggedSet(0, 0, sec: sec, km: km)], incline: incline),
      ]);
      fit.sessions.add(s);
      return s;
    }

    setUp(() => fit.addBodyweight(70));

    test('caminar 5 km en una hora con 70 kg: 175 activas y ~249 en total (ACSM)', () {
      final s = walk('walking', 5, 3600);
      final c = fit.cardioKcal(s, s.exercises.first)!;
      expect(c.active, 175);
      expect(c.total, closeTo(249, 1));
      expect(c.own, isFalse);
    });

    test('a partir de 7,2 km/h usa la fórmula de correr', () {
      final s = walk('running', 10, 3000);
      expect(fit.cardioKcal(s, s.exercises.first)!.active, 700);
    });

    test('la inclinación suma: 3 km en 30 min al 10 % son 294 activas', () {
      final s = walk('treadmill-incline-walk', 3, 1800, incline: 10);
      expect(fit.cardioKcal(s, s.exercises.first)!.active, 294);
    });

    test('cada serie es un tramo y se calcula por separado', () {
      final s = LoggedSession(DateTime.now().copyWith(hour: 12), 4800, [
        LoggedExercise('running', 'Running', 'quads', [
          LoggedSet(0, 0, sec: 1800, km: 2.5),
          LoggedSet(0, 0, sec: 3000, km: 10),
        ]),
      ]);
      fit.sessions.add(s);
      final walkPart = (0.1 * (2500 / 30)) * 70 * 30 / 200;
      expect(fit.cardioKcal(s, s.exercises.first)!.active, (walkPart + 700).round());
    });

    test('el valor del reloj manda sobre el estimado y se puede volver atrás', () {
      final s = walk('walking', 5, 3600);
      final e = s.exercises.first;
      fit.setLoggedKcal(e, 210);
      expect(fit.cardioKcal(s, e)!.active, 210);
      expect(fit.cardioKcal(s, e)!.own, isTrue);
      fit.setLoggedKcal(e, null);
      expect(fit.cardioKcal(s, e)!.active, 175);
    });

    test('bici, elíptica o remo no se estiman con la fórmula de caminar', () {
      final s = walk('cycling', 20, 3600);
      expect(fit.cardioKcal(s, s.exercises.first), isNull);
    });

    test('un ejercicio propio que se llama carrera sí se estima', () {
      final id = fit.addCustomExercise(name: 'Carrera por el parque', primary: 'quads', equipment: 'Bodyweight', mode: 'cardio');
      final s = LoggedSession(DateTime.now().copyWith(hour: 12), 3600, [
        LoggedExercise(id, 'Carrera por el parque', 'quads', [LoggedSet(0, 0, sec: 3600, km: 5)]),
      ]);
      fit.sessions.add(s);
      expect(fit.cardioKcal(s, s.exercises.first)!.active, 175);
    });

    test('las kcal quemadas del día usan el cardio y el resto como pesas', () {
      walk('walking', 5, 3600, dur: 5400);
      expect(fit.burnedOn(DateTime.now()), 175 + 140);
    });

    test('la inclinación y el valor propio se guardan', () async {
      final s = walk('walking', 5, 3600);
      fit.setLoggedIncline(s.exercises.first, 4);
      fit.setLoggedKcal(s.exercises.first, 300);
      await pumpEventQueue();
      fit.loadFromStore();
      final e = fit.sessions.last.exercises.first;
      expect(e.incline, 4);
      expect(e.kcal, 300);
    });

    test('la siguiente sesión hereda la última inclinación de ese ejercicio', () {
      final s = walk('treadmill-incline-walk', 3, 1800);
      fit.setLoggedIncline(s.exercises.first, 12);
      expect(fit.lastIncline('treadmill-incline-walk'), 12);
    });
  });

  group('#158 planes guardados', () {
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
}
