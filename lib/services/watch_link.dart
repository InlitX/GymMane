import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'local_store.dart';

typedef LinkMessage = Map<String, dynamic>;

Uint8List packLink(LinkMessage m) => Uint8List.fromList(gzip.encode(utf8.encode(jsonEncode(m))));

LinkMessage? unpackLink(Object? bytes) {
  if (bytes is! Uint8List || bytes.isEmpty) return null;
  try {
    final decoded = jsonDecode(utf8.decode(gzip.decode(bytes)));
    return decoded is LinkMessage ? decoded : null;
  } catch (_) {
    return null;
  }
}

class WatchLink extends ChangeNotifier with WidgetsBindingObserver {
  WatchLink._();
  static final WatchLink instance = WatchLink._();

  static const _ch = MethodChannel('gymmane/watchlink');
  static const _note = 'watchLink';

  bool onWatch = false;
  bool available = false;
  bool granted = false;
  bool enabled = false;
  bool on = false;
  bool busy = false;
  bool? lastOk;
  String peer = '';
  String _address = '';
  DateTime? at;
  bool _listening = false;
  bool _started = false;

  Future<LinkMessage> Function()? outgoing;
  Future<LinkMessage?> Function(LinkMessage message)? onRequest;
  Future<void> Function(LinkMessage reply)? onReply;
  VoidCallback? onResumed;

  bool get ready => available && granted && enabled && (onWatch || on);

  Future<void> init({required bool watch}) async {
    if (_started || kIsWeb || !Platform.isAndroid) return;
    _started = true;
    onWatch = watch;
    _load();
    _ch.setMethodCallHandler(_handle);
    WidgetsBinding.instance.addObserver(this);
    await refresh();
    await _listen();
  }

  void _load() {
    final raw = Store.instance.note(_note);
    if (raw == null || raw.isEmpty) return;
    try {
      final j = jsonDecode(raw) as Map<String, dynamic>;
      on = j['on'] == true;
      peer = j['peer'] as String? ?? '';
      _address = j['address'] as String? ?? '';
      final a = (j['at'] as num?)?.toInt();
      at = a == null ? null : DateTime.fromMillisecondsSinceEpoch(a);
    } catch (_) {}
  }

  void _save() {
    Store.instance.setNote(
        _note,
        jsonEncode({
          'on': on,
          'peer': peer,
          'address': _address,
          if (at != null) 'at': at!.millisecondsSinceEpoch,
        }));
    notifyListeners();
  }

  Future<void> refresh() async {
    try {
      final s = await _ch.invokeMapMethod<String, dynamic>('state');
      available = s?['available'] == true;
      granted = s?['granted'] == true;
      enabled = s?['enabled'] == true;
    } catch (_) {
      available = false;
    }
    notifyListeners();
  }

  Future<bool> askPermission() async {
    try {
      granted = await _ch.invokeMethod<bool>('permission') ?? false;
    } catch (_) {
      granted = false;
    }
    await refresh();
    await _listen();
    return granted;
  }

  Future<void> setOn(bool value) async {
    if (value && !granted && !await askPermission()) return;
    on = value;
    _save();
    await _listen();
    if (on) unawaited(exchange());
  }

  Future<void> openSettings() async {
    try {
      await _ch.invokeMethod<void>('settings');
    } catch (_) {}
  }

  Future<void> _listen() async {
    final want = ready && WidgetsBinding.instance.lifecycleState != AppLifecycleState.paused;
    if (want == _listening) return;
    _listening = want;
    try {
      await _ch.invokeMethod<void>('listen', {'on': want});
    } catch (_) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(() async {
        await refresh();
        await _listen();
        onResumed?.call();
      }());
    } else if (state == AppLifecycleState.paused) {
      _listening = false;
      unawaited(_ch.invokeMethod<void>('listen', {'on': false}).catchError((_) {}));
    }
  }

  void _done(String name, String address) {
    if (name.isNotEmpty) peer = name;
    if (address.isNotEmpty) _address = address;
    at = DateTime.now();
    lastOk = true;
  }

  Future<bool> exchange({bool manual = false}) async {
    final make = outgoing;
    if (make == null || busy) return false;
    await refresh();
    if (!ready) return false;
    busy = true;
    notifyListeners();
    var ok = false;
    try {
      final r = await _ch.invokeMapMethod<String, dynamic>('exchange', {
        'data': packLink(await make()),
        'last': _address,
        'toWatch': !onWatch,
      });
      final reply = unpackLink(r?['data']);
      if (reply != null) {
        await onReply?.call(reply);
        _done(r?['name'] as String? ?? '', r?['address'] as String? ?? '');
        ok = true;
      }
    } catch (e) {
      debugPrint('WatchLink: $e');
    }
    if (!ok && manual) lastOk = false;
    busy = false;
    _save();
    return ok;
  }

  Future<Object?> _handle(MethodCall call) async {
    if (call.method != 'request') return null;
    final args = call.arguments as Map?;
    final message = unpackLink(args?['data']);
    final handler = onRequest;
    if (message == null || handler == null || (!onWatch && !on)) return null;
    try {
      final reply = await handler(message);
      if (reply == null) return null;
      _done(args?['name'] as String? ?? '', args?['address'] as String? ?? '');
      _save();
      return packLink(reply);
    } catch (e) {
      debugPrint('WatchLink request: $e');
      return null;
    }
  }
}
