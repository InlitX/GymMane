part of 'fit_state.dart';

typedef _Best = ({double score, double weight, double volume, List<(int, double)> front});

mixin StatsState on FitCore, ToolsState, LibraryState, SettingsState, TimelineState {
  List<Exercise> recommendedExercises(int n) {
    final muscles = suggestedFocus.muscles;
    final pool = kExercises.where((e) => e.kind != 'sport' && !noSuggest.contains(e.id) && !isArchived(e.id) && fitsHere(e));
    final picks = [
      for (final m in muscles) ...pool.where((e) => e.primary == m).take(1),
    ];

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

  void addBodyweight(double kg, {String note = ''}) {
    bodyweight.add(BodyweightEntry(DateTime.now(), _round3(kg), note: note.trim()));
    profile.weightKg = _round3(kg);
    _seedCalculatorsFromProfile();
    _persist();
    notifyListeners();
  }

  int get todayIndex => (DateTime.now().weekday - weekStartDay + 7) % 7;

  int weekdayAt(int i) => (weekStartDay - 1 + i) % 7 + 1;

  DateTime get weekStartDate => _weekStart;

  DateTime get _weekStart => shiftDays(_dayKey(DateTime.now()), -todayIndex);

  Map<DateTime, List<LoggedSession>> get _byDay => _sessionDays;

  Map<DateTime, double> get _loadByDay => _remember('loadByDay', () => {
        for (final e in _byDay.entries) e.key: e.value.fold(0.0, (a, s) => a + s.volume),
      });

  Iterable<LoggedSession> get _thisWeekSessions {
    final start = _weekStart;
    final byDay = _byDay;
    return [for (var i = 0; i < 7; i++) ...?byDay[shiftDays(start, i)]];
  }

  List<double> _dailyVolumes(int days) {
    final today = _dayKey(DateTime.now());
    final byDay = _loadByDay;
    return List.generate(days, (i) {
      final d = shiftDays(today, i - (days - 1));
      return byDay[d] ?? 0;
    });
  }

  double _volumeBetween(DateTime start, DateTime end) => sessions
      .where((s) => s.day.isAfter(start) && !s.day.isAfter(end))
      .fold(0.0, (a, s) => a + s.volume);

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
    return (k >= 10 ? groupedInt(k.round()) : decimalText(k.toStringAsFixed(1)), units == 'kg' ? 't' : 'k $units');
  }

  (String, String) get liftedSpan => liftedSpanOf(totalVolumeKg);
  int get totalSets => sessions.fold(0, (n, s) => n + s.setCount);

  double get totalVolumeKg => sessions.fold(0.0, (a, s) => a + s.volume);

  Duration get totalTime => Duration(seconds: sessions.fold(0, (n, s) => n + s.durationSec));

  Duration get averageSession => sessions.isEmpty
      ? Duration.zero
      : Duration(seconds: totalTime.inSeconds ~/ sessions.length);

  int get statsYear => DateTime.now().year;

  List<int> get sessionsByMonth {
    final out = List.filled(12, 0);
    for (final s in sessions) {
      if (s.day.year == statsYear) out[s.day.month - 1]++;
    }
    return out;
  }

  double get volumeThisYearKg => sessions
      .where((s) => s.day.year == statsYear)
      .fold(0.0, (a, s) => a + s.volume);

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
        now.subtract(const Duration(days: 60)), now.subtract(const Duration(days: 30)));
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
    final today = _dayKey(DateTime.now());
    return List.of(_remember(('heat', days), () => _heatLevels(days, today), today));
  }

  List<int> _heatLevels(int days, DateTime today) {
    final active = <DateTime>{..._checkinDays, ..._byDay.keys};
    final load = _loadByDay;
    final keys = List.generate(days, (i) => shiftDays(today, i - (days - 1)));
    final lifted = [for (final k in keys) if ((load[k] ?? 0) > 0) load[k]!]..sort();
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

  DateTime heatmapDate(int i) =>
      shiftDays(_dayKey(DateTime.now()), i - (kHeatmapDays - 1));

  List<LoggedSession> sessionsOn(DateTime day) {
    return [...?_byDay[_dayKey(day)]]
      ..sort((a, b) => b.date.compareTo(a.date));
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

  void goHistoryTab() {
    final now = DateTime.now();
    historyMonth = DateTime(now.year, now.month);
    _setRoute('history', reset: true);
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
    if (!s.counts) return 0;
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

  bool _beats(String id, LoggedSet st, _Best? best) {
    if (best == null || !st.counts || st.reps <= 0 && (st.sec ?? 0) <= 0 && (st.km ?? 0) <= 0) return false;
    if (_setScore(id, st) > best.score + 1e-9) return true;
    if (isAssisted(id) || st.weight <= 0) return false;
    if (st.weight > best.weight + 1e-9 || st.weight * st.reps > best.volume + 1e-9) return true;
    return _newOnLadder(id, st, best);
  }

  bool _newOnLadder(String id, LoggedSet st, _Best best) {
    if (!_onLadder(id, st) || st.weight < best.weight * 0.8) return false;
    return !best.front.any((p) => p.$1 >= st.reps && p.$2 >= st.weight - 1e-9);
  }

  bool _onLadder(String id, LoggedSet st) =>
      st.reps > 0 && st.weight > 0 && (st.km ?? 0) <= 0 && (st.sec ?? 0) <= 0 && !isAssisted(id);

  _Best _raise(String id, LoggedSet st, _Best? best) {
    var front = best?.front ?? const <(int, double)>[];
    if (_onLadder(id, st)) {
      front = [
        for (final p in front)
          if (!(st.reps >= p.$1 && st.weight >= p.$2 - 1e-9)) p,
        if (!front.any((p) => p.$1 >= st.reps && p.$2 >= st.weight - 1e-9)) (st.reps, st.weight),
      ];
    }
    return (
      score: math.max(best?.score ?? 0, _setScore(id, st)),
      weight: math.max(best?.weight ?? 0, st.weight),
      volume: math.max(best?.volume ?? 0, st.weight * st.reps),
      front: front,
    );
  }

  Set<LoggedSet> get recordSets => _remember('recordSets', _recordSets);

  Set<LoggedSet> _recordSets() {
    final ordered = [...sessions]..sort((a, b) => a.date.compareTo(b.date));
    final best = <String, _Best>{};
    final out = Set<LoggedSet>.identity();
    for (final s in ordered) {
      for (final e in s.exercises) {
        for (final st in e.workingSets) {
          if (_beats(e.id, st, best[e.id])) out.add(st);
          best[e.id] = _raise(e.id, st, best[e.id]);
        }
      }
    }
    return out;
  }

  _Best? _bestBefore(String id) => _remember(('bestBefore', id), () {
        _Best? best;
        for (final s in sessions) {
          for (final e in s.exercises) {
            if (e.id != id) continue;
            for (final st in e.workingSets) {
              best = _raise(id, st, best);
            }
          }
        }
        return best;
      });

  Map<LoggedSession, int> recordsBySession() => Map.of(_remember('recordsBySession', _recordsBySession));

  Map<LoggedSession, int> _recordsBySession() {
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
    final lifts = s.exercises.where((e) => countsForMuscles(e.id));
    for (final e in lifts.isEmpty ? s.exercises : lifts) {
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
      if (x.sided) {
        final both = t.sidesReps(x.left!, x.right!);
        return x.weight > 0 ? '${weightLabel(x.weight)} × $both' : both;
      }
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
    healthForget(s);
    _releaseLevel(s, s.exercises.map((e) => e.id));
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  void setSessionDuration(LoggedSession s, int seconds) {
    if (!sessions.contains(s) || seconds < 0 || seconds == s.durationSec) return;
    s.durationSec = seconds;
    healthSave(s);
    persistNow();
    notifyListeners();
  }

  void deleteLoggedExercise(LoggedSession s, LoggedExercise e) {
    s.exercises.remove(e);
    if (s.exercises.isEmpty) {
      sessions.remove(s);
      healthForget(s);
    } else {
      healthSave(s);
    }
    _releaseLevel(s, [e.id]);
    persistNow();
    notifyListeners();
  }

  void _replaceLoggedSet(LoggedExercise e, int i,
      {int? reps, int? left, int? right, double? weight, int? sec, double? km}) {
    if (i < 0 || i >= e.sets.length) return;
    final old = e.sets[i];
    var l = old.left;
    var r = old.right;
    if (old.sided) {
      if (reps != null) {
        l = reps;
        r = reps;
      }
      l = left ?? l;
      r = right ?? r;
      reps = l! < r! ? l : r;
    }
    e.sets[i] = LoggedSet(
      reps ?? old.reps,
      weight ?? old.weight,
      kind: old.kind,
      rpe: old.rpe,
      sec: sec ?? old.sec,
      km: km ?? old.km,
      note: old.note,
      left: l,
      right: r,
    );
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  void setLoggedReps(LoggedExercise e, int i, int reps) => _replaceLoggedSet(e, i, reps: reps.clamp(0, 999));

  void setLoggedWeight(LoggedExercise e, int i, double kg) =>
      _replaceLoggedSet(e, i, weight: _round3(kg.clamp(0, 1000)));

  void setLoggedSide(LoggedExercise e, int i, bool leftSide, int reps) {
    if (i < 0 || i >= e.sets.length || !e.sets[i].sided) return;
    final v = reps.clamp(0, 999);
    _replaceLoggedSet(e, i, left: leftSide ? v : null, right: leftSide ? null : v);
  }

  void setLoggedKmShown(LoggedExercise e, int i, double shown) {
    if (i < 0 || i >= e.sets.length) return;
    _replaceLoggedSet(e, i, km: _round3(fromDisplayKmFor(e.id, math.max(0.0, shown))));
  }

  void bumpLoggedSec(LoggedExercise e, int i, int d) {
    if (i < 0 || i >= e.sets.length) return;
    final now = e.sets[i].sec ?? 0;
    final step = now >= 600 ? 30 : 5;
    _replaceLoggedSet(e, i, sec: ((now ~/ step) * step + d * step).clamp(0, 86400));
  }

  void bumpLoggedKm(LoggedExercise e, int i, int dir) {
    if (i < 0 || i >= e.sets.length) return;
    final shown = toDisplayKmFor(e.id, e.sets[i].km ?? 0);
    final next = math.max(0.0, ((shown / distanceStep).round() + dir) * distanceStep);
    _replaceLoggedSet(e, i, km: _round3(fromDisplayKmFor(e.id, next)));
  }

  bool loggedTimed(LoggedExercise e) =>
      isTimed(e.id) || e.sets.any((s) => s.sec != null && s.reps <= 0 && (s.km ?? 0) <= 0);

  bool loggedDistance(LoggedExercise e) => isCardio(e.id) || e.sets.any((s) => (s.km ?? 0) > 0);

  static const double _walkRunMpm = 120;
  static const _walkRunIds = {'running', 'walking', 'treadmill-incline-walk', 'hiking'};
  static final _walkRunName = RegExp(r'\b(walk|run|jog|treadmill|hik|camin|corr|carrer|trot|cinta|sender|marcha)');

  bool walksOrRuns(LoggedExercise e) =>
      _walkRunIds.contains(e.id) || (isCustom(e.id) && _walkRunName.hasMatch(e.name.toLowerCase()));

  double _weightOn(DateTime day) {
    BodyweightEntry? best;
    for (final b in bodyweight) {
      if (!b.date.isAfter(day) && (best == null || b.date.isAfter(best.date))) best = b;
    }
    final kg = best?.kg ?? latestBodyweight?.kg ?? profile.weightKg;
    return kg > 0 ? kg : 75;
  }

  ({int active, int total, int sec, bool own})? cardioKcal(LoggedSession s, LoggedExercise e) {
    if (!walksOrRuns(e)) return null;
    final grade = (e.incline ?? 0) / 100;
    final kg = _weightOn(s.day);
    var active = 0.0, total = 0.0;
    var sec = 0;
    for (final st in e.sets) {
      final km = st.km ?? 0, t = st.sec ?? 0;
      if (km <= 0 || t <= 0) continue;
      final min = t / 60;
      final speed = km * 1000 / min;
      final vo2 = speed < _walkRunMpm
          ? 0.1 * speed + 1.8 * speed * grade + 3.5
          : 0.2 * speed + 0.9 * speed * grade + 3.5;
      total += vo2 * kg * min / 200;
      active += (vo2 - 3.5) * kg * min / 200;
      sec += t;
    }
    final own = e.kcal;
    if (own != null) return (active: own, total: own + (3.5 * kg * sec / 60 / 200).round(), sec: sec, own: true);
    if (sec == 0) return null;
    return (active: active.round(), total: total.round(), sec: sec, own: false);
  }

  double? lastIncline(String id) {
    for (final s in sessions.reversed) {
      for (final e in s.exercises) {
        if (e.id == id && e.incline != null) return e.incline;
      }
    }
    return null;
  }

  void setLoggedIncline(LoggedExercise e, double pct) {
    final v = (pct.clamp(0, 40) * 2).round() / 2;
    e.incline = v > 0 ? v : null;
    persistNow();
    notifyListeners();
  }

  void setLoggedKcal(LoggedExercise e, int? kcal) {
    e.kcal = kcal?.clamp(0, 9999);
    persistNow();
    notifyListeners();
  }

  void setLoggedWeightShown(LoggedExercise e, int i, double shown) =>
      setLoggedWeight(e, i, fromDisplayWeight(shown));

  void bumpLoggedReps(LoggedExercise e, int i, int d) =>
      setLoggedReps(e, i, e.sets[i].reps + d);

  void bumpLoggedSide(LoggedExercise e, int i, bool leftSide, int d) {
    final s = e.sets[i];
    if (!s.sided) return;
    final v = ((leftSide ? s.left! : s.right!) + d).clamp(0, 999);
    _replaceLoggedSet(e, i, left: leftSide ? v : null, right: leftSide ? null : v);
  }

  void bumpLoggedWeight(LoggedExercise e, int i, int dir) {
    final next = _roundTo(toDisplayWeight(e.sets[i].weight), weightStep) + dir * weightStep;
    setLoggedWeight(e, i, fromDisplayWeight(math.max(0, next)));
  }

  void addLoggedSet(LoggedExercise e) {
    final last = e.sets.isNotEmpty ? e.sets.last : LoggedSet(10, isRepsOnly(e.id) ? 0 : 20);
    e.sets.add(LoggedSet(last.reps, last.weight, sec: last.sec, km: last.km, left: last.left, right: last.right));
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

  List<BodyweightEntry> get bodyweightHistory =>
      [...bodyweight]..sort((a, b) => b.date.compareTo(a.date));

  ({int exercises, int sets, double volume, int durationSec, List<String> names})? daySummary(
      DateTime day) {
    final k = _dayKey(day);
    final ofDay = _sessionsOnDay(k);
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
    final today = _dayKey(DateTime.now());
    return _remember('streak', _streak, today);
  }

  static const looseRestDays = 2;

  int _streak() {
    final days = {..._byDay.keys, ..._checkinDays};
    if (days.isEmpty) return 0;
    final first = days.reduce((a, b) => a.isBefore(b) ? a : b);
    final loose = rotating;
    bool rest(DateTime d) =>
        daysOff.containsKey(_dayId(d)) || (!loose && weeklyPlan.isNotEmpty && !weeklyPlan.containsKey(d.weekday));
    var cursor = _dayKey(DateTime.now());
    if (!days.contains(cursor)) cursor = shiftDays(cursor, -1);
    var n = 0, gap = 0;
    while (!cursor.isBefore(first)) {
      if (days.contains(cursor)) {
        n++;
        gap = 0;
      } else if (!rest(cursor) && ++gap > (loose ? looseRestDays : 0)) {
        break;
      }
      cursor = shiftDays(cursor, -1);
    }
    return n;
  }

  static const dayOffReasons = ['sick', 'travel', 'injury', 'rest'];

  String dayIdOf(DateTime d) => _dayId(d);

  String? dayOffOn(DateTime d) => daysOff[_dayId(d)];

  bool isCheckedIn(DateTime d) => checkins.contains(_dayId(d));

  void setDayOff(DateTime d, String? reason) {
    final id = _dayId(d);
    if (reason == null || !dayOffReasons.contains(reason)) {
      if (daysOff.remove(id) == null) return;
    } else {
      daysOff[id] = reason;
      checkins.remove(id);
    }
    _persist();
    _refreshWidgets();
    syncTrainReminder();
    refreshAwards();
    notifyListeners();
  }

  void setCheckedIn(DateTime d, bool on) {
    final id = _dayId(d);
    if (_hasSessionOn(d) || on == checkins.contains(id)) return;
    if (on) {
      checkins.add(id);
      daysOff.remove(id);
    } else {
      checkins.remove(id);
    }
    _persist();
    _refreshWidgets();
    refreshAwards();
    notifyListeners();
  }

  List<bool> get weekMask {
    final start = _weekStart;
    final days = _byDay;
    return List.generate(7, (i) => days.containsKey(shiftDays(start, i)));
  }

  String _dayId(DateTime d) => '${d.year}-${d.month}-${d.day}';

  DateTime _dateForWeekday(int i) => shiftDays(_weekStart, i);

  DateTime dateForWeekday(int i) => _dateForWeekday(i);

  bool _hasSessionOn(DateTime day) => _byDay.containsKey(_dayKey(day));

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
      daysOff.remove(id);
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
    return _sessionsOnDay(DateTime.now()).fold(0, (a, s) => a + s.setCount);
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
    if (!s.counts) return 0;
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

  List<PersonalRecord> get personalRecords => List.of(_remember('records', _personalRecords));

  List<PersonalRecord> _personalRecords() {
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
    ]..sort((a, b) => a.kind != b.kind
        ? a.kind.index.compareTo(b.kind.index)
        : (a.kind == PrKind.weight ? b.oneRm.compareTo(a.oneRm) : b.best.compareTo(a.best)));
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

  List<({int reps, double kg, DateTime date})> repRecords(String id) {
    if (modeOf(id).isNotEmpty || isRepsOnly(id) || isAssisted(id)) return const [];
    final best = <int, ({double kg, DateTime date})>{};
    for (final h in exerciseHistory(id)) {
      for (final st in h.ex.workingSets) {
        if (st.reps <= 0 || st.weight <= 0) continue;
        final had = best[st.reps];
        if (had == null || st.weight > had.kg || (st.weight == had.kg && h.date.isBefore(had.date))) {
          best[st.reps] = (kg: st.weight, date: h.date);
        }
      }
    }
    final out = <({int reps, double kg, DateTime date})>[];
    var floor = 0.0;
    for (final r in best.keys.toList()..sort((a, b) => b.compareTo(a))) {
      final b = best[r]!;
      if (b.kg <= floor) continue;
      out.add((reps: r, kg: b.kg, date: b.date));
      floor = b.kg;
    }
    final ladder = out.reversed.toList();
    if (ladder.length <= 5) return ladder;
    return [for (var i = 0; i < 5; i++) ladder[(i * (ladder.length - 1) / 4).round()]];
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

  int get prsThisWeek => _remember('prsThisWeek', _prsThisWeek, _weekStart);

  int _prsThisWeek() {
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
    final list = byGroup.entries
        .map((e) => (name: t.muscleGroupName(e.key), pct: ((e.value / total) * 100).round()))
        .where((e) => e.pct > 0)
        .toList()
      ..sort((a, b) => b.pct.compareTo(a.pct));
    return list;
  }

  static const double weeklySetTarget = 12;

  double muscleTargetFor(int days) => weeklySetTarget * days / 7;

  @override
  bool countsForMuscles(String id) {
    final ex = exerciseById(id);
    if (ex == null) return !isCardio(id);
    final kind = kindOf(ex);
    return kind != 'cardio' && kind != 'sport';
  }

  Map<String, double> muscleSetsOver(int days) {
    final today = _dayKey(DateTime.now());
    return Map.of(_remember(('setsOver', days), () => _muscleSetsFrom(shiftDays(today, -(days - 1))), today));
  }

  Map<String, double> _muscleSetsFrom(DateTime start) {
    final out = <String, double>{};
    for (final s in sessions) {
      if (_dayKey(s.day).isBefore(start)) continue;
      for (final e in s.exercises) {
        final n = e.workingSets.length.toDouble();
        if (n <= 0 || !countsForMuscles(e.id)) continue;
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
    return List.of(_remember('bodyWindows', () => _bodyWindows(step), (_dayKey(DateTime.now()), step)));
  }

  List<BodyWindow> _bodyWindows(int step) {
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
        out.add((
          from: from,
          to: to,
          heat: muscleHeatBetween(from, to),
          sessions: count,
          volume: volume,
        ));
      }
      to = DateTime(from.year, from.month, from.day - 1);
    }
    return out;
  }

  Map<String, double> muscleSetsBetween(DateTime from, DateTime to) {
    final a = _dayKey(from), b = _dayKey(to);
    return Map.of(_remember(('setsBetween', a, b), () => _muscleSetsBetween(a, b)));
  }

  Map<String, double> _muscleSetsBetween(DateTime a, DateTime b) {
    final out = <String, double>{};
    for (final s in sessions) {
      final d = _dayKey(s.day);
      if (d.isBefore(a) || d.isAfter(b)) continue;
      for (final e in s.exercises) {
        final n = e.workingSets.length.toDouble();
        if (n <= 0 || !countsForMuscles(e.id)) continue;
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
    return {
      for (final e in muscleSetsBetween(from, to).entries)
        e.key: (e.value / target).clamp(0.0, 1.0),
    };
  }

  Map<String, double> muscleHeatOver(int days) {
    final target = muscleTargetFor(days);
    return {
      for (final e in muscleSetsOver(days).entries) e.key: (e.value / target).clamp(0.0, 1.0),
    };
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
    return {
      for (final m in kMuscles) m.id: (1 - (fatigue[m.id] ?? 0) / _fullFatigue).clamp(0.0, 1.0),
    };
  }

  int overallRecovery({DateTime? now}) {
    final r = muscleRecovery(now: now);
    if (r.isEmpty) return 100;
    return (r.values.reduce((a, b) => a + b) / r.length * 100).round();
  }

  int? hoursUntilRecovery(String muscle, double target, {DateTime? now}) {
    final fatigue = muscleFatigue(now: now)[muscle] ?? 0;
    final limit = _fullFatigue * (1 - target.clamp(0.0, 0.99));
    if (fatigue <= limit) return null;
    return (_tau(muscle) * math.log(fatigue / limit)).ceil();
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
    return Map.of(_remember('daysSince', () => _daysSinceTrained(today), today));
  }

  Map<String, int?> _daysSinceTrained(DateTime today) {
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
    final ids = days.keys.where((id) => age(id) >= atLeast).toList()..sort((a, b) => age(b).compareTo(age(a)));
    return ids.take(3).toList();
  }

  Map<String, double> get muscleSetsThisWeek => muscleSetsBetween(_weekStart, DateTime.now());

  Map<String, double> get muscleHeatThisWeek {
    final target = muscleTargetFor(7);
    return {
      for (final e in muscleSetsThisWeek.entries) e.key: (e.value / target).clamp(0.0, 1.0),
    };
  }

  List<String> get neglectedThisWeek => _neglected(muscleSetsThisWeek, todayIndex + 1);

  List<String> neglectedMuscles(int days) => _neglected(muscleSetsOver(days), days);

  List<String> _neglected(Map<String, double> sets, int days) {
    if (sets.isEmpty) return const [];
    final threshold = muscleTargetFor(days) / 3;
    final ids = kMuscles.map((m) => m.id).where((id) => (sets[id] ?? 0) < threshold).toList()
      ..sort((a, b) => (sets[a] ?? 0).compareTo(sets[b] ?? 0));
    return ids.take(3).toList();
  }

  List<({DateTime date, LoggedExercise ex})> exerciseHistory(String id) =>
      List.of(_remember('history', _historyIndex)[id] ?? const []);

  Map<String, List<({DateTime date, LoggedExercise ex})>> _historyIndex() {
    final out = <String, List<({DateTime date, LoggedExercise ex})>>{};
    for (final s in sessions) {
      for (final e in s.exercises) {
        (out[e.id] ??= []).add((date: s.date, ex: e));
      }
    }
    for (final list in out.values) {
      list.sort((a, b) => b.date.compareTo(a.date));
    }
    return out;
  }

  Set<LoggedExercise> get _lightExercises => _remember('lightEx', () => Set<LoggedExercise>.identity()
    ..addAll([for (final s in sessions) if (s.deload) ...s.exercises]));

  List<({DateTime date, LoggedExercise ex})> progressHistory(String id) {
    final light = _lightExercises;
    return [for (final h in exerciseHistory(id)) if (!light.contains(h.ex)) h];
  }

  List<LoggedSet> lastSetsFor(String id) {
    final h = exerciseHistory(id);
    if (h.isEmpty) return const [];
    final light = _lightExercises;
    for (final e in h) {
      if (!light.contains(e.ex)) return e.ex.sets;
    }
    return h.first.ex.sets;
  }

  String? lastSummaryFor(String id) {
    final sets = lastSetsFor(id);
    if (sets.isEmpty) return null;
    return setsSummary(sets);
  }

  String setsSummary(List<LoggedSet> sets) =>
      sets.map((s) => s.rpe == null ? loggedSetLabel(s) : '${loggedSetLabel(s)} ${effortTag(s.rpe!)}').join(' · ');

  String loggedSetLabel(LoggedSet s, {String? id}) {
    final km = s.km ?? 0;
    final sec = s.sec;
    final w = id == null ? weightValue(s.weight) : weightValueFor(id, s.weight);
    final d = id == null ? distanceLabel(km) : distanceLabelFor(id, km);
    if (km > 0) return sec == null ? d : '$d · ${durationLabel(sec)}';
    if (sec != null && s.reps <= 0) {
      return s.weight > 0 ? '$w × ${durationLabel(sec)}' : durationLabel(sec);
    }
    return s.sided ? '$w×${t.sidesReps(s.left!, s.right!)}' : '$w×${s.reps}';
  }

  String? strengthExerciseId;

  static const _ratioSteps = {
    'EIeI8Vf': ([0.8, 1.15, 1.5, 2.0], [0.5, 0.7, 1.0, 1.3]),
    'qXTaZnJ': ([1.0, 1.4, 1.9, 2.5], [0.75, 1.1, 1.5, 1.9]),
    'ila4NZS': ([1.25, 1.75, 2.25, 3.0], [1.0, 1.35, 1.75, 2.3]),
    'Kyd9Rz5': ([0.5, 0.7, 0.95, 1.25], [0.35, 0.45, 0.65, 0.85]),
    'kTbSH9h': ([0.5, 0.7, 0.95, 1.25], [0.35, 0.45, 0.65, 0.85]),
    'eZyBC3j': ([0.6, 0.85, 1.15, 1.5], [0.4, 0.6, 0.8, 1.05]),
  };

  static const balanceLifts = <(String, double, List<String>)>[
    ('qXTaZnJ', 1.0, ['qXTaZnJ']),
    ('ila4NZS', 1.2, ['ila4NZS']),
    ('EIeI8Vf', 0.75, ['EIeI8Vf']),
    ('eZyBC3j', 0.52, ['eZyBC3j']),
    ('Kyd9Rz5', 0.45, ['Kyd9Rz5', 'kTbSH9h']),
  ];

  DateTime get recapMonth {
    final now = DateTime.now();
    final last = DateTime(now.year, now.month - 1);
    final early = now.day <= 7 && sessions.any((s) => s.day.year == last.year && s.day.month == last.month);
    return early ? last : DateTime(now.year, now.month);
  }

  MonthRecap recapFor(DateTime month) => _remember(('recap', month.year, month.month), () => _recap(month));

  MonthRecap _recap(DateTime month) {
    final from = DateTime(month.year, month.month);
    final to = DateTime(month.year, month.month + 1);
    final inMonth = [for (final s in sessions) if (!s.day.isBefore(from) && s.day.isBefore(to)) s];
    final days = <int>{for (final s in inMonth) s.day.day};
    var seconds = 0, sets = 0;
    var volume = 0.0;
    LoggedSession? longest;
    final byExercise = <String, double>{};
    final setsOf = <String, int>{};
    final timesOf = <String, int>{};
    final bestOf = <String, double>{};
    final weekdays = <int, int>{};
    final starts = <int>[];
    for (final s in inMonth) {
      seconds += s.durationSec;
      sets += s.setCount;
      volume += s.volume;
      if (longest == null || s.durationSec > longest.durationSec) longest = s;
      weekdays[s.day.weekday] = (weekdays[s.day.weekday] ?? 0) + 1;
      starts.add(s.day.hour * 60 + s.day.minute);
      for (final e in s.exercises) {
        if (e.volume > 0) byExercise[e.id] = (byExercise[e.id] ?? 0) + e.volume;
        final n = e.workingSets.length;
        if (n == 0) continue;
        setsOf[e.id] = (setsOf[e.id] ?? 0) + n;
        timesOf[e.id] = (timesOf[e.id] ?? 0) + 1;
        if (e.topWeight > (bestOf[e.id] ?? 0)) bestOf[e.id] = e.topWeight;
      }
    }
    String? topExercise;
    var topVolume = 0.0;
    for (final e in byExercise.entries) {
      if (e.value > topVolume) {
        topVolume = e.value;
        topExercise = e.key;
      }
    }
    final muscles = muscleSetsBetween(from, shiftDays(to, -1));
    String? topMuscle;
    var topSets = 0.0;
    for (final e in muscles.entries) {
      if (e.value > topSets) {
        topSets = e.value;
        topMuscle = e.key;
      }
    }
    final records = <({String id, double kg})>[];
    final seen = <String>{};
    for (final s in inMonth) {
      for (final e in s.exercises) {
        if (!seen.add(e.id) || modeOf(e.id).isNotEmpty || isAssisted(e.id) || isRepsOnly(e.id)) continue;
        var before = 0.0, now = 0.0, kg = 0.0;
        for (final h in exerciseHistory(e.id)) {
          final day = h.date;
          if (day.isBefore(from)) {
            if (h.ex.bestOneRm > before) before = h.ex.bestOneRm;
          } else if (day.isBefore(to) && h.ex.bestOneRm > now) {
            now = h.ex.bestOneRm;
            kg = h.ex.topWeight;
          }
        }
        if (before > 0 && now > before) records.add((id: e.id, kg: kg));
      }
    }
    records.sort((a, b) => b.kg.compareTo(a.kg));
    int? favDay;
    var favCount = 0;
    for (final e in weekdays.entries) {
      if (e.value > favCount) {
        favCount = e.value;
        favDay = e.key;
      }
    }
    starts.sort();
    String? liftId;
    for (final e in setsOf.entries) {
      if (exerciseById(e.key) == null) continue;
      if (liftId == null || e.value > setsOf[liftId]! ||
          (e.value == setsOf[liftId]! && (byExercise[e.key] ?? 0) > (byExercise[liftId] ?? 0))) {
        liftId = e.key;
      }
    }
    return MonthRecap(
      month: from,
      workouts: inMonth.length,
      days: days,
      seconds: seconds,
      longest: longest,
      sets: sets,
      volumeKg: volume,
      topExercise: topExercise,
      topExerciseKg: topVolume,
      heat: muscleHeatBetween(from, shiftDays(to, -1)),
      topMuscle: topMuscle,
      topMuscleSets: topSets.round(),
      records: records,
      favDay: favCount >= 2 ? favDay : null,
      usualStart: starts.length >= 3 ? (starts[starts.length ~/ 2] ~/ 15) * 15 : null,
      weekdays: [for (var d = 1; d <= 7; d++) weekdays[d] ?? 0],
      lift: liftId == null
          ? null
          : (
              id: liftId,
              sets: setsOf[liftId]!,
              times: timesOf[liftId]!,
              bestKg: bestOf[liftId] ?? 0,
              volumeKg: byExercise[liftId] ?? 0,
            ),
      sessionMinutes: [for (final s in inMonth) s.durationSec ~/ 60],
      topLifts: ([
        for (final e in setsOf.entries)
          if (exerciseById(e.key) != null && !isCardio(e.key)) (id: e.key, sets: e.value),
      ]..sort((a, b) => b.sets.compareTo(a.sets)))
          .take(5)
          .toList(),
      exerciseIds: (setsOf.keys.where((id) => exerciseById(id) != null).toList()
        ..sort((a, b) => setsOf[b]!.compareTo(setsOf[a]!))),
    );
  }

  static const _pushMuscles = {'chest', 'shoulders', 'triceps'};
  static const _pullMuscles = {'back', 'biceps', 'trapezius'};

  List<({String kind, String text, String? exerciseId})> get weekInsights =>
      _remember('insights', _weekInsights, (_dayKey(DateTime.now()), weekStartDay, t.localeName));

  List<({String kind, String text, String? exerciseId})> _weekInsights() {
    final today = _dayKey(DateTime.now());
    final lastHit = <String, DateTime>{};
    final visits = <String, int>{};
    final recent = <String>{};
    var push = 0, pull = 0;
    for (final s in sessions) {
      final day = _dayKey(s.day);
      final age = today.difference(day).inDays;
      if (age < 0 || age > 56) continue;
      final seen = <String>{};
      for (final e in s.exercises) {
        final n = e.workingSets.length;
        if (n == 0 || !countsForMuscles(e.id)) continue;
        seen.add(e.primary);
        final was = lastHit[e.primary];
        if (was == null || day.isAfter(was)) lastHit[e.primary] = day;
        if (age <= 28) {
          if (_pushMuscles.contains(e.primary)) push += n;
          if (_pullMuscles.contains(e.primary)) pull += n;
          if (modeOf(e.id).isEmpty && !isAssisted(e.id) && !isRepsOnly(e.id)) recent.add(e.id);
        }
      }
      for (final m in seen) {
        visits[m] = (visits[m] ?? 0) + 1;
      }
    }
    final out = <({String kind, String text, String? exerciseId})>[];

    final start = _weekStart;
    final weeks = List<int>.filled(5, 0);
    for (final s in sessions) {
      final day = _dayKey(s.day);
      if (day.isAfter(today)) continue;
      final back = start.difference(day).inDays;
      final i = back <= 0 ? 0 : 1 + (back - 1) ~/ 7;
      if (i < weeks.length) weeks[i] += s.setCount;
    }
    final before = weeks.sublist(1).where((w) => w > 0).toList();
    if (before.length >= 3 && weeks[0] >= 12) {
      final avg = before.fold(0, (a, b) => a + b) / before.length;
      if (weeks[0] >= avg * 1.5) {
        out.add((kind: 'load', text: t.insightLoad(((weeks[0] / avg - 1) * 100).round()), exerciseId: null));
      }
    }

    String? forgotten;
    var gap = 13;
    for (final e in lastHit.entries) {
      final days = today.difference(e.value).inDays;
      if ((visits[e.key] ?? 0) >= 2 && days > gap) {
        gap = days;
        forgotten = e.key;
      }
    }
    if (forgotten != null) {
      out.add((kind: 'muscle', text: t.insightMuscle(muscleLabel(forgotten), gap), exerciseId: null));
    }

    if (push + pull >= 20) {
      if (push >= pull * 1.6) {
        out.add((kind: 'balance', text: t.insightPushHeavy(push, pull), exerciseId: null));
      } else if (pull >= push * 1.6) {
        out.add((kind: 'balance', text: t.insightPullHeavy(pull, push), exerciseId: null));
      }
    }

    String? best;
    var gain = 0.03;
    for (final id in recent) {
      var now = 0.0, then = 0.0;
      for (final h in exerciseHistory(id)) {
        final age = today.difference(_dayKey(h.date)).inDays;
        if (age > 90) break;
        final rm = h.ex.bestOneRm;
        if (age <= 28) {
          if (rm > now) now = rm;
        } else if (rm > then) {
          then = rm;
        }
      }
      if (then <= 0 || now <= 0) continue;
      final g = now / then - 1;
      if (g > gain) {
        gain = g;
        best = id;
      }
    }
    if (best != null) {
      final ex = exerciseById(best);
      if (ex != null) {
        out.add((kind: 'up', text: t.insightStronger(exerciseName(ex), (gain * 100).round()), exerciseId: best));
      }
    }
    return out.take(3).toList();
  }

  ({List<({String id, double kg, double target, double score})> lifts, String? behind})? get structuralBalance =>
      _remember('balance', _structuralBalance, _dayKey(DateTime.now()));

  ({List<({String id, double kg, double target, double score})> lifts, String? behind})? _structuralBalance() {
    final since = DateTime.now().subtract(const Duration(days: 120));
    final found = <(String, double, double)>[];
    for (final (id, ratio, ids) in balanceLifts) {
      var best = 0.0;
      for (final any in ids) {
        for (final h in exerciseHistory(any)) {
          if (h.date.isBefore(since)) break;
          if (h.ex.bestOneRm > best) best = h.ex.bestOneRm;
        }
      }
      if (best > 0) found.add((id, ratio, best));
    }
    if (found.length < 3) return null;
    final implied = [for (final f in found) f.$3 / f.$2]..sort();
    final mid = implied.length.isOdd
        ? implied[implied.length ~/ 2]
        : (implied[implied.length ~/ 2 - 1] + implied[implied.length ~/ 2]) / 2;
    final lifts = [
      for (final (id, ratio, kg) in found) (id: id, kg: kg, target: mid * ratio, score: kg / (mid * ratio)),
    ];
    final low = lifts.reduce((a, b) => a.score <= b.score ? a : b);
    return (lifts: lifts, behind: low.score < 0.9 ? low.id : null);
  }

  void rateSession(LoggedSession s, {required bool sleep, int? value}) {
    if (!sessions.contains(s)) return;
    final v = value?.clamp(1, 5);
    if (sleep) {
      if (s.sleep == v) return;
      s.sleep = v;
    } else {
      if (s.energy == v) return;
      s.energy = v;
    }
    _persist();
    notifyListeners();
  }

  Map<LoggedSession, double> get _sessionForm => _remember('sessionForm', () {
        final out = <LoggedSession, double>{};
        final best = <String, List<(DateTime, double)>>{};
        for (final s in sessions) {
          final ratios = <double>[];
          for (final e in s.exercises) {
            final rm = e.bestOneRm;
            if (rm <= 0) continue;
            final past = best[e.id] ??= [];
            final since = s.date.subtract(const Duration(days: 90));
            past.removeWhere((p) => p.$1.isBefore(since));
            if (past.isNotEmpty) {
              final top = past.map((p) => p.$2).reduce(math.max);
              ratios.add(rm / top);
            }
            past.add((s.date, rm));
          }
          if (ratios.isNotEmpty && (s.sleep != null || s.energy != null)) {
            out[s] = ratios.reduce((a, b) => a + b) / ratios.length;
          }
        }
        return out;
      });

  ({bool sleep, int pct, int low, int high})? _readinessEffect(bool sleep) {
    final low = <double>[], high = <double>[];
    for (final MapEntry(key: s, value: form) in _sessionForm.entries) {
      final v = sleep ? s.sleep : s.energy;
      if (v == null) continue;
      if (v <= 2) low.add(form);
      if (v >= 4) high.add(form);
    }
    if (low.length < 3 || high.length < 3) return null;
    double mean(List<double> l) => l.reduce((a, b) => a + b) / l.length;
    final pct = ((mean(low) / mean(high) - 1) * 100).round();
    return (sleep: sleep, pct: pct, low: low.length, high: high.length);
  }

  ({bool sleep, int pct, int low, int high})? get readinessEffect {
    final a = _readinessEffect(true), b = _readinessEffect(false);
    if (a == null || b == null) return a ?? b;
    return a.pct.abs() >= b.pct.abs() ? a : b;
  }

  ({int rated, double? sleep, double? energy}) get readinessRecent {
    final since = DateTime.now().subtract(const Duration(days: 30));
    final sl = <int>[], en = <int>[];
    var rated = 0;
    for (final s in sessions) {
      if (s.sleep == null && s.energy == null) continue;
      rated++;
      if (s.date.isBefore(since)) continue;
      if (s.sleep != null) sl.add(s.sleep!);
      if (s.energy != null) en.add(s.energy!);
    }
    double? avg(List<int> l) => l.isEmpty ? null : l.reduce((a, b) => a + b) / l.length;
    return (rated: rated, sleep: avg(sl), energy: avg(en));
  }

  ({double ratio, int level, double toNext})? relativeStrength(String id) {
    final steps = _ratioSteps[id];
    final body = latestBodyweight?.kg ?? profile.weightKg;
    if (steps == null || body <= 0) return null;
    final since = DateTime.now().subtract(const Duration(days: 90));
    var best = 0.0;
    for (final h in exerciseHistory(id)) {
      if (h.date.isBefore(since)) break;
      best = math.max(best, h.ex.bestOneRm);
    }
    if (best <= 0) return null;
    final ratio = best / body;
    final cuts = profile.sex == 'female' ? steps.$2 : steps.$1;
    final level = cuts.where((c) => ratio >= c).length;
    final lo = level == 0 ? 0.0 : cuts[level - 1];
    final toNext = level >= cuts.length ? 1.0 : ((ratio - lo) / (cuts[level] - lo)).clamp(0.0, 1.0);
    return (ratio: ratio, level: level, toNext: toNext);
  }

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
    final list = count.entries
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
    return [
      for (final r in h)
        if (r.ex.bestOneRm > 0) _round1(r.ex.bestOneRm),
    ];
  }

  bool canShowRelative(String id) =>
      modeOf(id).isEmpty &&
      !isRepsOnly(id) &&
      !isAssisted(id) &&
      exerciseById(id)?.equipment != 'Bodyweight' &&
      (bodyweight.isNotEmpty || profile.weightKg > 0);

  List<({DateTime date, double value})> exerciseTrend(String id, {int days = 0, bool relative = false}) {
    final from = days <= 0 ? null : shiftDays(_dayKey(DateTime.now()), -(days - 1));
    if (relative && !canShowRelative(id)) return const [];
    final reps = isRepsOnly(id), assisted = isAssisted(id);
    final out = <({DateTime date, double value})>[];
    for (final h in exerciseHistory(id).reversed) {
      if (from != null && _dayKey(h.date).isBefore(from)) continue;
      final sets = h.ex.workingSets.where((s) => s.reps > 0);
      if (sets.isEmpty) continue;
      final value = reps
          ? sets.map((s) => s.reps).reduce(math.max).toDouble()
          : assisted
              ? _round1(sets.map((s) => s.weight).reduce(math.min))
              : relative
                  ? (h.ex.bestOneRm / _weightOn(h.date) * 100).roundToDouble()
                  : _round1(h.ex.bestOneRm);
      if (value > 0 || assisted) out.add((date: h.date, value: value));
    }
    return out;
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
    for (final d in _byDay.keys) {
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
          if (r.ex.workingSets.isNotEmpty)
            r.ex.workingSets.fold(0, (m, s) => math.max(m, s.reps)).toDouble(),
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

  bool get trainedToday => _sessionsOnDay(DateTime.now()).isNotEmpty;

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
      return (
        title: picked.title,
        subtitle: t.habitFocus(t.weekday(today)),
        muscles: picked.muscles,
      );
    }
    final idx = order.indexOf(last);

    final next = idx >= 0 ? order[(idx + 1) % order.length] : order[today % 3];
    return table[next]!;
  }
}
