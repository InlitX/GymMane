const List<String> kPoses = ['front', 'side', 'back'];

class ProgressEntry {
  const ProgressEntry({
    required this.id,
    required this.date,
    this.shots = const {},
    this.weightKg,
    this.note = '',
  });

  final String id;
  final DateTime date;
  final Map<String, String> shots;
  final double? weightKg;
  final String note;

  bool get isEmpty => shots.isEmpty;

  List<String> get media => [
        for (final pose in kPoses)
          if ((shots[pose] ?? '').isNotEmpty) shots[pose]!,
      ];

  String? shot(String pose) {
    final name = shots[pose];
    return (name == null || name.isEmpty) ? null : name;
  }

  ProgressEntry copyWith({
    Map<String, String>? shots,
    double? weightKg,
    String? note,
    bool clearWeight = false,
  }) =>
      ProgressEntry(
        id: id,
        date: date,
        shots: shots ?? this.shots,
        weightKg: clearWeight ? null : (weightKg ?? this.weightKg),
        note: note ?? this.note,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'd': date.toIso8601String(),
        's': shots,
        if (weightKg != null) 'w': weightKg,
        if (note.isNotEmpty) 'n': note,
      };

  factory ProgressEntry.fromJson(Map<String, dynamic> j) => ProgressEntry(
        id: (j['id'] ?? '') as String,
        date: DateTime.tryParse((j['d'] ?? '') as String) ?? DateTime.now(),
        shots: {
          for (final e in ((j['s'] as Map?) ?? const {}).entries)
            if (kPoses.contains(e.key) && e.value is String && (e.value as String).isNotEmpty)
              e.key as String: e.value as String,
        },
        weightKg: (j['w'] as num?)?.toDouble(),
        note: (j['n'] ?? '') as String,
      );
}
