import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
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
}
