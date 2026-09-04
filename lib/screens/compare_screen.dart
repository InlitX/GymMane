import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/progress_shot.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/share_cards.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';
import 'share_sheet.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final pair = fit.comparePair;
    if (pair == null) return const SizedBox.shrink();

    final poses = fit.posesWithBoth;
    final pose = poses.contains(fit.comparePose) ? fit.comparePose : (poses.isEmpty ? null : poses.first);
    final delta = fit.compareWeightDelta;
    final entries = fit.timelineAsc;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Row(
              children: [
                RoundBtn(icon: Ic.chevronLeft, onTap: fit.backFromCompare),
                const SizedBox(width: 12),
                Expanded(child: ScreenTitle(t.compare, size: 20)),
                Semantics(
                  button: true,
                  label: t.share,
                  child: GestureDetector(
                    onTap: () => showShareSheet(context, initial: ShareKind.compare),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: gc.bgRaised,
                        shape: BoxShape.circle,
                        border: Border.all(color: gc.border),
                      ),
                      child: Icon(PhosphorIconsRegular.shareNetwork, size: 16, color: gc.text),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (poses.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: SegToggle([
                for (final p in poses)
                  SegOption(t.poseName(p), p == pose, () => fit.setComparePose(p)),
              ]),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Expanded(child: _shot(gc, pair.from, pose)),
                  const SizedBox(width: 10),
                  Expanded(child: _shot(gc, pair.to, pose)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.daysApart(fit.compareDays),
                          style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
                      if (delta != null) ...[
                        const SizedBox(height: 2),
                        Text('${delta > 0 ? '+' : ''}${fmt(delta)} ${fit.units}',
                            style: AppTheme.s(13,
                                weight: FontWeight.w600,
                                color: delta == 0 ? gc.textSecondary : gc.accent)),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          _picker(gc, entries, pair.from.id, fit.setCompareFrom, gc.textSecondary),
          _picker(gc, entries, pair.to.id, fit.setCompareTo, gc.accent),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _picker(
    GymColors gc,
    List<ProgressEntry> entries,
    String selectedId,
    ValueChanged<String> onPick,
    Color tint,
  ) =>
      SizedBox(
        height: 44,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
          children: [
            for (final e in entries)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Pill(
                  label: t.shortDate(e.date),
                  bg: e.id == selectedId ? tint.withValues(alpha: 0.18) : gc.bgRaised,
                  fg: e.id == selectedId ? tint : gc.textTertiary,
                  fontSize: 12,
                  onTap: () => onPick(e.id),
                ),
              ),
          ],
        ),
      );

  Widget _shot(GymColors gc, ProgressEntry entry, String? pose) {
    final name = pose == null ? (entry.media.isEmpty ? null : entry.media.first) : entry.shot(pose);
    final path = name == null ? null : MediaStore.pathFor(name);
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: gc.bgRaised2,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: gc.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: path == null
                ? Icon(PhosphorIconsRegular.imageSquare, size: 22, color: gc.textTertiary)
                : Image.file(File(path), fit: BoxFit.cover, gaplessPlayback: true,
                    errorBuilder: (_, _, _) =>
                        Icon(PhosphorIconsRegular.imageSquare, size: 22, color: gc.textTertiary)),
          ),
        ),
        const SizedBox(height: 8),
        Text(t.shortDateYear(entry.date),
            style: AppTheme.s(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
      ],
    );
  }
}
