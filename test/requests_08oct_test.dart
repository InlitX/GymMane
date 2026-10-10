import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  group('#177 saltar dentro de una superserie', () {
    void finish(int exIdx) {
      for (final st in fit.session!.exercises[exIdx].sets) {
        st.done = true;
      }
    }

    test('la flecha sale de la cadena como al completar la serie', () {
      routineWith('Cadena', ids);
      fit.startRoutine(fit.routines.single);
      final s = fit.session!;
      for (var i = 0; i < 4; i++) {
        s.exercises[i].linkedNext = true;
      }
      for (final i in [0, 1, 3, 4]) {
        finish(i);
      }
      s.currentIndex = 2;

      fit.nextExercise();
      expect(s.currentIndex, 5);
    });

    test('dentro de la cadena va al siguiente que aún tiene series', () {
      routineWith('Cadena', ids);
      fit.startRoutine(fit.routines.single);
      final s = fit.session!;
      for (var i = 0; i < 4; i++) {
        s.exercises[i].linkedNext = true;
      }
      finish(1);
      s.currentIndex = 0;

      fit.nextExercise();
      expect(s.currentIndex, 2);
    });

    test('fuera de una cadena sigue yendo al siguiente de la lista', () {
      routineWith('Suelta', ids.take(3).toList());
      fit.startRoutine(fit.routines.single);
      fit.nextExercise();
      expect(fit.session!.currentIndex, 1);
    });
  });

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
}
