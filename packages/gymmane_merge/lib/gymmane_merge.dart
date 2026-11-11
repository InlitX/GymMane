import 'dart:convert';

const String syncPrefix = 'gymmane-auto-';

const Set<String> _localOnly = {'live', 'liveStart', 'liveElapsed', 'livePaused', 'alarmSound', 'alarmSoundName'};

const Set<String> _unionLists = {'checkins', 'awardsSeen', 'trkKnown'};

const Set<String> mediaGroups = {'noteMedia', 'shotMedia', 'momentMedia', 'foodMedia', 'passMedia'};

class SyncFile {
  const SyncFile(this.name, this.device, this.at);

  final String name;
  final String device;
  final DateTime at;

  static SyncFile? parse(String name) {
    if (!name.startsWith(syncPrefix) || !name.toLowerCase().endsWith('.zip')) return null;
    final body = name.substring(syncPrefix.length, name.length - 4);
    final dash = body.indexOf('-');
    if (dash <= 0) return null;
    final device = body.substring(0, dash);
    if (!RegExp(r'^[a-z]+$').hasMatch(device)) return null;
    final at = parseStamp(body.substring(dash + 1));
    if (at == null) return null;
    return SyncFile(name, device, at);
  }
}

String two(int n) => n.toString().padLeft(2, '0');

String stamp(DateTime d) {
  final u = d.toUtc();
  return '${u.year}-${two(u.month)}-${two(u.day)}-${two(u.hour)}${two(u.minute)}${two(u.second)}';
}

DateTime? parseStamp(String s) {
  final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})(\d{2})$').firstMatch(s);
  if (m == null) return null;
  int g(int i) => int.parse(m.group(i)!);
  return DateTime.utc(g(1), g(2), g(3), g(4), g(5), g(6));
}

String syncName(String device, DateTime at) => '$syncPrefix$device-${stamp(at)}.zip';

Map<String, SyncFile> newestByDevice(Iterable<String> names, {required String self}) {
  final out = <String, SyncFile>{};
  for (final n in names) {
    final f = SyncFile.parse(n);
    if (f == null || f.device == self) continue;
    final best = out[f.device];
    if (best == null || f.at.isAfter(best.at)) out[f.device] = f;
  }
  return out;
}

Map<String, dynamic> mergeStates(Map<String, dynamic> local, Map<String, dynamic> incoming,
    {required bool incomingNewer}) {
  final newer = incomingNewer ? incoming : local;
  final older = incomingNewer ? local : incoming;
  final out = _mergeMap(newer, older);
  for (final k in _localOnly) {
    if (local.containsKey(k)) {
      out[k] = local[k];
    } else {
      out.remove(k);
    }
  }
  for (final g in mediaGroups) {
    out.remove(g);
  }
  if (local['onboarded'] == true || incoming['onboarded'] == true) out['onboarded'] = true;
  return out;
}

bool sameState(Map<String, dynamic> a, Map<String, dynamic> b) => jsonEncode(a) == jsonEncode(b);

Map<String, dynamic> _mergeMap(Map a, Map b) {
  final out = <String, dynamic>{};
  for (final e in a.entries) {
    final k = '${e.key}';
    out[k] = b.containsKey(e.key) ? _merge(k, e.value, b[e.key]) : e.value;
  }
  for (final e in b.entries) {
    final k = '${e.key}';
    if (!out.containsKey(k)) out[k] = e.value;
  }
  return out;
}

Object? _merge(String key, Object? a, Object? b) {
  if (a is Map && b is Map) return _mergeMap(a, b);
  if (a is List && b is List) return _mergeList(key, a, b);
  return a ?? b;
}

String? _keyOf(Object? x) {
  if (x is! Map) return null;
  final id = x['id'];
  if (id is String && id.isNotEmpty) return 'id:$id';
  if (id is num) return 'id:$id';
  final d = x['d'];
  if (d is String && d.isNotEmpty) return 'd:$d|${x['k'] ?? ''}';
  return null;
}

List<Object?> _mergeList(String key, List a, List b) {
  if (b.isEmpty) return a;
  if (a.isEmpty) return b;
  final all = [...a, ...b];
  if (all.every((x) => x is Map)) {
    final keyed = all.every((x) => _keyOf(x) != null);
    final seen = <String>{};
    final out = <Object?>[];
    for (final x in a) {
      final k = keyed ? _keyOf(x)! : jsonEncode(x);
      if (seen.add(k)) out.add(x);
    }
    for (final x in b) {
      final k = keyed ? _keyOf(x)! : jsonEncode(x);
      if (seen.add(k)) out.add(x);
    }
    if (keyed && all.first is Map && (all.first as Map).containsKey('d') && !(all.first as Map).containsKey('id')) {
      out.sort((x, y) => '${(x as Map)['d']}'.compareTo('${(y as Map)['d']}'));
    }
    return out;
  }
  if (_unionLists.contains(key) && all.every((x) => x is! Map && x is! List)) {
    final seen = <String>{};
    return [
      for (final x in [...a, ...b])
        if (seen.add(jsonEncode(x))) x,
    ];
  }
  return a;
}

Set<String> stringsIn(Object? node) {
  final out = <String>{};
  void walk(Object? n) {
    if (n is String) {
      out.add(n);
    } else if (n is List) {
      n.forEach(walk);
    } else if (n is Map) {
      n.values.forEach(walk);
    }
  }

  walk(node);
  return out;
}

Object? renameStrings(Object? node, Map<String, String> renames) {
  if (renames.isEmpty) return node;
  if (node is String) return renames[node] ?? node;
  if (node is List) return [for (final x in node) renameStrings(x, renames)];
  if (node is Map) return {for (final e in node.entries) '${e.key}': renameStrings(e.value, renames)};
  return node;
}
