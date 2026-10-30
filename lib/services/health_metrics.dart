import 'dart:io';

import 'package:flutter/services.dart';

enum HealthGroup { heart, vitals, sleep, activity }

enum HealthMetric {
  restingHr(HealthGroup.heart),
  heartRate(HealthGroup.heart),
  hrv(HealthGroup.heart),
  spo2(HealthGroup.vitals),
  respiration(HealthGroup.vitals),
  bloodPressure(HealthGroup.vitals),
  temperature(HealthGroup.vitals),
  sleep(HealthGroup.sleep),
  distance(HealthGroup.activity),
  floors(HealthGroup.activity),
  elevation(HealthGroup.activity),
  activeKcal(HealthGroup.activity);

  const HealthMetric(this.group);

  final HealthGroup group;

  bool get daily => switch (this) {
        restingHr || heartRate || distance || floors || elevation || activeKcal => true,
        _ => false,
      };

  bool get summed => switch (this) {
        sleep || distance || floors || elevation || activeKcal => true,
        _ => false,
      };
}

class HealthMetrics {
  const HealthMetrics._();

  static const _channel = MethodChannel('gymmane/health');

  static Future<Set<HealthMetric>> granted() async {
    if (!Platform.isAndroid) return {};
    try {
      final keys = await _channel.invokeListMethod<String>('metricsGranted') ?? const [];
      final byName = HealthMetric.values.asNameMap();
      return {for (final k in keys) ?byName[k]};
    } on PlatformException {
      return {};
    } on MissingPluginException {
      return {};
    }
  }

  static Future<bool> request(Iterable<HealthMetric> metrics) async {
    if (!Platform.isAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('requestMetrics', {
            'metrics': [for (final m in metrics) m.name],
          }) ??
          false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<List<List<double>>?> read(HealthMetric metric, DateTime from, DateTime to) async {
    if (!Platform.isAndroid) return null;
    try {
      final rows = await _channel.invokeListMethod<Object?>('readMetric', {
        'metric': metric.name,
        'from': from.millisecondsSinceEpoch,
        'to': to.millisecondsSinceEpoch,
      });
      if (rows == null) return null;
      return [
        for (final r in rows)
          if (r is List && r.length >= 2) [for (final v in r) (v as num).toDouble()],
      ];
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  static Map<String, List<double>> byDay(HealthMetric metric, List<List<double>> rows) {
    final sums = <String, List<double>>{};
    final counts = <String, int>{};
    for (final r in rows) {
      final t = DateTime.fromMillisecondsSinceEpoch(r[0].round());
      final key = dayKey(t);
      final values = r.sublist(1);
      final acc = sums[key];
      if (acc == null) {
        sums[key] = [...values];
      } else {
        for (var i = 0; i < acc.length && i < values.length; i++) {
          acc[i] += values[i];
        }
      }
      counts[key] = (counts[key] ?? 0) + 1;
    }
    if (metric.daily || metric.summed) return sums;
    return {
      for (final e in sums.entries) e.key: [for (final v in e.value) v / counts[e.key]!],
    };
  }

  static String dayKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
