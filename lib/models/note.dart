enum NoteKind { note, plan, done, pain }

class NoteLink {
  const NoteLink({required this.name, required this.url});

  final String name;
  final String url;

  Map<String, dynamic> toJson() => {'n': name, 'u': url};

  factory NoteLink.fromJson(Map<String, dynamic> j) =>
      NoteLink(name: (j['n'] ?? '') as String, url: (j['u'] ?? '') as String);

  static Uri? parse(String raw) {
    final text = raw.trim();
    if (text.isEmpty || text.contains(RegExp(r'\s'))) return null;
    final uri = Uri.tryParse(text.contains('://') ? text : 'https://$text');
    if (uri == null || !uri.hasAuthority || uri.host.isEmpty) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    return uri;
  }
}

class GymNote {
  const GymNote({
    required this.id,
    required this.exerciseId,
    required this.date,
    required this.kind,
    required this.text,
    this.media = const [],
    required this.createdAt,
    this.pinned = false,
    this.folder = '',
    this.links = const [],
  });

  final String id;
  final String exerciseId;
  final DateTime date;
  final NoteKind kind;
  final String text;
  final List<String> media;
  final DateTime createdAt;
  final bool pinned;
  final String folder;
  final List<NoteLink> links;

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
    bool? pinned,
    String? folder,
    List<NoteLink>? links,
  }) =>
      GymNote(
        id: id,
        exerciseId: exerciseId ?? this.exerciseId,
        date: date ?? this.date,
        kind: kind ?? this.kind,
        text: text ?? this.text,
        media: media ?? this.media,
        createdAt: createdAt,
        pinned: pinned ?? this.pinned,
        folder: folder ?? this.folder,
        links: links ?? this.links,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'x': exerciseId,
        'd': date.toIso8601String(),
        'k': kind.index,
        't': text,
        if (media.isNotEmpty) 'm': media,
        'c': createdAt.toIso8601String(),
        if (pinned) 'p': true,
        if (folder.isNotEmpty) 'f': folder,
        if (links.isNotEmpty) 'l': [for (final l in links) l.toJson()],
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
      pinned: j['p'] == true,
      folder: (j['f'] ?? '') as String,
      links: [
        for (final l in (j['l'] as List?) ?? const [])
          if (l is Map) NoteLink.fromJson(l.cast<String, dynamic>()),
      ],
    );
  }
}

class NoteFolder {
  NoteFolder({required this.id, required this.name, this.color = 0});

  final String id;
  String name;
  int color;

  Map<String, dynamic> toJson() => {'id': id, 'n': name, 'k': color};

  factory NoteFolder.fromJson(Map<String, dynamic> j) => NoteFolder(
        id: (j['id'] ?? '') as String,
        name: (j['n'] ?? '') as String,
        color: ((j['k'] ?? 0) as num).toInt(),
      );
}
