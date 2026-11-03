import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/voice_coach.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

String _voiceSample() =>
    '${t.voiceRest(fit.voiceDuration(90))} ${t.voiceNext(t.catalogName('EIeI8Vf', 'Barbell Bench Press'), t.voiceLoad(8, fit.weightLabel(60)))}';

void showVoiceSheet(BuildContext context) {
  final gc = context.gc;
  final status = VoiceCoach.check(intlLocale);
  final points = [
    (PhosphorIconsRegular.timer, t.voicePointRest),
    (PhosphorIconsRegular.hourglassMedium, t.voicePointCount),
    (PhosphorIconsRegular.speakerHigh, t.voicePointPhone),
  ];
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => Container(
      padding: sheetPad(sheet),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 20),
          Text(t.voiceSheetTitle, textAlign: TextAlign.center, style: AppTheme.f(19, color: gc.text)),
          const SizedBox(height: 22),
          for (final (icon, text) in points)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 16, color: gc.accent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(text,
                        style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                  ),
                ],
              ),
            ),
          FutureBuilder<String>(
            future: status,
            builder: (_, snap) {
              final s = snap.data;
              if (s == null || s == 'ok') return const SizedBox(height: 12);
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(PhosphorIconsRegular.warningCircle, size: 16, color: gc.warn),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(s == 'noLang' ? t.voiceNoLang : t.voiceNoEngine,
                          style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.text, height: 1.4)),
                    ),
                  ],
                ),
              );
            },
          ),
          Center(
            child: Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, children: [
              const _TryButton(),
              GhostButton(
                label: t.voiceOpenSettings,
                icon: PhosphorIconsRegular.gear,
                onTap: VoiceCoach.openSettings,
              ),
            ]),
          ),
          const SizedBox(height: 16),
          PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
        ],
      ),
    ),
  );
}

class _TryButton extends StatefulWidget {
  const _TryButton();

  @override
  State<_TryButton> createState() => _TryButtonState();
}

class _TryButtonState extends State<_TryButton> {
  bool _playing = false;

  Future<void> _tap() async {
    if (_playing) {
      setState(() => _playing = false);
      await VoiceCoach.stop();
      return;
    }
    setState(() => _playing = true);
    await VoiceCoach.sayAndWait(_voiceSample(), intlLocale);
    if (mounted) setState(() => _playing = false);
  }

  @override
  void dispose() {
    if (_playing) VoiceCoach.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GhostButton(
        label: t.voiceTry,
        icon: _playing ? PhosphorIconsRegular.pause : PhosphorIconsRegular.play,
        onTap: _tap,
      );
}
