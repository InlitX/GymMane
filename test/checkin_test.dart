import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/state/fit_state.dart';

void main() {
  test('weekly check-in toggles and persists in the model', () {
    fit.sessions.clear();
    fit.checkins.clear();
    final today = fit.todayIndex;

    expect(fit.isDayDone(today), false);

    fit.toggleCheckin(today);
    expect(fit.isDayDone(today), true);
    expect(fit.checkins, isNotEmpty);
    expect((fit.toJson()['checkins'] as List), isNotEmpty);

    fit.toggleCheckin(today);
    expect(fit.isDayDone(today), false);
    expect(fit.checkins, isEmpty);

    if (today < 6) {
      expect(fit.canToggleDay(today + 1), false);
      fit.toggleCheckin(today + 1);
      expect(fit.isDayDone(today + 1), false);
    }
  });
}
