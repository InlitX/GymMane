import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../models/profile.dart';
import '../services/alarm_store.dart';
import '../services/auto_backup.dart';
import '../services/backup_zip.dart';
import '../services/fitnotes_backup.dart';
import '../services/home_widget_bridge.dart';
import '../services/rest_alarm.dart';
import '../services/sqlite_reader.dart';
import '../services/workout_import.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/auto_backup_sheet.dart';
import '../widgets/body_rulers.dart';
import '../widgets/dialogs.dart';
import '../widgets/entrance.dart';
import '../widgets/file_thumb.dart';
import '../widgets/glass.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/sheet_page.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/timer_panel.dart';
import 'profile_screen.dart';
import 'strava_sheet.dart';
import '../widgets/health_cards.dart';
import '../widgets/steps_card.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

const _kRepoUrl = 'https://github.com/InlitX/GymMane';
const _kBugUrl = '$_kRepoUrl/issues/new?labels=bug';
const _kFeatureUrl = '$_kRepoUrl/issues/new?labels=enhancement';
const _kKofiUrl = 'https://ko-fi.com/inlitx';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.section});

  final String? section;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final id = section;
    if (id == null) return _SettingsHome(screen: this);
    return RiseScope(
      id: 'settings-$id',
      once: false,
      child: SheetPage(
        title: titleCase(_sectionTitle(id)),
        eyebrow: t.settings,
        onBack: fit.popRoute,
        children: riseAll(_sectionBody(context, gc, id)),
      ),
    );
  }

  List<Widget> _sectionBody(BuildContext context, GymColors gc, String id) {
    switch (id) {
      case 'general':
        return [
          _card(gc, [
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.moon,
                    t.theme,
                    [
                      ('system', t.themeAuto, PhosphorIconsRegular.circleHalf),
                      ('dark', t.darkTheme, PhosphorIconsRegular.moon),
                      ('amoled', t.amoledTheme, PhosphorIconsRegular.moonStars),
                      ('light', t.lightTheme, PhosphorIconsRegular.sun),
                    ],
                    () => fit.themePref,
                    fit.setThemePref,
                    hint: t.themeAutoHint,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _editLanguage(context),
                    child: _prefRow(
                      gc,
                      PhosphorIconsRegular.translate,
                      t.languageLabel,
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          languageNameOf(fit.language),
                          style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary),
                        ),
                        const SizedBox(width: 6),
                        Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                      ]),
                    ),
                  ),
                  _prefRow(gc, PhosphorIconsRegular.scales, t.unitsLabel, SegToggle([
                    SegOption('kg', fit.units == 'kg', () => fit.setUnits('kg')),
                    SegOption('lb', fit.units == 'lb', () => fit.setUnits('lb')),
                  ])),
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.calendarBlank,
                    t.weekStartSetting,
                    [for (final d in SettingsState.weekStarts) ('$d', t.weekday(d), PhosphorIconsRegular.calendarBlank)],
                    () => '${fit.weekStartDay}',
                    (v) => fit.setWeekStart(int.parse(v)),
                  ),
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.calendarDots,
                    t.heatRangeSetting,
                    [
                      ('weeks', t.heatRangeWeeks, PhosphorIconsRegular.squaresFour),
                      ('year', t.heatRangeYear, PhosphorIconsRegular.calendarDots),
                    ],
                    () => fit.heatmapRange,
                    fit.setHeatmapRange,
                    hint: t.heatRangeHint,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleHeatmapLabels,
                    child: _prefRow(gc, PhosphorIconsRegular.gridNine, t.heatmapLabelsSetting,
                        TinySwitch(on: fit.heatmapLabels)),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _editBackground(context),
                    child: _prefRow(
                      gc,
                      PhosphorIconsRegular.image,
                      t.background,
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(_bgName(fit.bgPattern),
                            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
                        const SizedBox(width: 6),
                        Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                      ]),
                    ),
                  ),

            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => fit.setBlur(!fit.blurOn),
              child: _prefRow(gc, PhosphorIconsRegular.drop, t.blurSetting, TinySwitch(on: fit.blurOn),
                  hint: t.blurSettingHint),
            ),
          ]),
        ];
      case 'training':
        return [
          _card(gc, [
                  _prefRow(
                    gc,
                    PhosphorIconsRegular.timer,
                    t.restTimer,
                    StepperControl(
                      value: fit.restSeconds == 0 ? t.restOff : clockLabel(fit.restSeconds),
                      minWidth: 48,
                      btnSize: 28,
                      gap: 10,
                      fontSize: 14,
                      onDec: () => fit.setRestSeconds(fit.restSeconds - 15),
                      onInc: () => fit.setRestSeconds(fit.restSeconds + 15),
                      onEdit: () async {
                        final v = await askRuler(context,
                            title: t.restTimer,
                            value: fit.restSeconds.toDouble(),
                            min: 0,
                            max: 600,
                            step: 5,
                            majorEvery: 6,
                            format: (v) => clockLabel(v.round()),
                            tickLabel: (v) => clockLabel(v.round()));
                        if (v != null) fit.setRestSeconds(v.round());
                      },
                    ),
                    hint: t.restRowHint,
                  ),
                  _prefRow(
                    gc,
                    PhosphorIconsRegular.timer,
                    t.miniRest,
                    StepperControl(
                      value: fit.miniRestSeconds == 0 ? t.restOff : clockLabel(fit.miniRestSeconds),
                      minWidth: 48,
                      btnSize: 28,
                      gap: 10,
                      fontSize: 14,
                      onDec: () => fit.setMiniRest(fit.miniRestSeconds - 5),
                      onInc: () => fit.setMiniRest(fit.miniRestSeconds + 5),
                      onEdit: () async {
                        final v = await askRuler(context,
                            title: t.miniRest,
                            value: fit.miniRestSeconds.toDouble(),
                            min: 0,
                            max: 180,
                            step: 5,
                            majorEvery: 6,
                            format: (v) => clockLabel(v.round()),
                            tickLabel: (v) => clockLabel(v.round()));
                        if (v != null) fit.setMiniRest(v.round());
                      },
                    ),
                    hint: t.miniRestHint,
                  ),
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.gauge,
                    t.effortSetting,
                    [
                      ('', t.restOff, PhosphorIconsRegular.prohibit),
                      ('rpe', 'RPE', PhosphorIconsRegular.gauge),
                      ('rir', 'RIR', PhosphorIconsRegular.arrowCounterClockwise),
                    ],
                    () => fit.effortMode,
                    fit.setEffortMode,
                    hint: t.effortHint,
                    rowHint: t.effortRowHint,
                  ),
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.barbell,
                    t.weightStepSetting,
                    [for (final s in fit.weightSteps) ('$s', '${fmt(s)} ${fit.units}', PhosphorIconsRegular.barbell)],
                    () => '${fit.weightStep}',
                    (v) => fit.setWeightStep(double.parse(v)),
                    rowHint: t.weightStepHint,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleAutoAdvance,
                    child: _prefRow(gc, PhosphorIconsRegular.skipForward, t.autoAdvance,
                        TinySwitch(on: fit.autoAdvance), hint: t.autoAdvanceHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleStartCountdown,
                    child: _prefRow(gc, PhosphorIconsRegular.timer, t.countdownSetting,
                        TinySwitch(on: fit.startCountdown), hint: t.countdownHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleKeepScreenOn,
                    child: _prefRow(gc, PhosphorIconsRegular.sun, t.keepScreenOn,
                        TinySwitch(on: fit.keepScreenOn), hint: t.keepScreenOnHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleMultiPlan,
                    child: _prefRow(gc, PhosphorIconsRegular.stack, t.multiPlanSetting,
                        TinySwitch(on: fit.multiPlan), hint: t.multiPlanSettingHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleLevelHints,
                    child: _prefRow(gc, PhosphorIconsRegular.stairs, t.levelHintsSetting,
                        TinySwitch(on: fit.levelHints), hint: t.levelHintsHint),
                  ),
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.rows,
                    t.layoutSetting,
                    [
                      ('cards', t.layoutCards, PhosphorIconsRegular.cards),
                      ('list', t.layoutList, PhosphorIconsRegular.listBullets),
                    ],
                    () => fit.sessionLayout,
                    fit.setSessionLayout,
                    hint: t.layoutHint,
                    rowHint: t.layoutRowHint,
                  ),
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.filmStrip,
                    t.demoSizeTitle,
                    [
                      ('large', t.demoLarge, PhosphorIconsRegular.rectangle),
                      ('small', t.demoSmall, PhosphorIconsRegular.square),
                      ('off', t.demoOff, PhosphorIconsRegular.eyeSlash),
                    ],
                    () => fit.demoSize,
                    fit.setDemoSize,
                    rowHint: t.demoSizeRowHint,
                  ),
                  if (fit.demoSize != 'off')
                    _choiceRow(
                      context,
                      gc,
                      PhosphorIconsRegular.repeat,
                      t.demoLoopTitle,
                      [
                        ('always', t.demoLoopAlways, PhosphorIconsRegular.repeat),
                        ('short', t.demoLoopShort, PhosphorIconsRegular.timer),
                      ],
                      () => fit.demoLoop,
                      fit.setDemoLoop,
                      hint: t.demoLoopHint,
                      rowHint: t.demoLoopRowHint,
                    ),

          ]),
          const SizedBox(height: 18),
          _linkGroup(gc, [
              (PhosphorIconsRegular.mapPin, t.placesLabel, fit.goPlaces),
          ]),
        ];
      case 'alerts':
        return [
          _card(gc, [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _editTrainReminder(context),
                    child: _prefRow(
                      gc,
                      PhosphorIconsRegular.bellSimple,
                      t.trainReminder,
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Flexible(
                          child: Text(
                            _reminderValue(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                      ]),
                      hint: t.trainReminderRowHint,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _editAlarmSound(context),
                    child: _prefRow(
                      gc,
                      PhosphorIconsRegular.speakerHigh,
                      t.alarmSound,
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 128),
                          child: Text(
                            fit.alarmSoundName ?? t.alarmDefaultName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                      ]),
                      hint: t.alarmSoundRowHint,
                    ),
                  ),
                  _choiceRow(
                    context,
                    gc,
                    PhosphorIconsRegular.vibrate,
                    t.alarmStyleTitle,
                    [
                      ('loud', t.alarmStyleLoud, PhosphorIconsRegular.bellRinging),
                      ('quiet', t.alarmStyleQuiet, PhosphorIconsRegular.bellSimpleSlash),
                      ('vibrate', t.alarmStyleVibrate, PhosphorIconsRegular.vibrate),
                    ],
                    () => fit.alarmStyle,
                    fit.setAlarmStyle,
                    hint: t.alarmStyleHint,
                    rowHint: t.alarmStyleRowHint,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleToastSound,
                    child: _prefRow(gc, PhosphorIconsRegular.bellSimple, t.toastSoundSetting,
                        TinySwitch(on: fit.toastSound), hint: t.toastSoundHint),
                  ),
                  if (!fit.alarmAllowed) ...[
                    const SizedBox(height: 14),
                    _alarmWarning(context, gc),
                    const SizedBox(height: 14),
                  ],

          ]),
        ];
      case 'home':
        return [
          _card(gc, [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleFocusCard,
                    child: _prefRow(gc, PhosphorIconsRegular.target, t.focusCard,
                        TinySwitch(on: fit.showFocus), hint: t.focusCardHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleRecommended,
                    child: _prefRow(gc, PhosphorIconsRegular.sparkle, t.homeRecommended,
                        TinySwitch(on: fit.showRecommended), hint: t.recommendedRowHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleRoutineRow,
                    child: _prefRow(gc, PhosphorIconsRegular.folders, t.homeRoutines,
                        TinySwitch(on: fit.showRoutineRow), hint: t.homeRoutinesHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleWeekStats,
                    child: _prefRow(gc, PhosphorIconsRegular.chartBar, t.homeWeekStats,
                        TinySwitch(on: fit.showWeekStats), hint: t.homeWeekStatsHint),
                  ),
                  if (fit.stepsAvailable)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        if (await fit.setStepsOn(!fit.stepsOn) || !context.mounted) return;
                        showStepsSheet(context);
                      },
                      child: _prefRow(gc, PhosphorIconsRegular.footprints, t.stepsSetting,
                          TinySwitch(on: fit.stepsOn), hint: t.stepsSettingHint),
                    ),
                  if (fit.stepsAvailable)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => showHealthPicker(context),
                      child: _prefRow(
                          gc,
                          PhosphorIconsRegular.heartbeat,
                          t.healthSetting,
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            if (fit.healthShown.isNotEmpty)
                              Text('${fit.healthShown.length}',
                                  style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.textSecondary)),
                            const SizedBox(width: 6),
                            Icon(PhosphorIconsBold.caretRight, size: 14, color: gc.textTertiary),
                          ]),
                          hint: t.healthSettingHint),
                    ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.toggleGamification,
                    child: _prefRow(gc, PhosphorIconsRegular.medal, t.gamificationSetting,
                        TinySwitch(on: fit.gamification), hint: t.gamificationHint),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: fit.togglePass,
                    child: _prefRow(gc, PhosphorIconsRegular.qrCode, t.gymPass,
                        TinySwitch(on: fit.passOn), hint: t.gymPassSettingHint),
                  ),

          ]),
        ];
      case 'beta':
        return [
          _card(gc, [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => fit.setNutritionBeta(!fit.nutritionBeta),
                    child: _prefRow(gc, PhosphorIconsRegular.forkKnife, t.nutritionBeta,
                        TinySwitch(on: fit.nutritionBeta),
                        hint: t.nutritionBetaHint,
                        badge: BetaTag(t.sectionBeta, small: true)),
                  ),

          ]),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 12),
            child: Text(t.nutritionAboutTitle.toUpperCase(),
                style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(26)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (final (icon, title, body) in [
                (PhosphorIconsRegular.barbell, t.nutritionAboutWhatTitle, t.nutritionAboutWhat),
                (PhosphorIconsRegular.shieldCheck, t.nutritionAboutScanTitle, t.nutritionAboutScan),
                (PhosphorIconsRegular.deviceMobile, t.nutritionAboutLocalTitle, t.nutritionAboutLocal),
                (PhosphorIconsRegular.flask, t.nutritionAboutBetaTitle, t.nutritionAboutBeta),
              ])
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _rowIcon(gc, icon),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const SizedBox(height: 2),
                        Text(title, style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
                        const SizedBox(height: 3),
                        Text(body,
                            style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
                      ]),
                    ),
                  ]),
                ),
            ]),
          ),
          const SizedBox(height: 12),
          _linkGroup(gc, [
            (PhosphorIconsRegular.githubLogo, t.nutritionAboutSuggest, () => _open(context, '$_kRepoUrl/issues')),
          ]),
        ];
      case 'widgets':
        return [
          _linkGroup(gc, [
              (PhosphorIconsRegular.squaresFour, t.addActivityWidget, () => _addWidget(context, 'HeatmapWidgetProvider')),
              (PhosphorIconsRegular.chartBar, t.addStatsWidget, () => _addWidget(context, 'StatsWidgetProvider')),
              (PhosphorIconsRegular.person, t.addBodyWidget, () => _addWidget(context, 'BodyWidgetProvider')),
              (PhosphorIconsRegular.checkCircle, t.addTodayWidget, () => _addWidget(context, 'TodayWidgetProvider')),
              (PhosphorIconsRegular.calendarCheck, t.addWeekWidget, () => _addWidget(context, 'WeekWidgetProvider')),
          ], hints: [t.widgetHintActivity, t.widgetHintStats, t.widgetHintBody, t.widgetHintToday, t.widgetHintWeek]),
        ];
      case 'data':
        return [
          _linkGroup(gc, [
              (PhosphorIconsRegular.fileCsv, t.exportCsv, () => _exportCsv(context)),
              (PhosphorIconsRegular.fileZip, t.exportBackup, () => _exportBackup(context)),
              (PhosphorIconsRegular.downloadSimple, t.importBackup, () => _importBackup(context)),
              if (AutoBackup.instance.supported)
                (PhosphorIconsRegular.clockCounterClockwise, t.autoBackup, () => showAutoBackupSheet(context)),
              (PhosphorIconsRegular.arrowSquareIn, t.importFromApp, () => _openImportApps(context)),
              (PhosphorIconsRegular.export, t.stravaRow, () => showStravaSheet(context)),
              (PhosphorIconsRegular.trash, t.resetData, () => _resetAll(context)),
          ], danger: AutoBackup.instance.supported ? 6 : 5),
        ];
      default:
        return [
          _linkGroup(gc, [
              (PhosphorIconsRegular.bug, t.reportBug, () => _open(context, _kBugUrl)),
              (PhosphorIconsRegular.lightbulb, t.requestFeature, () => _open(context, _kFeatureUrl)),
              (PhosphorIconsRegular.githubLogo, t.starOnGithub, () => _open(context, _kRepoUrl)),
              (PhosphorIconsRegular.coffee, t.buyCoffee, () => _open(context, _kKofiUrl)),
          ], hints: [t.supportHintBug, t.supportHintFeature, t.supportHintStar, t.supportHintCoffee]),
        ];
    }
  }

  Widget _card(GymColors gc, List<Widget> rows) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(26)),
        child: Column(children: rows),
      );

  static String _sectionTitle(String id) => switch (id) {
        'general' => t.sectionGeneral,
        'training' => t.sectionTraining,
        'alerts' => t.sectionAlerts,
        'home' => t.sectionHome,
        'widgets' => t.sectionWidgets,
        'beta' => t.sectionBeta,
        'data' => t.sectionData,
        _ => titleCase(t.support),
      };

  static String sectionTitleOf(String id) => _sectionTitle(id);

  List<_Category> _categories() {
    const r = PhosphorIconsRegular.gearSix;
    return [
      _Category('general', PhosphorIconsRegular.slidersHorizontal, _sectionTitle('general'), [
        (t.theme, PhosphorIconsRegular.moon),
        (t.languageLabel, PhosphorIconsRegular.translate),
        (t.unitsLabel, PhosphorIconsRegular.scales),
        (t.weekStartSetting, PhosphorIconsRegular.calendarBlank),
        (t.heatRangeSetting, PhosphorIconsRegular.calendarDots),
        (t.heatmapLabelsSetting, PhosphorIconsRegular.gridNine),
        (t.background, PhosphorIconsRegular.image),
        (t.blurSetting, PhosphorIconsRegular.drop),
      ]),
      _Category('training', PhosphorIconsRegular.barbell, _sectionTitle('training'), [
        (t.restTimer, PhosphorIconsRegular.timer),
        (t.miniRest, PhosphorIconsRegular.timer),
        (t.effortSetting, PhosphorIconsRegular.gauge),
        (t.weightStepSetting, PhosphorIconsRegular.barbell),
        (t.autoAdvance, PhosphorIconsRegular.skipForward),
        (t.countdownSetting, PhosphorIconsRegular.timer),
        (t.keepScreenOn, PhosphorIconsRegular.sun),
        (t.multiPlanSetting, PhosphorIconsRegular.stack),
        (t.levelHintsSetting, PhosphorIconsRegular.stairs),
        (t.layoutSetting, PhosphorIconsRegular.rows),
        (t.demoSizeTitle, PhosphorIconsRegular.filmStrip),
        (t.demoLoopTitle, PhosphorIconsRegular.repeat),
        (t.placesLabel, PhosphorIconsRegular.mapPin),
      ]),
      _Category('alerts', PhosphorIconsRegular.bellSimple, _sectionTitle('alerts'), [
        (t.trainReminder, PhosphorIconsRegular.bellSimple),
        (t.alarmSound, PhosphorIconsRegular.speakerHigh),
        (t.alarmStyleTitle, PhosphorIconsRegular.vibrate),
        (t.toastSoundSetting, PhosphorIconsRegular.bellSimple),
      ]),
      _Category('home', PhosphorIconsRegular.house, _sectionTitle('home'), [
        (t.focusCard, PhosphorIconsRegular.target),
        (t.homeRecommended, PhosphorIconsRegular.sparkle),
        (t.homeRoutines, PhosphorIconsRegular.folders),
        (t.homeWeekStats, PhosphorIconsRegular.chartBar),
        (t.stepsSetting, PhosphorIconsRegular.footprints),
        (t.healthSetting, PhosphorIconsRegular.heartbeat),
        (t.gamificationSetting, PhosphorIconsRegular.medal),
        (t.gymPass, PhosphorIconsRegular.qrCode),
      ]),
      if (Platform.isAndroid || Platform.isIOS)
        _Category('widgets', PhosphorIconsRegular.squaresFour, _sectionTitle('widgets'), [
          (t.addActivityWidget, PhosphorIconsRegular.squaresFour),
          (t.addStatsWidget, PhosphorIconsRegular.chartBar),
          (t.addBodyWidget, PhosphorIconsRegular.person),
          (t.addTodayWidget, PhosphorIconsRegular.checkCircle),
          (t.addWeekWidget, PhosphorIconsRegular.calendarCheck),
        ]),
      _Category('beta', PhosphorIconsRegular.flask, _sectionTitle('beta'), [
        (t.nutritionBeta, PhosphorIconsRegular.forkKnife),
      ]),
      _Category('data', PhosphorIconsRegular.database, _sectionTitle('data'), [
        (t.exportCsv, PhosphorIconsRegular.fileCsv),
        (t.exportBackup, PhosphorIconsRegular.fileZip),
        (t.importBackup, PhosphorIconsRegular.downloadSimple),
        (t.autoBackup, PhosphorIconsRegular.clockCounterClockwise),
        (t.importFromApp, PhosphorIconsRegular.arrowSquareIn),
        (t.stravaRow, PhosphorIconsRegular.export),
        (t.resetData, PhosphorIconsRegular.trash),
      ]),
      _Category('support', PhosphorIconsRegular.heart, _sectionTitle('support'), [
        (t.reportBug, PhosphorIconsRegular.bug),
        (t.requestFeature, PhosphorIconsRegular.lightbulb),
        (t.starOnGithub, PhosphorIconsRegular.githubLogo),
        (t.buyCoffee, PhosphorIconsRegular.coffee),
      ]),
      _Category('about', PhosphorIconsRegular.info, t.aboutGymmane, [(t.aboutGymmane, r)]),
    ];
  }

  static void _openCategory(String id) => id == 'about' ? fit.goAbout() : fit.pushRoute('preferences/$id');

  Widget _prefRow(GymColors gc, IconData icon, String label, Widget control, {String? hint, Widget? badge}) {
    if (hint == null) {
      return _Flash(label: label, child: SizedBox(
        height: 52,
        child: Row(
          children: [
            _rowIcon(gc, icon),
            Expanded(child: Text(label, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text))),
            const SizedBox(width: 12),
            control,
          ],
        ),
      ));
    }
    return _Flash(label: label, child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            _rowIcon(gc, icon),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (badge == null)
                    Text(label, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text))
                  else
                    Row(children: [
                      Flexible(child: Text(label, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text))),
                      const SizedBox(width: 7),
                      badge,
                    ]),
                  const SizedBox(height: 3),
                  Text(hint,
                      style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            control,
          ],
        ),
      ),
    ));
  }

  Widget _choiceRow(
    BuildContext context,
    GymColors gc,
    IconData icon,
    String label,
    List<(String, String, IconData)> options,
    String Function() current,
    void Function(String) onPick, {
    String? hint,
    String? rowHint,
  }) {
    final now = current();
    final shown = options.firstWhere((o) => o.$1 == now, orElse: () => options.first);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _choiceSheet(context, label, options, current, onPick, hint: hint),
      child: _prefRow(
        gc,
        icon,
        label,
        hint: rowHint,
        Row(mainAxisSize: MainAxisSize.min, children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 128),
            child: Text(
              shown.$2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary),
            ),
          ),
          const SizedBox(width: 6),
          Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
        ]),
      ),
    );
  }

  void _choiceSheet(
    BuildContext context,
    String title,
    List<(String, String, IconData)> options,
    String Function() current,
    void Function(String) onPick, {
    String? hint,
  }) {
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) => AnimatedBuilder(
        animation: fit,
        builder: (sheet, _) {
          final gc = sheet.gc;
          final now = current();
          return Container(
            padding: sheetPad(sheet),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SheetHandle(),
                  const SizedBox(height: 16),
                  SheetTitle(title),
                  const SizedBox(height: 14),
                  OptionGroup([
                    for (final o in options)
                      OptionItem(
                        o.$2,
                        icon: o.$3,
                        selected: now == o.$1,
                        onTap: () {
                          onPick(o.$1);
                          Navigator.of(sheet).pop();
                        },
                      ),
                  ]),
                  if (hint != null) ...[
                    const SizedBox(height: 12),
                    Text(hint,
                        textAlign: TextAlign.center,
                        style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _rowIcon(GymColors gc, IconData icon, {Color? color}) => Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: (color ?? gc.text).withValues(alpha: 0.09),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 17, color: color ?? gc.text),
        ),
      );

  Widget _linkGroup(GymColors gc, List<(IconData, String, VoidCallback)> items, {int? danger, List<String>? hints}) {
    return Container(
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(26),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++)
            _Flash(label: items[i].$2, child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: items[i].$3,
              child: Container(
                constraints: const BoxConstraints(minHeight: 52),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: hints == null ? 0 : 13),
                decoration: BoxDecoration(
                  border: i < items.length - 1
                      ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.6)))
                      : null,
                ),
                child: Row(
                  children: [
                    _rowIcon(gc, items[i].$1, color: i == danger ? gc.danger : null),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[i].$2,
                              style: AppTheme.f(14.5,
                                  weight: FontWeight.w500, color: i == danger ? gc.danger : gc.text)),
                          if (hints != null && i < hints.length) ...[
                            const SizedBox(height: 2),
                            Text(hints[i],
                                style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.3)),
                          ],
                        ],
                      ),
                    ),
                    Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                  ],
                ),
              ),
            )),
        ],
      ),
    );
  }

  Future<void> _exportCsv(BuildContext context) async {
    if (!fit.hasData) {
      _snack(context, t.nothingToExport);
      return;
    }
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toIso8601String().split('T').first;
    final file = File('${dir.path}/gymmane-workouts-$stamp.csv');
    await file.writeAsString(fit.exportCsv());
    if (!context.mounted) return;
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], subject: 'GymMane workouts'),
    );
  }

  Future<void> _resetAll(BuildContext context) async {
    final ok = await askConfirm(
      context,
      title: t.resetTitle,
      body: t.resetBody,
      confirmLabel: t.resetConfirm,
    );
    if (!ok) return;
    fit.resetAllData();
    if (context.mounted) _snack(context, t.resetDone);
  }

  Future<void> _exportBackup(BuildContext context) async {
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toIso8601String().split('T').first;
    final file = File('${dir.path}/gymmane-backup-$stamp.zip');
    await file.writeAsBytes(await buildBackupZip(), flush: true);
    if (!context.mounted) return;
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], subject: 'GymMane backup'),
    );
  }

  Future<void> _importBackup(BuildContext context) async {
    final ok = await askConfirm(
      context,
      title: t.importBackup,
      body: t.importHint,
      confirmLabel: t.chooseFile,
    );
    if (!ok) return;

    Uint8List? bytes;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip', 'json'],
        withData: true,
      );
      if (result == null) return;
      final picked = result.files.single;
      bytes = picked.bytes ?? (picked.path == null ? null : await File(picked.path!).readAsBytes());
    } catch (_) {
      bytes = null;
    }

    if (!context.mounted) return;
    if (bytes == null) {
      _snack(context, t.backupFailed);
      return;
    }
    final success = looksLikeZip(bytes)
        ? await restoreBackupZip(bytes)
        : fit.importJson(utf8.decode(bytes, allowMalformed: true));
    if (context.mounted) {
      _snack(context, success ? t.backupImported : t.backupFailed);
    }
  }

  Widget _alarmWarning(BuildContext context, GymColors gc) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: fit.openNotificationSettings,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: gc.accentSoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: gc.accent.withValues(alpha: .3)),
        ),
        child: Row(children: [
          Icon(PhosphorIconsRegular.bellSlash, size: 18, color: gc.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.alarmBlockedTitle,
                    style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 2),
                Text(t.alarmBlockedBody, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(t.alarmBlockedAction,
              style: AppTheme.f(12, weight: FontWeight.w700, color: gc.accent, letterSpacing: 1)),
        ]),
      ),
    );
  }

  void _openImportApps(BuildContext context) {
    final gc = context.gc;
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) => Container(
        padding: sheetPad(sheet),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 16),
              SheetTitle(t.importFromApp),
              const SizedBox(height: 16),
              Text(t.importApps,
                  style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: ColoredBox(
                  color: gc.bgRaised2,
                  child: Column(children: [
                    for (final (i, (name, what)) in const [
                      ('Hevy', 'workout_data.csv'),
                      ('Strong', 'strong.csv'),
                      ('Lyfta', 'LyftaExport.csv'),
                      ('FitNotes', '.fitnotes'),
                      ('openGym', 'opengym-backup.json'),
                      ('CSV', ''),
                    ].indexed) ...[
                      if (i > 0) Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: gc.border),
                      _appRow(gc, name, what.isEmpty ? t.importOtherCsv : what),
                    ],
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              Text(t.importHint, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
              const SizedBox(height: 18),
              PrimaryButton(
                label: t.chooseFile,
                onTap: () {
                  Navigator.pop(sheet);
                  _importFromApp(context);
                },
              ),
              const SizedBox(height: 6),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(sheet);
                  _open(context, _kFeatureUrl);
                },
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(PhosphorIconsRegular.githubLogo, size: 15, color: gc.accent),
                      const SizedBox(width: 8),
                      Text(t.importAskApp,
                          style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appRow(GymColors gc, String name, String what) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(name, style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(what,
                textAlign: TextAlign.right,
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
          ),
        ],
      ),
    );
  }

  Future<void> _importFromApp(BuildContext context) async {
    Uint8List? bytes;
    try {
      final result = await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      final picked = result.files.single;
      bytes = picked.bytes ?? (picked.path == null ? null : await File(picked.path!).readAsBytes());
    } catch (_) {
      bytes = null;
    }
    if (!context.mounted) return;
    if (bytes == null) {
      _snack(context, t.importReadFailed);
      return;
    }

    if (SqliteDb.looksLikeSqlite(bytes)) {
      final parsed = parseFitNotes(bytes);
      if (parsed == null) {
        _snack(context, t.importUnknownFormat);
        return;
      }
      _applyImport(context, parsed);
      return;
    }

    String? raw;
    try {
      if (bytes.length > 2 && bytes[0] == 0x50 && bytes[1] == 0x4B) {
        raw = weightCsvFromZip(bytes);
        if (raw == null) {
          _snack(context, t.importZipNoWeights);
          return;
        }
      } else {
        raw = utf8.decode(bytes, allowMalformed: true);
      }
    } catch (_) {
      raw = null;
    }
    if (!context.mounted) return;
    if (raw == null) {
      _snack(context, t.importReadFailed);
      return;
    }
    final format = detectFormat(raw);
    if (format == ImportFormat.unknown) {
      _snack(context, t.importUnknownFormat);
      return;
    }
    var isLb = fit.isLb;
    if (needsUnitChoice(raw)) {
      final choice = await _askImportUnit(context);
      if (choice == null) return;
      isLb = choice;
    }
    if (!context.mounted) return;
    _applyImport(context, parseImport(raw, isLb: isLb));
  }

  void _applyImport(BuildContext context, ImportResult parsed) {
    final sessions = fit.importParsedSessions(parsed.sessions);
    final weights = fit.importParsedWeights(parsed.weights);
    if (!context.mounted) return;
    _snack(context, _importSummary(sessions, weights));
  }

  String _importSummary(int sessions, int weights) {
    if (sessions > 0 && weights > 0) return '${t.importDone(sessions)} · ${t.importWeights(weights)}';
    if (sessions > 0) return t.importDone(sessions);
    if (weights > 0) return t.importWeights(weights);
    return t.importNothing;
  }

  Future<bool?> _askImportUnit(BuildContext context) {
    final gc = context.gc;
    return showAppDialog<bool>(
      context: context,
      builder: (dctx) => appDialog(
        gc,
        title: Text(t.importUnitTitle, style: AppTheme.f(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.importUnitBody, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
        actions: [
          dialogAction('kg', gc.accent, () => Navigator.of(dctx).pop(false)),
          dialogAction('lb', gc.accent, () => Navigator.of(dctx).pop(true)),
        ],
      ),
    );
  }

  Future<void> _open(BuildContext context, String url) async {
    var ok = false;
    try {
      ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (_) {
      ok = false;
    }
    if (!ok && context.mounted) _snack(context, t.cantOpenLink);
  }

  Future<void> _addWidget(BuildContext context, String provider) async {
    await HomeWidgetBridge.updateNow(provider: provider);
    try {
      final supported = await HomeWidget.isRequestPinWidgetSupported() ?? false;
      if (!supported) {
        if (context.mounted) _snack(context, t.pinUnsupported);
        return;
      }
      await HomeWidget.requestPinWidget(
          qualifiedAndroidName: 'com.gymmane.app.$provider');
    } catch (_) {
      if (context.mounted) _snack(context, t.pinUnsupported);
    }
  }

  String _clockLabel(BuildContext context, int minuteOfDay) =>
      TimeOfDay(hour: minuteOfDay ~/ 60, minute: minuteOfDay % 60).format(context);

  String _reminderValue(BuildContext context) {
    if (fit.trainReminderMin == null) return t.photoEveryOff;
    if (!fit.smartReminder) return _clockLabel(context, fit.trainReminderMin!);
    return _habitLabel(context) ?? t.reminderSmart;
  }

  String? _habitLabel(BuildContext context) {
    final days = fit.usualWeekdays;
    final at = fit.usualStartMinute;
    if (days.isEmpty || at == null) return null;
    final initials = days.map(t.weekdayInitial).join(' ');
    return '$initials · ${_clockLabel(context, at)}';
  }

  void _editTrainReminder(BuildContext context) {
    final gc = context.gc;
    var minutes = fit.trainReminderMin ?? 19 * 60;
    var smart = fit.smartReminder;
    var again = fit.trainAgainMin;
    showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheet) => StatefulBuilder(
        builder: (sheet, setSheet) => Container(
          padding: sheetPad(sheet),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 16),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(height: 36, width: double.infinity),
                  SheetTitle(t.trainReminder),
                  if (!smart)
                    Positioned(
                      left: 0,
                      child: RoundAction(
                        label: t.reminderExactTime,
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: sheet,
                            initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
                            initialEntryMode: TimePickerEntryMode.inputOnly,
                            helpText: t.reminderExactTime,
                          );
                          if (picked != null) setSheet(() => minutes = picked.hour * 60 + picked.minute);
                        },
                        child: Icon(PhosphorIconsRegular.pencilSimple, size: 16, color: gc.text),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: SegToggle([
                  SegOption(t.reminderFixed, !smart, () => setSheet(() => smart = false)),
                  SegOption(t.reminderSmart, smart, () => setSheet(() => smart = true)),
                ]),
              ),
              const SizedBox(height: 18),
              if (smart) ...[
                Text(_habitLabel(sheet) ?? t.reminderSmartEmpty,
                    textAlign: TextAlign.center,
                    style: _habitLabel(sheet) == null
                        ? AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)
                        : AppTheme.f(22, weight: FontWeight.w700, color: gc.ember)),
                const SizedBox(height: 12),
                Text(t.reminderSmartHint,
                    textAlign: TextAlign.center,
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
              ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StepperControl(
                    value: (minutes ~/ 60).toString().padLeft(2, '0'),
                    minWidth: 34,
                    btnSize: 30,
                    gap: 10,
                    fontSize: 22,
                    onDec: () => setSheet(() => minutes = (minutes - 60 + 1440) % 1440),
                    onInc: () => setSheet(() => minutes = (minutes + 60) % 1440),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(':',
                        style: AppTheme.f(22, weight: FontWeight.w700, color: gc.textTertiary)),
                  ),
                  StepperControl(
                    value: (minutes % 60).toString().padLeft(2, '0'),
                    minWidth: 34,
                    btnSize: 30,
                    gap: 10,
                    fontSize: 22,
                    onDec: () => setSheet(() => minutes = (minutes - 15 + 1440) % 1440),
                    onInc: () => setSheet(() => minutes = (minutes + 15) % 1440),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(_clockLabel(sheet, minutes),
                  textAlign: TextAlign.center,
                  style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.ember)),
              const SizedBox(height: 14),
              Text(t.trainReminderHint,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
              ],
              const SizedBox(height: 20),
              Container(height: 1, color: gc.border),
              const SizedBox(height: 16),
              Text(t.trainAgainLabel,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(height: 10),
              Center(
                child: SegToggle([
                  for (final m in SettingsState.trainAgainOptions)
                    SegOption(m == 0 ? t.trainAgainOff : t.trainAgainAfter(m ~/ 60), again == m,
                        () => setSheet(() => again = m)),
                ]),
              ),
              const SizedBox(height: 8),
              Text(t.trainAgainHint,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
              const SizedBox(height: 18),
              PrimaryButton(
                label: t.save,
                onTap: () {
                  fit.setSmartReminder(smart);
                  fit.setTrainAgain(again);
                  fit.setTrainReminder(minutes);
                  fit.askAlarmPermission(force: true);
                  Navigator.of(sheet).pop();
                },
              ),
              const SizedBox(height: 6),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  fit.setTrainReminder(null);
                  Navigator.of(sheet).pop();
                },
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  child: Text(t.photoEveryOff,
                      style: AppTheme.f(13,
                          weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _bgName(String pattern) => switch (pattern) {
        'none' => t.bgNone,
        'grid' => t.bgGrid,
        'photo' => t.bgPhoto,
        _ => t.bgDots,
      };

  void _editBackground(BuildContext context) {
    final gc = context.gc;
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) => StatefulBuilder(
        builder: (sheet, setSheet) {
          final photo = fit.bgPhotoPath;
          return Container(
            padding: sheetPad(sheet),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SheetHandle(),
                  const SizedBox(height: 16),
                  SheetTitle(t.background),
                  const SizedBox(height: 14),
                  OptionGroup([
                    for (final (pattern, icon) in const [
                      ('none', PhosphorIconsRegular.square),
                      ('dots', PhosphorIconsRegular.dotsNine),
                      ('grid', PhosphorIconsRegular.gridFour),
                    ])
                      OptionItem(
                        _bgName(pattern),
                        icon: icon,
                        selected: fit.bgPattern == pattern,
                        onTap: () => setSheet(() => fit.setBgPattern(pattern)),
                      ),
                    if (photo != null)
                      OptionItem(
                        t.bgPhoto,
                        selected: fit.bgPattern == 'photo',
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: FileThumb(photo,
                              width: 26,
                              height: 20,
                              errorBuilder: (_, _, _) => const SizedBox(width: 26, height: 20)),
                        ),
                        onTap: () => setSheet(() => fit.setBgPattern('photo')),
                      ),
                  ]),
                  const SizedBox(height: 16),
                  if (photo != null) ...[
                    Text(t.bgDim,
                        style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                    const SizedBox(height: 8),
                    Center(
                      child: SegToggle([
                        SegOption(t.dimSoft, fit.bgDim < 0.5, () => setSheet(() => fit.setBgDim(0.4))),
                        SegOption(t.dimMedium, fit.bgDim >= 0.5 && fit.bgDim < 0.65,
                            () => setSheet(() => fit.setBgDim(0.55))),
                        SegOption(t.dimStrong, fit.bgDim >= 0.65, () => setSheet(() => fit.setBgDim(0.72))),
                      ]),
                    ),
                    const SizedBox(height: 14),
                  ],
                  GhostButton(
                    label: photo == null ? t.bgPhotoPick : t.bgPhotoChange,
                    icon: PhosphorIconsRegular.image,
                    onTap: () async {
                      await _pickBackground();
                      setSheet(() {});
                    },
                  ),
                  if (photo != null) ...[
                    const SizedBox(height: 6),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setSheet(fit.clearBgPhoto),
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        child: Text(t.bgPhotoRemove,
                            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(t.bgPhotoHint,
                      textAlign: TextAlign.center,
                      style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                  const SizedBox(height: 16),
                  PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickBackground() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      final path = result?.files.single.path;
      if (path != null) await fit.setBgPhoto(path);
    } catch (_) {}
  }

  void _editLanguage(BuildContext context) {
    showAppSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LanguageSheet(),
    );
  }

  void _editAlarmSound(BuildContext context) {
    showAppSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _AlarmSoundSheet(
        onPreview: () => RestAlarm.instance.preview(),
        onChoose: () async {
          Navigator.of(context).pop();
          await _pickAlarmSound(context);
        },
        onReset: fit.alarmSound == null
            ? null
            : () async {
                Navigator.of(context).pop();
                await fit.clearAlarmSound();
                if (context.mounted) _snack(context, t.alarmChangedDefault);
              },
      ),
    );
  }

  Future<void> _pickAlarmSound(BuildContext context) async {
    String? path;
    String? name;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: AlarmStore.audioExtensions,
      );
      if (result == null) return;
      final picked = result.files.single;
      path = picked.path;
      name = picked.name;
    } catch (_) {
      path = null;
    }
    if (!context.mounted) return;
    if (path == null) {
      _snack(context, t.alarmInvalid);
      return;
    }

    final dur = await RestAlarm.instance.probeDuration(path);
    if (!context.mounted) return;
    if (dur == null) {
      _snack(context, t.alarmInvalid);
      return;
    }
    if (dur > AlarmStore.maxDuration) {
      _snack(context, t.alarmTooLong);
      return;
    }
    final basename = await AlarmStore.importSound(path);
    if (!context.mounted) return;
    if (basename == null) {
      _snack(context, t.alarmInvalid);
      return;
    }
    final display = _prettyName(name ?? basename);
    fit.setAlarmSound(basename, display);
    _snack(context, t.alarmChanged(display));
  }

  String _prettyName(String fileName) {
    final slash = fileName.replaceAll('\\', '/');
    final base = slash.contains('/') ? slash.substring(slash.lastIndexOf('/') + 1) : slash;
    final dot = base.lastIndexOf('.');
    final noExt = dot > 0 ? base.substring(0, dot) : base;
    return noExt.length > 28 ? '${noExt.substring(0, 27)}…' : noExt;
  }


  void _snack(BuildContext context, String msg) {
    showNotchToast(context, msg, icon: PhosphorIconsFill.checkCircle, accent: context.gc.sage);
  }
}

class _LanguageSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.66),
      padding: sheetPad(context),
      decoration: BoxDecoration(
        color: context.gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(t.languageLabel),
          const SizedBox(height: 14),
          Flexible(
            child: OptionGroup(
              scroll: true,
              [
                for (final code in appLanguages)
                  OptionItem(
                    languageNameOf(code),
                    selected: fit.language == code,
                    onTap: () {
                      fit.setLanguage(code);
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlarmSoundSheet extends StatelessWidget {
  const _AlarmSoundSheet({required this.onPreview, required this.onChoose, this.onReset});

  final VoidCallback onPreview;
  final VoidCallback onChoose;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    final current = fit.alarmSoundName ?? t.alarmDefaultName;
    return Container(
      padding: sheetPad(context),
      decoration: BoxDecoration(
        color: context.gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(t.alarmSound, subtitle: '$current · ${t.alarmSoundHint}'),
          const SizedBox(height: 14),
          OptionGroup([
            OptionItem(t.alarmPreview, icon: PhosphorIconsRegular.play, onTap: onPreview),
            OptionItem(t.alarmChoose, icon: PhosphorIconsRegular.uploadSimple, onTap: onChoose),
            if (onReset != null)
              OptionItem(t.alarmReset, icon: PhosphorIconsRegular.arrowCounterClockwise, onTap: onReset!),
          ]),
        ],
      ),
    );
  }
}

void showProfileSheet(BuildContext context) {
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ProfileSheet(),
  );
}

class _ProfileSheet extends StatefulWidget {
  const _ProfileSheet();
  @override
  State<_ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<_ProfileSheet> {
  late final TextEditingController _name = TextEditingController(text: fit.profile.name);
  late final TextEditingController _handle = TextEditingController(text: fit.profile.handle);

  @override
  void dispose() {
    _name.dispose();
    _handle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final p = fit.profile;
    final sheet = fit.dark ? Color.lerp(gc.bg, gc.bgRaised, 0.55)! : gc.bg;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom + MediaQuery.paddingOf(context).bottom),
      decoration: BoxDecoration(
        color: sheet,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 20),
            Text(sentenceCase(t.yourProfile), style: AppTheme.f(24, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.4)),
            const SizedBox(height: 3),
            Text(t.autofills, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
            const SizedBox(height: 18),
            _top(gc, sheet),
            const SizedBox(height: 16),
            _group(gc, [
              _field(gc, t.nameLabel, TextField(
                controller: _name,
                style: AppTheme.f(15.5, weight: FontWeight.w600, color: gc.text),
                cursorColor: gc.accent,
                textCapitalization: TextCapitalization.words,
                onChanged: (v) => fit.updateProfile(name: v),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: kDefaultName,
                  hintStyle: AppTheme.f(15.5, weight: FontWeight.w600, color: gc.textTertiary),
                ),
              )),
              _field(gc, t.handleLabel, Row(children: [
                Text('@', style: AppTheme.f(15.5, weight: FontWeight.w700, color: gc.textTertiary)),
                const SizedBox(width: 3),
                Expanded(
                  child: TextField(
                    controller: _handle,
                    style: AppTheme.f(15.5, weight: FontWeight.w600, color: gc.text),
                    cursorColor: gc.accent,
                    onChanged: fit.setProfileHandle,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: fit.profileHandle,
                      hintStyle: AppTheme.f(15.5, weight: FontWeight.w600, color: gc.textTertiary),
                    ),
                  ),
                ),
              ])),
              _row(gc, t.pickBadge, _badgeDots(gc)),
            ]),
            const SizedBox(height: 12),
            _group(gc, [
              _row(gc, t.sexLabel, SegToggle([
                SegOption(t.male, p.sex == 'male', () => _up(() => fit.updateProfile(sex: 'male'))),
                SegOption(t.female, p.sex == 'female', () => _up(() => fit.updateProfile(sex: 'female'))),
              ])),
              _stepRow(gc, t.ageLabel, '${p.age}', () => _up(() => fit.updateProfile(ageDelta: -1)), () => _up(() => fit.updateProfile(ageDelta: 1)), edit: editAge),
              _stepRow(gc, t.heightLabel, fit.heightLabel(p.heightCm), () => _up(() => fit.updateProfile(heightDelta: -fit.heightStep)), () => _up(() => fit.updateProfile(heightDelta: fit.heightStep)), edit: editHeight),
              _stepRow(gc, t.weightLabel, fit.weightLabel(p.weightKg),
                  () => _up(() => fit.updateProfile(weightDelta: -fit.fromDisplayWeight(fit.isLb ? 1 : 0.5))),
                  () => _up(() => fit.updateProfile(weightDelta: fit.fromDisplayWeight(fit.isLb ? 1 : 0.5))),
                  edit: editBodyWeight),
              _stepRow(gc, t.weeklyGoal, '${p.weeklyGoal}×', () => _up(() => fit.updateProfile(weeklyGoalDelta: -1)), () => _up(() => fit.updateProfile(weeklyGoalDelta: 1))),
            ]),
            const SizedBox(height: 18),
            Padding(padding: const EdgeInsets.only(left: 4), child: _label(gc, t.activityLabel)),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _act(gc, t.activityName('Sedentary'), 1.2),
              _act(gc, t.activityName('Light'), 1.375),
              _act(gc, t.activityName('Moderate'), 1.55),
              _act(gc, t.activityName('Active'), 1.725),
            ]),
            const SizedBox(height: 24),
            PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }

  void _up(VoidCallback action) {
    action();
    setState(() {});
  }

  Widget _top(GymColors gc, Color sheet) {
    final banner = fit.profileBanner;
    final photo = fit.profilePhoto != null;
    Widget chip(IconData icon) => Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
          ),
          child: Icon(icon, size: 14, color: Colors.white),
        );
    Widget remove(String label, VoidCallback onTap) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(label, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
          ),
        );
    return SizedBox(
      height: 168,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 120,
            child: GestureDetector(
              onTap: _pickBanner,
              child: Container(
                decoration: BoxDecoration(
                  color: gc.bgRaised2,
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: banner == null ? kDefaultBanner : MemoryImage(banner),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10),
                child: chip(PhosphorIconsRegular.image),
              ),
            ),
          ),
          Positioned(
            left: 14,
            top: 74,
            child: GestureDetector(
              onTap: _pickPhoto,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: sheet, shape: BoxShape.circle),
                    child: ProfileAvatar(size: 82),
                  ),
                  Positioned(right: 0, bottom: 2, child: chip(PhosphorIconsRegular.camera)),
                ],
              ),
            ),
          ),
          Positioned(
            left: 118,
            right: 0,
            top: 128,
            child: Row(children: [
              if (photo) remove(t.removePhoto, () => _up(fit.clearProfilePhoto)),
              if (photo && banner != null) Text('  ·  ', style: AppTheme.f(12, color: gc.textTertiary)),
              if (banner != null) remove(t.removeCover, () => _up(fit.clearProfileBanner)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _group(GymColors gc, List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
      child: Column(children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) Container(height: 1, color: gc.text.withValues(alpha: 0.06)),
          rows[i],
        ],
      ]),
    );
  }

  Widget _field(GymColors gc, String label, Widget input) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label(gc, label),
        const SizedBox(height: 6),
        input,
      ]),
    );
  }

  Future<void> _pickBanner() async {
    final source = await pickPhotoSource(context);
    if (source == null) return;

    final shot = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 900,
      imageQuality: 82,
    );
    if (shot == null) return;
    final bytes = await shot.readAsBytes();
    if (!mounted) return;
    _up(() => fit.setProfileBanner(bytes));
  }

  Future<void> _pickPhoto() async {
    final source = await pickPhotoSource(context);
    if (source == null) return;

    final shot = await ImagePicker().pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (shot == null) return;
    final bytes = await shot.readAsBytes();
    if (!mounted) return;
    _up(() => fit.setProfilePhoto(bytes));
  }

  Widget _badgeDots(GymColors gc) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final id in kProfileBadges) ...[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _up(() => fit.setProfileBadge(id)),
            child: Semantics(
              button: true,
              selected: fit.profile.badge == id,
              label: t.badgeName(id),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(
                  PhosphorIconsFill.sealCheck,
                  size: fit.profile.badge == id ? 26 : 22,
                  color: fit.profile.badge == id
                      ? badgeColor(id)
                      : badgeColor(id).withValues(alpha: 0.32),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _label(GymColors gc, String t) =>
      Text(t.toUpperCase(),
          style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3));

  Widget _row(GymColors gc, String label, Widget control) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Row(
        children: [
          Expanded(child: Text(sentenceCase(label), style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text))),
          control,
        ],
      ),
    );
  }

  Widget _stepRow(GymColors gc, String label, String value, VoidCallback dec, VoidCallback inc,
      {Future<void> Function(BuildContext)? edit}) {
    return _row(
        gc,
        label,
        StepperControl(
          value: value,
          minWidth: 64,
          btnSize: 30,
          gap: 12,
          fontSize: 15,
          onDec: dec,
          onInc: inc,
          onEdit: edit == null ? null : () => edit(context).then((_) => _up(() {})),
        ));
  }

  Widget _act(GymColors gc, String label, double v) {
    final active = fit.profile.activity == v;
    return Pill(
      label: label,
      bg: active ? gc.text : gc.bgRaised,
      fg: active ? gc.bg : gc.textSecondary,
      onTap: () => _up(() => fit.updateProfile(activity: v)),
      hPad: 12,
      vPad: 8,
      fontSize: 12,
    );
  }
}

