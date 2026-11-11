import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'server/server_link.dart';

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

  static bool get remote => kIsWeb && ServerLink.instance.available;

  static bool get ready => _dir != null || remote;

  @visibleForTesting
  static set directory(String? path) => _dir = path;

  static String? pathFor(String basename) {
    if (basename.isEmpty) return null;
    if (remote) return ServerLink.instance.mediaUrl(basename);
    return _dir == null ? null : '$_dir/$basename';
  }

  static Future<String?> importFor(String exerciseId, String srcPath) async {
    if (remote) {
      final bytes = await ServerLink.instance.fetchBytes(srcPath);
      return bytes == null ? null : saveBytes(exerciseId, extOf(srcPath), bytes);
    }
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
    if (remote) {
      final base = _newName(exerciseId, ext);
      return await ServerLink.instance.putMedia(base, bytes) ? base : null;
    }
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
    if (remote) return basename.isEmpty ? null : ServerLink.instance.getMedia(basename);
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
    if (remote && basename.isNotEmpty) return ServerLink.instance.deleteMedia(basename);
    if (_dir == null || basename.isEmpty) return;
    try {
      final f = File('$_dir/$basename');
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  static Set<String> names() {
    if (_dir == null) return {};
    try {
      return {
        for (final f in Directory(_dir!).listSync())
          if (f is File) f.uri.pathSegments.last,
      };
    } catch (_) {
      return {};
    }
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
