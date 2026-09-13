import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/screens/home_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/award_celebration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    ProgressReminder.instance.enabled = false;
    setAppLanguage('es');
    fit.onboarded = true;
    fit.session = null;
    fit.sessions.clear();
    fit.awards.clear();
    fit.awardsSeen.clear();
    fit.pendingAwards.clear();
    fit.resetRoute('home');
  });

  double homeOpacity(WidgetTester tester) {
    final fade = tester.widget<FadeTransition>(
      find
          .ancestor(of: find.byType(HomeScreen), matching: find.byType(FadeTransition))
          .first,
    );
    return fade.opacity.value;
  }

  testWidgets('the screen being left is gone before the new one shows up', (tester) async {
    await tester.pumpWidget(const GymManeApp());
    await tester.pump();

    fit.goProgress();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(homeOpacity(tester), 0, reason: 'la pantalla anterior se quedaba de fondo');

    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('a medal waits before taking over the screen', (tester) async {
    await tester.pumpWidget(const GymManeApp());
    await tester.pump();

    fit.refreshAwards();
    await tester.pump();
    expect(find.byType(AwardCelebration), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(AwardCelebration), findsNothing,
        reason: 'no da tiempo a ver la app antes de la medalla');

    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(AwardCelebration), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    fit.persistNow();
  });

  testWidgets('medals queue up one after another with a pause in between', (tester) async {
    await tester.pumpWidget(const GymManeApp());
    await tester.pump();

    fit.sessions.add(LoggedSession(DateTime.now(), 1200, [
      LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(10, 60)]),
    ]));
    fit.refreshAwards();
    expect(fit.pendingAwards.length, greaterThan(1));

    await tester.pump(const Duration(seconds: 3));
    expect(find.byType(AwardCelebration), findsOneWidget);

    await tester.tap(find.text(t.awardNice));
    await tester.pump();
    expect(find.byType(AwardCelebration), findsNothing);

    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(AwardCelebration), findsNothing,
        reason: 'la segunda medalla salía pegada a la primera');

    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(AwardCelebration), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    fit.persistNow();
  });
}
