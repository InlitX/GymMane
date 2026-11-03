import 'dart:convert';

class PlanSet {
  const PlanSet({this.reps, this.weightKg, this.kind = 0, this.sec, this.km});
  final int? reps;
  final double? weightKg;
  final int kind;
  final int? sec;
  final double? km;
}

class PlanItem {
  const PlanItem(
    this.name,
    this.sets, {
    this.id,
    this.reps,
    this.weightKg,
    this.restSec,
    this.superset = false,
    this.plan = const [],
    this.muscle,
    this.equipment,
    this.level,
    this.steps = const [],
    this.mode = '',
    this.secondary = const [],
    this.ladder = const [],
  });
  final String name;
  final int? sets;
  final String? id;
  final int? reps;
  final double? weightKg;
  final int? restSec;
  final bool superset;
  final List<PlanSet> plan;
  final String? muscle;
  final List<String> secondary;
  final String? equipment;
  final String? level;
  final List<String> steps;
  final String mode;
  final List<String> ladder;
}

class PlanRoutine {
  const PlanRoutine(this.name, this.items, {this.group = '', this.days = const []});
  final String name;
  final List<PlanItem> items;
  final String group;
  final List<int> days;
}

const _nameKeys = ['name', 'routine', 'title', 'nombre', 'rutina', 'workout', 'day', 'dia'];
const _listKeys = ['exercises', 'items', 'ejercicios', 'movements', 'exercicios', 'esercizi', 'ubungen'];
const _routineListKeys = ['routines', 'rutinas', 'plan', 'days', 'workouts', 'sessions', 'dias'];
const _groupKeys = ['group', 'grupo', 'folder', 'program', 'programme', 'programa', 'split'];
const _weekKeys = ['weeks', 'semanas', 'mesocycle', 'blocks'];
const _dayKeys = ['days', 'dias', 'weekdays', 'schedule', 'on'];
const _setKeys = ['sets', 'series', 'setcount'];
const _repKeys = ['reps', 'repetitions', 'repeticiones', 'rep', 'repeticoes', 'ripetizioni'];
const _weightKeys = ['weight', 'weightkg', 'load', 'kg', 'peso', 'carga', 'lbs', 'lb'];
const _restKeys = ['rest', 'restseconds', 'restsec', 'descanso', 'pause', 'riposo'];
const _timeKeys = ['time', 'duration', 'seconds', 'sec', 'secs', 'tiempo', 'durationseconds'];
const _distanceKeys = ['distance', 'km', 'distancekm', 'distancia'];
const _itemNameKeys = ['name', 'exercise', 'ejercicio', 'movement', 'exercisename', 'title', 'nombre'];

const _weekdayNames = {
  1: ['monday', 'mon', 'lunes', 'lun', 'segunda', 'lunedi', 'montag', 'mo'],
  2: ['tuesday', 'tue', 'tues', 'martes', 'mar', 'terca', 'martedi', 'dienstag', 'di'],
  3: ['wednesday', 'wed', 'miercoles', 'mie', 'quarta', 'mercoledi', 'mittwoch', 'mi'],
  4: ['thursday', 'thu', 'thur', 'thurs', 'jueves', 'jue', 'quinta', 'giovedi', 'donnerstag', 'do'],
  5: ['friday', 'fri', 'viernes', 'vie', 'sexta', 'venerdi', 'freitag', 'fr'],
  6: ['saturday', 'sat', 'sabado', 'sab', 'sabato', 'samstag', 'sa'],
  7: ['sunday', 'sun', 'domingo', 'dom', 'domenica', 'sonntag', 'so'],
};

List<PlanRoutine> parsePlan(String raw) {
  final data = _decode(raw);
  if (data == null) return _parseCsv(raw);
  final lb = data is Map<Object?, Object?> && _isLb(_value(data, ['unit', 'units', 'unidad']));
  final out = <PlanRoutine>[];

  void addRoutine(Map<Object?, Object?> map, String group) {
    final items = _items(_value(map, _listKeys), lb);
    if (items.isEmpty) return;
    final own = _string(_value(map, _groupKeys));
    out.add(PlanRoutine(
      _string(_value(map, _nameKeys)),
      items,
      group: own.isNotEmpty ? own : group,
      days: _days(_value(map, _dayKeys)),
    ));
  }

  void addRoutines(List<Object?> list, String group) {
    if (list.isNotEmpty && list.every((e) => e is String)) {
      out.add(PlanRoutine('', _items(list, lb), group: group));
      return;
    }
    for (final r in list) {
      if (r is Map<Object?, Object?>) addRoutine(r, group);
    }
  }

  if (data is Map<Object?, Object?>) {
    final program = _string(_value(data, _groupKeys));
    final weeks = _value(data, _weekKeys);
    final nested = _routineList(data);
    if (weeks is List) {
      var n = 0;
      for (final w in weeks) {
        n++;
        if (w is! Map<Object?, Object?>) continue;
        final label = _string(_value(w, _nameKeys + ['week', 'semana']));
        final week = label.isNotEmpty ? label : 'Week $n';
        final group = program.isEmpty ? week : '$program · $week';
        final inner = _routineList(w);
        if (inner != null) addRoutines(inner, group);
      }
    } else if (nested != null) {
      final name = _string(_value(data, _nameKeys));
      addRoutines(nested, program.isNotEmpty ? program : (_listOfRoutines(nested) ? name : ''));
    } else {
      addRoutine(data, '');
    }
  } else if (data is List) {
    addRoutines(data, '');
  }
  return out;
}

