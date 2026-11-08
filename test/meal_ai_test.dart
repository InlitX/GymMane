import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/services/food_library.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/meal_ai.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    FoodLibrary.parse(File('assets/data/foods.tsv').readAsStringSync());
  });

  List<AiDraftOption> resolve(String raw, {bool day = false, Meal meal = Meal.snacks, List<FoodItem> own = const []}) =>
      resolveMealAi(parseMealAi(raw), lang: 'en', meal: meal, slots: kDefaultMeals, day: day, own: own);

  const brief = MealAiBrief(
    language: 'English',
    day: false,
    mealId: 'snacks',
    mealLabel: 'Snack',
    slots: [('breakfast', 'Breakfast'), ('lunch', 'Lunch'), ('dinner', 'Dinner'), ('snacks', 'Snack')],
    kcal: 300,
    protein: 25,
    carbs: 30,
    fat: 10,
    options: 3,
    tags: ['High protein', 'Quick'],
    notes: 'I have oats and eggs. No peanuts.',
    eaten: ['Oats', 'Milk'],
  );

  group('prompt', () {
    test('lleva el objetivo, las comidas, los gustos y las reglas', () {
      final p = buildMealAiPrompt(brief);
      expect(p, contains('about 300 kcal, 25 g protein, 30 g carbs and 10 g fat'));
      expect(p, contains('ONE meal only: Snack (id "snacks")'));
      expect(p, contains('"breakfast", "lunch", "dinner", "snacks"'));
      expect(p, contains('High protein, Quick'));
      expect(p, contains('I have oats and eggs. No peanuts.'));
      expect(p, contains('Already eaten today'));
      expect(p, contains('3 different options'));
      expect(p, contains('English'));
      expect(p, contains(kMealAiTag));
    });

    test('el ejemplo del prompt se lee solo con el mismo lector de la app', () {
      for (final day in [false, true]) {
        final p = buildMealAiPrompt(MealAiBrief(
          language: 'Español',
          day: day,
          mealId: brief.mealId,
          mealLabel: brief.mealLabel,
          slots: brief.slots,
          kcal: 2000,
          protein: 150,
          carbs: 200,
          fat: 60,
          options: 1,
        ));
        final reply = parseMealAi(p);
        expect(reply.itemCount, 2, reason: 'day=$day');
        expect(reply.options.first.items.first.name, 'Greek yogurt');
        expect(reply.options.first.items.first.grams, 170);
        expect(reply.options.first.items.first.kcal, 100);
      }
    });

    test('una sola opción no pide varias y el día lo reparte', () {
      final one = buildMealAiPrompt(MealAiBrief(
        language: 'English',
        day: true,
        mealId: 'snacks',
        mealLabel: 'Snack',
        slots: brief.slots,
        kcal: 2200,
        protein: 140,
        carbs: 250,
        fat: 70,
        options: 1,
      ));
      expect(one, contains('a full day of eating'));
      expect(one, contains('Give 1 different option.'));
      expect(one, contains('Spread the foods across the meals'));
    });
  });

  group('lector', () {
    test('respuesta limpia con texto alrededor', () {
      final r = parseMealAi('Claro, aquí tienes:\n```json\n'
          '{"gymmane":"gymmane-meal","v":1,"options":[{"name":"Bowl","items":['
          '{"food":"Greek yogurt","grams":170,"kcal":100,"protein":17,"carbs":6,"fat":0.7,"meal":"snacks"}]}]}\n'
          '```\nEspero que te guste.');
      expect(r.options.length, 1);
      expect(r.options.first.name, 'Bowl');
      expect(r.options.first.items.single.protein, 17);
    });

    test('comillas tipográficas, comas finales y comentarios', () {
      final r = parseMealAi('{“options”: [ {“name”: “Plato”, “items”: [\n'
          '  {“food”: “Banana”, “grams”: 120, “kcal”: 107, “protein”: 1.3, “carbs”: 27, “fat”: 0.4,}, // fruta\n'
          '  /* otro */ {“food”: “Walnuts”, “grams”: 15, “kcal”: 98, “protein”: 2.3, “carbs”: 2.1, “fat”: 9.8},\n'
          ' ],},]}');
      expect(r.itemCount, 2);
      expect(r.options.first.items.last.name, 'Walnuts');
    });

    test('comillas simples, claves sin comillas y True/None', () {
      final r = parseMealAi("{options: [{name: 'Chef\\'s mix', items: [{food: 'Egg', grams: 60, kcal: 86, protein: 7.6, carbs: 0.4, fat: 5.7, liquid: False, note: None}]}]}");
      expect(r.itemCount, 1);
      expect(r.options.first.items.single.name, 'Egg');
    });

    test('cantidades con unidades y decimales con coma', () {
      final r = parseMealAi('{"items":['
          '{"food":"Milk","amount":"250 ml","kcal":"120 kcal","protein":"8,5 g","carbs":"12","fat":"4,8"},'
          '{"food":"Oats","quantity":"1/2 cup (45 g)","calories":170,"protein":6,"carbs":30,"fat":3},'
          '{"food":"Butter","grams":"1,5","kcal":11,"protein":0,"carbs":0,"fat":1.2},'
          '{"food":"Flour","weight":"2 oz","kcal":200,"protein":6,"carbs":42,"fat":1}]}');
      final items = r.options.first.items;
      expect(items[0].grams, 250);
      expect(items[0].liquid, isTrue);
      expect(items[0].protein, 8.5);
      expect(items[0].kcal, 120);
      expect(items[1].grams, 45);
      expect(items[2].grams, 1.5);
      expect(items[3].grams, closeTo(56.7, 0.01));
    });

    test('otros nombres de campos y macros anidados', () {
      final r = parseMealAi('{"menu":[{"title":"Cena","ingredients":['
          '{"name":"Salmon","grams":150,"nutrition":{"calories":280,"proteins":30,"carbohydrates":0,"fats":17}},'
          '{"alimento":"Arroz","gramos":"120 g","macros":{"kcal":156,"proteina":3,"hidratos":34,"grasa":0.4}}]}]}');
      expect(r.options.first.name, 'Cena');
      final items = r.options.first.items;
      expect(items[0].kcal, 280);
      expect(items[0].protein, 30);
      expect(items[0].fat, 17);
      expect(items[1].name, 'Arroz');
      expect(items[1].grams, 120);
      expect(items[1].carbs, 34);
    });

    test('lista suelta de alimentos y valores por 100 g', () {
      final list = parseMealAi('[{"food":"Banana","grams":100,"kcal":89,"protein":1,"carbs":23,"fat":0.3}]');
      expect(list.itemCount, 1);
      final per = parseMealAi('{"items":[{"food":"Rice","grams":200,"per100":{"kcal":130,"protein":2.7,"carbs":28,"fat":0.3}}]}');
      final f = per.options.first.items.single;
      expect(f.per100, isTrue);
      expect(f.kcal, 130);
    });

    test('un día entero por comidas', () {
      final r = parseMealAi('{"day":{"breakfast":[{"food":"Oats","grams":60,"kcal":227,"protein":8,"carbs":40,"fat":4}],'
          '"dinner":{"items":[{"food":"Salmon","grams":150,"kcal":280,"protein":30,"carbs":0,"fat":17}]}}}');
      expect(r.options.length, 1);
      final items = r.options.first.items;
      expect(items.map((e) => e.meal), ['breakfast', 'dinner']);
    });

    test('respuesta cortada: se queda con lo completo', () {
      final r = parseMealAi('{"options":[{"name":"A","items":['
          '{"food":"Banana","grams":120,"kcal":107,"protein":1.3,"carbs":27,"fat":0.4,"meal":"snacks"},'
          '{"food":"Almonds","grams":20,"kcal":116,"protein":4,"carbs":4');
      expect(r.truncated, isTrue);
      expect(r.itemCount, 2);
    });

    test('varios bloques: se queda con el más grande', () {
      final r = parseMealAi('Ejemplo: {"food":"x","grams":1,"kcal":1}\n'
          'Respuesta: {"options":[{"items":[{"food":"Banana","grams":120,"kcal":107},{"food":"Egg","grams":60,"kcal":86}]}]}');
      expect(r.itemCount, 2);
    });

    test('si el JSON exterior está roto rescata los alimentos sueltos', () {
      final r = parseMealAi('options = ( {"food":"Banana","grams":120,"kcal":107,"protein":1,"carbs":27,"fat":0.4} ;; '
          '{"food":"Egg","grams":60,"kcal":86,"protein":7.6,"carbs":0.4,"fat":5.7} )');
      expect(r.itemCount, 2);
    });

    test('texto que no es una comida no da nada', () {
      for (final raw in ['', 'hola', '{}', '[]', '{"options": []}', '{"a": 1, "b": [1, 2]}', '```json\n```', '{{{{', '}}}}']) {
        expect(parseMealAi(raw).isEmpty, isTrue, reason: raw);
      }
    });

    test('no se cuelga con basura enorme ni con anidación absurda', () {
      expect(parseMealAi('[' * 5000).isEmpty, isTrue);
      expect(parseMealAi('{"a":' * 3000).isEmpty, isTrue);
      expect(parseMealAi('{' * 10000 + '}' * 10000).isEmpty, isTrue);
    });

    test('limita opciones y alimentos', () {
      final items = [for (var i = 0; i < 80; i++) '{"food":"Item $i","grams":10,"kcal":10,"protein":1,"carbs":1,"fat":0}'].join(',');
      final options = [for (var i = 0; i < 12; i++) '{"name":"O$i","items":[$items]}'].join(',');
      final r = parseMealAi('{"options":[$options]}');
      expect(r.options.length, kMealAiMaxOptions);
      expect(r.options.first.items.length, kMealAiMaxItems);
    });
  });

  group('estado', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
    });

    test('el objetivo de una comida reparte lo que queda entre las comidas vacías', () {
      final all = fit.mealAiTargets(Meal.snacks, day: true);
      final goals = fit.goalsFor(fit.nutritionDay);
      expect(all.kcal, goals.kcal);
      final one = fit.mealAiTargets(Meal.snacks, day: false);
      expect(one.kcal, closeTo(goals.kcal / fit.mealSlots.length, 10));
      expect(one.leftKcal, goals.kcal);
      fit.logQuick('Algo', const Macros(kcal: 500, protein: 20), meal: Meal.breakfast);
      final after = fit.mealAiTargets(Meal.snacks, day: false);
      expect(after.leftKcal, goals.kcal - 500);
      expect(after.kcal, closeTo((goals.kcal - 500) / (fit.mealSlots.length - 1), 10));
    });

    test('lo importado se guarda en su comida con valores, gramos y foto de la biblioteca', () {
      final o = resolve('{"items":[{"food":"Greek yogurt","grams":170,"kcal":100,"protein":17,"carbs":6,"fat":0.7},'
              '{"food":"protein pudding","grams":200,"kcal":180,"protein":24,"carbs":14,"fat":3}]}',
              meal: Meal.dinner)
          .single;
      final added = fit.logEntries([for (final d in o.chosen) d.entry], Meal.dinner);
      expect(added.length, 2);
      final today = fit.entriesOn(fit.nutritionDay);
      expect(today.every((e) => e.meal == Meal.dinner), isTrue);
      expect(today.map((e) => e.name), containsAll(['Greek Yogurt', 'Protein pudding']));
      expect(fit.totalOn(fit.nutritionDay).kcal, closeTo(73 * 1.7 + 180, 1));
      expect(fit.photoForEntry(today.firstWhere((e) => e.foodId == 'a:greek-yogurt')), isNotEmpty);
    });

    test('guardado como receta y como plan', () {
      final o = resolve('{"items":[{"food":"Banana","grams":100,"kcal":89,"protein":1,"carbs":23,"fat":0.3},'
              '{"food":"Egg","grams":60,"kcal":86,"protein":7.6,"carbs":0.4,"fat":5.7}]}')
          .single;
      final r = fit.saveRecipe('Mi picoteo', [for (final d in o.chosen) d.entry]);
      expect(r, isNotNull);
      expect(r!.items.length, 2);
      final plan = fit.saveMealPlan(
        MealPlan(id: '', name: 'IA', items: [for (final d in o.chosen) d.entry.copyWith(id: fit.newPlanItemId())]),
        const {},
      );
      expect(fit.mealPlanById(plan.id)!.items.length, 2);
    });
  });

  group('resolución', () {
    test('un alimento de la biblioteca usa sus valores y su foto', () {
      final o = resolve('{"items":[{"food":"Greek yogurt","grams":170,"kcal":100,"protein":17,"carbs":6,"fat":0.7}]}').single;
      final d = o.items.single;
      expect(d.source, AiSource.library);
      expect(d.entry.foodId, 'a:greek-yogurt');
      expect(d.entry.meal, Meal.snacks);
      expect(d.total.kcal, closeTo(73 * 1.7, 0.5));
      expect(d.flags, isEmpty);
      expect(d.on, isTrue);
    });

    test('nombres en español, plurales y descripciones se encuentran', () {
      final r = resolveMealAi(
        parseMealAi('{"items":[{"food":"Huevos","grams":120,"kcal":172,"protein":15,"carbs":1,"fat":11},'
            '{"food":"Walnuts (shelled)","grams":20,"kcal":131,"protein":3,"carbs":3,"fat":13},'
            '{"food":"Rolled oats, dry","grams":50,"kcal":190,"protein":7,"carbs":34,"fat":3}]}'),
        lang: 'es',
        meal: Meal.breakfast,
        slots: kDefaultMeals,
      ).single;
      expect(r.items.map((e) => e.entry.foodId), ['a:egg', 'a:walnuts', 'a:rolled-oats']);
      expect(r.items.every((e) => e.source == AiSource.library), isTrue);
    });

    test('si los números de la IA no cuadran con la biblioteca se queda con los de la IA', () {
      final d = resolve('{"items":[{"food":"Banana","grams":100,"kcal":400,"protein":2,"carbs":90,"fat":1}]}').single.items.single;
      expect(d.source, AiSource.ai);
      expect(d.entry.foodId, isEmpty);
      expect(d.total.kcal, 400);
    });

    test('un alimento que no existe entra con los valores de la IA', () {
      final d = resolve('{"items":[{"food":"protein pudding","grams":200,"kcal":180,"protein":24,"carbs":14,"fat":3}]}')
          .single
          .items
          .single;
      expect(d.source, AiSource.ai);
      expect(d.entry.name, 'Protein pudding');
      expect(d.entry.totalGrams, 200);
      expect(d.total.protein, 24);
      expect(d.on, isTrue);
    });

    test('calorías que no cuadran con los macros se corrigen y se avisa', () {
      final d = resolve('{"items":[{"food":"mystery bar","grams":50,"kcal":900,"protein":10,"carbs":20,"fat":8}]}').single.items.single;
      expect(d.flags, contains(AiFlag.adjusted));
      expect(d.total.kcal, 10 * 4 + 20 * 4 + 8 * 9);
    });

    test('si faltan las calorías se calculan con los macros', () {
      final d = resolve('{"items":[{"food":"mystery bar","grams":50,"protein":10,"carbs":20,"fat":8}]}').single.items.single;
      expect(d.total.kcal, 192);
      expect(d.flags, isNot(contains(AiFlag.noValues)));
    });

    test('lo imposible o sin valores queda apagado por defecto', () {
      final o = resolve('{"items":['
          '{"food":"magic powder","grams":10,"kcal":900,"protein":50,"carbs":50,"fat":50},'
          '{"food":"mystery thing","grams":100},'
          '{"food":"lead brick","grams":100,"kcal":4000,"protein":0,"carbs":0,"fat":300}]}').single;
      expect(o.items[0].risky, isTrue);
      expect(o.items[0].on, isFalse);
      expect(o.items[1].usable, isFalse);
      expect(o.items[1].on, isFalse);
      expect(o.items[2].risky, isTrue);
      expect(o.chosen, isEmpty);
      expect(o.total.kcal, 0);
    });

    test('lo cocinado usa el peso cocinado de la biblioteca', () {
      final d = resolve('{"items":[{"food":"Chicken breast, grilled","grams":150,"kcal":200,"protein":38,"carbs":0,"fat":4}]}')
          .single
          .items
          .single;
      expect(d.source, AiSource.library);
      expect(d.entry.cooked, 0.75);
      expect(d.total.kcal, closeTo(120 * 150 / 0.75 / 100, 0.5));
      expect(d.shownGrams, closeTo(150, 0.01));
    });

    test('una comida: ignora la comida que ponga la IA y usa la pedida', () {
      final d = resolve('{"items":[{"food":"Banana","grams":100,"kcal":89,"protein":1,"carbs":23,"fat":0.3,"meal":"dinner"}]}',
              meal: Meal.snacks)
          .single
          .items
          .single;
      expect(d.entry.meal, Meal.snacks);
    });

    test('un día: reparte por comidas, con sinónimos y con una desconocida a la de por defecto', () {
      final o = resolve('{"day":{"desayuno":[{"food":"Banana","grams":100,"kcal":89,"protein":1,"carbs":23,"fat":0.3}],'
              '"Almuerzo":[{"food":"Egg","grams":60,"kcal":86,"protein":7.6,"carbs":0.4,"fat":5.7}],'
              '"cena":[{"food":"Almonds","grams":20,"kcal":116,"protein":4,"carbs":4,"fat":10}],'
              '"postre ligero":[{"food":"Banana","grams":50,"kcal":45,"protein":0.5,"carbs":11,"fat":0.2}],'
              '"zzz":[{"food":"Egg","grams":30,"kcal":43,"protein":3.8,"carbs":0.2,"fat":2.8}]}}',
          day: true,
          meal: Meal.lunch)
          .single;
      expect(o.items.map((e) => e.entry.meal.id), ['breakfast', 'lunch', 'dinner', 'snacks', 'lunch']);
    });

    test('un alimento propio gana a la biblioteca', () {
      const mine = FoodItem(
        id: 'f1',
        name: 'Greek yogurt',
        grams: 100,
        macros: Macros(kcal: 60, protein: 10, carbs: 4, fat: 0.2),
      );
      final d = resolve('{"items":[{"food":"greek yogurt","grams":200,"kcal":120,"protein":20,"carbs":8,"fat":0.4}]}', own: [mine])
          .single
          .items
          .single;
      expect(d.source, AiSource.mine);
      expect(d.entry.foodId, 'f1');
      expect(d.total.kcal, 120);
    });

    test('con piezas usa el peso de la pieza de la biblioteca', () {
      final d = resolve('{"items":[{"food":"Banana","count":2,"kcal":214,"protein":2.6,"carbs":54,"fat":0.7}]}').single.items.single;
      expect(d.source, AiSource.library);
      expect(d.entry.totalGrams, 240);
    });

    test('cambiar los gramos reescala sin romper nada', () {
      final lib = resolve('{"items":[{"food":"Greek yogurt","grams":100,"kcal":73,"protein":10,"carbs":4,"fat":2}]}').single.items.single;
      final before = lib.total.kcal;
      lib.scaleTo(200);
      expect(lib.total.kcal, closeTo(before * 2, 0.01));
      expect(lib.shownGrams, closeTo(200, 0.01));
      final ai = resolve('{"items":[{"food":"protein pudding","grams":200,"kcal":180,"protein":24,"carbs":14,"fat":3}]}').single.items.single;
      ai.scaleTo(100);
      expect(ai.total.kcal, closeTo(90, 0.01));
      expect(ai.total.protein, closeTo(12, 0.01));
      expect(ai.entry.totalGrams, closeTo(100, 0.01));
    });
  });

  group('etiqueta completa', () {
    test('lee fibra, azucar, sodio y tipos de grasa del alimento', () {
      final d = resolve('{"items":[{"food":"Beef stick and cheese protein snack","grams":40,"kcal":150,"protein":9,"carbs":3,"fat":11,"sodium":480,"saturated":5,"trans":0.2,"sugar":1,"fiber":0.5,"monounsaturated":4,"polyunsaturated":0.8}]}')
          .single
          .items
          .single;
      expect(d.source, AiSource.ai);
      expect(d.total.sodium, closeTo(480, 0.01));
      expect(d.total.sat, closeTo(5, 0.01));
      expect(d.total.trans, closeTo(0.2, 0.01));
      expect(d.total.sugar, closeTo(1, 0.01));
      expect(d.total.fiber, closeTo(0.5, 0.01));
      expect(d.total.mono, closeTo(4, 0.01));
      expect(d.total.poly, closeTo(0.8, 0.01));
    });

    test('sin los campos nuevos se importa igual y por 100 g se escalan', () {
      final plain = resolve('{"items":[{"food":"protein pudding","grams":200,"kcal":180,"protein":24,"carbs":14,"fat":3}]}').single.items.single;
      expect(plain.total.sodium, 0);
      expect(plain.total.sat, 0);
      final per = resolve('{"items":[{"food":"protein pudding","grams":200,"per100":{"kcal":90,"protein":12,"carbs":7,"fat":1.5,"sodium":100,"saturated":0.5}}]}')
          .single
          .items
          .single;
      expect(per.total.sodium, closeTo(200, 0.01));
      expect(per.total.sat, closeTo(1, 0.01));
    });

    test('el prompt pide los campos opcionales sin hacerlos obligatorios', () {
      final p = buildMealAiPrompt(brief);
      expect(p, contains('"sodium" in milligrams'));
      expect(p, contains('leave the key out otherwise'));
    });
  });
}
