part of 'fit_state.dart';

mixin LibraryState on FitCore {
  String exSearch = '';
  String? exMuscleFilter;
  String? exDifficultyFilter;
  String? exEquipmentFilter;
  String? activeExerciseId;
  List<Exercise> get allExercises => [...kExercises, ...customExercises];

  Exercise? exerciseById(String id) {
    for (final e in allExercises) {
      if (e.id == id) return e;
    }
    return null;
  }

  void openExercise(String id) {
    activeExerciseId = id;
    pushRoute('exercise-detail');
  }

  void closeExerciseDetail() => popRoute(fallback: 'exercises');

  void toggleFavorite(String id) {
    favorites[id] = !(favorites[id] ?? false);
    _persist();
    notifyListeners();
  }

  void setExSearch(String v) {
    exSearch = v;
    notifyListeners();
  }

  void clearExFilters() {
    exSearch = '';
    exMuscleFilter = null;
    exDifficultyFilter = null;
    exEquipmentFilter = null;
    exFavouritesOnly = false;
    notifyListeners();
  }

  void setMuscleFilter(String id) {
    exMuscleFilter = exMuscleFilter == id ? null : id;
    notifyListeners();
  }

  void setDifficultyFilter(String d) {
    exDifficultyFilter = exDifficultyFilter == d ? null : d;
    notifyListeners();
  }

  void setEquipmentFilter(String e) {
    exEquipmentFilter = exEquipmentFilter == e ? null : e;
    notifyListeners();
  }

  bool exFavouritesOnly = false;

  void toggleFavouritesFilter() {
    exFavouritesOnly = !exFavouritesOnly;
    notifyListeners();
  }

  int get favouriteCount => favorites.values.where((v) => v).length;

  List<Exercise> get exercisesFiltered {
    final matchesSearch = exerciseSearch(exSearch);
    return allExercises.where((ex) {
      if (exFavouritesOnly && favorites[ex.id] != true) return false;
      if (!matchesSearch(ex)) return false;
      if (exMuscleFilter != null &&
          ex.primary != exMuscleFilter &&
          !ex.secondary.contains(exMuscleFilter)) {
        return false;
      }
      if (exDifficultyFilter != null && ex.difficulty != exDifficultyFilter) return false;
      if (exEquipmentFilter != null && ex.equipment != exEquipmentFilter) return false;
      return true;
    }).toList();
  }

  Exercise get activeExercise =>
      exerciseById(activeExerciseId ?? '') ?? kExercises.first;

  List<String> activeExerciseSteps(Exercise ex) => exerciseSteps(ex);

  List<Exercise> similarExercises(Exercise ex, int n) => allExercises
      .where((e) => e.id != ex.id && e.primary == ex.primary)
      .take(n)
      .toList();

  String addCustomExercise({
    required String name,
    required String primary,
    required String equipment,
    String difficulty = 'Beginner',
  }) {
    final id = 'c${DateTime.now().microsecondsSinceEpoch}';
    customExercises.add(Exercise(
      id: id,
      name: name.trim(),
      primary: primary,
      secondary: const [],
      equipment: equipment,
      difficulty: difficulty,
      art: '',
      steps: const [],
    ));
    _persist();
    notifyListeners();
    return id;
  }

  void deleteCustomExercise(String id) {
    clearExerciseMedia(id);
    customExercises.removeWhere((e) => e.id == id);
    for (final r in routines) {
      r.exerciseIds.remove(id);
    }
    favorites.remove(id);
    _persist();
    notifyListeners();
  }

  String mediaFor(String id) => exerciseMedia[id] ?? '';

  bool hasCustomMedia(String id) => mediaFor(id).isNotEmpty;

  Future<void> attachExerciseMedia(String id, String srcPath) async {
    final base = await MediaStore.importFor(id, srcPath);
    if (base == null) return;
    final old = mediaFor(id);
    if (old.isNotEmpty && old != base) await MediaStore.delete(old);
    exerciseMedia[id] = base;
    _persist();
    notifyListeners();
  }

  void clearExerciseMedia(String id) {
    final old = exerciseMedia.remove(id);
    if (old != null && old.isNotEmpty) MediaStore.delete(old);
    _persist();
    notifyListeners();
  }

  bool isRepsOnly(String id) {
    if (repsOnly.contains(id)) return true;
    if (repsOnlyOff.contains(id)) return false;
    if (exerciseById(id)?.equipment != 'Bodyweight') return false;
    return !_hasLoadedHistory(id);
  }

  bool _hasLoadedHistory(String id) {
    for (final s in sessions) {
      for (final e in s.exercises) {
        if (e.id == id && e.sets.any((st) => st.weight > 0)) return true;
      }
    }
    return false;
  }

  void toggleRepsOnly(String id) {
    if (isRepsOnly(id)) {
      repsOnly.remove(id);
      repsOnlyOff.add(id);
    } else {
      repsOnlyOff.remove(id);
      repsOnly.add(id);
    }
    _persist();
    notifyListeners();
  }

  bool isCustom(String id) => id.startsWith('c');
}
