import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/glass.dart';
import 'package:gymmane/widgets/keyboard_guard.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = false;
    setAppLanguage('en');
  });

  testWidgets('onboarding: pasar de paso mueve la barra y vuelve atrás', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(PhosphorIconsBold.arrowLeft), findsNothing);
    await tester.tap(find.text(t.next));
    await tester.pumpAndSettle();
    expect(find.byIcon(PhosphorIconsBold.arrowLeft), findsOneWidget);

    await tester.tap(find.byIcon(PhosphorIconsBold.arrowLeft));
    await tester.pumpAndSettle();
    expect(find.byIcon(PhosphorIconsBold.arrowLeft), findsNothing);
    fit.onboarded = true;
    fit.persistNow();
  });

  group('hueco del teclado que se queda puesto', () {
    Widget host(ValueNotifier<double> seen) => MaterialApp(
          builder: (context, child) => KeyboardGuard(child: child!),
          home: Builder(builder: (context) {
            seen.value = MediaQuery.viewInsetsOf(context).bottom;
            return const Material(child: Align(alignment: Alignment.topCenter, child: SizedBox(width: 200, child: TextField())));
          }),
        );

    testWidgets('sin nada que escribir se ignora pasado un momento', (tester) async {
      final seen = ValueNotifier<double>(-1);
      tester.view.physicalSize = const Size(1080, 1800);
      tester.view.devicePixelRatio = 3;
      tester.view.viewInsets = const FakeViewPadding(bottom: 900);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(host(seen));
      expect(seen.value, 300);
      await tester.pump(const Duration(milliseconds: 300));
      expect(seen.value, 300, reason: 'el teclado puede estar cerrándose');
      await tester.pump(const Duration(milliseconds: 500));
      expect(seen.value, 0);
    });

    testWidgets('con un campo enfocado el hueco se respeta', (tester) async {
      final seen = ValueNotifier<double>(-1);
      tester.view.physicalSize = const Size(1080, 1800);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(host(seen));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      tester.view.viewInsets = const FakeViewPadding(bottom: 900);
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));
      expect(seen.value, 300);

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(seen.value, 0, reason: 'sin foco y con el hueco aún puesto, está atascado');

      await tester.tap(find.byType(TextField));
      await tester.pump();
      await tester.pump();
      expect(seen.value, 300, reason: 'al volver a escribir manda el teclado de verdad');
    });

    testWidgets('lo escrito no se pierde cuando el hueco se ignora', (tester) async {
      final seen = ValueNotifier<double>(-1);
      tester.view.physicalSize = const Size(1080, 1800);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(host(seen));
      await tester.enterText(find.byType(TextField), 'Press banca');
      tester.view.viewInsets = const FakeViewPadding(bottom: 900);
      await tester.pump();
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(seen.value, 0);
      expect(find.text('Press banca'), findsOneWidget, reason: 'cambiar el hueco no puede rehacer la pantalla');
    });
  });

  group('#372 las hojas se apartan del teclado', () {
    testWidgets('un campo al fondo de una hoja queda por encima del teclado y no pierde lo escrito', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => showAppSheet<void>(
                  context: context,
                  builder: (_) => const Padding(
                    padding: EdgeInsets.fromLTRB(20, 200, 20, 20),
                    child: Material(child: TextField(key: Key('campo'))),
                  ),
                ),
                child: const Text('abrir'),
              ),
            ),
          ),
        ),
      ));
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('campo')), 'Lesiones');
      tester.view.viewInsets = const FakeViewPadding(bottom: 1200);
      await tester.pumpAndSettle();
      final field = tester.getRect(find.byKey(const Key('campo')));
      expect(field.bottom, lessThanOrEqualTo(800 - 400));
      expect(find.text('Lesiones'), findsOneWidget);
    });
  });
}
