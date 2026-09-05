import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_aliases.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/services/exercise_match.dart';

const _hevyNames = {
  'Bench Press (Barbell)': 'Barbell Bench Press',
  'Squat (Barbell)': 'Barbell Full Squat',
  'Deadlift (Barbell)': 'Barbell Deadlift',
  'Lat Pulldown (Cable)': 'Cable Pulldown',
  'Seated Row (Cable)': 'Cable Seated Row',
  'Overhead Press (Barbell)': 'Barbell Standing Wide Military Press',
  'Shoulder Press (Dumbbell)': 'Dumbbell Standing Overhead Press',
  'Lateral Raise (Dumbbell)': 'Dumbbell Lateral Raise',
  'Bicep Curl (Dumbbell)': 'Dumbbell Biceps Curl',
  'Hammer Curl (Dumbbell)': 'Dumbbell Hammer Curl',
  'Triceps Pushdown (Cable)': 'Cable Pushdown',
  'Skullcrusher (Barbell)': 'Barbell Lying Triceps Extension',
  'Romanian Deadlift (Barbell)': 'Barbell Romanian Deadlift',
  'Bulgarian Split Squat (Dumbbell)': 'Dumbbell Single Leg Split Squat',
  'Chest Fly (Machine)': 'Pec Deck',
  'Chest Press (Machine)': 'Lever Standing Chest Press',
  'T Bar Row': 'Lever T Bar Row',
  'Hip Abduction (Machine)': 'Hip Abduction Machine',
  'Leg Curl (Machine)': 'Seated Leg Curl',
  'Farmers Walk': 'Kettlebell Farmer Carry',
};

List<Exercise> _search(String query) => kExercises.where(exerciseSearch(query)).toList();

void main() {
  final byName = {for (final e in kExercises) e.name: e};

  test('every alias belongs to an exercise in the catalog', () {
    final orphans = kExerciseAliases.keys.where((name) => !byName.containsKey(name));
    expect(orphans, isEmpty);
  });

  test('no two exercises claim the same alias', () {
    final owners = <String, String>{};
    final clashes = <String>[];
    for (final entry in kExerciseAliases.entries) {
      for (final alias in entry.value) {
        final owner = owners.putIfAbsent(searchKey(alias), () => entry.key);
        if (owner != entry.key) clashes.add('$alias: $owner / ${entry.key}');
      }
    }
    expect(clashes, isEmpty);
  });

  test('searching a name from another app finds the exercise', () {
    for (final entry in _hevyNames.entries) {
      expect(_search(entry.key).map((e) => e.name), contains(entry.value),
          reason: 'searching "${entry.key}" should find ${entry.value}');
    }
  });

  test('importing a name from another app maps to the same exercise', () {
    for (final entry in _hevyNames.entries) {
      expect(matchExercise(entry.key, kExercises)?.name, entry.value);
    }
  });

  test('a half-typed name still narrows down to the exercise', () {
    expect(_search('lat pulld').map((e) => e.name), contains('Cable Pulldown'));
    expect(_search('db bench').map((e) => e.name), contains('Dumbbell Bench Press'));
    expect(_search('bulgarian split').map((e) => e.name), contains('Dumbbell Single Leg Split Squat'));
  });

  test('the plain catalog name still wins on its own', () {
    expect(_search('Barbell Bench Press').map((e) => e.name), contains('Barbell Bench Press'));
    expect(_search('pec deck').single.name, 'Pec Deck');
  });

  test('an empty search keeps the whole catalog', () {
    expect(_search('   ').length, kExercises.length);
  });
}
