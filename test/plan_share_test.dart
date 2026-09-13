import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/plan_share.dart';
import 'package:gymmane/state/fit_state.dart';

void main() {
  group('lectura del JSON', () {
    test('lee una rutina simple', () {
      final plans = parsePlan('{"name":"Push","exercises":["Barbell Bench Press","Push-Up"]}');
      expect(plans.length, 1);
      expect(plans.first.name, 'Push');
      expect(plans.first.items.length, 2);
      expect(plans.first.items.first.sets, isNull);
    });

    test('lee series por ejercicio y varias rutinas', () {
      final plans = parsePlan(
          '{"routines":[{"name":"A","exercises":[{"name":"Squat","sets":5}]},'
          '{"title":"B","ejercicios":[{"exercise":"Deadlift"}]}]}');
      expect(plans.length, 2);
      expect(plans.first.items.single.sets, 5);
      expect(plans.last.name, 'B');
    });

    test('aguanta la prosa y las vallas de código de una IA', () {
      final plans = parsePlan('Sure! Here you go:\n```json\n'
          '{"name":"Full body","exercises":["Squat"]}\n```\nEnjoy.');
      expect(plans.single.name, 'Full body');
    });

    test('un archivo que no es un plan devuelve nada', () {
      expect(parsePlan('hola'), isEmpty);
      expect(parsePlan('{"name":"Push"}'), isEmpty);
    });
  });

  group('importar en el estado', () {
    setUp(() => fit.resetAllData());

    test('crea la rutina, empareja los nombres y guarda las series', () {
      final result = fit.importPlan(
          '{"name":"Empuje","exercises":[{"name":"Barbell Bench Press","sets":5},'
          '{"name":"no existe este ejercicio"}]}');
      expect(result.added, 1);
      expect(result.missed, ['no existe este ejercicio']);
      expect(result.readable, isTrue);
      final routine = fit.routines.single;
      expect(routine.name, 'Empuje');
      expect(routine.exerciseIds.length, 1);
      expect(fit.routineSets(routine, routine.exerciseIds.first), 5);
    });

    test('avisa cuando no hay nada que emparejar', () {
      final result = fit.importPlan('{"name":"X","exercises":["zzzz qqqq"]}');
      expect(result.added, 0);
      expect(result.readable, isTrue);
      expect(result.missed, ['zzzz qqqq']);
      expect(fit.routines, isEmpty);
    });

    test('un archivo ilegible se distingue de uno sin coincidencias', () {
      expect(fit.importPlan('no soy json').readable, isFalse);
    });
  });

  test('la lista para la IA lleva cabecera y ejercicios', () {
    final text = fit.planRequestText();
    expect(text.contains('GymMane'), isTrue);
    expect(text.contains('Barbell Bench Press'), isTrue);
    expect(text.split('\n').length, greaterThan(50));
  });
}
