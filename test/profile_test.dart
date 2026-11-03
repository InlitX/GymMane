import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/screens/recap_screen.dart';
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

  test('a medal won while opening the app still gets its celebration', () {
    fit.sessions.add(LoggedSession(DateTime.now(), 1800, const []));
    fit.persistNow();
    fit.pendingAwards.clear();
    fit.loadFromStore();

    expect(fit.hasAward(AwardId.firstWorkout), true);
    expect(fit.pendingAwards, contains(AwardId.firstWorkout),
        reason: 'se ganaba en silencio y aparecía en el perfil sin animación');
  });

  test('a medal already celebrated does not come back on the next launch', () {
    fit.sessions.add(LoggedSession(DateTime.now(), 1800, const []));
    fit.refreshAwards();
    while (fit.nextCelebration != null) {
      fit.celebrationShown();
    }
    fit.persistNow();
    fit.loadFromStore();

    expect(fit.pendingAwards, isEmpty);
  });

  test('a medal you have not earned reports how far along you are', () {
    expect(fit.hasAward(AwardId.sets1000), false);
    expect(fit.awardProgress(AwardId.sets1000), 0);
    expect(fit.awardGoal(AwardId.sets1000), 1000);
  });

  test('you pick which won medals show on the profile, and the pick survives a restart', () {
    fit.profile.medals.clear();
    fit.sessions.addAll([
      for (var i = 0; i < 12; i++) LoggedSession(DateTime.now().subtract(Duration(days: i)), 1800, const []),
    ]);
    fit.refreshAwards(silent: true);
    expect(fit.profileMedals.first, AwardId.values.firstWhere(fit.hasAward), reason: 'sin elegir, salen todas');

    fit.toggleProfileMedal(AwardId.workouts10);
    fit.toggleProfileMedal(AwardId.workouts100);
    expect(fit.profileMedals, [AwardId.workouts10], reason: 'una que no tienes no se puede elegir');

    fit.persistNow();
    fit.profile.medals.clear();
    fit.loadFromStore();
    expect(fit.profileMedals, [AwardId.workouts10]);

    fit.toggleProfileMedal(AwardId.workouts10);
    expect(fit.profileMedals.length, AwardId.values.length, reason: 'sin ninguna elegida vuelve a enseñarlas todas');
  });

  LoggedSession lift(DateTime at, List<(String, double)> work) => LoggedSession(at, 1800, [
        for (final (id, kg) in work) LoggedExercise(id, id, 'chest', [LoggedSet(8, kg), LoggedSet(8, kg)]),
      ]);

  test('the month recap finds new exercises, the longest streak and the toughest session', () {
    fit.sessions.addAll([
      lift(DateTime(2026, 8, 10, 19), [('EIeI8Vf', 60)]),
      lift(DateTime(2026, 9, 3, 19), [('EIeI8Vf', 60), ('qXTaZnJ', 80)]),
      lift(DateTime(2026, 9, 4, 19), [('EIeI8Vf', 60)]),
      lift(DateTime(2026, 9, 5, 19), [('EIeI8Vf', 60)]),
      lift(DateTime(2026, 9, 20, 19), [('EIeI8Vf', 100), ('qXTaZnJ', 140)]),
    ]);
    final extras = recapExtras(fit.recapFor(DateTime(2026, 9)));

    expect(extras.fresh, ['qXTaZnJ'], reason: 'la sentadilla es nueva; el press ya se hizo en agosto');
    expect(extras.streak, 3);
    expect(extras.peak?.date, DateTime(2026, 9, 20, 19));
    expect(extras.yearAgo, 0);
  });

  test('one logged food day is enough for the food page of the recap', () {
    final now = DateTime.now();
    fit.sessions.add(lift(DateTime(now.year, now.month, 1, 19), [('EIeI8Vf', 60)]));
    fit.nutritionBeta = true;
    fit.foodLog.clear();
    fit.nutritionDay = DateTime(now.year, now.month, 1);
    fit.logQuick('Pollo', const Macros(kcal: 600, protein: 400, carbs: 50, fat: 10));
    fit.logQuick('Pollo', const Macros(kcal: 100, protein: 10, carbs: 5, fat: 1));
    final food = recapExtras(fit.recapFor(DateTime(now.year, now.month))).food;

    expect(food?.days, 1);
    expect(food?.hit, 1);
    expect(food?.starTimes, 1, reason: 'dos veces el mismo día cuenta como un día');
    expect(food?.star, isNull, reason: 'una comida estrella pide repetirla otro día');
    fit.foodLog.clear();
    fit.nutritionDay = DateTime(now.year, now.month, now.day);
  });

  test('the exercise wall never repeats a drawing, even with a single exercise', () {
    fit.sessions.add(lift(DateTime(2026, 9, 3, 19), [('EIeI8Vf', 60)]));
    final alone = recapWallIds(fit.recapFor(DateTime(2026, 9)));
    expect(alone.first, 'EIeI8Vf');
    expect(alone.length, 10, reason: 'con uno solo se completa con otros del mismo músculo');
    expect(alone.toSet().length, alone.length, reason: 'sin repetir dibujos');

    fit.sessions.insert(0, lift(DateTime(2026, 8, 3, 19), [('qXTaZnJ', 80), ('eZyBC3j', 50), ('kTbSH9h', 40)]));
    expect(recapWallIds(fit.recapFor(DateTime(2026, 9))).take(4), ['EIeI8Vf', 'qXTaZnJ', 'eZyBC3j', 'kTbSH9h']);
  });
}
