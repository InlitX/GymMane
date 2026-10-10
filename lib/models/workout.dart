enum SetKind { normal, warmup, drop, failure, restPause }

SetKind setKindFrom(Object? raw) {
  final i = (raw as num?)?.toInt() ?? 0;
  return SetKind.values[i.clamp(0, SetKind.values.length - 1)];
}

const _rpeTable = [
  1.0, .978, .955, .939, .922, .907, .892, .878, .863, .85, .837, .824, .811, .799, .786, .774,
  .762, .751, .739, .723, .707, .694, .68, .667, .653, .64, .626, .613, .599, .586, .574,
];

double? rpePercent(int reps, double? rpe) {
  if (rpe == null || rpe < 6 || rpe > 10 || reps < 1 || reps > 12) return null;
  final i = (reps - 1) * 2 + ((10 - rpe) * 2).round();
  return i < _rpeTable.length ? _rpeTable[i] : null;
}

class LoggedSet {
  LoggedSet(this.reps, this.weight, {this.kind = SetKind.normal, this.rpe, this.sec, this.km});
  final int reps;
  final double weight;
  final SetKind kind;
  final double? rpe;
  final int? sec;
  final double? km;

  bool get counts => kind != SetKind.warmup;
  double get volume => reps * weight;

  double get oneRm {
    if (reps <= 0) return 0;
    final pct = rpePercent(reps, rpe);
    return pct == null ? weight * (1 + reps / 30) : weight / pct;
  }

  Map<String, dynamic> toJson() => {
        'r': reps,
        'w': weight,
        if (kind != SetKind.normal) 'k': kind.index,
        if (rpe != null) 'e': rpe,
        if (sec != null) 't': sec,
        if (km != null) 'km': km,
      };
  factory LoggedSet.fromJson(Map<String, dynamic> j) => LoggedSet(
        (j['r'] as num).toInt(),
        (j['w'] as num).toDouble(),
        kind: setKindFrom(j['k']),
        rpe: (j['e'] as num?)?.toDouble(),
        sec: (j['t'] as num?)?.toInt(),
        km: (j['km'] as num?)?.toDouble(),
      );
}

enum PrKind {
  weight,
  distance,
  time,
  reps;

  double score(LoggedSet s) => switch (this) {
        PrKind.weight => s.weight,
        PrKind.distance => s.km ?? 0,
        PrKind.time => (s.sec ?? 0).toDouble(),
        PrKind.reps => s.reps.toDouble(),
      };
}

typedef PersonalRecord = ({String id, String name, PrKind kind, double best, double oneRm});

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
  LoggedSession(this.date, this.durationSec, this.exercises, {this.routineId});
  final DateTime date;
  int durationSec;
  final List<LoggedExercise> exercises;
  final String? routineId;

  double get volume => exercises.fold(0.0, (s, e) => s + e.volume);
  int get setCount => exercises.fold(0, (s, e) => s + e.workingSets.length);

  Map<String, dynamic> toJson() => {
        'd': date.toIso8601String(),
        'dur': durationSec,
        'ex': exercises.map((e) => e.toJson()).toList(),
        if (routineId != null) 'r': routineId,
      };
  factory LoggedSession.fromJson(Map<String, dynamic> j) => LoggedSession(
        DateTime.parse(j['d'] as String),
        (j['dur'] as num?)?.toInt() ?? 0,
        (j['ex'] as List).map((e) => LoggedExercise.fromJson(e as Map<String, dynamic>)).toList(),
        routineId: j['r'] as String?,
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

class PlannedSet {
  const PlannedSet({this.reps, this.weightKg, this.kind = SetKind.normal, this.sec, this.km});
  final int? reps;
  final double? weightKg;
  final SetKind kind;
  final int? sec;
  final double? km;

  PlannedSet copyWith({
    int? reps,
    double? weightKg,
    SetKind? kind,
    int? sec,
    double? km,
    bool autoWeight = false,
  }) =>
      PlannedSet(
        reps: reps ?? this.reps,
        weightKg: autoWeight ? null : (weightKg ?? this.weightKg),
        kind: kind ?? this.kind,
        sec: sec ?? this.sec,
        km: km ?? this.km,
      );

  Map<String, dynamic> toJson() => {
        if (reps != null) 'r': reps,
        if (weightKg != null) 'w': weightKg,
        if (kind != SetKind.normal) 'k': kind.index,
        if (sec != null) 't': sec,
        if (km != null) 'km': km,
      };
  factory PlannedSet.fromJson(Map<String, dynamic> j) => PlannedSet(
        reps: (j['r'] as num?)?.toInt(),
        weightKg: (j['w'] as num?)?.toDouble(),
        kind: setKindFrom(j['k']),
        sec: (j['t'] as num?)?.toInt(),
        km: (j['km'] as num?)?.toDouble(),
      );
}

class Routine {
  Routine(this.id, this.name, this.exerciseIds,
      {Map<String, int>? sets,
      Set<String>? chained,
      Map<String, List<PlannedSet>>? plan,
      Map<String, int>? rest,
      this.group = '',
      this.color = -1})
      : sets = sets ?? {},
        chained = chained ?? {},
        plan = plan ?? {},
        rest = rest ?? {};
  final String id;
  String name;
  String group;
  int color;
  final List<String> exerciseIds;
  final Map<String, int> sets;
  final Set<String> chained;
  final Map<String, List<PlannedSet>> plan;
  final Map<String, int> rest;

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'ex': exerciseIds,
        if (rest.isNotEmpty) 'r': rest,
        if (sets.isNotEmpty) 's': sets,
        if (chained.isNotEmpty) 'c': chained.toList(),
        if (group.isNotEmpty) 'g': group,
        if (color >= 0) 'k': color,
        if (plan.isNotEmpty)
          'p': plan.map((k, v) => MapEntry(k, v.map((s) => s.toJson()).toList())),
      };
  factory Routine.fromJson(Map<String, dynamic> j) => Routine(
        j['id'] as String,
        j['n'] as String,
        ((j['ex'] as List?) ?? []).cast<String>(),
        sets: ((j['s'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, (v as num).toInt())),
        chained: ((j['c'] as List?) ?? const []).cast<String>().toSet(),
        plan: ((j['p'] as Map?) ?? const {}).map((k, v) => MapEntry(
              k as String,
              (v as List).map((s) => PlannedSet.fromJson((s as Map).cast<String, dynamic>())).toList(),
            )),
        rest: ((j['r'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, ((v as num).toInt()).clamp(0, 600))),
        group: (j['g'] as String?) ?? '',
        color: (j['k'] as num?)?.toInt() ?? -1,
      );
}