class _Category {
  const _Category(this.id, this.icon, this.title, this.rows);

  final String id;
  final IconData icon;
  final String title;
  final List<(String, IconData)> rows;
}

String? _flashPending;

class _Flash extends StatefulWidget {
  const _Flash({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  State<_Flash> createState() => _FlashState();
}

class _FlashState extends State<_Flash> with SingleTickerProviderStateMixin {
  late final _glow = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 220), reverseDuration: const Duration(milliseconds: 900));
  Timer? _off;

  @override
  void initState() {
    super.initState();
    if (_flashPending != widget.label) return;
    _flashPending = null;
    _off = Timer(const Duration(milliseconds: 320), () async {
      if (!mounted) return;
      await Scrollable.ensureVisible(context,
          alignment: 0.4, duration: const Duration(milliseconds: 480), curve: Curves.easeOutCubic);
      if (!mounted) return;
      await _glow.forward();
      if (mounted) _glow.reverse();
    });
  }

  @override
  void dispose() {
    _off?.cancel();
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return AnimatedBuilder(
      animation: _glow,
      child: widget.child,
      builder: (context, child) {
        final v = _glow.value;
        if (v <= 0) return child!;
        return Stack(
          children: [
            Positioned(
              left: -8,
              right: -8,
              top: 4,
              bottom: 4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: gc.text.withValues(alpha: 0.05 * v),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: gc.text.withValues(alpha: 0.7 * v), width: 1.5),
                ),
              ),
            ),
            child!,
          ],
        );
      },
    );
  }
}

