import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/live_session.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#183 ejercicio por tiempo sin peso', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('uno propio por tiempo con barra empieza sin peso', () {
      final id = fit.addCustomExercise(
          name: 'Sweep', primary: 'abdomen', equipment: 'Barbell', mode: 'time');
      expect(fit.isRepsOnly(id), isTrue);
    });

    test('si ya lo hizo con peso, el peso sigue', () {
      final id = fit.addCustomExercise(
          name: 'Sweep', primary: 'abdomen', equipment: 'Barbell', mode: 'time');
      fit.sessions.add(LoggedSession(DateTime.now(), 600, [
        LoggedExercise(id, 'Sweep', 'abdomen', [LoggedSet(0, 10, sec: 30)]),
      ]));
      expect(fit.isRepsOnly(id), isFalse);
    });

    test('se puede volver a poner el peso', () {
      final id = fit.addCustomExercise(
          name: 'Sweep', primary: 'abdomen', equipment: 'Barbell', mode: 'time');
      fit.toggleRepsOnly(id);
      expect(fit.isRepsOnly(id), isFalse);
    });

    test('los de carga siguen con peso y los de reps no cambian', () {
      expect(fit.isRepsOnly('kettlebell-farmer-carry'), isFalse);
      expect(fit.isRepsOnly('cable-pallof-hold'), isFalse);
      expect(fit.isRepsOnly('jump-rope'), isTrue);
      final barbell = fit.allExercises.firstWhere((e) => e.equipment == 'Barbell' && fit.modeOf(e.id).isEmpty);
      expect(fit.isRepsOnly(barbell.id), isFalse);
    });
  });

  group('#173 cardio', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    Routine routineOf(List<String> ids) {
      final id = fit.createRoutine('Cardio');
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    test('el filtro rápido de cardio solo deja cardio y no cuenta como filtro de la hoja', () {
      fit.setKindFilter('cardio');
      final list = fit.exercisesFiltered;
      expect(list, isNotEmpty);
      expect(list.every((e) => fit.kindOf(e) == 'cardio'), isTrue);
      expect(list.map((e) => e.id), containsAll(['running', 'jump-rope']));
      fit.setKindFilter('cardio');
      expect(fit.exKindFilter, isNull);
    });

    test('las series de cardio llevan reloj y las de peso no', () {
      expect(fit.runsClock('running'), isTrue);
      expect(fit.runsClock('cable-pallof-hold'), fit.isTimed('cable-pallof-hold'));
      final barbell = fit.allExercises.firstWhere((e) => fit.modeOf(e.id).isEmpty);
      expect(fit.runsClock(barbell.id), isFalse);
    });

    test('una carrera larga no se corta a la hora', () {
      fit.startRoutine(routineOf(['running']));
      fit.endCountdown();
      fit.session!.exercises.first.sets.first.sec = 90 * 60;
      fit.startHold(0, 0);
      expect(fit.holdTotal, 90 * 60);
      fit.stopHold();
    });

    test('terminar antes guarda el tiempo que se ha corrido', () {
      fit.startRoutine(routineOf(['running']));
      fit.endCountdown();
      fit.session!.exercises.first.sets.first.sec = 1200;
      fit.startHold(0, 0);
      final start = DateTime.now().subtract(const Duration(seconds: 300));
      fit.holdStartsAt = start;
      fit.holdEndsAt = start.add(const Duration(seconds: 1200));
      fit.toggleHoldPause();
      fit.completeHold();
      final set = fit.session!.exercises.first.sets.first;
      expect(set.done, isTrue);
      expect(set.sec, inInclusiveRange(299, 301));
    });

    test('un aguante terminado antes sigue guardando lo planeado', () {
      final plank = fit.matchExerciseByName('Plank')!.id;
      fit.startRoutine(routineOf([plank]));
      fit.endCountdown();
      fit.setExerciseMode(plank, 'time');
      final planned = fit.session!.exercises.first.sets.first.sec;
      fit.startHold(0, 0);
      final start = DateTime.now().subtract(const Duration(seconds: 10));
      fit.holdStartsAt = start;
      fit.holdEndsAt = start.add(Duration(seconds: fit.holdTotal));
      fit.toggleHoldPause();
      fit.completeHold();
      expect(fit.session!.exercises.first.sets.first.sec, planned);
    });
  });

  group('#213 cada lado', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    Routine routineOf(List<String> ids) {
      final id = fit.createRoutine('Core');
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    Future<void> endSide() async {
      final past = DateTime.now().subtract(const Duration(milliseconds: 50));
      fit.holdStartsAt = past.subtract(Duration(seconds: fit.holdTotal));
      fit.holdEndsAt = past;
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }

    test('la plancha lateral viene por lados y se puede quitar y volver a poner', () async {
      expect(fit.isEachSide('side-plank-hold'), isTrue);
      expect(fit.isEachSide('plank-hold'), isFalse);
      fit.toggleEachSide('side-plank-hold');
      fit.toggleEachSide('plank-hold');
      expect(fit.isEachSide('side-plank-hold'), isFalse);
      expect(fit.isEachSide('plank-hold'), isTrue);

      fit.persistNow();
      fit.eachSide.clear();
      fit.eachSideOff.clear();
      fit.loadFromStore();
      expect(fit.isEachSide('side-plank-hold'), isFalse);
      expect(fit.isEachSide('plank-hold'), isTrue);

      fit.toggleEachSide('side-plank-hold');
      expect(fit.eachSideOff, isNot(contains('side-plank-hold')));
      expect(fit.eachSide, isNot(contains('side-plank-hold')));
    });

    test('solo cuenta en ejercicios por tiempo', () {
      fit.setExerciseMode('side-plank-hold', 'weight');
      expect(fit.isEachSide('side-plank-hold'), isFalse);
      fit.setExerciseMode('side-plank-hold', 'time');
      expect(fit.isEachSide('side-plank-hold'), isTrue);
    });

    test('corre un lado, avisa de cambiar y descansa solo tras el segundo', () async {
      fit.startRoutine(routineOf(['side-plank-hold']));
      fit.endCountdown();
      final set = fit.session!.exercises.first.sets.first;
      fit.startHold(0, 0);
      expect(fit.holdSides, 2);
      expect(fit.holdLength('side-plank-hold', 30), '0:30 × 2');

      await endSide();
      expect(fit.holding, isTrue);
      expect(fit.holdSide, 1);
      expect(fit.switchingSides, isTrue);
      expect(set.done, isFalse);
      expect(fit.session!.restRemaining, isNull);

      await endSide();
      expect(fit.holding, isFalse);
      expect(set.done, isTrue);
      expect(fit.session!.restRemaining, isNotNull);
      fit.skipRest();
    });

    test('un aguante normal sigue siendo de una vez', () async {
      fit.startRoutine(routineOf(['plank-hold']));
      fit.endCountdown();
      fit.startHold(0, 0);
      expect(fit.holdSides, 1);
      await endSide();
      expect(fit.holding, isFalse);
      expect(fit.session!.exercises.first.sets.first.done, isTrue);
      fit.skipRest();
    });

    test('pararlo deja todo como al principio', () {
      fit.startRoutine(routineOf(['side-plank-hold']));
      fit.endCountdown();
      fit.startHold(0, 0);
      fit.stopHold();
      expect(fit.holdSide, 0);
      expect(fit.holdSides, 1);
      expect(fit.session!.exercises.first.sets.first.done, isFalse);
    });
  });

  group('cardio and timed work', () {
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

    Routine routineWith(List<String> ids, {String name = 'Push'}) {
      final id = fit.createRoutine(name);
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    test('a run opens with time and distance, and remembers them', () {
      final run = idOf('Outdoor Run');
      expect(fit.modeOf(run), 'cardio');
      expect(fit.restFor(run), 0);
      final r = routineWith([run]);
      expect(fit.routineSets(r, run), 1);
      fit.startRoutine(r);
      final st = fit.session!.exercises.single.sets.single;
      expect(st.sec, 1200);
      fit.setSessionKm(0, 0, 5.2);
      fit.setSessionSeconds(0, 0, 1800);
      fit.toggleSet(0, 0);
      fit.finishSession();
      fit.saveAndExit();
      final logged = fit.lastSetsFor(run).single;
      expect(logged.km, 5.2);
      expect(fit.loggedSetLabel(logged), '5.2 km · 30:00');
      fit.startRoutine(r);
      expect(fit.session!.exercises.single.sets.single.km, 5.2);
      expect(fit.nextTarget(run), isNull);
    });

    test('miles show for imperial users', () {
      fit.setUnits('lb');
      expect(fit.distanceLabel(1.609344), '1 mi');
      fit.setUnits('kg');
    });

    test('a plank opens with seconds and the hold can start and stop', () {
      final plank = idOf('Plank');
      expect(fit.modeOf(plank), 'time');
      fit.startRoutine(routineWith([plank]));
      final sets = fit.session!.exercises.single.sets;
      expect(sets.first.sec, 30);
      fit.startHold(0, 0);
      expect(fit.holding, isTrue);
      expect(fit.holdRemaining, 30);
      expect(fit.holdLead, inInclusiveRange(4, 5));
      fit.stopHold();
      expect(fit.holding, isFalse);
      expect(sets.first.done, isFalse);
    });

    test('how an exercise is logged can be changed and changed back', () {
      final rope = idOf('Jump Rope');
      expect(fit.modeOf(rope), 'time');
      fit.setExerciseMode(rope, '');
      expect(fit.modeOf(rope), '');
      fit.setExerciseMode(rope, 'time');
      expect(fit.modeOverride.containsKey(rope), isFalse);
    });

    test('timed and cardio sets keep their fields through json', () {
      final s = SessionSet(0, 20, true, sec: 45, km: null, kind: SetKind.restPause);
      final back = SessionSet.fromJson(s.toJson());
      expect(back.sec, 45);
      expect(back.kind, SetKind.restPause);
      final l = LoggedSet.fromJson(LoggedSet(0, 0, sec: 600, km: 2.5).toJson());
      expect(l.km, 2.5);
      expect(l.oneRm, 0);
    });
  });

  group('cronómetro', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    test('#236 el cronómetro solo en ejercicios con reloj', () {
      expect(fit.runsClock('plank-hold'), isTrue);
      expect(fit.runsClock(fit.matchExerciseByName('Bench Press')!.id), isFalse);
    });
  });

  group('#219 calorías de caminar y correr', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

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

  group('#88 pausar el temporizador', () {
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

    test('pausar guarda lo que queda y terminar ya marca la serie', () {
      fit.startRoutine(routineOf(['Plank']));
      fit.endCountdown();
      fit.setExerciseMode(idOf('Plank'), 'time');
      fit.startHold(0, 0);
      final lead = fit.holdLead;
      fit.toggleHoldPause();
      expect(fit.holdPaused, isTrue);
      expect(fit.holdLead, lead);
      fit.toggleHoldPause();
      expect(fit.holdPaused, isFalse);
      fit.toggleHoldPause();
      fit.completeHold();
      expect(fit.session!.exercises.first.sets.first.done, isTrue);
      expect(fit.holding, isFalse);
    });
  });
}
