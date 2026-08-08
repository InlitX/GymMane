import '../l10n/l10n.dart';

class Muscle {
  const Muscle(this.id, this.label, this.view);
  final String id;
  final String label;
  final String view;
}

class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.primary,
    required this.secondary,
    required this.equipment,
    required this.difficulty,
    required this.gif,
    required this.steps,
    this.media = '',
  });
  final String id;
  final String name;
  final String primary;
  final List<String> secondary;
  final String equipment;
  final String difficulty;
  final String gif;
  final List<String> steps;
  final String media;

  Exercise copyWith({String? media}) => Exercise(
        id: id,
        name: name,
        primary: primary,
        secondary: secondary,
        equipment: equipment,
        difficulty: difficulty,
        gif: gif,
        steps: steps,
        media: media ?? this.media,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'p': primary,
        'e': equipment,
        'd': difficulty,
        if (media.isNotEmpty) 'm': media,
      };
  factory Exercise.fromJson(Map<String, dynamic> j) => Exercise(
        id: j['id'] as String,
        name: j['n'] as String,
        primary: j['p'] as String,
        secondary: const [],
        equipment: (j['e'] as String?) ?? 'Other',
        difficulty: (j['d'] as String?) ?? 'Beginner',
        gif: '',
        steps: const [],
        media: (j['m'] as String?) ?? '',
      );
}

class ToolMeta {
  const ToolMeta(this.id, this.name, this.desc);
  final String id;
  final String name;
  final String desc;
}

const List<Muscle> kMuscles = [
  Muscle('chest', 'Chest', 'front'),
  Muscle('shoulders', 'Shoulders', 'front'),
  Muscle('biceps', 'Biceps', 'front'),
  Muscle('abdomen', 'Abdomen', 'front'),
  Muscle('obliques', 'Obliques', 'front'),
  Muscle('quads', 'Quads', 'front'),
  Muscle('forearm', 'Forearm', 'front'),
  Muscle('trapezius', 'Trapezius', 'back'),
  Muscle('back', 'Back', 'back'),
  Muscle('triceps', 'Triceps', 'back'),
  Muscle('glutes', 'Glutes', 'back'),
  Muscle('hamstrings', 'Hamstrings', 'back'),
  Muscle('calves', 'Calves', 'back'),
];

String muscleLabel(String id) => t.muscle(id);

String exerciseName(Exercise e) => t.catalogName(e.id, e.name);

List<String> exerciseSteps(Exercise e) => t.catalogSteps(e.id, e.steps);

String muscleGroup(String muscleId) {
  switch (muscleId) {
    case 'chest':
      return 'Chest';
    case 'back':
    case 'trapezius':
      return 'Back';
    case 'quads':
    case 'hamstrings':
    case 'glutes':
    case 'calves':
      return 'Legs';
    case 'shoulders':
      return 'Shoulders';
    case 'biceps':
    case 'triceps':
    case 'forearm':
      return 'Arms';
    case 'abdomen':
    case 'obliques':
      return 'Core';
    default:
      return muscleLabel(muscleId);
  }
}

String muscleFamily(String muscleId) {
  switch (muscleId) {
    case 'chest':
    case 'shoulders':
    case 'triceps':
      return 'push';
    case 'back':
    case 'trapezius':
    case 'biceps':
    case 'forearm':
      return 'pull';
    case 'quads':
    case 'hamstrings':
    case 'glutes':
    case 'calves':
      return 'legs';
    default:
      return 'core';
  }
}
