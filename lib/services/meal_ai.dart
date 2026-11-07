import 'dart:math' as math;

import '../models/nutrition.dart';
import 'food_library.dart';

const kMealAiTag = 'gymmane-meal';
const kMealAiVersion = 1;
const kMealAiMaxOptions = 6;
const kMealAiMaxItems = 40;

enum AiSource { library, mine, ai }

enum AiFlag { adjusted, doubtful, noValues, noAmount }

class AiFood {
  AiFood({
    required this.name,
    this.grams,
    this.liquid = false,
    this.count,
    this.kcal,
    this.protein,
    this.carbs,
    this.fat,
    this.fiber,
    this.per100 = false,
    this.meal = '',
  });

  final String name;
  double? grams;
  bool liquid;
  double? count;
  double? kcal;
  double? protein;
  double? carbs;
  double? fat;
  double? fiber;
  bool per100;
  String meal;

  bool get hasMacros => kcal != null || protein != null || carbs != null || fat != null;
}

class AiOption {
  AiOption(this.name, this.meal, this.items);

  final String name;
  final String meal;
  final List<AiFood> items;
}

class AiReply {
  const AiReply(this.options, {this.truncated = false});

  final List<AiOption> options;
  final bool truncated;

  int get itemCount => options.fold(0, (s, o) => s + o.items.length);

  bool get isEmpty => itemCount == 0;
}

class _Lenient {
  _Lenient(this.s, this.i);

  final String s;
  int i;
  bool cut = false;
  int _depth = 0;

  void _skip() {
    while (i < s.length) {
      final c = s.codeUnitAt(i);
      if (c == 0x20 || c == 0x09 || c == 0x0A || c == 0x0D || c == 0xFEFF || c == 0xA0) {
        i++;
        continue;
      }
      if (c == 0x2F && i + 1 < s.length) {
        final n = s[i + 1];
        if (n == '/') {
          while (i < s.length && s[i] != '\n') {
            i++;
          }
          continue;
        }
        if (n == '*') {
          final e = s.indexOf('*/', i + 2);
          i = e < 0 ? s.length : e + 2;
          continue;
        }
      }
      break;
    }
  }

  Object? value() {
    _skip();
    if (i >= s.length) {
      cut = true;
      return null;
    }
    if (++_depth > 40) throw const FormatException('deep');
    try {
      final c = s[i];
      if (c == '{') return _object();
      if (c == '[') return _array();
      if (c == '"' || c == "'") return _string(c);
      return _bare();
    } finally {
      _depth--;
    }
  }

  Map<String, Object?> _object() {
    i++;
    final m = <String, Object?>{};
    while (true) {
      _skip();
      if (i >= s.length) {
        cut = true;
        return m;
      }
      final c = s[i];
      if (c == '}') {
        i++;
        return m;
      }
      if (c == ',') {
        i++;
        continue;
      }
      if (c == ']') throw const FormatException('mismatch');
      final String key;
      if (c == '"' || c == "'") {
        key = _string(c);
      } else {
        final st = i;
        while (i < s.length && RegExp(r'[A-Za-z0-9_\-.$]').hasMatch(s[i])) {
          i++;
        }
        key = s.substring(st, i);
        if (key.isEmpty) throw const FormatException('key');
      }
      _skip();
      if (i >= s.length) {
        cut = true;
        m[key] = null;
        return m;
      }
      if (s[i] != ':') throw const FormatException('colon');
      i++;
      m[key] = value();
      if (cut) return m;
    }
  }

  List<Object?> _array() {
    i++;
    final a = <Object?>[];
    while (true) {
      _skip();
      if (i >= s.length) {
        cut = true;
        return a;
      }
      final c = s[i];
      if (c == ']') {
        i++;
        return a;
      }
      if (c == ',') {
        i++;
        continue;
      }
      if (c == '}') throw const FormatException('mismatch');
      a.add(value());
      if (cut) return a;
    }
  }

  String _string(String q) {
    i++;
    final b = StringBuffer();
    while (i < s.length) {
      final c = s[i];
      if (c == '\\' && i + 1 < s.length) {
        final n = s[i + 1];
        i += 2;
        switch (n) {
          case 'n':
          case 'r':
            b.write(' ');
          case 't':
            b.write(' ');
          case 'u':
            final hex = i + 4 <= s.length ? int.tryParse(s.substring(i, i + 4), radix: 16) : null;
            if (hex != null) {
              b.writeCharCode(hex);
              i += 4;
            }
          default:
            b.write(n);
        }
        continue;
      }
      if (c == q) {
        if (q == "'") {
          var j = i + 1;
          while (j < s.length && (s[j] == ' ' || s[j] == '\n' || s[j] == '\t' || s[j] == '\r')) {
            j++;
          }
          if (j < s.length && ',}]:'.contains(s[j])) {
            i++;
            return b.toString();
          }
          b.write(c);
          i++;
          continue;
        }
        i++;
        return b.toString();
      }
      b.write(c);
      i++;
    }
    cut = true;
    return b.toString();
  }

