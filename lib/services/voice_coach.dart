import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class VoiceCoach {
  VoiceCoach._();

  static const _channel = MethodChannel('gymmane/voice');
  static bool enabled = true;

  static Future<void> say(String text, String lang) async {
    if (!enabled || kIsWeb || !(Platform.isAndroid || Platform.isIOS) || text.trim().isEmpty) return;
    try {
      await _channel.invokeMethod('say', {'text': text, 'lang': lang});
    } catch (_) {}
  }

  static Future<void> sayAndWait(String text, String lang) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS) || text.trim().isEmpty) return;
    try {
      await _channel.invokeMethod('sayWait', {'text': text, 'lang': lang});
    } catch (_) {}
  }

  static Future<void> stop() async {
    if (!enabled || kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    try {
      await _channel.invokeMethod('stop');
    } catch (_) {}
  }

  static Future<String> check(String lang) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return 'noEngine';
    try {
      return await _channel.invokeMethod<String>('check', {'lang': lang}) ?? 'noEngine';
    } catch (_) {
      return 'noEngine';
    }
  }

  static Future<void> openSettings() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    try {
      await _channel.invokeMethod('settings');
    } catch (_) {}
  }
}
