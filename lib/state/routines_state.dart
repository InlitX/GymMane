part of 'fit_state.dart';

mixin RoutinesState on FitCore, LibraryState {
  String? activeRoutineId;

  void goRoutines() => pushRoute('routines');

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

  Routine? get todayRoutine {
    final id = weeklyPlan[DateTime.now().weekday];
    return id == null ? null : _routine(id);
  }

  String createRoutine([String name = '']) {
    final id = 'r${DateTime.now().microsecondsSinceEpoch}';
    routines.add(Routine(id, name.trim(), []));
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

  void deleteRoutine(String id) {
    routines.removeWhere((r) => r.id == id);
    weeklyPlan.removeWhere((_, v) => v == id);
    if (activeRoutineId == id) activeRoutineId = null;
    _persist();
    notifyListeners();
  }

  void toggleRoutineExercise(String routineId, String exId) {
    final r = _routine(routineId);
    if (r == null) return;
    if (!r.exerciseIds.remove(exId)) r.exerciseIds.add(exId);
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
    if (routineId == null) {
      weeklyPlan.remove(weekday);
    } else {
      weeklyPlan[weekday] = routineId;
    }
    _persist();
    notifyListeners();
  }

  void openRoutine(String id) {
    activeRoutineId = id;
    route = 'routine-edit';
    notifyListeners();
  }

  String routineTitle(Routine r) => r.name.isEmpty ? t.newRoutineName : r.name;

  void closeRoutineEdit() {
    route = 'routines';
    notifyListeners();
  }
}
