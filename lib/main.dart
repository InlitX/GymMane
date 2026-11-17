import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/gymmane_app.dart';
import 'services/alarm_store.dart';
import 'services/auto_backup.dart';
import 'services/device_kind.dart';
import 'services/home_widget_bridge.dart';
import 'services/nutrition_widgets.dart';
import 'services/live_workout.dart';
import 'services/local_store.dart';
import 'services/media_store.dart';
import 'services/app_icon.dart';
import 'services/nfc_tags.dart';
import 'services/graphics_mode.dart';
import 'services/rest_alarm.dart';
import 'services/screen_awake.dart';
import 'state/fit_state.dart';
import 'services/quick_tiles.dart';
import 'services/watch_phone.dart';
import 'wear/wear_app.dart';
import 'wear/wear_surfaces.dart';
import 'wear/wear_sync.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
  ));

  await initializeDateFormatting();
  await Store.instance.init();
  await MediaStore.init();
  await AlarmStore.init();
  await RestAlarm.instance.init();
  GraphicsMode.load();
  AppIcon.load();
  fit.loadFromStore();
  NfcTags.load();
  fit.syncPhotoReminder();
  fit.syncMeasureReminder();
  fit.syncTrainReminder();

  final watch = await DeviceKind.isWatch();
  _onWatch = watch;
  fit.addListener(_sessionSideEffects);
  _sessionSideEffects();

  if (watch) {
    WearSurfaces.watch();
    unawaited(WearSync.instance.init());
    runApp(const WearApp());
    GraphicsMode.watchFirstFrame();
    return;
  }

  fit.onWidgetsShouldUpdate = HomeWidgetBridge.update;
  NutritionWidgets.watch(HomeWidgetBridge.update);
  AutoBackup.instance.init();
  unawaited(WatchPhone.init());
  unawaited(QuickTiles.init());
  runApp(const GymManeApp());

  GraphicsMode.watchFirstFrame();
  WidgetsBinding.instance.addPostFrameCallback((_) => HomeWidgetBridge.update());
}

bool _onWatch = false;

void _sessionSideEffects() {
  if (!_onWatch) LiveWorkout.sync();
  final live = fit.isSessionActive && fit.session?.manual == false;
  ScreenAwake.keepOn(fit.keepScreenOn && live);
}
