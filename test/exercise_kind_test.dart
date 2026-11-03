import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/exercise.dart';
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

  String kindOfId(String id) => fit.kindOf(fit.exerciseById(id)!);

  test('el catálogo se reparte en los cuatro tipos', () {
    expect(kindOfId('hamstring-stretch'), 'stretch');
    expect(kindOfId('running'), 'cardio');
    expect(kindOfId('burpee'), 'cardio');
    expect(kindOfId('nordic-curl'), 'calisthenics');
    expect(kindOfId('kettlebell-swing'), 'strength');
    final kinds = fit.allExercises.map(fit.kindOf).toSet();
    expect(kinds, kExerciseKinds.toSet());
  });

  test('el filtro de tipo deja solo ese tipo y se limpia con los demás', () {
    fit.setKindFilter('stretch');
    final list = fit.exercisesFiltered;
    expect(list, isNotEmpty);
    expect(list.every((e) => fit.kindOf(e) == 'stretch'), isTrue);
    fit.clearExFilters();
    expect(fit.exKindFilter, isNull);
  });

  test('un ejercicio propio guarda su tipo y sobrevive a la copia', () {
    final id = fit.addCustomExercise(name: 'Pole spin', primary: 'back', equipment: 'Other', kind: 'calisthenics');
    expect(kindOfId(id), 'calisthenics');
    final back = Exercise.fromJson(fit.exerciseById(id)!.toJson());
    expect(back.kind, 'calisthenics');
    final ex = fit.exerciseById(id)!;
    fit.updateCustomExercise(id,
        name: ex.name, primary: ex.primary, equipment: ex.equipment, difficulty: ex.difficulty, steps: [], mode: '');
    expect(kindOfId(id), 'calisthenics');
    final plain = fit.addCustomExercise(name: 'Row', primary: 'back', equipment: 'Cable');
    expect(kindOfId(plain), 'strength');
  });

  test('los deportes son su propio tipo y no suman series por músculo', () {
    expect(kindOfId('football'), 'sport');
    expect(kindOfId('padel'), 'sport');
    expect(fit.isCardio('badminton'), true, reason: 'se apuntan por tiempo');
    expect(fit.countsForMuscles('volleyball'), false);
    expect(fit.countsForMuscles('EIeI8Vf'), true);
    expect(fit.recommendedExercises(30).any((e) => e.kind == 'sport'), false);
  });
}
