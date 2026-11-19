import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/screens/routine_edit_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('jump set desde el editor de rutina', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      setAppLanguage('en');
    });

    testWidgets('el enlace pasa de nada a superserie, a jump set y vuelve a nada', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final id = fit.createRoutine('Par');
      final ids = fit.allExercises.take(2).map((e) => e.id).toList();
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      fit.openRoutine(id);
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.dark,
        home: AnimatedBuilder(
          animation: fit,
          builder: (_, _) => Scaffold(body: RoutineEditScreen()),
        ),
      ));
      await tester.pump(const Duration(seconds: 1));
      final r = fit.routines.single;

      await tester.tap(find.bySemanticsLabel('Chain with the next one'));
      await tester.pump(const Duration(seconds: 1));
      expect(fit.chainsToNext(r, ids[0]), isTrue);
      expect(fit.jumpsToNext(r, ids[0]), isFalse);
      expect(find.text('SUPERSET'), findsNWidgets(2));

      await tester.tap(find.bySemanticsLabel('Make it a jump set'));
      await tester.pump(const Duration(seconds: 1));
      expect(fit.jumpsToNext(r, ids[0]), isTrue);
      expect(find.text('JUMP SET'), findsNWidgets(2));
      expect(find.text('SUPERSET'), findsNothing);

      await tester.tap(find.bySemanticsLabel('Unchain from the next one'));
      await tester.pump(const Duration(seconds: 1));
      expect(fit.chainsToNext(r, ids[0]), isFalse);
      expect(r.jumped, isEmpty);
      expect(find.text('JUMP SET'), findsNothing);
    });

    testWidgets('en una cadena de tres cada tarjeta describe el enlace que sale de ella', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final id = fit.createRoutine('Tres');
      final ids = fit.allExercises.take(3).map((e) => e.id).toList();
      for (final ex in ids) {
        fit.toggleRoutineExercise(id, ex);
      }
      fit.toggleChain(id, ids[0]);
      fit.toggleJump(id, ids[0]);
      fit.toggleChain(id, ids[1]);
      fit.openRoutine(id);
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.dark,
        home: AnimatedBuilder(
          animation: fit,
          builder: (_, _) => Scaffold(body: RoutineEditScreen()),
        ),
      ));
      await tester.pump(const Duration(seconds: 1));

      final pills = tester
          .widgetList<Text>(find.byWidgetPredicate((w) => w is Text && (w.data == 'JUMP SET' || w.data == 'SUPERSET')))
          .map((w) => w.data)
          .toList();
      expect(pills, ['JUMP SET', 'SUPERSET', 'SUPERSET']);
      expect(find.bySemanticsLabel('Unchain from the next one'), findsOneWidget);
      expect(find.bySemanticsLabel('Make it a jump set'), findsOneWidget);
    });
  });
}
