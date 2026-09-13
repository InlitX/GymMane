import 'package:flutter/material.dart';

import '../catalog/awards.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'medal.dart';
import 'ui_kit.dart';

class MedalShelf extends StatelessWidget {
  const MedalShelf({super.key, this.size = 66});

  final double size;

  @override
  Widget build(BuildContext context) {
    final order = [
      ...AwardId.values.where(fit.hasAward),
      ...AwardId.values.where((a) => !fit.hasAward(a)),
    ];
    return SizedBox(
      height: size + 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: order.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _slot(context, order[i]),
      ),
    );
  }

  Widget _slot(BuildContext context, AwardId id) {
    final won = fit.hasAward(id);
    final fresh = fit.unseenAwards.contains(id);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showMedalSheet(context, id),
      child: Semantics(
        button: true,
        label: awardName(id),
        child: SizedBox(
          width: size + 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: Stack(
                  children: [
                    Medal(id: id, size: size, locked: !won),
                    if (fresh)
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration:
                              BoxDecoration(color: context.gc.accent, shape: BoxShape.circle),
                        ),
                      ),
                  ],
                ),
              ),
              if (won) ...[
                const SizedBox(height: 7),
                Text(
                  awardName(id),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(9.5,
                      weight: FontWeight.w600, color: context.gc.textSecondary, height: 1.15),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showMedalSheet(BuildContext context, AwardId id) {
  fit.markAwardsSeen();
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => _MedalSheet(id: id),
  );
}

class _MedalSheet extends StatelessWidget {
  const _MedalSheet({required this.id});

  final AwardId id;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final won = fit.hasAward(id);
    final at = fit.awardWonAt(id);

    return Container(
      padding: sheetPad(context),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHandle(margin: EdgeInsets.only(bottom: 22)),
          MedalSpin(id: id, size: 236, locked: !won),
          const SizedBox(height: 8),
          Text(t.awardSpinHint,
              style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
          const SizedBox(height: 22),
          Text(awardName(id), textAlign: TextAlign.center, style: AppTheme.f(21, color: gc.text)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(awardLine(id),
                textAlign: TextAlign.center,
                style: AppTheme.f(13,
                    weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
          ),
          const SizedBox(height: 18),
          if (won && at != null)
            Text(t.awardWonOn(t.shortDateYear(at)),
                style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textTertiary))
          else
            _progress(gc),
        ],
      ),
    );
  }

  Widget _progress(GymColors gc) {
    final value = fit.awardValue(id);
    final goal = fit.awardGoal(id);
    return Column(
      children: [
        SizedBox(
          width: 190,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: fit.awardProgress(id),
              minHeight: 5,
              backgroundColor: gc.bgRaised2,
              valueColor: AlwaysStoppedAnimation<Color>(gc.textSecondary),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text('${medalShort(value)} / ${medalShort(goal)}',
            style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textTertiary)),
      ],
    );
  }
}

String medalShort(int v) =>
    v >= 1000 ? '${(v / 1000).toStringAsFixed(v % 1000 == 0 ? 0 : 1)}k' : '$v';
