import 'dart:io';

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

  static String? pathFor(String basename) =>
      (_dir == null || basename.isEmpty) ? null : '$_dir/$basename';

  static Future<String?> importFor(String exerciseId, String srcPath) async {
    if (_dir == null) return null;
    try {
      final ext = _ext(srcPath);

      final base = '$exerciseId-${DateTime.now().millisecondsSinceEpoch}.$ext';
      final dst = File('$_dir/$base');
      await File(srcPath).copy(dst.path);
      return base;
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

  static String _ext(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return 'dat';
    return path.substring(dot + 1).toLowerCase();
  }

  static bool isVideo(String basename) {
    const vids = {'mp4', 'mov', 'm4v', 'webm', 'mkv', '3gp', 'avi'};
    return vids.contains(_ext(basename));
  }
}
