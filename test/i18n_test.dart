import 'dart:convert';
import 'dart:io';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/catalog_es.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  tearDown(() => setAppLanguage('en'));

  test('every ARB file in lib/l10n ships as a language of the app', () {
    final arbs = Directory('lib/l10n')
        .listSync()
        .whereType<File>()
        .map((f) => f.uri.pathSegments.last)
        .where((n) => n.startsWith('app_') && n.endsWith('.arb'))
        .map((n) => n.substring(4, n.length - 4))
        .toList()
      ..sort();
    expect(appLanguages.toList()..sort(), arbs);
    for (final code in appLanguages) {
      expect(languageNameOf(code).trim(), isNotEmpty, reason: 'falta languageName en $code');
    }
  });

  test('no key is left untranslated in any shipped language', () {
    Map<String, dynamic> arb(String code) =>
        jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync()) as Map<String, dynamic>;

    final template = arb('en').keys.where((k) => !k.startsWith('@')).toSet();
    for (final code in appLanguages.where((c) => c != 'en')) {
      final keys = arb(code).keys.where((k) => !k.startsWith('@')).toSet();
      expect(template.difference(keys), isEmpty, reason: 'faltan claves en $code');
      expect(keys.difference(template), isEmpty, reason: 'claves de más en $code');
    }
  });

  test('the screens that show an exercise ask the catalogue for its name', () {
    setAppLanguage('es');
    final logged = kExercises.take(30).where((e) => kExerciseNameEs.containsKey(e.id)).toList();
    expect(logged, isNotEmpty);
    for (final e in logged) {
      expect(t.catalogName(e.id, e.name), kExerciseNameEs[e.id],
          reason: 'catalogName es lo que tienen que llamar las pantallas, no e.name');
    }
    expect(fit.personalRecords, isA<List<({String id, String name, double topWeight, double oneRm})>>());
  });

  test('an unknown language falls back to English instead of crashing', () {
    setAppLanguage('xx');
    expect(appLanguage, 'en');
    setAppLanguage('es-419');
    expect(appLanguage, 'es');
  });

  test('a fresh install follows the phone language', () async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.loadFromStore();
    final phone = PlatformDispatcher.instance.locale.languageCode.toLowerCase();
    expect(fit.language, phone == 'es' ? 'es' : 'en');
  });

  test('a chosen language always beats the phone one', () async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.setLanguage('es');
    fit.persistNow();
    fit.loadFromStore();
    expect(fit.language, 'es', reason: 'lo que elige el usuario manda');
    fit.setLanguage('en');
  });

  test('the switch actually changes the language', () {
    fit.setLanguage('es');
    expect(appLanguage, 'es');
    expect(t.startWorkout, 'EMPEZAR');
    fit.setLanguage('en');
    expect(t.startWorkout, 'START WORKOUT');
  });

  test('every key says something different in each language', () {

    final same = <String>[];
    for (final probe in <(String, String Function())>[
      ('startWorkout', () => t.startWorkout),
      ('chooseFocus', () => t.chooseFocus),
      ('finishSession', () => t.finishSession),
      ('bodyweight', () => t.bodyweight),
      ('personalRecords', () => t.personalRecords),
      ('muscleSplit', () => t.muscleSplit),
      ('importBackup', () => t.importBackup),
      ('noRoutines', () => t.noRoutines),
      ('howTo', () => t.howTo),
      ('restOverBody', () => t.restOverBody),
    ]) {
      setAppLanguage('en');
      final en = probe.$2();
      setAppLanguage('es');
      if (probe.$2() == en) same.add(probe.$1);
    }
    expect(same, isEmpty, reason: 'sin traducir al español');
  });

  test('plurals agree in Spanish', () {
    setAppLanguage('es');
    expect(t.exerciseCount(1), '1 ejercicio');
    expect(t.exerciseCount(4), '4 ejercicios');
    expect(t.sessionsLogged(1), '1 sesión registrada');
    expect(t.sessionsLogged(3), '3 sesiones registradas');
    expect(t.streakDays(1), 'racha de 1 día');
    expect(t.streakDays(9), 'racha de 9 días');
    expect(t.setCount(1), '1 serie');
    expect(t.setCount(5), '5 series');
  });

  test('plurals agree in English', () {
    setAppLanguage('en');
    expect(t.exerciseCount(1), '1 exercise');
    expect(t.exerciseCount(4), '4 exercises');
    expect(t.sessionsLogged(1), '1 session logged');
    expect(t.streakDays(1), '1-day streak');
  });

  test('dates read the Spanish way round', () {
    final d = DateTime(2026, 7, 16);
    setAppLanguage('en');
    expect(t.longDate(d), 'Thursday, Jul 16');
    expect(t.shortDate(d), 'Jul 16');
    setAppLanguage('es');
    expect(t.longDate(d), 'Jueves, 16 jul');
    expect(t.shortDate(d), '16 jul');
  });

  test('the week strip uses Spanish initials, and X for Wednesday', () {
    setAppLanguage('en');
    expect([for (var w = 1; w <= 7; w++) t.weekdayInitial(w)], ['M', 'T', 'W', 'T', 'F', 'S', 'S']);
    setAppLanguage('es');

    expect([for (var w = 1; w <= 7; w++) t.weekdayInitial(w)], ['L', 'M', 'X', 'J', 'V', 'S', 'D']);
  });

  test('the whole catalogue vocabulary is translated', () {
    setAppLanguage('es');
    for (final m in kMuscles) {
      expect(t.muscle(m.id), isNot(m.id), reason: 'músculo ${m.id}');
    }
    expect(t.muscle('quads'), 'Cuádriceps');
    expect(t.muscle('hamstrings'), 'Isquiotibiales');
    for (final e in kEquipment) {
      expect(t.equipment(e).trim(), isNotEmpty);
    }
    expect(t.equipment('Barbell'), 'Barra');
    for (final d in kDifficulties) {
      expect(t.difficulty(d).trim(), isNotEmpty);
    }
    expect(t.difficulty('Beginner'), 'Principiante');
  });

  group('catálogo en español', () {
    test('every factory exercise has a Spanish name', () {
      final missing = kExercises.where((e) => !kExerciseNameEs.containsKey(e.id)).map((e) => e.name);
      expect(missing, isEmpty);
    });

    test('the map has no entries for exercises that do not exist', () {
      final ids = kExercises.map((e) => e.id).toSet();
      expect(kExerciseNameEs.keys.where((k) => !ids.contains(k)), isEmpty);
    });

    test('no Spanish name is left in English or empty', () {
      final bad = <String>[];
      kExerciseNameEs.forEach((id, es) {
        if (es.trim().isEmpty) bad.add('$id vacío');
        final en = kExercises.firstWhere((e) => e.id == id).name;
        if (es == en) bad.add('$id sin traducir: "$es"');
      });
      expect(bad, isEmpty);
    });

    test('names follow the active language', () {
      final bench = kExercises.firstWhere((e) => e.id == 'EIeI8Vf');
      setAppLanguage('en');
      expect(exerciseName(bench), 'Barbell Bench Press');
      setAppLanguage('es');
      expect(exerciseName(bench), 'Press de banca con barra');
    });

    test("a user's own exercise is never translated away", () {
      final mine = Exercise(
        id: 'c123', name: 'Mi invento', primary: 'chest', secondary: const [],
        equipment: 'Other', difficulty: 'Beginner', art: '', steps: const [],
      );
      setAppLanguage('es');
      expect(exerciseName(mine), 'Mi invento');
    });

    test('every factory exercise has Spanish steps', () {
      final missing = kExercises.where((e) => !kExerciseStepsEs.containsKey(e.id)).map((e) => e.name);
      expect(missing, isEmpty);
    });

    test('the Spanish steps line up one-to-one with the English ones', () {
      final bad = <String>[];
      for (final e in kExercises) {
        final es = kExerciseStepsEs[e.id];
        if (es == null) continue;
        if (es.length != e.steps.length) bad.add('${e.name}: ${es.length} vs ${e.steps.length}');
        for (final s in es) {
          if (s.trim().isEmpty) bad.add('${e.name}: paso vacío');
        }
      }
      expect(bad, isEmpty);
    });

    test('no step was left in English', () {
      final bad = <String>[];
      for (final e in kExercises) {
        final es = kExerciseStepsEs[e.id];
        if (es == null) continue;
        for (var i = 0; i < es.length && i < e.steps.length; i++) {
          if (es[i] == e.steps[i]) bad.add('${e.name}: "${es[i]}"');
        }
      }
      expect(bad, isEmpty);
    });

    test('steps follow the active language', () {
      final bench = kExercises.firstWhere((e) => e.id == 'EIeI8Vf');
      setAppLanguage('en');
      expect(exerciseSteps(bench), bench.steps);
      setAppLanguage('es');
      expect(exerciseSteps(bench), isNot(bench.steps));
      expect(exerciseSteps(bench).first, contains('Túmbate'));
    });

    test("a user's own exercise keeps its own steps", () {
      final mine = Exercise(
        id: 'c999', name: 'Mío', primary: 'chest', secondary: const [],
        equipment: 'Other', difficulty: 'Beginner', art: '', steps: const ['Mi paso'],
      );
      setAppLanguage('es');
      expect(exerciseSteps(mine), const ['Mi paso']);
    });

    test('no leftover mojibake in the catalogue', () {
      final bad = kExercises.where((e) => e.name.contains('Â') || e.name.contains('�'));
      expect(bad.map((e) => e.name), isEmpty);
    });
  });

  test('every tool is named and described in Spanish', () {
    setAppLanguage('es');
    for (final tool in kToolMeta) {
      expect(t.toolName(tool.id).trim(), isNotEmpty);
      expect(t.toolDesc(tool.id).trim(), isNotEmpty);
      expect(t.toolTitle(tool.id).trim(), isNotEmpty);
    }
    expect(t.toolName('bf'), 'Grasa corporal');
  });

  test("the day's focus follows the language", () {
    fit.sessions.clear();
    setAppLanguage('en');
    expect(['PUSH DAY', 'PULL DAY', 'LEG DAY'], contains(fit.suggestedFocus.title));
    setAppLanguage('es');
    expect(['DÍA DE EMPUJE', 'DÍA DE TIRÓN', 'DÍA DE PIERNA'], contains(fit.suggestedFocus.title));
  });

  test('muscleLabel goes through T, so the whole UI follows', () {
    setAppLanguage('es');
    expect(muscleLabel('chest'), 'Pecho');
    setAppLanguage('en');
    expect(muscleLabel('chest'), 'Chest');
  });

  test('no English strings left hard-coded in the widgets', () {

    final pattern = RegExp(
      r"""(?:Text\(\s*|label:\s*|hintText:\s*|ScreenTitle\(\s*|title:\s*)'([^']{2,})'""",
    );

    bool looksLikeUi(String t) => RegExp(r'^[A-Z]').hasMatch(t) || t.contains(' ');

    const allowed = {'GymMane', 'GYMMANE', 'GYM · MANE', 'M', 'F', 'kg', 'lb', 'cm', 'EN', 'ES'};

    final offenders = <String>[];

    final ui = [Directory('lib/screens'), Directory('lib/widgets'), Directory('lib/app')];
    for (final f in ui.expand((d) => d.listSync(recursive: true)).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      for (final m in pattern.allMatches(src)) {
        final text = m.group(1)!;
        if (text.contains(r'$')) continue;
        if (!RegExp(r'[A-Za-z]{2}').hasMatch(text)) continue;
        if (!looksLikeUi(text)) continue;
        if (allowed.contains(text)) continue;
        offenders.add('${f.uri.pathSegments.last}: "$text"');
      }
    }
    expect(offenders, isEmpty, reason: 'literales sin pasar por T');
  });

  test('no screen keeps its own English calendar', () {
    final offenders = <String>[];
    final ui = [Directory('lib/screens'), Directory('lib/widgets'), Directory('lib/app')];
    for (final f in ui.expand((d) => d.listSync(recursive: true)).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      for (final word in const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Jan', 'Feb', 'Dec']) {
        if (src.contains("'$word'")) offenders.add('${f.uri.pathSegments.last}: "$word"');
      }
    }
    expect(offenders, isEmpty, reason: 'las fechas se piden a t.longDate / t.shortDate / t.weekday');
  });
}
