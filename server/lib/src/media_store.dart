import 'dart:io';
import 'dart:typed_data';

class MediaFiles {
  MediaFiles(this.dir);

  final String dir;

  static final _safe = RegExp(r'^[A-Za-z0-9][A-Za-z0-9._-]{0,159}$');

  static bool validName(String name) => _safe.hasMatch(name) && !name.contains('..');

  Future<void> open() => Directory(dir).create(recursive: true);

  File? _file(String name) => validName(name) ? File('$dir/$name') : null;

  Future<Uint8List?> read(String name) async {
    final f = _file(name);
    if (f == null || !await f.exists()) return null;
    return f.readAsBytes();
  }

  Future<bool> write(String name, List<int> bytes) async {
    final f = _file(name);
    if (f == null) return false;
    final tmp = File('${f.path}.part');
    await tmp.writeAsBytes(bytes, flush: true);
    await tmp.rename(f.path);
    return true;
  }

  Future<bool> delete(String name) async {
    final f = _file(name);
    if (f == null || !await f.exists()) return false;
    await f.delete();
    return true;
  }

  Future<bool> exists(String name) async {
    final f = _file(name);
    return f != null && await f.exists();
  }

  static String typeOf(String name) {
    final ext = name.contains('.') ? name.substring(name.lastIndexOf('.') + 1).toLowerCase() : '';
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      'heic' => 'image/heic',
      'mp4' => 'video/mp4',
      'webm' => 'video/webm',
      'mov' => 'video/quicktime',
      'mp3' => 'audio/mpeg',
      'm4a' => 'audio/mp4',
      'ogg' => 'audio/ogg',
      'wav' => 'audio/wav',
      _ => 'application/octet-stream',
    };
  }
}
