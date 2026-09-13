import 'dart:io';

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/progress_shot.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'body_map.dart';
import 'charts.dart';
import 'profile_avatar.dart';
import 'svg_icon.dart';

const Size kShareCardSize = Size(340, 425);

enum ShareKind { streak, body, compare }

class ShareCard extends StatelessWidget {
  const ShareCard({super.key, required this.kind, required this.gc});

  final ShareKind kind;
  final GymColors gc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kShareCardSize.width,
      height: kShareCardSize.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gc.bgRaised, gc.bg],
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: gc.accent, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text('GymMane',
                      style: AppTheme.f(13,
                          weight: FontWeight.w800, color: gc.text, letterSpacing: 0.4)),
                  const Spacer(),
                  Text(t.shortDateYear(DateTime.now()),
                      style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary)),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(child: _body()),
              const SizedBox(height: 14),
              Container(height: 1, color: gc.border),
              const SizedBox(height: 10),
              Row(
                children: [
                  const ProfileAvatar(size: 22),
                  const SizedBox(width: 8),
                  Text('@${fit.profileHandle}',
                      style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() => switch (kind) {
        ShareKind.streak => _streak(),
        ShareKind.body => _bodyMap(),
        ShareKind.compare => _compare(),
      };

  Widget _kicker(String text) => Text(text,
      style: AppTheme.f(11, weight: FontWeight.w600, color: gc.brass, letterSpacing: 1.5));

  Widget _stat(String label, String value, {String? unit, Color? color}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTheme.f(9.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1)),
          const SizedBox(height: 3),
          RichText(
            text: TextSpan(
              text: value,
              style: AppTheme.f(22, weight: FontWeight.w800, color: color ?? gc.text),
              children: [
                if (unit != null)
                  TextSpan(
                      text: ' $unit',
                      style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textSecondary)),
              ],
            ),
          ),
        ],
      );

  Widget _streak() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker(t.consistency.toUpperCase()),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${fit.currentStreak}',
                style: AppTheme.f(66, weight: FontWeight.w700, color: gc.text, height: 0.95)),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(t.shareStreakLabel.toLowerCase(),
                  style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
            ),
            const Spacer(),
            SvgPathIcon(Ic.flame, size: 76, color: gc.accent),
          ],
        ),
        const SizedBox(height: 4),
        Text(t.sessionsLogged(fit.sessionsThisWeek),
            style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
        const SizedBox(height: 18),
        SizedBox(height: 118, child: Heatmap(levels: fit.heatmapLevelsFor(60))),
        const Spacer(),
        Row(
          children: [
            Expanded(child: _stat(t.shareSessionsLabel, '${fit.totalSessions}')),
            Expanded(child: _stat(t.statTrained, fit.trainedSpan.$1, unit: fit.trainedSpan.$2)),
            Expanded(
                child: _stat(t.shareVolumeLabel, fit.volumeValue(fit.volume30dKg),
                    unit: fit.volumeUnit, color: gc.accent)),
          ],
        ),
      ],
    );
  }


  Widget _bodyMap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker(t.shareWeekOf),
        const SizedBox(height: 6),
        Text(t.shareBody,
            style: AppTheme.f(22, weight: FontWeight.w700, color: gc.text)),
        const SizedBox(height: 10),
        Expanded(
          child: Center(
            child: BodyHeatArt(gc: gc, intensity: fit.muscleHeatOver(7), width: 228),
          ),
        ),
        Row(
          children: [
            Expanded(child: _stat(t.shareSessionsLabel, '${fit.sessionsThisWeek}')),
            Expanded(
                child: _stat(t.shareStreakLabel, '${fit.currentStreak}', color: gc.accent)),
          ],
        ),
      ],
    );
  }

  Widget _compare() {
    final pair = fit.comparePair;
    if (pair == null) {
      return Center(child: Text(t.compareNeedTwo, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)));
    }
    final pose = fit.posesWithBoth.contains(fit.comparePose)
        ? fit.comparePose
        : (fit.posesWithBoth.isEmpty ? null : fit.posesWithBoth.first);
    final delta = fit.compareWeightDelta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker(t.daysApart(fit.compareDays).toUpperCase()),
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
