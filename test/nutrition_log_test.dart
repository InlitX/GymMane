import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('widgets de nutrición', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('lo tocado en el widget se apunta con su hora, en su día, y lo muy viejo se ignora', () {
      final now = DateTime.now();
      final ms = now.subtract(const Duration(minutes: 5)).millisecondsSinceEpoch;
      final twoDays = now.subtract(const Duration(days: 2));
      final old = twoDays.millisecondsSinceEpoch;
      final stale = now.subtract(const Duration(days: 10)).millisecondsSinceEpoch;
      final food = fit.saveFood(name: 'Batido', macros: const Macros(kcal: 120, protein: 24));
      final before = fit.waterOn(now);
      final n = fit.takeWidgetLog('w,$ms,250;w,$old,250;w,$stale,250;s,$ms,${food.id};x,1,2;w,bad,3');
      expect(n, 3);
      expect(fit.waterOn(twoDays), 250);
      expect(fit.waterOn(now), before + 250);
      expect(fit.totalOn(now).protein.round(), 24);
      expect(fit.waterSipsOn(now).last.at.millisecondsSinceEpoch, ms);
    });
  });

  group('#226 batidos marcados', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    const whey = Macros(kcal: 120, protein: 24, carbs: 3, fat: 1.5);

    test('elegir un batido lo marca y solo los marcados salen en la lista', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.saveFood(name: 'Avena', macros: const Macros(kcal: 380));
      fit.setShakeFood(a.id);
      expect(fit.isShakeFood(a.id), isTrue);
      expect(fit.shakeFoodItems.map((f) => f.id), [a.id]);
    });

    test('quitar la marca del elegido pasa al siguiente marcado', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      final b = fit.saveFood(name: 'Vegano', macros: whey);
      fit.setShakeFood(a.id);
      fit.setShakeTag(b.id, true);
      fit.setShakeTag(a.id, false);
      expect(fit.shakeFoodId, b.id);
      fit.setShakeTag(b.id, false);
      expect(fit.shakeFoodId, '');
      expect(fit.shakeFood, isNull);
    });

    test('marcar el primero lo deja elegido para el vaso', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.setShakeTag(a.id, true);
      expect(fit.shakeFoodId, a.id);
    });

    test('borrar el alimento quita la marca', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.setShakeTag(a.id, true);
      fit.deleteFood(a.id);
      expect(fit.shakeFoods, isEmpty);
    });

    test('las marcas sobreviven a guardar y cargar', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      final b = fit.saveFood(name: 'Vegano', macros: whey);
      fit.setShakeFood(a.id);
      fit.setShakeTag(b.id, true);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.applyBackup(data);
      expect(fit.shakeFoods.toSet(), {a.id, b.id});
      expect(fit.shakeFoodId, a.id);
    });

    test('una copia antigua sin marcas conserva su batido elegido', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.setShakeFood(a.id);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      (data['nutrition'] as Map).remove('shakes');
      fit.applyBackup(data);
      expect(fit.shakeFoods, [a.id]);
      expect(fit.shakeFoodId, a.id);
    });
  });

  group('#247 completa tu día', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
    });

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

  group('comidas propias y días futuros', () {
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

    group('#269 categoría en comidas propias', () {
      test('se guarda, sobrevive a la copia y filtra la búsqueda', () {
        final mine = fit.saveFood(name: 'Pollo marca X', grams: 100, macros: const Macros(kcal: 110), cat: FoodCat.meat);
        fit.saveFood(name: 'Yogur', grams: 125, macros: const Macros(kcal: 80), cat: FoodCat.dairy);
        fit.saveFood(name: 'Sin nada', macros: const Macros(kcal: 50));
        expect(FoodItem.fromJson(mine.toJson()).cat, FoodCat.meat);
        expect(fit.searchFoods('', cat: FoodCat.meat).map((f) => f.name), ['Pollo marca X']);
        expect(fit.searchFoods(''), hasLength(3));
      });

      test('editar puede cambiar o quitar la categoría', () {
        final f = fit.saveFood(name: 'Pan', cat: FoodCat.bakery);
        expect(fit.saveFood(id: f.id, name: 'Pan', cat: FoodCat.grain).cat, FoodCat.grain);
        expect(fit.saveFood(id: f.id, name: 'Pan').cat, isNull);
      });
    });

    group('#273 comidas al futuro', () {
      test('se puede mover una comida a mañana y ver ese día', () {
        final food = fit.saveFood(name: 'Cena', macros: const Macros(kcal: 600));
        final e = fit.logFood(food);
        final now = DateTime.now();
        final tomorrow = DateTime(now.year, now.month, now.day + 1);
        fit.moveEntryToDay(e.id, tomorrow);
        expect(fit.entriesOn(tomorrow).map((x) => x.id), [e.id]);
        fit.setNutritionDay(tomorrow);
        expect(fit.nutritionDay, tomorrow);
        fit.setNutritionDay(DateTime(now.year, now.month, now.day + 30));
        expect(fit.nutritionDay, DateTime(now.year, now.month, now.day + 7));
      });
    });
  });
}
