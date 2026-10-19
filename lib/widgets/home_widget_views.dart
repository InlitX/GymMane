import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import 'body_map.dart';
import 'nutrition_art.dart';
import 'ui_kit.dart';

const _kDisplay = 'Nunito';
const _kBody = 'Nunito';
const _kBorder = 1.0;

Color _heat(int level, GymColors gc) => level < 0
    ? Colors.transparent
    : level == 0
    ? gc.heatEmpty
    : heatLevelColor(gc, level);

BoxDecoration _card(GymColors gc, bool framed, double radius) => BoxDecoration(
  color: gc.bgRaised,
  borderRadius: framed ? BorderRadius.circular(radius) : null,
  border: framed ? Border.all(color: gc.border, width: _kBorder) : null,
);

class HeatmapWidgetView extends StatelessWidget {
  const HeatmapWidgetView({
    super.key,
    required this.gc,
    required this.levels,
    required this.streak,
    this.size = const Size(320, 150),
    this.framed = true,
  });

  final GymColors gc;
  final List<int> levels;
  final int streak;
  final Size size;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    const rows = 7;
    const vgap = 3.0;
    const pad = 16.0;
    const headerH = 30.0;
    final gridW = size.width - pad * 2 - _kBorder * 2;
    final gridH = size.height - pad * 2 - headerH - _kBorder * 2;
    final cell = ((gridH - (rows - 1) * vgap) / rows).clamp(4.0, 40.0);
    final cols = math.max(1, ((gridW + vgap) / (cell + vgap)).floor());

    final hgap = cols > 1 ? ((gridW - cols * cell) / (cols - 1)).clamp(vgap, cell) : 0.0;

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
      decoration: _card(gc, framed, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: headerH - 10,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'GymMane',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(
                      fontFamily: _kDisplay,
                      fontSize: 16,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: gc.text,
                    ),
                  ),
                ),
                Icon(Icons.local_fire_department_rounded, size: 15, color: gc.accent),
                const SizedBox(width: 3),
                Text(
                  '$streak',
                  style: TextStyle(
                    fontFamily: _kDisplay,
                    fontSize: 15,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: gc.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
    this.framed = true,
  });

  final GymColors gc;
  final int streak;
  final int sessionsThisWeek;
  final int goalPct;
  final Size size;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16),
      decoration: _card(gc, framed, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department_rounded, size: 16, color: gc.accent),
              const SizedBox(width: 4),
              Text(
                titleCase(t.streakCaps),
                style: TextStyle(
                  fontFamily: _kDisplay,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: gc.text,
                ),
              ),
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
                Text(
                  '$streak',
                  style: TextStyle(
                    fontFamily: _kDisplay,
                    fontSize: 46,
                    height: 1,
                    fontWeight: FontWeight.w700,
                    color: gc.text,
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    t.daysUnit(streak),
                    style: TextStyle(fontFamily: _kBody, fontSize: 14, color: gc.textSecondary),
                  ),
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
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              maxLines: 1,
              style: TextStyle(
                fontFamily: _kDisplay,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: gc.text,
              ),
            ),
            const SizedBox(height: 1),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontFamily: _kBody,
                  fontSize: 9.5,
                  letterSpacing: 0.3,
                  color: gc.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayWidgetView extends StatelessWidget {
  const TodayWidgetView({
    super.key,
    required this.gc,
    required this.done,
    required this.planned,
    required this.streak,
    this.rest = false,
    this.size = const Size(120, 120),
    this.framed = true,
  });

  final GymColors gc;
  final bool done;
  final bool planned;
  final bool rest;
  final int streak;
  final Size size;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    final side = size.shortestSide;
    final tone = planned ? gc.brass : gc.textTertiary;
    return Container(
      width: size.width,
      height: size.height,
      decoration: _card(gc, framed, side * 0.3),
      child: Center(
        child: Container(
          width: side * 0.62,
          height: side * 0.62,
          decoration: BoxDecoration(
            color: done ? gc.accent : (rest ? gc.sageSoft : Colors.transparent),
            shape: BoxShape.circle,
            border: done || rest
                ? null
                : Border.all(color: planned ? gc.brass : gc.border, width: side * 0.035),
          ),
          child: Center(
            child: done
                ? Icon(Icons.check_rounded, size: side * 0.34, color: gc.bgRaised)
                : rest
                ? Icon(Icons.local_cafe_rounded, size: side * 0.24, color: gc.sage)
                : Icon(Icons.fitness_center_rounded, size: side * 0.22, color: tone),
          ),
        ),
      ),
    );
  }
}

