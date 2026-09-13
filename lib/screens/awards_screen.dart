import 'package:flutter/material.dart';

import '../catalog/awards.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/medal.dart';
import '../widgets/medal_shelf.dart';
import '../widgets/ui_kit.dart';

class AwardsScreen extends StatelessWidget {
  const AwardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final won = AwardId.values.where(fit.hasAward).toList();
    final left = AwardId.values.where((a) => !fit.hasAward(a)).toList();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(title: t.awardsTitle, onBack: fit.backFromAwards),
            const SizedBox(height: 22),
            if (won.isNotEmpty) ...[
              _section(gc, t.awardsEarned, won.length),
              const SizedBox(height: 14),
              _grid(context, won),
              const SizedBox(height: 30),
            ],
            if (left.isNotEmpty) ...[
              _section(gc, t.awardsLocked, left.length),
              const SizedBox(height: 14),
              _grid(context, left),
            ],
          ],
        ),
      ),
    );
  }

  Widget _section(GymColors gc, String label, int count) {
    return Row(
      children: [
        Text(label, style: AppTheme.f(19, color: gc.text)),
        const SizedBox(width: 8),
        Text('$count', style: AppTheme.f(16, weight: FontWeight.w600, color: gc.textTertiary)),
      ],
    );
  }

  Widget _grid(BuildContext context, List<AwardId> ids) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ids.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (_, i) => _card(context, ids[i]),
    );
  }

  Widget _card(BuildContext context, AwardId id) {
    final gc = context.gc;
    final won = fit.hasAward(id);
    final at = fit.awardWonAt(id);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showMedalSheet(context, id),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 14),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Medal(id: id, size: 96, locked: !won),
            const SizedBox(height: 14),
            Text(
              awardName(id),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(14, color: won ? gc.text : gc.textSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              won && at != null
                  ? t.shortDateYear(at)
                  : '${medalShort(fit.awardValue(id))} / ${medalShort(fit.awardGoal(id))}',
              style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
