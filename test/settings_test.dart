import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/app_localizations.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/rest_alarm.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#181 negro AMOLED', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('es un tema oscuro aparte y se recuerda', () {
      fit.setThemePref('amoled');
      expect(fit.dark, isTrue);
      expect(fit.themeMode, ThemeMode.dark);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.themePref, 'amoled');
      fit.setThemePref('dark');
      expect(fit.themePref, 'dark');
    });
  });

  group('#206 fotos tapadas en Progreso', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('se recuerda al reiniciar', () {
      expect(fit.hideShots, isFalse);
      fit.toggleHideShots();
      fit.persistNow();
      fit.hideShots = false;
      fit.loadFromStore();
      expect(fit.hideShots, isTrue);
      fit.resetAllData();
      expect(fit.hideShots, isFalse);
    });
  });

  group('settings', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    test('the theme can follow the phone and older backups still load', () {
      fit.setThemePref('system');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.themePref, 'system');
      fit.applyBackup({'dark': false});
      expect(fit.themePref, 'light');
      fit.setThemePref('dark');
    });

    test('the rest alarm style is kept and handed to the alarm', () {
      fit.setAlarmStyle('vibrate');
      expect(RestAlarm.instance.style, 'vibrate');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.alarmStyle, 'vibrate');
      fit.setAlarmStyle('loud');
    });

    test('height reads in feet and inches for imperial users', () {
      fit.setUnits('lb');
      expect(fit.heightLabel(175), '5′ 9″');
      fit.setUnits('kg');
      expect(fit.heightLabel(175), '175 cm');
    });
  });

  group('tamaño del texto y animaciones', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    test('se eligen, se recuerdan y lo raro no entra', () {
      expect(fit.textFactor, 1.0);
      fit.setTextSize('large');
      fit.setTextSize('giant');
      fit.setCalmMotion(true);
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.textSize, 'large');
      expect(fit.textFactor, greaterThan(1));
      expect(fit.calmMotion, isTrue);
    });

    test('#307 los niveles de rendimiento mueven cada parte y tocar una lo deja personalizado', () {
      fit.maxRefresh = 120;
      fit.setPerfLevel('max');
      expect((fit.blurOn, fit.fineOn, fit.highRefresh, fit.calmMotion), (true, true, true, false));
      expect(fit.perfLevel, 'max');
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.perfLevel, 'max');
      fit.setFine(false);
      expect(fit.perfLevel, 'custom');
      fit.setPerfLevel('lite');
      expect((fit.blurOn, fit.fineOn, fit.highRefresh, fit.calmMotion), (false, false, false, true));
      expect(fit.perfLevel, 'lite');
      fit.maxRefresh = 60;
      fit.setPerfLevel('max');
      fit.setHighRefresh(false);
      expect(fit.perfLevel, 'max', reason: 'sin pantalla rápida, Máximo no depende de los Hz');
      fit.setPerfLevel('balanced');
      expect(fit.perfLevel, 'balanced');
    });
  });

  group('#92 inicio de semana', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.setUnits('kg');
    });

    tearDown(() {
      if (fit.session != null) fit.saveAndExit();
    });

    test('empezar en domingo mueve toda la semana', () {
      fit.setWeekStart(DateTime.sunday);
      expect(fit.weekStartDate.weekday, DateTime.sunday);
      expect(fit.weekdayAt(0), DateTime.sunday);
      expect(fit.dateForWeekday(fit.todayIndex).day, DateTime.now().day);
    });

    test('se guarda con el resto de ajustes', () {
      fit.setWeekStart(DateTime.saturday);
      expect(fit.toJson()['weekStart'], DateTime.saturday);
      fit.setWeekStart(4);
      expect(fit.weekStartDay, DateTime.saturday, reason: 'solo lunes, sábado o domingo');
    });
  });

  test('el texto de Apoyo pide primero el café y luego la estrella, en todos los idiomas', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final t = lookupAppLocalizations(locale);
      final body = t.supportThanksBody;
      expect(t.supportThanksTitle, contains('🤍'), reason: '$locale');
      expect(body.split('\n\n').length, 2, reason: '$locale: dos párrafos');
      final coffee = body.indexOf('☕'), star = body.indexOf('⭐');
      expect(coffee, greaterThan(0), reason: '$locale');
      expect(star, greaterThan(coffee), reason: '$locale: la estrella va después del café');
    }
  });
}
