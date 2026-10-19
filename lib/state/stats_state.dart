part of 'fit_state.dart';

mixin StatsState on FitCore, ToolsState, LibraryState, SettingsState, TimelineState {
  List<Exercise> recommendedExercises(int n) {
    final muscles = suggestedFocus.muscles;
    final pool = kExercises.where((e) => !noSuggest.contains(e.id) && !isArchived(e.id) && fitsHere(e));
    final picks = [for (final m in muscles) ...pool.where((e) => e.primary == m).take(1)];

    for (final e in pool) {
      if (picks.length >= n) break;
      if (muscles.contains(e.primary) && !picks.contains(e)) picks.add(e);
    }
    return picks.take(n).toList();
  }

  int get athleteLevel => 1 + totalSessions ~/ 10;

  int get sessionsToNextLevel => 10 - totalSessions % 10;

  List<BodyweightEntry> get bodyweightTrend {
    final list = [...bodyweight]..sort((a, b) => a.date.compareTo(b.date));
    final out = <BodyweightEntry>[];
    for (final e in list) {
      if (out.isEmpty) {
        out.add(BodyweightEntry(e.date, e.kg));
        continue;
      }
      final prev = out.last;
      final days = math.max(1, e.date.difference(prev.date).inHours / 24);
      final keep = math.pow(0.9, days).toDouble();
      out.add(BodyweightEntry(e.date, prev.kg * keep + e.kg * (1 - keep)));
    }
    return out;
  }

  BodyweightEntry? get latestBodyweight =>
      bodyweight.isEmpty ? null : bodyweight.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

  List<double> get bodyweightSeries {
    final sorted = [...bodyweight]..sort((a, b) => a.date.compareTo(b.date));
    return sorted.map((e) => e.kg).toList();
  }

  void addBodyweight(double kg) {
    bodyweight.add(BodyweightEntry(DateTime.now(), _round3(kg)));
    profile.weightKg = _round3(kg);
    _seedCalculatorsFromProfile();
    _persist();
    notifyListeners();
  }

  int get todayIndex => (DateTime.now().weekday - weekStartDay + 7) % 7;

  int weekdayAt(int i) => (weekStartDay - 1 + i) % 7 + 1;

  DateTime get weekStartDate => _weekStart;

  DateTime get _weekStart => shiftDays(_dayKey(DateTime.now()), -todayIndex);

  Iterable<LoggedSession> get _thisWeekSessions {
    final start = _weekStart;
    final end = shiftDays(start, 7);
    return sessions.where((s) {
      final k = _dayKey(s.day);
      return !k.isBefore(start) && k.isBefore(end);
    });
  }

  List<double> _dailyVolumes(int days) {
    final today = _dayKey(DateTime.now());
    final byDay = <DateTime, double>{};
    for (final s in sessions) {
      final k = _dayKey(s.day);
      byDay[k] = (byDay[k] ?? 0) + s.volume;
    }
    return List.generate(days, (i) {
      final d = shiftDays(today, i - (days - 1));
      return byDay[d] ?? 0;
    });
  }

  double _volumeBetween(DateTime start, DateTime end) =>
      sessions.where((s) => s.day.isAfter(start) && !s.day.isAfter(end)).fold(0.0, (a, s) => a + s.volume);

  bool get hasData => sessions.isNotEmpty;
  int get totalSessions => sessions.length;

  (String, String) get trainedSpan {
    final secs = sessions.fold<int>(0, (n, s) => n + s.durationSec);
    final hours = secs ~/ 3600;
    if (hours < 48) return ('$hours', t.unitHours);
    return ('${hours ~/ 24}', t.unitDays);
  }

  (String, String) liftedSpanOf(double kg) {
    final shown = toDisplayWeight(kg);
    if (shown < 1000) return (shown.round().toString(), units);
    final k = shown / 1000;
    return (
      k >= 10 ? k.round().toString() : decimalText(k.toStringAsFixed(1)),
      units == 'kg' ? 't' : 'k $units',
    );
  }

  (String, String) get liftedSpan => liftedSpanOf(totalVolumeKg);
  int get totalSets => sessions.fold(0, (n, s) => n + s.setCount);

  double get totalVolumeKg => sessions.fold(0.0, (a, s) => a + s.volume);

  Duration get totalTime => Duration(seconds: sessions.fold(0, (n, s) => n + s.durationSec));

  Duration get averageSession =>
      sessions.isEmpty ? Duration.zero : Duration(seconds: totalTime.inSeconds ~/ sessions.length);

  int get statsYear => DateTime.now().year;

  List<int> get sessionsByMonth {
    final out = List.filled(12, 0);
    for (final s in sessions) {
      if (s.day.year == statsYear) out[s.day.month - 1]++;
    }
    return out;
  }

  double get volumeThisYearKg =>
      sessions.where((s) => s.day.year == statsYear).fold(0.0, (a, s) => a + s.volume);

  int get sessionsThisYear => sessionsByMonth.fold(0, (a, b) => a + b);

  int get monthsTrainedThisYear => sessionsByMonth.where((n) => n > 0).length;

  int get bestMonthThisYear {
    final months = sessionsByMonth;
    var best = 0;
    for (var i = 1; i < 12; i++) {
      if (months[i] > months[best]) best = i;
    }
    return months[best] == 0 ? 0 : best + 1;
  }

  Map<int, int> get sessionsByWeekday {
    final out = {for (int w = 1; w <= 7; w++) w: 0};
    for (final s in sessions) {
      out[s.day.weekday] = out[s.day.weekday]! + 1;
    }
    return out;
  }

  int get busiestWeekday {
    final by = sessionsByWeekday;
    final top = by.values.fold(0, (m, v) => v > m ? v : m);
    if (top == 0) return 0;
    final tied = by.entries.where((e) => e.value == top).toList();
    return tied.length == 1 ? tied.first.key : 0;
  }

  double get volume30dKg {
    final now = DateTime.now();
    return _volumeBetween(now.subtract(const Duration(days: 30)), now);
  }

  int? get volumeChangePct {
    final now = DateTime.now();
    final cur = _volumeBetween(now.subtract(const Duration(days: 30)), now);
    final prev = _volumeBetween(
      now.subtract(const Duration(days: 60)),
      now.subtract(const Duration(days: 30)),
    );
    if (prev <= 0) return null;
    return (((cur - prev) / prev) * 100).round();
  }

  List<double> get volumeChartPoints {
    final daily = _dailyVolumes(30);
    final cum = <double>[];
    double run = 0;
    for (final v in daily) {
      run += v;
      cum.add(run);
    }
    const n = 12;
    return List.generate(n, (i) {
      final idx = ((cum.length - 1) * i / (n - 1)).round();
      return cum[idx];
    });
  }

  List<int> get heatmapLevels => heatmapLevelsFor(kHeatmapDays);

  List<int> heatmapLevelsFor(int days) {
    final active = <DateTime>{..._checkinDays};
    final load = <DateTime, double>{};
    for (final s in sessions) {
      final k = _dayKey(s.day);
      active.add(k);
      load[k] = (load[k] ?? 0) + s.volume;
    }
    final today = _dayKey(DateTime.now());
    final keys = List.generate(days, (i) => shiftDays(today, i - (days - 1)));
    final lifted = [
      for (final k in keys)
        if ((load[k] ?? 0) > 0) load[k]!,
    ]..sort();
    return [
      for (final k in keys)
        if (!active.contains(k))
          0
        else if ((load[k] ?? 0) <= 0)
          1
        else if (lifted.length < 2)
          heatLevels
        else
          1 + (lifted.indexOf(load[k]!) / (lifted.length - 1) * (heatLevels - 1)).round(),
    ];
  }

  DateTime heatmapDate(int i) => shiftDays(_dayKey(DateTime.now()), i - (kHeatmapDays - 1));

  List<LoggedSession> sessionsOn(DateTime day) {
    final k = _dayKey(day);
    return sessions.where((s) => _dayKey(s.day) == k).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  void _releaseLevel(LoggedSession s, Iterable<String> ids) {
    final ms = s.date.millisecondsSinceEpoch;
    for (final id in ids) {
      final shown = levelShown[id];
      if (shown == null || shown.first != ms) continue;
      if (shown.last == 0) {
        levelSeen.remove(id);
      } else {
        levelSeen[id] = shown.last;
      }
      levelShown.remove(id);
    }
  }

  DateTime historyMonth = DateTime(DateTime.now().year, DateTime.now().month);

  void goHistory({DateTime? month}) {
    final m = month ?? DateTime.now();
    historyMonth = DateTime(m.year, m.month);
    pushRoute('history');
  }

  bool get historyAtLatest {
    final now = DateTime.now();
    return !historyMonth.isBefore(DateTime(now.year, now.month));
  }

  void shiftHistoryMonth(int delta) {
    final next = DateTime(historyMonth.year, historyMonth.month + delta);
    final now = DateTime.now();
    if (next.isAfter(DateTime(now.year, now.month))) return;
    historyMonth = next;
    notifyListeners();
  }

  List<LoggedSession> sessionsInMonth(DateTime month) {
    final list = [
      for (final s in sessions)
        if (s.day.year == month.year && s.day.month == month.month) s,
    ];
    list.sort((a, b) => b.day.compareTo(a.day));
    return list;
  }

  ({int workouts, int seconds, int sets, double volume}) monthSummary(DateTime month) {
    var workouts = 0, seconds = 0, sets = 0;
    var volume = 0.0;
    for (final s in sessions) {
      if (s.day.year != month.year || s.day.month != month.month) continue;
      workouts++;
      seconds += s.durationSec;
      sets += s.setCount;
      volume += s.volume;
    }
    return (workouts: workouts, seconds: seconds, sets: sets, volume: volume);
  }

  double _setScore(String id, LoggedSet s) {
    if ((s.km ?? 0) > 0) return s.km!;
    if (s.weight > 0 || isAssisted(id)) return liftScore(id, s);
    if (s.reps > 0) return s.reps.toDouble();
    return (s.sec ?? 0).toDouble();
  }

  LoggedSet? topSetOf(LoggedExercise e) {
    LoggedSet? best;
    for (final s in e.workingSets) {
      if (best == null || _setScore(e.id, s) > _setScore(e.id, best)) best = s;
    }
    return best;
  }

  Map<LoggedSession, int> recordsBySession() {
    final ordered = [...sessions]..sort((a, b) => a.date.compareTo(b.date));
    final best = <String, double>{};
    final out = <LoggedSession, int>{};
    for (final s in ordered) {
      var n = 0;
      for (final e in s.exercises) {
        final top = topSetOf(e);
        if (top == null) continue;
        final score = _setScore(e.id, top);
        final before = best[e.id];
        if (before != null && score > before + 1e-9) n++;
        if (before == null || score > before) best[e.id] = score;
      }
      if (n > 0) out[s] = n;
    }
    return out;
  }

  String sessionHeading(LoggedSession s) {
    final named = sessionTitle(s);
    if (named != null && named.trim().isNotEmpty) return named;
    final count = <String, int>{};
    for (final e in s.exercises) {
      final g = muscleGroup(e.primary);
      count[g] = (count[g] ?? 0) + e.workingSets.length;
    }
    final groups = count.keys.toList()..sort((a, b) => count[b]!.compareTo(count[a]!));
    return groups.take(2).map(t.muscleGroupName).join(' · ');
  }

  String? sessionTitle(LoggedSession s) {
    final name = s.name;
    if (name != null) return name;
    final r = routines.where((r) => r.id == s.routineId).firstOrNull;
    if (r == null) return null;
    return r.name.isEmpty ? t.newRoutineName : r.name;
  }

  String workoutText(LoggedSession s) {
    String line(LoggedSet x) {
      if (x.km != null) return '${distanceLabel(x.km!)} · ${durationLabel(x.sec ?? 0)}';
      if (x.sec != null && x.reps == 0) return durationLabel(x.sec!);
      return x.weight > 0 ? '${weightLabel(x.weight)} × ${x.reps}' : t.repCount(x.reps);
    }

    final title = sessionTitle(s);
    final out = [
      ?title,
      s.durationSec > 0 ? '${t.longDate(s.day)} · ${s.durationSec ~/ 60} min' : t.longDate(s.day),
    ];
    var reps = 0;
    for (final e in s.exercises) {
      out
        ..add('')
        ..add(t.catalogName(e.id, e.name));
      for (final x in e.sets) {
        if (x.counts) reps += x.reps;
        out.add('  ${line(x)}');
      }
    }
    out
      ..add('')
      ..add('${t.setCount(s.setCount)} · ${t.repCount(reps)} · ${volumeLabel(s.volume)}');
    return out.join('\n');
  }

  void deleteSession(LoggedSession s) {
    sessions.remove(s);
    _releaseLevel(s, s.exercises.map((e) => e.id));
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  void setSessionDuration(LoggedSession s, int seconds) {
    if (!sessions.contains(s) || seconds < 0 || seconds == s.durationSec) return;
    s.durationSec = seconds;
    persistNow();
    notifyListeners();
  }

  void deleteLoggedExercise(LoggedSession s, LoggedExercise e) {
    s.exercises.remove(e);
    if (s.exercises.isEmpty) sessions.remove(s);
    _releaseLevel(s, [e.id]);
    persistNow();
    notifyListeners();
  }

  void _replaceLoggedSet(LoggedExercise e, int i, {int? reps, double? weight, int? sec, double? km}) {
    if (i < 0 || i >= e.sets.length) return;
    final old = e.sets[i];
    e.sets[i] = LoggedSet(
      reps ?? old.reps,
      weight ?? old.weight,
      kind: old.kind,
      rpe: old.rpe,
      sec: sec ?? old.sec,
      km: km ?? old.km,
    );
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  void setLoggedReps(LoggedExercise e, int i, int reps) => _replaceLoggedSet(e, i, reps: reps.clamp(0, 999));

  void setLoggedWeight(LoggedExercise e, int i, double kg) =>
      _replaceLoggedSet(e, i, weight: _round3(kg.clamp(0, 1000)));

  void bumpLoggedSec(LoggedExercise e, int i, int d) {
    if (i < 0 || i >= e.sets.length) return;
    final now = e.sets[i].sec ?? 0;
    final step = now >= 600 ? 30 : 5;
    _replaceLoggedSet(e, i, sec: ((now ~/ step) * step + d * step).clamp(0, 86400));
  }

  void bumpLoggedKm(LoggedExercise e, int i, int dir) {
    if (i < 0 || i >= e.sets.length) return;
    final shown = toDisplayKm(e.sets[i].km ?? 0);
    final next = math.max(0.0, ((shown / distanceStep).round() + dir) * distanceStep);
    _replaceLoggedSet(e, i, km: _round3(fromDisplayKm(next)));
  }

  bool loggedTimed(LoggedExercise e) =>
      isTimed(e.id) || e.sets.any((s) => s.sec != null && s.reps <= 0 && (s.km ?? 0) <= 0);

  bool loggedDistance(LoggedExercise e) => isCardio(e.id) || e.sets.any((s) => (s.km ?? 0) > 0);

  void setLoggedWeightShown(LoggedExercise e, int i, double shown) =>
      setLoggedWeight(e, i, fromDisplayWeight(shown));

  void bumpLoggedReps(LoggedExercise e, int i, int d) => setLoggedReps(e, i, e.sets[i].reps + d);

  void bumpLoggedWeight(LoggedExercise e, int i, int dir) {
    final next = _roundTo(toDisplayWeight(e.sets[i].weight), weightStep) + dir * weightStep;
    setLoggedWeight(e, i, fromDisplayWeight(math.max(0, next)));
  }

  void addLoggedSet(LoggedExercise e) {
    final last = e.sets.isNotEmpty ? e.sets.last : LoggedSet(10, isRepsOnly(e.id) ? 0 : 20);
    e.sets.add(LoggedSet(last.reps, last.weight, sec: last.sec, km: last.km));
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  void removeLoggedSet(LoggedSession s, LoggedExercise e, int i) {
    if (i < 0 || i >= e.sets.length) return;
    e.sets.removeAt(i);
    if (e.sets.isEmpty) {
      deleteLoggedExercise(s, e);
      return;
    }
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  void deleteBodyweight(BodyweightEntry e) {
    bodyweight.remove(e);
    final latest = latestBodyweight;
    if (latest != null) {
      profile.weightKg = latest.kg;
      _seedCalculatorsFromProfile();
    }
    persistNow();
    notifyListeners();
  }

  List<BodyweightEntry> get bodyweightHistory => [...bodyweight]..sort((a, b) => b.date.compareTo(a.date));

  ({int exercises, int sets, double volume, int durationSec, List<String> names})? daySummary(DateTime day) {
    final k = _dayKey(day);
    final ofDay = sessions.where((s) => _dayKey(s.day) == k).toList();
    if (ofDay.isEmpty) return null;
    final names = <String>[];
    for (final s in ofDay) {
      for (final e in s.exercises) {
        final n = t.catalogName(e.id, e.name);
        if (!names.contains(n)) names.add(n);
      }
    }
    return (
      exercises: names.length,
      sets: ofDay.fold(0, (a, s) => a + s.setCount),
      volume: ofDay.fold(0.0, (a, s) => a + s.volume),
      durationSec: ofDay.fold(0, (a, s) => a + s.durationSec),
      names: names,
    );
  }

  Iterable<DateTime> get _checkinDays sync* {
    for (final id in checkins) {
      final p = id.split('-');
      if (p.length != 3) continue;
      final y = int.tryParse(p[0]), m = int.tryParse(p[1]), d = int.tryParse(p[2]);
      if (y != null && m != null && d != null) yield DateTime(y, m, d);
    }
  }

  int get currentStreak {
    final days = {...sessions.map((s) => _dayKey(s.day)), ..._checkinDays};
    if (days.isEmpty) return 0;
    final first = days.reduce((a, b) => a.isBefore(b) ? a : b);
    bool rest(DateTime d) => weeklyPlan.isNotEmpty && !weeklyPlan.containsKey(d.weekday);
    var cursor = _dayKey(DateTime.now());
    if (!days.contains(cursor)) cursor = shiftDays(cursor, -1);
    var n = 0;
    while (!cursor.isBefore(first)) {
      if (days.contains(cursor)) {
        n++;
      } else if (!rest(cursor)) {
        break;
      }
      cursor = shiftDays(cursor, -1);
    }
    return n;
  }

  List<bool> get weekMask {
    final start = _weekStart;
    final days = sessions.map((s) => _dayKey(s.day)).toSet();
    return List.generate(7, (i) => days.contains(shiftDays(start, i)));
  }

  String _dayId(DateTime d) => '${d.year}-${d.month}-${d.day}';

  DateTime _dateForWeekday(int i) => shiftDays(_weekStart, i);

  DateTime dateForWeekday(int i) => _dateForWeekday(i);

  bool _hasSessionOn(DateTime day) {
    final k = _dayKey(day);
    return sessions.any((s) => _dayKey(s.day) == k);
  }

  bool isDayDone(int i) {
    final d = _dateForWeekday(i);
    return _hasSessionOn(d) || checkins.contains(_dayId(d));
  }

  bool isSessionDay(int i) => _hasSessionOn(_dateForWeekday(i));

  bool canToggleDay(int i) => i <= todayIndex;

  void toggleCheckin(int i) {
    if (!canToggleDay(i)) return;
    final d = _dateForWeekday(i);
    if (_hasSessionOn(d)) return;
    final id = _dayId(d);
    if (checkins.contains(id)) {
      checkins.remove(id);
    } else {
      checkins.add(id);
    }
    _persist();
    _refreshWidgets();
    refreshAwards();
    notifyListeners();
  }

  int get sessionsThisWeek => _thisWeekSessions.length;

  double get volumeThisWeekKg => _thisWeekSessions.fold(0.0, (a, s) => a + s.volume);

  int get weekSetCount => _thisWeekSessions.fold(0, (a, s) => a + s.setCount);

  int get setsToday {
    final t = _dayKey(DateTime.now());
    return sessions.where((s) => _dayKey(s.day) == t).fold(0, (a, s) => a + s.setCount);
  }

  int get weeklyTarget => profile.weeklyGoal <= 0 ? 4 : profile.weeklyGoal;

  int get daysDoneThisWeek => [for (var i = 0; i < 7; i++) isDayDone(i)].where((d) => d).length;

  int get goalPct => ((daysDoneThisWeek / weeklyTarget) * 100).round().clamp(0, 100);

  double headlineWeight(LoggedExercise e) {
    if (!isAssisted(e.id)) return e.topWeight;
    final done = e.workingSets.where((s) => s.reps > 0);
    return done.isEmpty ? e.topWeight : done.map((s) => s.weight).reduce(math.min);
  }

  double get _assistBodyKg => profile.weightKg > 0 ? profile.weightKg : 75;

  double liftScore(String id, LoggedSet s) {
    if (!isAssisted(id)) return s.oneRm;
    if (s.reps <= 0) return 0;
    return math.max(0.0, _assistBodyKg - s.weight) * (1 + s.reps / 30);
  }

  PersonalRecord _record(String id, String name, List<LoggedSet> sets) {
    double top(double Function(LoggedSet) f) => sets.fold(0.0, (m, s) => math.max(m, f(s)));
    if (isAssisted(id)) {
      final done = sets.where((s) => s.reps > 0).toList();
      if (done.isNotEmpty) {
        final least = done.map((s) => s.weight).reduce(math.min);
        return (id: id, name: name, kind: PrKind.weight, best: least, oneRm: top((s) => liftScore(id, s)));
      }
    }
    final kind = PrKind.values.firstWhere((k) => top(k.score) > 0, orElse: () => PrKind.reps);
    return (id: id, name: name, kind: kind, best: top(kind.score), oneRm: top((s) => s.oneRm));
  }

  List<PersonalRecord> get personalRecords {
    final sets = <String, List<LoggedSet>>{};
    final names = <String, String>{};
    for (final s in sessions) {
      for (final e in s.exercises) {
        (sets[e.id] ??= []).addAll(e.workingSets);
        names[e.id] = e.name;
      }
    }
    return [
      for (final e in sets.entries)
        if (e.value.isNotEmpty) _record(e.key, names[e.key]!, e.value),
    ]..sort(
      (a, b) => a.kind != b.kind
          ? a.kind.index.compareTo(b.kind.index)
          : (a.kind == PrKind.weight ? b.oneRm.compareTo(a.oneRm) : b.best.compareTo(a.best)),
    );
  }

  PersonalRecord? exerciseRecord(String id) {
    final sets = [for (final h in exerciseHistory(id)) ...h.ex.workingSets];
    return sets.isEmpty ? null : _record(id, '', sets);
  }

  ({LoggedSet set, DateTime date})? bestSet(String id) {
    final assisted = isAssisted(id);
    ({LoggedSet set, DateTime date})? best;
    for (final h in exerciseHistory(id)) {
      for (final st in h.ex.workingSets) {
        if (st.reps <= 0 || (!assisted && st.weight <= 0)) continue;
        if (best == null || liftScore(id, st) > liftScore(id, best.set)) best = (set: st, date: h.date);
      }
    }
    return best;
  }

  ({double score, DateTime date})? bestWorkout(String id, PrKind kind) {
    double score(LoggedExercise e) => switch (kind) {
      PrKind.weight => e.volume,
      PrKind.reps => e.workingSets.fold(0.0, (n, st) => n + st.reps),
      _ => 0,
    };
    ({double score, DateTime date})? best;
    for (final h in exerciseHistory(id)) {
      final v = score(h.ex);
      if (v > 0 && (best == null || v > best.score)) best = (score: v, date: h.date);
    }
    return best;
  }

  String bestWorkoutLabel(double score, PrKind kind) => kind == PrKind.weight
      ? '${fmt(toDisplayWeight(score).roundToDouble())} $units'
      : t.repCount(score.round());

  String recordLabel(PersonalRecord r) => switch (r.kind) {
    PrKind.weight => weightLabel(r.best),
    PrKind.distance => distanceLabel(r.best),
    PrKind.time => durationLabel(r.best.round()),
    PrKind.reps => t.repCount(r.best.round()),
  };

  String recordDetail(PersonalRecord r) => r.kind == PrKind.weight
      ? (isAssisted(r.id) ? t.assistedRecordHint : t.oneRmEst(weightLabel(r.oneRm)))
      : t.prBestSet;

  int get prsThisWeek {
    final kinds = {for (final r in personalRecords) r.id: r.kind};
    final bestScore = <String, double>{};
    final bestDate = <String, DateTime>{};
    for (final s in sessions) {
      for (final e in s.exercises) {
        final kind = kinds[e.id];
        if (kind == null) continue;
        for (final st in e.workingSets) {
          final score = kind == PrKind.weight ? liftScore(e.id, st) : kind.score(st);
          if (score > (bestScore[e.id] ?? 0)) {
            bestScore[e.id] = score;
            bestDate[e.id] = s.date;
          }
        }
      }
    }
    final start = _weekStart;
    final end = shiftDays(start, 7);
    var n = 0;
    bestDate.forEach((_, d) {
      final k = _dayKey(d);
      if (!k.isBefore(start) && k.isBefore(end)) n++;
    });
    return n;
  }

  List<({String name, int pct})> get muscleSplit {
    final start = DateTime.now().subtract(const Duration(days: 30));
    final byGroup = <String, double>{};
    for (final s in sessions) {
      if (s.date.isBefore(start)) continue;
      for (final e in s.exercises) {
        final g = muscleGroup(e.primary);
        byGroup[g] = (byGroup[g] ?? 0) + e.volume;
      }
    }
    final total = byGroup.values.fold(0.0, (a, b) => a + b);
    if (total <= 0) return const [];
    final list =
        byGroup.entries
            .map((e) => (name: t.muscleGroupName(e.key), pct: ((e.value / total) * 100).round()))
            .where((e) => e.pct > 0)
            .toList()
          ..sort((a, b) => b.pct.compareTo(a.pct));
    return list;
  }

  static const double weeklySetTarget = 12;

  double muscleTargetFor(int days) => weeklySetTarget * days / 7;

  Map<String, double> muscleSetsOver(int days) {
    final start = shiftDays(_dayKey(DateTime.now()), -(days - 1));
    final out = <String, double>{};
    for (final s in sessions) {
      if (_dayKey(s.day).isBefore(start)) continue;
      for (final e in s.exercises) {
        final n = e.workingSets.length.toDouble();
        if (n <= 0) continue;
        out[e.primary] = (out[e.primary] ?? 0) + n;
        for (final m in exerciseById(e.id)?.secondary ?? const <String>[]) {
          out[m] = (out[m] ?? 0) + n / 2;
        }
      }
    }
    return out;
  }

  int get bodyWindowDays => photoIntervalDays > 0 ? photoIntervalDays : 30;

  List<BodyWindow> get bodyWindows {
    if (sessions.isEmpty) return const [];
    final step = bodyWindowDays;
    final first = _dayKey(sessions.map((s) => s.day).reduce((a, b) => a.isBefore(b) ? a : b));
    final out = <BodyWindow>[];
    var to = _dayKey(DateTime.now());

    while (!to.isBefore(first) && out.length < 12) {
      final from = DateTime(to.year, to.month, to.day - (step - 1));
      var count = 0;
      var volume = 0.0;
      for (final s in sessions) {
        final d = _dayKey(s.day);
        if (d.isBefore(from) || d.isAfter(to)) continue;
        count++;
        volume += s.volume;
      }
      if (count > 0 || out.isEmpty) {
        out.add((from: from, to: to, heat: muscleHeatBetween(from, to), sessions: count, volume: volume));
      }
      to = DateTime(from.year, from.month, from.day - 1);
    }
    return out;
  }

  Map<String, double> muscleSetsBetween(DateTime from, DateTime to) {
    final a = _dayKey(from), b = _dayKey(to);
    final out = <String, double>{};
    for (final s in sessions) {
      final d = _dayKey(s.day);
      if (d.isBefore(a) || d.isAfter(b)) continue;
      for (final e in s.exercises) {
        final n = e.workingSets.length.toDouble();
        if (n <= 0) continue;
        out[e.primary] = (out[e.primary] ?? 0) + n;
        for (final m in exerciseById(e.id)?.secondary ?? const <String>[]) {
          out[m] = (out[m] ?? 0) + n / 2;
        }
      }
    }
    return out;
  }

  Map<String, double> muscleHeatBetween(DateTime from, DateTime to) {
    final target = muscleTargetFor(daysBetween(from, to) + 1);
    return {for (final e in muscleSetsBetween(from, to).entries) e.key: (e.value / target).clamp(0.0, 1.0)};
  }

  Map<String, double> muscleHeatOver(int days) {
    final target = muscleTargetFor(days);
    return {for (final e in muscleSetsOver(days).entries) e.key: (e.value / target).clamp(0.0, 1.0)};
  }

  static const Map<String, double> _recoveryHours = {
    'chest': 60,
    'back': 60,
    'lowerback': 72,
    'quads': 72,
    'hamstrings': 72,
    'glutes': 72,
    'shoulders': 48,
    'trapezius': 48,
    'biceps': 48,
    'triceps': 48,
    'forearm': 36,
    'calves': 36,
    'abdomen': 36,
    'obliques': 36,
  };

  static const double _fullFatigue = 8;

  double _tau(String muscle) => (_recoveryHours[muscle] ?? 48) / 3;

  double _setEffort(LoggedSet st) {
    final rpe = st.rpe;
    if (rpe == null) return st.kind == SetKind.failure ? 1.2 : 1;
    return ((rpe - 5) / 4).clamp(0.4, 1.3);
  }

  Map<String, double> muscleFatigue({DateTime? now}) {
    final at = now ?? DateTime.now();
    final out = <String, double>{};
    for (final s in sessions) {
      final hours = at.difference(s.date).inMinutes / 60;
      if (hours < 0 || hours > 24 * 8) continue;
      for (final e in s.exercises) {
        final effort = e.workingSets.fold<double>(0, (sum, st) => sum + _setEffort(st));
        if (effort <= 0) continue;
        void add(String m, double share) =>
            out[m] = (out[m] ?? 0) + effort * share * math.exp(-hours / _tau(m));
        add(e.primary, 1);
        for (final m in exerciseById(e.id)?.secondary ?? const <String>[]) {
          add(m, 0.5);
        }
      }
    }
    return out;
  }

  Map<String, double> muscleRecovery({DateTime? now}) {
    final fatigue = muscleFatigue(now: now);
    return {for (final m in kMuscles) m.id: (1 - (fatigue[m.id] ?? 0) / _fullFatigue).clamp(0.0, 1.0)};
  }

  int overallRecovery({DateTime? now}) {
    final r = muscleRecovery(now: now);
    if (r.isEmpty) return 100;
    return (r.values.reduce((a, b) => a + b) / r.length * 100).round();
  }

  int? hoursUntilRecovered(String muscle, {DateTime? now}) {
    final fatigue = muscleFatigue(now: now)[muscle] ?? 0;
    final limit = _fullFatigue * 0.2;
    if (fatigue <= limit) return null;
    return (_tau(muscle) * math.log(fatigue / limit)).ceil();
  }

  List<String> stillRecovering({DateTime? now}) {
    final r = muscleRecovery(now: now);
    final ids = r.keys.where((k) => r[k]! < 0.8).toList()..sort((a, b) => r[a]!.compareTo(r[b]!));
    return ids;
  }

  Map<String, int?> daysSinceTrained({DateTime? now}) {
    final today = _dayKey(now ?? DateTime.now());
    final last = <String, DateTime>{};
    for (final s in sessions) {
      final day = _dayKey(s.day);
      for (final e in s.exercises) {
        if (e.workingSets.isEmpty) continue;
        final seen = last[e.primary];
        if (seen == null || day.isAfter(seen)) last[e.primary] = day;
      }
    }
    return {
      for (final m in kMuscles)
        m.id: last[m.id] == null ? null : math.max(0, (today.difference(last[m.id]!).inHours / 24).round()),
    };
  }

  List<String> untrainedLongest({DateTime? now, int atLeast = 7}) {
    final days = daysSinceTrained(now: now);
    int age(String id) => days[id] ?? 1 << 20;
    final ids = days.keys.where((id) => age(id) >= atLeast).toList()
      ..sort((a, b) => age(b).compareTo(age(a)));
    return ids.take(3).toList();
  }

  List<String> neglectedMuscles(int days) {
    final sets = muscleSetsOver(days);
    if (sets.isEmpty) return const [];
    final threshold = muscleTargetFor(days) / 3;
    final ids = kMuscles.map((m) => m.id).where((id) => (sets[id] ?? 0) < threshold).toList()
      ..sort((a, b) => (sets[a] ?? 0).compareTo(sets[b] ?? 0));
    return ids.take(3).toList();
  }

  List<({DateTime date, LoggedExercise ex})> exerciseHistory(String id) {
    final out = <({DateTime date, LoggedExercise ex})>[];
    for (final s in sessions) {
      for (final e in s.exercises) {
        if (e.id == id) out.add((date: s.date, ex: e));
      }
    }
    out.sort((a, b) => b.date.compareTo(a.date));
    return out;
  }

  List<LoggedSet> lastSetsFor(String id) {
    final h = exerciseHistory(id);
    return h.isEmpty ? const [] : h.first.ex.sets;
  }

  String? lastSummaryFor(String id) {
    final sets = lastSetsFor(id);
    if (sets.isEmpty) return null;
    return setsSummary(sets);
  }

  String setsSummary(List<LoggedSet> sets) => sets.map(loggedSetLabel).join(' · ');

  String loggedSetLabel(LoggedSet s) {
    final km = s.km ?? 0;
    final sec = s.sec;
    if (km > 0) return sec == null ? distanceLabel(km) : '${distanceLabel(km)} · ${durationLabel(sec)}';
    if (sec != null && s.reps <= 0) {
      return s.weight > 0 ? '${weightValue(s.weight)} × ${durationLabel(sec)}' : durationLabel(sec);
    }
    return '${weightValue(s.weight)}×${s.reps}';
  }

  String? strengthExerciseId;

  List<({String id, String name, int sessions})> get trackedExercises {
    final count = <String, int>{};
    final names = <String, String>{};
    for (final s in sessions) {
      for (final e in s.exercises) {
        if (e.topWeight <= 0) continue;
        count[e.id] = (count[e.id] ?? 0) + 1;
        names[e.id] = e.name;
      }
    }
    final list =
        count.entries
            .where((e) => e.value >= 2)
            .map((e) => (id: e.key, name: names[e.key]!, sessions: e.value))
            .toList()
          ..sort((a, b) => b.sessions.compareTo(a.sessions));
    return list;
  }

  String? get activeStrengthId {
    final tracked = trackedExercises;
    if (tracked.isEmpty) return null;
    if (strengthExerciseId != null && tracked.any((e) => e.id == strengthExerciseId)) {
      return strengthExerciseId;
    }
    return tracked.first.id;
  }

  void setStrengthExercise(String id) {
    strengthExerciseId = id;
    notifyListeners();
  }

  @override
  double bestLift(String id) => isAssisted(id) ? 0 : oneRmSeries(id).fold(0.0, math.max);

  List<double> oneRmSeries(String id) {
    final h = exerciseHistory(id).reversed;
    if (isAssisted(id)) {
      return [
        for (final r in h)
          if (r.ex.workingSets.any((s) => s.reps > 0))
            _round1(r.ex.workingSets.where((s) => s.reps > 0).map((s) => s.weight).reduce(math.min)),
      ];
    }
    return h.map((r) => _round1(r.ex.bestOneRm)).toList();
  }

  bool goalFits(String id) => modeOf(id).isEmpty && !isAssisted(id);

  PrKind goalKind(String id) {
    final kind = exerciseRecord(id)?.kind;
    if (kind == PrKind.weight || kind == PrKind.reps) return kind!;
    return isRepsOnly(id) ? PrKind.reps : PrKind.weight;
  }

  double goalBest(String id) {
    final r = exerciseRecord(id);
    return r != null && r.kind == goalKind(id) ? r.best : 0;
  }

  String goalLabel(String id, double value) =>
      goalKind(id) == PrKind.reps ? t.repCount(value.round()) : weightLabel(value);

  void setExerciseGoal(String id, double target, DateTime? due) {
    exerciseGoals[id] = (target: target, due: due == null ? null : _dayKey(due));
    persistNow();
    notifyListeners();
  }

  void clearExerciseGoal(String id) {
    if (exerciseGoals.remove(id) == null) return;
    persistNow();
    notifyListeners();
  }

  List<int> heatmapWeeksFor(int weeks) {
    final tail = 6 - todayIndex;
    return [...heatmapLevelsFor(weeks * 7 - tail), for (var i = 0; i < tail; i++) -1];
  }

  List<int> get heatmapWeeks => heatmapWeeksFor(kHeatmapDays ~/ 7);

  DateTime heatmapWeekDate(int i, {int weeks = kHeatmapDays ~/ 7}) =>
      shiftDays(_weekStart, i - (weeks - 1) * 7);

  int get heatmapYearWeeks {
    DateTime? first;
    for (final s in sessions) {
      final d = _dayKey(s.day);
      if (first == null || d.isBefore(first)) first = d;
    }
    for (final d in _checkinDays) {
      if (first == null || d.isBefore(first)) first = d;
    }
    final back = first == null ? 0 : _weekStart.difference(first).inDays;
    return math.max(53, (back / 7).ceil() + 1);
  }

  int get heatmapShownWeeks => heatmapYear ? heatmapYearWeeks : kHeatmapDays ~/ 7;

  List<int> get heatmapShown => heatmapWeeksFor(heatmapShownWeeks);

  DateTime heatmapShownDate(int i) => heatmapWeekDate(i, weeks: heatmapShownWeeks);

  List<double> bestRepsSeries(String id) => [
    for (final r in exerciseHistory(id).reversed)
      r.ex.sets.where((s) => s.counts).fold(0, (m, s) => math.max(m, s.reps)).toDouble(),
  ];

  static const _habitWindowDays = 120;

  Iterable<LoggedSession> get _recentSessions {
    final now = DateTime.now();
    return sessions.where((s) => now.difference(s.date).inDays <= _habitWindowDays);
  }

  Map<int, int> get _recentByWeekday {
    final out = <int, int>{};
    for (final s in _recentSessions) {
      out[s.day.weekday] = (out[s.day.weekday] ?? 0) + 1;
    }
    return out;
  }

  List<int> get usualWeekdays {
    final counts = _recentByWeekday;
    if (counts.isEmpty) return const [];
    final best = counts.values.reduce(math.max);
    if (best < 2) return const [];
    final cut = (best * 0.6).ceil();
    final days = counts.entries.where((e) => e.value >= cut).map((e) => e.key).toList()..sort();
    return days.length > 6 ? days.sublist(0, 6) : days;
  }

  int? get usualStartMinute {
    final starts = <int>[];
    for (final s in _recentSessions) {
      final start = s.date.subtract(Duration(seconds: s.durationSec));
      starts.add(start.hour * 60 + start.minute);
    }
    if (starts.length < 3) return null;
    starts.sort();
    return (starts[starts.length ~/ 2] ~/ 15) * 15;
  }

  bool get hasTrainingHabit => usualWeekdays.isNotEmpty && usualStartMinute != null;

  String? familyOnWeekday(int weekday) {
    final onDay = _recentSessions.where((s) => s.day.weekday == weekday).toList();
    if (onDay.length < 2) return null;
    final volume = <String, double>{};
    for (final s in onDay) {
      for (final e in s.exercises) {
        final f = muscleFamily(e.primary);
        volume[f] = (volume[f] ?? 0) + e.volume;
      }
    }
    if (volume.isEmpty) return null;
    return volume.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  bool get trainedToday {
    final today = _dayKey(DateTime.now());
    return sessions.any((s) => _dayKey(s.day) == today);
  }

  ({String title, String subtitle, List<String> muscles}) get suggestedFocus {
    final table = {
      'push': (title: t.pushDay, subtitle: t.pushFocus, muscles: ['chest', 'shoulders', 'triceps']),
      'pull': (title: t.pullDay, subtitle: t.pullFocus, muscles: ['back', 'biceps', 'trapezius']),
      'legs': (title: t.legDay, subtitle: t.legFocus, muscles: ['quads', 'hamstrings', 'glutes']),
    };
    var last = '';
    var lastWasRecent = false;
    if (sessions.isNotEmpty) {
      final s = sessions.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
      lastWasRecent = daysBetween(s.date, DateTime.now()) <= 1;
      final fam = <String, double>{};
      for (final e in s.exercises) {
        final f = muscleFamily(e.primary);
        fam[f] = (fam[f] ?? 0) + e.volume;
      }
      if (fam.isNotEmpty) {
        last = fam.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
      }
    }
    const order = ['push', 'pull', 'legs'];
    final today = DateTime.now().weekday;
    final habit = familyOnWeekday(today);
    if (habit != null && order.contains(habit) && !(lastWasRecent && habit == last)) {
      final picked = table[habit]!;
      return (title: picked.title, subtitle: t.habitFocus(t.weekday(today)), muscles: picked.muscles);
    }
    final idx = order.indexOf(last);

    final next = idx >= 0 ? order[(idx + 1) % order.length] : order[today % 3];
    return table[next]!;
  }
}
