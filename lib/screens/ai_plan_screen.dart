import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../services/plan_share.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/ui_kit.dart';
import 'plan_import_sheet.dart';

class AiPlanScreen extends StatefulWidget {
  const AiPlanScreen({super.key});

  @override
  State<AiPlanScreen> createState() => _AiPlanScreenState();
}

class _AiPlanScreenState extends State<AiPlanScreen> {
  final TextEditingController _answer = TextEditingController();
  List<String> _missed = const [];
  int _added = 0;
  int _routines = 0;
  bool _unreadable = false;
  bool _format = false;

  @override
  void dispose() {
    _answer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(title: t.aiRoutine, onBack: fit.backFromAiPlan, titleSize: 22),
            const SizedBox(height: 20),
            SoftCard(
              radius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(PhosphorIconsRegular.shieldCheck, size: 18, color: gc.sage),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(t.fullyOffline.toUpperCase(),
                          style: AppTheme.f(12, weight: FontWeight.w700, color: gc.sage, letterSpacing: 1.4)),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Text(t.aiIntro,
                      style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.5)),
                  const SizedBox(height: 18),
                  for (var i = 0; i < _steps.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    _step(gc, i + 1, _steps[i]),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(label: t.copyForAi, onTap: _copy),
            const SizedBox(height: 10),
            GhostButton(label: t.shareAsFile, icon: PhosphorIconsRegular.shareNetwork, onTap: _export),
            const SizedBox(height: 24),
            TextField(
              controller: _answer,
              minLines: 8,
              maxLines: 16,
              keyboardType: TextInputType.multiline,
              onChanged: (_) => setState(() {}),
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.text, height: 1.35),
              cursorColor: gc.accent,
              decoration: InputDecoration(
                hintText: t.aiPasteHint,
                hintStyle: AppTheme.f(14, weight: FontWeight.w500, color: gc.textTertiary),
                filled: true,
                fillColor: gc.bgRaised,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 10),
            Row(children: [
              _chip(gc, PhosphorIconsRegular.clipboardText, t.pasteAction, _paste),
              const SizedBox(width: 8),
              _chip(gc, PhosphorIconsRegular.fileArrowUp, t.chooseFile, _file),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _format = !_format),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Text(t.showFormat,
                        textAlign: TextAlign.end,
                        style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.accent)),
                  ),
                ),
              ),
            ]),
            if (_format) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(16)),
                child: SelectableText(FitState.planTemplate,
                    style: TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: gc.textSecondary, height: 1.4)),
              ),
            ],
            const SizedBox(height: 14),
            PrimaryButton(
              label: t.importAction,
              bg: _answer.text.trim().isEmpty ? gc.bgRaised2 : gc.ember,
              fg: _answer.text.trim().isEmpty ? gc.textTertiary : gc.onEmber,
              onTap: _import,
            ),
            if (_unreadable || _added > 0 || _missed.isNotEmpty) ...[
              const SizedBox(height: 18),
              _result(gc),
            ],
          ],
        ),
      ),
    );
  }

  List<String> get _steps => [t.aiStepCopy, t.aiStepAsk, t.aiStepPaste];

  Widget _chip(GymColors gc, IconData icon, String label, VoidCallback onTap) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 15, color: gc.text),
            const SizedBox(width: 7),
            Text(label, style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.text)),
          ]),
        ),
      );

  Widget _step(GymColors gc, int n, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: gc.emberSoft, shape: BoxShape.circle),
          child: Text('$n', style: AppTheme.f(12, weight: FontWeight.w700, color: gc.ember)),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Text(text, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.text, height: 1.45))),
      ],
    );
  }

  Widget _result(GymColors gc) {
    final good = _added > 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: good ? gc.sage : gc.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _unreadable
                ? t.planFailed
                : good
                    ? '${t.routinesAdded(_routines)} · ${t.exerciseCount(_added)}'
                    : t.planNothing,
            style: AppTheme.f(13.5, weight: FontWeight.w600, color: good ? gc.sage : gc.text),
          ),
          if (_missed.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(t.aiMissing(_missed.length),
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
            const SizedBox(height: 4),
            Text(_missed.join(' · '),
                style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
          ],
          if (good) ...[
            const SizedBox(height: 10),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: fit.backFromAiPlan,
              child: Text(t.routines, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.accent)),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: fit.planRequestText()));
    if (!mounted) return;
    showNotchToast(context, t.copiedDone,
        subtitle: t.aiStepAsk, icon: PhosphorIconsFill.copy, accent: context.gc.sage);
  }

  Future<void> _export() async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/gymmane-exercises.txt');
      await file.writeAsString(fit.planRequestText());
      if (!mounted) return;
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], subject: 'GymMane exercises'),
      );
    } catch (_) {}
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null || text.trim().isEmpty || !mounted) return;
    setState(() => _answer.text = text);
  }

  Future<void> _file() async {
    final text = await pickTextFile();
    if (text == null || !mounted) return;
    setState(() => _answer.text = text);
  }

  void _import() {
    final raw = _answer.text;
    if (raw.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    final plans = parsePlan(raw);
    if (plans.isEmpty) {
      setState(() {
        _unreadable = true;
        _added = 0;
        _routines = 0;
        _missed = const [];
      });
      return;
    }
    final outcome = fit.applyPlan(plans, schedule: fit.weeklyPlan.isEmpty);
    setState(() {
      _unreadable = false;
      _added = outcome.added;
      _routines = outcome.routines;
      _missed = outcome.missed;
    });
  }
}
