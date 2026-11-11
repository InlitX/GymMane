import 'package:sync/sync.dart';
import 'package:test/test.dart';

void main() {
  test('keeps workouts from both sides and the newer settings', () {
    final phone = {
      'units': 'kg',
      'sessions': [
        {'d': '2026-11-01T10:00:00.000', 'dur': 60},
        {'d': '2026-11-03T10:00:00.000', 'dur': 50},
      ],
      'routines': [
        {'id': 'a', 'n': 'Push'},
      ],
      'live': {'ex': 1},
    };
    final web = {
      'units': 'lb',
      'sessions': [
        {'d': '2026-11-01T10:00:00.000', 'dur': 61},
        {'d': '2026-11-02T10:00:00.000', 'dur': 40},
      ],
      'routines': [
        {'id': 'a', 'n': 'Push day'},
        {'id': 'b', 'n': 'Pull'},
      ],
      'live': {'ex': 9},
      'noteMedia': {'x.jpg': 'notes/x.jpg'},
    };
    final m = mergeStates(phone, web, incomingNewer: true);
    expect(m['units'], 'lb');
    expect([for (final s in m['sessions'] as List) (s as Map)['d']],
        ['2026-11-01T10:00:00.000', '2026-11-02T10:00:00.000', '2026-11-03T10:00:00.000']);
    expect(((m['sessions'] as List).first as Map)['dur'], 61);
    expect([for (final r in m['routines'] as List) (r as Map)['n']], ['Push day', 'Pull']);
    expect(m['live'], {'ex': 1});
    expect(m.containsKey('noteMedia'), isFalse);
  });

  test('merging twice changes nothing', () {
    final a = {
      'notes': [
        {'id': '1', 't': 'a'},
      ],
      'checkins': ['x'],
    };
    final b = {
      'notes': [
        {'id': '2', 't': 'b'},
      ],
      'checkins': ['y'],
    };
    final once = mergeStates(a, b, incomingNewer: false);
    final twice = mergeStates(once, b, incomingNewer: false);
    expect(sameState(once, twice), isTrue);
    expect(once['checkins'], ['x', 'y']);
  });

  test('reads sync file names and skips its own', () {
    final at = DateTime.utc(2026, 11, 11, 9, 5, 7);
    final name = syncName('server', at);
    expect(name, 'gymmane-auto-server-2026-11-11-090507.zip');
    expect(SyncFile.parse(name)!.at, at);
    expect(SyncFile.parse('gymmane-auto-2026-11-11-090507.zip'), isNull);
    final newest = newestByDevice([
      syncName('phone', at),
      syncName('phone', at.add(const Duration(hours: 1))),
      syncName('server', at),
    ], self: 'server');
    expect(newest.keys, ['phone']);
    expect(newest['phone']!.at, at.add(const Duration(hours: 1)));
  });

  test('renames media references', () {
    final out = renameStrings({
      'notes': [
        {'m': ['old.jpg']},
      ],
    }, {'old.jpg': 'new.jpg'});
    expect(stringsIn(out), contains('new.jpg'));
  });
}
