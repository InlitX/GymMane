import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/progression.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/screens/routine_edit_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
    fit.setUnits('kg');
    setAppLanguage('en');
  });

  group('#252 vs la última vez', () {
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

  group('#253 tipos de progresión', () {
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

  group('#247 completa tu día', () {
    setUp(() {
      fit.nutritionBeta = true;
      fit.setAddBurned(false);
      fit.setNutritionGoals(const NutritionGoals(kcal: 2000, protein: 150));
      fit.setTracker(Tracker.protein, true);
    });

    FoodItem chicken() =>
        fit.saveFood(name: 'Pollo', grams: 100, macros: const Macros(kcal: 120, protein: 25, carbs: 0, fat: 2));
    FoodItem rice() =>
        fit.saveFood(name: 'Arroz', grams: 100, macros: const Macros(kcal: 350, protein: 7, carbs: 78, fat: 1));

    test('un alimento proteico cierra la proteína sin pasarse de kcal', () {
      fit.logFood(fit.saveFood(name: 'Base', grams: 100, macros: const Macros(kcal: 1500, protein: 100, carbs: 150, fat: 50)));
      expect(fit.fillGrams(chicken()), closeTo(200, 0.01));
    });

    test('si las kcal se acaban antes, manda el tope de kcal', () {
      fit.logFood(fit.saveFood(name: 'Base', grams: 100, macros: const Macros(kcal: 1880, protein: 60, carbs: 200, fat: 60)));
      expect(fit.fillGrams(chicken()), closeTo(100, 0.01));
    });

    test('un alimento con poca proteína solo rellena las kcal', () {
      fit.logFood(fit.saveFood(name: 'Base', grams: 100, macros: const Macros(kcal: 1300, protein: 145, carbs: 100, fat: 40)));
      expect(fit.fillGrams(rice()), closeTo(200, 0.01));
    });

    test('sin kcal libres no propone nada', () {
      fit.logFood(fit.saveFood(name: 'Base', grams: 100, macros: const Macros(kcal: 2100, protein: 100, carbs: 200, fat: 60)));
      expect(fit.fillGrams(chicken()), isNull);
    });

    test('al editar una entrada, su propia ración no cuenta como comida', () {
      final e = fit.logFood(chicken(), servings: 2);
      expect(fit.fillGrams(chicken(), replacing: e.total), closeTo(600, 0.01));
    });

    test('te quedarán: resta lo que vas a apuntar', () {
      fit.logFood(fit.saveFood(name: 'Base', grams: 100, macros: const Macros(kcal: 1000, protein: 50, carbs: 100, fat: 30)));
      final left = fit.leftAfter(const Macros(kcal: 240, protein: 50, carbs: 0, fat: 4));
      expect(left.kcal, 760);
      expect(left.protein, 50);
    });
  });

  testWidgets('#251 arrastrar al borde de abajo desplaza la lista de la rutina', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final id = fit.createRoutine('Larga');
    for (final ex in fit.allExercises.take(15)) {
      fit.toggleRoutineExercise(id, ex.id);
    }
    fit.openRoutine(id);
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.dark,
      home: AnimatedBuilder(
        animation: fit,
        builder: (_, _) => const Scaffold(body: RoutineEditScreen()),
      ),
    ));
    await tester.pump(const Duration(seconds: 1));

    final handle = find.byType(ReorderableDragStartListener).first;
    await tester.ensureVisible(handle);
    await tester.pump(const Duration(milliseconds: 300));
    final scroll = tester.state<ScrollableState>(find.byType(Scrollable).first).position;
    final start = scroll.pixels;

    final drag = await tester.startGesture(tester.getCenter(handle));
    await drag.moveBy(const Offset(0, 20));
    await tester.pump(const Duration(milliseconds: 100));
    await drag.moveTo(const Offset(200, 790));
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(scroll.pixels, greaterThan(start + 100));
    await drag.up();
    await tester.pump(const Duration(seconds: 1));
  });
}
