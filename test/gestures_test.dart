import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/screens/routine_edit_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:gymmane/widgets/glass.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('cerrar hojas', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
    });

    testWidgets('#227 una hoja larga se cierra tirando hacia abajo', (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));
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
  });

  group('arrastrar en la rutina', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Store.instance.init();
      fit.resetAllData();
      fit.onboarded = true;
      fit.setUnits('kg');
      setAppLanguage('en');
    });

    testWidgets('#251 arrastrar al borde de abajo desplaza la lista de la rutina', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final id = fit.createRoutine('Larga');
      for (final ex in fit.allExercises.take(15)) {
        fit.toggleRoutineExercise(id, ex.id);
      }
      fit.openRoutine(id);
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.dark,
        home: AnimatedBuilder(
          animation: fit,
          builder: (_, _) => const Scaffold(body: RoutineEditScreen()),
        ),
      ));
      await tester.pump(const Duration(seconds: 1));

      final handle = find.byType(ReorderableDragStartListener).first;
      await tester.ensureVisible(handle);
      await tester.pump(const Duration(milliseconds: 300));
      final scroll = tester.state<ScrollableState>(find.byType(Scrollable).first).position;
      final start = scroll.pixels;

      final drag = await tester.startGesture(tester.getCenter(handle));
      await drag.moveBy(const Offset(0, 20));
      await tester.pump(const Duration(milliseconds: 100));
      await drag.moveTo(const Offset(200, 790));
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(scroll.pixels, greaterThan(start + 100));
      await drag.up();
      await tester.pump(const Duration(seconds: 1));
    });
  });
}
