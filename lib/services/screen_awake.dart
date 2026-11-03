import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ScreenAwake {
  ScreenAwake._();

  static const _channel = MethodChannel('gymmane/screen');
  static bool? _last;
  static bool? _dimmed;

  static Future<void> dim(bool on) async {
    if (kIsWeb || _dimmed == on) return;
    _dimmed = on;
    try {
      await _channel.invokeMethod<void>('dim', {'on': on});
    } catch (e) {
      _dimmed = null;
      debugPrint('ScreenAwake no disponible: $e');
    }
  }

  static Future<void> bright(bool on) async {
    if (kIsWeb) return;
    try {
      await _channel.invokeMethod<void>('bright', {'on': on});
    } catch (e) {
      debugPrint('ScreenAwake no disponible: $e');
    }
  }

  static Future<void> keepOn(bool on) async {
    if (kIsWeb || _last == on) return;
    _last = on;
    try {
      await _channel.invokeMethod<void>('keepOn', {'on': on});
    } catch (e) {
      _last = null;
      debugPrint('ScreenAwake no disponible: $e');
    }
  }
}
