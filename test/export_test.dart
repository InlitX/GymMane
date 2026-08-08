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
    expect(lines.first, 'date,exercise,muscle,set,reps,weight_kg,volume_kg,est_1rm_kg');
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

    expect(row.replaceAll(RegExp('"[^"]*"'), 'X').split(',').length, 8);
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
        'date,exercise,muscle,set,reps,weight_kg,volume_kg,est_1rm_kg');
  });
}
