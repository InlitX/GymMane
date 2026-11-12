import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';

LoggedSession _session(DateTime date, String name, List<LoggedSet> sets) =>
    LoggedSession(date, 1800, [LoggedExercise('x1', name, 'chest', sets)]);

void main() {
  final store = Store.instance;

  test('csv has a header and one row per set', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 7, 14), 'Barbell Bench Press', [
        LoggedSet(10, 60),
        LoggedSet(8, 70),
      ]),
    ]);
    final lines = csv.trim().split('\n');
    expect(lines.first,
        'date,exercise,muscle,set,reps,weight_kg,volume_kg,est_1rm_kg,distance_km,duration_s,set_type,rpe,rir,note');
    expect(lines.length, 3);
    expect(lines[1], startsWith('2026-07-14,Barbell Bench Press,chest,1,10,60,600,'));
    expect(lines[2], contains(',2,8,70,560,'));
  });

  test('a name with a comma does not shift the columns', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 7, 14), 'Chest Dip, Assisted', [LoggedSet(5, 20)]),
    ]);
    final row = csv.trim().split('\n')[1];
    expect(row, contains('"Chest Dip, Assisted"'));

    expect(row.replaceAll(RegExp('"[^"]*"'), 'X').split(',').length, 14);
  });

  test('a name with quotes is escaped, not mangled', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 7, 14), 'The "good" morning', [LoggedSet(5, 20)]),
    ]);
    expect(csv, contains('"The ""good"" morning"'));
  });

  test('weights keep halves but lose noise decimals', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 7, 14), 'Curl', [LoggedSet(10, 12.5), LoggedSet(10, 20)]),
    ]);
    expect(csv, contains(',10,12.5,125,'));
    expect(csv, contains(',10,20,200,'));
  });

  test('cardio and timed sets carry their distance and time', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 9, 18), 'Outdoor Run', [LoggedSet(0, 0, sec: 1800, km: 5.25)]),
      _session(DateTime(2026, 9, 18), 'Plank', [LoggedSet(0, 0, sec: 60)]),
    ]);
    expect(csv, contains(',0,0,0,0,5.25,1800'));
    expect(csv, contains(',0,0,0,0,,60'));
  });

  test('rows come out oldest first regardless of input order', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 7, 16), 'B', [LoggedSet(1, 1)]),
      _session(DateTime(2026, 7, 14), 'A', [LoggedSet(1, 1)]),
    ]);
    final lines = csv.trim().split('\n');
    expect(lines[1], startsWith('2026-07-14'));
    expect(lines[2], startsWith('2026-07-16'));
  });

  test('no sessions still yields a valid header-only file', () {
    expect(store.exportCsv([]).trim(),
        'date,exercise,muscle,set,reps,weight_kg,volume_kg,est_1rm_kg,distance_km,duration_s,set_type,rpe,rir,note');
  });

  test('a set note goes in the last column, escaped', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 11, 2), 'Squat', [LoggedSet(5, 100, note: 'knee, a bit sore'), LoggedSet(5, 100)]),
    ]);
    final lines = csv.trim().split('\n');
    expect(lines[1], endsWith(',"knee, a bit sore"'));
    expect(lines[2], endsWith(','));
  });

  test('warm-up 40 kg x 8 does not export est_1rm_kg and csv serializes set_type and rir', () {
    final csv = store.exportCsv([
      _session(DateTime(2026, 11, 10), 'Barbell Bench Press', [
        LoggedSet(8, 40, kind: SetKind.warmup, rpe: 7),
        LoggedSet(5, 80, rpe: 8.5),
      ]),
    ]);
    final lines = csv.trim().split('\n');
    expect(lines[1], '2026-11-10,Barbell Bench Press,chest,1,8,40,0,0,,,warmup,7,3,');
    expect(lines[2], '2026-11-10,Barbell Bench Press,chest,2,5,80,400,97.09,,,normal,8.5,1.5,');
  });
}
