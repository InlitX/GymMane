import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import '../l10n/l10n.dart';
import '../services/nfc_tags.dart';
import '../state/fit_state.dart';
import '../widgets/ui_kit.dart';
import 'settings_screen.dart';

class HelpTopic {
  const HelpTopic(this.id, this.question, this.answer, {this.section, this.row, this.go});

  final String id;
  final String question;
  final String answer;
  final String? section;
  final String? row;
  final void Function()? go;

  bool get leads => section != null || go != null;

  bool matches(String query) {
    final words = helpPlain(query).split(RegExp(r'\s+')).where((w) => w.length > 1).toList();
    if (words.isEmpty) return false;
    final hay = helpPlain('$question $answer');
    return words.every(hay.contains);
  }
}

String helpPlain(String s) => s
    .toLowerCase()
    .replaceAll(RegExp('[áàäâ]'), 'a')
    .replaceAll(RegExp('[éèëê]'), 'e')
    .replaceAll(RegExp('[íìïî]'), 'i')
    .replaceAll(RegExp('[óòöô]'), 'o')
    .replaceAll(RegExp('[úùüû]'), 'u')
    .replaceAll(RegExp('[¿?¡!.,:;«»“”"()]'), ' ');

const kHelpCommon = ['superset', 'range', 'dayOff', 'lb', 'rest', 'import', 'phone', 'homeOrder', 'custom', 'steps', 'slow'];

List<HelpTopic> helpTopics() {
  String s(String id) => SettingsScreen.sectionTitleOf(id);
  return [
    HelpTopic('superset', t.helpSupersetQ, t.helpSupersetA, go: fit.goRoutines),
    HelpTopic('range', t.helpRangeQ, t.helpRangeA, go: fit.goRoutines),
    HelpTopic('dayOff', t.helpDayOffQ, t.helpDayOffA, go: fit.goHome),
    HelpTopic('lb', t.helpLbQ, t.helpLbA(t.exerciseUnitSwitch('lb'))),
    HelpTopic('import', t.helpImportQ, t.helpImportA(s('data'), t.importFromApp), section: 'data', row: t.importFromApp),
    HelpTopic('phone', t.helpPhoneQ, t.helpPhoneA(s('data'), t.importBackup), section: 'data', row: t.exportBackup),
    HelpTopic('slow', t.helpSlowQ, t.helpSlowA(s('general'), t.perfSetting, t.perfLite),
        section: 'general', row: t.perfSetting),
    HelpTopic('rest', t.helpRestQ, t.helpRestA(t.exerciseSettings, titleCase(t.restForExercise), s('training')),
        section: 'training', row: t.restTimer),
    HelpTopic('sides', t.helpSidesQ, t.helpSidesA(t.exerciseSettings, t.eachSide), go: fit.goExercises),
    HelpTopic('pair', t.helpPairQ, t.helpPairA(t.pairSetting), go: fit.goExercises),
    HelpTopic('keep', t.helpKeepQ, t.helpKeepA(t.keepCounting), go: fit.goExercises),
    HelpTopic('race', t.helpRaceQ, t.helpRaceA(t.raceTitle)),
    HelpTopic('plates', t.helpPlatesQ, t.helpPlatesA(t.toolNamePlate, t.placesLabel), go: () => fit.openTool('plate')),
    HelpTopic('homeOrder', t.helpHomeOrderQ, t.helpHomeOrderA(s('home'), t.homeOrderRow), section: 'home'),
    HelpTopic('custom', t.helpCustomQ, t.helpCustomA(titleCase(t.newExercise)), go: fit.goExercises),
    HelpTopic('warmup', t.helpWarmupQ, t.helpWarmupA(t.exerciseSettings, t.autoWarmup, t.toolNameWarmup),
        go: fit.goExercises),
    HelpTopic('pass', t.helpPassQ, t.helpPassA(t.gymPass, s('home')), section: 'home', row: t.gymPass),
    if (!kIsWeb && Platform.isAndroid)
      HelpTopic('steps', t.helpStepsQ, t.helpStepsA(health(t.stepsSetting), s('home')),
          section: 'home', row: health(t.stepsSetting)),
    if (NfcTags.available)
      HelpTopic('nfc', t.helpNfcQ, t.helpNfcA(t.nfcRow, s('training')), section: 'training', row: t.nfcRow),
    if (fit.nutritionBeta)
      HelpTopic('clean', t.helpCleanQ, t.helpCleanA(t.trackersTitle), go: () => fit.pushRoute('nutrition')),
    if (fit.nutritionBeta) HelpTopic('fast', t.helpFastQ, t.helpFastA(t.fastAdjust)),
  ];
}
