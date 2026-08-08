import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/state/fit_state.dart';

void main() {
  test('full workout loop populates real stats', () {

    fit.sessions.clear();
    fit.selectedMuscles.clear();
    fit.route = 'home';

    expect(fit.hasData, false);
    expect(fit.currentStreak, 0);
    expect(fit.weekMask[fit.todayIndex], false);

    fit.startWorkout();
    fit.toggleMuscle('chest');
    expect(fit.selectedMuscles, ['chest']);

    fit.trainContinue();
    expect(fit.trainStep, 'review');
    fit.startSession();
    expect(fit.session, isNotNull);
    expect(fit.session!.exercises, isNotEmpty);

    final s = fit.session!;
    for (final e in s.exercises) {
      for (final st in e.sets) {
        st.done = true;
      }
    }
    fit.finishSession();

    expect(fit.sessions.length, 1);
    expect(fit.hasData, true);
    expect(fit.setsToday, greaterThan(0));
    expect(fit.volume30dKg, greaterThan(0));
    expect(fit.currentStreak, 1);
    expect(fit.weekMask[fit.todayIndex], true, reason: 'today should be checked');
    expect(fit.personalRecords, isNotEmpty);
    expect(fit.muscleSplit, isNotEmpty);

    fit.saveAndExit();
  });
}
