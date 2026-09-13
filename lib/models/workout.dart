enum SetKind { normal, warmup, drop, failure }

SetKind setKindFrom(Object? raw) {
  final i = (raw as num?)?.toInt() ?? 0;
  return SetKind.values[i.clamp(0, SetKind.values.length - 1)];
}

class LoggedSet {
  LoggedSet(this.reps, this.weight, {this.kind = SetKind.normal, this.rpe});
  final int reps;
  final double weight;
  final SetKind kind;
  final double? rpe;

  bool get counts => kind != SetKind.warmup;
  double get volume => reps * weight;

  double get oneRm => weight * (1 + reps / 30);

  Map<String, dynamic> toJson() => {
        'r': reps,
        'w': weight,
        if (kind != SetKind.normal) 'k': kind.index,
        if (rpe != null) 'e': rpe,
      };
  factory LoggedSet.fromJson(Map<String, dynamic> j) => LoggedSet(
        (j['r'] as num).toInt(),
        (j['w'] as num).toDouble(),
        kind: setKindFrom(j['k']),
        rpe: (j['e'] as num?)?.toDouble(),
      );
}

class LoggedExercise {
  LoggedExercise(this.id, this.name, this.primary, this.sets);
  final String id;
  final String name;
  final String primary;
  final List<LoggedSet> sets;

  List<LoggedSet> get workingSets => sets.where((s) => s.counts).toList();

  double get volume => workingSets.fold(0.0, (s, x) => s + x.volume);
  double get topWeight {
    final w = workingSets;
    return w.isEmpty ? 0 : w.map((s) => s.weight).reduce((a, b) => a > b ? a : b);
  }

  double get bestOneRm {
    final w = workingSets;
    return w.isEmpty ? 0 : w.map((s) => s.oneRm).reduce((a, b) => a > b ? a : b);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'p': primary,
        's': sets.map((s) => s.toJson()).toList(),
      };
  factory LoggedExercise.fromJson(Map<String, dynamic> j) => LoggedExercise(
        j['id'] as String,
        j['n'] as String,
        j['p'] as String,
        (j['s'] as List).map((e) => LoggedSet.fromJson(e as Map<String, dynamic>)).toList(),
      );
}

class LoggedSession {
  LoggedSession(this.date, this.durationSec, this.exercises);
  final DateTime date;
  final int durationSec;
  final List<LoggedExercise> exercises;

  double get volume => exercises.fold(0.0, (s, e) => s + e.volume);
  int get setCount => exercises.fold(0, (s, e) => s + e.workingSets.length);

  Map<String, dynamic> toJson() => {
        'd': date.toIso8601String(),
        'dur': durationSec,
        'ex': exercises.map((e) => e.toJson()).toList(),
      };
  factory LoggedSession.fromJson(Map<String, dynamic> j) => LoggedSession(
        DateTime.parse(j['d'] as String),
        (j['dur'] as num?)?.toInt() ?? 0,
        (j['ex'] as List).map((e) => LoggedExercise.fromJson(e as Map<String, dynamic>)).toList(),
      );
}

class BodyweightEntry {
  BodyweightEntry(this.date, this.kg);
  final DateTime date;
  final double kg;

  Map<String, dynamic> toJson() => {'d': date.toIso8601String(), 'kg': kg};
  factory BodyweightEntry.fromJson(Map<String, dynamic> j) =>
      BodyweightEntry(DateTime.parse(j['d'] as String), (j['kg'] as num).toDouble());
}

class Routine {
  Routine(this.id, this.name, this.exerciseIds,
      {Map<String, int>? sets, Set<String>? chained, this.group = ''})
      : sets = sets ?? {},
        chained = chained ?? {};
  final String id;
  String name;
  String group;
  final List<String> exerciseIds;
  final Map<String, int> sets;
  final Set<String> chained;

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'ex': exerciseIds,
        if (sets.isNotEmpty) 's': sets,
        if (chained.isNotEmpty) 'c': chained.toList(),
        if (group.isNotEmpty) 'g': group,
      };
  factory Routine.fromJson(Map<String, dynamic> j) => Routine(
        j['id'] as String,
        j['n'] as String,
        ((j['ex'] as List?) ?? []).cast<String>(),
        sets: ((j['s'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, (v as num).toInt())),
        chained: ((j['c'] as List?) ?? const []).cast<String>().toSet(),
        group: (j['g'] as String?) ?? '',
      );
}
