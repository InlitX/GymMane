import 'dart:io';

class Config {
  Config({
    required this.port,
    required this.host,
    required this.dataDir,
    required this.webDir,
    required this.syncDir,
    required this.password,
    required this.keepDays,
  });

  final int port;
  final String host;
  final String dataDir;
  final String webDir;
  final String? syncDir;
  final String? password;
  final int keepDays;

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
    );
  }
}
