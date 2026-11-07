import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/theme/app_colors.dart';
import 'package:gymmane/widgets/rolling_text.dart';
import 'package:gymmane/widgets/ui_kit.dart';

void main() {
  Future<void> rtl(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(extensions: const [GymColors.dark]),
      home: Directionality(textDirection: TextDirection.rtl, child: Scaffold(body: Center(child: child))),
    ));
    await tester.pump(const Duration(seconds: 1));
  }

  double x(WidgetTester tester, String text) => tester.getTopLeft(find.text(text).first).dx;

  testWidgets('el reloj sigue de izquierda a derecha en árabe', (tester) async {
    await rtl(tester, const RollingText('12:34', style: TextStyle(fontSize: 20)));
    expect(x(tester, '1'), lessThan(x(tester, '2')));
    expect(x(tester, '2'), lessThan(x(tester, ':')));
    expect(x(tester, ':'), lessThan(x(tester, '3')));
    expect(x(tester, '3'), lessThan(x(tester, '4')));
  });

  testWidgets('el contador con signos mas y menos no se invierte en árabe', (tester) async {
    await rtl(tester, StepperControl(value: '60', onDec: () {}, onInc: () {}));
    expect(x(tester, '–'), lessThan(x(tester, '6')));
    expect(x(tester, '6'), lessThan(x(tester, '0')));
    expect(x(tester, '0'), lessThan(x(tester, '+')));
  });

  testWidgets('Ltr deja la cifra antes que la unidad', (tester) async {
    await rtl(
      tester,
      const Ltr(
        child: Row(mainAxisSize: MainAxisSize.min, children: [Text('60'), SizedBox(width: 4), Text('kg')]),
      ),
    );
    expect(x(tester, '60'), lessThan(x(tester, 'kg')));
  });
}
