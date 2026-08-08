import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/state/fit_state.dart';

void main() {
  LoggedSession session(int daysAgo, String exId, String primary, int sets) => LoggedSession(
        DateTime.now().subtract(Duration(days: daysAgo)),
        1800,
        [LoggedExercise(exId, exId, primary, List.generate(sets, (_) => LoggedSet(10, 60)))],
      );

  setUp(() => fit.sessions.clear());
  tearDown(() => fit.sessions.clear());

  test('sets land on the primary muscle and half on the secondary ones', () {
    // barbell-bench-press: chest primary, triceps secondary.
    final ex = fit.allExercises.firstWhere((e) => e.primary == 'chest' && e.secondary.contains('triceps'));
    fit.sessions.add(session(1, ex.id, 'chest', 4));

    final sets = fit.muscleSetsOver(7);
    expect(sets['chest'], 4);
    expect(sets['triceps'], 2);
    expect(sets['quads'], isNull);
  });

  test('work outside the window does not count', () {
    fit.sessions.add(session(9, 'x1', 'back', 5));
    expect(fit.muscleSetsOver(7)['back'], isNull);
    expect(fit.muscleSetsOver(30)['back'], 5);
  });

  test('heat is sets over the target for the period and tops out at 1', () {
    fit.sessions.add(session(1, 'x1', 'quads', 6));
    expect(fit.muscleTargetFor(7), 12);
    expect(fit.muscleHeatOver(7)['quads'], closeTo(0.5, 0.001));

    fit.sessions.add(session(2, 'x2', 'quads', 30));
    expect(fit.muscleHeatOver(7)['quads'], 1.0);
  });

  test('the target scales with the window', () {
    fit.sessions.add(session(1, 'x1', 'glutes', 12));
    expect(fit.muscleHeatOver(7)['glutes'], 1.0);
    expect(fit.muscleHeatOver(28)['glutes'], closeTo(0.25, 0.001));
  });

  test('untouched muscles are called out, trained ones are not', () {
    fit.sessions.add(session(1, 'x1', 'chest', 12));
    final behind = fit.neglectedMuscles(7);
    expect(behind, isNot(contains('chest')));
    expect(behind.length, 3);
    expect(fit.neglectedMuscles(7), isNotEmpty);

    fit.sessions.clear();
    expect(fit.neglectedMuscles(7), isEmpty, reason: 'sin datos no se señala nada');
  });
}
