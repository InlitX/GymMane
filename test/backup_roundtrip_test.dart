import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/models/nutrition.dart';
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
  late Directory src;
  final png = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 1, 2, 3, 4]);

  final bench = kExercises.firstWhere((e) => e.name == 'Barbell Bench Press');
  final squat = kExercises.firstWhere((e) => e.name == 'Barbell Front Squat');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    tmp = await Directory.systemTemp.createTemp('gymmane_rt');
    src = await Directory.systemTemp.createTemp('gymmane_rt_src');
    MediaStore.directory = tmp.path;
    ProgressReminder.instance.enabled = false;
    TrainReminder.instance.enabled = false;
    fit.resetAllData();
  });

  tearDown(() async {
    MediaStore.directory = null;
    for (final d in [tmp, src]) {
      if (d.existsSync()) await d.delete(recursive: true);
    }
  });

  Future<String> source(String name) async {
    final f = File('${src.path}/$name');
    await f.writeAsBytes(png, flush: true);
    return f.path;
  }

  Future<void> seedEverything() async {
    final day = DateTime(2026, 3, 2, 18, 40);
    for (var i = 0; i < 12; i++) {
      fit.sessions.add(LoggedSession(day.add(Duration(days: i * 2, minutes: i * 7)), 3000 + i * 61, [
        LoggedExercise(bench.id, bench.name, bench.primary, [
          LoggedSet(8, 62.5 + i, rpe: 7.5),
          LoggedSet(6, 70.0 + i, kind: SetKind.failure),
        ]),
        LoggedExercise(squat.id, squat.name, squat.primary, [
          LoggedSet(5, 90, kind: SetKind.warmup),
        ]),
      ]));
      fit.bodyweight.add(BodyweightEntry(day.add(Duration(days: i * 3)), 81.3 - i * 0.2));
    }

    fit.updateProfile(name: 'Prueba', sex: 'female', ageDelta: 2, weeklyGoalDelta: 1);
    fit.setProfileHandle('prueba');
    fit.setProfilePhoto(png);
    fit.setUnits('lb');
    fit.setThemeLight();
    fit.setBgDim(0.4);
    await fit.setBgPhoto(await source('bg.png'));
    fit.setTrainReminder(7 * 60 + 30);
    fit.setTrainAgain(SettingsState.trainAgainOptions.last);
    fit.toggleLogRpe();
    fit.toggleAutoAdvance();
    fit.toggleFocusCard();
    fit.setExerciseGoal(bench.id, 100, DateTime(2026, 12, 1));

    final custom = fit.addCustomExercise(name: 'Remo raro', primary: 'back', equipment: 'Cable');
    await fit.attachExerciseMedia(custom, await source('custom.png'));
    fit.toggleFavorite(bench.id);
    fit.toggleArchived(squat.id);
    fit.setExerciseRest(bench.id, 150);
    fit.toggleProgress(bench.id);
    fit.toggleAutoWarmup(squat.id);

    final place = fit.addPlace('Gym', equipment: {'Barbell'});
    fit.setActivePlace(place);
    fit.setPlatePairs(place, 20, 2);

    final push = fit.createRoutine('Push');
    fit.toggleRoutineExercise(push, bench.id);
    fit.setRoutineGroup(push, 'PPL');
    fit.assignRoutineToDay(1, push);
    final legs = fit.createRoutine('Legs');
    fit.toggleRoutineExercise(legs, squat.id);
    fit.assignRoutineToDay(4, legs);
    fit.setRotation(true);

    fit.saveNote(
      exerciseId: bench.id,
      date: DateTime(2026, 3, 4),
      kind: NoteKind.done,
      text: 'Nota con foto',
      media: [(await MediaStore.importFor('note', await source('note.png')))!],
    );
    for (final pose in ['front', 'side']) {
      await fit.attachShot(DateTime(2026, 3, 1), pose, await source('$pose.png'));
    }
    fit.addMeasure('chest', 101);
    fit.addMeasure('waist', 80.5);
    await fit.addMoment(await source('moment.png'), note: 'Hito');

    final oats = fit.saveFood(
        name: 'Avena', grams: 100, photo: (await MediaStore.importFor('food', await source('oats.png')))!,
        macros: const Macros(kcal: 380, protein: 13, carbs: 60, fat: 7));
    final milk = fit.saveFood(name: 'Leche', grams: 250, liquid: true, macros: const Macros(kcal: 120, protein: 8));
    final a = fit.logFood(oats, servings: 0.8);
    final b = fit.logFood(milk);
    fit.toggleFavoriteFood(oats.id);
    fit.saveRecipe('Desayuno', [a, b]);
    fit.addWater(330);
    final supp = fit.addSupplement('Creatina', dose: '5 g', at: 9 * 60)!;
    fit.toggleSupplement(supp.id);
    fit.setUseKj(true);
    fit.setWeightGoal(78);
    fit.setNutritionGoals(fit.nutritionGoals.copyWith(kcal: 2400, protein: 160));
    final plan = fit.createMealPlan(name: 'Lunes', fromDay: true);
    fit.setPlanDay(1, plan.id);
    fit.setStepsGoal(10000);

    fit.refreshAwards(silent: true);
  }

  Object? normalize(Object? v, Set<String> media) => switch (v) {
        String s when media.contains(s) => '<media>',
        Map m => {
            for (final e in m.entries)
              if (!const {'media', 'alarmAskedAt'}.contains(e.key)) '${e.key}': normalize(e.value, media)
          },
        List l => [for (final x in l) normalize(x, media)],
        _ => v,
      };

  Set<String> mediaNames() => {for (final f in tmp.listSync().whereType<File>()) f.uri.pathSegments.last};

  test('todo lo que guarda la app vuelve igual tras copia y restauración', () async {
    await seedEverything();
    final before = jsonEncode(normalize(Store.finite(fit.toJson()), mediaNames()));
    final zip = await buildBackupZip();

    fit.resetAllData();
    expect(await restoreBackupZip(zip), isTrue);
    final after = jsonEncode(normalize(Store.finite(fit.toJson()), mediaNames()));

    final a = jsonDecode(before) as Map<String, dynamic>;
    final b = jsonDecode(after) as Map<String, dynamic>;
    for (final key in {...a.keys, ...b.keys}) {
      expect(jsonEncode(b[key]), jsonEncode(a[key]), reason: 'la clave "$key" cambia al restaurar');
    }
    expect(fit.exerciseMedia.length, 2);
  });

  test('una copia dañada no borra las fotos ni los datos que ya había', () async {
    await seedEverything();
    final sessions = fit.sessions.length;
    final files = mediaNames();
    final zip = await buildBackupZip();

    final broken = Archive();
    for (final f in ZipDecoder().decodeBytes(zip).files) {
      if (f.name == kBackupJsonEntry) {
        final data = jsonDecode(utf8.decode(f.readBytes()!)) as Map<String, dynamic>;
        broken.addFile(ArchiveFile.string(kBackupJsonEntry, jsonEncode({...data, 'sessions': 'roto'})));
      } else {
        broken.addFile(ArchiveFile.noCompress(f.name, f.size, f.readBytes()!));
      }
    }
    expect(await restoreBackupZip(ZipEncoder().encodeBytes(broken)), isFalse);
    expect(fit.sessions.length, sessions);
    expect(mediaNames(), files);
    expect(await MediaStore.readBytes(fit.bgPhoto!), png);

    expect(await restoreBackupZip(Uint8List.fromList(zip.sublist(0, zip.length ~/ 2))), isFalse);
    expect(fit.sessions.length, sessions);
    expect(mediaNames(), files);
  });

  test('la copia se comprueba antes de darla por buena', () async {
    await seedEverything();
    final zip = await buildBackupZip();
    expect(isValidBackupZip(zip), isTrue);
    expect(isValidBackupZip(Uint8List.fromList(zip.sublist(0, zip.length - 40))), isFalse);
    expect(isValidBackupZip(Uint8List.fromList(utf8.encode('hola'))), isFalse);
  });
}
