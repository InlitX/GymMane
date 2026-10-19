import 'dart:io' show Platform;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show AppLifecycleState, WidgetsBinding;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../l10n/l10n.dart';

class RestAlarm {
  RestAlarm._();
  static final RestAlarm instance = RestAlarm._();

  static const _id = 1001;
  static const _haptics = MethodChannel('gymmane/haptics');
  static final _pattern = Int64List.fromList([0, 350, 180, 350, 180, 600]);

  String style = 'loud';

  AndroidNotificationDetails get _android => switch (style) {
    'quiet' => AndroidNotificationDetails(
      'rest_timer_quiet',
      t.notifRestChannel,
      channelDescription: t.notifRestChannelWhy,
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
      playSound: true,
      enableVibration: true,
      vibrationPattern: _pattern,
      audioAttributesUsage: AudioAttributesUsage.notification,
      visibility: NotificationVisibility.public,
    ),
    'vibrate' => AndroidNotificationDetails(
      'rest_timer_vibrate',
      t.notifRestChannel,
      channelDescription: t.notifRestChannelWhy,
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
      playSound: false,
      enableVibration: true,
      vibrationPattern: _pattern,
      visibility: NotificationVisibility.public,
    ),
    _ => AndroidNotificationDetails(
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
    ),
  };

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

  DarwinNotificationDetails get _darwin => DarwinNotificationDetails(
    presentAlert: true,
    presentBanner: true,
    presentList: true,
    presentSound: style != 'vibrate',
    sound: style == 'vibrate' ? null : 'rest_over.wav',
    interruptionLevel: InterruptionLevel.timeSensitive,
  );

  DarwinNotificationDetails get _darwinAlert => const DarwinNotificationDetails(
    presentAlert: true,
    presentBanner: true,
    presentList: true,
    presentSound: false,
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
          android: AndroidInitializationSettings('@drawable/ic_stat_gymmane'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestSoundPermission: false,
            requestBadgePermission: false,
          ),
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
      _player = player;
      await _applyAudioContext();
    } catch (e) {
      debugPrint('RestAlarm (audio) no disponible: $e');
    }
  }

  String? _contextFor;

  Future<void> _applyAudioContext() async {
    final player = _player;
    if (player == null || _contextFor == style) return;
    final loud = style == 'loud';
    try {
      await player.setAudioContext(
        AudioContext(
          android: AudioContextAndroid(
            isSpeakerphoneOn: false,
            stayAwake: true,
            contentType: AndroidContentType.sonification,
            usageType: loud ? AndroidUsageType.alarm : AndroidUsageType.notification,
            audioFocus: AndroidAudioFocus.gainTransientMayDuck,
          ),
          iOS: AudioContextIOS(
            category: loud ? AVAudioSessionCategory.playback : AVAudioSessionCategory.ambient,
            options: const {},
          ),
        ),
      );
      _contextFor = style;
    } catch (e) {
      debugPrint('RestAlarm (contexto de audio): $e');
    }
  }

  Future<void> _buzz() async {
    try {
      await _haptics.invokeMethod<void>('buzz');
    } catch (_) {
      try {
        HapticFeedback.heavyImpact();
      } catch (_) {}
    }
  }

  AndroidFlutterLocalNotificationsPlugin? get _androidPlugin =>
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  IOSFlutterLocalNotificationsPlugin? get _iosPlugin =>
      _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

  Future<bool> notificationsAllowed() async {
    if (!_ready) return true;
    try {
      if (Platform.isIOS) {
        final options = await _iosPlugin?.checkPermissions();
        return options?.isEnabled ?? true;
      }
      return await _androidPlugin?.areNotificationsEnabled() ?? true;
    } catch (_) {
      return true;
    }
  }

  Future<bool> requestPermission() async {
    if (!_ready) return true;
    try {
      if (Platform.isIOS) {
        return await _iosPlugin?.requestPermissions(alert: true, sound: true) ?? true;
      }
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
    final visible = WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    final custom = customSoundPath?.isNotEmpty ?? false;
    if (_ready && !visible && !custom && Platform.isAndroid) {
      _generation++;
      return;
    }
    await cancel();

    if (_ready && !visible) {
      try {
        await _plugin.show(
          id: _id,
          title: t.restOverTitle,
          body: t.restOverBody,
          notificationDetails: NotificationDetails(android: _androidAlert, iOS: _darwinAlert),
        );
      } catch (e) {
        debugPrint('No se pudo mostrar el aviso: $e');
      }
    }
    if (style == 'loud') {
      try {
        HapticFeedback.heavyImpact();
      } catch (_) {}
    } else {
      await _buzz();
    }
    if (style == 'vibrate') return;
    final player = _player;
    if (player == null) return;
    try {
      await _applyAudioContext();
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
      await _applyAudioContext();
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
        notificationDetails: NotificationDetails(android: _android, iOS: _darwin),
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
