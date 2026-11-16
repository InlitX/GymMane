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
    for (final right in [0, 8, 10, 12]) {
      test('both sides count once: paired=$paired, right=$right', () {
        start(paired: paired, right: right);
        final expected = 10.0 * (10 + right);
        expect(fit.sessionVolumeKg, expected);
        fit.finishSession();
        final session = fit.filedSession!;
        final set = session.exercises.single.sets.single;
        final weak = right < 10 ? right : 10;
        expect(set.reps, weak);
        expect(set.weight, 10);
        expect(set.oneRm, LoggedSet(weak, 10).oneRm);
        expect(session.volume, expected);
        expect(fit.session!.summaryVolume, expected);
        expect(LoggedSession.fromJson(session.toJson()).volume, expected);
        expect(set.toJson(), {'r': weak, 'w': 10.0, 'rl': 10, 'rr': right});
        fit.togglePaired(session.exercises.single.id);
        expect(session.volume, expected);
      });
    }
  }

  test('mixed sets retain paired behavior for ordinary reps and exclude warmups', () {
    final id = fit.matchExerciseByName('Dumbbell Curl')!.id;
    final exercise = LoggedExercise(id, 'Curl', 'biceps', [
      LoggedSet(8, 10, left: 10, right: 8),
      LoggedSet(10, 10),
      LoggedSet(20, 100, left: 20, right: 20, kind: SetKind.warmup),
    ]);
    expect(exercise.volume, 280);
    fit.togglePaired(id);
    expect(exercise.volume, 380);
    fit.togglePaired(id);
    expect(exercise.volume, 280);
  });

  test('existing sided records calculate both sides without rewriting saved data', () {
    final id = fit.matchExerciseByName('Dumbbell Curl')!.id;
    final old = LoggedSession(DateTime(2026, 10, 1), 600, [
      LoggedExercise(id, 'Curl', 'biceps', [LoggedSet(8, 10, left: 10, right: 8)]),
    ]).toJson();
    final backup = fit.toJson();
    backup['pairOn'] = [id];
    backup['sessions'] = [old];
    expect(fit.importJson(jsonEncode(backup)), isTrue);
    expect(fit.totalVolumeKg, 180);
    expect(fit.sessions.single.toJson(), old);
    final exported = fit.exportJson();
    fit.resetAllData();
    expect(fit.importJson(exported), isTrue);
    expect(fit.totalVolumeKg, 180);
    expect(fit.sessions.single.toJson(), old);
    fit.resumeLoggedSession(fit.sessions.single);
    expect(fit.sessionVolumeKg, 180);
    fit.finishSession();
    expect(fit.filedSession!.volume, 180);
    expect(fit.filedSession!.exercises.single.toJson(), (old['ex'] as List).single);
  });

  test('sided comparison and summary agree with saved volume, excluding warmups', () {
    start(paired: true, right: 8);
    fit.session!.exercises.single.sets.add(SessionSet(20, 100, true, repsR: 20, kind: SetKind.warmup));
    expect(fit.sessionVolumeKg, 180);
    fit.finishSession();
    expect(fit.session!.summaryVolume, 180);
    expect(fit.filedSession!.volume, 180);
    fit.saveAndExit();
    start(right: 10);
    expect(fit.raceRows.single.then, 180);
    expect(fit.raceRows.single.now, 200);
  });
}
