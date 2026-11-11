import 'dart:convert';
import 'dart:io';

class Snapshot {
  const Snapshot(this.rev, this.text, this.savedAt, this.source);

  final int rev;
  final String? text;
  final DateTime? savedAt;
  final String source;
}

class WriteResult {
  const WriteResult.ok(this.rev) : conflict = false;
  const WriteResult.conflict(this.rev) : conflict = true;

  final int rev;
  final bool conflict;
}

class StateStore {
  StateStore(this.dir, {this.keepDays = 30});

  final String dir;
  final int keepDays;

  File get _state => File('$dir/state.json');
  File get _meta => File('$dir/state.meta.json');
  Directory get _history => Directory('$dir/history');

  Snapshot? _cache;

  Future<void> open() async {
    await Directory(dir).create(recursive: true);
    await _history.create(recursive: true);
    _cache = await _readDisk();
  }

  Snapshot get current => _cache ?? const Snapshot(0, null, null, 'none');

  Future<Snapshot> _readDisk() async {
    var rev = 0;
    DateTime? at;
    var source = 'none';
    if (await _meta.exists()) {
      try {
        final m = jsonDecode(await _meta.readAsString()) as Map<String, dynamic>;
        rev = (m['rev'] as num?)?.toInt() ?? 0;
        at = DateTime.tryParse(m['savedAt'] as String? ?? '');
        source = m['source'] as String? ?? 'web';
      } catch (_) {}
    }
    final text = await _state.exists() ? await _state.readAsString() : null;
    if (text != null && rev == 0) rev = 1;
    return Snapshot(rev, text, at, text == null ? 'none' : source);
  }

  static bool isValid(String text) {
    try {
      return jsonDecode(text) is Map<String, dynamic>;
    } catch (_) {
      return false;
    }
  }

  Future<WriteResult> write(String text, {int? baseRev, String source = 'web'}) async {
    final now = current;
    if (baseRev != null && now.rev != 0 && baseRev != now.rev) return WriteResult.conflict(now.rev);
    final rev = now.rev + 1;
    final at = DateTime.now().toUtc();
    await _keepHistory(now);
    await _atomic(_state, text);
    await _atomic(_meta, jsonEncode({'rev': rev, 'savedAt': at.toIso8601String(), 'source': source}));
    _cache = Snapshot(rev, text, at, source);
    return WriteResult.ok(rev);
  }

  Future<void> _atomic(File f, String text) async {
    final tmp = File('${f.path}.tmp');
    await tmp.writeAsString(text, flush: true);
    await tmp.rename(f.path);
  }

  Future<void> _keepHistory(Snapshot before) async {
    final text = before.text;
    if (text == null) return;
    final day = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    final f = File('${_history.path}/state-$day.json');
    if (!await f.exists()) await f.writeAsString(text, flush: true);
    final files = (await _history.list().toList()).whereType<File>().where((x) => x.path.endsWith('.json')).toList()
      ..sort((a, b) => b.path.compareTo(a.path));
    for (final old in files.skip(keepDays)) {
      try {
        await old.delete();
      } catch (_) {}
    }
  }
}
