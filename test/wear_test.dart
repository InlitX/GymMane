import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/watch_link.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/wear/wear_app.dart';
import 'package:gymmane/wear/wear_shell.dart';
import 'package:gymmane/wear/wear_sync.dart';
import 'package:gymmane/widgets/ui_kit.dart' show sentenceCase;
import 'package:sync/sync.dart';

void _reset() {
  fit.saveAndExit();
  fit.sessions.clear();
  fit.routines.clear();
  fit.weeklyPlan.clear();
  fit.setUnits('kg');
  fit.setRestSeconds(90);
  fit.keepScreenOn = true;
  fit.startCountdown = true;
}

Finder _label(String text) => find.text(sentenceCase(text));

Future<void> _pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(454, 454);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const WearApp());
  await tester.pump();
}

Future<void> _reveal(WidgetTester tester, Finder finder, {double delta = 40}) async {
  for (var i = 0; i < 60 && finder.evaluate().isEmpty; i++) {
    final p = tester.state<ScrollableState>(find.byType(Scrollable).last).position;
    p.jumpTo((p.pixels + delta).clamp(p.minScrollExtent, p.maxScrollExtent));
    await tester.pump();
  }
  await tester.ensureVisible(finder.first);
  await tester.pump();
}

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

String _push() {
  final id = fit.createRoutine('Push');
  fit.toggleRoutineExercise(id, 'EIeI8Vf');
  return id;
}

Future<void> _openSession(WidgetTester tester) async {
  await _reveal(tester, _label(t.routines));
  await tester.tap(_label(t.routines));
  await _settle(tester);
  await tester.tap(find.text('Push'));
  await _settle(tester);
}

