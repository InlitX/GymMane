import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/screens/progress_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    setAppLanguage('en');
  });

  testWidgets('Activity shows duration and distance for logged timed sets', (tester) async {
    final day = DateTime(2026, 10, 12);
    fit.sessions.add(
      LoggedSession(DateTime(2026, 10, 12, 18), 1800, [
        LoggedExercise('plank', 'Plank', 'abdomen', [LoggedSet(0, 0, sec: 45), LoggedSet(0, 0, sec: 70)]),
        LoggedExercise('outdoor-run', 'Outdoor Run', 'quads', [LoggedSet(0, 0, sec: 1800, km: 5.25)]),
        LoggedExercise('barbell-bench-press', 'Barbell Bench Press', 'chest', [LoggedSet(8, 60)]),
      ]),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: Builder(
            builder: (context) =>
                TextButton(onPressed: () => showDaySheet(context, day), child: const Text('Open Activity')),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open Activity'));
    await tester.pumpAndSettle();

    expect(find.text('0:45 · 1:10'), findsOneWidget);
    expect(find.text('5.25 km · 30:00'), findsOneWidget);
    expect(find.text('60×8'), findsOneWidget);
    expect(find.text('0×0'), findsNothing);
  });
}
