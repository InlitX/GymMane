extension type const Meal(String id) {
  static const breakfast = Meal('breakfast');
  static const lunch = Meal('lunch');
  static const dinner = Meal('dinner');
  static const snacks = Meal('snacks');
}

class MealSlot {
  const MealSlot(this.meal, {this.name = '', this.from});

  final Meal meal;
  final String name;
  final int? from;

  bool get isDefault => kDefaultMeals.any((m) => m.meal == meal);

  MealSlot copyWith({String? name}) => MealSlot(meal, name: name ?? this.name, from: from);

  Map<String, dynamic> toJson() => {'id': meal.id, if (name.isNotEmpty) 'n': name, 'from': ?from};

  static MealSlot? fromJson(Map<String, dynamic> j) {
    final id = j['id'] as String? ?? '';
    if (id.isEmpty) return null;
    final from = (j['from'] as num?)?.toInt();
    return MealSlot(Meal(id), name: j['n'] as String? ?? '', from: from?.clamp(0, 23));
  }
}

const kDefaultMeals = [
  MealSlot(Meal.breakfast, from: 0),
  MealSlot(Meal.lunch, from: 11),
  MealSlot(Meal.dinner, from: 18),
  MealSlot(Meal.snacks, from: 16),
];

Meal mealForHour(int hour, [List<MealSlot> slots = kDefaultMeals]) {
  MealSlot? best;
  for (final s in slots) {
    final from = s.from;
    if (from == null || from > hour) continue;
    if (best == null || from > best.from!) best = s;
  }
  return (best ?? (slots.isEmpty ? kDefaultMeals.first : slots.first)).meal;
}

enum Amino { his, ile, leu, lys, saa, aaa, thr, trp, val }

const kAminoNeed = [15.0, 30.0, 59.0, 45.0, 22.0, 38.0, 23.0, 6.0, 39.0];

class Macros {
  const Macros({
    this.kcal = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.fiber = 0,
    this.sugar = 0,
    this.sodium = 0,
    this.animal = 0,
    this.sat = 0,
    this.mono = 0,
    this.poly = 0,
    this.aminoProtein = 0,
    this.amino = const [],
  });

  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;
  final double animal;
  final double sat;
  final double mono;
  final double poly;
  final double aminoProtein;
  final List<double> amino;

  static const zero = Macros();

  static List<double> _addAmino(List<double> a, List<double> b) {
    if (a.isEmpty) return b;
    if (b.isEmpty) return a;
    return [for (var i = 0; i < Amino.values.length; i++) a[i] + b[i]];
  }

  Macros operator +(Macros o) => Macros(
    kcal: kcal + o.kcal,
    protein: protein + o.protein,
    carbs: carbs + o.carbs,
    fat: fat + o.fat,
    fiber: fiber + o.fiber,
    sugar: sugar + o.sugar,
    sodium: sodium + o.sodium,
    animal: animal + o.animal,
    sat: sat + o.sat,
    mono: mono + o.mono,
    poly: poly + o.poly,
    aminoProtein: aminoProtein + o.aminoProtein,
    amino: _addAmino(amino, o.amino),
  );

  Macros operator *(double k) => Macros(
    kcal: kcal * k,
    protein: protein * k,
    carbs: carbs * k,
    fat: fat * k,
    fiber: fiber * k,
    sugar: sugar * k,
    sodium: sodium * k,
    animal: animal * k,
    sat: sat * k,
    mono: mono * k,
    poly: poly * k,
    aminoProtein: aminoProtein * k,
    amino: [for (final a in amino) a * k],
  );

  bool get isEmpty => kcal <= 0 && protein <= 0 && carbs <= 0 && fat <= 0;

  bool get hasExtras => fiber > 0 || sugar > 0 || sodium > 0;

  bool get hasFatTypes => sat > 0 || mono > 0 || poly > 0;

  double get plant => (protein - animal).clamp(0, double.infinity).toDouble();

  List<double> get aminoScores => aminoProtein <= 0 || amino.length != Amino.values.length
      ? const []
      : [for (var i = 0; i < amino.length; i++) amino[i] * 1000 / aminoProtein / kAminoNeed[i]];

