import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/measure.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/report_doc.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/health_metrics.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_pdf.dart';
import 'package:gymmane/services/report_content.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:gymmane/widgets/report_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  DateTime ago(int d, [int hour = 0]) => DateTime(today.year, today.month, today.day - d, hour);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.setUnits('kg');
    setAppLanguage('en');
    fit.nutritionBeta = true;
  });

  void lift(int daysAgo, double kg, {String note = ''}) {
    fit.sessions.add(LoggedSession(
      ago(daysAgo, 19),
      3600,
      [
        LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [
          LoggedSet(5, kg, rpe: 8, note: note),
          LoggedSet(5, kg, kind: SetKind.warmup),
        ]),
      ],
      sleep: 4,
      energy: 3,
    ));
    fit.sessions.sort((a, b) => a.date.compareTo(b.date));
  }

  void eat(int daysAgo, String name, Macros m, {Meal meal = Meal.lunch}) {
    fit.setNutritionDay(ago(daysAgo));
    fit.logQuick(name, m, meal: meal);
  }

  RangeReport range(int days) => fit.rangeReport(ago(days - 1), today);

  group('informes', () {
    test('entrenamiento: cada entreno con sus series, RPE, tipo y nota', () {
      lift(3, 100, note: 'Felt easy');
      lift(1, 102.5);
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.training));
      expect(md, contains('# ${reportRangeLabel(range(7))}'));
      expect(md, contains('DETAILED TRAINING REPORT'));
      expect(md, contains('## Workout log'));
      expect(md, contains('### ${t.longDate(ago(3))}'));
      expect(md, contains('- 1. 100 kg × 5 @8 — Felt easy'));
      expect(md, contains('(Warm-up)'));
      expect(md, contains('Sleep 4/5'));
      expect(md, isNot(contains('## Food log')));
      expect('### '.allMatches(md).length, 2);
    });

    test('nutrición: objetivos, totales por día, comidas y días en objetivo', () {
      fit.setNutritionGoals(const NutritionGoals(kcal: 2000, protein: 150, carbs: 200, fat: 60));
      eat(2, 'Rice and chicken', const Macros(kcal: 1950, protein: 160, carbs: 200, fat: 50));
      eat(1, 'Pizza', const Macros(kcal: 1200, protein: 40, carbs: 150, fat: 45), meal: Meal.dinner);
      eat(1, 'Yogurt', const Macros(kcal: 150, protein: 15, carbs: 10, fat: 4), meal: Meal.breakfast);
      lift(1, 100);
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.nutrition));
      expect(md, contains('NUTRITION REPORT'));
      expect(md, contains('- Daily goal: **2000 kcal · P 150 · C 200 · F 60 g**'));
      expect(md, contains('- Days within 10 % of the calorie goal: **1 / 2**'));
      expect(md, contains('- Days reaching the protein goal: **1 / 2**'));
      expect(md, contains('| ${t.shortDate(ago(2))} | 1950 | 160 | 200 | 50 | – |'));
      expect(md, contains('**Breakfast** · 150 kcal'));
      expect(md.indexOf('**Breakfast**'), lessThan(md.indexOf('**Dinner**')), reason: 'las comidas van en su orden del día');
      expect(md, contains('- Pizza · 1200 kcal · P 40 · C 150 · F 45 g'));
      expect(md, isNot(contains('Barbell Bench Press')), reason: 'el de nutrición no lleva entrenos');
    });

    test('todo: día a día con entreno, comida, peso y salud', () {
      lift(1, 100);
      eat(1, 'Oats', const Macros(kcal: 400, protein: 15, carbs: 60, fat: 8), meal: Meal.breakfast);
      fit.bodyweight.add(BodyweightEntry(ago(1, 8), 81.4));
      fit.healthShown.add(HealthMetric.restingHr);
      fit.healthByDay[HealthMetric.restingHr] = {HealthMetrics.dayKey(ago(1)): [57]};
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.full));
      expect(md, contains('COMPLETE REPORT'));
      expect(md, contains('## Day by day'));
      final day = md.substring(md.indexOf('### ${t.longDate(ago(1))}'));
      expect(day, contains('Barbell Bench Press'));
      expect(day, contains('**Breakfast** · 400 kcal'));
      expect(day, contains('- Bodyweight 81.4 kg · Resting heart rate 57 bpm'));
      expect(md, contains('## Health · daily average'));
    });

    test('el resumen se queda como estaba: sin día a día ni datos personales', () {
      lift(40, 100);
      lift(3, 105);
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.summary));
      expect(md, contains('TRAINING REPORT'));
      expect(md, contains('## New records'));
      expect(md, contains('| Barbell Bench Press | 105 kg |'));
      expect(md, contains('## Exercises'));
      expect(md, isNot(contains('###')));
      final header = reportBlocks(range(7), ReportKind.summary).first as RepHeader;
      expect(header.about, isEmpty);
      final coach = reportBlocks(range(7), ReportKind.training).first as RepHeader;
      expect(coach.about, isNotEmpty);
    });

    test('las medidas del periodo van de la primera a la última', () {
      fit.measures.addAll([
        BodyMeasure(ago(6), 'waist', 84),
        BodyMeasure(ago(1), 'waist', 82),
        BodyMeasure(ago(20), 'waist', 90),
      ]);
      final md = reportMarkdown(reportBlocks(range(7), ReportKind.full));
      expect(md, contains('**84 cm → 82 cm**'));
    });

    test('un nombre con barra no rompe la tabla en Markdown', () {
      eat(1, 'A | B', const Macros(kcal: 100));
      final md = reportMarkdown([
        const RepTable(head: ['A|B', 'X'], rows: [['1|2', '3']], widths: [1, 1]),
      ]);
      expect(md, contains(r'| A\|B | X |'));
      expect(md, contains(r'| 1\|2 | 3 |'));
    });

    testWidgets('los cuatro PDF se generan y el detallado ocupa varias páginas', (tester) async {
      for (var d = 0; d < 20; d++) {
        lift(d, 100);
        eat(d, 'Meal $d', const Macros(kcal: 2000, protein: 120, carbs: 200, fat: 60));
      }
      for (final kind in ReportKind.values) {
        final bytes = await tester.runAsync(() => buildReportPdf(range(30), kind: kind));
        final text = latin1.decode(bytes!);
        expect(text.startsWith('%PDF-1.4'), isTrue, reason: kind.name);
        final pages = RegExp(r'/Type /Page ').allMatches(text).length;
        if (kind == ReportKind.summary) {
          expect(pages, 1);
        } else {
          expect(pages, greaterThan(2), reason: kind.name);
        }
      }
      expect(reportFileStem(range(7), ReportKind.nutrition), startsWith('gymmane-nutrition-'));
      await tester.pump(const Duration(seconds: 5));
    });
  });

  group('copiar el día de nutrición', () {
    test('solo la comida, o el día entero con entreno', () {
      eat(0, 'Eggs', const Macros(kcal: 300, protein: 20, carbs: 2, fat: 22), meal: Meal.breakfast);
      expect(dayHasMore(today), isFalse);
      final food = dayMarkdown(today, full: false);
      expect(food, startsWith('### ${t.longDate(today)}'));
      expect(food, contains('_300 / '));
      expect(food, contains('- Eggs · 300 kcal · P 20 · C 2 · F 22 g'));
      lift(0, 100);
      expect(dayHasMore(today), isTrue);
      final all = dayMarkdown(today, full: true);
      expect(all, contains('Barbell Bench Press'));
      expect(all, contains('#### Nutrition · 300 / '));
      expect(food, isNot(contains('Barbell')));
    });

    test('los nombres de comida y raciones salen igual que en la pantalla', () {
      fit.mealSlots[0] = const MealSlot(Meal.breakfast, name: 'Pre-gym');
      expect(fit.mealLabel(Meal.breakfast), 'Pre-gym');
      expect(fit.mealLabel(Meal.dinner), 'Dinner');
      final food = fit.saveFood(name: 'Whey', serving: '30 g', macros: const Macros(kcal: 120, protein: 24));
      final e = fit.logFood(food, servings: 2, meal: Meal.snacks);
      expect(fit.servingLabel(e), '2 × 30 g');
      expect(fit.amountLabel(150, false), '150 g');
      fit.setUnits('lb');
      expect(fit.amountLabel(150, false), '5.3 oz');
    });
  });

  group('tensión en Salud (#338)', () {
    test('junta las lecturas a mano con las de Health Connect', () {
      fit.healthShown.add(HealthMetric.bloodPressure);
      fit.healthByDay[HealthMetric.bloodPressure] = {HealthMetrics.dayKey(ago(3)): [130, 85]};
      fit.addPressure(120, 80, date: ago(3, 9));
      fit.addPressure(118, 76, date: ago(1, 9));
      expect(fit.healthOnDay(HealthMetric.bloodPressure, ago(3)), [125, 82.5]);
      final latest = fit.healthLatest(HealthMetric.bloodPressure)!;
      expect(latest.day, ago(1));
      expect(latest.values, [118, 76]);
      expect(fit.healthOnDay(HealthMetric.restingHr, ago(1)), isNull);
    });

    test('sin lecturas a mano queda como antes', () {
      fit.healthByDay[HealthMetric.bloodPressure] = {HealthMetrics.dayKey(ago(2)): [121, 79]};
      expect(fit.healthOnDay(HealthMetric.bloodPressure, ago(2)), [121, 79]);
      expect(fit.healthLatest(HealthMetric.bloodPressure)!.values, [121, 79]);
      expect(fit.healthLatest(HealthMetric.hrv), isNull);
    });
  });

  testWidgets('la hoja del informe cambia de tipo, recorta a 92 días y copia el Markdown', (tester) async {
    lift(2, 100);
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 1400);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(theme: AppTheme.dark, home: const Scaffold(body: ReportSheet())));
    expect(find.text('Summary'), findsOneWidget);
    expect(find.text(t.days365), findsOneWidget);
    await tester.tap(find.text(t.days365));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Training'));
    await tester.pumpAndSettle();
    expect(find.text(t.days7), findsOneWidget, reason: 'los detallados van por semanas o meses');
    expect(find.text(t.days365), findsNothing);
    await tester.tap(find.text('Copy as Markdown'));
    await tester.pumpAndSettle();
    expect(copied, contains('DETAILED TRAINING REPORT'));
    expect(copied, contains('## Workout log'));
    await tester.pump(const Duration(seconds: 5));
  });
}
