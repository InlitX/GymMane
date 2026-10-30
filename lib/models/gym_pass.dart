enum PassFormat { qr, code128, ean13, ean8, upca, code39, itf, dataMatrix, pdf417, aztec }

PassFormat passFormatFrom(Object? raw) =>
    PassFormat.values.firstWhere((f) => f.name == raw, orElse: () => PassFormat.qr);

class GymPass {
  const GymPass({
    required this.id,
    required this.name,
    required this.code,
    this.format = PassFormat.qr,
    this.hue = 0,
    this.member = '',
  });

  final String id;
  final String name;
  final String code;
  final PassFormat format;
  final int hue;
  final String member;

  bool get square => const {PassFormat.qr, PassFormat.dataMatrix, PassFormat.aztec}.contains(format);

  GymPass copyWith({String? name, String? code, PassFormat? format, int? hue, String? member}) => GymPass(
        id: id,
        name: name ?? this.name,
        code: code ?? this.code,
        format: format ?? this.format,
        hue: hue ?? this.hue,
        member: member ?? this.member,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        'c': code,
        if (format != PassFormat.qr) 'f': format.name,
        if (hue != 0) 'h': hue,
        if (member.isNotEmpty) 'm': member,
      };

  factory GymPass.fromJson(Map<String, dynamic> j) => GymPass(
        id: (j['id'] ?? '') as String,
        name: (j['n'] ?? '') as String,
        code: (j['c'] ?? '') as String,
        format: passFormatFrom(j['f']),
        hue: (j['h'] as num?)?.toInt() ?? 0,
        member: (j['m'] ?? '') as String,
      );
}
