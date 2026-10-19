import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gymmane/models/note.dart';
import 'package:gymmane/models/nutrition.dart';
import 'package:gymmane/models/workout.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/plan_pdf.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/glass.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
  });

  const whey = Macros(kcal: 120, protein: 24, carbs: 3, fat: 1.5);

  group('#226 batidos marcados', () {
    test('elegir un batido lo marca y solo los marcados salen en la lista', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.saveFood(name: 'Avena', macros: const Macros(kcal: 380));
      fit.setShakeFood(a.id);
      expect(fit.isShakeFood(a.id), isTrue);
      expect(fit.shakeFoodItems.map((f) => f.id), [a.id]);
    });

    test('quitar la marca del elegido pasa al siguiente marcado', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      final b = fit.saveFood(name: 'Vegano', macros: whey);
      fit.setShakeFood(a.id);
      fit.setShakeTag(b.id, true);
      fit.setShakeTag(a.id, false);
      expect(fit.shakeFoodId, b.id);
      fit.setShakeTag(b.id, false);
      expect(fit.shakeFoodId, '');
      expect(fit.shakeFood, isNull);
    });

    test('marcar el primero lo deja elegido para el vaso', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.setShakeTag(a.id, true);
      expect(fit.shakeFoodId, a.id);
    });

    test('borrar el alimento quita la marca', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.setShakeTag(a.id, true);
      fit.deleteFood(a.id);
      expect(fit.shakeFoods, isEmpty);
    });

    test('las marcas sobreviven a guardar y cargar', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      final b = fit.saveFood(name: 'Vegano', macros: whey);
      fit.setShakeFood(a.id);
      fit.setShakeTag(b.id, true);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.applyBackup(data);
      expect(fit.shakeFoods.toSet(), {a.id, b.id});
      expect(fit.shakeFoodId, a.id);
    });

    test('una copia antigua sin marcas conserva su batido elegido', () {
      final a = fit.saveFood(name: 'Whey', macros: whey);
      fit.setShakeFood(a.id);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      (data['nutrition'] as Map).remove('shakes');
      fit.applyBackup(data);
      expect(fit.shakeFoods, [a.id]);
      expect(fit.shakeFoodId, a.id);
    });
  });

  group('#220 calendario de 12 meses', () {
    test('por defecto son 12 semanas y se guarda el cambio', () {
      expect(fit.heatmapYear, isFalse);
      expect(fit.heatmapShown.length, 12 * 7);
      fit.setHeatmapRange('year');
      expect(fit.heatmapShown.length, 53 * 7);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.resetAllData();
      expect(fit.heatmapYear, isFalse);
      fit.applyBackup(data);
      expect(fit.heatmapYear, isTrue);
    });

    test('con historia de más de un año llega hasta el primer entreno', () {
      fit.setHeatmapRange('year');
      final old = DateTime.now().subtract(const Duration(days: 500));
      fit.sessions.add(
        LoggedSession(old, 1800, [
          LoggedExercise('x', 'X', 'chest', [LoggedSet(8, 50)]),
        ]),
      );
      final weeks = fit.heatmapShownWeeks;
      expect(weeks, greaterThan(53));
      final first = fit.heatmapShownDate(0);
      expect(first.isAfter(DateTime(old.year, old.month, old.day)), isFalse);
      final i = DateTime(old.year, old.month, old.day).difference(first).inDays;
      expect(fit.heatmapShown[i], greaterThan(0));
    });

    test('tocar un día abre la fecha correcta en los dos modos', () {
      final today = DateTime.now();
      final key = DateTime(today.year, today.month, today.day);
      for (final range in ['weeks', 'year']) {
        fit.setHeatmapRange(range);
        final levels = fit.heatmapShown;
        final i = levels.lastIndexWhere((l) => l >= 0);
        expect(fit.heatmapShownDate(i), key, reason: range);
      }
    });

    test('un valor raro no cambia el ajuste', () {
      fit.setHeatmapRange('decade');
      expect(fit.heatmapRange, 'weeks');
    });
  });

  group('plan en PDF', () {
    testWidgets('sale un PDF válido con una página por cada tanda', (tester) async {
      setAppLanguage('es');
      final id = fit.createRoutine('Empuje');
      for (final name in ['Bench Press', 'Barbell Squat', 'Barbell Bent Over Row']) {
        fit.toggleRoutineExercise(id, fit.matchExerciseByName(name)!.id);
      }
      fit.assignRoutineToDay(DateTime.monday, id);
      final bytes = await tester.runAsync(() => buildPlanPdf(fit.routines, week: true));
      await tester.pump(const Duration(seconds: 1));
      final text = latin1.decode(bytes!);
      expect(text.startsWith('%PDF-1.4'), isTrue);
      expect(text.trimRight().endsWith('%%EOF'), isTrue);
      expect(RegExp(r'/Type /Page ').allMatches(text).length, 1);
      String hex(String v) =>
          '<FEFF${v.codeUnits.map((u) => u.toRadixString(16).padLeft(4, '0').toUpperCase()).join()}>';
      expect(text, contains('/Author ${hex('InlitX')}'));
      expect(text, contains('/Lang (es)'));
      expect(text, contains('<dc:creator><rdf:Seq><rdf:li>InlitX</rdf:li></rdf:Seq></dc:creator>'));
      expect(text, contains('<xmp:CreatorTool>GymMane</xmp:CreatorTool>'));
      final xref = int.parse(RegExp(r'startxref\n(\d+)').firstMatch(text)!.group(1)!);
      expect(text.substring(xref, xref + 4), 'xref');
      for (final m in RegExp(r'(\d{10}) 00000 n ').allMatches(text)) {
        final at = int.parse(m.group(1)!);
        expect(RegExp(r'^\d+ 0 obj').hasMatch(text.substring(at, at + 12)), isTrue);
      }
    });

    testWidgets('una rutina larga pasa a otra página', (tester) async {
      setAppLanguage('es');
      final id = fit.createRoutine('Larga');
      for (final e in fit.allExercises.take(24)) {
        fit.toggleRoutineExercise(id, e.id);
      }
      final bytes = await tester.runAsync(() => buildPlanPdf([fit.routines.single]));
      await tester.pump(const Duration(seconds: 1));
      final pages = RegExp(r'/Type /Page ').allMatches(latin1.decode(bytes!)).length;
      expect(pages, greaterThan(1));
    });
  });

  DateTime ago(int days, [int hour = 18]) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day - days, hour);
  }

  DateTime dayAgo(int days) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day - days);
  }

  void logged(String id, int days, List<LoggedSet> sets) =>
      fit.sessions.add(LoggedSession(ago(days), 1200, [LoggedExercise(id, id, 'back', sets)]));

  group('#224 notas en el entreno', () {
    test('una nota fijada sale siempre en el entreno', () {
      fit.saveNote(
        exerciseId: 'row',
        date: ago(10),
        kind: NoteKind.note,
        text: 'Asiento en el 2',
        pinned: true,
      );
      logged('row', 5, [LoggedSet(8, 40)]);
      expect(fit.workoutNotesFor('row').map((n) => n.text), ['Asiento en el 2']);
    });

    test('una nota sin fijar y que no es plan no molesta', () {
      fit.saveNote(exerciseId: 'row', date: ago(1), kind: NoteKind.done, text: 'Buen día');
      expect(fit.workoutNotesFor('row'), isEmpty);
    });

    test('la próxima vez sale hoy, la próxima vez y luego desaparece', () {
      fit.saveNote(exerciseId: 'row', date: ago(0), kind: NoteKind.plan, text: 'Sube a 45');
      expect(fit.workoutNotesFor('row').single.text, 'Sube a 45');
      final old = fit.notes.single;
      fit.notes[0] = GymNote(
        id: old.id,
        exerciseId: 'row',
        date: dayAgo(3),
        kind: NoteKind.plan,
        text: old.text,
        createdAt: old.createdAt,
      );
      logged('row', 3, [LoggedSet(8, 40)]);
      expect(fit.workoutNotesFor('row').single.text, 'Sube a 45');
      logged('row', 1, [LoggedSet(8, 45)]);
      expect(fit.workoutNotesFor('row'), isEmpty);
    });

    test('solo sale el plan más reciente', () {
      fit.saveNote(exerciseId: 'row', date: ago(2), kind: NoteKind.plan, text: 'Viejo');
      fit.saveNote(exerciseId: 'row', date: ago(1), kind: NoteKind.plan, text: 'Nuevo');
      expect(fit.workoutNotesFor('row').map((n) => n.text), ['Nuevo']);
    });

    test('fijar y soltar se guarda, y una nota general no se puede fijar', () {
      fit.saveNote(exerciseId: 'row', date: ago(0), kind: NoteKind.note, text: 'Polea 19');
      final id = fit.notes.single.id;
      fit.setNotePinned(id, true);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.applyBackup(data);
      expect(fit.noteById(id)!.pinned, isTrue);
      fit.setNotePinned(id, false);
      expect(fit.workoutNotesFor('row'), isEmpty);
      fit.saveNote(exerciseId: '', date: ago(0), kind: NoteKind.note, text: 'General', pinned: true);
      expect(fit.notes.last.pinned, isFalse);
    });

    test('editar sin decir nada conserva la chincheta', () {
      fit.saveNote(exerciseId: 'row', date: ago(0), kind: NoteKind.note, text: 'A', pinned: true);
      final id = fit.notes.single.id;
      fit.saveNote(id: id, exerciseId: 'row', date: ago(0), kind: NoteKind.note, text: 'B');
      expect(fit.noteById(id)!.pinned, isTrue);
    });
  });

  group('#228 editar series registradas', () {
    test('cambiar el peso no borra el tiempo, el tipo ni el RPE', () {
      final e = LoggedExercise('plank', 'Plank', 'abdomen', [
        LoggedSet(0, 10, sec: 45, rpe: 8, kind: SetKind.drop),
      ]);
      fit.sessions.add(LoggedSession(ago(1), 600, [e]));
      fit.bumpLoggedWeight(e, 0, 1);
      expect(e.sets.single.sec, 45);
      expect(e.sets.single.rpe, 8);
      expect(e.sets.single.kind, SetKind.drop);
      fit.bumpLoggedSec(e, 0, 1);
      expect(e.sets.single.sec, 50);
      fit.bumpLoggedSec(e, 0, -20);
      expect(e.sets.single.sec, 0);
    });

    test('añadir serie copia el tiempo y la distancia', () {
      final e = LoggedExercise('run', 'Run', 'quads', [LoggedSet(0, 0, sec: 1800, km: 5)]);
      fit.sessions.add(LoggedSession(ago(1), 600, [e]));
      fit.addLoggedSet(e);
      expect(e.sets.last.sec, 1800);
      expect(e.sets.last.km, 5);
      fit.bumpLoggedKm(e, 1, 1);
      expect(e.sets.last.km, closeTo(5.1, 0.001));
      expect(fit.loggedDistance(e), isTrue);
    });

    test('un ejercicio con tiempo se reconoce aunque sea propio', () {
      final e = LoggedExercise('mio', 'Mío', 'abdomen', [LoggedSet(0, 0, sec: 30)]);
      expect(fit.loggedTimed(e), isTrue);
      expect(fit.loggedTimed(LoggedExercise('b', 'B', 'chest', [LoggedSet(8, 60)])), isFalse);
    });
  });

  group('#201 máquinas asistidas', () {
    const pull = 'kiJ4Z2K';

    test('las dominadas asistidas vienen marcadas y se pueden desmarcar', () {
      expect(fit.isAssisted(pull), isTrue);
      expect(fit.isAssisted(fit.matchExerciseByName('Bench Press')!.id), isFalse);
      fit.toggleAssisted(pull);
      expect(fit.isAssisted(pull), isFalse);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.applyBackup(data);
      expect(fit.isAssisted(pull), isFalse);
    });

    test('el récord es la menor ayuda, no la mayor', () {
      logged(pull, 10, [LoggedSet(8, 40)]);
      logged(pull, 3, [LoggedSet(8, 35)]);
      final r = fit.exerciseRecord(pull)!;
      expect(r.best, 35);
      expect(fit.bestSet(pull)!.set.weight, 35);
      expect(fit.oneRmSeries(pull), [40, 35]);
    });

    test('con más reps y la misma ayuda también es mejor', () {
      logged(pull, 10, [LoggedSet(6, 35)]);
      logged(pull, 3, [LoggedSet(10, 35)]);
      expect(fit.bestSet(pull)!.set.reps, 10);
    });

    test('la sugerencia y los pesos de partida bajan la ayuda', () {
      fit.progressStep[pull] = 2.5;
      logged(pull, 3, [LoggedSet(8, 35), LoggedSet(8, 35)]);
      final next = fit.nextTarget(pull)!;
      expect(next.weightKg, 32.5);
      expect(next.up, isTrue);
      final r = fit.createRoutine('Espalda');
      fit.toggleRoutineExercise(r, pull);
      fit.startRoutine(fit.routines.single);
      expect(fit.session!.exercises.single.sets.where((s) => s.kind != SetKind.warmup).first.weight, 32.5);
      fit.saveAndExit();
    });

    test('la ayuda nunca baja de cero y no hay objetivo de peso', () {
      fit.progressStep[pull] = 5;
      logged(pull, 3, [LoggedSet(8, 2.5)]);
      expect(fit.nextTarget(pull)!.weightKg, 0);
      expect(fit.goalFits(pull), isFalse);
      expect(fit.bestLift(pull), 0);
    });
  });

  group('#218 segundo aviso', () {
    test('solo acepta las opciones de la hoja y se guarda', () {
      expect(fit.trainAgainMin, 0);
      fit.setTrainAgain(45);
      expect(fit.trainAgainMin, 0);
      fit.setTrainAgain(120);
      final data = jsonDecode(jsonEncode(fit.toJson())) as Map<String, dynamic>;
      fit.resetAllData();
      expect(fit.trainAgainMin, 0);
      fit.applyBackup(data);
      expect(fit.trainAgainMin, 120);
    });
  });

  group('descarga automática', () {
    String bench() => fit.matchExerciseByName('Bench Press')!.id;

    test('sin «subir el peso solo» no hay descarga', () {
      final id = bench();
      for (final d in [9, 6, 3]) {
        logged(id, d, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      }
      expect(fit.stallStreak(id), 3);
      expect(fit.needsDeload(id), isFalse);
    });

    test('tres entrenos al mismo peso sin cumplir bajan al 90 %', () {
      final id = bench();
      fit.progressStep[id] = 2.5;
      for (final d in [9, 6, 3]) {
        logged(id, d, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      }
      final next = fit.nextTarget(id)!;
      expect(next.deload, isTrue);
      expect(next.up, isFalse);
      expect(next.weightKg, 72.5);
      final r = fit.createRoutine('Pecho');
      fit.toggleRoutineExercise(r, id);
      fit.startRoutine(fit.routines.single);
      expect(fit.session!.exercises.single.sets.where((s) => s.kind != SetKind.warmup).first.weight, 72.5);
      fit.saveAndExit();
    });

    test('dos fallos no bastan y cambiar de peso empieza la cuenta de cero', () {
      final id = bench();
      fit.progressStep[id] = 2.5;
      logged(id, 12, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      logged(id, 9, [LoggedSet(8, 80), LoggedSet(6, 80)]);
      expect(fit.needsDeload(id), isFalse);
      logged(id, 6, [LoggedSet(8, 72.5), LoggedSet(6, 72.5)]);
      expect(fit.stallStreak(id), 1);
      logged(id, 3, [LoggedSet(8, 72.5), LoggedSet(8, 72.5)]);
      expect(fit.stallStreak(id), 0);
      expect(fit.nextTarget(id)!.up, isTrue);
    });

    test('en una asistida la descarga da más ayuda', () {
      const pull = 'kiJ4Z2K';
      fit.progressStep[pull] = 2.5;
      for (final d in [9, 6, 3]) {
        logged(pull, d, [LoggedSet(8, 30), LoggedSet(5, 30)]);
      }
      final next = fit.nextTarget(pull)!;
      expect(next.deload, isTrue);
      expect(next.weightKg, 32.5);
    });

    test('con poco peso baja al menos un escalón', () {
      final id = bench();
      fit.progressStep[id] = 2.5;
      for (final d in [9, 6, 3]) {
        logged(id, d, [LoggedSet(8, 5), LoggedSet(6, 5)]);
      }
      expect(fit.nextTarget(id)!.weightKg, 2.5);
    });
  });

  group('#214 #196 historial', () {
    test('el mes lista sus entrenos, del más nuevo al más viejo', () {
      final n = DateTime.now();
      final month = DateTime(n.year, n.month);
      fit.sessions.add(
        LoggedSession(DateTime(n.year, n.month, 1, 18), 1800, [
          LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 60)]),
        ]),
      );
      fit.sessions.add(
        LoggedSession(DateTime(n.year, n.month, 2, 18), 2400, [
          LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 62.5), LoggedSet(8, 62.5)]),
        ]),
      );
      fit.sessions.add(
        LoggedSession(DateTime(n.year, n.month - 1, 20, 18), 600, [
          LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 50)]),
        ]),
      );
      final list = fit.sessionsInMonth(month);
      expect(list.length, 2);
      expect(list.first.day.day, 2);
      final sum = fit.monthSummary(month);
      expect(sum.workouts, 2);
      expect(sum.sets, 3);
      expect(sum.seconds, 4200);
      expect(fit.monthSummary(DateTime(n.year, n.month - 1)).workouts, 1);
    });

    test('no se puede ir más allá del mes actual', () {
      fit.goHistory();
      expect(fit.historyAtLatest, isTrue);
      final before = fit.historyMonth;
      fit.shiftHistoryMonth(1);
      expect(fit.historyMonth, before);
      fit.shiftHistoryMonth(-1);
      expect(fit.historyAtLatest, isFalse);
      fit.popRoute();
    });

    test('cuenta los récords de cada entreno, no el primero', () {
      logged('a', 9, [LoggedSet(8, 60)]);
      logged('a', 6, [LoggedSet(8, 65)]);
      logged('a', 3, [LoggedSet(8, 62.5)]);
      final byDay = {for (final e in fit.recordsBySession().entries) e.key.day.day: e.value};
      expect(byDay.length, 1);
      expect(byDay[ago(6).day], 1);
    });

    test('sin nombre ni rutina, el título son los grupos musculares', () {
      final s = LoggedSession(ago(1), 600, [
        LoggedExercise('a', 'A', 'chest', [LoggedSet(8, 60), LoggedSet(8, 60)]),
        LoggedExercise('b', 'B', 'quads', [LoggedSet(5, 100)]),
      ]);
      fit.sessions.add(s);
      expect(fit.sessionHeading(s), contains(' · '));
      fit.renameSession(s, 'Pecho pesado');
      expect(fit.sessionHeading(s), 'Pecho pesado');
    });

    test('la mejor serie de una plancha es la más larga', () {
      final e = LoggedExercise('plank', 'Plank', 'abdomen', [
        LoggedSet(0, 0, sec: 45),
        LoggedSet(0, 0, sec: 60),
      ]);
      expect(fit.topSetOf(e)!.sec, 60);
    });
  });

  testWidgets('el historial cambia de mes en la app de verdad', (tester) async {
    setAppLanguage('es');
    fit.refreshAwards(silent: true);
    fit.pendingAwards.clear();
    fit.resetRoute('settings');
    fit.goHistory();
    await tester.pumpWidget(const GymManeApp());
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    final now = DateTime.now();
    expect(find.text(t.monthYear(DateTime(now.year, now.month))), findsOneWidget);
    await tester.tap(find.bySemanticsLabel(t.notePrevMonth));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text(t.monthYear(DateTime(now.year, now.month - 1))), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('#227 una hoja larga se cierra tirando hacia abajo', (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (c) {
            ctx = c;
            return const SizedBox();
          },
        ),
      ),
    );
    showAppSheet<void>(
      context: ctx,
      builder: (_) => SingleChildScrollView(
        child: Column(children: [for (var i = 0; i < 60; i++) SizedBox(height: 40, child: Text('fila $i'))]),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('fila 0'), findsOneWidget);
    await tester.drag(find.text('fila 2'), const Offset(0, 300));
    await tester.pumpAndSettle();
    expect(find.text('fila 0'), findsNothing);
  });

  test('el corredor del logo está en los assets', () async {
    final data = await rootBundle.load('assets/img/runner.png');
    expect(data.lengthInBytes, greaterThan(0));
  });
}
