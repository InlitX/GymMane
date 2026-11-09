import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Headphones {
  Headphones._();

  static const _channel = MethodChannel('gymmane/device');

  static Future<bool> connected() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return false;
    try {
      return await _channel.invokeMethod<bool>('headphones') ?? false;
    } catch (_) {
      return false;
    }
  }
}
