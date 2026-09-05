import 'package:archive/archive.dart';

const double _lbPerKg = 2.2046226218;

enum ImportFormat { hevy, strong, fitnotes, gymmane, hevyWeights, strongWeights, weights, unknown }

extension ImportFormatX on ImportFormat {
  bool get isWeights =>
      this == ImportFormat.hevyWeights ||
      this == ImportFormat.strongWeights ||
      this == ImportFormat.weights;
}

class ParsedSet {
  ParsedSet(this.reps, this.weightKg);
  final int reps;
  final double weightKg;
}

class ParsedWeight {
  ParsedWeight(this.date, this.kg);
  final DateTime date;
  final double kg;
}

class ParsedExercise {
  ParsedExercise(this.name, this.muscle);
  final String name;
  final String? muscle;
  final List<ParsedSet> sets = [];
}

class ParsedSession {
  ParsedSession(this.date, this.durationSec);
  final DateTime date;
  final int durationSec;
  final List<ParsedExercise> exercises = [];
}

class ImportResult {
  ImportResult(this.format, this.sessions, {this.weights = const []});
  final ImportFormat format;
  final List<ParsedSession> sessions;
  final List<ParsedWeight> weights;

  bool get isEmpty => sessions.isEmpty && weights.isEmpty;
}

class _Fmt {
  const _Fmt({
    required this.date,
    required this.exercise,
    required this.reps,
    required this.weightKg,
    required this.weightLb,
    this.weightPlain,
    this.group,
    this.muscle,
    this.endDate,
    this.durationText,
    this.durationSec,
    this.setType,
  });

  final List<String> date;
  final List<String> exercise;
  final List<String> reps;
  final List<String> weightKg;
  final List<String> weightLb;
  final List<String>? weightPlain;
  final List<String>? group;
  final List<String>? muscle;
  final List<String>? endDate;
  final List<String>? durationText;
  final List<String>? durationSec;
  final List<String>? setType;
}

const _formats = <ImportFormat, _Fmt>{
  ImportFormat.hevy: _Fmt(
    date: ['start_time'],
    endDate: ['end_time'],
    group: ['title'],
    exercise: ['exercise_title'],
    reps: ['reps'],
    weightKg: ['weight_kg'],
    weightLb: ['weight_lbs', 'weight_lb'],
    setType: ['set_type'],
  ),
  ImportFormat.strong: _Fmt(
    date: ['date'],
    group: ['workout #', 'workout name'],
    exercise: ['exercise name'],
    reps: ['reps'],
    weightKg: ['weight (kg)'],
    weightLb: ['weight (lbs)', 'weight (lb)'],
    weightPlain: ['weight'],
    durationText: ['duration'],
    durationSec: ['duration (sec)', 'duration (seconds)'],
  ),
  ImportFormat.fitnotes: _Fmt(
    date: ['date'],
    exercise: ['exercise'],
    reps: ['reps'],
    weightKg: ['weight (kg)'],
    weightLb: ['weight (lbs)', 'weight (lb)'],
    weightPlain: ['weight'],
    muscle: ['category'],
  ),
  ImportFormat.gymmane: _Fmt(
    date: ['date'],
    exercise: ['exercise'],
    reps: ['reps'],
    weightKg: ['weight_kg'],
    weightLb: [],
    muscle: ['muscle'],
  ),
};

const _anyWeight = ['weight (kg)', 'weight (lbs)', 'weight (lb)', 'weight', 'weight_kg'];
const _weightKgCols = ['weight_kg', 'weight (kg)', 'weight kg', 'peso (kg)'];
const _weightLbCols = ['weight_lbs', 'weight_lb', 'weight (lbs)', 'weight (lb)', 'weight lbs'];
const _dateCols = ['date', 'fecha', 'start_time', 'time'];

ImportFormat detectFormat(String csv) {
  final cols = _header(csv);
  if (cols.isEmpty) return ImportFormat.unknown;
  if (cols.contains('exercise_title') && cols.contains('start_time')) return ImportFormat.hevy;
  if (cols.contains('exercise name') && cols.contains('set order')) return ImportFormat.strong;
  if (cols.contains('weight_kg') && (cols.contains('est_1rm_kg') || cols.contains('volume_kg'))) {
    return ImportFormat.gymmane;
  }
  if (cols.contains('exercise') && cols.contains('category') && _pick(cols, _anyWeight) != null) {
    return ImportFormat.fitnotes;
  }
  final hasExercise = cols.any((c) => c.contains('exercise') || c.contains('ejercicio'));
  final dateCol = _pick(cols, _dateCols);
  final weightCol = _pick(cols, [..._weightKgCols, ..._weightLbCols, 'weight', 'peso']);
  if (!hasExercise && dateCol != null && weightCol != null) {
    if (cols.contains('fat_percent') || cols.contains('weight_lbs') && cols.length > 3) {
      return ImportFormat.hevyWeights;
    }
    if (cols.length <= 3) return ImportFormat.strongWeights;
    return ImportFormat.weights;
  }
  return ImportFormat.unknown;
}

