import 'dart:typed_data';

import '../models/workout.dart';

const _fitEpoch = 631065600;
const _unknownCategory = 65534;

const _categories = <(String, int)>[
  ('bench press', 0),
  ('calf', 1),
  ('carry', 3),
  ('chop', 4),
  ('crunch', 6),
  ('leg curl', 15),
  ('curl', 7),
  ('deadlift', 8),
  ('fly', 9),
  ('hip thrust', 10),
  ('bridge', 10),
  ('swing', 12),
  ('hyperextension', 13),
  ('back extension', 13),
  ('lateral raise', 14),
  ('leg raise', 16),
  ('lunge', 17),
  ('split squat', 17),
  ('clean', 18),
  ('snatch', 18),
  ('plank', 19),
  ('burpee', 20),
  ('jump', 20),
  ('pull-up', 21),
  ('chin-up', 21),
  ('pulldown', 21),
  ('push-up', 22),
  ('row', 23),
  ('shoulder press', 24),
  ('overhead press', 24),
  ('military press', 24),
  ('shrug', 26),
  ('sit-up', 27),
  ('squat', 28),
  ('triceps', 30),
  ('pushdown', 30),
];

int fitCategory(String name) {
  final n = name.toLowerCase();
  for (final (key, id) in _categories) {
    if (n.contains(key)) return id;
  }
  return _unknownCategory;
}

Uint8List workoutFit(LoggedSession session, {bool pounds = false}) {
  final end = session.date.toUtc().millisecondsSinceEpoch ~/ 1000 - _fitEpoch;
  final duration = session.durationSec < 1 ? 1 : session.durationSec;
  final start = end - duration;
  final offset = session.date.timeZoneOffset.inSeconds;
  final sets = [
    for (final e in session.exercises)
      for (final st in e.workingSets) (e, st),
  ];
  final slot = sets.isEmpty ? duration : duration ~/ sets.length;

  final w = _FitWriter();
  w.define(0, 0, const [(0, 1, 0x00), (1, 2, 0x84), (2, 2, 0x84), (4, 4, 0x86)]);
  w.data(0, [(1, 4), (2, 255), (2, 0), (4, start)]);

  w.define(1, 21, const [(253, 4, 0x86), (0, 1, 0x00), (1, 1, 0x00)]);
  w.data(1, [(4, start), (1, 0), (1, 0)]);

  w.define(2, 225, const [
    (254, 4, 0x86),
    (6, 4, 0x86),
    (0, 4, 0x86),
    (3, 2, 0x84),
    (4, 2, 0x84),
    (5, 1, 0x02),
    (7, 2, 0x84),
    (9, 2, 0x84),
    (10, 2, 0x84),
  ]);
  for (var i = 0; i < sets.length; i++) {
    final (e, st) = sets[i];
    final at = start + i * slot;
    final seconds = st.sec ?? (slot < 60 ? slot : 60);
    w.data(2, [
      (4, at + seconds),
      (4, at),
      (4, seconds * 1000),
      (2, st.reps.clamp(0, 65534)),
      (2, (st.weight * 16).round().clamp(0, 65534)),
      (1, 1),
      (2, fitCategory(e.name)),
      (2, pounds ? 2 : 1),
      (2, i),
    ]);
  }

  w.data(1, [(4, end), (1, 0), (1, 4)]);

  w.define(3, 19, const [
    (253, 4, 0x86),
    (2, 4, 0x86),
    (7, 4, 0x86),
    (8, 4, 0x86),
    (0, 1, 0x00),
    (1, 1, 0x00),
  ]);
  w.data(3, [(4, end), (4, start), (4, duration * 1000), (4, duration * 1000), (1, 9), (1, 1)]);

  w.define(4, 18, const [
    (253, 4, 0x86),
    (2, 4, 0x86),
    (7, 4, 0x86),
    (8, 4, 0x86),
    (5, 1, 0x00),
    (6, 1, 0x00),
    (25, 2, 0x84),
    (26, 2, 0x84),
    (0, 1, 0x00),
    (1, 1, 0x00),
  ]);
  w.data(4, [
    (4, end),
    (4, start),
    (4, duration * 1000),
    (4, duration * 1000),
    (1, 10),
    (1, 20),
    (2, 0),
    (2, 1),
    (1, 8),
    (1, 1),
  ]);

  w.define(5, 34, const [
    (253, 4, 0x86),
    (0, 4, 0x86),
    (1, 2, 0x84),
    (2, 1, 0x00),
    (3, 1, 0x00),
    (4, 1, 0x00),
    (5, 4, 0x86),
  ]);
  w.data(5, [(4, end), (4, duration * 1000), (2, 1), (1, 0), (1, 26), (1, 1), (4, end + offset)]);

  return w.bytes();
}

class _FitWriter {
  final _body = BytesBuilder();

  void define(int local, int global, List<(int, int, int)> fields) {
    _body
      ..addByte(0x40 | local)
      ..addByte(0)
      ..addByte(0);
    _int(2, global);
    _body.addByte(fields.length);
    for (final (number, size, type) in fields) {
      _body
        ..addByte(number)
        ..addByte(size)
        ..addByte(type);
    }
  }

  void data(int local, List<(int, int)> values) {
    _body.addByte(local);
    for (final (size, value) in values) {
      _int(size, value);
    }
  }

  void _int(int size, int value) {
    for (var i = 0; i < size; i++) {
      _body.addByte((value >> (8 * i)) & 0xFF);
    }
  }

  Uint8List bytes() {
    final body = _body.toBytes();
    final header = BytesBuilder()
      ..addByte(14)
      ..addByte(0x20)
      ..add(_le(2, 2132))
      ..add(_le(4, body.length))
      ..add('.FIT'.codeUnits);
    final head = header.toBytes();
    final out = BytesBuilder()
      ..add(head)
      ..add(_le(2, fitCrc(head)))
      ..add(body);
    final all = out.toBytes();
    return (BytesBuilder()
          ..add(all)
          ..add(_le(2, fitCrc(all))))
        .toBytes();
  }

  static List<int> _le(int size, int value) => [for (var i = 0; i < size; i++) (value >> (8 * i)) & 0xFF];
}

const _crcTable = [
  0x0000,
  0xCC01,
  0xD801,
  0x1400,
  0xF001,
  0x3C00,
  0x2800,
  0xE401,
  0xA001,
  0x6C00,
  0x7800,
  0xB401,
  0x5000,
  0x9C01,
  0x8801,
  0x4400,
];

int fitCrc(List<int> bytes) {
  var crc = 0;
  for (final b in bytes) {
    var tmp = _crcTable[crc & 0xF];
    crc = (crc >> 4) & 0x0FFF;
    crc = crc ^ tmp ^ _crcTable[b & 0xF];
    tmp = _crcTable[crc & 0xF];
    crc = (crc >> 4) & 0x0FFF;
    crc = crc ^ tmp ^ _crcTable[(b >> 4) & 0xF];
  }
  return crc;
}
