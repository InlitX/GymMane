import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/theme/app_colors.dart';
import 'package:gymmane/widgets/home_widget_views.dart';

void main() {
  Future<void> draw(WidgetTester tester, Widget view) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: view),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  }

  for (final (name, gc) in [('dark', GymColors.dark), ('light', GymColors.light)]) {
    testWidgets('the four home widgets draw in $name without overflowing', (tester) async {
      await draw(tester, HeatmapWidgetView(gc: gc, levels: List.filled(182, 2), streak: 12));
      await draw(tester, StatsWidgetView(gc: gc, streak: 12, sessionsThisWeek: 3, goalPct: 75));
      await draw(
        tester,
        BodyWidgetView(gc: gc, days: 7, intensity: const {'chest': 1.0, 'back': 0.5, 'quads': 0.1}),
      );
      await draw(tester, TodayWidgetView(gc: gc, done: true, planned: true, streak: 12));
      await draw(tester, TodayWidgetView(gc: gc, done: false, planned: true, streak: 0));
      await draw(tester, TodayWidgetView(gc: gc, done: false, planned: false, streak: 0));
    });
  }

  testWidgets('the iOS sizes draw without a frame and without overflowing', (tester) async {
    const gc = GymColors.dark;
    await draw(tester, HeatmapWidgetView(gc: gc, levels: List.filled(182, 3), streak: 40, framed: false));
    await draw(
      tester,
      const StatsWidgetView(gc: gc, streak: 120, sessionsThisWeek: 5, goalPct: 100, framed: false),
    );
    await draw(
      tester,
      const BodyWidgetView(
        gc: gc,
        days: 7,
        intensity: {'chest': 1.0, 'back': 0.5, 'quads': 0.1},
        size: Size(320, 336),
        framed: false,
      ),
    );
    await draw(
      tester,
      const TodayWidgetView(
        gc: gc,
        done: false,
        planned: true,
        streak: 3,
        size: Size(155, 155),
        framed: false,
      ),
    );
  });

  testWidgets('the muscle map widget survives an empty history', (tester) async {
    await draw(tester, const BodyWidgetView(gc: GymColors.dark, days: 7, intensity: {}));
  });
}
