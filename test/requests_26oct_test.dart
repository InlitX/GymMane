import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/nutrition.dart';
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

  group('#271 RPE en el historial', () {
    test('cada serie con esfuerzo lleva su etiqueta', () {
      fit.setEffortMode('rpe');
      final label = fit.setsSummary([LoggedSet(5, 100, rpe: 8), LoggedSet(5, 100)]);
      expect(label, '${fit.loggedSetLabel(LoggedSet(5, 100))} @8 · ${fit.loggedSetLabel(LoggedSet(5, 100))}');
    });
  });

  group('#266 superserie sin rutina', () {
    test('se encadena y se separa dentro de la sesión libre', () {
      fit.startWorkout();
      fit.toggleMuscle('chest');
      fit.trainContinue();
      fit.startSession();
      fit.addExerciseToSession(fit.matchExerciseByName('Barbell Squat')!.id);
      final s = fit.session!;
      expect(s.routineId, isNull);
      final last = s.exercises.length - 1;
      fit.toggleSessionLink(last - 1);
      expect(s.exercises[last - 1].linkedNext, isTrue);
      fit.toggleSessionLink(last);
      expect(s.exercises[last].linkedNext, isFalse);
      fit.toggleSessionLink(last - 1);
      expect(s.exercises[last - 1].linkedNext, isFalse);
    });
  });

  group('#272 pesos de cuarto de kilo', () {
    test('61,25 no se redondea y lo raro sigue a un decimal', () {
      expect(fit.weightValue(61.25), anyOf('61.25', '61,25'));
      expect(fit.weightValue(61.33), anyOf('61.3', '61,3'));
      expect(fit.weightValue(60), '60');
    });

    test('la regla baja a 0,25 con saltos de 1,25', () {
      fit.setWeightStep(1.25);
      expect(fit.rulerStep, 0.25);
      fit.setWeightStep(2.5);
      expect(fit.rulerStep, 0.5);
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
}
