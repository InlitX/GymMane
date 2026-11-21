import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../catalog/garmin_exercises.dart';
import 'workout_import.dart';

const _fitEpoch = 631065600;

bool looksLikeFit(List<int> b) =>
    b.length >= 12 && b[8] == 0x2E && b[9] == 0x46 && b[10] == 0x49 && b[11] == 0x54;

List<Uint8List> fitFilesFromZip(List<int> bytes, {int depth = 0}) {
  Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } catch (_) {
    return const [];
  }
  final out = <Uint8List>[];
  for (final file in archive.files) {
    if (!file.isFile) continue;
    final name = file.name.toLowerCase();
    if (!name.endsWith('.fit') && !(depth < 2 && name.endsWith('.zip'))) continue;
    List<int> content;
    try {
      content = file.content as List<int>;
    } catch (_) {
      continue;
    }
    if (name.endsWith('.zip')) {
      out.addAll(fitFilesFromZip(content, depth: depth + 1));
    } else if (looksLikeFit(content)) {
      out.add(Uint8List.fromList(content));
    }
  }
  return out;
}

ImportResult parseFitFiles(Iterable<List<int>> files, {String unknownName = 'Exercise'}) {
  final sessions = <ParsedSession>[];
  for (final bytes in files) {
    try {
      sessions.addAll(_FitReader(Uint8List.fromList(bytes)).read(unknownName));
    } catch (_) {
      continue;
    }
  }
  return ImportResult(ImportFormat.garmin, sessions);
}

class _Field {
  const _Field(this.num, this.size, this.base);
  final int num;
  final int size;
  final int base;
}

class _Def {
  const _Def(this.global, this.little, this.fields, this.devSize);
  final int global;
  final bool little;
  final List<_Field> fields;
  final int devSize;
}

class _FitSession {
  _FitSession(this.start, this.elapsed, this.timer, this.sport, this.subSport, this.meters);
  final int? start;
  final int? elapsed;
  final int? timer;
  final int? sport;
  final int? subSport;
  final int? meters;
}

class _FitSet {
  _FitSet(this.start, this.duration, this.reps, this.weight, this.category, this.subtype);
  final int? start;
  final int? duration;
  final int? reps;
  final int? weight;
  final int? category;
  final int? subtype;
}

const _sizes = [1, 1, 1, 2, 2, 4, 4, 1, 4, 8, 1, 2, 4, 1, 8, 8, 8];

class _FitReader {
  _FitReader(this.bytes) : data = ByteData.sublistView(bytes);
  final Uint8List bytes;
  final ByteData data;
  final _sessions = <_FitSession>[];
  final _sets = <_FitSet>[];
  final _titles = <int, String>{};
  int? _created;
  int? _fileType;
  int _lastTime = 0;

  List<ParsedSession> read(String unknownName) {
    var pos = 0;
    while (pos + 12 <= bytes.length && looksLikeFit(bytes.sublist(pos, pos + 12))) {
      final headerSize = bytes[pos];
      final dataSize = data.getUint32(pos + 4, Endian.little);
      final start = pos + headerSize;
      final end = start + dataSize;
      if (headerSize < 12 || end > bytes.length) {
        _records(start, bytes.length);
        break;
      }
      _records(start, end);
      pos = end + 2;
    }
    if (_fileType != null && _fileType != 4) return const [];
    return _build(unknownName);
  }

  void _records(int from, int to) {
    final defs = <int, _Def>{};
    var p = from;
    while (p < to) {
      final h = bytes[p++];
      if (h & 0x80 != 0) {
        final local = (h >> 5) & 0x03;
        final offset = h & 0x1F;
        var time = (_lastTime & ~0x1F) + offset;
        if (offset < (_lastTime & 0x1F)) time += 0x20;
        _lastTime = time;
        final def = defs[local];
        if (def == null) return;
        p = _message(def, p, time);
        continue;
      }
      final local = h & 0x0F;
      if (h & 0x40 != 0) {
        if (p + 5 > to) return;
        final little = bytes[p + 1] == 0;
        final global = little ? data.getUint16(p + 2, Endian.little) : data.getUint16(p + 2, Endian.big);
        final count = bytes[p + 4];
        p += 5;
        final fields = <_Field>[];
        for (var i = 0; i < count; i++) {
          fields.add(_Field(bytes[p], bytes[p + 1], bytes[p + 2] & 0x1F));
          p += 3;
        }
        var devSize = 0;
        if (h & 0x20 != 0) {
          final devCount = bytes[p++];
          for (var i = 0; i < devCount; i++) {
            devSize += bytes[p + 1];
            p += 3;
          }
        }
        defs[local] = _Def(global, little, fields, devSize);
        continue;
      }
      final def = defs[local];
      if (def == null) return;
      p = _message(def, p, null);
    }
  }

  int _message(_Def def, int p, int? time) {
    final values = <int, Object>{};
    for (final f in def.fields) {
      final v = _value(p, f, def.little);
      if (v != null) values[f.num] = v;
      p += f.size;
    }
    p += def.devSize;
    final stamp = values[253];
    if (stamp is int) _lastTime = stamp;
    int? n(int key) => values[key] is int ? values[key] as int : null;
    switch (def.global) {
      case 0:
        _fileType = n(0);
        _created = n(4);
      case 18:
        _sessions.add(_FitSession(n(2) ?? n(253) ?? time, n(7), n(8), n(5), n(6), n(9)));
      case 225:
        if (n(5) == 1) _sets.add(_FitSet(n(6) ?? n(254), n(0), n(3), n(4), n(7), n(8)));
      case 264:
        final title = values[2];
        final category = n(0);
        if (title is String && title.trim().isNotEmpty && category != null) {
          _titles[category * 65536 + (n(1) ?? 65535)] = title.trim();
        }
    }
    return p;
  }

