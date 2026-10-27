import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#180 duración de la sesión', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('se corrige y se guarda', () {
      final s = LoggedSession(DateTime.now(), 108 * 60, [
        LoggedExercise('x', 'x', 'chest', [LoggedSet(8, 60)]),
      ]);
      fit.sessions.add(s);
      fit.setSessionDuration(s, 45 * 60);
      expect(fit.daySummary(DateTime.now())!.durationSec, 45 * 60);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.sessions.single.durationSec, 45 * 60);
    });
  });

  group('#81 entreno que pasa de medianoche', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    String bench() => fit.matchExerciseByName('Bench Press')!.id;

    DateTime day(int offset, [int hour = 10]) {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day + offset, hour);
    }

    test('cuenta en el día en que empezó', () {
      final end = day(0, 1);
      fit.sessions.add(LoggedSession(end, 2 * 3600, [
        LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(8, 60)]),
      ]));
      expect(fit.trainedToday, isFalse);
      expect(fit.sessionsOn(day(-1)).length, 1);
      expect(fit.sessionsOn(DateTime.now()), isEmpty);
    });
  });

  group('historial y series registradas', () {
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

    group('#228 editar series registradas', () {
      test('cambiar el peso no borra el tiempo, el tipo ni el RPE', () {
        final e = LoggedExercise('plank', 'Plank', 'abdomen', [LoggedSet(0, 10, sec: 45, rpe: 8, kind: SetKind.drop)]);
        fit.sessions.add(LoggedSession(ago(1), 600, [e]));
        fit.bumpLoggedWeight(e, 0, 1);
        expect(e.sets.single.sec, 45);
        expect(e.sets.single.rpe, 8);
        expect(e.sets.single.kind, SetKind.drop);
        fit.bumpLoggedSec(e, 0, 1);
        expect(e.sets.single.sec, 50);
        fit.bumpLoggedSec(e, 0, -20);
        expect(e.sets.single.sec, 0);
      });

      test('añadir serie copia el tiempo y la distancia', () {
        final e = LoggedExercise('run', 'Run', 'quads', [LoggedSet(0, 0, sec: 1800, km: 5)]);
        fit.sessions.add(LoggedSession(ago(1), 600, [e]));
        fit.addLoggedSet(e);
        expect(e.sets.last.sec, 1800);
        expect(e.sets.last.km, 5);
        fit.bumpLoggedKm(e, 1, 1);
        expect(e.sets.last.km, closeTo(5.1, 0.001));
        expect(fit.loggedDistance(e), isTrue);
      });

      test('un ejercicio con tiempo se reconoce aunque sea propio', () {
        final e = LoggedExercise('mio', 'Mío', 'abdomen', [LoggedSet(0, 0, sec: 30)]);
        expect(fit.loggedTimed(e), isTrue);
        expect(fit.loggedTimed(LoggedExercise('b', 'B', 'chest', [LoggedSet(8, 60)])), isFalse);
      });
    });

    group('#214 #196 historial', () {
      test('el mes lista sus entrenos, del más nuevo al más viejo', () {
        final n = DateTime.now();
        final month = DateTime(n.year, n.month);
        fit.sessions.add(LoggedSession(DateTime(n.year, n.month, 1, 18), 1800, [LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 60)])]));
        fit.sessions.add(LoggedSession(DateTime(n.year, n.month, 2, 18), 2400, [LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 62.5), LoggedSet(8, 62.5)])]));
        fit.sessions.add(LoggedSession(DateTime(n.year, n.month - 1, 20, 18), 600, [LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 50)])]));
        final list = fit.sessionsInMonth(month);
        expect(list.length, 2);
        expect(list.first.day.day, 2);
        final sum = fit.monthSummary(month);
        expect(sum.workouts, 2);
        expect(sum.sets, 3);
        expect(sum.seconds, 4200);
        expect(fit.monthSummary(DateTime(n.year, n.month - 1)).workouts, 1);
      });

      test('no se puede ir más allá del mes actual', () {
        fit.goHistory();
        expect(fit.historyAtLatest, isTrue);
        final before = fit.historyMonth;
        fit.shiftHistoryMonth(1);
        expect(fit.historyMonth, before);
        fit.shiftHistoryMonth(-1);
        expect(fit.historyAtLatest, isFalse);
        fit.popRoute();
      });

      test('cuenta los récords de cada entreno, no el primero', () {
        logged('a', 9, [LoggedSet(8, 60)]);
        logged('a', 6, [LoggedSet(8, 65)]);
        logged('a', 3, [LoggedSet(8, 62.5)]);
        final byDay = {for (final e in fit.recordsBySession().entries) e.key.day.day: e.value};
        expect(byDay.length, 1);
        expect(byDay[ago(6).day], 1);
      });

      test('sin nombre ni rutina, el título son los grupos musculares', () {
        final s = LoggedSession(ago(1), 600, [
          LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 60), LoggedSet(8, 60)]),
          LoggedExercise('b', 'B', 'quads', [LoggedSet(5, 100)]),
        ]);
        fit.sessions.add(s);
        expect(fit.sessionHeading(s), contains(' · '));
        fit.renameSession(s, 'Pecho pesado');
        expect(fit.sessionHeading(s), 'Pecho pesado');
      });

      test('la mejor serie de una plancha es la más larga', () {
        final e = LoggedExercise('plank', 'Plank', 'abdomen', [LoggedSet(0, 0, sec: 45), LoggedSet(0, 0, sec: 60)]);
        expect(fit.topSetOf(e)!.sec, 60);
      });
    });

    testWidgets('el historial cambia de mes en la app de verdad', (tester) async {
      setAppLanguage('es');
      fit.refreshAwards(silent: true);
      fit.pendingAwards.clear();
      fit.resetRoute('settings');
      fit.goHistory();
      await tester.pumpWidget(const GymManeApp());
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      final now = DateTime.now();
      expect(find.text(t.monthYear(DateTime(now.year, now.month))), findsOneWidget);
      await tester.tap(find.bySemanticsLabel(t.notePrevMonth));
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.text(t.monthYear(DateTime(now.year, now.month - 1))), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 1));
    });
  });

  group('#252 vs la última vez', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
    });

    String startOne() {
      fit.startWorkout();
      fit.toggleMuscle('chest');
      fit.trainContinue();
      for (final id in fit.sessionPicks.toList().skip(1)) {
        fit.togglePick(id);
      }
      fit.startSession();
      return fit.session!.exercises.first.id;
    }

    void before(List<LoggedExercise> ex) => fit.sessions
        .add(LoggedSession(DateTime.now().subtract(const Duration(days: 1)), 1800, ex));

    void logSet(int reps, double kg) {
      fit.setSessionReps(0, 0, reps);
      fit.setSessionWeight(0, 0, kg);
      fit.toggleSet(0, 0);
      fit.finishSession();
    }

    test('peso corporal: compara repeticiones, no da −100 %', () {
      final id = startOne();
      before([LoggedExercise(id, id, 'chest', [LoggedSet(10, 0)])]);
      logSet(12, 0);
      expect(fit.summaryVsLast, 20);
      expect(fit.summaryFirstTime, isFalse);
    });

    test('solo cuentan los ejercicios en común, no la rutina larga de ayer', () {
      final id = startOne();
      before([
        LoggedExercise(id, id, 'chest', [LoggedSet(10, 50)]),
        LoggedExercise('otro', 'otro', 'back', [LoggedSet(10, 100)]),
      ]);
      logSet(10, 55);
      expect(fit.summaryVsLast, 10);
    });

    test('ayer con peso y hoy sin peso: pasa a repeticiones', () {
      final id = startOne();
      before([LoggedExercise(id, id, 'chest', [LoggedSet(8, 40)])]);
      logSet(8, 0);
      expect(fit.summaryVsLast, 0);
    });

    test('sin sesión anterior con esos ejercicios es la primera vez', () {
      startOne();
      before([LoggedExercise('otro', 'otro', 'back', [LoggedSet(10, 100)])]);
      logSet(10, 20);
      expect(fit.summaryVsLast, isNull);
      expect(fit.summaryFirstTime, isTrue);
    });

    test('nada que comparar (solo tiempo) no enseña tarjeta', () {
      final id = startOne();
      before([LoggedExercise(id, id, 'chest', [LoggedSet(0, 0, sec: 60)])]);
      logSet(0, 0);
      expect(fit.summaryVsLast, isNull);
      expect(fit.summaryFirstTime, isFalse);
    });
  });

  group('#271 RPE en el historial', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      fit.autoAdvance = false;
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    test('cada serie con esfuerzo lleva su etiqueta', () {
      fit.setEffortMode('rpe');
      final label = fit.setsSummary([LoggedSet(5, 100, rpe: 8), LoggedSet(5, 100)]);
      expect(label, '${fit.loggedSetLabel(LoggedSet(5, 100))} @8 · ${fit.loggedSetLabel(LoggedSet(5, 100))}');
    });
  });

  group('#107 entreno pasado con su hora', () {
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

    Routine routineOf(List<String> names) {
      final id = fit.createRoutine('Push');
      for (final name in names) {
        fit.toggleRoutineExercise(id, idOf(name));
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    test('la hora y la duración elegidas llegan al historial', () {
      final day = DateTime.now().subtract(const Duration(days: 2));
      fit.startRoutine(routineOf(['Barbell Bench Press']), on: day);
      fit.setManualStart(18 * 60 + 30);
      fit.setManualMinutes(45);
      fit.stepOutOfSession();
      fit.stepBackIntoSession();
      expect(fit.manualMinutes, 45, reason: 'salir y volver no toca la duración');
      fit.toggleSet(0, 0);
      fit.finishSession();
      final s = fit.sessions.last;
      expect(s.durationSec, 45 * 60);
      expect(s.date, DateTime(day.year, day.month, day.day, 19, 15));
    });
  });
}
