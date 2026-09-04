import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// El fixture tiene fechas fijas; se desplaza entero para que el último
/// entreno caiga ayer y las ventanas de 30 días sigan teniendo sentido.
String _slideToToday(String text) {
  final data = jsonDecode(text) as Map<String, dynamic>;
  final sessions = (data['sessions'] as List).cast<Map<String, dynamic>>();
  final newest = sessions
      .map((s) => DateTime.parse(s['d'] as String))
      .reduce((a, b) => a.isAfter(b) ? a : b);
  final target = DateTime.now().subtract(const Duration(days: 1));
  final shift = Duration(days: target.difference(newest).inDays);

  String slide(String iso) => DateTime.parse(iso).add(shift).toIso8601String();

  for (final s in sessions) {
    s['d'] = slide(s['d'] as String);
  }
  for (final b in (data['bodyweight'] as List).cast<Map<String, dynamic>>()) {
    b['d'] = slide(b['d'] as String);
  }
  ((data['exNotes'] as Map?) ?? {}).forEach((_, v) {
    for (final n in (v as List).cast<Map<String, dynamic>>()) {
      n['d'] = slide(n['d'] as String);
    }
  });
  return jsonEncode(data);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fixture = File('test/fixtures/seed_backup.json');
  if (!fixture.existsSync()) {
    test('sin fixture', () {}, skip: 'test/fixtures no se publica');
    return;
  }

  late Map<String, dynamic> raw;

  double fixtureVolume(int startDaysAgo, int endDaysAgo) {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: startDaysAgo));
    final end = now.subtract(Duration(days: endDaysAgo));
    double sum = 0;
    for (final s in (raw['sessions'] as List)) {
      final d = DateTime.parse(s['d'] as String);
      if (d.isAfter(start) && !d.isAfter(end)) {
        for (final e in (s['ex'] as List)) {
          for (final st in (e['s'] as List)) {
            sum += (st['r'] as num).toDouble() * (st['w'] as num).toDouble();
          }
        }
      }
    }
    return sum;
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    final text = _slideToToday(fixture.readAsStringSync());
    raw = jsonDecode(text) as Map<String, dynamic>;
    expect(fit.importJson(text), true, reason: 'el backup de prueba debe ser válido');
  });

  tearDown(() {
    fit.resetAllData();
    setAppLanguage('en');
  });

  test('the whole backup lands', () {
    expect(fit.sessions.length, 29);
    expect(fit.profile.name, (raw['profile'] as Map)['name']);
    expect(fit.bodyweight.length, 8);
    expect(fit.routines.single.name, 'Empuje');
    expect(fit.favorites.length, 2);
    expect(fit.notesFor('EIeI8Vf').single.text, 'Subir a 82.5 la próxima.');
    expect(fit.language, 'es', reason: 'el idioma del backup manda');
  });

  test('30-day volume matches the number worked out from the fixture', () {
    final cur = fixtureVolume(30, 0);
    final prev = fixtureVolume(60, 30);
    expect(fit.volume30dKg, closeTo(cur, 0.5));
    expect(fit.volumeChangePct, (((cur - prev) / prev) * 100).round(),
        reason: 'crecimiento real vs. mes anterior');
  });

  test('personal records are the best set ever, not the last one', () {
    final prs = {for (final p in fit.personalRecords) p.name: p};

    expect(prs['Barbell Deadlift']!.topWeight, 120);
    expect(prs['Barbell Deadlift']!.oneRm, closeTo(152, 1));
    expect(prs['Barbell Full Squat']!.topWeight, 110);
    expect(prs['Barbell Bench Press']!.topWeight, 77.5);
    expect(prs['Barbell Curl']!.topWeight, 32.5);

    expect(fit.personalRecords.first.name, 'Barbell Deadlift');
  });

  test('the strength curve rises with the programme', () {
    final series = fit.oneRmSeries('EIeI8Vf');
    expect(series.length, greaterThan(5));
    expect(series.last, greaterThan(series.first), reason: 'la progresión debe verse');
    expect(series.last, closeTo(98, 1));
  });

  test('the heatmap only lights up the days that were trained', () {
    final levels = fit.heatmapLevels;
    expect(levels.length, kHeatmapDays);
    final trained = levels.where((l) => l > 0).length;

    expect(trained, greaterThan(15));
    expect(trained, lessThanOrEqualTo(29));
    expect(levels.every((l) => l >= 0 && l <= heatLevels), true);
  });

  test('the muscle split adds up to roughly 100%', () {
    final split = fit.muscleSplit;
    expect(split, isNotEmpty);
    final total = split.fold(0, (a, e) => a + e.pct);
    expect(total, closeTo(100, 2), reason: 'margen por redondeo a enteros');
    expect(split.first.pct, greaterThanOrEqualTo(split.last.pct), reason: 'de mayor a menor');
  });

  test('bodyweight reads newest-first and the profile agrees', () {
    expect(fit.latestBodyweight!.kg, closeTo(75.2, 0.01));
    expect(fit.bodyweightHistory.first.kg, closeTo(75.2, 0.01));
    expect(fit.bodyweightSeries.first, greaterThan(fit.bodyweightSeries.last),
        reason: 'bajó de 78 a 75.2');
  });

  test('a day sheet shows what was really done that day', () {
    final day = fit.sessions.map((s) => s.date).reduce((a, b) => a.isAfter(b) ? a : b);
    final s = fit.daySummary(day)!;
    expect(s.exercises, 2);
    expect(s.sets, 6);
    expect(s.volume, greaterThan(0));
    expect(s.names.length, 2);
  });

  test('the CSV carries every single set', () {
    final rows = fit.exportCsv().trim().split('\n');
    final sets = fit.sessions.fold(0, (a, s) => a + s.setCount);
    expect(rows.length, sets + 1, reason: 'una fila por serie, más la cabecera');
    expect(rows.first, startsWith('date,exercise'));
  });

  test('switching to pounds converts the display but not the data', () {
    final kg = fit.volume30dKg;
    fit.setUnits('lb');
    expect(fit.volume30dKg, kg, reason: 'lo guardado no se toca');
    expect(fit.volumeUnit, 'k lb');
    expect(fit.weightLabel(100), '220.5 lb');
    fit.setUnits('kg');
  });

  test('a re-export round-trips without losing a single session', () {
    final again = fit.exportJson();
    fit.sessions.clear();
    expect(fit.importJson(again), true);
    expect(fit.sessions.length, (raw['sessions'] as List).length);
    expect(fit.volume30dKg, closeTo(fixtureVolume(30, 0), 0.5));
  });
}