  double get proteinQuality {
    final s = aminoScores;
    return s.isEmpty ? 0 : s.reduce((a, b) => a < b ? a : b).clamp(0, 1).toDouble();
  }

  Amino? get limitingAmino {
    final s = aminoScores;
    if (s.isEmpty) return null;
    var low = 0;
    for (var i = 1; i < s.length; i++) {
      if (s[i] < s[low]) low = i;
    }
    return s[low] >= 1 ? null : Amino.values[low];
  }

  Map<String, dynamic> toJson() => {
    if (kcal > 0) 'k': kcal,
    if (protein > 0) 'p': protein,
    if (carbs > 0) 'c': carbs,
    if (fat > 0) 'f': fat,
    if (fiber > 0) 'fi': fiber,
    if (sugar > 0) 'su': sugar,
    if (sodium > 0) 'na': sodium,
    if (animal > 0) 'an': animal,
    if (sat > 0) 'sa': sat,
    if (mono > 0) 'mu': mono,
    if (poly > 0) 'po': poly,
    if (aminoProtein > 0 && amino.length == Amino.values.length) ...{
      'ap': aminoProtein,
      'aa': [for (final a in amino) (a * 1000).round() / 1000],
    },
  };

  factory Macros.fromJson(Map<String, dynamic>? j) {
    final aa = [for (final v in (j?['aa'] as List?) ?? const []) _num(v)];
    final ok = aa.length == Amino.values.length;
    return Macros(
      kcal: _num(j?['k']),
      protein: _num(j?['p']),
      carbs: _num(j?['c']),
      fat: _num(j?['f']),
      fiber: _num(j?['fi']),
      sugar: _num(j?['su']),
      sodium: _num(j?['na']),
      animal: _num(j?['an']),
      sat: _num(j?['sa']),
      mono: _num(j?['mu']),
      poly: _num(j?['po']),
      aminoProtein: ok ? _num(j?['ap']) : 0,
      amino: ok ? aa : const [],
    );
  }
}

double _num(Object? v) {
  final n = (v as num?)?.toDouble() ?? 0;
  return n.isFinite && n > 0 ? n : 0;
}

enum PortionKind { unit, slice, scoop, tbsp, tsp, cup, glass }

const kLibraryPrefix = 'a:';
const kDishPrefix = 'd:';

bool isAssetPhoto(String photo) => photo.startsWith('asset:');

String assetOfPhoto(String photo) => photo.substring(6);

enum FoodCat {
  fruit,
  veg,
  meat,
  fish,
  egg,
  dairy,
  grain,
  bakery,
  legume,
  nut,
  oil,
  pantry,
  drink,
  sauce,
  spice,
}

class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    this.photo = '',
    this.serving = '',
    this.grams = 0,
    this.liquid = false,
    this.portion,
    this.portionGrams = 0,
    this.macros = Macros.zero,
    this.cookedYield = 0,
    this.approx = false,
    this.cat,
  });

  final String id;
  final String name;
  final String photo;
  final String serving;
  final double grams;
  final bool liquid;
  final PortionKind? portion;
  final double portionGrams;
  final Macros macros;
  final double cookedYield;
  final bool approx;
  final FoodCat? cat;

  bool get isLibrary => id.startsWith(kLibraryPrefix);

  bool get byWeight => grams > 0;

  bool get canCook => cookedYield > 0 && grams > 0;

  FoodItem copyWith({
    String? name,
    String? photo,
    String? serving,
    double? grams,
    bool? liquid,
    Macros? macros,
    double? cookedYield,
  }) => FoodItem(
    id: id,
    name: name ?? this.name,
    photo: photo ?? this.photo,
    serving: serving ?? this.serving,
    grams: grams ?? this.grams,
    liquid: liquid ?? this.liquid,
    portion: portion,
    portionGrams: portionGrams,
    macros: macros ?? this.macros,
    cookedYield: cookedYield ?? this.cookedYield,
    approx: approx,
    cat: cat,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'n': name,
    if (photo.isNotEmpty) 'ph': photo,
    if (serving.isNotEmpty) 's': serving,
    if (grams > 0) 'g': grams,
    if (liquid) 'lq': true,
    if (cookedYield > 0) 'cy': cookedYield,
    'm': macros.toJson(),
  };

  factory FoodItem.fromJson(Map<String, dynamic> j) => FoodItem(
    id: j['id'] as String? ?? '',
    name: j['n'] as String? ?? '',
    photo: j['ph'] as String? ?? '',
    serving: j['s'] as String? ?? '',
    grams: _num(j['g']),
    liquid: j['lq'] as bool? ?? false,
    cookedYield: _num(j['cy']).clamp(0, 5).toDouble(),
    macros: Macros.fromJson((j['m'] as Map?)?.cast<String, dynamic>()),
  );
}

