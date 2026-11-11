import 'dart:math' as math;

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'host.dart';

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
    if (!onAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('takeUsage') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<HealthAccess> access() async {
    if (!onMobile) return HealthAccess.unsupported;
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
    if (!onMobile) return false;
    try {
      return await _channel.invokeMethod<bool>('request') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<bool> openSettings() async {
    if (!onMobile) return false;
    try {
      return await _channel.invokeMethod<bool>('openSettings') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<Map<DateTime, int>?> read(List<DateTime> days) async {
    if (days.isEmpty || !onMobile) return null;
    final cutoff = onIOS ? DateTime.now() : null;
    final ranges = [for (final day in days) stepQueryRange(day, cutoff: cutoff)];
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

  @visibleForTesting
  static List<int> stepQueryRange(DateTime day, {DateTime? cutoff}) {
    final start = DateTime(day.year, day.month, day.day).millisecondsSinceEpoch;
    final end = DateTime(day.year, day.month, day.day + 1).millisecondsSinceEpoch;
    return [
      start,
      if (cutoff == null) end else math.max(start + 1, math.min(end, cutoff.millisecondsSinceEpoch)),
    ];
  }
}
