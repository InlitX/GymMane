import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../l10n/l10n.dart';

class TrainReminder {
  TrainReminder._();
  static final TrainReminder instance = TrainReminder._();

  static const _firstId = 1010;
  static const _againId = 1100;
  static const _slots = 14;
  static const _horizonDays = 28;

  final _plugin = FlutterLocalNotificationsPlugin();
  bool enabled = true;
  Future<void> _queue = Future.value();

  Future<void> _serial(Future<void> Function() job) =>
      _queue = _queue.then((_) => job()).catchError((Object e) => debugPrint('Aviso de entreno: $e'));

  AndroidNotificationDetails get _android => AndroidNotificationDetails(
        'train_reminder',
        t.notifTrainChannel,
        channelDescription: t.notifTrainChannelWhy,
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

  Future<void> cancel() => _serial(_cancel);

  Future<void> _cancel() async {
    if (!enabled) return;
    for (var i = 0; i < _slots; i++) {
      try {
        await _plugin.cancel(id: _firstId + i);
        await _plugin.cancel(id: _againId + i);
      } catch (_) {}
    }
  }

  Future<void> schedule({
    required int minuteOfDay,
    required Set<int> weekdays,
    bool skipToday = false,
    int againMinutes = 0,
    bool Function(DateTime day)? restOn,
  }) =>
      _serial(() => _schedule(minuteOfDay, weekdays, skipToday, againMinutes, restOn));

  Future<void> _schedule(
      int minuteOfDay, Set<int> weekdays, bool skipToday, int againMinutes, bool Function(DateTime day)? restOn) async {
    if (!enabled) return;
    await _cancel();
    final mode = await reminderMode(_plugin);
    final now = DateTime.now();
    var slot = 0;
    for (var i = skipToday ? 1 : 0; i < _horizonDays && slot < _slots; i++) {
      final day = DateTime(now.year, now.month, now.day + i, minuteOfDay ~/ 60, minuteOfDay % 60);
      final again = againMinutes > 0 && minuteOfDay + againMinutes < 24 * 60
          ? day.add(Duration(minutes: againMinutes))
          : null;
      if (!day.isAfter(now) && !(again?.isAfter(now) ?? false)) continue;
      if (weekdays.isNotEmpty && !weekdays.contains(day.weekday)) continue;
      if (restOn?.call(day) ?? false) continue;
      try {
        if (again != null && again.isAfter(now)) {
          await _plugin.zonedSchedule(
            id: _againId + slot,
            title: t.notifTrainTitle,
            body: t.notifTrainAgainBody,
            scheduledDate: atLocal(again),
            notificationDetails: NotificationDetails(android: _android, iOS: _darwin),
            androidScheduleMode: mode,
          );
        }
        if (!day.isAfter(now)) {
          slot++;
          continue;
        }
        await _plugin.zonedSchedule(
          id: _firstId + slot,
          title: t.notifTrainTitle,
          body: t.notifTrainBody,
          scheduledDate: atLocal(day),
          notificationDetails: NotificationDetails(android: _android, iOS: _darwin),
          androidScheduleMode: mode,
        );
        slot++;
      } catch (e) {
        debugPrint('No se pudo programar el aviso de entreno: $e');
        return;
      }
    }
  }
}

Future<AndroidScheduleMode> reminderMode(FlutterLocalNotificationsPlugin plugin) async {
  try {
    final android = plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (await android?.canScheduleExactNotifications() ?? false) return AndroidScheduleMode.exactAllowWhileIdle;
  } catch (_) {}
  return AndroidScheduleMode.inexactAllowWhileIdle;
}

tz.TZDateTime atLocal(DateTime wallClock) {
  final utc = wallClock.toUtc();
  return tz.TZDateTime.utc(utc.year, utc.month, utc.day, utc.hour, utc.minute, utc.second);
}