class _SettingsHome extends StatefulWidget {
  const _SettingsHome({required this.screen});

  final SettingsScreen screen;

  @override
  State<_SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<_SettingsHome> {
  final _query = TextEditingController();
  final _focus = FocusNode();
  final _scroll = ScrollController();
  static const _span = 96.0;
  static const _back = 36.0;
  static const _pill = 52.0;
  static const _titleSize = 32.0;
  static const _small = 0.56;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  double get _folded {
    if (!_scroll.hasClients) return 0;
    final v = (_scroll.offset / _span).clamp(0.0, 1.0);
    return Curves.easeInOut.transform(v);
  }

  Future<void> _openSearch() async {
    HapticFeedback.selectionClick();
    if (_scroll.hasClients && _scroll.offset > 0) {
      await _scroll.animateTo(0, duration: const Duration(milliseconds: 420), curve: Curves.easeOutCubic);
    }
    if (mounted) _focus.requestFocus();
  }

  @override
  void dispose() {
    _query.dispose();
    _focus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  static String _plain(String s) => s
      .toLowerCase()
      .replaceAll(RegExp('[áàä]'), 'a')
      .replaceAll(RegExp('[éèë]'), 'e')
      .replaceAll(RegExp('[íìï]'), 'i')
      .replaceAll(RegExp('[óòö]'), 'o')
      .replaceAll(RegExp('[úùü]'), 'u');

  void _go(_Category c, String? row) {
    _focus.unfocus();
    _flashPending = row;
    SettingsScreen._openCategory(c.id);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final cats = widget.screen._categories();
    final q = _plain(_query.text.trim());
    final searching = q.isNotEmpty || _focus.hasFocus;
    final hits = <(_Category, String, IconData)>[
      if (q.isNotEmpty)
        for (final c in cats)
          for (final r in c.rows)
            if (_plain(r.$1).contains(q) || _plain(c.title).contains(q)) (c, r.$1, r.$2),
    ];

    final pad = MediaQuery.paddingOf(context).top;
    final titleTop = pad + 12 + _back + 18;
    final pillTop = titleTop + _titleSize * 1.05 + 18;

    return RiseScope(
      id: 'settings',
      once: false,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _focus.unfocus,
        child: Stack(
          children: [
            SingleChildScrollView(
            key: const PageStorageKey('settings-home'),
            controller: _scroll,
            clipBehavior: Clip.none,
            padding: EdgeInsets.fromLTRB(20, pillTop + _pill + 18, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: riseAll([
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, a) => FadeTransition(
                    opacity: a,
                    child: SlideTransition(
                      position: Tween(begin: const Offset(0, 0.02), end: Offset.zero).animate(a),
                      child: child,
                    ),
                  ),
                  child: searching
                      ? _results(gc, hits, q.isEmpty)
                      : Column(
                          key: const ValueKey('cats'),
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (final (g, label) in [
                              (const {'general', 'training', 'alerts'}, t.settingsGroupApp),
                              (const {'home', 'widgets', 'beta'}, t.settingsGroupHome),
                              (const {'data', 'support', 'about'}, t.settingsGroupData),
                            ]) ...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 6, 0, 10),
                                child: Text(label.toUpperCase(),
                                    style: AppTheme.f(10.5,
                                        weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                              ),
                              for (final c in cats.where((c) => g.contains(c.id))) ...[
                                Rise(index: cats.indexOf(c) + 2, child: _bubble(gc, c)),
                                const SizedBox(height: 10),
                              ],
                              const SizedBox(height: 12),
                            ],
                          ],
                        ),
                ),
              ]),
            ),
          ),
            Positioned.fill(child: IgnorePointer(child: _bar(pad))),
            _header(gc, pad, titleTop, pillTop),
          ],
        ),
      ),
    );
  }

  Widget _bar(double pad) {
    final blur = EdgeBlur(height: pad + 64, sigma: 14);
    return AnimatedBuilder(
      animation: _scroll,
      builder: (context, _) {
        final p = _folded;
        if (p <= 0.001) return const SizedBox.shrink();
        return Align(alignment: Alignment.topCenter, child: Opacity(opacity: p, child: blur));
      },
    );
  }

  Widget _header(GymColors gc, double pad, double titleTop, double pillTop) {
    return Positioned.fill(
      child: LayoutBuilder(builder: (context, box) {
        final w = box.maxWidth;
        return AnimatedBuilder(
          animation: _scroll,
          builder: (context, _) {
            final p = _folded;
            final blur = math.sin(p * math.pi) * 5;
            final scale = 1 - (1 - _small) * p;
            final titleH = _titleSize * 1.05;
            final small = pad + 12 + _back / 2 - titleH * _small / 2;
            final pillX = 20 + (w - 20 - _back - 20) * p;
            final pillY = pillTop + (pad + 12 - pillTop) * p;
            final pillW = (w - 40) + (_back - (w - 40)) * p;
            final pillH = _pill + (_back - _pill) * p;
            return Stack(
              children: [
                Positioned(
                  left: 20,
                  top: pad + 12,
                  child: RoundBtn(icon: Ic.chevronLeft, onTap: fit.backFromPreferences),
                ),
                Positioned(
                  left: 20 + (_back + 12) * p,
                  top: titleTop + (small - titleTop) * p,
                  child: IgnorePointer(
                    child: Transform.scale(
                      scale: scale,
                      alignment: Alignment.topLeft,
                      child: ImageFiltered(
                        enabled: blur > 0.3,
                        imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                        child: Text(titleCase(t.settings),
                            style: AppTheme.f(_titleSize,
                                weight: FontWeight.w800, color: gc.text, letterSpacing: -0.9, height: 1.05)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: pillX,
                  top: pillY,
                  width: pillW,
                  height: pillH,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    decoration: BoxDecoration(
                      color: gc.bgRaised,
                      borderRadius: BorderRadius.circular(pillH / 2),
                      border: Border.all(color: gc.text.withValues(alpha: _focus.hasFocus ? 0.16 : 0)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        IgnorePointer(
                          ignoring: p > 0.5,
                          child: Opacity(
                            opacity: (1 - p / 0.6).clamp(0.0, 1.0),
                            child: OverflowBox(
                              alignment: Alignment.centerLeft,
                              minWidth: w - 40,
                              maxWidth: w - 40,
                              child: _search(gc),
                            ),
                          ),
                        ),
                        if (p > 0.45)
                          Positioned.fill(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: _openSearch,
                              child: Opacity(
                                opacity: ((p - 0.45) / 0.55).clamp(0.0, 1.0),
                                child: Icon(PhosphorIconsRegular.magnifyingGlass, size: 16, color: gc.text),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _circle(GymColors gc, IconData icon, {double size = 40}) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.09), shape: BoxShape.circle),
        child: Icon(icon, size: size * 0.48, color: gc.text),
      );

  Widget _search(GymColors gc) {
    final on = _focus.hasFocus;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.magnifyingGlass, size: 18, color: on ? gc.text : gc.textTertiary),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _query,
              focusNode: _focus,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.search,
              style: AppTheme.f(16, weight: FontWeight.w500, color: gc.text),
              cursorColor: gc.text,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: t.settingsSearch,
                hintStyle: AppTheme.f(16, weight: FontWeight.w500, color: gc.textTertiary),
              ),
            ),
          ),
          AnimatedScale(
            scale: _query.text.isEmpty ? 0 : 1,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            child: GestureDetector(
              onTap: () => setState(_query.clear),
              child: Icon(PhosphorIconsRegular.xCircle, size: 20, color: gc.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(GymColors gc, _Category c) {
    return Pressable(
      onTap: () => _go(c, null),
      scale: 0.975,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
        child: Row(
          children: [
            _circle(gc, c.icon),
            const SizedBox(width: 14),
            Expanded(
              child: Text(c.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(16, weight: FontWeight.w600, color: gc.text)),
            ),
            Icon(PhosphorIconsRegular.caretRight, size: 16, color: gc.textTertiary),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }

  Widget _results(GymColors gc, List<(_Category, String, IconData)> hits, bool empty) {
    if (empty) return const SizedBox(key: ValueKey('blank'), height: 200);
    if (hits.isEmpty) {
      return Padding(
        key: const ValueKey('none'),
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
        child: Text(t.settingsNoResults, style: AppTheme.f(15, weight: FontWeight.w500, color: gc.textSecondary)),
      );
    }
    return Column(
      key: ValueKey('hits${hits.length}'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < hits.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          Pressable(
            onTap: () => _go(hits[i].$1, hits[i].$2),
            scale: 0.975,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  _circle(gc, hits[i].$3, size: 38),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hits[i].$2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(16, weight: FontWeight.w600, color: gc.text)),
                        Text(hits[i].$1.title,
                            style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
