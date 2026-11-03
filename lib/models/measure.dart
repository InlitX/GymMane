const List<String> kMeasureKeys = [
  'neck',
  'shoulders',
  'chest',
  'arm',
  'forearm',
  'waist',
  'hips',
  'thigh',
  'calf',
  'bodyfat',
];

class BodyMeasure {
  const BodyMeasure(this.date, this.key, this.value);

  final DateTime date;
  final String key;
  final double value;

  Map<String, dynamic> toJson() => {'d': date.toIso8601String(), 'k': key, 'v': value};

  factory BodyMeasure.fromJson(Map<String, dynamic> j) => BodyMeasure(
        DateTime.tryParse((j['d'] ?? '') as String) ?? DateTime.now(),
        (j['k'] ?? '') as String,
        ((j['v'] ?? 0) as num).toDouble(),
      );
}

class CustomMeasure {
  CustomMeasure(this.id, this.name, {this.unit = '', this.length = true});

  final String id;
  String name;
  String unit;
  bool length;

  Map<String, dynamic> toJson() => {'id': id, 'n': name, if (unit.isNotEmpty) 'u': unit, if (!length) 'l': false};

  static CustomMeasure? fromJson(Map<String, dynamic> j) {
    final id = j['id'] as String? ?? '';
    final name = (j['n'] as String? ?? '').trim();
    if (!id.startsWith('c') || name.isEmpty) return null;
    return CustomMeasure(id, name, unit: j['u'] as String? ?? '', length: j['l'] as bool? ?? true);
  }
}
