enum SetKind { normal, warmup, drop, failure, restPause, cluster }

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
  LoggedSet(this.reps, this.weight,
      {this.kind = SetKind.normal, this.rpe, this.sec, this.km, this.note = '', this.left, this.right});
  final int reps;
  final int? left;
  final int? right;
  final String note;
  final double weight;
  final SetKind kind;
  final double? rpe;
  final int? sec;
  final double? km;

  bool get counts => kind != SetKind.warmup;
  bool get sided => left != null && right != null;
  double? get rir => rpe == null ? null : 10 - rpe!;
  double get volume => counts ? reps * weight : 0;

  double get oneRm {
    if (!counts || reps <= 0) return 0;
    final pct = rpePercent(reps, rpe);
    return pct == null ? weight * (1 + reps / 30) : weight / pct;
  }

  Map<String, dynamic> toJson() => {
        'r': reps,
        'w': weight,
        if (sided) 'rl': left,
        if (sided) 'rr': right,
        if (kind != SetKind.normal) 'k': kind.index,
        if (rpe != null) 'e': rpe,
        if (sec != null) 't': sec,
        if (km != null) 'km': km,
        if (note.isNotEmpty) 'n': note,
      };
  factory LoggedSet.fromJson(Map<String, dynamic> j) => LoggedSet(
        (j['r'] as num).toInt(),
        (j['w'] as num).toDouble(),
        kind: setKindFrom(j['k']),
        rpe: (j['e'] as num?)?.toDouble(),
        sec: (j['t'] as num?)?.toInt(),
        km: (j['km'] as num?)?.toDouble(),
        note: j['n'] as String? ?? '',
        left: (j['rl'] as num?)?.toInt(),
        right: (j['rr'] as num?)?.toInt(),
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
  LoggedExercise(this.id, this.name, this.primary, this.sets, {this.incline, this.kcal});
  final String id;
  final String name;
  final String primary;
  final List<LoggedSet> sets;
  double? incline;
  int? kcal;

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
        if (incline != null) 'g': incline,
        if (kcal != null) 'kc': kcal,
      };
  factory LoggedExercise.fromJson(Map<String, dynamic> j) => LoggedExercise(
        j['id'] as String,
        j['n'] as String,
        j['p'] as String,
        (j['s'] as List).map((e) => LoggedSet.fromJson(e as Map<String, dynamic>)).toList(),
        incline: (j['g'] as num?)?.toDouble(),
        kcal: (j['kc'] as num?)?.toInt(),
      );
}

class LoggedSession {
  LoggedSession(this.date, this.durationSec, this.exercises, {this.routineId, this.name, this.hrAvg, this.hrMax, this.sleep, this.energy, this.deload = false});
  final DateTime date;
  int durationSec;
  final List<LoggedExercise> exercises;
  final String? routineId;
  String? name;
  int? hrAvg;
  int? hrMax;
  int? sleep;
  int? energy;
  final bool deload;

  DateTime get day => date.subtract(Duration(seconds: durationSec));
  double get volume => exercises.fold(0.0, (s, e) => s + e.volume);
  int get setCount => exercises.fold(0, (s, e) => s + e.workingSets.length);

  Map<String, dynamic> toJson() => {
        'd': date.toIso8601String(),
        'dur': durationSec,
        'ex': exercises.map((e) => e.toJson()).toList(),
        if (routineId != null) 'r': routineId,
        if (name != null) 'n': name,
        if (hrAvg != null) 'hra': hrAvg,
        if (hrMax != null) 'hrm': hrMax,
        if (sleep != null) 'sl': sleep,
        if (energy != null) 'en': energy,
        if (deload) 'dl': true,
      };
  factory LoggedSession.fromJson(Map<String, dynamic> j) => LoggedSession(
        DateTime.parse(j['d'] as String),
        (j['dur'] as num?)?.toInt() ?? 0,
        (j['ex'] as List).map((e) => LoggedExercise.fromJson(e as Map<String, dynamic>)).toList(),
        routineId: j['r'] as String?,
        name: j['n'] as String?,
        hrAvg: (j['hra'] as num?)?.toInt(),
        hrMax: (j['hrm'] as num?)?.toInt(),
        sleep: (j['sl'] as num?)?.toInt().clamp(1, 5),
        energy: (j['en'] as num?)?.toInt().clamp(1, 5),
        deload: j['dl'] == true,
      );
}

class BodyweightEntry {
  BodyweightEntry(this.date, this.kg, {this.note = ''});
  final DateTime date;
  final double kg;
  final String note;

  Map<String, dynamic> toJson() => {'d': date.toIso8601String(), 'kg': kg, if (note.isNotEmpty) 'n': note};
  factory BodyweightEntry.fromJson(Map<String, dynamic> j) => BodyweightEntry(
      DateTime.parse(j['d'] as String), (j['kg'] as num).toDouble(),
      note: j['n'] as String? ?? '');
}

class PlannedSet {
  const PlannedSet({this.reps, this.repsMax, this.weightKg, this.kind = SetKind.normal, this.sec, this.km});
  final int? reps;
  final int? repsMax;

  String? get repsLabel => reps == null ? null : (repsMax != null && repsMax! > reps! ? '$reps-$repsMax' : '$reps');
  final double? weightKg;
  final SetKind kind;
  final int? sec;
  final double? km;

  PlannedSet copyWith({
    int? reps,
    int? repsMax,
    bool clearRange = false,
    double? weightKg,
    SetKind? kind,
    int? sec,
    double? km,
    bool autoWeight = false,
  }) =>
      PlannedSet(
        reps: reps ?? this.reps,
        repsMax: clearRange ? null : (repsMax ?? this.repsMax),
        weightKg: autoWeight ? null : (weightKg ?? this.weightKg),
        kind: kind ?? this.kind,
        sec: sec ?? this.sec,
        km: km ?? this.km,
      );

