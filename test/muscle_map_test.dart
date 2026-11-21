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

  test('#280 la semana cuenta desde el día en que empieza, no los últimos 7', () {
    fit.weekStartDay = DateTime.monday;
    final start = fit.weekStartDate;
    final before = DateTime(start.year, start.month, start.day - 1, 12);
    fit.sessions
      ..add(LoggedSession(before, 1800, [LoggedExercise('x1', 'x1', 'back', [LoggedSet(10, 60)])]))
      ..add(LoggedSession(DateTime(start.year, start.month, start.day, 12), 1800,
          [LoggedExercise('x2', 'x2', 'chest', List.generate(6, (_) => LoggedSet(10, 60)))]));

    expect(fit.muscleSetsThisWeek['back'], isNull);
    expect(fit.muscleSetsThisWeek['chest'], 6);
    expect(fit.muscleHeatThisWeek['chest'], closeTo(0.5, 0.001), reason: 'objetivo semanal entero');
  });

  group('#433 metas de series por músculo', () {
    setUp(() {
      fit.muscleGoals.clear();
      fit.muscleGoalAll = 12;
    });
    tearDown(() {
      fit.muscleGoals.clear();
      fit.muscleGoalAll = 12;
    });

    test('una meta propia cambia el calor y el aviso solo de ese músculo', () {
      fit.sessions
        ..add(session(1, 'x1', 'quads', 6))
        ..add(session(1, 'x2', 'calves', 6));
      fit.setMuscleGoal('quads', 6);
      expect(fit.muscleHeatOver(7)['quads'], 1.0);
      expect(fit.muscleHeatOver(7)['calves'], closeTo(0.5, 0.001));
      expect(fit.muscleTargetFor(30, 'quads'), closeTo(6 * 30 / 7, 0.001), reason: 'al mes escala igual');
    });

    test('cambiar el nivel de todos respeta las metas propias y borra las que quedan iguales', () {
      fit.setMuscleGoal('chest', 18);
      fit.setMuscleGoal('back', 14);
      fit.setMuscleGoalAll(14);
      expect(fit.muscleGoalWeek('chest'), 18);
      expect(fit.muscleGoalCustom('back'), isFalse);
      expect(fit.muscleGoalWeek('quads'), 14);
      fit.setMuscleGoal('chest', null);
      expect(fit.muscleGoalWeek('chest'), 14);
    });

    test('un músculo que no entrenas no sale como olvidado ni en la lista', () {
      fit.sessions.add(session(1, 'x1', 'chest', 12));
      for (final m in ['back', 'quads', 'calves', 'forearm']) {
        fit.setMuscleGoal(m, 0);
      }
      final behind = fit.neglectedMuscles(7);
      expect(behind, isNot(contains('forearm')));
      expect(behind, isNot(contains('calves')));
      final rows = fit.muscleProgress(7);
      expect(rows.map((r) => r.id), isNot(contains('forearm')));
      expect(rows.first.id, 'chest', reason: 'lo más cerca de su meta va primero');
      expect(rows.first.target, 12);
    });
  });
}
