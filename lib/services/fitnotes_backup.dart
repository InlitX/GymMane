import 'sqlite_reader.dart';
import 'workout_import.dart';

const _categoryMuscle = {
  'shoulders': 'shoulders',
  'chest': 'chest',
  'back': 'back',
  'biceps': 'biceps',
  'triceps': 'triceps',
  'forearms': 'forearm',
  'abs': 'abdomen',
  'core': 'abdomen',
  'legs': 'quads',
  'calves': 'calves',
  'glutes': 'glutes',
  'hamstrings': 'hamstrings',
  'quads': 'quads',
  'traps': 'trapezius',
};

const double _lbPerKg = 2.2046226218;

ImportResult? parseFitNotes(List<int> bytes) {
  final db = SqliteDb.open(bytes);
  if (db == null || !db.has('training_log') || !db.has('exercise')) return null;

  final categories = {
    for (final c in db.rows('Category')) _int(c['_id']): _text(c['name']),
  };
  final exercises = {
    for (final e in db.rows('exercise'))
      _int(e['_id']): (
        name: _text(e['name']),
        muscle: _categoryMuscle[(categories[_int(e['category_id'])] ?? '').toLowerCase()],
      ),
  };

  final byDay = <String, ParsedSession>{};
  final perDay = <String, Map<String, ParsedExercise>>{};

  for (final log in db.rows('training_log')) {
    final reps = _int(log['reps']);
    if (reps <= 0) continue;
    final date = _date(_text(log['date']));
    if (date == null) continue;
    final exercise = exercises[_int(log['exercise_id'])];
    if (exercise == null || exercise.name.isEmpty) continue;

    final day = _dayId(date);
    final session = byDay.putIfAbsent(day, () => ParsedSession(date, 0));
    final slot = perDay.putIfAbsent(day, () => {});
    final parsed = slot.putIfAbsent(exercise.name, () {
      final e = ParsedExercise(exercise.name, exercise.muscle);
      session.exercises.add(e);
      return e;
    });
    parsed.sets.add(ParsedSet(reps, _double(log['metric_weight'])));
  }

  return ImportResult(
    ImportFormat.fitnotes,
    byDay.values.toList(),
    weights: _weights(db),
  );
}

List<ParsedWeight> _weights(SqliteDb db) {
  if (!db.has('MeasurementRecord') || !db.has('Measurement')) return const [];

  final units = {
    for (final u in db.rows('MeasurementUnit')) _int(u['_id']): _text(u['short_name']).toLowerCase(),
  };
  int? bodyweightId;
  var inLb = false;
  for (final m in db.rows('Measurement')) {
    if (_text(m['name']).toLowerCase() != 'bodyweight') continue;
    bodyweightId = _int(m['_id']);
    inLb = (units[_int(m['unit_id'])] ?? '').startsWith('lb');
  }
  if (bodyweightId == null) return const [];

  final out = <ParsedWeight>[];
  for (final r in db.rows('MeasurementRecord')) {
    if (_int(r['measurement_id']) != bodyweightId) continue;
    final date = _date(_text(r['date']));
    final value = _double(r['value']);
    if (date == null || value <= 0) continue;
    out.add(ParsedWeight(date, inLb ? value / _lbPerKg : value));
  }
  return out;
}

int _int(Object? v) => v is int ? v : (v is double ? v.toInt() : (v is String ? int.tryParse(v) ?? 0 : 0));

double _double(Object? v) =>
    v is double ? v : (v is int ? v.toDouble() : (v is String ? double.tryParse(v) ?? 0 : 0));

String _text(Object? v) => v is String ? v : '';

DateTime? _date(String s) => s.isEmpty ? null : DateTime.tryParse(s.replaceFirst(' ', 'T'));

String _dayId(DateTime d) => '${d.year}-${d.month}-${d.day}';
