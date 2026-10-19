import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../l10n/l10n.dart';
import 'train_reminder.dart';

class SupplementReminder {
  SupplementReminder._();
  static final SupplementReminder instance = SupplementReminder._();

  static const _firstId = 1030;
  static const _slots = 32;

  final _plugin = FlutterLocalNotificationsPlugin();
  bool enabled = true;
  Future<void> _queue = Future.value();

  Future<void> _serial(Future<void> Function() job) =>
      _queue = _queue.then((_) => job()).catchError((Object e) => debugPrint('Aviso de suplementos: $e'));

  AndroidNotificationDetails get _android => AndroidNotificationDetails(
    'supplement_reminder',
    t.notifSuppChannel,
    channelDescription: t.notifSuppChannelWhy,
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
      } catch (_) {}
    }
  }

  Future<void> schedule(List<({DateTime at, List<String> names, List<String> doses})> due) =>
      _serial(() => _schedule(due));

  Future<void> _schedule(List<({DateTime at, List<String> names, List<String> doses})> list) async {
    if (!enabled) return;
    await _cancel();
    if (list.isEmpty) return;
    final mode = await reminderMode(_plugin);
    final due = <(DateTime, String, String)>[
      for (final d in list)
        (
          d.at,
          t.notifSuppTitleFor(d.names.join(', ')),
          d.doses.isEmpty ? t.notifSuppTap : d.doses.join(' · '),
        ),
    ];
    due.sort((a, b) => a.$1.compareTo(b.$1));
    var slot = 0;
    for (final (day, title, body) in due.take(_slots)) {
      try {
        await _plugin.zonedSchedule(
          id: _firstId + slot,
          title: title,
          body: body,
          scheduledDate: atLocal(day),
          notificationDetails: NotificationDetails(android: _android, iOS: _darwin),
          androidScheduleMode: mode,
        );
        slot++;
      } catch (e) {
        debugPrint('No se pudo programar el aviso de suplementos: $e');
        return;
      }
    }
  }
}
