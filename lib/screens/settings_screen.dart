import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
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
import '../widgets/profile_avatar.dart';
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
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenTitle(t.settings),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () => _editProfile(context),
              child: SoftCard(
                radius: 20,
                child: Row(children: [
                  ProfileAvatar(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fit.profile.name,
                            style: AppTheme.d(16, weight: FontWeight.w600, color: gc.text)),
                        const SizedBox(height: 2),
                        Text(t.levelStreak(fit.athleteLevel, fit.currentStreak),
                            style: AppTheme.s(13, color: gc.textSecondary)),
                      ],
                    ),
                  ),
                  Icon(PhosphorIconsRegular.pencilSimple, size: 18, color: gc.textSecondary),
                ]),
              ),
            ),
            const SizedBox(height: 22),
            _sectionLabel(gc, t.preferences),
            const SizedBox(height: 10),
            SoftCard(
              radius: 18,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _prefRow(gc, PhosphorIconsRegular.moonStars, t.theme, SegToggle([
                    SegOption(t.darkTheme, fit.dark, fit.setThemeDark),
                    SegOption(t.lightTheme, !fit.dark, fit.setThemeLight),
                  ])),
                  const SizedBox(height: 16),
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
                          style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary),
                        ),
                        const SizedBox(width: 6),
                        Icon(PhosphorIconsRegular.caretRight, size: 16, color: gc.textSecondary),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _prefRow(gc, PhosphorIconsRegular.scales, t.unitsLabel, SegToggle([
                    SegOption('kg', fit.units == 'kg', () => fit.setUnits('kg')),
                    SegOption('lb', fit.units == 'lb', () => fit.setUnits('lb')),
                  ])),
                  const SizedBox(height: 16),
                  _prefRow(
                    gc,
                    PhosphorIconsRegular.timer,
                    t.restTimer,
                    StepperControl(
                      value: '${fit.restSeconds}s',
                      minWidth: 48,
                      btnSize: 28,
                      gap: 10,
                      fontSize: 14,
                      onDec: () => fit.setRestSeconds(fit.restSeconds - 15),
                      onInc: () => fit.setRestSeconds(fit.restSeconds + 15),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _editAlarmSound(context),
                    child: _prefRow(
                      gc,
                      PhosphorIconsRegular.bellRinging,
                      t.alarmSound,
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 128),
                          child: Text(
                            fit.alarmSoundName ?? t.alarmDefaultName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(PhosphorIconsRegular.caretRight, size: 16, color: gc.textSecondary),
                      ]),
                    ),
                  ),
                  if (!fit.alarmAllowed) ...[
                    const SizedBox(height: 14),
                    _alarmWarning(context, gc),
                  ],
                  const SizedBox(height: 16),
                  _prefRow(gc, PhosphorIconsRegular.gridFour, t.background, SegToggle([
                    SegOption(t.bgNone, fit.bgPattern == 'none', () => fit.setBgPattern('none')),
                    SegOption(t.bgDots, fit.bgPattern == 'dots', () => fit.setBgPattern('dots')),
                    SegOption(t.bgGrid, fit.bgPattern == 'grid', () => fit.setBgPattern('grid')),
                  ], hPad: 11)),
                ],
              ),
            ),
            const SizedBox(height: 22),
            if (Platform.isAndroid) ...[
              _sectionLabel(gc, t.homeWidgets),
              const SizedBox(height: 10),
              _linkGroup(gc, [
                (PhosphorIconsRegular.squaresFour, t.addActivityWidget, () => _addWidget(context, 'HeatmapWidgetProvider')),
                (PhosphorIconsRegular.chartBar, t.addStatsWidget, () => _addWidget(context, 'StatsWidgetProvider')),
                (PhosphorIconsRegular.person, t.addBodyWidget, () => _addWidget(context, 'BodyWidgetProvider')),
              ]),
              const SizedBox(height: 22),
            ],
            _linkGroup(gc, [
              (PhosphorIconsRegular.mapPin, t.places, fit.goPlaces),
            ]),
            const SizedBox(height: 22),
            _sectionLabel(gc, t.data),
            const SizedBox(height: 10),
            _linkGroup(gc, [
              (PhosphorIconsRegular.table, t.exportCsv, () => _exportCsv(context)),
              (PhosphorIconsRegular.uploadSimple, t.exportBackup, () => _exportBackup(context)),
              (PhosphorIconsRegular.downloadSimple, t.importBackup, () => _importBackup(context)),
              (PhosphorIconsRegular.arrowSquareIn, t.importFromApp, () => _importFromApp(context)),
              (PhosphorIconsRegular.trash, t.resetData, () => _resetAll(context)),
            ]),
            const SizedBox(height: 22),
            _sectionLabel(gc, t.support),
            const SizedBox(height: 10),
            _linkGroup(gc, [
              (PhosphorIconsRegular.warningCircle, t.reportBug, () => _open(context, _kBugUrl)),
              (PhosphorIconsRegular.lightbulb, t.requestFeature, () => _open(context, _kFeatureUrl)),
              (PhosphorIconsRegular.githubLogo, t.starOnGithub, () => _open(context, _kRepoUrl)),
              (PhosphorIconsRegular.coffee, t.buyCoffee, () => _open(context, _kKofiUrl)),
            ]),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: fit.goAbout,
              child: SoftCard(
                radius: 18,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(PhosphorIconsRegular.info, size: 20, color: gc.textSecondary),
                    const SizedBox(width: 14),
                    Expanded(child: Text(t.aboutGymmane, style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text))),
                    Icon(PhosphorIconsRegular.caretRight, size: 16, color: gc.textSecondary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(GymColors gc, String t) =>
      Text(t, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 2));

  Widget _prefRow(GymColors gc, IconData icon, String label, Widget control) {
    return Row(
      children: [
        Icon(icon, size: 20, color: gc.textSecondary),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: AppTheme.s(14, color: gc.text))),
        control,
      ],
    );
  }

  Widget _linkGroup(GymColors gc, List<(IconData, String, VoidCallback)> items) {
    return Container(
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: items[i].$3,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: i < items.length - 1 ? Border(bottom: BorderSide(color: gc.border)) : null,
                ),
                child: Row(
                  children: [
                    Icon(items[i].$1, size: 20, color: gc.textSecondary),
                    const SizedBox(width: 14),
                    Expanded(child: Text(items[i].$2, style: AppTheme.s(14, color: gc.text))),
                    Icon(PhosphorIconsRegular.caretRight, size: 16, color: gc.textSecondary),
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
    final gc = context.gc;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.resetTitle, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.resetBody, style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(t.cancel, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text(t.resetConfirm, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
        ],
      ),
    );
    if (ok != true) return;
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
    final gc = context.gc;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.importBackup, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.importHint, style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(t.cancel, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text(t.chooseFile, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
        ],
      ),
    );
    if (ok != true) return;

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
                    style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 2),
                Text(t.alarmBlockedBody, style: AppTheme.s(11.5, color: gc.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(t.alarmBlockedAction,
              style: AppTheme.d(12, weight: FontWeight.w700, color: gc.accent, letterSpacing: 1)),
        ]),
      ),
    );
  }

  Future<void> _importFromApp(BuildContext context) async {
    // Se aceptan todos los ficheros y se mira el contenido: la copia de
    // FitNotes lleva una extensión rara y el selector de Android la escondería.
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

    // FitNotes: base de datos SQLite entera.
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
        // Strong exporta las medidas en un zip con un csv por medida.
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
    return showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.importUnitTitle, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.importUnitBody, style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text('kg', style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text('lb', style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
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
    await HomeWidgetBridge.update();
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

  void _editLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _LanguageSheet(),
    );
  }

  void _editAlarmSound(BuildContext context) {
    showModalBottomSheet(
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

  void _editProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _ProfileSheet(),
    );
  }

  void _snack(BuildContext context, String msg) {
    final gc = context.gc;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.onEmber)),
      backgroundColor: gc.ember,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      duration: const Duration(seconds: 2),
    ));
  }
}

