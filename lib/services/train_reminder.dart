import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../l10n/l10n.dart';

class TrainReminder {
  TrainReminder._();
  static final TrainReminder instance = TrainReminder._();

  static const _firstId = 1010;
  static const _slots = 14;
  static const _horizonDays = 28;

  final _plugin = FlutterLocalNotificationsPlugin();
  bool enabled = true;

  AndroidNotificationDetails get _android => AndroidNotificationDetails(
        'train_reminder',
        t.notifTrainChannel,
        channelDescription: t.notifTrainChannelWhy,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        playSound: true,
      );

  Future<void> cancel() async {
    if (!enabled) return;
    for (var i = 0; i < _slots; i++) {
      try {
        await _plugin.cancel(id: _firstId + i);
      } catch (_) {}
    }
  }

  Future<void> schedule({
    required int minuteOfDay,
    required Set<int> weekdays,
    bool skipToday = false,
  }) async {
    if (!enabled) return;
    await cancel();
    final now = DateTime.now();
    var slot = 0;
    for (var i = skipToday ? 1 : 0; i < _horizonDays && slot < _slots; i++) {
      final day = DateTime(now.year, now.month, now.day + i, minuteOfDay ~/ 60, minuteOfDay % 60);
      if (!day.isAfter(now)) continue;
      if (weekdays.isNotEmpty && !weekdays.contains(day.weekday)) continue;
      try {
        await _plugin.zonedSchedule(
          id: _firstId + slot,
          title: t.notifTrainTitle,
          body: t.notifTrainBody,
          scheduledDate: atLocal(day),
          notificationDetails: NotificationDetails(android: _android),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
        slot++;
      } catch (e) {
        debugPrint('No se pudo programar el aviso de entreno: $e');
        return;
      }
    }
  }
}

tz.TZDateTime atLocal(DateTime wallClock) {
  final utc = wallClock.toUtc();
  return tz.TZDateTime.utc(utc.year, utc.month, utc.day, utc.hour, utc.minute, utc.second);
}
