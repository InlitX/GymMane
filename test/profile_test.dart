import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.sessions.clear();
    fit.awards.clear();
    fit.awardsSeen.clear();
    fit.profile.badge = '';
    fit.profile.handle = '';
    fit.profile.since = null;
  });

  test('the handle falls back to the name until you set your own', () {
    fit.profile.name = 'Inlitx Lifts';
    expect(fit.profileHandle, 'inlitxlifts');

    fit.setProfileHandle(' my.handle! ');
    expect(fit.profileHandle, 'my.handle');
  });

  test('the badge is a toggle, not a one-way door', () {
    fit.setProfileBadge('blue');
    expect(fit.profile.badge, 'blue');

    fit.setProfileBadge('green');
    expect(fit.profile.badge, 'green');

    fit.setProfileBadge('green');
    expect(fit.profile.badge, '', reason: 'tocar la que tienes la quita');
  });

  test('the join date comes from the first workout, not from today', () {
    final old = DateTime.now().subtract(const Duration(days: 400));
    fit.sessions.add(LoggedSession(old, 1800, const []));
    fit.persistNow();
    fit.profile.since = null;
    fit.loadFromStore();

    expect(fit.memberSince.year, old.year);
    expect(fit.memberSince.month, old.month);
  });

  test('a medal is won once and keeps the day it was won', () {
    fit.sessions.addAll([
      for (var i = 0; i < 100; i++)
        LoggedSession(DateTime.now().subtract(Duration(days: i)), 1800, const []),
    ]);
    fit.refreshAwards();

    expect(fit.hasAward(AwardId.workouts100), true);
    expect(fit.unseenAwards, contains(AwardId.workouts100));
    final won = fit.awardWonAt(AwardId.workouts100);

    fit.sessions.add(LoggedSession(DateTime.now(), 1800, const []));
    fit.refreshAwards();
    expect(fit.awardWonAt(AwardId.workouts100), won, reason: 'no se vuelve a ganar');

    fit.markAwardsSeen();
    expect(fit.unseenAwards, isEmpty);
  });

  test('a medal you have not earned reports how far along you are', () {
    expect(fit.hasAward(AwardId.sets1000), false);
    expect(fit.awardProgress(AwardId.sets1000), 0);
    expect(fit.awardGoal(AwardId.sets1000), 1000);
  });
}
