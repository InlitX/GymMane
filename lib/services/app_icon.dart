import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppIconStyle {
  const AppIconStyle(this.id, this.design);

  final String id;
  final bool design;

  String get asset => 'assets/icon/variants/$id.webp';
}

class AppIcon {
  AppIcon._();

  static const _channel = MethodChannel('gymmane/app_icon');

  static const styles = [
    AppIconStyle('default', false),
    AppIconStyle('light', false),
    AppIconStyle('sand', false),
    AppIconStyle('graphite', false),
    AppIconStyle('sage', false),
    AppIconStyle('night', false),
    AppIconStyle('material', true),
    AppIconStyle('medal', true),
    AppIconStyle('glass', true),
    AppIconStyle('stopwatch', true),
    AppIconStyle('marble', true),
  ];

  static final current = ValueNotifier<String>('default');
  static bool available = false;

  static AppIconStyle get style => styles.firstWhere((s) => s.id == current.value, orElse: () => styles.first);

  static Future<void> load() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    try {
      current.value = await _channel.invokeMethod<String>('current') ?? 'default';
      available = true;
    } catch (_) {
      available = false;
    }
  }

  static Future<bool> set(String id) async {
    if (!available || id == current.value) return false;
    final before = current.value;
    current.value = id;
    try {
      final ok = await _channel.invokeMethod<bool>('set', {'name': id}) ?? false;
      if (!ok) current.value = before;
      return ok;
    } catch (_) {
      current.value = before;
      return false;
    }
  }
}
