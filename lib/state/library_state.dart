part of 'fit_state.dart';

mixin LibraryState on FitCore {
  String exSearch = '';
  String? exMuscleFilter;
  String? exDifficultyFilter;
  String? activeExerciseId;
  List<Exercise> get allExercises => [...kExercises, ...customExercises];

  Exercise? exerciseById(String id) {
    for (final e in allExercises) {
      if (e.id == id) return e;
    }
    return null;
  }

  void openExercise(String id) {
    if (route != 'exercise-detail') prevRoute = route;
    route = 'exercise-detail';
    activeExerciseId = id;
    notifyListeners();
  }

  void closeExerciseDetail() {
    route = prevRoute;
    notifyListeners();
  }

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

  bool exFavouritesOnly = false;

  void toggleFavouritesFilter() {
    exFavouritesOnly = !exFavouritesOnly;
    notifyListeners();
  }

  int get favouriteCount => favorites.values.where((v) => v).length;

  List<Exercise> get exercisesFiltered {
    final q = exSearch.trim().toLowerCase();
    return allExercises.where((ex) {
      if (exFavouritesOnly && favorites[ex.id] != true) return false;

      if (q.isNotEmpty &&
          !ex.name.toLowerCase().contains(q) &&
          !exerciseName(ex).toLowerCase().contains(q)) {
        return false;
      }
      if (exMuscleFilter != null &&
          ex.primary != exMuscleFilter &&
          !ex.secondary.contains(exMuscleFilter)) {
        return false;
      }
      if (exDifficultyFilter != null && ex.difficulty != exDifficultyFilter) return false;
      return true;
    }).toList();
  }

  Exercise get activeExercise =>
      exerciseById(activeExerciseId ?? '') ?? kExercises.first;

  List<String> activeExerciseSteps(Exercise ex) => exerciseSteps(ex);

  List<ExerciseNote> notesFor(String id) => exNotes[id] ?? const [];

  void addNote(String id, String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    (exNotes[id] ??= []).insert(0, ExerciseNote(DateTime.now(), t));
    _persist();
    notifyListeners();
  }

  void deleteNote(String id, int index) {
    final list = exNotes[id];
    if (list == null || index < 0 || index >= list.length) return;
    list.removeAt(index);
    if (list.isEmpty) exNotes.remove(id);
    _persist();
    notifyListeners();
  }

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
    final ex = exerciseById(id);
    if (ex != null && ex.media.isNotEmpty) MediaStore.delete(ex.media);
    customExercises.removeWhere((e) => e.id == id);
    for (final r in routines) {
      r.exerciseIds.remove(id);
    }
    favorites.remove(id);
    _persist();
    notifyListeners();
  }

  Future<void> attachExerciseMedia(String id, String srcPath) async {
    final i = customExercises.indexWhere((e) => e.id == id);
    if (i < 0) return;
    final old = customExercises[i].media;
    final base = await MediaStore.importFor(id, srcPath);
    if (base == null) return;
    if (old.isNotEmpty && old != base) await MediaStore.delete(old);
    customExercises[i] = customExercises[i].copyWith(media: base);
    _persist();
    notifyListeners();
  }

  void clearExerciseMedia(String id) {
    final i = customExercises.indexWhere((e) => e.id == id);
    if (i < 0) return;
    final old = customExercises[i].media;
    if (old.isNotEmpty) MediaStore.delete(old);
    customExercises[i] = customExercises[i].copyWith(media: '');
    _persist();
    notifyListeners();
  }

  bool isCustom(String id) => id.startsWith('c');
}
