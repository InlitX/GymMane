import 'workout.dart';

class SessionSet {
  SessionSet(this.reps, this.weight, this.done,
      {this.kind = SetKind.normal, this.rpe, this.sec, this.km});
  int reps;
  double weight;
  bool done;
  SetKind kind;
  double? rpe;
  int? sec;
  double? km;

  bool get counts => kind != SetKind.warmup;

  LoggedSet get logged => LoggedSet(reps, weight, kind: kind, rpe: rpe, sec: sec, km: km);

  SessionSet copy({bool done = false}) =>
      SessionSet(reps, weight, done, kind: kind, rpe: rpe, sec: sec, km: km);

  Map<String, dynamic> toJson() => {
        'r': reps,
        'w': weight,
        'd': done,
        if (kind != SetKind.normal) 'k': kind.index,
        if (rpe != null) 'e': rpe,
        if (sec != null) 't': sec,
        if (km != null) 'km': km,
      };
  factory SessionSet.fromJson(Map<String, dynamic> j) => SessionSet(
        (j['r'] as num).toInt(),
        (j['w'] as num).toDouble(),
        j['d'] as bool? ?? false,
        kind: setKindFrom(j['k']),
        rpe: (j['e'] as num?)?.toDouble(),
        sec: (j['t'] as num?)?.toInt(),
        km: (j['km'] as num?)?.toDouble(),
      );
}

class SessionExercise {
  SessionExercise(this.id, this.name, this.primary, this.sets, {this.linkedNext = false, this.swappedFrom});
  final String id;
  final String name;
  final String primary;
  final List<SessionSet> sets;
  bool linkedNext;
  final String? swappedFrom;

  bool get hasUndone => sets.any((s) => !s.done);

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'p': primary,
        's': sets.map((s) => s.toJson()).toList(),
        if (linkedNext) 'l': true,
        if (swappedFrom != null) 'sw': swappedFrom,
      };
  factory SessionExercise.fromJson(Map<String, dynamic> j) => SessionExercise(
        j['id'] as String,
        j['n'] as String,
        j['p'] as String,
        (j['s'] as List).map((e) => SessionSet.fromJson((e as Map).cast<String, dynamic>())).toList(),
        linkedNext: j['l'] as bool? ?? false,
        swappedFrom: j['sw'] as String?,
      );
}

class WorkoutSession {
  WorkoutSession();

  List<SessionExercise> exercises = [];
  int currentIndex = 0;
  bool complete = false;
  bool manual = false;
  String? routineId;
  DateTime? loggedAt;
  DateTime? restEndsAt;
  int? restFrozen;
  int? summaryVolume;
  int? summarySets;
  int? summaryDuration;

  int? get restRemaining {
    final frozen = restFrozen;
    if (frozen != null) return frozen;
    final end = restEndsAt;
    if (end == null) return null;
    final left = end.difference(DateTime.now()).inMilliseconds;
    return left <= 0 ? null : (left / 1000).ceil();
  }

  void clearRest() {
    restEndsAt = null;
    restFrozen = null;
  }

  Map<String, dynamic> toJson() => {
        'ex': exercises.map((e) => e.toJson()).toList(),
        'i': currentIndex,
        'c': complete,
        if (manual) 'm': true,
        if (routineId != null) 'r': routineId,
        'at': loggedAt?.toIso8601String(),
        if (restEndsAt != null) 're': restEndsAt!.toIso8601String(),
        if (restFrozen != null) 'rf': restFrozen,
        'sv': summaryVolume,
        'ss': summarySets,
        'sd': summaryDuration,
      };

  factory WorkoutSession.fromJson(Map<String, dynamic> j) => WorkoutSession()
    ..exercises =
        (j['ex'] as List).map((e) => SessionExercise.fromJson((e as Map).cast<String, dynamic>())).toList()
    ..currentIndex = (j['i'] as num?)?.toInt() ?? 0
    ..complete = j['c'] as bool? ?? false
    ..manual = j['m'] as bool? ?? false
    ..routineId = j['r'] as String?
    ..loggedAt = DateTime.tryParse((j['at'] as String?) ?? '')
    ..restEndsAt = DateTime.tryParse((j['re'] as String?) ?? '')
    ..restFrozen = (j['rf'] as num?)?.toInt()
    ..summaryVolume = (j['sv'] as num?)?.toInt()
    ..summarySets = (j['ss'] as num?)?.toInt()
    ..summaryDuration = (j['sd'] as num?)?.toInt();
}
