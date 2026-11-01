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

  LoggedSession bench(int daysAgo, double kg) {
    final s = LoggedSession(
      DateTime.now().subtract(Duration(days: daysAgo)),
      3600,
      [LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [LoggedSet(5, kg)])],
    );
    fit.sessions.add(s);
    fit.sessions.sort((a, b) => a.date.compareTo(b.date));
    return s;
  }

  test('sueño y energía se guardan con el entreno y vuelven al cargar', () {
    final s = bench(1, 100);
    fit.rateSession(s, sleep: true, value: 2);
    fit.rateSession(s, sleep: false, value: 9);
    expect(s.sleep, 2);
    expect(s.energy, 5, reason: 'la escala acaba en 5');
    final back = LoggedSession.fromJson(s.toJson());
    expect(back.sleep, 2);
    expect(back.energy, 5);
    fit.rateSession(s, sleep: true, value: null);
    expect(LoggedSession.fromJson(s.toJson()).sleep, isNull);
  });

  test('sin días buenos y malos suficientes no se inventa nada', () {
    final s = bench(1, 100);
    fit.rateSession(s, sleep: true, value: 1);
    expect(fit.readinessEffect, isNull);
    expect(fit.readinessRecent.rated, 1);
    expect(fit.readinessRecent.sleep, 1);
  });

  test('dormir mal se ve en las marcas', () {
    bench(20, 100);
    for (var i = 0; i < 6; i++) {
      final good = i.isEven;
      final s = bench(18 - i * 2, good ? 100 : 90);
      fit.rateSession(s, sleep: true, value: good ? 5 : 1);
    }
    final effect = fit.readinessEffect!;
    expect(effect.sleep, true);
    expect(effect.pct, -10);
    expect(effect.low, 3);
    expect(effect.high, 3);
  });

  test('se puede no preguntar al acabar', () {
    expect(fit.askCheckIn, true);
    fit.toggleAskCheckIn();
    expect(fit.askCheckIn, false);
  });
}