class FoodEntry {
  const FoodEntry({
    required this.id,
    required this.at,
    required this.meal,
    required this.name,
    this.foodId = '',
    this.servings = 1,
    this.grams = 0,
    this.liquid = false,
    this.cooked = 0,
    this.per = Macros.zero,
  });

  final String id;
  final DateTime at;
  final Meal meal;
  final String name;
  final String foodId;
  final double servings;
  final double grams;
  final bool liquid;
  final double cooked;
  final Macros per;

  Macros get total => per * servings;

  double get totalGrams => grams * servings;

  double get shownGrams => cooked > 0 ? totalGrams * cooked : totalGrams;

  FoodEntry copyWith({String? id, DateTime? at, double? servings, Meal? meal, String? name, Macros? per}) =>
      FoodEntry(
        id: id ?? this.id,
        at: at ?? this.at,
        meal: meal ?? this.meal,
        name: name ?? this.name,
        foodId: foodId,
        servings: servings ?? this.servings,
        grams: grams,
        liquid: liquid,
        cooked: cooked,
        per: per ?? this.per,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'at': at.toIso8601String(),
    'ml': meal.id,
    'n': name,
    if (foodId.isNotEmpty) 'fd': foodId,
    if (servings != 1) 'x': servings,
    if (grams > 0) 'g': grams,
    if (liquid) 'lq': true,
    if (cooked > 0) 'ck': cooked,
    'm': per.toJson(),
  };

  factory FoodEntry.fromJson(Map<String, dynamic> j) => FoodEntry(
    id: j['id'] as String? ?? '',
    at: DateTime.tryParse(j['at'] as String? ?? '') ?? DateTime.now(),
    meal: Meal(j['ml'] as String? ?? Meal.snacks.id),
    name: j['n'] as String? ?? '',
    foodId: j['fd'] as String? ?? '',
    servings: _servings(j['x']),
    grams: _num(j['g']),
    liquid: j['lq'] as bool? ?? false,
    cooked: _num(j['ck']).clamp(0, 5).toDouble(),
    per: Macros.fromJson((j['m'] as Map?)?.cast<String, dynamic>()),
  );
}

double _servings(Object? v) {
  final n = (v as num?)?.toDouble() ?? 1;
  return n.isFinite && n > 0 ? n : 1;
}

class Recipe {
  const Recipe({required this.id, required this.name, required this.items});

  final String id;
  final String name;
  final List<FoodEntry> items;

  Macros get total => items.fold(Macros.zero, (s, e) => s + e.total);

  Recipe copyWith({String? name}) => Recipe(id: id, name: name ?? this.name, items: items);

  Map<String, dynamic> toJson() => {'id': id, 'n': name, 'i': items.map((e) => e.toJson()).toList()};

  factory Recipe.fromJson(Map<String, dynamic> j) => Recipe(
    id: j['id'] as String? ?? '',
    name: j['n'] as String? ?? '',
    items: [
      for (final e in (j['i'] as List?) ?? const [])
        if (e is Map) FoodEntry.fromJson(e.cast<String, dynamic>()),
    ],
  );
}

class MealPlan {
  const MealPlan({required this.id, required this.name, required this.items, this.color = -1});

  final String id;
  final String name;
  final List<FoodEntry> items;
  final int color;

  Macros get total => items.fold(Macros.zero, (s, e) => s + e.total);

  List<FoodEntry> itemsOf(Meal meal) => [
    for (final e in items)
      if (e.meal == meal) e,
  ];

  MealPlan copyWith({String? name, List<FoodEntry>? items, int? color}) =>
      MealPlan(id: id, name: name ?? this.name, items: items ?? this.items, color: color ?? this.color);

