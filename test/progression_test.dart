import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/progression.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('descarga automática', () {
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

    String bench() => fit.matchExerciseByName('Bench Press')!.id;

    test('sin «subir el peso solo» no hay descarga', () {
      final id = bench();
      for (final d in [9, 6, 3]) {
        logged(id, d, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      }
      expect(fit.stallStreak(id), 3);
      expect(fit.needsDeload(id), isFalse);
    });

    test('tres entrenos al mismo peso sin cumplir bajan al 90 %', () {
      final id = bench();
      fit.progressStep[id] = 2.5;
      for (final d in [9, 6, 3]) {
        logged(id, d, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      }
      final next = fit.nextTarget(id)!;
      expect(next.deload, isTrue);
      expect(next.up, isFalse);
      expect(next.weightKg, 72.5);
      final r = fit.createRoutine('Pecho');
      fit.toggleRoutineExercise(r, id);
      fit.startRoutine(fit.routines.single);
      expect(fit.session!.exercises.single.sets.where((s) => s.kind != SetKind.warmup).first.weight, 72.5);
      fit.saveAndExit();
    });

    test('dos fallos no bastan y cambiar de peso empieza la cuenta de cero', () {
      final id = bench();
      fit.progressStep[id] = 2.5;
      logged(id, 12, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      logged(id, 9, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      expect(fit.needsDeload(id), isFalse);
      logged(id, 6, [LoggedSet(8, 72.5), LoggedSet(6, 72.5)]);
      expect(fit.stallStreak(id), 1);
      logged(id, 3, [LoggedSet(8, 72.5), LoggedSet(8, 72.5)]);
      expect(fit.stallStreak(id), 0);
      expect(fit.nextTarget(id)!.up, isTrue);
    });

    test('en una asistida la descarga da más ayuda', () {
      const pull = 'kiJ4Z2K';
      fit.progressStep[pull] = 2.5;
      for (final d in [9, 6, 3]) {
        logged(pull, d, [LoggedSet(8, 30), LoggedSet(5, 30)]);
      }
      final next = fit.nextTarget(pull)!;
      expect(next.deload, isTrue);
      expect(next.weightKg, 32.5);
    });

    test('con poco peso baja al menos un escalón', () {
      final id = bench();
      fit.progressStep[id] = 2.5;
      for (final d in [9, 6, 3]) {
        logged(id, d, [LoggedSet(8, 5), LoggedSet(6, 5)]);
      }
      expect(fit.nextTarget(id)!.weightKg, 2.5);
    });
  });

  group('#253 tipos de progresión', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
    });

    String bench() => fit.matchExerciseByName('Bench Press')!.id;
    DateTime ago(int d) => DateTime.now().subtract(Duration(days: d));
    void logged(String id, int days, List<LoggedSet> sets) =>
        fit.sessions.add(LoggedSession(ago(days), 1200, [LoggedExercise(id, id, 'chest', sets)]));
    List<(int, double)> opening(String id) {
      final r = fit.createRoutine('R');
      fit.toggleRoutineExercise(r, id);
      fit.startRoutine(fit.routines.firstWhere((x) => x.id == r));
      final out = [
        for (final s in fit.session!.exercises.single.sets.where((s) => s.kind != SetKind.warmup)) (s.reps, s.weight)
      ];
      fit.saveAndExit();
      return out;
    }

    void use(String id, ProgressRule r) => fit.setProgressRule(id, r);

    test('por defecto sigue siendo lineal y solo sugiere', () {
      final id = bench();
      expect(fit.progressRule(id).kind, ProgressKind.linear);
      expect(fit.hasProgress(id), isFalse);
      logged(id, 2, [LoggedSet(8, 60), LoggedSet(8, 60)]);
      expect(fit.nextTarget(id)!.weightKg, 62.5);
      expect(opening(id).first, (8, 60.0));
    });

    test('elegir una estrategia la deja aplicándose sola', () {
      final id = bench();
      use(id, const ProgressRule(kind: ProgressKind.double));
      expect(fit.hasProgress(id), isTrue);
      expect(fit.progressFor(id), 2.5);
    });

    test('manual: sin sugerencia y el peso tal cual', () {
      final id = bench();
      fit.toggleProgress(id);
      use(id, const ProgressRule(kind: ProgressKind.manual));
      logged(id, 2, [LoggedSet(8, 60), LoggedSet(8, 60)]);
      expect(fit.hasProgress(id), isFalse);
      expect(fit.nextTarget(id), isNull);
      expect(opening(id).first, (8, 60.0));
    });

    group('doble progresión 8–12', () {
      setUp(() => use(bench(), const ProgressRule(kind: ProgressKind.double, low: 8, high: 12)));

      test('sin llegar al tope: mismo peso y una repe más en cada serie', () {
        final id = bench();
        logged(id, 2, [LoggedSet(10, 26), LoggedSet(9, 26), LoggedSet(8, 26)]);
        final next = fit.nextTarget(id)!;
        expect(next.move, NextMove.reps);
        expect(next.weightKg, 26);
        expect(opening(id), [(11, 26.0), (10, 26.0), (9, 26.0)]);
        expect(fit.nextWhy(id), t.nextMoreReps);
        expect(fit.nextTargetLabel(id), '26 kg × 11/10/9');
      });

      test('las tres series a 12: sube el peso y vuelve a 8', () {
        final id = bench();
        logged(id, 2, [LoggedSet(12, 26), LoggedSet(12, 26), LoggedSet(12, 26)]);
        expect(fit.nextTarget(id)!.move, NextMove.up);
        expect(fit.nextTargetLabel(id), '28.5 kg × 8');
        expect(opening(id), [(8, 28.5), (8, 28.5), (8, 28.5)]);
      });

      test('nunca pide más del tope del rango', () {
        final id = bench();
        logged(id, 2, [LoggedSet(12, 26), LoggedSet(11, 26)]);
        expect(opening(id).take(2), [(12, 26.0), (12, 26.0)]);
      });

      test('estancado: sin sumar repes 3 veces seguidas, descarga', () {
        final id = bench();
        logged(id, 12, [LoggedSet(9, 60), LoggedSet(8, 60)]);
        for (final d in [9, 6, 3]) {
          logged(id, d, [LoggedSet(9, 60), LoggedSet(8, 60)]);
        }
        expect(fit.stallStreak(id), 3);
        final next = fit.nextTarget(id)!;
        expect(next.deload, isTrue);
        expect(next.weightKg, 55);
        expect(next.reps, 8);
      });

      test('si sumas repes no cuenta como estancado', () {
        final id = bench();
        logged(id, 9, [LoggedSet(8, 60), LoggedSet(8, 60)]);
        logged(id, 6, [LoggedSet(9, 60), LoggedSet(8, 60)]);
        logged(id, 3, [LoggedSet(9, 60), LoggedSet(9, 60)]);
        expect(fit.stallStreak(id), 0);
      });
    });

    group('repes, series y peso', () {
      setUp(() => use(bench(), const ProgressRule(kind: ProgressKind.volume, low: 8, high: 12, sets: 2, maxSets: 3)));

      test('al tope con menos series del máximo: una serie más, vuelta a 8', () {
        final id = bench();
        logged(id, 2, [LoggedSet(12, 40), LoggedSet(12, 40)]);
        expect(fit.nextTarget(id)!.move, NextMove.addSet);
        expect(fit.nextTargetLabel(id), '3 × 40 kg × 8');
        expect(opening(id), [(8, 40.0), (8, 40.0), (8, 40.0)]);
      });

      test('al tope con todas las series: más peso y vuelta a las series de partida', () {
        final id = bench();
        logged(id, 2, [LoggedSet(12, 40), LoggedSet(12, 40), LoggedSet(12, 40)]);
        expect(fit.nextTarget(id)!.move, NextMove.up);
        expect(opening(id), [(8, 42.5), (8, 42.5)]);
      });
    });

    group('última serie a tope', () {
      setUp(() => use(bench(), const ProgressRule(kind: ProgressKind.amrap)));

      test('elegirla descarga al primer fallo', () {
        expect(fit.progressRule(bench()).fails, 1);
      });

      test('cumplir sube un salto', () {
        final id = bench();
        logged(id, 2, [LoggedSet(5, 60), LoggedSet(5, 60), LoggedSet(7, 60)]);
        expect(fit.nextTarget(id)!.weightKg, 62.5);
        expect(opening(id), [(5, 62.5), (5, 62.5), (5, 62.5)]);
        expect(fit.nextWhy(id), t.nextAmrap);
      });

      test('doblar el objetivo en la última sube dos saltos', () {
        final id = bench();
        logged(id, 2, [LoggedSet(5, 60), LoggedSet(5, 60), LoggedSet(10, 60)]);
        expect(fit.nextTarget(id)!.weightKg, 65);
      });

      test('fallar descarga un 10 %', () {
        final id = bench();
        logged(id, 2, [LoggedSet(5, 60), LoggedSet(5, 60), LoggedSet(3, 60)]);
        final next = fit.nextTarget(id)!;
        expect(next.deload, isTrue);
        expect(next.weightKg, 55);
      });
    });

    test('la descarga usa el porcentaje y los fallos elegidos', () {
      final id = bench();
      fit.toggleProgress(id);
      use(id, fit.progressRule(id).copyWith(fails: 2, deloadPct: 20));
      logged(id, 6, [LoggedSet(8, 100), LoggedSet(6, 100)]);
      logged(id, 3, [LoggedSet(8, 100), LoggedSet(6, 100)]);
      expect(fit.nextTarget(id)!.weightKg, 80);
    });

    test('el rango no se cruza', () {
      const r = ProgressRule(kind: ProgressKind.double, low: 8, high: 12);
      expect(r.copyWith(low: 15).high, 16);
      expect(r.copyWith(high: 3).high, 9);
      expect(const ProgressRule(sets: 3, maxSets: 5).copyWith(sets: 6).maxSets, 7);
    });

    test('se guarda en la copia y se borra con los datos', () async {
      final id = bench();
      use(id, const ProgressRule(kind: ProgressKind.volume, low: 6, high: 10, sets: 2, maxSets: 4));
      fit.persistNow();
      await pumpEventQueue();
      fit.loadFromStore();
      final r = fit.progressRule(id);
      expect((r.kind, r.low, r.high, r.sets, r.maxSets), (ProgressKind.volume, 6, 10, 2, 4));
      fit.resetAllData();
      expect(fit.progressRule(id).kind, ProgressKind.linear);
    });
  });

  group('progresión automática', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    String bench() => fit.matchExerciseByName('Barbell Bench Press')!.id;

    Routine routineWith(List<String> ids) {
      final id = fit.createRoutine('Push');
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      return fit.routines.firstWhere((r) => r.id == id);
    }

    group('progresión automática', () {
      void logBench(int reps, double kg, int sets) {
        final r = routineWith([bench()]);
        fit.startRoutine(r);
        final session = fit.session!;
        while (session.exercises.first.sets.length > sets) {
          session.exercises.first.sets.removeLast();
        }
        for (var i = 0; i < sets; i++) {
          fit.setSessionReps(0, i, reps);
          fit.setSessionWeight(0, i, kg);
          fit.toggleSet(0, i);
        }
        fit.finishSession();
        fit.saveAndExit();
      }

      test('sube el peso cuando cumpliste todas las repes', () {
        fit.toggleProgress(bench());
        logBench(5, 60, 3);

        final r = fit.routines.first;
        fit.startRoutine(r);
        expect(fit.session!.exercises.first.sets.first.weight, 62.5);
      });

      test('no sube si se te cayeron las repes', () {
        fit.toggleProgress(bench());
        final r = routineWith([bench()]);
        fit.startRoutine(r);
        final sets = fit.session!.exercises.first.sets;
        while (sets.length > 2) {
          sets.removeLast();
        }
        fit.setSessionReps(0, 0, 5);
        fit.setSessionWeight(0, 0, 60);
        fit.toggleSet(0, 0);
        fit.setSessionReps(0, 1, 3);
        fit.setSessionWeight(0, 1, 60);
        fit.toggleSet(0, 1);
        fit.finishSession();
        fit.saveAndExit();

        fit.startRoutine(fit.routines.first);
        expect(fit.session!.exercises.first.sets.first.weight, 60);
      });

      test('sin progresión el peso se queda como estaba', () {
        logBench(5, 60, 2);
        fit.startRoutine(fit.routines.first);
        expect(fit.session!.exercises.first.sets.first.weight, 60);
      });
    });

    group('recomendación para la próxima (issue #12)', () {
      void logBenchSets(List<(int, double)> sets) {
        final r = routineWith([bench()]);
        fit.startRoutine(r);
        final live = fit.session!.exercises.first.sets;
        while (live.length > sets.length) {
          live.removeLast();
        }
        while (live.length < sets.length) {
          fit.addSet(0);
        }
        for (var i = 0; i < sets.length; i++) {
          fit.setSessionReps(0, i, sets[i].$1);
          fit.setSessionWeight(0, i, sets[i].$2);
          fit.toggleSet(0, i);
        }
        fit.finishSession();
        fit.saveAndExit();
      }

      test('sin historial no propone nada', () {
        expect(fit.nextTarget(bench()), isNull);
        expect(fit.nextTargetLabel(bench()), isNull);
      });

      test('si cumpliste todas las repes propone subir', () {
        logBenchSets([(10, 60), (10, 60), (10, 60)]);
        final next = fit.nextTarget(bench())!;
        expect(next.up, isTrue);
        expect(next.weightKg, 62.5);
        expect(next.reps, 10);
        expect(fit.nextTargetLabel(bench()), '62.5 kg × 10');
      });

      test('si se te cayeron las repes propone repetir el peso', () {
        logBenchSets([(10, 60), (8, 60)]);
        final next = fit.nextTarget(bench())!;
        expect(next.up, isFalse);
        expect(next.weightKg, 60);
      });

      test('respeta el incremento que hayas puesto en el ejercicio', () {
        fit.toggleProgress(bench());
        fit.bumpProgressStep(bench(), 1);
        fit.bumpProgressStep(bench(), 1);
        expect(fit.progressFor(bench()), 5);
        logBenchSets([(5, 100), (5, 100)]);
        expect(fit.nextTarget(bench())!.weightKg, 105);
      });

      test('en un ejercicio sin peso propone una repe más', () {
        final pushUp = fit.matchExerciseByName('Push-Up')!.id;
        expect(fit.isRepsOnly(pushUp), isTrue);
        final r = routineWith([pushUp]);
        fit.startRoutine(r);
        final live = fit.session!.exercises.first.sets;
        while (live.length > 1) {
          live.removeLast();
        }
        fit.setSessionReps(0, 0, 12);
        fit.setSessionWeight(0, 0, 0);
        fit.toggleSet(0, 0);
        fit.finishSession();
        fit.saveAndExit();

        final next = fit.nextTarget(pushUp)!;
        expect(next.up, isTrue);
        expect(next.reps, 13);
        expect(fit.nextTargetLabel(pushUp), '13 reps');
      });
    });
  });
}
