import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CommunityApps {
  CommunityApps._();

  static const _channel = MethodChannel('gymmane/device');
  static const scannerPackage = 'de.gymmane.scanner';
  static const scannerPage = 'https://github.com/KingMezzo/GymMane-Scanner/releases/latest';

  static const scannerListed = true;

  static bool get canScan => scannerListed && !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<bool> openScanner() async {
    if (!canScan) return false;
    try {
      return await _channel.invokeMethod<bool>('openApp', {'package': scannerPackage}) ?? false;
    } catch (_) {
      return false;
    }
  }
}
