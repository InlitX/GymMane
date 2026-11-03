
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/app_localizations_ru.dart';

void main() {
  final ru = AppLocalizationsRu();

  test('Russian plurals handle teens and numbers ending in one', () {
    for (final n in [1, 2, 5, 11, 12, 14, 21, 22, 25, 101, 111]) {
      final one = n % 10 == 1 && n % 100 != 11;
      final few = n % 10 >= 2 && n % 10 <= 4 &&
          (n % 100 < 12 || n % 100 > 14);
      final piece = one ? 'штука' : (few ? 'штуки' : 'штук');
      final day = one ? 'день' : (few ? 'дня' : 'дней');
      final food = one ? 'продукт' : (few ? 'продукта' : 'продуктов');
      final copied = one ? 'Скопирован' : (few ? 'Скопированы' : 'Скопировано');
      expect(ru.portionUnit(n), '$n $piece');
      expect(ru.recipeItems(n), '$n $food');
      expect(ru.copiedMealToast(n), '$copied $n $food');
      expect(ru.photoNextIn(n), 'Следующее фото через $n $day');
      expect(ru.lastDoneAgo(n), '$n $day назад');
      expect(ru.suppEveryN(n), 'Раз в $n $day');
      expect(ru.goalDaysLeft(n), '${one ? 'Остался' : 'Осталось'} $n $day');
      expect(ru.progFails(n), '$n ${one ? 'неудачи' : 'неудач'}');
    }
    expect(ru.lastDoneAgo(0), 'Сделано сегодня');
    expect(ru.inRoutines(21), 'В 21 программе');
    expect(ru.sessionsLogged(22), 'записаны 22 тренировки');
  });

  test('Russian meal plans and supplements no longer fall back to English', () {
    expect(ru.mealPlansTitle, 'Планы питания');
    expect(ru.planImported(21), 'Импортирован 21 план');
    expect(ru.planImported(22), 'Импортированы 22 плана');
    expect(ru.planImported(25), 'Импортировано 25 планов');
    expect(ru.planLogged(21), 'Записан 21 продукт');
    expect(ru.savedMealsCount(21), '21 приём пищи');
    expect(ru.suppTakenOf(2, 3), 'Принято: 2 из 3');
    expect(ru.suppDoseHint, '5 г, 2 капсулы…');
  });

  test('corrected advice and terminology retain the intended meaning', () {
    expect(ru.progAmrapHint, contains('прибавка к весу удвоится'));
    expect(ru.addBurnedHint, contains('уже учитывает обычную активность'));
    expect(ru.addBurnedHint, contains('только при сидячем уровне активности'));
    expect(ru.importUnknownFormat, contains('столбцы с датой'));
    expect(ru.planDeleteBody, 'Записи за прошлые дни останутся без изменений.');
    expect(ru.shareRoutine, 'Поделиться программой');
    expect(ru.routineCount(21), '21 программа');
    expect(ru.setTypeRestPause, 'Отдых-пауза');
    expect(ru.mineOnly, 'Созданные тобой');
  });
}
