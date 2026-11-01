import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
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
  });

  test('las dos calculadoras nuevas están en la lista', () {
    expect(kToolMeta.map((m) => m.id), containsAll(['rpe', 'dots']));
  });

  test('peso por RPE: 100 x 5 a RPE 8 da unos 110 para 3 a RPE 9', () {
    fit.rpeWeight = 100;
    fit.rpeReps = 5;
    fit.rpeRpe = 8;
    fit.rpeTargetReps = 3;
    fit.rpeTargetRpe = 9;
    expect(fit.rpeOneRm, closeTo(123.3, 0.1));
    expect(fit.rpeResult, 110);
  });

  test('peso por RPE: misma serie y mismo esfuerzo devuelve el mismo peso', () {
    fit.rpeWeight = 80;
    fit.rpeReps = 8;
    fit.rpeRpe = 7.5;
    fit.rpeTargetReps = 8;
    fit.rpeTargetRpe = 7.5;
    expect(fit.rpeResult, 80);
  });

  test('peso por RPE: el RPE no sale de 6 a 10 ni las repes de 1 a 12', () {
    fit.rpeRpe = 10;
    fit.bumpRpe(0.5);
    expect(fit.rpeRpe, 10);
    fit.rpeReps = 12;
    fit.bumpRpeReps(1);
    expect(fit.rpeReps, 12);
  });

  test('DOTS: 80 kg y 500 de total en hombre da unos 345', () {
    fit.dotsSex = 'male';
    fit.dotsBody = 80;
    fit.dotsSquat = 180;
    fit.dotsBench = 120;
    fit.dotsDeadlift = 200;
    expect(fit.dotsScore, closeTo(344.8, 0.5));
    expect(fit.dotsLevel, 2);
  });

  test('DOTS: con el mismo total, una mujer puntúa más', () {
    fit.dotsBody = 60;
    fit.dotsSquat = 100;
    fit.dotsBench = 60;
    fit.dotsDeadlift = 120;
    fit.dotsSex = 'male';
    final male = fit.dotsScore;
    fit.dotsSex = 'female';
    expect(fit.dotsScore, greaterThan(male));
  });

  test('DOTS toma tus mejores marcas al abrirla', () {
    fit.sessions.add(LoggedSession(DateTime.now(), 600, [
      LoggedExercise('qXTaZnJ', 'Barbell Full Squat', 'quads', [LoggedSet(5, 120)]),
    ]));
    fit.openTool('dots');
    expect(fit.dotsSquat, closeTo(140, 0.1));
    fit.closeTool();
  });

  group('equilibrio de fuerza', () {
    void lift(String id, double kg) {
      final n = DateTime.now();
      fit.sessions.add(LoggedSession(DateTime(n.year, n.month, n.day - 3, 18), 3600, [
        LoggedExercise(id, id, 'chest', [LoggedSet(1, kg)]),
      ]));
    }

    test('con menos de tres básicos no dice nada', () {
      fit.sessions.clear();
      lift('qXTaZnJ', 100);
      lift('EIeI8Vf', 75);
      expect(fit.structuralBalance, isNull);
    });

    test('señala el que va atrasado y cuánto le falta', () {
      fit.sessions.clear();
      lift('qXTaZnJ', 100);
      lift('ila4NZS', 120);
      lift('EIeI8Vf', 75);
      lift('kTbSH9h', 30);
      final b = fit.structuralBalance!;
      expect(b.behind, 'Kyd9Rz5');
      final ohp = b.lifts.firstWhere((l) => l.id == 'Kyd9Rz5');
      final squat = b.lifts.firstWhere((l) => l.id == 'qXTaZnJ');
      expect(ohp.target, closeTo(squat.kg * 0.45, 0.01));
      expect(b.lifts.firstWhere((l) => l.id == 'qXTaZnJ').score, closeTo(1, 0.01));
    });

    test('todo en proporción no marca a nadie', () {
      fit.sessions.clear();
      lift('qXTaZnJ', 100);
      lift('ila4NZS', 118);
      lift('EIeI8Vf', 76);
      expect(fit.structuralBalance!.behind, isNull);
    });
  });
}
