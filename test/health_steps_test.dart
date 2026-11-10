import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/health_steps.dart';

void main() {
  test('Android includes the entire calendar day for daily step records', () {
    final day = DateTime(2026, 10, 31, 11, 30);

    expect(HealthSteps.stepQueryRange(day), [
      DateTime(2026, 10, 31).millisecondsSinceEpoch,
      DateTime(2026, 11, 1).millisecondsSinceEpoch,
    ]);
  });

  test('iOS caps the current day and keeps past days intact', () {
    final now = DateTime(2026, 11, 1, 11, 30);
    final previousDay = DateTime(2026, 10, 31);
    final today = DateTime(2026, 11, 1);

    expect(HealthSteps.stepQueryRange(today, cutoff: now), [
      today.millisecondsSinceEpoch,
      now.millisecondsSinceEpoch,
    ]);
    expect(HealthSteps.stepQueryRange(previousDay, cutoff: now), [
      previousDay.millisecondsSinceEpoch,
      today.millisecondsSinceEpoch,
    ]);
  });
}
