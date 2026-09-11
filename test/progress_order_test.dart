import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/services/train_reminder.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final bench = kExercises.firstWhere((e) => e.name == 'Barbell Bench Press');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    ProgressReminder.instance.enabled = false;
    TrainReminder.instance.enabled = false;
    fit.resetAllData();
    fit.completeOnboarding();
  });

  void logSessions() {
    for (var i = 1; i <= 6; i++) {
      fit.sessions.add(LoggedSession(
        DateTime.now().subtract(Duration(days: i * 3)),
        3600,
        [
          LoggedExercise(bench.id, bench.name, bench.primary, [LoggedSet(8, 70)]),
        ],
      ));
    }
  }

  Future<double> yOf(WidgetTester tester, String text) async {
    final finder = find.text(text);
    expect(finder, findsWidgets, reason: 'no se encontró "$text"');
    return tester.getTopLeft(finder.first).dy;
  }

  testWidgets('la gráfica va primero, luego el cuerpo y luego el mapa de días',
      (tester) async {
    logSessions();
    fit.route = 'progress';
    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();

    final chart = await yOf(tester, t.totalVolume30d);
    final body = await yOf(tester, t.muscleMap);
    final heat = await yOf(tester, t.consistency);

    expect(chart, lessThan(body));
    expect(body, lessThan(heat));
  });

  testWidgets('las tarjetas sin datos se van al final', (tester) async {
    logSessions();
    fit.route = 'progress';
    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();

    final withData = await yOf(tester, t.personalRecords);
    final empty = await yOf(tester, t.measures);

    expect(withData, lessThan(empty), reason: 'las medidas vacías deberían quedar debajo');
  });

  testWidgets('en cuanto hay datos, la tarjeta sube', (tester) async {
    logSessions();
    fit.addMeasure('chest', 100);
    fit.persistNow();
    fit.route = 'progress';
    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();

    final measures = await yOf(tester, t.measures);
    final timeline = await yOf(tester, t.timeline);

    expect(measures, lessThan(timeline), reason: 'con datos, las medidas van antes que lo vacío');
  });
}