  Map<String, dynamic> toJson() => {
    'id': id,
    'n': name,
    if (color >= 0) 'c': color,
    'i': items.map((e) => e.toJson()).toList(),
  };

  factory MealPlan.fromJson(Map<String, dynamic> j) => MealPlan(
    id: j['id'] as String? ?? '',
    name: j['n'] as String? ?? '',
    color: (j['c'] as num?)?.toInt() ?? -1,
    items: [
      for (final e in (j['i'] as List?) ?? const [])
        if (e is Map) FoodEntry.fromJson(e.cast<String, dynamic>()),
    ],
  );
}

class WaterSip {
  const WaterSip(this.at, this.ml);

  final DateTime at;
  final int ml;

  Map<String, dynamic> toJson() => {'at': at.toIso8601String(), 'ml': ml};

  factory WaterSip.fromJson(Map<String, dynamic> j) => WaterSip(
    DateTime.tryParse(j['at'] as String? ?? '') ?? DateTime.now(),
    ((j['ml'] as num?)?.toInt() ?? 0).clamp(0, 5000),
  );
}

class Supplement {
  const Supplement({
    required this.id,
    required this.name,
    this.dose = '',
    this.photo = '',
    this.at,
    this.days = 0,
    this.every = 1,
    this.from,
    this.until,
  });

  final String id;
  final String name;
  final String dose;
  final String photo;
  final int? at;
  final int days;
  final int every;
  final DateTime? from;
  final DateTime? until;

  bool get everyDay => days == 0 && every <= 1;

  bool onWeekday(int weekday) => days == 0 || days & (1 << weekday) != 0;

  bool dueOn(DateTime day) {
    final d = DateTime.utc(day.year, day.month, day.day);
    final start = from == null ? null : DateTime.utc(from!.year, from!.month, from!.day);
    final end = until == null ? null : DateTime.utc(until!.year, until!.month, until!.day);
    if (start != null && d.isBefore(start)) return false;
    if (end != null && d.isAfter(end)) return false;
    if (every > 1) return d.difference(start ?? d).inDays % every == 0;
    return onWeekday(day.weekday);
  }

  Supplement copyWith({
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
  }) => Supplement(
    id: id,
    name: name ?? this.name,
    dose: dose ?? this.dose,
    photo: photo ?? this.photo,
    at: clearAt ? null : (at ?? this.at),
    days: days ?? this.days,
    every: every ?? this.every,
    from: from ?? this.from,
    until: clearUntil ? null : (until ?? this.until),
  );

  static String _date(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static DateTime? _readDate(Object? v) {
    final d = v is String ? DateTime.tryParse(v) : null;
    return d == null ? null : DateTime(d.year, d.month, d.day);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'n': name,
    if (dose.isNotEmpty) 'd': dose,
    if (photo.isNotEmpty) 'p': photo,
    'at': ?at,
    if (days != 0) 'w': days,
    if (every > 1) 'e': every,
    if (from != null) 'f': _date(from!),
    if (until != null) 'u': _date(until!),
  };

  factory Supplement.fromJson(Map<String, dynamic> j) => Supplement(
    id: j['id'] as String? ?? '',
    name: j['n'] as String? ?? '',
    dose: j['d'] as String? ?? '',
    photo: j['p'] as String? ?? '',
    at: (j['at'] as num?)?.toInt().clamp(0, 24 * 60 - 1),
    days: ((j['w'] as num?)?.toInt() ?? 0) & 0xFE,
    every: ((j['e'] as num?)?.toInt() ?? 1).clamp(1, 90),
    from: _readDate(j['f']),
    until: _readDate(j['u']),
  );
}

class NutritionGoals {
  const NutritionGoals({
    this.kcal = 2200,
    this.protein = 140,
    this.carbs = 250,
    this.fat = 70,
    this.waterMl = 2500,
    this.glassMl = 250,
    this.fiber = 30,
    this.sugar = 50,
    this.sodium = 2300,
  });

  final int kcal;
  final int protein;
  final int carbs;
  final int fat;
  final int waterMl;
  final int glassMl;
  final int fiber;
  final int sugar;
  final int sodium;

  int get satLimit => (kcal * 0.1 / 9).round();

