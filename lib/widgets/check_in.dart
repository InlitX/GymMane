import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'ui_kit.dart';

String checkInWord(int v) => switch (v) {
      1 => t.checkInLevel1,
      2 => t.checkInLevel2,
      3 => t.checkInLevel3,
      4 => t.checkInLevel4,
      _ => t.checkInLevel5,
    };

class CheckInCard extends StatelessWidget {
  const CheckInCard(this.session, {super.key, this.flat = false});
  final LoggedSession session;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final body = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(t.checkInTitle.toUpperCase(),
          style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
      const SizedBox(height: 12),
      CheckInRow(
        icon: PhosphorIconsRegular.moon,
        label: t.checkInSleep,
        value: session.sleep,
        color: gc.sage,
        onPick: (v) => fit.rateSession(session, sleep: true, value: v),
      ),
      const SizedBox(height: 12),
      CheckInRow(
        icon: PhosphorIconsRegular.lightning,
        label: t.checkInEnergy,
        value: session.energy,
        color: gc.brass,
        onPick: (v) => fit.rateSession(session, sleep: false, value: v),
      ),
    ]);
    if (flat) return body;
    return SoftCard(radius: 22, padding: const EdgeInsets.fromLTRB(16, 16, 16, 16), child: body);
  }
}

class CheckInRow extends StatelessWidget {
  const CheckInRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onPick,
  });
  final IconData icon;
  final String label;
  final int? value;
  final Color color;
  final ValueChanged<int?> onPick;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final v = value;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Icon(icon, size: 15, color: v == null ? gc.textSecondary : color),
        const SizedBox(width: 7),
        Text(label, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)),
        const Spacer(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: Text(v == null ? t.checkInSkip : checkInWord(v),
              key: ValueKey(v),
              style: AppTheme.f(12, weight: FontWeight.w600, color: v == null ? gc.textTertiary : color)),
        ),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        for (var i = 1; i <= 5; i++) ...[
          if (i > 1) const SizedBox(width: 6),
          Expanded(
            child: Semantics(
              button: true,
              selected: v == i,
              label: '$label ${checkInWord(i)}',
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  HapticFeedback.selectionClick();
                  onPick(v == i ? null : i);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    height: 10,
                    decoration: BoxDecoration(
                      color: v != null && i <= v ? color : gc.bgRaised2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ]),
    ]);
  }
}
