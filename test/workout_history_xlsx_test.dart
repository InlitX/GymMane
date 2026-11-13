import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/workout_history_xlsx.dart';

void main() {
  test('creates a readable XLSX with every logged set and numeric cells', () {
    final newer = LoggedSession(DateTime(2026, 11, 13, 15), 1800, [
      LoggedExercise(
        'run',
        'Run & Walk',
        'cardio',
        [LoggedSet(0, 0, sec: 1800, km: 5.25, note: 'steady < pace')],
      ),
    ], name: 'Outdoor session');
    final older = LoggedSession(DateTime(2026, 11, 12, 15), 1800, [
      LoggedExercise(
        'bench',
        'Bench Press',
        'chest',
        [
          LoggedSet(8, 80, rpe: 8),
          LoggedSet(5, 40, kind: SetKind.warmup),
        ],
      ),
    ], name: 'Push');

    final archive = ZipDecoder().decodeBytes(workoutHistoryXlsx([newer, older]));
    final paths = archive.files.where((f) => f.isFile).map((f) => f.name).toSet();
    expect(paths, containsAll([
      '[Content_Types].xml',
      '_rels/.rels',
      'xl/workbook.xml',
      'xl/_rels/workbook.xml.rels',
      'xl/styles.xml',
      'xl/worksheets/sheet1.xml',
    ]));

    final sheetFile = archive.findFile('xl/worksheets/sheet1.xml');
    expect(sheetFile, isNotNull);
    final sheet = utf8.decode(sheetFile!.readBytes()!);
    expect(sheet, contains('Workout History'));
    expect(sheet, contains('Date'));
    expect(sheet, contains('Bench Press'));
    expect(sheet, contains('Run &amp; Walk'));
    expect(sheet, contains('steady &lt; pace'));
    expect(sheet, contains('<c r="G2"><v>80.0</v></c>'));
    expect(sheet, contains('<c r="J4"><v>5.25</v></c>'));
    expect(sheet.indexOf('2026-11-12'), lessThan(sheet.indexOf('2026-11-13')));
    expect(sheet, contains('state="frozen"'));
    expect(sheet, contains('<autoFilter ref="A1:O4"/>'));
  });

  test('creates a valid header-only workbook when there are no sessions', () {
    final archive = ZipDecoder().decodeBytes(workoutHistoryXlsx(const []));
    final sheet = utf8.decode(archive.findFile('xl/worksheets/sheet1.xml')!.readBytes()!);
    expect(sheet, contains('A1:O1'));
    expect(sheet, contains('Date'));
    expect(sheet, contains('Note'));
    expect(sheet, contains('<autoFilter ref="A1:O1"/>'));
  });
}