class WeekWidgetView extends StatelessWidget {
  const WeekWidgetView({
    super.key,
    required this.gc,
    required this.done,
    required this.goal,
    this.size = const Size(320, 150),
    this.framed = true,
  });

  final GymColors gc;
  final List<bool> done;
  final int goal;
  final Size size;
  final bool framed;

  static const pad = 18.0;
  static const dot = 32.0;

  static List<double> geometry(Size size, {bool framed = true}) {
    final inset = pad + (framed ? _kBorder : 0);
    final col = (size.width - inset * 2) / 7;
    return [
      (inset + col / 2) / size.width,
      col / size.width,
      (size.height - inset - dot / 2) / size.height,
      (dot / 2 - 1) / size.width,
      2 / size.width,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final count = done.where((d) => d).length;
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(pad),
      decoration: _card(gc, framed, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.thisWeek.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: TextStyle(
                        fontFamily: _kBody,
                        fontSize: 10.5,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: gc.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$count',
                          style: TextStyle(
                            fontFamily: _kDisplay,
                            fontSize: 30,
                            height: 1,
                            fontWeight: FontWeight.w800,
                            color: gc.text,
                          ),
                        ),
                        Text(
                          '/$goal',
                          style: TextStyle(
                            fontFamily: _kDisplay,
                            fontSize: 16,
                            height: 1,
                            fontWeight: FontWeight.w700,
                            color: gc.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: goal <= 0 ? 0 : (count / goal).clamp(0.0, 1.0),
                  strokeWidth: 4,
                  strokeCap: StrokeCap.round,
                  backgroundColor: gc.bgRaised2,
                  valueColor: AlwaysStoppedAnimation(gc.accent),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.weekdayInitial(fit.weekdayAt(i)),
                        style: TextStyle(
                          fontFamily: _kBody,
                          fontSize: 10,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: gc.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: dot,
                        height: dot,
                        decoration: BoxDecoration(
                          color: done[i] ? gc.ember : gc.bgRaised2,
                          shape: BoxShape.circle,
                        ),
                        child: done[i] ? Icon(Icons.check_rounded, size: 17, color: gc.onEmber) : null,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyWidgetView extends StatelessWidget {
  const BodyWidgetView({
    super.key,
    required this.gc,
    required this.intensity,
    required this.days,
    this.size = const Size(320, 220),
    this.framed = true,
  });

  final GymColors gc;
  final Map<String, double> intensity;
  final int days;
  final Size size;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    const pad = 16.0;
    const headerH = 28.0;
    final artW = math.min(
      size.width - pad * 2 - _kBorder * 2,
      (size.height - pad * 2 - headerH - _kBorder * 2) / kBodyAspect,
    );

    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(pad),
      decoration: _card(gc, framed, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: headerH - 8,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    titleCase(t.muscleMap),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(
                      fontFamily: _kDisplay,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: gc.text,
                    ),
                  ),
                ),
                for (int i = 1; i <= heatLevels; i++) ...[
                  if (i > 1) const SizedBox(width: 3),
                  Container(
                    width: 12,
                    height: 6,
                    decoration: BoxDecoration(
                      color: heatLevelColor(gc, i),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                Text(
                  t.daysShort(days),
                  style: TextStyle(fontFamily: _kBody, fontSize: 10.5, color: gc.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: BodyHeatArt(gc: gc, intensity: intensity, width: artW),
            ),
          ),
        ],
      ),
    );
  }
}

class VesselWidgetGeometry {
  const VesselWidgetGeometry._();

  static const size = Size(155, 155);
  static const vesselLeft = 10.0;
  static const vesselTop = 10.0;
  static const vesselHeight = 136.0;
  static const columnLeft = 70.0;
  static const columnRight = 141.0;
  static const valueBaseline = 82.0;
  static const valueSize = 32.0;
  static const barTop = 108.0;
  static const barHeight = 6.0;
  static const pillTop = 122.0;

  static List<double> fractions() => [
    vesselLeft / size.width,
    vesselTop / size.height,
    vesselHeight / size.height,
    columnLeft / size.width,
    valueBaseline / size.height,
    valueSize / size.height,
    (columnRight - columnLeft) / size.width,
    barTop / size.height,
    barHeight / size.height,
  ];
}

class VesselWidgetView extends StatelessWidget {
  const VesselWidgetView({
    super.key,
    required this.gc,
    required this.title,
    required this.icon,
    required this.tone,
    required this.goal,
    required this.pill,
    this.message,
    this.framed = true,
  });

  final GymColors gc;
  final String title;
  final IconData icon;
  final Color tone;
  final String goal;
  final String pill;
  final String? message;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    const g = VesselWidgetGeometry.size;
    const left = VesselWidgetGeometry.columnLeft;
    const width = VesselWidgetGeometry.columnRight - VesselWidgetGeometry.columnLeft;
    final text = message;
    return Container(
      width: g.width,
      height: g.height,
      decoration: _card(gc, framed, 24),
      child: Stack(
        children: [
          Positioned(
            left: -34,
            top: 34,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [tone.withValues(alpha: 0.18), tone.withValues(alpha: 0)]),
              ),
            ),
          ),
          Positioned(
            left: left,
            top: 16,
            width: width,
            child: Row(
              children: [
                Icon(icon, size: 13, color: tone),
                const SizedBox(width: 4),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title.toUpperCase(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: _kDisplay,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: gc.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (text != null)
            Positioned(
              left: left,
              top: 40,
              width: width,
              bottom: 14,
              child: Text(
                text,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: _kBody,
                  fontSize: 11,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                  color: gc.textSecondary,
                ),
              ),
            )
          else ...[
            Positioned(
              left: left,
              top: VesselWidgetGeometry.valueBaseline + 4,
              width: width,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  goal,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: _kBody,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: gc.textSecondary,
                  ),
                ),
              ),
            ),
            Positioned(
              left: left,
              top: VesselWidgetGeometry.barTop,
              width: width,
              height: VesselWidgetGeometry.barHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: gc.bgRaised2,
                  borderRadius: BorderRadius.circular(VesselWidgetGeometry.barHeight),
                ),
              ),
            ),
            Positioned(
              left: left,
              top: VesselWidgetGeometry.pillTop,
              width: width,
              height: 22,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    pill,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: _kDisplay,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: tone,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class KcalWidgetView extends StatelessWidget {
  const KcalWidgetView({
    super.key,
    required this.gc,
    required this.kcal,
    required this.goal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.goals,
    required this.unit,
    this.message,
    this.size = const Size(320, 150),
    this.framed = true,
  });

  final GymColors gc;
  final int kcal;
  final int goal;
  final double protein, carbs, fat;
  final (int, int, int) goals;
  final String unit;
  final String? message;
  final Size size;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    final left = goal - kcal;
    final ring = size.height - 30;
    final text = message;
    Widget macro(IconData icon, String label, double value, int target, Color color) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 11, color: color),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                sentenceCase(label),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: _kBody,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: gc.textSecondary,
                ),
              ),
            ),
            Text(
              '${value.round()}',
              style: TextStyle(
                fontFamily: _kDisplay,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: gc.text,
              ),
            ),
            Text(
              ' / $target g',
              style: TextStyle(
                fontFamily: _kBody,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: gc.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        MacroTrack(pct: target <= 0 ? 0 : value / target, color: color, height: 5),
      ],
    );
    return Theme(
      data: ThemeData(extensions: [gc]),
      child: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(15),
        decoration: _card(gc, framed, 24),
        child: text != null
            ? Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: _kBody,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gc.textSecondary,
                  ),
                ),
              )
            : Row(
                children: [
                  CalorieRing(
                    pct: goal <= 0 ? 0 : kcal / goal,
                    size: ring,
                    stroke: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${left.abs()}',
                            style: TextStyle(
                              fontFamily: _kDisplay,
                              fontSize: 25,
                              height: 1.05,
                              fontWeight: FontWeight.w800,
                              color: left < 0 ? gc.danger : gc.text,
                            ),
                          ),
                        ),
                        Text(
                          left < 0 ? t.kcalOver : sentenceCase(t.kcalRemaining),
                          style: TextStyle(
                            fontFamily: _kBody,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: gc.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Icon(PhosphorIconsFill.fire, size: 15, color: gc.warn),
                            const SizedBox(width: 4),
                            Text(
                              '$kcal',
                              style: TextStyle(
                                fontFamily: _kDisplay,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: gc.text,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                ' / $goal $unit',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: _kBody,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: gc.textTertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        macro(PhosphorIconsFill.egg, t.macroProtein, protein, goals.$1, gc.protein),
                        macro(PhosphorIconsFill.grains, t.macroCarbs, carbs, goals.$2, gc.carbs),
                        macro(PhosphorIconsFill.drop, t.macroFat, fat, goals.$3, gc.fat),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
