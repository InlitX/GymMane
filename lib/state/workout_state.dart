part of 'fit_state.dart';

mixin WorkoutState on FitCore, SettingsState, LibraryState, PlacesState, StatsState, RoutinesState {
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
    final rest = pool.where((e) => !picks.contains(e)).toList()
      ..sort((a, b) => rank(a).compareTo(rank(b)));
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
    final exs = routineExercises(r);
    if (exs.isEmpty) return;
    _beginSession(exs,
        plan: {for (final ex in exs) ex.id: routineSets(r, ex.id)},
        planned: {for (final ex in exs) if (hasPlan(r, ex.id)) ex.id: plannedSets(r, ex.id)},
        chained: {for (final ex in exs) if (chainsToNext(r, ex.id)) ex.id},
        routineId: r.id,
        on: on);
  }

  void startSession() {
    final exs = allExercises.where((e) => sessionPicks.contains(e.id)).toList();
    if (exs.isNotEmpty) _beginSession(exs, on: logDay);
  }

  List<SessionSet> _fromPlan(String id, List<PlannedSet> planned) {
    final working = planned.where((p) => p.kind != SetKind.warmup).length;
    final base = _workingOpeners(id, count: working == 0 ? 1 : working);
    final first = base.isEmpty ? SessionSet(10, 0, false) : base.first;
    final warmWeight = fromDisplayWeight(_roundTo(toDisplayWeight(first.weight * 0.5), weightStep));
    final out = <SessionSet>[];
    var w = 0;
    for (final p in planned) {
      final warm = p.kind == SetKind.warmup;
      final b = warm || base.isEmpty ? first : base[(w++).clamp(0, base.length - 1)];
      out.add(SessionSet(
        p.reps ?? (warm ? 10 : b.reps),
        p.weightKg ?? (warm ? warmWeight : b.weight),
        false,
        kind: p.kind,
        sec: p.sec ?? b.sec,
        km: p.km ?? b.km,
      ));
    }
    return out;
  }

  List<SessionSet> _openingSets(String id, {int? count, List<PlannedSet>? planned}) {
    if (planned != null && planned.isNotEmpty) return _fromPlan(id, planned);
    final sets = _workingOpeners(id, count: count);
    if (!warmsUp(id) || isRepsOnly(id) || modeOf(id).isNotEmpty) return sets;
    return [..._warmupFor(sets), ...sets];
  }

  List<SessionSet> _modeOpeners(String mode, List<LoggedSet> last) {
    final cardio = mode == 'cardio';
    final fromLast = [
      for (final l in last)
        if ((l.sec ?? 0) > 0 || (l.km ?? 0) > 0)
          SessionSet(0, cardio ? 0 : l.weight, false,
              sec: l.sec ?? (cardio ? 1200 : 30), km: cardio ? (l.km ?? 0) : null),
    ];
    if (fromLast.isNotEmpty) return fromLast;
    if (cardio) return [SessionSet(0, 0, false, sec: 1200, km: 0)];
    return [for (var i = 0; i < kDefaultRoutineSets; i++) SessionSet(0, 0, false, sec: 30)];
  }

  List<SessionSet> _workingOpeners(String id, {int? count}) {
    final last = lastSetsFor(id).where((l) => l.counts).toList();
    final mode = modeOf(id);
    final List<SessionSet> base;
    if (mode.isNotEmpty) {
      base = _modeOpeners(mode, last);
    } else if (last.isNotEmpty) {
      final bump = _progressBump(id, last);
      base = last.map((l) => SessionSet(l.reps, l.weight + bump, false)).toList();
    } else {
      final w = isRepsOnly(id) ? 0.0 : 20.0;
      base = [for (var i = 0; i < kDefaultRoutineSets; i++) SessionSet(10, w, false)];
    }
    if (count == null || count == base.length) return base;
    if (count < base.length) return base.take(count).toList();
    final fill = base.last;
    return [
      ...base,
      for (var i = base.length; i < count; i++) fill.copy(),
    ];
  }

  ({double weightKg, int reps, bool up})? nextTarget(String id) {
    if (modeOf(id).isNotEmpty) return null;
    final last = lastSetsFor(id).where((l) => l.counts).toList();
    if (last.isEmpty) return null;
    final reps = last.first.reps;
    if (reps <= 0) return null;
    final hit = last.every((l) => l.reps >= reps);
    if (isRepsOnly(id)) return (weightKg: 0, reps: hit ? reps + 1 : reps, up: hit);
    final top = last.map((l) => l.weight).reduce(math.max);
    final step = progressStep[id] ?? fromDisplayWeight(weightStep);
    return (weightKg: hit ? top + step : top, reps: reps, up: hit);
  }

  String? nextTargetLabel(String id) {
    final target = nextTarget(id);
    if (target == null) return null;
    if (isRepsOnly(id)) return '${target.reps} ${t.repsCol.toLowerCase()}';
    return '${weightLabel(target.weightKg)} × ${target.reps}';
  }

  double _progressBump(String id, List<LoggedSet> last) {
    final step = progressStep[id] ?? 0;
    if (step <= 0) return 0;
    final working = last.where((l) => l.counts).toList();
    if (working.isEmpty) return 0;
    final target = working.first.reps;
    if (working.any((l) => l.reps < target)) return 0;
    return step;
  }

  void _beginSession(List<Exercise> exs,
      {Map<String, int>? plan,
      Map<String, List<PlannedSet>> planned = const {},
      Set<String> chained = const {},
      String? routineId,
      DateTime? on}) {
    final s = WorkoutSession()..routineId = routineId;
    if (on != null) {
      s.loggedAt = DateTime(on.year, on.month, on.day, 12);
      s.manual = true;
    }
    logDay = null;
    s.exercises = exs
        .map((ex) => SessionExercise(
              ex.id,
              ex.name,
              ex.primary,
              _openingSets(ex.id, count: plan?[ex.id], planned: planned[ex.id]),
              linkedNext: chained.contains(ex.id),
            ))
        .toList();
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
    return '${(e ~/ 60).toString().padLeft(2, '0')}:${(e % 60).toString().padLeft(2, '0')}';
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

  void toggleSet(int exIdx, int setIdx) {
    final st = session!.exercises[exIdx].sets[setIdx];
    _advanceTimer?.cancel();
    st.done = !st.done;
    _persist();
    notifyListeners();
    if (!st.done) return;
    final chain = chainAt(exIdx);
    if (chain.length > 1) {
      _advanceChain(chain, exIdx);
      return;
    }
    startRest();
    if (autoAdvance || sessionLocked) _advanceWhenDone(exIdx);
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

  void _advanceChain(List<int> chain, int exIdx) {
    final s = session!;
    final after = chain.where((i) => i > exIdx && s.exercises[i].hasUndone).toList();
    if (after.isNotEmpty) {
      s.currentIndex = after.first;
      _persist();
      notifyListeners();
      return;
    }
    startRest();
    final left = chain.where((i) => s.exercises[i].hasUndone).toList();
    final next = pendingAfter(chain.last);
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

  void startRest() {
    if (sessionPaused || session?.manual == true) return;
    _restTimer?.cancel();
    RestAlarm.instance.stopSound();
    final exId = session!.exercises.isEmpty
        ? ''
        : session!.exercises[session!.currentIndex.clamp(0, session!.exercises.length - 1)].id;
    final seconds = routineRest(session!.routineId, exId) ?? restFor(exId);
    if (seconds <= 0) {
      session!.clearRest();
      notifyListeners();
      return;
    }

    restTotal = seconds;
    _armRest(seconds);
    askAlarmPermission();
    notifyListeners();
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
      if (live.restRemaining == null) {
        live.clearRest();
        t.cancel();
        restDoneTick++;
        RestAlarm.instance.fireNow();
        notifyListeners();
        return;
      }
      clock.value++;
    });
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
    restTotal = math.max(next, restTotal + (next - left));
    _armRest(next);
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
      sets.add(SessionSet(last.reps, last.weight, false, kind: last.kind, sec: last.sec, km: last.km));
    }
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
      setSessionKm(exIdx, setIdx, fromDisplayKm(shown));

  void bumpSessionDistance(int exIdx, int setIdx, int dir) {
    final st = session!.exercises[exIdx].sets[setIdx];
    final shown = toDisplayKm(st.km ?? 0);
    final next = ((shown / distanceStep).round() + dir) * distanceStep;
    setSessionDistanceShown(exIdx, setIdx, next < 0 ? 0 : next);
  }

  DateTime? holdEndsAt;
  DateTime? holdStartsAt;
  int holdEx = -1;
  int holdSet = -1;
  Timer? _holdTimer;

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

  void completeHold() => _finishHold();

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
    final secs = (sets[setIdx].sec ?? 30).clamp(1, 3600);
    if (s.restRemaining != null) skipRest();
    holdEx = exIdx;
    holdSet = setIdx;
    holdTotal = secs;
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
    _holdTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final lead = holdLead;
      final left = holdRemaining;
      if (left == 0) {
        Beeper.instance.go(sound: sound);
        _finishHold();
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

  void stopHold() {
    _holdTimer?.cancel();
    _holdTimer = null;
    holdPaused = false;
    holdEndsAt = null;
    holdStartsAt = null;
    holdEx = -1;
    holdSet = -1;
    notifyListeners();
  }

  void _finishHold() {
    final exIdx = holdEx, setIdx = holdSet;
    stopHold();
    final s = session;
    if (s == null || exIdx < 0 || exIdx >= s.exercises.length) return;
    final sets = s.exercises[exIdx].sets;
    if (setIdx < 0 || setIdx >= sets.length || sets[setIdx].done) return;
    toggleSet(exIdx, setIdx);
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

  void reorderSessionExercise(int from, int to) {
    final s = session;
    if (s == null || from < 0 || from >= s.exercises.length) return;
    if (to > from) to -= 1;
    to = to.clamp(0, s.exercises.length - 1);
    if (to == from) return;
    final current = s.exercises[s.currentIndex];
    if (from > 0) s.exercises[from - 1].linkedNext = false;
    final moved = s.exercises.removeAt(from)..linkedNext = false;
    s.exercises.insert(to, moved);
    if (to > 0) s.exercises[to - 1].linkedNext = false;
    s.currentIndex = s.exercises.indexOf(current);
    _persist();
    notifyListeners();
  }

  void bumpSessionReps(int exIdx, int setIdx, int d) =>
      setSessionReps(exIdx, setIdx, session!.exercises[exIdx].sets[setIdx].reps + d);

  void bumpSessionWeight(int exIdx, int setIdx, int dir) {
    final current = toDisplayWeight(session!.exercises[exIdx].sets[setIdx].weight);
    final next = _roundTo(current, weightStep) + dir * weightStep;
    setSessionWeight(exIdx, setIdx, fromDisplayWeight(math.max(0, next)));
  }

  static const _warmupSpec = [(0.4, 10), (0.6, 5), (0.8, 3)];

  List<SessionSet> _warmupFor(List<SessionSet> sets) {
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
          fromDisplayWeight(_roundTo(toDisplayWeight(target * spec.$1), weightStep)),
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
    final warm = _warmupFor(sets);
    if (warm.isEmpty) return;
    sets.insertAll(0, warm);
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
      setSessionWeight(exIdx, setIdx, fromDisplayWeight(shown));

  void removeSessionExercise(int exIdx) {
    final s = session!;
    if (exIdx < 0 || exIdx >= s.exercises.length) return;
    s.exercises.removeAt(exIdx);
    if (s.exercises.isEmpty) {
      discardSession();
      return;
    }
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
        started ? _workingOpeners(toId, count: count) : _openingSets(toId, count: count),
        linkedNext: from.linkedNext,
        swappedFrom: from.swappedFrom ?? from.id);
    if (started) {
      from.sets.removeWhere((st) => !st.done);
      from.linkedNext = false;
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
    s.currentIndex = math.min(s.currentIndex + 1, s.exercises.length - 1);
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
    s.summaryVolume = working.fold<double>(0, (sum, st) => sum + st.reps * st.weight).round();
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
          logged.add(LoggedExercise(e.id, e.name, e.primary, doneSets));
        }
      }
      final entry = LoggedSession(s.loggedAt ?? DateTime.now(), s.summaryDuration ?? 0, logged, routineId: s.routineId);
      sessions.add(entry);
      sessions.sort((a, b) => a.date.compareTo(b.date));
      _filed = entry;
      _computeSummaryHighlights(entry);
      _offerLevelUp(entry);
    } else {
      _filed = null;
      summaryPrs = 0;
      summaryVsLast = null;
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

  Map<String, String> get _swaps {
    final r = sessionRoutine;
    if (r == null) return const {};
    final out = <String, String>{};
    for (final e in _savable) {
      final from = e.swappedFrom;
      if (from != null && r.exerciseIds.contains(from) && !r.exerciseIds.contains(e.id)) out[from] = e.id;
    }
    return out;
  }

  List<SessionExercise> get _savableForRoutine {
    final swaps = _swaps;
    return [for (final e in _savable) if (!swaps.containsKey(e.id)) e];
  }

  void _planFromSession(String routineId, SessionExercise ex) {
    if (ex.sets.isEmpty) return;
    setPlannedSets(routineId, ex.id, [
      for (final st in ex.sets)
        PlannedSet(
          reps: modeOf(ex.id).isEmpty ? st.reps : null,
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
    return r != null &&
        _savableForRoutine.map((e) => e.id).join('|') != routineExercises(r).map((e) => e.id).join('|');
  }

  ({List<Exercise> added, List<Exercise> removed, bool reordered}) get sessionRoutineChanges {
    final r = sessionRoutine;
    final before = r == null ? const <Exercise>[] : routineExercises(r);
    final after = [for (final e in _savableForRoutine) exerciseById(e.id)!];
    final was = {for (final e in before) e.id};
    final now = {for (final e in after) e.id};
    return (
      added: after.where((e) => !was.contains(e.id)).toList(),
      removed: before.where((e) => !now.contains(e.id)).toList(),
      reordered: was.where(now.contains).join('|') != now.where(was.contains).join('|'),
    );
  }

  String saveSessionAsRoutine(String name) {
    final exs = _savable;
    if (exs.isEmpty) return '';
    final id = createRoutine(name);
    for (final ex in exs) {
      toggleRoutineExercise(id, ex.id);
      if (ex.linkedNext) toggleChain(id, ex.id);
      _planFromSession(id, ex);
    }
    session!.routineId = id;
    persistNow();
    notifyListeners();
    return id;
  }

  void saveSessionIntoRoutine() {
    final r = sessionRoutine;
    if (r == null) return;
    final swaps = _swaps;
    final exs = [for (final e in _savable) if (!swaps.containsKey(e.id)) e];
    for (final swap in swaps.entries) {
      replaceRoutineExercise(r.id, swap.key, swap.value);
    }
    final kept = {for (final e in exs) e.id};
    for (final id in [...r.exerciseIds]) {
      if (!kept.contains(id)) toggleRoutineExercise(r.id, id);
    }
    for (final ex in exs) {
      if (r.exerciseIds.contains(ex.id)) continue;
      toggleRoutineExercise(r.id, ex.id);
      _planFromSession(r.id, ex);
    }
    r.exerciseIds
      ..clear()
      ..addAll(kept);
    persistNow();
    notifyListeners();
  }

  double get summaryVolumeKg => (session?.summaryVolume ?? 0).toDouble();

  int summaryPrs = 0;
  double? summaryVsLast;

  void _computeSummaryHighlights(LoggedSession entry) {
    var prs = 0;
    for (final e in entry.exercises) {
      final previousBest = sessions
          .where((s) => !identical(s, entry))
          .expand((s) => s.exercises)
          .where((x) => x.id == e.id)
          .fold(0.0, (m, x) => math.max(m, x.bestOneRm));
      if (e.bestOneRm > previousBest) prs++;
    }
    summaryPrs = prs;

    final ids = entry.exercises.map((e) => e.id).toSet();
    LoggedSession? previous;
    for (final s in sessions.reversed) {
      if (identical(s, entry)) continue;
      if (s.exercises.any((e) => ids.contains(e.id))) {
        previous = s;
        break;
      }
    }
    summaryVsLast = previous?.volume;
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
    ({Exercise from, Exercise to, int reps})? best;
    var bestStep = -1;
    for (final e in entry.exercises) {
      final next = nextStepOf(e.id);
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
      final step = kProgressions.firstWhere((c) => c.contains(e.id)).indexOf(e.id);
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
    return l != null && r != null && r.exerciseIds.contains(l.from.id) && !r.exerciseIds.contains(l.to.id);
  }

  String? levelUpSwap() {
    final l = summaryLevelUp;
    final r = sessionRoutine;
    if (l == null || r == null || !levelUpInRoutine) return null;
    replaceRoutineExercise(r.id, l.from.id, l.to.id);
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

  void continueSession() {
    final s = session;
    if (s == null || !s.complete) return;
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
    if (filed != null) sessions.remove(filed);
    _filed = null;
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
      ..exercises = ls.exercises
          .map((e) => SessionExercise(
              e.id,
              e.name,
              e.primary,
              e.sets
                  .map((x) => SessionSet(x.reps, x.weight, true,
                      kind: x.kind, rpe: x.rpe, sec: x.sec, km: x.km))
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

  String get summaryDurationLabel {
    final d = session?.summaryDuration ?? 0;
    return '${d ~/ 60}:${(d % 60).toString().padLeft(2, '0')}';
  }

  void saveAndExit() {
    _holdTimer?.cancel();
    holdEndsAt = null;
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
