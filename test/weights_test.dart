import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('salto de peso', () {
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

    test('los botones suman el salto elegido', () {
      final bench = idOf('Barbell Bench Press');
      fit.sessionPicks
        ..clear()
        ..add(bench);
      fit.startSession();
      fit.setSessionWeight(0, 0, 60);

      fit.setWeightStep(2);
      fit.bumpSessionWeight(0, 0, 1);
      expect(fit.session!.exercises[0].sets[0].weight, 62);
    });

    test('kg y lb guardan su propio salto y uno raro no entra', () {
      fit.setWeightStep(1);
      fit.setWeightStep(3);
      expect(fit.weightStep, 1);

      fit.setUnits('lb');
      expect(fit.weightStep, 5);
      fit.setWeightStep(10);
      expect(fit.weightStep, 10);

      fit.setUnits('kg');
      expect(fit.weightStep, 1);
      expect(fit.toJson()['stepKg'], 1);
      expect(fit.toJson()['stepLb'], 10);
    });

    test('los calentamientos siguen redondeando a discos', () {
      fit.setWeightStep(1);
      expect(fit.plateStep, 2.5);
    });
  });

  group('#240 barra propia', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    test('sin elegir nada, la barra es la olímpica', () {
      expect(fit.plateBarDisplay, 20);
      expect(fit.defaultBar, 20);
    });

    test('una barra de otro peso calcula los discos sobre ella', () {
      fit.setPlateBar(12.5);
      fit.plateTarget = 52.5;
      expect(fit.plateBreakdown.map((p) => '${fmt(p.weight)}x${p.count}'), ['20x1']);
    });

    test('la barra elegida se recuerda al reabrir y vale para toda la app', () async {
      fit.setPlateBar(7);
      fit.persistNow();
      await pumpEventQueue();
      fit.loadFromStore();
      expect(fit.plateBarDisplay, 7);
      expect(fit.defaultBar, 7);
      expect(fit.barFor('x'), 7);
    });

    test('borrar los datos vuelve a la barra de 20', () {
      fit.setPlateBar(15);
      fit.resetAllData();
      expect(fit.plateBarDisplay, 20);
    });
  });

  group('#272 pesos de cuarto de kilo', () {
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

  group('carro de la prensa', () {
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

    test('#125 la prensa usa su propio carro en la calculadora', () {
      final press = idOf('Leg Press');
      expect(fit.plateHint('Machine', 150, id: press), isNull);
      fit.setExerciseBar(press, 50);
      expect(fit.plateHint('Machine', 150, id: press), '25×2');
      expect(fit.toJson()['barKg'], {press: 50.0});
    });
  });

  group('discos del sitio', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    test('la calculadora solo propone los discos que tienes', () {
      final id = fit.addPlace('Casa', equipment: {'Barbell'});
      fit.setActivePlace(id);
      fit.setPlatePairs(id, 20, 1);
      fit.setPlatePairs(id, 10, 1);

      final parts = fit.platesPerSide(100, 20);
      expect(parts.map((p) => p.weight), [20, 10]);
      expect(fit.loadableTotal(100, 20), 80);
    });

    test('sin inventario sigue proponiendo de todo', () {
      final parts = fit.platesPerSide(100, 20);
      expect(parts.first.weight, 25);
      expect(fit.loadableTotal(100, 20), 100);
    });

    test('la barra del sitio manda en el aviso del entreno', () {
      final id = fit.addPlace('Casa', equipment: {'Barbell'});
      fit.setActivePlace(id);
      fit.setPlaceBar(id, 15);
      expect(fit.defaultBar, 15);
    });
  });
}
