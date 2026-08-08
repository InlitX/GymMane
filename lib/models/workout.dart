class LoggedSet {
  LoggedSet(this.reps, this.weight);
  final int reps;
  final double weight;
  double get volume => reps * weight;

  double get oneRm => weight * (1 + reps / 30);

  Map<String, dynamic> toJson() => {'r': reps, 'w': weight};
  factory LoggedSet.fromJson(Map<String, dynamic> j) =>
      LoggedSet((j['r'] as num).toInt(), (j['w'] as num).toDouble());
}

class LoggedExercise {
  LoggedExercise(this.id, this.name, this.primary, this.sets);
  final String id;
  final String name;
  final String primary;
  final List<LoggedSet> sets;

  double get volume => sets.fold(0.0, (s, x) => s + x.volume);
  double get topWeight => sets.isEmpty ? 0 : sets.map((s) => s.weight).reduce((a, b) => a > b ? a : b);
  double get bestOneRm => sets.isEmpty ? 0 : sets.map((s) => s.oneRm).reduce((a, b) => a > b ? a : b);

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
  int get setCount => exercises.fold(0, (s, e) => s + e.sets.length);

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

class ExerciseNote {
  ExerciseNote(this.date, this.text);
  final DateTime date;
  final String text;

  Map<String, dynamic> toJson() => {'d': date.toIso8601String(), 't': text};
  factory ExerciseNote.fromJson(Map<String, dynamic> j) =>
      ExerciseNote(DateTime.parse(j['d'] as String), j['t'] as String);
}

class Routine {
  Routine(this.id, this.name, this.exerciseIds);
  final String id;
  String name;
  final List<String> exerciseIds;

  Map<String, dynamic> toJson() => {'id': id, 'n': name, 'ex': exerciseIds};
  factory Routine.fromJson(Map<String, dynamic> j) => Routine(
        j['id'] as String,
        j['n'] as String,
        ((j['ex'] as List?) ?? []).cast<String>(),
      );
}
