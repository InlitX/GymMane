part of 'fit_state.dart';

mixin StatsState on FitCore, ToolsState, LibraryState {
  List<Exercise> recommendedExercises(int n) {
    final muscles = suggestedFocus.muscles;
    final picks = <Exercise>[];
    final usedMuscle = <String>{};

    for (final m in muscles) {
      final ex = kExercises.firstWhere(
        (e) => e.primary == m && !picks.contains(e),
        orElse: () => kExercises.first,
      );
      if (ex.primary == m && usedMuscle.add(m)) picks.add(ex);
    }

    for (final e in kExercises) {
      if (picks.length >= n) break;
      if (muscles.contains(e.primary) && !picks.contains(e)) picks.add(e);
    }
    return picks.take(n).toList();
  }

  int get athleteLevel => 1 + totalSessions ~/ 10;

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

  int get todayIndex => DateTime.now().weekday - 1;

  DateTime get _weekStart {
    final t = _dayKey(DateTime.now());
    return t.subtract(Duration(days: t.weekday - 1));
  }

  Iterable<LoggedSession> get _thisWeekSessions {
    final start = _weekStart;
    final end = start.add(const Duration(days: 7));
    return sessions.where((s) {
      final k = _dayKey(s.date);
      return !k.isBefore(start) && k.isBefore(end);
    });
  }

  List<double> _dailyVolumes(int days) {
    final today = _dayKey(DateTime.now());
    final byDay = <DateTime, double>{};
    for (final s in sessions) {
      final k = _dayKey(s.date);
      byDay[k] = (byDay[k] ?? 0) + s.volume;
    }
    return List.generate(days, (i) {
      final d = today.subtract(Duration(days: days - 1 - i));
      return byDay[d] ?? 0;
    });
  }

  double _volumeBetween(DateTime start, DateTime end) => sessions
      .where((s) => s.date.isAfter(start) && !s.date.isAfter(end))
      .fold(0.0, (a, s) => a + s.volume);

  bool get hasData => sessions.isNotEmpty;
  int get totalSessions => sessions.length;

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
    final daily = _dailyVolumes(days);
    final maxV = daily.fold(0.0, (m, v) => v > m ? v : m);
    if (maxV <= 0) return List.filled(days, 0);
    return daily.map((v) {
      if (v <= 0) return 0;
      final r = v / maxV;
      if (r > 0.66) return 3;
      if (r > 0.33) return 2;
      return 1;
    }).toList();
  }

  DateTime heatmapDate(int i) =>
      _dayKey(DateTime.now()).subtract(Duration(days: kHeatmapDays - 1 - i));

  List<LoggedSession> sessionsOn(DateTime day) {
    final k = _dayKey(day);
    return sessions.where((s) => _dayKey(s.date) == k).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  void deleteSession(LoggedSession s) {
    sessions.remove(s);
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  void deleteLoggedExercise(LoggedSession s, LoggedExercise e) {
    s.exercises.remove(e);
    if (s.exercises.isEmpty) sessions.remove(s);
    persistNow();
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
    final ofDay = sessions.where((s) => _dayKey(s.date) == k).toList();
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

  int get currentStreak {
    final days = sessions.map((s) => _dayKey(s.date)).toSet();
    for (final id in checkins) {
      final p = id.split('-');
      if (p.length == 3) {
        final y = int.tryParse(p[0]), m = int.tryParse(p[1]), d = int.tryParse(p[2]);
        if (y != null && m != null && d != null) days.add(DateTime(y, m, d));
      }
    }
    if (days.isEmpty) return 0;
    var cursor = _dayKey(DateTime.now());
    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (!days.contains(cursor)) return 0;
    }
    var n = 0;
    while (days.contains(cursor)) {
      n++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return n;
  }

  List<bool> get weekMask {
    final start = _weekStart;
    final days = sessions.map((s) => _dayKey(s.date)).toSet();
    return List.generate(7, (i) => days.contains(start.add(Duration(days: i))));
  }

  String _dayId(DateTime d) => '${d.year}-${d.month}-${d.day}';

  DateTime _dateForWeekday(int i) => _weekStart.add(Duration(days: i));

  bool _hasSessionOn(DateTime day) {
    final k = _dayKey(day);
    return sessions.any((s) => _dayKey(s.date) == k);
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
    notifyListeners();
  }

  int get sessionsThisWeek => _thisWeekSessions.length;

  double get volumeThisWeekKg => _thisWeekSessions.fold(0.0, (a, s) => a + s.volume);

  int get setsToday {
    final t = _dayKey(DateTime.now());
    return sessions.where((s) => _dayKey(s.date) == t).fold(0, (a, s) => a + s.setCount);
  }

  int get goalPct {
    final g = profile.weeklyGoal <= 0 ? 4 : profile.weeklyGoal;
    return ((sessionsThisWeek / g) * 100).round().clamp(0, 100);
  }

  List<({String name, double topWeight, double oneRm})> get personalRecords {
    final best = <String, ({String name, double topWeight, double oneRm})>{};
    for (final s in sessions) {
      for (final e in s.exercises) {
        for (final st in e.sets) {
          final c = best[e.id];
          best[e.id] = (
            name: t.catalogName(e.id, e.name),
            topWeight: c == null ? st.weight : math.max(c.topWeight, st.weight),
            oneRm: c == null ? st.oneRm : math.max(c.oneRm, st.oneRm),
          );
        }
      }
    }
    final list = best.values.toList()..sort((a, b) => b.oneRm.compareTo(a.oneRm));
    return list;
  }

  int get prsThisWeek {
    final bestOrm = <String, double>{};
    final bestDate = <String, DateTime>{};
    for (final s in sessions) {
      for (final e in s.exercises) {
        for (final st in e.sets) {
          if (!bestOrm.containsKey(e.id) || st.oneRm > bestOrm[e.id]!) {
            bestOrm[e.id] = st.oneRm;
            bestDate[e.id] = s.date;
          }
        }
      }
    }
    final start = _weekStart;
    final end = start.add(const Duration(days: 7));
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

  Map<String, double> muscleSetsOver(int days) {
    final start = _dayKey(DateTime.now()).subtract(Duration(days: days - 1));
    final out = <String, double>{};
    for (final s in sessions) {
      if (_dayKey(s.date).isBefore(start)) continue;
      for (final e in s.exercises) {
        final n = e.sets.length.toDouble();
        if (n <= 0) continue;
        out[e.primary] = (out[e.primary] ?? 0) + n;
        for (final m in exerciseById(e.id)?.secondary ?? const <String>[]) {
          out[m] = (out[m] ?? 0) + n / 2;
        }
      }
    }
    return out;
  }

  Map<String, double> muscleHeatOver(int days) {
    final target = muscleTargetFor(days);
    return {
      for (final e in muscleSetsOver(days).entries) e.key: (e.value / target).clamp(0.0, 1.0),
    };
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
    return sets.map((s) => '${weightValue(s.weight)}×${s.reps}').join(' · ');
  }

  ({double topWeight, double oneRm})? exercisePr(String id) {
    final h = exerciseHistory(id);
    if (h.isEmpty) return null;
    double tw = 0, orm = 0;
    for (final r in h) {
      tw = math.max(tw, r.ex.topWeight);
      orm = math.max(orm, r.ex.bestOneRm);
    }
    return (topWeight: tw, oneRm: orm);
  }

  String? strengthExerciseId;

  List<({String id, String name, int sessions})> get trackedExercises {
    final count = <String, int>{};
    final names = <String, String>{};
    for (final s in sessions) {
      for (final e in s.exercises) {
        count[e.id] = (count[e.id] ?? 0) + 1;
        names[e.id] = t.catalogName(e.id, e.name);
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

  List<double> oneRmSeries(String id) {
    final h = exerciseHistory(id).reversed;
    return h.map((r) => _round1(r.ex.bestOneRm)).toList();
  }

  ({String title, String subtitle, List<String> muscles}) get suggestedFocus {
    final table = {
      'push': (title: t.pushDay, subtitle: t.pushFocus, muscles: ['chest', 'shoulders', 'triceps']),
      'pull': (title: t.pullDay, subtitle: t.pullFocus, muscles: ['back', 'biceps', 'trapezius']),
      'legs': (title: t.legDay, subtitle: t.legFocus, muscles: ['quads', 'hamstrings', 'glutes']),
    };
    var last = '';
    if (sessions.isNotEmpty) {
      final s = sessions.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
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
    final idx = order.indexOf(last);

    final next = idx >= 0 ? order[(idx + 1) % order.length] : order[DateTime.now().weekday % 3];
    return table[next]!;
  }
}
