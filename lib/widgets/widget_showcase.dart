import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import 'home_widget_views.dart';
import 'nutrition_art.dart';
import 'settings_showcase.dart' show ShowcaseFrame;

class WidgetShowcase extends StatelessWidget {
  const WidgetShowcase({super.key, this.height = 380});

  static bool _warm = false;

  static void warm(BuildContext context) {
    if (_warm) return;
    _warm = true;
    final h = (VesselWidgetGeometry.vesselHeight * MediaQuery.devicePixelRatioOf(context)).round();
    for (final a in const [
      'assets/img/vessel-water.webp',
      'assets/img/vessel-water-mask.webp',
      'assets/img/vessel-shake.webp',
      'assets/img/vessel-shake-mask.webp',
    ]) {
      precacheImage(ResizeImage(AssetImage(a), height: h, policy: ResizeImagePolicy.fit), context);
    }
    precacheImage(const AssetImage('assets/img/shake-texture.webp'), context);
  }

  final double height;

  static const _gap = 10.0;

  static final _levels = [
    for (var i = 0; i < 7 * 40; i++) const [0, 2, 0, 3, 1, 4, 0, 0, 2, 3, 0, 1, 4, 2][(i * 7 + i ~/ 9) % 14],
  ];

  static const _body = {
    'chest': 0.9,
    'shoulders': 0.6,
    'triceps': 0.7,
    'back': 0.8,
    'biceps': 0.5,
    'quads': 0.75,
    'glutes': 0.55,
    'hamstrings': 0.4,
    'abdomen': 0.3,
  };

  Widget _vessel(
    GymColors gc, {
    required String title,
    required IconData icon,
    required Color tone,
    required Color liquid,
    required String asset,
    required double top,
    required double bottom,
    required double curve,
    String? texture,
    required String value,
    required String goal,
    required String pill,
    required double level,
  }) {
    const g = VesselWidgetGeometry.size;
    const column = VesselWidgetGeometry.columnRight - VesselWidgetGeometry.columnLeft;
    return SizedBox(
      width: g.width,
      height: g.height,
      child: Stack(children: [
        VesselWidgetView(gc: gc, title: title, icon: icon, tone: tone, goal: goal, pill: pill),
        Positioned(
          left: VesselWidgetGeometry.vesselLeft,
          top: VesselWidgetGeometry.vesselTop,
          height: VesselWidgetGeometry.vesselHeight,
          width: 56,
          child: PhotoVessel(
            asset: asset,
            level: level,
            height: VesselWidgetGeometry.vesselHeight,
            top: top,
            bottom: bottom,
            curve: curve,
            liquid: liquid,
            texture: texture,
            animate: false,
          ),
        ),
        Positioned(
          left: VesselWidgetGeometry.columnLeft,
          top: VesselWidgetGeometry.valueBaseline - VesselWidgetGeometry.valueSize - 2,
          child: Text(value,
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: VesselWidgetGeometry.valueSize,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                  color: gc.text)),
        ),
        Positioned(
          left: VesselWidgetGeometry.columnLeft,
          top: VesselWidgetGeometry.barTop,
          width: column * level,
          height: VesselWidgetGeometry.barHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(color: tone, borderRadius: BorderRadius.circular(VesselWidgetGeometry.barHeight)),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget lift(Widget child) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 6))],
          ),
          child: child,
        );
    Widget col(double top, List<Widget> items) => Padding(
          padding: EdgeInsets.only(top: top),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(height: _gap),
              items[i] is Row || items[i] is Align ? items[i] : lift(items[i]),
            ],
          ]),
        );

    final small = col(0, [
      Align(
        alignment: Alignment.centerRight,
        child: Transform.translate(
          offset: const Offset(6, 0),
          child: lift(TodayWidgetView(gc: gc, done: true, planned: true, streak: 12, size: const Size(112, 112))),
        ),
      ),
      _vessel(gc,
          title: t.waterLabel,
          icon: PhosphorIconsFill.drop,
          tone: gc.water,
          liquid: const Color(0xFF4FB4F2),
          asset: 'assets/img/vessel-water.webp',
          top: 0.269,
          bottom: 0.989,
          curve: 0.08,
          value: '1.5',
          goal: '/ 2.5 L',
          pill: '+ 250 ml',
          level: 0.6),
      _vessel(gc,
          title: t.macroProtein,
          icon: PhosphorIconsFill.lightning,
          tone: gc.protein,
          liquid: const Color(0xFFB98F72),
          asset: 'assets/img/vessel-shake.webp',
          top: 0.407,
          bottom: 0.975,
          curve: 0.066,
          texture: 'assets/img/shake-texture.webp',
          value: '96',
          goal: '/ 150 g',
          pill: '+ 24 g',
          level: 0.64),
      TodayWidgetView(gc: gc, done: false, planned: true, streak: 12, size: const Size(155, 155)),
    ]);
    final wide = col(40, [
      HeatmapWidgetView(gc: gc, levels: _levels, streak: 12),
      KcalWidgetView(
        gc: gc,
        kcal: 1640,
        goal: 2400,
        protein: 96,
        carbs: 180,
        fat: 52,
        goals: (150, 260, 70),
        unit: 'kcal',
      ),
      BodyWidgetView(gc: gc, intensity: _body, days: 7, size: const Size(320, 220)),
      Align(
        alignment: Alignment.centerRight,
        child: lift(TodayWidgetView(gc: gc, done: false, planned: false, rest: true, streak: 12, size: const Size(130, 130))),
      ),
    ]);
    final mixed = Padding(
      padding: const EdgeInsets.only(top: 72),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        lift(StatsWidgetView(gc: gc, streak: 12, sessionsThisWeek: 3, goalPct: 75, size: const Size(155, 172))),
        const SizedBox(height: _gap),
        lift(RotatedBox(
          quarterTurns: 1,
          child: WeekWidgetView(gc: gc, done: const [true, false, true, true, false, true, false], goal: 4, size: const Size(348, 155)),
        )),
      ]),
    );

    return ShowcaseFrame(
      height: height,
      child: ExcludeSemantics(
      child: IgnorePointer(
        child: SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: ColoredBox(
              color: gc.bgRaised,
              child: OverflowBox(
                maxWidth: 1000,
                maxHeight: 1000,
                child: Transform.translate(
                  offset: const Offset(16, -26),
                  child: Transform.rotate(
                  angle: -0.16,
                  child: Transform.scale(
                    scale: 0.66,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 155,
                          height: 602,
                          child: OverflowBox(alignment: Alignment.topCenter, maxHeight: double.infinity, child: small),
                        ),
                        const SizedBox(width: _gap),
                        SizedBox(
                          width: 320,
                          height: 602,
                          child: OverflowBox(alignment: Alignment.topCenter, maxHeight: double.infinity, child: wide),
                        ),
                        const SizedBox(width: _gap),
                        mixed,
                      ],
                    ),
                  ),
                ),
                ),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
