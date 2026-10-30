import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceKind {
  DeviceKind._();

  static const _channel = MethodChannel('gymmane/device');

  static Future<bool> isLowEnd() async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('isLowEnd') ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> isWatch() async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('isWatch') ?? false;
    } catch (_) {
      return false;
    }
  }
}
