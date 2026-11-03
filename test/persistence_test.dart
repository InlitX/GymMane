import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/profile.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.saveAndExit();
    fit.sessions.clear();
    fit.bodyweight.clear();
    fit.favorites.clear();
    fit.notes.clear();
    fit.checkins.clear();
    fit.routines.clear();
    fit.weeklyPlan.clear();
    fit.customExercises.clear();
    fit.profile = Profile();
    fit.setUnits('kg');
    fit.progressStep.clear();
    fit.autoWarmup.clear();
    fit.logRpe = false;
    fit.autoAdvance = true;
    fit.showFocus = true;
    fit.smartReminder = false;
    fit.trainReminderMin = null;
  });

  void fillEverything() {
    fit.updateProfile(name: 'Alex', sex: 'male');
    fit.setRestSeconds(120);
    fit.setUnits('lb');
    fit.setLanguage('es');
    fit.toggleFavorite(kFirstId);
    fit.saveNote(
        exerciseId: kFirstId,
        date: DateTime.now(),
        kind: NoteKind.plan,
        text: 'Subir 2.5 kg la próxima');
    fit.addBodyweight(74.5, note: 'Tras la semana de descarga');
    fit.setMiniRest(25);
    fit.setExerciseUnits(kFirstId, 'kg');
    final r = fit.createRoutine('Empuje');
    fit.toggleRoutineExercise(r, kFirstId);
    fit.assignRoutineToDay(1, r);
    fit.addCustomExercise(name: 'Mi ejercicio', primary: 'chest', equipment: 'Other');
    fit.toggleProgress(kFirstId);
    fit.toggleAutoWarmup(kFirstId);
    fit.toggleLogRpe();
    fit.toggleAutoAdvance();
    fit.toggleFocusCard();
    fit.setBgDim(0.72);
    fit.setTrainReminder(7 * 60 + 45);
    fit.setSmartReminder(true);
    fit.toggleChain(r, kFirstId);
    fit.setRoutineGroup(r, 'PPL');
    fit.bumpRoutineSets(r, kFirstId, 2);

    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    fit.startSession();
    fit.setSessionReps(0, 0, 10);
    fit.setSessionWeight(0, 0, 60);
    fit.toggleSet(0, 0);
    fit.finishSession();
    fit.saveAndExit();
  }

  void expectEverythingIsThere() {
    expect(fit.profile.name, 'Alex');
    expect(fit.restSeconds, 120);
    expect(fit.units, 'lb');
    expect(fit.language, 'es');
    expect(fit.favorites[kFirstId], true);
    expect(fit.notesFor(kFirstId).first.text, 'Subir 2.5 kg la próxima');
    expect(fit.notesFor(kFirstId).first.kind, NoteKind.plan);
    expect(fit.latestBodyweight!.kg, closeTo(74.5, 0.001));
    expect(fit.latestBodyweight!.note, 'Tras la semana de descarga');
    expect(fit.miniRestSeconds, 25);
    expect(fit.unitsFor(kFirstId), 'kg', reason: 'la app va en lb y este ejercicio en kg');
    expect(fit.routines.single.name, 'Empuje');
    expect(fit.routines.single.exerciseIds, [kFirstId]);
    expect(fit.weeklyPlan[1], fit.routines.single.id);
    expect(fit.customExercises.single.name, 'Mi ejercicio');
    expect(fit.sessions.single.exercises.single.sets.single.reps, 10);
    expect(fit.hasProgress(kFirstId), isTrue);
    expect(fit.warmsUp(kFirstId), isTrue);
    expect(fit.logRpe, isTrue);
    expect(fit.autoAdvance, isFalse);
    expect(fit.showFocus, isFalse);
    expect(fit.bgDim, 0.72);
    expect(fit.trainReminderMin, 7 * 60 + 45);
    expect(fit.smartReminder, isTrue);
    expect(fit.routines.single.chained, contains(kFirstId));
    expect(fit.routines.single.group, 'PPL');
    expect(fit.routineSets(fit.routines.single, kFirstId), 5);
  }

  test('everything survives a restart', () async {
    fillEverything();
    await pumpEventQueue();
    fit.loadFromStore();
    expectEverythingIsThere();
  });

  test('a backup round-trips through export and import', () {
    fillEverything();
    final backup = fit.exportJson();

    fit.sessions.clear();
    fit.favorites.clear();
    fit.routines.clear();
    fit.profile = Profile();

    expect(fit.importJson(backup), true);
    expectEverythingIsThere();
  });

  test('rubbish input is refused instead of wiping your data', () {
    fillEverything();
    for (final junk in ['', 'nope', '[]', '{oops', '{"a":1']) {
      expect(fit.importJson(junk), false, reason: 'con "$junk"');
    }
    expectEverythingIsThere();
  });

  test('a backup from an empty install imports without blowing up', () {
    final empty = fit.exportJson();
    expect(fit.importJson(empty), true);
    expect(fit.sessions, isEmpty);
    expect(fit.profile.name, kDefaultName);
  });

  test('old backups with the previous notes format still load', () {

    const old = '{"notes":{"abc":"vieja nota"},"profile":{"name":"Legacy"}}';
    expect(fit.importJson(old), true);
    expect(fit.profile.name, 'Legacy');
    expect(fit.notesFor('abc').single.text, 'vieja nota');
  });

  test('a session is only stored once it has a completed set', () {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    fit.startSession();
    fit.finishSession();
    expect(fit.sessions, isEmpty, reason: 'nada marcado = nada que guardar');

    fit.startSession();
    fit.toggleSet(0, 0);
    fit.finishSession();
    expect(fit.sessions.length, 1);
    fit.saveAndExit();
  });

  test('deleting a custom exercise cleans it out of routines and favourites', () {
    final id = fit.addCustomExercise(name: 'Temporal', primary: 'chest', equipment: 'Other');
    final r = fit.createRoutine('R');
    fit.toggleRoutineExercise(r, id);
    fit.toggleFavorite(id);

    fit.deleteCustomExercise(id);
    expect(fit.customExercises, isEmpty);
    expect(fit.routines.single.exerciseIds, isEmpty, reason: 'no debe quedar un id fantasma');
    expect(fit.favorites.containsKey(id), false);
  });

  test('deleting a routine unassigns it from the week', () {
    final r = fit.createRoutine('R');
    fit.assignRoutineToDay(3, r);
    fit.deleteRoutine(r);
    expect(fit.weeklyPlan[3], isNull);
    expect(fit.todayRoutine, isNull);
  });

  group('#265 guardado con caché', () {
    Map<String, dynamic> stored() {
      final raw = jsonDecode(jsonEncode(Store.finite(fit.toJson()))) as Map<String, dynamic>;
      return raw;
    }

    void same() {
      fit.persistNow();
      expect(jsonEncode(Store.instance.load()), jsonEncode(stored()));
    }

    test('lo guardado es igual que toJson, también tras editar entrenos y comidas', () {
      for (var i = 0; i < 5; i++) {
        fit.sessions.add(LoggedSession(DateTime(2026, 3, 1 + i, 18), 3600, [
          LoggedExercise(kFirstId, 'Bench', 'chest', [LoggedSet(8, 60), LoggedSet(6, 70)]),
        ]));
      }
      final food = fit.saveFood(name: 'Avena', macros: const Macros(kcal: 380, protein: 13, carbs: 60, fat: 7));
      fit.logFood(food, meal: Meal.breakfast);
      same();

      fit.sessions[1].name = 'Pierna';
      same();
      fit.sessions[2].durationSec = 100;
      same();
      fit.sessions[3].exercises.first.sets[0] = LoggedSet(10, 65, rpe: 8);
      same();
      fit.sessions[3].exercises.first.sets.add(LoggedSet(5, 75));
      same();
      fit.sessions[4].exercises.first.incline = 3;
      same();
      fit.sessions[0].exercises.add(LoggedExercise(kFirstId, 'Bench', 'chest', [LoggedSet(1, 1)]));
      same();
      fit.sessions.removeAt(2);
      same();
      fit.logFood(food, servings: 2, meal: Meal.lunch);
      same();
      fit.foodLog.removeAt(0);
      same();
    });

    test('un NaN no rompe el guardado', () {
      fit.sessions.add(LoggedSession(DateTime(2026, 3, 1, 18), 60, [
        LoggedExercise(kFirstId, 'Bench', 'chest', [LoggedSet(8, double.nan)]),
      ]));
      fit.persistNow();
      final back = Store.instance.load();
      expect(((back['sessions'] as List).single as Map)['ex'], isNotEmpty);
    });
  });
}

final kFirstId = fit.allExercises.first.id;
