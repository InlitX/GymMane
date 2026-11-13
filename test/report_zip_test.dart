import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/health_metrics.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/report_zip.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:gymmane/widgets/report_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> filesOf(Uint8List bytes) => {
  for (final file in ZipDecoder().decodeBytes(bytes)) file.name: utf8.decode(file.content),
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    setAppLanguage('en');
  });

  test('selected CSVs respect the date range and distinguish missing data from zero', () {
    final start = DateTime(2026, 11, 9);
    final end = DateTime(2026, 11, 11);
    const stamp = '2026-11-09_2026-11-11';
    fit.stepsByDay.addAll({'2026-11-08': 9000, '2026-11-09': 8000, '2026-11-11': 0, '2026-11-12': 7000});
    fit.healthByDay[HealthMetric.sleep] = {
      '2026-11-08': [455],
      '2026-11-10': [431.5],
      '2026-11-11': [],
      '2026-11-12': [482],
    };
    fit.supplements.add(const Supplement(id: 's', name: 'Vitamin, "D"', dose: '10 mcg'));
    fit.supplementsTaken.addAll({
      '2026-11-08': {'s'},
      '2026-11-09': {'s'},
      '2026-11-11': {'s'},
      '2026-11-12': {'s'},
    });
    fit.bodyweight.addAll([
      BodyweightEntry(DateTime(2026, 11, 8, 23), 89.9),
      BodyweightEntry(DateTime(2026, 11, 11, 19), 89.1, note: 'Private note'),
      BodyweightEntry(DateTime(2026, 11, 9, 7), 89.2),
      BodyweightEntry(DateTime(2026, 11, 9, 9), 89.3),
      BodyweightEntry(DateTime(2026, 11, 12), 88.8),
    ]);

    final r = fit.rangeReport(start, end);
    final files = filesOf(
      buildReportZip(r, {
        ReportSection.steps,
        ReportSection.sleep,
        ReportSection.supplements,
        ReportSection.weighIns,
      }),
    );
    expect(
      files.keys,
      unorderedEquals([
        'gymmane-steps-$stamp.csv',
        'gymmane-sleep-$stamp.csv',
        'gymmane-supplements-$stamp.csv',
        'gymmane-weigh-ins-$stamp.csv',
      ]),
    );
    expect(files['gymmane-steps-$stamp.csv'], 'date,steps\n2026-11-09,8000\n2026-11-10,\n2026-11-11,0\n');
    expect(
      files['gymmane-sleep-$stamp.csv'],
      'date,sleep_minutes\n2026-11-09,\n2026-11-10,431.5\n2026-11-11,\n',
    );
    expect(
      files['gymmane-supplements-$stamp.csv'],
      'date,supplement\n2026-11-09,"Vitamin, ""D"""\n2026-11-11,"Vitamin, ""D"""\n',
    );
    expect(
      files['gymmane-weigh-ins-$stamp.csv'],
      'date,recorded_at,weight_kg\n'
      '2026-11-09,2026-11-09T07:00:00.000,89.2\n'
      '2026-11-09,2026-11-09T09:00:00.000,89.3\n'
      '2026-11-11,2026-11-11T19:00:00.000,89.1\n',
    );
  });

  test('keeps the existing CSVs and puts workout metadata in a separate file', () {
    const stamp = '2026-11-09_2026-11-09';
    final day = DateTime(2026, 11, 9);
    fit.sessions.add(
      LoggedSession(
        DateTime(2026, 11, 10, 0, 15),
        1800,
        [
          LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(8, 50)]),
        ],
        name: 'Upper, "A"',
        hrAvg: 108,
        sleep: 4,
        energy: 3,
      ),
    );
    fit.sessions.add(LoggedSession(DateTime(2026, 11, 10, 1), 300, [], name: 'Outside the range'));
    fit.foodLog.add(
      FoodEntry(
        id: 'f',
        at: day,
        meal: Meal.breakfast,
        name: 'Food',
        per: const Macros(kcal: 200, protein: 20),
      ),
    );
    final r = fit.rangeReport(day, day);
    final files = filesOf(
      buildReportZip(r, {ReportSection.workouts, ReportSection.nutrition, ReportSection.sessions}),
    );
    expect(files['gymmane-workouts-$stamp.csv'], fit.reportWorkoutsCsv(r));
    expect(files['gymmane-nutrition-$stamp.csv'], fit.reportNutritionCsv(r));
    expect(files['gymmane-nutrition-$stamp.csv'], contains('2026-11-09,200,20,'));
    expect(
      files['gymmane-sessions-$stamp.csv'],
      contains(
        '2026-11-09,2026-11-09T23:45:00.000,2026-11-10T00:15:00.000,"Upper, ""A""",1800,1,1,400.0,108,,4,3,false\n',
      ),
    );
    expect(files['gymmane-sessions-$stamp.csv'], isNot(contains('Outside the range')));
  });

  testWidgets('the section picker is available for ranges without workouts or food', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const Scaffold(body: ReportSheet()),
      ),
    );
    await tester.tap(find.text(t.reportExportZip));
    await tester.pumpAndSettle();
    expect(find.byType(CheckboxListTile), findsNWidgets(ReportSection.values.length));

    await tester.tap(find.widgetWithText(CheckboxListTile, 'Workouts'));
    await tester.tap(find.widgetWithText(CheckboxListTile, t.nutrition));
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed, isNull);

    await tester.tap(find.widgetWithText(CheckboxListTile, t.homeCardSteps));
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed, isNotNull);
    expect(tester.takeException(), isNull);
  });
}
