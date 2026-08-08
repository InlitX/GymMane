import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/state/fit_state.dart';

void _reset() {
  fit.saveAndExit();
  fit.sessions.clear();
  fit.favorites.clear();
}

void main() {
  setUp(_reset);
  tearDown(_reset);

  strengthTests();

  test('a leg day proposes a session, not the whole catalogue', () {
    fit.startWorkout();
    fit.toggleMuscle('quads');
    fit.toggleMuscle('hamstrings');

    final candidates = fit.getFilteredExercises(fit.selectedMuscles);
    expect(candidates.length, greaterThan(20), reason: 'the library should stay broad');

    fit.trainContinue();
    expect(fit.sessionPicks.length, lessThanOrEqualTo(6));

    final picked = candidates.where((e) => fit.isPicked(e.id));
    expect(picked.map((e) => e.primary).toSet(), containsAll(['quads', 'hamstrings']));

    fit.startSession();
    expect(fit.session!.exercises.length, fit.sessionPicks.length);
  });

  test('dropping every exercise refuses to start a session', () {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    for (final id in fit.sessionPicks.toList()) {
      fit.togglePick(id);
    }
    fit.startSession();
    expect(fit.session, isNull);
    expect(fit.route, 'train');
  });

  test('pausing freezes the clock and resuming keeps the elapsed time', () async {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    fit.startSession();

    fit.toggleSessionPause();
    expect(fit.sessionPaused, true);
    final frozen = fit.sessionElapsed;
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    expect(fit.sessionElapsed, frozen, reason: 'clock must not advance while paused');

    fit.toggleSessionPause();
    expect(fit.sessionPaused, false);
    expect(fit.sessionElapsed, greaterThanOrEqualTo(frozen));

    fit.saveAndExit();
  });

  test('rest timer stays put while the session is paused', () {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    fit.startSession();
    fit.toggleSessionPause();
    fit.startRest();
    expect(fit.session!.restRemaining, isNull);
    fit.saveAndExit();
  });

  test('back walks up the routes instead of leaving the app', () {
    fit.goProgress();
    expect(fit.handleBack(), true);
    expect(fit.route, 'home');

    fit.goExercises();
    fit.openExercise(fit.allExercises.first.id);
    expect(fit.handleBack(), true);
    expect(fit.route, 'exercises');

    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    expect(fit.handleBack(), true);
    expect(fit.trainStep, 'select');
    expect(fit.handleBack(), true);
    expect(fit.route, 'exercises');
  });

  test('back at home reports unhandled so the app can close', () {
    fit.goHome();
    expect(fit.handleBack(), false);
  });

  test('heatmap dates line up with the levels window', () {
    expect(fit.heatmapLevels.length, kHeatmapDays);
    final last = fit.heatmapDate(kHeatmapDays - 1);
    final today = DateTime.now();
    expect(DateTime(last.year, last.month, last.day),
        DateTime(today.year, today.month, today.day),
        reason: 'the last cell is today');
  });

  test('day summary reflects a logged session', () {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    fit.startSession();
    for (final e in fit.session!.exercises) {
      for (final st in e.sets) {
        st.done = true;
      }
    }
    fit.finishSession();

    final s = fit.daySummary(DateTime.now());
    expect(s, isNotNull);
    expect(s!.sets, greaterThan(0));
    expect(s.volume, greaterThan(0));
    expect(s.names, isNotEmpty);
    expect(fit.daySummary(DateTime.now().subtract(const Duration(days: 5))), isNull);

    fit.saveAndExit();
  });
}

void _log(String exId, String name, List<LoggedSet> sets, DateTime when) {
  fit.sessions.add(LoggedSession(when, 600, [LoggedExercise(exId, name, 'chest', sets)]));
}

void strengthTests() {
  test('an exercise needs two sessions before it gets a curve', () {
    _reset();
    _log('a1', 'Bench', [LoggedSet(10, 60)], DateTime.now().subtract(const Duration(days: 7)));
    expect(fit.trackedExercises, isEmpty);
    expect(fit.activeStrengthId, isNull);

    _log('a1', 'Bench', [LoggedSet(10, 65)], DateTime.now());
    expect(fit.trackedExercises.map((e) => e.id), ['a1']);
    expect(fit.activeStrengthId, 'a1');
    _reset();
  });

  test('the curve runs oldest to newest and follows the best set', () {
    _reset();
    _log('a1', 'Bench', [LoggedSet(10, 60)], DateTime.now().subtract(const Duration(days: 14)));
    _log('a1', 'Bench', [LoggedSet(5, 80), LoggedSet(10, 60)], DateTime.now());

    final series = fit.oneRmSeries('a1');
    expect(series.length, 2);
    expect(series.first, lessThan(series.last), reason: 'el más antiguo va primero');

    expect(series.last, closeTo(93.3, 0.1));
    _reset();
  });

  test('the default pick is the most trained exercise', () {
    _reset();
    for (var i = 0; i < 3; i++) {
      _log('a1', 'Bench', [LoggedSet(5, 60)], DateTime.now().subtract(Duration(days: i)));
    }
    _log('b2', 'Row', [LoggedSet(5, 50)], DateTime.now());
    _log('b2', 'Row', [LoggedSet(5, 55)], DateTime.now());

    expect(fit.activeStrengthId, 'a1');
    fit.setStrengthExercise('b2');
    expect(fit.activeStrengthId, 'b2');
    _reset();
  });

  test('a stale selection falls back instead of showing nothing', () {
    _reset();
    fit.setStrengthExercise('deleted-id');
    _log('a1', 'Bench', [LoggedSet(5, 60)], DateTime.now().subtract(const Duration(days: 1)));
    _log('a1', 'Bench', [LoggedSet(5, 62)], DateTime.now());
    expect(fit.activeStrengthId, 'a1');
    _reset();
  });
}