  static final _number = RegExp(r'^[+-]?(\d+\.?\d*|\.\d+)([eE][+-]?\d+)?$');

  Object? _bare() {
    final st = i;
    while (i < s.length) {
      final c = s[i];
      if (c == ',' || c == '}' || c == ']' || c == '\n' || c == '\r') break;
      i++;
    }
    var t = s.substring(st, i);
    final slash = t.indexOf('//');
    if (slash >= 0) t = t.substring(0, slash);
    t = t.trim();
    if (t.isEmpty) return null;
    switch (t.toLowerCase()) {
      case 'true':
        return true;
      case 'false':
        return false;
      case 'null':
      case 'none':
      case 'nan':
      case 'undefined':
        return null;
    }
    if (_number.hasMatch(t)) return num.tryParse(t);
    return t;
  }
}

String _clean(String raw) => raw
    .replaceAll(RegExp('[​‌‍⁠﻿]'), '')
    .replaceAll(' ', ' ')
    .replaceAll(RegExp('[“”„‟«»]'), '"')
    .replaceAll(RegExp('[‘’‚‛]'), "'");

String _k(String s) => foldText(s).replaceAll(RegExp(r'[^a-z0-9]'), '');

Map<String, Object?> _norm(Map m) => {for (final e in m.entries) _k('${e.key}'): e.value};

Object? _first(Map<String, Object?> nm, List<String> keys) {
  for (final k in keys) {
    final v = nm[k];
    if (v != null) return v;
  }
  return null;
}

const _nameKeys = ['food', 'name', 'n', 'item', 'ingredient', 'alimento', 'nombre', 'ingrediente', 'product', 'producto', 'title'];
const _gramKeys = [
  'grams',
  'gram',
  'g',
  'gr',
  'gramos',
  'amountg',
  'weightg',
  'weight',
  'quantityg',
  'servinggrams',
  'portiong',
  'peso'
];
const _mlKeys = ['ml', 'amountml', 'volumeml', 'millilitres', 'milliliters', 'mililitros'];
const _amountKeys = ['amount', 'quantity', 'cantidad', 'qty', 'portion', 'porcion', 'serving', 'size'];
const _unitKeys = ['unit', 'units', 'unidad'];
const _countKeys = ['count', 'pieces', 'piezas', 'unidades', 'servings', 'numberofunits'];
const _kcalKeys = ['kcal', 'calories', 'calorias', 'cal', 'energy', 'energykcal', 'kilocalories', 'kcals', 'cals'];
const _proteinKeys = ['protein', 'proteins', 'proteina', 'proteinas', 'prot', 'p', 'proteing'];
const _carbKeys = ['carbs', 'carbohydrates', 'carbohydrate', 'carbohidratos', 'hidratos', 'carb', 'c', 'carbsg', 'hidratosdecarbono'];
const _fatKeys = ['fat', 'fats', 'grasa', 'grasas', 'lipids', 'lipidos', 'f', 'fatg'];
const _fiberKeys = ['fiber', 'fibre', 'fibra', 'fiberg'];
const _nestedKeys = ['macros', 'nutrition', 'nutrients', 'nutrientes', 'nutritionalvalues', 'valoresnutricionales', 'totals', 'total', 'values'];
const _per100Keys = ['per100', 'per100g', 'per100grams', 'porcada100g', 'per100ml'];
const _mealKeys = ['meal', 'comida', 'slot', 'mealtype', 'momento'];
const _optionNameKeys = ['name', 'title', 'label', 'nombre', 'option', 'menu', 'plan', 'dish', 'recipe', 'receta', 'idea'];
const _itemsKeys = ['items', 'foods', 'ingredients', 'alimentos', 'ingredientes', 'entries', 'food', 'list', 'contents'];
const _optionsKeys = ['options', 'opciones', 'menus', 'plans', 'planes', 'ideas', 'suggestions', 'recipes', 'recetas', 'dishes', 'platos', 'results', 'variants'];
const _daysKeys = ['meals', 'comidas', 'day', 'dia', 'plan', 'menu', 'schedule'];

double? _numOf(Object? v) {
  if (v is num) {
    final d = v.toDouble();
    return d.isFinite ? d.abs() : null;
  }
  if (v is String) {
    final m = RegExp(r'(\d+(?:[.,]\d+)*)').firstMatch(v);
    if (m == null) return null;
    var t = m.group(1)!;
    if (RegExp(r'^\d{1,3}(,\d{3})+$').hasMatch(t)) {
      t = t.replaceAll(',', '');
    } else if (RegExp(r'^\d{1,3}(\.\d{3})+$').hasMatch(t) && v.contains('.') && !v.contains(',')) {
      t = t.replaceAll('.', '');
    } else {
      t = t.replaceAll(',', '.');
      final dots = '.'.allMatches(t).length;
      if (dots > 1) t = t.replaceFirst('.', '');
    }
    final d = double.tryParse(t);
    return d != null && d.isFinite ? d : null;
  }
  return null;
}

