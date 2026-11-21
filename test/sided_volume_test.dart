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

  group('peso corporal en la carga', () {
    String id(String name) => fit.matchExerciseByName(name)!.id;

    test('dominadas y fondos suman tu peso de ese día al lastre', () {
      fit.bodyweight
        ..add(BodyweightEntry(DateTime(2026, 9, 1), 80))
        ..add(BodyweightEntry(DateTime(2026, 10, 1), 70));
      LoggedSession on(DateTime d, String ex, double kg) =>
          LoggedSession(d, 600, [LoggedExercise(id(ex), ex, 'lats', [LoggedSet(10, kg)])]);
      expect(on(DateTime(2026, 9, 15), 'Pull-up', 0).volume, 800);
      expect(on(DateTime(2026, 10, 15), 'Pull-up', 0).volume, 700);
      expect(on(DateTime(2026, 9, 15), 'Weighted Pull-up', 10).volume, 900);
      expect(on(DateTime(2026, 9, 15), 'Assisted Pull-up', 30).volume, 500);
      expect(on(DateTime(2026, 9, 15), 'Push-up', 0).volume, 0);
      expect(on(DateTime(2026, 8, 1), 'Pull-up', 0).volume, 800);
    });

    test('se apaga y se enciende por ejercicio y va en la copia', () {
      fit.addBodyweight(75);
      final pull = id('Pull-up');
      final push = id('Push-up');
      expect(fit.carriesBody(pull), isTrue);
      expect(fit.carriesBody(push), isFalse);
      expect(fit.canCarryBody(push), isTrue);
      fit.toggleCarriesBody(pull);
      fit.toggleCarriesBody(push);
      final ex = LoggedExercise(pull, 'Pull-up', 'lats', [LoggedSet(10, 0)]);
      expect(ex.volume, 0);
      fit.resetAllData();
      expect(fit.importJson(jsonEncode(fit.toJson()..addAll({'bodyOff': [pull], 'bodyOn': [push]}))), isTrue);
      expect(fit.carriesBody(pull), isFalse);
      expect(fit.carriesBody(push), isTrue);
    });

    test('el entreno en curso y la pantalla final cuentan lo mismo que lo guardado', () {
      fit.addBodyweight(80);
      final pull = id('Pull-up');
      fit.session = WorkoutSession()
        ..exercises = [SessionExercise(pull, 'Pull-up', 'lats', [SessionSet(10, 5, true)])];
      expect(fit.sessionVolumeKg, 850);
      fit.finishSession();
      expect(fit.session!.summaryVolume, 850);
      expect(fit.filedSession!.volume, 850);
    });

    test('parte del peso corporal por ejercicio, con lastre y en la copia', () {
      fit.addBodyweight(80);
      final push = id('Push-up');
      final pull = id('Pull-up');
      expect(fit.bodyShareOf(push), 65);
      expect(fit.bodyShareOf(pull), 100);
      fit.toggleCarriesBody(push);
      fit.setBodyShare(push, 65);
      expect(fit.hasOwnBodyShare(push), isFalse);
      LoggedExercise ex(String i, double kg) => LoggedExercise(i, 'x', 'chest', [LoggedSet(10, kg)]);
      expect(ex(push, 0).volume, closeTo(520, 0.001));
      expect(ex(push, 10).volume, closeTo(620, 0.001));
      fit.setBodyShare(pull, 50);
      expect(ex(pull, 0).volume, closeTo(400, 0.001));
      fit.setBodyShare(pull, 100);
      expect(fit.hasOwnBodyShare(pull), isFalse);
      fit.setBodyShare(push, 300);
      expect(fit.bodyShareOf(push), 100);
      fit.setBodyShare(push, 70);
      final saved = jsonEncode(fit.toJson());
      fit.resetAllData();
      expect(fit.bodyShareOf(push), 65);
      expect(fit.importJson(saved), isTrue);
      expect(fit.bodyShareOf(push), 70);
    });

    test('sin peso apuntado no se inventa ninguno', () {
      fit.profile.weightKg = 0;
      final ex = LoggedExercise(id('Pull-up'), 'Pull-up', 'lats', [LoggedSet(10, 0)]);
      expect(ex.volume, 0);
    });
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
