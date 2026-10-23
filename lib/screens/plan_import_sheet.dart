import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../services/plan_share.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/glass.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/ui_kit.dart';

const _sample = '{ "name": "Push", "exercises": [ ... ] }';

Future<void> sharePlan(List<Routine> routines, {String? title}) async {
  if (routines.isEmpty) return;
  final name = title ?? fit.routineTitle(routines.first);
  try {
    final dir = await getTemporaryDirectory();
    final slug = name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    final file = File('${dir.path}/gymmane-${slug.isEmpty ? 'plan' : slug}.json');
    await file.writeAsString(fit.exportPlanJson(routines));
    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path, mimeType: 'application/json')],
      text: '${fit.planSummaryText(routines)}\n\n${t.shareMessage(name)}',
      subject: name,
    ));
  } catch (_) {}
}

Future<String?> pickTextFile() async {
  try {
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result == null) return null;
    final picked = result.files.single;
    final bytes = picked.bytes ?? (picked.path == null ? null : await File(picked.path!).readAsBytes());
    return bytes == null ? null : utf8.decode(bytes, allowMalformed: true);
  } catch (_) {
    return null;
  }
}

Future<void> showPlanImportSheet(BuildContext context, {String? text}) =>
    showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _PlanImportSheet(initial: text),
    );

class _PlanImportSheet extends StatefulWidget {
  const _PlanImportSheet({this.initial});

  final String? initial;

  @override
  State<_PlanImportSheet> createState() => _PlanImportSheetState();
}

class _PlanImportSheetState extends State<_PlanImportSheet> {
  late final TextEditingController _text = TextEditingController(text: widget.initial ?? '');
  late bool _field = widget.initial == null;
  List<PlanRoutine> _plans = const [];
  bool _schedule = false;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) _parse();
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _parse() {
    final plans = _text.text.trim().isEmpty ? const <PlanRoutine>[] : parsePlan(_text.text);
    setState(() {
      _plans = plans;
      _schedule = plans.any((p) => p.days.isNotEmpty) && fit.weeklyPlan.isEmpty;
    });
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null || text.trim().isEmpty) return;
    _text.text = text;
    _parse();
  }

  Future<void> _file() async {
    final text = await pickTextFile();
    if (text == null || !mounted) return;
    _text.text = text;
    setState(() => _field = false);
    _parse();
  }

  void _apply({bool copies = false}) {
    final result = fit.applyPlan(_plans, schedule: _schedule, copies: copies);
    final gc = context.gc;
    showNotchToast(
      context,
      result.routines > 0 ? t.routinesAdded(result.routines) : t.nothingToImport,
      subtitle: result.routines > 0 ? t.exerciseCount(result.added) : null,
      icon: result.routines > 0 ? PhosphorIconsFill.checkCircle : PhosphorIconsFill.warningCircle,
      accent: result.routines > 0 ? gc.sage : gc.warn,
    );
    Navigator.of(context).pop();
  }

  String _days(List<int> days) => days.map(t.weekdayShort).join(', ');

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final preview = _plans.isEmpty ? null : fit.previewPlan(_plans);
    final hasDays = _plans.any((p) => p.days.isNotEmpty);
    final allOwned = preview != null && preview.routines > 0 && preview.owned == preview.routines;
    return Container(
      padding: sheetPad(context).add(EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom)),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
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
            Text(titleCase(t.importRoutines), style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
            const SizedBox(height: 6),
            Text(t.importPasteHint,
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
            const SizedBox(height: 14),
            if (_field) ...[
              TextField(
                controller: _text,
                minLines: 4,
                maxLines: 8,
                onChanged: (_) => _parse(),
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.text, height: 1.35),
                cursorColor: gc.accent,
                decoration: InputDecoration(
                  hintText: _sample,
                  hintStyle: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textTertiary),
                  filled: true,
                  fillColor: gc.bgRaised2,
                  contentPadding: const EdgeInsets.all(14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 10),
              Row(children: [
                _action(gc, PhosphorIconsRegular.clipboardText, t.pasteAction, _paste),
                const SizedBox(width: 8),
                _action(gc, PhosphorIconsRegular.fileArrowUp, t.chooseFile, _file),
              ]),
            ],
            if (preview != null && preview.routines > 0) ...[
              const SizedBox(height: 18),
              Text('${t.routineCount(preview.routines)} · ${t.exerciseCount(preview.added)}'.toUpperCase(),
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3)),
              const SizedBox(height: 10),
              for (final p in _plans)
                if (p.items.isNotEmpty) _planCard(gc, p),
              if (preview.missed.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(t.aiMissing(preview.missed.length),
                    style: AppTheme.f(12, weight: FontWeight.w600, color: gc.warn)),
                const SizedBox(height: 4),
                Text(preview.missed.join(' · '),
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
              ],
              if (hasDays) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _schedule = !_schedule),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.useTheirSchedule,
                                style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                            const SizedBox(height: 2),
                            Text(t.useTheirScheduleHint,
                                style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      TinySwitch(on: _schedule),
                    ]),
                  ),
                ),
              ],
              if (allOwned) ...[
                const SizedBox(height: 12),
                Row(children: [
                  Icon(PhosphorIconsRegular.checkCircle, size: 16, color: gc.sage),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(t.importAlreadyHave,
                        style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary, height: 1.35)),
                  ),
                ]),
              ],
              const SizedBox(height: 16),
              if (allOwned)
                GhostButton(
                  label: t.importAsCopy,
                  icon: PhosphorIconsRegular.copy,
                  onTap: () => _apply(copies: true),
                )
              else
                PrimaryButton(label: t.addToMyRoutines, onTap: _apply),
            ] else if (_text.text.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(children: [
                Icon(PhosphorIconsRegular.warningCircle, size: 16, color: gc.warn),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(t.nothingToImport,
                      style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
                ),
              ]),
              if (!_field) ...[
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Pill(
                    label: t.pasteAction,
                    bg: gc.bgRaised2,
                    fg: gc.accent,
                    onTap: () => setState(() => _field = true),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _action(GymColors gc, IconData icon, String label, VoidCallback onTap) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 15, color: gc.text),
            const SizedBox(width: 7),
            Text(label, style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.text)),
          ]),
        ),
      );

  Widget _planCard(GymColors gc, PlanRoutine p) {
    final meta = [
      if (p.group.isNotEmpty) p.group,
      if (p.days.isNotEmpty) _days(p.days),
      t.exerciseCount(p.items.length),
    ].join(' · ');
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(11)),
          child: Icon(PhosphorIconsRegular.listChecks, size: 19, color: gc.ember),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.name.isEmpty ? t.newRoutineName : p.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 2),
              Text(meta,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary)),
            ],
          ),
        ),
        if (fit.ownsPlan(p)) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(color: gc.sageSoft, borderRadius: BorderRadius.circular(100)),
            child: Text(t.importOwned, style: AppTheme.f(11, weight: FontWeight.w700, color: gc.sage)),
          ),
        ],
      ]),
    );
  }
}
