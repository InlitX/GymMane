import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/gymmane_app.dart';
import 'services/alarm_store.dart';
import 'services/home_widget_bridge.dart';
import 'services/local_store.dart';
import 'services/media_store.dart';
import 'services/rest_alarm.dart';
import 'state/fit_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await initializeDateFormatting();
  await Store.instance.init();
  await MediaStore.init();
  await AlarmStore.init();
  fit.loadFromStore();
  await RestAlarm.instance.init();

  fit.onWidgetsShouldUpdate = HomeWidgetBridge.update;
  runApp(const GymManeApp());

  WidgetsBinding.instance.addPostFrameCallback((_) => HomeWidgetBridge.update());
}
