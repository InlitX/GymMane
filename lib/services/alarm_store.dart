import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AlarmStore {
  AlarmStore._();

  static String? _dir;

  static const audioExtensions = <String>[
    'mp3', 'wav', 'ogg', 'm4a', 'aac', 'flac', 'opus', 'wma', 'caf', 'aiff',
  ];

  static const maxDuration = Duration(seconds: 15);

  static Future<void> init() async {
    try {
      final docs = await getApplicationDocumentsDirectory();
      final dir = Directory('${docs.path}/alarm');
      if (!await dir.exists()) await dir.create(recursive: true);
      _dir = dir.path;
    } catch (_) {
      _dir = null;
    }
  }

  static bool get ready => _dir != null;

  static String? pathFor(String? basename) {
    if (_dir == null || basename == null || basename.isEmpty) return null;
    final p = '$_dir/$basename';
    return File(p).existsSync() ? p : null;
  }

  static Future<String?> importSound(String srcPath) async {
    if (_dir == null) return null;
    try {
      await _clear();
      final ext = _ext(srcPath);

      final base = 'alarm-${DateTime.now().millisecondsSinceEpoch}.$ext';
      await File(srcPath).copy('$_dir/$base');
      return base;
    } catch (_) {
      return null;
    }
  }

  static Future<void> clear() => _clear();

  static Future<void> _clear() async {
    if (_dir == null) return;
    try {
      final dir = Directory(_dir!);
      if (!await dir.exists()) return;
      for (final f in dir.listSync()) {
        if (f is File) await f.delete();
      }
    } catch (_) {}
  }

  static String _ext(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return 'mp3';
    return path.substring(dot + 1).toLowerCase();
  }
}
