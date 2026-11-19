part of 'fit_state.dart';

mixin RecoveryState on FitCore, StatsState {
  static const defaultHeatGoal = 60;
  static const defaultColdGoal = 11;

  bool recoveryOn = false;
  bool recoveryTipSeen = false;
  int heatGoalMin = defaultHeatGoal;
  int coldGoalMin = defaultColdGoal;
  final List<RecoveryEntry> recovery = [];
  int _recoverySeq = 0;

  void loadRecovery(Map<String, dynamic>? j) {
    recoveryOn = j?['on'] as bool? ?? false;
    recoveryTipSeen = j?['tip'] as bool? ?? false;
    heatGoalMin = ((j?['hg'] as num?)?.toInt() ?? defaultHeatGoal).clamp(0, 1000);
    coldGoalMin = ((j?['cg'] as num?)?.toInt() ?? defaultColdGoal).clamp(0, 1000);
    recovery
      ..clear()
      ..addAll([
        for (final e in (j?['log'] as List?) ?? const [])
          if (e is Map) ?RecoveryEntry.fromJson(e.cast<String, dynamic>()),
      ]);
    recovery.sort((a, b) => a.date.compareTo(b.date));
  }

  Map<String, dynamic> recoveryJson() => {
        if (recoveryOn) 'on': true,
        if (recoveryTipSeen) 'tip': true,
        if (heatGoalMin != defaultHeatGoal) 'hg': heatGoalMin,
        if (coldGoalMin != defaultColdGoal) 'cg': coldGoalMin,
        if (recovery.isNotEmpty) 'log': recovery.map((e) => e.toJson()).toList(),
      };

  void setRecoveryOn(bool on) {
    if (recoveryOn == on) return;
    recoveryOn = on;
    _persist();
    notifyListeners();
  }

  void goRecovery() => pushRoute('recovery');

  RecoveryEntry addRecovery({
    required String kind,
    required int sec,
    int coldSec = 0,
    double? tempC,
    double? coldTempC,
    int rounds = 1,
    String? pattern,
    String note = '',
    DateTime? date,
    int restSec = 0,
    int? feel,
    List<int> holds = const [],
  }) {
    final when = date ?? DateTime.now();
    final entry = RecoveryEntry(
      id: 'r${when.microsecondsSinceEpoch}-${_recoverySeq++}',
      kind: kind,
      date: when,
      sec: sec.clamp(1, 24 * 3600),
      coldSec: coldSec.clamp(0, 24 * 3600),
      tempC: tempC,
      coldTempC: coldTempC,
      rounds: rounds.clamp(1, 20),
      pattern: pattern,
      note: note.trim(),
      restSec: restSec.clamp(0, 24 * 3600),
      feel: feel,
      holds: holds,
    );
    recovery
      ..add(entry)
      ..sort((a, b) => a.date.compareTo(b.date));
    _persist();
    notifyListeners();
    return entry;
  }

  void setRecoveryFeel(String id, int? feel) {
    final i = recovery.indexWhere((e) => e.id == id);
    if (i < 0) return;
    recovery[i] = recovery[i].withFeel(feel);
    _persist();
    notifyListeners();
  }

  void setRecoveryGoals({int? heat, int? cold}) {
    if (heat != null) heatGoalMin = heat.clamp(0, 1000);
    if (cold != null) coldGoalMin = cold.clamp(0, 1000);
    _persist();
    notifyListeners();
  }

  void seeRecoveryTip() {
    if (recoveryTipSeen) return;
    recoveryTipSeen = true;
    _persist();
    notifyListeners();
  }

  int get bestColdSec =>
      recovery.where((e) => e.kind == 'cold').fold(0, (a, e) => math.max(a, e.sec));

  int get bestHoldSec => recovery.fold(0, (a, e) => math.max(a, e.bestHold));

  void removeRecovery(String id) {
    recovery.removeWhere((e) => e.id == id);
    _persist();
    notifyListeners();
  }

  void restoreRecovery(RecoveryEntry entry) {
    if (recovery.any((e) => e.id == entry.id)) return;
    recovery
      ..add(entry)
      ..sort((a, b) => a.date.compareTo(b.date));
    _persist();
    notifyListeners();
  }

  List<RecoveryEntry> get recoveryRecent => recovery.reversed.toList();

  RecoveryEntry? lastRecovery(String kind) {
    for (final e in recovery.reversed) {
      if (e.kind == kind) return e;
    }
    return null;
  }

  Iterable<RecoveryEntry> _recoveryFrom(DateTime start) => recovery.where((e) => !_dayKey(e.date).isBefore(start));

  ({int heat, int cold, int breath, int sessions}) get recoveryWeek {
    var heat = 0, cold = 0, breath = 0, sessions = 0;
    for (final e in _recoveryFrom(weekStartDate)) {
      heat += e.heatSec;
      cold += e.coldTotalSec;
      if (e.kind == 'breath') breath += e.sec;
      sessions++;
    }
    return (heat: heat, cold: cold, breath: breath, sessions: sessions);
  }

  List<int> get recoveryWeekDays {
    final start = weekStartDate;
    final out = List.filled(7, 0);
    for (final e in _recoveryFrom(start)) {
      final i = _dayKey(e.date).difference(start).inDays;
      if (i >= 0 && i < 7) out[i] += e.totalSec;
    }
    return out;
  }

  int get recoveryStreakWeeks {
    var weeks = 0;
    var start = weekStartDate;
    if (!_recoveryFrom(start).any((_) => true)) start = shiftDays(start, -7);
    while (true) {
      final end = shiftDays(start, 7);
      final any = recovery.any((e) {
        final d = _dayKey(e.date);
        return !d.isBefore(start) && d.isBefore(end);
      });
      if (!any) break;
      weeks++;
      start = shiftDays(start, -7);
    }
    return weeks;
  }
}
