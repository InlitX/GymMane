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
    fit.setUnits('kg');
    fit.autoAdvance = false;
  });

  tearDown(() {
    if (fit.session != null) fit.saveAndExit();
  });

  Routine routine(List<String> names) {
    final id = fit.createRoutine('Push');
    for (final name in names) {
      fit.toggleRoutineExercise(id, fit.matchExerciseByName(name)!.id);
    }
    return fit.routines.firstWhere((r) => r.id == id);
  }

  test('finishing by mistake can be undone and nothing is lost', () {
    fit.startRoutine(routine(['Barbell Bench Press', 'Barbell Squat']));
    fit.endCountdown();
    fit.toggleSet(0, 0);
    final pending = fit.session!.exercises.expand((e) => e.sets).where((s) => !s.done).length;
    expect(pending, greaterThan(0));

    fit.finishSession();
    expect(fit.isSessionComplete, isTrue);
    expect(fit.sessions, hasLength(1));

    fit.continueSession();
    expect(fit.isSessionActive, isTrue);
    expect(fit.sessions, isEmpty, reason: 'la entrada guardada por error se quita');
    expect(fit.session!.exercises.expand((e) => e.sets).where((s) => !s.done).length, pending);
    expect(fit.session!.exercises.first.sets.first.done, isTrue);
  });

  test('finishing again leaves a single workout for the day', () {
    fit.startRoutine(routine(['Barbell Bench Press']));
    fit.endCountdown();
    fit.toggleSet(0, 0);
    fit.finishSession();
    fit.continueSession();
    fit.toggleSet(0, 1);
    fit.finishSession();

    expect(fit.sessions, hasLength(1));
    expect(fit.sessions.single.exercises.single.sets, hasLength(2));
  });

  test('the clock carries on from where it stopped', () {
    fit.startRoutine(routine(['Barbell Bench Press']));
    fit.endCountdown();
    fit.toggleSet(0, 0);
    fit.finishSession();
    final before = fit.session!.summaryDuration!;
    fit.continueSession();
    expect(fit.sessionElapsed, greaterThanOrEqualTo(before));
  });

  test('an empty finish keeps the history untouched', () {
    final old = LoggedSession(DateTime.now().subtract(const Duration(days: 2)), 1800, [
      LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(8, 60)]),
    ]);
    fit.sessions.add(old);
    fit.startRoutine(routine(['Barbell Squat']));
    fit.endCountdown();
    fit.finishSession();
    fit.continueSession();
    expect(fit.sessions, [old]);
    expect(fit.isSessionActive, isTrue);
  });

  test('after save and exit there is nothing to continue', () {
    fit.startRoutine(routine(['Barbell Bench Press']));
    fit.endCountdown();
    fit.toggleSet(0, 0);
    fit.finishSession();
    fit.saveAndExit();
    fit.continueSession();
    expect(fit.session, isNull);
    expect(fit.sessions, hasLength(1));
  });

  test('#264 las fotos del entreno siguen a la sesión aunque se siga entrenando', () async {
    fit.startRoutine(routine(['Barbell Bench Press']));
    fit.endCountdown();
    fit.toggleSet(0, 0);
    fit.finishSession();
    final first = fit.filedSession!;
    fit.moments.add(Moment(first.date, 'a.jpg'));
    fit.moments.add(Moment(first.date.subtract(const Duration(days: 1)), 'b.jpg'));
    expect(fit.momentsOf(first).map((m) => m.file), ['a.jpg']);

    fit.continueSession();
    await Future<void>.delayed(const Duration(milliseconds: 5));
    fit.toggleSet(0, 1);
    fit.finishSession();
    final again = fit.filedSession!;
    expect(again.date.isAtSameMomentAs(first.date), isFalse);
    expect(fit.momentsOf(again).map((m) => m.file), ['a.jpg']);
    expect(fit.moments.firstWhere((m) => m.file == 'b.jpg').date.isBefore(first.date), isTrue);
  });
}
