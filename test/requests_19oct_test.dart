import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
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
    fit.onboarded = true;
  });

  String bench() => fit.matchExerciseByName('Bench Press')!.id;
  String squat() => fit.matchExerciseByName('Barbell Squat')!.id;

  Routine routine(String name, [List<String>? ids]) {
    final id = fit.createRoutine(name);
    for (final e in ids ?? [bench()]) {
      fit.toggleRoutineExercise(id, e);
    }
    return fit.routines.firstWhere((r) => r.id == id);
  }

  void train(Routine r) {
    fit.startRoutine(r);
    fit.endCountdown();
    fit.toggleSet(0, 0);
    fit.finishSession();
  }

  void close() => fit.saveAndExit();

  DateTime day(int offset, [int hour = 10]) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day + offset, hour);
  }

  group('rotación a fondo', () {
    Routine rotate(List<Routine> list) {
      fit.setRotation(true);
      for (final r in list) {
        if (!fit.rotationIds.contains(r.id)) fit.toggleRotationRoutine(r.id);
      }
      return list.first;
    }

    test('A, B, C seguidas en días distintos dan la vuelta entera', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      rotate([a, b, c]);
      final seen = <String>[];
      for (var i = 0; i < 4; i++) {
        final next = fit.rotationNext!;
        seen.add(next.name);
        train(next);
        close();
      }
      expect(seen, ['A', 'B', 'C', 'A']);
      expect(fit.rotationNext?.id, b.id);
    });

    test('hoy enseña la hecha y mañana la siguiente', () {
      final a = routine('A'), b = routine('B');
      rotate([a, b]);
      train(a);
      close();
      expect(fit.routinesOn(DateTime.now()).single.id, a.id);
      expect(fit.pendingRoutinesOn(DateTime.now()), isEmpty);
      expect(fit.routinesOn(day(1)).single.id, b.id);
      expect(fit.routinesOn(day(-1)), isEmpty);
    });

    test('una rutina fuera de la rotación no la mueve', () {
      final a = routine('A'), b = routine('B'), x = routine('X');
      rotate([a, b]);
      train(x);
      close();
      expect(fit.rotationNext?.id, a.id);
    });

    test('hacer la B cuando tocaba la A salta a la C', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      rotate([a, b, c]);
      train(b);
      close();
      expect(fit.rotationNext?.id, c.id);
    });

    test('volver al entreno desde el resumen no avanza dos veces', () {
      final a = routine('A'), b = routine('B'), c = routine('C');
      rotate([a, b, c]);
      train(a);
      expect(fit.rotationNext?.id, b.id);
      fit.continueSession();
      expect(fit.rotationNext?.id, a.id);
      fit.finishSession();
      expect(fit.rotationNext?.id, b.id);
      close();
      expect(fit.sessions.length, 1);
    });

    test('quitar la que tocaba pasa a la primera y vaciarla vuelve a la semana', () {
      final a = routine('A'), b = routine('B');
      fit.assignRoutineToDay(DateTime.now().weekday, a.id);
      rotate([a, b]);
      fit.setRotationNext(b.id);
      fit.toggleRotationRoutine(b.id);
      expect(fit.rotationNext?.id, a.id);
      fit.toggleRotationRoutine(a.id);
      expect(fit.rotating, isFalse);
      expect(fit.routinesOn(DateTime.now()).single.id, a.id);
    });

    test('nada de rutinas vacías ni ids sueltos al cargar', () {
      final a = routine('A'), b = routine('B');
      rotate([a, b]);
      fit.rotationIds.add('no-existe');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.rotationRoutines.map((r) => r.id), [a.id, b.id]);
    });
  });

  group('mover el día a fondo', () {
    test('a un día que ya tiene rutina se suman las dos', () {
      final a = routine('A'), b = routine('B');
      final today = DateTime.now();
      fit.toggleMultiPlan();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.assignRoutineToDay(day(1).weekday, b.id);
      fit.moveRoutineDay(a.id, today, day(1));
      expect(fit.routinesOn(day(1)).map((r) => r.id), [b.id, a.id]);
      expect(fit.routinesOn(today), isEmpty);
      expect(fit.routinesOn(day(8)).map((r) => r.id), [b.id]);
    });

    test('mover dos veces y deshacer la segunda deja la primera', () {
      final a = routine('A');
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.moveRoutineDay(a.id, today, day(1));
      final undo = fit.moveRoutineDay(a.id, day(1), day(2))!;
      expect(fit.routinesOn(day(2)).single.id, a.id);
      expect(fit.routinesOn(day(1)), isEmpty);
      undo();
      expect(fit.routinesOn(day(1)).single.id, a.id);
      expect(fit.routinesOn(day(2)), isEmpty);
    });

    test('no mueve lo que no está ese día ni al mismo día', () {
      final a = routine('A');
      final today = DateTime.now();
      expect(fit.moveRoutineDay(a.id, today, day(1)), isNull);
      fit.assignRoutineToDay(today.weekday, a.id);
      expect(fit.moveRoutineDay(a.id, today, DateTime.now()), isNull);
      expect(fit.planMoves, isEmpty);
    });

    test('los cambios viejos se borran solos', () {
      final a = routine('A');
      fit.planMoves['2001-01-01'] = [a.id];
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.moveRoutineDay(a.id, today, day(1));
      expect(fit.planMoves.containsKey('2001-01-01'), isFalse);
    });

    test('borrar la rutina la quita también de los días movidos', () {
      final a = routine('A');
      final today = DateTime.now();
      fit.assignRoutineToDay(today.weekday, a.id);
      fit.moveRoutineDay(a.id, today, day(1));
      fit.deleteRoutine(a.id);
      expect(fit.routinesOn(day(1)), isEmpty);
    });
  });

  group('#81 entreno que pasa de medianoche', () {
    test('cuenta en el día en que empezó', () {
      final end = day(0, 1);
      fit.sessions.add(
        LoggedSession(end, 2 * 3600, [
          LoggedExercise(bench(), 'Bench Press', 'chest', [LoggedSet(8, 60)]),
        ]),
      );
      expect(fit.trainedToday, isFalse);
      expect(fit.sessionsOn(day(-1)).length, 1);
      expect(fit.sessionsOn(DateTime.now()), isEmpty);
    });
  });

  group('#212 series añadidas en la rutina', () {
    test('añadir una serie se ofrece guardar y queda en la rutina', () {
      final r = routine('A', [bench(), squat()]);
      expect(fit.routineSets(r, bench()), 3);
      fit.startRoutine(r);
      fit.endCountdown();
      fit.addSet(0);
      fit.removeSet(1, 2);
      fit.toggleSet(0, 0);
      fit.finishSession();
      expect(fit.sessionEditedRoutine, isTrue);
      final changes = fit.sessionRoutineChanges;
      expect(changes.added, isEmpty);
      expect([for (final c in changes.sets) (c.ex.id, c.from, c.to)], [(bench(), 3, 4), (squat(), 3, 2)]);
      fit.saveSessionIntoRoutine();
      expect(fit.routineSets(r, bench()), 4);
      expect(fit.routineSets(r, squat()), 2);
      expect(fit.sessionEditedRoutine, isFalse);
    });

    test('con series planificadas copia la última', () {
      final r = routine('A');
      fit.setPlannedSets(r.id, bench(), const [
        PlannedSet(kind: SetKind.warmup, reps: 10),
        PlannedSet(reps: 8, weightKg: 60),
        PlannedSet(reps: 6, weightKg: 70),
      ]);
      fit.startRoutine(r);
      fit.endCountdown();
      fit.addSet(0);
      fit.toggleSet(0, 0);
      fit.finishSession();
      fit.saveSessionIntoRoutine();
      final plan = fit.plannedSets(r, bench());
      expect(plan.length, 4);
      expect(plan.first.kind, SetKind.warmup);
      expect(plan.last.reps, 6);
      expect(plan.last.weightKg, 70);
    });

    test('sin cambios no molesta', () {
      final r = routine('A');
      train(r);
      expect(fit.sessionEditedRoutine, isFalse);
    });
  });

  group('#211 press inclinado en máquina', () {
    test('está en el catálogo con su dibujo', () {
      final ex = fit.exerciseById('incline-chest-press-machine');
      expect(ex, isNotNull);
      expect(ex!.equipment, 'Machine');
      expect(File('assets/art/${ex.art}.txt').readAsLinesSync().where((l) => l.isNotEmpty).length, 2);
      expect(fit.matchExerciseByName('Incline Chest Press (Machine)')?.id, ex.id);
    });
  });

  group('descanso', () {
    test('quitar segundos baja la barra y sumar la alarga', () {
      final r = routine('A');
      fit.setRoutineRest(r.id, bench(), 120);
      fit.startRoutine(r);
      fit.endCountdown();
      fit.toggleSet(0, 0);
      expect(fit.restTotal, 120);
      fit.nudgeRest(-15);
      fit.nudgeRest(-15);
      expect(fit.restTotal, 120);
      expect(fit.session!.restRemaining, lessThanOrEqualTo(90));
      fit.nudgeRest(60);
      expect(fit.restTotal, greaterThanOrEqualTo(fit.session!.restRemaining!));
      fit.skipRest();
    });

    test('cuando el aviso nativo dice que acabó, se cierra el descanso', () {
      final r = routine('A');
      fit.startRoutine(r);
      fit.endCountdown();
      fit.toggleSet(0, 0);
      final s = fit.session!;
      s.restEndsAt = DateTime.now().subtract(const Duration(seconds: 1));
      final tick = fit.restDoneTick;
      fit.restElapsed();
      expect(s.restEndsAt, isNull);
      expect(fit.restDoneTick, tick + 1);
      fit.restElapsed();
      expect(fit.restDoneTick, tick + 1);
    });
  });
}