  NutritionGoals copyWith({
    int? kcal,
    int? protein,
    int? carbs,
    int? fat,
    int? waterMl,
    int? glassMl,
    int? fiber,
    int? sugar,
    int? sodium,
  }) => NutritionGoals(
    kcal: kcal ?? this.kcal,
    protein: protein ?? this.protein,
    carbs: carbs ?? this.carbs,
    fat: fat ?? this.fat,
    waterMl: waterMl ?? this.waterMl,
    glassMl: glassMl ?? this.glassMl,
    fiber: fiber ?? this.fiber,
    sugar: sugar ?? this.sugar,
    sodium: sodium ?? this.sodium,
  );

  Map<String, dynamic> toJson() => {
    'k': kcal,
    'p': protein,
    'c': carbs,
    'f': fat,
    'w': waterMl,
    'g': glassMl,
    'fi': fiber,
    'su': sugar,
    'na': sodium,
  };

  factory NutritionGoals.fromJson(Map<String, dynamic>? j) {
    const d = NutritionGoals();
    int read(String k, int fallback, int max) {
      final v = (j?[k] as num?)?.toInt();
      return v == null || v <= 0 ? fallback : v.clamp(1, max);
    }

    return NutritionGoals(
      kcal: read('k', d.kcal, 9000),
      protein: read('p', d.protein, 600),
      carbs: read('c', d.carbs, 1500),
      fat: read('f', d.fat, 500),
      waterMl: read('w', d.waterMl, 10000),
      glassMl: read('g', d.glassMl, 2000),
      fiber: read('fi', d.fiber, 200),
      sugar: read('su', d.sugar, 500),
      sodium: read('na', d.sodium, 20000),
    );
  }
}

class Batch {
  const Batch({
    required this.id,
    required this.name,
    required this.items,
    required this.created,
    this.cookedGrams = 0,
    this.leftGrams = 0,
  });

  final String id;
  final String name;
  final List<FoodEntry> items;
  final DateTime created;
  final double cookedGrams;
  final double leftGrams;

  Macros get total => items.fold(Macros.zero, (s, e) => s + e.total);

  double get rawGrams => items.fold(0.0, (s, e) => s + e.totalGrams);

  double get totalGrams => cookedGrams > 0 ? cookedGrams : rawGrams;

  bool get finished => leftGrams <= 0.5;

  double get leftShare => totalGrams <= 0 ? 0 : (leftGrams / totalGrams).clamp(0, 1).toDouble();

  Macros get per100 => totalGrams <= 0 ? Macros.zero : total * (100 / totalGrams);

  Batch copyWith({String? name, List<FoodEntry>? items, double? cookedGrams, double? leftGrams}) => Batch(
    id: id,
    name: name ?? this.name,
    items: items ?? this.items,
    created: created,
    cookedGrams: cookedGrams ?? this.cookedGrams,
    leftGrams: leftGrams ?? this.leftGrams,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'n': name,
    'i': items.map((e) => e.toJson()).toList(),
    'at': created.toIso8601String(),
    if (cookedGrams > 0) 'cg': cookedGrams,
    'left': leftGrams,
  };

  static Batch? fromJson(Map<String, dynamic> j) {
    final id = j['id'] as String? ?? '';
    final items = [
      for (final e in (j['i'] as List?) ?? const [])
        if (e is Map) FoodEntry.fromJson(e.cast<String, dynamic>()),
    ];
    if (id.isEmpty || items.isEmpty) return null;
    final b = Batch(
      id: id,
      name: j['n'] as String? ?? '',
      items: items,
      created: DateTime.tryParse(j['at'] as String? ?? '') ?? DateTime.now(),
      cookedGrams: _num(j['cg']),
    );
    return b.copyWith(leftGrams: _num(j['left']).clamp(0, b.totalGrams).toDouble());
  }
}

enum Tracker {
  calories,
  protein,
  carbs,
  fat,
  fiber,
  animal,
  quality,
  fats,
  sugarSodium,
  water,
  shake,
  supplements,
  weight,
  week,
  prep,
  foods,
  plans,
}

const kTrackersOffByDefault = {
  Tracker.fiber,
  Tracker.animal,
  Tracker.quality,
  Tracker.fats,
  Tracker.sugarSodium,
};
