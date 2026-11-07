import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/app_localizations_vi.dart';

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
}
