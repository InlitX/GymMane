import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

void main() {
  testWidgets('TrainScreen step 2 displays reset picks button and toggles selection', (tester) async {
    fit.onboarded = true;
    fit.selectedMuscles.clear();
    fit.selectedMuscles.addAll(['chest', 'triceps']);
    fit.trainContinue();
    fit.route = 'train';

    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();

    final iconFinder = find.byIcon(PhosphorIconsRegular.arrowCounterClockwise);
    expect(iconFinder, findsOneWidget);
    final initialIcon = tester.widget<Icon>(iconFinder);

    expect(find.byIcon(PhosphorIconsRegular.plus), findsOneWidget);

    expect(fit.sessionPicks.isNotEmpty, true);

    await tester.tap(iconFinder);
    await tester.pumpAndSettle();
    expect(fit.sessionPicks.isEmpty, true);
    final clearedIcon = tester.widget<Icon>(iconFinder);
    expect(clearedIcon.color != initialIcon.color, true);

    await tester.tap(iconFinder);
    await tester.pumpAndSettle();
    expect(fit.sessionPicks.isNotEmpty, true);
    final restoredIcon = tester.widget<Icon>(iconFinder);
    expect(restoredIcon.color == initialIcon.color, true);

    fit.route = 'home';
  });

  testWidgets('step 2 filters by muscle and keeps secondary exercises apart', (tester) async {
    fit.onboarded = true;
    fit.selectedMuscles
      ..clear()
      ..addAll(['triceps', 'forearm']);
    fit.trainContinue();
    fit.route = 'train';

    final muscles = ['triceps', 'forearm'];
    final suggested = fit.allExercises.where((e) => fit.sessionPicks.contains(e.id)).toList();
    final direct = fit.getFilteredExercises(muscles).where((e) => muscles.contains(e.primary) && fit.suggests(e.id));
    if (direct.length >= suggested.length) {
      expect(suggested.every((e) => muscles.contains(e.primary)), true);
    }

    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();

    expect(find.text('Triceps'), findsWidgets);
    expect(find.text('Forearm'), findsWidgets);
    expect(find.textContaining('ALSO WORKS'), findsOneWidget);

    await tester.tap(find.text('Triceps').first);
    await tester.pumpAndSettle();
    expect(find.text('ALSO WORKS TRICEPS'), findsOneWidget);

    await tester.tap(find.text('Triceps').first);
    await tester.pumpAndSettle();
    expect(find.text('ALSO WORKS TRICEPS, FOREARM'), findsOneWidget);

    fit.route = 'home';
  });
}
