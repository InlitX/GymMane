import 'dart:convert';

class PlanItem {
  const PlanItem(this.name, this.sets);
  final String name;
  final int? sets;
}

class PlanRoutine {
  const PlanRoutine(this.name, this.items);
  final String name;
  final List<PlanItem> items;
}

const _nameKeys = ['name', 'routine', 'title', 'nombre', 'rutina'];
const _listKeys = ['exercises', 'items', 'ejercicios', 'movements', 'workout'];
const _setKeys = ['sets', 'series', 'setcount'];
const _itemNameKeys = [..._nameKeys, 'exercise', 'ejercicio', 'movement', 'exercisename'];

List<PlanRoutine> parsePlan(String raw) {
  final data = _decode(raw);
  if (data == null) return const [];
  final out = <PlanRoutine>[];

  void addMap(Map<Object?, Object?> map) {
    final items = _items(_value(map, _listKeys));
    if (items.isEmpty) return;
    out.add(PlanRoutine(_string(_value(map, _nameKeys)), items));
  }

  if (data is Map<Object?, Object?>) {
    final nested = _value(data, ['routines', 'rutinas', 'plan', 'days']);
    if (nested is List) {
      for (final r in nested) {
        if (r is Map<Object?, Object?>) addMap(r);
      }
    } else {
      addMap(data);
    }
  } else if (data is List) {
    if (data.every((e) => e is String)) {
      out.add(PlanRoutine('', _items(data)));
    } else {
      for (final r in data) {
        if (r is Map<Object?, Object?>) addMap(r);
      }
    }
  }
  return out;
}

Object? _decode(String raw) {
  for (final text in _candidates(raw)) {
    try {
      return jsonDecode(text);
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

Object? _value(Map<Object?, Object?> map, List<String> keys) {
  for (final entry in map.entries) {
    final k = entry.key.toString().toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
    if (keys.contains(k)) return entry.value;
  }
  return null;
}

String _string(Object? v) => v is String ? v.trim() : '';

List<PlanItem> _items(Object? raw) {
  if (raw is! List) return const [];
  final out = <PlanItem>[];
  for (final entry in raw) {
    if (entry is String) {
      if (entry.trim().isNotEmpty) out.add(PlanItem(entry.trim(), null));
      continue;
    }
    if (entry is Map<Object?, Object?>) {
      final name = _string(_value(entry, _itemNameKeys));
      if (name.isEmpty) continue;
      final sets = _value(entry, _setKeys);
      out.add(PlanItem(name, sets is num ? sets.toInt() : int.tryParse('$sets')));
    }
  }
  return out;
}