bool _listOfRoutines(List<Object?> list) =>
    list.isNotEmpty && list.every((e) => e is Map<Object?, Object?> && _value(e, _listKeys) is List);

List<Object?>? _routineList(Map<Object?, Object?> map) {
  for (final entry in map.entries) {
    final k = _norm(entry.key);
    final v = entry.value;
    if (!_routineListKeys.contains(k) || v is! List) continue;
    if (v.isNotEmpty && v.every((e) => e is num || e is String) && _dayKeys.contains(k)) continue;
    return v;
  }
  return null;
}

Object? _decode(String raw) {
  for (final text in _candidates(raw)) {
    try {
      final data = jsonDecode(text);
      if (data is Map || data is List) return data;
    } catch (_) {
      continue;
    }
  }
  return null;
}

List<String> _candidates(String raw) {
  final text = raw.trim();
  final out = [text];
  final fenced = RegExp(r'```(?:json)?\s*([\s\S]*?)```').firstMatch(text);
  if (fenced != null) out.add(fenced.group(1)!.trim());
  for (final pair in [('{', '}'), ('[', ']')]) {
    final start = text.indexOf(pair.$1);
    final end = text.lastIndexOf(pair.$2);
    if (start >= 0 && end > start) out.add(text.substring(start, end + 1));
  }
  return out;
}

String _norm(Object? key) => key.toString().toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');

Object? _value(Map<Object?, Object?> map, List<String> keys) {
  for (final key in keys) {
    for (final entry in map.entries) {
      if (_norm(entry.key) == key) return entry.value;
    }
  }
  return null;
}

String _string(Object? v) => v is String ? v.trim() : (v is num ? '$v' : '');

bool _isLb(Object? v) => v is String && RegExp(r'^\s*(lb|lbs|pounds?)\s*$', caseSensitive: false).hasMatch(v);

int? _int(Object? v) {
  if (v is num) return v.round();
  if (v is String) {
    final m = RegExp(r'\d+').firstMatch(v);
    return m == null ? null : int.parse(m.group(0)!);
  }
  return null;
}

double? _double(Object? v) {
  if (v is num) return v.toDouble();
  if (v is String) {
    final m = RegExp(r'\d+(?:[.,]\d+)?').firstMatch(v);
    return m == null ? null : double.tryParse(m.group(0)!.replaceAll(',', '.'));
  }
  return null;
}

double? _weight(Object? v, bool lb) {
  final n = _double(v);
  if (n == null) return null;
  final inLb = lb || (v is String && RegExp(r'lb', caseSensitive: false).hasMatch(v));
  return inLb ? n / 2.20462 : n;
}

int? _seconds(Object? v) {
  if (v is num) return v.round();
  if (v is! String) return null;
  final s = v.trim().toLowerCase();
  final clock = RegExp(r'^(\d+):(\d{1,2})(?::(\d{1,2}))?$').firstMatch(s);
  if (clock != null) {
    final a = int.parse(clock.group(1)!), b = int.parse(clock.group(2)!);
    final c = clock.group(3);
    return c == null ? a * 60 + b : a * 3600 + b * 60 + int.parse(c);
  }
  final n = _double(s);
  if (n == null) return null;
  if (s.contains('h')) return (n * 3600).round();
  if (s.contains('min') || RegExp(r'\d\s*m\b').hasMatch(s)) return (n * 60).round();
  return n.round();
}

int _kind(Object? v) {
  final s = _norm(v);
  if (s.startsWith('warm') || s.startsWith('calent') || s == 'w') return 1;
  if (s.startsWith('drop')) return 2;
  if (s.startsWith('fail') || s.startsWith('fallo') || s == 'amrap') return 3;
  if (s.startsWith('restpause') || s == 'rp') return 4;
  if (s.startsWith('cluster') || s == 'c') return 5;
  return 0;
}

