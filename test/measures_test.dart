import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.setUnits('kg');
  });

  test('a reading is kept and read back with its unit', () {
    fit.addMeasure('waist', 82.5);
    expect(fit.latestMeasure('waist')!.value, closeTo(82.5, 0.001));
    expect(fit.measureLabel('waist', 82.5), '82.5 cm');
    expect(fit.measureUnit('bodyfat'), '%');
  });

  test('two readings the same day replace each other instead of piling up', () {
    fit.addMeasure('chest', 100);
    fit.addMeasure('chest', 101);
    expect(fit.measureHistory('chest'), hasLength(1));
    expect(fit.latestMeasure('chest')!.value, closeTo(101, 0.001));
  });

  test('the change compares the last two readings', () {
    fit.addMeasure('arm', 38, date: DateTime.now().subtract(const Duration(days: 30)));
    fit.addMeasure('arm', 39.5);
    expect(fit.measureChange('arm'), closeTo(1.5, 0.001));
    expect(fit.measureChange('calf'), isNull);
  });

  test('inches go in and come back out as inches, stored as cm', () {
    fit.setUnits('lb');
    fit.addMeasure('waist', 32);
    expect(fit.lengthUnit, 'in');
    expect(fit.latestMeasure('waist')!.value, closeTo(81.3, 0.05));
    expect(fit.measureValue('waist', fit.latestMeasure('waist')!.value), '32');

    fit.setUnits('kg');
    expect(fit.measureValue('waist', fit.latestMeasure('waist')!.value), '81.3');
  });

  test('body fat is a percentage and never gets converted', () {
    fit.setUnits('lb');
    fit.addMeasure('bodyfat', 14.2);
    expect(fit.latestMeasure('bodyfat')!.value, closeTo(14.2, 0.001));
    expect(fit.measureLabel('bodyfat', 14.2), '14.2 %');
  });

  test('junk readings are turned away', () {
    fit.addMeasure('waist', 0);
    fit.addMeasure('waist', -5);
    fit.addMeasure('nose', 10);
    expect(fit.measures, isEmpty);
  });

  test('readings survive a save and a reload', () {
    fit.addMeasure('thigh', 60);
    fit.addMeasure('bodyfat', 15);
    fit.persistNow();

    fit.measures.clear();
    fit.loadFromStore();

    expect(fit.trackedMeasures, ['thigh', 'bodyfat']);
    expect(fit.latestMeasure('thigh')!.value, closeTo(60, 0.001));
  });

  test('a reading can be dropped again', () {
    fit.addMeasure('neck', 40);
    fit.deleteMeasure(fit.latestMeasure('neck')!);
    expect(fit.hasMeasures, false);
  });

  test('reset takes the readings with it', () {
    fit.addMeasure('hips', 95);
    fit.resetAllData();
    expect(fit.measures, isEmpty);
  });
}
