part of 'fit_state.dart';

mixin LibraryState on FitCore {
  String exSearch = '';
  String? exMuscleFilter;
  String? exDifficultyFilter;
  String? exEquipmentFilter;
  String? exKindFilter;
  String? activeExerciseId;
  int _customSeq = 0;
  List<Exercise> get allExercises => [...kExercises, ...customExercises];

  bool fitsHere(Exercise ex) => true;

  bool exArchivedOnly = false;

  bool isArchived(String id) => archived.contains(id);

  void toggleArchived(String id) {
    if (!archived.remove(id)) archived.add(id);
    if (archived.isEmpty) exArchivedOnly = false;
    _persist();
    notifyListeners();
  }

  void toggleArchivedFilter() {
    exArchivedOnly = !exArchivedOnly;
    notifyListeners();
  }

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
    exKindFilter = null;
    exFavouritesOnly = false;
    exArchivedOnly = false;
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

  void setKindFilter(String k) {
    exKindFilter = exKindFilter == k ? null : k;
    notifyListeners();
  }

  String kindOf(Exercise ex) {
    if (ex.kind.isNotEmpty) return ex.kind;
    if (kStretchIds.contains(ex.id)) return 'stretch';
    if (isCardio(ex.id) || kCardioExtras.contains(ex.id)) return 'cardio';
    return kCalisthenicsEquipment.contains(ex.equipment) ? 'calisthenics' : 'strength';
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

  List<Exercise> get exercisesFiltered => exercisesMatching(exSearch);

  List<Exercise> exercisesMatching(String query) {
    final matchesSearch = exerciseSearch(query);
    final list = allExercises.where((ex) {
      if (isArchived(ex.id) != exArchivedOnly) return false;
      if (exFavouritesOnly && favorites[ex.id] != true) return false;
      if (!matchesSearch(ex)) return false;
      if (exMuscleFilter != null &&
          ex.primary != exMuscleFilter &&
          !ex.secondary.contains(exMuscleFilter)) {
        return false;
      }
      if (exDifficultyFilter != null && ex.difficulty != exDifficultyFilter) return false;
      if (exEquipmentFilter != null && ex.equipment != exEquipmentFilter) return false;
      if (exKindFilter != null && kindOf(ex) != exKindFilter) return false;
      return true;
    }).toList();
    final muscle = exMuscleFilter;
    if (muscle == null) return _groupedByMuscle(list);
    final primary = list.where((ex) => ex.primary == muscle);
    final secondary = _groupedByMuscle(list.where((ex) => ex.primary != muscle).toList());
    return [...primary, ...secondary];
  }

  List<Exercise> _groupedByMuscle(List<Exercise> list) {
    final order = {for (var i = 0; i < kMuscles.length; i++) kMuscles[i].id: i};
    final seats = [
      for (var i = 0; i < list.length; i++)
        (ex: list[i], muscle: order[list[i].primary] ?? kMuscles.length, seat: i),
    ]..sort((a, b) =>
        a.muscle == b.muscle ? a.seat.compareTo(b.seat) : a.muscle.compareTo(b.muscle));
    return [for (final s in seats) s.ex];
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
    List<String> steps = const [],
    String mode = '',
    List<String> secondary = const [],
    List<String> aliases = const [],
    String kind = '',
  }) {
    final id = 'c${DateTime.now().microsecondsSinceEpoch}-${_customSeq++}';
    customExercises.add(Exercise(
      id: id,
      name: name.trim(),
      primary: primary,
      secondary: _cleanSecondary(primary, secondary),
      equipment: equipment,
      difficulty: difficulty,
      art: '',
      steps: _cleanSteps(steps),
      mode: kExerciseModeIds.contains(mode) ? mode : '',
      aliases: _cleanAliases(name, aliases),
      kind: kExerciseKinds.contains(kind) ? kind : '',
    ));
    _persist();
    notifyListeners();
    return id;
  }

  void updateCustomExercise(
    String id, {
    required String name,
    required String primary,
    required String equipment,
    required String difficulty,
    required List<String> steps,
    required String mode,
    List<String> secondary = const [],
    List<String>? aliases,
    String? kind,
  }) {
    final i = customExercises.indexWhere((e) => e.id == id);
    if (i < 0 || name.trim().isEmpty) return;
    customExercises[i] = customExercises[i].copyWith(
      name: name.trim(),
      primary: primary,
      secondary: _cleanSecondary(primary, secondary),
      equipment: equipment,
      difficulty: difficulty,
      steps: _cleanSteps(steps),
      mode: kExerciseModeIds.contains(mode) ? mode : '',
      aliases: _cleanAliases(name, aliases ?? customExercises[i].aliases),
      kind: kind == null ? null : (kExerciseKinds.contains(kind) ? kind : ''),
    );
    modeOverride.remove(id);
    _persist();
    notifyListeners();
  }

  static List<String> _cleanSecondary(String primary, List<String> raw) => [
        for (final m in kMuscles)
          if (m.id != primary && raw.contains(m.id)) m.id,
      ];

  static List<String> _cleanAliases(String name, List<String> raw) {
    final seen = {name.trim().toLowerCase()};
    return [
      for (final a in raw.map((a) => a.trim()))
        if (a.isNotEmpty && seen.add(a.toLowerCase())) a,
    ];
  }

  static final _bullet = RegExp(r'^(\d+[.)]|[-•*])\s*');

  static List<String> _cleanSteps(List<String> raw) => [
        for (final s in raw.map((s) => s.trim().replaceFirst(_bullet, '')))
          if (s.isNotEmpty) s,
      ];

  String modeOf(String id) {
    final forced = modeOverride[id];
    if (forced != null) return forced == 'weight' ? '' : forced;
    for (final e in customExercises) {
      if (e.id == id) return e.mode;
    }
    return kExerciseModes[id] ?? '';
  }

  bool isCardio(String id) => modeOf(id) == 'cardio';

  bool isTimed(String id) => modeOf(id) == 'time';

  void setExerciseMode(String id, String mode) {
    final base = customExercises.where((e) => e.id == id).map((e) => e.mode).firstOrNull ??
        kExerciseModes[id] ??
        '';
    final wanted = mode == 'weight' ? '' : mode;
    if (wanted == base) {
      modeOverride.remove(id);
    } else {
      modeOverride[id] = mode.isEmpty ? 'weight' : mode;
    }
    _persist();
    notifyListeners();
  }

  void deleteCustomExercise(String id) {
    clearExerciseMedia(id);
    customExercises.removeWhere((e) => e.id == id);
    modeOverride.remove(id);
    for (final r in routines) {
      r.exerciseIds.remove(id);
    }
    favorites.remove(id);
    _persist();
    notifyListeners();
  }

  String mediaFor(String id) => exerciseMedia[id] ?? '';

  bool hasCustomMedia(String id) => mediaFor(id).isNotEmpty;

  int? videoMark(String id, int step) => videoMarks[id]?[step];

  void setVideoMark(String id, int step, int? ms) {
    final marks = videoMarks.putIfAbsent(id, () => {});
    if (ms == null) {
      marks.remove(step);
    } else {
      marks[step] = ms;
    }
    if (marks.isEmpty) videoMarks.remove(id);
    _persist();
    notifyListeners();
  }

  Future<void> attachExerciseMedia(String id, String srcPath) async {
    final base = await MediaStore.importFor(id, srcPath);
    if (base == null) return;
    final old = mediaFor(id);
    if (old.isNotEmpty && old != base) await MediaStore.delete(old);
    exerciseMedia[id] = base;
    videoMarks.remove(id);
    _persist();
    notifyListeners();
  }

  void clearExerciseMedia(String id) {
    videoMarks.remove(id);
    final old = exerciseMedia.remove(id);
    if (old != null && old.isNotEmpty) MediaStore.delete(old);
    _persist();
    notifyListeners();
  }

  bool isRepsOnly(String id) {
    if (repsOnly.contains(id)) return true;
    if (repsOnlyOff.contains(id)) return false;
    final equipment = exerciseById(id)?.equipment;
    final bare = modeOf(id) == 'time' ? !_loadedHolds.contains(equipment) : equipment == 'Bodyweight';
    if (!bare) return false;
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

  bool isCustom(String id) => customExercises.any((e) => e.id == id);
}
  static const _loadedHolds = {'Dumbbell', 'Kettlebell', 'Cable', 'Machine', 'Weighted'};

