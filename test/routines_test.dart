import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_share.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('planned routines', () {
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

    test('planned sets open the workout with their type, reps and weight', () {
      final bench = idOf('Barbell Bench Press');
      final r = routineWith([bench]);
      fit.setPlannedSets(r.id, bench, const [
        PlannedSet(reps: 12, weightKg: 30, kind: SetKind.warmup),
        PlannedSet(reps: 8, weightKg: 70),
        PlannedSet(reps: 6, weightKg: 75, kind: SetKind.drop),
      ]);
      expect(fit.routineSets(r, bench), 2);
      fit.startRoutine(r);
      final sets = fit.session!.exercises.single.sets;
      expect(sets.map((s) => s.kind), [SetKind.warmup, SetKind.normal, SetKind.drop]);
      expect(sets.map((s) => s.reps), [12, 8, 6]);
      expect(sets.map((s) => s.weight), [30, 70, 75]);
    });

    test('the set stepper grows and shrinks the plan, never below one working set', () {
      final bench = idOf('Barbell Bench Press');
      final r = routineWith([bench]);
      fit.setPlannedSets(r.id, bench, const [
        PlannedSet(kind: SetKind.warmup),
        PlannedSet(reps: 5, weightKg: 100),
      ]);
      fit.bumpRoutineSets(r.id, bench, 2);
      expect(fit.routineSets(r, bench), 3);
      expect(fit.plannedSets(r, bench).last.weightKg, 100);
      fit.bumpRoutineSets(r.id, bench, -5);
      expect(fit.routineSets(r, bench), 1);
      expect(fit.plannedSets(r, bench).first.kind, SetKind.warmup);
    });

    test('a finished workout saved as routine keeps its sets and supersets', () {
      final ids = [idOf('Barbell Bench Press'), idOf('Barbell Bent Over Row')];
      final r = routineWith(ids);
      fit.toggleChain(r.id, ids.first);
      fit.startRoutine(r);
      fit.setSessionWeight(0, 0, 62.5);
      final saved = fit.saveSessionAsRoutine('Copy');
      final made = fit.routines.firstWhere((x) => x.id == saved);
      expect(made.chained, contains(ids.first));
      expect(fit.plannedSets(made, ids.first).first.weightKg, 62.5);
    });
  });

  group('#212 series añadidas en la rutina', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    String bench() => fit.matchExerciseByName('Bench Press')!.id;

    String squat() => fit.matchExerciseByName('Barbell Squat')!.id;

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

    test('añadir una serie se ofrece guardar y queda en la rutina', () {
      final r = routine('A', [bench(), squat()]);
      expect(fit.routineSets(r, bench()), 3);
      fit.startRoutine(r);
      fit.endCountdown();
      fit.addSet(0);
      fit.removeSet(1, 2);
      fit.toggleSet(0, 0);
      fit.finishSession();
      expect(fit.sessionEditedRoutine, isTrue);
      final changes = fit.sessionRoutineChanges;
      expect(changes.added, isEmpty);
      expect([for (final c in changes.sets) (c.ex.id, c.from, c.to)], [(bench(), 3, 4), (squat(), 3, 2)]);
      fit.saveSessionIntoRoutine();
      expect(fit.routineSets(r, bench()), 4);
      expect(fit.routineSets(r, squat()), 2);
      expect(fit.sessionEditedRoutine, isFalse);
    });

    test('con series planificadas copia la última', () {
      final r = routine('A');
      fit.setPlannedSets(r.id, bench(), const [
        PlannedSet(kind: SetKind.warmup, reps: 10),
        PlannedSet(reps: 8, weightKg: 60),
        PlannedSet(reps: 6, weightKg: 70),
      ]);
      fit.startRoutine(r);
      fit.endCountdown();
      fit.addSet(0);
      fit.toggleSet(0, 0);
      fit.finishSession();
      fit.saveSessionIntoRoutine();
      final plan = fit.plannedSets(r, bench());
      expect(plan.length, 4);
      expect(plan.first.kind, SetKind.warmup);
      expect(plan.last.reps, 6);
      expect(plan.last.weightKg, 70);
    });

    test('sin cambios no molesta', () {
      final r = routine('A');
      train(r);
      expect(fit.sessionEditedRoutine, isFalse);
    });
  });

  group('#102 guardar la rutina', () {
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

    test('sin cambios no hay nada que guardar', () {
      fit.startRoutine(routineOf(['Barbell Bench Press']));
      expect(fit.sessionRoutine, isNotNull);
      expect(fit.sessionEditedRoutine, isFalse);
    });

    test('añadir un ejercicio se puede llevar a la rutina', () {
      final r = routineOf(['Barbell Bench Press']);
      fit.startRoutine(r);
      fit.addExerciseToSession(idOf('Barbell Squat'));
      expect(fit.sessionEditedRoutine, isTrue);

      fit.saveSessionIntoRoutine();
      expect(r.exerciseIds, [idOf('Barbell Bench Press'), idOf('Barbell Squat')]);
      expect(fit.sessionEditedRoutine, isFalse);
    });

    test('los cambios se enseñan antes de guardarlos', () {
      final r = routineOf(['Barbell Bench Press', 'Barbell Squat', 'Barbell Deadlift']);
      fit.startRoutine(r);
      fit.removeSessionExercise(2);
      fit.addExerciseToSession(idOf('Barbell Curl'));
      fit.reorderSessionExercise(2, 0);
      final changes = fit.sessionRoutineChanges;
      expect(changes.added.map((e) => e.id), [idOf('Barbell Curl')]);
      expect(changes.removed.map((e) => e.id), [idOf('Barbell Deadlift')]);
      expect(changes.reordered, isTrue);
      expect(r.exerciseIds, hasLength(3), reason: 'nada cambia hasta aceptar');
    });

    test('una sesión suelta se guarda con el nombre elegido', () {
      fit.startRoutine(routineOf(['Barbell Bench Press']));
      fit.session!.routineId = null;
      final id = fit.saveSessionAsRoutine('Pecho');
      expect(fit.routines.firstWhere((r) => r.id == id).name, 'Pecho');
      expect(fit.sessionRoutine?.id, id, reason: 'el botón no vuelve a salir');
    });
  });

  group('series y planes de rutina', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    String bench() => fit.matchExerciseByName('Barbell Bench Press')!.id;

    Routine routineWith(List<String> ids) {
      final id = fit.createRoutine('Push');
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    group('series planificadas', () {
      test('la sesión abre con las series que pusiste en la rutina', () {
        final r = routineWith([bench()]);
        fit.bumpRoutineSets(r.id, bench(), 2);
        expect(fit.routineSets(r, bench()), 5);

        fit.startRoutine(r);
        expect(fit.session!.exercises.single.sets.length, 5);
      });

      test('quitar el ejercicio se lleva sus series', () {
        final r = routineWith([bench()]);
        fit.bumpRoutineSets(r.id, bench(), 1);
        fit.toggleRoutineExercise(r.id, bench());
        expect(r.sets, isEmpty);
      });

      test('al marcar la última serie salta al siguiente ejercicio', () async {
        final squat = fit.matchExerciseByName('Barbell Squat') ?? fit.allExercises[1];
        final r = routineWith([bench(), squat.id]);
        fit.bumpRoutineSets(r.id, bench(), -2);
        fit.startRoutine(r);

        expect(fit.session!.exercises.first.sets.length, 1);
        fit.toggleSet(0, 0);
        expect(fit.session!.currentIndex, 0, reason: 'primero se ve el tic marcado');

        await Future<void>.delayed(WorkoutState.advanceDelay + const Duration(milliseconds: 200));
        expect(fit.session!.currentIndex, 1);
      });

      test('desmarcar antes de tiempo cancela el salto', () async {
        final squat = fit.matchExerciseByName('Barbell Squat') ?? fit.allExercises[1];
        final r = routineWith([bench(), squat.id]);
        fit.bumpRoutineSets(r.id, bench(), -2);
        fit.startRoutine(r);

        fit.toggleSet(0, 0);
        fit.toggleSet(0, 0);
        await Future<void>.delayed(WorkoutState.advanceDelay + const Duration(milliseconds: 200));
        expect(fit.session!.currentIndex, 0);
      });

      test('con el salto apagado se queda donde estaba', () async {
        fit.toggleAutoAdvance();
        final squat = fit.matchExerciseByName('Barbell Squat') ?? fit.allExercises[1];
        final r = routineWith([bench(), squat.id]);
        fit.bumpRoutineSets(r.id, bench(), -2);
        fit.startRoutine(r);
        fit.toggleSet(0, 0);
        await Future<void>.delayed(WorkoutState.advanceDelay + const Duration(milliseconds: 200));
        expect(fit.session!.currentIndex, 0);
        fit.toggleAutoAdvance();
      });
    });

    group('calentamiento pegado al ejercicio', () {
      test('la sesión abre con las series de calentamiento delante', () {
        fit.toggleAutoWarmup(bench());
        final r = routineWith([bench()]);
        fit.startRoutine(r);

        final sets = fit.session!.exercises.first.sets;
        expect(sets.first.kind, SetKind.warmup);
        expect(sets.where((s) => s.kind == SetKind.warmup).length, 3);
        expect(sets.where((s) => s.counts).length, 3);
      });
    });

    group('grupos de rutinas', () {
      test('agrupa y deja fuera las sueltas', () {
        final a = fit.createRoutine('Push');
        final b = fit.createRoutine('Pull');
        fit.createRoutine('Suelta');
        fit.setRoutineGroup(a, 'PPL');
        fit.setRoutineGroup(b, 'PPL');

        expect(fit.routineGroups, ['PPL']);
        expect(fit.routinesInGroup('PPL').length, 2);
        expect(fit.routinesInGroup('').single.name, 'Suelta');
      });

      test('el grupo aguanta un guardado y una carga', () {
        final a = fit.createRoutine('Push');
        fit.setRoutineGroup(a, 'PPL');
        final saved = fit.toJson();
        fit.resetAllData();
        fit.applyBackup(saved);
        expect(fit.routines.single.group, 'PPL');
      });
    });

    group('planes hechos', () {
      test('cada ejercicio de cada plantilla existe en el catálogo', () {
        for (final template in kProgramTemplates) {
          for (final day in template.days) {
            for (final (name, _) in day.exercises) {
              expect(fit.matchExerciseByName(name), isNotNull,
                  reason: '${template.name} · $name');
            }
          }
        }
      });

      test('aplicar un plan crea sus rutinas agrupadas y con sus series', () {
        final made = fit.applyTemplate(kProgramTemplates.firstWhere((x) => x.id == 'stronglifts'));
        expect(made, 2);
        expect(fit.routineGroups, ['StrongLifts 5×5']);
        final a = fit.routinesInGroup('StrongLifts 5×5').first;
        expect(a.exerciseIds.length, 3);
        expect(fit.routineSets(a, a.exerciseIds.first), 5);
      });

      test('la Recommended Routine es una sola rutina puesta lunes, miércoles y viernes', () {
        final made = fit.applyTemplate(kProgramTemplates.firstWhere((x) => x.id == 'rr'));
        expect(made, 1);
        final id = fit.routinesInGroup('Recommended Routine').single.id;
        expect(fit.weeklyPlan, {1: id, 3: id, 5: id});
      });

      test('coloca los días solo si el plan semanal estaba vacío', () {
        fit.applyTemplate(kProgramTemplates.firstWhere((x) => x.id == 'stronglifts'));
        expect(fit.weeklyPlan.length, 2);

        final before = Map.of(fit.weeklyPlan);
        fit.applyTemplate(kProgramTemplates.firstWhere((x) => x.id == 'ppl'));
        expect(fit.weeklyPlan, before);
      });
    });

    group('copiar rutinas', () {
      test('duplicar se lleva ejercicios, series y grupo', () {
        final r = routineWith([bench()]);
        fit.bumpRoutineSets(r.id, bench(), 2);
        fit.setRoutineGroup(r.id, 'PPL');

        final copy = fit.duplicateRoutine(r.id);
        final made = fit.routines.firstWhere((x) => x.id == copy);
        expect(made.exerciseIds, r.exerciseIds);
        expect(fit.routineSets(made, bench()), 5);
        expect(made.group, 'PPL');
        expect(made.name.contains(r.name), isTrue);
      });

      test('guardar la sesión como rutina se queda con las series buenas', () {
        fit.toggleAutoWarmup(bench());
        final r = routineWith([bench()]);
        fit.bumpRoutineSets(r.id, bench(), 1);
        fit.startRoutine(r);

        final id = fit.saveSessionAsRoutine('Copy');
        final made = fit.routines.firstWhere((x) => x.id == id);
        expect(made.exerciseIds, [bench()]);
        expect(fit.routineSets(made, bench()), 4);
      });
    });
  });

  group('naming a routine', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    test('a new routine starts unnamed so the field shows its hint', () {
      final id = fit.createRoutine();
      expect(fit.routines.single.name, '');
      expect(fit.routineTitle(fit.routines.single), t.newRoutineName);
      fit.renameRoutine(id, 'Empuje');
      expect(fit.routineTitle(fit.routines.single), 'Empuje');
    });

    test('clearing the name to retype it does not stick the old one', () {
      final id = fit.createRoutine('Viejo');
      fit.renameRoutine(id, '');
      expect(fit.routines.single.name, '');
      fit.renameRoutine(id, 'Nuevo');
      expect(fit.routines.single.name, 'Nuevo');
    });
  });

  group('#378 el mismo ejercicio varias veces', () {
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
    String bench() => idOf('Barbell Bench Press');
    String ext() => idOf('Leg Extension');
    String curl() => idOf('Lying Leg Curl');

    Routine blocks() {
      final id = fit.createRoutine('Bloques');
      fit.toggleRoutineExercise(id, bench());
      fit.toggleRoutineExercise(id, ext());
      fit.addRoutineSlot(id, bench(), like: bench());
      fit.toggleRoutineExercise(id, curl());
      return fit.routineById(id)!;
    }

    test('se añade otra vez con su propio hueco y el primero no cambia', () {
      final r = blocks();
      expect(r.exerciseIds, [bench(), ext(), '${bench()}#2', curl()]);
      expect(fit.routineExercises(r).map((e) => e.id), [bench(), ext(), bench(), curl()]);
      expect(fit.routineHas(r.id, bench()), isTrue);
      expect(fit.routineCountOf(r.id, bench()), 2);
      expect(fit.routineRepeat(r, bench()), (n: 1, of: 2));
      expect(fit.routineRepeat(r, '${bench()}#2'), (n: 2, of: 2));
      expect(fit.routineRepeat(r, ext()), (n: 1, of: 1));
    });

    test('las series alternas van por hueco: solo enlaza el bloque que toca', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.toggleChain(r.id, second);
      fit.toggleJump(r.id, second);
      expect(fit.jumpsToNext(r, second), isTrue);
      expect(fit.jumpsToNext(r, bench()), isFalse);
      expect(fit.chainsToNext(r, bench()), isFalse);
      fit.startRoutine(r);
      fit.endCountdown();
      final exs = fit.session!.exercises;
      expect([for (final e in exs) e.jumpNext], [false, false, true, false]);
      expect([for (final e in exs) e.linkedNext], [false, false, true, false]);
      fit.saveAndExit();
      final copy = Routine.fromJson(fit.routineById(r.id)!.toJson());
      expect(copy.jumped, {second});
      fit.removeRoutineExercise(r.id, second);
      expect(fit.routineById(r.id)!.jumped, isEmpty);
      expect(fit.routineById(r.id)!.chained, isEmpty);
    });

    test('cada hueco guarda sus series, plan, descanso y nota por separado', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.setRoutineSetCount(r.id, bench(), 4);
      fit.setPlannedSets(r.id, second, const [PlannedSet(reps: 12, weightKg: 50), PlannedSet(reps: 12, weightKg: 50)]);
      fit.setRoutineRest(r.id, bench(), 180);
      fit.setRoutineRest(r.id, second, 60);
      fit.setRoutineExerciseNote(r.id, second, 'Más ligero');
      expect(fit.routineSets(r, bench()), 4);
      expect(fit.routineSets(r, second), 2);
      expect(fit.hasPlan(r, bench()), isFalse);
      expect(fit.routineRest(r.id, bench()), 180);
      expect(fit.routineRest(r.id, second), 60);
      expect(fit.routineExerciseNote(r.id, bench()), isNull);
      expect(fit.routineExerciseNote(r.id, second), 'Más ligero');
    });

    test('añadir otra vez copia series, plan, descanso y alternativas, pero no la superserie ni la nota', () {
      final id = fit.createRoutine('Copia');
      fit.toggleRoutineExercise(id, bench());
      fit.toggleRoutineExercise(id, ext());
      fit.setPlannedSets(id, bench(), const [PlannedSet(reps: 5, weightKg: 100)]);
      fit.setRoutineRest(id, bench(), 200);
      fit.toggleRoutineAlt(id, bench(), idOf('Dumbbell Bench Press'));
      fit.toggleChain(id, bench());
      fit.setRoutineExerciseNote(id, bench(), 'Pausa abajo');
      final slot = fit.addRoutineSlot(id, bench(), like: bench());
      final r = fit.routineById(id)!;
      expect(slot, '${bench()}#2');
      expect(r.exerciseIds.last, slot);
      expect(fit.plannedSets(r, slot).single.weightKg, 100);
      expect(fit.routineRest(id, slot), 200);
      expect(fit.routineAlts(id, slot), [idOf('Dumbbell Bench Press')]);
      expect(fit.chainsToNext(r, slot), isFalse);
      expect(fit.routineExerciseNote(id, slot), isNull);
    });

    test('tocarlo en la lista quita la última vez, no la primera', () {
      final r = blocks();
      fit.setRoutineSetCount(r.id, bench(), 5);
      fit.toggleRoutineExercise(r.id, bench());
      expect(r.exerciseIds, [bench(), ext(), curl()]);
      expect(fit.routineSets(r, bench()), 5);
      fit.toggleRoutineExercise(r.id, bench());
      expect(fit.routineHas(r.id, bench()), isFalse);
    });

    test('quitar el segundo y deshacer lo deja en su sitio con sus datos', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.setRoutineSetCount(r.id, second, 6);
      final undo = fit.removeRoutineExercise(r.id, second)!;
      expect(r.exerciseIds, [bench(), ext(), curl()]);
      undo();
      expect(r.exerciseIds, [bench(), ext(), second, curl()]);
      expect(fit.routineSets(r, second), 6);
    });

    test('el entreno tiene los dos bloques, cada uno con sus series y su descanso', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.setRoutineSetCount(r.id, bench(), 4);
      fit.setRoutineSetCount(r.id, second, 2);
      fit.setRoutineRest(r.id, second, 45);
      fit.toggleChain(r.id, second);
      fit.startRoutine(r);
      final ex = fit.session!.exercises;
      expect(ex.map((e) => e.id), [bench(), ext(), bench(), curl()]);
      expect(ex.map((e) => e.routineSlot), [bench(), ext(), second, curl()]);
      expect(ex[0].sets.where((s) => s.counts).length, 4);
      expect(ex[2].sets.where((s) => s.counts).length, 2);
      expect(ex[0].linkedNext, isFalse);
      expect(ex[2].linkedNext, isTrue);
      expect(fit.normalRestAfter(2, 0), 45);
      expect(fit.nthInSession(ex[0]), 0);
      expect(fit.nthInSession(ex[2]), 1);
      expect(fit.sessionEditedRoutine, isFalse);
    });

    test('cada bloque empieza con lo que hiciste en ese mismo bloque la vez anterior', () {
      final r = blocks();
      fit.sessions.add(LoggedSession(DateTime.now().subtract(const Duration(days: 3)), 3600, [
        LoggedExercise(bench(), 'Bench', 'chest', [LoggedSet(5, 100), LoggedSet(5, 100), LoggedSet(5, 100)]),
        LoggedExercise(ext(), 'Ext', 'quads', [LoggedSet(12, 40)]),
        LoggedExercise(bench(), 'Bench', 'chest', [LoggedSet(10, 70), LoggedSet(10, 70), LoggedSet(10, 70)]),
      ], routineId: r.id));
      expect(fit.lastSetsFor(bench()).first.weight, 100);
      expect(fit.lastSetsFor(bench(), 1).first.weight, 70);
      expect(fit.lastSetsFor(bench(), 5).first.weight, 100);
      fit.startRoutine(r);
      final ex = fit.session!.exercises;
      expect(ex[0].sets.where((s) => s.counts).first.weight, 100);
      expect(ex[2].sets.where((s) => s.counts).first.weight, 70);
      expect(ex[2].sets.where((s) => s.counts).first.reps, 10);
    });

    test('al acabar se guardan los dos bloques y el segundo no cuenta como récord si no supera al primero', () {
      final r = blocks();
      fit.sessions.add(LoggedSession(DateTime.now().subtract(const Duration(days: 3)), 3600, [
        LoggedExercise(bench(), 'Bench', 'chest', [LoggedSet(5, 80)]),
      ]));
      fit.startRoutine(r);
      fit.endCountdown();
      final ex = fit.session!.exercises;
      for (final i in [0, 2]) {
        for (var k = 0; k < ex[i].sets.length; k++) {
          if (!ex[i].sets[k].counts) continue;
          fit.setSessionWeight(i, k, 100);
          fit.setSessionReps(i, k, 5);
          fit.toggleSet(i, k);
        }
      }
      fit.finishSession();
      final logged = fit.filedSession!;
      expect(logged.exercises.map((e) => e.id), [bench(), bench()]);
      expect(fit.summaryRecords.length, 1);
      expect(identical(fit.summaryRecords.single.$1, logged.exercises.first), isTrue);
    });

    test('cambiar el segundo bloque por otro ejercicio y guardar solo toca ese hueco', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.setRoutineSetCount(r.id, bench(), 5);
      fit.startRoutine(r);
      final db = idOf('Dumbbell Bench Press');
      fit.swapSessionExercise(2, db);
      expect(fit.session!.exercises[2].routineSlot, second);
      expect(fit.sessionEditedRoutine, isTrue);
      final changes = fit.sessionRoutineChanges;
      expect(changes.added.map((e) => e.id), [db]);
      expect(changes.removed.map((e) => e.id), [bench()]);
      fit.saveSessionIntoRoutine();
      expect(r.exerciseIds, [bench(), ext(), db, curl()]);
      expect(fit.routineSets(r, bench()), 5);
      expect(fit.sessionEditedRoutine, isFalse);
    });

    test('quitar un bloque del entreno y guardar quita solo ese', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.setRoutineRest(r.id, second, 30);
      fit.startRoutine(r);
      fit.removeSessionExercise(0);
      expect(fit.sessionRoutineChanges.removed.map((e) => e.id), [bench()]);
      fit.saveSessionIntoRoutine();
      expect(r.exerciseIds, [ext(), second, curl()]);
      expect(fit.routineRest(r.id, second), 30);
    });

    test('cambiar series de un bloque en el entreno y guardar cambia solo ese bloque', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.setRoutineSetCount(r.id, bench(), 3);
      fit.setRoutineSetCount(r.id, second, 3);
      fit.startRoutine(r);
      fit.session!.exercises[2].sets.removeLast();
      final sets = fit.sessionRoutineChanges.sets;
      expect(sets.single.slot, second);
      fit.saveSessionIntoRoutine();
      expect(fit.routineSets(r, bench()), 3);
      expect(fit.routineSets(r, second), 2);
    });

    test('guardar como rutina nueva respeta los bloques repetidos', () {
      final r = blocks();
      fit.toggleChain(r.id, '${bench()}#2');
      fit.startRoutine(r);
      final made = fit.saveSessionAsRoutine('Copia');
      final copy = fit.routineById(made)!;
      expect(copy.exerciseIds, [bench(), ext(), '${bench()}#2', curl()]);
      expect(fit.chainsToNext(copy, '${bench()}#2'), isTrue);
      expect(fit.session!.exercises[2].routineSlot, '${bench()}#2');
      expect(fit.sessionEditedRoutine, isFalse);
    });

    test('la copia de seguridad y duplicar la rutina conservan los huecos', () {
      final r = blocks();
      final second = '${bench()}#2';
      fit.setRoutineSetCount(r.id, second, 7);
      final copy = fit.routineById(fit.duplicateRoutine(r.id))!;
      expect(copy.exerciseIds, r.exerciseIds);
      expect(fit.routineSets(copy, second), 7);
      final back = Routine.fromJson(r.toJson());
      expect(back.exerciseIds, r.exerciseIds);
      expect(back.sets[second], 7);
      final json = fit.exportJson();
      fit.resetAllData();
      expect(fit.importJson(json), isTrue);
      final again = fit.routines.firstWhere((x) => x.name == 'Bloques');
      expect(again.exerciseIds, [bench(), ext(), second, curl()]);
      expect(fit.routineSets(again, second), 7);
    });

    test('una lista con el mismo id repetido se arregla al cargarla', () {
      final r = Routine.fromJson({
        'id': 'r1',
        'n': 'Vieja',
        'ex': ['a', 'b', 'a', 'a#2', ''],
      });
      expect(r.exerciseIds, ['a', 'b', 'a#2', 'a#3']);
    });

    test('borrar un ejercicio propio lo quita de todos sus huecos', () {
      final own = fit.addCustomExercise(name: 'Mi press', primary: 'chest', equipment: 'Barbell');
      final id = fit.createRoutine('Propio');
      fit.toggleRoutineExercise(id, own);
      fit.toggleRoutineExercise(id, ext());
      fit.addRoutineSlot(id, own);
      fit.deleteCustomExercise(own);
      expect(fit.routineById(id)!.exerciseIds, [ext()]);
    });

    test('exportar e importar el plan mantiene los bloques separados', () {
      final r = blocks();
      fit.setRoutineSetCount(r.id, bench(), 4);
      fit.setRoutineSetCount(r.id, '${bench()}#2', 2);
      final json = fit.exportPlanJson([r]);
      final plans = parsePlan(json);
      expect(plans.single.items.map((i) => i.id), [bench(), ext(), bench(), curl()]);
      fit.resetAllData();
      final done = fit.applyPlan(plans);
      expect(done.routines, 1);
      final made = fit.routines.single;
      expect(made.exerciseIds, [bench(), ext(), '${bench()}#2', curl()]);
      expect(fit.routineSets(made, bench()), 4);
      expect(fit.routineSets(made, '${bench()}#2'), 2);
      expect(fit.ownsPlan(plans.single), isTrue);
    });

    test('dos filas seguidas del mismo ejercicio en un plan siguen siendo uno', () {
      final plans = parsePlan('{"routines":[{"name":"A","exercises":['
          '{"name":"Barbell Bench Press","sets":1,"reps":10,"plan":[{"type":"warmup","reps":10}]},'
          '{"name":"Barbell Bench Press","sets":3,"reps":5},'
          '{"name":"Leg Extension","sets":3},'
          '{"name":"Barbell Bench Press","sets":2}]}]}');
      expect(plans.single.items.length, 3);
    });
  });
}
