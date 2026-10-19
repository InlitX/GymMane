import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/food_library.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/sticker_cutout.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

FoodItem lib(String es) => FoodLibrary.foods.firstWhere((f) => f.names['es'] == es).item('es');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    FoodLibrary.parse(File('assets/data/foods.tsv').readAsStringSync());
    FoodLibrary.parseDishes(File('assets/data/dishes.tsv').readAsStringSync());
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.setUnits('kg');
  });

  const whey = Macros(kcal: 120, protein: 24, carbs: 3, fat: 1.5);

  group('comidas', () {
    test('apuntar un alimento suma sus macros por ración', () {
      final food = fit.saveFood(name: 'Whey', serving: '30 g', macros: whey);
      fit.logFood(food, servings: 1.5, meal: Meal.snacks);
      final total = fit.totalOn(DateTime.now());
      expect(total.kcal, 180);
      expect(total.protein, 36);
      expect(fit.entriesOn(DateTime.now()).single.meal, Meal.snacks);
    });

    test('el añadido rápido sin números no apunta nada y sin kcal las calcula', () {
      expect(fit.logQuick('Nada', Macros.zero), isNull);
      final e = fit.logQuick('', const Macros(kcal: 500, protein: 30))!;
      expect(fit.totalOn(DateTime.now()).kcal, 500);
      expect(e.name, isEmpty);
    });

    test('quitar y deshacer deja la comida como estaba', () {
      final e = fit.logQuick('Pollo', const Macros(kcal: 640, protein: 48))!;
      final gone = fit.removeEntry(e.id)!;
      expect(fit.entriesOn(DateTime.now()), isEmpty);
      fit.restoreEntry(gone);
      expect(fit.totalOn(DateTime.now()).protein, 48);
    });

    test('lo apuntado en otro día no cuenta para hoy', () {
      fit.setNutritionDay(shiftDays(DateTime.now(), -2));
      fit.logQuick('Ayer', const Macros(kcal: 300));
      expect(fit.totalOn(DateTime.now()).kcal, 0);
      expect(fit.totalOn(fit.nutritionDay).kcal, 300);
    });

    test('no se puede ir a un día futuro', () {
      fit.setNutritionDay(shiftDays(DateTime.now(), 3));
      final now = DateTime.now();
      expect(fit.nutritionDay, DateTime(now.year, now.month, now.day));
    });

    test('borrar un alimento no borra lo que ya se apuntó', () {
      final food = fit.saveFood(name: 'Pan', macros: const Macros(kcal: 180));
      fit.logFood(food);
      fit.deleteFood(food.id);
      expect(fit.foods, isEmpty);
      expect(fit.totalOn(DateTime.now()).kcal, 180);
    });
  });

  group('agua y suplementos', () {
    test('cada vaso suma su tamaño y deshacer quita el último', () {
      fit.addWater();
      fit.addWater(500);
      expect(fit.waterOn(DateTime.now()), fit.activeGoals.glassMl + 500);
      expect(fit.undoWater(), isTrue);
      expect(fit.waterOn(DateTime.now()), fit.activeGoals.glassMl);
    });

    test('un suplemento se marca por día y al quitarlo se van sus marcas', () {
      final s = fit.addSupplement('Creatina', dose: '5 g')!;
      fit.toggleSupplement(s.id);
      expect(fit.takenOn(DateTime.now()), {s.id});
      fit.removeSupplement(s.id);
      expect(fit.takenOn(DateTime.now()), isEmpty);
      expect(fit.addSupplement('  '), isNull);
    });
  });

  group('objetivos', () {
    test('sin tocar nada salen del perfil, y al fijarlos mandan los tuyos', () {
      fit.profile.weightKg = 80;
      final auto = fit.activeGoals;
      expect(auto.protein, 144);
      expect(auto.waterMl, 2750);
      fit.setNutritionGoals(auto.copyWith(protein: 180));
      expect(fit.activeGoals.protein, 180);
    });
  });

  group('guardado', () {
    test('todo sobrevive a cerrar la app', () {
      final food = fit.saveFood(name: 'Whey', photo: 'food-x.png', serving: '30 g', macros: whey);
      fit.logFood(food, meal: Meal.breakfast);
      fit.addWater(750);
      final s = fit.addSupplement('Omega 3')!;
      fit.toggleSupplement(s.id);
      fit.setNutritionGoals(const NutritionGoals(kcal: 2500, protein: 170));
      fit.persistNow();

      fit.loadFromStore();
      expect(fit.foods.single.photo, 'food-x.png');
      expect(fit.totalOn(DateTime.now()).protein, 24);
      expect(fit.waterOn(DateTime.now()), 750);
      expect(fit.takenOn(DateTime.now()), {s.id});
      expect(fit.activeGoals.kcal, 2500);
    });

    test('al restaurar una copia las fotos apuntan a los ficheros nuevos', () {
      fit.saveFood(name: 'Whey', photo: 'viejo.png', macros: whey);
      final data = fit.toJson();
      fit.applyBackup(data, restoredFoods: {'viejo.png': 'nuevo.png'});
      expect(fit.foods.single.photo, 'nuevo.png');
    });

    test('borrar todos los datos vacía la nutrición', () {
      fit.logQuick('x', const Macros(kcal: 100));
      fit.addWater();
      fit.resetAllData();
      expect(fit.foodLog, isEmpty);
      expect(fit.waterLog, isEmpty);
      expect(fit.nutritionGoalsSet, isFalse);
    });
  });

  group('base de alimentos', () {
    test('se carga entera y busca sin tildes en el idioma de la app', () {
      expect(FoodLibrary.foods.length, greaterThan(500));
      final hits = FoodLibrary.search('platano', 'es');
      expect(hits.first.nameFor('es'), startsWith('Plátano'));
      expect(FoodLibrary.search('chicken breast', 'es'), isNotEmpty);
      expect(FoodLibrary.search('   ', 'es'), isEmpty);
    });

    test('los 17 idiomas tienen nombre propio y se buscan sin diacríticos', () {
      for (final l in appLanguages) {
        final missing = FoodLibrary.foods.where((f) => (f.names[l] ?? '').isEmpty).length;
        expect(missing, 0, reason: l);
      }
      expect(FoodLibrary.search('losos', 'pl').first.names['en'], 'Salmon');
      expect(FoodLibrary.search('sut', 'tr').first.names['en'], contains('Milk'));
      expect(FoodLibrary.search('鮭魚', 'zh_Hant').first.names['en'], 'Salmon');
      expect(FoodLibrary.search('سيب', 'fa').first.names['en'], 'Apple');
      expect(FoodLibrary.search('banana', 'ja'), isNotEmpty);
    });

    test('apuntar en gramos guarda los gramos y escala por 100 g', () {
      final rice = FoodLibrary.search('arroz blanco', 'es').first.item('es');
      expect(rice.grams, 100);
      final e = fit.logFood(rice, servings: 1.5);
      expect(e.totalGrams, 150);
      expect(fit.totalOn(DateTime.now()).kcal, closeTo(rice.macros.kcal * 1.5, 0.01));
      expect(fit.foodById(rice.id)?.macros.kcal, rice.macros.kcal);
      expect(e.name, 'Arroz blanco');
    });

    test('cocido convierte el peso al crudo con el rendimiento del alimento', () {
      final rice = lib('Arroz blanco');
      expect(rice.canCook, isTrue);
      final e = fit.logFood(rice, servings: 250 / rice.cookedYield / 100, cooked: true);
      expect(e.cooked, rice.cookedYield);
      expect(e.shownGrams, closeTo(250, 0.01));
      expect(fit.totalOn(DateTime.now()).kcal, closeTo(rice.macros.kcal, 0.5));
      expect(lib('Pechuga de pollo').cookedYield, 0.75);
      expect(lib('Jamón serrano').canCook, isFalse);
    });

    test('las fotos de la base son assets y no se borran ni se exportan', () {
      final egg = lib('Huevo');
      expect(egg.photo, 'asset:assets/food/egg.webp');
      expect(File(assetOfPhoto(egg.photo)).existsSync(), isTrue);
      final mine = fit.saveFood(name: 'Mi huevo', photo: egg.photo, grams: 100, macros: egg.macros);
      final data = fit.toJson();
      fit.applyBackup(data, restoredFoods: {});
      expect(fit.foods.single.photo, mine.photo);
    });

    test('los líquidos van en ml y traen ración de vaso', () {
      final milk = FoodLibrary.foods.firstWhere((f) => f.names['es'] == 'Leche entera');
      expect(milk.liquid, isTrue);
      expect(milk.portion, PortionKind.glass);
      expect(milk.portionGrams, 250);
    });
  });

  group('platos hechos', () {
    setUp(() => setAppLanguage('es'));
    tearDown(() => setAppLanguage('en'));

    test('todos los platos traen todos sus ingredientes de la base', () {
      expect(FoodLibrary.dishes.length, greaterThan(20));
      for (final d in FoodLibrary.dishes) {
        expect(fit.dishRecipe(d).items.length, d.items.length, reason: d.id);
        expect(d.nameFor('es'), isNotEmpty);
      }
    });

    test('el arroz del plato va en peso cocido y se apunta en crudo', () {
      final r = fit.dishRecipe(FoodLibrary.dishes.firstWhere((d) => d.id == 'chicken-rice'));
      final rice = r.items.firstWhere((e) => e.foodId == 'a:rice');
      expect(rice.shownGrams, closeTo(250, 0.01));
      expect(rice.totalGrams, closeTo(250 / lib('Arroz blanco').cookedYield, 0.01));
      expect(r.total.kcal, greaterThan(400));
    });

    test('se buscan sin tildes y no se guardan solos', () {
      expect(fit.searchDishes('bolonesa').single.name, 'Espaguetis a la boloñesa');
      final r = fit.searchDishes('cafe con leche').single;
      expect(fit.isOwnRecipe(r.id), isFalse);
      fit.logRecipe(r, meal: Meal.breakfast);
      expect(fit.recipes, isEmpty);
      expect(fit.entriesOn(DateTime.now()).length, 2);
    });

    test('editar una comida propia cambia sus ingredientes y no se queda vacía', () {
      final dish = fit.searchDishes('arroz con pollo').single;
      final r = fit.saveRecipe('Mi arroz', dish.items)!;
      expect(fit.isOwnRecipe(r.id), isTrue);
      fit.updateRecipe(r.id, [r.items.first.copyWith(servings: r.items.first.servings * 2)]);
      expect(fit.recipes.single.items.length, 1);
      expect(fit.recipes.single.name, 'Mi arroz');
      fit.updateRecipe(r.id, const []);
      expect(fit.recipes.single.items.length, 1);
    });
  });

  group('comidas guardadas y repetir', () {
    test('una comida guardada se apunta entera y se puede escalar', () {
      fit.logQuick('Avena', const Macros(kcal: 300, protein: 10), meal: Meal.breakfast);
      fit.logQuick('Whey', const Macros(kcal: 120, protein: 24), meal: Meal.breakfast);
      final r = fit.saveRecipe('Desayuno', fit.entriesOn(DateTime.now()))!;
      expect(fit.saveRecipe('  ', fit.foodLog), isNull);
      fit.setNutritionDay(shiftDays(DateTime.now(), -1));
      final added = fit.logRecipe(r, meal: Meal.lunch, factor: 2);
      expect(added.length, 2);
      expect(fit.totalOn(fit.nutritionDay).kcal, 840);
      expect(added.every((e) => e.meal == Meal.lunch), isTrue);
      expect(r.items.first.id, isNot(added.first.id));
    });

    test('repetir una comida de otro día la copia al día abierto', () {
      fit.setNutritionDay(shiftDays(DateTime.now(), -2));
      fit.logQuick('Pollo', const Macros(kcal: 500), meal: Meal.dinner);
      fit.logQuick('Fruta', const Macros(kcal: 80), meal: Meal.snacks);
      fit.setNutritionDay(DateTime.now());
      final from = fit.daysWithMeal(Meal.dinner);
      expect(from.length, 1);
      fit.copyMeal(from.single, Meal.dinner);
      expect(fit.totalOn(DateTime.now()).kcal, 500);
      expect(fit.daysWithMeal(Meal.dinner).length, 1);
    });

    test('repetir el día entero copia cada comida en la suya', () {
      fit.setNutritionDay(shiftDays(DateTime.now(), -1));
      fit.logQuick('Avena', const Macros(kcal: 300), meal: Meal.breakfast);
      fit.logQuick('Pasta', const Macros(kcal: 700), meal: Meal.lunch);
      fit.setNutritionDay(DateTime.now());
      final from = fit.daysWithMeal(null);
      expect(from.length, 1);
      final added = fit.copyDay(from.single);
      expect(added.length, 2);
      final today = fit.entriesOn(DateTime.now());
      expect(today.firstWhere((e) => e.name == 'Avena').meal, Meal.breakfast);
      expect(today.firstWhere((e) => e.name == 'Pasta').meal, Meal.lunch);
      expect(fit.totalOn(shiftDays(DateTime.now(), -1)).kcal, 1000);
    });

    test('vaciar una comida se deshace y mover la pasa entera a otra', () {
      fit.logQuick('Huevos', const Macros(kcal: 200), meal: Meal.breakfast);
      fit.logQuick('Café', const Macros(kcal: 40), meal: Meal.breakfast);
      fit.logQuick('Pasta', const Macros(kcal: 700), meal: Meal.lunch);
      final gone = fit.clearMeal(Meal.breakfast);
      expect(gone.length, 2);
      expect(fit.totalOn(DateTime.now()).kcal, 700);
      fit.restoreEntries(gone);
      expect(fit.totalOn(DateTime.now()).kcal, 940);
      final moved = fit.moveMeal(Meal.breakfast, Meal.lunch);
      expect(moved.length, 2);
      var today = fit.entriesOn(DateTime.now());
      expect(today.where((e) => e.meal == Meal.lunch).length, 3);
      expect(today.where((e) => e.meal == Meal.breakfast), isEmpty);
      fit.moveEntries(moved, Meal.breakfast);
      today = fit.entriesOn(DateTime.now());
      expect(today.where((e) => e.meal == Meal.lunch).single.name, 'Pasta');
      expect(fit.moveMeal(Meal.lunch, Meal.lunch), isEmpty);
    });

    test('mover una entrada a otro día conserva la hora y se puede deshacer', () {
      final e = fit.logQuick('Cena', const Macros(kcal: 600), meal: Meal.dinner)!;
      final ayer = shiftDays(DateTime.now(), -1);
      fit.moveEntryToDay(e.id, ayer);
      expect(fit.totalOn(DateTime.now()).kcal, 0);
      expect(fit.totalOn(ayer).kcal, 600);
      expect(fit.entriesOn(ayer).single.at.hour, e.at.hour);
      fit.moveEntryToDay(e.id, DateTime.now());
      expect(fit.totalOn(DateTime.now()).kcal, 600);
    });

    test('los favoritos se guardan, van primero los últimos y se van al borrar el alimento', () {
      final mine = fit.saveFood(name: 'Whey', serving: '30 g', macros: whey);
      final egg = lib('Huevo');
      fit.toggleFavoriteFood(egg.id);
      fit.toggleFavoriteFood(mine.id);
      expect([for (final f in fit.favoriteFoodItems) f.id], [mine.id, egg.id]);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.isFavoriteFood(egg.id), isTrue);
      fit.deleteFood(mine.id);
      expect([for (final f in fit.favoriteFoodItems) f.id], [egg.id]);
      fit.toggleFavoriteFood(egg.id);
      expect(fit.favoriteFoodItems, isEmpty);
    });

    test('las comidas guardadas sobreviven a cerrar la app', () {
      fit.logQuick('Tostada', const Macros(kcal: 200, fiber: 4));
      fit.saveRecipe('Merienda', fit.foodLog);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.recipes.single.name, 'Merienda');
      expect(fit.recipes.single.total.fiber, 4);
    });
  });

  group('objetivos y quemado', () {
    test('lo quemado solo se suma si lo activas y sin contar el reposo', () {
      fit.profile.weightKg = 80;
      fit.setNutritionGoals(const NutritionGoals(kcal: 2000));
      fit.sessions.add(LoggedSession(DateTime.now(), 3600, const []));
      expect(fit.burnedOn(DateTime.now()), 320);
      expect(fit.kcalBudgetOn(DateTime.now()), 2000);
      fit.setAddBurned(true);
      expect(fit.kcalBudgetOn(DateTime.now()), 2320);
    });

    test('las calorías sugeridas siguen al objetivo de peso', () {
      fit.profile.weightKg = 80;
      final base = fit.suggestedGoals.kcal;
      fit.setWeightGoal(74);
      expect(fit.suggestedGoals.kcal, base - 500);
      expect(fit.suggestedGoals.protein, 160);
      fit.setWeightGoal(86);
      expect(fit.suggestedGoals.kcal, base + 300);
      fit.setWeightGoal(80.3);
      expect(fit.suggestedGoals.kcal, base);
    });

    test('en descanso mandan los objetivos de descanso', () {
      fit.setNutritionGoals(const NutritionGoals(kcal: 2600, protein: 160));
      fit.splitRestGoals(true);
      final past = shiftDays(DateTime.now(), -3);
      expect(fit.goalsFor(past).kcal, 2210);
      expect(fit.goalsFor(past).protein, 160);
      fit.sessions.add(LoggedSession(past, 1800, const []));
      expect(fit.goalsFor(past).kcal, 2600);
      fit.splitRestGoals(false);
      expect(fit.restGoals, isNull);
    });

    test('kJ solo cambia cómo se muestra, no lo guardado', () {
      fit.setUseKj(true);
      expect(fit.energyOf(100), 418);
      expect(fit.kcalFromShown(418.4), closeTo(100, 0.01));
      expect(fit.energyUnit, 'kJ');
    });

    test('la media de la semana cuenta solo los días apuntados', () {
      fit.setNutritionGoals(const NutritionGoals(kcal: 2000, protein: 150));
      fit.setAddBurned(false);
      fit.logQuick('a', const Macros(kcal: 2000, protein: 150));
      final w = fit.weekNutrition()!;
      expect(w.days, 1);
      expect(w.kcal, 2000);
      expect(w.kcalMet, 1);
      expect(w.proteinMet, 1);
    });

    test('el peso objetivo se guarda en kg', () {
      fit.setWeightGoal(78.5);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.weightGoalKg, 78.5);
      fit.setWeightGoal(0);
      expect(fit.weightGoalKg, 0);
    });
  });

  group('ideas de Francis', () {
    test('la proteína animal y los tipos de grasa salen de la base', () {
      fit.logFood(lib('Pechuga de pollo'), servings: 2);
      fit.logFood(lib('Lentejas'), servings: 2);
      final m = fit.totalOn(DateTime.now());
      expect(m.animal, closeTo(lib('Pechuga de pollo').macros.protein * 2, 0.5));
      expect(m.plant, closeTo(lib('Lentejas').macros.protein * 2, 0.5));
      expect(m.sat + m.mono + m.poly, greaterThan(0));
    });

    test('el arroz solo es incompleto y con legumbres mejora', () {
      final rice = lib('Arroz blanco');
      fit.logFood(rice, servings: 3);
      final alone = fit.totalOn(DateTime.now());
      expect(alone.limitingAmino, Amino.lys);
      fit.logFood(lib('Lentejas'), servings: 2);
      final mixed = fit.totalOn(DateTime.now());
      expect(mixed.proteinQuality, greaterThan(alone.proteinQuality));
    });

    test('el huevo es proteína completa', () {
      fit.logFood(lib('Huevo'), servings: 1);
      expect(fit.totalOn(DateTime.now()).proteinQuality, 1);
      expect(fit.totalOn(DateTime.now()).limitingAmino, isNull);
    });

    test('un lote se apunta una vez y se come a trozos de lo que queda', () {
      final rice = fit.entryFor(lib('Arroz blanco'), servings: 10);
      final chicken = fit.entryFor(lib('Pechuga de pollo'), servings: 6);
      final b = fit.saveBatch(name: 'Pollo con arroz', items: [rice, chicken], cookedGrams: 2000)!;
      expect(fit.foodLog, isEmpty);
      expect(b.leftGrams, 2000);
      final e = fit.logFromBatch(b, b.leftGrams * 0.25)!;
      expect(e.totalGrams, 500);
      expect(fit.batchById(b.id)!.leftGrams, 1500);
      expect(fit.totalOn(DateTime.now()).kcal, closeTo(b.total.kcal / 4, 0.5));
      fit.updateEntry(e.id, servings: 4);
      expect(fit.batchById(b.id)!.leftGrams, 1600);
      fit.removeEntry(e.id);
      expect(fit.batchById(b.id)!.leftGrams, 2000);
      fit.logFromBatch(b, 5000);
      expect(fit.batchById(b.id)!.finished, isTrue);
      expect(fit.activeBatches, isEmpty);
    });

    test('sin peso cocinado ni gramos no se crea el lote', () {
      final quick = FoodEntry(
        id: 'x',
        at: DateTime.now(),
        meal: Meal.lunch,
        name: 'a',
        per: const Macros(kcal: 100),
      );
      expect(fit.saveBatch(name: 'Nada', items: [quick]), isNull);
      expect(fit.saveBatch(name: 'Con peso', items: [quick], cookedGrams: 300), isNotNull);
    });

    test('comidas libres: crear, renombrar, mover y quitar sin perder lo apuntado', () {
      final pre = fit.addMealSlot('Preentreno')!;
      fit.logQuick('Plátano', const Macros(kcal: 100), meal: pre.meal);
      fit.renameMealSlot(pre.meal, 'Pre');
      fit.moveMealSlot(pre.meal, -1);
      expect(fit.mealSlots[fit.mealSlots.length - 2].meal, pre.meal);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.slotOf(pre.meal)?.name, 'Pre');
      expect(fit.removeMealSlot(pre.meal), isTrue);
      expect(fit.entriesOn(DateTime.now()).single.meal, isNot(pre.meal));
      expect(fit.totalOn(DateTime.now()).kcal, 100);
    });

    test('la comida por hora sale de las franjas', () {
      expect(mealForHour(8), Meal.breakfast);
      expect(mealForHour(13), Meal.lunch);
      expect(mealForHour(17), Meal.snacks);
      expect(mealForHour(21), Meal.dinner);
    });

    test('el aviso de suplementos se guarda y se apaga', () {
      fit.addSupplement('Creatina');
      fit.setSupplementReminder(21 * 60 + 30);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.supplementReminderMin, 21 * 60 + 30);
      fit.setSupplementReminder(null);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.supplementReminderMin, isNull);
    });

    test('repetir una entrada la apunta otra vez en la misma comida', () {
      final e = fit.logQuick('Café', const Macros(kcal: 20), meal: Meal.breakfast)!;
      final copy = fit.repeatEntry(e)!;
      expect(copy.id, isNot(e.id));
      expect(copy.meal, Meal.breakfast);
      expect(fit.totalOn(DateTime.now()).kcal, 40);
    });

    test('editar los valores de una entrada solo cambia esa entrada', () {
      final food = fit.saveFood(name: 'Pan', grams: 100, macros: const Macros(kcal: 250, protein: 8));
      final a = fit.logFood(food);
      fit.logFood(food);
      fit.editEntryValues(a.id, name: 'Pan de casa', per: const Macros(kcal: 300, protein: 10));
      final list = fit.entriesOn(DateTime.now());
      expect(list.firstWhere((e) => e.id == a.id).name, 'Pan de casa');
      expect(fit.totalOn(DateTime.now()).kcal, 550);
      expect(fit.foods.single.macros.kcal, 250);
    });

    test('los rastreadores se apagan y se guardan', () {
      expect(fit.trackerOn(Tracker.water), isTrue);
      expect(fit.trackerOn(Tracker.quality), isFalse);
      fit.setTracker(Tracker.water, false);
      fit.setTracker(Tracker.quality, true);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.trackerOn(Tracker.water), isFalse);
      expect(fit.trackerOn(Tracker.quality), isTrue);
    });
  });

  group('recorte de pegatina', () {
    Uint8List scene({required bool busy}) {
      const w = 120, h = 120;
      final px = Uint8List(w * h * 4);
      for (var y = 0; y < h; y++) {
        for (var x = 0; x < w; x++) {
          final i = (y * w + x) * 4;
          final inside = x >= 40 && x < 80 && y >= 30 && y < 95;
          final shade = 220 - y ~/ 4;
          final noise = busy ? ((x * 37 + y * 91) % 200) : 0;
          px[i] = inside ? 30 : (busy ? noise : shade);
          px[i + 1] = inside ? 30 : (busy ? (noise * 3) % 255 : shade - 4);
          px[i + 2] = inside ? 200 : (busy ? (noise * 7) % 255 : shade - 10);
          px[i + 3] = 255;
        }
      }
      return px;
    }

    test('un objeto sobre fondo liso se separa del fondo', () {
      final mask = cutoutMask(120, 120, scene(busy: false))!;
      expect(mask[60 * 120 + 60], 1);
      expect(mask[5 * 120 + 5], 0);
      final area = mask.where((v) => v == 1).length;
      expect(area, closeTo(40 * 65, 400));
    });

    test('con el fondo revuelto no se inventa un recorte', () {
      expect(cutoutMask(120, 120, scene(busy: true)), isNull);
    });
  });

  group('planes de comida', () {
    test('un plan copia el día, se asigna a un día y apunta solo lo que falta', () {
      fit.logFood(lib('Huevo'), servings: 2, meal: Meal.breakfast);
      fit.logFood(lib('Arroz blanco'), meal: Meal.lunch);
      final plan = fit.createMealPlan(name: 'Pierna', fromDay: true);
      expect(plan.items.length, 2);
      expect(plan.itemsOf(Meal.breakfast).single.servings, 2);

      final other = shiftDays(fit.nutritionDay, -1);
      fit.setPlanDay(other.weekday, plan.id);
      expect(fit.planOn(other)?.id, plan.id);

      fit.setNutritionDay(other);
      fit.logFood(lib('Plátano'), meal: Meal.breakfast);
      expect(fit.logPlanDay(fit.planOn(other)!), 1);
      expect(fit.entriesOn(other).where((e) => e.meal == Meal.lunch).single.name, contains('Arroz'));
      expect(fit.entriesOn(other).where((e) => e.meal == Meal.breakfast).length, 1);
    });

    test('borrar un plan lo quita de la semana y todo sobrevive a reiniciar', () async {
      final a = fit.createMealPlan(name: 'A');
      final b = fit.createMealPlan(name: 'B');
      fit.addPlanItem(a.id, fit.entryFor(lib('Huevo'), meal: Meal.dinner));
      fit.setPlanDay(1, a.id);
      fit.setPlanDay(2, b.id);
      fit.deleteMealPlan(b.id);
      expect(fit.mealWeek, {1: a.id});

      fit.persistNow();
      fit.loadFromStore();
      expect(fit.mealPlans.single.itemsOf(Meal.dinner).single.name, contains('Huevo'));
      expect(fit.mealWeek, {1: fit.mealPlans.single.id});
    });

    test('quien ya tenía rastreadores guardados ve los planes al actualizar', () {
      fit.loadNutrition({
        'trackers': ['calories', 'water'],
      });
      expect(fit.trackerOn(Tracker.plans), isTrue);
      expect(fit.trackerOn(Tracker.protein), isFalse);
    });
  });

  group('suplementos con hora', () {
    test('cada suplemento guarda su foto, su dosis y su hora', () {
      final s = fit.addSupplement('Creatina', dose: '5 g', at: 9 * 60)!;
      fit.updateSupplement(s.id, photo: 'asset:assets/img/peek-protein.webp', at: 21 * 60);
      final saved = fit.supplements.single;
      expect(saved.dose, '5 g');
      expect(saved.photo, contains('peek-protein'));
      expect(fit.supplementTime(saved), 21 * 60);
      fit.updateSupplement(s.id, clearAt: true);
      expect(fit.supplementTime(fit.supplements.single), isNull);
    });

    test('sin hora propia hereda la hora general de antes', () {
      final s = fit.addSupplement('Vitamina D')!;
      fit.setSupplementReminder(8 * 60);
      expect(fit.supplementTime(fit.supplements.firstWhere((x) => x.id == s.id)), 8 * 60);
    });
  });

  group('compartir planes y beta', () {
    test('un plan exportado vuelve igual, con su comida propia y sus días', () {
      final pre = fit.addMealSlot('Preentreno')!;
      final plan = fit.createMealPlan(name: 'Volumen');
      fit.addPlanItem(plan.id, fit.entryFor(lib('Huevo'), servings: 2, meal: Meal.breakfast));
      fit.addPlanItem(plan.id, fit.entryFor(lib('Plátano'), meal: pre.meal));
      fit.setPlanDay(3, plan.id);
      final json = fit.exportMealPlansJson([plan]);

      fit.deleteMealPlan(plan.id);
      fit.removeMealSlot(pre.meal);
      expect(fit.isMealPlanText(json), isTrue);
      expect(fit.importMealPlans('mira mi plan: $json'), 1);

      final back = fit.mealPlans.single;
      expect(back.name, 'Volumen');
      expect(back.itemsOf(Meal.breakfast).single.servings, 2);
      final slot = fit.mealSlots.firstWhere((s) => s.name == 'Preentreno');
      expect(back.itemsOf(slot.meal).single.name, contains('Plátano'));
      expect(fit.mealWeek[3], back.id);
    });

    test('un texto cualquiera no importa nada', () {
      expect(fit.importMealPlans('hola'), 0);
      expect(fit.importMealPlans('{"name": "Push"}'), 0);
    });

    test('los planes se pueden ordenar', () {
      final a = fit.createMealPlan(name: 'A');
      final b = fit.createMealPlan(name: 'B');
      fit.moveMealPlan(b.id, -1);
      expect(fit.mealPlans.map((p) => p.id), [b.id, a.id]);
    });

    test('la nutrición viene encendida y se recuerda al apagarla', () {
      expect(fit.nutritionBeta, isTrue);
      fit.setNutritionBeta(false);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.nutritionBeta, isFalse);
      fit.setNutritionBeta(true);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.nutritionBeta, isTrue);
    });
  });

  group('tanda 9-oct', () {
    test('un suplemento puede tocar algunos días, cada X días y con fecha de fin', () {
      final monday = DateTime(2026, 10, 5);
      final someDays = Supplement(id: 'a', name: 'Omega', days: (1 << 1) | (1 << 3) | (1 << 5));
      expect(
        [for (var i = 0; i < 7; i++) someDays.dueOn(monday.add(Duration(days: i)))],
        [true, false, true, false, true, false, false],
      );
      final every3 = Supplement(id: 'b', name: 'Zinc', every: 3, from: monday);
      expect(
        [for (var i = 0; i < 7; i++) every3.dueOn(monday.add(Duration(days: i)))],
        [true, false, false, true, false, false, true],
      );
      final short = Supplement(id: 'c', name: 'Melatonina', from: monday, until: DateTime(2026, 10, 6));
      expect(short.dueOn(DateTime(2026, 10, 4)), isFalse);
      expect(short.dueOn(DateTime(2026, 10, 6, 23)), isTrue);
      expect(short.dueOn(DateTime(2026, 10, 7)), isFalse);
      final back = Supplement.fromJson(every3.toJson());
      expect(back.every, 3);
      expect(back.from, monday);
    });

    test('el calendario del suplemento se guarda y la tarjeta solo cuenta los de hoy', () {
      final today = fit.nutritionDay;
      final notToday = (today.weekday % 7) + 1;
      final s = fit.addSupplement('Creatina', days: 1 << notToday, until: shiftDays(today, 30))!;
      fit.addSupplement('Vitamina D');
      expect(fit.supplementsDueOn(today).map((x) => x.name), ['Vitamina D']);
      fit.persistNow();
      fit.loadFromStore();
      final again = fit.supplements.firstWhere((x) => x.id == s.id);
      expect(again.days, 1 << notToday);
      expect(again.until, shiftDays(today, 30));
      fit.updateSupplement(s.id, days: 0, clearUntil: true);
      expect(fit.supplements.firstWhere((x) => x.id == s.id).until, isNull);
      expect(fit.supplementsDueOn(today).length, 2);
    });

    test('cada X días sin fecha empieza a contar hoy', () {
      final s = fit.addSupplement('Hierro', every: 2)!;
      expect(s.from, fit.nutritionDay);
      expect(s.dueOn(fit.nutritionDay), isTrue);
      expect(s.dueOn(shiftDays(fit.nutritionDay, 1)), isFalse);
    });

    test('un plan nuevo no existe hasta guardarlo y se guarda con sus días', () {
      final draft = fit.draftMealPlan();
      expect(fit.mealPlans, isEmpty);
      final saved = fit.saveMealPlan(
        draft.copyWith(
          name: 'Lunes',
          items: [fit.entryFor(lib('Huevo'), servings: 2).copyWith(meal: Meal.breakfast)],
        ),
        {1, 3},
      );
      expect(fit.mealPlans.single.name, 'Lunes');
      expect(fit.planDays(saved.id), [1, 3]);
      fit.saveMealPlan(saved.copyWith(name: 'Lunes y viernes'), {1, 5});
      expect(fit.mealPlans.length, 1);
      expect(fit.planDays(saved.id), [1, 5]);
      expect(fit.mealPlans.single.name, 'Lunes y viernes');
    });

    test('el progreso del plan de hoy cuenta las comidas ya apuntadas', () {
      final plan = fit.saveMealPlan(
        fit.draftMealPlan().copyWith(
          items: [
            fit.entryFor(lib('Huevo')).copyWith(meal: Meal.breakfast),
            fit.entryFor(lib('Arroz blanco')).copyWith(meal: Meal.lunch),
          ],
        ),
        {fit.nutritionDay.weekday},
      );
      expect(fit.planProgress(plan, fit.nutritionDay), (done: 0, total: 2));
      fit.logFood(lib('Plátano'), meal: Meal.breakfast);
      expect(fit.planProgress(plan, fit.nutritionDay), (done: 1, total: 2));
      expect(fit.logPlanDay(plan), 1);
      expect(fit.planProgress(plan, fit.nutritionDay), (done: 2, total: 2));
    });

    Uint8List withLeg() {
      const w = 120, h = 120;
      final px = Uint8List(w * h * 4);
      for (var y = 0; y < h; y++) {
        for (var x = 0; x < w; x++) {
          final i = (y * w + x) * 4;
          final object = (x - 60) * (x - 60) + (y - 55) * (y - 55) < 18 * 18;
          final leg = x >= 0 && x < 40 && y >= 70;
          px[i] = object ? 240 : (leg ? 200 : 40);
          px[i + 1] = object ? 200 : (leg ? 150 : 40);
          px[i + 2] = object ? 20 : (leg ? 120 : 45);
          px[i + 3] = 255;
        }
      }
      return px;
    }

    test('el recorte se queda con lo del centro y no con lo que entra por el borde', () {
      final mask = cutoutMask(120, 120, withLeg(), force: true)!;
      expect(mask[55 * 120 + 60], 1);
      expect(mask[100 * 120 + 15], 0);
    });

    test('la varita coge la zona tocada entera', () async {
      final px = withLeg();
      final full = Uint8List(120 * 120)..fillRange(0, 120 * 120, 1);
      final draft = CutoutDraft(120, 120, px, full, auto: full, found: false);
      final region = await regionAt(draft, 15, 100);
      expect(region[110 * 120 + 30], 1);
      expect(region[55 * 120 + 60], 0);
      expect(region[10 * 120 + 100], 0);
    });
  });

  test('agua: se borra un trago suelto y los topes de azúcar y sodio se guardan', () {
    fit.addWater(250);
    fit.addWater(500);
    final sips = fit.waterSipsOn(DateTime.now());
    expect(sips.length, 2);
    fit.removeWaterSip(sips.first);
    expect(fit.waterOn(DateTime.now()), 500);
    fit.setNutritionGoals(fit.activeGoals.copyWith(sugar: 30, sodium: 1500, fiber: 35));
    fit.persistNow();
    fit.loadFromStore();
    expect(fit.activeGoals.sugar, 30);
    expect(fit.activeGoals.sodium, 1500);
    expect(fit.activeGoals.fiber, 35);
  });

  test('quitar una comida pasa también lo planeado a la anterior', () {
    final slot = fit.addMealSlot('Preentreno')!;
    final plan = fit.createMealPlan(name: 'Pierna');
    fit.addPlanItem(plan.id, fit.entryFor(lib('Plátano'), meal: slot.meal));
    fit.removeMealSlot(slot.meal);
    final items = fit.mealPlanById(plan.id)!.items;
    expect(items.single.meal, isNot(slot.meal));
    expect(fit.mealSlots.any((s) => s.meal == items.single.meal), isTrue);
  });
}
