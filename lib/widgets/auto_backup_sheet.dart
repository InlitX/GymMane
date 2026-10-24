import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/auto_backup.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'liquid_notch.dart';
import 'ui_kit.dart';

void showAutoBackupSheet(BuildContext context) {
  final gc = context.gc;
  final b = AutoBackup.instance;

  Future<void> choose(AutoBackupMode m) async {
    if (m != AutoBackupMode.off && !b.hasFolder && !await b.pickFolder()) return;
    b.setMode(m);
    if (m != AutoBackupMode.off && b.lastAt == null) await b.run();
  }

  Future<void> now(BuildContext sheet) async {
    if (!b.hasFolder && !await b.pickFolder()) return;
    final ok = await b.run(force: true);
    if (!sheet.mounted) return;
    showNotchToast(sheet, ok ? t.autoBackupSaved : t.autoBackupLost,
        icon: ok ? PhosphorIconsFill.checkCircle : PhosphorIconsFill.warningCircle,
        accent: ok ? sheet.gc.sage : sheet.gc.danger);
  }

  String status() {
    if (b.failed) return t.autoBackupLost;
    final at = b.lastAt;
    if (at == null) return t.autoBackupNever;
    return t.autoBackupLast(DateFormat.MMMd(intlLocale).add_Hm().format(at));
  }

  final modes = [
    (AutoBackupMode.off, t.autoBackupOff, null),
    (AutoBackupMode.workout, t.autoBackupWorkout, null),
    (AutoBackupMode.daily, t.autoBackupDaily, t.autoBackupOnLeave),
    (AutoBackupMode.weekly, t.autoBackupWeekly, t.autoBackupOnLeave),
  ];

  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => ListenableBuilder(
      listenable: b,
      builder: (sheet, _) {
        final i = AutoBackup.keepOptions.indexOf(b.keep);
        return Container(
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
              const SizedBox(height: 20),
              SheetTitle(t.autoBackup, subtitle: t.autoBackupHint),
              const SizedBox(height: 18),
              OptionGroup([
                for (final (m, label, detail) in modes)
                  OptionItem(label, detail: detail, selected: b.mode == m, onTap: () => choose(m)),
              ]),
              const SizedBox(height: 12),
              OptionGroup([
                OptionItem(
                  b.hasFolder && b.folderName.isNotEmpty ? b.folderName : t.autoBackupFolder,
                  icon: PhosphorIconsRegular.folderSimple,
                  detail: b.hasFolder ? status() : t.autoBackupNoFolder,
                  danger: b.failed,
                  trailing: Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                  onTap: b.pickFolder,
                ),
              ]),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(t.autoBackupKeep,
                        style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                  ),
                  StepperControl(
                    value: '${b.keep}',
                    onDec: () {
                      if (i > 0) b.setKeep(AutoBackup.keepOptions[i - 1]);
                    },
                    onInc: () {
                      if (i < AutoBackup.keepOptions.length - 1) b.setKeep(AutoBackup.keepOptions[i + 1]);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Center(
                child: b.running
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.4, color: gc.ember),
                        ),
                      )
                    : GhostButton(
                        label: t.autoBackupNow,
                        icon: PhosphorIconsRegular.fileZip,
                        onTap: () => now(sheet),
                      ),
              ),
              const SizedBox(height: 14),
              PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
            ],
          ),
        );
      },
    ),
  );
}
