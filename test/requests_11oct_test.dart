import 'package:flutter_test/flutter_test.dart';
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
  });

  Routine routineOf(List<String> ids) {
    final id = fit.createRoutine('Cardio');
    for (final ex in ids) {
      fit.toggleRoutineExercise(id, ex);
    }
    return fit.routines.firstWhere((r) => r.id == id);
  }

  group('#173 cardio', () {
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

  group('#160 nombre del entreno libre', () {
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
}
