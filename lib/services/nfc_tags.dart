import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../state/fit_state.dart';

class NfcTags {
  NfcTags._();

  static const _channel = MethodChannel('gymmane/nfc');
  static final _written = StreamController<String>.broadcast();

  static bool available = false;
  static bool? _listening;

  static Stream<String> get written => _written.stream;

  static bool get _android => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<void> load() async {
    if (!_android) return;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'written' && call.arguments is String) _written.add(call.arguments as String);
    });
    available = (await state()).available;
    if (!available) return;
    _sync();
    fit.addListener(_sync);
  }

  static void _sync() {
    final on = fit.nfcTag;
    if (_listening == on) return;
    _listening = on;
    _channel.invokeMethod<void>('listen', {'on': on}).catchError((_) {});
  }

  static Future<({bool available, bool enabled})> state() async {
    if (!_android) return (available: false, enabled: false);
    try {
      final s = await _channel.invokeMapMethod<String, Object?>('state');
      return (available: s?['available'] == true, enabled: s?['enabled'] == true);
    } catch (_) {
      return (available: false, enabled: false);
    }
  }

  static Future<bool> write() async {
    try {
      return await _channel.invokeMethod<bool>('write') ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> cancel() async {
    try {
      await _channel.invokeMethod<void>('cancel');
    } catch (_) {}
  }

  static Future<void> openSettings() async {
    try {
      await _channel.invokeMethod<void>('settings');
    } catch (_) {}
  }
}
