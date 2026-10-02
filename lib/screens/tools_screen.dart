import 'package:flutter/material.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/tool_art.dart';
import '../widgets/ui_kit.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final scale = MediaQuery.textScalerOf(context).scale(1);
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
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
