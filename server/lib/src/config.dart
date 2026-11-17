import 'dart:io';

class Person {
  const Person(this.name, this.label, this.password);

  final String name;
  final String label;
  final String? password;

  String get display => label;

  static const _plain = {
    'á': 'a', 'à': 'a', 'â': 'a', 'ä': 'a', 'ã': 'a', 'å': 'a',
    'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
    'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
    'ó': 'o', 'ò': 'o', 'ô': 'o', 'ö': 'o', 'õ': 'o', 'ø': 'o',
    'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
    'ñ': 'n', 'ç': 'c', 'ß': 'ss', 'æ': 'ae', 'œ': 'oe',
  };

  static String slug(String label) {
    final out = StringBuffer();
    for (final ch in label.toLowerCase().split('')) {
      out.write(_plain[ch] ?? ch);
    }
    return out
        .toString()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }
}

class Config {
  Config({
    required this.port,
    required this.host,
    required this.dataDir,
    required this.webDir,
    required this.syncDir,
    required this.password,
    required this.keepDays,
    this.people = const [],
  });

  final int port;
  final String host;
  final String dataDir;
  final String webDir;
  final String? syncDir;
  final String? password;
  final int keepDays;
  final List<Person> people;

  factory Config.fromEnvironment([Map<String, String>? env]) {
    final e = env ?? Platform.environment;
    String? read(String key) {
      final v = e[key]?.trim();
      return v == null || v.isEmpty ? null : v;
    }

    final here = File(Platform.resolvedExecutable).parent.path;
    final data = read('GYMMANE_DATA') ?? '$here${Platform.pathSeparator}data';
    final sync = read('GYMMANE_SYNC');
    return Config(
      port: int.tryParse(read('GYMMANE_PORT') ?? read('PORT') ?? '') ?? 8080,
      host: read('GYMMANE_HOST') ?? '0.0.0.0',
      dataDir: data,
      webDir: read('GYMMANE_WEB') ?? '$here${Platform.pathSeparator}web',
      syncDir: sync == 'off' ? null : sync ?? '$data${Platform.pathSeparator}sync',
      password: read('GYMMANE_PASSWORD'),
      keepDays: int.tryParse(read('GYMMANE_KEEP_DAYS') ?? '') ?? 30,
      people: parsePeople(read('GYMMANE_PEOPLE')),
    );
  }

  static List<Person> parsePeople(String? text) {
    if (text == null) return const [];
    var raw = text.trim();
    if (raw.length >= 2 && (raw[0] == '"' || raw[0] == "'") && raw[raw.length - 1] == raw[0]) {
      raw = raw.substring(1, raw.length - 1);
    }
    final out = <Person>[];
    for (final item in raw.split(',')) {
      if (item.trim().isEmpty) continue;
      final cut = item.indexOf(':');
      final label = (cut < 0 ? item : item.substring(0, cut)).trim().replaceAll(RegExp(r'\s+'), ' ');
      final pass = cut < 0 ? null : item.substring(cut + 1).trim();
      final name = Person.slug(label);
      if (name.isEmpty || name.length > 40) {
        throw FormatException('"$label" cannot be a name: use letters or digits, up to 40.');
      }
      if (out.any((p) => p.name == name)) throw FormatException('"$label" is in GYMMANE_PEOPLE twice.');
      out.add(Person(name, label, pass == null || pass.isEmpty ? null : pass));
    }
    return out;
  }
}
