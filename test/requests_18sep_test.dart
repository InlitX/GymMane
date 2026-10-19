import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/models/live_session.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_share.dart';
import 'package:gymmane/services/rest_alarm.dart';
import 'package:gymmane/services/workout_import.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  group('sets inside a live workout', () {
    test('changing a set carries over to the sets that still match it', () {
      final r = routineWith([idOf('Barbell Bench Press')]);
      fit.startRoutine(r);
      final sets = fit.session!.exercises.first.sets;
      for (var j = 0; j < sets.length; j++) {
        fit.setSessionWeight(0, j, 60);
        fit.setSessionReps(0, j, 10);
      }
      fit.setSessionWeight(0, sets.length - 1, 70);

      fit.setSessionWeight(0, 0, 62.5);
      fit.setSessionReps(0, 0, 8);
      expect(sets.first.weight, 62.5);
      for (var j = 1; j < sets.length - 1; j++) {
        expect(sets[j].weight, 62.5);
        expect(sets[j].reps, 8);
      }
      expect(sets.last.weight, 70);
      expect(sets.last.reps, 8);
    });

    test('a set can be removed and brought back', () {
      final r = routineWith([idOf('Barbell Bench Press')]);
      fit.startRoutine(r);
      final sets = fit.session!.exercises.single.sets;
      final before = sets.length;
      final gone = fit.removeSet(0, 1)!;
      expect(sets.length, before - 1);
      fit.insertSet(0, 1, gone);
      expect(sets.length, before);
      expect(identical(sets[1], gone), isTrue);
    });

    test('a warm-up added by mistake goes away in one tap', () {
      final r = routineWith([idOf('Barbell Bench Press')]);
      fit.startRoutine(r);
      final working = fit.session!.exercises.single.sets.length;
      fit.addWarmupSets(0);
      expect(fit.hasWarmup(0), isTrue);
      fit.removeWarmupSets(0);
      expect(fit.hasWarmup(0), isFalse);
      expect(fit.session!.exercises.single.sets.length, working);
    });

    test('jumping and reordering keep the exercise you are on', () {
      final ids = [idOf('Barbell Bench Press'), idOf('Barbell Full Squat'), idOf('Pull Up')];
      final r = routineWith(ids);
      fit.toggleChain(r.id, ids[0]);
      fit.startRoutine(r);
      fit.goToExercise(1);
      expect(fit.currentExercise!.id, ids[1]);
      fit.reorderSessionExercise(2, 0);
      expect(fit.session!.exercises.first.id, ids[2]);
      expect(fit.currentExercise!.id, ids[1]);
      expect(fit.session!.exercises.every((e) => !e.linkedNext || e.id != ids[2]), isTrue);
    });
  });

  group('suggestions', () {
    test('an exercise switched off never lands in the picks but stays searchable', () {
      fit.selectedMuscles
        ..clear()
        ..add('chest');
      fit.trainContinue();
      final first = fit.sessionPicks.first;
      fit.toggleSuggest(first);
      fit.trainContinue();
      expect(fit.sessionPicks.contains(first), isFalse);
      expect(fit.trainSearchResults(fit.exerciseById(first)!.name).map((e) => e.id), contains(first));
      expect(fit.recommendedExercises(20).map((e) => e.id), isNot(contains(first)));
    });

    test('the suggested picks come first in the review list', () {
      fit.selectedMuscles
        ..clear()
        ..addAll(['chest', 'triceps']);
      fit.trainContinue();
      final list = fit.reviewExercises();
      final seeded = list.take(fit.pickSeed.length).map((e) => e.id).toSet();
      expect(seeded, fit.pickSeed);
    });

    test('hidden exercises survive a restart', () {
      fit.toggleSuggest(idOf('Barbell Bench Press'));
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.suggests(idOf('Barbell Bench Press')), isFalse);
    });
  });

  group('your own exercises', () {
    test('a catalogue id starting with c is not taken for yours', () {
      expect(fit.isCustom('cycling'), isFalse);
      final mine = fit.addCustomExercise(name: 'Cable thing', primary: 'chest', equipment: 'Barbell');
      expect(fit.isCustom(mine), isTrue);
    });

    test('yours always show up, whatever place is active', () {
      final mine = fit.addCustomExercise(name: 'Mi press raro', primary: 'chest', equipment: 'Barbell');
      final home = fit.addPresetPlace('home');
      fit.setActivePlace(home);
      expect(fit.exercisesMatching('raro').map((e) => e.id), contains(mine));
    });

    test('steps and type travel through a save and back', () {
      final mine = fit.addCustomExercise(
        name: 'Row a la valla',
        primary: 'back',
        equipment: 'Other',
        steps: ['1. Grab the rail', '- Pull', '', 'Lower slowly'],
        mode: 'time',
      );
      final ex = fit.exerciseById(mine)!;
      expect(ex.steps, ['Grab the rail', 'Pull', 'Lower slowly']);
      expect(ex.mode, 'time');
      final back = Exercise.fromJson(ex.toJson());
      expect(back.steps, ex.steps);
      expect(back.mode, 'time');
      fit.updateCustomExercise(
        mine,
        name: 'Row',
        primary: 'back',
        equipment: 'Other',
        difficulty: 'Beginner',
        steps: ['Only'],
        mode: '',
      );
      expect(fit.exerciseById(mine)!.steps, ['Only']);
      expect(fit.modeOf(mine), '');
    });
  });

  group('cardio and timed work', () {
    test('a run opens with time and distance, and remembers them', () {
      final run = idOf('Outdoor Run');
      expect(fit.modeOf(run), 'cardio');
      expect(fit.restFor(run), 0);
      final r = routineWith([run]);
      expect(fit.routineSets(r, run), 1);
      fit.startRoutine(r);
      final st = fit.session!.exercises.single.sets.single;
      expect(st.sec, 1200);
      fit.setSessionKm(0, 0, 5.2);
      fit.setSessionSeconds(0, 0, 1800);
      fit.toggleSet(0, 0);
      fit.finishSession();
      fit.saveAndExit();
      final logged = fit.lastSetsFor(run).single;
      expect(logged.km, 5.2);
      expect(fit.loggedSetLabel(logged), '5.2 km · 30:00');
      fit.startRoutine(r);
      expect(fit.session!.exercises.single.sets.single.km, 5.2);
      expect(fit.nextTarget(run), isNull);
    });

    test('miles show for imperial users', () {
      fit.setUnits('lb');
      expect(fit.distanceLabel(1.609344), '1 mi');
      fit.setUnits('kg');
    });

    test('a plank opens with seconds and the hold can start and stop', () {
      final plank = idOf('Plank');
      expect(fit.modeOf(plank), 'time');
      fit.startRoutine(routineWith([plank]));
      final sets = fit.session!.exercises.single.sets;
      expect(sets.first.sec, 30);
      fit.startHold(0, 0);
      expect(fit.holding, isTrue);
      expect(fit.holdRemaining, 30);
      expect(fit.holdLead, inInclusiveRange(4, 5));
      fit.stopHold();
      expect(fit.holding, isFalse);
      expect(sets.first.done, isFalse);
    });

    test('how an exercise is logged can be changed and changed back', () {
      final rope = idOf('Jump Rope');
      expect(fit.modeOf(rope), 'time');
      fit.setExerciseMode(rope, '');
      expect(fit.modeOf(rope), '');
      fit.setExerciseMode(rope, 'time');
      expect(fit.modeOverride.containsKey(rope), isFalse);
    });

    test('timed and cardio sets keep their fields through json', () {
      final s = SessionSet(0, 20, true, sec: 45, km: null, kind: SetKind.restPause);
      final back = SessionSet.fromJson(s.toJson());
      expect(back.sec, 45);
      expect(back.kind, SetKind.restPause);
      final l = LoggedSet.fromJson(LoggedSet(0, 0, sec: 600, km: 2.5).toJson());
      expect(l.km, 2.5);
      expect(l.oneRm, 0);
    });
  });

  group('planned routines', () {
    test('planned sets open the workout with their type, reps and weight', () {
      final bench = idOf('Barbell Bench Press');
      final r = routineWith([bench]);
      fit.setPlannedSets(r.id, bench, const [
        PlannedSet(reps: 12, weightKg: 30, kind: SetKind.warmup),
        PlannedSet(reps: 8, weightKg: 70),
        PlannedSet(reps: 6, weightKg: 75, kind: SetKind.drop),
      ]);
      expect(fit.routineSets(r, bench), 2);
      fit.startRoutine(r);
      final sets = fit.session!.exercises.single.sets;
      expect(sets.map((s) => s.kind), [SetKind.warmup, SetKind.normal, SetKind.drop]);
      expect(sets.map((s) => s.reps), [12, 8, 6]);
      expect(sets.map((s) => s.weight), [30, 70, 75]);
    });

    test('the set stepper grows and shrinks the plan, never below one working set', () {
      final bench = idOf('Barbell Bench Press');
      final r = routineWith([bench]);
      fit.setPlannedSets(r.id, bench, const [
        PlannedSet(kind: SetKind.warmup),
        PlannedSet(reps: 5, weightKg: 100),
      ]);
      fit.bumpRoutineSets(r.id, bench, 2);
      expect(fit.routineSets(r, bench), 3);
      expect(fit.plannedSets(r, bench).last.weightKg, 100);
      fit.bumpRoutineSets(r.id, bench, -5);
      expect(fit.routineSets(r, bench), 1);
      expect(fit.plannedSets(r, bench).first.kind, SetKind.warmup);
    });

    test('a finished workout saved as routine keeps its sets and supersets', () {
      final ids = [idOf('Barbell Bench Press'), idOf('Barbell Bent Over Row')];
      final r = routineWith(ids);
      fit.toggleChain(r.id, ids.first);
      fit.startRoutine(r);
      fit.setSessionWeight(0, 0, 62.5);
      final saved = fit.saveSessionAsRoutine('Copy');
      final made = fit.routines.firstWhere((x) => x.id == saved);
      expect(made.chained, contains(ids.first));
      expect(fit.plannedSets(made, ids.first).first.weightKg, 62.5);
    });
  });

  group('reading plans', () {
    test('an AI plan with weeks, days, reps, weight and supersets', () {
      final plans = parsePlan(
        'Here you go!\n```json\n'
        '{"program": "Base", "unit": "lb", "weeks": ['
        '{"name": "Week 1", "routines": [{"name": "A", "days": ["Monday", "jue"], "exercises": ['
        '{"name": "Barbell Bench Press", "sets": 3, "reps": "8-10", "weight": 135, "rest": "2 min", "superset": true},'
        '{"name": "Barbell Bent Over Row", "sets": 3, "reps": 8}]}]},'
        '{"name": "Week 2", "routines": [{"name": "A", "exercises": ["Pull Up"]}]}]}\n```',
      );
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
      final plans = parsePlan(
        'routine;exercise;sets;reps;weight\n'
        'Push;Barbell Bench Press;4;8;60\nPush;Push Up;3;15;\nLegs;Barbell Full Squat;5;5;100',
      );
      expect(plans.map((p) => p.name), ['Push', 'Legs']);
      expect(plans.first.items.first.weightKg, 60);
      expect(plans.last.items.single.sets, 5);
    });

    test('prose with commas is not taken for a plan', () {
      expect(parsePlan('Sure, here is your routine, enjoy it'), isEmpty);
    });

    test('importing builds planned sets, supersets and the week, once', () {
      final text =
          '{"routines": [{"name": "Upper", "days": [2], "exercises": ['
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
        name: 'Landmine Twist',
        primary: 'obliques',
        equipment: 'Barbell',
        steps: ['Twist'],
      );
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

  group('recovery', () {
    test('nothing trained means fully recovered', () {
      expect(fit.overallRecovery(), 100);
      expect(fit.stillRecovering(), isEmpty);
    });

    test('a hard chest day tires the chest and it recovers in a few days', () {
      final now = DateTime(2026, 9, 18, 18);
      fit.sessions.add(
        LoggedSession(now.subtract(const Duration(hours: 1)), 3600, [
          LoggedExercise(idOf('Barbell Bench Press'), 'Bench', 'chest', [
            for (var i = 0; i < 8; i++) LoggedSet(8, 80, rpe: 9),
          ]),
        ]),
      );
      final fresh = fit.muscleRecovery(now: now);
      expect(fresh['chest'], lessThan(0.3));
      expect(fresh['quads'], 1);
      expect(fit.hoursUntilRecovered('chest', now: now), greaterThan(12));
      final later = fit.muscleRecovery(now: now.add(const Duration(days: 4)));
      expect(later['chest'], greaterThan(0.8));
      expect(fit.stillRecovering(now: now), contains('chest'));
    });
  });

  group('settings', () {
    test('the theme can follow the phone and older backups still load', () {
      fit.setThemePref('system');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.themePref, 'system');
      fit.applyBackup({'dark': false});
      expect(fit.themePref, 'light');
      fit.setThemePref('dark');
    });

    test('the rest alarm style is kept and handed to the alarm', () {
      fit.setAlarmStyle('vibrate');
      expect(RestAlarm.instance.style, 'vibrate');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.alarmStyle, 'vibrate');
      fit.setAlarmStyle('loud');
    });

    test('height reads in feet and inches for imperial users', () {
      fit.setUnits('lb');
      expect(fit.heightLabel(175), '5′ 9″');
      fit.setUnits('kg');
      expect(fit.heightLabel(175), '175 cm');
    });
  });

  group('lyfta', () {
    const csv =
        '﻿Title,Date,Duration,Description,Notes,Exercise,Exercise Note,Superset id,Weight,Reps,'
        'RIR/RPE,Distance,Time,Set Type,RecordLevel: gold/silver/bronze,RecordType: 1RM / max_weight / volume / reps\n'
        'Pull Day,2026-04-17 16:00:05,01:19:33,"A plan, with commas",,Barbell Bent Over Row,,,60.000,10,,,,NORMAL_SET,,\n'
        'Pull Day,2026-04-17 16:00:05,01:19:33,"A plan, with commas",,Barbell Bent Over Row,,,70.000,8,,,,NORMAL_SET,1,1\n'
        'Pull Day,2026-04-17 16:00:05,01:19:33,"A plan, with commas",,Pull Up,,,,12,,,,NORMAL_SET,,\n';

    test('the export is recognised and read', () {
      expect(detectFormat(csv), ImportFormat.lyfta);
      final result = parseImport(csv);
      final session = result.sessions.single;
      expect(session.durationSec, 3600 + 19 * 60 + 33);
      expect(session.exercises.first.sets.map((s) => s.weightKg), [60, 70]);
      expect(session.exercises.last.name, 'Pull Up');
    });
  });
}