class _SourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 18),
          _option(context, PhosphorIconsRegular.camera, t.takePhoto, ImageSource.camera),
          const SizedBox(height: 10),
          _option(context, PhosphorIconsRegular.image, t.chooseGallery, ImageSource.gallery),
        ],
      ),
    );
  }

  Widget _option(BuildContext context, IconData icon, String label, ImageSource source) {
    final gc = context.gc;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(source),
      child: SoftCard(
        radius: 16,
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(icon, size: 20, color: gc.textSecondary),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text))),
        ]),
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 18),
          Text(t.languageLabel,
              textAlign: TextAlign.center,
              style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 2)),
          const SizedBox(height: 18),
          for (final code in appLanguages) ...[
            _option(context, code),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _option(BuildContext context, String code) {
    final gc = context.gc;
    final active = fit.language == code;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        fit.setLanguage(code);
        Navigator.of(context).pop();
      },
      child: SoftCard(
        radius: 16,
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(
            child: Text(languageNameOf(code),
                style: AppTheme.s(14,
                    weight: FontWeight.w600, color: active ? gc.ember : gc.text)),
          ),
          if (active) Icon(PhosphorIconsFill.check, size: 16, color: gc.ember),
        ]),
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
    final gc = context.gc;
    final current = fit.alarmSoundName ?? t.alarmDefaultName;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 18),
          Text(t.alarmSound,
              textAlign: TextAlign.center,
              style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 2)),
          const SizedBox(height: 4),
          Text('$current · ${t.alarmSoundHint}',
              textAlign: TextAlign.center, style: AppTheme.s(12, color: gc.textSecondary)),
          const SizedBox(height: 18),
          _option(context, PhosphorIconsRegular.play, t.alarmPreview, onPreview),
          const SizedBox(height: 10),
          _option(context, PhosphorIconsRegular.uploadSimple, t.alarmChoose, onChoose),
          if (onReset != null) ...[
            const SizedBox(height: 10),
            _option(context, PhosphorIconsRegular.arrowCounterClockwise, t.alarmReset, onReset!),
          ],
        ],
      ),
    );
  }

  Widget _option(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    final gc = context.gc;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SoftCard(
        radius: 16,
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(icon, size: 20, color: gc.textSecondary),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text))),
        ]),
      ),
    );
  }
}

