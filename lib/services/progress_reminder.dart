import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../l10n/l10n.dart';

class ProgressReminder {
  ProgressReminder._();
  static final ProgressReminder instance = ProgressReminder._();

  static const _id = 1002;

  final _plugin = FlutterLocalNotificationsPlugin();
  bool enabled = true;

  AndroidNotificationDetails get _android => AndroidNotificationDetails(
        'progress_photo',
        t.notifPhotoChannel,
        channelDescription: t.notifPhotoChannelWhy,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        playSound: true,
      );

  Future<void> scheduleFor(DateTime day, int intervalDays) async {
    if (!enabled) return;
    await cancel();
    if (intervalDays <= 0) return;

    try {
      final when = tz.TZDateTime(tz.local, day.year, day.month, day.day, 10);
      if (!when.isAfter(tz.TZDateTime.now(tz.local))) return;
      await _plugin.zonedSchedule(
        id: _id,
        title: t.notifPhotoTitle,
        body: t.notifPhotoBody(intervalDays),
        scheduledDate: when,
        notificationDetails: NotificationDetails(android: _android),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint('No se pudo programar el recordatorio de fotos: $e');
    }
  }

  Future<void> cancel() async {
    if (!enabled) return;
    try {
      await _plugin.cancel(id: _id);
    } catch (_) {}
  }
}
