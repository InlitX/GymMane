import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/plan_pdf.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

void showReportSheet(BuildContext context) {
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const ReportSheet(),
  );
}

class ReportSheet extends StatefulWidget {
  const ReportSheet({super.key});

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  static const _presets = [30, 90, 365];
  int _preset = 30;
  late DateTimeRange _range = _last(30);
  bool _busy = false;

  static DateTimeRange _last(int days) {
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day);
    return DateTimeRange(start: end.subtract(Duration(days: days - 1)), end: end);
  }

  String _presetLabel(int d) => switch (d) {
        30 => t.days30,
        90 => t.days90,
        _ => t.days365,
      };

  Future<void> _pickRange() async {
    final now = DateTime.now();
    final first = fit.sessions.isEmpty ? DateTime(now.year - 1) : fit.sessions.first.day;
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(first.year, first.month, first.day).subtract(const Duration(days: 365)),
      lastDate: DateTime(now.year, now.month, now.day),
      initialDateRange: _range,
      helpText: t.reportPickRange,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _preset = 0;
      _range = picked;
    });
  }

  Future<void> _share({required bool pdf}) async {
    if (_busy) return;
    setState(() => _busy = true);
    HapticFeedback.mediumImpact();
    await shareReport(fit.rangeReport(_range.start, _range.end), pdf: pdf, csv: !pdf);
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final r = fit.rangeReport(_range.start, _range.end);
    Widget stat(String label, String value) => Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FitText(label, style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textSecondary, letterSpacing: 0.4)),
              const SizedBox(height: 3),
              FitText(value, style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
            ]),
          ),
        );
    Widget line(IconData icon, String text) => Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(children: [
            Icon(icon, size: 15, color: gc.textSecondary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text, height: 1.3)),
            ),
          ]),
        );
    final food = r.food;
    return Container(
      padding: sheetPad(context),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.88),
      decoration: sheetDecoration(gc),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(t.reportTitle, subtitle: t.reportHint),
          const SizedBox(height: 16),
          Center(
            child: SegToggle([
              for (final d in _presets)
                SegOption(_presetLabel(d), _preset == d, () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _preset = d;
                    _range = _last(d);
                  });
                }),
              SegOption(t.reportCustom, _preset == 0, _pickRange),
            ]),
          ),
          const SizedBox(height: 14),
          Semantics(
            button: true,
            label: t.reportPickRange,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _pickRange,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Flexible(
                    child: Text(reportRangeLabel(r),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
                  ),
                  const SizedBox(width: 8),
                  Icon(PhosphorIconsRegular.calendarBlank, size: 16, color: gc.textSecondary),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (r.empty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(t.reportEmpty,
                  textAlign: TextAlign.center, style: AppTheme.s(13, color: gc.textSecondary, height: 1.4)),
            )
          else ...[
            Row(children: [
              stat(t.reportWorkouts, '${r.sessions}'),
              const SizedBox(width: 8),
              stat(t.setsCaps, '${r.sets}'),
              const SizedBox(width: 8),
              stat(t.volume, fit.volumeLabel(r.volume)),
            ]),
            if (r.records.isNotEmpty) line(PhosphorIconsRegular.trophy, t.reportRecordsLine(r.records.length)),
            if (r.lifts.isNotEmpty) line(PhosphorIconsRegular.barbell, t.reportLiftsLine(r.lifts.length)),
            if (r.weightFrom != null && r.weightTo != null)
              line(PhosphorIconsRegular.scales, '${fit.weightLabel(r.weightFrom!)} → ${fit.weightLabel(r.weightTo!)}'),
            if (food != null)
              line(PhosphorIconsRegular.forkKnife,
                  t.reportFoodLine('${fit.energyOf(food.kcal)} ${fit.energyUnit}', food.protein.round(), food.days)),
            if (r.sleep != null || r.energy != null)
              line(PhosphorIconsRegular.moon, [
                if (r.sleep != null) '${t.checkInSleep} ${decimalText(r.sleep!.toStringAsFixed(1))}',
                if (r.energy != null) '${t.checkInEnergy} ${decimalText(r.energy!.toStringAsFixed(1))}',
              ].join(' · ')),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 160),
              opacity: _busy ? 0.5 : 1,
              child: PrimaryButton(label: t.reportSharePdf, height: 52, onTap: () => _share(pdf: true)),
            ),
            const SizedBox(height: 10),
            GhostButton(
              label: food != null && r.sessions > 0 ? t.reportShareCsvBoth : t.reportShareCsv,
              icon: PhosphorIconsRegular.fileCsv,
              onTap: () => _share(pdf: false),
            ),
          ],
          const SizedBox(height: 4),
        ]),
      ),
    );
  }
}
