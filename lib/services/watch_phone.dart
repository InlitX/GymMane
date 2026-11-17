import 'dart:async';
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';

import '../state/fit_state.dart';
import '../wear/wear_sync.dart';
import 'backup_zip.dart';
import 'local_store.dart';
import 'watch_link.dart';

class WatchPhone {
  WatchPhone._();

  static Future<void> init() async {
    final link = WatchLink.instance
      ..outgoing = _state
      ..onRequest = _fromWatch
      ..onReply = _merge
      ..onResumed = () => unawaited(WatchLink.instance.exchange());
    await link.init(watch: false);
    if (link.ready) unawaited(link.exchange());
  }

  static Future<LinkMessage> _state() async {
    fit.persistNow();
    final local = jsonDecode(jsonEncode(Store.finite(fit.toJson()))) as Map<String, dynamic>;
    return {'role': 'phone', 'state': slimForWatch(local)};
  }

  static Future<LinkMessage?> _fromWatch(LinkMessage m) async {
    if (m['role'] != 'watch') return null;
    await _merge(m);
    return _state();
  }

  static Future<void> _merge(LinkMessage m) async {
    final sessions = m['sessions'];
    if (m['role'] != 'watch' || sessions is! List || sessions.isEmpty || fit.isSessionActive) return;
    final known = {for (final s in fit.sessions) s.date.toIso8601String()};
    if (sessions.every((s) => known.contains(sessionKey(s)))) return;
    final bytes = utf8.encode(jsonEncode({'sessions': sessions}));
    final zip = ZipEncoder().encode(Archive()..addFile(ArchiveFile(kBackupJsonEntry, bytes.length, bytes)));
    try {
      await mergeBackupZip(Uint8List.fromList(zip), incomingNewer: false);
    } catch (e) {
      debugPrint('WatchPhone merge: $e');
    }
  }
}
