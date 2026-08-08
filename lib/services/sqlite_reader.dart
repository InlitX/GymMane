import 'dart:convert';
import 'dart:typed_data';

/// Lector de SQLite de solo lectura, en Dart puro.
///
/// FitNotes no exporta un CSV: su copia de seguridad es una base de datos
/// SQLite entera. Con esto se lee sin plugins nativos, así que sigue
/// funcionando en los tests y en la web.
class SqliteDb {
  SqliteDb._(this._bytes, this._pageSize, this._usable, this._tables);

  static const _magic = 'SQLite format 3\x00';

  final Uint8List _bytes;
  final int _pageSize;
  final int _usable;
  final Map<String, _Table> _tables;

  Iterable<String> get tables => _tables.keys;

  bool has(String table) => _tables.containsKey(table.toLowerCase());

  static bool looksLikeSqlite(List<int> bytes) {
    if (bytes.length < 16) return false;
    for (var i = 0; i < _magic.length; i++) {
      if (bytes[i] != _magic.codeUnitAt(i)) return false;
    }
    return true;
  }

  static SqliteDb? open(List<int> raw) {
    if (!looksLikeSqlite(raw)) return null;
    final bytes = raw is Uint8List ? raw : Uint8List.fromList(raw);
    try {
      var pageSize = _be16(bytes, 16);
      if (pageSize == 1) pageSize = 65536;
      if (pageSize < 512 || bytes.length < pageSize) return null;
      final usable = pageSize - bytes[20];

      final db = SqliteDb._(bytes, pageSize, usable, {});
      for (final row in db._readTree(1)) {
        final v = row.values;
        if (v.length < 5 || v[0] != 'table') continue;
        final name = (v[1] as String?) ?? '';
        final root = _asInt(v[3]);
        final sql = v[4] as String?;
        if (name.isEmpty || root == null || sql == null) continue;
        db._tables[name.toLowerCase()] = _Table(root, _columns(sql));
      }
      return db;
    } catch (_) {
      return null;
    }
  }

  /// Filas de una tabla, ya con el nombre de cada columna.
  List<Map<String, Object?>> rows(String table) {
    final t = _tables[table.toLowerCase()];
    if (t == null) return const [];
    final out = <Map<String, Object?>>[];
    for (final rec in _readTree(t.root)) {
      final row = <String, Object?>{};
      for (var i = 0; i < t.columns.length; i++) {
        final value = i < rec.values.length ? rec.values[i] : null;
        // Una columna INTEGER PRIMARY KEY no se guarda: es el rowid.
        row[t.columns[i].name] = value == null && t.columns[i].isRowId ? rec.rowId : value;
      }
      out.add(row);
    }
    return out;
  }

  // ── árbol B ──────────────────────────────────────────────────
  List<_Record> _readTree(int page) {
    final out = <_Record>[];
    _walk(page, out, 0);
    return out;
  }

  void _walk(int page, List<_Record> out, int depth) {
    if (page < 1 || depth > 32) return;
    final start = (page - 1) * _pageSize;
    if (start + _pageSize > _bytes.length) return;
    final header = page == 1 ? start + 100 : start;
    final type = _bytes[header];
    final cells = _be16(_bytes, header + 3);

    if (type == 0x05) {
      final ptrs = header + 12;
      for (var i = 0; i < cells; i++) {
        final cell = start + _be16(_bytes, ptrs + i * 2);
        _walk(_be32(_bytes, cell), out, depth + 1);
      }
      _walk(_be32(_bytes, header + 8), out, depth + 1);
      return;
    }
    if (type != 0x0D) return;

    final ptrs = header + 8;
    for (var i = 0; i < cells; i++) {
      final cell = start + _be16(_bytes, ptrs + i * 2);
      var p = cell;
      final size = _varint(_bytes, p);
      p += size.length;
      final rowId = _varint(_bytes, p);
      p += rowId.length;
      final payload = _payload(p, size.value);
      if (payload == null) continue;
      out.add(_Record(rowId.value, _decode(payload)));
    }
  }

