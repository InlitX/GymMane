import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app_localizations.dart';
import 'catalog_es.dart';
import 'catalog_zh.dart';

export 'app_localizations.dart';

const Map<String, Map<String, String>> _catalogNames = {'es': kExerciseNameEs, 'zh': kExerciseNameZh};
const Map<String, Map<String, List<String>>> _catalogSteps = {'es': kExerciseStepsEs, 'zh': kExerciseStepsZh};

String appLanguage = 'en';
AppLocalizations t = lookupAppLocalizations(const Locale('en'));

List<String> get appLanguages =>
    AppLocalizations.supportedLocales.map((l) => l.languageCode).toList();

String languageNameOf(String code) => lookupAppLocalizations(Locale(code)).languageName;

String resolveLanguage(String code) {
  final base = code.toLowerCase().split(RegExp('[-_]')).first;
  return appLanguages.contains(base) ? base : 'en';
}

void setAppLanguage(String code) {
  appLanguage = resolveLanguage(code);
  t = lookupAppLocalizations(Locale(appLanguage));
  Intl.defaultLocale = appLanguage;
}

bool _dateSymbolsReady = false;

DateFormat _dates(DateFormat Function(String locale) build) {
  if (!_dateSymbolsReady) {
    initializeDateFormatting();
    _dateSymbolsReady = true;
  }
  return build(appLanguage);
}

extension GymL10n on AppLocalizations {
  String finishHeadline({required int prs, required int streak, required bool goalHit}) {
    if (prs > 0) return finishHeadlinePr;
    if (goalHit) return finishHeadlineGoal;
    if (streak >= 3) return finishHeadlineStreak;
    return finishHeadlineDefault;
  }

  String finishBody({required int prs, required int streak, required bool goalHit}) {
    if (prs > 0) return finishBodyPr(prs);
    if (goalHit) return finishBodyGoal;
    if (streak >= 3) return finishBodyStreak(streak);
    return finishBodyDefault;
  }

  String vsLastMonth(int pct) => vsLastMonthLabel('${pct >= 0 ? '+' : ''}$pct');

  String levelStreak(int level, int streak) => levelStreakLabel(level, streakDays(streak));

  String toolName(String id) => switch (id) {
        'rm' => toolNameRm,
        'bmi' => toolNameBmi,
        'cal' => toolNameCal,
        'bf' => toolNameBf,
        'plate' => toolNamePlate,
        _ => toolNameWarmup,
      };

  String toolTitle(String id) => switch (id) {
        'rm' => toolTitleRm,
        'bmi' => toolTitleBmi,
        'cal' => toolTitleCal,
        'bf' => toolTitleBf,
        'plate' => toolTitlePlate,
        _ => toolTitleWarmup,
      };

  String toolResultHint(String id) => switch (id) {
        'rm' => toolHintRm,
        'cal' => toolHintCal,
        'bf' => toolHintBf,
        'plate' => toolHintPlate,
        _ => toolHintWarmup,
      };

  String toolDesc(String id) => switch (id) {
        'rm' => toolDescRm,
        'bmi' => toolDescBmi,
        'cal' => toolDescCal,
        'bf' => toolDescBf,
        'plate' => toolDescPlate,
        _ => toolDescWarmup,
      };

  String get macroProtein => switch (appLanguage) {
        'zh' => '蛋白质',
        'es' => 'PROTEÍNA',
        _ => 'PROTEIN',
      };

  String get macroCarbs => switch (appLanguage) {
        'zh' => '碳水',
        'es' => 'CARBOS',
        _ => 'CARBS',
      };

  String get macroFat => switch (appLanguage) {
        'zh' => '脂肪',
        'es' => 'GRASA',
        _ => 'FAT',
      };

  String bmiCategory(String key) => switch (key) {
        'Underweight' => bmiUnderweight,
        'Normal' => bmiNormal,
        'Overweight' => bmiOverweight,
        _ => bmiObese,
      };

  String activityName(String key) => switch (key) {
        'Sedentary' => actSedentary,
        'Light' => actLight,
        'Active' => actActive,
        _ => actModerate,
      };

  String muscle(String id) => switch (id) {
        'chest' => muscleChest,
        'back' => muscleBack,
        'shoulders' => muscleShoulders,
        'biceps' => muscleBiceps,
        'triceps' => muscleTriceps,
        'forearm' => muscleForearm,
        'trapezius' => muscleTrapezius,
        'abdomen' => muscleAbdomen,
        'obliques' => muscleObliques,
        'quads' => muscleQuads,
        'hamstrings' => muscleHamstrings,
        'glutes' => muscleGlutes,
        'calves' => muscleCalves,
        _ => id,
      };

  String muscleGroupName(String key) => switch (key) {
        'Chest' => mgChest,
        'Back' => mgBack,
        'Legs' => mgLegs,
        'Shoulders' => mgShoulders,
        'Arms' => mgArms,
        'Core' => mgCore,
        _ => key,
      };

  String equipment(String id) => switch (id) {
        'Barbell' => equipBarbell,
        'Dumbbell' => equipDumbbell,
        'Cable' => equipCable,
        'Machine' => equipMachine,
        'Bodyweight' => equipBodyweight,
        'Weighted' => equipWeighted,
        'Band' => equipBand,
        'Kettlebell' => equipKettlebell,
        _ => equipOther,
      };

  String difficulty(String id) => switch (id) {
        'Beginner' => diffBeginner,
        'Advanced' => diffAdvanced,
        _ => diffIntermediate,
      };

  String weekday(int w) =>
      _capitalize(_dates(DateFormat.EEEE).format(DateTime(2024, 1, w)));

  String weekdayInitial(int w) =>
      _dates((l) => DateFormat('', l)).dateSymbols.NARROWWEEKDAYS[w % 7];

  String longDate(DateTime d) => '${weekday(d.weekday)}, ${shortDate(d)}';

  String shortDate(DateTime d) => _dates(DateFormat.MMMd).format(d);

  String shortDateYear(DateTime d) => _dates(DateFormat.yMMMd).format(d);

  String catalogName(String id, String fallback) => _catalogNames[appLanguage]?[id] ?? fallback;

  List<String> catalogSteps(String id, List<String> fallback) =>
      _catalogSteps[appLanguage]?[id] ?? fallback;
}

String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
