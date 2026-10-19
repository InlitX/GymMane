part of 'fit_state.dart';

mixin StepsState on FitCore {
  static const _keepDays = 30;

  bool stepsOn = false;
  int stepsGoal = 8000;
  HealthAccess stepsAccess = HealthAccess.unsupported;
  final Map<String, int> stepsByDay = {};
  Future<void>? _stepsRunning;

  static String _sk(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  bool get stepsAvailable => stepsAccess != HealthAccess.unsupported;

  int get stepsToday => stepsOnDay(DateTime.now());

  int stepsOnDay(DateTime day) => stepsByDay[_sk(day)] ?? 0;

  List<DateTime> get stepsWeekDays {
    final now = DateTime.now();
    return [for (var i = 6; i >= 0; i--) DateTime(now.year, now.month, now.day - i)];
  }

  void loadSteps(Map<String, dynamic>? j) {
    stepsOn = j?['on'] as bool? ?? false;
    stepsGoal = ((j?['goal'] as num?)?.toInt() ?? 8000).clamp(1000, 50000);
    stepsByDay
      ..clear()
      ..addAll(((j?['days'] as Map?) ?? const {}).map((k, v) => MapEntry(k as String, (v as num).toInt())));
  }

  Map<String, dynamic> stepsJson() => {
    if (stepsOn) 'on': true,
    if (stepsGoal != 8000) 'goal': stepsGoal,
    if (stepsByDay.isNotEmpty) 'days': stepsByDay,
  };

  Future<void> refreshSteps() => _stepsRunning ??= _syncSteps().whenComplete(() => _stepsRunning = null);

  Future<void> _syncSteps() async {
    final access = await HealthSteps.access();
    final changed = access != stepsAccess;
    stepsAccess = access;
    if (!stepsOn || access != HealthAccess.granted) {
      if (changed) notifyListeners();
      return;
    }
    final counts = await HealthSteps.read(stepsWeekDays);
    if (counts == null) {
      if (changed) notifyListeners();
      return;
    }
    var dirty = false;
    counts.forEach((day, n) {
      final key = _sk(day);
      if (n <= 0 || stepsByDay[key] == n) return;
      stepsByDay[key] = n;
      dirty = true;
    });
    final now = DateTime.now();
    final oldest = _sk(DateTime(now.year, now.month, now.day - _keepDays));
    final before = stepsByDay.length;
    stepsByDay.removeWhere((k, _) => k.compareTo(oldest) < 0);
    if (stepsByDay.length != before) dirty = true;
    if (dirty) _persist();
    if (dirty || changed) notifyListeners();
  }

  Future<bool> setStepsOn(bool on) async {
    if (on && !await HealthSteps.request()) {
      await refreshSteps();
      return false;
    }
    stepsOn = on;
    _persist();
    notifyListeners();
    if (on) await _freshSteps();
    return true;
  }

  Future<void> askStepsAccess() async {
    if (!await HealthSteps.request()) await HealthSteps.openSettings();
    await _freshSteps();
  }

  Future<void> _freshSteps() async {
    await _stepsRunning;
    await refreshSteps();
  }

  void setStepsGoal(int goal) {
    stepsGoal = goal.clamp(1000, 50000);
    _persist();
    notifyListeners();
  }
}