class _Amount {
  const _Amount({this.grams, this.count, this.liquid = false});

  final double? grams;
  final double? count;
  final bool liquid;
}

const _unitGrams = <String, (double, bool)>{
  'kg': (1000, false),
  'kilogram': (1000, false),
  'kilograms': (1000, false),
  'kilo': (1000, false),
  'kilos': (1000, false),
  'g': (1, false),
  'gr': (1, false),
  'grs': (1, false),
  'gram': (1, false),
  'grams': (1, false),
  'gramo': (1, false),
  'gramos': (1, false),
  'mg': (0.001, false),
  'ml': (1, true),
  'cl': (10, true),
  'dl': (100, true),
  'l': (1000, true),
  'lt': (1000, true),
  'liter': (1000, true),
  'litre': (1000, true),
  'litro': (1000, true),
  'litros': (1000, true),
  'oz': (28.35, false),
  'ounce': (28.35, false),
  'ounces': (28.35, false),
  'lb': (453.6, false),
  'lbs': (453.6, false),
  'pound': (453.6, false),
  'pounds': (453.6, false),
  'cup': (240, true),
  'cups': (240, true),
  'taza': (240, true),
  'tazas': (240, true),
  'tbsp': (15, true),
  'tablespoon': (15, true),
  'tablespoons': (15, true),
  'cucharada': (15, true),
  'cucharadas': (15, true),
  'tsp': (5, true),
  'teaspoon': (5, true),
  'teaspoons': (5, true),
  'cucharadita': (5, true),
  'cucharaditas': (5, true),
};

_Amount _amountOf(Object? v, String unitHint) {
  if (v == null) return const _Amount();
  if (v is num) {
    final n = v.toDouble();
    if (!n.isFinite || n <= 0) return const _Amount();
    final u = _unitGrams[_k(unitHint)];
    if (u != null) return _Amount(grams: n * u.$1, liquid: u.$2);
    if (_k(unitHint).isEmpty || _k(unitHint) == 'g') return _Amount(grams: n);
    return _Amount(count: n);
  }
  if (v is! String) return const _Amount();
  final text = foldText(v.replaceAll(',', '.'));
  final unitWord = RegExp(r'(\d+(?:\.\d+)?)\s*(kg|mg|gr|grs|grams?|gramos?|g|ml|cl|dl|litros?|liters?|litres?|lt|l|oz|ounces?|lbs?|pounds?)\b');
  final metric = unitWord.firstMatch(text);
  if (metric != null) {
    final n = double.tryParse(metric.group(1)!) ?? 0;
    final u = _unitGrams[metric.group(2)!];
    if (u != null && n > 0) return _Amount(grams: n * u.$1, liquid: u.$2);
  }
  final loose = RegExp(r'(\d+)\s+(\d+)\s*/\s*(\d+)|(\d+)\s*/\s*(\d+)|(\d+(?:\.\d+)?)\s*([a-z]*)').firstMatch(text);
  if (loose == null) return const _Amount();
  double n;
  String unit = '';
  if (loose.group(1) != null) {
    n = double.parse(loose.group(1)!) + double.parse(loose.group(2)!) / double.parse(loose.group(3)!);
    unit = text.substring(loose.end).trim().split(RegExp(r'\W+')).first;
  } else if (loose.group(4) != null) {
    n = double.parse(loose.group(4)!) / double.parse(loose.group(5)!);
    unit = text.substring(loose.end).trim().split(RegExp(r'\W+')).first;
  } else {
    n = double.parse(loose.group(6)!);
    unit = loose.group(7) ?? '';
  }
  if (!n.isFinite || n <= 0) return const _Amount();
  final u = _unitGrams[unit.isEmpty ? _k(unitHint) : unit];
  if (u != null) return _Amount(grams: n * u.$1, liquid: u.$2);
  if (unit.isEmpty && _k(unitHint).isEmpty) return _Amount(grams: n);
  return _Amount(count: n);
}

bool _isItem(Object? v) {
  if (v is! Map) return false;
  final nm = _norm(v);
  final name = _first(nm, _nameKeys);
  if (name is! String || name.trim().isEmpty) return false;
  final amount = _first(nm, [..._gramKeys, ..._mlKeys, ..._amountKeys, ..._countKeys]);
  final macro = _first(nm, [..._kcalKeys, ..._proteinKeys, ..._carbKeys, ..._fatKeys, ..._nestedKeys, ..._per100Keys]);
  return amount != null || macro != null;
}