List<int> _days(Object? v) {
  final list = v is List ? v : (v is String ? v.split(RegExp(r'[,/;\s]+')) : const []);
  final out = <int>{};
  for (final d in list) {
    if (d is num && d >= 1 && d <= 7) out.add(d.toInt());
    if (d is String) {
      final k = d
          .toLowerCase()
          .replaceAll(RegExp(r'[áàâä]'), 'a')
          .replaceAll(RegExp(r'[éèêë]'), 'e')
          .replaceAll(RegExp(r'[íìîï]'), 'i')
          .replaceAll(RegExp(r'[óòôö]'), 'o')
          .replaceAll(RegExp(r'[úùûü]'), 'u')
          .replaceAll('ç', 'c')
          .replaceAll(RegExp(r'[^a-z0-9]'), '');
      final n = int.tryParse(k);
      if (n != null && n >= 1 && n <= 7) {
        out.add(n);
        continue;
      }
      for (final e in _weekdayNames.entries) {
        if (e.value.contains(k) || (k.length > 3 && e.value.first.startsWith(k))) out.add(e.key);
      }
    }
  }
  return out.toList()..sort();
}

List<PlanSet> _planSets(Object? raw, bool lb) {
  if (raw is! List) return const [];
  final out = <PlanSet>[];
  for (final s in raw) {
    if (s is! Map<Object?, Object?>) continue;
    out.add(PlanSet(
      reps: _int(_value(s, _repKeys)),
      weightKg: _weight(_value(s, _weightKeys), lb || _value(s, ['lbs', 'lb']) != null),
      kind: _kind(_value(s, ['type', 'kind', 'tipo', 'settype'])),
      sec: _seconds(_value(s, _timeKeys)),
      km: _double(_value(s, _distanceKeys)),
    ));
  }
  return out;
}

List<PlanItem> _items(Object? raw, bool lb) {
  if (raw is! List) return const [];
  final out = <PlanItem>[];
  for (final entry in raw) {
    if (entry is String) {
      if (entry.trim().isNotEmpty) out.add(PlanItem(entry.trim(), null));
      continue;
    }
    if (entry is! Map<Object?, Object?>) continue;
    final name = _string(_value(entry, _itemNameKeys));
    final id = _string(_value(entry, ['id', 'exerciseid']));
    if (name.isEmpty && id.isEmpty) continue;
    final itemLb = lb || _isLb(_value(entry, ['unit', 'units'])) || _value(entry, ['lbs', 'lb']) != null;
    final custom = _value(entry, ['custom', 'own', 'details']);
    final info = custom is Map<Object?, Object?> ? custom : const <Object?, Object?>{};
    final steps = _value(info, ['steps', 'howto', 'pasos', 'instructions']);
    final superset = _value(entry, ['superset', 'supersetwithnext', 'linked', 'chain']);
    out.add(PlanItem(
      name.isEmpty ? id : name,
      _int(_value(entry, _setKeys)),
      id: id.isEmpty ? null : id,
      reps: _int(_value(entry, _repKeys)),
      weightKg: _weight(_value(entry, _weightKeys), itemLb),
      restSec: _seconds(_value(entry, _restKeys)),
      superset: superset == true || (superset is String && superset.toLowerCase() == 'true'),
      plan: _planSets(_value(entry, ['plan', 'setplan', 'setsplan', 'detail']), itemLb),
      muscle: _string(_value(info, ['muscle', 'primary', 'musculo'])),
      equipment: _string(_value(info, ['equipment', 'material', 'gear'])),
      level: _string(_value(info, ['level', 'difficulty', 'nivel'])),
      steps: steps is List ? steps.whereType<String>().toList() : const [],
      mode: _string(_value(info, ['track', 'mode', 'type'])),
      secondary: switch (_value(info, ['secondary', 'secondarymuscles'])) {
        final List list => list.whereType<String>().toList(),
        _ => const [],
      },
      ladder: switch (_value(entry, ['progression', 'ladder', 'progresion', 'progressao', 'progressione'])) {
        final List list => [for (final s in list.whereType<String>()) if (s.trim().isNotEmpty) s.trim()],
        _ => const [],
      },
    ));
  }
  return _mergeRepeats(out);
}

