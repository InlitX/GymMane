class GymPlace {
  const GymPlace({required this.id, required this.name, required this.equipment});

  final String id;
  final String name;
  final Set<String> equipment;

  GymPlace copyWith({String? name, Set<String>? equipment}) => GymPlace(
        id: id,
        name: name ?? this.name,
        equipment: equipment ?? this.equipment,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'e': equipment.toList(),
      };

  factory GymPlace.fromJson(Map<String, dynamic> j) => GymPlace(
        id: (j['id'] ?? '') as String,
        name: (j['n'] ?? '') as String,
        equipment: ((j['e'] as List?) ?? const []).cast<String>().toSet(),
      );
}