Map<String, Object?> _macroSource(Map<String, Object?> nm, {required bool per100}) {
  final out = <String, Object?>{};
  final keys = per100 ? _per100Keys : _nestedKeys;
  for (final k in keys) {
    final v = nm[k];
    if (v is Map) out.addAll(_norm(v));
  }
  return out;
}

AiFood? _food(Object? raw, String defaultMeal) {
  if (raw is! Map) return null;
  final nm = _norm(raw);
  final nameRaw = _first(nm, _nameKeys);
  if (nameRaw is! String) return null;
  final name = nameRaw.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (name.isEmpty) return null;
  final per = _macroSource(nm, per100: true);
  final nested = _macroSource(nm, per100: false);
  final isPer100 = per.isNotEmpty;
  final src = isPer100 ? {...nm, ...per} : {...nm, ...nested};
  double? macro(List<String> keys) => _numOf(_first(src, keys));
  final unitHint = _first(nm, _unitKeys);
  final unit = unitHint is String ? unitHint : '';
  double? grams;
  var liquid = false;
  final g = _first(nm, _gramKeys);
  final ml = _first(nm, _mlKeys);
  final a = _first(nm, _amountKeys);
  double? count;
  if (g != null) {
    final r = _amountOf(g, g is num ? 'g' : unit);
    grams = r.grams;
    liquid = r.liquid;
    count = r.count;
  }
  if (grams == null && ml != null) {
    final r = _amountOf(ml, 'ml');
    grams = r.grams;
    liquid = true;
  }
  if (grams == null && a != null) {
    final r = _amountOf(a, unit);
    grams = r.grams;
    liquid = r.liquid;
    count ??= r.count;
  }
  count ??= _numOf(_first(nm, _countKeys));
  if (grams != null && (grams <= 0 || !grams.isFinite)) grams = null;
  final meal = _first(nm, _mealKeys);
  return AiFood(
    name: name,
    grams: grams,
    liquid: liquid,
    count: count,
    kcal: macro(_kcalKeys),
    protein: macro(_proteinKeys),
    carbs: macro(_carbKeys),
    fat: macro(_fatKeys),
    fiber: macro(_fiberKeys),
    per100: isPer100,
    meal: meal is String && meal.trim().isNotEmpty ? meal.trim() : defaultMeal,
  );
}

List<AiFood> _foods(Object? list, String defaultMeal) {
  final out = <AiFood>[];
  if (list is List) {
    for (final e in list) {
      final f = _food(e, defaultMeal);
      if (f != null) out.add(f);
    }
  } else if (list is Map) {
    for (final e in list.entries) {
      final v = e.value;
      if (v is Map) {
        final f = _food({'name': e.key, ...v}, defaultMeal);
        if (f != null) out.add(f);
      } else if (v is num || v is String) {
        final f = _food({'name': e.key, 'amount': v}, defaultMeal);
        if (f != null) out.add(f);
      }
    }
  }
  return out.take(kMealAiMaxItems).toList();
}

String _optionName(Map<String, Object?> nm) {
  final v = _first(nm, _optionNameKeys);
  return v is String ? v.replaceAll(RegExp(r'\s+'), ' ').trim() : '';
}

bool _looksLikeItems(Object? v) {
  if (v is List) return v.any(_isItem);
  if (v is Map) {
    return v.values.any((e) => e is Map && _isItem({'name': 'x', ...e})) ||
        v.values.any((e) => e is num && e > 0);
  }
  return false;
}

List<AiOption> _byMeal(Map<String, Object?> m, String name) {
  final items = <AiFood>[];
  for (final e in m.entries) {
    final v = e.value;
    if (v is List && _looksLikeItems(v)) {
      items.addAll(_foods(v, e.key.trim()));
    } else if (v is Map) {
      final nm = _norm(v);
      final inner = _first(nm, _itemsKeys);
      if (inner != null && _looksLikeItems(inner)) items.addAll(_foods(inner, e.key.trim()));
    }
  }
  return items.isEmpty ? const [] : [AiOption(name, '', items.take(kMealAiMaxItems * 2).toList())];
}

