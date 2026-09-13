import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/models/live_session.dart';
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

  group('ejercicios propios en la rutina', () {
    test('el que te creas aparece al montar la rutina', () {
      final id = fit.addCustomExercise(name: 'Sentadilla búlgara', primary: 'quads', equipment: 'Bodyweight');
      expect(fit.exercisesMatching('').map((e) => e.id), contains(id));
      expect(fit.exercisesMatching('bulgara').map((e) => e.id), contains(id));
    });

    test('el selector de la rutina respeta los filtros de la biblioteca', () {
      fit.setEquipmentFilter('Bodyweight');
      expect(fit.exercisesMatching('').every((e) => e.equipment == 'Bodyweight'), isTrue);
      fit.clearExFilters();
    });
  });

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

  group('progresión automática', () {
    void logBench(int reps, double kg, int sets) {
      final r = routineWith([bench()]);
      fit.startRoutine(r);
      final session = fit.session!;
      while (session.exercises.first.sets.length > sets) {
        session.exercises.first.sets.removeLast();
      }
      for (var i = 0; i < sets; i++) {
        fit.setSessionReps(0, i, reps);
        fit.setSessionWeight(0, i, kg);
        fit.toggleSet(0, i);
      }
      fit.finishSession();
      fit.saveAndExit();
    }

    test('sube el peso cuando cumpliste todas las repes', () {
      fit.toggleProgress(bench());
      logBench(5, 60, 3);

      final r = fit.routines.first;
      fit.startRoutine(r);
      expect(fit.session!.exercises.first.sets.first.weight, 62.5);
    });

    test('no sube si se te cayeron las repes', () {
      fit.toggleProgress(bench());
      final r = routineWith([bench()]);
      fit.startRoutine(r);
      final sets = fit.session!.exercises.first.sets;
      while (sets.length > 2) {
        sets.removeLast();
      }
      fit.setSessionReps(0, 0, 5);
      fit.setSessionWeight(0, 0, 60);
      fit.toggleSet(0, 0);
      fit.setSessionReps(0, 1, 3);
      fit.setSessionWeight(0, 1, 60);
      fit.toggleSet(0, 1);
      fit.finishSession();
      fit.saveAndExit();

      fit.startRoutine(fit.routines.first);
      expect(fit.session!.exercises.first.sets.first.weight, 60);
    });

    test('sin progresión el peso se queda como estaba', () {
      logBench(5, 60, 2);
      fit.startRoutine(fit.routines.first);
      expect(fit.session!.exercises.first.sets.first.weight, 60);
    });
  });

  group('recomendación para la próxima (issue #12)', () {
    void logBenchSets(List<(int, double)> sets) {
      final r = routineWith([bench()]);
      fit.startRoutine(r);
      final live = fit.session!.exercises.first.sets;
      while (live.length > sets.length) {
        live.removeLast();
      }
      while (live.length < sets.length) {
        fit.addSet(0);
      }
      for (var i = 0; i < sets.length; i++) {
        fit.setSessionReps(0, i, sets[i].$1);
        fit.setSessionWeight(0, i, sets[i].$2);
        fit.toggleSet(0, i);
      }
      fit.finishSession();
      fit.saveAndExit();
    }

    test('sin historial no propone nada', () {
      expect(fit.nextTarget(bench()), isNull);
      expect(fit.nextTargetLabel(bench()), isNull);
    });

    test('si cumpliste todas las repes propone subir', () {
      logBenchSets([(10, 60), (10, 60), (10, 60)]);
      final next = fit.nextTarget(bench())!;
      expect(next.up, isTrue);
      expect(next.weightKg, 62.5);
      expect(next.reps, 10);
      expect(fit.nextTargetLabel(bench()), '62.5 kg × 10');
    });

    test('si se te cayeron las repes propone repetir el peso', () {
      logBenchSets([(10, 60), (8, 60)]);
      final next = fit.nextTarget(bench())!;
      expect(next.up, isFalse);
      expect(next.weightKg, 60);
    });

    test('respeta el incremento que hayas puesto en el ejercicio', () {
      fit.toggleProgress(bench());
      fit.bumpProgressStep(bench(), 1);
      fit.bumpProgressStep(bench(), 1);
      expect(fit.progressFor(bench()), 5);
      logBenchSets([(5, 100), (5, 100)]);
      expect(fit.nextTarget(bench())!.weightKg, 105);
    });

    test('en un ejercicio sin peso propone una repe más', () {
      final pushUp = fit.matchExerciseByName('Push-Up')!.id;
      expect(fit.isRepsOnly(pushUp), isTrue);
      final r = routineWith([pushUp]);
      fit.startRoutine(r);
      final live = fit.session!.exercises.first.sets;
      while (live.length > 1) {
        live.removeLast();
      }
      fit.setSessionReps(0, 0, 12);
      fit.setSessionWeight(0, 0, 0);
      fit.toggleSet(0, 0);
      fit.finishSession();
      fit.saveAndExit();

      final next = fit.nextTarget(pushUp)!;
      expect(next.up, isTrue);
      expect(next.reps, 13);
      expect(fit.nextTargetLabel(pushUp), '13 reps');
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

  group('discos del sitio', () {
    test('la calculadora solo propone los discos que tienes', () {
      final id = fit.addPlace('Casa', equipment: {'Barbell'});
      fit.setActivePlace(id);
      fit.setPlatePairs(id, 20, 1);
      fit.setPlatePairs(id, 10, 1);

      final parts = fit.platesPerSide(100, 20);
      expect(parts.map((p) => p.weight), [20, 10]);
      expect(fit.loadableTotal(100, 20), 80);
    });

    test('sin inventario sigue proponiendo de todo', () {
      final parts = fit.platesPerSide(100, 20);
      expect(parts.first.weight, 25);
      expect(fit.loadableTotal(100, 20), 100);
    });

    test('la barra del sitio manda en el aviso del entreno', () {
      final id = fit.addPlace('Casa', equipment: {'Barbell'});
      fit.setActivePlace(id);
      fit.setPlaceBar(id, 15);
      expect(fit.defaultBar, 15);
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

      final id = fit.saveSessionAsRoutine();
      final made = fit.routines.firstWhere((x) => x.id == id);
      expect(made.exerciseIds, [bench()]);
      expect(fit.routineSets(made, bench()), 4);
    });
  });

  group('hábitos (recordatorio inteligente)', () {
    void logAt(DateTime when, int minutes) {
      fit.sessions.add(LoggedSession(when, minutes * 60,
          [LoggedExercise(bench(), 'Bench', 'chest', [LoggedSet(5, 60)])]));
    }

    test('sin historial no hay hábito', () {
      expect(fit.usualWeekdays, isEmpty);
      expect(fit.usualStartMinute, isNull);
      expect(fit.hasTrainingHabit, isFalse);
    });

    test('saca los días que más entrenas y la hora de siempre', () {
      final monday = DateTime(2026, 9, 7, 20, 0);
      for (var week = 0; week < 3; week++) {
        logAt(monday.add(Duration(days: 7 * week)), 60);
        logAt(monday.add(Duration(days: 7 * week + 2)), 60);
      }
      expect(fit.usualWeekdays, [1, 3]);
      expect(fit.usualStartMinute, 19 * 60);
      expect(fit.hasTrainingHabit, isTrue);
    });

    test('el foco de hoy sigue siendo uno de los tres días', () {
      final today = DateTime.now();
      for (var week = 1; week <= 3; week++) {
        fit.sessions.add(LoggedSession(today.subtract(Duration(days: 7 * week)), 3600,
            [LoggedExercise(bench(), 'Bench', 'chest', [LoggedSet(5, 60)])]));
      }
      expect(fit.familyOnWeekday(today.weekday), 'push');
      expect(fit.suggestedFocus.muscles, contains('chest'));
    });
  });

  group('superseries', () {
    ({Routine routine, String a, String b}) chainedPair() {
      final squat = fit.matchExerciseByName('Barbell Squat')!.id;
      final r = routineWith([bench(), squat]);
      fit.bumpRoutineSets(r.id, bench(), -1);
      fit.bumpRoutineSets(r.id, squat, -1);
      fit.toggleChain(r.id, bench());
      return (routine: r, a: bench(), b: squat);
    }

    test('el encadenado se guarda y se lee', () {
      final pair = chainedPair();
      expect(fit.chainsToNext(pair.routine, pair.a), isTrue);
      expect(fit.chainsToNext(pair.routine, pair.b), isFalse);

      final saved = fit.toJson();
      fit.resetAllData();
      fit.applyBackup(saved);
      expect(fit.routines.single.chained, {pair.a});
    });

    test('marcar una serie salta al encadenado sin descanso', () {
      final pair = chainedPair();
      fit.startRoutine(pair.routine);
      expect(fit.inSuperset, isTrue);

      fit.toggleSet(0, 0);
      expect(fit.session!.currentIndex, 1);
      expect(fit.session!.restRemaining, isNull);
    });

    test('al cerrar la vuelta descansa y vuelve al primero', () {
      final pair = chainedPair();
      fit.startRoutine(pair.routine);
      fit.session!.exercises[0].sets.add(SessionSet(10, 60, false));
      fit.session!.exercises[1].sets.add(SessionSet(10, 60, false));

      fit.toggleSet(0, 0);
      fit.toggleSet(1, 0);
      expect(fit.session!.restRemaining, isNotNull);
      expect(fit.session!.currentIndex, 0);
    });

    test('sin encadenar sigue el comportamiento de siempre', () async {
      final squat = fit.matchExerciseByName('Barbell Squat')!.id;
      final r = routineWith([bench(), squat]);
      fit.bumpRoutineSets(r.id, bench(), -2);
      fit.startRoutine(r);
      expect(fit.inSuperset, isFalse);
      fit.toggleSet(0, 0);
      expect(fit.session!.restRemaining, isNotNull);
      expect(fit.session!.currentIndex, 0, reason: 'el tic se ve antes de saltar');

      await Future<void>.delayed(WorkoutState.advanceDelay + const Duration(milliseconds: 200));
      expect(fit.session!.currentIndex, 1);
    });
  });

  group('ajustes nuevos', () {
    test('el objetivo semanal es el que se enseña en el anillo', () {
      fit.updateProfile(weeklyGoalDelta: 10 - fit.profile.weeklyGoal);
      expect(fit.weeklyTarget, 10);
      expect(fit.goalPct, 0);
    });

    test('el foco de hoy se puede apagar y se guarda', () {
      expect(fit.showFocus, isTrue);
      fit.toggleFocusCard();
      final saved = fit.toJson();
      fit.resetAllData();
      fit.applyBackup(saved);
      expect(fit.showFocus, isFalse);
    });

    test('la hora del aviso se guarda y se puede quitar', () {
      fit.setTrainReminder(19 * 60 + 30);
      final saved = fit.toJson();
      fit.resetAllData();
      fit.applyBackup(saved);
      expect(fit.trainReminderMin, 19 * 60 + 30);
      fit.setTrainReminder(null);
      expect(fit.trainReminderMin, isNull);
    });
  });
}
