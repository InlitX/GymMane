import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/fit_file.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/workout_import.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _epoch = 631065600;

class _Fit {
  final _body = BytesBuilder();
  final _locals = <int, List<(int, int, int)>>{};
  final _big = <int>{};

  void define(int local, int global, List<(int, int, int)> fields, {bool big = false}) {
    _locals[local] = fields;
    if (big) _big.add(local);
    final b = ByteData(5);
    b.setUint8(0, 0);
    b.setUint8(1, big ? 1 : 0);
    b.setUint16(2, global, big ? Endian.big : Endian.little);
    b.setUint8(4, fields.length);
    _body.addByte(0x40 | local);
    _body.add(b.buffer.asUint8List());
    for (final (num, size, base) in fields) {
      _body.add([num, size, base]);
    }
  }

  void data(int local, List<Object> values) {
    final fields = _locals[local]!;
    final endian = _big.contains(local) ? Endian.big : Endian.little;
    _body.addByte(local);
    for (final (i, (_, size, _)) in fields.indexed) {
      final v = values[i];
      if (v is String) {
        final out = Uint8List(size)..setAll(0, v.codeUnits.take(size - 1));
        _body.add(out);
        continue;
      }
      final b = ByteData(size);
      switch (size) {
        case 1:
          b.setUint8(0, v as int);
        case 2:
          b.setUint16(0, v as int, endian);
        case 4:
          b.setUint32(0, v as int, endian);
      }
      _body.add(b.buffer.asUint8List());
    }
  }

  Uint8List bytes() {
    final body = _body.toBytes();
    final head = ByteData(14);
    head.setUint8(0, 14);
    head.setUint8(1, 0x20);
    head.setUint16(2, 2100, Endian.little);
    head.setUint32(4, body.length, Endian.little);
    head.buffer.asUint8List().setAll(8, '.FIT'.codeUnits);
    return Uint8List.fromList([...head.buffer.asUint8List(), ...body, 0, 0]);
  }
}

int _at(DateTime d) => d.millisecondsSinceEpoch ~/ 1000 - _epoch;

Uint8List _strength(DateTime start) {
  final f = _Fit();
  final t = _at(start);
  f.define(0, 0, [(0, 1, 0x00), (4, 4, 0x86)]);
  f.data(0, [4, t]);
  f.define(1, 264, [(254, 2, 0x84), (0, 2, 0x84), (1, 2, 0x84), (2, 16, 0x07)]);
  f.data(1, [0, 28, 2, 'My squat']);
  f.define(2, 225, [(254, 4, 0x86), (0, 4, 0x86), (3, 2, 0x84), (4, 2, 0x84), (5, 1, 0x02), (6, 4, 0x86), (7, 2, 0x84), (8, 2, 0x84)],
      big: true);
  f.data(2, [t + 60, 40000, 8, 960, 1, t + 20, 0, 1]);
  f.data(2, [t + 150, 90000, 0xFFFF, 0xFFFF, 0, t + 60, 0xFFFF, 0xFFFF]);
  f.data(2, [t + 200, 40000, 6, 1040, 1, t + 160, 0, 1]);
  f.data(2, [t + 300, 45000, 0xFFFF, 0xFFFF, 1, t + 255, 19, 0xFFFF]);
  f.data(2, [t + 400, 30000, 5, 1600, 1, t + 370, 28, 2]);
  f.data(2, [t + 500, 30000, 10, 0xFFFF, 1, t + 470, 0xFFFE, 0xFFFF]);
  f.define(3, 18, [(2, 4, 0x86), (7, 4, 0x86), (8, 4, 0x86), (5, 1, 0x00), (6, 1, 0x00)]);
  f.data(3, [t, 3000000, 2700000, 10, 20]);
  return f.bytes();
}

Uint8List _run(DateTime start) {
  final f = _Fit();
  f.define(0, 0, [(0, 1, 0x00)]);
  f.data(0, [4]);
  f.define(1, 18, [(2, 4, 0x86), (7, 4, 0x86), (8, 4, 0x86), (5, 1, 0x00), (6, 1, 0x00), (9, 4, 0x86)]);
  f.data(1, [_at(start), 1900000, 1800000, 1, 0, 500000]);
  return f.bytes();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('garmin', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    final day = DateTime(2026, 11, 20, 18, 30);

    test('a strength activity becomes a session with its sets', () {
      final bytes = _strength(day);
      expect(looksLikeFit(bytes), isTrue);
      final result = parseFitFiles([bytes], unknownName: 'Ejercicio');
      expect(result.format, ImportFormat.garmin);
      expect(result.sessions, hasLength(1));
      final s = result.sessions.single;
      expect(s.date, day);
      expect(s.durationSec, 3000);
      expect(s.exercises.map((e) => e.name), ['Barbell Bench Press', 'Plank', 'My squat', 'Ejercicio']);
      final bench = s.exercises.first.sets;
      expect(bench.map((e) => e.reps), [8, 6]);
      expect(bench.map((e) => e.weightKg), [60, 65]);
      final plank = s.exercises[1].sets.single;
      expect(plank.reps, 0);
      expect(plank.sec, 45);
      expect(s.exercises[2].sets.single.weightKg, 100);
      expect(s.exercises[3].sets.single.weightKg, 0);
    });

    test('a run becomes one timed set with its distance', () {
      final s = parseFitFiles([_run(day)]).sessions.single;
      expect(s.durationSec, 1900);
      final set = s.exercises.single.sets.single;
      expect(s.exercises.single.name, 'Outdoor Run');
      expect(set.sec, 1800);
      expect(set.km, 5);
    });

    test('a Garmin export zip with zips inside is read, and importing twice adds nothing', () {
      final inner = Archive()
        ..addFile(ArchiveFile('a.fit', 0, _strength(day)))
        ..addFile(ArchiveFile('b.fit', 0, _run(day.add(const Duration(days: 1)))))
        ..addFile(ArchiveFile('notes.txt', 3, 'hey'.codeUnits));
      final outer = Archive()
        ..addFile(ArchiveFile('DI_CONNECT/UploadedFiles_0-_Part1.zip', 0, ZipEncoder().encode(inner)));
      final files = fitFilesFromZip(ZipEncoder().encode(outer));
      expect(files, hasLength(2));
      final parsed = parseFitFiles(files);
      expect(fit.importParsedSessions(parsed.sessions), 2);
      expect(fit.importParsedSessions(parsed.sessions), 0);
      final bench = fit.sessions.first.exercises.first;
      expect(bench.id, isNot(startsWith('imp:')));
      expect(bench.sets.map((e) => e.weight), [60, 65]);
      expect(fit.sessions.last.exercises.single.sets.single.km, 5);
    });

    test('broken or non-activity files are skipped', () {
      final cut = _strength(day).sublist(0, 40);
      expect(parseFitFiles([cut]).sessions, isEmpty);
      final course = _Fit()
        ..define(0, 0, [(0, 1, 0x00)])
        ..data(0, [6])
        ..define(1, 18, [(2, 4, 0x86), (8, 4, 0x86), (5, 1, 0x00)])
        ..data(1, [_at(day), 1000000, 1]);
      expect(parseFitFiles([course.bytes()]).sessions, isEmpty);
      expect(looksLikeFit('date,exercise'.codeUnits), isFalse);
    });
  });
}
