import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_kit.dart';

IconData _toolIcon(String id) => switch (id) {
      'rm' => PhosphorIconsRegular.barbell,
      'bmi' => PhosphorIconsRegular.scales,
      'cal' => PhosphorIconsRegular.fire,
      'bf' => PhosphorIconsRegular.percent,
      'plate' => PhosphorIconsRegular.circlesThree,
      _ => PhosphorIconsRegular.trendUp,
    };

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

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
            ScreenHeader(title: t.tools, onBack: fit.backFromTools, titleSize: 22),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Text(t.calculatorsCount(kToolMeta.length),
                  style: AppTheme.s(13, color: gc.textSecondary)),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [for (final tool in kToolMeta) _card(gc, tool)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(GymColors gc, ToolMeta tool) {
    return GestureDetector(
      onTap: () => fit.openTool(tool.id),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Icon(_toolIcon(tool.id), size: 20, color: gc.ember)),
            ),
            const Spacer(),
            Text(t.toolName(tool.id), style: AppTheme.d(15, weight: FontWeight.w600, color: gc.text, letterSpacing: 0.5)),
            const SizedBox(height: 2),
            Text(t.toolDesc(tool.id),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.s(12, color: gc.textSecondary)),
          ],
        ),
      ),
    );
  }
}
