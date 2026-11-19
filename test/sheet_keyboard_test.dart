import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/widgets/glass.dart';

const _screen = 800.0;
const _keyboard = 300.0;
const _body = Key('body');

Future<BuildContext> _host(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  late BuildContext ctx;
  await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
    ctx = c;
    return const SizedBox();
  })));
  return ctx;
}

Future<void> _openKeyboard(WidgetTester tester) async {
  tester.view.viewInsets = const FakeViewPadding(bottom: _keyboard * 3);
  await tester.pumpAndSettle();
}

Future<void> _closeKeyboard(WidgetTester tester) async {
  tester.view.viewInsets = FakeViewPadding.zero;
  await tester.pumpAndSettle();
}

double _bottom(WidgetTester tester) => tester.getBottomLeft(find.byKey(_body)).dy;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a sheet reads no keyboard inset, in its builder or below it', (tester) async {
    final ctx = await _host(tester);
    double? inBuilder;
    double? below;
    showAppSheet<void>(
      context: ctx,
      isScrollControlled: true,
      builder: (sheet) {
        inBuilder = MediaQuery.viewInsetsOf(sheet).bottom;
        return Builder(builder: (c) {
          below = MediaQuery.viewInsetsOf(c).bottom;
          return const SizedBox(key: _body, height: 100);
        });
      },
    );
    await tester.pumpAndSettle();
    await _openKeyboard(tester);
    expect(inBuilder, 0);
    expect(below, 0);
  });

  testWidgets('a sheet that pads itself in its builder sits right above the keyboard', (tester) async {
    final ctx = await _host(tester);
    showAppSheet<void>(
      context: ctx,
      isScrollControlled: true,
      builder: (sheet) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheet).bottom),
        child: const SizedBox(key: _body, height: 100),
      ),
    );
    await tester.pumpAndSettle();
    expect(_bottom(tester), _screen);
    await _openKeyboard(tester);
    expect(_bottom(tester), _screen - _keyboard);
    await _closeKeyboard(tester);
    expect(_bottom(tester), _screen);
  });

  testWidgets('a sheet that pads itself in its own widget sits right above the keyboard', (tester) async {
    final ctx = await _host(tester);
    showAppSheet<void>(
      context: ctx,
      isScrollControlled: true,
      builder: (_) => Builder(
        builder: (c) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(c).bottom),
          child: const SizedBox(key: _body, height: 100),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await _openKeyboard(tester);
    expect(_bottom(tester), _screen - _keyboard);
  });

  testWidgets('a sheet without its own padding is lifted above the keyboard', (tester) async {
    final ctx = await _host(tester);
    showAppSheet<void>(
      context: ctx,
      builder: (_) => const SizedBox(key: _body, height: 100),
    );
    await tester.pumpAndSettle();
    await _openKeyboard(tester);
    expect(_bottom(tester), _screen - _keyboard);
  });

  testWidgets('a sheet that is not scroll-controlled keeps its height when the keyboard opens', (tester) async {
    final ctx = await _host(tester);
    showAppSheet<void>(
      context: ctx,
      builder: (_) => const SingleChildScrollView(
        key: _body,
        child: SizedBox(height: 2000),
      ),
    );
    await tester.pumpAndSettle();
    final height = tester.getSize(find.byKey(_body)).height;
    expect(height, _screen * 9 / 16);
    await _openKeyboard(tester);
    expect(tester.getSize(find.byKey(_body)).height, height);
    expect(_bottom(tester), _screen - _keyboard);
  });
}
