import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/screens/help_topics.dart';
import 'package:gymmane/screens/settings_screen.dart';
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

    test('la luz al acabar el descanso viene apagada y se recuerda', () {
      expect(fit.restGlow, isFalse);
      fit.toggleRestGlow();
      fit.persistNow();
      fit.loadFromStore();
      expect(fit.restGlow, isTrue);
      expect(fit.toJson()['restGlow'], isTrue);
      fit.resetAllData();
      expect(fit.restGlow, isFalse);
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
      expect(fit.perfLevel, 'balanced');
      fit.setHighRefresh(false);
      expect(fit.perfLevel, 'custom');
      fit.setPerfLevel('lite');
      expect((fit.blurOn, fit.fineOn, fit.highRefresh, fit.calmMotion), (false, false, false, true));
      expect(fit.perfLevel, 'lite');
      fit.setPerfLevel('balanced');
      expect(fit.highRefresh, isTrue, reason: '#427 Equilibrado ya no deja la pantalla a 60 Hz en móviles de 120');
      expect(fit.perfLevel, 'balanced');
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

  group('guía en el buscador', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.nutritionBeta = true;
    });

    for (final lang in ['en', 'es']) {
      test('cada respuesta que lleva a Ajustes apunta a una fila que existe ($lang)', () {
        setAppLanguage(lang);
        final rows = const SettingsScreen().searchRows.toSet();
        final topics = helpTopics();
        expect(topics.map((h) => h.id).toSet().length, topics.length, reason: 'ids repetidos');
        for (final h in topics) {
          if (h.section == null) continue;
          if (h.row == null) {
            expect(rows.any((r) => r.$1 == h.section), isTrue, reason: '${h.id} lleva a ${h.section}');
            continue;
          }
          expect(rows.contains((h.section!, h.row!)), isTrue, reason: '${h.id} lleva a ${h.section} › ${h.row}');
        }
        for (final id in kHelpCommon.where((id) => id != 'steps')) {
          expect(topics.any((h) => h.id == id), isTrue, reason: 'frecuente sin entrada: $id');
        }
        for (final h in topics) {
          expect(h.answer.contains('{'), isFalse, reason: '${h.id} con hueco sin rellenar');
        }
      });
    }

    test('se encuentra preguntando con palabras sueltas, sin tildes ni orden', () {
      setAppLanguage('es');
      final topics = helpTopics();
      List<String> find(String q) => [for (final h in topics) if (h.matches(q)) h.id];
      expect(find('superserie'), contains('superset'));
      expect(find('movil nuevo'), contains('phone'));
      expect(find('lenta'), contains('slow'));
      expect(find('lyfta'), contains('import'));
      expect(find('hevy'), contains('import'));
      expect(find('8-12'), contains('range'));
      expect(find('mancuernas'), contains('pair'));
      expect(find('x'), isEmpty);
      setAppLanguage('en');
    });
  });
}
