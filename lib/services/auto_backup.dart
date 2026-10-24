import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../state/fit_state.dart';
import 'backup_zip.dart';
import 'local_store.dart';

enum AutoBackupMode { off, workout, daily, weekly }

class AutoBackup extends ChangeNotifier {
  AutoBackup._();
  static final AutoBackup instance = AutoBackup._();

  static const _channel = MethodChannel('gymmane/backup');
  static const _key = 'autoBackup';
  static const prefix = 'gymmane-auto-';
  static const keepOptions = [1, 3, 5, 10, 20];

  bool get supported => !kIsWeb && Platform.isAndroid;

  AutoBackupMode mode = AutoBackupMode.off;
  String folderUri = '';
  String folderName = '';
  int keep = 5;
  DateTime? lastAt;
  int _lastCrc = 0;
  bool failed = false;
  bool running = false;
  int _seenSessions = -1;
  Timer? _afterWorkout;

  bool get hasFolder => folderUri.isNotEmpty;

  void init() {
    _load();
    if (!supported) return;
    _seenSessions = fit.sessions.length;
    fit.addListener(_onFit);
    unawaited(_checkFolder());
    Timer(const Duration(seconds: 8), onLeave);
  }

  void _load() {
    final raw = Store.instance.note(_key);
    if (raw == null || raw.isEmpty) return;
    try {
      final j = jsonDecode(raw) as Map<String, dynamic>;
      mode = AutoBackupMode.values.asNameMap()[j['mode']] ?? AutoBackupMode.off;
      folderUri = j['uri'] as String? ?? '';
      folderName = j['name'] as String? ?? '';
      final k = (j['keep'] as num?)?.toInt() ?? 5;
      keep = keepOptions.contains(k) ? k : 5;
      final at = (j['at'] as num?)?.toInt();
      lastAt = at == null ? null : DateTime.fromMillisecondsSinceEpoch(at);
      _lastCrc = (j['crc'] as num?)?.toInt() ?? 0;
      failed = j['failed'] as bool? ?? false;
    } catch (_) {}
  }

  void _save() {
    Store.instance.setNote(
        _key,
        jsonEncode({
          'mode': mode.name,
          'uri': folderUri,
          'name': folderName,
          'keep': keep,
          if (lastAt != null) 'at': lastAt!.millisecondsSinceEpoch,
          'crc': _lastCrc,
          if (failed) 'failed': true,
        }));
    notifyListeners();
  }

  Future<void> _checkFolder() async {
    if (!hasFolder) return;
    try {
      final ok = await _channel.invokeMethod<bool>('check', {'uri': folderUri}) ?? false;
      if (!ok && !failed) {
        failed = true;
        _save();
      }
    } catch (_) {}
  }

  Future<bool> pickFolder() async {
    try {
      final picked = await _channel.invokeMapMethod<String, dynamic>('pick');
      if (picked == null) return false;
      folderUri = picked['uri'] as String? ?? '';
      folderName = picked['name'] as String? ?? '';
      failed = false;
      _lastCrc = 0;
      _save();
      return hasFolder;
    } catch (_) {
      return false;
    }
  }

  void setMode(AutoBackupMode m) {
    mode = m;
    _save();
  }

  void setKeep(int k) {
    if (!keepOptions.contains(k)) return;
    keep = k;
    _save();
  }

  void _onFit() {
    final count = fit.sessions.length;
    final grew = _seenSessions >= 0 && count > _seenSessions;
    _seenSessions = count;
    if (!grew || mode != AutoBackupMode.workout) return;
    _afterWorkout?.cancel();
    _afterWorkout = Timer(const Duration(seconds: 3), () => unawaited(run()));
  }

  bool get due {
    if (!hasFolder) return false;
    final last = lastAt;
    final now = DateTime.now();
    return switch (mode) {
      AutoBackupMode.off || AutoBackupMode.workout => false,
      AutoBackupMode.daily => last == null || DateTime(last.year, last.month, last.day) != DateTime(now.year, now.month, now.day),
      AutoBackupMode.weekly => last == null || now.difference(last) >= const Duration(days: 7),
    };
  }

  void onLeave() {
    if (supported && due) unawaited(run());
  }

  Future<bool> run({bool force = false}) async {
    if (!supported || !hasFolder || running) return false;
    running = true;
    notifyListeners();
    var ok = false;
    try {
      ok = await _write(force);
    } catch (e) {
      debugPrint('AutoBackup failed: $e');
    }
    running = false;
    failed = !ok;
    _save();
    return ok;
  }

  Future<bool> _write(bool force) async {
    fit.persistNow();
    final crc = getCrc32(utf8.encode(jsonEncode(Store.finite(fit.toJson()))));
    if (!force && crc == _lastCrc && lastAt != null) {
      lastAt = DateTime.now();
      return true;
    }
    final zip = await buildBackupZip();
    if (!isValidBackupZip(zip)) return false;
    final now = DateTime.now();
    final name = '$prefix${_stamp(now)}.zip';
    final tmp = File('${(await getTemporaryDirectory()).path}/$name');
    await tmp.writeAsBytes(zip, flush: true);
    try {
      final saved = await _channel.invokeMethod<bool>('write', {
            'uri': folderUri,
            'path': tmp.path,
            'name': name,
            'prefix': prefix,
            'keep': keep,
          }) ??
          false;
      if (!saved) return false;
    } finally {
      try {
        await tmp.delete();
      } catch (_) {}
    }
    lastAt = now;
    _lastCrc = crc;
    return true;
  }

  static String _two(int n) => n.toString().padLeft(2, '0');

  static String _stamp(DateTime d) =>
      '${d.year}-${_two(d.month)}-${_two(d.day)}-${_two(d.hour)}${_two(d.minute)}${_two(d.second)}';
}
