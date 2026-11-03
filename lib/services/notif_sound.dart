import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum SoundGroup { train, food, other }

class NotifSound {
  NotifSound._();

  static const silent = 'silent';
  static const _channel = MethodChannel('gymmane/device');

  static final Map<SoundGroup, String> uris = {};

  static String uriOf(SoundGroup g) => uris[g] ?? '';

  static bool plays(SoundGroup g) => uriOf(g) != silent;

  static AndroidNotificationSound? soundOf(SoundGroup g) {
    final u = uriOf(g);
    return u.isEmpty || u == silent ? null : UriAndroidNotificationSound(u);
  }

  static String channelOf(String base, SoundGroup g) {
    final u = uriOf(g);
    if (u.isEmpty) return base;
    if (u == silent) return '${base}_silent';
    var h = 0x811c9dc5;
    for (final c in u.codeUnits) {
      h = ((h ^ c) * 0x01000193) & 0xffffffff;
    }
    return '${base}_${h.toRadixString(36)}';
  }

  static Future<({String uri, String name})?> pick(String current) async {
    if (kIsWeb || !Platform.isAndroid) return null;
    try {
      final r = await _channel.invokeMapMethod<String, String>('pickSound', {'current': current});
      final uri = r?['uri'] ?? '';
      if (uri.isEmpty) return null;
      return (uri: uri, name: r?['name'] ?? '');
    } catch (_) {
      return null;
    }
  }

  static const _sounds = MethodChannel('gymmane/sounds');
  static List<({String uri, String name})>? _list;

  static Future<List<({String uri, String name})>> phoneSounds() async {
    if (_list case final cached?) return cached;
    if (kIsWeb || !Platform.isAndroid) return const [];
    try {
      final raw = await _sounds.invokeListMethod<Map>('list') ?? const [];
      return _list = [
        for (final m in raw) (uri: '${m['uri'] ?? ''}', name: '${m['title'] ?? ''}'),
      ];
    } catch (_) {
      return const [];
    }
  }

  static Future<void> preview(String uri) async {
    if (kIsWeb || !Platform.isAndroid) return;
    try {
      await _sounds.invokeMethod('play', {'uri': uri});
    } catch (_) {}
  }

  static Future<void> stopPreview() async {
    if (kIsWeb || !Platform.isAndroid) return;
    try {
      await _sounds.invokeMethod('stop');
    } catch (_) {}
  }

  static Future<void> dropOld(List<String> bases, Set<String> keep) async {
    if (kIsWeb || !Platform.isAndroid) return;
    try {
      final android = FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      final channels = await android?.getNotificationChannels() ?? const [];
      for (final c in channels) {
        if (keep.contains(c.id)) continue;
        if (bases.any((b) => c.id == b || c.id.startsWith('${b}_'))) {
          await android?.deleteNotificationChannel(channelId: c.id);
        }
      }
    } catch (_) {}
  }
}