void main() {
  setUp(_reset);
  tearDown(_reset);

  testWidgets('the watch home offers to start and to browse routines', (tester) async {
    await _pump(tester);
    expect(tester.takeException(), isNull);
    expect(_label(t.startWorkout), findsOneWidget);

    await _reveal(tester, _label(t.routines));
    await tester.tap(_label(t.routines));
    await _settle(tester);
    expect(fit.route, 'routines');
    expect(find.text(t.templates), findsOneWidget);

    await tester.tap(find.text('Push Pull Legs'));
    await _settle(tester);
    expect(fit.routines, isNotEmpty);
    expect(find.text(t.templates), findsNothing);
  });

  testWidgets('a routine runs on the wrist: sets, rest and finish', (tester) async {
    _push();
    await _pump(tester);
    await _openSession(tester);
    expect(fit.route, 'session');
    expect(fit.session, isNotNull);
    expect(tester.takeException(), isNull);

    expect(_label(t.setDone), findsOneWidget, reason: 'el botón principal se ve sin bajar');
    await tester.tap(_label(t.setDone));
    await tester.pump();
    expect(fit.session!.exercises.first.sets.first.done, isTrue);
    expect(fit.session!.restRemaining, isNotNull);
    await _reveal(tester, _label(t.rest), delta: -40);
    expect(_label(t.rest), findsOneWidget);

    await tester.tap(_label(t.skip));
    await tester.pump();
    expect(fit.session!.restRemaining, isNull);

    await _reveal(tester, _label(t.finishSession));
    await tester.tap(_label(t.finishSession).last);
    await tester.pump();
    expect(fit.isSessionComplete, isTrue);

    await _reveal(tester, _label(t.done));
    await tester.tap(_label(t.done));
    await tester.pump();
    expect(fit.session, isNull);
    expect(fit.sessions.length, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a mistaken finish can be undone from the summary', (tester) async {
    _push();
    await _pump(tester);
    await _openSession(tester);
    await tester.tap(_label(t.setDone));
    await tester.pump();
    fit.finishSession();
    await _settle(tester);
    await _reveal(tester, find.text(t.keepTraining));
    await tester.tap(find.text(t.keepTraining));
    await _settle(tester);
    expect(fit.isSessionActive, isTrue);
    expect(fit.sessions, isEmpty);
    fit.saveAndExit();
    await _settle(tester);
  });

  testWidgets('backing out parks the workout and home offers to continue', (tester) async {
    _push();
    fit.startRoutine(fit.routines.first);
    await _pump(tester);
    expect(fit.route, 'session');

    fit.parkSession();
    await _settle(tester);
    expect(fit.route, 'home');
    expect(fit.session, isNotNull);
    expect(_label(t.continueBtn), findsOneWidget);

    await tester.tap(_label(t.continueBtn));
    await _settle(tester);
    expect(fit.route, 'session');
    fit.saveAndExit();
    await _settle(tester);
  });

  testWidgets('settings on the watch change units, rest, goal and screen', (tester) async {
    await _pump(tester);
    await _reveal(tester, _label(t.settings));
    await tester.tap(_label(t.settings));
    await _settle(tester);
    expect(fit.route, 'settings');

    await tester.tap(find.text('lb'));
    await tester.pump();
    expect(fit.units, 'lb');

    final rest = fit.restSeconds;
    await tester.tap(find.bySemanticsLabel(t.increase).first);
    await tester.pump();
    expect(fit.restSeconds, rest + 15);

    final goal = fit.profile.weeklyGoal;
    await _reveal(tester, find.bySemanticsLabel(t.increase).last);
    await tester.tap(find.bySemanticsLabel(t.increase).last);
    await tester.pump();
    expect(fit.profile.weeklyGoal, goal < 7 ? goal + 1 : goal);

    await _reveal(tester, find.text(t.keepScreenOn));
    await tester.tap(find.text(t.keepScreenOn));
    await tester.pump();
    expect(fit.keepScreenOn, isFalse);
    await _settle(tester);
  });

  testWidgets('the crown scrolls the page', (tester) async {
    await _pump(tester);
    await tester.tap(_label(t.startWorkout));
    await _settle(tester);
    fit.applyTemplate(kProgramTemplates.firstWhere((p) => p.id == 'ppl'));
    await _settle(tester);
    final list = tester.state<ScrollableState>(find.byType(Scrollable).last);
    final before = list.position.pixels;
    WearRotary.turn(60);
    await tester.pump();
    expect(list.position.pixels, greaterThan(before));
  });

  testWidgets('the screen dims after a while and wakes on touch', (tester) async {
    _push();
    fit.startRoutine(fit.routines.first);
    fit.endCountdown();
    await _pump(tester);
    expect(find.byType(WearDim), findsNothing);

    await tester.pump(const Duration(seconds: 16));
    expect(find.byType(WearDim), findsOneWidget);

    await tester.tap(find.byType(WearDim));
    await tester.pump();
    expect(find.byType(WearDim), findsNothing);
    fit.saveAndExit();
    await _settle(tester);
  });

  test('a plan that repeats the same day makes a single routine', () {
    fit.applyTemplate(kProgramTemplates.firstWhere((p) => p.id == 'fullbody'));
    expect(fit.routines, hasLength(1));
    expect(fit.weeklyPlan.values.toSet(), {fit.routines.single.id});
    expect(fit.weeklyPlan.keys, containsAll([1, 3, 5]));
  });

  group('datos entre el móvil y el reloj', () {
    Map<String, dynamic> session(String d) => {
          'd': d,
          'dur': 1800,
          'ex': [
            {
              'id': 'EIeI8Vf',
              'n': 'Bench',
              's': [
                {'r': 8, 'w': 60},
              ],
            },
          ],
        };

    test('el reloj copia lo del móvil, guarda sus entrenos y no carga con fotos ni notas', () {
      final watch = {
        'units': 'lb',
        'keepAwake': false,
        'routines': [
          {'id': 'old', 'name': 'Borrada en el móvil'},
        ],
        'sessions': [session('2026-11-10T10:00:00.000'), session('2026-11-12T10:00:00.000')],
      };
      final phone = {
        'units': 'kg',
        'keepAwake': true,
        'profile': {'name': 'Ana', 'photo': 'AAAA', 'banner': 'BBBB', 'goal': 4},
        'routines': [
          {'id': 'r1', 'name': 'Push'},
        ],
        'sessions': [session('2026-11-10T10:00:00.000'), session('2026-11-11T10:00:00.000')],
        'notes': [
          {'id': 'n1'},
        ],
        'nutrition': {'x': 1},
        'noteMedia': {'a.jpg': 'media/notes/a.jpg'},
      };
      final out = mirrorPhone(watch, phone);
      expect(out['units'], 'kg');
      expect(out['keepAwake'], false, reason: 'la pantalla encendida es cosa del reloj');
      expect((out['routines'] as List).map((r) => (r as Map)['id']), ['r1'], reason: 'lo borrado en el móvil se va');
      expect((out['sessions'] as List).map(sessionKey),
          ['2026-11-10T10:00:00.000', '2026-11-11T10:00:00.000', '2026-11-12T10:00:00.000']);
      expect(out['profile'], {'name': 'Ana', 'goal': 4});
      expect(out.containsKey('notes'), isFalse);
      expect(out.containsKey('nutrition'), isFalse);
      expect(out.containsKey('noteMedia'), isFalse);
      expect(out['onboarded'], true);
    });

    test('al móvil solo van los entrenos hechos en el reloj', () {
      final watch = {
        'units': 'kg',
        'routines': [
          {'id': 'r1'},
        ],
        'sessions': [session('2026-11-10T10:00:00.000'), session('2026-11-12T10:00:00.000')],
      };
      final out = watchExport(watch, ['2026-11-12T10:00:00.000']);
      expect(out.keys, ['sessions']);
      expect((out['sessions'] as List).map(sessionKey), ['2026-11-12T10:00:00.000']);
    });

    test('el móvil junta el entreno del reloj sin tocar nada más', () {
      final phone = {
        'units': 'kg',
        'routines': [
          {'id': 'r1', 'name': 'Push'},
        ],
        'sessions': [session('2026-11-10T10:00:00.000')],
      };
      final fromWatch = watchExport({
        'sessions': [session('2026-11-10T10:00:00.000'), session('2026-11-12T10:00:00.000')],
      }, ['2026-11-12T10:00:00.000']);
      for (final newer in [true, false]) {
        final merged = mergeStates(phone, fromWatch, incomingNewer: newer);
        expect((merged['sessions'] as List).map(sessionKey), ['2026-11-10T10:00:00.000', '2026-11-12T10:00:00.000']);
        expect(merged['units'], 'kg');
        expect((merged['routines'] as List).single, {'id': 'r1', 'name': 'Push'});
      }
    });

    test('lo que el reloj copia del móvil se puede cargar', () {
      _reset();
      final id = _push();
      fit.persistNow();
      final phone = fit.toJson();
      fit.routines.clear();
      final next = mirrorPhone(fit.toJson(), jsonDecode(jsonEncode(Store.finite(phone))) as Map<String, dynamic>);
      expect(fit.tryApplyBackup(next), isTrue);
      expect(fit.routines.single.id, id);
      expect(fit.onboarded, isTrue);
    });

    test('lo que viaja por Bluetooth va comprimido, sin fotos ni notas, y llega igual', () {
      final phone = {
        'units': 'kg',
        'profile': {'name': 'Ana', 'photo': 'AAAA'},
        'routines': [
          {'id': 'r1', 'name': 'Push'},
        ],
        'sessions': [for (var i = 1; i <= 9; i++) session('2026-11-0${i}T10:00:00.000')],
        'notes': [
          {'id': 'n1'},
        ],
        'noteMedia': {'a': 'b'},
        'live': {'x': 1},
      };
      final message = {'role': 'phone', 'state': slimForWatch(phone)};
      final bytes = packLink(message);
      expect(bytes.length, lessThan(utf8.encode(jsonEncode(message)).length));
      final back = unpackLink(bytes)!;
      expect(back['role'], 'phone');
      final state = back['state'] as Map<String, dynamic>;
      expect(state['profile'], {'name': 'Ana'});
      expect(state.containsKey('notes'), isFalse);
      expect(state.containsKey('noteMedia'), isFalse);
      expect(state.containsKey('live'), isFalse);
      expect((state['sessions'] as List).length, 9);
      expect(unpackLink(Uint8List.fromList([1, 2, 3])), isNull);
    });
  });
}
