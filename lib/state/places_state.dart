part of 'fit_state.dart';

const List<String> kPlacePresets = ['gym', 'home', 'outdoors'];

const Map<String, List<String>> kPlacePresetGear = {
  'gym': kEquipment,
  'home': ['Bodyweight', 'Dumbbell', 'Kettlebell', 'Band', 'Weighted'],
  'outdoors': ['Bodyweight', 'Band'],
};

mixin PlacesState on FitCore, LibraryState {
  String activePlaceId = '';
  int _placeSeq = 0;

  GymPlace? get activePlace {
    for (final p in places) {
      if (p.id == activePlaceId) return p;
    }
    return null;
  }

  Set<String> get gearHere {
    final place = activePlace;
    return place == null ? kEquipment.toSet() : {...place.equipment, 'Bodyweight'};
  }

  bool fitsHere(Exercise ex) => activePlace == null || gearHere.contains(ex.equipment);

  int placeExerciseCount(GymPlace place) {
    final gear = {...place.equipment, 'Bodyweight'};
    return allExercises.where((e) => gear.contains(e.equipment)).length;
  }

  List<Exercise> alternativesHere(Exercise ex, int n) {
    if (fitsHere(ex)) return const [];
    final pool = allExercises
        .where((e) => e.id != ex.id && e.primary == ex.primary && fitsHere(e))
        .toList();
    pool.sort((a, b) {
      int rank(Exercise e) {
        if (favorites[e.id] == true) return 0;
        return e.equipment == 'Bodyweight' ? 1 : 2;
      }

      return rank(a).compareTo(rank(b));
    });
    return pool.take(n).toList();
  }

  String addPlace(String name, {Set<String> equipment = const {'Bodyweight'}}) {
    final clean = name.trim();
    if (clean.isEmpty) return '';
    final id = 'p${DateTime.now().microsecondsSinceEpoch}-${_placeSeq++}';
    places.add(GymPlace(id: id, name: clean, equipment: {...equipment}));
    _persist();
    notifyListeners();
    return id;
  }

  String addPresetPlace(String preset) => addPlace(
        t.placePresetName(preset),
        equipment: (kPlacePresetGear[preset] ?? const ['Bodyweight']).toSet(),
      );

  void renamePlace(String id, String name) {
    final i = places.indexWhere((p) => p.id == id);
    final clean = name.trim();
    if (i < 0 || clean.isEmpty) return;
    places[i] = places[i].copyWith(name: clean);
    _persist();
    notifyListeners();
  }

  void togglePlaceGear(String id, String equipment) {
    final i = places.indexWhere((p) => p.id == id);
    if (i < 0) return;
    final gear = {...places[i].equipment};
    gear.contains(equipment) ? gear.remove(equipment) : gear.add(equipment);
    places[i] = places[i].copyWith(equipment: gear);
    _persist();
    notifyListeners();
  }

  void deletePlace(String id) {
    places.removeWhere((p) => p.id == id);
    if (activePlaceId == id) activePlaceId = '';
    _persist();
    notifyListeners();
  }

  @override
  Map<double, int>? get plateStockKg {
    final p = activePlace;
    if (p == null || p.plates.isEmpty) return null;
    return p.plates;
  }

  @override
  double? get placeBarKg => activePlace?.bar;

  void setPlatePairs(String placeId, double kg, int pairs) {
    final i = places.indexWhere((p) => p.id == placeId);
    if (i < 0) return;
    final plates = {...places[i].plates};
    final key = _plateKey(plates, kg);
    if (pairs <= 0) {
      plates.remove(key);
    } else {
      plates[key] = pairs.clamp(1, 20);
    }
    places[i] = places[i].copyWith(plates: plates);
    _persist();
    notifyListeners();
  }

  void clearPlates(String placeId) {
    final i = places.indexWhere((p) => p.id == placeId);
    if (i < 0) return;
    places[i] = places[i].copyWith(plates: const {}, clearBar: true);
    _persist();
    notifyListeners();
  }

  void setPlaceBar(String placeId, double kg) {
    final i = places.indexWhere((p) => p.id == placeId);
    if (i < 0) return;
    places[i] = places[i].copyWith(bar: _round3(kg.clamp(1, 60)));
    _persist();
    notifyListeners();
  }

  int platePairs(GymPlace place, double kg) {
    for (final e in place.plates.entries) {
      if ((e.key - kg).abs() < 0.05) return e.value;
    }
    return 0;
  }

  double _plateKey(Map<double, int> plates, double kg) {
    for (final k in plates.keys) {
      if ((k - kg).abs() < 0.05) return k;
    }
    return _round3(kg);
  }

  void setActivePlace(String id) {
    activePlaceId = activePlaceId == id ? '' : id;
    _persist();
    notifyListeners();
  }

  bool exNoGearOnly = false;

  void toggleNoGearFilter() {
    exNoGearOnly = !exNoGearOnly;
    notifyListeners();
  }

  @override
  List<Exercise> exercisesMatching(String query) => super
      .exercisesMatching(query)
      .where((ex) => (!exNoGearOnly || ex.equipment == 'Bodyweight') && fitsHere(ex))
      .toList();

  @override
  void clearExFilters() {
    exNoGearOnly = false;
    super.clearExFilters();
  }

  void goPlaces() => pushRoute('places');

  void backFromPlaces() => popRoute(fallback: 'settings');
}
