import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/workout_import.dart';

void main() {
  const header = 'Workout DateTime,Program,Day Name,Exercise,Is Warmup Set?,Required Reps,Completed Reps,Is AMRAP?,'
      'Required RPE,Completed RPE,Log RPE?,Required Weight Value,Required Weight Unit,Completed Weight Value,'
      'Completed Weight Unit,Ask Weight?,Completed Reps Time,Target Muscles,Synergist Muscles,Notes\n';
  const csv = '$header'
      '2026-03-01T10:00:00.000Z,My Program,Day 1,Squat,1,5,5,0,,,0,95,lb,95,lb,0,2026-03-01T10:02:00.000Z,,,\n'
      '2026-03-01T10:00:00.000Z,My Program,Day 1,Squat,0,5,5,0,,8,1,225,lb,225,lb,0,2026-03-01T10:05:00.000Z,,,\n'
      '2026-03-01T10:00:00.000Z,My Program,Day 1,Squat,0,5,4,0,,,0,225,lb,225,lb,0,2026-03-01T10:09:00.000Z,,,\n'
      '2026-03-01T10:00:00.000Z,My Program,Day 1,Bench Press,0,8,8,0,,,0,60,kg,60,kg,0,2026-03-01T10:20:00.000Z,,,"felt good"\n'
      '2026-03-03T10:00:00.000Z,My Program,Day 2,Deadlift,0,5,5,0,,,0,100,kg,100,kg,0,2026-03-03T10:05:00.000Z,,,\n';

  test('a Liftosaur history export is recognised', () {
    expect(detectFormat(csv), ImportFormat.liftosaur);
    expect(needsUnitChoice(csv), isFalse);
  });

  test('sets are read with their own unit and warm-ups are skipped', () {
    final result = parseImport(csv);
    expect(result.sessions, hasLength(2));
    final first = result.sessions.first;
    expect(first.exercises.map((e) => e.name), ['Squat', 'Bench Press']);
    final squat = first.exercises.first.sets;
    expect(squat.map((s) => s.reps), [5, 4]);
    expect(squat.first.weightKg, closeTo(102.06, 0.05));
    expect(squat.first.rpe, 8);
    expect(first.exercises.last.sets.single.weightKg, 60);
    expect(result.sessions.last.exercises.single.sets.single.weightKg, 100);
  });
}
