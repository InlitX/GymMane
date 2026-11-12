import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/program_templates.dart';
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
    fit.autoAdvance = false;
  });

  tearDown(() {
    if (fit.session != null) fit.saveAndExit();
  });

  test('PPL routine, workout logging, calendar history, and reload', () async {
    final template = kProgramTemplates.firstWhere((item) => item.id == 'pplrpp');
    expect(fit.applyTemplate(template), 5);

    final push = fit.routines.firstWhere((routine) => routine.name == 'Push A');
    final benchId = fit.matchExerciseByName('Barbell Bench Press')!.id;
    fit.bumpRoutineSets(push.id, benchId, 1);
    expect(fit.routineSets(push, benchId), 5);
    expect(fit.weeklyPlan.keys.toList()..sort(), [1, 2, 3, 5, 6]);

    fit.startRoutine(push);
    fit.endCountdown();
    fit.setSessionReps(0, 0, 8);
    fit.setSessionWeight(0, 0, 60);
    fit.toggleSet(0, 0);
    fit.finishSession();

    expect(fit.sessionsOn(DateTime.now()), hasLength(1));
    expect(fit.heatmapLevels.last, greaterThan(0));
    expect(fit.sessions.single.exercises.first.sets.first.reps, 8);
    expect(fit.sessions.single.exercises.first.sets.first.weight, 60);

    fit.saveAndExit();
    await pumpEventQueue();
    fit.loadFromStore();

    expect(fit.sessionsOn(DateTime.now()), hasLength(1));
    expect(fit.sessions.single.exercises.first.sets.first.reps, 8);
    expect(fit.sessions.single.exercises.first.sets.first.weight, 60);
    expect(fit.weeklyPlan.keys.toList()..sort(), [1, 2, 3, 5, 6]);
    expect(fit.routineSets(fit.routines.firstWhere((r) => r.name == 'Push A'), benchId), 5);
  });
}
