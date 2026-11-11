import 'package:flutter/material.dart';

import '../app/desktop.dart';
import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/tool_art.dart';
import 'tool_detail_screen.dart';
import '../widgets/ui_kit.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final scale = MediaQuery.textScalerOf(context).scale(1);
    final wide = DesktopScope.of(context);
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: wide ? const EdgeInsets.fromLTRB(32, 30, 32, 48) : const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: t.tools,
              onBack: fit.backFromTools,
              titleSize: 22,
              subtitle: t.calculatorsCount(kToolMeta.length),
            ),
            const SizedBox(height: 22),
            if (wide)
              _desktop(gc, scale)
            else
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.12 / scale,
                children: [for (final tool in kToolMeta) _card(gc, tool, scale)],
              ),
          ],
        ),
      ),
    );
  }

  Widget _desktop(GymColors gc, double scale) {
    final picked = kToolMeta.any((m) => m.id == fit.activeToolId) ? fit.activeToolId! : kToolMeta.first.id;
    if (fit.activeToolId != picked) fit.activeToolId = picked;
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            for (final (i, g) in [
              (t.kindStrength, const ['rm', 'plate', 'warmup', 'rpe', 'dots', 'wilks']),
              (t.toolGroupBody, const ['bmi', 'bf', 'ffmi']),
              (t.nutrition, const ['cal', 'protein', 'water']),
            ].indexed) ...[
              if (i > 0) const SizedBox(height: 26),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 4, bottom: 12),
                child: Text(g.$1, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textTertiary)),
              ),
              LayoutBuilder(
                builder: (context, box) => GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (box.maxWidth / 300).floor().clamp(1, 3),
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    mainAxisExtent: 82 * scale,
                  ),
                  children: [
                    for (final tool in kToolMeta)
                      if (g.$2.contains(tool.id)) _row(gc, tool),
                  ],
                ),
              ),
            ]
        ]),
      ),
      const SizedBox(width: 24),
      Container(
        width: 400,
        margin: const EdgeInsets.only(top: 26),
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
        decoration: BoxDecoration(color: gc.bgRaised.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(26)),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          layoutBuilder: (current, previous) => Stack(
            alignment: Alignment.topCenter,
            children: [...previous, ?current],
          ),
          child: ToolDetailScreen(key: ValueKey(fit.activeToolId), embedded: true),
        ),
      ),
    ]);
  }

  Widget _row(GymColors gc, ToolMeta tool) {
    final on = fit.activeToolId == tool.id;
    return Pressable(
      onTap: () => fit.selectTool(tool.id),
      scale: 0.97,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: on ? gc.text.withValues(alpha: 0.55) : Colors.transparent, width: 1.4),
        ),
        child: Row(children: [
          const SizedBox(width: 4),
          ToolArt(tool.id),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(t.toolName(tool.id),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text)),
              const SizedBox(height: 4),
              Text(t.toolDesc(tool.id),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _card(GymColors gc, ToolMeta tool, double scale) {
    return Pressable(
      onTap: () => fit.openTool(tool.id),
      scale: 0.96,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ToolArt(tool.id),
            const Spacer(),
            Text(t.toolName(tool.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 2),
            SizedBox(
              height: 31 * scale,
              child: Text(t.toolDesc(tool.id),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(11.5,
                      weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
            ),
          ],
        ),
      ),
    );
  }
}
