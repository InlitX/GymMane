part of 'fit_state.dart';

mixin HealthState on FitCore {
  static const healthDays = 30;

  final Set<HealthMetric> healthShown = {};
  final List<HealthMetric> healthPinned = [];
  Set<HealthMetric> healthGranted = {};
  final Set<HealthMetric> healthFailed = {};
  final Map<HealthMetric, Map<String, List<double>>> healthByDay = {};
  Future<void>? _healthRunning;
  bool hcWeights = false;
  bool hcHeart = false;
  bool hcWrite = false;
  final Set<int> hcSeenWeights = {};

  Future<bool> setHcWrite(bool on) async {
    if (on && !(await HealthMetrics.grantedKeys()).contains('writeWorkouts')) {
      await HealthMetrics.requestKeys(['writeWorkouts']);
      if (!(await HealthMetrics.grantedKeys()).contains('writeWorkouts')) {
        notifyListeners();
        return false;
      }
    }
    hcWrite = on;
    _persist();
    notifyListeners();
    if (on) {
      final since = DateTime.now().subtract(const Duration(days: 30));
      for (final s in sessions.where((s) => s.date.isAfter(since)).toList()) {
        await _sendWorkout(s);
      }
    }
    return true;
  }

  static String healthWorkoutId(LoggedSession s) => 'gymmane-${s.date.millisecondsSinceEpoch}';

  String healthWorkoutType(LoggedSession s) {
    if (s.exercises.isEmpty || s.exercises.any((e) => countsForMuscles(e.id))) return 'strength';
    final id = s.exercises.first.id.toLowerCase();
    if (kSportIcons.containsKey(id)) return id;
    bool has(List<String> words) => words.any(id.contains);
    if (has(['treadmill'])) return 'treadmill';
    if (has(['run', 'jog', 'sprint'])) return 'running';
    if (has(['walk', 'hike'])) return 'walking';
    if (has(['stationary', 'spin', 'assault', 'air-bike', 'airbike'])) return 'stationaryBike';
    if (has(['bike', 'cycl'])) return 'biking';
    if (has(['row'])) return 'rowing';
    if (has(['elliptical'])) return 'elliptical';
    if (has(['stair', 'step-mill', 'stepmill'])) return 'stairs';
    if (has(['swim'])) return 'swimming';
    return 'other';
  }

  String healthWorkoutNotes(LoggedSession s) {
    final text = s.exercises.map((e) => t.catalogName(e.id, e.name)).join(' · ');
    return text.length > 500 ? '${text.substring(0, 497)}…' : text;
  }

  Future<bool> _sendWorkout(LoggedSession s) async {
    if (!hcWrite || s.durationSec <= 0) return false;
    final title = s.name?.trim().isNotEmpty == true ? s.name!.trim() : t.healthWorkoutTitle;
    return HealthMetrics.writeWorkout(
      id: healthWorkoutId(s),
      start: s.day,
      end: s.date,
      type: healthWorkoutType(s),
      title: title,
      notes: healthWorkoutNotes(s),
    );
  }

  @override
  void healthSave(LoggedSession s) {
    if (hcWrite) _sendWorkout(s);
  }

  @override
  void healthForget(LoggedSession s) {
    if (hcWrite) HealthMetrics.deleteWorkout(healthWorkoutId(s));
  }

  Future<bool> setHcWeights(bool on) async {
    if (on && !(await HealthMetrics.grantedKeys()).contains('weight')) {
      await HealthMetrics.requestKeys(['weight']);
      if (!(await HealthMetrics.grantedKeys()).contains('weight')) {
        notifyListeners();
        return false;
      }
    }
    hcWeights = on;
    _persist();
    notifyListeners();
    if (on) await syncHealthExtras();
    return true;
  }

  Future<bool> setHcHeart(bool on) async {
    if (on && !(await HealthMetrics.grantedKeys()).contains('workoutHr')) {
      await HealthMetrics.requestKeys(['workoutHr']);
      if (!(await HealthMetrics.grantedKeys()).contains('workoutHr')) {
        notifyListeners();
        return false;
      }
    }
    hcHeart = on;
    _persist();
    notifyListeners();
    if (on) await syncHealthExtras();
    return true;
  }

  bool importWeighIns(List<List<double>> rows) {
    var added = false;
    for (final r in rows) {
      final at = DateTime.fromMillisecondsSinceEpoch(r[0].round());
      final kg = r[1];
      final key = r[0].round() ~/ 60000;
      if (!kg.isFinite || kg < 20 || kg > 400 || !hcSeenWeights.add(key)) continue;
      final dup = bodyweight.any((b) => (b.date.difference(at).inMinutes).abs() <= 120 && (b.kg - kg).abs() < 0.06);
      if (dup) continue;
      bodyweight.add(BodyweightEntry(at, (kg * 100).round() / 100));
      added = true;
    }
    if (added) bodyweight.sort((a, b) => a.date.compareTo(b.date));
    return added;
  }

  bool applyWorkoutHeart(LoggedSession s, List<List<double>> samples) {
    final start = s.day.millisecondsSinceEpoch, end = s.date.millisecondsSinceEpoch;
    final bpm = [
      for (final r in samples)
        if (r[0] >= start && r[0] <= end && r[1] > 30 && r[1] < 240) r[1],
    ];
    if (bpm.length < 3) return false;
    s.hrAvg = (bpm.reduce((a, b) => a + b) / bpm.length).round();
    s.hrMax = bpm.reduce((a, b) => a > b ? a : b).round();
    return true;
  }

  Future<void> syncHealthExtras() async {
    if (!hcWeights && !hcHeart) return;
    final keys = await HealthMetrics.grantedKeys();
    final now = DateTime.now();
    var dirty = false;
    if (hcWeights && keys.contains('weight')) {
      final rows = await HealthMetrics.readKey('weight', now.subtract(const Duration(days: 30)), now);
      if (rows != null && importWeighIns(rows)) dirty = true;
    }
    if (hcHeart && keys.contains('workoutHr')) {
      final since = now.subtract(const Duration(days: 2));
      for (final s in sessions.where((s) => s.hrAvg == null && s.date.isAfter(since)).toList()) {
        final rows = await HealthMetrics.readKey('workoutHr', s.day, s.date);
        if (rows != null && applyWorkoutHeart(s, rows)) dirty = true;
      }
    }
    if (!dirty) return;
    _persist();
    notifyListeners();
  }

  List<HealthMetric> get healthMetrics => [for (final m in HealthMetric.values) if (healthShown.contains(m)) m];

  List<HealthMetric> get healthTop {
    final pinned = [for (final m in healthPinned) if (healthShown.contains(m)) m];
    if (pinned.isNotEmpty) return pinned;
    const preferred = [HealthMetric.sleep, HealthMetric.restingHr, HealthMetric.activeKcal];
    return [
      ...[for (final m in preferred) if (healthShown.contains(m)) m],
      ...[for (final m in healthMetrics) if (!preferred.contains(m)) m],
    ].take(3).toList();
  }

  void toggleHealthPin(HealthMetric m) {
    final current = healthTop;
    healthPinned
      ..clear()
      ..addAll(current);
    if (healthPinned.contains(m)) {
      if (healthPinned.length > 1) healthPinned.remove(m);
    } else if (healthPinned.length < 3) {
      healthPinned.add(m);
    }
    _persist();
    notifyListeners();
  }

  Future<bool> allowAllHealth() async {
    final missing = [for (final m in HealthMetric.values) if (!healthGranted.contains(m)) m.name];
    if (!(await HealthMetrics.grantedKeys()).contains('steps')) missing.add('steps');
    if (missing.isNotEmpty) {
      await HealthMetrics.requestKeys(missing);
      healthGranted = await HealthMetrics.granted();
    }
    if ((await HealthMetrics.grantedKeys()).contains('steps')) await stepsAllowed();
    final now = [for (final m in HealthMetric.values) if (healthGranted.contains(m)) m];
    if (now.isEmpty) {
      notifyListeners();
      return false;
    }
    healthShown.addAll(now);
    _persist();
    notifyListeners();
    await _healthRunning;
    await refreshHealth();
    return now.length == HealthMetric.values.length;
  }

  void loadHealth(Map<String, dynamic>? j) {
    hcWeights = j?['w'] == true;
    hcHeart = j?['hr'] == true;
    hcWrite = j?['wo'] == true;
    hcSeenWeights
      ..clear()
      ..addAll([for (final k in (j?['seen'] as List?) ?? const []) if (k is num) k.toInt()]);
    final byName = HealthMetric.values.asNameMap();
    healthShown
      ..clear()
      ..addAll([for (final k in (j?['on'] as List?) ?? const []) ?byName[k]]);
    healthPinned
      ..clear()
      ..addAll([for (final k in (j?['pin'] as List?) ?? const []) ?byName[k]]);
    healthByDay.clear();
    ((j?['days'] as Map?) ?? const {}).forEach((k, v) {
      final m = byName[k];
      if (m == null || v is! Map) return;
      healthByDay[m] = v.map((d, xs) => MapEntry(d as String, [for (final x in xs as List) (x as num).toDouble()]));
    });
  }

  Map<String, dynamic> healthJson() => {
        if (healthShown.isNotEmpty) 'on': [for (final m in healthMetrics) m.name],
        if (healthPinned.isNotEmpty) 'pin': [for (final m in healthPinned) m.name],
        if (healthByDay.isNotEmpty) 'days': {for (final e in healthByDay.entries) e.key.name: e.value},
        if (hcWeights) 'w': true,
        if (hcHeart) 'hr': true,
        if (hcWrite) 'wo': true,
        if (hcSeenWeights.isNotEmpty) 'seen': [...hcSeenWeights.toList()..sort()].reversed.take(400).toList(),
      };

  List<double>? healthOnDay(HealthMetric m, DateTime day) => healthByDay[m]?[HealthMetrics.dayKey(day)];

  ({DateTime day, List<double> values})? healthLatest(HealthMetric m) {
    final days = healthByDay[m];
    if (days == null || days.isEmpty) return null;
    final key = days.keys.reduce((a, b) => a.compareTo(b) >= 0 ? a : b);
    return (day: DateTime.parse(key), values: days[key]!);
  }

  List<DateTime> healthLastDays(int n) {
    final now = DateTime.now();
    return [for (var i = n - 1; i >= 0; i--) DateTime(now.year, now.month, now.day - i)];
  }

  List<double?> healthSeries(HealthMetric m, int n) =>
      [for (final d in healthLastDays(n)) healthOnDay(m, d)?.first];

  Future<void> refreshHealth() => _healthRunning ??= () async {
        await _syncHealth();
        await syncHealthExtras();
      }()
          .whenComplete(() => _healthRunning = null);

  Future<void> _syncHealth() async {
    if (healthShown.isEmpty) return;
    final granted = await HealthMetrics.granted();
    var dirty = !setEquals(granted, healthGranted);
    healthGranted = granted;
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day - healthDays + 1);
    final to = DateTime(now.year, now.month, now.day + 1);
    for (final m in healthMetrics) {
      if (!granted.contains(m)) continue;
      final rows = await HealthMetrics.read(m, from, to);
      if (rows == null) {
        dirty |= healthFailed.add(m);
        continue;
      }
      dirty |= healthFailed.remove(m);
      final days = HealthMetrics.byDay(m, rows);
      if (_sameDays(healthByDay[m], days)) continue;
      healthByDay[m] = days;
      dirty = true;
    }
    if (!dirty) return;
    _persist();
    notifyListeners();
  }

  static bool _sameDays(Map<String, List<double>>? a, Map<String, List<double>> b) {
    if (a == null || a.length != b.length) return false;
    for (final e in b.entries) {
      final o = a[e.key];
      if (o == null || !listEquals(o, e.value)) return false;
    }
    return true;
  }

  Future<bool> setHealthMetric(HealthMetric m, bool on) async {
    if (on && !healthGranted.contains(m)) {
      final ok = await HealthMetrics.request([m]);
      healthGranted = await HealthMetrics.granted();
      if (!ok && !healthGranted.contains(m)) {
        notifyListeners();
        return false;
      }
    }
    if (on) {
      healthShown.add(m);
    } else {
      healthShown.remove(m);
      healthByDay.remove(m);
    }
    _persist();
    notifyListeners();
    if (on) {
      await _healthRunning;
      await refreshHealth();
    }
    return true;
  }
}
