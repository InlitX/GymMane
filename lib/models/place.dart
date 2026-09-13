class GymPlace {
  const GymPlace({
    required this.id,
    required this.name,
    required this.equipment,
    this.plates = const {},
    this.bar,
  });

  final String id;
  final String name;
  final Set<String> equipment;
  final Map<double, int> plates;
  final double? bar;

  GymPlace copyWith({
    String? name,
    Set<String>? equipment,
    Map<double, int>? plates,
    double? bar,
    bool clearBar = false,
  }) =>
      GymPlace(
        id: id,
        name: name ?? this.name,
        equipment: equipment ?? this.equipment,
        plates: plates ?? this.plates,
        bar: clearBar ? null : (bar ?? this.bar),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'e': equipment.toList(),
        if (plates.isNotEmpty) 'p': plates.map((k, v) => MapEntry(k.toString(), v)),
        if (bar != null) 'b': bar,
      };

  factory GymPlace.fromJson(Map<String, dynamic> j) => GymPlace(
        id: (j['id'] ?? '') as String,
        name: (j['n'] ?? '') as String,
        equipment: ((j['e'] as List?) ?? const []).cast<String>().toSet(),
        plates: ((j['p'] as Map?) ?? const {})
            .map((k, v) => MapEntry(double.parse(k as String), (v as num).toInt())),
        bar: (j['b'] as num?)?.toDouble(),
      );
}
