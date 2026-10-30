import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/awards.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/medal.dart';
import '../widgets/medal_shelf.dart';
import '../widgets/sheet_page.dart';
import '../widgets/ui_kit.dart';

class AwardsScreen extends StatefulWidget {
  const AwardsScreen({super.key});

  @override
  State<AwardsScreen> createState() => _AwardsScreenState();
}

class _AwardsScreenState extends State<AwardsScreen> {
  bool _picking = false;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final won = AwardId.values.where(fit.hasAward).toList();
    final left = AwardId.values.where((a) => !fit.hasAward(a)).toList();
    final total = AwardId.values.length;

    return RiseScope(
      id: 'awards',
      once: false,
      child: SheetPage(
        title: t.awardsTitle,
        eyebrow: _picking ? t.awardsPickHint : t.profile,
        onBack: fit.backFromAwards,
        actions: [
          if (won.isNotEmpty)
            RoundAction(
              label: t.awardsPick,
              filled: _picking,
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _picking = !_picking);
              },
              child: Icon(_picking ? PhosphorIconsBold.check : PhosphorIconsRegular.pushPin,
                  size: 17, color: _picking ? gc.onEmber : gc.text),
            ),
        ],
        children: [
          Rise(index: 0, child: _summary(gc, won.length, total)),
          if (won.isNotEmpty) ...[
            const SizedBox(height: 26),
            Rise(index: 1, child: _section(gc, t.awardsEarned, won.length)),
            const SizedBox(height: 10),
            Rise(index: 2, child: _grid(context, won)),
          ],
          if (left.isNotEmpty) ...[
            const SizedBox(height: 26),
            Rise(index: 3, child: _section(gc, t.awardsLocked, left.length)),
            const SizedBox(height: 10),
            Rise(index: 4, child: _grid(context, left)),
          ],
        ],
      ),
    );
  }

  Widget _summary(GymColors gc, int won, int total) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 18, 18),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(26)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.09), shape: BoxShape.circle),
              child: Icon(PhosphorIconsRegular.medal, size: 22, color: gc.text),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    RollIn('$won',
                        style: AppTheme.f(32, weight: FontWeight.w900, color: gc.text, letterSpacing: -1, height: 1)),
                    const SizedBox(width: 5),
                    Text('/ $total', style: AppTheme.f(16, weight: FontWeight.w800, color: gc.textTertiary)),
                  ],
                ),
                const SizedBox(height: 3),
                Text(t.awardsEarned.toUpperCase(),
                    style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
              ]),
            ),
            Text('${total == 0 ? 0 : (won * 100 / total).round()} %',
                style: AppTheme.f(15, weight: FontWeight.w800, color: gc.accent)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 8,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: total == 0 ? 0 : won / total),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, v, _) => LayoutBuilder(
              builder: (context, box) => Stack(children: [
                Container(
                  width: box.maxWidth,
                  decoration: BoxDecoration(
                    color: gc.text.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: box.maxWidth * v.clamp(0.02, 1.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [gc.accent, gc.brass]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _section(GymColors gc, String label, int count) {
    final style = AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4);
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Text(label.toUpperCase(), style: style),
          const SizedBox(width: 8),
          Text('$count', style: style.copyWith(color: gc.textSecondary)),
        ],
      ),
    );
  }

  Widget _grid(BuildContext context, List<AwardId> ids) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: ids.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.02,
      ),
      itemBuilder: (_, i) => _card(context, ids[i]),
    );
  }

  Widget _card(BuildContext context, AwardId id) {
    final gc = context.gc;
    final won = fit.hasAward(id);
    final at = fit.awardWonAt(id);
    final shown = fit.isProfileMedal(id);
    final pickable = _picking && won;
    return Pressable(
      onTap: pickable
          ? () {
              HapticFeedback.selectionClick();
              fit.toggleProfileMedal(id);
            }
          : () => showMedalSheet(context, id),
      scale: 0.97,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _picking && !won ? 0.35 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: pickable && shown ? gc.text.withValues(alpha: 0.6) : Colors.transparent, width: 1.5),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Medal(id: id, size: 74, locked: !won),
                  const SizedBox(height: 10),
                  Text(
                    awardName(id),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14, color: won ? gc.text : gc.textSecondary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    won && at != null
                        ? t.shortDateYear(at)
                        : '${medalShort(fit.awardValue(id))} / ${medalShort(fit.awardGoal(id))}',
                    style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary),
                  ),
                ],
              ),
              ),
              if (pickable)
                Positioned(
                  right: 0,
                  top: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: shown ? gc.text : Colors.transparent,
                      border: Border.all(color: shown ? gc.text : gc.textTertiary, width: 1.5),
                    ),
                    child: shown ? Icon(PhosphorIconsBold.check, size: 12, color: gc.bg) : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
