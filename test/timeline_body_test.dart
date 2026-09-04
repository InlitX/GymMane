import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/screens/timeline_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _host(Widget Function() screen) => MaterialApp(
      theme: AppTheme.dark,
      home: AnimatedBuilder(
        animation: fit,
        builder: (_, _) => Scaffold(body: screen()),
      ),
    );

LoggedSession _session(int daysAgo, String primary, int sets) => LoggedSession(
      DateTime.now().subtract(Duration(days: daysAgo)),
      1800,
      [LoggedExercise('x$daysAgo', 'x$daysAgo', primary, List.generate(sets, (_) => LoggedSet(10, 60)))],
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    ProgressReminder.instance.enabled = false;
    setAppLanguage('es');
    fit.sessions.clear();
    fit.setPhotoInterval(30);
    fit.setBodyTimeline(false);
  });

  tearDown(() {
    fit.sessions.clear();
    fit.setBodyTimeline(false);
    fit.persistNow();
  });

  test('with no sessions there is no muscle timeline', () {
    expect(fit.bodyWindows, isEmpty);
  });

  test('windows walk back from today in interval-sized steps', () {
    fit.sessions.add(_session(2, 'chest', 4));
    fit.sessions.add(_session(40, 'quads', 6));
    fit.setPhotoInterval(30);

    final windows = fit.bodyWindows;
    expect(windows.length, 2);
    expect(daysBetween(windows.first.from, windows.first.to), 29);
    expect(windows.first.sessions, 1);
    expect(windows.first.heat['chest'], greaterThan(0));
    expect(windows.last.heat['quads'], greaterThan(0));
    expect(windows.first.to.isAfter(windows.last.to), true);
  });

  test('the window follows the interval you picked', () {
    fit.sessions.add(_session(1, 'back', 4));
    fit.setPhotoInterval(15);
    expect(daysBetween(fit.bodyWindows.first.from, fit.bodyWindows.first.to), 14);

    fit.setPhotoInterval(0);
    expect(fit.bodyWindowDays, 30, reason: 'sin recordatorio la ventana sigue siendo de un mes');
  });

  test('the muscle map mode survives a save and a reload', () {
    fit.setBodyTimeline(true);
    fit.persistNow();
    fit.bodyTimeline = false;
    fit.loadFromStore();
    expect(fit.bodyTimeline, true);
  });

  testWidgets('every interval button lands on a phone-sized screen', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_host(TimelineScreen.new));
    await tester.pumpAndSettle();

    for (final days in [15, 60, 90, 0]) {
      final label = days <= 0 ? t.photoEveryOff : '$days';
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      expect(fit.photoIntervalDays, days, reason: 'el botón de $label no hizo nada');
    }
    fit.persistNow();
  });

  testWidgets('the muscle map mode drops the photo buttons and draws the body', (tester) async {
    fit.sessions.add(_session(1, 'chest', 4));
    await tester.pumpWidget(_host(TimelineScreen.new));
    await tester.pumpAndSettle();

    expect(find.text(t.addTodayPhotos), findsOneWidget);

    await tester.tap(find.text(t.timelineBody));
    await tester.pumpAndSettle();

    expect(fit.bodyTimeline, true);
    expect(find.text(t.addTodayPhotos), findsNothing);
    expect(find.text(t.timelineBodyHint), findsOneWidget);
    fit.persistNow();
  });
}