  Object? _value(int p, _Field f, bool little) {
    if (p + f.size > bytes.length) return null;
    if (f.base == 7) {
      final raw = bytes.sublist(p, p + f.size);
      final cut = raw.indexOf(0);
      final text = String.fromCharCodes(cut < 0 ? raw : raw.sublist(0, cut));
      return text.isEmpty ? null : text;
    }
    if (f.base >= _sizes.length || f.size < _sizes[f.base] || f.base == 8 || f.base == 9 || f.base >= 14) {
      return null;
    }
    final e = little ? Endian.little : Endian.big;
    switch (f.base) {
      case 0 || 2 || 13:
        final v = bytes[p];
        return v == 0xFF ? null : v;
      case 1:
        final v = data.getInt8(p);
        return v == 0x7F ? null : v;
      case 10:
        final v = bytes[p];
        return v == 0 ? null : v;
      case 3:
        final v = data.getInt16(p, e);
        return v == 0x7FFF ? null : v;
      case 4:
        final v = data.getUint16(p, e);
        return v == 0xFFFF ? null : v;
      case 11:
        final v = data.getUint16(p, e);
        return v == 0 ? null : v;
      case 5:
        final v = data.getInt32(p, e);
        return v == 0x7FFFFFFF ? null : v;
      case 6:
        final v = data.getUint32(p, e);
        return v == 0xFFFFFFFF ? null : v;
      case 12:
        final v = data.getUint32(p, e);
        return v == 0 ? null : v;
    }
    return null;
  }

  static DateTime _date(int fit) => DateTime.fromMillisecondsSinceEpoch((fit + _fitEpoch) * 1000);

  String _name(int? category, int? subtype, String unknownName) {
    if (category == null || category == 65534) return unknownName;
    return _titles[category * 65536 + (subtype ?? 65535)] ??
        kGarminExercises[category]?[subtype] ??
        _titles[category * 65536 + 65535] ??
        kGarminCategories[category] ??
        unknownName;
  }

  List<ParsedSession> _build(String unknownName) {
    final infos = _sessions.isEmpty ? [_FitSession(_sets.firstOrNull?.start ?? _created, null, null, null, null, null)] : _sessions;
    final out = <ParsedSession>[];
    for (final (i, info) in infos.indexed) {
      final start = info.start ?? _created;
      if (start == null) continue;
      final seconds = ((info.elapsed ?? info.timer ?? 0) / 1000).round();
      final session = ParsedSession(_date(start), seconds > 0 && seconds <= 24 * 3600 ? seconds : 0);
      final mine = [
        for (final s in _sets)
          if (infos.length == 1 || _owner(s, infos) == i) s,
      ];
      final byName = <String, ParsedExercise>{};
      for (final s in mine) {
        final reps = s.reps ?? 0;
        final sec = ((s.duration ?? 0) / 1000).round();
        if (reps <= 0 && sec <= 0) continue;
        final name = _name(s.category, s.subtype, unknownName);
        final exercise = byName.putIfAbsent(name, () {
          final e = ParsedExercise(name, null);
          session.exercises.add(e);
          return e;
        });
        exercise.sets.add(ParsedSet(reps, (s.weight ?? 0) / 16, sec: reps <= 0 ? sec : null));
      }
      if (session.exercises.isEmpty) {
        final cardio = _cardioName(info.sport, info.subSport);
        final timer = ((info.timer ?? info.elapsed ?? 0) / 1000).round();
        final km = (info.meters ?? 0) / 100000;
        if (cardio != null && timer > 0) {
          session.exercises.add(ParsedExercise(cardio, null)
            ..sets.add(ParsedSet(0, 0, sec: timer, km: km > 0 ? double.parse(km.toStringAsFixed(3)) : null)));
        }
      }
      if (session.exercises.isNotEmpty) out.add(session);
    }
    return out;
  }

  int _owner(_FitSet s, List<_FitSession> infos) {
    final at = s.start;
    if (at == null) return 0;
    for (final (i, info) in infos.indexed) {
      final from = info.start;
      if (from == null) continue;
      final to = from + ((info.elapsed ?? info.timer ?? 0) / 1000).round();
      if (at >= from && at <= to) return i;
    }
    return 0;
  }

  static String? _cardioName(int? sport, int? sub) {
    switch (sport) {
      case 1:
        return sub == 1 || sub == 45 ? 'Treadmill Run' : 'Outdoor Run';
      case 2:
        return sub == 6 ? 'Stationary Bike' : 'Outdoor Cycling';
      case 4:
        return switch (sub) {
          1 => 'Treadmill Run',
          6 => 'Stationary Bike',
          14 => 'Rowing Machine',
          15 => 'Elliptical Trainer',
          16 => 'Stair Climber',
          27 => 'Treadmill Walk',
          _ => null,
        };
      case 5:
        return 'Swimming';
      case 11:
        return sub == 1 || sub == 27 ? 'Treadmill Walk' : 'Walking';
      case 15:
        return sub == 14 ? 'Rowing Machine' : 'Rowing';
      case 17:
        return 'Hiking';
    }
    return null;
  }
}
