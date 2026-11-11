import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:sync/sync.dart';

import 'media_store.dart';
import 'state_store.dart';

class PhoneSync {
  PhoneSync({required this.syncDir, required this.dataDir, required this.store, required this.media});

  final String syncDir;
  final String dataDir;
  final StateStore store;
  final MediaFiles media;

  static const device = 'server';
  static const keep = 3;
  static const _groups = {
    'noteMedia': ['notes'],
    'shotMedia': ['shots', 'bodyTl', 'timeline'],
    'momentMedia': ['moments'],
    'foodMedia': ['nutrition'],
    'passMedia': ['passes'],
  };
  static final _legacy = RegExp(r'^gymmane-auto-\d{4}-\d{2}-\d{2}.*\.zip$');

  File get _meta => File('$dataDir/sync.meta.json');

  final Map<String, int> _pulled = {};
  DateTime? lastImport;
  String? lastImportFile;
  DateTime? lastExport;
  String? lastError;
  Timer? _poll;
  Timer? _exportSoon;
  bool _busy = false;

  Future<void> start({Duration every = const Duration(seconds: 15)}) async {
    await Directory(syncDir).create(recursive: true);
    await _readMeta();
    await scan();
    _poll = Timer.periodic(every, (_) => scan());
  }

  void stop() {
    _poll?.cancel();
    _exportSoon?.cancel();
  }

  Map<String, Object?> get info => {
        'enabled': true,
        'folder': Uri.file(Directory(syncDir).absolute.path).normalizePath().toFilePath(),
        'devices': _pulled.keys.toList(),
        if (lastImport != null) 'lastImport': lastImport!.toIso8601String(),
        if (lastImportFile != null) 'lastImportFile': lastImportFile,
        if (lastExport != null) 'lastExport': lastExport!.toIso8601String(),
        if (lastError != null) 'error': lastError,
      };

  Future<void> _readMeta() async {
    if (!await _meta.exists()) return;
    try {
      final m = jsonDecode(await _meta.readAsString()) as Map<String, dynamic>;
      lastImport = DateTime.tryParse(m['import'] as String? ?? '');
      lastImportFile = m['file'] as String?;
      lastExport = DateTime.tryParse(m['export'] as String? ?? '');
      ((m['pulled'] as Map?) ?? const {}).forEach((k, v) {
        if (k is String && v is num) _pulled[k] = v.toInt();
      });
    } catch (_) {}
  }

  Future<void> _writeMeta() => _meta.writeAsString(jsonEncode({
        if (lastImport != null) 'import': lastImport!.toIso8601String(),
        if (lastImportFile != null) 'file': lastImportFile,
        if (lastExport != null) 'export': lastExport!.toIso8601String(),
        'pulled': _pulled,
      }));

  Future<List<(String, DateTime, File)>> _candidates() async {
    final dir = Directory(syncDir);
    if (!await dir.exists()) return const [];
    final names = <String, File>{};
    final legacy = <File>[];
    await for (final f in dir.list()) {
      if (f is! File) continue;
      final name = f.uri.pathSegments.last;
      if (name.startsWith('.')) continue;
      names[name] = f;
      if (_legacy.hasMatch(name)) legacy.add(f);
    }
    final out = <(String, DateTime, File)>[
      for (final e in newestByDevice(names.keys, self: device).entries) (e.key, e.value.at, names[e.value.name]!),
    ];
    File? old;
    DateTime? oldAt;
    for (final f in legacy) {
      final at = (await f.stat()).modified.toUtc();
      if (oldAt == null || at.isAfter(oldAt)) {
        old = f;
        oldAt = at;
      }
    }
    if (old != null) out.add(('legacy', oldAt!, old));
    return out;
  }

  Future<bool> scan() async {
    if (_busy) return false;
    _busy = true;
    var merged = false;
    try {
      for (final (dev, at, f) in await _candidates()) {
        if (at.millisecondsSinceEpoch <= (_pulled[dev] ?? 0)) continue;
        final size = await f.length();
        await Future<void>.delayed(const Duration(milliseconds: 600));
        if (await f.length() != size) continue;
        final last = lastExport;
        final result = await mergeZip(await f.readAsBytes(), incomingNewer: last == null || at.isAfter(last));
        _pulled[dev] = at.millisecondsSinceEpoch;
        if (result == null) {
          lastError = 'Could not read ${f.uri.pathSegments.last}';
          continue;
        }
        lastError = null;
        lastImport = DateTime.now().toUtc();
        lastImportFile = f.uri.pathSegments.last;
        if (result) merged = true;
      }
      await _writeMeta();
      return merged;
    } catch (e) {
      lastError = '$e';
      return false;
    } finally {
      _busy = false;
    }
  }