List<PlanSet> _expanded(PlanItem item) {
  if (item.plan.isNotEmpty) {
    final working = item.plan.where((p) => p.kind != 1).length;
    return [
      for (final p in item.plan) PlanSet(reps: p.reps ?? item.reps, weightKg: p.weightKg ?? item.weightKg, kind: p.kind, sec: p.sec, km: p.km),
      for (var i = working; i < (item.sets ?? working); i++) PlanSet(reps: item.reps, weightKg: item.weightKg),
    ];
  }
  return [for (var i = 0; i < (item.sets ?? 1); i++) PlanSet(reps: item.reps, weightKg: item.weightKg)];
}

List<PlanItem> _mergeRepeats(List<PlanItem> items) {
  String key(PlanItem i) => (i.id ?? i.name).trim().toLowerCase();
  final seen = <String, int>{};
  final out = <PlanItem>[];
  for (final item in items) {
    final at = seen[key(item)];
    if (at == null) {
      seen[key(item)] = out.length;
      out.add(item);
      continue;
    }
    final first = out[at];
    final plan = [..._expanded(first), ..._expanded(item)];
    out[at] = PlanItem(
      first.name,
      plan.where((p) => p.kind != 1).length,
      id: first.id,
      reps: first.reps ?? item.reps,
      weightKg: first.weightKg ?? item.weightKg,
      restSec: first.restSec ?? item.restSec,
      superset: first.superset || item.superset,
      plan: plan,
      muscle: first.muscle,
      equipment: first.equipment,
      level: first.level,
      steps: first.steps,
      mode: first.mode,
      secondary: first.secondary,
      ladder: first.ladder,
    );
  }
  return out;
}

List<List<String>> _rows(String raw) {
  final lines = raw.split(RegExp(r'\r?\n')).map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
  if (lines.isEmpty) return const [];
  final first = lines.first;
  final sep = [';', '\t', ','].reduce((a, b) => first.split(a).length >= first.split(b).length ? a : b);
  List<String> split(String line) {
    final cells = <String>[];
    final cell = StringBuffer();
    var quoted = false;
    for (var i = 0; i < line.length; i++) {
      final c = line[i];
      if (c == '"') {
        quoted = !quoted;
      } else if (c == sep && !quoted) {
        cells.add(cell.toString().trim());
        cell.clear();
      } else {
        cell.write(c);
      }
    }
    cells.add(cell.toString().trim());
    return cells;
  }

  return lines.map(split).where((r) => r.length >= 2).toList();
}

List<PlanRoutine> _parseCsv(String raw) {
  final rows = _rows(raw);
  if (rows.isEmpty) return const [];
  final head = rows.first.map(_norm).toList();
  int col(List<String> keys) => head.indexWhere(keys.contains);
  var exercise = col(['exercise', 'ejercicio', 'exercisename', 'movement', 'name']);
  var routine = col(['routine', 'rutina', 'workout', 'day', 'dia', 'session']);
  var sets = col(_setKeys);
  var reps = col(_repKeys);
  var weight = col(_weightKeys);
  final group = col(['week', 'semana', 'group', 'grupo', 'program']);
  final rest = col(_restKeys);
  final days = col(['weekday', 'weekdays', 'schedule']);
  final lb = head.any((h) => h == 'lbs' || h == 'lb' || h == 'weightlbs');
  var body = rows.skip(1).toList();
  if (exercise < 0) {
    final probe = rows.first;
    if (probe.length < 3 || _int(probe[1]) != null || _int(probe[2]) == null) return const [];
    body = rows;
    routine = 0;
    exercise = 1;
    sets = 2;
    reps = 3;
    weight = 4;
  }
  String cell(List<String> r, int i) => i >= 0 && i < r.length ? r[i] : '';

  final order = <String>[];
  final grouped = <String, List<PlanItem>>{};
  final groups = <String, String>{};
  final schedule = <String, List<int>>{};
  for (final r in body) {
    final name = cell(r, exercise);
    if (name.isEmpty || _int(name) != null) continue;
    final g = cell(r, group);
    final key = '$g|${cell(r, routine)}';
    if (!grouped.containsKey(key)) {
      order.add(key);
      grouped[key] = [];
      groups[key] = g;
      schedule[key] = _days(cell(r, days));
    }
    grouped[key]!.add(PlanItem(
      name,
      _int(cell(r, sets)),
      reps: _int(cell(r, reps)),
      weightKg: _weight(cell(r, weight), lb),
      restSec: _seconds(cell(r, rest)),
    ));
  }
  return [
    for (final key in order)
      PlanRoutine(key.split('|').last, grouped[key]!, group: groups[key]!, days: schedule[key]!),
  ];
}

String encodePlan(Map<String, Object?> plan) => const JsonEncoder.withIndent('  ').convert(plan);
