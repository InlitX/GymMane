part of 'fit_state.dart';

mixin WorkoutState on FitCore, SettingsState, LibraryState, PlacesState, StatsState, MomentsState, RoutinesState {
  final List<String> selectedMuscles = [];
  final Set<String> sessionPicks = {};
  final Set<String> pickSeed = {};
  String trainStep = 'select';
  String? trainKind;
  WorkoutSession? session;
  Timer? _sessionTimer;
  Timer? _restTimer;
  DateTime? _runningSince;
  int _elapsedBefore = 0;
  bool sessionPaused = false;
  bool sessionLocked = false;
  DateTime? logDay;
  int restDoneTick = 0;
  final ValueNotifier<int> clock = ValueNotifier(0);
  int restTotal = 0;
  int autoMoves = 0;

  void startWorkout([List<String>? initialMuscles, DateTime? on]) {
    if (_backToParked()) return;
    logDay = on;
    trainKind = null;
    selectedMuscles
      ..clear()
      ..addAll(initialMuscles ?? const []);
    trainStep = 'select';
    pushRoute('train');
  }

  void startFocusWorkout() => startWorkout(suggestedFocus.muscles);

  void startPicking({DateTime? on}) {
    if (_backToParked()) return;
    logDay = on;
    trainKind = null;
    selectedMuscles.clear();
    sessionPicks.clear();
    pickSeed.clear();
    trainStep = 'review';
    pushRoute('train');
  }

  List<Exercise> getFilteredExercises(List<String> sel) {
    if (sel.isEmpty) return const [];
    return allExercises
        .where((ex) => sel.contains(ex.primary) || ex.secondary.any(sel.contains))
        .where((ex) => fitsHere(ex) && !isArchived(ex.id))
        .toList();
  }

  void toggleMuscle(String id) {
    if (selectedMuscles.contains(id)) {
      selectedMuscles.remove(id);
    } else {
      selectedMuscles.add(id);
    }
    notifyListeners();
  }

  void trainContinue() {
    if (selectedMuscles.isEmpty) return;
    trainKind = null;
    trainStep = 'review';
    sessionPicks
      ..clear()
      ..addAll(_defaultPicks(selectedMuscles).map((e) => e.id));
    pickSeed
      ..clear()
      ..addAll(sessionPicks);
    notifyListeners();
  }

  List<Exercise> _kindPool(String kind) => (kind == 'cardio'
          ? allExercises.where((e) => isCardio(e.id) || kCardioExtras.contains(e.id))
          : [for (final id in kWarmupIds) ?exerciseById(id)])
      .where((ex) => fitsHere(ex) && !isArchived(ex.id))
      .toList();

  void startKindWorkout(String kind) {
    trainKind = kind;
    trainStep = 'review';
    final pool = _kindPool(kind).where((e) => suggests(e.id));
    final picks = kind == 'cardio'
        ? pool.where((e) => exerciseHistory(e.id).isNotEmpty).take(1)
        : pool.take(_pickTarget);
    sessionPicks
      ..clear()
      ..addAll(picks.map((e) => e.id));
    pickSeed
      ..clear()
      ..addAll(sessionPicks);
    notifyListeners();
  }

  List<Exercise> reviewExercises() {
    final kind = trainKind;
    final base = kind == null ? getFilteredExercises(selectedMuscles) : _kindPool(kind);
    final baseIds = base.map((e) => e.id).toSet();
    final extras = allExercises.where((e) => sessionPicks.contains(e.id) && !baseIds.contains(e.id));
    final all = [...base, ...extras];
    return [
      ...all.where((e) => pickSeed.contains(e.id)),
      ...all.where((e) => !pickSeed.contains(e.id)),
    ];
  }

  bool suggests(String id) => !noSuggest.contains(id);

  void toggleSuggest(String id) {
    if (!noSuggest.remove(id)) {
      noSuggest.add(id);
      sessionPicks.remove(id);
    }
    _persist();
    notifyListeners();
  }

  List<Exercise> trainSearchResults(String query) {
    if (query.trim().isEmpty) return const [];
    return allExercises.where((e) => !isArchived(e.id)).where(exerciseSearch(query)).take(40).toList();
  }

  static const _pickTarget = 6;

  List<Exercise> _defaultPicks(List<String> muscles) {
    final pool = getFilteredExercises(muscles).where((e) => suggests(e.id)).toList();
    if (pool.length <= _pickTarget) return pool;

    int rank(Exercise e) {
      if (favorites[e.id] == true) return 0;
      if (exerciseHistory(e.id).isNotEmpty) return 1;
      return 2;
    }

    final picks = <Exercise>[];

    for (final m in muscles) {
      final forMuscle = pool.where((e) => e.primary == m && !picks.contains(e)).toList()
        ..sort((a, b) => rank(a).compareTo(rank(b)));
      if (forMuscle.isNotEmpty) picks.add(forMuscle.first);
    }
    int aim(Exercise e) => muscles.contains(e.primary) ? 0 : 1;
    final rest = pool.where((e) => !picks.contains(e)).toList()
      ..sort((a, b) {
        final byAim = aim(a).compareTo(aim(b));
        return byAim != 0 ? byAim : rank(a).compareTo(rank(b));
      });
    for (final e in rest) {
      if (picks.length >= _pickTarget) break;
      picks.add(e);
    }
    return picks;
  }

  void togglePick(String id) {
    if (!sessionPicks.remove(id)) sessionPicks.add(id);
    notifyListeners();
  }

  bool isPicked(String id) => sessionPicks.contains(id);

  void clearPicks() {
    sessionPicks.clear();
    notifyListeners();
  }

  void resetDefaultPicks() {
    final kind = trainKind;
    if (kind != null) return startKindWorkout(kind);
    sessionPicks
      ..clear()
      ..addAll(_defaultPicks(selectedMuscles).map((e) => e.id));
    pickSeed
      ..clear()
      ..addAll(sessionPicks);
    notifyListeners();
  }

  void toggleResetPicks() {
    if (sessionPicks.isNotEmpty) {
      clearPicks();
    } else {
      resetDefaultPicks();
    }
  }

  void trainBack() {
    trainStep = 'select';
    trainKind = null;
    notifyListeners();
  }

  void closeTrain() {
    trainStep = 'select';
    trainKind = null;
    selectedMuscles.clear();
    sessionPicks.clear();
    pickSeed.clear();
    logDay = null;
    popRoute();
  }

  void startRoutine(Routine r, {DateTime? on}) {
    if (_backToParked()) return;
    final slots = routineSlots(r);
    if (slots.isEmpty) return;
    _beginSession([for (final s in slots) s.ex],
        slots: [for (final s in slots) s.slot],
        plan: {for (final s in slots) s.slot: routineSets(r, s.slot)},
        planned: {for (final s in slots) if (hasPlan(r, s.slot)) s.slot: plannedSets(r, s.slot)},
        chained: {for (final s in slots) if (chainsToNext(r, s.slot)) s.slot},
        jumped: {for (final s in slots) if (jumpsToNext(r, s.slot)) s.slot},
        routineId: r.id,
        on: on);
  }

  ({int n, int of}) blockOf(SessionExercise e) {
    final s = session;
    if (s == null) return (n: 1, of: 1);
    return (n: nthInSession(e) + 1, of: s.exercises.where((x) => x.id == e.id).length);
  }

  int nthInSession(SessionExercise e) {
    final s = session;
    if (s == null) return 0;
    var n = 0;
    for (final x in s.exercises) {
      if (identical(x, e)) return n;
      if (x.id == e.id) n++;
    }
    return 0;
  }

  void startSession() {
    final exs = allExercises.where((e) => sessionPicks.contains(e.id)).toList();
    if (exs.isNotEmpty) _beginSession(exs, on: logDay);
  }

  List<SessionSet> _fromPlan(String id, List<PlannedSet> planned, [int nth = 0]) {
    final working = planned.where((p) => p.kind != SetKind.warmup).length;
    final base = _workingOpeners(id, count: working == 0 ? 1 : working, nth: nth);
    if (_drivesSets(id) && base.length != working) {
      planned = [
        ...planned.where((p) => p.kind == SetKind.warmup),
        for (var i = 0; i < base.length; i++) const PlannedSet(),
      ];
    }
    final first = base.isEmpty ? SessionSet(10, 0, false) : base.first;
    final warmWeight = fromDisplayWeight(_roundTo(toDisplayWeight(first.weight * 0.5), plateStep));
    final out = <SessionSet>[];
    var w = 0;
    final hold = nextHoldSeconds(id, nth);
    for (final p in planned) {
      final warm = p.kind == SetKind.warmup;
      final b = warm || base.isEmpty ? first : base[(w++).clamp(0, base.length - 1)];
      final own = !warm && _drivesReps(id);
      out.add(SessionSet(
        own ? b.reps : p.reps ?? (warm ? 10 : b.reps),
        own ? b.weight : p.weightKg ?? (warm ? warmWeight : b.weight),
        false,
        kind: p.kind,
        sec: !warm && hold != null ? hold : p.sec ?? b.sec,
        km: p.km ?? b.km,
        goal: own || warm || p.repsMax == null ? null : p.repsLabel,
      ));
    }
    return out;
  }

  List<SessionSet> _openingSets(String id, {int? count, List<PlannedSet>? planned, int nth = 0}) =>
      _withSides(id, _openingSetsRaw(id, count: count, planned: planned, nth: nth));

  List<SessionSet> _openingSetsRaw(String id, {int? count, List<PlannedSet>? planned, int nth = 0}) {
    if (planned != null && planned.isNotEmpty) return _fromPlan(id, planned, nth);
    final sets = _workingOpeners(id, count: count, nth: nth);
    if (!warmsUp(id) || isRepsOnly(id) || modeOf(id).isNotEmpty) return sets;
    return [..._warmupFor(sets, id), ...sets];
  }

  List<SessionSet> _withSides(String id, List<SessionSet> sets) {
    if (isSidedReps(id)) {
      for (final st in sets) {
        st.repsR ??= st.reps;
      }
    }
    return sets;
  }

  void syncSides(SessionExercise e) {
    final sided = isSidedReps(e.id);
    for (final st in e.sets) {
      if (sided) {
        st.repsR ??= st.reps;
      } else if (st.repsR != null) {
        st.reps = st.weakReps;
        st.repsR = null;
      }
    }
  }

  void toggleSidedReps(String id) {
    if (isSidedReps(id)) {
      eachSide.remove(id);
    } else {
      eachSide.add(id);
    }
    final s = session;
    if (s != null && !s.complete) {
      for (final e in s.exercises) {
        if (e.id == id) syncSides(e);
      }
    }
    _persist();
    notifyListeners();
  }

  int? nextHoldSeconds(String id, [int nth = 0]) {
    if (modeOf(id) != 'time') return null;
    final step = holdStepFor(id);
    if (step <= 0) return null;
    final secs = [for (final l in lastSetsFor(id, nth)) if (l.counts && (l.sec ?? 0) > 0) l.sec!];
    if (secs.isEmpty) return null;
    final aim = secs.reduce(math.max);
    return secs.every((s) => s >= aim) ? aim + step : aim;
  }

  bool holdGoesUp(String id) {
    final next = nextHoldSeconds(id);
    final last = [for (final l in lastSetsFor(id)) if (l.counts && (l.sec ?? 0) > 0) l.sec!];
    return next != null && last.isNotEmpty && next > last.reduce(math.max);
  }

  List<SessionSet> _modeOpeners(String mode, List<LoggedSet> last, [String? id, int nth = 0]) {
    final cardio = mode == 'cardio';
    final hold = id == null ? null : nextHoldSeconds(id, nth);
    final fromLast = [
      for (final l in last)
        if ((l.sec ?? 0) > 0 || (l.km ?? 0) > 0)
          SessionSet(0, cardio ? 0 : l.weight, false,
              sec: hold ?? l.sec ?? (cardio ? 1200 : 30), km: cardio ? (l.km ?? 0) : null),
    ];
    if (fromLast.isNotEmpty) return fromLast;
    if (cardio) return [SessionSet(0, 0, false, sec: 1200, km: 0)];
    return [for (var i = 0; i < kDefaultRoutineSets; i++) SessionSet(0, 0, false, sec: 30)];
  }

  List<SessionSet> _workingOpeners(String id, {int? count, int nth = 0}) {
    final last = lastSetsFor(id, nth).where((l) => l.counts).toList();
    final mode = modeOf(id);
    final List<SessionSet> base;
    if (mode.isNotEmpty) {
      base = _modeOpeners(mode, last, id, nth);
    } else if (last.isNotEmpty) {
      final plan = hasProgress(id) ? _nextPlan(id, nth) : null;
      base = plan?.sets ?? last.map((l) => SessionSet(l.reps, l.weight, false)).toList();
    } else {
      final w = isRepsOnly(id) ? 0.0 : 20.0;
      base = [for (var i = 0; i < kDefaultRoutineSets; i++) SessionSet(10, w, false)];
    }
    if (count == null || count == base.length || _drivesSets(id)) return base;
    if (count < base.length) return base.take(count).toList();
    final fill = base.last;
    return [
      ...base,
      for (var i = base.length; i < count; i++) fill.copy(),
    ];
  }

  bool _drivesSets(String id) => hasProgress(id) && progressRule(id).kind == ProgressKind.volume;

  bool _drivesReps(String id) {
    if (!hasProgress(id)) return false;
    final kind = progressRule(id).kind;
    return kind == ProgressKind.double || kind == ProgressKind.volume || kind == ProgressKind.amrap;
  }

  static const deloadAfter = 3;

  int stallStreak(String id) {
    final h = progressHistory(id);
    if (h.isEmpty) return 0;
    final rule = progressRule(id);
    final load = headlineWeight(h.first.ex);
    bool same(LoggedExercise e) => (headlineWeight(e) - load).abs() <= 0.01;
    int total(List<LoggedSet> l) => l.fold(0, (sum, x) => sum + x.reps);
    var n = 0;
    for (var i = 0; i < h.length; i++) {
      final sets = h[i].ex.workingSets;
      if (sets.isEmpty || !same(h[i].ex)) break;
      if (rule.usesRange) {
        if (sets.every((s) => s.reps >= rule.high)) break;
        final older = i + 1 < h.length ? h[i + 1].ex : null;
        if (older == null || older.workingSets.isEmpty || !same(older)) break;
        if (total(sets) > total(older.workingSets)) break;
      } else {
        final target = sets.first.reps;
        if (target <= 0 || sets.every((s) => s.reps >= target)) break;
      }
      n++;
    }
    return n;
  }

  bool needsDeload(String id) =>
      hasProgress(id) && modeOf(id).isEmpty && !isRepsOnly(id) && stallStreak(id) >= progressRule(id).fails;

  double deloadWeight(String id, double from) {
    final step = progressStep[id] ?? fromDisplayWeight(weightStep);
    if (stackFor(id) != null) {
      if (isAssisted(id)) return snapToStack(id, from, dir: 1);
      final aim = from * (100 - progressRule(id).deloadPct) / 100;
      final down = floorToStack(id, aim);
      return down < from - 0.001 ? down : snapToStack(id, from, dir: -1);
    }
    if (isAssisted(id)) return from + step;
    final grid = weightStep;
    final shown = toDisplayWeight(from);
    var next = (shown * (100 - progressRule(id).deloadPct) / 100 / grid).round() * grid;
    if (next >= shown) next = shown - grid;
    return _round3(fromDisplayWeight(math.max(0.0, next)));
  }

  ({List<SessionSet> sets, double weightKg, int reps, NextMove move})? _nextPlan(String id, [int nth = 0]) {
    if (modeOf(id).isNotEmpty) return null;
    final rule = progressRule(id);
    if (rule.kind == ProgressKind.manual) return null;
    final last = lastSetsFor(id, nth).where((l) => l.counts).toList();
    if (last.isEmpty) return null;
    final reps = last.first.reps;
    if (reps <= 0) return null;
    if (isRepsOnly(id)) {
      final hit = last.every((l) => l.reps >= reps);
      return (
        sets: [for (final l in last) SessionSet(hit ? l.reps + 1 : l.reps, l.weight, false)],
        weightKg: 0.0,
        reps: hit ? reps + 1 : reps,
        move: hit ? NextMove.reps : NextMove.hold,
      );
    }
    final step = progressStep[id] ?? fromDisplayWeight(weightStep);
    final assisted = isAssisted(id);
    final load = assisted ? last.map((l) => l.weight).reduce(math.min) : last.map((l) => l.weight).reduce(math.max);
    double heavier(double w, [int times = 1]) {
      if (stackFor(id) != null) {
        var v = w;
        for (var i = 0; i < times; i++) {
          v = snapToStack(id, v, dir: assisted ? -1 : 1);
        }
        return v;
      }
      return assisted ? math.max(0.0, w - step * times) : w + step * times;
    }
    final volume = rule.kind == ProgressKind.volume;

    List<SessionSet> shaped(int Function(LoggedSet l) repsOf, double Function(double w) weightOf, [int? count]) => [
          for (var i = 0; i < (count ?? last.length); i++)
            SessionSet(repsOf(last[math.min(i, last.length - 1)]), weightOf(last[math.min(i, last.length - 1)].weight), false),
        ];

    ({List<SessionSet> sets, double weightKg, int reps, NextMove move}) deload(int r) => (
          sets: shaped((_) => r, (w) => deloadWeight(id, w), volume ? rule.sets : null),
          weightKg: deloadWeight(id, load),
          reps: r,
          move: NextMove.deload,
        );

    switch (rule.kind) {
      case ProgressKind.double:
      case ProgressKind.volume:
        final top = last.every((l) => l.reps >= rule.high);
        if (top && volume && last.length < rule.maxSets) {
          return (sets: shaped((_) => rule.low, (w) => w, last.length + 1), weightKg: load, reps: rule.low, move: NextMove.addSet);
        }
        if (top) {
          return (
            sets: shaped((_) => rule.low, heavier, volume ? rule.sets : null),
            weightKg: heavier(load),
            reps: rule.low,
            move: NextMove.up,
          );
        }
        if (needsDeload(id)) return deload(rule.low);
        int more(LoggedSet l) => (l.reps + 1).clamp(rule.low, rule.high);
        return (sets: shaped(more, (w) => w), weightKg: load, reps: more(last.first), move: NextMove.reps);
      case ProgressKind.amrap:
        final open = last.last.reps;
        final hit = last.take(last.length - 1).every((l) => l.reps >= reps) && open >= reps;
        if (hit) {
          final times = open >= reps * 2 ? 2 : 1;
          return (
            sets: shaped((_) => reps, (w) => heavier(w, times)),
            weightKg: heavier(load, times),
            reps: reps,
            move: NextMove.up,
          );
        }
        if (needsDeload(id)) return deload(reps);
        return (sets: shaped((_) => reps, (w) => w), weightKg: load, reps: reps, move: NextMove.hold);
      case ProgressKind.manual:
      case ProgressKind.linear:
        final hit = last.every((l) => l.reps >= reps);
        if (!hit && needsDeload(id)) return deload(reps);
        if (hit) return (sets: shaped((l) => l.reps, heavier), weightKg: heavier(load), reps: reps, move: NextMove.up);
        return (sets: shaped((l) => l.reps, (w) => w), weightKg: load, reps: reps, move: NextMove.hold);
    }
  }

  ({double weightKg, int reps, bool up, bool deload, NextMove move, int sets, List<int> perSet})? nextTarget(String id) {
    final plan = _nextPlan(id);
    if (plan == null) return null;
    final move = plan.move;
    return (
      weightKg: plan.weightKg,
      reps: plan.reps,
      up: move == NextMove.up || move == NextMove.reps || move == NextMove.addSet,
      deload: move == NextMove.deload,
      move: move,
      sets: plan.sets.length,
      perSet: [for (final s in plan.sets) s.reps],
    );
  }

  String? nextWhy(String id) {
    final target = nextTarget(id);
    if (target == null) return null;
    final amrap = progressRule(id).kind == ProgressKind.amrap && !isRepsOnly(id);
    return switch (target.move) {
      NextMove.deload => t.nextDeload(stallStreak(id)),
      NextMove.reps => isRepsOnly(id) ? null : t.nextMoreReps,
      NextMove.addSet => t.nextAddSet,
      NextMove.hold => amrap ? t.nextAmrap : t.nextHold,
      NextMove.up => amrap ? t.nextAmrap : null,
    };
  }

  String? nextTargetLabel(String id) {
    final hold = nextHoldSeconds(id);
    if (hold != null) return durationLabel(hold);
    final target = nextTarget(id);
    if (target == null) return null;
    if (isRepsOnly(id)) return '${target.reps} ${t.repsCol.toLowerCase()}';
    final reps = target.move == NextMove.reps && target.perSet.toSet().length > 1
        ? target.perSet.join('/')
        : '${target.reps}';
    final main = '${weightLabel(target.weightKg)} × $reps';
    return ltr(target.move == NextMove.addSet ? '${target.sets} × $main' : main);
  }

  void _beginSession(List<Exercise> exs,
      {List<String>? slots,
      Map<String, int>? plan,
      Map<String, List<PlannedSet>> planned = const {},
      Set<String> chained = const {},
      Set<String> jumped = const {},
      String? routineId,
      DateTime? on}) {
    final s = WorkoutSession()..routineId = routineId;
    if (on != null) {
      s.loggedAt = DateTime(on.year, on.month, on.day, 12);
      s.manual = true;
    }
    logDay = null;
    final seen = <String, int>{};
    s.exercises = [];
    for (final (i, ex) in exs.indexed) {
      final key = slots?[i] ?? ex.id;
      final nth = seen[ex.id] ?? 0;
      seen[ex.id] = nth + 1;
      s.exercises.add(SessionExercise(
        ex.id,
        ex.name,
        ex.primary,
        _openingSets(ex.id, count: plan?[key], planned: planned[key], nth: nth),
        linkedNext: chained.contains(key),
        jumpNext: jumped.contains(key),
        slot: slots?[i],
      ));
    }
    if (deloadWeek && !s.manual) _lighten(s);
    _restTimer?.cancel();
    _elapsedBefore = 0;
    sessionPaused = false;
    sessionLocked = false;
    countdownUntil = startCountdown && !s.manual ? DateTime.now().add(countdownLength) : null;
    _startTicking(from: countdownUntil);
    session = s;
    route = 'session';
    persistNow();
    notifyListeners();
  }

  void _lighten(WorkoutSession s) {
    s.deload = true;
    s.lightened = true;
    for (final e in s.exercises) {
      final working = e.sets.where((st) => st.kind != SetKind.warmup).toList();
      if (working.isEmpty) continue;
      final keep = (working.length / 2).ceil();
      final drop = working.sublist(keep).toSet();
      e.sets.removeWhere(drop.contains);
      if (modeOf(e.id).isNotEmpty || isRepsOnly(e.id)) continue;
      for (final st in e.sets) {
        if (st.kind == SetKind.warmup || st.weight <= 0) continue;
        st.weight = fromDisplayWeight(_roundTo(toDisplayWeight(st.weight * 0.9), plateStep));
      }
    }
  }

  bool get canSkipDeload {
    final s = session;
    return s != null && s.deload && s.routineId != null && !s.exercises.any((e) => e.sets.any((st) => st.done));
  }

  void skipDeload() {
    final s = session;
    final r = routineById(s?.routineId ?? '');
    if (s == null || r == null || !canSkipDeload) return;
    for (final e in s.exercises) {
      final slot = e.routineSlot;
      final fresh = _openingSets(e.id,
          count: routineSets(r, slot), planned: hasPlan(r, slot) ? plannedSets(r, slot) : null, nth: nthInSession(e));
      e.sets
        ..clear()
        ..addAll(fresh);
    }
    s.deload = false;
    s.lightened = false;
    persistNow();
    notifyListeners();
  }

  void toggleLightSession() {
    final s = session;
    if (s == null || s.complete) return;
    if (s.deload) {
      if (s.lightened && canSkipDeload) {
        skipDeload();
        return;
      }
      s.deload = false;
      s.lightened = false;
    } else {
      s.deload = true;
    }
    persistNow();
    notifyListeners();
  }

  void _startTicking({DateTime? from}) {
    _sessionTimer?.cancel();
    _runningSince = from ?? DateTime.now();
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (_) => clock.value++);
  }

  int get sessionElapsed => _runningSince == null
      ? _elapsedBefore
      : _elapsedBefore + math.max(0, DateTime.now().difference(_runningSince!).inSeconds);

  static const countdownLength = Duration(seconds: 5);

  DateTime? countdownUntil;

  bool get countingDown {
    final until = countdownUntil;
    return until != null && session != null && DateTime.now().isBefore(until);
  }

  void endCountdown() {
    final until = countdownUntil;
    if (until == null) return;
    countdownUntil = null;
    final now = DateTime.now();
    if (!sessionPaused && _runningSince != null && _runningSince!.isAfter(now)) _runningSince = now;
    persistNow();
    notifyListeners();
  }

  void toggleSessionPause() {
    final s = session;
    if (holding && !holdPaused) toggleHoldPause();
    if (sessionPaused) {
      _startTicking();
      sessionPaused = false;
      final frozen = s?.restFrozen;
      if (frozen != null) _armRest(frozen);
    } else {
      _elapsedBefore = sessionElapsed;
      _runningSince = null;
      _sessionTimer?.cancel();
      _restTimer?.cancel();
      RestAlarm.instance.cancel();
      if (s != null) {
        s.restFrozen = s.restRemaining;
        s.restEndsAt = null;
      }
      sessionPaused = true;
    }
    persistNow();
    notifyListeners();
  }

  void toggleSessionLock() {
    sessionLocked = !sessionLocked;
    notifyListeners();
  }

  void resumeSession() {
    final s = session;
    if (s == null || s.complete) return;
    resetRoute('session');
    notifyListeners();
  }

  void parkSession() {
    if (route != 'session') return;
    sessionLocked = false;
    resetRoute('home');
    notifyListeners();
  }

  bool isDayPartial(int i) {
    if (!isSessionDay(i)) return false;
    final day = dateForWeekday(i);
    return routinesOn(day).length > 1 && pendingRoutinesOn(day).isNotEmpty;
  }

  bool get todayPlanDone {
    final now = DateTime.now();
    return routinesOn(now).length > 1 ? pendingRoutinesOn(now).isEmpty : isDayDone(todayIndex);
  }

  Routine? get nextRoutineToday {
    final s = session;
    if (s == null || s.manual) return null;
    for (final r in pendingRoutinesOn(DateTime.now())) {
      if (r.id != s.routineId && r.exerciseIds.isNotEmpty) return r;
    }
    return null;
  }

  void startNextRoutine() {
    final r = nextRoutineToday;
    if (r == null) return;
    saveAndExit();
    startRoutine(r);
  }

  bool get sessionParked => session != null && !session!.complete && route != 'session';

  void stepOutOfSession() {
    if (!sessionPaused && !(session?.manual ?? false)) toggleSessionPause();
    parkSession();
  }

  void stepBackIntoSession() {
    if (sessionPaused) toggleSessionPause();
    resumeSession();
  }

  DateTime? get manualStart {
    final s = session;
    final at = s?.loggedAt;
    if (s == null || !s.manual || at == null) return null;
    return at.subtract(Duration(seconds: _elapsedBefore));
  }

  int get manualMinutes => _elapsedBefore ~/ 60;

  void setManualStart(int minuteOfDay) {
    final start = manualStart;
    if (start == null) return;
    final next = DateTime(start.year, start.month, start.day, minuteOfDay ~/ 60, minuteOfDay % 60);
    session!.loggedAt = next.add(Duration(seconds: _elapsedBefore));
    persistNow();
    notifyListeners();
  }

  void setManualMinutes(int minutes) {
    final start = manualStart;
    if (start == null) return;
    _elapsedBefore = minutes.clamp(0, 24 * 60) * 60;
    session!.loggedAt = start.add(Duration(seconds: _elapsedBefore));
    persistNow();
    notifyListeners();
  }

  bool _backToParked() {
    if (!sessionParked) return false;
    stepBackIntoSession();
    return true;
  }

  String get elapsedLabel {
    final e = sessionElapsed;
    final ss = (e % 60).toString().padLeft(2, '0');
    if (e < 3600) return '${(e ~/ 60).toString().padLeft(2, '0')}:$ss';
    return '${e ~/ 3600}:${(e % 3600 ~/ 60).toString().padLeft(2, '0')}:$ss';
  }

  SessionExercise? get currentExercise {
    final s = session;
    if (s == null || s.exercises.isEmpty) return null;
    return s.exercises[s.currentIndex];
  }

  String get sessionProgressLabel {
    final s = session;
    if (s == null) return '';
    return t.exerciseXofY(s.currentIndex + 1, s.exercises.length);
  }

  bool restsBetweenSides(int exIdx, SessionSet st) {
    final s = session;
    return s != null &&
        !s.manual &&
        sideRestSeconds > 0 &&
        st.repsR != null &&
        exIdx >= 0 &&
        exIdx < s.exercises.length &&
        isSidedReps(s.exercises[exIdx].id);
  }

  void toggleSet(int exIdx, int setIdx) {
    final st = session!.exercises[exIdx].sets[setIdx];
    _advanceTimer?.cancel();
    if (!st.done && !st.half && restsBetweenSides(exIdx, st)) {
      st.half = true;
      _persist();
      startRest(seconds: sideRestSeconds, switchSides: true);
      notifyListeners();
      return;
    }
    st.half = false;
    st.done = !st.done;
    if (st.done) {
      session!
        ..lastDoneAt = DateTime.now()
        ..lastDoneElapsed = sessionElapsed;
    }
    _persist();
    notifyListeners();
    if (!st.done) return;
    final sets = session!.exercises[exIdx].sets;
    final mini = setIdx + 1 < sets.length && const [SetKind.restPause, SetKind.cluster].contains(sets[setIdx + 1].kind);
    final chain = chainAt(exIdx);
    if (chain.length > 1) {
      _advanceChain(chain, exIdx, mini: mini, rest: st.rest);
      return;
    }
    startRest(mini: mini, seconds: st.rest ?? (mini ? null : _changeRestAfter(exIdx)));
    if (autoAdvance || sessionLocked) _advanceWhenDone(exIdx);
  }

  void _focusExercise(int exIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length || s.currentIndex == exIdx) return;
    _advanceTimer?.cancel();
    s.currentIndex = exIdx;
  }

  void toggleSetAt(int exIdx, int setIdx) {
    _focusExercise(exIdx);
    toggleSet(exIdx, setIdx);
  }

  void startHoldAt(int exIdx, int setIdx) {
    _focusExercise(exIdx);
    startHold(exIdx, setIdx);
  }

  LoggedSet? previousSet(String exId, int setIdx) {
    final last = lastSetsFor(exId);
    return setIdx >= 0 && setIdx < last.length ? last[setIdx] : null;
  }

  void copyPreviousSet(int exIdx, int setIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    final prev = previousSet(s.exercises[exIdx].id, setIdx);
    if (prev == null || setIdx >= sets.length) return;
    final st = sets[setIdx];
    if (st.repsR != null) {
      st.reps = prev.left ?? prev.reps;
      st.repsR = prev.right ?? prev.reps;
    } else {
      st.reps = prev.reps;
    }
    st.weight = prev.weight;
    if (prev.sec != null) st.sec = prev.sec;
    if (prev.km != null) st.km = prev.km;
    _persist();
    notifyListeners();
  }

  void moveSessionExercise(int exIdx, int delta) {
    final s = session;
    if (s == null) return;
    final to = exIdx + delta;
    if (exIdx < 0 || exIdx >= s.exercises.length || to < 0 || to >= s.exercises.length) return;
    reorderSessionExercise(exIdx, delta > 0 ? to + 1 : to);
  }

  void toggleSessionLink(int exIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length - 1) return;
    s.exercises[exIdx].linkedNext = !s.exercises[exIdx].linkedNext;
    if (!s.exercises[exIdx].linkedNext) s.exercises[exIdx].jumpNext = false;
    _persist();
    notifyListeners();
  }

  void toggleSessionJump(int exIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length - 1 || !s.exercises[exIdx].linkedNext) return;
    s.exercises[exIdx].jumpNext = !s.exercises[exIdx].jumpNext;
    _persist();
    notifyListeners();
  }

  ({Map<String, double> planned, Map<String, double> done}) get sessionMuscleSets {
    final planned = <String, double>{}, done = <String, double>{};
    for (final e in session?.exercises ?? const <SessionExercise>[]) {
      if (!countsForMuscles(e.id)) continue;
      final total = e.sets.where((st) => st.counts).length.toDouble();
      final ticked = e.sets.where((st) => st.counts && st.done).length.toDouble();
      if (total <= 0) continue;
      final secondary = exerciseById(e.id)?.secondary ?? const <String>[];
      void add(Map<String, double> m, String id, double n) => m[id] = (m[id] ?? 0) + n;
      add(planned, e.primary, total);
      if (ticked > 0) add(done, e.primary, ticked);
      for (final m in secondary) {
        add(planned, m, total / 2);
        if (ticked > 0) add(done, m, ticked / 2);
      }
    }
    return (planned: planned, done: done);
  }

  double get sessionVolumeKg {
    var kg = 0.0;
    for (final e in session?.exercises ?? const <SessionExercise>[]) {
      final times = isPaired(e.id) ? 2 : 1;
      final now = DateTime.now();
      for (final st in e.sets) {
        if (!st.done || !st.counts) continue;
        final x = st.logged;
        final reps = x.sided ? x.left! + x.right! : x.reps;
        if (reps > 0) kg += reps * loadOf(e.id, x.weight, now) * (x.sided ? 1 : times);
      }
    }
    return kg;
  }

  LoggedSession? get raceSession {
    final s = session;
    if (s == null || s.complete || s.manual) return null;
    final ids = {for (final e in s.exercises) e.id};
    LoggedSession? best;
    for (final p in sessions) {
      if (p.deload) continue;
      if (s.routineId != null) {
        if (p.routineId != s.routineId) continue;
      } else {
        final shared = p.exercises.where((e) => ids.contains(e.id)).length;
        if (shared == 0 || shared * 2 < ids.length) continue;
      }
      if (best == null || p.date.isAfter(best.date)) best = p;
    }
    return best;
  }

  List<({String id, String name, double now, double then})> get raceRows {
    final s = session;
    final last = raceSession;
    if (s == null || last == null) return const [];
    final rows = <({String id, String name, double now, double then})>[];
    for (final e in s.exercises) {
      final done = [for (final x in e.sets) if (x.done && x.counts) x];
      if (done.isEmpty) continue;
      final same = [for (final p in last.exercises) if (p.id == e.id) p];
      if (same.isEmpty) continue;
      final nth = nthInSession(e);
      final before = (nth < same.length ? same[nth] : same.first).workingSets;
      if (before.isEmpty) continue;
      var now = 0.0;
      var then = 0.0;
      for (var i = 0; i < done.length; i++) {
        now += done[i].logged.volume;
        if (i < before.length) then += before[i].volume;
      }
      if (now <= 0 && then <= 0) continue;
      rows.add((id: e.id, name: e.name, now: now, then: then));
    }
    return rows;
  }

  double? get raceDelta {
    final rows = raceRows;
    final then = rows.fold(0.0, (a, r) => a + r.then);
    if (then <= 0) return null;
    final now = rows.fold(0.0, (a, r) => a + r.now);
    return (now - then) / then;
  }

  List<int> chainAt(int exIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return const [];
    var start = exIdx;
    while (start > 0 && s.exercises[start - 1].linkedNext) {
      start--;
    }
    final chain = <int>[start];
    var i = start;
    while (i < s.exercises.length - 1 && s.exercises[i].linkedNext) {
      chain.add(++i);
    }
    return chain;
  }

  bool get inSuperset => chainAt(session?.currentIndex ?? -1).length > 1;

  bool get inJumpSet {
    final s = session;
    if (s == null || s.currentIndex >= s.exercises.length - 1) return false;
    final ex = s.exercises[s.currentIndex];
    return ex.linkedNext && ex.jumpNext;
  }

  void _advanceChain(List<int> chain, int exIdx, {bool mini = false, int? rest}) {
    final s = session!;
    final after = chain.where((i) => i > exIdx && s.exercises[i].hasUndone).toList();
    if (after.isNotEmpty) {
      if (s.exercises[exIdx].jumpNext) startRest(mini: mini, seconds: rest);
      s.currentIndex = after.first;
      _persist();
      notifyListeners();
      return;
    }
    final left = chain.where((i) => s.exercises[i].hasUndone).toList();
    final next = pendingAfter(chain.last);
    startRest(seconds: left.isEmpty && next != null && changeRestSeconds > 0 ? changeRestSeconds : null);
    if (left.isNotEmpty) {
      s.currentIndex = left.first;
    } else if ((autoAdvance || sessionLocked) && next != null) {
      s.currentIndex = next;
      autoMoves++;
    } else if (autoAdvance || sessionLocked) {
      _finishWhenAllDone();
    }
    _persist();
    notifyListeners();
  }

  int? pendingAfter(int exIdx) {
    final s = session;
    if (s == null) return null;
    final n = s.exercises.length;
    for (var k = 1; k < n; k++) {
      final i = (exIdx + k) % n;
      if (s.exercises[i].hasUndone) return i;
    }
    return null;
  }

  void goNextPending() {
    final s = session;
    if (s == null) return;
    final next = pendingAfter(s.currentIndex);
    if (next == null) {
      nextExercise();
      return;
    }
    goToExercise(next);
  }

  static const advanceDelay = Duration(milliseconds: 900);

  Timer? _advanceTimer;

  void _advanceWhenDone(int exIdx) {
    final s = session;
    if (s == null || exIdx != s.currentIndex) return;
    if (s.exercises[exIdx].sets.any((st) => !st.done)) return;
    if (pendingAfter(exIdx) == null) {
      _finishWhenAllDone();
      return;
    }
    _advanceTimer?.cancel();
    _advanceTimer = Timer(_waitForEffort(exIdx) ? effortDelay : advanceDelay, () {
      final live = session;
      if (live == null || live.currentIndex != exIdx) return;
      if (live.exercises[exIdx].sets.any((st) => !st.done)) return;
      final next = pendingAfter(exIdx);
      if (next == null) return;
      live.currentIndex = next;
      autoMoves++;
      _persist();
      notifyListeners();
    });
  }

  static const finishDelay = Duration(milliseconds: 1500);

  static const effortDelay = Duration(milliseconds: 3500);

  bool _waitForEffort(int exIdx) {
    final s = session;
    if (!logRpe || s == null || exIdx < 0 || exIdx >= s.exercises.length) return false;
    final ex = s.exercises[exIdx];
    if (modeOf(ex.id) == 'cardio') return false;
    final last = ex.sets.lastIndexWhere((st) => st.done);
    return last >= 0 && ex.sets[last].counts && ex.sets[last].rpe == null;
  }

  void _finishWhenAllDone() {
    final s = session;
    if (s == null || s.manual || s.complete || s.exercises.any((e) => e.hasUndone)) return;
    _advanceTimer?.cancel();
    _advanceTimer = Timer(_waitForEffort(s.currentIndex) ? effortDelay : finishDelay, () {
      final live = session;
      if (live == null || live.complete || live.exercises.any((e) => e.hasUndone)) return;
      if (route != 'session') return;
      finishSession();
    });
  }

  bool liveSetIsRecord(int exIdx, int setIdx) {
    final ex = session?.exercises[exIdx];
    if (ex == null || setIdx >= ex.sets.length) return false;
    final target = ex.sets[setIdx];
    if (!target.done || !target.counts) return false;
    var best = _bestBefore(ex.id);
    for (var i = 0; i < setIdx; i++) {
      final st = ex.sets[i];
      if (st.done && st.counts) best = _raise(ex.id, st.logged, best);
    }
    return _beats(ex.id, target.logged, best);
  }

  int? _changeRestAfter(int exIdx, {int? closing}) {
    final s = session;
    if (s == null || changeRestSeconds <= 0 || exIdx < 0 || exIdx >= s.exercises.length) return null;
    final sets = s.exercises[exIdx].sets;
    for (var i = 0; i < sets.length; i++) {
      if (i != closing && !sets[i].done) return null;
    }
    if (pendingAfter(exIdx) == null) return null;
    return changeRestSeconds;
  }

  int normalRestAfter(int exIdx, int setIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return restSeconds;
    final ex = s.exercises[exIdx];
    final sets = ex.sets;
    final mini = setIdx + 1 < sets.length && const [SetKind.restPause, SetKind.cluster].contains(sets[setIdx + 1].kind);
    if (mini && miniRestSeconds > 0) return miniRestSeconds;
    final change = _changeRestAfter(exIdx, closing: setIdx);
    if (change != null) return change;
    return routineRest(s.routineId, ex.routineSlot) ?? restFor(ex.id);
  }

  void setSetRest(int exIdx, int setIdx, int? seconds) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    if (setIdx < 0 || setIdx >= sets.length) return;
    sets[setIdx].rest = seconds?.clamp(0, 3600);
    _persist();
    notifyListeners();
  }

  void startRest({bool mini = false, int? seconds, bool switchSides = false}) {
    if (sessionPaused || session?.manual == true) return;
    _restTimer?.cancel();
    RestAlarm.instance.stopSound();
    final current = session!.exercises.isEmpty
        ? null
        : session!.exercises[session!.currentIndex.clamp(0, session!.exercises.length - 1)];
    final exId = current?.id ?? '';
    seconds ??= mini && miniRestSeconds > 0
        ? miniRestSeconds
        : routineRest(session!.routineId, current?.routineSlot ?? '') ?? restFor(exId);
    if (seconds <= 0) {
      session!.clearRest();
      notifyListeners();
      return;
    }

    restTotal = seconds;
    _armRest(seconds);
    session!.restSwitch = switchSides;
    if (voiceCoach && switchSides) {
      VoiceCoach.say(t.switchSides, intlLocale);
    } else if (voiceCoach) {
      final next = voiceNext();
      VoiceCoach.say(next == null ? t.voiceRest(voiceDuration(seconds)) : '${t.voiceRest(voiceDuration(seconds))} $next', intlLocale);
    }
    askAlarmPermission();
    notifyListeners();
  }

  String voiceDuration(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    if (m == 0) return t.voiceSeconds(s);
    if (s == 0) return t.voiceMinutes(m);
    return '${t.voiceMinutes(m)} ${t.voiceAnd} ${t.voiceSeconds(s)}';
  }

  String? voiceNext() {
    final s = session;
    if (s == null || s.exercises.isEmpty) return null;
    var i = s.currentIndex.clamp(0, s.exercises.length - 1);
    var pending = s.exercises[i].sets.indexWhere((st) => !st.done);
    if (pending < 0) {
      final after = pendingAfter(i);
      if (after == null) return null;
      i = after;
      pending = s.exercises[i].sets.indexWhere((st) => !st.done);
      if (pending < 0) return null;
    }
    final ex = s.exercises[i];
    final st = ex.sets[pending];
    final name = t.catalogName(ex.id, ex.name);
    final String load;
    if (st.sec != null) {
      load = voiceDuration(st.sec!);
    } else if (st.km != null) {
      load = fit.loggedSetLabel(st.logged);
    } else if (isRepsOnly(ex.id) || st.weight <= 0) {
      load = t.voiceReps(st.reps);
    } else {
      load = t.voiceLoad(st.reps, weightLabel(st.weight));
    }
    return t.voiceNext(name, load);
  }

  void _armRest(int seconds) {
    final s = session;
    if (s == null) return;
    _restTimer?.cancel();
    s.restFrozen = null;
    s.restEndsAt = DateTime.now().add(Duration(seconds: seconds));
    RestAlarm.instance.schedule(Duration(seconds: seconds));
    _restTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      final live = session;
      if (live == null || live.restEndsAt == null) {
        t.cancel();
        return;
      }
      final left = live.restRemaining;
      if (left == null) {
        restElapsed();
        return;
      }
      if (voiceCoach && left <= 3) VoiceCoach.say('$left', intlLocale);
      clock.value++;
    });
  }

  void restElapsed() {
    final s = session;
    if (s == null || s.restEndsAt == null || s.restRemaining != null) return;
    _restTimer?.cancel();
    s.clearRest();
    restDoneTick++;
    if (voiceCoach) VoiceCoach.say(t.voiceGo, intlLocale);
    RestAlarm.instance.fireNow();
    _holdNextOnItsOwn();
    notifyListeners();
  }

  int _heldEx = -1;

  void _holdNextOnItsOwn() {
    final s = session;
    final exIdx = _heldEx;
    _heldEx = -1;
    if (!autoHold || s == null || holding || s.restEndsAt != null || exIdx < 0 || exIdx >= s.exercises.length) return;
    if (s.currentIndex != exIdx) return;
    final ex = s.exercises[exIdx];
    if (modeOf(ex.id) != 'time') return;
    final next = ex.sets.indexWhere((st) => !st.done && st.counts);
    if (next < 0) return;
    startHold(exIdx, next);
  }

  void syncRest() {
    final s = session;
    if (s == null || s.restEndsAt == null) return;
    final left = s.restRemaining;
    if (left == null) {
      _restTimer?.cancel();
      s.clearRest();
      RestAlarm.instance.cancel();
    } else if (!(_restTimer?.isActive ?? false)) {
      restTotal = math.max(restTotal, left);
      _armRest(left);
    } else {
      return;
    }
    notifyListeners();
  }

  void nudgeRest(int seconds) {
    final s = session;
    final left = s?.restRemaining;
    if (s == null || left == null) return;
    final next = (left + seconds).clamp(5, 600);
    restTotal = seconds > 0 ? math.max(next, restTotal + (next - left)) : math.max(restTotal, next);
    _armRest(next);
    notifyListeners();
  }

  void setRest(int seconds) {
    final s = session;
    if (s == null) return;
    if (seconds <= 0) {
      skipRest();
      return;
    }
    final next = seconds.clamp(5, 600);
    RestAlarm.instance.stopSound();
    restTotal = next;
    if (sessionPaused) {
      s.restEndsAt = null;
      s.restFrozen = next;
      _persist();
    } else {
      _armRest(next);
    }
    notifyListeners();
  }

  void skipRest() {
    _restTimer?.cancel();
    RestAlarm.instance.cancel();
    RestAlarm.instance.stopSound();
    session?.clearRest();
    notifyListeners();
  }

  void addSet(int exIdx) {
    final ex = session!.exercises[exIdx];
    final sets = ex.sets;
    if (sets.isEmpty) {
      final mode = modeOf(ex.id);
      sets.add(mode.isEmpty
          ? SessionSet(10, isRepsOnly(ex.id) ? 0 : 20, false)
          : _modeOpeners(mode, const []).first);
    } else {
      final last = sets.last;
      sets.add(SessionSet(last.reps, last.weight, false,
          kind: last.kind, sec: last.sec, km: last.km, repsR: last.repsR));
    }
    syncSides(ex);
    _persist();
    notifyListeners();
  }

  void setSessionSeconds(int exIdx, int setIdx, int sec) {
    _carry(exIdx, setIdx, (st) => st.sec, (st, v) => st.sec = v, sec.clamp(0, 24 * 3600));
    _persist();
    notifyListeners();
  }

  void bumpSessionSeconds(int exIdx, int setIdx, int delta) {
    final st = session!.exercises[exIdx].sets[setIdx];
    final now = st.sec ?? 0;
    final step = delta.abs();
    final snapped = ((now / step).round() * step) + delta;
    setSessionSeconds(exIdx, setIdx, snapped < 0 ? 0 : snapped);
  }

  void setSessionKm(int exIdx, int setIdx, double km) {
    _carry(exIdx, setIdx, (st) => st.km, (st, v) => st.km = v, _round3(km.clamp(0, 1000)));
    _persist();
    notifyListeners();
  }

  void setSessionDistanceShown(int exIdx, int setIdx, double shown) =>
      setSessionKm(exIdx, setIdx, fromDisplayKmFor(session!.exercises[exIdx].id, shown));

  void bumpSessionDistance(int exIdx, int setIdx, int dir) {
    final st = session!.exercises[exIdx].sets[setIdx];
    final shown = toDisplayKmFor(session!.exercises[exIdx].id, st.km ?? 0);
    final next = ((shown / distanceStep).round() + dir) * distanceStep;
    setSessionDistanceShown(exIdx, setIdx, next < 0 ? 0 : next);
  }

  DateTime? holdEndsAt;
  DateTime? holdStartsAt;
  int holdEx = -1;
  int holdSet = -1;
  int holdSide = 0;
  int holdSides = 1;
  DateTime? holdOverFrom;
  int _pausedOverMs = 0;
  Timer? _holdTimer;

  bool get holdOvertime => holdOverFrom != null;

  int get holdExtra {
    final from = holdOverFrom;
    if (from == null) return 0;
    if (holdPaused) return _pausedOverMs ~/ 1000;
    return math.max(0, DateTime.now().difference(from).inSeconds);
  }

  static const holdLeadIn = 5;

  static int _secondsUntil(DateTime? at) {
    if (at == null) return 0;
    final left = at.difference(DateTime.now()).inMilliseconds;
    return left <= 0 ? 0 : (left / 1000).ceil();
  }

  bool holdPaused = false;
  int _pausedLeadMs = 0;
  int _pausedEndMs = 0;

  int get holdLead => holdPaused ? (_pausedLeadMs / 1000).ceil() : _secondsUntil(holdStartsAt);

  int? get holdRemaining {
    final end = holdEndsAt;
    if (end == null) return null;
    return math.min(holdPaused ? (_pausedEndMs / 1000).ceil() : _secondsUntil(end), holdTotal);
  }

  void toggleHoldPause() {
    final start = holdStartsAt, end = holdEndsAt;
    if (start == null || end == null) return;
    final now = DateTime.now();
    final over = holdOverFrom;
    if (over != null) {
      if (holdPaused) {
        holdOverFrom = now.subtract(Duration(milliseconds: _pausedOverMs));
        holdPaused = false;
        _runHold();
      } else {
        _pausedOverMs = math.max(0, now.difference(over).inMilliseconds);
        _holdTimer?.cancel();
        holdPaused = true;
      }
      notifyListeners();
      return;
    }
    if (holdPaused) {
      holdStartsAt = now.add(Duration(milliseconds: _pausedLeadMs));
      holdEndsAt = now.add(Duration(milliseconds: _pausedEndMs));
      holdPaused = false;
      _runHold();
    } else {
      _pausedLeadMs = math.max(0, start.difference(now).inMilliseconds);
      _pausedEndMs = math.max(0, end.difference(now).inMilliseconds);
      _holdTimer?.cancel();
      holdPaused = true;
    }
    notifyListeners();
  }

  void completeHold() {
    if (holdOvertime) {
      _finishOvertime();
      return;
    }
    final s = session;
    if (s != null && holdEx >= 0 && holdEx < s.exercises.length && holdLead == 0) {
      final ex = s.exercises[holdEx];
      final ran = holdTotal - (holdRemaining ?? 0);
      final mode = modeOf(ex.id);
      final short = mode == 'cardio' ? ran < holdTotal : ran < holdTotal - 2;
      if ((mode == 'cardio' || mode == 'time') && ran > 0 && short && holdSet < ex.sets.length) {
        ex.sets[holdSet].sec = ran;
      }
    }
    _finishHold();
  }

  bool get holding => holdEndsAt != null;

  int holdTotal = 0;

  ({int done, int total}) get sessionSetCount {
    final s = session;
    if (s == null) return (done: 0, total: 0);
    var done = 0, total = 0;
    for (final e in s.exercises) {
      for (final st in e.sets) {
        if (!st.counts) continue;
        total++;
        if (st.done) done++;
      }
    }
    return (done: done, total: total);
  }

  void startHold(int exIdx, int setIdx) {
    final s = session;
    if (s == null || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    if (setIdx < 0 || setIdx >= sets.length) return;
    final secs = (sets[setIdx].sec ?? 30).clamp(1, 18000);
    if (s.restRemaining != null) skipRest();
    holdEx = exIdx;
    holdSet = setIdx;
    holdSide = 0;
    holdSides = isEachSide(s.exercises[exIdx].id) ? 2 : 1;
    holdTotal = secs;
    holdOverFrom = null;
    final now = DateTime.now();
    holdStartsAt = now.add(const Duration(seconds: holdLeadIn));
    holdEndsAt = holdStartsAt!.add(Duration(seconds: secs));
    holdPaused = false;
    _runHold();
    notifyListeners();
  }

  void _runHold() {
    _holdTimer?.cancel();
    final sound = alarmStyle != 'vibrate';
    var shownLead = holdLead;
    var shown = holdRemaining;
    var shownExtra = holdExtra;
    _holdTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (holdOverFrom != null) {
        final extra = holdExtra;
        if (extra != shownExtra) {
          shownExtra = extra;
          clock.value++;
        }
        return;
      }
      final lead = holdLead;
      final left = holdRemaining;
      if (left == 0) {
        Beeper.instance.go(sound: sound);
        if (holdSide + 1 < holdSides) {
          _nextSide();
        } else if (_holdKeepsCounting) {
          holdOverFrom = DateTime.now();
          shownExtra = 0;
          clock.value++;
          notifyListeners();
        } else {
          _finishHold();
        }
        return;
      }
      if (lead != shownLead) {
        shownLead = lead;
        if (lead == 0) {
          Beeper.instance.go(sound: sound);
        } else if (lead <= 3) {
          Beeper.instance.tick(sound: sound);
        }
        clock.value++;
      } else if (left != shown) {
        shown = left;
        if (lead == 0 && left != null && left <= 3) Beeper.instance.tick(sound: sound);
        clock.value++;
      }
    });
  }

  String holdLength(String exId, int sec) =>
      isEachSide(exId) ? '${durationLabel(sec)} × 2' : durationLabel(sec);

  bool get switchingSides => holdSide > 0 && holdLead > 0;

  void _nextSide() {
    holdSide++;
    holdStartsAt = DateTime.now().add(const Duration(seconds: holdLeadIn));
    holdEndsAt = holdStartsAt!.add(Duration(seconds: holdTotal));
    _runHold();
    notifyListeners();
  }

  bool get _holdKeepsCounting {
    final s = session;
    if (s == null || holdEx < 0 || holdEx >= s.exercises.length || holdSides > 1) return false;
    return keepsCounting(s.exercises[holdEx].id);
  }

  void _finishOvertime() {
    final s = session;
    if (s != null && holdEx >= 0 && holdEx < s.exercises.length) {
      final sets = s.exercises[holdEx].sets;
      if (holdSet >= 0 && holdSet < sets.length) sets[holdSet].sec = (holdTotal + holdExtra).clamp(1, 18000);
    }
    _finishHold();
  }

  void stopHold() {
    if (holdOvertime) {
      _finishOvertime();
      return;
    }
    _clearHold();
  }

  void _clearHold() {
    _holdTimer?.cancel();
    _holdTimer = null;
    holdPaused = false;
    holdSide = 0;
    holdSides = 1;
    holdEndsAt = null;
    holdStartsAt = null;
    holdOverFrom = null;
    holdEx = -1;
    holdSet = -1;
    notifyListeners();
  }

  void _finishHold() {
    final exIdx = holdEx, setIdx = holdSet;
    _clearHold();
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    if (setIdx < 0 || setIdx >= sets.length || sets[setIdx].done) return;
    toggleSet(exIdx, setIdx);
    _heldEx = exIdx;
    if (session?.restEndsAt == null) _holdNextOnItsOwn();
  }

  SessionSet? removeSet(int exIdx, int setIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return null;
    final sets = s.exercises[exIdx].sets;
    if (setIdx < 0 || setIdx >= sets.length) return null;
    final gone = sets.removeAt(setIdx);
    _persist();
    notifyListeners();
    return gone;
  }

  SessionSet? duplicateSet(int exIdx, int setIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return null;
    final sets = s.exercises[exIdx].sets;
    if (setIdx < 0 || setIdx >= sets.length) return null;
    final copy = sets[setIdx].copy();
    sets.insert(setIdx + 1, copy);
    _persist();
    notifyListeners();
    return copy;
  }

  void removeSetObject(int exIdx, SessionSet set) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    if (!s.exercises[exIdx].sets.remove(set)) return;
    _persist();
    notifyListeners();
  }

  void insertSet(int exIdx, int setIdx, SessionSet set) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    sets.insert(setIdx.clamp(0, sets.length), set);
    _persist();
    notifyListeners();
  }

  void removeWarmupSets(int exIdx) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    s.exercises[exIdx].sets.removeWhere((st) => st.kind == SetKind.warmup && !st.done);
    _persist();
    notifyListeners();
  }

  void goToExercise(int i) {
    final s = session;
    if (s == null || i < 0 || i >= s.exercises.length || i == s.currentIndex) return;
    _advanceTimer?.cancel();
    s.currentIndex = i;
    _persist();
    notifyListeners();
  }

  SessionExercise _unchain(SessionExercise ex) => ex
    ..linkedNext = false
    ..jumpNext = false;

  void reorderSessionExercise(int from, int to) {
    final s = session;
    if (s == null || from < 0 || from >= s.exercises.length) return;
    if (to > from) to -= 1;
    to = to.clamp(0, s.exercises.length - 1);
    if (to == from) return;
    final current = s.exercises[s.currentIndex];
    if (from > 0) _unchain(s.exercises[from - 1]);
    final moved = _unchain(s.exercises.removeAt(from));
    s.exercises.insert(to, moved);
    if (to > 0) _unchain(s.exercises[to - 1]);
    s.currentIndex = s.exercises.indexOf(current);
    _persist();
    notifyListeners();
  }

  void bumpSessionReps(int exIdx, int setIdx, int d) =>
      setSessionReps(exIdx, setIdx, session!.exercises[exIdx].sets[setIdx].reps + d);

  void bumpSessionRepsRight(int exIdx, int setIdx, int d) {
    final st = session!.exercises[exIdx].sets[setIdx];
    setSessionRepsRight(exIdx, setIdx, (st.repsR ?? st.reps) + d);
  }

  void bumpSessionWeight(int exIdx, int setIdx, int dir) {
    final id = session!.exercises[exIdx].id;
    if (stackFor(id) != null) {
      setSessionWeight(exIdx, setIdx, snapToStack(id, session!.exercises[exIdx].sets[setIdx].weight, dir: dir));
      return;
    }
    final current = toShownFor(id, session!.exercises[exIdx].sets[setIdx].weight);
    final step = weightStepFor(id);
    final next = _roundTo(current, step) + dir * step;
    setSessionWeight(exIdx, setIdx, fromShownFor(id, math.max(0, next)));
  }

  static const _warmupSpec = [(0.4, 10), (0.6, 5), (0.8, 3)];

  List<SessionSet> _warmupFor(List<SessionSet> sets, [String? id]) {
    if (sets.isEmpty) return const [];
    final target = sets.map((st) => st.weight).reduce(math.max);
    if (target <= 0) {
      final reps = sets.map((st) => st.reps).reduce(math.max);
      return reps < 2 ? const [] : [SessionSet((reps / 2).ceil(), 0, false, kind: SetKind.warmup)];
    }
    return [
      for (final spec in _warmupSpec)
        SessionSet(
          spec.$2,
          id != null && stackFor(id) != null
              ? snapToStack(id, target * spec.$1)
              : fromDisplayWeight(_roundTo(toDisplayWeight(target * spec.$1), plateStep)),
          false,
          kind: SetKind.warmup,
        ),
    ];
  }

  bool hasWarmup(int exIdx) {
    final s = session;
    if (s == null || exIdx >= s.exercises.length) return false;
    return s.exercises[exIdx].sets.any((st) => st.kind == SetKind.warmup);
  }

  void addWarmupSets(int exIdx) {
    final s = session;
    if (s == null || exIdx >= s.exercises.length) return;
    if (modeOf(s.exercises[exIdx].id).isNotEmpty) return;
    final sets = s.exercises[exIdx].sets;
    if (hasWarmup(exIdx)) return;
    final warm = _warmupFor(sets, s.exercises[exIdx].id);
    if (warm.isEmpty) return;
    sets.insertAll(0, warm);
    syncSides(s.exercises[exIdx]);
    _persist();
    notifyListeners();
  }

  void setSessionRpe(int exIdx, int setIdx, double? rpe) {
    final s = session;
    if (s == null || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    if (setIdx >= sets.length) return;
    sets[setIdx].rpe = rpe;
    _persist();
    notifyListeners();
    if (rpe != null && sets[setIdx].done && (autoAdvance || sessionLocked) && _advanceTimer?.isActive == true) {
      _advanceWhenDone(exIdx);
    }
  }

  void setSetNote(int exIdx, int setIdx, String note) {
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    if (setIdx < 0 || setIdx >= sets.length) return;
    final clean = note.length > 280 ? note.substring(0, 280) : note;
    if (sets[setIdx].note == clean) return;
    sets[setIdx].note = clean;
    _persist();
    notifyListeners();
  }

  List<(int, String)> lastSetNotes(String exId, [int nth = 0]) {
    final last = lastSetsFor(exId, nth);
    return [
      for (var i = 0; i < last.length; i++)
        if (last[i].note.isNotEmpty) (i + 1, last[i].note),
    ];
  }

  void setSetKind(int exIdx, int setIdx, SetKind kind) {
    final s = session;
    if (s == null || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    if (setIdx >= sets.length) return;
    sets[setIdx].kind = kind;
    _persist();
    notifyListeners();
  }

  void setSessionReps(int exIdx, int setIdx, int reps) {
    _carry(exIdx, setIdx, (st) => st.reps, (st, v) => st.reps = v, reps.clamp(0, 999));
    _persist();
    notifyListeners();
  }

  void setSessionRepsRight(int exIdx, int setIdx, int reps) {
    _carry(exIdx, setIdx, (st) => st.repsR ?? st.reps, (st, v) => st.repsR = v, reps.clamp(0, 999));
    _persist();
    notifyListeners();
  }

  void setSessionWeight(int exIdx, int setIdx, double kg) {
    _carry(exIdx, setIdx, (st) => st.weight, (st, v) => st.weight = v, _round3(kg.clamp(0, 1000)));
    _persist();
    notifyListeners();
  }

  void _carry<T>(int exIdx, int setIdx, T Function(SessionSet) read, void Function(SessionSet, T) write, T value) {
    final sets = session!.exercises[exIdx].sets;
    final st = sets[setIdx];
    final before = read(st);
    write(st, value);
    if (before == value) return;
    for (var j = setIdx + 1; j < sets.length; j++) {
      final later = sets[j];
      if (later.done || later.kind != st.kind || read(later) != before) break;
      write(later, value);
    }
  }

  void setSessionWeightShown(int exIdx, int setIdx, double shown) =>
      setSessionWeight(exIdx, setIdx, fromShownFor(session!.exercises[exIdx].id, shown));

  void removeSessionExercise(int exIdx) {
    final s = session!;
    if (exIdx < 0 || exIdx >= s.exercises.length) return;
    s.exercises.removeAt(exIdx);
    if (s.exercises.isEmpty) {
      discardSession();
      return;
    }
    _unchain(s.exercises.last);
    s.currentIndex = s.currentIndex.clamp(0, s.exercises.length - 1);
    persistNow();
    notifyListeners();
  }

  void addExerciseToSession(String id) {
    final s = session;
    final ex = exerciseById(id);
    if (s == null || ex == null || s.exercises.any((e) => e.id == id)) return;
    final chain = chainAt(s.currentIndex);
    final at = chain.isEmpty ? s.exercises.length : chain.last + 1;
    s.exercises.insert(at, SessionExercise(ex.id, ex.name, ex.primary, _openingSets(id)));
    _advanceTimer?.cancel();
    s.currentIndex = at;
    persistNow();
    notifyListeners();
  }

  List<Exercise> sessionAltsFor(int exIdx) {
    final s = session;
    final r = sessionRoutine;
    if (s == null || r == null || exIdx < 0 || exIdx >= s.exercises.length) return const [];
    final slot = s.exercises[exIdx].routineSlot;
    final back = s.exercises[exIdx].swappedFrom;
    return [
      if (back != null && !inSession(back)) ?exerciseById(back),
      for (final id in r.alts[slot] ?? const <String>[])
        if (id != s.exercises[exIdx].id && !inSession(id)) ?exerciseById(id),
    ];
  }

  List<Exercise> swapOptions(String exId, {int n = 15}) {
    final from = exerciseById(exId);
    if (from == null) return const [];
    final cardio = modeOf(exId) == 'cardio';
    final pool = allExercises
        .where((e) =>
            e.id != exId &&
            e.primary == from.primary &&
            !inSession(e.id) &&
            !isArchived(e.id) &&
            (modeOf(e.id) == 'cardio') == cardio)
        .toList();
    final shared = from.secondary.toSet();
    int score(Exercise e) =>
        (fitsHere(e) ? 8 : 0) +
        (favorites[e.id] == true ? 4 : 0) +
        (lastSetsFor(e.id).isNotEmpty ? 3 : 0) +
        (e.secondary.where(shared.contains).isNotEmpty ? 1 : 0);
    final ranked = [
      for (var i = 0; i < pool.length; i++) (ex: pool[i], score: score(pool[i]), seat: i),
    ]..sort((a, b) => a.score == b.score ? a.seat.compareTo(b.seat) : b.score.compareTo(a.score));
    return [for (final r in ranked.take(n)) r.ex];
  }

  void swapSessionExercise(int exIdx, String toId) {
    final s = session;
    final to = exerciseById(toId);
    if (s == null || to == null || exIdx < 0 || exIdx >= s.exercises.length || inSession(toId)) return;
    final from = s.exercises[exIdx];
    final left = from.sets.where((st) => !st.done && st.counts).length;
    final started = from.sets.any((st) => st.done);
    final count = left > 0 ? left : null;
    final next = SessionExercise(to.id, to.name, to.primary,
        started ? _withSides(toId, _workingOpeners(toId, count: count)) : _openingSets(toId, count: count),
        linkedNext: from.linkedNext,
        jumpNext: from.jumpNext,
        swappedFrom: from.swappedFrom ?? from.id,
        slot: from.slot);
    if (started) {
      from.sets.removeWhere((st) => !st.done);
      _unchain(from);
      s.exercises.insert(exIdx + 1, next);
      s.currentIndex = exIdx + 1;
    } else {
      s.exercises[exIdx] = next;
      s.currentIndex = exIdx;
    }
    persistNow();
    notifyListeners();
  }

  List<Exercise> sessionSuggestions() {
    final inSession = session?.exercises.map((e) => e.id).toSet() ?? <String>{};
    final ids = <String>[];
    for (final e in allExercises) {
      if (favorites[e.id] == true && !inSession.contains(e.id)) ids.add(e.id);
    }
    for (final s in sessions.reversed) {
      for (final e in s.exercises) {
        if (!inSession.contains(e.id) && !ids.contains(e.id)) ids.add(e.id);
      }
      if (ids.length >= 12) break;
    }
    final out = <Exercise>[];
    for (final id in ids.take(12)) {
      final ex = exerciseById(id);
      if (ex != null && !isArchived(id)) out.add(ex);
    }
    return out;
  }

  bool inSession(String id) => session?.exercises.any((e) => e.id == id) ?? false;

  void nextExercise() {
    final s = session!;
    var next = s.currentIndex + 1;
    final chain = chainAt(s.currentIndex);
    if (chain.length > 1) {
      final after = chain.where((i) => i > s.currentIndex && s.exercises[i].hasUndone);
      next = after.isNotEmpty ? after.first : chain.last + 1;
      if (next >= s.exercises.length) next = s.currentIndex + 1;
    }
    s.currentIndex = math.min(next, s.exercises.length - 1);
    _persist();
    notifyListeners();
  }

  void prevExercise() {
    final s = session!;
    s.currentIndex = math.max(s.currentIndex - 1, 0);
    _persist();
    notifyListeners();
  }

  void finishSession() {
    _holdTimer?.cancel();
    holdEndsAt = null;
    holdOverFrom = null;
    _advanceTimer?.cancel();
    _sessionTimer?.cancel();
    _restTimer?.cancel();
    RestAlarm.instance.cancel();
    final s = session!;
    final done = <SessionSet>[];
    final working = <SessionSet>[];
    for (final e in s.exercises) {
      for (final st in e.sets) {
        if (!st.done) continue;
        done.add(st);
        if (st.counts) working.add(st);
      }
    }
    s.summaryVolume = sessionVolumeKg.round();
    s.summarySets = working.length;
    s.summaryDuration = s.manual ? _elapsedBefore : sessionElapsed;
    s.complete = true;
    s.clearRest();
    sessionLocked = false;

    if (done.isNotEmpty) {
      final logged = <LoggedExercise>[];
      for (final e in s.exercises) {
        final doneSets = e.sets.where((st) => st.done).map((st) => st.logged).toList();
        if (doneSets.isNotEmpty) {
          logged.add(LoggedExercise(e.id, e.name, e.primary, doneSets, incline: lastIncline(e.id)));
        }
      }
      final entry = LoggedSession(s.loggedAt ?? DateTime.now(), s.summaryDuration ?? 0, logged, routineId: s.routineId, name: s.name, deload: s.deload);
      sessions.add(entry);
      sessions.sort((a, b) => a.date.compareTo(b.date));
      _rotationBefore = (rotationNextId, rotationRestDay);
      _advanceRotation(entry.routineId, entry.date);
      _filed = entry;
      final photos = _photosFrom;
      if (photos != null) _moveMoments(photos, entry.date);
      _photosFrom = null;
      _computeSummaryHighlights(entry);
      _offerLevelUp(entry);
      healthSave(entry);
    } else {
      _filed = null;
      summaryPrs = 0;
      summaryRecords = const [];
      summaryVsLast = null;
      summaryFirstTime = false;
      summaryLevelUp = null;
    }
    persistNow();
    _refreshWidgets();
    syncTrainReminder();
    refreshAwards();
    notifyListeners();
  }

  List<SessionExercise> get _savable =>
      [for (final e in session?.exercises ?? const <SessionExercise>[]) if (exerciseById(e.id) != null) e];

  String? _keptSlot(SessionExercise e) {
    final r = sessionRoutine;
    if (r == null) return null;
    final slot = e.routineSlot;
    if (!r.exerciseIds.contains(slot)) return null;
    if (slotExercise(slot) == e.id || r.alts[slot]?.contains(e.id) == true) return slot;
    return null;
  }

  Map<String, String> get _swaps {
    final r = sessionRoutine;
    if (r == null) return const {};
    final out = <String, String>{};
    for (final e in _savable) {
      final slot = e.routineSlot;
      if (!r.exerciseIds.contains(slot) || _keptSlot(e) != null || out.containsKey(slot)) continue;
      out[slot] = e.id;
    }
    return out;
  }

  List<({String? slot, SessionExercise e, bool keep})> get _routineLayout {
    final r = sessionRoutine;
    if (r == null) return const [];
    final swaps = _swaps;
    final used = <String>{};
    final out = <({String? slot, SessionExercise e, bool keep})>[];
    for (final e in _savable) {
      final slot = e.routineSlot;
      final swapped = swaps[slot];
      if (swapped != null) {
        if (swapped == e.id && used.add(slot)) out.add((slot: slot, e: e, keep: false));
        continue;
      }
      final kept = _keptSlot(e);
      if (kept != null) {
        if (used.add(kept)) out.add((slot: kept, e: e, keep: true));
        continue;
      }
      out.add((slot: null, e: e, keep: false));
    }
    return out;
  }

  void _planFromSession(String routineId, String slot, SessionExercise ex) {
    if (ex.sets.isEmpty) return;
    setPlannedSets(routineId, slot, [
      for (final st in ex.sets)
        PlannedSet(
          reps: modeOf(ex.id).isEmpty ? st.weakReps : null,
          weightKg: st.weight > 0 ? st.weight : null,
          kind: st.kind,
          sec: st.sec,
          km: st.km,
        ),
    ]);
  }

  Routine? get sessionRoutine {
    final id = session?.routineId;
    return id == null ? null : _routine(id);
  }

  bool get sessionEditedRoutine {
    final r = sessionRoutine;
    if (r == null) return false;
    final now = [for (final l in _routineLayout) l.keep ? l.slot! : '+${l.e.id}'];
    final before = [for (final x in routineSlots(r)) x.slot];
    return now.join('|') != before.join('|') || _sessionSetChanges.isNotEmpty;
  }

  List<({Exercise ex, String slot, int from, int to})> get _sessionSetChanges {
    final r = sessionRoutine;
    if (r == null) return const [];
    final out = <({Exercise ex, String slot, int from, int to})>[];
    final tuned = {for (final v in _votes.values) v.exId};
    for (final l in _routineLayout) {
      final slot = l.slot;
      if (!l.keep || slot == null || slotExercise(slot) != l.e.id || tuned.contains(slot)) continue;
      final to = l.e.sets.where((st) => st.kind != SetKind.warmup).length;
      final from = routineSets(r, slot);
      if (to > 0 && to != from) out.add((ex: exerciseById(l.e.id)!, slot: slot, from: from, to: to));
    }
    return out;
  }

  ({List<Exercise> added, List<Exercise> removed, bool reordered, List<({Exercise ex, String slot, int from, int to})> sets})
      get sessionRoutineChanges {
    final r = sessionRoutine;
    final layout = _routineLayout;
    final kept = [for (final l in layout) if (l.keep) l.slot!];
    final keptSet = kept.toSet();
    final before = r == null ? const <({String slot, Exercise ex})>[] : routineSlots(r);
    return (
      added: [for (final l in layout) if (!l.keep) ?exerciseById(l.e.id)],
      removed: [for (final x in before) if (!keptSet.contains(x.slot)) x.ex],
      reordered: [for (final x in before) if (keptSet.contains(x.slot)) x.slot].join('|') != kept.join('|'),
      sets: _sessionSetChanges,
    );
  }

  String saveSessionAsRoutine(String name) {
    final exs = _savable;
    if (exs.isEmpty) return '';
    final id = createRoutine(name);
    for (final ex in exs) {
      final slot = addRoutineSlot(id, ex.id);
      if (slot.isEmpty) continue;
      ex.slot = slot;
      if (ex.linkedNext) toggleChain(id, slot);
      if (ex.jumpNext) toggleJump(id, slot);
      _planFromSession(id, slot, ex);
    }
    session!.routineId = id;
    persistNow();
    notifyListeners();
    return id;
  }

  void saveSessionIntoRoutine() {
    final r = sessionRoutine;
    if (r == null) return;
    final layout = _routineLayout;
    final counts = _sessionSetChanges;
    final order = <String>[];
    for (final l in layout) {
      final slot = l.slot;
      if (l.keep) {
        order.add(slot!);
      } else if (slot != null) {
        final made = replaceRoutineExercise(r.id, slot, l.e.id, beside: true);
        if (made == null) continue;
        l.e.slot = made;
        order.add(made);
      } else {
        final made = r.freeSlot(l.e.id);
        r.exerciseIds.add(made);
        _planFromSession(r.id, made, l.e);
        l.e.slot = made;
        order.add(made);
      }
    }
    for (final slot in [...r.exerciseIds]) {
      if (!order.contains(slot)) r.dropSlot(slot);
    }
    r.exerciseIds
      ..clear()
      ..addAll(order);
    for (final c in counts) {
      bumpRoutineSets(r.id, c.slot, c.to - c.from);
    }
    persistNow();
    notifyListeners();
  }

  List<SessionExercise> get sessionExtras => [
        for (final l in _routineLayout)
          if (!l.keep && l.slot == null && l.e.sets.any((st) => st.done)) l.e,
      ];

  bool addExtraToRoutine(String exId) {
    final r = sessionRoutine;
    final s = session;
    if (r == null || s == null) return false;
    final ex = sessionExtras.where((e) => e.id == exId).firstOrNull;
    if (ex == null) return false;
    final i = s.exercises.indexOf(ex);
    var at = 0;
    for (var j = i - 1; j >= 0; j--) {
      final k = r.exerciseIds.indexOf(s.exercises[j].routineSlot);
      if (k >= 0) {
        at = k + 1;
        break;
      }
    }
    final slot = r.freeSlot(exId);
    r.exerciseIds.insert(at.clamp(0, r.exerciseIds.length), slot);
    ex.slot = slot;
    final done = ex.sets.where((st) => st.done).toList();
    final timed = modeOf(exId).isNotEmpty;
    if (done.isNotEmpty) {
      setPlannedSets(r.id, slot, [
        for (final st in done)
          PlannedSet(
            reps: timed ? null : st.weakReps,
            weightKg: st.weight > 0 ? st.weight : null,
            kind: st.kind,
            sec: st.sec,
            km: st.km,
          ),
      ]);
    }
    persistNow();
    notifyListeners();
    return true;
  }

  double get summaryVolumeKg => (session?.summaryVolume ?? 0).toDouble();

  int summaryPrs = 0;
  List<(LoggedExercise, LoggedSet)> summaryRecords = const [];
  int? summaryVsLast;
  bool summaryFirstTime = false;

  void _computeSummaryHighlights(LoggedSession entry) {
    final records = <(LoggedExercise, LoggedSet)>[];
    final carried = <String, _Best?>{};
    for (final e in entry.exercises) {
      _Best? best;
      if (carried.containsKey(e.id)) {
        best = carried[e.id];
      } else {
        for (final s in sessions) {
          if (identical(s, entry)) continue;
          for (final x in s.exercises) {
            if (x.id != e.id) continue;
            for (final st in x.workingSets) {
              best = _raise(e.id, st, best);
            }
          }
        }
      }
      LoggedSet? top;
      for (final st in e.workingSets) {
        if (_beats(e.id, st, best) && (top == null || _setScore(e.id, st) >= _setScore(e.id, top))) top = st;
        best = _raise(e.id, st, best);
      }
      carried[e.id] = best;
      if (top != null) records.add((e, top));
    }
    summaryRecords = records;
    summaryPrs = records.length;

    final ids = entry.exercises.map((e) => e.id).toSet();
    LoggedSession? previous;
    for (final s in sessions.reversed) {
      if (identical(s, entry)) continue;
      if (s.exercises.any((e) => ids.contains(e.id))) {
        previous = s;
        break;
      }
    }
    summaryFirstTime = previous == null;
    summaryVsLast = previous == null ? null : _vsLastPct(entry, previous);
  }

  int? _vsLastPct(LoggedSession now, LoggedSession before) {
    double measure(LoggedExercise e, double Function(LoggedSet) of) =>
        e.workingSets.fold(0.0, (sum, x) => sum + of(x));
    final measures = <double Function(LoggedSet)>[
      (x) => x.weight * x.reps,
      (x) => x.reps.toDouble(),
      (x) => (x.sec ?? 0).toDouble(),
      (x) => x.km ?? 0,
    ];
    final changes = <double>[];
    final seen = <String, int>{};
    for (final e in now.exercises) {
      final nth = seen[e.id] ?? 0;
      seen[e.id] = nth + 1;
      final old = before.exercises.where((x) => x.id == e.id).toList();
      if (old.isEmpty) continue;
      final pair = nth < old.length ? old[nth] : old.first;
      for (final of in measures) {
        final a = measure(e, of), b = measure(pair, of);
        if (a <= 0 || b <= 0) continue;
        changes.add((a - b) / b);
        break;
      }
    }
    if (changes.isEmpty) return null;
    return (changes.reduce((a, b) => a + b) / changes.length * 100).round();
  }

  ({Exercise from, Exercise to, int reps})? summaryLevelUp;
  int? _levelQuietBefore;

  static const _levelQuiet = Duration(days: 7);
  static const _levelLater = Duration(days: 21);

  bool _clearsLevel(List<LoggedSet> sets, int reps) => sets.where((s) => s.counts && s.reps >= reps).length >= 3;

  void _offerLevelUp(LoggedSession entry) {
    summaryLevelUp = null;
    _levelQuietBefore = null;
    if (!levelHints) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final done = {for (final e in entry.exercises) e.id};
    final routine = entry.routineId == null ? null : routineById(entry.routineId!);
    ({Exercise from, Exercise to, int reps})? best;
    var bestStep = -1;
    for (final e in entry.exercises) {
      final next = nextStepIn(routine, e.id);
      if (next == null || done.contains(next) || levelStay.contains(e.id) || isArchived(next)) continue;
      if ((levelSeen[e.id] ?? 0) > now || modeOf(e.id).isNotEmpty) continue;
      final from = exerciseById(e.id);
      final to = exerciseById(next);
      if (from == null || to == null) continue;
      final reps = kSlowReps.contains(e.id) ? 5 : 8;
      if (!_clearsLevel(e.sets, reps)) continue;
      LoggedExercise? before;
      for (final s in sessions.reversed) {
        if (identical(s, entry)) continue;
        for (final x in s.exercises) {
          if (x.id == e.id) before = x;
        }
        if (before != null) break;
      }
      if (before == null || !_clearsLevel(before.sets, reps)) continue;
      final step = stepIndexIn(routine, e.id);
      if (step > bestStep) {
        bestStep = step;
        best = (from: from, to: to, reps: reps);
      }
    }
    if (best == null) return;
    summaryLevelUp = best;
    _levelQuietBefore = levelSeen[best.from.id];
    levelSeen[best.from.id] = now + _levelQuiet.inMilliseconds;
    levelShown[best.from.id] = [entry.date.millisecondsSinceEpoch, _levelQuietBefore ?? 0];
  }

  bool get levelUpInRoutine {
    final l = summaryLevelUp;
    final r = sessionRoutine;
    return l != null && r != null && r.hasExercise(l.from.id) && !r.hasExercise(l.to.id);
  }

  String? levelUpSwap() {
    final l = summaryLevelUp;
    final r = sessionRoutine;
    if (l == null || r == null || !levelUpInRoutine) return null;
    for (final slot in r.slotsOf(l.from.id)) {
      replaceRoutineExercise(r.id, slot, l.to.id, beside: true);
    }
    summaryLevelUp = null;
    persistNow();
    notifyListeners();
    return routineTitle(r);
  }

  void levelUpLater() {
    final l = summaryLevelUp;
    if (l == null) return;
    levelSeen[l.from.id] = DateTime.now().add(_levelLater).millisecondsSinceEpoch;
    levelShown.remove(l.from.id);
    summaryLevelUp = null;
    persistNow();
    notifyListeners();
  }

  VoidCallback? levelUpStay() {
    final l = summaryLevelUp;
    if (l == null) return null;
    levelStay.add(l.from.id);
    summaryLevelUp = null;
    persistNow();
    notifyListeners();
    return () {
      levelStay.remove(l.from.id);
      summaryLevelUp = l;
      persistNow();
      notifyListeners();
    };
  }

  LoggedSession? _filed;
  DateTime? _photosFrom;
  (String, DateTime?)? _rotationBefore;

  LoggedSession? get filedSession => _filed;

  void renameSession(LoggedSession s, String name) {
    final clean = name.trim().isEmpty ? null : name.trim();
    if (!sessions.contains(s) || clean == s.name) return;
    s.name = clean;
    if (identical(s, _filed)) session?.name = clean;
    persistNow();
    notifyListeners();
  }

  final Map<String, ({String exId, int vote})> _votes = {};

  List<({String muscle, String exId})> get tuneTargets {
    final r = sessionRoutine;
    final s = session;
    if (!muscleTune || r == null || s == null || _filed == null) return const [];
    final last = <String, String>{};
    final done = <String, int>{};
    for (final e in s.exercises) {
      final slot = _keptSlot(e);
      if (slot == null || modeOf(e.id).isNotEmpty || _drivesSets(slotExercise(slot))) continue;
      final n = e.sets.where((st) => st.done && st.counts).length;
      if (n == 0) continue;
      done[e.primary] = (done[e.primary] ?? 0) + n;
      last[e.primary] = slot;
    }
    final ranked = done.entries.where((e) => e.value >= 2).toList()..sort((a, b) => b.value.compareTo(a.value));
    return [for (final m in ranked.take(3)) (muscle: m.key, exId: _votes[m.key]?.exId ?? last[m.key]!)];
  }

  int? muscleVote(String muscle) => _votes[muscle]?.vote;

  void voteMuscle(String muscle, int? vote) {
    final r = sessionRoutine;
    if (r == null) return;
    final target = tuneTargets.where((m) => m.muscle == muscle).firstOrNull;
    if (target == null) return;
    final old = muscleVote(muscle) ?? 0;
    final next = vote?.clamp(-1, 1);
    final delta = (next ?? 0) - old;
    if (routineSets(r, target.exId) + delta < 1) return;
    if (delta != 0) bumpRoutineSets(r.id, target.exId, delta);
    if (next == null) {
      _votes.remove(muscle);
    } else {
      _votes[muscle] = (exId: target.exId, vote: next);
    }
    persistNow();
    notifyListeners();
  }

  void _undoVotes() {
    final r = sessionRoutine;
    if (r != null) {
      for (final v in _votes.values) {
        bumpRoutineSets(r.id, v.exId, -v.vote);
      }
    }
    _votes.clear();
  }

  void continueSession() {
    final s = session;
    if (s == null || !s.complete) return;
    _undoVotes();
    final level = summaryLevelUp;
    if (level != null) {
      final before = _levelQuietBefore;
      if (before == null) {
        levelSeen.remove(level.from.id);
      } else {
        levelSeen[level.from.id] = before;
      }
      levelShown.remove(level.from.id);
      summaryLevelUp = null;
    }
    final filed = _filed;
    if (filed != null) {
      sessions.remove(filed);
      _photosFrom = filed.date;
      final back = _rotationBefore;
      if (back != null) {
        rotationNextId = back.$1;
        rotationRestDay = back.$2;
      }
    }
    _filed = null;
    _rotationBefore = null;
    _elapsedBefore = s.summaryDuration ?? _elapsedBefore;
    s
      ..complete = false
      ..summaryVolume = null
      ..summarySets = null
      ..summaryDuration = null;
    sessionPaused = false;
    _startTicking();
    persistNow();
    _refreshWidgets();
    syncTrainReminder();
    notifyListeners();
  }

  void resumeLoggedSession(LoggedSession ls) {
    if (session != null && !session!.complete) return;
    sessions.remove(ls);
    final s = WorkoutSession()
      ..loggedAt = ls.date
      ..manual = _dayKey(ls.date) != _dayKey(DateTime.now())
      ..routineId = ls.routineId
      ..name = ls.name
      ..exercises = ls.exercises
          .map((e) => SessionExercise(
              e.id,
              e.name,
              e.primary,
              e.sets
                  .map((x) => SessionSet(x.sided ? x.left! : x.reps, x.weight, true,
                      kind: x.kind, rpe: x.rpe, sec: x.sec, km: x.km, note: x.note, repsR: x.right))
                  .toList()))
          .toList();
    _restTimer?.cancel();
    _elapsedBefore = ls.durationSec;
    sessionPaused = false;
    sessionLocked = false;
    _startTicking();
    session = s;
    resetRoute('session');
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  static const forgotGap = 30 * 60;

  DateTime? get forgotEndAt {
    final s = session;
    final filed = _filed;
    if (s == null || !s.complete || s.manual || filed == null) return null;
    final at = s.lastDoneAt, mark = s.lastDoneElapsed;
    if (at == null || mark == null) return null;
    if ((s.summaryDuration ?? 0) - mark < forgotGap) return null;
    return at;
  }

  void endAtLastSet() {
    final s = session;
    final filed = _filed;
    final mark = s?.lastDoneElapsed;
    if (s == null || filed == null || mark == null || forgotEndAt == null) return;
    final trimmed = mark + 60;
    s.summaryDuration = trimmed;
    setSessionDuration(filed, trimmed);
  }

  String get summaryDurationLabel {
    final d = session?.summaryDuration ?? 0;
    return '${d ~/ 60}:${(d % 60).toString().padLeft(2, '0')}';
  }

  void saveAndExit() {
    _holdTimer?.cancel();
    holdEndsAt = null;
    holdOverFrom = null;
    holdEx = -1;
    holdSet = -1;
    _advanceTimer?.cancel();
    _sessionTimer?.cancel();
    _restTimer?.cancel();
    RestAlarm.instance.cancel();
    _runningSince = null;
    _elapsedBefore = 0;
    sessionPaused = false;
    sessionLocked = false;
    session = null;
    _filed = null;
    _votes.clear();
    selectedMuscles.clear();
    sessionPicks.clear();
    pickSeed.clear();
    trainStep = 'select';
    logDay = null;
    resetRoute('home');
    persistNow();
    notifyListeners();
  }

  void discardSession() => saveAndExit();

  bool get isSessionActive => route == 'session' && session != null && !session!.complete;
  bool get isSessionComplete => route == 'session' && session != null && session!.complete;
}
