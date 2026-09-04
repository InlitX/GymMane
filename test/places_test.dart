import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/screens/places_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _host(Widget Function() screen) => MaterialApp(
      theme: AppTheme.dark,
      home: AnimatedBuilder(
        animation: fit,
        builder: (_, _) => Scaffold(body: screen()),
      ),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    setAppLanguage('es');
    fit.places.clear();
    fit.activePlaceId = '';
    fit.exNoGearOnly = false;
    fit.clearExFilters();
    fit.onboarded = true;
  });

  tearDown(() {
    fit.places.clear();
    fit.activePlaceId = '';
    fit.exNoGearOnly = false;
    fit.persistNow();
  });

  test('with no place picked the whole library is on the table', () {
    final all = fit.exercisesFiltered.length;
    expect(all, greaterThan(400));
    expect(fit.activePlace, isNull);
    expect(fit.fitsHere(fit.allExercises.firstWhere((e) => e.equipment == 'Machine')), true);
  });

  test('a place only shows what its kit can do, and bodyweight always fits', () {
    final id = fit.addPlace('Casa', equipment: {'Dumbbell'});
    fit.setActivePlace(id);

    final list = fit.exercisesFiltered;
    expect(list, isNotEmpty);
    expect(list.every((e) => e.equipment == 'Dumbbell' || e.equipment == 'Bodyweight'), true);
    expect(list.any((e) => e.equipment == 'Bodyweight'), true,
        reason: 'sin material siempre se puede');
    expect(list.length, lessThan(fit.allExercises.length));
  });

  test('the kettlebell preset brings the kettlebell work in', () {
    final id = fit.addPlace('Casa', equipment: {'Kettlebell'});
    fit.setActivePlace(id);
    final list = fit.exercisesFiltered;

    expect(list.where((e) => e.equipment == 'Kettlebell').length, greaterThanOrEqualTo(15));
    expect(list.any((e) => e.equipment == 'Barbell'), false);
  });

  test('the no-kit toggle leaves bodyweight only', () {
    fit.toggleNoGearFilter();
    expect(fit.exercisesFiltered.every((e) => e.equipment == 'Bodyweight'), true);

    fit.toggleNoGearFilter();
    expect(fit.exercisesFiltered.any((e) => e.equipment != 'Bodyweight'), true);
  });

  test('clearing the filters also drops the no-kit toggle but keeps the place', () {
    final id = fit.addPlace('Casa', equipment: {'Dumbbell'});
    fit.setActivePlace(id);
    fit.toggleNoGearFilter();
    fit.clearExFilters();

    expect(fit.exNoGearOnly, false);
    expect(fit.activePlaceId, id, reason: 'el sitio es un modo, no un filtro de la lista');
  });

  test('the workout picker only suggests what the place can do', () {
    final id = fit.addPlace('Parque', equipment: {'Bodyweight'});
    fit.setActivePlace(id);

    final picks = fit.getFilteredExercises(['chest']);
    expect(picks, isNotEmpty);
    expect(picks.every((e) => e.equipment == 'Bodyweight'), true);
  });

  test('presets land with their own kit', () {
    final id = fit.addPresetPlace('home');
    final place = fit.places.single;

    expect(place.id, id);
    expect(place.equipment, contains('Kettlebell'));
    expect(place.equipment.contains('Machine'), false);
    expect(fit.placeExerciseCount(place), greaterThan(50));
  });

  test('places survive a save and a reload, and the active one with them', () {
    final id = fit.addPlace('Gimnasio', equipment: {'Barbell', 'Machine'});
    fit.setActivePlace(id);
    fit.persistNow();

    fit.places.clear();
    fit.activePlaceId = '';
    fit.loadFromStore();

    expect(fit.places.single.name, 'Gimnasio');
    expect(fit.places.single.equipment, {'Barbell', 'Machine'});
    expect(fit.activePlaceId, id);
  });

  test('deleting the place you are at puts you back everywhere', () {
    final id = fit.addPlace('Casa', equipment: {'Dumbbell'});
    fit.setActivePlace(id);
    fit.deletePlace(id);

    expect(fit.places, isEmpty);
    expect(fit.activePlaceId, '');
    expect(fit.exercisesFiltered.length, fit.allExercises.length);
  });

  test('an exercise you cannot do here offers what you can', () {
    final id = fit.addPlace('Casa', equipment: {'Dumbbell'});
    fit.setActivePlace(id);
    final barbell = fit.allExercises.firstWhere((e) => e.equipment == 'Barbell');

    final alts = fit.alternativesHere(barbell, 3);
    expect(alts, isNotEmpty);
    expect(alts.every((e) => e.primary == barbell.primary), true);
    expect(alts.every(fit.fitsHere), true);

    final dumbbell = fit.allExercises.firstWhere((e) => e.equipment == 'Dumbbell');
    expect(fit.alternativesHere(dumbbell, 3), isEmpty, reason: 'ese sí se puede hacer aquí');
  });

  testWidgets('picking a place on its screen switches where you train', (tester) async {
    fit.addPlace('Casa', equipment: {'Dumbbell'});
    fit.goPlaces();
    await tester.pumpWidget(_host(PlacesScreen.new));
    await tester.pumpAndSettle();

    expect(find.text('Casa'), findsOneWidget);
    await tester.tap(find.text('Casa'));
    await tester.pumpAndSettle();

    expect(fit.activePlace?.name, 'Casa');
    fit.persistNow();
  });

  testWidgets('the empty screen offers the three starters', (tester) async {
    fit.goPlaces();
    await tester.pumpWidget(_host(PlacesScreen.new));
    await tester.pumpAndSettle();

    expect(find.text(t.placeEmptyTitle), findsOneWidget);
    await tester.tap(find.text(t.placeHome));
    await tester.pumpAndSettle();

    expect(fit.places.single.name, t.placeHome);
    expect(fit.activePlaceId, fit.places.single.id);
    fit.persistNow();
  });

  testWidgets('the library screen carries the place chips', (tester) async {
    fit.addPlace('Casa', equipment: {'Dumbbell'});
    fit.route = 'exercises';
    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();

    expect(find.text(t.placeAll), findsOneWidget);
    await tester.tap(find.text('Casa'));
    await tester.pumpAndSettle();
    expect(fit.activePlace?.name, 'Casa');

    await tester.tap(find.text(t.placeAll));
    await tester.pumpAndSettle();
    expect(fit.activePlaceId, '');
    fit.persistNow();
  });
}
