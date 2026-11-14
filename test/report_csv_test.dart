import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_pdf.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:gymmane/widgets/report_sheet.dart';
import 'package:gymmane/widgets/ui_kit.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestPathProvider extends PathProviderPlatform {
  _TestPathProvider(this.path);

  final String path;

  @override
  Future<String?> getTemporaryPath() async => path;
}

class _TestShare extends SharePlatform {
  Completer<List<String>>? pending;

  @override
  Future<ShareResult> share(ShareParams params) async {
    final files = params.files!;
    expect(files.map((file) => file.mimeType), everyElement('text/csv'));
    expect(files.every((file) => File(file.path).existsSync()), isTrue);
    pending!.complete(files.map((file) => File(file.path).uri.pathSegments.last).toList());
    return const ShareResult('', ShareResultStatus.dismissed);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final share = _TestShare();
  final originalShare = SharePlatform.instance;
  setUpAll(() => SharePlatform.instance = share);
  tearDownAll(() => SharePlatform.instance = originalShare);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    setAppLanguage('en');
  });

  Future<List<String>> captureSharedFiles(Future<void> Function() triggerShare) async {
    final directory = Directory.systemTemp.createTempSync('gymmane_report_csv');
    final shared = Completer<List<String>>();
    final originalPaths = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _TestPathProvider(directory.path);
    share.pending = shared;
    addTearDown(() {
      PathProviderPlatform.instance = originalPaths;
      share.pending = null;
      directory.deleteSync(recursive: true);
    });
    await triggerShare();
    expect(shared.isCompleted, isTrue);
    return shared.future;
  }

  Future<void> showReport(WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const Scaffold(body: ReportSheet()),
      ),
    );
  }

  test('only offers sections with exportable data in the date range', () {
    final start = DateTime(2026, 11, 9);
    final end = DateTime(2026, 11, 11);
    fit.supplements.add(const Supplement(id: 's', name: 'Vitamin D', dose: '10 mcg'));
    fit.supplementsTaken.addAll({
      '2026-11-08': {'s'},
      '2026-11-10': {'unknown'},
      '2026-11-12': {'s'},
    });
    fit.bodyweight.add(BodyweightEntry(DateTime(2026, 11, 8), 89.9));
    fit.sessions.add(LoggedSession(start, 1800, []));
    expect(fit.reportCsvSections(fit.rangeReport(start, end)), isEmpty);

    fit.sessions.add(LoggedSession(DateTime(2026, 11, 9, 8), 1800, []));
    fit.waterLog.add(WaterSip(end, 250));
    expect(fit.reportCsvSections(fit.rangeReport(start, end)), {
      ReportSection.nutrition,
      ReportSection.sessions,
    });
  });

  test('exports supplement check-offs and individual weigh-ins within inclusive dates', () {
    final start = DateTime(2026, 11, 9);
    final end = DateTime(2026, 11, 11);
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
    expect(fit.reportCsvSections(r), {ReportSection.supplements, ReportSection.weighIns});
    expect(
      fit.reportSectionCsv(r, ReportSection.supplements),
      'date,supplement\n2026-11-09,"Vitamin, ""D"""\n2026-11-11,"Vitamin, ""D"""\n',
    );
    expect(
      fit.reportSectionCsv(r, ReportSection.weighIns),
      'date,recorded_at,weight_kg\n'
      '2026-11-09,2026-11-09T07:00:00.000,89.2\n'
      '2026-11-09,2026-11-09T09:00:00.000,89.3\n'
      '2026-11-11,2026-11-11T19:00:00.000,89.1\n',
    );
  });

  test('preserves the existing formats and exports sessions by their start date', () {
    final day = DateTime(2026, 11, 9);
    final session = LoggedSession(
      DateTime(2026, 11, 10, 0, 15),
      1800,
      [
        LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(8, 50)]),
      ],
      name: 'Upper, "A"',
      hrAvg: 108,
      sleep: 4,
      energy: 3,
    );
    fit.sessions.add(session);
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
    expect(fit.reportCsvSections(r), {
      ReportSection.workouts,
      ReportSection.nutrition,
      ReportSection.sessions,
    });
    expect(fit.reportSectionCsv(r, ReportSection.workouts), Store.instance.exportCsv([session]));
    expect(
      fit.reportSectionCsv(r, ReportSection.nutrition),
      'date,kcal,protein_g,carbs_g,fat_g,fiber_g,water_ml,foods\n2026-11-09,200,20,0,0,0,0,1\n',
    );
    expect(fit.reportSectionCsv(r, ReportSection.sessions).split('\n').skip(1), [
      '2026-11-09,2026-11-09T23:45:00.000,2026-11-10T00:15:00.000,"Upper, ""A""",1800,1,1,400.0,108,,4,3,false',
      '',
    ]);
  });

  test('the share service writes only selected CSV attachments', () async {
    final day = DateTime(2026, 11, 9);
    final report = fit.rangeReport(day, day);
    final paths = await captureSharedFiles(
      () => shareReport(report, csv: {ReportSection.weighIns, ReportSection.sessions}),
    );
    expect(paths, [
      'gymmane-weigh-ins-2026-11-09_2026-11-09.csv',
      'gymmane-sessions-2026-11-09_2026-11-09.csv',
    ]);
  });

  testWidgets('the CSV picker defaults to workouts and nutrition and can toggle each option', (tester) async {
    final today = DateTime.now();
    fit.sessions.add(
      LoggedSession(DateTime(today.year, today.month, today.day, 12), 600, [
        LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(8, 50)]),
      ]),
    );
    fit.bodyweight.add(BodyweightEntry(today, 89.2));
    fit.foodLog.add(
      FoodEntry(id: 'f', at: today, meal: Meal.breakfast, name: 'Food', per: const Macros(kcal: 200)),
    );
    await showReport(tester);
    await tester.tap(find.byType(GhostButton));
    await tester.pumpAndSettle();
    final picker = find.byType(AppSheet);
    final rows = find.descendant(of: picker, matching: find.byType(TinySwitch));
    expect(tester.widgetList<TinySwitch>(rows).map((w) => w.on), [true, true, false, false]);
    expect(find.text(titleCase(t.supplementsLabel)), findsNothing);

    await tester.tap(find.text(titleCase(t.reportWorkouts)));
    await tester.tap(find.text(t.nutrition));
    await tester.pumpAndSettle();
    final action = find.descendant(of: picker, matching: find.byType(PrimaryButton));
    expect(tester.widget<PrimaryButton>(action).onTap, isNull);
    await tester.tap(find.text(t.reportWeighIns));
    await tester.tap(find.text(t.reportSessionDetails));
    await tester.pumpAndSettle();
    expect(tester.widgetList<TinySwitch>(rows).map((w) => w.on), [false, false, true, true]);
    expect(tester.widget<PrimaryButton>(action).onTap, isNotNull);
    Navigator.of(tester.element(picker)).pop();
    await tester.pumpAndSettle();
  });

  testWidgets('a supplement-only report shares directly', (tester) async {
    final today = DateTime.now();
    fit.supplements.add(const Supplement(id: 's', name: 'Vitamin D', dose: '10 mcg'));
    fit.supplementsTaken[today.toIso8601String().split('T').first] = {'s'};
    await showReport(tester);
    expect(find.text(t.reportEmpty), findsNothing);
    final export = tester.widget<GhostButton>(find.byType(GhostButton));
    final paths = await tester.runAsync(
      () => captureSharedFiles(() async {
        export.onTap();
        await share.pending!.future.timeout(const Duration(seconds: 5));
      }),
    );
    expect(find.byType(OptionGroup), findsNothing);
    expect(paths!.single, startsWith('gymmane-supplements-'));
    await tester.pumpAndSettle();
  });
}
