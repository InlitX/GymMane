import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/workout_import.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_colors.dart';
import 'package:gymmane/widgets/home_widget_views.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.setUnits('kg');
  });

  tearDown(() {
    if (fit.session != null) fit.saveAndExit();
  });

  Routine oneSetEach(List<String> names) {
    final id = fit.createRoutine('Push');
    for (final name in names) {
      final ex = fit.matchExerciseByName(name)!.id;
      fit.toggleRoutineExercise(id, ex);
      fit.bumpRoutineSets(id, ex, -2);
    }
    return fit.routines.firstWhere((r) => r.id == id);
  }

  Future<void> wait(Duration d) => Future<void>.delayed(d + const Duration(milliseconds: 200));

  group('#67 terminar solo', () {
    test('al marcar la última serie del último ejercicio se abre el resumen', () async {
      fit.startRoutine(oneSetEach(['Barbell Bench Press', 'Barbell Squat']));
      fit.endCountdown();
      expect(fit.route, 'session');

      fit.toggleSet(0, 0);
      await wait(WorkoutState.advanceDelay);
      expect(fit.session!.currentIndex, 1);

      fit.toggleSet(1, 0);
      expect(fit.isSessionComplete, isFalse, reason: 'primero se ve el tic marcado');
      await wait(WorkoutState.finishDelay);
      expect(fit.isSessionComplete, isTrue);
      expect(fit.sessions, hasLength(1));
    });

    test('desmarcar a tiempo lo cancela', () async {
      fit.startRoutine(oneSetEach(['Barbell Bench Press']));
      fit.endCountdown();
      fit.toggleSet(0, 0);
      fit.toggleSet(0, 0);
      await wait(WorkoutState.finishDelay);
      expect(fit.isSessionComplete, isFalse);
    });

    test('con el paso automático apagado espera al botón', () async {
      fit.toggleAutoAdvance();
      fit.startRoutine(oneSetEach(['Barbell Bench Press']));
      fit.endCountdown();
      fit.toggleSet(0, 0);
      await wait(WorkoutState.finishDelay);
      expect(fit.isSessionComplete, isFalse);
      fit.toggleAutoAdvance();
    });

    test('si quedan series atrás, vuelve a ellas en vez de terminar', () async {
      fit.startRoutine(oneSetEach(['Barbell Bench Press', 'Barbell Squat']));
      fit.endCountdown();
      fit.goToExercise(1);
      fit.toggleSet(1, 0);
      await wait(WorkoutState.finishDelay);
      expect(fit.isSessionComplete, isFalse);
      expect(fit.session!.currentIndex, 0);
    });
  });

  test('#58 el paso automático queda contado para avisar del cambio', () async {
    fit.startRoutine(oneSetEach(['Barbell Bench Press', 'Barbell Squat']));
    fit.endCountdown();
    final before = fit.autoMoves;
    fit.goToExercise(1);
    expect(fit.autoMoves, before, reason: 'moverse a mano no avisa');
    fit.goToExercise(0);
    fit.toggleSet(0, 0);
    await wait(WorkoutState.advanceDelay);
    expect(fit.autoMoves, before + 1);
  });

  test('el check puesto a mano se quita con otro toque', () {
    final today = fit.todayIndex;
    fit.toggleCheckin(today);
    expect(fit.isDayDone(today), isTrue);
    fit.toggleCheckin(today);
    expect(fit.isDayDone(today), isFalse);
    expect(fit.dateForWeekday(today).day, DateTime.now().day);
  });

  testWidgets('el widget de hoy dice hecho o no sin poner el día', (tester) async {
    Future<void> show(bool done) => tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: TodayWidgetView(gc: GymColors.dark, done: done, planned: true, streak: 0),
        ),
      ),
    );
    await show(false);
    expect(find.text('${DateTime.now().day}'), findsNothing);
    expect(find.byIcon(Icons.fitness_center_rounded), findsOneWidget);
    await show(true);
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);
  });

  testWidgets('el widget de la semana cuenta los días hechos', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: WeekWidgetView(
            gc: GymColors.dark,
            done: const [true, false, true, false, false, false, false],
            goal: 4,
          ),
        ),
      ),
    );
    expect(find.text('2'), findsOneWidget);
    expect(find.text('/4'), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsNWidgets(2));
    final geo = WeekWidgetView.geometry(const Size(320, 150));
    final origin = tester.getTopLeft(find.byType(WeekWidgetView));
    final dots = find.byWidgetPredicate(
      (w) =>
          w is Container &&
          w.decoration is BoxDecoration &&
          (w.decoration as BoxDecoration).shape == BoxShape.circle,
    );
    expect(dots, findsNWidgets(7));
    for (var i = 0; i < 7; i++) {
      final c = tester.getCenter(dots.at(i)) - origin;
      expect(c.dx / 320, closeTo(geo[0] + geo[1] * i, 0.002));
      expect(c.dy / 150, closeTo(geo[2], 0.002));
    }
  });

  group('#55 nombres de Lyfta', () {
    String? match(String name) => fit.matchExerciseByName(name)?.name;

    test('no cambia de músculo por una palabra suelta', () {
      expect(match('Dumbbell Seated Curl'), isNot('Seated Leg Curl'));
      expect(match('Lever Seated Leg Extension'), isNot(contains('Calf')));
      expect(match('Dumbbell Seated One Arm Rotate'), isNull);
    });

    test('el nombre exacto gana', () {
      expect(match('Machine Reverse Fly'), 'Machine Reverse Fly');
      expect(match('Smith Hack Squat'), 'Smith Hack Squat');
    });

    test('encuentra el ejercicio aunque el nombre traiga más cosas', () {
      expect(match('Cable Standing Face Pull (with rope)'), 'Face Pull');
      expect(match('Barbell Feet Flat Bench Press (male)'), 'Barbell Bench Press');
      expect(match('Lever Pec Deck Fly'), 'Pec Deck');
      expect(match('Close Grip Preacher Curl'), 'Barbell Preacher Curl');
    });

    test('su columna RIR/RPE se entiende en las dos escalas', () {
      const csv =
          'Title,Date,Duration,Description,Notes,Exercise,Exercise Note,Superset id,Weight,Reps,'
          'RIR/RPE,Distance,Time,Set Type,RecordLevel: gold/silver/bronze,RecordType: 1RM / max_weight / volume / reps\n'
          'Pull,2026-04-17 16:00:05,01:00:00,,,Barbell Curl,,,30.000,10,2,,,NORMAL_SET,,\n'
          'Pull,2026-04-17 16:00:05,01:00:00,,,Barbell Curl,,,30.000,8,8.5,,,NORMAL_SET,,\n'
          'Pull,2026-04-17 16:00:05,01:00:00,,,Barbell Curl,,,30.000,8,,,,NORMAL_SET,,\n';
      final sets = parseImport(csv).sessions.single.exercises.single.sets;
      expect(sets.map((s) => s.rpe), [8, 8.5, null]);
    });
  });
}
