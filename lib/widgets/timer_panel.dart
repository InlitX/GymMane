import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'rolling_text.dart';

String clockLabel(int seconds) {
  final s = seconds < 0 ? 0 : seconds;
  return '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
}

class TimerPanel extends StatelessWidget {
  const TimerPanel({
    super.key,
    required this.label,
    required this.remaining,
    required this.total,
    required this.elapsed,
    required this.elapsedLabel,
    required this.sets,
    required this.setsLabel,
    required this.hint,
    required this.onTap,
    this.onMinus,
    this.onPlus,
    this.color,
  });

  final String label;
  final int remaining;
  final int total;
  final String elapsed;
  final String elapsedLabel;
  final String sets;
  final String setsLabel;
  final String hint;
  final VoidCallback onTap;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final accent = color ?? gc.sage;
    final left = total <= 0 ? 0.0 : (remaining / total).clamp(0.0, 1.0);
    return Semantics(
      button: true,
      label: '$label ${clockLabel(remaining)}',
      hint: hint,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _nudge(gc, '−15', onMinus),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.only(top: 9),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: gc.bgRaised2,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                      ),
                      child: Text(
                        label.toUpperCase(),
                        style: AppTheme.f(11, weight: FontWeight.w800, color: gc.text, letterSpacing: 2),
                      ),
                    ),
                  ),
                  _nudge(gc, '+15', onPlus),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
              decoration: BoxDecoration(
                color: gc.bgRaised,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: gc.border.withValues(alpha: 0.5)),
              ),
              child: Column(
                children: [
                  _Ticks(left: left, lit: accent, dim: gc.bgRaised2),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: _stat(gc, elapsed, elapsedLabel, CrossAxisAlignment.start)),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          RollingText(
                            clockLabel(remaining),
                            countsDown: true,
                            style: AppTheme.f(36, weight: FontWeight.w800, color: gc.text, height: 1.05),
                          ),
                          const SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                hint.toUpperCase(),
                                maxLines: 1,
                                style: AppTheme.f(
                                  10,
                                  weight: FontWeight.w800,
                                  color: accent,
                                  letterSpacing: 1.6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: _stat(gc, sets, setsLabel, CrossAxisAlignment.end)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(GymColors gc, String value, String caption, CrossAxisAlignment align) => Column(
    crossAxisAlignment: align,
    children: [
      RollingText(
        value,
        style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text, height: 1.1),
      ),
      const SizedBox(height: 3),
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          caption.toUpperCase(),
          maxLines: 1,
          style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5),
        ),
      ),
    ],
  );

  Widget _nudge(GymColors gc, String glyph, VoidCallback? onTap) {
    if (onTap == null) return const SizedBox(width: 56);
    return Semantics(
      button: true,
      label: glyph,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Container(
          width: 56,
          height: 32,
          margin: const EdgeInsets.only(bottom: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
          child: Text(
            glyph,
            style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.textSecondary),
          ),
        ),
      ),
    );
  }
}

class _Ticks extends StatelessWidget {
  const _Ticks({required this.left, required this.lit, required this.dim});

  final double left;
  final Color lit;
  final Color dim;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        const tick = 3.0, gap = 5.5;
        final n = ((box.maxWidth + gap) / (tick + gap)).floor();
        final drained = ((1 - left) * n).floor();
        return SizedBox(
          height: 22,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < n; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 380),
                  curve: Curves.easeOut,
                  width: tick,
                  height: i < drained ? 14 : 22,
                  decoration: BoxDecoration(
                    color: i < drained ? dim : lit,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
