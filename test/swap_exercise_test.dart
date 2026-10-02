import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/live_session.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String bench;
  late String other;
  late String legs;
  late String r;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    bench = 'EIeI8Vf';
    legs = fit.allExercises.firstWhere((e) => e.primary == 'quads' && fit.modeOf(e.id).isEmpty).id;
    r = fit.createRoutine('Torso');
    fit.toggleRoutineExercise(r, bench);
    fit.toggleRoutineExercise(r, legs);
    other = fit.swapOptions(bench).first.id;
  });

  tearDown(fit.saveAndExit);

  test('las opciones son del mismo músculo y no repiten lo que ya está en el entreno', () {
    fit.startRoutine(fit.routines.single);
    final options = fit.swapOptions(bench);
    final primary = fit.exerciseById(bench)!.primary;
    expect(options, isNotEmpty);
    expect(options.every((e) => e.primary == primary), isTrue);
    expect(options.map((e) => e.id), isNot(contains(bench)));
  });

  test('los favoritos y los ya hechos salen antes', () {
    final pool = fit.swapOptions(bench, n: 100);
    final fav = pool.last.id;
    fit.toggleFavorite(fav);
    expect(fit.swapOptions(bench).first.id, fav);
  });

  test('sin series hechas lo sustituye en su sitio', () {
    fit.startRoutine(fit.routines.single);
    fit.swapSessionExercise(0, other);
    final s = fit.session!;
    expect(s.exercises.map((e) => e.id), [other, legs]);
    expect(s.exercises.first.swappedFrom, bench);
    expect(s.currentIndex, 0);
  });

  test('con series hechas, las hechas se quedan y el nuevo sigue con las que faltan', () {
    fit.startRoutine(fit.routines.single);
    final s = fit.session!;
    final working = s.exercises.first.sets.where((st) => st.counts).length;
    final firstWorking = s.exercises.first.sets.indexWhere((st) => st.counts);
    fit.toggleSet(0, firstWorking);
    fit.swapSessionExercise(0, other);
    expect(s.exercises.map((e) => e.id), [bench, other, legs]);
    expect(s.exercises.first.sets.every((st) => st.done), isTrue);
    expect(s.exercises[1].sets.length, working - 1);
    expect(s.exercises[1].sets.any((st) => !st.counts), isFalse);
    expect(s.currentIndex, 1);
  });

  test('guardar en la rutina pone el nuevo en el sitio del viejo', () {
    fit.startRoutine(fit.routines.single);
    fit.swapSessionExercise(0, other);
    expect(fit.sessionEditedRoutine, isTrue);
    final changes = fit.sessionRoutineChanges;
    expect(changes.added.map((e) => e.id), [other]);
    expect(changes.removed.map((e) => e.id), [bench]);
    fit.saveSessionIntoRoutine();
    expect(fit.routines.single.exerciseIds, [other, legs]);
  });

  test('también si ya había series hechas del viejo', () {
    fit.startRoutine(fit.routines.single);
    fit.toggleSet(0, fit.session!.exercises.first.sets.indexWhere((st) => st.counts));
    fit.swapSessionExercise(0, other);
    fit.saveSessionIntoRoutine();
    expect(fit.routines.single.exerciseIds, [other, legs]);
  });

  test('el cambio sobrevive a cerrar la app a mitad', () {
    fit.startRoutine(fit.routines.single);
    fit.swapSessionExercise(0, other);
    final back = SessionExercise.fromJson(fit.session!.exercises.first.toJson());
    expect(back.swappedFrom, bench);
  });
}
