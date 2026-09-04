import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/services/backup_zip.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/media_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tmp;
  final png = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 1, 2, 3, 4]);
  final mp4 = Uint8List.fromList(List<int>.generate(64, (i) => i));

  final pushUp = kExercises.firstWhere((e) => e.equipment == 'Bodyweight');
  final bench = kExercises.firstWhere((e) => e.equipment == 'Barbell');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    tmp = await Directory.systemTemp.createTemp('gymmane_media');
    MediaStore.directory = tmp.path;
    ProgressReminder.instance.enabled = false;
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

  test('the zip keeps the data json and renames the media after the exercise', () async {
    await fit.attachExerciseMedia(pushUp.id, await source('IMG_1800.png', png));
    await fit.attachExerciseMedia(bench.id, await source('clip.mp4', mp4));

    final archive = ZipDecoder().decodeBytes(await buildBackupZip());
    final names = archive.files.map((f) => f.name).toList();

    expect(names, contains(kBackupJsonEntry));
    expect(names, contains('media/images/${slugify(exerciseName(pushUp))}.png'));
    expect(names, contains('media/videos/${slugify(exerciseName(bench))}.mp4'));
    expect(archive.findFile('media/images/${slugify(exerciseName(pushUp))}.png')!.readBytes(), png);

    final data = jsonDecode(utf8.decode(archive.findFile(kBackupJsonEntry)!.readBytes()!))
        as Map<String, dynamic>;
    expect((data['media'] as Map)[pushUp.id], 'media/images/${slugify(exerciseName(pushUp))}.png');
  });

  test('two exercises with the same name do not overwrite each other', () async {
    final id = fit.addCustomExercise(
        name: exerciseName(pushUp), primary: 'chest', equipment: 'Bodyweight');
    await fit.attachExerciseMedia(pushUp.id, await source('a.png', png));
    await fit.attachExerciseMedia(id, await source('b.png', png));

    final slug = slugify(exerciseName(pushUp));
    final names = ZipDecoder().decodeBytes(await buildBackupZip()).files.map((f) => f.name);
    expect(names, contains('media/images/$slug.png'));
    expect(names, contains('media/images/$slug-2.png'));
  });

  test('importing the zip brings back the data and the media files', () async {
    fit.updateProfile(name: 'Alex');
    fit.toggleRepsOnly(bench.id);
    await fit.attachExerciseMedia(pushUp.id, await source('IMG_1800.png', png));
    final zip = await buildBackupZip();

    fit.resetAllData();
    expect(fit.mediaFor(pushUp.id), '');

    expect(await restoreBackupZip(zip), true);
    expect(fit.profile.name, 'Alex');
    expect(fit.isRepsOnly(bench.id), true);

    final restored = fit.mediaFor(pushUp.id);
    expect(restored, isNotEmpty);
    expect(await MediaStore.readBytes(restored), png);
  });

  test('a zip without media still restores, and a broken file is rejected', () async {
    fit.updateProfile(name: 'Alex');
    final zip = await buildBackupZip();
    fit.resetAllData();

    expect(await restoreBackupZip(zip), true);
    expect(fit.profile.name, 'Alex');
    expect(fit.exerciseMedia, isEmpty);
    expect(await restoreBackupZip(Uint8List.fromList([1, 2, 3, 4, 5])), false);
  });

  test('a json backup from 1.0 still imports, media included', () async {
    await fit.attachExerciseMedia(pushUp.id, await source('IMG_1800.png', png));
    final legacy = fit.exportJson();
    final basename = fit.mediaFor(pushUp.id);

    fit.exerciseMedia.clear();
    expect(fit.importJson(legacy), true);
    expect(fit.mediaFor(pushUp.id), basename);
  });

  test('the zip carries the photos hanging off a note and brings them back', () async {
    fit.saveNote(
        exerciseId: pushUp.id,
        date: DateTime(2026, 9, 3),
        kind: NoteKind.done,
        text: 'Primera dominada limpia',
        media: [(await MediaStore.importFor('note', await source('shot.png', png)))!]);

    final zip = await buildBackupZip();
    final archive = ZipDecoder().decodeBytes(zip);
    expect(archive.files.map((f) => f.name),
        contains('media/notes/2026-09-03-primera-dominada-limpia.png'));

    fit.resetAllData();
    expect(await restoreBackupZip(zip), true);

    final note = fit.notes.single;
    expect(note.text, 'Primera dominada limpia');
    expect(note.media, hasLength(1));
    expect(await MediaStore.readBytes(note.media.single), png);
  });

  test('a 1.0 backup with the old per-exercise notes lands in the journal', () {
    expect(
        fit.importJson(jsonEncode({
          'profile': {'name': 'Alex'},
          'exNotes': {
            pushUp.id: [
              {'d': '2026-07-16T17:12:08.558090', 't': 'Subir a 82.5 la próxima.'},
            ],
          },
        })),
        true);

    final note = fit.notesFor(pushUp.id).single;
    expect(note.text, 'Subir a 82.5 la próxima.');
    expect(note.kind, NoteKind.note);
    expect(note.date, DateTime(2026, 7, 16));
  });

  test('a note whose file is gone does not sink the backup', () async {
    fit.saveNote(
        exerciseId: pushUp.id,
        date: DateTime(2026, 9, 3),
        kind: NoteKind.note,
        text: 'sin foto',
        media: const ['note-desaparecida.png']);

    final zip = await buildBackupZip();
    fit.resetAllData();
    expect(await restoreBackupZip(zip), true);
    expect(fit.notes.single.media, isEmpty);
  });

  test('the progress photos travel in the zip named by day and pose', () async {
    await fit.attachShot(DateTime(2026, 2, 1), 'front', await source('f.png', png));
    await fit.attachShot(DateTime(2026, 2, 1), 'back', await source('b.png', png));
    fit.setPhotoInterval(15);

    final zip = await buildBackupZip();
    final names = ZipDecoder().decodeBytes(zip).files.map((f) => f.name);
    expect(names, contains('media/progress/2026-02-01-front.png'));
    expect(names, contains('media/progress/2026-02-01-back.png'));

    fit.resetAllData();
    expect(await restoreBackupZip(zip), true);

    final entry = fit.timeline.single;
    expect(entry.date, DateTime(2026, 2, 1));
    expect(entry.shots.keys, containsAll(['front', 'back']));
    expect(await MediaStore.readBytes(entry.shot('front')!), png);
    expect(fit.photoIntervalDays, 15);
  });

  test('a day whose photos are missing from the zip is dropped, not left broken', () async {
    await fit.attachShot(DateTime(2026, 2, 1), 'front', await source('f.png', png));
    final zip = await buildBackupZip();
    final stripped = Archive();
    for (final f in ZipDecoder().decodeBytes(zip).files) {
      if (f.name.startsWith('media/progress/')) continue;
      final bytes = f.readBytes()!;
      stripped.addFile(ArchiveFile.noCompress(f.name, bytes.length, bytes));
    }

    fit.resetAllData();
    expect(await restoreBackupZip(ZipEncoder().encodeBytes(stripped)), true);
    expect(fit.timeline, isEmpty);
  });

  test('slugs are file-safe and keep the exercise readable', () {
    expect(slugify('Flexiones'), 'flexiones');
    expect(slugify('Press de banca — inclinado'), 'press-de-banca-inclinado');
    expect(slugify('Curl 21s / bíceps'), 'curl-21s-biceps');
    expect(slugify('...'), '');
  });

  test('looksLikeZip only accepts a real zip header', () {
    expect(looksLikeZip(Uint8List.fromList([0x50, 0x4B, 0x03, 0x04, 0])), true);
    expect(looksLikeZip(Uint8List.fromList(utf8.encode('{"profile":{}}'))), false);
  });
}
