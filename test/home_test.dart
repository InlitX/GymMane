import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_colors.dart';
import 'package:gymmane/widgets/home_widget_views.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('rutinas en inicio', () {
    late List<String> ids;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      ids = fit.allExercises.take(6).map((e) => e.id).toList();
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    String routineWith(String name, List<String> exs) {
      final r = fit.createRoutine(name);
      for (final id in exs) {
        fit.toggleRoutineExercise(r, id);
      }
      return r;
    }

    LoggedSession done(String routineId, int ago) => LoggedSession(
          DateTime.now().subtract(Duration(days: ago)),
          1800,
          [LoggedExercise(ids[0], 'x', 'chest', [LoggedSet(8, 60)])],
          routineId: routineId,
        );

    group('#174 rutina de hoy hecha', () {
      test('tras hacerla no queda nada pendiente hoy', () {
        final r = routineWith('Básica', ids.take(2).toList());
        fit.weeklyPlan[DateTime.now().weekday] = r;
        expect(fit.pendingRoutinesOn(DateTime.now()).map((e) => e.id), [r]);

        fit.sessions.add(done(r, 0));
        expect(fit.pendingRoutinesOn(DateTime.now()), isEmpty);
        expect(fit.todayRoutine?.id, r);
      });
    });

    group('#176 rutinas en inicio', () {
      test('la última hecha va primero y las nunca hechas al final en su orden', () {
        final a = routineWith('A', [ids[0]]);
        final b = routineWith('B', [ids[1]]);
        final c = routineWith('C', [ids[2]]);
        final d = routineWith('D', [ids[3]]);
        fit.sessions.addAll([done(a, 5), done(c, 1), done(a, 9)]);

        expect(fit.routinesByLastDone.map((r) => r.id), [c, a, b, d]);
        expect(fit.lastDoneOf(b), isNull);
      });
    });

    group('#175 ajustes de inicio', () {
      test('las dos tarjetas se pueden quitar y se recuerdan', () async {
        expect(fit.showWeekStats, isTrue);
        expect(fit.showRoutineRow, isTrue);
        fit.toggleWeekStats();
        fit.toggleRoutineRow();
        fit.persistNow();
        fit.loadFromStore();
        expect(fit.showWeekStats, isFalse);
        expect(fit.showRoutineRow, isFalse);
      });

      test('las series de la tarjeta semanal son las de la semana', () {
        fit.sessions.add(LoggedSession(DateTime.now(), 600, [
          LoggedExercise(ids[0], 'x', 'chest', [LoggedSet(8, 60), LoggedSet(8, 60)]),
        ]));
        expect(fit.weekSetCount, 2);
      });
    });
  });

  group('#234 tira de la semana', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    test('con una rutina pendiente el día sale a medias, no hecho', () {
      fit.toggleMultiPlan();
      final a = fit.createRoutine('A');
      final b = fit.createRoutine('B');
      final today = DateTime.now().weekday;
      fit.togglePlanDay(today, a);
      fit.togglePlanDay(today, b);
      expect(fit.isDayPartial(fit.todayIndex), isFalse);

      fit.sessions.add(LoggedSession(DateTime.now().copyWith(hour: 12), 600, [
        LoggedExercise('x', 'X', 'chest', [LoggedSet(5, 60)]),
      ], routineId: a));
      expect(fit.isDayDone(fit.todayIndex), isTrue);
      expect(fit.isDayPartial(fit.todayIndex), isTrue);

      fit.sessions.add(LoggedSession(DateTime.now().copyWith(hour: 12), 600, [
        LoggedExercise('x', 'X', 'chest', [LoggedSet(5, 60)]),
      ], routineId: b));
      expect(fit.isDayPartial(fit.todayIndex), isFalse);
    });

    test('un día con una sola rutina sigue igual que antes', () {
      final a = fit.createRoutine('A');
      fit.togglePlanDay(DateTime.now().weekday, a);
      fit.sessions.add(LoggedSession(DateTime.now().copyWith(hour: 12), 600, [
        LoggedExercise('x', 'X', 'chest', [LoggedSet(5, 60)]),
      ], routineId: a));
      expect(fit.isDayPartial(fit.todayIndex), isFalse);
    });
  });

  group('widgets de inicio', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    testWidgets('el widget de hoy dice hecho o no sin poner el día', (tester) async {
      Future<void> show(bool done) => tester.pumpWidget(Directionality(
            textDirection: TextDirection.ltr,
            child: Center(child: TodayWidgetView(gc: GymColors.dark, done: done, planned: true, streak: 0)),
          ));
      await show(false);
      expect(find.text('${DateTime.now().day}'), findsNothing);
      expect(find.byIcon(Icons.fitness_center_rounded), findsOneWidget);
      await show(true);
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('el widget de la semana cuenta los días hechos', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: WeekWidgetView(
            gc: GymColors.dark,
            done: const [true, false, true, false, false, false, false],
            goal: 4,
          ),
        ),
      ));
      expect(find.text('2'), findsOneWidget);
      expect(find.text('/4'), findsOneWidget);
      expect(find.byIcon(Icons.check_rounded), findsNWidgets(2));
      final geo = WeekWidgetView.geometry(const Size(320, 150));
      final origin = tester.getTopLeft(find.byType(WeekWidgetView));
      final dots = find.byWidgetPredicate(
          (w) => w is Container && w.decoration is BoxDecoration && (w.decoration as BoxDecoration).shape == BoxShape.circle);
      expect(dots, findsNWidgets(7));
      for (var i = 0; i < 7; i++) {
        final c = tester.getCenter(dots.at(i)) - origin;
        expect(c.dx / 320, closeTo(geo[0] + geo[1] * i, 0.002));
        expect(c.dy / 150, closeTo(geo[2], 0.002));
      }
    });
  });

  group('objetivo semanal y racha', () {
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

    LoggedSession logged(DateTime at, List<LoggedSet> sets, {String id = 'push', String primary = 'chest'}) =>
        LoggedSession(at, 600, [LoggedExercise(id, id, primary, sets)]);

    group('#117 objetivo semanal por días', () {
      test('dos sesiones el mismo día son un día', () {
        fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 60)]));
        fit.sessions.add(logged(DateTime.now(), [LoggedSet(5, 60)]));
        expect(fit.daysDoneThisWeek, 1);
      });

      test('marcar y desmarcar un día lo deja como estaba', () {
        final before = fit.daysDoneThisWeek;
        fit.toggleCheckin(fit.todayIndex);
        expect(fit.daysDoneThisWeek, before + 1);
        fit.toggleCheckin(fit.todayIndex);
        expect(fit.daysDoneThisWeek, before);
        expect(fit.currentStreak, 0);
      });
    });

    group('#85 racha con calendario', () {
      test('un día sin rutina no rompe la racha', () {
        final today = DateTime.now();
        final yesterday = DateTime(today.year, today.month, today.day - 1);
        final before = DateTime(today.year, today.month, today.day - 2, 18);
        fit.sessions.add(logged(today, [LoggedSet(5, 60)]));
        fit.sessions.add(logged(before, [LoggedSet(5, 60)]));
        expect(fit.currentStreak, 1);

        final r = routineOf(['Barbell Bench Press']);
        for (var d = 1; d <= 7; d++) {
          if (d != yesterday.weekday) fit.assignRoutineToDay(d, r.id);
        }
        expect(fit.currentStreak, 2);
      });
    });
  });

  group('hábitos y ajustes de inicio', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    String bench() => fit.matchExerciseByName('Barbell Bench Press')!.id;

    group('hábitos (recordatorio inteligente)', () {
      void logAt(DateTime when, int minutes) {
        fit.sessions.add(LoggedSession(when, minutes * 60,
            [LoggedExercise(bench(), 'Bench', 'chest', [LoggedSet(5, 60)])]));
      }

      test('sin historial no hay hábito', () {
        expect(fit.usualWeekdays, isEmpty);
        expect(fit.usualStartMinute, isNull);
        expect(fit.hasTrainingHabit, isFalse);
      });

      test('saca los días que más entrenas y la hora de siempre', () {
        final monday = DateTime(2026, 9, 7, 20, 0);
        for (var week = 0; week < 3; week++) {
          logAt(monday.add(Duration(days: 7 * week)), 60);
          logAt(monday.add(Duration(days: 7 * week + 2)), 60);
        }
        expect(fit.usualWeekdays, [1, 3]);
        expect(fit.usualStartMinute, 19 * 60);
        expect(fit.hasTrainingHabit, isTrue);
      });

      test('el foco de hoy sigue siendo uno de los tres días', () {
        final today = DateTime.now();
        for (var week = 1; week <= 3; week++) {
          fit.sessions.add(LoggedSession(today.subtract(Duration(days: 7 * week)), 3600,
              [LoggedExercise(bench(), 'Bench', 'chest', [LoggedSet(5, 60)])]));
        }
        expect(fit.familyOnWeekday(today.weekday), 'push');
        expect(fit.suggestedFocus.muscles, contains('chest'));
      });
    });

    group('ajustes nuevos', () {
      test('el objetivo semanal es el que se enseña en el anillo', () {
        fit.updateProfile(weeklyGoalDelta: 10 - fit.profile.weeklyGoal);
        expect(fit.weeklyTarget, 10);
        expect(fit.goalPct, 0);
      });

      test('el foco de hoy se puede apagar y se guarda', () {
        expect(fit.showFocus, isTrue);
        fit.toggleFocusCard();
        final saved = fit.toJson();
        fit.resetAllData();
        fit.applyBackup(saved);
        expect(fit.showFocus, isFalse);
      });

      test('la hora del aviso se guarda y se puede quitar', () {
        fit.setTrainReminder(19 * 60 + 30);
        final saved = fit.toJson();
        fit.resetAllData();
        fit.applyBackup(saved);
        expect(fit.trainReminderMin, 19 * 60 + 30);
        fit.setTrainReminder(null);
        expect(fit.trainReminderMin, isNull);
      });
    });
  });
}
