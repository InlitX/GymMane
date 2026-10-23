import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/live_session.dart';
import 'package:gymmane/models/profile.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_share.dart';
import 'package:gymmane/state/fit_state.dart';
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

  group('importar una rutina que ya tienes', () {
    String own() {
      final id = fit.createRoutine('Push');
      fit.toggleRoutineExercise(id, fit.matchExerciseByName('Barbell Bench Press')!.id);
      return fit.exportPlanJson(fit.routines);
    }

    test('la vista previa sabe que ya la tienes', () {
      final plans = parsePlan(own());
      final preview = fit.previewPlan(plans);
      expect(preview.routines, 1);
      expect(preview.owned, 1);
      expect(fit.ownsPlan(plans.single), isTrue);
    });

    test('como copia se añade otra vez', () {
      final plans = parsePlan(own());
      expect(fit.applyPlan(plans).routines, 0);
      expect(fit.applyPlan(plans, copies: true).routines, 1);
      expect(fit.routines.length, 2);
    });

    test('en otro móvil se importa normal', () {
      final json = own();
      fit.resetAllData();
      final plans = parsePlan(json);
      expect(fit.previewPlan(plans).owned, 0);
      expect(fit.applyPlan(plans).routines, 1);
    });
  });

  group('#250 series cluster', () {
    test('es un tipo de serie más y no rompe los guardados viejos', () {
      expect(SetKind.values.last, SetKind.cluster);
      expect(setKindFrom(SetKind.restPause.index), SetKind.restPause);
      final back = LoggedSet.fromJson(LoggedSet(9, 80, kind: SetKind.cluster).toJson());
      expect(back.kind, SetKind.cluster);
      expect(back.counts, isTrue);
    });

    test('viaja en el plan compartido', () {
      final plans = parsePlan('{"name":"A","exercises":[{"name":"Barbell Full Squat",'
          '"plan":[{"type":"cluster","reps":12,"weight":100}]}]}');
      expect(plans.single.items.single.plan.single.kind, SetKind.cluster.index);
      fit.applyPlan(plans);
      final r = fit.routines.single;
      expect(fit.exportPlanJson([r]), contains('"type": "cluster"'));
    });
  });

  group('deslizar para duplicar una serie', () {
    test('la copia va justo debajo, sin marcar, y se puede deshacer', () {
      fit.startWorkout();
      fit.toggleMuscle('chest');
      fit.trainContinue();
      fit.startSession();
      final sets = fit.session!.exercises.first.sets;
      final before = sets.length;
      fit.setSessionReps(0, 0, 7);
      fit.setSessionWeight(0, 0, 42.5);
      fit.toggleSet(0, 0);
      final copy = fit.duplicateSet(0, 0)!;
      expect(sets.length, before + 1);
      expect(identical(sets[1], copy), isTrue);
      expect(copy.done, isFalse);
      expect((copy.reps, copy.weight), (7, 42.5));
      fit.removeSetObject(0, copy);
      expect(sets.length, before);
      expect(sets.contains(copy), isFalse);
    });
  });

  group('fuerza relativa', () {
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

  group('ejercicios por zona', () {
    test('piernas trae los de pierna primero y se limpia con el resto', () {
      fit.setZoneFilter('Legs');
      final list = fit.exercisesFiltered;
      final legs = kBodyZones['Legs']!;
      expect(list, isNotEmpty);
      expect(legs.contains(list.first.primary), isTrue);
      expect(list.every((e) => legs.contains(e.primary) || e.secondary.any(legs.contains)), isTrue);
      expect(fit.zoneCount('Legs'), list.where((e) => legs.contains(e.primary)).length);
      fit.setMuscleFilter('chest');
      expect(fit.exZoneFilter, isNull);
      fit.setZoneFilter('Arms');
      expect(fit.exMuscleFilter, isNull);
      fit.clearExFilters();
      expect(fit.exZoneFilter, isNull);
    });

    test('cada músculo del filtro cae en una zona', () {
      final all = kBodyZones.values.expand((m) => m).toSet();
      expect(all, containsAll(kFilterMuscles));
    });
  });

  test('#238 side bend: oblicuos primero', () {
    for (final name in ['Dumbbell Side Bend', 'Weighted Side Bend (On Stability Ball)']) {
      final ex = kExercises.firstWhere((e) => e.name == name);
      expect(ex.primary, 'obliques');
      expect(ex.secondary, ['abdomen']);
    }
  });
}
