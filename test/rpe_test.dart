import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/workout_import.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
  });

  group('tabla de RPE', () {
    test('coincide con la tabla de RTS', () {
      expect(rpePercent(1, 10), 1.0);
      expect(rpePercent(5, 8), closeTo(0.811, 1e-9));
      expect(rpePercent(3, 9.5), closeTo(0.907, 1e-9));
      expect(rpePercent(12, 6), closeTo(0.574, 1e-9));
    });

    test('fuera de la tabla no se inventa nada', () {
      expect(rpePercent(5, null), isNull);
      expect(rpePercent(5, 5), isNull);
      expect(rpePercent(13, 8), isNull);
      expect(rpePercent(0, 8), isNull);
    });

    test('el 1RM usa la tabla cuando la serie lleva RPE', () {
      expect(LoggedSet(5, 100, rpe: 8).oneRm, closeTo(100 / 0.811, 1e-6));
      expect(LoggedSet(5, 100).oneRm, closeTo(100 * (1 + 5 / 30), 1e-6));
      expect(LoggedSet(15, 50, rpe: 8).oneRm, closeTo(50 * (1 + 15 / 30), 1e-6));
    });
  });

  group('RPE o RIR', () {
    test('apagado por defecto y se elige la escala', () {
      expect(fit.effortMode, '');
      fit.setEffortMode('rir');
      expect(fit.logRpe, isTrue);
      expect(fit.usesRir, isTrue);
      expect(fit.effortLabel(8), 'RIR 2');
      expect(fit.effortTag(8.5), 'R1.5');
      fit.setEffortMode('rpe');
      expect(fit.effortLabel(8), 'RPE 8');
      expect(fit.effortTag(8), '@8');
      fit.setEffortMode('');
      expect(fit.logRpe, isFalse);
      expect(fit.effortScale, 'rpe');
    });

    test('la escala se guarda en la copia', () {
      fit.setEffortMode('rir');
      final data = fit.toJson();
      fit.resetAllData();
      expect(fit.effortMode, '');
      fit.applyBackup(data);
      expect(fit.effortMode, 'rir');
    });
  });

  group('CSV', () {
    test('la exportación lleva el RPE y se vuelve a leer', () {
      final csv = Store.instance.exportCsv([
        LoggedSession(DateTime(2026, 9, 19), 1800, [
          LoggedExercise('EIeI8Vf', 'Barbell Bench Press', 'chest', [
            LoggedSet(5, 100, rpe: 8.5),
            LoggedSet(5, 100),
          ]),
        ]),
      ]);
      final rows = csv.trim().split('\n');
      expect(rows.first, endsWith(',rpe'));
      expect(rows[1], endsWith(',8.5'));
      expect(rows[2], endsWith(','));

      final back = parseImport(csv);
      final sets = back.sessions.single.exercises.single.sets;
      expect(sets.first.rpe, 8.5);
      expect(sets.last.rpe, isNull);
    });

    test('Hevy trae su RPE y una columna RIR se convierte', () {
      const hevy =
          '"title","start_time","end_time","description","exercise_title","superset_id",'
          '"exercise_notes","set_index","set_type","weight_kg","reps","distance_km","duration_seconds","rpe"\n'
          '"Push","19 Sep 2026, 10:00","19 Sep 2026, 11:00","","Bench Press (Barbell)","","",0,"normal",100,5,,,8\n';
      final hevySets = parseImport(hevy).sessions.single.exercises.single.sets;
      expect(hevySets.single.rpe, 8);

      const generic = 'date,exercise,reps,weight,rir\n2026-09-19,Squat,5,120,2\n';
      final genericSets = parseImport(generic).sessions.single.exercises.single.sets;
      expect(genericSets.single.rpe, 8);
    });
  });
}
