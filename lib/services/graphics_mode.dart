import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class GraphicsMode {
  GraphicsMode._();

  static const _channel = MethodChannel('gymmane/graphics');

  static bool available = false;
  static bool compat = false;
  static bool detected = false;

  static Future<void> load() async {
    if (kIsWeb || !Platform.isAndroid) return;
    try {
      final state = await _channel.invokeMapMethod<String, Object?>('state');
      if (state == null) return;
      compat = state['compat'] == true;
      detected = state['detected'] == true;
      available = true;
    } catch (_) {
      available = false;
    }
  }

  static Future<void> restartWith(bool on) async {
    try {
      await _channel.invokeMethod<void>('set', {'compat': on});
    } catch (_) {}
  }
}
