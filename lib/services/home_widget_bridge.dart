import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../widgets/home_widget_views.dart';

class HomeWidgetBridge {
  HomeWidgetBridge._();

  static const _pkg = 'com.gymmane.app';
  static const appGroup = 'group.com.gymmane.app';
  static const heatmapKey = 'heatmap_img';
  static const statsKey = 'stats_img';
  static const bodyKey = 'body_img';
  static const todayKey = 'today_img';
  static const todayIdleKey = 'today_idle_img';
  static const todayPlanKey = 'today_plan_img';
  static const todayRestKey = 'today_rest_img';
  static const weekKey = 'week_img';
  static const weekFreshKey = 'week_fresh_img';
  static const darkKey = 'widget_dark';
  static const themeKey = 'widget_theme';
  static const bodyDays = 7;
  static bool get _ios => !kIsWeb && Platform.isIOS;
  static bool get _supported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  static bool _groupReady = false;
  static Timer? _debounce;
  static Future<void>? _job;
  static String? _allPainted;
  static final Set<String> _forced = {};

  static void update() {
    if (!_supported) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), _run);
  }

  static Future<void> _run() async {
    while (_job != null) {
      await _job;
    }
    final job = _paint();
    _job = job;
    try {
      await job;
    } finally {
      _job = null;
    }
  }

  static Future<void> updateNow({String? provider}) {
    if (provider != null) _forced.add(provider);
    _debounce?.cancel();
    return _run();
  }

  static Future<void> _paint() async {
    try {
      final today = _stamp(DateTime.now());
      final everyone = _allPainted != today;
      final installed = _ios || everyone
          ? null
          : {
              ..._forced,
              for (final w in await HomeWidget.getInstalledWidgets()) w.androidClassName?.split('.').last,
            };
      _forced.clear();
      if (installed != null && installed.isEmpty) return;
      bool wants(String provider) => installed == null || installed.contains(provider);
      if (_ios && !_groupReady) {
        await HomeWidget.setAppGroupId(appGroup);
        _groupReady = true;
      }
      final pref = fit.themePref;
      final day = pref == 'dark' ? GymColors.dark : GymColors.light;
      final night = pref == 'light' ? GymColors.light : GymColors.dark;
      final framed = !_ios;
      const heatmapSize = Size(320, 150);
      const statsSize = Size(155, 155);
      final bodySize = _ios ? const Size(320, 336) : const Size(320, 220);
      final todaySize = _ios ? const Size(155, 155) : const Size(120, 120);
      const weekSize = Size(320, 150);
      final week = [for (var i = 0; i < 7; i++) fit.isDayDone(i)];
      final levels = fit.heatmapWeeksFor(26);
      final heat = fit.muscleHeatOver(bodyDays);
      final plannedToday = fit.todayRoutine != null;
      final hasPlan = fit.weeklyPlan.isNotEmpty;

      final views = <(String, String, Size, Widget Function(GymColors))>[
        (
          'HeatmapWidgetProvider',
          heatmapKey,
          heatmapSize,
          (gc) => HeatmapWidgetView(
                gc: gc,
                levels: levels,
                streak: fit.currentStreak,
                size: heatmapSize,
                framed: framed,
              ),
        ),
        (
          'StatsWidgetProvider',
          statsKey,
          statsSize,
          (gc) => StatsWidgetView(
                gc: gc,
                streak: fit.currentStreak,
                sessionsThisWeek: fit.daysDoneThisWeek,
                goalPct: fit.goalPct,
                size: statsSize,
                framed: framed,
              ),
        ),
        (
          'BodyWidgetProvider',
          bodyKey,
          bodySize,
          (gc) => BodyWidgetView(
                gc: gc,
                intensity: heat,
                days: bodyDays,
                size: bodySize,
                framed: framed,
              ),
        ),
        (
          'TodayWidgetProvider',
          todayKey,
          todaySize,
          (gc) => TodayWidgetView(
                gc: gc,
                done: fit.todayPlanDone,
                planned: plannedToday,
                rest: !plannedToday && hasPlan,
                streak: fit.currentStreak,
                size: todaySize,
                framed: framed,
              ),
        ),
        for (final (key, planned, rest) in [
          (todayIdleKey, false, false),
          (todayPlanKey, true, false),
          (todayRestKey, false, true),
        ])
          (
            'TodayWidgetProvider',
            key,
            todaySize,
            (gc) => TodayWidgetView(
                  gc: gc,
                  done: false,
                  planned: planned,
                  rest: rest,
                  streak: 0,
                  size: todaySize,
                  framed: framed,
                ),
          ),
        (
          'WeekWidgetProvider',
          weekKey,
          weekSize,
          (gc) => WeekWidgetView(gc: gc, done: week, goal: fit.weeklyTarget, size: weekSize, framed: framed),
        ),
        (
          'WeekWidgetProvider',
          weekFreshKey,
          weekSize,
          (gc) => WeekWidgetView(
                gc: gc,
                done: List.filled(7, false),
                goal: fit.weeklyTarget,
                size: weekSize,
                framed: framed,
              ),
        ),
      ];
      for (final (provider, key, size, build) in views) {
        if (!wants(provider)) continue;
        await _render(build(day), key, size);
        if (!identical(day, night)) {
          await _render(build(night), '${key}_night', size);
        } else {
          final path = await HomeWidget.getWidgetData<String>(key);
          if (path != null) await HomeWidget.saveWidgetData<String>('${key}_night', path);
        }
      }
      final now = DateTime.now();
      if (everyone) _allPainted = today;
      await HomeWidget.saveWidgetData<String>('today_stamp', _stamp(now));
      final plan = [
        for (var d = 1; d <= 7; d++) fit.routineOn(now.add(Duration(days: d - now.weekday))) != null ? '1' : '0',
      ];
      await HomeWidget.saveWidgetData<String>('today_week', plan.join());
      await HomeWidget.saveWidgetData<String>('week_start', _stamp(fit.weekStartDate));
      await HomeWidget.saveWidgetData<String>('week_first', '${fit.weekStartDay}');
      await HomeWidget.saveWidgetData<String>('week_done', [for (final d in week) d ? '1' : '0'].join());
      await HomeWidget.saveWidgetData<String>(
          'week_geo', WeekWidgetView.geometry(weekSize, framed: framed).map((v) => v.toStringAsFixed(5)).join(','));
      await HomeWidget.saveWidgetData<String>('week_ring', _hex(day.ember));
      await HomeWidget.saveWidgetData<String>('week_ring_night', _hex(night.ember));
      if (_ios) {
        await HomeWidget.saveWidgetData<bool>(darkKey, fit.dark);
        await HomeWidget.saveWidgetData<String>(themeKey, pref);
      }

      for (final (android, ios) in const [
        ('HeatmapWidgetProvider', 'HeatmapWidget'),
        ('BodyWidgetProvider', 'BodyWidget'),
        ('TodayWidgetProvider', 'TodayWidget'),
        ('StatsWidgetProvider', 'StatsWidget'),
        ('WeekWidgetProvider', 'WeekWidget'),
      ]) {
        if (wants(android)) await _reload(android, ios);
      }
    } catch (e) {
      debugPrint('HomeWidgetBridge.update falló: $e');
    }
  }

  static String _stamp(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String _hex(Color c) => '#${c.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

  static Future<void> _render(Widget view, String key, Size size) =>
      HomeWidget.renderFlutterWidget(view, key: key, logicalSize: size, pixelRatio: 3);

  static Future<void> _reload(String android, String ios) => HomeWidget.updateWidget(
        qualifiedAndroidName: '$_pkg.$android',
        iOSName: ios,
      );
}
