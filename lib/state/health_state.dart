part of 'fit_state.dart';

mixin HealthState on FitCore {
  static const healthDays = 30;

  final Set<HealthMetric> healthShown = {};
  final List<HealthMetric> healthPinned = [];
  Set<HealthMetric> healthGranted = {};
  final Map<HealthMetric, Map<String, List<double>>> healthByDay = {};
  Future<void>? _healthRunning;

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
    final missing = [for (final m in HealthMetric.values) if (!healthGranted.contains(m)) m];
    if (missing.isNotEmpty) {
      await HealthMetrics.request(missing);
      healthGranted = await HealthMetrics.granted();
    }
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

  Future<void> refreshHealth() => _healthRunning ??= _syncHealth().whenComplete(() => _healthRunning = null);

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
      if (rows == null) continue;
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
