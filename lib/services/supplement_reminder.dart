import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/l10n.dart';
import 'notif_sound.dart';
import 'train_reminder.dart';

@pragma('vm:entry-point')
Future<void> supplementActionInBackground(NotificationResponse r) async {
  final payload = r.payload;
  if (r.actionId != SupplementReminder.takeAction || payload == null) return;
  final port = IsolateNameServer.lookupPortByName(SupplementReminder._portName);
  if (port != null) {
    port.send(payload);
    return;
  }
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final list = prefs.getStringList(SupplementReminder._pendingKey) ?? const [];
    await prefs.setStringList(SupplementReminder._pendingKey, [...list, payload]);
  } catch (e) {
    debugPrint('Aviso de suplementos (tomado): $e');
  }
}

class SupplementReminder {
  SupplementReminder._();
  static final SupplementReminder instance = SupplementReminder._();

  static const _firstId = 1030;
  static const _slots = 32;
  static const payloadPrefix = 'supp:';

  static const takeAction = 'supp_take';
  static const _portName = 'gymmane_supp_take';
  static const _pendingKey = 'gm_supp_taken_pending';

  void Function(List<String> ids)? onOpen;
  void Function(DateTime day, List<String> ids)? onTaken;
  ReceivePort? _port;

  void tapped(String? payload) {
    final ids = idsOf(payload);
    if (ids != null) onOpen?.call(ids);
  }

  static List<String>? idsOf(String? payload) {
    if (payload == null || !payload.startsWith(payloadPrefix)) return null;
    return payload.substring(payloadPrefix.length).split(';').first.split(',').where((e) => e.isNotEmpty).toList();
  }

  static DateTime? dayOf(String payload) {
    final parts = payload.split(';');
    if (parts.length < 2) return null;
    final ms = int.tryParse(parts[1]);
    if (ms == null) return null;
    final at = DateTime.fromMillisecondsSinceEpoch(ms);
    return DateTime(at.year, at.month, at.day);
  }

  static String payloadFor(DateTime at, List<String> ids) =>
      '$payloadPrefix${ids.join(',')};${at.millisecondsSinceEpoch}';

  void listenTaken(void Function(DateTime day, List<String> ids) handler) {
    onTaken = handler;
    if (kIsWeb || _port != null) return;
    final port = ReceivePort();
    IsolateNameServer.removePortNameMapping(_portName);
    IsolateNameServer.registerPortWithName(port.sendPort, _portName);
    port.listen((m) {
      if (m is String) _apply(m);
    });
    _port = port;
  }

  Future<void> takePending() async {
    if (kIsWeb) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final list = prefs.getStringList(_pendingKey);
      if (list == null || list.isEmpty) return;
      await prefs.remove(_pendingKey);
      list.forEach(_apply);
    } catch (e) {
      debugPrint('Aviso de suplementos (pendientes): $e');
    }
  }

  void _apply(String payload) {
    final ids = idsOf(payload);
    if (ids == null || ids.isEmpty) return;
    final now = DateTime.now();
    onTaken?.call(dayOf(payload) ?? DateTime(now.year, now.month, now.day), ids);
  }

  Future<List<String>?> launchIds() async {
    try {
      final d = await _plugin.getNotificationAppLaunchDetails();
      if (d == null || !d.didNotificationLaunchApp) return null;
      return idsOf(d.notificationResponse?.payload);
    } catch (_) {
      return null;
    }
  }

  final _plugin = FlutterLocalNotificationsPlugin();
  bool enabled = true;
  Future<void> _queue = Future.value();

  Future<void> _serial(Future<void> Function() job) =>
      _queue = _queue.then((_) => job()).catchError((Object e) => debugPrint('Aviso de suplementos: $e'));

  AndroidNotificationDetails get _android => AndroidNotificationDetails(
        NotifSound.channelOf('supplement_reminder', SoundGroup.food),
        t.notifSuppChannel,
        channelDescription: t.notifSuppChannelWhy,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        playSound: NotifSound.plays(SoundGroup.food),
        sound: NotifSound.soundOf(SoundGroup.food),
        actions: [AndroidNotificationAction(takeAction, t.notifSuppTake)],
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

  Future<void> schedule(List<({DateTime at, List<String> ids, List<String> names, List<String> doses})> due) =>
      _serial(() => _schedule(due));

  Future<void> _schedule(List<({DateTime at, List<String> ids, List<String> names, List<String> doses})> list) async {
    if (!enabled) return;
    await _cancel();
    if (list.isEmpty) return;
    final mode = await reminderMode(_plugin);
    final due = <(DateTime, String, String, String)>[
      for (final d in list)
        (
          d.at,
          t.notifSuppTitleFor(d.names.join(', ')),
          d.doses.isEmpty ? t.notifSuppTap : d.doses.join(' · '),
          payloadFor(d.at, d.ids),
        ),
    ];
    due.sort((a, b) => a.$1.compareTo(b.$1));
    var slot = 0;
    for (final (day, title, body, payload) in due.take(_slots)) {
      try {
        await _plugin.zonedSchedule(
          id: _firstId + slot,
          title: title,
          body: body,
          payload: payload,
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
