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
    fit.resetAllData();
    fit.setUnits('kg');
  });

  LoggedSession at(int daysAgo, List<LoggedSet> sets) => LoggedSession(
    shiftDays(DateTime.now(), -daysAgo).add(const Duration(hours: 18)),
    600,
    [LoggedExercise('push', 'push', 'chest', sets)],
  );

  test('#187 el mapa reparte los tonos por volumen y el día sin peso queda abajo', () {
    fit.sessions
      ..add(at(4, [LoggedSet(10, 0), LoggedSet(10, 0)]))
      ..add(at(3, [LoggedSet(10, 30)]))
      ..add(at(2, [for (var i = 0; i < 6; i++) LoggedSet(10, 60)]))
      ..add(at(1, [for (var i = 0; i < 12; i++) LoggedSet(8, 100)]));
    final l = fit.heatmapLevels;
    final n = l.length;
    expect(l[n - 5], 1);
    expect(l[n - 4], 1);
    expect(l[n - 3], greaterThan(1));
    expect(l[n - 2], heatLevels);
    expect(l[n - 3], lessThan(l[n - 2]));
    expect(l.last, 0);
  });
}
