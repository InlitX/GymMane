import 'dart:io';

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/progress_shot.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'body_map.dart';
import 'charts.dart';
import 'profile_avatar.dart';

const Size kShareCardSize = Size(340, 425);

enum ShareKind { streak, body, compare }

class ShareCard extends StatelessWidget {
  const ShareCard({super.key, required this.kind, required this.gc});

  final ShareKind kind;
  final GymColors gc;

  static const _tabular = [FontFeature.tabularFigures()];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kShareCardSize.width,
      height: kShareCardSize.height,
      padding: const EdgeInsets.fromLTRB(26, 24, 26, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gc.bgRaised, Color.lerp(gc.bgRaised, gc.bg, 0.7)!],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('GymMane', style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.2)),
              const Spacer(),
              Text(t.shortDateYear(DateTime.now()),
                  style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
            ],
          ),
          Expanded(child: _body()),
          Container(height: 1, color: gc.text.withValues(alpha: 0.08)),
          const SizedBox(height: 14),
          Row(
            children: [
              const ProfileAvatar(size: 26),
              const SizedBox(width: 10),
              Flexible(
                child: Text(fit.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
              ),
              const SizedBox(width: 6),
              Text('@${fit.profileHandle}',
                  maxLines: 1, style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body() => switch (kind) {
        ShareKind.streak => _streak(),
        ShareKind.body => _bodyMap(),
        ShareKind.compare => _compare(),
      };

  Widget _label(String text) => Text(text.toUpperCase(),
      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4));

  Widget _stats(List<(String, String, String?)> items) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (label, value, unit) in items)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        text: value,
                        style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.4)
                            .copyWith(fontFeatures: _tabular),
                        children: [
                          if (unit != null)
                            TextSpan(
                                text: ' $unit',
                                style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(label.toUpperCase(),
                        maxLines: 1,
                        style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.1)),
                  ),
                ],
              ),
            ),
        ],
      );

  Widget _streak() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 3),
        _label(t.consistency),
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (r) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gc.accent, gc.brass],
              ).createShader(r),
              child: Text('${fit.currentStreak}',
                  style: AppTheme.f(104, weight: FontWeight.w800, color: gc.text, height: 1, letterSpacing: -5)
                      .copyWith(fontFeatures: _tabular)),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(t.shareStreakLabel.toLowerCase(),
                  maxLines: 2,
                  style: AppTheme.f(17, weight: FontWeight.w700, color: gc.textSecondary, height: 1.15)),
            ),
          ],
        ),
        const Spacer(flex: 2),
        Heatmap(levels: fit.heatmapWeeksFor(20)),
        const Spacer(flex: 3),
        _stats([
          (t.shareSessionsLabel, '${fit.totalSessions}', null),
          (t.statTrained, fit.trainedSpan.$1, fit.trainedSpan.$2),
          (t.shareVolumeLabel, fit.volumeValue(fit.volume30dKg), fit.volumeUnit),
        ]),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _bodyMap() {
    final heat = fit.muscleHeatOver(7);
    final top = (heat.entries.where((e) => e.value > 0).toList()..sort((a, b) => b.value.compareTo(a.value)))
        .take(3)
        .map((e) => muscleLabel(e.key))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        _label(t.shareWeekOf),
        const SizedBox(height: 4),
        Text(t.shareBody,
            style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.6, height: 1.1)),
        if (top.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(top.join(' · '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
        ],
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(child: FittedBox(child: BodyHeatArt(gc: gc, intensity: heat, width: 250))),
          ),
        ),
        _stats([
          (t.shareSessionsLabel, '${fit.sessionsThisWeek}', null),
          (t.allTimeSets, '${fit.weekSetCount}', null),
          (t.shareStreakLabel, '${fit.currentStreak}', null),
        ]),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _compare() {
    final pair = fit.comparePair;
    if (pair == null) {
      return Center(
          child: Text(t.compareNeedTwo, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)));
    }
    final pose = fit.posesWithBoth.contains(fit.comparePose)
        ? fit.comparePose
        : (fit.posesWithBoth.isEmpty ? null : fit.posesWithBoth.first);
    final delta = fit.compareWeightDelta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _label(t.daysApart(fit.compareDays)),
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _shot(pair.from, pose)),
              const SizedBox(width: 10),
              Expanded(child: _shot(pair.to, pose)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(t.shortDateYear(pair.from.date),
                  style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(t.shortDateYear(pair.to.date),
                  textAlign: TextAlign.right,
                  style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
            ),
          ],
        ),
        if (delta != null) ...[
          const SizedBox(height: 8),
          Text('${delta > 0 ? '+' : ''}${fmt(delta)} ${fit.units}',
              style: AppTheme.f(20, weight: FontWeight.w700, color: gc.accent)),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _shot(ProgressEntry entry, String? pose) {
    final name = pose == null ? (entry.media.isEmpty ? null : entry.media.first) : entry.shot(pose);
    final path = name == null ? null : MediaStore.pathFor(name);
    return Container(
      decoration: BoxDecoration(
        color: gc.bgRaised2,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: path == null
          ? const SizedBox.expand()
          : Image.file(File(path), fit: BoxFit.cover, gaplessPlayback: true,
              errorBuilder: (_, _, _) => const SizedBox.expand()),
    );
  }
}
