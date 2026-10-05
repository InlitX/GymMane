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
  'ups': 'up', 'downs': 'down', 'climbers': 'climber', 'crushers': 'crusher',
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

String sortedKey(String raw) => (nameTokens(raw)..sort()).join(' ');

final Map<String, String> _keyCache = {};

String _keyOf(String name) => _keyCache.putIfAbsent(name, () => searchKey(name));

final Map<String, String> _aliasIndex = {
  for (final entry in kExerciseAliases.entries)
    for (final alias in entry.value) sortedKey(alias): entry.key,
};

typedef ExerciseFilter = bool Function(Exercise);

ExerciseFilter exerciseSearch(String query) {
  final plain = query.trim().toLowerCase();
  if (plain.isEmpty) return (_) => true;
  final key = searchKey(query);

  return (e) {
    final label = exerciseName(e);
    if (e.name.toLowerCase().contains(plain) || label.toLowerCase().contains(plain)) return true;
    if (e.aliases.any((a) => a.toLowerCase().contains(plain))) return true;
    if (key.isEmpty) return false;
    if (_keyOf(e.name).contains(key) || _keyOf(label).contains(key)) return true;
    if (e.aliases.any((a) => _keyOf(a).contains(key))) return true;
    return kExerciseAliases[e.name]?.any((a) => _keyOf(a).contains(key)) ?? false;
  };
}

bool _sameEquipment(Set<String> q, Set<String> c) {
  final qe = q.intersection(_equipment);
  final ce = c.intersection(_equipment);
  if (qe.isEmpty || ce.isEmpty) return true;
  return qe.intersection(ce).isNotEmpty;
}

const _modifiers = {
  'one', 'single', 'arm', 'seated', 'sitted', 'standing', 'lying', 'alternate', 'alternating',
  'wide', 'close', 'narrow', 'grip', 'straight', 'bent', 'over', 'both', 'two', 'double', 'hand',
};

bool _fits(Set<String> qCore, Set<String> q, Set<String> c) {
  if (qCore.isNotEmpty && c.containsAll(qCore)) return true;
  final cMeaning = c.difference(_equipment);
  return cMeaning.length >= 2 && cMeaning.difference(_modifiers).isNotEmpty && q.containsAll(cMeaning);
}

const _legs = {'quads', 'glutes', 'hamstrings', 'calves'};

bool _sameMuscle(String? hint, Exercise e) =>
    hint == null ||
    e.primary == hint ||
    e.secondary.contains(hint) ||
    (_legs.contains(hint) && _legs.contains(e.primary)) ||
    (hint == 'lowerback' && (e.primary == 'hamstrings' || e.primary == 'glutes'));

int _score(Set<String> q, Set<String> c) {
  final shared = q.intersection(c);
  if (shared.difference(_equipment).isEmpty) return 0;
  return shared.length * 3 - c.difference(q).length - q.difference(c).length;
}

const _muscleHints = <List<String>, String>{
  ['hyperextension', 'back extension', 'superman', 'lower back', 'erector', 'deadlift']: 'lowerback',
  ['calf', 'calves', 'soleus']: 'calves',
  ['hamstring', 'leg curl', 'good morning', 'nordic']: 'hamstrings',
  ['glute', 'hip thrust', 'bridge', 'kickback']: 'glutes',
  ['quad', 'squat', 'leg press', 'leg extension', 'lunge', 'step up', 'hack']: 'quads',
  ['oblique', 'twist', 'side bend', 'wood chop', 'russian']: 'obliques',
  ['crunch', 'sit up', 'plank', 'abdominal', 'leg raise', 'hollow', 'v up']: 'abdomen',
  ['shrug', 'trap ', 'trapezius', 'upright row']: 'trapezius',
  ['forearm', 'wrist', 'farmer', 'gripper', 'hand grip']: 'forearm',
  ['triceps', 'pushdown', 'skullcrusher', 'kickback', 'dip']: 'triceps',
  ['biceps', 'curl', 'preacher', 'chin up']: 'biceps',
  ['lateral raise', 'shoulder', 'overhead press', 'military', 'arnold', 'face pull', 'delt', 'upright']:
      'shoulders',
  ['row', 'pulldown', 'pull up', 'pullover', 'lateral pull']: 'back',
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

  for (final e in pool) {
    if (_keyOf(e.name) == key) return e;
  }

  for (final e in pool) {
    if (e.aliases.any((a) => _keyOf(a) == key)) return e;
  }

  final alias = _aliasIndex[sortedKey(name)];
  if (alias != null) {
    final wanted = searchKey(alias);
    for (final e in pool) {
      if (searchKey(e.name) == wanted) return e;
    }
  }

  for (final e in pool) {
    final label = exerciseName(e);
    if (label != e.name && _keyOf(label) == key) return e;
  }

  final q = key.split(' ').toSet();
  final qMeaning = q.difference(_equipment);
  if (qMeaning.isEmpty) return null;
  final qCore = qMeaning.difference(_modifiers);
  final hint = guessMuscle(name);

  Exercise? exact;
  var exactExtra = 1 << 30;
  Exercise? loose;
  var looseScore = 0;

  for (final e in pool) {
    final c = nameTokens(e.name).toSet();
    if (c.isEmpty || !_sameEquipment(q, c) || !_sameMuscle(hint, e)) continue;
    if (c.containsAll(qMeaning)) {
      final extra = c.difference(q).length;
      if (extra < exactExtra) {
        exact = e;
        exactExtra = extra;
      }
    } else if (_fits(qCore, q, c)) {
      final s = _score(q, c);
      if (s > looseScore) {
        loose = e;
        looseScore = s;
      }
    }
  }
  return exact ?? (looseScore >= 3 ? loose : null);
}
