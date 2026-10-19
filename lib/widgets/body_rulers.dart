import 'package:flutter/widgets.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import 'ruler_picker.dart';

Future<void> editAge(BuildContext context) async {
  final age = fit.profile.age;
  final v = await askRuler(
    context,
    title: t.ageLabel,
    value: age.toDouble(),
    min: 10,
    max: 90,
    step: 1,
    majorEvery: 5,
  );
  if (v != null) fit.updateProfile(ageDelta: v.round() - age);
}

Future<void> editHeight(BuildContext context) async {
  final cm = fit.profile.heightCm;
  if (fit.isInches) {
    String feet(double v) => '${v.round() ~/ 12}′${v.round() % 12}″';
    final v = await askRuler(
      context,
      title: t.heightLabel,
      value: (cm / 2.54).roundToDouble(),
      min: 40,
      max: 96,
      step: 1,
      majorEvery: 12,
      format: feet,
      tickLabel: feet,
      vertical: true,
    );
    if (v != null) fit.updateProfile(heightDelta: v * 2.54 - cm);
    return;
  }
  final v = await askRuler(
    context,
    title: t.heightLabel,
    value: cm.roundToDouble(),
    min: 100,
    max: 250,
    step: 1,
    majorEvery: 10,
    unit: 'cm',
    vertical: true,
  );
  if (v != null) fit.updateProfile(heightDelta: v - cm);
}

Future<void> editBodyWeight(BuildContext context) async {
  final kg = fit.profile.weightKg;
  final v = await askRuler(
    context,
    title: t.weightLabel,
    value: (fit.toDisplayWeight(kg) * 2).round() / 2,
    min: fit.isLb ? 66 : 30,
    max: fit.isLb ? 550 : 250,
    step: fit.isLb ? 1 : 0.5,
    majorEvery: 10,
    unit: fit.units,
  );
  if (v != null) fit.updateProfile(weightDelta: fit.fromDisplayWeight(v) - kg);
}
