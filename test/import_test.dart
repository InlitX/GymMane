import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/workout_import.dart';
import 'package:gymmane/state/fit_state.dart';

const _hevy = '''
"title","start_time","end_time","description","exercise_title","superset_id","exercise_notes","set_index","set_type","weight_kg","reps","distance_km","duration_seconds","rpe"
"Morning","12 Jan 2024, 18:30","12 Jan 2024, 19:15","","Bench Press (Barbell)",,"",0,"warmup",20,10,,0,
"Morning","12 Jan 2024, 18:30","12 Jan 2024, 19:15","","Bench Press (Barbell)",,"",1,"normal",60,10,,0,8
"Morning","12 Jan 2024, 18:30","12 Jan 2024, 19:15","","Bench Press (Barbell)",,"",2,"normal",60,8,,0,9
"Morning","12 Jan 2024, 18:30","12 Jan 2024, 19:15","","Squat (Barbell)",,"",0,"normal",100,5,,0,8
''';

const _hevyLb = '''
"title","start_time","end_time","exercise_title","set_index","set_type","weight_kg","weight_lbs","reps"
"Push","12 Jan 2024, 18:30","12 Jan 2024, 19:00","Bench Press (Barbell)",0,"normal",,220,5
''';

const _strongPlain = '''
Date;Workout Name;Duration;Exercise Name;Set Order;Weight;Reps;Distance;Seconds;Notes;Workout Notes;RPE
2024-01-13 10:00:00;Legs;1h 5m;Squat (Barbell);1;100;5;;;;;
2024-01-13 10:00:00;Legs;1h 5m;Squat (Barbell);2;100;5;;;;;
''';

const _strongLb = '''
Date,Workout Name,Duration,Exercise Name,Set Order,Weight,Reps,Distance,Seconds,Notes,Workout Notes,RPE
2024-01-14 09:00:00,Push,30m,Bench Press (Barbell),1,220,5,,,,,
''';

const _fitnotesPlain = '''
Date,Exercise,Category,Weight,Reps,Distance,Distance Unit,Time,Comment
2024-01-15,Barbell Bench Press,Chest,60,10,,,,
2024-01-15,Barbell Squat,Legs,100,5,,,,
''';

const _fitnotesUnits = '''
Date,Exercise,Category,Weight (kg),Weight (lbs),Reps,Distance,Distance Unit,Time,Notes,Kind
2024-01-15,Bench Press,Chest,100.00,220.46,10,,,00:03:45,Good form,wr
''';

const _gymmane = '''
date,exercise,muscle,set,reps,weight_kg,volume_kg,est_1rm_kg
2024-01-16,Barbell Bench Press,chest,1,10,60,600,80
''';

void main() {
  group('detección de formato', () {
    test('reconoce cada app', () {
      expect(detectFormat(_hevy), ImportFormat.hevy);
      expect(detectFormat(_strongPlain), ImportFormat.strong);
      expect(detectFormat(_fitnotesPlain), ImportFormat.fitnotes);
      expect(detectFormat(_fitnotesUnits), ImportFormat.fitnotes);
      expect(detectFormat(_gymmane), ImportFormat.gymmane);
      expect(detectFormat('a,b,c\n1,2,3'), ImportFormat.unknown);
      expect(detectFormat(''), ImportFormat.unknown);
    });

    test('solo se pregunta la unidad cuando el archivo no la dice', () {
      expect(needsUnitChoice(_strongPlain), isTrue);
      expect(needsUnitChoice(_fitnotesPlain), isTrue);
      expect(needsUnitChoice(_fitnotesUnits), isFalse);
      expect(needsUnitChoice(_hevy), isFalse);
      expect(needsUnitChoice(_gymmane), isFalse);
    });
  });

  group('parseo', () {
    test('Hevy agrupa la sesión y saca la duración de start/end', () {
      final r = parseImport(_hevy);
      expect(r.sessions.length, 1);
      final s = r.sessions.first;
      expect(s.durationSec, 45 * 60);
      expect(s.exercises.length, 2);
      expect(s.exercises.first.sets.length, 2, reason: 'la serie de calentamiento no cuenta');
      expect(s.exercises.first.sets.first.weightKg, 60);
      expect(s.exercises.first.sets.first.reps, 10);
      expect(s.exercises[1].sets.single.weightKg, 100);
    });

    test('Hevy sin weight_kg cae a weight_lbs', () {
      final r = parseImport(_hevyLb);
      expect(r.sessions.single.exercises.single.sets.single.weightKg, closeTo(99.79, 0.05));
      expect(r.sessions.single.durationSec, 1800);
    });

    test('Strong con ; y kg', () {
      final r = parseImport(_strongPlain);
      expect(r.sessions.length, 1);
      final s = r.sessions.first;
      expect(s.durationSec, 3900);
      expect(s.exercises.single.sets.length, 2);
      expect(s.exercises.single.sets.first.weightKg, 100);
    });

    test('Strong en lb convierte a kg', () {
      final r = parseImport(_strongLb, isLb: true);
      final w = r.sessions.single.exercises.single.sets.single.weightKg;
      expect(w, closeTo(99.79, 0.05));
      expect(r.sessions.single.durationSec, 1800);
    });

    test('FitNotes agrupa por día y trae la categoría', () {
      final r = parseImport(_fitnotesPlain);
      expect(r.sessions.length, 1);
      expect(r.sessions.single.exercises.length, 2);
      expect(r.sessions.single.exercises.first.muscle, 'Chest');
    });

    test('FitNotes moderno usa la columna en kg y ignora la de lb', () {
      final r = parseImport(_fitnotesUnits, isLb: true);
      expect(r.sessions.single.exercises.single.sets.single.weightKg, 100);
    });

    test('GymMane propio', () {
      final r = parseImport(_gymmane);
      expect(r.sessions.single.exercises.single.sets.single.weightKg, 60);
    });

    test('un archivo sin filas útiles no rompe nada', () {
      expect(parseImport(_hevy.split('\n').first).sessions, isEmpty);
      expect(parseImport('cualquier cosa').sessions, isEmpty);
    });
  });

  group('fusión en el estado', () {
    setUp(() => fit.sessions.clear());

    test('empareja con el catálogo, salta duplicados y marca los no encontrados', () {
      final known = fit.allExercises.first;
      final ps = ParsedSession(DateTime(2024, 1, 1), 0)
        ..exercises.add(ParsedExercise(known.name, null)..sets.add(ParsedSet(5, 100)));

      expect(fit.importParsedSessions([ps]), 1);
      expect(fit.sessions.last.exercises.first.id, known.id);
      expect(fit.importParsedSessions([ps]), 0);

      final ps2 = ParsedSession(DateTime(2024, 1, 2), 0)
        ..exercises.add(ParsedExercise('Zzz Nonexistent Lift 9000', null)..sets.add(ParsedSet(5, 50)));
      expect(fit.importParsedSessions([ps2]), 1);
      expect(fit.sessions.last.exercises.first.id, startsWith('imp:'));
    });

    test('importar un CSV real deja el historial listo para las estadísticas', () {
      final r = parseImport(_hevy);
      expect(fit.importParsedSessions(r.sessions), 1);
      final logged = fit.sessions.single;
      expect(logged.setCount, 3);
      expect(logged.volume, 60 * 10 + 60 * 8 + 100 * 5);
      expect(logged.durationSec, 45 * 60);
    });
  });
}
