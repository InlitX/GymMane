import 'package:flutter_test/flutter_test.dart';
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
  });

  tearDown(() {
    fit.saveAndExit();
    fit.sessions.clear();
  });

  void startAndLog() {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    fit.startSession();
    fit.setSessionReps(0, 0, 8);
    fit.setSessionWeight(0, 0, 72.5);
    fit.toggleSet(0, 0);
    fit.nextExercise();
  }

  void killAndReopen() {
    fit.persistNow();
    fit.session = null;
    fit.route = 'home';
    fit.loadFromStore();
  }

  test('a workout in progress survives the app being killed', () {
    startAndLog();
    killAndReopen();

    expect(fit.session, isNotNull, reason: 'el entreno no puede evaporarse');
    expect(fit.route, 'session', reason: 'vuelves justo donde estabas');
    expect(fit.session!.currentIndex, 1, reason: 'y en el ejercicio en el que ibas');

    final firstSet = fit.session!.exercises[0].sets[0];
    expect(firstSet.reps, 8);
    expect(firstSet.weight, 72.5);
    expect(firstSet.done, true, reason: 'la serie marcada sigue marcada');
  });

  test('the clock keeps counting real time while the app is dead', () {
    startAndLog();

    fit.persistNow();
    final raw = Store.instance.load();
    raw['liveStart'] = DateTime.now().subtract(const Duration(minutes: 10)).toIso8601String();
    Store.instance.save(raw);

    fit.session = null;
    fit.loadFromStore();

    expect(fit.sessionElapsed, greaterThanOrEqualTo(600),
        reason: 'los 10 minutos pasaron aunque la app estuviera muerta');
    expect(fit.sessionPaused, false);
  });

  test('a paused workout comes back paused, not silently running', () {
    startAndLog();
    fit.toggleSessionPause();
    final frozen = fit.sessionElapsed;

    killAndReopen();

    expect(fit.sessionPaused, true);
    expect(fit.sessionElapsed, frozen, reason: 'en pausa el reloj no corre ni estando muerta');
  });

  test('the rest timer is not resurrected — that rest already happened', () {
    startAndLog();
    fit.startRest();
    expect(fit.session!.restRemaining, isNotNull);

    killAndReopen();
    expect(fit.session!.restRemaining, isNull);
  });

  test('finishing clears the rescue copy so it does not reappear', () {
    startAndLog();
    fit.finishSession();
    fit.saveAndExit();

    expect(Store.instance.load().containsKey('live'), false);
    fit.loadFromStore();
    expect(fit.session, isNull);
    expect(fit.route, 'home');
  });

  test('discarding a workout leaves nothing to come back to', () {
    startAndLog();
    fit.discardSession();
    expect(Store.instance.load().containsKey('live'), false);
    fit.loadFromStore();
    expect(fit.session, isNull);
  });

  test('a finished-but-unsaved summary is not treated as live', () {
    startAndLog();
    fit.finishSession();
    fit.persistNow();
    expect(Store.instance.load().containsKey('live'), false,
        reason: 'la sesión completa ya está en el historial');
  });
}