bool needsUnitChoice(String csv) {
  final format = detectFormat(csv);
  final cols = _header(csv);
  if (format.isWeights) {
    if (_pick(cols, _weightKgCols) != null || _pick(cols, _weightLbCols) != null) return false;
    return _pick(cols, ['weight', 'peso']) != null;
  }
  final fmt = _formats[format];
  if (fmt == null) return false;
  if (_pick(cols, fmt.weightKg) != null || _pick(cols, fmt.weightLb) != null) return false;
  return _pick(cols, fmt.weightPlain ?? const []) != null;
}

String? weightCsvFromZip(List<int> bytes) {
  Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } catch (_) {
    return null;
  }
  String? best;
  for (final file in archive.files) {
    if (!file.isFile) continue;
    final name = file.name.split('/').last.toLowerCase();
    if (!name.endsWith('.csv')) continue;
    if (!name.contains('weight') && !name.contains('peso')) continue;
    if (name.contains('percentage') || name.contains('fat')) continue;
    String text;
    try {
      text = String.fromCharCodes(file.content as List<int>);
    } catch (_) {
      continue;
    }
    best = text;
    if (name == 'weight.csv') break;
  }
  return best;
}

List<ParsedWeight> parseWeights(String csv, {bool isLb = false}) {
  final rows = _rows(csv, _delimiter(csv));
  if (rows.length < 2) return const [];

  final index = <String, int>{};
  for (var i = 0; i < rows.first.length; i++) {
    index[_norm(rows.first[i])] = i;
  }
  final cols = index.keys.toList();

  final dateCol = _pick(cols, _dateCols);
  if (dateCol == null) return const [];
  final kgCol = _pick(cols, _weightKgCols);
  final lbCol = _pick(cols, _weightLbCols);
  final plainCol = kgCol == null && lbCol == null ? _pick(cols, ['weight', 'peso']) : null;
  if (kgCol == null && lbCol == null && plainCol == null) return const [];

  String cell(List<String> row, String? name) {
    final i = name == null ? null : index[name];
    return (i == null || i >= row.length) ? '' : row[i].trim();
  }

  final out = <ParsedWeight>[];
  for (final row in rows.skip(1)) {
    final date = _parseDate(cell(row, dateCol));
    if (date == null) continue;
    final kg = _weightKg(
      kg: cell(row, kgCol),
      lb: cell(row, lbCol),
      plain: cell(row, plainCol),
      plainIsLb: isLb,
    );
    if (kg <= 0) continue;
    out.add(ParsedWeight(date, kg));
  }
  return out;
}

ImportResult parseImport(String csv, {bool isLb = false}) {
  final format = detectFormat(csv);
  if (format.isWeights) {
    return ImportResult(format, const [], weights: parseWeights(csv, isLb: isLb));
  }
  final fmt = _formats[format];
  if (fmt == null) return ImportResult(format, const []);

  final rows = _rows(csv, _delimiter(csv));
  if (rows.length < 2) return ImportResult(format, const []);

  final index = <String, int>{};
  for (var i = 0; i < rows.first.length; i++) {
    index[_norm(rows.first[i])] = i;
  }
  final cols = index.keys.toList();

  String cell(List<String> row, List<String>? names) {
    final name = _pick(cols, names ?? const []);
    final i = name == null ? null : index[name];
    return (i == null || i >= row.length) ? '' : row[i].trim();
  }

  final kgCol = _pick(cols, fmt.weightKg);
  final lbCol = _pick(cols, fmt.weightLb);
  final plainCol = _pick(cols, fmt.weightPlain ?? const []);

  final sessions = <String, ParsedSession>{};
  final exercisesOf = <String, Map<String, ParsedExercise>>{};

  for (final row in rows.skip(1)) {
    final reps = int.tryParse(cell(row, fmt.reps)) ?? 0;
    if (reps <= 0) continue;
    if (_norm(cell(row, fmt.setType)) == 'warmup') continue;

    final date = _parseDate(cell(row, fmt.date));
    if (date == null) continue;
    final name = cell(row, fmt.exercise);
    if (name.isEmpty) continue;

    final kg = _weightKg(
      kg: kgCol == null ? '' : cell(row, [kgCol]),
      lb: lbCol == null ? '' : cell(row, [lbCol]),
      plain: plainCol == null ? '' : cell(row, [plainCol]),
      plainIsLb: isLb,
    );

    final group = cell(row, fmt.group);
    final key = group.isNotEmpty ? '${_dayId(date)}|$group' : _dayId(date);

    final session = sessions.putIfAbsent(key, () {
      final end = _parseDate(cell(row, fmt.endDate));
      final span = end == null ? 0 : end.difference(date).inSeconds;
      if (span > 0) return ParsedSession(date, span);
      final secs = int.tryParse(cell(row, fmt.durationSec)) ?? 0;
      return ParsedSession(date, secs > 0 ? secs : _parseDuration(cell(row, fmt.durationText)));
    });
    final exercises = exercisesOf.putIfAbsent(key, () => {});
    final exercise = exercises.putIfAbsent(name, () {
      final muscle = cell(row, fmt.muscle);
      final parsed = ParsedExercise(name, muscle.isEmpty ? null : muscle);
      session.exercises.add(parsed);
      return parsed;
    });
    exercise.sets.add(ParsedSet(reps, kg));
  }

  return ImportResult(format, sessions.values.toList());
}