class _ProfileSheet extends StatefulWidget {
  const _ProfileSheet();
  @override
  State<_ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<_ProfileSheet> {
  late final TextEditingController _name = TextEditingController(text: fit.profile.name);

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final p = fit.profile;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 18),
            Text(t.yourProfile,
                textAlign: TextAlign.center,
                style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 2)),
            const SizedBox(height: 4),
            Text(t.autofills, textAlign: TextAlign.center, style: AppTheme.s(13, color: gc.textSecondary)),
            const SizedBox(height: 20),
            Center(child: _photoPicker(gc)),
            const SizedBox(height: 20),
            _label(gc, t.nameLabel),
            const SizedBox(height: 8),
            TextField(
              controller: _name,
              style: AppTheme.s(15, weight: FontWeight.w600, color: gc.text),
              cursorColor: gc.accent,
              textCapitalization: TextCapitalization.words,
              onChanged: (v) => fit.updateProfile(name: v),
              decoration: InputDecoration(
                filled: true,
                fillColor: gc.bgRaised2,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            _row(gc, t.sexLabel, SegToggle([
              SegOption(t.male, p.sex == 'male', () => _up(() => fit.updateProfile(sex: 'male'))),
              SegOption(t.female, p.sex == 'female', () => _up(() => fit.updateProfile(sex: 'female'))),
            ])),
            const SizedBox(height: 12),
            _stepRow(gc, t.ageLabel, '${p.age}', () => _up(() => fit.updateProfile(ageDelta: -1)), () => _up(() => fit.updateProfile(ageDelta: 1))),
            const SizedBox(height: 12),
            _stepRow(gc, t.heightLabel, '${fmt(p.heightCm)} cm', () => _up(() => fit.updateProfile(heightDelta: -1)), () => _up(() => fit.updateProfile(heightDelta: 1))),
            const SizedBox(height: 12),
            _stepRow(gc, t.weightLabel, fit.weightLabel(p.weightKg),
                () => _up(() => fit.updateProfile(weightDelta: -fit.fromDisplayWeight(fit.isLb ? 1 : 0.5))),
                () => _up(() => fit.updateProfile(weightDelta: fit.fromDisplayWeight(fit.isLb ? 1 : 0.5)))),
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
            style: AppTheme.s(12, weight: FontWeight.w600, color: gc.textSecondary),
          ),
        ),
      ],
    );
  }

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => _SourceSheet(),
    );
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

  Widget _label(GymColors gc, String t) =>
      Text(t, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 2));

  Widget _row(GymColors gc, String label, Widget control) {
    return SoftCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary)),
          control,
        ],
      ),
    );
  }

  Widget _stepRow(GymColors gc, String label, String value, VoidCallback dec, VoidCallback inc) {
    return _row(gc, label, StepperControl(value: value, minWidth: 64, btnSize: 30, gap: 12, fontSize: 15, onDec: dec, onInc: inc));
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
