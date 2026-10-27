import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_pdf.dart';
import 'package:gymmane/services/plan_share.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('reading plans', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    String idOf(String name) => fit.matchExerciseByName(name)!.id;

    Routine routineWith(List<String> ids, {String name = 'Push'}) {
      final id = fit.createRoutine(name);
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    test('an AI plan with weeks, days, reps, weight and supersets', () {
      final plans = parsePlan('Here you go!\n```json\n'
          '{"program": "Base", "unit": "lb", "weeks": ['
          '{"name": "Week 1", "routines": [{"name": "A", "days": ["Monday", "jue"], "exercises": ['
          '{"name": "Barbell Bench Press", "sets": 3, "reps": "8-10", "weight": 135, "rest": "2 min", "superset": true},'
          '{"name": "Barbell Bent Over Row", "sets": 3, "reps": 8}]}]},'
          '{"name": "Week 2", "routines": [{"name": "A", "exercises": ["Pull Up"]}]}]}\n```');
      expect(plans.length, 2);
      expect(plans.first.group, 'Base · Week 1');
      expect(plans.first.days, [1, 4]);
      final bench = plans.first.items.first;
      expect(bench.reps, 8);
      expect(bench.weightKg, closeTo(61.2, 0.1));
      expect(bench.restSec, 120);
      expect(bench.superset, isTrue);
      expect(plans.last.group, 'Base · Week 2');
    });

    test('a csv plan', () {
      final plans = parsePlan('routine;exercise;sets;reps;weight\n'
          'Push;Barbell Bench Press;4;8;60\nPush;Push Up;3;15;\nLegs;Barbell Full Squat;5;5;100');
      expect(plans.map((p) => p.name), ['Push', 'Legs']);
      expect(plans.first.items.first.weightKg, 60);
      expect(plans.last.items.single.sets, 5);
    });

    test('prose with commas is not taken for a plan', () {
      expect(parsePlan('Sure, here is your routine, enjoy it'), isEmpty);
    });

    test('importing builds planned sets, supersets and the week, once', () {
      final text = '{"routines": [{"name": "Upper", "days": [2], "exercises": ['
          '{"name": "Barbell Bench Press", "sets": 2, "reps": 8, "weight": 60, "superset": true,'
          ' "plan": [{"type": "warmup", "reps": 10, "weight": 30}]},'
          '{"name": "Barbell Bent Over Row", "sets": 3}]}]}';
      final plans = parsePlan(text);
      final first = fit.applyPlan(plans, schedule: true);
      expect(first.routines, 1);
      final r = fit.routines.single;
      final bench = idOf('Barbell Bench Press');
      expect(fit.plannedSets(r, bench).map((p) => p.kind), [SetKind.warmup, SetKind.normal, SetKind.normal]);
      expect(fit.routineSets(r, bench), 2);
      expect(fit.routineSets(r, idOf('Barbell Bent Over Row')), 3);
      expect(r.chained, contains(bench));
      expect(fit.weeklyPlan[2], r.id);
      final again = fit.applyPlan(plans);
      expect(again.routines, 0);
      expect(fit.routines.length, 1);
    });

    test('a shared plan round-trips to another phone, custom exercises included', () {
      final mine = fit.addCustomExercise(
          name: 'Landmine Twist', primary: 'obliques', equipment: 'Barbell', steps: ['Twist']);
      final bench = idOf('Barbell Bench Press');
      final r = routineWith([bench, mine], name: 'Mixed');
      fit.setRoutineGroup(r.id, 'Couple');
      fit.setPlannedSets(r.id, bench, const [PlannedSet(reps: 8, weightKg: 50)]);
      fit.assignRoutineToDay(3, r.id);
      final json = fit.exportPlanJson([r]);
      expect(jsonDecode(json)['gymmane'], 'plan');
      expect(fit.planSummaryText([r]), contains('Mixed'));

      fit.resetAllData();
      final result = fit.applyPlan(parsePlan(json), schedule: true);
      expect(result.routines, 1);
      expect(result.missed, isEmpty);
      final got = fit.routines.single;
      expect(got.name, 'Mixed');
      expect(got.group, 'Couple');
      expect(fit.plannedSets(got, bench).single.weightKg, 50);
      final twist = fit.customExercises.single;
      expect(twist.name, 'Landmine Twist');
      expect(twist.steps, ['Twist']);
      expect(got.exerciseIds, [bench, twist.id]);
      expect(fit.weeklyPlan[3], got.id);
    });

    test('the request for an AI carries the format', () {
      final text = fit.planRequestText();
      expect(text, contains('"weeks"'));
      expect(text, contains('Barbell Bench Press'));
    });
  });

  group('plan en PDF', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    testWidgets('sale un PDF válido con una página por cada tanda', (tester) async {
      setAppLanguage('es');
      final id = fit.createRoutine('Empuje');
      for (final name in ['Bench Press', 'Barbell Squat', 'Barbell Bent Over Row']) {
        fit.toggleRoutineExercise(id, fit.matchExerciseByName(name)!.id);
      }
      fit.assignRoutineToDay(DateTime.monday, id);
      final bytes = await tester.runAsync(() => buildPlanPdf(fit.routines, week: true));
      await tester.pump(const Duration(seconds: 1));
      final text = latin1.decode(bytes!);
      expect(text.startsWith('%PDF-1.4'), isTrue);
      expect(text.trimRight().endsWith('%%EOF'), isTrue);
      expect(RegExp(r'/Type /Page ').allMatches(text).length, 1);
      String hex(String v) => '<FEFF${v.codeUnits.map((u) => u.toRadixString(16).padLeft(4, '0').toUpperCase()).join()}>';
      expect(text, contains('/Author ${hex('InlitX')}'));
      expect(text, contains('/Lang (es)'));
      expect(text, contains('<dc:creator><rdf:Seq><rdf:li>InlitX</rdf:li></rdf:Seq></dc:creator>'));
      expect(text, contains('<xmp:CreatorTool>GymMane</xmp:CreatorTool>'));
      final xref = int.parse(RegExp(r'startxref\n(\d+)').firstMatch(text)!.group(1)!);
      expect(text.substring(xref, xref + 4), 'xref');
      for (final m in RegExp(r'(\d{10}) 00000 n ').allMatches(text)) {
        final at = int.parse(m.group(1)!);
        expect(RegExp(r'^\d+ 0 obj').hasMatch(text.substring(at, at + 12)), isTrue);
      }
    });

    testWidgets('una rutina larga pasa a otra página', (tester) async {
      setAppLanguage('es');
      final id = fit.createRoutine('Larga');
      for (final e in fit.allExercises.take(24)) {
        fit.toggleRoutineExercise(id, e.id);
      }
      final bytes = await tester.runAsync(() => buildPlanPdf([fit.routines.single]));
      await tester.pump(const Duration(seconds: 1));
      final pages = RegExp(r'/Type /Page ').allMatches(latin1.decode(bytes!)).length;
      expect(pages, greaterThan(1));
    });
  });

  group('importar una rutina que ya tienes', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
    });

    String own() {
      final id = fit.createRoutine('Push');
      fit.toggleRoutineExercise(id, fit.matchExerciseByName('Barbell Bench Press')!.id);
      return fit.exportPlanJson(fit.routines);
    }

    test('la vista previa sabe que ya la tienes', () {
      final plans = parsePlan(own());
      final preview = fit.previewPlan(plans);
      expect(preview.routines, 1);
      expect(preview.owned, 1);
      expect(fit.ownsPlan(plans.single), isTrue);
    });

    test('como copia se añade otra vez', () {
      final plans = parsePlan(own());
      expect(fit.applyPlan(plans).routines, 0);
      expect(fit.applyPlan(plans, copies: true).routines, 1);
      expect(fit.routines.length, 2);
    });

    test('en otro móvil se importa normal', () {
      final json = own();
      fit.resetAllData();
      final plans = parsePlan(json);
      expect(fit.previewPlan(plans).owned, 0);
      expect(fit.applyPlan(plans).routines, 1);
    });
  });

  group('texto para la IA', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    String idOf(String name) => fit.matchExerciseByName(name)!.id;

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = 'push', String primary = 'chest'}) =>
        LoggedSession(at, 600, [LoggedExercise(id, id, primary, sets)]);

    test('un usuario nuevo pide empezar suave y que le pregunten', () {
      final text = fit.planRequestText();
      expect(text, contains(t.planNoHistory));
      expect(text, contains(t.planAskFirst));
      expect(text, contains(t.planDays(fit.weeklyTarget)));
    });

    test('con historial lleva los entrenos y las mejores series', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 100)], id: idOf('Barbell Bench Press')));
      final text = fit.planRequestText();
      expect(text, isNot(contains(t.planNoHistory)));
      expect(text, contains(t.planHistory(1)));
      expect(text, contains(t.planBestLifts));
    });
  });
}
