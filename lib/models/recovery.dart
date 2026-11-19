const List<String> kRecoveryKinds = ['sauna', 'cold', 'contrast', 'breath'];

const List<String> kHeatKinds = ['sauna', 'contrast'];

const List<String> kColdKinds = ['cold', 'contrast'];

class BreathPattern {
  const BreathPattern(this.id, this.inhale, this.hold, this.exhale, this.rest);

  final String id;
  final int inhale;
  final int hold;
  final int exhale;
  final int rest;

  int get cycle => inhale + hold + exhale + rest;

  List<(String, int)> get phases => [
        ('in', inhale),
        if (hold > 0) ('hold', hold),
        ('out', exhale),
        if (rest > 0) ('rest', rest),
      ];
}

const List<BreathPattern> kBreathPatterns = [
  BreathPattern('box', 4, 4, 4, 4),
  BreathPattern('relax', 4, 7, 8, 0),
  BreathPattern('even', 5, 0, 5, 0),
];

class RecoveryEntry {
  RecoveryEntry({
    required this.id,
    required this.kind,
    required this.date,
    required this.sec,
    this.coldSec = 0,
    this.tempC,
    this.coldTempC,
    this.rounds = 1,
    this.pattern,
    this.note = '',
    this.restSec = 0,
    this.feel,
    this.holds = const [],
  });

  final String id;
  final String kind;
  final DateTime date;
  final int sec;
  final int coldSec;
  final double? tempC;
  final double? coldTempC;
  final int rounds;
  final String? pattern;
  final String note;
  final int restSec;
  final int? feel;
  final List<int> holds;

  int get bestHold => holds.fold(0, (a, b) => a > b ? a : b);

  RecoveryEntry withFeel(int? value) => RecoveryEntry(
        id: id,
        kind: kind,
        date: date,
        sec: sec,
        coldSec: coldSec,
        tempC: tempC,
        coldTempC: coldTempC,
        rounds: rounds,
        pattern: pattern,
        note: note,
        restSec: restSec,
        feel: value,
        holds: holds,
      );

  int get heatSec => switch (kind) {
        'sauna' => sec,
        'contrast' => sec,
        _ => 0,
      };

  int get coldTotalSec => switch (kind) {
        'cold' => sec,
        'contrast' => coldSec,
        _ => 0,
      };

  int get totalSec => kind == 'contrast' ? sec + coldSec : sec;

  Map<String, dynamic> toJson() => {
        'i': id,
        'k': kind,
        'd': date.toIso8601String(),
        's': sec,
        if (coldSec > 0) 'cs': coldSec,
        if (tempC != null) 't': tempC,
        if (coldTempC != null) 'ct': coldTempC,
        if (rounds != 1) 'r': rounds,
        if (pattern != null) 'p': pattern,
        if (note.isNotEmpty) 'n': note,
        if (restSec > 0) 'rs': restSec,
        if (feel != null) 'f': feel,
        if (holds.isNotEmpty) 'h': holds,
      };

  static RecoveryEntry? fromJson(Map<String, dynamic> j) {
    final kind = j['k'];
    final date = DateTime.tryParse(j['d'] as String? ?? '');
    if (kind is! String || !kRecoveryKinds.contains(kind) || date == null) return null;
    return RecoveryEntry(
      id: j['i'] as String? ?? 'r${date.microsecondsSinceEpoch}',
      kind: kind,
      date: date,
      sec: ((j['s'] as num?)?.toInt() ?? 0).clamp(0, 24 * 3600),
      coldSec: ((j['cs'] as num?)?.toInt() ?? 0).clamp(0, 24 * 3600),
      tempC: (j['t'] as num?)?.toDouble(),
      coldTempC: (j['ct'] as num?)?.toDouble(),
      rounds: ((j['r'] as num?)?.toInt() ?? 1).clamp(1, 20),
      pattern: j['p'] as String?,
      note: j['n'] as String? ?? '',
      restSec: ((j['rs'] as num?)?.toInt() ?? 0).clamp(0, 24 * 3600),
      feel: switch ((j['f'] as num?)?.toInt()) {
        final int f when f >= 1 && f <= 5 => f,
        _ => null,
      },
      holds: [for (final h in (j['h'] as List?) ?? const []) if (h is num) h.toInt().clamp(0, 3600)],
    );
  }
}

List<(String, int)> recoveryPlan(String kind, {required int heat, int cold = 0, int rest = 0, int rounds = 1}) => switch (kind) {
      'sauna' => [
          for (var r = 0; r < rounds; r++) ...[
            ('heat', heat),
            if (r < rounds - 1 && rest > 0) ('rest', rest),
          ],
        ],
      'contrast' => [
          for (var r = 0; r < rounds; r++) ...[('heat', heat), ('cold', cold)],
        ],
      _ => [('cold', heat)],
    };

({int index, int left, int into}) recoveryPhaseAt(List<(String, int)> plan, int elapsed) {
  var at = 0;
  for (var i = 0; i < plan.length; i++) {
    final len = plan[i].$2;
    if (elapsed < at + len) return (index: i, left: at + len - elapsed, into: elapsed - at);
    at += len;
  }
  return (index: plan.length, left: 0, into: elapsed - at);
}

({int heat, int cold, int rest, int rounds}) recoveryDone(List<(String, int)> plan, int elapsed) {
  var heat = 0, cold = 0, rest = 0, heats = 0, colds = 0, at = 0;
  for (final (kind, len) in plan) {
    final spent = (elapsed - at).clamp(0, len);
    at += len;
    if (spent <= 0) continue;
    switch (kind) {
      case 'heat':
        heat += spent;
        heats++;
      case 'cold':
        cold += spent;
        colds++;
      default:
        rest += spent;
    }
  }
  final total = plan.fold(0, (a, p) => a + p.$2);
  if (elapsed > total && plan.isNotEmpty) {
    final extra = elapsed - total;
    if (plan.last.$1 == 'cold') {
      cold += extra;
    } else {
      heat += extra;
    }
  }
  return (heat: heat, cold: cold, rest: rest, rounds: heats > colds ? heats : (colds > 0 ? colds : 1));
}
