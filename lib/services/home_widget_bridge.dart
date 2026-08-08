import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../widgets/home_widget_views.dart';

class HomeWidgetBridge {
  HomeWidgetBridge._();

  static const _pkg = 'com.gymmane.app';
  static const heatmapKey = 'heatmap_img';
  static const statsKey = 'stats_img';
  static bool get _supported => !kIsWeb && Platform.isAndroid;

  static Future<void> update() async {
    if (!_supported) return;
    try {
      final gc = fit.dark ? GymColors.dark : GymColors.light;
      await HomeWidget.renderFlutterWidget(
        HeatmapWidgetView(
          gc: gc,
          levels: fit.heatmapLevelsFor(182),
          streak: fit.currentStreak,
          size: const Size(320, 150),
        ),
        key: heatmapKey,
        logicalSize: const Size(320, 150),
        pixelRatio: 3,
      );
      await HomeWidget.renderFlutterWidget(
        StatsWidgetView(
          gc: gc,
          streak: fit.currentStreak,
          sessionsThisWeek: fit.sessionsThisWeek,
          goalPct: fit.goalPct,
          size: const Size(155, 155),
        ),
        key: statsKey,
        logicalSize: const Size(155, 155),
        pixelRatio: 3,
      );
      await HomeWidget.updateWidget(
          qualifiedAndroidName: '$_pkg.HeatmapWidgetProvider');
      await HomeWidget.updateWidget(
          qualifiedAndroidName: '$_pkg.StatsWidgetProvider');
    } catch (e) {
      debugPrint('HomeWidgetBridge.update falló: $e');
    }
  }
}