List<AiOption> _find(Object? node, int depth) {
  if (depth > 6) return const [];
  if (node is List) {
    if (node.any(_isItem)) return [AiOption('', '', _foods(node, ''))];
    final out = <AiOption>[];
    for (final e in node) {
      if (e is Map || e is List) out.addAll(_find(e, depth + 1));
    }
    return out;
  }
  if (node is! Map) return const [];
  final nm = _norm(node);
  final name = _optionName(nm);
  final meal = _first(nm, _mealKeys);
  final defaultMeal = meal is String ? meal.trim() : '';
  final inner = _first(nm, _itemsKeys);
  if (inner != null && _looksLikeItems(inner)) {
    return [AiOption(name, defaultMeal, _foods(inner, defaultMeal))];
  }
  for (final k in _optionsKeys) {
    final v = nm[k];
    if (v is List || v is Map) {
      final found = v is Map && _looksLikeItems(v) ? [AiOption(name, defaultMeal, _foods(v, defaultMeal))] : _find(v, depth + 1);
      if (found.isNotEmpty) return found;
    }
  }
  for (final k in _daysKeys) {
    final v = nm[k];
    if (v is Map) {
      final day = _byMeal(v.map((a, b) => MapEntry('$a', b)), name);
      if (day.isNotEmpty) return day;
    } else if (v is List) {
      final found = _find(v, depth + 1);
      if (found.isNotEmpty) return found;
    }
  }
  final direct = _byMeal(node.map((a, b) => MapEntry('$a', b)), name);
  if (direct.isNotEmpty) return direct;
  if (_isItem(node)) return [AiOption('', '', _foods([node], ''))];
  for (final v in nm.values) {
    if (v is Map || v is List) {
      final found = _find(v, depth + 1);
      if (found.isNotEmpty) return found;
    }
  }
  return const [];
}

List<(Object?, bool)> _candidates(String text, String open) {
  final out = <(Object?, bool)>[];
  var i = 0;
  while (i < text.length) {
    final at = text.indexOf(open, i);
    if (at < 0) break;
    final p = _Lenient(text, at);
    try {
      final v = p.value();
      final real = v is Map ? v.isNotEmpty : v is List && v.isNotEmpty;
      if (real) out.add((v, p.cut));
      i = math.max(p.i, at + 1);
    } on FormatException {
      i = at + 1;
    }
  }
  return out;
}

AiReply parseMealAi(String raw) {
  final text = _clean(raw);
  var best = const AiReply([]);
  final all = [..._candidates(text, '{'), ..._candidates(text, '[')];
  final loose = <AiFood>[];
  var looseCut = false;
  for (final (v, cut) in all) {
    if (_isItem(v)) {
      final f = _food(v, '');
      if (f != null) {
        loose.add(f);
        looseCut = looseCut || cut;
      }
      continue;
    }
    final options = _find(v, 0).where((o) => o.items.isNotEmpty).take(kMealAiMaxOptions).toList();
    if (options.isEmpty) continue;
    final reply = AiReply(options, truncated: cut);
    if (reply.itemCount > best.itemCount) best = reply;
  }
  if (loose.length > best.itemCount) {
    best = AiReply([AiOption('', '', loose.take(kMealAiMaxItems).toList())], truncated: looseCut);
  }
  return best;
}

class AiDraft {
  AiDraft({required this.entry, required this.source, this.flags = const {}, this.on = true});

  FoodEntry entry;
  final AiSource source;
  final Set<AiFlag> flags;
  bool on;

  String get name => entry.name;

  Macros get total => entry.total;

  bool get usable => !flags.contains(AiFlag.noValues);

  bool get risky => flags.contains(AiFlag.doubtful);

  double get shownGrams => entry.shownGrams;

  void scaleTo(double grams) {
    final now = entry.shownGrams;
    if (now <= 0 || grams <= 0) return;
    final k = grams / now;
    entry = source == AiSource.ai
        ? FoodEntry(
            id: entry.id,
            at: entry.at,
            meal: entry.meal,
            name: entry.name,
            servings: entry.servings,
            grams: entry.grams * k,
            liquid: entry.liquid,
            per: entry.per * k,
            water: entry.water,
          )
        : entry.copyWith(servings: entry.servings * k);
  }
}

class AiDraftOption {
  AiDraftOption(this.name, this.items);

  final String name;
  final List<AiDraft> items;

  List<AiDraft> get chosen => [for (final d in items) if (d.on && d.usable) d];

  Macros get total => chosen.fold(Macros.zero, (s, d) => s + d.total);
}

const _cookedWords = {
  'cooked', 'boiled', 'grilled', 'roasted', 'baked', 'steamed', 'fried', 'cocido', 'cocida', 'cocidos', 'cocidas', 'hervido',
  'hervida', 'hervidos', 'asado', 'asada', 'plancha', 'horneado', 'horneada', 'cuit', 'cuite', 'gekocht', 'cotto', 'cotta',
  'cozido', 'cozida',
};

const _noiseWords = {
  'fresh', 'plain', 'natural', 'raw', 'organic', 'large', 'medium', 'small', 'sliced', 'chopped', 'diced', 'homemade',
  'boneless', 'skinless', 'ripe', 'whole', 'the', 'a', 'an', 'of', 'de', 'la', 'el', 'con', 'with', 'and', 'y',
  ..._cookedWords,
};

