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
    fit.saveAndExit();
    fit.sessions.clear();
    fit.bodyweight.clear();
    fit.onboarded = true;
  });

  LoggedSession log(String name, double kg, {int daysAgo = 0}) {
    final s = LoggedSession(
      DateTime.now().subtract(Duration(days: daysAgo)),
      600,
      [LoggedExercise('e-$name', name, 'chest', [LoggedSet(5, kg)])],
    );
    fit.sessions.add(s);
    return s;
  }

  test('a mis-logged exercise can be removed, and the records follow', () {
    log('Bench', 60);
    final fat = log('Bench Typo', 1000);
    expect(fit.personalRecords.first.topWeight, 1000);

    fit.deleteLoggedExercise(fat, fat.exercises.first);
    expect(fit.personalRecords.first.topWeight, 60, reason: 'el récord falso desaparece');
  });

  test('removing the last exercise takes the whole session with it', () {
    final s = log('Bench', 60);
    fit.deleteLoggedExercise(s, s.exercises.first);
    expect(fit.sessions, isEmpty, reason: 'una sesión sin ejercicios no es una sesión');
  });

  test('deleting a session updates volume and the heatmap', () {
    final s = log('Bench', 60);
    expect(fit.volume30dKg, greaterThan(0));
    expect(fit.daySummary(DateTime.now()), isNotNull);

    fit.deleteSession(s);
    expect(fit.volume30dKg, 0);
    expect(fit.daySummary(DateTime.now()), isNull);
  });

  test('the deletion is written to disk, not just to memory', () async {
    final s = log('Bench', 60);
    fit.deleteSession(s);
    await pumpEventQueue();
    fit.loadFromStore();
    expect(fit.sessions, isEmpty, reason: 'no puede resucitar al reabrir');
  });

  test('a session finished this instant already counts', () {
    log('Bench', 60);
    expect(fit.volume30dKg, 300);
    expect(fit.setsToday, 1);
  });

  test('the 30-day window really cuts at 30 days', () {
    log('Reciente', 60, daysAgo: 29);
    log('Viejo', 60, daysAgo: 31);
    expect(fit.volume30dKg, 300, reason: 'solo entra la de hace 29 días');
  });

  test('sessionsOn returns a day newest first', () {
    log('A', 60, daysAgo: 0);
    log('B', 70, daysAgo: 1);
    final today = fit.sessionsOn(DateTime.now());
    expect(today.length, 1);
    expect(today.first.exercises.first.name, 'A');
  });

  test('a bad bodyweight entry can be deleted and the profile heals', () {
    fit.addBodyweight(75);
    fit.addBodyweight(750);
    expect(fit.profile.weightKg, 750);

    fit.deleteBodyweight(fit.latestBodyweight!);
    expect(fit.bodyweight.length, 1);
    expect(fit.profile.weightKg, 75, reason: 'el perfil vuelve a la última pesada real');
  });

  test('deleting the only bodyweight entry leaves no ghost', () {
    fit.addBodyweight(75);
    fit.deleteBodyweight(fit.bodyweight.single);
    expect(fit.bodyweight, isEmpty);
    expect(fit.latestBodyweight, isNull);
  });

  test('bodyweight history reads newest first', () {
    fit.bodyweight
      ..add(BodyweightEntry(DateTime.now().subtract(const Duration(days: 2)), 74))
      ..add(BodyweightEntry(DateTime.now(), 76));
    expect(fit.bodyweightHistory.first.kg, 76);
  });

  test('onboarding is asked once and then remembered', () async {
    fit.onboarded = false;
    fit.completeOnboarding();
    expect(fit.onboarded, true);

    await pumpEventQueue();
    fit.onboarded = false;
    fit.loadFromStore();
    expect(fit.onboarded, true, reason: 'no se pregunta dos veces');
  });

  test('a backup without the flag does not silently re-ask', () {

    expect(fit.importJson('{"profile":{"name":"Legacy"}}'), true);
    expect(fit.onboarded, true);
  });
}
