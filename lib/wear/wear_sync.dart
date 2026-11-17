import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync/sync.dart';

import '../services/backup_zip.dart';
import '../services/local_store.dart';
import '../services/watch_link.dart';
import '../state/fit_state.dart';

const Set<String> _watchOwn = {
  'keepAwake',
  'live',
  'liveStart',
  'liveElapsed',
  'livePaused',
  'alarmSound',
  'alarmSoundName',
};

const Set<String> _phoneOnly = {
  'notes',
  'exNotes',
  'shots',
  'moments',
  'bodyTl',
  'nutrition',
  'measures',
  'steps',
  'health',
  'media',
};

String sessionKey(Object? session) => session is Map ? '${session['d'] ?? ''}' : '';

Map<String, dynamic> mirrorPhone(Map<String, dynamic> watch, Map<String, dynamic> phone) {
  final out = slimForWatch(phone);
  for (final k in _watchOwn) {
    if (watch.containsKey(k)) out[k] = watch[k];
  }
  final seen = <String>{};
  final sessions = <Object?>[];
  for (final s in [...(phone['sessions'] as List? ?? const []), ...(watch['sessions'] as List? ?? const [])]) {
    final k = sessionKey(s);
    if (k.isEmpty || seen.add(k)) sessions.add(s);
  }
  sessions.sort((a, b) => sessionKey(a).compareTo(sessionKey(b)));
  out['sessions'] = sessions;
  out['onboarded'] = true;
  return out;
}

Map<String, dynamic> slimForWatch(Map<String, dynamic> phone) {
  final out = <String, dynamic>{};
  for (final e in phone.entries) {
    if (_phoneOnly.contains(e.key) || mediaGroups.contains(e.key) || _watchOwn.contains(e.key)) continue;
    out[e.key] = e.value;
  }
  final profile = out['profile'];
  if (profile is Map) out['profile'] = {...profile}..remove('photo')..remove('banner');
  return out;
}

Map<String, dynamic> watchExport(Map<String, dynamic> watch, Iterable<String> mine) {
  final keep = mine.toSet();
  return {
    'sessions': [
      for (final s in (watch['sessions'] as List? ?? const []))
        if (keep.contains(sessionKey(s))) s,
    ],
  };
}

class WearSync extends ChangeNotifier {
  WearSync._();
  static final WearSync instance = WearSync._();

  static const _note = 'wearSync';
  static const folder = 'sync';

  String device = '';
  final List<String> _mine = [];
  final Map<String, int> _pulled = {};
  final Set<String> _known = {};
  DateTime? pulledAt;
  DateTime? sentAt;
  String _sent = '';
  bool busy = false;
  bool _applying = false;
  Directory? _dir;

  int get waiting => _mine.length;

  String? get path => _dir?.path;

  Future<void> init() async {
    _load();
    try {
      final base = await getExternalStorageDirectory();
      if (base != null) {
        _dir = Directory('${base.path}/$folder');
        await _dir!.create(recursive: true);
      }
    } catch (e) {
      debugPrint('WearSync: $e');
    }
    _known.addAll(_keys());
    fit.addListener(_onFit);
    final link = WatchLink.instance
      ..outgoing = _outgoing
      ..onRequest = _fromPhone
      ..onReply = _phoneReply;
    await link.init(watch: true);
    await sync();
  }

