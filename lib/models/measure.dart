const List<String> kMeasureKeys = [
  'neck',
  'shoulders',
  'chest',
  'arm',
  'forearm',
  'waist',
  'abdomen',
  'hips',
  'thigh',
  'calf',
  'bodyfat',
  'bp',
];

const Set<String> kSidedMeasureKeys = {'arm', 'forearm', 'thigh', 'calf'};

class BodyMeasure {
  const BodyMeasure(this.date, this.key, this.value, {this.note = '', this.left, this.right, this.low, this.pulse});

  final DateTime date;
  final String key;
  final double value;
  final String note;
  final double? left;
  final double? right;
  final double? low;
  final int? pulse;

  bool get sided => left != null && right != null;

  Map<String, dynamic> toJson() => {
        'd': date.toIso8601String(),
        'k': key,
        'v': value,
        if (note.isNotEmpty) 'n': note,
        if (left != null) 'l': left,
        if (right != null) 'r': right,
        if (low != null) 'lo': low,
        if (pulse != null) 'p': pulse,
      };

  factory BodyMeasure.fromJson(Map<String, dynamic> j) => BodyMeasure(
        DateTime.tryParse((j['d'] ?? '') as String) ?? DateTime.now(),
        (j['k'] ?? '') as String,
        ((j['v'] ?? 0) as num).toDouble(),
        note: (j['n'] as String?) ?? '',
        left: (j['l'] as num?)?.toDouble(),
        right: (j['r'] as num?)?.toDouble(),
        low: (j['lo'] as num?)?.toDouble(),
        pulse: (j['p'] as num?)?.toInt(),
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
