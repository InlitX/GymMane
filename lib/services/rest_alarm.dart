import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../l10n/l10n.dart';

class RestAlarm {
  RestAlarm._();
  static final RestAlarm instance = RestAlarm._();

  static const _id = 1001;
  AndroidNotificationDetails get _android => AndroidNotificationDetails(
    'rest_timer',
    t.notifRestChannel,
    channelDescription: t.notifRestChannelWhy,
    importance: Importance.max,
    priority: Priority.high,
    category: AndroidNotificationCategory.alarm,
    playSound: true,
    enableVibration: true,
    audioAttributesUsage: AudioAttributesUsage.alarm,
    fullScreenIntent: true,
    visibility: NotificationVisibility.public,
  );

  AndroidNotificationDetails get _androidAlert => AndroidNotificationDetails(
    'rest_timer_alert',
    t.notifAlertChannel,
    channelDescription: t.notifAlertChannelWhy,
    importance: Importance.max,
    priority: Priority.high,
    category: AndroidNotificationCategory.alarm,
    playSound: false,
    enableVibration: false,
    visibility: NotificationVisibility.public,
  );

  final _plugin = FlutterLocalNotificationsPlugin();

  AudioPlayer? _player;
  String? customSoundPath;

  Source get _source {
    final p = customSoundPath;
    if (p != null && p.isNotEmpty) return DeviceFileSource(p);
    return AssetSource('audio/rest_over.wav');
  }
  bool _ready = false;
  bool _permissionAsked = false;
  int _generation = 0;

  Future<void> init() async {
    if (_ready) return;

    try {
      tzdata.initializeTimeZones();
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );
      _ready = true;
    } catch (e) {
      debugPrint('RestAlarm (notificaciones) no disponible: $e');
    }
    try {
      final player = AudioPlayer();
      await player.setReleaseMode(ReleaseMode.stop);
      await player.setPlayerMode(PlayerMode.mediaPlayer);
      await player.setAudioContext(
        AudioContext(
          android: const AudioContextAndroid(
            isSpeakerphoneOn: false,
            stayAwake: true,
            contentType: AndroidContentType.sonification,
            usageType: AndroidUsageType.alarm,
            audioFocus: AndroidAudioFocus.gainTransientMayDuck,
          ),
          iOS: AudioContextIOS(category: AVAudioSessionCategory.playback, options: const {}),
        ),
      );
      _player = player;
    } catch (e) {
      debugPrint('RestAlarm (audio) no disponible: $e');
    }
  }

  AndroidFlutterLocalNotificationsPlugin? get _androidPlugin =>
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  Future<bool> notificationsAllowed() async {
    if (!_ready) return true;
    try {
      return await _androidPlugin?.areNotificationsEnabled() ?? true;
    } catch (_) {
      return true;
    }
  }

  Future<bool> requestPermission() async {
    if (!_ready) return true;
    try {
      final granted = await _androidPlugin?.requestNotificationsPermission() ?? true;
      await _androidPlugin?.requestExactAlarmsPermission();
      return granted;
    } catch (e) {
      debugPrint('No se pudo pedir permiso de notificaciones: $e');
      return false;
    }
  }

  Future<void> ensurePermission() async {
    if (!_ready || _permissionAsked) return;
    _permissionAsked = true;
    await requestPermission();
  }

  Future<void> fireNow() async {
    await cancel();

    if (_ready) {
      try {
        await _plugin.show(
          id: _id,
          title: t.restOverTitle,
          body: t.restOverBody,
          notificationDetails: NotificationDetails(android: _androidAlert),
        );
      } catch (e) {
        debugPrint('No se pudo mostrar el aviso: $e');
      }
    }
    try {
      HapticFeedback.heavyImpact();
    } catch (_) {}
    final player = _player;
    if (player == null) return;
    try {
      await player.stop();
      await player.play(_source, volume: 1.0);
    } catch (e) {
      debugPrint('No se pudo reproducir el aviso: $e');
    }
  }

  Future<void> preview() async {
    final player = _player;
    if (player == null) return;
    try {
      await player.stop();
      await player.play(_source, volume: 1.0);
    } catch (e) {
      debugPrint('No se pudo reproducir la vista previa: $e');
    }
  }

  Future<Duration?> probeDuration(String path) async {
    AudioPlayer? probe;
    try {
      probe = AudioPlayer();
      await probe.setReleaseMode(ReleaseMode.stop);
      await probe.setSource(DeviceFileSource(path));

      for (var i = 0; i < 10; i++) {
        final d = await probe.getDuration();
        if (d != null && d > Duration.zero) return d;
        await Future<void>.delayed(const Duration(milliseconds: 120));
      }
      return null;
    } catch (e) {
      debugPrint('No se pudo leer la duración del audio: $e');
      return null;
    } finally {
      try {
        await probe?.release();
        await probe?.dispose();
      } catch (_) {}
    }
  }

  Future<void> stopSound() async {
    try {
      await _player?.stop();
    } catch (_) {}
  }

  Future<void> schedule(Duration after) async {
    if (!_ready) return;
    final mine = ++_generation;

    await ensurePermission();
    if (mine != _generation) return;
    await _clear();
    if (mine != _generation) return;
    try {
      await _plugin.zonedSchedule(
        id: _id,
        title: t.restOverTitle,
        body: t.restOverBody,
        scheduledDate: tz.TZDateTime.now(tz.local).add(after),
        notificationDetails: NotificationDetails(android: _android),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
      );
    } catch (e) {
      debugPrint('No se pudo programar el aviso: $e');
    }
  }

  Future<void> cancel() async {
    _generation++;
    await _clear();
  }

  Future<void> _clear() async {
    if (!_ready) return;
    try {
      await _plugin.cancel(id: _id);
    } catch (_) {}
  }
}
