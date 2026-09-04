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
