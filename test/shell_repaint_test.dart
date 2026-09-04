import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/progress_reminder.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    ProgressReminder.instance.enabled = false;
    setAppLanguage('es');
    fit.onboarded = true;
    fit.session = null;
    fit.setBodyTimeline(false);
    fit.setPhotoInterval(30);
  });

  tearDown(() {
    fit.setBodyTimeline(false);
    fit.persistNow();
  });

  Future<void> open(WidgetTester tester, String route) async {
    fit.route = route;
    await tester.pumpWidget(const GymManeApp());
    await tester.pumpAndSettle();
  }

  testWidgets('the timeline repaints when its own buttons change the state', (tester) async {
    await open(tester, 'timeline');

    await tester.tap(find.text(t.timelineBody));
    await tester.pumpAndSettle();
    expect(find.text(t.addTodayPhotos), findsNothing, reason: 'la pantalla no se repintó');

    await tester.tap(find.text(t.timelinePhotos));
    await tester.pumpAndSettle();
    expect(find.text(t.addTodayPhotos), findsOneWidget);

    await tester.tap(find.text('60'));
    await tester.pumpAndSettle();
    expect(fit.photoIntervalDays, 60);
    expect(find.text(t.photoNextIn(60)), findsNothing);
    fit.persistNow();
  });

  testWidgets('the measurements screen repaints when a measure is logged', (tester) async {
    fit.measures.clear();
    fit.setUnits('kg');
    await open(tester, 'measures');
    expect(find.text(t.measureNoneYet), findsWidgets);

    fit.addMeasure('arm', 38);
    await tester.pumpAndSettle();
    expect(find.text('38'), findsOneWidget, reason: 'la pantalla no se repintó');
    fit.measures.clear();
    fit.persistNow();
  });
}
