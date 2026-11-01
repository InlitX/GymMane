import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'ui_kit.dart';

const kImportApps = ['Hevy', 'Strong', 'FitNotes', 'Lyfta', 'openGym', 'CSV'];

class ImportCard extends StatelessWidget {
  const ImportCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      label: t.importCardTitle,
      child: Pressable(
        scale: 0.97,
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppMarquee(),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.importCardTitle,
                              style: AppTheme.f(20,
                                  weight: FontWeight.w800, color: gc.text, letterSpacing: -0.4, height: 1.15)),
                          const SizedBox(height: 4),
                          Text(t.importCardBody,
                              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
                      child: Icon(PhosphorIconsBold.arrowRight, size: 17, color: gc.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppMarquee extends StatefulWidget {
  const AppMarquee({super.key});

  @override
  State<AppMarquee> createState() => _AppMarqueeState();
}

class _AppMarqueeState extends State<AppMarquee> with SingleTickerProviderStateMixin {
  static const _tile = 104.0;
  static const _gap = 10.0;
  static const _period = (_tile + _gap) * 6;

  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 15));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _ctrl.stop();
    } else if (!_ctrl.isAnimating) {
      _ctrl.repeat();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final strip = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var round = 0; round < 3; round++)
          for (final name in kImportApps)
            Padding(
              padding: const EdgeInsets.only(right: _gap),
              child: Container(
                width: _tile,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(15)),
                child: Text(name,
                    maxLines: 1,
                    style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.2)),
              ),
            ),
      ],
    );
    return RepaintBoundary(
      child: SizedBox(
        height: 46,
        child: ClipRect(
          child: OverflowBox(
            alignment: Alignment.centerLeft,
            maxWidth: double.infinity,
            child: AnimatedBuilder(
              animation: _ctrl,
              child: RepaintBoundary(child: strip),
              builder: (context, child) => Transform.translate(
                offset: Offset(-_ctrl.value * _period, 0),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
