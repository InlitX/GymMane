part of 'fit_state.dart';

mixin NutritionState on FitCore, ToolsState, StatsState {
  final List<FoodItem> foods = [];
  final List<FoodEntry> foodLog = [];
  final List<WaterSip> waterLog = [];
  final List<Supplement> supplements = [];
  final List<Recipe> recipes = [];
  final List<Batch> batches = [];
  final List<String> favoriteFoods = [];
  final List<MealPlan> mealPlans = [];
  final Map<int, String> mealWeek = {};
  final List<MealSlot> mealSlots = [...kDefaultMeals];
  final Set<Tracker> trackers = {...Tracker.values}..removeAll(kTrackersOffByDefault);
  final Map<String, Set<String>> supplementsTaken = {};
  NutritionGoals nutritionGoals = const NutritionGoals();
  bool nutritionGoalsSet = false;
  NutritionGoals? restGoals;
  bool addBurned = false;
  bool nutritionBeta = true;
  bool useKj = false;
  bool vesselMotion = true;
  double weightGoalKg = 0;
  int? supplementReminderMin;
  String shakeFoodId = '';
  final List<String> shakeFoods = [];
  DateTime nutritionDay = _dayKey(DateTime.now());
  DateTime _nutritionSetOn = _dayKey(DateTime.now());
  int _foodSeq = 0;

  static String _dk(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  bool get nutritionOnToday => _dayKey(DateTime.now()) == nutritionDay;

  String _newId(String prefix) => '$prefix${DateTime.now().microsecondsSinceEpoch}-${_foodSeq++}';

  NutritionGoals get activeGoals => nutritionGoalsSet ? nutritionGoals : suggestedGoals;

  double get _nutritionWeight {
    final w = latestBodyweight?.kg ?? profile.weightKg;
    return w > 0 ? w : 75;
  }

  NutritionGoals get suggestedGoals {
    final kg = _nutritionWeight;
    final base = tdee > 0 ? tdee : (kg * 30).round();
    final aim = weightGoalKg <= 0 ? 0.0 : weightGoalKg - kg;
    final cutting = aim < -0.5, bulking = aim > 0.5;
    final kcal = (base + (cutting ? -500 : bulking ? 300 : 0)).clamp(1200, 9000).toInt();
    final protein = (kg * (cutting ? 2.0 : 1.8)).round();
    final fat = (kg * 0.8).round();
    final carbs = math.max(0, ((kcal - protein * 4 - fat * 9) / 4).round());
    final water = ((kg * 35) / 250).round() * 250;
    return NutritionGoals(
      kcal: kcal,
      protein: protein,
      carbs: carbs,
      fat: fat,
      waterMl: water.clamp(1000, 6000),
      glassMl: nutritionGoals.glassMl,
      fiber: (kcal * 14 / 1000).round().clamp(15, 60),
      sugar: nutritionGoals.sugar,
      sodium: nutritionGoals.sodium,
    );
  }

  void setNutritionGoals(NutritionGoals g) {
    nutritionGoals = g;
    nutritionGoalsSet = true;
    _persist();
    notifyListeners();
  }

  void useSuggestedGoals() => setNutritionGoals(suggestedGoals);

  void setRestGoals(NutritionGoals? g) {
    restGoals = g;
    _persist();
    notifyListeners();
  }

  void splitRestGoals(bool on) {
    final g = activeGoals;
    final kcal = (g.kcal * 0.85 / 10).round() * 10;
    final carbs = math.max(10, g.carbs - ((g.kcal - kcal) / 4).round());
    setRestGoals(on ? g.copyWith(kcal: kcal, carbs: carbs) : null);
  }

  bool isTrainingDay(DateTime day) {
    final key = _dayKey(day);
    if (sessions.any((s) => _dayKey(s.date) == key)) return true;
    if (key != _dayKey(DateTime.now())) return false;
    return hasPlanOn(key);
  }

  NutritionGoals goalsFor(DateTime day) {
    final rest = restGoals;
    if (rest == null || isTrainingDay(day)) return activeGoals;
    final a = activeGoals;
    return rest.copyWith(waterMl: a.waterMl, glassMl: a.glassMl, fiber: a.fiber, sugar: a.sugar, sodium: a.sodium);
  }

  static const double _liftMet = 5;

  int burnedOn(DateTime day) {
    final key = _dayKey(day);
    var kcal = 0.0;
    for (final s in sessions.where((s) => _dayKey(s.day) == key)) {
      var cardioSec = 0;
      for (final e in s.exercises) {
        final c = cardioKcal(s, e);
        if (c == null) continue;
        kcal += c.active;
        cardioSec += c.sec;
      }
      kcal += (_liftMet - 1) * _nutritionWeight * math.max(0, s.durationSec - cardioSec) / 3600;
    }
    return kcal.round();
  }

  int kcalBudgetOn(DateTime day) => goalsFor(day).kcal + (addBurned ? burnedOn(day) : 0);

  void setAddBurned(bool on) {
    addBurned = on;
    _persist();
    notifyListeners();
  }

  void setVesselMotion(bool on) {
    vesselMotion = on;
    _persist();
    notifyListeners();
  }

  void setUseKj(bool on) {
    useKj = on;
    _persist();
    notifyListeners();
  }

  int energyOf(num kcal) => (useKj ? kcal * 4.184 : kcal).round();

  double kcalFromShown(double v) => useKj ? v / 4.184 : v;

  String get energyUnit => useKj ? 'kJ' : 'kcal';

  void setWeightGoal(double kg) {
    weightGoalKg = kg > 0 ? _round3(kg) : 0;
    _persist();
    notifyListeners();
  }

  double get nutritionWeightKg => _nutritionWeight;

  ({int days, int kcal, int protein, int kcalMet, int proteinMet})? weekNutrition([DateTime? anyDay]) {
    final ref = anyDay ?? nutritionDay;
    final start = shiftDays(_dayKey(ref), -((ref.weekday - weekStartDay + 7) % 7));
    final today = _dayKey(DateTime.now());
    var days = 0, kcalMet = 0, proteinMet = 0;
    var kcal = 0.0, protein = 0.0;
    for (var i = 0; i < 7; i++) {
      final d = shiftDays(start, i);
      if (d.isAfter(today) || entriesOn(d).isEmpty) continue;
      final total = totalOn(d);
      final goal = goalsFor(d);
      final budget = kcalBudgetOn(d);
      days++;
      kcal += total.kcal;
      protein += total.protein;
      if (budget > 0 && (total.kcal - budget).abs() <= budget * 0.1) kcalMet++;
      if (goal.protein > 0 && total.protein >= goal.protein * 0.9) proteinMet++;
    }
    if (days == 0) return null;
    return (
      days: days,
      kcal: (kcal / days).round(),
      protein: (protein / days).round(),
      kcalMet: kcalMet,
      proteinMet: proteinMet,
    );
  }

  Map<DateTime, List<FoodEntry>>? _foodByDay;
  int _foodByDayLen = -1;
  Map<DateTime, int>? _waterByDay;
  int _waterByDayLen = -1;

  List<FoodItem>? _byUse;
  List<FoodItem>? _recent;
  int _cacheLen = -1;

  void _dropCaches() {
    _foodByDay = null;
    _waterByDay = null;
    _byUse = null;
    _recent = null;
  }

  bool _cacheStale() {
    if (_cacheLen == foodLog.length) return false;
    _cacheLen = foodLog.length;
    _byUse = null;
    _recent = null;
    return true;
  }

  @override
  void notifyListeners() {
    _dropCaches();
    super.notifyListeners();
  }

  List<FoodEntry> entriesOn(DateTime day) {
    var index = _foodByDay;
    if (index == null || _foodByDayLen != foodLog.length) {
      index = <DateTime, List<FoodEntry>>{};
      for (final e in foodLog) {
        index.putIfAbsent(_dayKey(e.at), () => []).add(e);
      }
      for (final list in index.values) {
        list.sort((a, b) => a.at.compareTo(b.at));
      }
      _foodByDay = index;
      _foodByDayLen = foodLog.length;
    }
    return [...?index[_dayKey(day)]];
  }

  Macros totalOn(DateTime day) => entriesOn(day).fold(Macros.zero, (s, e) => s + e.total);

  ({double kcal, double protein}) leftAfter(Macros adding, {Macros replacing = Macros.zero}) {
    final day = nutritionDay;
    final eaten = totalOn(day) + replacing * -1 + adding;
    return (kcal: kcalBudgetOn(day) - eaten.kcal, protein: goalsFor(day).protein - eaten.protein);
  }

  double? fillGrams(FoodItem food, {Macros replacing = Macros.zero}) {
    if (!food.byWeight || food.macros.kcal <= 0) return null;
    final left = leftAfter(Macros.zero, replacing: replacing);
    if (left.kcal <= 0) return null;
    final perGram = food.macros * (1 / food.grams);
    var grams = left.kcal / perGram.kcal;
    if (trackerOn(Tracker.protein) && perGram.protein * 100 >= 8 && left.protein > 0) {
      grams = math.min(grams, left.protein / perGram.protein);
    }
    return grams >= 1 ? grams : null;
  }

  int waterOn(DateTime day) {
    var index = _waterByDay;
    if (index == null || _waterByDayLen != waterLog.length) {
      index = <DateTime, int>{};
      for (final w in waterLog) {
        final k = _dayKey(w.at);
        index[k] = (index[k] ?? 0) + w.ml;
      }
      _waterByDay = index;
      _waterByDayLen = waterLog.length;
    }
    return index[_dayKey(day)] ?? 0;
  }

  Set<String> takenOn(DateTime day) => supplementsTaken[_dk(day)] ?? const {};

  DateTime _stampFor(DateTime day) {
    final now = DateTime.now();
    final key = _dayKey(day);
    return key == _dayKey(now) ? now : key.add(const Duration(hours: 12));
  }

  Meal get defaultMeal {
    if (nutritionOnToday) return mealForHour(DateTime.now().hour, mealSlots);
    return mealSlots.any((s) => s.meal == Meal.lunch) ? Meal.lunch : mealSlots.first.meal;
  }

  bool trackerOn(Tracker t) => trackers.contains(t);

  void setTracker(Tracker t, bool on) {
    if (on) {
      trackers.add(t);
    } else {
      trackers.remove(t);
    }
    _persist();
    notifyListeners();
  }

  MealSlot? slotOf(Meal m) {
    for (final s in mealSlots) {
      if (s.meal == m) return s;
    }
    return null;
  }

  List<Meal> get mealsShown {
    final out = [for (final s in mealSlots) s.meal];
    for (final e in entriesOn(nutritionDay)) {
      if (!out.contains(e.meal)) out.add(e.meal);
    }
    return out;
  }

  MealSlot? addMealSlot(String name) {
    final clean = name.trim();
    if (clean.isEmpty) return null;
    final slot = MealSlot(Meal(_newId('m')), name: clean);
    mealSlots.add(slot);
    _persist();
    notifyListeners();
    return slot;
  }

  void renameMealSlot(Meal m, String name) {
    final i = mealSlots.indexWhere((s) => s.meal == m);
    if (i < 0) return;
    mealSlots[i] = mealSlots[i].copyWith(name: name.trim());
    _persist();
    notifyListeners();
  }

  void moveMealSlot(Meal m, int dir) {
    final i = mealSlots.indexWhere((s) => s.meal == m);
    final j = i + dir;
    if (i < 0 || j < 0 || j >= mealSlots.length) return;
    final slot = mealSlots.removeAt(i);
    mealSlots.insert(j, slot);
    _persist();
    notifyListeners();
  }

  bool removeMealSlot(Meal m) {
    if (mealSlots.length <= 1) return false;
    final i = mealSlots.indexWhere((s) => s.meal == m);
    if (i < 0) return false;
    mealSlots.removeAt(i);
    final into = mealSlots[math.max(0, i - 1)].meal;
    for (var k = 0; k < foodLog.length; k++) {
      if (foodLog[k].meal == m) foodLog[k] = foodLog[k].copyWith(meal: into);
    }
    _foodByDay = null;
    for (var k = 0; k < mealPlans.length; k++) {
      final p = mealPlans[k];
      if (!p.items.any((e) => e.meal == m)) continue;
      mealPlans[k] = p.copyWith(items: [for (final e in p.items) e.meal == m ? e.copyWith(meal: into) : e]);
    }
    _persist();
    notifyListeners();
    return true;
  }

  FoodEntry entryFor(FoodItem food, {double servings = 1, Meal? meal, bool cooked = false}) => FoodEntry(
        id: _newId('e'),
        at: _stampFor(nutritionDay),
        meal: meal ?? defaultMeal,
        name: food.name,
        foodId: food.id,
        servings: servings <= 0 ? 1 : servings,
        grams: food.grams,
        liquid: food.liquid,
        cooked: cooked && food.canCook ? food.cookedYield : 0,
        per: food.macros,
      );

  FoodEntry logFood(FoodItem food, {double servings = 1, Meal? meal, bool cooked = false}) {
    final e = entryFor(food, servings: servings, meal: meal, cooked: cooked);
    foodLog.add(e);
    _persist();
    notifyListeners();
    return e;
  }

  FoodEntry? logQuick(String name, Macros macros, {Meal? meal}) {
    if (macros.isEmpty) return null;
    final e = FoodEntry(
      id: _newId('e'),
      at: _stampFor(nutritionDay),
      meal: meal ?? defaultMeal,
      name: name.trim(),
      per: macros,
    );
    foodLog.add(e);
    _persist();
    notifyListeners();
    return e;
  }

  void updateEntry(String id, {double? servings, Meal? meal}) {
    final i = foodLog.indexWhere((e) => e.id == id);
    if (i < 0) return;
    final old = foodLog[i];
    foodLog[i] = old.copyWith(servings: servings != null && servings > 0 ? servings : null, meal: meal);
    _foodByDay = null;
    _batchTake(old.foodId, foodLog[i].totalGrams - old.totalGrams);
    _persist();
    notifyListeners();
  }

  void moveEntryToDay(String id, DateTime day) {
    final i = foodLog.indexWhere((e) => e.id == id);
    if (i < 0) return;
    final old = foodLog[i].at;
    final at = DateTime(day.year, day.month, day.day, old.hour, old.minute, old.second);
    if (_dayKey(at) == _dayKey(old)) return;
    foodLog[i] = foodLog[i].copyWith(at: at);
    _foodByDay = null;
    _persist();
    notifyListeners();
  }

  void editEntryValues(String id, {required String name, required Macros per}) {
    final i = foodLog.indexWhere((e) => e.id == id);
    if (i < 0 || per.isEmpty) return;
    foodLog[i] = foodLog[i].copyWith(name: name.trim().isEmpty ? null : name.trim(), per: per);
    _foodByDay = null;
    _persist();
    notifyListeners();
  }

  FoodItem? customOf(String libraryId) {
    for (final f in foods) {
      if (f.photo.isNotEmpty && f.photo == FoodLibrary.byId(libraryId)?.item(appLanguage).photo) return f;
    }
    return null;
  }

  FoodEntry? removeEntry(String id) {
    final i = foodLog.indexWhere((e) => e.id == id);
    if (i < 0) return null;
    final gone = foodLog.removeAt(i);
    _batchTake(gone.foodId, -gone.totalGrams);
    _persist();
    notifyListeners();
    return gone;
  }

  void restoreEntry(FoodEntry e) {
    if (foodLog.any((x) => x.id == e.id)) return;
    foodLog.add(e);
    _batchTake(e.foodId, e.totalGrams);
    _persist();
    notifyListeners();
  }

  Batch? batchById(String id) {
    for (final b in batches) {
      if (b.id == id) return b;
    }
    return null;
  }

  List<Batch> get activeBatches => [
        for (final b in batches)
          if (!b.finished) b,
      ]..sort((a, b) => b.created.compareTo(a.created));

  void _batchTake(String id, double grams) {
    if (!id.startsWith('p') || grams == 0) return;
    final i = batches.indexWhere((b) => b.id == id);
    if (i < 0) return;
    final b = batches[i];
    batches[i] = b.copyWith(leftGrams: (b.leftGrams - grams).clamp(0, b.totalGrams).toDouble());
  }

  Batch? saveBatch({String? id, required String name, required List<FoodEntry> items, double cookedGrams = 0}) {
    final clean = name.trim();
    if (clean.isEmpty || items.isEmpty) return null;
    final i = id == null ? -1 : batches.indexWhere((b) => b.id == id);
    if (i >= 0) {
      final old = batches[i];
      final eaten = old.totalGrams - old.leftGrams;
      final next = old.copyWith(name: clean, items: items, cookedGrams: cookedGrams);
      batches[i] = next.copyWith(leftGrams: (next.totalGrams - eaten).clamp(0, next.totalGrams).toDouble());
      _persist();
      notifyListeners();
      return batches[i];
    }
    final draft = Batch(id: _newId('p'), name: clean, items: items, created: DateTime.now(), cookedGrams: cookedGrams);
    if (draft.totalGrams <= 0) return null;
    final b = draft.copyWith(leftGrams: draft.totalGrams);
    batches.add(b);
    _persist();
    notifyListeners();
    return b;
  }

  FoodEntry? logFromBatch(Batch batch, double grams, {Meal? meal}) {
    final b = batchById(batch.id);
    if (b == null || grams <= 0 || b.totalGrams <= 0) return null;
    final take = math.min(grams, b.leftGrams);
    if (take <= 0) return null;
    final e = FoodEntry(
      id: _newId('e'),
      at: _stampFor(nutritionDay),
      meal: meal ?? defaultMeal,
      name: b.name,
      foodId: b.id,
      servings: take / 100,
      grams: 100,
      per: b.per100,
    );
    foodLog.add(e);
    _batchTake(b.id, take);
    _persist();
    notifyListeners();
    return e;
  }

  void setBatchLeft(String id, double grams) {
    final i = batches.indexWhere((b) => b.id == id);
    if (i < 0) return;
    final b = batches[i];
    batches[i] = b.copyWith(leftGrams: grams.clamp(0, b.totalGrams).toDouble());
    _persist();
    notifyListeners();
  }

  void deleteBatch(String id) {
    batches.removeWhere((b) => b.id == id);
    _persist();
    notifyListeners();
  }

  void addWater([int? ml]) {
    final amount = ml ?? activeGoals.glassMl;
    if (amount <= 0) return;
    waterLog.add(WaterSip(_stampFor(nutritionDay), amount.clamp(1, 5000)));
    _persist();
    notifyListeners();
  }

  int takeWidgetLog(String pending) {
    var n = 0;
    final today = _dayKey(DateTime.now());
    for (final item in pending.split(';')) {
      final p = item.split(',');
      if (p.length != 3) continue;
      final ms = int.tryParse(p[1]);
      if (ms == null) continue;
      final at = DateTime.fromMillisecondsSinceEpoch(ms);
      final day = _dayKey(at);
      if (day.isAfter(today) || today.difference(day).inDays > 7) continue;
      if (p[0] == 'w') {
        final ml = int.tryParse(p[2]) ?? 0;
        if (ml <= 0) continue;
        waterLog.add(WaterSip(at, ml.clamp(1, 5000)));
        n++;
      } else if (p[0] == 's') {
        final food = foodById(p[2]);
        if (food == null) continue;
        foodLog.add(entryFor(food, meal: mealForHour(at.hour, mealSlots)).copyWith(at: at));
        n++;
      }
    }
    if (n > 0) {
      _persist();
      notifyListeners();
    }
    return n;
  }

  List<WaterSip> waterSipsOn(DateTime day) {
    final key = _dayKey(day);
    return [for (final w in waterLog) if (_dayKey(w.at) == key) w];
  }

  void removeWaterSip(WaterSip sip) {
    final i = waterLog.indexWhere((w) => identical(w, sip));
    if (i < 0) return;
    waterLog.removeAt(i);
    _persist();
    notifyListeners();
  }

  bool undoWater() {
    final key = _dayKey(nutritionDay);
    final i = waterLog.lastIndexWhere((w) => _dayKey(w.at) == key);
    if (i < 0) return false;
    waterLog.removeAt(i);
    _persist();
    notifyListeners();
    return true;
  }

  String waterLabel(int ml) {
    if (isLb) return '${(ml / 29.5735).round()} fl oz';
    if (ml >= 1000) return '${fmt((ml / 100).round() / 10)} L';
    return '$ml ml';
  }

  String waterValue(int ml) => isLb ? '${(ml / 29.5735).round()}' : fmt((ml / 100).round() / 10);

  String get waterUnit => isLb ? 'fl oz' : 'L';

  FoodItem? foodById(String id) {
    for (final f in foods) {
      if (f.id == id) return f;
    }
    return FoodLibrary.byId(id)?.item(appLanguage);
  }

  bool isFavoriteFood(String id) => favoriteFoods.contains(id);

  void toggleFavoriteFood(String id) {
    if (!favoriteFoods.remove(id)) favoriteFoods.insert(0, id);
    _persist();
    notifyListeners();
  }

  List<FoodItem> get favoriteFoodItems => [for (final id in favoriteFoods) ?foodById(id)];

  Recipe dishRecipe(ReadyDish d) => Recipe(
        id: '$kDishPrefix${d.id}',
        name: d.nameFor(appLanguage),
        items: [
          for (final (slug, grams, cooked) in d.items)
            if (FoodLibrary.byId('$kLibraryPrefix$slug')?.item(appLanguage) case final f?)
              entryFor(f, servings: (cooked && f.canCook ? grams / f.cookedYield : grams) / f.grams, cooked: cooked),
        ],
      );

  List<Recipe> searchDishes(String query) => [for (final d in FoodLibrary.searchDishes(query, appLanguage)) dishRecipe(d)];

  bool isOwnRecipe(String id) => recipes.any((r) => r.id == id);

  void updateRecipe(String id, List<FoodEntry> items) {
    final i = recipes.indexWhere((r) => r.id == id);
    if (i < 0 || items.isEmpty) return;
    recipes[i] = Recipe(id: id, name: recipes[i].name, items: items);
    _persist();
    notifyListeners();
  }

  List<Recipe> searchRecipes(String query) {
    final q = foldText(query.trim());
    return [
      for (final r in recipes)
        if (q.isEmpty || foldText(r.name).contains(q)) r,
    ];
  }

  List<FoodItem> searchFoods(String query) {
    final q = foldText(query.trim());
    return [
      for (final f in foodsByUse)
        if (q.isEmpty || foldText(f.name).contains(q)) f,
    ];
  }

  List<FoodItem> get recentLibraryFoods {
    _cacheStale();
    return _recent ??= _computeRecent();
  }

  List<FoodItem> _computeRecent() {
    final seen = <String>{};
    final out = <FoodItem>[];
    for (final e in [...foodLog]..sort((a, b) => b.at.compareTo(a.at))) {
      if (!e.foodId.startsWith(kLibraryPrefix) || !seen.add(e.foodId)) continue;
      final f = foodById(e.foodId);
      if (f != null) out.add(f);
      if (out.length >= 12) break;
    }
    return out;
  }

  Recipe? saveRecipe(String name, List<FoodEntry> items) {
    final clean = name.trim();
    if (clean.isEmpty || items.isEmpty) return null;
    final r = Recipe(
      id: _newId('r'),
      name: clean,
      items: [for (final e in items) e.copyWith(id: _newId('e'))],
    );
    recipes.add(r);
    _persist();
    notifyListeners();
    return r;
  }

  void renameRecipe(String id, String name) {
    final i = recipes.indexWhere((r) => r.id == id);
    if (i < 0 || name.trim().isEmpty) return;
    recipes[i] = recipes[i].copyWith(name: name.trim());
    _persist();
    notifyListeners();
  }

  void deleteRecipe(String id) {
    recipes.removeWhere((r) => r.id == id);
    _persist();
    notifyListeners();
  }

  List<FoodEntry> _logCopies(Iterable<FoodEntry> items, Meal meal, {double factor = 1}) {
    final at = _stampFor(nutritionDay);
    final added = [
      for (final e in items) e.copyWith(id: _newId('e'), at: at, meal: meal, servings: e.servings * factor),
    ];
    if (added.isEmpty) return added;
    foodLog.addAll(added);
    for (final e in added) {
      _batchTake(e.foodId, e.totalGrams);
    }
    _persist();
    notifyListeners();
    return added;
  }

  MealPlan? mealPlanById(String id) {
    for (final p in mealPlans) {
      if (p.id == id) return p;
    }
    return null;
  }

  MealPlan? planOn(DateTime day) => mealPlanById(mealWeek[day.weekday] ?? '');

  List<int> planDays(String id) => [for (final e in mealWeek.entries) if (e.value == id) e.key]..sort();

  MealPlan createMealPlan({String name = '', bool fromDay = false}) {
    final at = DateTime.now();
    final plan = MealPlan(
      id: _newId('mp'),
      name: name.trim().isEmpty ? t.mealPlanDefault(mealPlans.length + 1) : name.trim(),
      color: mealPlans.length,
      items: fromDay ? [for (final e in entriesOn(nutritionDay)) e.copyWith(id: _newId('pe'), at: at)] : const [],
    );
    mealPlans.add(plan);
    _persist();
    notifyListeners();
    return plan;
  }

  String newPlanItemId() => _newId('pe');

  MealPlan draftMealPlan({bool fromDay = false}) {
    final at = DateTime.now();
    return MealPlan(
      id: '',
      name: t.mealPlanDefault(mealPlans.length + 1),
      color: mealPlans.length,
      items: fromDay ? [for (final e in entriesOn(nutritionDay)) e.copyWith(id: _newId('pe'), at: at)] : const [],
    );
  }

  MealPlan saveMealPlan(MealPlan plan, Set<int> days) {
    final clean = plan.name.trim();
    final name = clean.isEmpty ? t.mealPlanDefault(mealPlans.length + 1) : clean;
    final i = plan.id.isEmpty ? -1 : mealPlans.indexWhere((p) => p.id == plan.id);
    final saved = i < 0
        ? MealPlan(id: _newId('mp'), name: name, color: mealPlans.length, items: plan.items)
        : plan.copyWith(name: name);
    if (i < 0) {
      mealPlans.add(saved);
    } else {
      mealPlans[i] = saved;
    }
    mealWeek.removeWhere((_, v) => v == saved.id);
    for (final d in days) {
      if (d >= 1 && d <= 7) mealWeek[d] = saved.id;
    }
    _persist();
    notifyListeners();
    return saved;
  }

  ({int done, int total}) planProgress(MealPlan plan, DateTime day) {
    final logged = {for (final e in entriesOn(day)) e.meal};
    var done = 0, total = 0;
    for (final slot in mealSlots) {
      if (plan.itemsOf(slot.meal).isEmpty) continue;
      total++;
      if (logged.contains(slot.meal)) done++;
    }
    return (done: done, total: total);
  }

  void _putPlan(MealPlan plan) {
    final i = mealPlans.indexWhere((p) => p.id == plan.id);
    if (i < 0) return;
    mealPlans[i] = plan;
    _persist();
    notifyListeners();
  }

  void renameMealPlan(String id, String name) {
    final p = mealPlanById(id);
    if (p != null && name.trim().isNotEmpty) _putPlan(p.copyWith(name: name.trim()));
  }

  void addPlanItem(String id, FoodEntry e) {
    final p = mealPlanById(id);
    if (p != null) _putPlan(p.copyWith(items: [...p.items, e.copyWith(id: _newId('pe'))]));
  }

  void updatePlanItem(String id, FoodEntry e) {
    final p = mealPlanById(id);
    if (p != null) _putPlan(p.copyWith(items: [for (final x in p.items) x.id == e.id ? e : x]));
  }

  void removePlanItem(String id, String entryId) {
    final p = mealPlanById(id);
    if (p != null) _putPlan(p.copyWith(items: [for (final x in p.items) if (x.id != entryId) x]));
  }

  MealPlan? duplicateMealPlan(String id) {
    final p = mealPlanById(id);
    if (p == null) return null;
    final copy = MealPlan(
      id: _newId('mp'),
      name: '${p.name} 2',
      color: mealPlans.length,
      items: [for (final e in p.items) e.copyWith(id: _newId('pe'))],
    );
    mealPlans.add(copy);
    _persist();
    notifyListeners();
    return copy;
  }

  void deleteMealPlan(String id) {
    mealPlans.removeWhere((p) => p.id == id);
    mealWeek.removeWhere((_, v) => v == id);
    _persist();
    notifyListeners();
  }

  void setPlanDay(int weekday, String? id) {
    if (id == null || mealWeek[weekday] == id) {
      mealWeek.remove(weekday);
    } else {
      mealWeek[weekday] = id;
    }
    _persist();
    notifyListeners();
  }

  static const mealPlanTag = 'gymmane-meal-plans';

  bool isMealPlanText(String text) => text.contains(mealPlanTag);

  void moveMealPlan(String id, int dir) {
    final i = mealPlans.indexWhere((p) => p.id == id);
    final j = i + dir;
    if (i < 0 || j < 0 || j >= mealPlans.length) return;
    final p = mealPlans.removeAt(i);
    mealPlans.insert(j, p);
    _persist();
    notifyListeners();
  }

  String exportMealPlansJson(List<MealPlan> chosen) {
    final plans = [for (final p in chosen) mealPlanById(p.id) ?? p];
    final used = {for (final p in plans) for (final e in p.items) e.meal.id};
    return const JsonEncoder.withIndent('  ').convert({
      'kind': mealPlanTag,
      'v': 1,
      'meals': {
        for (final s in mealSlots)
          if (used.contains(s.meal.id) && !s.isDefault) s.meal.id: s.name,
      },
      'plans': [
        for (final p in plans)
          {
            'n': p.name,
            'days': planDays(p.id),
            'i': [for (final e in p.items) e.toJson()..remove('id')..remove('at')],
          },
      ],
    });
  }

  int importMealPlans(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start < 0 || end <= start) return 0;
    Map<String, dynamic> data;
    try {
      data = (jsonDecode(text.substring(start, end + 1)) as Map).cast<String, dynamic>();
    } catch (_) {
      return 0;
    }
    if (data['kind'] != mealPlanTag) return 0;
    final slotIds = {for (final s in mealSlots) s.meal.id};
    final mapped = <String, Meal>{};
    final names = (data['meals'] as Map?)?.cast<String, dynamic>() ?? const {};
    names.forEach((id, name) {
      if (slotIds.contains(id) || name is! String || name.trim().isEmpty) return;
      final slot = mealSlots.where((s) => s.name.trim().toLowerCase() == name.trim().toLowerCase()).firstOrNull ??
          addMealSlot(name);
      if (slot != null) mapped[id] = slot.meal;
    });
    var count = 0;
    final at = DateTime.now();
    for (final raw in (data['plans'] as List?) ?? const []) {
      if (raw is! Map) continue;
      final p = raw.cast<String, dynamic>();
      final items = <FoodEntry>[];
      for (final r in (p['i'] as List?) ?? const []) {
        if (r is! Map) continue;
        final e = FoodEntry.fromJson({...r.cast<String, dynamic>(), 'id': _newId('pe'), 'at': at.toIso8601String()});
        final meal = mapped[e.meal.id] ?? (slotIds.contains(e.meal.id) ? e.meal : Meal.snacks);
        final local = e.foodId.isEmpty || foodById(e.foodId) != null || e.foodId.startsWith('a:');
        items.add(FoodEntry(
          id: e.id,
          at: e.at,
          meal: meal,
          name: e.name,
          foodId: local && !e.foodId.startsWith('p') ? e.foodId : '',
          servings: e.servings,
          grams: e.grams,
          liquid: e.liquid,
          cooked: e.cooked,
          per: e.per,
        ));
      }
      final name = (p['n'] as String? ?? '').trim();
      final plan = MealPlan(
        id: _newId('mp'),
        name: name.isEmpty ? t.mealPlanDefault(mealPlans.length + 1) : name,
        color: mealPlans.length,
        items: items,
      );
      mealPlans.add(plan);
      for (final d in (p['days'] as List?) ?? const []) {
        final day = (d as num?)?.toInt();
        if (day != null && day >= 1 && day <= 7 && !mealWeek.containsKey(day)) mealWeek[day] = plan.id;
      }
      count++;
    }
    if (count > 0) {
      _persist();
      notifyListeners();
    }
    return count;
  }

  List<FoodEntry> logPlanMeal(MealPlan plan, Meal meal) => _logCopies(plan.itemsOf(meal), meal);

  int logPlanDay(MealPlan plan) {
    var n = 0;
    for (final slot in mealSlots) {
      if (entriesOn(nutritionDay).any((e) => e.meal == slot.meal)) continue;
      n += logPlanMeal(plan, slot.meal).length;
    }
    return n;
  }

  FoodEntry? repeatEntry(FoodEntry e) {
    final added = _logCopies([e], e.meal);
    return added.isEmpty ? null : added.first;
  }

  List<FoodEntry> logRecipe(Recipe r, {Meal? meal, double factor = 1}) =>
      _logCopies(r.items, meal ?? defaultMeal, factor: factor <= 0 ? 1 : factor);

  List<FoodEntry> copyMeal(DateTime from, Meal meal, {Meal? into}) =>
      _logCopies(entriesOn(from).where((e) => e.meal == meal), into ?? meal);

  List<FoodEntry> copyDay(DateTime from) {
    final src = entriesOn(from);
    return [
      for (final m in {for (final e in src) e.meal}) ..._logCopies(src.where((e) => e.meal == m), m),
    ];
  }

  List<FoodEntry> clearMeal(Meal meal) {
    final gone = entriesOn(nutritionDay).where((e) => e.meal == meal).toList();
    for (final e in gone) {
      foodLog.removeWhere((x) => x.id == e.id);
      _batchTake(e.foodId, -e.totalGrams);
    }
    _persist();
    notifyListeners();
    return gone;
  }

  void restoreEntries(List<FoodEntry> list) {
    for (final e in list) {
      if (foodLog.any((x) => x.id == e.id)) continue;
      foodLog.add(e);
      _batchTake(e.foodId, e.totalGrams);
    }
    _persist();
    notifyListeners();
  }

  Set<String> moveMeal(Meal from, Meal to) {
    if (from == to) return const {};
    return moveEntries({for (final e in entriesOn(nutritionDay)) if (e.meal == from) e.id}, to);
  }

  Set<String> moveEntries(Set<String> ids, Meal to) {
    final moved = <String>{};
    for (var i = 0; i < foodLog.length; i++) {
      if (!ids.contains(foodLog[i].id) || foodLog[i].meal == to) continue;
      foodLog[i] = foodLog[i].copyWith(meal: to);
      moved.add(foodLog[i].id);
    }
    if (moved.isEmpty) return moved;
    _foodByDay = null;
    _persist();
    notifyListeners();
    return moved;
  }

  List<DateTime> daysWithMeal(Meal? meal, {int max = 7}) {
    final out = <DateTime>[];
    final seen = <DateTime>{};
    final current = _dayKey(nutritionDay);
    for (final e in [...foodLog]..sort((a, b) => b.at.compareTo(a.at))) {
      final d = _dayKey(e.at);
      if ((meal != null && e.meal != meal) || d == current || !seen.add(d)) continue;
      out.add(d);
      if (out.length >= max) break;
    }
    return out;
  }

  Batch? batchOfEntry(FoodEntry e) => e.foodId.startsWith('p') ? batchById(e.foodId) : null;

  String photoForEntry(FoodEntry e) {
    if (e.foodId.isEmpty) return '';
    final batch = batchOfEntry(e);
    if (batch != null) {
      final items = [...batch.items]..sort((a, b) => b.grams.compareTo(a.grams));
      for (final i in items) {
        final photo = photoForEntry(i);
        if (photo.isNotEmpty) return photo;
      }
      return '';
    }
    return foodById(e.foodId)?.photo ?? '';
  }

  List<FoodItem> get foodsByUse {
    _cacheStale();
    return _byUse ??= _computeByUse();
  }

  List<FoodItem> _computeByUse() {
    final last = <String, DateTime>{};
    for (final e in foodLog) {
      if (e.foodId.isEmpty) continue;
      final seen = last[e.foodId];
      if (seen == null || e.at.isAfter(seen)) last[e.foodId] = e.at;
    }
    final out = [...foods];
    out.sort((a, b) {
      final x = last[a.id], y = last[b.id];
      if (x == null && y == null) return 0;
      if (x == null) return 1;
      if (y == null) return -1;
      return y.compareTo(x);
    });
    return out;
  }

  FoodItem saveFood({
    String? id,
    required String name,
    String photo = '',
    String serving = '',
    double grams = 0,
    bool liquid = false,
    double cookedYield = 0,
    Macros macros = Macros.zero,
  }) {
    final clean = name.trim();
    final i = id == null ? -1 : foods.indexWhere((f) => f.id == id);
    if (i >= 0) {
      final old = foods[i];
      if (old.photo.isNotEmpty && old.photo != photo && !isAssetPhoto(old.photo)) MediaStore.delete(old.photo);
      foods[i] = old.copyWith(
          name: clean,
          photo: photo,
          serving: serving.trim(),
          grams: grams,
          liquid: liquid,
          macros: macros,
          cookedYield: cookedYield);
      _persist();
      notifyListeners();
      return foods[i];
    }
    final food = FoodItem(
      id: _newId('f'),
      name: clean,
      photo: photo,
      serving: serving.trim(),
      grams: grams,
      liquid: liquid,
      cookedYield: cookedYield,
      macros: macros,
    );
    foods.add(food);
    _persist();
    notifyListeners();
    return food;
  }

  FoodItem? get shakeFood => foodById(shakeFoodId);

  void setShakeFood(String id) {
    shakeFoodId = foodById(id) == null ? '' : id;
    if (shakeFoodId.isNotEmpty && !shakeFoods.contains(id)) shakeFoods.add(id);
    _persist();
    notifyListeners();
  }

  bool isShakeFood(String id) => shakeFoods.contains(id);

  List<FoodItem> get shakeFoodItems => [for (final f in foodsByUse) if (shakeFoods.contains(f.id)) f];

  void setShakeTag(String id, bool on) {
    if (on) {
      if (foodById(id) == null || shakeFoods.contains(id)) return;
      shakeFoods.add(id);
      if (shakeFood == null) shakeFoodId = id;
    } else {
      if (!shakeFoods.remove(id)) return;
      if (shakeFoodId == id) {
        final rest = shakeFoodItems;
        shakeFoodId = rest.isEmpty ? '' : rest.first.id;
      }
    }
    _persist();
    notifyListeners();
  }

  void deleteFood(String id) {
    final i = foods.indexWhere((f) => f.id == id);
    if (i < 0) return;
    if (shakeFoodId == id) shakeFoodId = '';
    shakeFoods.remove(id);
    favoriteFoods.remove(id);
    final gone = foods.removeAt(i);
    if (gone.photo.isNotEmpty && !isAssetPhoto(gone.photo)) MediaStore.delete(gone.photo);
    _persist();
    notifyListeners();
  }

  Supplement? addSupplement(
    String name, {
    String dose = '',
    String photo = '',
    int? at,
    int days = 0,
    int every = 1,
    DateTime? from,
    DateTime? until,
  }) {
    final clean = name.trim();
    if (clean.isEmpty) return null;
    final s = Supplement(
      id: _newId('s'),
      name: clean,
      dose: dose.trim(),
      photo: photo,
      at: at,
      days: days,
      every: every,
      from: from ?? (every > 1 ? _dayKey(DateTime.now()) : null),
      until: until,
    );
    supplements.add(s);
    syncSupplementReminder();
    _persist();
    notifyListeners();
    return s;
  }

  void updateSupplement(
    String id, {
    String? name,
    String? dose,
    String? photo,
    int? at,
    bool clearAt = false,
    int? days,
    int? every,
    DateTime? from,
    DateTime? until,
    bool clearUntil = false,
  }) {
    final i = supplements.indexWhere((s) => s.id == id);
    if (i < 0) return;
    final old = supplements[i];
    var next = old.copyWith(
      name: name == null || name.trim().isEmpty ? null : name.trim(),
      dose: dose?.trim(),
      photo: photo,
      at: at,
      clearAt: clearAt,
      days: days,
      every: every,
      from: from,
      until: until,
      clearUntil: clearUntil,
    );
    if (next.every > 1 && next.from == null) next = next.copyWith(from: _dayKey(DateTime.now()));
    if (old.photo.isNotEmpty && old.photo != next.photo && !isAssetPhoto(old.photo)) MediaStore.delete(old.photo);
    supplements[i] = next;
    syncSupplementReminder();
    _persist();
    notifyListeners();
  }

  int? supplementTime(Supplement s) => s.at ?? supplementReminderMin;

  List<Supplement> supplementsDueOn(DateTime day) => [for (final s in supplements) if (s.dueOn(day)) s];

  void removeSupplement(String id) {
    final gone = supplements.where((s) => s.id == id).firstOrNull;
    if (gone != null && gone.photo.isNotEmpty && !isAssetPhoto(gone.photo)) MediaStore.delete(gone.photo);
    supplements.removeWhere((s) => s.id == id);
    for (final taken in supplementsTaken.values) {
      taken.remove(id);
    }
    supplementsTaken.removeWhere((_, v) => v.isEmpty);
    syncSupplementReminder();
    _persist();
    notifyListeners();
  }

  void toggleSupplement(String id) {
    final key = _dk(nutritionDay);
    final taken = supplementsTaken.putIfAbsent(key, () => <String>{});
    if (!taken.remove(id)) taken.add(id);
    if (taken.isEmpty) supplementsTaken.remove(key);
    syncSupplementReminder();
    _persist();
    notifyListeners();
  }

  void setSupplementReminder(int? minuteOfDay) {
    supplementReminderMin = minuteOfDay?.clamp(0, 24 * 60 - 1);
    syncSupplementReminder();
    _persist();
    notifyListeners();
  }

  void syncSupplementReminder() {
    if (!nutritionBeta) {
      SupplementReminder.instance.cancel();
      return;
    }
    final now = DateTime.now();
    final today = _dayKey(now);
    final taken = takenOn(today);
    final due = <({DateTime at, List<Supplement> items})>[];
    for (var i = 0; i < 14; i++) {
      final day = shiftDays(today, i);
      final byTime = <int, List<Supplement>>{};
      for (final s in supplements) {
        final at = supplementTime(s);
        if (at == null || !s.dueOn(day) || (i == 0 && taken.contains(s.id))) continue;
        byTime.putIfAbsent(at, () => []).add(s);
      }
      for (final e in byTime.entries) {
        final when = DateTime(day.year, day.month, day.day, e.key ~/ 60, e.key % 60);
        if (when.isAfter(now)) due.add((at: when, items: e.value));
      }
    }
    if (due.isEmpty) {
      SupplementReminder.instance.cancel();
      return;
    }
    due.sort((a, b) => a.at.compareTo(b.at));
    SupplementReminder.instance.schedule([
      for (final d in due)
        (
          at: d.at,
          names: [for (final s in d.items) s.name],
          doses: [for (final s in d.items) if (s.dose.isNotEmpty) '${s.name} ${s.dose}'],
        ),
    ]);
  }

  List<DateTime> get nutritionWeek {
    final start = shiftDays(nutritionDay, -((nutritionDay.weekday - weekStartDay + 7) % 7));
    return [for (var i = 0; i < 7; i++) shiftDays(start, i)];
  }

  double kcalPctOn(DateTime day) {
    final goal = kcalBudgetOn(day);
    return goal <= 0 ? 0 : (totalOn(day).kcal / goal).clamp(0, 1.5).toDouble();
  }

  bool get hasNutritionData =>
      foodLog.isNotEmpty || waterLog.isNotEmpty || foods.isNotEmpty || recipes.isNotEmpty || batches.isNotEmpty;

  void setNutritionDay(DateTime day) {
    final key = _dayKey(day);
    final today = _dayKey(DateTime.now());
    nutritionDay = key.isAfter(today) ? today : key;
    _nutritionSetOn = today;
    notifyListeners();
  }

  void rollNutritionDay() {
    final today = _dayKey(DateTime.now());
    if (_nutritionSetOn == today) return;
    if (nutritionDay == _nutritionSetOn) nutritionDay = today;
    _nutritionSetOn = today;
    notifyListeners();
  }

  void setNutritionBeta(bool on) {
    nutritionBeta = on;
    syncSupplementReminder();
    _persist();
    notifyListeners();
  }

  void goNutrition() {
    if (!nutritionBeta) return;
    nutritionDay = _dayKey(DateTime.now());
    _nutritionSetOn = nutritionDay;
    FoodLibrary.load().then((_) => notifyListeners());
    pushRoute('nutrition');
  }

  void backFromNutrition() => popRoute();

  Map<String, dynamic> nutritionJson() => {
        'foods': foods.map((f) => f.toJson()).toList(),
        'log': foodLog.map((e) => e.toJson()).toList(),
        'water': waterLog.map((w) => w.toJson()).toList(),
        'supps': supplements.map((s) => s.toJson()).toList(),
        'taken': supplementsTaken.map((k, v) => MapEntry(k, v.toList())),
        'goals': nutritionGoals.toJson(),
        'goalsSet': nutritionGoalsSet,
        if (restGoals != null) 'rest': restGoals!.toJson(),
        if (addBurned) 'burned': true,
        if (!nutritionBeta) 'betaOff': true,
        if (useKj) 'kj': true,
        if (!vesselMotion) 'still': true,
        if (weightGoalKg > 0) 'wGoal': weightGoalKg,
        'suppAt': ?supplementReminderMin,
        if (recipes.isNotEmpty) 'recipes': recipes.map((r) => r.toJson()).toList(),
        if (favoriteFoods.isNotEmpty) 'fav': favoriteFoods,
        if (batches.isNotEmpty) 'batches': batches.map((b) => b.toJson()).toList(),
        'meals': mealSlots.map((m) => m.toJson()).toList(),
        if (mealPlans.isNotEmpty) 'plans': mealPlans.map((p) => p.toJson()).toList(),
        if (mealWeek.isNotEmpty) 'planWeek': mealWeek.map((k, v) => MapEntry('$k', v)),
        'trkKnown': [for (final t in Tracker.values) t.name],
        'trackers': [for (final t in Tracker.values) if (trackers.contains(t)) t.name],
        if (shakeFoodId.isNotEmpty) 'shake': shakeFoodId,
        'shakes': shakeFoods,
      };

  void loadNutrition(Map<String, dynamic>? j, {Map<String, String>? restored}) {
    _dropCaches();
    List<Map<String, dynamic>> list(String k) => [
          for (final e in (j?[k] as List?) ?? const [])
            if (e is Map) e.cast<String, dynamic>(),
        ];
    foods
      ..clear()
      ..addAll(list('foods').map(FoodItem.fromJson).where((f) => f.id.isNotEmpty).map((f) {
        if (restored == null || f.photo.isEmpty || isAssetPhoto(f.photo)) return f;
        return f.copyWith(photo: restored[f.photo] ?? '');
      }));
    foodLog
      ..clear()
      ..addAll(list('log').map(FoodEntry.fromJson).where((e) => e.id.isNotEmpty));
    waterLog
      ..clear()
      ..addAll(list('water').map(WaterSip.fromJson).where((w) => w.ml > 0));
    supplements
      ..clear()
      ..addAll(list('supps').map(Supplement.fromJson).where((s) => s.id.isNotEmpty && s.name.isNotEmpty).map((s) {
        if (restored == null || s.photo.isEmpty || isAssetPhoto(s.photo)) return s;
        return s.copyWith(photo: restored[s.photo] ?? '');
      }));
    supplementsTaken.clear();
    final taken = j?['taken'];
    if (taken is Map) {
      final known = {for (final s in supplements) s.id};
      taken.forEach((k, v) {
        if (k is! String || v is! List) return;
        final ids = v.whereType<String>().where(known.contains).toSet();
        if (ids.isNotEmpty) supplementsTaken[k] = ids;
      });
    }
    nutritionGoals = NutritionGoals.fromJson((j?['goals'] as Map?)?.cast<String, dynamic>());
    nutritionGoalsSet = j?['goalsSet'] as bool? ?? false;
    final rest = j?['rest'];
    restGoals = rest is Map ? NutritionGoals.fromJson(rest.cast<String, dynamic>()) : null;
    addBurned = j?['burned'] as bool? ?? false;
    nutritionBeta = !(j?['betaOff'] as bool? ?? false);
    useKj = j?['kj'] as bool? ?? false;
    vesselMotion = !(j?['still'] as bool? ?? false);
    final suppAt = (j?['suppAt'] as num?)?.toInt();
    supplementReminderMin = suppAt?.clamp(0, 24 * 60 - 1);
    final wGoal = (j?['wGoal'] as num?)?.toDouble() ?? 0;
    weightGoalKg = wGoal.isFinite && wGoal > 0 && wGoal < 500 ? wGoal : 0;
    recipes
      ..clear()
      ..addAll(list('recipes').map(Recipe.fromJson).where((r) => r.id.isNotEmpty && r.items.isNotEmpty));
    batches
      ..clear()
      ..addAll(list('batches').map(Batch.fromJson).nonNulls);
    favoriteFoods
      ..clear()
      ..addAll({...((j?['fav'] as List?) ?? const []).whereType<String>()});
    final slots = list('meals').map(MealSlot.fromJson).nonNulls.toList();
    final ids = <String>{};
    mealSlots
      ..clear()
      ..addAll(slots.isEmpty ? kDefaultMeals : slots.where((s) => ids.add(s.meal.id)));
    mealPlans
      ..clear()
      ..addAll(list('plans').map(MealPlan.fromJson).where((p) => p.id.isNotEmpty));
    mealWeek.clear();
    final week = j?['planWeek'];
    if (week is Map) {
      week.forEach((k, v) {
        final day = int.tryParse('$k');
        if (day != null && day >= 1 && day <= 7 && v is String && mealPlans.any((p) => p.id == v)) mealWeek[day] = v;
      });
    }
    trackers.clear();
    final saved = j?['trackers'];
    if (saved is List) {
      final byName = Tracker.values.asNameMap();
      trackers.addAll(saved.whereType<String>().map((n) => byName[n]).nonNulls);
      final knownList = j?['trkKnown'];
      final known = knownList is List
          ? knownList.whereType<String>().toSet()
          : {for (final t in Tracker.values) if (t != Tracker.plans) t.name};
      trackers.addAll(Tracker.values.where((t) => !known.contains(t.name) && !kTrackersOffByDefault.contains(t)));
    } else {
      trackers.addAll(Tracker.values.where((t) => !kTrackersOffByDefault.contains(t)));
    }
    final shake = j?['shake'] as String? ?? '';
    shakeFoodId = foods.any((f) => f.id == shake) ? shake : '';
    final tagged = j?['shakes'];
    shakeFoods
      ..clear()
      ..addAll(tagged is List
          ? {...tagged.whereType<String>().where((id) => foods.any((f) => f.id == id))}
          : [if (shakeFoodId.isNotEmpty) shakeFoodId]);
    if (!shakeFoods.contains(shakeFoodId)) shakeFoodId = shakeFoods.isEmpty ? '' : shakeFoods.first;
    nutritionDay = _dayKey(DateTime.now());
    _nutritionSetOn = nutritionDay;
    syncSupplementReminder();
  }
}
