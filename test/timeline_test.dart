import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/media_store.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tmp;
  final png = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 9, 9, 9, 9]);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    ProgressReminder.instance.enabled = false;
    tmp = await Directory.systemTemp.createTemp('gymmane_shots');
    MediaStore.directory = tmp.path;
    fit.resetAllData();
  });

  tearDown(() async {
    MediaStore.directory = null;
    try {
      if (tmp.existsSync()) await tmp.delete(recursive: true);
    } catch (_) {}
  });

  Future<String> source(String name) async {
    final f = File('${tmp.path}/$name');
    await f.writeAsBytes(png, flush: true);
    return f.path;
  }

  test('three poses on one day are one entry, not three', () async {
    final day = DateTime(2026, 1, 10);
    for (final pose in ['front', 'side', 'back']) {
      expect(await fit.attachShot(day, pose, await source('$pose.png')), true);
    }
    expect(fit.timeline, hasLength(1));
    expect(fit.shotCount, 3);
    expect(fit.timeline.single.shot('back'), isNotNull);
  });

  test('shooting the same pose again replaces the old file', () async {
    final day = DateTime(2026, 1, 10);
    await fit.attachShot(day, 'front', await source('a.png'));
    final first = fit.timeline.single.shot('front')!;
    await fit.attachShot(day, 'front', await source('b.png'));
    final second = fit.timeline.single.shot('front')!;

    expect(second, isNot(first));
    expect(fit.shotCount, 1);
    expect(await MediaStore.readBytes(first), isNull, reason: 'la vieja se borra del disco');
  });

  test('an unknown pose is not accepted', () async {
    expect(await fit.attachShot(DateTime(2026, 1, 10), 'top', await source('a.png')), false);
    expect(fit.timeline, isEmpty);
  });

  test('the timeline reads newest first and knows how long you have been at it', () async {
    await fit.attachShot(DateTime(2026, 1, 1), 'front', await source('a.png'));
    await fit.attachShot(DateTime(2026, 3, 2), 'front', await source('b.png'));

    expect(fit.timeline.first.date, DateTime(2026, 3, 2));
    expect(fit.firstEntry!.date, DateTime(2026, 1, 1));
    expect(fit.daysTracked, 60);
  });

  test('dropping the last pose of a day drops the day too', () async {
    final day = DateTime(2026, 1, 10);
    await fit.attachShot(day, 'front', await source('a.png'));
    await fit.attachShot(day, 'back', await source('b.png'));

    final id = fit.timeline.single.id;
    fit.removeShot(id, 'front');
    expect(fit.timeline, hasLength(1));
    fit.removeShot(id, 'back');
    expect(fit.timeline, isEmpty);
  });

  test('the reminder date follows the interval and the last photo', () async {
    expect(fit.nextPhotoDue, isNull, reason: 'sin fotos no hay nada que recordar');

    await fit.attachShot(DateTime(2026, 1, 10), 'front', await source('a.png'));
    fit.setPhotoInterval(30);
    expect(fit.nextPhotoDue, DateTime(2026, 2, 9));

    fit.setPhotoInterval(0);
    expect(fit.nextPhotoDue, isNull);
    expect(fit.daysUntilPhoto, isNull);
  });

  test('a rubbish interval falls back to the default', () {
    fit.setPhotoInterval(7);
    expect(fit.photoIntervalDays, 30);
  });

  test('comparing defaults to the first and the last, and only offers shared poses', () async {
    await fit.attachShot(DateTime(2026, 1, 1), 'front', await source('a.png'));
    await fit.attachShot(DateTime(2026, 1, 1), 'back', await source('b.png'));
    await fit.attachShot(DateTime(2026, 4, 1), 'front', await source('c.png'));

    final pair = fit.comparePair!;
    expect(pair.from.date, DateTime(2026, 1, 1));
    expect(pair.to.date, DateTime(2026, 4, 1));
    expect(fit.compareDays, 90);
    expect(fit.posesWithBoth, ['front'], reason: 'la espalda solo está en un día');
  });

  test('with a single day there is nothing to compare', () async {
    await fit.attachShot(DateTime(2026, 1, 1), 'front', await source('a.png'));
    expect(fit.comparePair, isNull);
  });

  test('the day keeps the bodyweight you had, and the delta uses your units', () async {
    fit.setUnits('kg');
    fit.addBodyweight(80);
    await fit.attachShot(DateTime(2026, 1, 1), 'front', await source('a.png'));
    fit.addBodyweight(76);
    await fit.attachShot(DateTime(2026, 4, 1), 'front', await source('b.png'));

    expect(fit.compareWeightDelta, closeTo(-4, 0.01));
  });

  test('photos survive a save and a reload, and reset wipes them', () async {
    await fit.attachShot(DateTime(2026, 1, 1), 'front', await source('a.png'));
    fit.setPhotoInterval(60);
    fit.persistNow();

    fit.shots.clear();
    fit.loadFromStore();
    expect(fit.timeline, hasLength(1));
    expect(fit.photoIntervalDays, 60);

    fit.resetAllData();
    expect(fit.shots, isEmpty);
  });
}