  /// Cuando la fila no cabe en la página, el resto va en páginas de desbordamiento.
  Uint8List? _payload(int at, int total) {
    final maxLocal = _usable - 35;
    if (total <= maxLocal) {
      if (at + total > _bytes.length) return null;
      return Uint8List.sublistView(_bytes, at, at + total);
    }
    final minLocal = ((_usable - 12) * 32 ~/ 255) - 23;
    var local = minLocal + (total - minLocal) % (_usable - 4);
    if (local > maxLocal) local = minLocal;
    if (at + local + 4 > _bytes.length) return null;

    final out = BytesBuilder();
    out.add(Uint8List.sublistView(_bytes, at, at + local));
    var next = _be32(_bytes, at + local);
    var left = total - local;
    var guard = 0;
    while (next > 0 && left > 0 && guard++ < 4096) {
      final page = (next - 1) * _pageSize;
      if (page + _usable > _bytes.length) break;
      final take = left < _usable - 4 ? left : _usable - 4;
      out.add(Uint8List.sublistView(_bytes, page + 4, page + 4 + take));
      left -= take;
      next = _be32(_bytes, page);
    }
    return out.toBytes();
  }

  List<Object?> _decode(Uint8List rec) {
    final headerSize = _varint(rec, 0);
    var p = headerSize.length;
    final types = <int>[];
    while (p < headerSize.value) {
      final t = _varint(rec, p);
      types.add(t.value);
      p += t.length;
    }
    var body = headerSize.value;
    final values = <Object?>[];
    for (final t in types) {
      final size = _sizeOf(t);
      if (body + size > rec.length) {
        values.add(null);
        continue;
      }
      values.add(_value(t, rec, body, size));
      body += size;
    }
    return values;
  }

  static int _sizeOf(int type) => switch (type) {
        0 || 8 || 9 => 0,
        1 => 1,
        2 => 2,
        3 => 3,
        4 => 4,
        5 => 6,
        6 || 7 => 8,
        _ => type >= 12 ? (type - 12) ~/ 2 : 0,
      };

  static Object? _value(int type, Uint8List b, int at, int size) {
    switch (type) {
      case 0:
        return null;
      case 8:
        return 0;
      case 9:
        return 1;
      case 7:
        return ByteData.sublistView(b, at, at + 8).getFloat64(0);
      case 1 || 2 || 3 || 4 || 5 || 6:
        var v = 0;
        for (var i = 0; i < size; i++) {
          v = (v << 8) | b[at + i];
        }
        final bits = size * 8;
        final sign = 1 << (bits - 1);
        return (v & sign) != 0 ? v - (1 << bits) : v;
      default:
        final data = Uint8List.sublistView(b, at, at + size);
        if (type.isOdd) return utf8.decode(data, allowMalformed: true);
        return data;
    }
  }

  static List<_Column> _columns(String sql) {
    final open = sql.indexOf('(');
    final close = sql.lastIndexOf(')');
    if (open < 0 || close <= open) return const [];
    final body = sql.substring(open + 1, close);

    final parts = <String>[];
    var depth = 0;
    var buf = StringBuffer();
    for (final ch in body.split('')) {
      if (ch == '(') depth++;
      if (ch == ')') depth--;
      if (ch == ',' && depth == 0) {
        parts.add(buf.toString());
        buf = StringBuffer();
      } else {
        buf.write(ch);
      }
    }
    parts.add(buf.toString());

    const skip = {'primary', 'foreign', 'unique', 'check', 'constraint'};
    final out = <_Column>[];
    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) continue;
      final words = trimmed.split(RegExp(r'\s+'));
      final first = words.first.toLowerCase();
      if (skip.contains(first)) continue;
      final name = words.first.replaceAll(RegExp(r'''^["`\[]|["`\]]$'''), '');
      final rest = trimmed.toLowerCase();
      out.add(_Column(name, rest.contains('integer') && rest.contains('primary key')));
    }
    return out;
  }

  static int _be16(Uint8List b, int at) => (b[at] << 8) | b[at + 1];

  static int _be32(Uint8List b, int at) =>
      (b[at] << 24) | (b[at + 1] << 16) | (b[at + 2] << 8) | b[at + 3];

  static _Varint _varint(Uint8List b, int at) {
    var value = 0;
    for (var i = 0; i < 8; i++) {
      final byte = b[at + i];
      value = (value << 7) | (byte & 0x7F);
      if (byte & 0x80 == 0) return _Varint(value, i + 1);
    }
    return _Varint((value << 8) | b[at + 8], 9);
  }

  static int? _asInt(Object? v) => v is int ? v : (v is double ? v.toInt() : null);
}

class _Table {
  _Table(this.root, this.columns);
  final int root;
  final List<_Column> columns;
}

class _Column {
  _Column(this.name, this.isRowId);
  final String name;
  final bool isRowId;
}

class _Record {
  _Record(this.rowId, this.values);
  final int rowId;
  final List<Object?> values;
}

class _Varint {
  _Varint(this.value, this.length);
  final int value;
  final int length;
}
