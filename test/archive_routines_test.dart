import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
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
    setAppLanguage('en');
  });

  test('archivar la quita de las listas y del plan, y deshacer lo devuelve', () {
    final a = fit.createRoutine('A');
    final b = fit.createRoutine('B');
    fit.assignRoutineToDay(1, a);
    final undo = fit.archiveRoutine(a, true)!;
    expect(fit.activeRoutines.map((r) => r.id), [b]);
    expect(fit.archivedRoutines.map((r) => r.id), [a]);
    expect(fit.routinesInGroup('').map((r) => r.id), [b]);
    expect(fit.routinesByLastDone.map((r) => r.id), [b]);
    expect(fit.weeklyPlan[1], isNull);
    undo();
    expect(fit.archivedRoutines, isEmpty);
    expect(fit.weeklyPlan[1], a);
  });

  test('restaurar no devuelve deshacer y la rutina vuelve a la lista', () {
    final a = fit.createRoutine('A');
    fit.archiveRoutine(a, true);
    expect(fit.archiveRoutine(a, false), isNull);
    expect(fit.activeRoutines.single.id, a);
  });

  test('archivada se guarda y se lee', () {
    final r = Routine('x', 'X', const [], archived: true);
    expect(Routine.fromJson(r.toJson()).archived, isTrue);
    expect(Routine.fromJson(Routine('y', 'Y', const []).toJson()).archived, isFalse);
  });
}
