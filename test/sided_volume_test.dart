import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/live_session.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
  });

  tearDown(() => fit.saveAndExit());

  void start({bool paired = false, int? right}) {
    final id = fit.matchExerciseByName('Dumbbell Curl')!.id;
    if (paired) fit.togglePaired(id);
    fit.session = WorkoutSession()
      ..exercises = [
        SessionExercise(id, 'Curl', 'biceps', [SessionSet(10, 10, true, repsR: right)]),
      ];
  }

  for (final paired in [false, true]) {
    for (final right in [0, 8, 10]) {
      test('separate reps count once: paired=$paired, right=$right', () {
        start(paired: paired, right: right);
        final expected = 10.0 * (10 + right);
        expect(fit.sessionVolumeKg, expected);
        fit.finishSession();
        final session = fit.filedSession!;
        final set = session.exercises.single.sets.single;
        expect(set.reps, right);
        expect(set.weight, 10);
        expect(set.oneRm, LoggedSet(right, 10).oneRm);
        expect(session.volume, expected);
        expect(fit.session!.summaryVolume, expected);
        expect(LoggedSession.fromJson(session.toJson()).volume, expected);
        fit.togglePaired(session.exercises.single.id);
        expect(session.volume, expected);
      });
    }
  }

  test('paired reps, warmups and single load share the same saved calculation', () {
    start(paired: true);
    final e = fit.session!.exercises.single;
    e.sets.add(SessionSet(20, 100, true, kind: SetKind.warmup));
    expect(fit.sessionVolumeKg, 200);
    fit.finishSession();
    expect(fit.filedSession!.volume, 200);
    fit.togglePaired(e.id);
    expect(fit.filedSession!.volume, 200);
    fit.saveAndExit();
    start();
    expect(fit.sessionVolumeKg, 100);
    fit.finishSession();
    expect(fit.filedSession!.volume, 100);
  });

  for (final paired in [false, true]) {
    test('legacy records and pairing survive settings, backup and resume: $paired', () {
      final id = fit.matchExerciseByName('Dumbbell Curl')!.id;
      final old = LoggedSession(DateTime(2026, 10, 1), 600, [
        LoggedExercise(id, 'Curl', 'biceps', [LoggedSet(8, 10, left: 10, right: 8)]),
      ]).toJson();
      final backup = fit.toJson()..remove('legacyPairOn');
      backup['pairOn'] = paired ? [id] : <String>[];
      backup['sessions'] = [old];
      expect(fit.importJson(jsonEncode(backup)), isTrue);
      final expected = paired ? 160.0 : 80.0;
      expect(fit.totalVolumeKg, expected);
      fit.togglePaired(id);
      expect(fit.totalVolumeKg, expected);
      expect(fit.sessions.single.toJson(), old);
      final exported = fit.exportJson();
      fit.resetAllData();
      expect(fit.importJson(exported), isTrue);
      expect(fit.totalVolumeKg, expected);
      expect(fit.sessions.single.toJson(), old);
      fit.resumeLoggedSession(fit.sessions.single);
      fit.session = WorkoutSession.fromJson(fit.session!.toJson());
      expect(fit.sessionVolumeKg, expected);
      fit.finishSession();
      expect(fit.filedSession!.volume, expected);
      expect(fit.filedSession!.exercises.single.toJson(), (old['ex'] as List).single);
    });
  }

  test('history edits and resume retain the saved new convention', () {
    start(paired: true, right: 8);
    fit.finishSession();
    final logged = fit.filedSession!;
    final e = logged.exercises.single;
    fit.setLoggedReps(e, 0, 9);
    expect(e.volume, 180);
    fit.setLoggedWeight(e, 0, 12);
    expect(e.volume, 216);
    fit.togglePaired(e.id);
    fit.saveAndExit();
    fit.resumeLoggedSession(logged);
    expect(fit.sessionVolumeKg, 216);
    fit.finishSession();
    expect(fit.filedSession!.volume, 216);
    final backup = fit.exportJson();
    fit.resetAllData();
    expect(fit.importJson(backup), isTrue);
    expect(fit.totalVolumeKg, 216);
  });

  test('continuing a filed workout preserves its saved pairing', () {
    start(paired: true);
    fit.finishSession();
    final id = fit.filedSession!.exercises.single.id;
    fit.togglePaired(id);
    fit.continueSession();
    expect(fit.sessionVolumeKg, 200);
    fit.finishSession();
    expect(fit.filedSession!.volume, 200);
  });

  test('comparison uses the same total as the session and history', () {
    start(paired: true, right: 8);
    fit.finishSession();
    fit.saveAndExit();
    start(right: 10);
    expect(fit.raceRows.single.then, 180);
    expect(fit.raceRows.single.now, 200);
  });
}
