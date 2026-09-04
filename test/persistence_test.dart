import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/models/profile.dart';
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
    fit.addBodyweight(74.5);
    final r = fit.createRoutine('Empuje');
    fit.toggleRoutineExercise(r, kFirstId);
    fit.assignRoutineToDay(1, r);
    fit.addCustomExercise(name: 'Mi ejercicio', primary: 'chest', equipment: 'Other');

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
    expect(fit.routines.single.name, 'Empuje');
    expect(fit.routines.single.exerciseIds, [kFirstId]);
    expect(fit.weeklyPlan[1], fit.routines.single.id);
    expect(fit.customExercises.single.name, 'Mi ejercicio');
    expect(fit.sessions.single.exercises.single.sets.single.reps, 10);
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
    expect(fit.profile.name, 'InlitX');
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
}

final kFirstId = fit.allExercises.first.id;
