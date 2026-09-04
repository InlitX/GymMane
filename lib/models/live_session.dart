import 'workout.dart';

class SessionSet {
  SessionSet(this.reps, this.weight, this.done, {this.kind = SetKind.normal});
  int reps;
  double weight;
  bool done;
  SetKind kind;

  bool get counts => kind != SetKind.warmup;

  Map<String, dynamic> toJson() => {
        'r': reps,
        'w': weight,
        'd': done,
        if (kind != SetKind.normal) 'k': kind.index,
      };
  factory SessionSet.fromJson(Map<String, dynamic> j) => SessionSet(
        (j['r'] as num).toInt(),
        (j['w'] as num).toDouble(),
        j['d'] as bool? ?? false,
        kind: setKindFrom(j['k']),
      );
}

class SessionExercise {
  SessionExercise(this.id, this.name, this.primary, this.sets);
  final String id;
  final String name;
  final String primary;
  final List<SessionSet> sets;

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'p': primary,
        's': sets.map((s) => s.toJson()).toList(),
      };
  factory SessionExercise.fromJson(Map<String, dynamic> j) => SessionExercise(
        j['id'] as String,
        j['n'] as String,
        j['p'] as String,
        (j['s'] as List).map((e) => SessionSet.fromJson((e as Map).cast<String, dynamic>())).toList(),
      );
}

class WorkoutSession {
  WorkoutSession();

  List<SessionExercise> exercises = [];
  int currentIndex = 0;
  bool complete = false;
  DateTime? loggedAt;
  int? restRemaining;
  int? summaryVolume;
  int? summarySets;
  int? summaryDuration;

  Map<String, dynamic> toJson() => {
        'ex': exercises.map((e) => e.toJson()).toList(),
        'i': currentIndex,
        'c': complete,
        'at': loggedAt?.toIso8601String(),
        'sv': summaryVolume,
        'ss': summarySets,
        'sd': summaryDuration,
      };

  factory WorkoutSession.fromJson(Map<String, dynamic> j) => WorkoutSession()
    ..exercises =
        (j['ex'] as List).map((e) => SessionExercise.fromJson((e as Map).cast<String, dynamic>())).toList()
    ..currentIndex = (j['i'] as num?)?.toInt() ?? 0
    ..complete = j['c'] as bool? ?? false
    ..loggedAt = DateTime.tryParse((j['at'] as String?) ?? '')
    ..summaryVolume = (j['sv'] as num?)?.toInt()
    ..summarySets = (j['ss'] as num?)?.toInt()
    ..summaryDuration = (j['sd'] as num?)?.toInt();
}
