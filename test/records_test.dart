import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/profile.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('mejor serie y mejor entreno', () {
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

    LoggedSession day(int ago, List<LoggedExercise> exs) =>
        LoggedSession(DateTime.now().subtract(Duration(days: ago)), 1800, exs);

    test('la mejor serie es la de más 1RM y el mejor entreno el de más volumen', () {
      final bench = idOf('Barbell Bench Press');
      fit.sessions.addAll([
        day(3, [LoggedExercise(bench, 'Bench', 'chest', [LoggedSet(13, 16), LoggedSet(5, 18)])]),
        day(1, [LoggedExercise(bench, 'Bench', 'chest', [LoggedSet(10, 17), LoggedSet(10, 17), LoggedSet(10, 17)])]),
      ]);

      final set = fit.bestSet(bench)!;
      expect((set.set.weight, set.set.reps), (16, 13));

      final work = fit.bestWorkout(bench, PrKind.weight)!;
      expect(work.score, 510);
    });

    test('en un ejercicio de repeticiones el mejor entreno suma repeticiones', () {
      final pull = idOf('Pull Up');
      fit.sessions.add(day(1, [LoggedExercise(pull, 'Pull', 'back', [LoggedSet(8, 0), LoggedSet(6, 0)])]));
      expect(fit.bestWorkout(pull, PrKind.reps)!.score, 14);
      expect(fit.bestSet(pull), isNull);
    });
  });

  group('#201 máquinas asistidas', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    DateTime ago(int days, [int hour = 18]) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day - days, hour);
    }

    void logged(String id, int days, List<LoggedSet> sets) =>
        fit.sessions.add(LoggedSession(ago(days), 1200, [LoggedExercise(id, id, 'back', sets)]));

    const pull = 'kiJ4Z2K';

    test('las dominadas asistidas vienen marcadas y se pueden desmarcar', () {
      expect(fit.isAssisted(pull), isTrue);
      expect(fit.isAssisted(fit.matchExerciseByName('Bench Press')!.id), isFalse);
      fit.toggleAssisted(pull);
      expect(fit.isAssisted(pull), isFalse);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.applyBackup(data);
      expect(fit.isAssisted(pull), isFalse);
    });

    test('el récord es la menor ayuda, no la mayor', () {
      logged(pull, 10, [LoggedSet(8, 40)]);
      logged(pull, 3, [LoggedSet(8, 35)]);
      final r = fit.exerciseRecord(pull)!;
      expect(r.best, 35);
      expect(fit.bestSet(pull)!.set.weight, 35);
      expect(fit.oneRmSeries(pull), [40, 35]);
    });

    test('con más reps y la misma ayuda también es mejor', () {
      logged(pull, 10, [LoggedSet(6, 35)]);
      logged(pull, 3, [LoggedSet(10, 35)]);
      expect(fit.bestSet(pull)!.set.reps, 10);
    });

    test('la sugerencia y los pesos de partida bajan la ayuda', () {
      fit.progressStep[pull] = 2.5;
      logged(pull, 3, [LoggedSet(8, 35), LoggedSet(8, 35)]);
      final next = fit.nextTarget(pull)!;
      expect(next.weightKg, 32.5);
      expect(next.up, isTrue);
      final r = fit.createRoutine('Espalda');
      fit.toggleRoutineExercise(r, pull);
      fit.startRoutine(fit.routines.single);
      expect(fit.session!.exercises.single.sets.where((s) => s.kind != SetKind.warmup).first.weight, 32.5);
      fit.saveAndExit();
    });

    test('la ayuda nunca baja de cero y no hay objetivo de peso', () {
      fit.progressStep[pull] = 5;
      logged(pull, 3, [LoggedSet(8, 2.5)]);
      expect(fit.nextTarget(pull)!.weightKg, 0);
      expect(fit.goalFits(pull), isFalse);
      expect(fit.bestLift(pull), 0);
    });
  });

  group('fuerza relativa', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
    });

    void lift(String name, int reps, double kg) {
      final ex = fit.matchExerciseByName(name)!;
      fit.sessions.add(LoggedSession(DateTime.now().subtract(const Duration(days: 2)), 1800,
          [LoggedExercise(ex.id, ex.name, ex.primary, [LoggedSet(reps, kg)])]));
    }

    test('press banca a 1,0× el peso es intermedio en hombre y muy avanzado en mujer', () {
      fit.profile = Profile(weightKg: 80);
      lift('Barbell Bench Press', 1, 80);
      final id = fit.matchExerciseByName('Barbell Bench Press')!.id;
      final rel = fit.relativeStrength(id)!;
      expect(rel.ratio, closeTo(1.03, 0.01));
      expect(rel.level, 1);
      fit.profile = Profile(weightKg: 80, sex: 'female');
      expect(fit.relativeStrength(id)!.level, 3);
    });

    test('solo para los básicos y con marcas de los últimos 90 días', () {
      lift('Dumbbell Biceps Curl', 10, 15);
      expect(fit.relativeStrength(fit.matchExerciseByName('Dumbbell Biceps Curl')!.id), isNull);
      final ex = fit.matchExerciseByName('Barbell Deadlift')!;
      fit.sessions.add(LoggedSession(DateTime.now().subtract(const Duration(days: 200)), 1800,
          [LoggedExercise(ex.id, ex.name, ex.primary, [LoggedSet(5, 140)])]));
      expect(fit.relativeStrength(ex.id), isNull);
    });
  });

  group('#104 récords sin peso', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = 'push', String primary = 'chest'}) =>
        LoggedSession(at, 600, [LoggedExercise(id, id, primary, sets)]);

    test('peso corporal: el récord son las repeticiones', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(15, 0), LoggedSet(22, 0)]));
      final pr = fit.personalRecords.single;
      expect(pr.kind, PrKind.reps);
      expect(pr.best, 22);
    });

    test('isométrico: el récord es el tiempo', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(0, 0, sec: 45), LoggedSet(0, 0, sec: 70)]));
      final pr = fit.personalRecords.single;
      expect(pr.kind, PrKind.time);
      expect(fit.recordLabel(pr), isNot(contains('kg')));
    });

    test('con peso manda el peso y va primero en la lista', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(30, 0)], id: 'dips'));
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 100)], id: 'bench'));
      expect(fit.personalRecords.map((r) => r.id), ['bench', 'dips']);
      expect(fit.personalRecords.first.kind, PrKind.weight);
    });
  });

  group('#127 ideas de FitNotes', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    const bench = 'EIeI8Vf';

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = bench}) =>
        LoggedSession(at, 1800, [LoggedExercise(id, 'Barbell Bench Press', 'chest', sets)]);

    test('el objetivo mide el mejor peso y se guarda con su fecha', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 100), LoggedSet(3, 110)]));
      final due = DateTime.now().add(const Duration(days: 30));
      fit.setExerciseGoal(bench, 140, due);
      expect(fit.goalBest(bench), 110);
      fit.persistNow();
      fit.loadFromStore();
      final g = fit.exerciseGoals[bench]!;
      expect(g.target, 140);
      expect((g.due!.year, g.due!.month, g.due!.day), (due.year, due.month, due.day));
      fit.clearExerciseGoal(bench);
      expect(fit.exerciseGoals, isEmpty);
    });

    test('el objetivo de un ejercicio sin peso va en repeticiones', () {
      fit.sessions.add(logged(DateTime.now(), [LoggedSet(12, 0)], id: 'I4hDWkc'));
      expect(fit.goalKind('I4hDWkc'), PrKind.reps);
      expect(fit.goalBest('I4hDWkc'), 12);
    });

    test('el entreno se copia como texto con sus series y totales', () {
      final s = logged(DateTime(2026, 9, 29, 18), [LoggedSet(8, 60), LoggedSet(6, 70)]);
      final text = fit.workoutText(s);
      expect(text, contains('60 kg × 8'));
      expect(text, contains('70 kg × 6'));
      expect(text, contains('30 min'));
      expect(text.split('\n').last, contains('14'));
    });

    test('el porcentaje del máximo da un peso que se puede cargar', () {
      fit.bumpRmWeight(100 - fit.rmWeight);
      fit.bumpRmReps(1 - fit.rmReps);
      fit.bumpRmPct(72 - fit.rmPct);
      final w = fit.rmAtPct;
      expect((w - 72.6).abs(), lessThan(2.6));
      expect(w % 1.25, closeTo(0, 1e-9));
    });
  });

  group('finish screen tells the truth', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    void logSession(String exId, double kg) {
      fit.sessions.add(LoggedSession(DateTime.now().subtract(const Duration(days: 3)), 600,
          [LoggedExercise(exId, 'X', 'chest', [LoggedSet(5, kg)])]));
    }

    void doWorkout(double kg) {
      fit.startWorkout();
      fit.toggleMuscle('chest');
      fit.trainContinue();
      fit.startSession();
      fit.setSessionWeight(0, 0, kg);
      fit.setSessionReps(0, 0, 5);
      fit.toggleSet(0, 0);
      fit.finishSession();
    }

    test('a real PR is counted; a lighter day is not', () {
      final id = fit.allExercises.firstWhere((e) => e.primary == 'chest').id;
      logSession(id, 60);

      doWorkout(80);
      expect(fit.summaryPrs, 1);
      fit.saveAndExit();

      doWorkout(50);
      expect(fit.summaryPrs, 0, reason: 'se compara con TODO lo anterior, no con la última vez');
      fit.saveAndExit();
    });

    test('the headline changes with what actually happened', () {
      expect(t.finishHeadline(prs: 1, streak: 0, goalHit: false),
          isNot(t.finishHeadline(prs: 0, streak: 0, goalHit: false)));
      expect(t.finishHeadline(prs: 0, streak: 0, goalHit: true),
          isNot(t.finishHeadline(prs: 0, streak: 0, goalHit: false)));
      setAppLanguage('es');
      expect(t.finishHeadline(prs: 2, streak: 0, goalHit: false), 'Récord personal nuevo');
      expect(t.finishBody(prs: 2, streak: 0, goalHit: false), contains('2 ejercicios'));
      expect(t.finishBody(prs: 1, streak: 0, goalHit: false), contains('un ejercicio'));
    });

    test('nothing logged means no fake celebration', () {
      fit.startWorkout();
      fit.toggleMuscle('chest');
      fit.trainContinue();
      fit.startSession();
      fit.finishSession();
      expect(fit.summaryPrs, 0);
      expect(fit.summaryVsLast, isNull);
      fit.saveAndExit();
    });
  });

  group('#287 trofeo en la serie', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    LoggedSession day(int ago, String id, List<LoggedSet> sets) => LoggedSession(
        DateTime.now().subtract(Duration(days: ago)), 1800, [LoggedExercise(id, 'Bench', 'chest', sets)]);

    test('marca la serie que supera lo de antes y no la primera vez', () {
      final bench = fit.matchExerciseByName('Barbell Bench Press')!.id;
      final first = LoggedSet(8, 80);
      final same = LoggedSet(8, 80);
      final heavier = LoggedSet(3, 90);
      final moreReps = LoggedSet(10, 80);
      fit.sessions.addAll([
        day(4, bench, [first]),
        day(2, bench, [same, heavier]),
        day(1, bench, [moreReps, LoggedSet(5, 60)]),
      ]);
      final records = fit.recordSets;
      expect(records.contains(first), isFalse, reason: 'sin nada antes no hay récord');
      expect(records.contains(same), isFalse);
      expect(records.contains(heavier), isTrue, reason: 'más peso');
      expect(records.contains(moreReps), isTrue, reason: 'más repeticiones con el mismo peso');
      expect(records.length, 2);
    });

    test('en el entreno la serie hecha que bate la marca lleva trofeo', () {
      final bench = fit.matchExerciseByName('Barbell Bench Press')!.id;
      fit.sessions.add(day(3, bench, [LoggedSet(8, 80)]));
      final id = fit.createRoutine('Pecho');
      fit.toggleRoutineExercise(id, bench);
      fit.startRoutine(fit.routines.firstWhere((r) => r.id == id));
      fit.endCountdown();
      fit.setSessionReps(0, 0, 8);
      fit.setSessionWeight(0, 0, 85);
      expect(fit.liveSetIsRecord(0, 0), isFalse, reason: 'aún sin marcar');
      fit.toggleSet(0, 0);
      expect(fit.liveSetIsRecord(0, 0), isTrue);
      fit.setSessionReps(0, 1, 8);
      fit.setSessionWeight(0, 1, 85);
      fit.toggleSet(0, 1);
      expect(fit.liveSetIsRecord(0, 1), isFalse, reason: 'igualar la serie anterior no es récord');
    });
  });
}