List<String> _tokens(String s) => [
      for (final w in s.split(RegExp('[^a-z0-9\u0400-\u04FF\u0600-\u06FF\u3040-\u30FF\u4E00-\u9FFF\uAC00-\uD7AF]+')))
        if (w.isNotEmpty) w
    ];

String _singular(String w) {
  if (w.length > 4 && w.endsWith('ies')) return '${w.substring(0, w.length - 3)}y';
  if (w.length > 4 && w.endsWith('es') && !w.endsWith('ses')) return w.substring(0, w.length - 2);
  if (w.length > 3 && w.endsWith('s') && !w.endsWith('ss')) return w.substring(0, w.length - 1);
  return w;
}

List<String> _variants(String raw) {
  var s = foldText(raw);
  s = s.replaceAll(RegExp(r'[\(\[].*?[\)\]]'), ' ');
  s = s.replaceFirst(RegExp(r'^\s*\d+([.,]\d+)?\s*(x|g|ml)?\s+'), '');
  final parts = s.split(',').map((p) => p.trim()).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return const [];
  final full = _tokens(parts.join(' '));
  final head = _tokens(parts.first);
  final seen = <String>{};
  final out = <String>[];
  void add(List<String> words) {
    final v = words.join(' ');
    if (v.isNotEmpty && seen.add(v)) out.add(v);
  }

  add(full);
  add(head);
  final cleanFull = [for (final w in full) if (!_noiseWords.contains(w)) w];
  final cleanHead = [for (final w in head) if (!_noiseWords.contains(w)) w];
  add(cleanFull);
  add(cleanHead);
  for (final base in [full, head, cleanFull, cleanHead]) {
    add([for (final w in base) _singular(w)]);
  }
  return out;
}

bool _isCooked(String name) => _tokens(foldText(name)).any(_cookedWords.contains);

double _similarity(List<String> query, String candidate) {
  final cand = _tokens(foldText(candidate));
  if (cand.isEmpty || query.isEmpty) return 0;
  if (cand.join(' ') == query.join(' ')) return 1;
  for (final q in query) {
    if (!cand.any((c) => c == q || (q.length >= 4 && c.startsWith(q)) || _singular(c) == _singular(q))) return 0;
  }
  return query.length / cand.length;
}

class _Hit {
  const _Hit(this.library, this.own, this.score);

  final LibraryFood? library;
  final FoodItem? own;
  final double score;
}

_Hit? _match(String name, String lang, List<FoodItem> own) {
  final variants = _variants(name);
  _Hit? best;
  for (final v in variants) {
    final q = _tokens(v);
    for (final f in own) {
      if (f.grams <= 0) continue;
      final s = _similarity(q, f.name);
      if (s >= 0.6 && (best == null || s > best.score)) best = _Hit(null, f, s + 0.05);
    }
  }
  if (best != null && best.score >= 0.95) return best;
  for (final v in variants) {
    final q = _tokens(v);
    for (final lf in FoodLibrary.search(v, lang, limit: 10)) {
      final s = math.max(_similarity(q, lf.nameFor(lang)), _similarity(q, lf.names['en'] ?? ''));
      if (s >= 0.34 && (best == null || s > best.score)) best = _Hit(lf, null, s);
    }
    if (best != null && best.score >= 0.95) break;
  }
  return best;
}

Meal _mealFor(String raw, List<MealSlot> slots, Meal fallback) {
  final k = _k(raw);
  if (k.isEmpty) return fallback;
  for (final s in slots) {
    if (_k(s.meal.id) == k || (s.name.isNotEmpty && _k(s.name) == k)) return s.meal;
  }
  Meal? pick(Meal m) => slots.any((s) => s.meal == m) ? m : null;
  if (RegExp(r'break|desay|morning|manana|fruhstuck|petitdej|colazione|cafe').hasMatch(k)) return pick(Meal.breakfast) ?? fallback;
  if (RegExp(r'lunch|almuerzo|comida|mittag|dejeuner|pranzo|midday').hasMatch(k)) return pick(Meal.lunch) ?? fallback;
  if (RegExp(r'dinner|cena|supper|abend|diner|souper').hasMatch(k)) return pick(Meal.dinner) ?? fallback;
  if (RegExp(r'snack|merienda|tentempie|colacion|aperitivo|brunch|postre|dessert|pre|post').hasMatch(k)) {
    return pick(Meal.snacks) ?? fallback;
  }
  return fallback;
}

