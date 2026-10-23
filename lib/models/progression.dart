enum ProgressKind { manual, linear, double, volume, amrap }

class ProgressRule {
  const ProgressRule({
    this.kind = ProgressKind.linear,
    this.low = 8,
    this.high = 12,
    this.sets = 3,
    this.maxSets = 5,
    this.fails = 3,
    this.deloadPct = 10,
  });

  final ProgressKind kind;
  final int low;
  final int high;
  final int sets;
  final int maxSets;
  final int fails;
  final int deloadPct;

  bool get usesRange => kind == ProgressKind.double || kind == ProgressKind.volume;

  ProgressRule copyWith({
    ProgressKind? kind,
    int? low,
    int? high,
    int? sets,
    int? maxSets,
    int? fails,
    int? deloadPct,
  }) {
    final lo = (low ?? this.low).clamp(1, 50);
    final hi = (high ?? this.high).clamp(lo + 1, 60);
    final base = (sets ?? this.sets).clamp(1, 10);
    return ProgressRule(
      kind: kind ?? this.kind,
      low: lo,
      high: hi,
      sets: base,
      maxSets: (maxSets ?? this.maxSets).clamp(base + 1, 12),
      fails: (fails ?? this.fails).clamp(1, 6),
      deloadPct: (deloadPct ?? this.deloadPct).clamp(5, 30),
    );
  }

  Map<String, dynamic> toJson() => {
        'k': kind.index,
        'lo': low,
        'hi': high,
        's': sets,
        'ms': maxSets,
        'f': fails,
        'd': deloadPct,
      };

  factory ProgressRule.fromJson(Map<String, dynamic> j) {
    final k = (j['k'] as num?)?.toInt() ?? 1;
    return const ProgressRule().copyWith(
      kind: ProgressKind.values[k.clamp(0, ProgressKind.values.length - 1)],
      low: (j['lo'] as num?)?.toInt(),
      high: (j['hi'] as num?)?.toInt(),
      sets: (j['s'] as num?)?.toInt(),
      maxSets: (j['ms'] as num?)?.toInt(),
      fails: (j['f'] as num?)?.toInt(),
      deloadPct: (j['d'] as num?)?.toInt(),
    );
  }
}

enum NextMove { up, reps, addSet, hold, deload }
