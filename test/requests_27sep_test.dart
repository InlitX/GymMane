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

  group('#83 mapa de actividad', () {
    test('un día de peso corporal se pinta', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(15, 0), LoggedSet(12, 0)]));
      expect(fit.heatmapLevels.last, greaterThan(0));
    });

    test('un día marcado a mano también cuenta', () {
      fit.toggleCheckin(fit.todayIndex);
      expect(fit.heatmapLevels.last, greaterThan(0));
    });
  });

  group('#104 récords sin peso', () {
    test('peso corporal: el récord son las repeticiones', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(15, 0), LoggedSet(22, 0)]));
      final pr = fit.personalRecords.single;
      expect(pr.kind, PrKind.reps);
      expect(pr.best, 22);
    });

    test('isométrico: el récord es el tiempo', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(0, 0, sec: 45), LoggedSet(0, 0, sec: 70)]));
      final pr = fit.personalRecords.single;
      expect(pr.kind, PrKind.time);
      expect(fit.recordLabel(pr), isNot(contains('kg')));
    });

    test('con peso manda el peso y va primero en la lista', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(30, 0)], id: 'dips'));
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 100)], id: 'bench'));
      expect(fit.personalRecords.map((r) => r.id), ['bench', 'dips']);
      expect(fit.personalRecords.first.kind, PrKind.weight);
    });
  });

  group('#92 inicio de semana', () {
    test('empezar en domingo mueve toda la semana', () {
      fit.setWeekStart(DateTime.sunday);
      expect(fit.weekStartDate.weekday, DateTime.sunday);
      expect(fit.weekdayAt(0), DateTime.sunday);
      expect(fit.dateForWeekday(fit.todayIndex).day, DateTime.now().day);
    });

    test('se guarda con el resto de ajustes', () {
      fit.setWeekStart(DateTime.saturday);
      expect(fit.toJson()['weekStart'], DateTime.saturday);
      fit.setWeekStart(4);
      expect(fit.weekStartDay, DateTime.saturday, reason: 'solo lunes, sábado o domingo');
    });
  });

  group('#117 objetivo semanal por días', () {
    test('dos sesiones el mismo día son un día', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 60)]));
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 60)]));
      expect(fit.daysDoneThisWeek, 1);
    });

    test('marcar y desmarcar un día lo deja como estaba', () {
      final before = fit.daysDoneThisWeek;
      fit.toggleCheckin(fit.todayIndex);
      expect(fit.daysDoneThisWeek, before + 1);
      fit.toggleCheckin(fit.todayIndex);
      expect(fit.daysDoneThisWeek, before);
      expect(fit.currentStreak, 0);
    });
  });

  group('#122 salir del entreno', () {
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

  group('#102 guardar la rutina', () {
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
      fit.reorderSessionExercise(1, 0);
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

  group('#115 sin material', () {
    tearDown(fit.clearExFilters);

    test('no enseña lo que necesita barra', () {
      fit.toggleNoGearFilter();
      final ids = fit.exercisesMatching('').map((e) => e.id).toSet();
      expect(ids, isNot(contains(idOf('Pull-up'))));
      expect(ids, isNot(contains('seal-jack')), reason: 'su dibujo es una estación de fondos');
      expect(ids, isNot(contains('outdoor-run')), reason: 'el dibujo es una cinta');
      expect(ids, contains(idOf('Push-up')));
    });

    test('elegir material lo apaga y al revés', () {
      fit.toggleNoGearFilter();
      fit.setEquipmentFilter('Barbell');
      expect(fit.exNoGearOnly, isFalse);
      fit.toggleNoGearFilter();
      expect(fit.exEquipmentFilter, isNull);
    });
  });

  test('#89 solo los creados por ti', () {
    final id = fit.addCustomExercise(name: 'Mi press', primary: 'chest', equipment: 'Dumbbell');
    fit.toggleMineFilter();
    expect(fit.exercisesMatching('').map((e) => e.id), [id]);
    fit.clearExFilters();
  });

  group('#120 calentamiento y #106 cardio', () {
    test('los ejercicios sin peso también calientan', () {
      fit.startRoutine(routineOf(['Push-up']));
      fit.addWarmupSets(0);
      expect(fit.hasWarmup(0), isTrue);
    });

    test('el calentamiento propone movilidad y el cardio solo cardio', () {
      fit.startWorkout();
      fit.startKindWorkout('warmup');
      expect(fit.sessionPicks, isNotEmpty);
      expect(fit.reviewExercises().where((e) => const ['Machine', 'Cable'].contains(e.equipment)), isEmpty);
      fit.startKindWorkout('cardio');
      final cardio = fit.reviewExercises().map((e) => e.id).toSet();
      expect(cardio, containsAll(['skierg', 'battle-ropes', 'running']));
      expect(cardio.every((id) => fit.isCardio(id) || kCardioExtras.contains(id)), isTrue);
      fit.closeTrain();
    });
  });

  group('#119 archivar', () {
    test('un archivado desaparece de todo y vuelve al restaurarlo', () {
      final id = idOf('Pull-up');
      fit.toggleArchived(id);
      expect(fit.exercisesMatching('').map((e) => e.id), isNot(contains(id)));
      expect(fit.trainSearchResults('pull').map((e) => e.id), isNot(contains(id)));
      expect(fit.getFilteredExercises(['back']).map((e) => e.id), isNot(contains(id)));
      expect(fit.recommendedExercises(40).map((e) => e.id), isNot(contains(id)));

      fit.toggleArchivedFilter();
      expect(fit.exercisesMatching('').map((e) => e.id), [id]);

      fit.toggleArchived(id);
      expect(fit.exArchivedOnly, isFalse, reason: 'sin archivados el filtro se apaga');
      expect(fit.exercisesMatching('').map((e) => e.id), contains(id));
    });

    test('se guarda en la copia', () {
      fit.toggleArchived(idOf('Pull-up'));
      expect(fit.toJson()['archived'], [idOf('Pull-up')]);
    });
  });

  test('#95 los recomendados se pueden quitar y se guarda', () {
    expect(fit.showRecommended, isTrue);
    fit.toggleRecommended();
    expect(fit.toJson()['showRecs'], isFalse);
  });

  test('#111 las marcas del vídeo se guardan y se van con el vídeo', () {
    final id = idOf('Barbell Bench Press');
    fit.setVideoMark(id, 1, 40000);
    expect(fit.videoMark(id, 1), 40000);
    expect(fit.toJson()['marks'], {id: {'1': 40000}});
    fit.setVideoMark(id, 1, null);
    expect(fit.videoMarks, isEmpty);
    fit.setVideoMark(id, 0, 1000);
    fit.clearExerciseMedia(id);
    expect(fit.videoMark(id, 0), isNull);
  });

  group('#86 varias rutinas al día', () {
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

  group('texto para la IA', () {
    test('un usuario nuevo pide empezar suave y que le pregunten', () {
      final text = fit.planRequestText();
      expect(text, contains(t.planNoHistory));
      expect(text, contains(t.planAskFirst));
      expect(text, contains(t.planDays(fit.weeklyTarget)));
    });

    test('con historial lleva los entrenos y las mejores series', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 100)], id: idOf('Barbell Bench Press')));
      final text = fit.planRequestText();
      expect(text, isNot(contains(t.planNoHistory)));
      expect(text, contains(t.planHistory(1)));
      expect(text, contains(t.planBestLifts));
    });
  });

  group('#107 entreno pasado con su hora', () {
    test('la hora y la duración elegidas llegan al historial', () {
      final day = DateTime.now().subtract(const Duration(days: 2));
      fit.startRoutine(routineOf(['Barbell Bench Press']), on: day);
      fit.setManualStart(18 * 60 + 30);
      fit.setManualMinutes(45);
      fit.stepOutOfSession();
      fit.stepBackIntoSession();
      expect(fit.manualMinutes, 45, reason: 'salir y volver no toca la duración');
      fit.toggleSet(0, 0);
      fit.finishSession();
      final s = fit.sessions.last;
      expect(s.durationSec, 45 * 60);
      expect(s.date, DateTime(day.year, day.month, day.day, 19, 15));
    });
  });

  group('#99 músculos secundarios propios', () {
    test('se guardan, viajan en la copia y cuentan en las series', () {
      final id = fit.addCustomExercise(
          name: 'Thruster', primary: 'quads', equipment: 'Dumbbell', secondary: ['shoulders', 'quads', 'triceps']);
      final ex = fit.exerciseById(id)!;
      expect(ex.secondary, ['shoulders', 'triceps'], reason: 'sin repetir el principal');
      final json = ex.toJson();
      expect(json['s'], ['shoulders', 'triceps']);
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(8, 20), LoggedSet(8, 20)], id: id, primary: 'quads'));
      expect(fit.muscleSetsOver(7)['shoulders'], 1);
    });
  });

  group('#88 pausar el temporizador', () {
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

  test('#105 las notas de un ejercicio se abren en lista y atrás vuelve', () {
    fit.openExercise(idOf('Plank'));
    fit.goNotes(exerciseId: idOf('Plank'), all: true);
    expect(fit.notesAllView, isTrue);
    fit.backFromNotes();
    expect(fit.route, 'exercise-detail');
  });

  test('#125 la prensa usa su propio carro en la calculadora', () {
    final press = idOf('Leg Press');
    expect(fit.plateHint('Machine', 150, id: press), isNull);
    fit.setExerciseBar(press, 50);
    expect(fit.plateHint('Machine', 150, id: press), '25×2');
    expect(fit.toJson()['barKg'], {press: 50.0});
  });

  group('#85 racha con calendario', () {
    test('un día sin rutina no rompe la racha', () {
      final today = DateTime.now();
      final yesterday = DateTime(today.year, today.month, today.day - 1);
      final before = DateTime(today.year, today.month, today.day - 2);
      fit.sessions.add(logged(today, [LoggedSet(5, 60)]));
      fit.sessions.add(logged(before, [LoggedSet(5, 60)]));
      expect(fit.currentStreak, 1);

      final r = routineOf(['Barbell Bench Press']);
      for (var d = 1; d <= 7; d++) {
        if (d != yesterday.weekday) fit.assignRoutineToDay(d, r.id);
      }
      expect(fit.currentStreak, 2);
    });
  });
}
