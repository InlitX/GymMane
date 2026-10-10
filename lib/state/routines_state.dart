part of 'fit_state.dart';

const int kDefaultRoutineSets = 3;

mixin RoutinesState on FitCore, LibraryState {
  String? activeRoutineId;
  int _routineSeq = 0;
  bool _editFromExercise = false;

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

  List<Routine> get routinesByLastDone {
    final last = {for (final r in routines) r.id: lastDoneOf(r.id)};
    final order = {for (final (i, r) in routines.indexed) r.id: i};
    return [...routines]..sort((a, b) {
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

  List<Routine> routinesOn(DateTime day) => [for (final id in planIdsOn(day.weekday)) ?_routine(id)];

  bool plannedOn(int weekday, String routineId) => planIdsOn(weekday).contains(routineId);

  List<Routine> pendingRoutinesOn(DateTime day) {
    final left = routinesOn(day);
    final key = _dayKey(day);
    var free = 0;
    for (final s in sessions.where((s) => _dayKey(s.date) == key)) {
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
    for (final r in routines) {
      if (r.group.isNotEmpty && !out.contains(r.group)) out.add(r.group);
    }
    return out;
  }

  List<Routine> routinesInGroup(String group) =>
      routines.where((r) => r.group == group).toList();

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
    routines.removeWhere((r) => r.id == id);
    weeklyPlan.removeWhere((_, v) => v == id);
    for (final extras in planExtras.values) {
      extras.remove(id);
    }
    planExtras.removeWhere((_, v) => v.isEmpty);
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
    if (route != 'routine-edit') _editFromExercise = false;
    activeRoutineId = id;
    route = 'routine-edit';
    notifyListeners();
  }

  void addToRoutineAndEdit(String? routineId, String exId) {
    final id = routineId ?? createRoutine();
    if (!routineHas(id, exId)) toggleRoutineExercise(id, exId);
    activeRoutineId = id;
    _editFromExercise = true;
    pushRoute('routine-edit');
  }

  int routinesWith(String exId) => routines.where((r) => r.exerciseIds.contains(exId)).length;

  String routineTitle(Routine r) => r.name.isEmpty ? t.newRoutineName : r.name;

  void closeRoutineEdit() {
    if (_editFromExercise) {
      _editFromExercise = false;
      return popRoute(fallback: 'routines');
    }
    route = 'routines';
    notifyListeners();
  }
}
