import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/exercise_match.dart';
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

  List<String> search(String q) => kExercises.where(exerciseSearch(q)).map((e) => e.name).toList();

  group('#237 buscador', () {
    test('gemelos en plural, por músculo y con palabras desordenadas', () {
      expect(search('Calf raises'), contains('Bodyweight Standing Calf Raise'));
      expect(search('calves'), contains('Donkey Calf Raise'));
      expect(search('machine calf raise'), contains('Lever Standing Calf Raise'));
      expect(search('seated calf raises'), contains('Dumbbell Seated One Leg Calf Raise'));
      expect(search('calf ra'), contains('Smith Calf Raise'));
    });

    test('el nombre del músculo en castellano también busca', () {
      setAppLanguage('es');
      expect(search('gemelos'), contains('Donkey Calf Raise'));
      setAppLanguage('en');
    });

    test('no se cuelan resultados de más', () {
      expect(search('calf raise').every((n) => n.toLowerCase().contains('calf')), isTrue);
      expect(search('bench press'), isNot(contains('Donkey Calf Raise')));
      expect(search('ch'), isNot(contains('Donkey Calf Raise')));
    });
  });

  group('#234 tira de la semana', () {
    test('con una rutina pendiente el día sale a medias, no hecho', () {
      fit.toggleMultiPlan();
      final a = fit.createRoutine('A');
      final b = fit.createRoutine('B');
      final today = DateTime.now().weekday;
      fit.togglePlanDay(today, a);
      fit.togglePlanDay(today, b);
      expect(fit.isDayPartial(fit.todayIndex), isFalse);

      fit.sessions.add(LoggedSession(DateTime.now().copyWith(hour: 12), 600, [
        LoggedExercise('x', 'X', 'chest', [LoggedSet(5, 60)]),
      ], routineId: a));
      expect(fit.isDayDone(fit.todayIndex), isTrue);
      expect(fit.isDayPartial(fit.todayIndex), isTrue);

      fit.sessions.add(LoggedSession(DateTime.now().copyWith(hour: 12), 600, [
        LoggedExercise('x', 'X', 'chest', [LoggedSet(5, 60)]),
      ], routineId: b));
      expect(fit.isDayPartial(fit.todayIndex), isFalse);
    });

    test('un día con una sola rutina sigue igual que antes', () {
      final a = fit.createRoutine('A');
      fit.togglePlanDay(DateTime.now().weekday, a);
      fit.sessions.add(LoggedSession(DateTime.now().copyWith(hour: 12), 600, [
        LoggedExercise('x', 'X', 'chest', [LoggedSet(5, 60)]),
      ], routineId: a));
      expect(fit.isDayPartial(fit.todayIndex), isFalse);
    });
  });

  test('#236 el cronómetro solo en ejercicios con reloj', () {
    expect(fit.runsClock('plank-hold'), isTrue);
    expect(fit.runsClock(fit.matchExerciseByName('Bench Press')!.id), isFalse);
  });
}
