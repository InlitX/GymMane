import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class AiPlanScreen extends StatefulWidget {
  const AiPlanScreen({super.key});

  @override
  State<AiPlanScreen> createState() => _AiPlanScreenState();
}

class _AiPlanScreenState extends State<AiPlanScreen> {
  List<String> _missed = const [];
  int _added = 0;
  bool _unreadable = false;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
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
                          style: AppTheme.f(12,
                              weight: FontWeight.w700, color: gc.sage, letterSpacing: 1.4)),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Text(t.aiIntro, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.5)),
                  const SizedBox(height: 18),
                  for (var i = 0; i < _steps.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    _step(gc, i + 1, _steps[i]),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(label: t.exportCatalog, icon: Ic.layers, onTap: _export),
            const SizedBox(height: 10),
            GhostButton(
              label: t.importRoutine,
              icon: PhosphorIconsRegular.clipboardText,
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

  List<String> get _steps => [t.aiStep1, t.aiStep2, t.aiStep3, t.aiStep4];

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
        Expanded(child: Text(text, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.text, height: 1.45))),
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
                    ? t.planImported(_added)
                    : t.planNothing,
            style: AppTheme.f(13.5, weight: FontWeight.w600, color: good ? gc.sage : gc.text),
          ),
          if (_missed.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(t.aiMissing(_missed.length),
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
            const SizedBox(height: 4),
            Text(_missed.join(' · '), style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
          ],
        ],
      ),
    );
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

  Future<void> _import() async {
    String? raw;
    try {
      final result = await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      final picked = result.files.single;
      final bytes =
          picked.bytes ?? (picked.path == null ? null : await File(picked.path!).readAsBytes());
      if (bytes != null) raw = utf8.decode(bytes, allowMalformed: true);
    } catch (_) {
      raw = null;
    }
    if (!mounted) return;
    if (raw == null) {
      setState(() {
        _unreadable = true;
        _added = 0;
        _missed = const [];
      });
      return;
    }
    final outcome = fit.importPlan(raw);
    setState(() {
      _unreadable = !outcome.readable;
      _added = outcome.added;
      _missed = outcome.missed;
    });
  }
}
