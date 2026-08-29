import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:path_drawing/path_drawing.dart';

void main() {
  test('every exercise points at art that exists and can be drawn', () {
    final broken = <String>[];
    for (final e in kExercises) {
      if (e.art.isEmpty) continue;
      final file = File('assets/art/${e.art}.txt');
      if (!file.existsSync()) {
        broken.add('${e.name}: falta assets/art/${e.art}.txt');
        continue;
      }
      final frames = file.readAsLinesSync().where((l) => l.trim().isNotEmpty).toList();
      if (frames.length != 3) broken.add('${e.name}: ${frames.length} frames, esperaba 3');
      for (final d in frames) {
        try {
          parseSvgPathData(d);
        } catch (err) {
          broken.add('${e.name}: frame ilegible ($err)');
        }
      }
    }
    expect(broken, isEmpty);
  });

  test('almost every exercise ships an illustration', () {
    final sinArte = kExercises.where((e) => e.art.isEmpty).map((e) => e.name).toList();
    expect(sinArte.length, lessThan(kExercises.length ~/ 20),
        reason: 'demasiados ejercicios sin ilustración: $sinArte');
  });

  test('no orphan art sitting unused in assets', () {
    final referenced = kExercises.map((e) => e.art).where((a) => a.isNotEmpty).toSet();
    final onDisk = Directory('assets/art')
        .listSync()
        .whereType<File>()
        .map((f) => f.uri.pathSegments.last)
        .where((n) => n.endsWith('.txt'))
        .map((n) => n.substring(0, n.length - 4))
        .toSet();
    expect(onDisk.difference(referenced), isEmpty);
    expect(referenced.difference(onDisk), isEmpty);
  });

  test('ids and names are unique', () {
    final ids = kExercises.map((e) => e.id).toList();
    expect(ids.toSet().length, ids.length, reason: 'ids duplicados');

    final names = kExercises.map((e) => e.name.trim().toLowerCase()).toList();
    expect(names.toSet().length, names.length, reason: 'nombres duplicados');
  });

  test('every exercise has a real muscle, equipment and difficulty', () {
    final muscles = kMuscles.map((m) => m.id).toSet();
    final bad = <String>[];
    for (final e in kExercises) {
      if (!muscles.contains(e.primary)) bad.add('${e.name}: primary "${e.primary}"');
      for (final s in e.secondary) {
        if (!muscles.contains(s)) bad.add('${e.name}: secondary "$s"');
      }
      if (!kEquipment.contains(e.equipment)) bad.add('${e.name}: equipment "${e.equipment}"');
      if (!kDifficulties.contains(e.difficulty)) bad.add('${e.name}: difficulty "${e.difficulty}"');
    }
    expect(bad, isEmpty);
  });

  test('an exercise never lists its primary muscle as secondary too', () {
    final bad = kExercises.where((e) => e.secondary.contains(e.primary)).map((e) => e.name);
    expect(bad, isEmpty);
  });

  test('every exercise explains how to do it', () {
    final bare = kExercises.where((e) => e.steps.length < 3).map((e) => e.name);
    expect(bare, isEmpty);
  });

  test('steps are real instructions, not filler', () {
    final bad = <String>[];
    for (final e in kExercises) {
      for (final s in e.steps) {
        if (s.trim().split(' ').length < 4) bad.add('${e.name}: "$s" (too short)');
        if (!s.trim().endsWith('.')) bad.add('${e.name}: "$s" (unfinished)');
      }
    }
    expect(bad, isEmpty);
  });

  test('names carry no leftovers from the source dataset', () {
    final leaked = kExercises
        .where((e) => RegExp(r'\((male|female)\)', caseSensitive: false).hasMatch(e.name))
        .map((e) => e.name);
    expect(leaked, isEmpty);
  });

  test('an exercise is never just named after a muscle', () {
    final labels = kMuscles.map((m) => m.label.toLowerCase()).toSet();
    final lazy = kExercises.where((e) => labels.contains(e.name.trim().toLowerCase())).map((e) => e.name);
    expect(lazy, isEmpty, reason: 'un músculo no es un ejercicio');
  });

  test('every muscle on the body map leads somewhere', () {
    for (final m in kMuscles) {
      final n = kExercises.where((e) => e.primary == m.id || e.secondary.contains(m.id)).length;
      expect(n, greaterThan(0), reason: '${m.label} no tiene ningún ejercicio');
    }
  });

  test('every muscle maps to a real group and family', () {
    for (final m in kMuscles) {
      expect(muscleGroup(m.id), isNotEmpty);
      expect(const ['push', 'pull', 'legs', 'core'], contains(muscleFamily(m.id)));
    }
  });
}
