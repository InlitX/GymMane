import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
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
}
