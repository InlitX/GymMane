enum NoteKind { note, plan, done, pain }

class GymNote {
  const GymNote({
    required this.id,
    required this.exerciseId,
    required this.date,
    required this.kind,
    required this.text,
    this.media = const [],
    required this.createdAt,
  });

  final String id;
  final String exerciseId;
  final DateTime date;
  final NoteKind kind;
  final String text;
  final List<String> media;
  final DateTime createdAt;

  bool get isGeneral => exerciseId.isEmpty;

  String get title => text.trim().split('\n').first;

  String get body {
    final lines = text.trim().split('\n');
    return lines.length > 1 ? lines.sublist(1).join('\n').trim() : '';
  }

  GymNote copyWith({
    String? exerciseId,
    DateTime? date,
    NoteKind? kind,
    String? text,
    List<String>? media,
  }) =>
      GymNote(
        id: id,
        exerciseId: exerciseId ?? this.exerciseId,
        date: date ?? this.date,
        kind: kind ?? this.kind,
        text: text ?? this.text,
        media: media ?? this.media,
        createdAt: createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'x': exerciseId,
        'd': date.toIso8601String(),
        'k': kind.index,
        't': text,
        if (media.isNotEmpty) 'm': media,
        'c': createdAt.toIso8601String(),
      };

  factory GymNote.fromJson(Map<String, dynamic> j) {
    final created = DateTime.tryParse((j['c'] ?? '') as String) ?? DateTime.now();
    return GymNote(
      id: (j['id'] ?? '') as String,
      exerciseId: (j['x'] ?? '') as String,
      date: DateTime.tryParse((j['d'] ?? '') as String) ?? created,
      kind: NoteKind.values[((j['k'] ?? 0) as num).toInt().clamp(0, NoteKind.values.length - 1)],
      text: (j['t'] ?? '') as String,
      media: ((j['m'] as List?) ?? const []).cast<String>(),
      createdAt: created,
    );
  }
}
