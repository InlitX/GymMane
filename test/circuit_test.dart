import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/circuit.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    setAppLanguage('en');
  });

  Circuit navySeal() {
    final c = fit.newCircuit()
      ..name = 'Navy Seal'
      ..rounds = 3
      ..roundRest = 80;
    c.steps.addAll([
      CircuitStep('plank-hold', work: 60, rest: 15),
      CircuitStep('kettlebell-russian-twist', work: 45, rest: 15),
      CircuitStep('side-plank-hold', work: 40, rest: 5),
      CircuitStep('side-plank-hold', work: 40, rest: 30),
    ]);
    return c;
  }

  test('el tiempo total cuenta trabajo, pausas y descansos entre rondas', () {
    final c = navySeal();
    expect(c.totalSeconds, (60 + 15 + 45 + 15 + 40 + 5 + 40) * 3 + 80 * 2,
        reason: 'la pausa del último paso no cuenta: tras él va el descanso de ronda');
  });

  test('un circuito se guarda, vuelve igual al reabrir y se borra', () {
    final c = navySeal();
    fit.saveCircuit(c);
    fit.persistNow();
    fit.loadFromStore();
    final back = fit.circuitById(c.id)!;
    expect(back.name, 'Navy Seal');
    expect(back.steps.map((s) => s.exerciseId), ['plank-hold', 'kettlebell-russian-twist', 'side-plank-hold', 'side-plank-hold']);
    expect((back.rounds, back.roundRest), (3, 80));
    fit.deleteCircuit(c.id);
    expect(fit.circuits, isEmpty);
  });

  test('sin nombre se llama Circuito y los valores raros se recortan', () {
    final c = fit.newCircuit()
      ..rounds = 900
      ..roundRest = -4;
    c.steps.add(CircuitStep('plank-hold'));
    fit.saveCircuit(c);
    expect(c.name, t.circuitDefaultName);
    expect((c.rounds, c.roundRest), (50, 0));
    final bad = Circuit.fromJson({'id': 'k1', 's': [{'e': 'plank-hold', 'w': 1, 'r': -3}, {'e': ''}]})!;
    expect(bad.steps, hasLength(1));
    expect((bad.steps.single.work, bad.steps.single.rest), (5, 0));
  });

  test('al acabar se guarda como entreno, juntando el mismo ejercicio', () {
    final c = navySeal();
    fit.saveCircuit(c);
    final start = DateTime.now().subtract(const Duration(minutes: 14));
    final entry = fit.logCircuit(
      c,
      [
        (step: 0, seconds: 60),
        (step: 1, seconds: 45),
        (step: 2, seconds: 40),
        (step: 3, seconds: 38),
        (step: 0, seconds: 60),
      ],
      start,
      DateTime.now(),
    )!;
    expect(fit.sessions.single, same(entry));
    expect(entry.name, 'Navy Seal');
    expect(entry.durationSec, closeTo(14 * 60, 2));
    final byId = {for (final e in entry.exercises) e.id: e.sets.map((s) => s.sec).toList()};
    expect(byId['plank-hold'], [60, 60]);
    expect(byId['side-plank-hold'], [40, 38], reason: 'izquierda y derecha son el mismo ejercicio');
  });

  test('si no se hizo nada no se guarda ningún entreno', () {
    final c = navySeal();
    expect(fit.logCircuit(c, const [], DateTime.now(), DateTime.now()), isNull);
    expect(fit.sessions, isEmpty);
  });
}
