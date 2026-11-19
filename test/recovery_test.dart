import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/recovery.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    setAppLanguage('es');
    fit.resetAllData();
    fit.onboarded = true;
  });

  test('viene apagado y no sale en Inicio hasta encenderlo', () {
    expect(fit.recoveryOn, isFalse);
    fit.setRecoveryOn(true);
    expect(fit.recoveryOn, isTrue);
    fit.persistNow();
    fit.loadFromStore();
    expect(fit.recoveryOn, isTrue);
  });

  test('la semana separa calor, frío y respiración, y el contraste cuenta en los dos', () {
    fit.addRecovery(kind: 'sauna', sec: 15 * 60, tempC: 80, rounds: 2);
    fit.addRecovery(kind: 'cold', sec: 3 * 60, tempC: 8);
    fit.addRecovery(kind: 'contrast', sec: 10 * 60, coldSec: 2 * 60, rounds: 3);
    fit.addRecovery(kind: 'breath', sec: 5 * 60, pattern: 'box');
    final week = fit.recoveryWeek;
    expect(week.heat, 25 * 60);
    expect(week.cold, 5 * 60);
    expect(week.breath, 5 * 60);
    expect(week.sessions, 4);
    expect(fit.recoveryWeekDays.fold(0, (a, b) => a + b), 35 * 60);
  });

  test('lo de semanas anteriores no entra en esta semana', () {
    fit.addRecovery(kind: 'sauna', sec: 600, date: fit.weekStartDate.subtract(const Duration(days: 2)));
    expect(fit.recoveryWeek.sessions, 0);
    expect(fit.recoveryStreakWeeks, 1);
    fit.addRecovery(kind: 'sauna', sec: 600);
    expect(fit.recoveryStreakWeeks, 2);
  });

  test('borrar y deshacer', () {
    final e = fit.addRecovery(kind: 'cold', sec: 120);
    fit.removeRecovery(e.id);
    expect(fit.recovery, isEmpty);
    fit.restoreRecovery(e);
    expect(fit.recovery.single.id, e.id);
  });

  test('va en la copia de seguridad y vuelve igual', () {
    fit.setRecoveryOn(true);
    fit.addRecovery(kind: 'sauna', sec: 900, tempC: 85.5, rounds: 3, note: 'Muy bien');
    fit.addRecovery(kind: 'contrast', sec: 600, coldSec: 180, coldTempC: 6);
    final saved = fit.toJson();
    fit.resetAllData();
    expect(fit.recovery, isEmpty);
    expect(fit.recoveryOn, isFalse);
    fit.applyBackup(saved);
    expect(fit.recoveryOn, isTrue);
    expect(fit.recovery.length, 2);
    final sauna = fit.recovery.firstWhere((e) => e.kind == 'sauna');
    expect(sauna.tempC, 85.5);
    expect(sauna.rounds, 3);
    expect(sauna.note, 'Muy bien');
    expect(fit.recovery.firstWhere((e) => e.kind == 'contrast').coldSec, 180);
  });

  test('un registro raro en el JSON no rompe la carga', () {
    expect(RecoveryEntry.fromJson({'k': 'lava', 'd': '2026-11-19T10:00:00.000'}), isNull);
    expect(RecoveryEntry.fromJson({'k': 'sauna'}), isNull);
    expect(RecoveryEntry.fromJson({'k': 'sauna', 'd': '2026-11-19T10:00:00.000', 's': 600})!.sec, 600);
  });

  test('las respiraciones tienen sus fases en orden', () {
    final box = kBreathPatterns.firstWhere((p) => p.id == 'box');
    expect(box.phases.map((p) => p.$1).toList(), ['in', 'hold', 'out', 'rest']);
    expect(box.cycle, 16);
    final even = kBreathPatterns.firstWhere((p) => p.id == 'even');
    expect(even.phases.map((p) => p.$1).toList(), ['in', 'out']);
  });

  test('el plan de sauna intercala descansos y no deja uno al final', () {
    final plan = recoveryPlan('sauna', heat: 900, rest: 300, rounds: 3);
    expect(plan.map((p) => p.$1).toList(), ['heat', 'rest', 'heat', 'rest', 'heat']);
    expect(recoveryPlan('contrast', heat: 600, cold: 120, rounds: 2).map((p) => p.$1).toList(),
        ['heat', 'cold', 'heat', 'cold']);
    expect(recoveryPlan('cold', heat: 120), [('cold', 120)]);
  });

  test('la fase en curso y lo que falta', () {
    final plan = recoveryPlan('sauna', heat: 600, rest: 120, rounds: 2);
    expect(recoveryPhaseAt(plan, 0), (index: 0, left: 600, into: 0));
    expect(recoveryPhaseAt(plan, 650), (index: 1, left: 70, into: 50));
    expect(recoveryPhaseAt(plan, 2000).index, plan.length);
  });

  test('parar a medias guarda solo lo hecho, y el frío de más también cuenta', () {
    final plan = recoveryPlan('sauna', heat: 600, rest: 120, rounds: 2);
    final half = recoveryDone(plan, 900);
    expect(half.heat, 600 + 180);
    expect(half.rest, 120);
    expect(half.rounds, 2);
    final cold = recoveryDone(recoveryPlan('cold', heat: 120), 150);
    expect(cold.cold, 150);
    expect(cold.rounds, 1);
  });

  test('metas, valoración y marcas se guardan', () {
    fit.setRecoveryGoals(heat: 45, cold: 15);
    final e = fit.addRecovery(kind: 'cold', sec: 190);
    fit.addRecovery(kind: 'breath', sec: 600, pattern: 'retention', holds: [62, 95, 80]);
    fit.addRecovery(kind: 'sauna', sec: 1800, restSec: 600, rounds: 3);
    fit.setRecoveryFeel(e.id, 4);
    fit.seeRecoveryTip();
    expect(fit.bestColdSec, 190);
    expect(fit.bestHoldSec, 95);
    final saved = fit.toJson();
    fit.resetAllData();
    fit.applyBackup(saved);
    expect(fit.heatGoalMin, 45);
    expect(fit.coldGoalMin, 15);
    expect(fit.recoveryTipSeen, isTrue);
    expect(fit.recovery.firstWhere((x) => x.kind == 'cold').feel, 4);
    expect(fit.recovery.firstWhere((x) => x.kind == 'breath').holds, [62, 95, 80]);
    expect(fit.recovery.firstWhere((x) => x.kind == 'sauna').restSec, 600);
  });
}
