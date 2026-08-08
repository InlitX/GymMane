import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';

const _kDisplay = 'Oswald';
const _kBody = 'IBM Plex Sans';

Color _heat(int level, GymColors gc) {
  switch (level) {
    case 3:
      return gc.accent;
    case 2:
      return gc.brass;
    case 1:
      return gc.mutedFill;
    default:
      return gc.heatEmpty;
  }
}

class HeatmapWidgetView extends StatelessWidget {
  const HeatmapWidgetView({
    super.key,
    required this.gc,
    required this.levels,
    required this.streak,
    this.size = const Size(320, 150),
  });

  final GymColors gc;
  final List<int> levels;
  final int streak;
  final Size size;

  @override
  Widget build(BuildContext context) {
    const rows = 7;
    const vgap = 3.0;
    const pad = 16.0;
    const headerH = 30.0;
    final gridW = size.width - pad * 2;
    final gridH = size.height - pad * 2 - headerH;
    final cell = ((gridH - (rows - 1) * vgap) / rows).clamp(4.0, 40.0);
    final cols = math.max(1, ((gridW + vgap) / (cell + vgap)).floor());

    final hgap = cols > 1
        ? ((gridW - cols * cell) / (cols - 1)).clamp(vgap, cell)
        : 0.0;

    final need = cols * rows;
    final start = math.max(0, levels.length - need);
    final window = levels.sublist(start);
    int levelAt(int c, int r) {
      final idx = c * rows + r - (need - window.length);
      return (idx >= 0 && idx < window.length) ? window[idx] : 0;
    }

    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: gc.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('GYMMANE',
                  style: TextStyle(
                      fontFamily: _kDisplay,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: gc.text)),
              const Spacer(),
              Icon(Icons.local_fire_department_rounded, size: 15, color: gc.accent),
              const SizedBox(width: 3),
              Text('$streak',
                  style: TextStyle(
                      fontFamily: _kDisplay,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: gc.accent)),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int c = 0; c < cols; c++) ...[
                  Column(
                    children: [
                      for (int r = 0; r < rows; r++) ...[
                        Container(
                          width: cell,
                          height: cell,
                          decoration: BoxDecoration(
                            color: _heat(levelAt(c, r), gc),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                        if (r < rows - 1) const SizedBox(height: vgap),
                      ],
                    ],
                  ),
                  if (c < cols - 1) SizedBox(width: hgap),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatsWidgetView extends StatelessWidget {
  const StatsWidgetView({
    super.key,
    required this.gc,
    required this.streak,
    required this.sessionsThisWeek,
    required this.goalPct,
    this.size = const Size(155, 155),
  });

  final GymColors gc;
  final int streak;
  final int sessionsThisWeek;
  final int goalPct;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: gc.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department_rounded, size: 16, color: gc.accent),
              const SizedBox(width: 4),
              Text(t.streakCaps,
                  style: TextStyle(
                      fontFamily: _kDisplay,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: gc.textSecondary)),
            ],
          ),
          const SizedBox(height: 14),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('$streak',
                    style: TextStyle(
                        fontFamily: _kDisplay,
                        fontSize: 46,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: gc.text)),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(t.daysUnit(streak),
                      style: TextStyle(fontFamily: _kBody, fontSize: 14, color: gc.textSecondary)),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              _chip(gc, '$sessionsThisWeek', t.thisWeek),
              const SizedBox(width: 10),
              _chip(gc, '$goalPct%', t.goal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(GymColors gc, String value, String label) {
    return Expanded(
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
        decoration: BoxDecoration(
          color: gc.bgRaised2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                maxLines: 1,
                style: TextStyle(
                    fontFamily: _kDisplay, fontSize: 16, fontWeight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 1),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(label,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      fontFamily: _kBody, fontSize: 9.5, letterSpacing: 0.3, color: gc.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}