  Map<String, dynamic> toJson() => {
        if (reps != null) 'r': reps,
        if (repsMax != null) 'rm': repsMax,
        if (weightKg != null) 'w': weightKg,
        if (kind != SetKind.normal) 'k': kind.index,
        if (sec != null) 't': sec,
        if (km != null) 'km': km,
      };
  factory PlannedSet.fromJson(Map<String, dynamic> j) => PlannedSet(
        reps: (j['r'] as num?)?.toInt(),
        repsMax: (j['rm'] as num?)?.toInt(),
        weightKg: (j['w'] as num?)?.toDouble(),
        kind: setKindFrom(j['k']),
        sec: (j['t'] as num?)?.toInt(),
        km: (j['km'] as num?)?.toDouble(),
      );
}

class SavedPlan {
  SavedPlan(this.id, this.name, this.week, this.extras, {this.multi = false});
  final String id;
  String name;
  final Map<int, String> week;
  final Map<int, List<String>> extras;
  final bool multi;

  bool uses(String routineId) => week.containsValue(routineId) || extras.values.any((ids) => ids.contains(routineId));

  void drop(String routineId) {
    week.removeWhere((_, v) => v == routineId);
    for (final ids in extras.values) {
      ids.remove(routineId);
    }
    for (final day in [...extras.keys]) {
      final ids = extras[day]!;
      if (week[day] == null && ids.isNotEmpty) week[day] = ids.removeAt(0);
      if (ids.isEmpty) extras.remove(day);
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'w': week.map((k, v) => MapEntry('$k', v)),
        if (extras.isNotEmpty) 'x': extras.map((k, v) => MapEntry('$k', v)),
        if (multi) 'm': true,
      };
  factory SavedPlan.fromJson(Map<String, dynamic> j) => SavedPlan(
        j['id'] as String,
        j['n'] as String? ?? '',
        ((j['w'] as Map?) ?? const {}).map((k, v) => MapEntry(int.parse(k as String), v as String)),
        ((j['x'] as Map?) ?? const {})
            .map((k, v) => MapEntry(int.parse(k as String), (v as List).cast<String>().toList())),
        multi: j['m'] as bool? ?? false,
      );
}

class Routine {
  Routine(this.id, this.name, this.exerciseIds,
      {Map<String, int>? sets,
      Set<String>? chained,
      Map<String, List<PlannedSet>>? plan,
      Map<String, int>? rest,
      List<List<String>>? ladders,
      Map<String, List<String>>? alts,
      this.group = '',
      this.color = -1,
      this.archived = false})
      : sets = sets ?? {},
        chained = chained ?? {},
        plan = plan ?? {},
        rest = rest ?? {},
        ladders = ladders ?? [],
        alts = alts ?? {};
  final String id;
  String name;
  String group;
  int color;
  bool archived;
  final List<String> exerciseIds;
  final Map<String, int> sets;
  final Set<String> chained;
  final Map<String, List<PlannedSet>> plan;
  final Map<String, int> rest;
  final List<List<String>> ladders;
  final Map<String, List<String>> alts;

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        if (ladders.isNotEmpty) 'lad': ladders,
        if (alts.isNotEmpty) 'alt': alts,
        'ex': exerciseIds,
        if (rest.isNotEmpty) 'r': rest,
        if (sets.isNotEmpty) 's': sets,
        if (chained.isNotEmpty) 'c': chained.toList(),
        if (group.isNotEmpty) 'g': group,
        if (color >= 0) 'k': color,
        if (archived) 'a': true,
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
        ladders: [
          for (final l in (j['lad'] as List?) ?? const [])
            if (l is List && l.length > 1) l.cast<String>().toList(),
        ],
        alts: {
          for (final e in ((j['alt'] as Map?) ?? const {}).entries)
            if (e.value is List && (e.value as List).isNotEmpty) e.key as String: (e.value as List).cast<String>().toList(),
        },
        group: (j['g'] as String?) ?? '',
        color: (j['k'] as num?)?.toInt() ?? -1,
        archived: j['a'] == true,
      );
}

class MonthRecap {
  const MonthRecap({
    required this.month,
    required this.workouts,
    required this.days,
    required this.seconds,
    required this.longest,
    required this.sets,
    required this.volumeKg,
    required this.topExercise,
    required this.topExerciseKg,
    required this.heat,
    required this.topMuscle,
    required this.topMuscleSets,
    required this.records,
    required this.favDay,
    required this.usualStart,
    required this.weekdays,
    required this.lift,
    required this.sessionMinutes,
    required this.topLifts,
    required this.exerciseIds,
  });

  final DateTime month;
  final int workouts;
  final Set<int> days;
  final int seconds;
  final LoggedSession? longest;
  final int sets;
  final double volumeKg;
  final String? topExercise;
  final double topExerciseKg;
  final Map<String, double> heat;
  final String? topMuscle;
  final int topMuscleSets;
  final List<({String id, double kg})> records;
  final int? favDay;
  final int? usualStart;
  final List<int> weekdays;
  final ({String id, int sets, int times, double bestKg, double volumeKg})? lift;
  final List<int> sessionMinutes;
  final List<({String id, int sets})> topLifts;
  final List<String> exerciseIds;

  int get avgMinutes => workouts == 0 ? 0 : seconds ~/ 60 ~/ workouts;

  bool get empty => workouts == 0;
}
