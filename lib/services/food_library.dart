import 'package:flutter/services.dart';

import '../models/nutrition.dart';

class LibraryFood {
  const LibraryFood({
    required this.id,
    required this.names,
    required this.per100,
    this.liquid = false,
    this.portion,
    this.portionGrams = 0,
    this.cat,
    this.approx = false,
    this.cookedYield = 0,
  });

  final String id;
  final Map<String, String> names;
  final Macros per100;
  final bool liquid;
  final PortionKind? portion;
  final double portionGrams;
  final FoodCat? cat;
  final bool approx;
  final double cookedYield;

  String get slug => id.substring(kLibraryPrefix.length);

  String get asset => 'assets/food/$slug.webp';

  String nameFor(String lang) => names[lang] ?? names[lang.split('_').first] ?? names['en'] ?? '';

  FoodItem item(String lang) => FoodItem(
    id: id,
    name: nameFor(lang),
    photo: 'asset:$asset',
    grams: 100,
    liquid: liquid,
    portion: portion,
    portionGrams: portionGrams,
    macros: per100,
    cookedYield: cookedYield,
    approx: approx,
    cat: cat,
  );
}

class ReadyDish {
  const ReadyDish({required this.id, required this.names, required this.items});

  final String id;
  final Map<String, String> names;
  final List<(String slug, double grams, bool cooked)> items;

  String nameFor(String lang) => names[lang] ?? names[lang.split('_').first] ?? names['en'] ?? '';
}

String foldText(String s) {
  const from = 'áàâäãåąéèêëęíìîïıóòôöõőøúùûüűñńçćčłśşšźżžğýÿёيكةأإآ';
  const to = 'aaaaaaaeeeeeiiiiiooooooouuuuunnccclssszzzgyyеیکهااا';
  final b = StringBuffer();
  for (final r in s.toLowerCase().runes) {
    final c = String.fromCharCode(r);
    final i = from.indexOf(c);
    b.write(i < 0 ? c : to[i]);
  }
  return b.toString();
}

class FoodLibrary {
  FoodLibrary._();

  static final List<LibraryFood> foods = [];
  static final List<ReadyDish> dishes = [];
  static final Map<String, LibraryFood> _byId = {};
  static final Map<String, List<(String, String)>> _folded = {};
  static Future<void>? _loading;

  static bool get ready => foods.isNotEmpty;

  static Future<void> load() => _loading ??= Future.wait([
    rootBundle.loadString('assets/data/foods.tsv').then(parse),
    rootBundle.loadString('assets/data/dishes.tsv').then(parseDishes),
  ]);

  static void parseDishes(String tsv) {
    final lines = tsv.split('\n').where((l) => l.trim().isNotEmpty).toList();
    dishes.clear();
    if (lines.isEmpty) return;
    final head = lines.first.split('\t');
    final items = head.indexOf('items');
    if (items < 0) return;
    for (final line in lines.skip(1)) {
      final c = line.split('\t');
      if (c.length <= items) continue;
      dishes.add(
        ReadyDish(
          id: c[0],
          names: {
            for (var i = 1; i < items; i++)
              if (c[i].isNotEmpty) head[i]: c[i],
          },
          items: [
            for (final part in c[items].split(' '))
              if (part.split(':') case [final slug, final amount] when slug.isNotEmpty)
                (slug, double.tryParse(amount.replaceAll('c', '')) ?? 0, amount.endsWith('c')),
          ],
        ),
      );
    }
  }

  static List<ReadyDish> searchDishes(String query, String lang) {
    final words = foldText(query.trim()).split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    return [
      for (final d in dishes)
        if (words.every('${foldText(d.nameFor(lang))} ${foldText(d.names['en'] ?? '')}'.contains)) d,
    ];
  }

  static void parse(String tsv) {
    final lines = tsv.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.isEmpty) return;
    _folded.clear();
    final head = lines.first.split('\t');
    int col(String k) => head.indexOf(k);
    final langs = {for (final h in head.skip(1).takeWhile((h) => h != 'k')) h: col(h)};
    String cell(List<String> c, String k) {
      final i = col(k);
      return i < 0 || i >= c.length ? '' : c[i];
    }

    double n(List<String> c, String k) => double.tryParse(cell(c, k)) ?? 0;

    final kinds = PortionKind.values.asNameMap();
    final cats = FoodCat.values.asNameMap();
    foods.clear();
    _byId.clear();
    for (final line in lines.skip(1)) {
      final c = line.split('\t');
      if (c.length < 13) continue;
      final aaText = cell(c, 'aa');
      final amino = aaText.isEmpty
          ? const <double>[]
          : [for (final v in aaText.split(',')) double.tryParse(v) ?? 0];
      final hasAmino = amino.length == Amino.values.length;
      final f = LibraryFood(
        id: c[0],
        names: {
          for (final e in langs.entries)
            if (c[e.value].isNotEmpty) e.key: c[e.value],
        },
        per100: Macros(
          kcal: n(c, 'k'),
          protein: n(c, 'p'),
          carbs: n(c, 'c'),
          fat: n(c, 'f'),
          fiber: n(c, 'fi'),
          sugar: n(c, 'su'),
          sodium: n(c, 'na'),
          animal: n(c, 'an'),
          sat: n(c, 'sa'),
          mono: n(c, 'mu'),
          poly: n(c, 'po'),
          aminoProtein: hasAmino ? n(c, 'p') : 0,
          amino: hasAmino ? amino : const [],
        ),
        liquid: cell(c, 'ml').isNotEmpty,
        portion: kinds[cell(c, 'kind')],
        portionGrams: n(c, 'g'),
        cat: cats[cell(c, 'cat')],
        approx: cell(c, 'ax').isNotEmpty,
        cookedYield: n(c, 'cy'),
      );
      foods.add(f);
      _byId[f.id] = f;
    }
  }

  static LibraryFood? byId(String id) => _byId[id];

  static List<LibraryFood> inCat(FoodCat cat) => [
    for (final f in foods)
      if (f.cat == cat) f,
  ];

  static List<LibraryFood> search(String query, String lang, {FoodCat? cat, int limit = 60}) {
    final q = foldText(query.trim());
    if (q.isEmpty) return cat == null ? const [] : inCat(cat).take(limit).toList();
    final words = q.split(RegExp(r'\s+'));
    final starts = RegExp('(^|\\s)${RegExp.escape(words.first)}');
    final folded = _folded[lang] ??= [
      for (final f in foods)
        (foldText(f.nameFor(lang)), '${foldText(f.nameFor(lang))} ${foldText(f.names['en'] ?? '')}'),
    ];
    final scored = <(int, LibraryFood)>[];
    for (var i = 0; i < foods.length; i++) {
      final f = foods[i];
      if (cat != null && f.cat != cat) continue;
      final (name, hay) = folded[i];
      if (!words.every(hay.contains)) continue;
      final score = name == q
          ? 0
          : name.startsWith(q)
          ? 1
          : starts.hasMatch(name)
          ? 2
          : name.contains(words.first)
          ? 3
          : 4;
      scored.add((score * 1000 + name.length, f));
    }
    scored.sort((a, b) => a.$1.compareTo(b.$1));
    return [for (final s in scored.take(limit)) s.$2];
  }
}