double _weightKg({
  required String kg,
  required String lb,
  required String plain,
  required bool plainIsLb,
}) {
  final inKg = _number(kg);
  if (inKg != null) return inKg;
  final inLb = _number(lb);
  if (inLb != null) return inLb / _lbPerKg;
  final raw = _number(plain) ?? 0;
  return plainIsLb ? raw / _lbPerKg : raw;
}

double? _number(String raw) => raw.isEmpty ? null : double.tryParse(raw.replaceAll(',', '.'));

String? _pick(List<String> cols, List<String> candidates) {
  for (final c in candidates) {
    if (cols.contains(c)) return c;
  }
  return null;
}

String _norm(String s) => s.trim().toLowerCase();

String _dayId(DateTime d) => '${d.year}-${d.month}-${d.day}';

List<String> _header(String csv) {
  final line = _firstLine(csv);
  if (line == null) return const [];
  return _splitLine(line, _delimiter(csv)).map(_norm).toList();
}

String _delimiter(String csv) => (_firstLine(csv) ?? '').contains(';') ? ';' : ',';

int _parseDuration(String s) {
  if (s.isEmpty) return 0;
  var seconds = 0;
  final h = RegExp(r'(\d+)\s*h').firstMatch(s);
  final m = RegExp(r'(\d+)\s*m').firstMatch(s);
  if (h != null) seconds += int.parse(h.group(1)!) * 3600;
  if (m != null) seconds += int.parse(m.group(1)!) * 60;
  return seconds;
}

const _months = {
  'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
  'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
};

DateTime? _parseDate(String s) {
  if (s.isEmpty) return null;
  final iso = DateTime.tryParse(s.replaceFirst(' ', 'T'));
  if (iso != null) return iso;
  final m = RegExp(r'^(\d{1,2})\s+([A-Za-z]{3})[a-z]*\s+(\d{4})(?:,?\s+(\d{1,2}):(\d{2}))?')
      .firstMatch(s.trim());
  if (m == null) return null;
  final month = _months[m.group(2)!.toLowerCase()];
  if (month == null) return null;
  return DateTime(
    int.parse(m.group(3)!),
    month,
    int.parse(m.group(1)!),
    int.tryParse(m.group(4) ?? '') ?? 0,
    int.tryParse(m.group(5) ?? '') ?? 0,
  );
}

String? _firstLine(String csv) {
  for (final line in csv.split('\n')) {
    if (line.trim().isNotEmpty) return line;
  }
  return null;
}

List<String> _splitLine(String line, String delim) {
  final out = <String>[];
  final field = StringBuffer();
  var quoted = false;
  for (var i = 0; i < line.length; i++) {
    final c = line[i];
    if (quoted) {
      if (c == '"') {
        if (i + 1 < line.length && line[i + 1] == '"') {
          field.write('"');
          i++;
        } else {
          quoted = false;
        }
      } else {
        field.write(c);
      }
    } else if (c == '"') {
      quoted = true;
    } else if (c == delim) {
      out.add(field.toString());
      field.clear();
    } else {
      field.write(c);
    }
  }
  out.add(field.toString());
  return out;
}

List<List<String>> _rows(String text, String delim) {
  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var quoted = false;
  var i = 0;
  final n = text.length;

  void endField() {
    row.add(field.toString());
    field.clear();
  }

  void endRow() {
    endField();
    if (row.length > 1 || row.first.trim().isNotEmpty) rows.add(row);
    row = <String>[];
  }

  while (i < n) {
    final c = text[i];
    if (quoted) {
      if (c == '"') {
        if (i + 1 < n && text[i + 1] == '"') {
          field.write('"');
          i += 2;
          continue;
        }
        quoted = false;
        i++;
        continue;
      }
      field.write(c);
      i++;
      continue;
    }
    if (c == '"') {
      quoted = true;
      i++;
      continue;
    }
    if (c == delim) {
      endField();
      i++;
      continue;
    }
    if (c == '\n' || c == '\r') {
      if (c == '\r' && i + 1 < n && text[i + 1] == '\n') i++;
      endRow();
      i++;
      continue;
    }
    field.write(c);
    i++;
  }
  if (field.isNotEmpty || row.isNotEmpty) endRow();
  return rows;
}