Macros _aiMacros(AiFood f, double? grams, Set<AiFlag> flags) {
  var kcal = f.kcal, p = f.protein, c = f.carbs, fat = f.fat, fi = f.fiber;
  if (f.per100) {
    final k = (grams ?? 100) / 100;
    kcal = kcal == null ? null : kcal * k;
    p = p == null ? null : p * k;
    c = c == null ? null : c * k;
    fat = fat == null ? null : fat * k;
    fi = fi == null ? null : fi * k;
  }
  final given = [p, c, fat].where((e) => e != null).length;
  final derived = (p ?? 0) * 4 + (c ?? 0) * 4 + (fat ?? 0) * 9;
  if (kcal == null && given >= 2) {
    kcal = derived;
  } else if (kcal != null && given == 3 && (kcal - derived).abs() > math.max(35, derived * 0.25)) {
    kcal = derived;
    flags.add(AiFlag.adjusted);
  }
  if (kcal == null && given == 1) {
    flags.add(AiFlag.noValues);
    return Macros.zero;
  }
  if (kcal == null || kcal <= 0 && given == 0) {
    flags.add(AiFlag.noValues);
    return Macros.zero;
  }
  p ??= 0;
  c ??= 0;
  fat ??= 0;
  final weight = grams ?? 0;
  if (weight > 0) {
    if (p + c + fat > weight * 1.08 + 2 || kcal > weight * 9.5 + 5 || kcal > 4000) flags.add(AiFlag.doubtful);
    if (weight > 3000) flags.add(AiFlag.doubtful);
  } else if (kcal > 2500) {
    flags.add(AiFlag.doubtful);
  }
  return Macros(kcal: kcal, protein: p, carbs: c, fat: fat, fiber: fi ?? 0);
}

AiDraft _draft(AiFood f, Meal meal, String lang, List<FoodItem> own, DateTime now) {
  final flags = <AiFlag>{};
  var grams = f.grams;
  final hit = _match(f.name, lang, own);
  if (hit != null) {
    final lib = hit.library;
    final mine = hit.own;
    final item = lib?.item(lang) ?? mine!;
    if (grams == null && f.count != null && item.portionGrams > 0) grams = f.count! * item.portionGrams;
    if (grams == null && f.count != null && mine != null && mine.grams > 0) grams = f.count! * mine.grams;
    if (grams != null && grams > 0 && item.grams > 0) {
      final cooked = item.canCook && _isCooked(f.name);
      final perGram = cooked ? grams / item.cookedYield : grams;
      final entry = FoodEntry(
        id: '',
        at: now,
        meal: meal,
        name: item.name,
        foodId: item.id,
        servings: perGram / item.grams,
        grams: item.grams,
        liquid: item.liquid,
        cooked: cooked ? item.cookedYield : 0,
        per: item.macros,
        water: item.water,
      );
      var agrees = true;
      final probe = <AiFlag>{};
      final ai = f.hasMacros ? _aiMacros(f, grams, probe) : Macros.zero;
      if (ai.kcal > 0 && entry.total.kcal > 0) {
        final ratio = ai.kcal / entry.total.kcal;
        final gap = (ai.kcal - entry.total.kcal).abs();
        agrees = !((ratio < 0.55 || ratio > 1.8) && gap > 40);
      }
      if (agrees) {
        return AiDraft(entry: entry, source: lib != null ? AiSource.library : AiSource.mine, flags: const {});
      }
    }
  }
  final macros = f.hasMacros ? _aiMacros(f, grams, flags) : Macros.zero;
  if (!f.hasMacros) flags.add(AiFlag.noValues);
  if (grams == null && !flags.contains(AiFlag.noValues)) flags.add(AiFlag.noAmount);
  final amount = grams ?? 0;
  final name = f.name.replaceAll(RegExp(r'\s+'), ' ').trim();
  final shown = name.length > 60 ? name.substring(0, 60) : name;
  final entry = FoodEntry(
    id: '',
    at: now,
    meal: meal,
    name: shown.isEmpty ? shown : '${shown[0].toUpperCase()}${shown.substring(1)}',
    grams: amount,
    liquid: f.liquid,
    per: macros,
  );
  final off = flags.contains(AiFlag.doubtful) || flags.contains(AiFlag.noValues);
  return AiDraft(entry: entry, source: AiSource.ai, flags: flags, on: !off);
}

List<AiDraftOption> resolveMealAi(
  AiReply reply, {
  required String lang,
  required Meal meal,
  required List<MealSlot> slots,
  bool day = false,
  List<FoodItem> own = const [],
  DateTime? now,
}) {
  final at = now ?? DateTime.now();
  final out = <AiDraftOption>[];
  for (final option in reply.options) {
    final items = <AiDraft>[];
    for (final f in option.items) {
      final target = day ? _mealFor(f.meal.isNotEmpty ? f.meal : option.meal, slots, meal) : meal;
      items.add(_draft(f, target, lang, own, at));
    }
    if (items.isNotEmpty) out.add(AiDraftOption(option.name, items));
  }
  return out;
}

class MealAiBrief {
  const MealAiBrief({
    required this.language,
    required this.day,
    required this.mealId,
    required this.mealLabel,
    required this.slots,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.options,
    this.tags = const [],
    this.notes = '',
    this.eaten = const [],
  });

