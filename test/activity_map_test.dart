import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('tonos del mapa', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    LoggedSession at(int daysAgo, List<LoggedSet> sets) => LoggedSession(
          shiftDays(DateTime.now(), -daysAgo).add(const Duration(hours: 18)),
          600,
          [LoggedExercise('push', 'push', 'chest', sets)],
        );

    test('#187 el mapa reparte los tonos por volumen y el día sin peso queda abajo', () {
      fit.sessions
        ..add(at(4, [LoggedSet(10, 0), LoggedSet(10, 0)]))
        ..add(at(3, [LoggedSet(10, 30)]))
        ..add(at(2, [for (var i = 0; i < 6; i++) LoggedSet(10, 60)]))
        ..add(at(1, [for (var i = 0; i < 12; i++) LoggedSet(8, 100)]));
      final l = fit.heatmapLevels;
      final n = l.length;
      expect(l[n - 5], 1);
      expect(l[n - 4], 1);
      expect(l[n - 3], greaterThan(1));
      expect(l[n - 2], heatLevels);
      expect(l[n - 3], lessThan(l[n - 2]));
      expect(l.last, 0);
    });
  });

  group('#220 calendario de 12 meses', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('por defecto son 12 semanas y se guarda el cambio', () {
      expect(fit.heatmapYear, isFalse);
      expect(fit.heatmapShown.length, 12 * 7);
      fit.setHeatmapRange('year');
      expect(fit.heatmapShown.length, 53 * 7);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.resetAllData();
      expect(fit.heatmapYear, isFalse);
      fit.applyBackup(data);
      expect(fit.heatmapYear, isTrue);
    });

    test('con historia de más de un año llega hasta el primer entreno', () {
      fit.setHeatmapRange('year');
      final old = DateTime.now().subtract(const Duration(days: 500));
      fit.sessions.add(LoggedSession(old, 1800, [
        LoggedExercise('x', 'X', 'chest', [LoggedSet(8, 50)]),
      ]));
      final weeks = fit.heatmapShownWeeks;
      expect(weeks, greaterThan(53));
      final first = fit.heatmapShownDate(0);
      expect(first.isAfter(DateTime(old.year, old.month, old.day)), isFalse);
      final i = DateTime(old.year, old.month, old.day).difference(first).inDays;
      expect(fit.heatmapShown[i], greaterThan(0));
    });

    test('tocar un día abre la fecha correcta en los dos modos', () {
      final today = DateTime.now();
      final key = DateTime(today.year, today.month, today.day);
      for (final range in ['weeks', 'year']) {
        fit.setHeatmapRange(range);
        final levels = fit.heatmapShown;
        final i = levels.lastIndexWhere((l) => l >= 0);
        expect(fit.heatmapShownDate(i), key, reason: range);
      }
    });

    test('un valor raro no cambia el ajuste', () {
      fit.setHeatmapRange('decade');
      expect(fit.heatmapRange, 'weeks');
    });
  });

  group('#83 mapa de actividad', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = 'push', String primary = 'chest'}) =>
        LoggedSession(at, 600, [LoggedExercise(id, id, primary, sets)]);

    test('un día de peso corporal se pinta', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(15, 0), LoggedSet(12, 0)]));
      expect(fit.heatmapLevels.last, greaterThan(0));
    });

    test('un día marcado a mano también cuenta', () {
      fit.toggleCheckin(fit.todayIndex);
      expect(fit.heatmapLevels.last, greaterThan(0));
    });
  });

  group('#138 una semana por columna', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    const bench = 'EIeI8Vf';

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = bench}) =>
        LoggedSession(at, 1800, [LoggedExercise(id, 'Barbell Bench Press', 'chest', sets)]);

    test('cada columna empieza el primer día de la semana y hoy cae en su fila', () {
      for (final start in [DateTime.monday, DateTime.sunday]) {
        fit.setWeekStart(start);
        final cells = fit.heatmapWeeks;
        expect(cells.length % 7, 0);
        expect(fit.heatmapWeekDate(0).weekday, start);
        final today = DateTime.now();
        final i = cells.length - 7 + fit.todayIndex;
        final d = fit.heatmapWeekDate(i);
        expect((d.year, d.month, d.day), (today.year, today.month, today.day));
        expect(cells.skip(i + 1).every((l) => l == -1), isTrue);
      }
    });

    test('un entreno de hoy se pinta en la casilla de hoy', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(8, 60)]));
      final cells = fit.heatmapWeeks;
      expect(cells[cells.length - 7 + fit.todayIndex], greaterThan(0));
    });

    test('los días y meses vienen encendidos y apagarlos se guarda', () {
      expect(fit.heatmapLabels, isTrue);
      fit.toggleHeatmapLabels();
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.heatmapLabels, isFalse);
    });
  });
}
