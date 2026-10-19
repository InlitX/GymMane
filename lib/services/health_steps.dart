import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/services.dart';

enum HealthAccess { unsupported, denied, granted }

class HealthSteps {
  const HealthSteps._();

  static const _channel = MethodChannel('gymmane/health');

  static void listen(void Function() onUsage) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'usage') onUsage();
    });
  }

  static Future<bool> takeUsage() async {
    if (!Platform.isAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('takeUsage') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<HealthAccess> access() async {
    if (!Platform.isAndroid) return HealthAccess.unsupported;
    try {
      final status = await _channel.invokeMethod<String>('status');
      return HealthAccess.values.asNameMap()[status] ?? HealthAccess.unsupported;
    } on PlatformException {
      return HealthAccess.unsupported;
    } on MissingPluginException {
      return HealthAccess.unsupported;
    }
  }

  static Future<bool> request() async {
    if (!Platform.isAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('request') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<bool> openSettings() async {
    if (!Platform.isAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('openSettings') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<Map<DateTime, int>?> read(List<DateTime> days) async {
    if (days.isEmpty || !Platform.isAndroid) return null;
    final now = DateTime.now().millisecondsSinceEpoch;
    final ranges = [
      for (final day in days)
        [
          _start(day),
          math.max(_start(day) + 1, math.min(_start(DateTime(day.year, day.month, day.day + 1)), now)),
        ],
    ];
    try {
      final counts = await _channel.invokeListMethod<int>('readSteps', {'ranges': ranges});
      if (counts == null || counts.length != days.length) return null;
      return {for (var i = 0; i < days.length; i++) days[i]: counts[i]};
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  static int _start(DateTime day) => DateTime(day.year, day.month, day.day).millisecondsSinceEpoch;
}
