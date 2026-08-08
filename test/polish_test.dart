import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
    setAppLanguage('en');
  });

  group('favourites filter', () {
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

    test('search finds exercises by their Spanish name too', () {
      setAppLanguage('es');
      fit.setExSearch('sentadilla');
      expect(fit.exercisesFiltered, isNotEmpty);
      fit.clearExFilters();
    });
  });

  group('naming a routine', () {
    test('a new routine starts unnamed so the field shows its hint', () {
      final id = fit.createRoutine();
      expect(fit.routines.single.name, '');
      expect(fit.routineTitle(fit.routines.single), t.newRoutineName);
      fit.renameRoutine(id, 'Empuje');
      expect(fit.routineTitle(fit.routines.single), 'Empuje');
    });

    test('clearing the name to retype it does not stick the old one', () {
      final id = fit.createRoutine('Viejo');
      fit.renameRoutine(id, '');
      expect(fit.routines.single.name, '');
      fit.renameRoutine(id, 'Nuevo');
      expect(fit.routines.single.name, 'Nuevo');
    });
  });

  group('finish screen tells the truth', () {
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

  group('light theme belongs to the same family as dark', () {

    double lin(double c) => c <= 0.03928 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
    double lum(Color c) => 0.2126 * lin(c.r) + 0.7152 * lin(c.g) + 0.0722 * lin(c.b);
    double contrast(Color a, Color b) {
      final la = lum(a), lb = lum(b);
      return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
    }

    double warmth(Color c) => (c.r - c.b) * 255;

    test('light neutrals are warm, not cold grey', () {
      for (final c in [GymColors.light.bg, GymColors.light.bgRaised2, GymColors.light.border]) {
        expect(warmth(c), greaterThan(6), reason: 'neutro frío: $c');
      }
    });

    test('every text colour on light is actually readable', () {
      final bg = GymColors.light.bg;
      expect(contrast(bg, GymColors.light.text), greaterThan(7), reason: 'principal, AAA');
      expect(contrast(bg, GymColors.light.textSecondary), greaterThan(4.5), reason: 'secundario, AA');

      expect(contrast(bg, GymColors.light.textTertiary), greaterThan(3), reason: 'terciario');
    });

    test('the light accent reads on bone', () {

      expect(contrast(GymColors.light.bg, GymColors.light.accent), greaterThanOrEqualTo(4.5));
    });

    test('dark text stays readable too', () {
      final bg = GymColors.dark.bg;
      expect(contrast(bg, GymColors.dark.text), greaterThan(7));
      expect(contrast(bg, GymColors.dark.textSecondary), greaterThan(4.5));
    });

    test('action colour flips with the theme but keeps its contrast', () {
      expect(contrast(GymColors.dark.ember, GymColors.dark.onEmber), greaterThan(7));
      expect(contrast(GymColors.light.ember, GymColors.light.onEmber), greaterThan(7));
    });
  });
}
