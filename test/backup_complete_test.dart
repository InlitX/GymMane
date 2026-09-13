import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/backup_zip.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/media_store.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/services/train_reminder.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tmp;
  final png = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 9, 9, 9, 9]);
  final mp4 = Uint8List.fromList(List<int>.generate(48, (i) => i));

  final bench = kExercises.firstWhere((e) => e.name == 'Barbell Bench Press');
  final squat = kExercises.firstWhere((e) => e.name == 'Barbell Front Squat');
  final pushUp = kExercises.firstWhere((e) => e.equipment == 'Bodyweight');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    tmp = await Directory.systemTemp.createTemp('gymmane_full');
    MediaStore.directory = tmp.path;
    ProgressReminder.instance.enabled = false;
    TrainReminder.instance.enabled = false;
    fit.resetAllData();
  });

  tearDown(() async {
    MediaStore.directory = null;
    if (tmp.existsSync()) await tmp.delete(recursive: true);
  });

  Future<String> source(String name, Uint8List bytes) async {
    final f = File('${tmp.path}/$name');
    await f.writeAsBytes(bytes, flush: true);
    return f.path;
  }

  Future<void> seedTwoYears() async {
    final start = DateTime(2024, 9, 1, 19, 30);
    for (var week = 0; week < 104; week++) {
      for (final day in [0, 3]) {
        final when = start.add(Duration(days: week * 7 + day));
        fit.sessions.add(LoggedSession(when, 3600 + week, [
          LoggedExercise(bench.id, bench.name, bench.primary, [
            LoggedSet(10, 60 + week * 0.25, rpe: 8),
            LoggedSet(8, 60 + week * 0.25),
            LoggedSet(6, 60 + week * 0.25, kind: SetKind.failure),
          ]),
          LoggedExercise(squat.id, squat.name, squat.primary, [
            LoggedSet(5, 100 + week * 0.5, kind: SetKind.warmup),
            LoggedSet(5, 100 + week * 0.5),
          ]),
        ]));
      }
      fit.bodyweight.add(BodyweightEntry(start.add(Duration(days: week * 7)), 80 - week * 0.05));
    }
    fit.sessions.sort((a, b) => a.date.compareTo(b.date));

    fit.updateProfile(name: 'InlitX', sex: 'male', ageDelta: 3, weeklyGoalDelta: 1);
    fit.setUnits('lb');
    fit.setThemeLight();
    fit.setBgDim(0.72);

    final custom = fit.addCustomExercise(
        name: 'Sentadilla búlgara', primary: 'quads', equipment: 'Bodyweight');
    await fit.attachExerciseMedia(custom, await source('custom.png', png));
    await fit.attachExerciseMedia(bench.id, await source('bench.mp4', mp4));
    await fit.setBgPhoto(await source('bg.png', png));

    fit.toggleFavorite(bench.id);
    fit.toggleRepsOnly(pushUp.id);
    fit.setExerciseRest(bench.id, 180);
    fit.toggleProgress(bench.id);
    fit.toggleAutoWarmup(squat.id);
    fit.toggleCheckin(0);

    final place = fit.addPlace('Casa', equipment: {'Barbell', 'Dumbbell'});
    fit.setActivePlace(place);
    fit.setPlatePairs(place, 20, 2);
    fit.setPlatePairs(place, 10, 3);
    fit.setPlaceBar(place, 15);

    final routine = fit.createRoutine('Push');
    fit.toggleRoutineExercise(routine, bench.id);
    fit.toggleRoutineExercise(routine, squat.id);
    fit.bumpRoutineSets(routine, bench.id, 2);
    fit.toggleChain(routine, bench.id);
    fit.setRoutineGroup(routine, 'PPL');
    fit.assignRoutineToDay(1, routine);

    fit.saveNote(
      exerciseId: bench.id,
      date: DateTime(2025, 3, 4),
      kind: NoteKind.done,
      text: 'Primer 100 limpio',
      media: [(await MediaStore.importFor('note', await source('note.png', png)))!],
    );

    for (final day in [DateTime(2025, 1, 5), DateTime(2025, 7, 5), DateTime(2026, 1, 5)]) {
      for (final pose in ['front', 'side', 'back']) {
        await fit.attachShot(day, pose, await source('$pose-${day.month}.png', png));
      }
    }
    fit.setPhotoInterval(30);
    fit.addMeasure('chest', 104);
    fit.addMeasure('arm', 38.5);
    fit.setTrainReminder(19 * 60 + 15);
    fit.setSmartReminder(true);
    fit.toggleLogRpe();
    fit.toggleAutoAdvance();
    fit.toggleFocusCard();

    fit.setProfileHandle('inlitx');
    fit.setProfileBadge('gold');
    fit.setProfilePhoto(png);
    fit.setProfileBanner(mp4);
    fit.refreshAwards(silent: true);
    await fit.addMoment(await source('moment.png', png), note: 'Primer día');
  }

  test('dos años de uso entran y salen de la copia sin perder nada', () async {
    await seedTwoYears();

    final before = {
      'sesiones': fit.sessions.length,
      'volumen': fit.sessions.fold<double>(0, (a, s) => a + s.volume).round(),
      'series': fit.sessions.fold<int>(0, (a, s) => a + s.setCount),
      'primera': fit.sessions.first.date,
      'ultima': fit.sessions.last.date,
      'peso': fit.bodyweight.length,
      'notas': fit.notes.length,
      'fotos': fit.timeline.length,
      'medidas': fit.measures.length,
      'propios': fit.customExercises.length,
      'rutinas': fit.routines.length,
      'sitios': fit.places.length,
    };
    final rpeBefore = fit.sessions.first.exercises.first.sets.first.rpe;
    final zip = await buildBackupZip();

    fit.resetAllData();
    expect(fit.sessions, isEmpty);
    expect(await restoreBackupZip(zip), isTrue);

    expect(fit.sessions.length, before['sesiones']);
    expect(fit.sessions.fold<double>(0, (a, s) => a + s.volume).round(), before['volumen']);
    expect(fit.sessions.fold<int>(0, (a, s) => a + s.setCount), before['series']);
    expect(fit.sessions.first.date, before['primera']);
    expect(fit.sessions.last.date, before['ultima']);
    expect(fit.sessions.first.exercises.first.sets.first.rpe, rpeBefore);
    expect(fit.sessions.first.exercises.last.sets.first.kind, SetKind.warmup);
    expect(fit.bodyweight.length, before['peso']);
    expect(fit.notes.length, before['notas']);
    expect(fit.timeline.length, before['fotos']);
    expect(fit.measures.length, before['medidas']);
    expect(fit.customExercises.length, before['propios']);
    expect(fit.routines.length, before['rutinas']);
    expect(fit.places.length, before['sitios']);
  });

  test('vuelven todas las fotos, los vídeos y el fondo, byte a byte', () async {
    await seedTwoYears();
    final zip = await buildBackupZip();
    fit.resetAllData();
    expect(await restoreBackupZip(zip), isTrue);

    expect(await MediaStore.readBytes(fit.mediaFor(bench.id)), mp4);
    final custom = fit.customExercises.single;
    expect(await MediaStore.readBytes(fit.mediaFor(custom.id)), png);
    expect(await MediaStore.readBytes(fit.bgPhoto!), png);
    expect(await MediaStore.readBytes(fit.notes.single.media.single), png);

    expect(fit.timeline.length, 3);
    for (final entry in fit.timeline) {
      expect(entry.shots.keys, containsAll(['front', 'side', 'back']));
      for (final pose in ['front', 'side', 'back']) {
        expect(await MediaStore.readBytes(entry.shot(pose)!), png);
      }
    }
  });

  test('las fotos del timeline van en su carpeta por fecha', () async {
    await seedTwoYears();
    final zip = await buildBackupZip();
    final names = ZipDecoder().decodeBytes(zip).files.map((f) => f.name).toList();

    expect(names, contains('timeline/2025-01-05/front.png'));
    expect(names, contains('timeline/2025-07-05/side.png'));
    expect(names, contains('timeline/2026-01-05/back.png'));
    expect(names.where((n) => n.startsWith('timeline/')).length, 9);
    expect(names.any((n) => n.startsWith('media/videos/')), isTrue);
    expect(names.any((n) => n.startsWith('media/notes/')), isTrue);
  });

  test('vuelven todos los ajustes, incluidos los nuevos', () async {
    await seedTwoYears();
    final zip = await buildBackupZip();
    fit.resetAllData();
    expect(await restoreBackupZip(zip), isTrue);

    expect(fit.units, 'lb');
    expect(fit.dark, isFalse);
    expect(fit.profile.name, 'InlitX');
    expect(fit.profile.weeklyGoal, 5);
    expect(fit.bgPattern, 'photo');
    expect(fit.bgDim, 0.72);
    expect(fit.showFocus, isFalse);
    expect(fit.autoAdvance, isFalse);
    expect(fit.logRpe, isTrue);
    expect(fit.smartReminder, isTrue);
    expect(fit.trainReminderMin, 19 * 60 + 15);
    expect(fit.photoIntervalDays, 30);
    expect(fit.favorites[bench.id], isTrue);
    expect(fit.isRepsOnly(pushUp.id), isFalse);
    expect(fit.restFor(bench.id), 180);
    expect(fit.hasProgress(bench.id), isTrue);
    expect(fit.warmsUp(squat.id), isTrue);
    expect(fit.checkins, isNotEmpty);
  });

  test('vuelven la identidad, las medallas y los momentos', () async {
    await seedTwoYears();
    final awardsBefore = fit.awards.length;
    final zip = await buildBackupZip();

    fit.resetAllData();
    expect(fit.moments, isEmpty);
    expect(await restoreBackupZip(zip), isTrue);

    expect(fit.profile.handle, 'inlitx');
    expect(fit.profile.badge, 'gold');
    expect(fit.profilePhoto, png);
    expect(fit.profileBanner, mp4);
    expect(fit.awards.length, awardsBefore);
    expect(awardsBefore, greaterThan(0));
    expect(fit.moments.single.note, 'Primer día');
    expect(File('${tmp.path}/${fit.moments.single.file}').existsSync(), isTrue,
        reason: 'la foto del momento no viajó en la copia');
  });

  test('vuelven la rutina con sus series, su cadena y su grupo, y el sitio con sus discos',
      () async {
    await seedTwoYears();
    final zip = await buildBackupZip();
    fit.resetAllData();
    expect(await restoreBackupZip(zip), isTrue);

    final routine = fit.routines.single;
    expect(routine.name, 'Push');
    expect(routine.group, 'PPL');
    expect(routine.exerciseIds, [bench.id, squat.id]);
    expect(fit.routineSets(routine, bench.id), 5);
    expect(fit.chainsToNext(routine, bench.id), isTrue);
    expect(fit.weeklyPlan[1], routine.id);

    final place = fit.places.single;
    expect(place.name, 'Casa');
    expect(place.equipment, containsAll(['Barbell', 'Dumbbell']));
    expect(fit.platePairs(place, 20), 2);
    expect(fit.platePairs(place, 10), 3);
    expect(place.bar, 15);
    expect(fit.activePlaceId, place.id);
  });
}
