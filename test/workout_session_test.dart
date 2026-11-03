import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_share.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#160 nombre del entreno libre', () {
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

    LoggedSession finishFree() {
      fit.startRoutine(routineOf(['running']));
      fit.endCountdown();
      fit.session!.routineId = null;
      fit.toggleSet(0, 0);
      fit.finishSession();
      return fit.filedSession!;
    }

    test('se le pone nombre al acabar y se guarda', () {
      final s = finishFree();
      expect(fit.sessionTitle(s), isNull);
      fit.renameSession(s, '  Pierna  ');
      expect(s.name, 'Pierna');
      expect(fit.sessionTitle(s), 'Pierna');
      expect(LoggedSession.fromJson(s.toJson()).name, 'Pierna');
      expect(fit.workoutText(s).split('\n').first, 'Pierna');
    });

    test('seguir entrenando y volver a acabar no pierde el nombre', () {
      final s = finishFree();
      fit.renameSession(s, 'Torso');
      fit.continueSession();
      expect(fit.session!.name, 'Torso');
      fit.finishSession();
      expect(fit.filedSession!.name, 'Torso');
    });

    test('reabrir un entreno guardado conserva el nombre', () {
      final s = finishFree();
      fit.renameSession(s, 'Brazos');
      fit.saveAndExit();
      fit.resumeLoggedSession(fit.sessions.last);
      expect(fit.session!.name, 'Brazos');
    });

    test('las de rutina se titulan con la rutina si no se renombran', () {
      final r = routineOf(['running']);
      fit.renameRoutine(r.id, 'Cardio suave');
      fit.startRoutine(fit.routines.firstWhere((x) => x.id == r.id));
      fit.endCountdown();
      fit.toggleSet(0, 0);
      fit.finishSession();
      expect(fit.sessionTitle(fit.filedSession!), 'Cardio suave');
    });
  });

  group('vista en lista', () {
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
      fit.sessions.add(LoggedSession(day(-2), 600, [
        LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(6, 82.5)]),
      ]));
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

  group('sets inside a live workout', () {
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

    test('changing a set carries over to the sets that still match it', () {
      final r = routineWith([idOf('Barbell Bench Press')]);
      fit.startRoutine(r);
      final sets = fit.session!.exercises.first.sets;
      for (var j = 0; j < sets.length; j++) {
        fit.setSessionWeight(0, j, 60);
        fit.setSessionReps(0, j, 10);
      }
      fit.setSessionWeight(0, sets.length - 1, 70);

      fit.setSessionWeight(0, 0, 62.5);
      fit.setSessionReps(0, 0, 8);
      expect(sets.first.weight, 62.5);
      for (var j = 1; j < sets.length - 1; j++) {
        expect(sets[j].weight, 62.5);
        expect(sets[j].reps, 8);
      }
      expect(sets.last.weight, 70);
      expect(sets.last.reps, 8);
    });

    test('a set can be removed and brought back', () {
      final r = routineWith([idOf('Barbell Bench Press')]);
      fit.startRoutine(r);
      final sets = fit.session!.exercises.single.sets;
      final before = sets.length;
      final gone = fit.removeSet(0, 1)!;
      expect(sets.length, before - 1);
      fit.insertSet(0, 1, gone);
      expect(sets.length, before);
      expect(identical(sets[1], gone), isTrue);
    });

    test('a warm-up added by mistake goes away in one tap', () {
      final r = routineWith([idOf('Barbell Bench Press')]);
      fit.startRoutine(r);
      final working = fit.session!.exercises.single.sets.length;
      fit.addWarmupSets(0);
      expect(fit.hasWarmup(0), isTrue);
      fit.removeWarmupSets(0);
      expect(fit.hasWarmup(0), isFalse);
      expect(fit.session!.exercises.single.sets.length, working);
    });

    test('jumping and reordering keep the exercise you are on', () {
      final ids = [idOf('Barbell Bench Press'), idOf('Barbell Full Squat'), idOf('Pull Up')];
      final r = routineWith(ids);
      fit.toggleChain(r.id, ids[0]);
      fit.startRoutine(r);
      fit.goToExercise(1);
      expect(fit.currentExercise!.id, ids[1]);
      fit.reorderSessionExercise(2, 0);
      expect(fit.session!.exercises.first.id, ids[2]);
      expect(fit.currentExercise!.id, ids[1]);
      expect(fit.session!.exercises.every((e) => !e.linkedNext || e.id != ids[2]), isTrue);
    });
  });

  group('terminar el entreno solo', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    Routine oneSetEach(List<String> names) {
      final id = fit.createRoutine('Push');
      for (final name in names) {
        final ex = fit.matchExerciseByName(name)!.id;
        fit.toggleRoutineExercise(id, ex);
        fit.bumpRoutineSets(id, ex, -2);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    Future<void> wait(Duration d) => Future<void>.delayed(d + const Duration(milliseconds: 200));

    group('#67 terminar solo', () {
      test('al marcar la última serie del último ejercicio se abre el resumen', () async {
        fit.startRoutine(oneSetEach(['Barbell Bench Press', 'Barbell Squat']));
        fit.endCountdown();
        expect(fit.route, 'session');

        fit.toggleSet(0, 0);
        await wait(WorkoutState.advanceDelay);
        expect(fit.session!.currentIndex, 1);

        fit.toggleSet(1, 0);
        expect(fit.isSessionComplete, isFalse, reason: 'primero se ve el tic marcado');
        await wait(WorkoutState.finishDelay);
        expect(fit.isSessionComplete, isTrue);
        expect(fit.sessions, hasLength(1));
      });

      test('desmarcar a tiempo lo cancela', () async {
        fit.startRoutine(oneSetEach(['Barbell Bench Press']));
        fit.endCountdown();
        fit.toggleSet(0, 0);
        fit.toggleSet(0, 0);
        await wait(WorkoutState.finishDelay);
        expect(fit.isSessionComplete, isFalse);
      });

      test('con el paso automático apagado espera al botón', () async {
        fit.toggleAutoAdvance();
        fit.startRoutine(oneSetEach(['Barbell Bench Press']));
        fit.endCountdown();
        fit.toggleSet(0, 0);
        await wait(WorkoutState.finishDelay);
        expect(fit.isSessionComplete, isFalse);
        fit.toggleAutoAdvance();
      });

      test('si quedan series atrás, vuelve a ellas en vez de terminar', () async {
        fit.startRoutine(oneSetEach(['Barbell Bench Press', 'Barbell Squat']));
        fit.endCountdown();
        fit.goToExercise(1);
        fit.toggleSet(1, 0);
        await wait(WorkoutState.finishDelay);
        expect(fit.isSessionComplete, isFalse);
        expect(fit.session!.currentIndex, 0);
      });
    });

    test('#58 el paso automático queda contado para avisar del cambio', () async {
      fit.startRoutine(oneSetEach(['Barbell Bench Press', 'Barbell Squat']));
      fit.endCountdown();
      final before = fit.autoMoves;
      fit.goToExercise(1);
      expect(fit.autoMoves, before, reason: 'moverse a mano no avisa');
      fit.goToExercise(0);
      fit.toggleSet(0, 0);
      await wait(WorkoutState.advanceDelay);
      expect(fit.autoMoves, before + 1);
    });

    test('el check puesto a mano se quita con otro toque', () {
      final today = fit.todayIndex;
      fit.toggleCheckin(today);
      expect(fit.isDayDone(today), isTrue);
      fit.toggleCheckin(today);
      expect(fit.isDayDone(today), isFalse);
      expect(fit.dateForWeekday(today).day, DateTime.now().day);
    });
  });

  group('#224 notas en el entreno', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    DateTime ago(int days, [int hour = 18]) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day - days, hour);
    }

    DateTime dayAgo(int days) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day - days);
    }

    void logged(String id, int days, List<LoggedSet> sets) =>
        fit.sessions.add(LoggedSession(ago(days), 1200, [LoggedExercise(id, id, 'back', sets)]));

    test('una nota fijada sale siempre en el entreno', () {
      fit.saveNote(exerciseId: 'row', date: ago(10), kind: NoteKind.note, text: 'Asiento en el 2', pinned: true);
      logged('row', 5, [LoggedSet(8, 40)]);
      expect(fit.workoutNotesFor('row').map((n) => n.text), ['Asiento en el 2']);
    });

    test('una nota sin fijar y que no es plan no molesta', () {
      fit.saveNote(exerciseId: 'row', date: ago(1), kind: NoteKind.done, text: 'Buen día');
      expect(fit.workoutNotesFor('row'), isEmpty);
    });

    test('la próxima vez sale hoy, la próxima vez y luego desaparece', () {
      fit.saveNote(exerciseId: 'row', date: ago(0), kind: NoteKind.plan, text: 'Sube a 45');
      expect(fit.workoutNotesFor('row').single.text, 'Sube a 45');
      final old = fit.notes.single;
      fit.notes[0] = GymNote(
        id: old.id,
        exerciseId: 'row',
        date: dayAgo(3),
        kind: NoteKind.plan,
        text: old.text,
        createdAt: old.createdAt,
      );
      logged('row', 3, [LoggedSet(8, 40)]);
      expect(fit.workoutNotesFor('row').single.text, 'Sube a 45');
      logged('row', 1, [LoggedSet(8, 45)]);
      expect(fit.workoutNotesFor('row'), isEmpty);
    });

    test('solo sale el plan más reciente', () {
      fit.saveNote(exerciseId: 'row', date: ago(2), kind: NoteKind.plan, text: 'Viejo');
      fit.saveNote(exerciseId: 'row', date: ago(1), kind: NoteKind.plan, text: 'Nuevo');
      expect(fit.workoutNotesFor('row').map((n) => n.text), ['Nuevo']);
    });

    test('fijar y soltar se guarda, y una nota general no se puede fijar', () {
      fit.saveNote(exerciseId: 'row', date: ago(0), kind: NoteKind.note, text: 'Polea 19');
      final id = fit.notes.single.id;
      fit.setNotePinned(id, true);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.applyBackup(data);
      expect(fit.noteById(id)!.pinned, isTrue);
      fit.setNotePinned(id, false);
      expect(fit.workoutNotesFor('row'), isEmpty);
      fit.saveNote(exerciseId: '', date: ago(0), kind: NoteKind.note, text: 'General', pinned: true);
      expect(fit.notes.last.pinned, isFalse);
    });

    test('editar sin decir nada conserva la chincheta', () {
      fit.saveNote(exerciseId: 'row', date: ago(0), kind: NoteKind.note, text: 'A', pinned: true);
      final id = fit.notes.single.id;
      fit.saveNote(id: id, exerciseId: 'row', date: ago(0), kind: NoteKind.note, text: 'B');
      expect(fit.noteById(id)!.pinned, isTrue);
    });
  });

  group('series cluster y duplicadas', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
    });

    group('#250 series cluster', () {
      test('es un tipo de serie más y no rompe los guardados viejos', () {
        expect(SetKind.values.last, SetKind.cluster);
        expect(setKindFrom(SetKind.restPause.index), SetKind.restPause);
        final back = LoggedSet.fromJson(LoggedSet(9, 80, kind: SetKind.cluster).toJson());
        expect(back.kind, SetKind.cluster);
        expect(back.counts, isTrue);
      });

      test('viaja en el plan compartido', () {
        final plans = parsePlan('{"name":"A","exercises":[{"name":"Barbell Full Squat",'
            '"plan":[{"type":"cluster","reps":12,"weight":100}]}]}');
        expect(plans.single.items.single.plan.single.kind, SetKind.cluster.index);
        fit.applyPlan(plans);
        final r = fit.routines.single;
        expect(fit.exportPlanJson([r]), contains('"type": "cluster"'));
      });
    });

    group('deslizar para duplicar una serie', () {
      test('la copia va justo debajo, sin marcar, y se puede deshacer', () {
        fit.startWorkout();
        fit.toggleMuscle('chest');
        fit.trainContinue();
        fit.startSession();
        final sets = fit.session!.exercises.first.sets;
        final before = sets.length;
        fit.setSessionReps(0, 0, 7);
        fit.setSessionWeight(0, 0, 42.5);
        fit.toggleSet(0, 0);
        final copy = fit.duplicateSet(0, 0)!;
        expect(sets.length, before + 1);
        expect(identical(sets[1], copy), isTrue);
        expect(copy.done, isFalse);
        expect((copy.reps, copy.weight), (7, 42.5));
        fit.removeSetObject(0, copy);
        expect(sets.length, before);
        expect(sets.contains(copy), isFalse);
      });
    });
  });

  group('#122 salir del entreno', () {
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

    test('salir pausa y deja volver donde estabas', () {
      fit.startRoutine(routineOf(['Barbell Bench Press']));
      fit.endCountdown();
      fit.stepOutOfSession();
      expect(fit.route, 'home');
      expect(fit.sessionPaused, isTrue);
      expect(fit.sessionParked, isTrue);

      fit.stepBackIntoSession();
      expect(fit.route, 'session');
      expect(fit.sessionPaused, isFalse);
    });

    test('empezar otra cosa con uno aparcado vuelve al aparcado', () {
      fit.startRoutine(routineOf(['Barbell Bench Press']));
      fit.endCountdown();
      final session = fit.session;
      fit.stepOutOfSession();
      fit.startRoutine(routineOf(['Barbell Squat']));
      expect(fit.session, same(session));
      expect(fit.route, 'session');
    });
  });
}
