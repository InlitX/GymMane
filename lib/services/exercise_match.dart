import '../catalog/exercise_aliases.dart';
import '../models/exercise.dart';

const _stop = {'the', 'a', 'an', 'with', 'on', 'to', 'and', 'or', 'in', 'for', 'v', 'var'};

const _syn = {
  'lat': 'lateral', 'lats': 'lateral',
  'bicep': 'biceps', 'bicepts': 'biceps',
  'tricep': 'triceps', 'tricepts': 'triceps',
  'db': 'dumbbell', 'bb': 'barbell', 'kb': 'kettlebell', 'bw': 'bodyweight',
  'dumbell': 'dumbbell', 'dumbells': 'dumbbell', 'dumbbells': 'dumbbell',
  'barbells': 'barbell', 'cables': 'cable', 'machines': 'machine', 'bands': 'band',
  'ohp': 'overhead press',
  'pushup': 'push up', 'pushups': 'push up', 'pullup': 'pull up', 'pullups': 'pull up',
  'chinup': 'chin up', 'chinups': 'chin up', 'situp': 'sit up', 'situps': 'sit up',
  'curls': 'curl', 'rows': 'row', 'presses': 'press',
  'squats': 'squat', 'raises': 'raise', 'extensions': 'extension',
  'flyes': 'fly', 'flies': 'fly', 'flys': 'fly',
  'deadlifts': 'deadlift', 'lunges': 'lunge', 'dips': 'dip', 'pulldowns': 'pulldown',
  'legs': 'leg', 'arms': 'arm', 'abs': 'abdominal', 'delts': 'deltoid',
  'lever': 'machine', 'smith': 'machine', 'skullcrusher': 'lying triceps extension',
  'skullcrushers': 'lying triceps extension',
  'rdl': 'romanian deadlift', 'sldl': 'stiff leg deadlift',
};

const _equipment = {
  'barbell', 'dumbbell', 'cable', 'machine', 'smith', 'kettlebell', 'band',
  'bodyweight', 'lever', 'sled', 'weighted', 'assisted', 'ez',
};

List<String> nameTokens(String raw) {
  final flat = raw
      .toLowerCase()
      .replaceAll(RegExp(r'[àáâãä]'), 'a')
      .replaceAll(RegExp(r'[èéêë]'), 'e')
      .replaceAll(RegExp(r'[ìíîï]'), 'i')
      .replaceAll(RegExp(r'[òóôõö]'), 'o')
      .replaceAll(RegExp(r'[ùúûü]'), 'u')
      .replaceAll('ñ', 'n');
  final out = <String>[];
  for (final part in flat.split(RegExp(r'[^a-z0-9]+'))) {
    if (part.isEmpty || _stop.contains(part)) continue;
    final mapped = _syn[part] ?? part;
    out.addAll(mapped.split(' '));
  }
  return out;
}

String searchKey(String raw) => nameTokens(raw).join(' ');

final Map<String, String> _keyCache = {};

String _keyOf(String name) => _keyCache.putIfAbsent(name, () => searchKey(name));

final Map<String, String> _aliasIndex = {
  for (final entry in kExerciseAliases.entries)
    for (final alias in entry.value) searchKey(alias): entry.key,
};

typedef ExerciseFilter = bool Function(Exercise);

ExerciseFilter exerciseSearch(String query) {
  final plain = query.trim().toLowerCase();
  if (plain.isEmpty) return (_) => true;
  final key = searchKey(query);

  return (e) {
    final label = exerciseName(e);
    if (e.name.toLowerCase().contains(plain) || label.toLowerCase().contains(plain)) return true;
    if (key.isEmpty) return false;
    if (_keyOf(e.name).contains(key) || _keyOf(label).contains(key)) return true;
    return kExerciseAliases[e.name]?.any((a) => _keyOf(a).contains(key)) ?? false;
  };
}

bool _sameEquipment(Set<String> q, Set<String> c) {
  final qe = q.intersection(_equipment);
  final ce = c.intersection(_equipment);
  if (qe.isEmpty || ce.isEmpty) return true;
  return qe.intersection(ce).isNotEmpty;
}

int _score(Set<String> q, Set<String> c) {
  final shared = q.intersection(c);
  if (shared.difference(_equipment).isEmpty) return 0;
  return shared.length * 3 - c.difference(q).length - q.difference(c).length;
}

const _muscleHints = <List<String>, String>{
  ['calf', 'calves', 'soleus']: 'calves',
  ['hamstring', 'leg curl', 'good morning', 'nordic']: 'hamstrings',
  ['glute', 'hip thrust', 'bridge', 'kickback']: 'glutes',
  ['quad', 'squat', 'leg press', 'leg extension', 'lunge', 'step up', 'hack']: 'quads',
  ['oblique', 'twist', 'side bend', 'wood chop', 'russian']: 'obliques',
  ['crunch', 'sit up', 'plank', 'abdominal', 'leg raise', 'hollow', 'v up']: 'abdomen',
  ['shrug', 'trap ', 'trapezius', 'upright row']: 'trapezius',
  ['forearm', 'wrist', 'grip', 'farmer']: 'forearm',
  ['triceps', 'pushdown', 'skullcrusher', 'kickback', 'dip']: 'triceps',
  ['biceps', 'curl', 'preacher', 'chin up']: 'biceps',
  ['lateral raise', 'shoulder', 'overhead press', 'military', 'arnold', 'face pull', 'delt', 'upright']:
      'shoulders',
  ['row', 'pulldown', 'pull up', 'pullover', 'lateral pull', 'back extension', 'deadlift']: 'back',
  ['bench press', 'chest', 'fly', 'pec', 'push up', 'press']: 'chest',
};

String? guessMuscle(String name) {
  final flat = ' ${nameTokens(name).join(' ')} ';
  for (final entry in _muscleHints.entries) {
    for (final needle in entry.key) {
      if (flat.contains(' $needle') || flat.contains('$needle ')) return entry.value;
    }
  }
  return null;
}

Exercise? matchExercise(String name, Iterable<Exercise> pool) {
  final key = searchKey(name);
  if (key.isEmpty) return null;

  final alias = _aliasIndex[key];
  if (alias != null) {
    final wanted = searchKey(alias);
    for (final e in pool) {
      if (searchKey(e.name) == wanted) return e;
    }
  }

  final q = key.split(' ').toSet();
  final qMeaning = q.difference(_equipment);
  if (qMeaning.isEmpty) return null;

  Exercise? exact;
  var exactExtra = 1 << 30;
  Exercise? loose;
  var looseScore = 0;

  for (final e in pool) {
    final c = nameTokens(e.name).toSet();
    if (c.isEmpty || !_sameEquipment(q, c)) continue;
    if (c.containsAll(qMeaning)) {
      final extra = c.difference(q).length;
      if (extra < exactExtra) {
        exact = e;
        exactExtra = extra;
      }
    } else {
      final s = _score(q, c);
      if (s > looseScore) {
        loose = e;
        looseScore = s;
      }
    }
  }
  if (exact != null) return exact;
  return looseScore >= 5 ? loose : null;
}
