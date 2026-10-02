import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/gymmane_app.dart';
import 'services/alarm_store.dart';
import 'services/device_kind.dart';
import 'services/home_widget_bridge.dart';
import 'services/live_workout.dart';
import 'services/local_store.dart';
import 'services/media_store.dart';
import 'services/rest_alarm.dart';
import 'services/screen_awake.dart';
import 'state/fit_state.dart';
import 'wear/wear_app.dart';

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
  fit.loadFromStore();
  fit.syncPhotoReminder();
  fit.syncTrainReminder();

  final watch = await DeviceKind.isWatch();
  _onWatch = watch;
  fit.addListener(_sessionSideEffects);
  _sessionSideEffects();

  if (watch) {
    runApp(const WearApp());
    return;
  }

  fit.onWidgetsShouldUpdate = HomeWidgetBridge.update;
  runApp(const GymManeApp());

  WidgetsBinding.instance.addPostFrameCallback((_) => HomeWidgetBridge.update());
}

bool _onWatch = false;

void _sessionSideEffects() {
  if (!_onWatch) LiveWorkout.sync();
  final live = fit.isSessionActive && fit.session?.manual == false;
  ScreenAwake.keepOn(fit.keepScreenOn && live);
}
