import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/fitnotes_backup.dart';
import 'package:gymmane/services/sqlite_reader.dart';
import 'package:gymmane/services/workout_import.dart';
import 'package:gymmane/state/fit_state.dart';

void main() {
  final file = File('test/fixtures/import/fitnotes_backup.fitnotes');
  if (!file.existsSync()) {
    test('sin fixture', () {}, skip: 'test/fixtures no se publica');
    return;
  }
  final bytes = file.readAsBytesSync();

  setUp(() => fit.sessions.clear());
  tearDown(() => fit.sessions.clear());

  group('el lector de SQLite', () {
    test('reconoce el fichero y encuentra las tablas', () {
      expect(SqliteDb.looksLikeSqlite(bytes), true);
      final db = SqliteDb.open(bytes)!;
      expect(db.has('training_log'), true);
      expect(db.has('exercise'), true);
      expect(db.has('Category'), true, reason: 'las tablas se buscan sin distinguir mayúsculas');
    });

    test('lee las filas con sus columnas y el rowid de la clave primaria', () {
      final db = SqliteDb.open(bytes)!;
      final exercises = db.rows('exercise');
      expect(exercises.length, 96);
      final first = exercises.first;
      expect(first['_id'], 1, reason: 'INTEGER PRIMARY KEY sale del rowid, no del registro');
      expect(first['name'], 'Overhead Press');
      expect(first['category_id'], 1);

      final categories = db.rows('Category');
      expect(categories.length, 8);
      expect(categories.first['name'], 'Shoulders');
    });

    test('un fichero que no es SQLite se rechaza', () {
      expect(SqliteDb.looksLikeSqlite([1, 2, 3]), false);
      expect(SqliteDb.open(List.filled(2000, 7)), isNull);
      expect(parseFitNotes([1, 2, 3]), isNull);
    });
  });

  group('la copia de FitNotes', () {
    test('sale una sesión con sus ejercicios y series', () {
      final r = parseFitNotes(bytes)!;
      expect(r.format, ImportFormat.fitnotes);
      expect(r.sessions.length, 1);

      final s = r.sessions.single;
      expect(s.date, DateTime(2026, 7, 26));
      expect(s.exercises.map((e) => e.name), [
        'Ab-Wheel Rollout',
        'Crunch',
        'Hanging Leg Raise',
        'Decline Crunch',
        'Dragon Flag',
        'Cable Crunch',
      ]);

      final rollout = s.exercises.first;
      expect(rollout.sets.length, 3);
      expect(rollout.sets.every((x) => x.reps == 10 && x.weightKg == 2), true);
      expect(rollout.muscle, 'abdomen', reason: 'la categoría Abs es abdomen');
    });

    test('las series sin repeticiones no entran', () {
      final r = parseFitNotes(bytes)!;
      final names = r.sessions.single.exercises.map((e) => e.name);
      expect(names.contains('Plank'), false);
      expect(names.contains('Side Plank'), false);
    });

    test('no había pesajes anotados y no revienta', () {
      expect(parseFitNotes(bytes)!.weights, isEmpty);
    });

    test('entra en la app y cuenta para el músculo correcto', () {
      final r = parseFitNotes(bytes)!;
      expect(fit.importParsedSessions(r.sessions), 1);
      expect(fit.importParsedSessions(r.sessions), 0, reason: 'no se duplica');

      final logged = fit.sessions.single.exercises;
      expect(logged.length, 6);
      expect(logged.every((e) => e.primary != 'other'), true);
      final window = DateTime.now().difference(DateTime(2026, 7, 26)).inDays + 1;
      expect(fit.muscleSetsOver(window)['abdomen'], greaterThan(0));
    });
  });
}
