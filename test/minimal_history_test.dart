import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
    fit.setUnits('kg');
    fit.setMinimalMode(true);
    fit.route = 'history';
    setAppLanguage('en');
  });

  Future<void> pumpHistory(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();
  }

  LoggedSession workout(DateTime date, String name, List<LoggedSet> sets) {
    final exercise = fit.matchExerciseByName('Barbell Bench Press')!;
    return LoggedSession(
      date,
      20 * 60,
      [LoggedExercise(exercise.id, exercise.name, exercise.primary, sets)],
      name: name,
    );
  }

  testWidgets('Minimal List shows the latest 40 sessions newest first and expands inline',
      (tester) async {
    final now = DateTime.now();
    for (var daysAgo = 0; daysAgo < 46; daysAgo++) {
      fit.sessions.add(workout(
        DateTime(now.year, now.month, now.day - daysAgo, 18),
        'Workout ${daysAgo.toString().padLeft(2, '0')}',
        [LoggedSet(8, 60), LoggedSet(6, 70)],
      ));
    }

    await pumpHistory(tester);

    expect(find.text('Workout 00'), findsOneWidget);
    expect(find.text('Workout 39'), findsOneWidget);
    expect(find.text('Workout 40'), findsNothing);
    expect(find.text('Workout 45'), findsNothing);

    await tester.tap(find.text('Workout 00'));
    await tester.pumpAndSettle();
    expect(find.text('Barbell Bench Press'), findsNWidgets(2),
        reason: 'the exercise is shown in the collapsed summary and expanded set detail');
    expect(find.textContaining('60 × 8'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Minimal Table searches all 8 columns and caps rendered rows at 200',
      (tester) async {
    final now = DateTime.now();
    for (var daysAgo = 0; daysAgo < 11; daysAgo++) {
      fit.sessions.add(workout(
        DateTime(now.year, now.month, now.day - daysAgo, 18),
        'Workout $daysAgo',
        [for (var set = 0; set < 20; set++) LoggedSet(8, 40 + set.toDouble())],
      ));
    }

    await pumpHistory(tester);
    await tester.tap(find.byKey(const ValueKey('minimal-history-view-table')));
    await tester.pumpAndSettle();

    expect(find.text('220 sets'), findsOneWidget);
    expect(find.text('Volume'), findsOneWidget);
    expect(find.text('Muscle'), findsOneWidget);
    expect(find.text('Showing 200 of 220 sets. Search to narrow the results.'), findsOneWidget);

    final search = find.byKey(const ValueKey('minimal-history-search'));
    await tester.enterText(search, 'chest');
    await tester.pumpAndSettle();
    expect(find.text('220 sets'), findsOneWidget);

    final target = DateTime(now.year, now.month, now.day - 5);
    final date = '${target.year.toString().padLeft(4, '0')}-'
        '${target.month.toString().padLeft(2, '0')}-'
        '${target.day.toString().padLeft(2, '0')}';
    await tester.enterText(search, date);
    await tester.pumpAndSettle();
    expect(find.text('20 sets'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Minimal History shows a clear empty state', (tester) async {
    await pumpHistory(tester);
    expect(find.text(t.historyEmpty), findsOneWidget);
    expect(find.text('Export Excel'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
