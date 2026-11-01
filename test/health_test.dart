import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
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
    test('con 3 en la tarjeta, tocar otra cambia la más antigua', () {
      fit.healthShown
        ..clear()
        ..addAll([HealthMetric.restingHr, HealthMetric.sleep, HealthMetric.activeKcal, HealthMetric.spo2]);
      fit.healthPinned.clear();
      fit.toggleHealthPin(HealthMetric.restingHr);
      expect(fit.healthTop, [HealthMetric.sleep, HealthMetric.activeKcal]);
      fit.toggleHealthPin(HealthMetric.restingHr);
      expect(fit.healthTop, [HealthMetric.sleep, HealthMetric.activeKcal, HealthMetric.restingHr]);
      fit.toggleHealthPin(HealthMetric.spo2);
      expect(fit.healthTop, [HealthMetric.activeKcal, HealthMetric.restingHr, HealthMetric.spo2]);
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

  group('Health Connect con tus entrenos', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
    });

    test('los pesajes de otras apps entran una vez y no pisan los tuyos', () {
      final n = DateTime(2026, 10, 20, 8);
      fit.bodyweight.add(BodyweightEntry(n, 80));
      final rows = <List<double>>[
        [n.add(const Duration(minutes: 30)).millisecondsSinceEpoch.toDouble(), 80.02],
        [n.add(const Duration(days: 1)).millisecondsSinceEpoch.toDouble(), 79.6],
        [n.add(const Duration(days: 2)).millisecondsSinceEpoch.toDouble(), 900.0],
      ];
      expect(fit.importWeighIns(rows), isTrue);
      expect(fit.bodyweight.map((b) => b.kg), [80, 79.6]);
      fit.bodyweight.removeLast();
      expect(fit.importWeighIns(rows), isFalse, reason: 'uno que borraste no vuelve');
      expect(fit.bodyweight.length, 1);
    });

    test('el pulso del entreno sale de las muestras de su hora', () {
      final end = DateTime(2026, 10, 20, 19);
      final s = LoggedSession(end, 3600, const []);
      final inside = end.subtract(const Duration(minutes: 30)).millisecondsSinceEpoch.toDouble();
      final rows = <List<double>>[
        [inside, 120.0],
        [inside + 60000, 150.0],
        [inside + 120000, 165.0],
        [end.add(const Duration(hours: 1)).millisecondsSinceEpoch.toDouble(), 70.0],
      ];
      expect(fit.applyWorkoutHeart(s, rows), isTrue);
      expect((s.hrAvg, s.hrMax), (145, 165));
      final back = LoggedSession.fromJson(s.toJson());
      expect((back.hrAvg, back.hrMax), (145, 165));
      expect(fit.applyWorkoutHeart(LoggedSession(end, 60, const []), rows.take(1).toList()), isFalse);
    });

    test('los interruptores se guardan', () {
      fit.hcHeart = true;
      fit.hcSeenWeights.add(42);
      final j = fit.healthJson();
      fit.loadHealth(null);
      expect(fit.hcHeart, isFalse);
      fit.loadHealth(j);
      expect((fit.hcHeart, fit.hcWeights), (true, false));
      expect(fit.hcSeenWeights, {42});
    });
  
    test('un entreno guardado en Salud lleva un id fijo y el tipo que toca', () {
      final end = DateTime(2026, 11, 2, 19);
      LoggedExercise ex(String id) => LoggedExercise(id, id, 'legs', [LoggedSet(0, 0, sec: 1200, km: 3)]);
      final lift = LoggedSession(end, 3600, [ex('barbell-squat'), ex('running')]);
      final run = LoggedSession(end, 1800, [ex('running')]);
      final walk = LoggedSession(end, 1800, [ex('treadmill-incline-walk')]);
      expect(fit.healthWorkoutType(lift), 'strength');
      expect(fit.healthWorkoutType(run), 'running');
      expect(fit.healthWorkoutType(walk), 'treadmill');
      expect(fit.healthWorkoutType(LoggedSession(end, 60, const [])), 'strength');
      expect(HealthState.healthWorkoutId(lift), 'gymmane-${end.millisecondsSinceEpoch}');
      expect(HealthState.healthWorkoutId(lift), HealthState.healthWorkoutId(run),
          reason: 'mismo final, mismo registro: al reanudarlo se actualiza en vez de duplicarse');
      expect(fit.healthWorkoutNotes(lift), contains(' · '));
    });

    test('guardar en Salud se recuerda al reabrir', () {
      fit.hcWrite = true;
      final j = fit.healthJson();
      fit.loadHealth(null);
      expect(fit.hcWrite, isFalse);
      fit.loadHealth(j);
      expect(fit.hcWrite, isTrue);
    });
  });
}
