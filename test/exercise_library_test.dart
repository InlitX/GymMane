import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/exercise_match.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#179 filtro de trapecio', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('trapecio, antebrazo y oblicuos salen en el filtro y encuentran ejercicios', () {
      for (final m in ['trapezius', 'forearm', 'obliques']) {
        expect(kFilterMuscles, contains(m));
        fit.setMuscleFilter(m);
        expect(fit.exercisesFiltered, isNotEmpty, reason: m);
        expect(
            fit.exercisesFiltered.every((e) => e.primary == m || e.secondary.contains(m)), isTrue);
        fit.setMuscleFilter(m);
      }
    });
  });

  group('suggestions', () {
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

    test('an exercise switched off never lands in the picks but stays searchable', () {
      fit.selectedMuscles
        ..clear()
        ..add('chest');
      fit.trainContinue();
      final first = fit.sessionPicks.first;
      fit.toggleSuggest(first);
      fit.trainContinue();
      expect(fit.sessionPicks.contains(first), isFalse);
      expect(fit.trainSearchResults(fit.exerciseById(first)!.name).map((e) => e.id), contains(first));
      expect(fit.recommendedExercises(20).map((e) => e.id), isNot(contains(first)));
    });

    test('the suggested picks come first in the review list', () {
      fit.selectedMuscles
        ..clear()
        ..addAll(['chest', 'triceps']);
      fit.trainContinue();
      final list = fit.reviewExercises();
      final seeded = list.take(fit.pickSeed.length).map((e) => e.id).toSet();
      expect(seeded, fit.pickSeed);
    });

    test('hidden exercises survive a restart', () {
      fit.toggleSuggest(idOf('Barbell Bench Press'));
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.suggests(idOf('Barbell Bench Press')), isFalse);
    });
  });

  group('#237 buscador', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    List<String> search(String q) => kExercises.where(exerciseSearch(q)).map((e) => e.name).toList();

    test('gemelos en plural, por músculo y con palabras desordenadas', () {
      expect(search('Calf raises'), contains('Bodyweight Standing Calf Raise'));
      expect(search('calves'), contains('Donkey Calf Raise'));
      expect(search('machine calf raise'), contains('Lever Standing Calf Raise'));
      expect(search('seated calf raises'), contains('Dumbbell Seated One Leg Calf Raise'));
      expect(search('calf ra'), contains('Smith Calf Raise'));
    });

    test('el nombre del músculo en castellano también busca', () {
      setAppLanguage('es');
      expect(search('gemelos'), contains('Donkey Calf Raise'));
      setAppLanguage('en');
    });

    test('no se cuelan resultados de más', () {
      expect(search('calf raise').every((n) => n.toLowerCase().contains('calf')), isTrue);
      expect(search('bench press'), isNot(contains('Donkey Calf Raise')));
      expect(search('ch'), isNot(contains('Donkey Calf Raise')));
    });
  });

  group('ejercicios por zona', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
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
  });

  group('biblioteca de ejercicios', () {
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

    group('#115 sin material', () {
      tearDown(fit.clearExFilters);

      test('no enseña lo que necesita barra', () {
        fit.toggleNoGearFilter();
        final ids = fit.exercisesMatching('').map((e) => e.id).toSet();
        expect(ids, isNot(contains(idOf('Pull-up'))));
        expect(ids, isNot(contains('seal-jack')), reason: 'su dibujo es una estación de fondos');
        expect(ids, isNot(contains('outdoor-run')), reason: 'el dibujo es una cinta');
        expect(ids, contains(idOf('Push-up')));
      });

      test('elegir material lo apaga y al revés', () {
        fit.toggleNoGearFilter();
        fit.setEquipmentFilter('Barbell');
        expect(fit.exNoGearOnly, isFalse);
        fit.toggleNoGearFilter();
        expect(fit.exEquipmentFilter, isNull);
      });
    });

    test('#89 solo los creados por ti', () {
      final id = fit.addCustomExercise(name: 'Mi press', primary: 'chest', equipment: 'Dumbbell');
      fit.toggleMineFilter();
      expect(fit.exercisesMatching('').map((e) => e.id), [id]);
      fit.clearExFilters();
    });

    group('#120 calentamiento y #106 cardio', () {
      test('los ejercicios sin peso también calientan', () {
        fit.startRoutine(routineOf(['Push-up']));
        fit.addWarmupSets(0);
        expect(fit.hasWarmup(0), isTrue);
      });

      test('el calentamiento propone movilidad y el cardio solo cardio', () {
        fit.startWorkout();
        fit.startKindWorkout('warmup');
        expect(fit.sessionPicks, isNotEmpty);
        expect(fit.reviewExercises().where((e) => const ['Machine', 'Cable'].contains(e.equipment)), isEmpty);
        fit.startKindWorkout('cardio');
        final cardio = fit.reviewExercises().map((e) => e.id).toSet();
        expect(cardio, containsAll(['skierg', 'battle-ropes', 'running']));
        expect(cardio.every((id) => fit.isCardio(id) || kCardioExtras.contains(id)), isTrue);
        fit.closeTrain();
      });
    });

    group('#119 archivar', () {
      test('un archivado desaparece de todo y vuelve al restaurarlo', () {
        final id = idOf('Pull-up');
        fit.toggleArchived(id);
        expect(fit.exercisesMatching('').map((e) => e.id), isNot(contains(id)));
        expect(fit.trainSearchResults('pull').map((e) => e.id), isNot(contains(id)));
        expect(fit.getFilteredExercises(['back']).map((e) => e.id), isNot(contains(id)));
        expect(fit.recommendedExercises(40).map((e) => e.id), isNot(contains(id)));

        fit.toggleArchivedFilter();
        expect(fit.exercisesMatching('').map((e) => e.id), [id]);

        fit.toggleArchived(id);
        expect(fit.exArchivedOnly, isFalse, reason: 'sin archivados el filtro se apaga');
        expect(fit.exercisesMatching('').map((e) => e.id), contains(id));
      });

      test('se guarda en la copia', () {
        fit.toggleArchived(idOf('Pull-up'));
        expect(fit.toJson()['archived'], [idOf('Pull-up')]);
      });
    });

    test('#95 los recomendados se pueden quitar y se guarda', () {
      expect(fit.showRecommended, isTrue);
      fit.toggleRecommended();
      expect(fit.toJson()['showRecs'], isFalse);
    });

    test('#111 las marcas del vídeo se guardan y se van con el vídeo', () {
      final id = idOf('Barbell Bench Press');
      fit.setVideoMark(id, 1, 40000);
      expect(fit.videoMark(id, 1), 40000);
      expect(fit.toJson()['marks'], {id: {'1': 40000}});
      fit.setVideoMark(id, 1, null);
      expect(fit.videoMarks, isEmpty);
      fit.setVideoMark(id, 0, 1000);
      fit.clearExerciseMedia(id);
      expect(fit.videoMark(id, 0), isNull);
    });

    test('#105 las notas de un ejercicio se abren en lista y atrás vuelve', () {
      fit.openExercise(idOf('Plank'));
      fit.goNotes(exerciseId: idOf('Plank'), all: true);
      expect(fit.notesAllView, isTrue);
      fit.backFromNotes();
      expect(fit.route, 'exercise-detail');
    });
  });

  group('favourites filter', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    test('marking a star and filtering leaves only that exercise', () {
      final a = kExercises[0], b = kExercises[1];
      fit.toggleFavorite(a.id);
      expect(fit.favouriteCount, 1);

      fit.toggleFavouritesFilter();
      final list = fit.exercisesFiltered;
      expect(list.map((e) => e.id), [a.id]);
      expect(list.contains(b), false);
    });

    test('the filter stacks with the muscle one instead of replacing it', () {
      final chest = kExercises.firstWhere((e) => e.primary == 'chest');
      final back = kExercises.firstWhere((e) => e.primary == 'back');
      fit.toggleFavorite(chest.id);
      fit.toggleFavorite(back.id);

      fit.toggleFavouritesFilter();
      fit.setMuscleFilter('chest');
      expect(fit.exercisesFiltered.map((e) => e.id), contains(chest.id));
      expect(fit.exercisesFiltered.map((e) => e.id), isNot(contains(back.id)));
    });

    test('un-starring drops it out of the filtered list', () {
      final a = kExercises[0];
      fit.toggleFavorite(a.id);
      fit.toggleFavouritesFilter();
      expect(fit.exercisesFiltered, isNotEmpty);

      fit.toggleFavorite(a.id);
      expect(fit.favouriteCount, 0);
      expect(fit.exercisesFiltered, isEmpty);
    });

    test('clearing filters brings the whole library back', () {
      fit.toggleFavouritesFilter();
      fit.setMuscleFilter('chest');
      fit.setExSearch('press');
      fit.clearExFilters();
      expect(fit.exercisesFiltered.length, fit.allExercises.length);
    });

    test('the muscle filter leads with the exercises that actually train it', () {
      fit.setMuscleFilter('back');
      final list = fit.exercisesFiltered;
      expect(list, isNotEmpty);
      final firstSecondary = list.indexWhere((e) => e.primary != 'back');
      final lastPrimary = list.lastIndexWhere((e) => e.primary == 'back');
      expect(firstSecondary == -1 || firstSecondary > lastPrimary, true,
          reason: 'los de espalda van antes que los que solo la tocan de apoyo');
      fit.clearExFilters();
    });

    test('search finds exercises by their Spanish name too', () {
      setAppLanguage('es');
      fit.setExSearch('sentadilla');
      expect(fit.exercisesFiltered, isNotEmpty);
      fit.clearExFilters();
    });
  });
}
