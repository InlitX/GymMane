import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class MediaStore {
  MediaStore._();

  static String? _dir;

  static Future<void> init() async {
    try {
      final docs = await getApplicationDocumentsDirectory();
      final dir = Directory('${docs.path}/exercise_media');
      if (!await dir.exists()) await dir.create(recursive: true);
      _dir = dir.path;
    } catch (_) {
      _dir = null;
    }
  }

  static bool get ready => _dir != null;

  @visibleForTesting
  static set directory(String? path) => _dir = path;

  static String? pathFor(String basename) =>
      (_dir == null || basename.isEmpty) ? null : '$_dir/$basename';

  static Future<String?> importFor(String exerciseId, String srcPath) async {
    if (_dir == null) return null;
    try {
      final base = _newName(exerciseId, extOf(srcPath));
      await File(srcPath).copy('$_dir/$base');
      return base;
    } catch (_) {
      return null;
    }
  }

  static Future<String?> saveBytes(String exerciseId, String ext, Uint8List bytes) async {
    if (_dir == null) return null;
    try {
      final base = _newName(exerciseId, ext);
      await File('$_dir/$base').writeAsBytes(bytes, flush: true);
      return base;
    } catch (_) {
      return null;
    }
  }

  static Future<Uint8List?> readBytes(String basename) async {
    final p = pathFor(basename);
    if (p == null) return null;
    try {
      final f = File(p);
      return await f.exists() ? await f.readAsBytes() : null;
    } catch (_) {
      return null;
    }
  }

  static Future<void> delete(String basename) async {
    if (_dir == null || basename.isEmpty) return;
    try {
      final f = File('$_dir/$basename');
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  static Future<void> clearAll() async {
    if (_dir == null) return;
    try {
      for (final f in Directory(_dir!).listSync()) {
        if (f is File) await f.delete();
      }
    } catch (_) {}
  }

  static int _seq = 0;

  static String _newName(String exerciseId, String ext) =>
      '$exerciseId-${DateTime.now().microsecondsSinceEpoch}-${_seq++}.$ext';

  static String extOf(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return 'dat';
    return path.substring(dot + 1).toLowerCase();
  }

  static const videoExtensions = {'mp4', 'mov', 'm4v', 'webm', 'mkv', '3gp', 'avi'};

  static bool isVideo(String basename) => videoExtensions.contains(extOf(basename));
}
