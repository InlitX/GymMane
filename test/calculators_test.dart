import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/state/fit_state.dart';

void main() {
  test('every tool in the menu has a screen behind it', () {
    expect(kToolMeta.map((t) => t.id).toSet(),
        {'rm', 'bmi', 'cal', 'bf', 'plate', 'warmup'});
    for (final t in kToolMeta) {
      expect(t.name.trim(), isNotEmpty);
      expect(t.desc.trim(), isNotEmpty);
    }
  });

  group('1RM (Epley)', () {
    test('100 kg x 5 → 116.7', () {
      fit.rmWeight = 100;
      fit.rmReps = 5;
      expect(fit.rmResult, closeTo(116.7, 0.05));
    });

    test('a single rep is the max itself', () {
      fit.rmWeight = 140;
      fit.rmReps = 1;
      expect(fit.rmResult, closeTo(144.7, 0.05));
    });
  });

  group('BMI', () {
    test('75 kg, 175 cm → 24.5 Normal', () {
      fit.bmiWeight = 75;
      fit.bmiHeight = 175;
      expect(fit.bmiVal, closeTo(24.5, 0.05));
      expect(fit.bmiCat, 'Normal');
    });

    test('the categories land on the WHO cut-offs', () {
      fit.bmiHeight = 100;
      fit.bmiWeight = 18.4;
      expect(fit.bmiCat, 'Underweight');
      fit.bmiWeight = 18.5;
      expect(fit.bmiCat, 'Normal');
      fit.bmiWeight = 25;
      expect(fit.bmiCat, 'Overweight');
      fit.bmiWeight = 30;
      expect(fit.bmiCat, 'Obese');
    });
  });

  group('Calories (Mifflin-St Jeor)', () {
    test('male 28y, 175 cm, 75 kg, moderate → 2649 kcal', () {
      fit.calSex = 'male';
      fit.calAge = 28;
      fit.calHeight = 175;
      fit.calWeight = 75;
      fit.calActivity = 1.55;

      expect(fit.tdee, 2649);
    });

    test('female uses the -161 constant, not -5', () {
      fit.calSex = 'female';
      fit.calAge = 28;
      fit.calHeight = 175;
      fit.calWeight = 75;
      fit.calActivity = 1.0;
      expect(fit.tdee, 1543);
    });

    test('macros split 30/40/30 and add back up to the target', () {
      fit.calSex = 'male';
      fit.calAge = 28;
      fit.calHeight = 175;
      fit.calWeight = 75;
      fit.calActivity = 1.55;
      final kcal = fit.calProtein * 4 + fit.calCarbs * 4 + fit.calFat * 9;
      expect(kcal, closeTo(fit.tdee, 6));
    });

    test('the activity label matches the factor', () {
      for (final (factor, label) in [
        (1.2, 'Sedentary'),
        (1.375, 'Light'),
        (1.55, 'Moderate'),
        (1.725, 'Active'),
      ]) {
        fit.calActivity = factor;
        expect(fit.activityLabel, label);
      }
    });
  });

  group('Body fat (US Navy)', () {
    test('male 175 cm, neck 38, waist 84 → 16.2%', () {
      fit.bfSex = 'male';
      fit.bfHeight = 175;
      fit.bfNeck = 38;
      fit.bfWaist = 84;
      expect(fit.bfVal, closeTo(16.2, 0.15));
    });

    test('female uses hip as well', () {
      fit.bfSex = 'female';
      fit.bfHeight = 165;
      fit.bfNeck = 32;
      fit.bfWaist = 70;
      fit.bfHip = 95;
      expect(fit.bfVal, greaterThan(15));
      expect(fit.bfVal, lessThan(40));
    });

    test('absurd input is clamped instead of returning nonsense', () {
      fit.bfSex = 'male';
      fit.bfHeight = 175;
      fit.bfNeck = 38;
      fit.bfWaist = 39;
      expect(fit.bfVal, greaterThanOrEqualTo(3));
      fit.bfWaist = 200;
      expect(fit.bfVal, lessThanOrEqualTo(50));
    });
  });

  group('Plates', () {
    test('100 kg on a 20 kg bar → 25 + 15 per side', () {
      fit.plateTarget = 100;
      fit.plateBar = 20;
      final b = fit.plateBreakdown;
      expect(b.map((p) => '${fmt(p.weight)}x${p.count}'), ['25x1', '15x1']);
    });

    test('the plates always add up to the target', () {
      for (final target in [60.0, 82.5, 100.0, 142.5, 227.5]) {
        fit.plateTarget = target;
        fit.plateBar = 20;
        final perSide = fit.plateBreakdown.fold(0.0, (a, p) => a + p.weight * p.count);
        expect(perSide * 2 + 20, closeTo(target, 0.01), reason: 'con $target kg');
      }
    });

    test('an empty or lighter-than-bar target asks for no plates', () {
      fit.plateBar = 20;
      fit.plateTarget = 20;
      expect(fit.plateBreakdown, isEmpty);
      fit.plateTarget = 10;
      expect(fit.plateBreakdown, isEmpty);
    });
  });

  group('Warm-up', () {
    test('ramps 40/60/80/90% of the target, rounded to 2.5', () {
      fit.warmupTarget = 100;
      final sets = fit.warmupSets;
      expect(sets.map((s) => s.pct), ['40%', '60%', '80%', '90%']);
      expect(sets.map((s) => s.weight), [40.0, 60.0, 80.0, 90.0]);
      expect(sets.map((s) => s.reps), [10, 5, 3, 1]);
    });

    test('weights land on loadable plate increments', () {
      fit.warmupTarget = 137;
      for (final s in fit.warmupSets) {
        expect(s.weight % 2.5, closeTo(0, 0.001), reason: '${s.pct} = ${s.weight}');
      }
    });
  });

  test('the profile feeds the calculators so they open ready to use', () {
    fit.updateProfile(name: 'Test', sex: 'female');
    expect(fit.calSex, 'female');
    expect(fit.bfSex, 'female');
    expect(fit.calHeight, fit.profile.heightCm);
    expect(fit.bmiWeight, fit.profile.weightKg);
    fit.updateProfile(sex: 'male');
  });
}
