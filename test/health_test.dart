import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/health_metrics.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/health_cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
    setAppLanguage('en');
  });

  double at(int daysAgo, int hour) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day - daysAgo, hour).millisecondsSinceEpoch.toDouble();
  }

  String key(int daysAgo) {
    final n = DateTime.now();
    return HealthMetrics.dayKey(DateTime(n.year, n.month, n.day - daysAgo));
  }

  group('#281 datos de salud por día', () {
    test('las medidas sueltas se promedian por día', () {
      final days = HealthMetrics.byDay(HealthMetric.spo2, [
        [at(0, 8), 96],
        [at(0, 20), 98],
        [at(1, 9), 95],
      ]);
      expect(days[key(0)], [97]);
      expect(days[key(1)], [95]);
    });

    test('la tensión promedia la alta y la baja por separado', () {
      final days = HealthMetrics.byDay(HealthMetric.bloodPressure, [
        [at(0, 8), 120, 80],
        [at(0, 21), 130, 84],
      ]);
      expect(days[key(0)], [125, 82]);
    });

    test('el sueño de un día se suma y cuenta en el día en que acaba', () {
      final days = HealthMetrics.byDay(HealthMetric.sleep, [
        [at(0, 7), 420],
        [at(0, 16), 30],
      ]);
      expect(days[key(0)], [450]);
      expect(days.containsKey(key(1)), isFalse);
    });

    test('los totales diarios se quedan tal cual', () {
      final days = HealthMetrics.byDay(HealthMetric.floors, [
        [at(1, 0), 12],
        [at(0, 0), 4],
      ]);
      expect(days[key(1)], [12]);
      expect(days[key(0)], [4]);
    });
  });

  group('#281 estado de salud', () {
    test('lo elegido y los datos se guardan y vuelven al reabrir', () {
      fit.healthShown.addAll({HealthMetric.sleep, HealthMetric.restingHr});
      fit.healthByDay[HealthMetric.restingHr] = {key(0): [58], key(2): [61]};
      fit.persistNow();
      fit.healthShown.clear();
      fit.healthByDay.clear();
      fit.loadFromStore();

      expect(fit.healthMetrics, [HealthMetric.restingHr, HealthMetric.sleep]);
      expect(fit.healthOnDay(HealthMetric.restingHr, DateTime.now()), [58]);
      expect(fit.healthLatest(HealthMetric.restingHr)!.values, [58]);
      final week = fit.healthSeries(HealthMetric.restingHr, 7);
      expect(week.length, 7);
      expect(week.last, 58);
      expect(week[4], 61);
      expect(week[5], isNull);
    });

    test('borrar todo deja la salud vacía', () {
      fit.healthShown.add(HealthMetric.hrv);
      fit.healthByDay[HealthMetric.hrv] = {key(0): [42]};
      fit.resetAllData();
      expect(fit.healthShown, isEmpty);
      expect(fit.healthByDay, isEmpty);
    });

    test('lo último es el día más reciente con datos', () {
      fit.healthByDay[HealthMetric.spo2] = {key(5): [95], key(1): [97], key(3): [96]};
      final last = fit.healthLatest(HealthMetric.spo2)!;
      expect(last.values, [97]);
      expect(HealthMetrics.dayKey(last.day), key(1));
    });
  });

  group('#281 cómo se enseñan', () {
    test('sueño en horas y minutos, tensión alta/baja', () {
      expect(healthValue(HealthMetric.sleep, [452]), '7:32');
      expect(healthValue(HealthMetric.bloodPressure, [121.4, 79.6]), '121/80');
      expect(healthValue(HealthMetric.restingHr, [57.6]), '58');
    });

    test('distancia, desnivel y temperatura siguen las unidades', () {
      fit.setUnits('kg');
      expect(healthValue(HealthMetric.distance, [5230]), '5.23');
      expect(healthUnit(HealthMetric.distance), 'km');
      expect(healthValue(HealthMetric.temperature, [36.64]), '36.6');
      expect(healthUnit(HealthMetric.temperature), '°C');
      fit.setUnits('lb');
      expect(healthUnit(HealthMetric.distance), 'mi');
      expect(healthValue(HealthMetric.temperature, [37]), '98.6');
      expect(healthUnit(HealthMetric.elevation), 'ft');
      expect(healthValue(HealthMetric.elevation, [100]), '328');
    });
  });
}
