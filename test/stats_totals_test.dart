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
  });

  group('counting days', () {
    test('a shifted day is always midnight on the day you asked for', () {
      for (final d in [
        DateTime(2026, 10, 25, 13, 40),
        DateTime(2026, 3, 29, 2, 30),
        DateTime(2026, 12, 31, 23, 59),
        DateTime(2026, 2, 28),
      ]) {
        for (final n in [-370, -30, -1, 0, 1, 30, 370]) {
          final moved = shiftDays(d, n);
          expect(moved.hour, 0);
          expect(moved.minute, 0);
          expect(daysBetween(d, moved), n, reason: '$d movido $n');
        }
      }
    });

    test('shifting lands on the calendar day, clock change or not', () {
      expect(shiftDays(DateTime(2026, 10, 24), 1), DateTime(2026, 10, 25));
      expect(shiftDays(DateTime(2026, 10, 26), -1), DateTime(2026, 10, 25));
      expect(shiftDays(DateTime(2026, 3, 28), 1), DateTime(2026, 3, 29));
      expect(shiftDays(DateTime(2026, 12, 31), 1), DateTime(2027, 1, 1));
      expect(shiftDays(DateTime(2028, 2, 28), 1), DateTime(2028, 2, 29));
    });
  });

  group('warm-ups never inflate anything', () {
    LoggedSession session(int daysAgo, List<LoggedSet> sets) => LoggedSession(
          shiftDays(DateTime.now(), -daysAgo).add(const Duration(hours: 12)),
          1800,
          [LoggedExercise('EIeI8Vf', 'Bench', 'chest', sets)],
        );

    test('a heavy warm-up does not become a record', () {
      fit.sessions.add(session(1, [
        LoggedSet(12, 90, kind: SetKind.warmup),
        LoggedSet(5, 80),
      ]));

      final pr = fit.personalRecords.single;
      expect(pr.best, 80, reason: 'el récord sale de las series efectivas');
      expect(pr.oneRm, closeTo(93.3, 0.1));
    });

    test('warm-up sets stay out of the muscle map', () {
      fit.sessions.add(session(1, [
        LoggedSet(10, 20, kind: SetKind.warmup),
        LoggedSet(10, 20, kind: SetKind.warmup),
        LoggedSet(8, 80),
      ]));

      expect(fit.muscleSetsOver(7)['chest'], 1);
      expect(
          fit.muscleSetsBetween(shiftDays(DateTime.now(), -7), DateTime.now())['chest'], 1);
    });

    test('a session of nothing but warm-up leaves no records behind', () {
      fit.sessions.add(session(2, [LoggedSet(10, 40, kind: SetKind.warmup)]));

      expect(fit.personalRecords, isEmpty);
      expect(fit.totalSets, 0);
      expect(fit.muscleSetsOver(7), isEmpty);
    });

    test('warm-up 40 kg x 8 does not overwrite est_1rm_kg or working tonnage', () {
      final warmup = LoggedSet(8, 40, kind: SetKind.warmup);
      final work = LoggedSet(5, 30);
      expect(warmup.oneRm, 0);
      expect(warmup.volume, 0);
      expect(fit.liftScore('EIeI8Vf', warmup), 0);

      fit.sessions
        ..add(session(2, [warmup]))
        ..add(session(1, [warmup, work]));

      final pr = fit.personalRecords.single;
      expect(pr.oneRm, closeTo(35.0, 0.1));
      expect(fit.oneRmSeries('EIeI8Vf'), [35.0]);
      expect(fit.bestRepsSeries('EIeI8Vf'), [5]);
      expect(fit.totalVolumeKg, 150);
    });
  });

  group('inches users are not fed centimetres', () {
    test('the body-fat inputs read in the unit you picked', () {
      fit.setUnits('kg');
      fit.bfWaist = 84;
      expect(fit.cmLabel(fit.bfWaist), '84 cm');

      fit.setUnits('lb');
      expect(fit.cmLabel(fit.bfWaist), '33.1 in');
      expect(fit.fromDisplayCm(33.1), closeTo(84.07, 0.01));
      expect(fit.girthStep, closeTo(0.635, 0.001), reason: 'un cuarto de pulgada');
      expect(fit.cmStep, closeTo(1.27, 0.001), reason: 'media pulgada');
      fit.setUnits('kg');
    });

    test('the formula keeps working in centimetres whatever is shown', () {
      fit.setUnits('kg');
      fit.bfSex = 'male';
      fit.bfHeight = 178;
      fit.bfNeck = 38;
      fit.bfWaist = 88;
      final metric = fit.bfVal;

      fit.setUnits('lb');
      expect(fit.bfVal, metric, reason: 'cambiar de unidad no cambia tu grasa corporal');
      fit.setUnits('kg');
    });
  });

  group('the numbers add up', () {
    test('the all-time totals match what was logged', () {
      fit.sessions
        ..add(LoggedSession(DateTime.now(), 3600, [
          LoggedExercise('a', 'A', 'chest', [LoggedSet(10, 50), LoggedSet(10, 50)]),
        ]))
        ..add(LoggedSession(shiftDays(DateTime.now(), -2), 1800, [
          LoggedExercise('b', 'B', 'back', [LoggedSet(5, 100)]),
        ]));

      expect(fit.totalSessions, 2);
      expect(fit.totalSets, 3);
      expect(fit.totalVolumeKg, 1500);
      expect(fit.totalTime, const Duration(minutes: 90));
      expect(fit.averageSession, const Duration(minutes: 45));
    });

    test('the muscle split adds up to 100 and never counts a muscle twice', () {
      fit.sessions.add(LoggedSession(DateTime.now(), 1800, [
        LoggedExercise('a', 'A', 'chest', [LoggedSet(10, 50)]),
        LoggedExercise('b', 'B', 'quads', [LoggedSet(10, 50)]),
      ]));

      final split = fit.muscleSplit;
      expect(split.fold(0, (a, e) => a + e.pct), closeTo(100, 1));
      expect(split.map((e) => e.name).toSet().length, split.length);
    });

    test('the weekly goal never reads over 100%', () {
      fit.profile.weeklyGoal = 1;
      for (int i = 0; i < 6; i++) {
        fit.sessions.add(LoggedSession(DateTime.now(), 600, const []));
      }
      expect(fit.goalPct, 100);
    });

    test('the volume chart only ever climbs and ends at the 30-day total', () {
      for (int i = 0; i < 10; i++) {
        fit.sessions.add(LoggedSession(shiftDays(DateTime.now(), -i * 2), 1800, [
          LoggedExercise('a', 'A', 'chest', [LoggedSet(10, 50)]),
        ]));
      }

      final points = fit.volumeChartPoints;
      for (int i = 1; i < points.length; i++) {
        expect(points[i], greaterThanOrEqualTo(points[i - 1]));
      }
      expect(points.last, closeTo(fit.volume30dKg, 0.01));
    });

    test('the heatmap lights the days that were trained and nothing else', () {
      fit.sessions.add(LoggedSession(DateTime.now(), 1800, [
        LoggedExercise('a', 'A', 'chest', [LoggedSet(10, 50)]),
      ]));

      final levels = fit.heatmapLevels;
      expect(levels.length, kHeatmapDays);
      expect(levels.last, greaterThan(0), reason: 'hoy está entrenado');
      expect(levels.where((l) => l > 0).length, 1);
      expect(fit.heatmapDate(levels.length - 1), shiftDays(DateTime.now(), 0));
    });
  });

  group('lecturas de la semana', () {
    String idFor(String muscle) =>
        fit.allExercises.firstWhere((e) => e.primary == muscle && fit.modeOf(e.id).isEmpty && !fit.isAssisted(e.id)).id;

    void log(int daysAgo, String muscle, double kg, {int sets = 3}) {
      final now = DateTime.now();
      final at = DateTime(now.year, now.month, now.day - daysAgo, 12);
      fit.sessions.add(LoggedSession(at, 600, [
        LoggedExercise(idFor(muscle), muscle, muscle, [for (var i = 0; i < sets; i++) LoggedSet(5, kg)]),
      ]));
      fit.sessions.sort((a, b) => a.date.compareTo(b.date));
    }

    test('sin historial no dice nada', () {
      expect(fit.weekInsights, isEmpty);
    });

    test('avisa del músculo olvidado y de quien se ha hecho más fuerte', () {
      log(40, 'quads', 100);
      log(30, 'quads', 100);
      log(50, 'chest', 60);
      log(3, 'chest', 70);
      final notes = fit.weekInsights;
      expect(notes.map((n) => n.kind), containsAll(['muscle', 'up']));
      expect(notes.firstWhere((n) => n.kind == 'up').exerciseId, idFor('chest'));
    });

    test('nota el desequilibrio entre empujar y tirar', () {
      for (var d = 1; d <= 20; d += 4) {
        log(d, 'chest', 60, sets: 5);
      }
      log(2, 'back', 60, sets: 3);
      expect(fit.weekInsights.map((n) => n.kind), contains('balance'));
    });

    test('nunca da más de tres', () {
      for (var d = 1; d <= 20; d += 4) {
        log(d, 'chest', 60, sets: 6);
      }
      log(40, 'quads', 100);
      log(30, 'quads', 100);
      log(50, 'chest', 40);
      expect(fit.weekInsights.length, lessThanOrEqualTo(3));
    });
  });
}
