import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/state/fit_state.dart';

void main() {
  setUp(() {
    fit.saveAndExit();
    fit.sessions.clear();
    fit.setUnits('kg');
  });
  tearDown(() => fit.setUnits('kg'));

  void startSession() {
    fit.startWorkout();
    fit.toggleMuscle('chest');
    fit.trainContinue();
    fit.startSession();
  }

  test('kg is the identity — nothing is converted', () {
    fit.setUnits('kg');
    expect(fit.toDisplayWeight(100), 100);
    expect(fit.fromDisplayWeight(100), 100);
    expect(fit.weightLabel(60), '60 kg');
    expect(fit.weightStep, 2.5);
  });

  test('lb only changes what is shown', () {
    fit.setUnits('lb');
    expect(fit.toDisplayWeight(100), closeTo(220.462, 0.001));
    expect(fit.fromDisplayWeight(220.462), closeTo(100, 0.001));
    expect(fit.weightLabel(100), '220.5 lb');
    expect(fit.weightStep, 5);
  });

  test('switching units never rewrites what was stored', () {
    startSession();
    fit.setSessionWeight(0, 0, 100);
    final stored = fit.session!.exercises[0].sets[0].weight;

    fit.setUnits('lb');
    expect(fit.session!.exercises[0].sets[0].weight, stored, reason: 'el kg guardado no se toca');
    expect(fit.weightValue(stored), '220.5');

    fit.setUnits('kg');
    expect(fit.weightValue(stored), '100');
    fit.saveAndExit();
  });

  test('typing a weight in lb round-trips back to the same lb', () {
    fit.setUnits('lb');
    startSession();
    fit.setSessionWeightShown(0, 0, 135);
    expect(fit.weightValue(fit.session!.exercises[0].sets[0].weight), '135');
    fit.saveAndExit();
  });

  test('repeated unit flipping does not erode the weight', () {
    fit.setUnits('lb');
    startSession();
    fit.setSessionWeightShown(0, 0, 225);
    for (var i = 0; i < 20; i++) {
      fit.setUnits(i.isEven ? 'kg' : 'lb');
    }
    fit.setUnits('lb');
    expect(fit.weightValue(fit.session!.exercises[0].sets[0].weight), '225');
    fit.saveAndExit();
  });

  test('the stepper moves in whole plates of the active unit', () {
    fit.setUnits('lb');
    startSession();
    fit.setSessionWeightShown(0, 0, 135);
    fit.bumpSessionWeight(0, 0, 1);
    expect(fit.weightValue(fit.session!.exercises[0].sets[0].weight), '140');
    fit.bumpSessionWeight(0, 0, -1);
    expect(fit.weightValue(fit.session!.exercises[0].sets[0].weight), '135');

    fit.setUnits('kg');
    fit.setSessionWeightShown(0, 0, 60);
    fit.bumpSessionWeight(0, 0, 1);
    expect(fit.weightValue(fit.session!.exercises[0].sets[0].weight), '62.5');
    fit.saveAndExit();
  });

  test('the stepper never drives the weight negative', () {
    startSession();
    fit.setSessionWeight(0, 0, 0);
    fit.bumpSessionWeight(0, 0, -1);
    expect(fit.session!.exercises[0].sets[0].weight, 0);
    fit.saveAndExit();
  });

  test('volume is summarised in the active unit', () {
    fit.setUnits('kg');
    expect(fit.volumeUnit, 't');
    expect(fit.volumeLabel(12400), '12.4 t');

    fit.setUnits('lb');
    expect(fit.volumeUnit, 'k lb');
    expect(fit.volumeLabel(12400), '27.3 k lb');
  });

  test('bodyweight logged in lb comes back as the same lb', () {
    fit.setUnits('lb');
    fit.addBodyweight(fit.fromDisplayWeight(180));
    expect(fit.weightValue(fit.latestBodyweight!.kg), '180');
    fit.bodyweight.clear();
  });
}
