import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/workout_import.dart';
import 'package:gymmane/state/fit_state.dart';

String read(String name) => File('test/fixtures/import/$name').readAsStringSync();

void main() {
  if (!Directory('test/fixtures/import').existsSync()) {
    test('sin fixtures', () {}, skip: 'test/fixtures no se publica');
    return;
  }

  setUp(() {
    fit.sessions.clear();
    fit.bodyweight.clear();
  });
  tearDown(() {
    fit.sessions.clear();
    fit.bodyweight.clear();
  });

  group('Hevy', () {
    test('el export de entrenos entra entero', () {
      final csv = read('hevy_workouts.csv');
      expect(detectFormat(csv), ImportFormat.hevy);
      expect(needsUnitChoice(csv), false, reason: 'la cabecera ya dice weight_lbs');

      final r = parseImport(csv);
      expect(r.sessions.length, 1);
      final s = r.sessions.single;
      expect(s.date, DateTime(2026, 7, 26, 14, 32));
      expect(s.durationSec, 60, reason: 'de 14:32 a 14:33');
      expect(s.exercises.single.name, 'Lat Pulldown (Cable)');

      final sets = s.exercises.single.sets;
      expect(sets.map((x) => x.reps), [5, 8, 6]);
      expect(sets.first.weightKg, closeTo(6.804, 0.001));
    });

    test('el export de medidas entra como pesajes', () {
      final csv = read('hevy_measurements.csv');
      expect(detectFormat(csv), ImportFormat.hevyWeights);
      expect(needsUnitChoice(csv), false);

      final r = parseImport(csv);
      expect(r.sessions, isEmpty);
      expect(r.weights.length, 1);
      expect(r.weights.single.date, DateTime(2026, 7, 26));
      expect(r.weights.single.kg, closeTo(68.039, 0.01), reason: '150 lb');
    });
  });

  group('Strong', () {
    test('el export de entrenos separa las dos sesiones y tira las filas de descanso', () {
      final csv = read('strong_workouts.csv');
      expect(detectFormat(csv), ImportFormat.strong);

      final r = parseImport(csv);
      expect(r.sessions.length, 2);

      final a = r.sessions.firstWhere((s) => s.exercises.length == 1);
      expect(a.exercises.single.name, 'Squat (Barbell)');
      expect(a.exercises.single.sets.length, 5, reason: 'las filas "Rest Timer" no son series');
      expect(a.exercises.single.sets.map((s) => s.reps), [1, 2, 1, 1, 3]);
      expect(a.durationSec, 37, reason: 'Duration (sec)');

      final b = r.sessions.firstWhere((s) => s.exercises.length > 1);
      expect(b.exercises.map((e) => e.name), [
        'Deadlift (Barbell)',
        'Seated Row (Cable)',
        'Lat Pulldown (Cable)',
        'Bicep Curl (Barbell)',
      ]);
      expect(b.exercises.every((e) => e.sets.length == 3), true);
      expect(b.exercises.first.sets.first.weightKg, closeTo(0.907, 0.001));
    });

    test('el zip de medidas se abre y se lee el peso', () {
      final bytes = File('test/fixtures/import/strong_measurements.zip').readAsBytesSync();
      final csv = weightCsvFromZip(bytes);
      expect(csv, isNotNull, reason: 'weight.csv está dentro del zip');
      expect(csv!.contains('Weight (lb)'), true);
      expect(detectFormat(csv), ImportFormat.strongWeights);
      expect(parseImport(csv).weights, isEmpty);
    });

    test('un zip con peso de verdad entra', () {
      const csv = '"Date";"Weight (lb)"\n"2026-07-20";"154"\n"2026-07-26";"152.5"\n';
      expect(detectFormat(csv), ImportFormat.strongWeights);
      final w = parseImport(csv).weights;
      expect(w.length, 2);
      expect(w.first.kg, closeTo(69.85, 0.01));
      expect(w.last.kg, closeTo(69.17, 0.01));
    });
  });

  group('en la app', () {
    test('los pesajes se guardan, se deduplican por día y actualizan el perfil', () {
      final csv = read('hevy_measurements.csv');
      final parsed = parseImport(csv);

      expect(fit.importParsedWeights(parsed.weights), 1);
      expect(fit.bodyweight.length, 1);
      expect(fit.profile.weightKg, closeTo(68.039, 0.01));

      expect(fit.importParsedWeights(parsed.weights), 0, reason: 'el mismo día no entra dos veces');
      expect(fit.bodyweight.length, 1);
    });

    test('las sesiones de Strong se guardan y no se duplican', () {
      final parsed = parseImport(read('strong_workouts.csv'));
      expect(fit.importParsedSessions(parsed.sessions), 2);
      expect(fit.importParsedSessions(parsed.sessions), 0);
      expect(fit.sessions.length, 2);
    });

    test('un ejercicio del catálogo se reconoce por el nombre de la otra app', () {
      final parsed = parseImport(read('hevy_workouts.csv'));
      fit.importParsedSessions(parsed.sessions);
      final ex = fit.sessions.single.exercises.single;
      expect(ex.primary, isNot('other'), reason: '"Lat Pulldown (Cable)" existe en el catálogo');
    });
  });

  group('ficheros que no valen', () {
    test('un csv de otra cosa no se reconoce', () {
      expect(detectFormat('"a","b"\n1,2\n'), ImportFormat.unknown);
    });

    test('un zip sin peso devuelve nulo', () {
      expect(weightCsvFromZip([1, 2, 3, 4]), isNull);
    });

    test('un fichero vacío no revienta', () {
      expect(detectFormat(''), ImportFormat.unknown);
      expect(parseImport('').isEmpty, true);
    });
  });
}
