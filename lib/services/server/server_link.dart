import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'transport_stub.dart' if (dart.library.js_interop) 'transport_web.dart' as net;

class ServerLink extends ChangeNotifier {
  ServerLink._();
  static final ServerLink instance = ServerLink._();

  bool available = false;
  bool online = true;
  int rev = 0;
  String? remoteText;
  DateTime? savedAt;

  String? _pending;
  bool _sending = false;
  Timer? _poll;
  bool _started = false;

  void Function(String text, {required bool conflict, required bool fromPhone})? onRemote;

  bool get busy => _sending || _pending != null;

  Future<void> connect() async {
    if (!kIsWeb || !net.transportAvailable) return;
    final r = await net.send('GET', 'api/state');
    if (r.status == 204 || (r.ok && (r.headers['content-type'] ?? '').contains('json'))) {
      available = true;
      rev = int.tryParse(r.headers['x-gymmane-rev'] ?? '') ?? 0;
      remoteText = r.status == 204 ? null : utf8.decode(r.bytes ?? Uint8List(0));
    }
  }

  void start() {
    if (!available || _started) return;
    _started = true;
    _poll = Timer.periodic(const Duration(seconds: 20), (_) => check());
    net.onPageVisible(check);
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  void push(String text) {
    if (!available || text == remoteText) return;
    _pending = text;
    if (!_sending) unawaited(_drain());
  }

  void _setOnline(bool v) {
    if (online == v) return;
    online = v;
    notifyListeners();
  }

  Future<void> _drain() async {
    _sending = true;
    var wait = 2;
    try {
      while (_pending != null) {
        final text = _pending!;
        _pending = null;
        final r = await net.send('PUT', 'api/state',
            body: Uint8List.fromList(utf8.encode(text)),
            headers: {'content-type': 'application/json', 'x-gymmane-base-rev': '$rev'});
        if (r.ok) {
          _setOnline(true);
          wait = 2;
          try {
            rev = (jsonDecode(utf8.decode(r.bytes!))['rev'] as num).toInt();
          } catch (_) {}
          remoteText = text;
          savedAt = DateTime.now();
          continue;
        }
        if (r.status == 409) {
          _setOnline(true);
          _pending = null;
          await _pull(conflict: true);
          break;
        }
        _setOnline(false);
        _pending ??= text;
        await Future<void>.delayed(Duration(seconds: wait));
        wait = wait >= 30 ? 30 : wait * 2;
      }
    } finally {
      _sending = false;
    }
  }

  Future<void> check() async {
    if (!available || busy) return;
    final r = await net.send('GET', 'api/rev');
    if (!r.ok) {
      _setOnline(false);
      return;
    }
    _setOnline(true);
    try {
      final remote = (jsonDecode(utf8.decode(r.bytes!))['rev'] as num).toInt();
      if (remote > rev) await _pull();
    } catch (_) {}
  }

  Future<void> _pull({bool conflict = false}) async {
    final r = await net.send('GET', 'api/state');
    if (!r.ok || r.bytes == null) return;
    rev = int.tryParse(r.headers['x-gymmane-rev'] ?? '') ?? rev;
    final text = utf8.decode(r.bytes!);
    remoteText = text;
    onRemote?.call(text, conflict: conflict, fromPhone: r.headers['x-gymmane-source'] == 'phone');
  }

  Future<Map<String, dynamic>?> _json(String method, String path) async {
    final r = await net.send(method, path);
    if (!r.ok || r.bytes == null) return null;
    try {
      final v = jsonDecode(utf8.decode(r.bytes!));
      return v is Map<String, dynamic> ? v : null;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> info() => available ? _json('GET', 'api/info') : Future.value(null);

  Future<Map<String, dynamic>?> scanPhone() async {
    if (!available) return null;
    final r = await _json('POST', 'api/sync/scan');
    if (r?['imported'] == true) await check();
    return r;
  }

  Future<Map<String, dynamic>?> exportForPhone() => available ? _json('POST', 'api/sync/export') : Future.value(null);

  String mediaUrl(String name) => net.mediaUrl(name);

  Future<bool> putMedia(String name, Uint8List bytes) async {
    if (!available) return false;
    final r = await net.send('PUT', 'api/media/${Uri.encodeComponent(name)}',
        body: bytes, headers: {'content-type': 'application/octet-stream'});
    return r.ok;
  }

  Future<Uint8List?> getMedia(String name) async {
    if (!available) return null;
    final r = await net.send('GET', 'api/media/${Uri.encodeComponent(name)}');
    return r.ok ? r.bytes : null;
  }

  Future<Uint8List?> fetchBytes(String url) async {
    final r = await net.send('GET', url);
    return r.ok ? r.bytes : null;
  }

  Future<void> deleteMedia(String name) async {
    if (!available) return;
    await net.send('DELETE', 'api/media/${Uri.encodeComponent(name)}');
  }
}
