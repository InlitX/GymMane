import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/fit_export.dart';

void main() {
  final session = LoggedSession(DateTime(2026, 9, 27, 19, 30), 3000, [
    LoggedExercise('b', 'Barbell Bench Press', 'chest', [LoggedSet(8, 80), LoggedSet(6, 85)]),
    LoggedExercise('s', 'Barbell Full Squat', 'quads', [
      LoggedSet(5, 100, kind: SetKind.warmup),
      LoggedSet(5, 120),
    ]),
  ]);

  test('el fichero FIT es válido', () {
    final bytes = workoutFit(session);
    expect(String.fromCharCodes(bytes.sublist(8, 12)), '.FIT');
    expect(fitCrc(bytes), 0, reason: 'el CRC sobre todo el fichero da 0 si es correcto');
    final dump = Platform.environment['FIT_DUMP'];
    if (dump != null) File(dump).writeAsBytesSync(bytes);
  });

  test('cada ejercicio cae en su categoría', () {
    expect(fitCategory('Barbell Bench Press'), 0);
    expect(fitCategory('Lying Leg Curl'), 15);
    expect(fitCategory('Dumbbell Biceps Curl'), 7);
    expect(fitCategory('Something new'), 65534);
  });
}
