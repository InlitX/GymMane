import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/live_session.dart';
import 'package:gymmane/screens/session_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    setAppLanguage('en');
  });

  tearDown(() => fit.saveAndExit());

  for (final sided in [false, true]) {
    testWidgets('weight label explains ${sided ? 'one side' : 'one dumbbell'}', (tester) async {
      tester.view.physicalSize = const Size(430, 932);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final ex = fit.matchExerciseByName('Dumbbell Hammer Curl') ?? fit.matchExerciseByName('Dumbbell Curl')!;
      fit.togglePaired(ex.id);
      if (sided) fit.toggleSidedReps(ex.id);
      fit.session = WorkoutSession()
        ..exercises = [
          SessionExercise(ex.id, ex.name, ex.primary, [SessionSet(10, 10, false, repsR: sided ? 10 : null)]),
        ];
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(body: SessionScreen()),
        ),
      );
      await tester.pump(const Duration(seconds: 1));
      expect(find.text(sided ? t.weightPerSideCol('KG') : t.weightPerDumbbellCol('KG')), findsOneWidget);
      if (sided) {
        expect(find.text(t.repsLeftCol), findsOneWidget);
        expect(find.text(t.repsRightCol), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    });
  }
}
