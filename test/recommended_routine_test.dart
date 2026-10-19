import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/l10n/catalog_es.dart';
import 'package:gymmane/l10n/catalog_it.dart';
import 'package:gymmane/l10n/catalog_zh.dart';
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
  'pull-up': ['Scapular Pulls', 'Arch Hang', 'Pull-up Negatives', 'Pull-up', 'Weighted Pull-up'],
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
  'dip': ['Parallel Bar Support Hold', 'Negative Dip', 'Chest Dip', 'Weighted Tricep Dips'],
  'hinge': [
    'Bodyweight Romanian Deadlift',
    'Bodyweight Single-Leg Deadlift',
    'Banded Nordic Curl Negative',
    'Banded Nordic Curl',
    'Nordic Curl',
  ],
  'row': ['Vertical Row', 'Incline Row', 'Horizontal Row', 'Wide Row', 'Weighted Inverted Row'],
  'push-up': ['Wall Push-up', 'Incline Push-up', 'Push-up', 'Diamond Push-up', 'Pseudo Planche Push-up'],
  'core': ['Plank', 'Ring Ab Rollout', 'Banded Pallof Press', 'Reverse Hyperextension'],
};

const _added = [
  'yuris-shoulder-band-warmup',
  'wrist-prep',
  'arch-hang',
  'parallel-bar-support-hold',
  'assisted-squat',
  'bulgarian-split-squat',
  'beginner-shrimp-squat',
  'intermediate-shrimp-squat',
  'weighted-shrimp-squat',
  'negative-dip',
  'bodyweight-romanian-deadlift',
  'bodyweight-single-leg-deadlift',
  'banded-nordic-curl-negative',
  'banded-nordic-curl',
  'nordic-curl',
  'vertical-row',
  'incline-row',
  'wide-row',
  'weighted-inverted-row',
  'pseudo-planche-push-up',
];

void main() {
  final byId = {for (final e in kExercises) e.id: e};
  Exercise? find(String name) => matchExercise(name, kExercises);

  test('todo el camino principal de la Recommended Routine se puede apuntar', () {
    final missing = [
      for (final p in _mainPath.entries)
        for (final name in p.value)
          if (find(name) == null) '${p.key}: $name',
    ];
    expect(missing, isEmpty);
  });

  test('los nombres de la rutina caen en el ejercicio que toca', () {
    expect(find('Advanced Shrimp Squat')?.id, 'shrimp-squat');
    expect(find('Diamond Push-up')?.name, 'Close-grip Push-up');
    expect(find('Squat Sky Reaches')?.name, 'Squat to Overhead Reach');
    expect(find('Scapular Pulls')?.name, 'Scapular Pull-up');
    expect(find('Pull-up Negatives')?.name, 'Negative Pull-up');
    expect(find('Deadbugs')?.name, 'Dead Bug');
    expect(find('Horizontal Row')?.name, 'Bench Pull-ups');
    expect(find('Nordic Curl')?.id, 'nordic-curl');
  });

  test('bisagra y remo tienen sus escalones propios', () {
    for (final id in [
      'bodyweight-romanian-deadlift',
      'bodyweight-single-leg-deadlift',
      'banded-nordic-curl-negative',
      'banded-nordic-curl',
      'nordic-curl',
    ]) {
      expect(byId[id]?.primary, 'hamstrings', reason: id);
    }
    for (final id in ['vertical-row', 'incline-row', 'wide-row', 'weighted-inverted-row']) {
      expect(byId[id]?.primary, 'back', reason: id);
    }
  });

  test('los aguantes se apuntan por tiempo', () {
    expect(kExerciseModes['arch-hang'], 'time');
    expect(kExerciseModes['parallel-bar-support-hold'], 'time');
  });

  test('lo que pide barra, banco o anclaje no sale en Sin material', () {
    for (final id in [
      'arch-hang',
      'parallel-bar-support-hold',
      'negative-dip',
      'nordic-curl',
      'incline-row',
    ]) {
      expect(isNoKit(byId[id]!), isFalse, reason: id);
    }
    for (final id in ['bodyweight-romanian-deadlift', 'bodyweight-single-leg-deadlift', 'wrist-prep']) {
      expect(isNoKit(byId[id]!), isTrue, reason: id);
    }
  });

  test('los calentamientos de la rutina salen en la tarjeta Calentamiento', () {
    expect(kWarmupIds, containsAll(['yuris-shoulder-band-warmup', 'wrist-prep']));
  });

  test('cada ejercicio nuevo tiene nombre y pasos en español, italiano y chino', () {
    for (final id in _added) {
      expect(byId[id], isNotNull, reason: id);
      for (final (names, steps) in [
        (kExerciseNameEs, kExerciseStepsEs),
        (kExerciseNameIt, kExerciseStepsIt),
        (kExerciseNameZh, kExerciseStepsZh),
      ]) {
        expect(names[id], isNotNull, reason: id);
        expect(steps[id]?.length, byId[id]!.steps.length, reason: id);
      }
    }
  });

  test('la plantilla usa ejercicios del catálogo y tres días a la semana', () {
    final rr = kProgramTemplates.firstWhere((p) => p.id == 'rr');
    expect(rr.days.map((d) => d.weekday), [1, 3, 5]);
    for (final (name, _) in rr.days.first.exercises) {
      expect(find(name), isNotNull, reason: name);
    }
  });
}
