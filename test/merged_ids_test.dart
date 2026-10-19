import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/catalog/merged_exercises.dart';
import 'package:gymmane/services/merged_ids.dart';

void main() {
  final old = kMergedExercises.keys.first;
  final kept = kMergedExercises[old]!;

  test('every merged exercise lands on one that still exists', () {
    final ids = kExercises.map((e) => e.id).toSet();
    for (final e in kMergedExercises.entries) {
      expect(ids, isNot(contains(e.key)), reason: e.key);
      expect(ids, contains(e.value), reason: '${e.key} -> ${e.value}');
    }
  });

  test('routines, history and favourites move to the exercise that stays', () {
    final data = withMergedExercises({
      'routines': [
        {
          'id': 'r1',
          'ex': [old, 'other'],
        },
      ],
      'sessions': [
        {
          'ex': [
            {'id': old, 'n': 'Old name'},
          ],
        },
      ],
      'favorites': {old: true},
    });
    expect((data['routines'] as List).first['ex'], [kept, 'other']);
    expect((data['sessions'] as List).first['ex'].first['id'], kept);
    expect(data['favorites'], {kept: true});
  });

  test('a routine that already had both keeps it once', () {
    final data = withMergedExercises({
      'routines': [
        {
          'ex': [kept, old],
        },
      ],
      'favorites': {kept: false, old: true},
    });
    expect((data['routines'] as List).first['ex'], [kept]);
    expect(data['favorites'], {kept: false});
  });
}
