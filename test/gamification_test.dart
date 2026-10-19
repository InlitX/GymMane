import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/services/train_reminder.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/medal_shelf.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    ProgressReminder.instance.enabled = false;
    TrainReminder.instance.enabled = false;
    fit.resetAllData();
    fit.onboarded = true;
    fit.awardsSeen.clear();
    fit.pendingAwards.clear();
  });

  void logWorkouts(int n) {
    final now = DateTime.now();
    for (var i = 0; i < n; i++) {
      fit.sessions.add(
        LoggedSession(now.subtract(Duration(days: i + 1)), 1800, [
          LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(8, 60)]),
        ]),
      );
    }
  }

  test('it is on by default and a new medal is queued to be shown', () {
    expect(fit.gamification, isTrue);
    logWorkouts(1);
    fit.refreshAwards();
    expect(fit.nextCelebration, isNotNull);
  });

  test('switched off, medals are still earned but nothing pops up', () {
    fit.toggleGamification();
    expect(fit.gamification, isFalse);
    logWorkouts(10);
    fit.refreshAwards();
    expect(fit.hasAward(AwardId.workouts10), isTrue);
    expect(fit.pendingAwards, isEmpty);
    expect(fit.nextCelebration, isNull);
    expect(fit.unseenAwards, isEmpty);
  });

  test('switching it off drops the medals waiting to be shown', () {
    logWorkouts(1);
    fit.refreshAwards();
    expect(fit.pendingAwards, isNotEmpty);
    fit.toggleGamification();
    expect(fit.pendingAwards, isEmpty);
    expect(fit.nextCelebration, isNull);
  });

  test('turning it back on does not replay old medals', () {
    fit.toggleGamification();
    logWorkouts(10);
    fit.refreshAwards();
    fit.toggleGamification();
    expect(fit.gamification, isTrue);
    expect(fit.nextCelebration, isNull);
  });

  test('the choice survives a restart', () {
    fit.toggleGamification();
    fit.persistNow();
    fit.gamification = true;
    fit.loadFromStore();
    expect(fit.gamification, isFalse);
    expect(fit.nextCelebration, isNull);
  });

  testWidgets('the profile hides medals and level when it is off', (tester) async {
    setAppLanguage('en');
    logWorkouts(3);
    fit.refreshAwards(silent: true);
    fit.pendingAwards.clear();
    fit.resetRoute('settings');

    Future<void> show() async {
      await tester.pumpWidget(const GymManeApp());
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    await show();
    expect(find.byType(MedalShelf), findsOneWidget);
    expect(find.text(t.levelShort(fit.athleteLevel)), findsOneWidget);

    fit.toggleGamification();
    await show();
    expect(find.byType(MedalShelf), findsNothing);
    expect(find.text(t.levelShort(fit.athleteLevel)), findsNothing);
    expect(find.text(t.awardsTitle), findsNothing);

    await tester.pumpWidget(const SizedBox());
  });
}