  Map<String, dynamic> _local() {
    fit.persistNow();
    return jsonDecode(jsonEncode(Store.finite(fit.toJson()))) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _outgoing() async =>
      {'role': 'watch', 'device': device, 'sessions': watchExport(_local(), _mine)['sessions']};

  Future<Map<String, dynamic>?> _fromPhone(Map<String, dynamic> m) async {
    if (m['role'] != 'phone') return null;
    final state = m['state'];
    if (state is Map<String, dynamic> && !fit.isSessionActive) {
      _apply(state);
      _save();
    }
    return _outgoing();
  }

  Future<void> _phoneReply(Map<String, dynamic> m) async {
    final state = m['state'];
    if (m['role'] != 'phone' || state is! Map<String, dynamic> || fit.isSessionActive) return;
    _apply(state);
  }

  bool _apply(Map<String, dynamic> phone) {
    if (phone['routines'] is! List) return false;
    final next = mirrorPhone(_local(), phone);
    _applying = true;
    final ok = fit.tryApplyBackup(next);
    _applying = false;
    if (!ok) return false;
    final theirs = {for (final s in (phone['sessions'] as List? ?? const [])) sessionKey(s)};
    _mine.removeWhere(theirs.contains);
    _known
      ..clear()
      ..addAll(_keys());
    pulledAt = DateTime.now();
    return true;
  }

  Iterable<String> _keys() => fit.sessions.map((s) => s.date.toIso8601String());

  void _load() {
    final raw = Store.instance.note(_note);
    if (raw != null && raw.isNotEmpty) {
      try {
        final j = jsonDecode(raw) as Map<String, dynamic>;
        device = j['device'] as String? ?? '';
        _mine.addAll(((j['mine'] as List?) ?? const []).whereType<String>());
        ((j['pulled'] as Map?) ?? const {}).forEach((k, v) {
          if (k is String && v is num) _pulled[k] = v.toInt();
        });
        final pa = (j['pulledAt'] as num?)?.toInt();
        pulledAt = pa == null ? null : DateTime.fromMillisecondsSinceEpoch(pa);
        final sa = (j['sentAt'] as num?)?.toInt();
        sentAt = sa == null ? null : DateTime.fromMillisecondsSinceEpoch(sa);
        _sent = j['sent'] as String? ?? '';
      } catch (_) {}
    }
    if (device.isEmpty) {
      final r = math.Random.secure();
      device = 'watch${String.fromCharCodes([for (var i = 0; i < 4; i++) 97 + r.nextInt(26)])}';
      _save();
    }
  }

  void _save() {
    Store.instance.setNote(
        _note,
        jsonEncode({
          'device': device,
          'mine': _mine,
          'pulled': _pulled,
          if (pulledAt != null) 'pulledAt': pulledAt!.millisecondsSinceEpoch,
          if (sentAt != null) 'sentAt': sentAt!.millisecondsSinceEpoch,
          'sent': _sent,
        }));
    notifyListeners();
  }

  void _onFit() {
    if (_applying) return;
    final now = _keys().toSet();
    final fresh = now.difference(_known);
    _known
      ..clear()
      ..addAll(now);
    if (fresh.isEmpty) return;
    _mine.addAll(fresh.where((k) => !_mine.contains(k)));
    _save();
    unawaited(sync());
  }

  Future<bool> sync({bool manual = false}) async {
    if (busy || fit.isSessionActive) return false;
    busy = true;
    notifyListeners();
    var changed = false;
    final dir = _dir;
    if (dir != null) {
      try {
        changed = await _pull(dir);
        await _push(dir);
      } catch (e) {
        debugPrint('WearSync failed: $e');
      }
    }
    busy = false;
    _save();
    if (await WatchLink.instance.exchange(manual: manual)) {
      changed = true;
      _save();
    }
    return changed;
  }

  static SyncFile? _parse(String name) =>
      SyncFile.parse(name.toLowerCase().endsWith('.json') ? '${name.substring(0, name.length - 5)}.zip' : name);

  Future<Map<String, dynamic>?> _read(File f) async {
    try {
      if (f.path.toLowerCase().endsWith('.json')) {
        final decoded = jsonDecode(await f.readAsString());
        return decoded is Map<String, dynamic> ? decoded : null;
      }
      final input = InputFileStream(f.path);
      try {
        final archive = ZipDecoder().decodeStream(input);
        ArchiveFile? found;
        for (final e in archive.files) {
          if (!e.isFile || !e.name.toLowerCase().endsWith('.json')) continue;
          if (e.name == kBackupJsonEntry) {
            found = e;
            break;
          }
          found ??= e;
        }
        final bytes = found?.readBytes();
        if (bytes == null) return null;
        final decoded = jsonDecode(utf8.decode(bytes));
        return decoded is Map<String, dynamic> ? decoded : null;
      } finally {
        await input.close();
      }
    } catch (e) {
      debugPrint('WearSync read failed: $e');
      return null;
    }
  }

  Future<bool> _pull(Directory dir) async {
    final files = <(SyncFile, File)>[];
    await for (final e in dir.list()) {
      if (e is! File) continue;
      final name = e.uri.pathSegments.last;
      final f = _parse(name);
      if (f == null || f.device.startsWith('watch')) continue;
      files.add((f, e));
    }
    if (files.isEmpty) return false;
    files.sort((a, b) => b.$1.at.compareTo(a.$1.at));
    final (newest, file) = files.first;
    for (final (_, old) in files.skip(1)) {
      try {
        await old.delete();
      } catch (_) {}
    }
    final stamp = newest.at.millisecondsSinceEpoch;
    if (stamp <= (_pulled.values.fold<int>(0, math.max))) return false;
    final phone = await _read(file);
    if (phone == null || !_apply(phone)) return false;
    _pulled
      ..clear()
      ..[newest.device] = stamp;
    return true;
  }

  Future<void> _push(Directory dir) async {
    final mine = <File>[];
    await for (final e in dir.list()) {
      if (e is File && e.uri.pathSegments.last.startsWith('$syncPrefix$device-')) mine.add(e);
    }
    final signature = _mine.join('|');
    if (_mine.isEmpty) {
      for (final f in mine) {
        try {
          await f.delete();
        } catch (_) {}
      }
      _sent = '';
      return;
    }
    if (signature == _sent && mine.isNotEmpty) return;
    final bytes = utf8.encode(jsonEncode(watchExport(_local(), _mine)));
    final zip = ZipEncoder().encode(Archive()..addFile(ArchiveFile(kBackupJsonEntry, bytes.length, bytes)));
    final now = DateTime.now();
    final target = File('${dir.path}/${syncName(device, now)}');
    final tmp = File('${target.path}.part');
    await tmp.writeAsBytes(zip, flush: true);
    await tmp.rename(target.path);
    for (final f in mine) {
      if (f.path == target.path) continue;
      try {
        await f.delete();
      } catch (_) {}
    }
    _sent = signature;
    sentAt = now;
  }
}
