import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('volver de un ejercicio deja la lista donde estaba', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.runAsync(() => Store.instance.init());
    fit.resetAllData();
    fit.onboarded = true;
    fit.pendingAwards.clear();
    fit.goExercises();
    await tester.pumpWidget(const GymManeApp());
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 80));
    }

    final list = find.byKey(const PageStorageKey('exercises'));
    double offset() => tester
        .state<ScrollableState>(
          find.descendant(
            of: find.byKey(const PageStorageKey('exercises')),
            matching: find.byType(Scrollable),
          ),
        )
        .position
        .pixels;
    await tester.drag(list, const Offset(0, -2500));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 80));
    }
    final before = offset();
    expect(before, greaterThan(1000));

    fit.openExercise(fit.exercisesFiltered.first.id);
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 80));
    }
    fit.closeExerciseDetail();
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 80));
    }
    final after = offset();
    expect(after, closeTo(before, 1));
  });
}
