import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.notes.clear();
    fit.goHome();
  });

  String exId() => fit.allExercises.first.id;

  test('going back from an exercise returns to where you came from', () {
    fit.goExercises();
    fit.openExercise(exId());
    expect(fit.handleBack(), isTrue);
    expect(fit.route, 'exercises');
  });

  test('writing a note inside an exercise does not lock you in', () {
    fit.goExercises();
    fit.openExercise(exId());
    fit.openNoteEditor(exerciseId: exId());
    fit.closeNoteEditor();
    expect(fit.route, 'exercise-detail');
    fit.handleBack();
    expect(fit.route, 'exercises');
  });

  test('the journal of an exercise gives the exercise back', () {
    fit.goHome();
    fit.openExercise(exId());
    fit.goNotes(exerciseId: exId());
    fit.openNoteEditor(exerciseId: exId());
    fit.closeNoteEditor();
    expect(fit.route, 'notes');
    fit.backFromNotes();
    expect(fit.route, 'exercise-detail');
    fit.handleBack();
    expect(fit.route, 'home');
  });

  test('a route never comes back to itself', () {
    fit.goSettings();
    fit.goPlaces();
    fit.goPlaces();
    fit.backFromPlaces();
    expect(fit.route, 'settings');
  });

  test('the tabs at the bottom drop the stack', () {
    fit.goExercises();
    fit.openExercise(exId());
    fit.goProgress();
    expect(fit.handleBack(), isTrue);
    expect(fit.route, 'home');
  });

  test('an exercise opened from another exercise still leaves', () {
    fit.goExercises();
    fit.openExercise(exId());
    fit.openExercise(fit.allExercises[1].id);
    fit.handleBack();
    expect(fit.route, 'exercises');
  });
}