  Future<bool?> mergeZip(Uint8List bytes, {required bool incomingNewer}) async {
    final Archive archive;
    try {
      archive = ZipDecoder().decodeBytes(bytes);
    } catch (_) {
      return null;
    }
    ArchiveFile? json;
    for (final f in archive.files) {
      if (f.isFile && f.name.split('/').last == 'gymmane.json') json = f;
    }
    if (json == null) return null;
    final Map<String, dynamic> incoming;
    try {
      final decoded = jsonDecode(utf8.decode(json.readBytes() ?? const []));
      if (decoded is! Map<String, dynamic>) return null;
      incoming = decoded;
    } catch (_) {
      return null;
    }

    Map<String, dynamic> local = const {};
    final text = store.current.text;
    if (text != null) {
      try {
        local = jsonDecode(text) as Map<String, dynamic>;
      } catch (_) {}
    }

    final localEx = (local['media'] as Map?) ?? const {};
    final exercise = <String, String>{};
    final exMap = incoming['media'];
    if (exMap is Map) {
      for (final e in exMap.entries) {
        final id = e.key;
        final path = e.value;
        if (id is! String || path is! String || localEx.containsKey(id)) continue;
        final data = archive.findFile(path)?.readBytes();
        if (data == null) continue;
        final ext = path.contains('.') ? path.substring(path.lastIndexOf('.') + 1).toLowerCase() : 'dat';
        final clean = id.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
        final name = 'ex-$clean-${data.length}.$ext';
        if (await media.write(name, data)) exercise[id] = name;
      }
    }
    incoming['media'] = exercise;

    var added = exercise.isNotEmpty;
    for (final group in _groups.keys) {
      final map = incoming[group];
      if (map is! Map) continue;
      for (final e in map.entries) {
        final name = e.key;
        final path = e.value;
        if (name is! String || path is! String || !MediaFiles.validName(name) || await media.exists(name)) continue;
        final data = archive.findFile(path)?.readBytes();
        if (data != null && await media.write(name, data)) added = true;
      }
    }

    final merged = mergeStates(local, incoming, incomingNewer: incomingNewer);
    if (sameState(local, merged) && !added) return false;
    await store.write(jsonEncode(merged), source: 'phone');
    return true;
  }

  void changed() {
    _exportSoon?.cancel();
    _exportSoon = Timer(const Duration(seconds: 30), () => exportZip());
  }

  Future<bool> exportZip() async {
    final text = store.current.text;
    if (text == null) return false;
    try {
      final data = jsonDecode(text) as Map<String, dynamic>;
      final archive = Archive();
      final added = <String>{};

      Future<String?> add(String name) async {
        final path = 'files/$name';
        if (added.contains(name)) return path;
        final bytes = await media.read(name);
        if (bytes == null) return null;
        archive.addFile(ArchiveFile.noCompress(path, bytes.length, bytes));
        added.add(name);
        return path;
      }

      final exercise = <String, String>{};
      final exMap = data['media'];
      if (exMap is Map) {
        for (final e in exMap.entries) {
          if (e.key is! String || e.value is! String) continue;
          final path = await add(e.value as String);
          if (path != null) exercise[e.key as String] = path;
        }
      }
      data['media'] = exercise;

      for (final entry in _groups.entries) {
        final found = <String, String>{};
        for (final key in entry.value) {
          for (final name in stringsIn(data[key])) {
            if (found.containsKey(name) || !MediaFiles.validName(name) || !await media.exists(name)) continue;
            final path = await add(name);
            if (path != null) found[name] = path;
          }
        }
        data[entry.key] = found;
      }

      archive.addFile(ArchiveFile.string('gymmane.json', const JsonEncoder.withIndent('  ').convert(data)));
      final zip = ZipEncoder().encodeBytes(archive);
      final now = DateTime.now().toUtc();
      final name = syncName(device, now);
      final tmp = File('$syncDir/.$name.part');
      await tmp.writeAsBytes(zip, flush: true);
      await tmp.rename('$syncDir/$name');
      lastExport = now;
      await _prune();
      await _writeMeta();
      return true;
    } catch (e) {
      lastError = '$e';
      return false;
    }
  }

  Future<void> _prune() async {
    final own = <SyncFile>[];
    await for (final f in Directory(syncDir).list()) {
      if (f is! File) continue;
      final s = SyncFile.parse(f.uri.pathSegments.last);
      if (s != null && s.device == device) own.add(s);
    }
    own.sort((a, b) => b.at.compareTo(a.at));
    for (final s in own.skip(keep)) {
      try {
        await File('$syncDir/${s.name}').delete();
      } catch (_) {}
    }
  }
}
