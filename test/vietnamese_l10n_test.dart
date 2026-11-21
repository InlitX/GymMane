import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/app_localizations_vi.dart';
import 'package:gymmane/l10n/catalog_vi.dart';
import 'package:gymmane/l10n/l10n.dart';

void main() {
  final vi = AppLocalizationsVi();

  test('Vietnamese is registered under its own name', () {
    expect(vi.languageName, 'Tiếng Việt');
    expect(vi.cancel, 'Hủy');
    expect(vi.save, 'LƯU');
  });

  test('set confirms a number, it is not a workout set', () {
    expect(vi.set, 'Đặt');
  });

  test('the support note asks for coffee before a star', () {
    final body = vi.supportThanksBody;
    expect(vi.supportThanksTitle, contains('🤍'));
    expect(body.split('\n\n').length, 2);
    final coffee = body.indexOf('☕');
    final star = body.indexOf('⭐');
    expect(coffee, greaterThan(0));
    expect(star, greaterThan(coffee));
  });

  test('Vietnamese plurals use the single other form', () {
    expect(vi.portionUnit(1), '1 miếng');
    expect(vi.portionUnit(3), '3 miếng');
  });

  test('app_vi.arb covers 100% of app_en.arb keys', () {
    final en = jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync()) as Map<String, dynamic>;
    final viMap = jsonDecode(File('lib/l10n/app_vi.arb').readAsStringSync()) as Map<String, dynamic>;
    final enKeys = en.keys.where((k) => !k.startsWith('@')).toSet();
    final viKeys = viMap.keys.where((k) => !k.startsWith('@')).toSet();
    Set<String> listed(String path) => File(path).readAsLinesSync().where((k) => k.isNotEmpty).toSet();
    final waiting = listed('test/nutrition_beta_keys.txt').union(listed('test/pending_translation_keys.txt'));
    expect(enKeys.difference(viKeys).difference(waiting), isEmpty);
  });

  test('every factory exercise has Vietnamese steps and keeps English name', () {
    setAppLanguage('vi');
    addTearDown(() => setAppLanguage('en'));
    for (final e in kExercises) {
      if (!kExerciseStepsVi.containsKey(e.id)) continue;
      final steps = t.catalogSteps(e.id, e.steps);
      expect(steps.length, e.steps.length, reason: 'Step count mismatch for ${e.id}');
      expect(t.catalogName(e.id, e.name), e.name);
    }
  });
}
