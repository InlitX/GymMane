import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.setUnits('kg');
  });

  void log(int daysAgo, double kg, {int reps = 5}) {
    fit.sessions.add(LoggedSession(
      today.subtract(Duration(days: daysAgo)).add(const Duration(hours: 19)),
      3600,
      [LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(reps, kg), LoggedSet(reps, kg)])],
    ));
    fit.sessions.sort((a, b) => a.date.compareTo(b.date));
  }

  test('solo cuenta lo que cae dentro de las fechas', () {
    log(40, 100);
    log(10, 100);
    log(3, 105);
    final r = fit.rangeReport(today.subtract(const Duration(days: 13)), today);
    expect(r.days, 14);
    expect(r.sessions, 2);
    expect(r.sets, 4);
    expect(r.volume, closeTo(2 * 500 + 2 * 525, 0.01));
    expect(r.minutes, 120);
    expect(r.lifts.single.sessions, 2);
    expect(r.lifts.single.change, greaterThan(0));
    expect(r.prev, isNull, reason: 'los 14 días de antes están vacíos');
  });

  test('un récord es superar lo que ya tenías antes del informe', () {
    log(40, 100);
    log(3, 105);
    final r = fit.rangeReport(today.subtract(const Duration(days: 6)), today);
    expect(r.records.single.kg, 105);
    final first = fit.rangeReport(today.subtract(const Duration(days: 60)), today);
    expect(first.records, isEmpty, reason: 'sin historia previa no hay récord que batir');
  });

  test('el CSV del informe solo lleva sus días', () {
    log(40, 100);
    log(3, 105);
    final r = fit.rangeReport(today.subtract(const Duration(days: 6)), today);
    final csv = fit.reportWorkoutsCsv(r).trim().split('\n');
    expect(csv, hasLength(3), reason: 'cabecera y las dos series del día 3');
    expect(csv.skip(1).every((l) => l.contains(',105,')), true);
  });

  test('peso al principio y al final', () {
    log(3, 100);
    fit.bodyweight.addAll([
      BodyweightEntry(today.subtract(const Duration(days: 5)), 82),
      BodyweightEntry(today.subtract(const Duration(days: 1)), 81),
    ]);
    final r = fit.rangeReport(today.subtract(const Duration(days: 6)), today);
    expect(r.weightFrom, 82);
    expect(r.weightTo, 81);
    expect(fit.rangeReport(today.subtract(const Duration(days: 100)), today.subtract(const Duration(days: 90))).empty,
        true);
  });
}