  final String language;
  final bool day;
  final String mealId;
  final String mealLabel;
  final List<(String id, String label)> slots;
  final int kcal;
  final int protein;
  final int carbs;
  final int fat;
  final int options;
  final List<String> tags;
  final String notes;
  final List<String> eaten;
}

const mealAiRetrySentence =
    'Send your last answer again as ONLY the JSON object, inside one ```json code block, using exactly the format from my first message. No text before it and none after it.';

String buildMealAiPrompt(MealAiBrief b) {
  final ids = [for (final s in b.slots) s.$1];
  final mealList = [for (final s in b.slots) '"${s.$1}" (${s.$2})'].join(', ');
  final firstMeal = b.day ? (ids.contains('breakfast') ? 'breakfast' : ids.first) : b.mealId;
  final secondMeal = b.day ? (ids.contains('lunch') ? 'lunch' : ids.last) : b.mealId;
  final what = b.day
      ? 'a full day of eating, spread over these meals: $mealList'
      : 'ONE meal only: ${b.mealLabel} (id "${b.mealId}")';
  final lines = <String>[
    'You are the nutrition assistant of GymMane, an offline fitness app. A program, not a person, will read your reply, so the format below is strict.',
    '',
    'REQUEST',
    '- I want $what.',
    '- Target for ${b.day ? 'the whole day' : 'this meal'}: about ${b.kcal} kcal, ${b.protein} g protein, ${b.carbs} g carbs and ${b.fat} g fat. Stay within 10% of the calories. Protein matters most.',
    '- Give ${b.options} different option${b.options == 1 ? '' : 's'}${b.options == 1 ? '' : ', each one a complete alternative that could replace the others'}.',
    '- Write food names and option names in ${b.language}.',
    if (b.tags.isNotEmpty) '- Style: ${b.tags.join(', ')}.',
    if (b.notes.trim().isNotEmpty) '- My notes (obey them, they may list foods I have at home, dislikes and allergies): ${b.notes.trim().replaceAll(RegExp(r'\s+'), ' ')}',
    if (b.eaten.isNotEmpty) '- Already eaten today (do not repeat them, vary the foods): ${b.eaten.join(', ')}.',
    '',
    'FORMAT RULES (follow every one)',
    '1. Reply with exactly one JSON object inside one ```json code block. Nothing before it, nothing after it: no greeting, no explanation, no notes, no markdown outside the block.',
    '2. Use exactly the keys shown in the example. Keep "gymmane" as "$kMealAiTag" and "v" as $kMealAiVersion.',
    '3. One entry in "items" per food or ingredient. Split mixed dishes into their ingredients (for example "Rice, cooked" and "Chicken breast, grilled").',
    '4. "grams" is the weight in grams of that item (for liquids, the volume in millilitres). Always a plain number, never a range.',
    '5. "kcal", "protein", "carbs" and "fat" are the TOTAL for the amount in "grams", not per 100 g. Plain numbers only: dot as decimal separator, no units, no quotes. Protein, carbs and fat are in grams. kcal must be close to 4 x protein + 4 x carbs + 9 x fat.',
    '6. Use simple, common, generic food names (for example "Greek yogurt", "Rolled oats", "Banana", "Olive oil"). No brands, no adjectives, no cooking instructions inside the name. Add "cooked" or "grilled" to the name only when the weight is the cooked weight.',
    '7. Use realistic amounts that a person can weigh at home. Do not put the same food twice in one option.',
    '8. "meal" is one of these ids: ${ids.map((e) => '"$e"').join(', ')}.${b.day ? ' Spread the foods across the meals.' : ' Use "${b.mealId}" for every item.'}',
    '9. Do not use web search, tools or code. Do not ask me questions. If something is unclear, choose a sensible default.',
    '10. Before you reply, check that the JSON is valid and that every item has "food", "grams", "kcal", "protein", "carbs", "fat" and "meal".',
    '',
    'EXAMPLE OF A VALID REPLY (the foods and numbers are only an illustration)',
    '```json',
    '{',
    '  "gymmane": "$kMealAiTag",',
    '  "v": $kMealAiVersion,',
    '  "options": [',
    '    {',
    '      "name": "Yogurt with walnuts",',
    '      "items": [',
    '        {"food": "Greek yogurt", "grams": 170, "kcal": 100, "protein": 17, "carbs": 6.1, "fat": 0.7, "meal": "$firstMeal"},',
    '        {"food": "Walnuts", "grams": 15, "kcal": 98, "protein": 2.3, "carbs": 2.1, "fat": 9.8, "meal": "$secondMeal"}',
    '      ]',
    '    }',
    '  ]',
    '}',
    '```',
    '',
    'If you cannot follow these rules, reply with {"gymmane": "$kMealAiTag", "v": $kMealAiVersion, "options": []}.',
  ];
  return lines.join('\n');
}
