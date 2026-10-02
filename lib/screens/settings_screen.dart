import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../models/profile.dart';
import '../services/alarm_store.dart';
import '../services/backup_zip.dart';
import '../services/fitnotes_backup.dart';
import '../services/home_widget_bridge.dart';
import '../services/rest_alarm.dart';
import '../services/sqlite_reader.dart';
import '../services/workout_import.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_rulers.dart';
import '../widgets/dialogs.dart';
import '../widgets/entrance.dart';
import '../widgets/glass.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/timer_panel.dart';
import 'profile_screen.dart';
import 'strava_sheet.dart';
import '../widgets/ui_kit.dart';

const _kRepoUrl = 'https://github.com/InlitX/GymMane';
const _kBugUrl = '$_kRepoUrl/issues/new?labels=bug';
const _kFeatureUrl = '$_kRepoUrl/issues/new?labels=enhancement';
const _kKofiUrl = 'https://ko-fi.com/inlitx';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return RiseScope(
      id: 'settings',
      once: false,
      child: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: riseAll([
            ScreenHeader(title: t.settings, onBack: fit.backFromPreferences),
            const SizedBox(height: 20),
            _group(gc, t.sectionGeneral, [
              _choiceRow(
                context,
                gc,
                PhosphorIconsRegular.moon,
                t.theme,
                [
                  ('system', t.themeAuto, PhosphorIconsRegular.circleHalf),
                  ('dark', t.darkTheme, PhosphorIconsRegular.moon),
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
            ]),
            const SizedBox(height: 18),
            _group(gc, t.sectionTraining, [
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
            const SizedBox(height: 18),
            _group(gc, t.sectionAlerts, [
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
            const SizedBox(height: 18),
            _group(gc, t.sectionHome, [
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
                onTap: fit.toggleGamification,
                child: _prefRow(gc, PhosphorIconsRegular.medal, t.gamificationSetting,
                    TinySwitch(on: fit.gamification), hint: t.gamificationHint),
              ),
            ]),
            const SizedBox(height: 18),
            if (Platform.isAndroid || Platform.isIOS) ...[
              _sectionLabel(gc, t.sectionWidgets),
              const SizedBox(height: 8),
              _linkGroup(gc, [
                (PhosphorIconsRegular.squaresFour, t.addActivityWidget, () => _addWidget(context, 'HeatmapWidgetProvider')),
                (PhosphorIconsRegular.chartBar, t.addStatsWidget, () => _addWidget(context, 'StatsWidgetProvider')),
                (PhosphorIconsRegular.person, t.addBodyWidget, () => _addWidget(context, 'BodyWidgetProvider')),
                (PhosphorIconsRegular.checkCircle, t.addTodayWidget, () => _addWidget(context, 'TodayWidgetProvider')),
                (PhosphorIconsRegular.calendarCheck, t.addWeekWidget, () => _addWidget(context, 'WeekWidgetProvider')),
              ]),
              const SizedBox(height: 18),
            ],
            _sectionLabel(gc, t.sectionData),
            const SizedBox(height: 8),
            _linkGroup(gc, [
              (PhosphorIconsRegular.fileCsv, t.exportCsv, () => _exportCsv(context)),
              (PhosphorIconsRegular.fileZip, t.exportBackup, () => _exportBackup(context)),
              (PhosphorIconsRegular.downloadSimple, t.importBackup, () => _importBackup(context)),
              (PhosphorIconsRegular.arrowSquareIn, t.importFromApp, () => _openImportApps(context)),
              (PhosphorIconsRegular.export, t.stravaRow, () => showStravaSheet(context)),
              (PhosphorIconsRegular.trash, t.resetData, () => _resetAll(context)),
            ], danger: 5),
            const SizedBox(height: 18),
            _sectionLabel(gc, t.support),
            const SizedBox(height: 8),
            _linkGroup(gc, [
              (PhosphorIconsRegular.bug, t.reportBug, () => _open(context, _kBugUrl)),
              (PhosphorIconsRegular.lightbulb, t.requestFeature, () => _open(context, _kFeatureUrl)),
              (PhosphorIconsRegular.githubLogo, t.starOnGithub, () => _open(context, _kRepoUrl)),
              (PhosphorIconsRegular.coffee, t.buyCoffee, () => _open(context, _kKofiUrl)),
            ]),
            const SizedBox(height: 22),
            _linkGroup(gc, [
              (PhosphorIconsRegular.info, t.aboutGymmane, fit.goAbout),
            ]),
          ]),
        ),
      ),
      ),
    );
  }

  Widget _group(GymColors gc, String label, List<Widget> rows) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionLabel(gc, label),
          const SizedBox(height: 8),
          SoftCard(
            radius: 20,
            borderColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: rows),
          ),
        ],
      );

  Widget _sectionLabel(GymColors gc, String t) =>
      Text(t.toUpperCase(),
          style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3));

  Widget _prefRow(GymColors gc, IconData icon, String label, Widget control, {String? hint}) {
    if (hint == null) {
      return SizedBox(
        height: 52,
        child: Row(
          children: [
            _rowIcon(gc, icon),
            Expanded(child: Text(label, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text))),
            const SizedBox(width: 12),
            control,
          ],
        ),
      );
    }
    return ConstrainedBox(
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
                  Text(label, style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
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
    );
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
        child: SizedBox(
          width: 22,
          child: Icon(icon, size: 19, color: color ?? gc.textSecondary),
        ),
      );

  Widget _linkGroup(GymColors gc, List<(IconData, String, VoidCallback)> items, {int? danger}) {
    return Container(
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: items[i].$3,
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: i < items.length - 1
                      ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.6)))
                      : null,
                ),
                child: Row(
                  children: [
                    _rowIcon(gc, items[i].$1, color: i == danger ? gc.danger : null),
                    Expanded(
                        child: Text(items[i].$2,
                            style: AppTheme.f(14.5,
                                weight: FontWeight.w500, color: i == danger ? gc.danger : gc.text))),
                    Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                  ],
                ),
              ),
            ),
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
    showAppSheet<void>(
      context: context,
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
              const SizedBox(height: 18),
              PrimaryButton(
                label: t.save,
                onTap: () {
                  fit.setSmartReminder(smart);
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
                          child: Image.file(File(photo),
                              width: 26,
                              height: 20,
                              fit: BoxFit.cover,
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
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom + MediaQuery.paddingOf(context).bottom),
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
            const SizedBox(height: 18),
            Text(t.yourProfile,
                textAlign: TextAlign.center,
                style: AppTheme.f(17, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 4),
            Text(t.autofills, textAlign: TextAlign.center, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
            const SizedBox(height: 20),
            Center(child: _photoPicker(gc)),
            const SizedBox(height: 18),
            _coverPicker(gc),
            const SizedBox(height: 20),
            _label(gc, t.nameLabel),
            const SizedBox(height: 8),
            TextField(
              controller: _name,
              style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text),
              cursorColor: gc.accent,
              textCapitalization: TextCapitalization.words,
              onChanged: (v) => fit.updateProfile(name: v),
              decoration: InputDecoration(
                hintText: kDefaultName,
                hintStyle: AppTheme.f(15, weight: FontWeight.w600, color: gc.textTertiary),
                filled: true,
                fillColor: gc.bgRaised2,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            _label(gc, t.handleLabel),
            const SizedBox(height: 8),
            TextField(
              controller: _handle,
              style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text),
              cursorColor: gc.accent,
              onChanged: fit.setProfileHandle,
              decoration: InputDecoration(
                filled: true,
                fillColor: gc.bgRaised2,
                hintText: fit.profileHandle,
                hintStyle: AppTheme.f(15, weight: FontWeight.w600, color: gc.textTertiary),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 6),
                  child: Text('@',
                      style: AppTheme.f(15, weight: FontWeight.w700, color: gc.textSecondary)),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            _row(gc, t.pickBadge, _badgeDots(gc)),
            const SizedBox(height: 12),
            _row(gc, t.sexLabel, SegToggle([
              SegOption(t.male, p.sex == 'male', () => _up(() => fit.updateProfile(sex: 'male'))),
              SegOption(t.female, p.sex == 'female', () => _up(() => fit.updateProfile(sex: 'female'))),
            ])),
            const SizedBox(height: 12),
            _stepRow(gc, t.ageLabel, '${p.age}', () => _up(() => fit.updateProfile(ageDelta: -1)), () => _up(() => fit.updateProfile(ageDelta: 1)), edit: editAge),
            const SizedBox(height: 12),
            _stepRow(gc, t.heightLabel, fit.heightLabel(p.heightCm), () => _up(() => fit.updateProfile(heightDelta: -fit.heightStep)), () => _up(() => fit.updateProfile(heightDelta: fit.heightStep)), edit: editHeight),
            const SizedBox(height: 12),
            _stepRow(gc, t.weightLabel, fit.weightLabel(p.weightKg),
                () => _up(() => fit.updateProfile(weightDelta: -fit.fromDisplayWeight(fit.isLb ? 1 : 0.5))),
                () => _up(() => fit.updateProfile(weightDelta: fit.fromDisplayWeight(fit.isLb ? 1 : 0.5))),
                edit: editBodyWeight),
            const SizedBox(height: 12),
            _stepRow(gc, t.weeklyGoal, '${p.weeklyGoal}×', () => _up(() => fit.updateProfile(weeklyGoalDelta: -1)), () => _up(() => fit.updateProfile(weeklyGoalDelta: 1))),
            const SizedBox(height: 12),
            _label(gc, t.activityLabel),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _act(gc, t.activityName('Sedentary'), 1.2),
              _act(gc, t.activityName('Light'), 1.375),
              _act(gc, t.activityName('Moderate'), 1.55),
              _act(gc, t.activityName('Active'), 1.725),
            ]),
            const SizedBox(height: 22),
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

  Widget _photoPicker(GymColors gc) {
    final has = fit.profilePhoto != null;
    return Column(
      children: [
        GestureDetector(
          onTap: _pickPhoto,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ProfileAvatar(size: 96),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: gc.ember,
                  shape: BoxShape.circle,
                  border: Border.all(color: gc.bgRaised, width: 2),
                ),
                child: Icon(PhosphorIconsFill.camera, size: 14, color: gc.onEmber),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: has ? () => _up(fit.clearProfilePhoto) : _pickPhoto,
          child: Text(
            has ? t.removePhoto : t.addPhoto,
            style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary),
          ),
        ),
      ],
    );
  }

  Widget _coverPicker(GymColors gc) {
    final bytes = fit.profileBanner;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(gc, t.coverLabel),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickBanner,
          child: Container(
            height: 96,
            decoration: BoxDecoration(
              color: gc.bgRaised2,
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: bytes == null ? kDefaultBanner : MemoryImage(bytes),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: GestureDetector(
            onTap: bytes == null ? _pickBanner : () => _up(fit.clearProfileBanner),
            child: Text(
              bytes == null ? t.addCover : t.removeCover,
              style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary),
            ),
          ),
        ),
      ],
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
    return SoftCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
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
      bg: active ? gc.ember : gc.bgRaised2,
      fg: active ? gc.onEmber : gc.textSecondary,
      onTap: () => _up(() => fit.updateProfile(activity: v)),
      hPad: 12,
      vPad: 8,
      fontSize: 12,
    );
  }
}
