part of 'fit_state.dart';

const int kDefaultRoutineSets = 3;

mixin RoutinesState on FitCore, LibraryState {
  String? activeRoutineId;
  int _routineSeq = 0;
  final List<SavedPlan> savedPlans = [];
  String currentPlanId = '';

  SavedPlan _snapshot(String id, String name) => SavedPlan(
        id,
        name,
        Map.of(weeklyPlan),
        {for (final e in planExtras.entries) e.key: List.of(e.value)},
        multi: multiPlan,
      );

  List<SavedPlan> get savedPlansLive => [
        for (final p in savedPlans) p.id == currentPlanId ? _snapshot(p.id, p.name) : p,
      ];

  void _storeCurrentPlan() {
    final i = savedPlans.indexWhere((p) => p.id == currentPlanId);
    if (i >= 0) savedPlans[i] = _snapshot(currentPlanId, savedPlans[i].name);
  }

  void savePlanAs(String name, {bool empty = false}) {
    final n = name.trim();
    if (n.isEmpty) return;
    _storeCurrentPlan();
    if (empty && currentPlanId.isEmpty && weeklyPlan.isNotEmpty) {
      final mine = 'p${DateTime.now().microsecondsSinceEpoch}-${_routineSeq++}';
      savedPlans.add(_snapshot(mine, t.planMine));
    }
    final id = 'p${DateTime.now().microsecondsSinceEpoch}-${_routineSeq++}';
    if (empty) {
      weeklyPlan.clear();
      planExtras.clear();
    }
    savedPlans.add(_snapshot(id, n));
    currentPlanId = id;
    _planChanged();
  }

  void switchPlan(String id) {
    if (id == currentPlanId) return;
    final i = savedPlans.indexWhere((p) => p.id == id);
    if (i < 0) return;
    _storeCurrentPlan();
    final p = savedPlans[i];
    weeklyPlan
      ..clear()
      ..addAll(p.week);
    planExtras
      ..clear()
      ..addAll({for (final e in p.extras.entries) e.key: List.of(e.value)});
    multiPlan = p.multi;
    currentPlanId = id;
    _planChanged();
  }

  void renamePlan(String id, String name) {
    final n = name.trim();
    final i = savedPlans.indexWhere((p) => p.id == id);
    if (i < 0 || n.isEmpty) return;
    savedPlans[i].name = n;
    _persist();
    notifyListeners();
  }

  void deletePlan(String id) {
    savedPlans.removeWhere((p) => p.id == id);
    if (currentPlanId == id) currentPlanId = '';
    _persist();
    notifyListeners();
  }

  void goRoutines() => pushRoute('routines');

  void goAiPlan() => pushRoute('ai-plan');

  void backFromAiPlan() => popRoute(fallback: 'routines');

  void backFromRoutines() => popRoute();

  Routine? _routine(String id) {
    for (final r in routines) {
      if (r.id == id) return r;
    }
    return null;
  }

  Routine? get activeRoutine => activeRoutineId == null ? null : _routine(activeRoutineId!);

  List<Exercise> routineExercises(Routine r) {
    final out = <Exercise>[];
    for (final id in r.exerciseIds) {
      final e = exerciseById(id);
      if (e != null) out.add(e);
    }
    return out;
  }

  Routine? get todayRoutine => routineOn(DateTime.now());

  DateTime? lastDoneOf(String routineId) {
    DateTime? last;
    for (final s in sessions) {
      if (s.routineId == routineId && (last == null || s.date.isAfter(last))) last = s.date;
    }
    return last;
  }

  List<Routine> get activeRoutines => [for (final r in routines) if (!r.archived) r];

  List<Routine> get archivedRoutines => [for (final r in routines) if (r.archived) r];

  bool showArchivedRoutines = false;

  void toggleArchivedRoutines() {
    showArchivedRoutines = !showArchivedRoutines;
    notifyListeners();
  }

  VoidCallback? archiveRoutine(String id, bool on) {
    final r = _routine(id);
    if (r == null || r.archived == on) return null;
    final week = {...weeklyPlan};
    final extras = {for (final e in planExtras.entries) e.key: [...e.value]};
    final moves = {for (final e in planMoves.entries) e.key: [...e.value]};
    final rotation = [...rotationIds];
    final next = rotationNextId;
    r.archived = on;
    if (on) _unplanRoutine(id);
    _persist();
    syncTrainReminder();
    notifyListeners();
    if (!on) return null;
    return () {
      r.archived = false;
      weeklyPlan
        ..clear()
        ..addAll(week);
      planExtras
        ..clear()
        ..addAll(extras);
      planMoves
        ..clear()
        ..addAll(moves);
      rotationIds
        ..clear()
        ..addAll(rotation);
      rotationNextId = next;
      _persist();
      syncTrainReminder();
      notifyListeners();
    };
  }

  List<Routine> get routinesByLastDone {
    final active = activeRoutines;
    final last = {for (final r in active) r.id: lastDoneOf(r.id)};
    final order = {for (final (i, r) in active.indexed) r.id: i};
    return [...active]..sort((a, b) {
        final la = last[a.id], lb = last[b.id];
        if (la != null && lb != null && la != lb) return lb.compareTo(la);
        if ((la == null) != (lb == null)) return la == null ? 1 : -1;
        return order[a.id]!.compareTo(order[b.id]!);
      });
  }

  List<String> planIdsOn(int weekday) => [
        ?weeklyPlan[weekday],
        if (multiPlan) ...?planExtras[weekday],
      ];

  static String _moveKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  List<String> planIdsFor(DateTime day) => planMoves[_moveKey(day)] ?? planIdsOn(day.weekday);

  bool movedOn(DateTime day) => planMoves.containsKey(_moveKey(day));

  Routine? routineById(String id) => _routine(id);

  bool get rotating => rotation && rotationRoutines.isNotEmpty;

  List<Routine> get rotationRoutines => [for (final id in rotationIds) ?_routine(id)];

  static bool isRestStep(String id) => id.startsWith('rest-');

  List<String> get rotationSteps => [
        for (final id in rotationIds)
          if (isRestStep(id) || _routine(id) != null) id,
      ];

  ({int index, DateTime? rest}) get _rotationCursor {
    final steps = rotationSteps;
    if (rotationRoutines.isEmpty) return (index: 0, rest: null);
    var i = steps.indexOf(rotationNextId);
    if (i < 0) i = 0;
    if (!isRestStep(steps[i])) return (index: i, rest: null);
    final today = _dayKey(DateTime.now());
    var day = _dayKey(rotationRestDay ?? today);
    while (isRestStep(steps[i]) && day.isBefore(today)) {
      i = (i + 1) % steps.length;
      day = shiftDays(day, 1);
    }
    return (index: i, rest: isRestStep(steps[i]) ? day : null);
  }

  Routine? get rotationNext {
    if (rotationRoutines.isEmpty) return null;
    final c = _rotationCursor;
    return c.rest == null ? _routine(rotationSteps[c.index]) : null;
  }

  Routine? get rotationUpcoming {
    final steps = rotationSteps;
    if (rotationRoutines.isEmpty) return null;
    var i = _rotationCursor.index;
    while (isRestStep(steps[i])) {
      i = (i + 1) % steps.length;
    }
    return _routine(steps[i]);
  }

  int get rotationStep => rotationRoutines.isEmpty ? 0 : _rotationCursor.index;

  bool get restingToday => restOn(DateTime.now());

  bool restOn(DateTime day) {
    if (rotating) return rotationRestOn(day);
    final key = _dayKey(day);
    if (key.isBefore(_dayKey(DateTime.now())) || _sessionsOnDay(key).isNotEmpty) return false;
    return routinesOn(key).isEmpty && nextPlannedAfter(key) != null;
  }

  ({Routine routine, DateTime day})? nextPlannedAfter(DateTime day) {
    for (var d = 1; d <= 7; d++) {
      final next = shiftDays(day, d);
      final on = routinesOn(next);
      if (on.isNotEmpty) return (routine: on.first, day: next);
    }
    return null;
  }

  bool rotationRestOn(DateTime day) {
    if (!rotating) return false;
    final key = _dayKey(day);
    if (key.isBefore(_dayKey(DateTime.now())) || _sessionsOnDay(key).isNotEmpty) return false;
    return _rotationOn(day).isEmpty;
  }

  List<Routine> _rotationOn(DateTime day) {
    final key = _dayKey(day);
    final today = _dayKey(DateTime.now());
    final done = [
      for (final s in _sessionsOnDay(key))
        if (s.routineId != null && rotationIds.contains(s.routineId)) ?_routine(s.routineId!),
    ];
    if (key.isBefore(today) || done.isNotEmpty) return done;
    final steps = rotationSteps;
    final c = _rotationCursor;
    var rest = c.rest;
    if (rest == null) return [?_routine(steps[c.index])];
    var i = c.index;
    while (isRestStep(steps[i])) {
      if (!key.isAfter(rest!)) return const [];
      i = (i + 1) % steps.length;
      rest = shiftDays(rest, 1);
    }
    return [?_routine(steps[i])];
  }

  @override
  bool hasPlanOn(DateTime day) => routinesOn(day).isNotEmpty;

  List<Routine> routinesOn(DateTime day) =>
      rotating ? _rotationOn(day) : [for (final id in planIdsFor(day)) ?_routine(id)];

  void setRotation(bool on) {
    if (rotation == on) return;
    rotation = on;
    if (on && rotationIds.isEmpty) {
      for (var d = 1; d <= 7; d++) {
        for (final id in planIdsOn(d)) {
          if (!rotationIds.contains(id) && _routine(id) != null) rotationIds.add(id);
        }
      }
      rotationNextId = rotationIds.isEmpty ? '' : rotationIds.first;
    }
    _planChanged();
  }

  void addRotationRest() {
    var n = 1;
    while (rotationIds.contains('rest-$n')) {
      n++;
    }
    rotationIds.add('rest-$n');
    _planChanged();
  }

  void removeRotationRest(String id) {
    final steps = rotationSteps;
    final i = steps.indexOf(id);
    if (i < 0 || !isRestStep(id)) return;
    _settleRotation();
    if (rotationNextId == id) _pointRotation(steps[(i + 1) % steps.length]);
    rotationIds.remove(id);
    _fixRotationNext();
    _planChanged();
  }

  void _settleRotation() {
    if (rotationRoutines.isEmpty) return;
    final c = _rotationCursor;
    rotationNextId = rotationSteps[c.index];
    rotationRestDay = c.rest;
  }

  void _pointRotation(String id, [DateTime? rest]) {
    rotationNextId = id;
    rotationRestDay = isRestStep(id) ? _dayKey(rest ?? DateTime.now()) : null;
  }

  void toggleRotationRoutine(String id) {
    if (_routine(id) == null) return;
    _settleRotation();
    if (rotationIds.remove(id)) {
      if (rotationNextId == id) rotationNextId = '';
    } else {
      rotationIds.add(id);
    }
    _fixRotationNext();
    _planChanged();
  }

  void reorderRotation(int from, int to) {
    if (from < 0 || from >= rotationIds.length) return;
    _settleRotation();
    if (to > from) to -= 1;
    rotationIds.insert(to.clamp(0, rotationIds.length), rotationIds.removeAt(from));
    _planChanged();
  }

  void setRotationNext(String id) {
    if (!rotationIds.contains(id)) return;
    _pointRotation(id);
    _planChanged();
  }

  void skipRotation() {
    final steps = rotationSteps;
    if (rotationRoutines.isEmpty) return;
    _pointRotation(steps[(_rotationCursor.index + 1) % steps.length]);
    _planChanged();
  }

  void restartRotation() {
    final steps = rotationSteps;
    if (rotationRoutines.isEmpty) return;
    _pointRotation(steps.first);
    _planChanged();
  }

  void _advanceRotation(String? routineId, DateTime on) {
    if (!rotation || routineId == null) return;
    final steps = rotationSteps;
    final i = steps.indexOf(routineId);
    if (i < 0) return;
    _pointRotation(steps[(i + 1) % steps.length], shiftDays(on, 1));
  }

  void _fixRotationNext() {
    rotationIds.removeWhere((id) => !isRestStep(id) && _routine(id) == null);
    if (rotationIds.contains(rotationNextId)) return;
    _pointRotation(rotationIds.isEmpty ? '' : rotationIds.first);
  }

  VoidCallback? moveRoutineDay(String routineId, DateTime from, DateTime to) {
    final source = _dayKey(from), target = _dayKey(to);
    if (source == target) return null;
    final left = [...planIdsFor(source)];
    if (!left.remove(routineId)) return null;
    final arrive = [...planIdsFor(target)];
    if (!arrive.contains(routineId)) arrive.add(routineId);
    final a = _moveKey(source), b = _moveKey(target);
    final before = {a: planMoves[a], b: planMoves[b]};
    planMoves[a] = left;
    planMoves[b] = arrive;
    _pruneMoves();
    _planChanged();
    return () {
      for (final e in before.entries) {
        final was = e.value;
        if (was == null) {
          planMoves.remove(e.key);
        } else {
          planMoves[e.key] = was;
        }
      }
      _planChanged();
    };
  }

  void undoMoves(DateTime day) {
    if (planMoves.remove(_moveKey(day)) == null) return;
    _planChanged();
  }

  void _pruneMoves() {
    final cutoff = _moveKey(_dayKey(DateTime.now()).subtract(const Duration(days: 14)));
    planMoves.removeWhere((k, _) => k.compareTo(cutoff) < 0);
  }

  void _planChanged() {
    _persist();
    _refreshWidgets();
    syncTrainReminder();
    notifyListeners();
  }

  bool plannedOn(int weekday, String routineId) => planIdsOn(weekday).contains(routineId);

  List<Routine> pendingRoutinesOn(DateTime day) {
    final left = routinesOn(day);
    final key = _dayKey(day);
    var free = 0;
    for (final s in _sessionsOnDay(key)) {
      final id = s.routineId;
      if (id == null) {
        free++;
      } else {
        final i = left.indexWhere((r) => r.id == id);
        if (i >= 0) left.removeAt(i);
      }
    }
    return left.sublist(math.min(free, left.length));
  }

  Routine? routineOn(DateTime day) {
    final list = routinesOn(day);
    if (list.isEmpty) return null;
    final pending = pendingRoutinesOn(day);
    return pending.isEmpty ? list.last : pending.first;
  }

  void toggleMultiPlan() {
    multiPlan = !multiPlan;
    _persist();
    _refreshWidgets();
    syncTrainReminder();
    notifyListeners();
  }

  void togglePlanDay(int weekday, String routineId) {
    if (!multiPlan) return assignRoutineToDay(weekday, plannedOn(weekday, routineId) ? null : routineId);
    final extras = planExtras.putIfAbsent(weekday, () => []);
    if (weeklyPlan[weekday] == routineId) {
      if (extras.isEmpty) {
        weeklyPlan.remove(weekday);
      } else {
        weeklyPlan[weekday] = extras.removeAt(0);
      }
    } else if (!extras.remove(routineId)) {
      if (weeklyPlan[weekday] == null) {
        weeklyPlan[weekday] = routineId;
      } else {
        extras.add(routineId);
      }
    }
    if (extras.isEmpty) planExtras.remove(weekday);
    _persist();
    _refreshWidgets();
    syncTrainReminder();
    notifyListeners();
  }

  String createRoutine([String name = '']) {
    final id = 'r${DateTime.now().microsecondsSinceEpoch}-${_routineSeq++}';
    routines.add(Routine(id, name.trim(), []));
    refreshAwards();
    _persist();
    notifyListeners();
    return id;
  }

  void renameRoutine(String id, String name) {
    final r = _routine(id);
    if (r == null) return;
    r.name = name.trim();
    _persist();
    notifyListeners();
  }

  List<String> get routineGroups {
    final out = <String>[];
    for (final r in activeRoutines) {
      if (r.group.isNotEmpty && !out.contains(r.group)) out.add(r.group);
    }
    return out;
  }

  List<Routine> routinesInGroup(String group) =>
      routines.where((r) => r.group == group && !r.archived).toList();

  void setRoutineGroup(String id, String group) {
    final r = _routine(id);
    if (r == null) return;
    r.group = group.trim();
    _persist();
    notifyListeners();
  }

  void setRoutineColor(String id, int color) {
    final r = _routine(id);
    if (r == null) return;
    r.color = color;
    _persist();
    notifyListeners();
  }

  String duplicateRoutine(String id) {
    final source = _routine(id);
    if (source == null) return '';
    final copy = createRoutine(t.copySuffix(routineTitle(source)));
    final made = _routine(copy)!;
    made.exerciseIds.addAll(source.exerciseIds);
    made.sets.addAll(source.sets);
    made.chained.addAll(source.chained);
    made.ladders.addAll([for (final l in source.ladders) [...l]]);
    made.plan.addAll({for (final e in source.plan.entries) e.key: [...e.value]});
    made.rest.addAll(source.rest);
    made.group = source.group;
    made.color = source.color;
    _persist();
    notifyListeners();
    return copy;
  }

  void renameGroup(String from, String to) {
    final name = to.trim();
    for (final r in routines) {
      if (r.group == from) r.group = name;
    }
    _persist();
    notifyListeners();
  }

  void deleteGroup(String group) {
    for (final id in [for (final r in routinesInGroup(group)) r.id]) {
      _dropRoutine(id);
    }
    _persist();
    notifyListeners();
  }

  void deleteRoutine(String id) {
    _dropRoutine(id);
    _persist();
    notifyListeners();
  }

  void _dropRoutine(String id) {
    _unplanRoutine(id);
    routines.removeWhere((r) => r.id == id);
    _fixRotationNext();
    for (final p in savedPlans) {
      p.drop(id);
    }
  }

  void _unplanRoutine(String id) {
    final i = rotationIds.indexOf(id);
    if (i >= 0) {
      if (rotationNextId == id) _pointRotation(rotationIds[(i + 1) % rotationIds.length]);
      rotationIds.removeAt(i);
    }
    _fixRotationNext();
    weeklyPlan.removeWhere((_, v) => v == id);
    for (final extras in planExtras.values) {
      extras.remove(id);
    }
    planExtras.removeWhere((_, v) => v.isEmpty);
    for (final ids in planMoves.values) {
      ids.remove(id);
    }
    for (final day in [...planExtras.keys]) {
      if (weeklyPlan[day] != null) continue;
      final extras = planExtras[day]!;
      weeklyPlan[day] = extras.removeAt(0);
      if (extras.isEmpty) planExtras.remove(day);
    }
    if (activeRoutineId == id) activeRoutineId = null;
  }

  void toggleRoutineExercise(String routineId, String exId) {
    final r = _routine(routineId);
    if (r == null) return;
    if (r.exerciseIds.remove(exId)) {
      r.sets.remove(exId);
      r.plan.remove(exId);
      r.rest.remove(exId);
      r.chained.remove(exId);
    } else {
      r.exerciseIds.add(exId);
    }
    _persist();
    notifyListeners();
  }

  List<String>? ladderIn(Routine? r, String exId) {
    if (r == null) return null;
    for (final l in r.ladders) {
      if (l.contains(exId)) return l;
    }
    return null;
  }

  List<String>? builtInLadder(String exId) {
    for (final chain in kProgressions) {
      if (chain.contains(exId)) return chain;
    }
    return null;
  }

  String? nextStepIn(Routine? r, String exId) {
    final own = ladderIn(r, exId);
    if (own == null) return nextStepOf(exId);
    final at = own.indexOf(exId);
    return at + 1 < own.length ? own[at + 1] : null;
  }

  int stepIndexIn(Routine? r, String exId) => (ladderIn(r, exId) ?? builtInLadder(exId) ?? const []).indexOf(exId);

  void setLadder(String routineId, String exId, List<String> steps) {
    final r = _routine(routineId);
    if (r == null) return;
    final clean = <String>[];
    for (final id in steps) {
      if (!clean.contains(id) && exerciseById(id) != null) clean.add(id);
    }
    r.ladders.removeWhere((l) => l.contains(exId) || clean.any(l.contains));
    if (clean.length > 1 && clean.contains(exId)) r.ladders.add(clean);
    _persist();
    notifyListeners();
  }

  void replaceRoutineExercise(String routineId, String from, String to) {
    final r = _routine(routineId);
    if (r == null) return;
    final at = r.exerciseIds.indexOf(from);
    if (at < 0 || r.exerciseIds.contains(to)) return;
    r.exerciseIds[at] = to;
    final sets = r.sets.remove(from);
    if (sets != null) r.sets[to] = sets;
    final plan = r.plan.remove(from);
    if (plan != null) r.plan[to] = [for (final p in plan) PlannedSet(kind: p.kind)];
    final rest = r.rest.remove(from);
    if (rest != null) r.rest[to] = rest;
    if (r.chained.remove(from)) r.chained.add(to);
    _persist();
    notifyListeners();
  }

  VoidCallback? removeRoutineExercise(String routineId, String exId) {
    final r = _routine(routineId);
    if (r == null) return null;
    final at = r.exerciseIds.indexOf(exId);
    if (at < 0) return null;
    final sets = r.sets[exId];
    final plan = r.plan[exId];
    final rest = r.rest[exId];
    final chained = r.chained.contains(exId);
    toggleRoutineExercise(routineId, exId);
    return () {
      final back = _routine(routineId);
      if (back == null || back.exerciseIds.contains(exId)) return;
      back.exerciseIds.insert(at.clamp(0, back.exerciseIds.length), exId);
      if (sets != null) back.sets[exId] = sets;
      if (plan != null) back.plan[exId] = plan;
      if (rest != null) back.rest[exId] = rest;
      if (chained) back.chained.add(exId);
      _persist();
      notifyListeners();
    };
  }

  int routineSets(Routine r, String exId) {
    final planned = r.plan[exId];
    if (planned != null && planned.isNotEmpty) {
      final working = planned.where((p) => p.kind != SetKind.warmup).length;
      return working == 0 ? planned.length : working;
    }
    return r.sets[exId] ?? (modeOf(exId) == 'cardio' ? 1 : kDefaultRoutineSets);
  }

  List<PlannedSet> plannedSets(Routine r, String exId) => r.plan[exId] ?? const [];

  int? routineRest(String? routineId, String exId) =>
      routineId == null ? null : _routine(routineId)?.rest[exId];

  void setRoutineRest(String routineId, String exId, int? seconds) {
    final r = _routine(routineId);
    if (r == null || !r.exerciseIds.contains(exId)) return;
    if (seconds == null) {
      r.rest.remove(exId);
    } else {
      r.rest[exId] = seconds <= 0 ? 0 : seconds.clamp(15, 600);
    }
    _persist();
    notifyListeners();
  }

  void setRoutineSetCount(String routineId, String exId, int n) {
    final r = _routine(routineId);
    if (r == null || !r.exerciseIds.contains(exId)) return;
    r.sets[exId] = n.clamp(1, 12);
    _persist();
    notifyListeners();
  }

  bool hasPlan(Routine r, String exId) => r.plan[exId]?.isNotEmpty ?? false;

  void setPlannedSets(String routineId, String exId, List<PlannedSet> sets) {
    final r = _routine(routineId);
    if (r == null || !r.exerciseIds.contains(exId)) return;
    if (sets.isEmpty) {
      r.plan.remove(exId);
    } else {
      r.plan[exId] = List.unmodifiable(sets.take(20));
      r.sets[exId] = sets.where((p) => p.kind != SetKind.warmup).length.clamp(1, 20);
    }
    _persist();
    notifyListeners();
  }

  bool chainsToNext(Routine r, String exId) {
    final i = r.exerciseIds.indexOf(exId);
    return i >= 0 && i < r.exerciseIds.length - 1 && r.chained.contains(exId);
  }

  void toggleChain(String routineId, String exId) {
    final r = _routine(routineId);
    if (r == null) return;
    if (!r.chained.remove(exId)) r.chained.add(exId);
    _persist();
    notifyListeners();
  }

  void bumpRoutineSets(String routineId, String exId, int delta) {
    final r = _routine(routineId);
    if (r == null || !r.exerciseIds.contains(exId)) return;
    final planned = r.plan[exId];
    if (planned != null && planned.isNotEmpty) {
      final next = [...planned];
      if (delta > 0) {
        for (var i = 0; i < delta && next.length < 20; i++) {
          next.add(next
              .lastWhere((s) => s.kind != SetKind.warmup, orElse: () => const PlannedSet())
              .copyWith(kind: SetKind.normal));
        }
      } else {
        for (var i = 0; i < -delta; i++) {
          final last = next.lastIndexWhere((s) => s.kind != SetKind.warmup);
          if (last < 0 || next.where((s) => s.kind != SetKind.warmup).length <= 1) break;
          next.removeAt(last);
        }
      }
      setPlannedSets(routineId, exId, next);
      return;
    }
    r.sets[exId] = (routineSets(r, exId) + delta).clamp(1, 12);
    _persist();
    notifyListeners();
  }

  bool routineHas(String routineId, String exId) => _routine(routineId)?.exerciseIds.contains(exId) ?? false;

  void reorderRoutineExercise(String routineId, int from, int to) {
    final ids = _routine(routineId)?.exerciseIds;
    if (ids == null || from < 0 || from >= ids.length) return;
    if (to > from) to -= 1;
    ids.insert(to.clamp(0, ids.length), ids.removeAt(from));
    persistNow();
    notifyListeners();
  }

  void assignRoutineToDay(int weekday, String? routineId) {
    planExtras.remove(weekday);
    if (routineId == null) {
      weeklyPlan.remove(weekday);
    } else {
      weeklyPlan[weekday] = routineId;
    }
    _persist();
    syncTrainReminder();
    notifyListeners();
  }

  void openRoutine(String id) {
    activeRoutineId = id;
    pushRoute('routine-edit');
  }

  void addToRoutineAndEdit(String? routineId, String exId) {
    final id = routineId ?? createRoutine();
    if (!routineHas(id, exId)) toggleRoutineExercise(id, exId);
    activeRoutineId = id;
    pushRoute('routine-edit');
  }

  int routinesWith(String exId) => routines.where((r) => r.exerciseIds.contains(exId)).length;

  String routineTitle(Routine r) => r.name.isEmpty ? t.newRoutineName : r.name;

  void closeRoutineEdit() => popRoute(fallback: 'routines');
}
