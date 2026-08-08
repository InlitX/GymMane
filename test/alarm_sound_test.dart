import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/alarm_store.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/rest_alarm.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory docs;

  setUp(() async {
    docs = await Directory.systemTemp.createTemp('gymmane_alarm');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async => docs.path,
    );
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    await AlarmStore.init();
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      null,
    );
    await fit.clearAlarmSound();
    if (docs.existsSync()) docs.deleteSync(recursive: true);
  });

  File sourceSound(String name) {
    final f = File('${docs.path}/$name')..writeAsBytesSync(List.filled(64, 7));
    return f;
  }

  test('the alarm folder is ready and empty by default', () {
    expect(AlarmStore.ready, isTrue);
    expect(AlarmStore.pathFor(null), isNull);
    expect(AlarmStore.pathFor('nope.mp3'), isNull);
  });

  test('uploading a sound copies it into the app and keeps its extension', () async {
    final base = await AlarmStore.importSound(sourceSound('siren.ogg').path);
    expect(base, isNotNull);
    expect(base, endsWith('.ogg'));
    expect(AlarmStore.pathFor(base), isNotNull);
    expect(File(AlarmStore.pathFor(base)!).existsSync(), isTrue);
  });

  test('a second upload replaces the first one instead of piling up', () async {
    await AlarmStore.importSound(sourceSound('one.mp3').path);
    final second = await AlarmStore.importSound(sourceSound('two.wav').path);
    final kept = Directory('${docs.path}/alarm').listSync().whereType<File>().toList();
    expect(kept.length, 1);
    expect(kept.single.path, endsWith(second!));
  });

  test('the chosen sound reaches the state, the alarm and the saved data', () async {
    final base = await AlarmStore.importSound(sourceSound('mine.wav').path);
    fit.setAlarmSound(base!, 'Mine');

    expect(fit.alarmSound, base);
    expect(fit.alarmSoundName, 'Mine');
    expect(fit.alarmSoundPath, isNotNull);
    expect(RestAlarm.instance.customSoundPath, fit.alarmSoundPath);

    fit.persistNow();
    fit.loadFromStore();
    expect(fit.alarmSound, base, reason: 'sobrevive a reiniciar la app');
    expect(fit.alarmSoundName, 'Mine');
  });

  test('resetting goes back to the built-in sound and deletes the file', () async {
    final base = await AlarmStore.importSound(sourceSound('mine.wav').path);
    fit.setAlarmSound(base!, 'Mine');
    final path = fit.alarmSoundPath!;

    await fit.clearAlarmSound();

    expect(fit.alarmSound, isNull);
    expect(fit.alarmSoundName, isNull);
    expect(fit.alarmSoundPath, isNull);
    expect(RestAlarm.instance.customSoundPath, isNull);
    expect(File(path).existsSync(), isFalse);
  });

  test('a sound that vanished between sessions falls back to the default', () async {
    final base = await AlarmStore.importSound(sourceSound('mine.wav').path);
    fit.setAlarmSound(base!, 'Mine');
    fit.persistNow();

    File(AlarmStore.pathFor(base)!).deleteSync();
    fit.loadFromStore();

    expect(fit.alarmSound, isNull);
    expect(fit.alarmSoundName, isNull);
    expect(fit.alarmSoundPath, isNull);
  });
}
