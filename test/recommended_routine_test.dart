import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/services/exercise_match.dart';

const _mainPath = {
  'warm-up': [
    "Yuri's Shoulder Band Warmup",
    'Wrist Prep',
    'Squat Sky Reaches',
    'Deadbugs',
    'Arch Hang',
    'Parallel Bar Support Hold',
    'Bodyweight Squat',
    'Push-up',
  ],
  'pull-up': [
    'Scapular Pulls',
    'Arch Hang',
    'Negative Pull-up',
    'Pull-up',
    'Weighted Pull-up',
  ],
  'squat': [
    'Assisted Squat',
    'Bodyweight Squat',
    'Split Squats',
    'Bulgarian Split Squat',
    'Beginner Shrimp Squat',
    'Intermediate Shrimp Squat',
    'Advanced Shrimp Squat',
    'Weighted Shrimp Squat',
  ],
  'dip': [
    'Parallel Bar Support Hold',
    'Negative Dip',
    'Chest Dip',
    'Weighted Tricep Dips',
  ],
  'hinge': [
    'Bodyweight Romanian Deadlift',
    'Bodyweight Single-Leg Deadlift',
    'Banded Nordic Curl Negative',
    'Banded Nordic Curl',
    'Nordic Curl',
  ],
  'row': [
    'Vertical Row',
    'Incline Row',
    'Horizontal Row',
    'Wide Row',
    'Weighted Inverted Row',
  ],
  'push-up': [
    'Wall Push-up',
    'Incline Push-up',
    'Push-up',
    'Diamond Push-up',
    'Pseudo Planche Push-up',
  ],
  'core': [
    'Plank',
    'Ring Ab Rollout',
    'Banded Pallof Press',
    'Reverse Hyperextension',
  ],
};

void main() {
  final byId = {for (final e in kExercises) e.id: e};

  Exercise? find(String name) => matchExercise(name, kExercises);

  test('every movement on the main path of the Recommended Routine is loggable', () {
    final missing = <String>[];
    for (final progression in _mainPath.entries) {
      for (final name in progression.value) {
        if (find(name) == null) missing.add('${progression.key}: $name');
      }
    }
    expect(missing, isEmpty);
  });

  test('the hinge and row progressions are catalogue entries of their own', () {
    for (final id in const [
      'bodyweight-romanian-deadlift',
      'bodyweight-single-leg-deadlift',
      'banded-nordic-curl-negative',
      'banded-nordic-curl',
      'nordic-curl',
    ]) {
      expect(byId[id]?.primary, 'hamstrings', reason: id);
    }
    for (final id in const ['vertical-row', 'incline-row', 'wide-row', 'weighted-inverted-row']) {
      expect(byId[id]?.primary, 'back', reason: id);
    }
  });

  test('nothing the routine adds needs a gym', () {
    final gymless = {'Bodyweight', 'Band', 'Weighted'};
    final needsKit = <String>[];
    for (final progression in const ['hinge', 'row', 'squat', 'dip']) {
      for (final name in _mainPath[progression]!) {
        final e = find(name);
        if (e != null && !gymless.contains(e.equipment)) needsKit.add('$name: ${e.equipment}');
      }
    }
    expect(needsKit, isEmpty);
  });

  test('an RR name never lands on the exercise of another progression', () {
    expect(find('Advanced Shrimp Squat')?.id, 'shrimp-squat');
    expect(find('Diamond Push-up')?.id, find('Close-grip Push-up')?.id);
    expect(find('Squat Sky Reaches')?.name, 'Squat to Overhead Reach');
    expect(find('Scapular Pulls')?.name, 'Scapular Pull-up');
    expect(find('Pull-up Negatives')?.id, 'negative-pull-up');
    expect(find('Deadbugs')?.name, 'Dead Bug');
    expect(find('Horizontal Row')?.name, 'Bench Pull-ups');
  });

  test('the holds are logged as time, not as reps', () {
    expect(kExerciseModes['arch-hang'], 'time');
    expect(kExerciseModes['parallel-bar-support-hold'], 'time');
  });

  test('the shrimp squat rungs climb in difficulty', () {
    expect(byId['beginner-shrimp-squat']!.difficulty, 'Intermediate');
    expect(byId['intermediate-shrimp-squat']!.difficulty, 'Advanced');
    expect(byId['shrimp-squat']!.difficulty, 'Advanced');
    expect(byId['weighted-shrimp-squat']!.equipment, 'Weighted');
  });
}
