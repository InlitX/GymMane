import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../l10n/l10n.dart';
import 'train_reminder.dart';

class ProgressReminder {
  ProgressReminder._();
  static final ProgressReminder instance = ProgressReminder._();

  static const _id = 1002;
  static const _measureId = 1003;

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

  DarwinNotificationDetails get _darwin => const DarwinNotificationDetails(
        presentAlert: true,
        presentBanner: true,
        presentList: true,
        presentSound: true,
      );

  Future<void> scheduleFor(DateTime day, int intervalDays) async {
    if (!enabled) return;
    await cancel();
    if (intervalDays <= 0) return;

    try {
      final when = atLocal(DateTime(day.year, day.month, day.day, 10));
      if (!when.isAfter(tz.TZDateTime.now(tz.local))) return;
      await _plugin.zonedSchedule(
        id: _id,
        title: t.notifPhotoTitle,
        body: t.notifPhotoBody(intervalDays),
        scheduledDate: when,
        notificationDetails: NotificationDetails(android: _android, iOS: _darwin),
        androidScheduleMode: await reminderMode(_plugin),
      );
    } catch (e) {
      debugPrint('No se pudo programar el recordatorio de fotos: $e');
    }
  }

  Future<void> scheduleMeasure(DateTime day, int intervalDays) async {
    if (!enabled) return;
    await cancelMeasure();
    if (intervalDays <= 0) return;
    try {
      final when = atLocal(DateTime(day.year, day.month, day.day, 10, 30));
      if (!when.isAfter(tz.TZDateTime.now(tz.local))) return;
      await _plugin.zonedSchedule(
        id: _measureId,
        title: t.notifMeasureTitle,
        body: t.notifMeasureBody(intervalDays),
        scheduledDate: when,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'measures',
            t.notifMeasureChannel,
            channelDescription: t.notifMeasureChannelWhy,
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            playSound: true,
          ),
          iOS: _darwin,
        ),
        androidScheduleMode: await reminderMode(_plugin),
      );
    } catch (e) {
      debugPrint('No se pudo programar el recordatorio de medidas: $e');
    }
  }

  static const _fastId = 1004;
  static const _fastDoneId = 1005;

  AndroidNotificationDetails _fastAndroid({required bool live, DateTime? end}) => AndroidNotificationDetails(
        live ? 'fasting_live' : 'fasting',
        live ? t.notifFastLiveChannel : t.notifFastChannel,
        channelDescription: live ? t.notifFastLiveChannelWhy : t.notifFastChannelWhy,
        importance: live ? Importance.low : Importance.defaultImportance,
        priority: live ? Priority.low : Priority.defaultPriority,
        playSound: !live,
        enableVibration: !live,
        ongoing: live,
        autoCancel: !live,
        onlyAlertOnce: live,
        showWhen: live,
        when: live ? end?.millisecondsSinceEpoch : null,
        usesChronometer: live,
        chronometerCountDown: live,
        category: live ? AndroidNotificationCategory.stopwatch : AndroidNotificationCategory.reminder,
      );

  Future<void> showFast(DateTime start, DateTime end) async {
    if (!enabled) return;
    await cancelFast();
    try {
      if (end.isAfter(DateTime.now())) {
        await _plugin.show(
          id: _fastId,
          title: t.notifFastLiveTitle,
          body: t.notifFastLiveBody(t.clockTime(end)),
          notificationDetails: NotificationDetails(android: _fastAndroid(live: true, end: end)),
        );
        await _plugin.zonedSchedule(
          id: _fastDoneId,
          title: t.notifFastDoneTitle,
          body: t.notifFastDoneBody(end.difference(start).inHours),
          scheduledDate: tz.TZDateTime.from(end, tz.local),
          notificationDetails: NotificationDetails(android: _fastAndroid(live: false), iOS: _darwin),
          androidScheduleMode: await reminderMode(_plugin),
        );
      }
    } catch (e) {
      debugPrint('No se pudo programar el aviso del ayuno: $e');
    }
  }

  Future<void> cancelFast() async {
    if (!enabled) return;
    try {
      await _plugin.cancel(id: _fastId);
      await _plugin.cancel(id: _fastDoneId);
    } catch (_) {}
  }

  Future<void> cancelMeasure() async {
    if (!enabled) return;
    try {
      await _plugin.cancel(id: _measureId);
    } catch (_) {}
  }

  Future<void> cancel() async {
    if (!enabled) return;
    try {
      await _plugin.cancel(id: _id);
    } catch (_) {}
  }
}
