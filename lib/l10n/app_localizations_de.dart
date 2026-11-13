// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get languageName => 'Deutsch';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% gegenüber dem letzten Monat';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Level $level · $streak';
  }

  @override
  String get save => 'SPEICHERN';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get cancelCaps => 'ABBRECHEN';

  @override
  String get deleteCaps => 'LÖSCHEN';

  @override
  String get done => 'FERTIG';

  @override
  String get set => 'Speichern';

  @override
  String get home => 'START';

  @override
  String get progress => 'FORTSCHRITT';

  @override
  String get exercises => 'ÜBUNGEN';

  @override
  String get settings => 'EINSTELLUNGEN';

  @override
  String get today => 'HEUTE';

  @override
  String get thisWeek => 'DIESE WOCHE';

  @override
  String get recommended => 'EMPFOHLEN';

  @override
  String get goal => 'ZIEL';

  @override
  String get volume => 'VOLUMEN';

  @override
  String get setsToday => 'SÄTZE HEUTE';

  @override
  String get prs => 'PRs';

  @override
  String get todaysFocus => 'HEUTIGER FOKUS';

  @override
  String get todaysRoutine => 'HEUTIGES TRAINING';

  @override
  String get startWorkout => 'TRAINING STARTEN';

  @override
  String get routines => 'TRAININGSPLÄNE';

  @override
  String get tools => 'WERKZEUGE';

  @override
  String get firstSessionHint => 'Wähle deine Muskeln und protokolliere dein erstes Training';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Übungen', one: '$n Übung');
    return '$_temp0';
  }

  @override
  String get pushDay => 'DRÜCKEN';

  @override
  String get pullDay => 'ZIEHEN';

  @override
  String get legDay => 'BEINE';

  @override
  String get pushFocus => 'Brust · Schultern · Trizeps';

  @override
  String get pullFocus => 'Rücken · Bizeps · Trapez';

  @override
  String get legFocus => 'Quadrizeps · Beinbeuger · Gesäß';

  @override
  String get train => 'TRAINIEREN';

  @override
  String get step1 => 'SCHRITT 1 VON 2';

  @override
  String get step2 => 'SCHRITT 2 VON 2';

  @override
  String get chooseFocus => 'WÄHLE DEINEN FOKUS';

  @override
  String get buildSession => 'TRAINING ZUSAMMENSTELLEN';

  @override
  String get tapMuscles => 'Tippe auf die Muskeln, die du trainieren möchtest, vorne und hinten.';

  @override
  String get continueBtn => 'WEITER';

  @override
  String get nothingForFocus => 'Noch nichts für diesen Fokus';

  @override
  String get goBackPick => 'Gehe zurück und wähle einen Muskel mit Übungen in deiner Bibliothek.';

  @override
  String pickedHint(int n) {
    return 'Wir haben ein Training für dich ausgewählt. Tippe, um eine der $n Übungen hinzuzufügen oder zu entfernen.';
  }

  @override
  String get pickAnExercise => 'WÄHLE EINE ÜBUNG';

  @override
  String get searchAllExercises => 'Übung suchen…';

  @override
  String get noExercisesMatch => 'Keine passenden Übungen';

  @override
  String get createItInstead => 'Stattdessen eigene Übung erstellen';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ÜBUNGEN', one: '$n ÜBUNG');
    return 'START · $_temp0';
  }

  @override
  String get inProgress => 'IM GANG';

  @override
  String get paused => 'PAUSIERT';

  @override
  String get last => 'LETZTES';

  @override
  String get rest => 'PAUSE';

  @override
  String get skip => 'ÜBERSPRINGEN';

  @override
  String get addSet => '+ SATZ HINZUFÜGEN';

  @override
  String get finishSession => 'TRAINING BEENDEN';

  @override
  String get setDone => 'SATZ ERLEDIGT';

  @override
  String get nextExercise => 'NÄCHSTE ÜBUNG';

  @override
  String get dropExerciseAction => 'Übung entfernen';

  @override
  String get restOff => 'Aus';

  @override
  String get miniRest => 'Pause bei Rest-Pause und Cluster';

  @override
  String get miniRestHint => 'Vor Rest-Pause- oder Cluster-Sätzen';

  @override
  String get gymPass => 'Studio-Pass';

  @override
  String get gymPassEmpty => 'Speichere hier den Code deines Studios und komm ohne Karte rein';

  @override
  String get gymPassAdd => 'Pass hinzufügen';

  @override
  String get gymPassScan => 'Code fotografieren';

  @override
  String get gymPassScanHint => 'Mit der Handykamera';

  @override
  String get gymPassPhoto => 'Aus einem Foto oder Screenshot';

  @override
  String get gymPassPhotoHint => 'Zum Beispiel ein Screenshot aus der App deines Studios';

  @override
  String get gymPassType => 'Nummer eintippen';

  @override
  String get gymPassTypeHint => 'Für Strichcodes: die Nummer darunter';

  @override
  String get gymPassNotFound => 'Kein QR-Code auf dem Bild. Versuch ein schärferes oder tipp die Nummer ein.';

  @override
  String get gymPassName => 'Name des Studios';

  @override
  String get gymPassDefaultName => 'Mein Studio';

  @override
  String get gymPassCode => 'Code';

  @override
  String get gymPassFormat => 'Code-Typ';

  @override
  String get gymPassInvalid => 'Diese Nummer passt nicht zu diesem Code-Typ';

  @override
  String get gymPassShowHint => 'Halt es an den Scanner. Die Helligkeit geht von selbst hoch.';

  @override
  String get gymPassDeleted => 'Pass gelöscht';

  @override
  String get gymPassEdit => 'Pass bearbeiten';

  @override
  String get gymPassShow => 'Am Eingang zeigen';

  @override
  String get gymPassPrivate => 'Bleibt nur auf deinem Handy. Nichts wird hochgeladen.';

  @override
  String get gymPassColor => 'Farbe';

  @override
  String get gymPassRescan => 'Code neu einlesen';

  @override
  String get gymPassReading => 'Code wird gelesen…';

  @override
  String get gymPassSettingHint => 'Deine Gymkarte im Profil';

  @override
  String get gymPassMember => 'Mitglied';

  @override
  String get widgetHintActivity => 'Deine Karte der Trainingstage';

  @override
  String get widgetHintStats => 'Serie, Volumen und Einheiten dieser Woche';

  @override
  String get widgetHintBody => 'Die Muskeln, die du trainiert hast';

  @override
  String get widgetHintToday => 'Auf einen Blick: Hast du heute trainiert?';

  @override
  String get widgetHintWeek => 'Dein Wochenplan, Tag für Tag';

  @override
  String get supportHintBug => 'Sag mir auf GitHub, was kaputt ist';

  @override
  String get supportHintFeature => 'Schlag eine Idee für die App vor';

  @override
  String get supportHintStar => 'Hilft, dass mehr Leute sie finden';

  @override
  String get supportHintCoffee => 'Unterstützt die Entwicklung. Gratis und ohne Werbung';

  @override
  String get bodyweightNoteHint => 'Notiz hinzufügen: wie du dich fühlst, was du ausprobierst… (optional)';

  @override
  String exerciseUnitSwitch(String unit) {
    return '$unit für diese Übung verwenden';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'WIEDERHOLUNGEN';

  @override
  String weightCol(String unit) {
    return 'GEWICHT ($unit)';
  }

  @override
  String get repsTitle => 'WIEDERHOLUNGEN';

  @override
  String weightTitle(String unit) {
    return 'GEWICHT ($unit)';
  }

  @override
  String get sessionComplete => 'TRAINING GESPEICHERT';

  @override
  String get finishHeadlinePr => 'Neuer persönlicher Rekord';

  @override
  String get finishHeadlineGoal => 'Wochenziel erreicht';

  @override
  String get finishHeadlineStreak => 'Serie bleibt bestehen';

  @override
  String get finishHeadlineDefault => 'Ein weiteres Training geschafft';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs exercises',
      one: 'an exercise',
    );
    return 'Du hast mehr geschafft als jemals in $_temp0. Es wurde zu deinen Rekorden hinzugefügt.';
  }

  @override
  String get finishBodyGoal => 'Du hast diese Woche die geplanten Trainings absolviert.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak Tage am Stück. Der schwierige Teil is nicht aufzuhören.';
  }

  @override
  String get finishBodyDefault => 'Protokolliert und gezählt. Beständigkeit bewegt die Zahlen.';

  @override
  String get vsLastTime => 'IM VERGLEICH ZUM LETZTEN MAL';

  @override
  String get firstTime => 'Zum ersten Mal protokolliert';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n neue Rekorde',
      one: '$n neuer Rekord',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'DAUER';

  @override
  String get setsCaps => 'SÄTZE';

  @override
  String exerciseXofY(int i, int n) {
    return 'ÜBUNG $i VON $n';
  }

  @override
  String get decrease => 'Verringern';

  @override
  String get increase => 'Erhöhen';

  @override
  String markSet(int n) {
    return 'Markiere Satz $n als erledigt';
  }

  @override
  String get pauseWorkout => 'Training pausieren';

  @override
  String get resumeWorkout => 'Training fortsetzen';

  @override
  String get discardTitle => 'Training verwerfen?';

  @override
  String get discardBody => 'Deine Sätze aus diesem Training gehen verloren.';

  @override
  String get keepTraining => 'Weiter trainieren';

  @override
  String get discard => 'Verwerfen';

  @override
  String get notifRestChannel => 'Pausentimer';

  @override
  String get notifRestChannelWhy => 'Informiert dich, wenn deine Satzpause vorbei ist';

  @override
  String get notifAlertChannel => 'Pausentimer (Hinweis)';

  @override
  String get notifAlertChannelWhy => 'Zeigt sofort einen Hinweis, wenn deine Pause vorbei ist';

  @override
  String get restOverTitle => 'Paue vorbei';

  @override
  String get restOverBody => 'Weiter gehts, der nächse Satz wartet.';

  @override
  String get allTimeSessions => 'TRAININGS';

  @override
  String get allTimeTime => 'ZEIT';

  @override
  String get allTimeSets => 'SÄTZE';

  @override
  String get consistency => 'KONTINUITÄT';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings protokolliert',
      one: '$n Training protokolliert',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n-Tage-Serie';
  }

  @override
  String get bodyweight => 'KÖRPERGEWICHT';

  @override
  String get logBodyweight => 'KÖRPERGEWICHT PROTOKOLLIEREN';

  @override
  String get trackWeight => 'Verfolge dein Gewicht über die Zeit';

  @override
  String get muscleMap => 'MUSKELKARTE';

  @override
  String get days7 => '7T';

  @override
  String get days30 => '30T';

  @override
  String get days90 => '90T';

  @override
  String get days365 => '1J';

  @override
  String get daysAll => 'Alle';

  @override
  String get weeklyAvgTitle => 'Wochendurchschnitt';

  @override
  String weekOfDate(String date) {
    return 'Woche vom $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change in diesem Zeitraum';
  }

  @override
  String get heatLow => 'Unberührt';

  @override
  String get heatHigh => 'Volles Volumen';

  @override
  String get muscleMapEmpty => 'Protokolliere ein Training und deine Körperkarte beginnt hier aufzuleuchten.';

  @override
  String get muscleMapHint => 'Tippe auf einen Muskel, um zu sehen, was er abbekommen hat.';

  @override
  String muscleMapBehind(String names) {
    return 'Im Rückstand: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% des Ziels';
  }

  @override
  String get muscleSplit => 'MUSKELVERTEILUNG';

  @override
  String get personalRecords => 'PERSÖNLICHE REKORDE';

  @override
  String get strength1rm => 'KRAFT · GESCH. 1RM';

  @override
  String get strengthEmpty => 'Protokolliere eine Übung zweimal und ihre Kraftkurve erscheint hier.';

  @override
  String oneRmEst(String w) {
    return 'Gesch. 1RM $w';
  }

  @override
  String get restDayShort => 'Ruhetag';

  @override
  String get restDay => 'Ruhetag, nichts protokolliert.';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteEntry => 'Diesen Eintrag löschen?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" wird von diesem Tag sowie aus deinen Rekorden und Diagrammen entfernt.';
  }

  @override
  String get bodyweightHistory => 'VERLAUF';

  @override
  String get exercisesCaps => 'ÜBUNGEN';

  @override
  String get timeCaps => 'ZEIT';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Übungen in deiner Bibliothek',
      one: '$n Übung in deiner Bibliothek',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Übungen suchen';

  @override
  String get muscleFilter => 'MUSKEL';

  @override
  String get levelFilter => 'STUFE';

  @override
  String get kindLabel => 'ART';

  @override
  String get kindStrength => 'Kraft';

  @override
  String get kindCalisthenics => 'Calisthenics';

  @override
  String get kindCardio => 'Kardio';

  @override
  String get kindStretch => 'Dehnen';

  @override
  String get newExercise => 'NEUE ÜBUNG';

  @override
  String get exerciseName => 'Übungsname';

  @override
  String get equipmentLabel => 'AUSRÜSTUNG';

  @override
  String get addExercise => 'ÜBUNG HINZUFÜGEN';

  @override
  String get advanced => 'ERWEITERT';

  @override
  String get demoMedia => 'DEMO';

  @override
  String get addMedia => 'Medien hinzufügen';

  @override
  String get mediaHint => 'Bild, GIF oder Video';

  @override
  String get changeMedia => 'Ändern';

  @override
  String get videoSelected => 'Video ausgewählt';

  @override
  String get favouritesOnly => 'Favoriten';

  @override
  String get noFavouritesYet => 'Noch keine Favoriten';

  @override
  String get noFavouritesHint => 'Tippe auf den Stern einer Übung, um sie hier zu speichern.';

  @override
  String get clearFilters => 'Filter löschen';

  @override
  String get quickAddAmount => 'Wie viel du hattest';

  @override
  String get homeCardsTitle => 'Karten auf Start';

  @override
  String get homeCardsHint => 'Was du einschaltest, erscheint auf Start';

  @override
  String get homeCardFocus => 'Heute';

  @override
  String get homeCardSteps => 'Schritte';

  @override
  String get homeCardWeek => 'Diese Woche';

  @override
  String get homeCardRoutines => 'Routinen';

  @override
  String get homeCardRecommended => 'Vorschläge';

  @override
  String get textSizeSetting => 'Textgröße';

  @override
  String get textSizeSmall => 'Klein';

  @override
  String get textSizeNormal => 'Normal';

  @override
  String get textSizeLarge => 'Groß';

  @override
  String get textSizeHint => 'Zusätzlich zur Textgröße deines Handys';

  @override
  String get calmMotionSetting => 'Animationen reduzieren';

  @override
  String get calmMotionHint => 'Bildschirme erscheinen ohne Einblenden';

  @override
  String get dishArchive => 'Archivieren';

  @override
  String get dishUnarchive => 'Wiederherstellen';

  @override
  String get dishArchivedToast => 'Gericht archiviert';

  @override
  String get filterShowLabel => 'Zeigen';

  @override
  String get noExercisesFound => 'Keine Übungen gefunden';

  @override
  String get noExercisesHint => 'Versuche eine andere Suche oder lösche deine Filter.';

  @override
  String get personalRecord => 'PERSÖNLICHER REKORD';

  @override
  String get history => 'VERLAUF';

  @override
  String get noHistory =>
      'Noch keine Trainings protokolliert. Trainiere diese Übung, um einen Verlauf aufzubauen.';

  @override
  String get notes => 'NOTIZEN';

  @override
  String get notePlaceholder => 'Hinweise, Aufbau, wie es sich angefühlt hat…';

  @override
  String notHere(String gear, String place) {
    return 'Kein $gear bei $place';
  }

  @override
  String get notHereWhy => 'Ersetze es gegen etwas aus, das du heute tatsächlich belasten kannst.';

  @override
  String get altHere => 'DAS KANNST DU HIER MACHEN';

  @override
  String get places => 'MEINE ORTE';

  @override
  String get placesHint =>
      'Gib an, was du an jedem Ort hast, und die Bibliothek zeigt nur Übungen, die du dort machen kannst.';

  @override
  String get placeAll => 'Überall';

  @override
  String get placeNew => 'Neuer Ort';

  @override
  String get placeNamePlaceholder => 'Zuhause, Fitnessstudio, Park…';

  @override
  String get placeGearLabel => 'WAS IST VORHANDEN';

  @override
  String placeExercises(int n) {
    return '$n Übungen hier';
  }

  @override
  String get placeEmptyTitle => 'Trainiere, wo immer du auch bist';

  @override
  String get placeEmptyBody =>
      'Ein Ort enthält die Ausrüstung, die du dort hast. Wähle einen zum Starten und bearbeite ihn später.';

  @override
  String get placeDeleteTitle => 'Ort löschen';

  @override
  String get placeDeleteBody => 'Nur der Ort wird gelöscht. Deine Übungen und Trainings bleiben erhalten.';

  @override
  String get placeGym => 'Fitnessstudio';

  @override
  String get placeHome => 'Zuhause';

  @override
  String get placeOutdoors => 'Draußen';

  @override
  String get placeFilterLabel => 'ORT';

  @override
  String get noGearOnly => 'Keine Ausrüstung';

  @override
  String placeActive(String name) {
    return 'Training bei $name';
  }

  @override
  String get journal => 'PROTOKOLL';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Notizen',
      one: '1 Notiz',
      zero: 'Keine Notizen',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Notiz';

  @override
  String get noteKindPlan => 'Plan';

  @override
  String get noteKindDone => 'Erfolg';

  @override
  String get noteKindPain => 'Beschwerde';

  @override
  String get noteFilterAll => 'Alle';

  @override
  String get newNote => 'Neue Notiz';

  @override
  String get editNote => 'Notiz bearbeiten';

  @override
  String get addNote => 'NOTIZ HINZUFÜGEN';

  @override
  String get noteEmptyTitle => 'Noch nichts geschrieben';

  @override
  String get noteEmptyBody =>
      'Hinweise, Pläne fürs nächste Mal, wie sich ein Training angefühlt hat. Mit Fotos oder Video, wenn du möchtest.';

  @override
  String get noteNoneForExercise => 'Noch keine Notizen für diese Übung.';

  @override
  String get noteKindLabel => 'TYP';

  @override
  String get noteTextLabel => 'NOTIZ';

  @override
  String get noteDateLabel => 'DATUM';

  @override
  String get noteExerciseLabel => 'ÜBUNG';

  @override
  String get noteMediaLabel => 'FOTOS & VIDEO';

  @override
  String get noteGeneral => 'Keine Übung';

  @override
  String get noteAttach => 'Anhängen';

  @override
  String get noteRemoveMedia => 'Anhang entfernen';

  @override
  String get deleteNoteTitle => 'Notiz löschen';

  @override
  String get deleteNoteBody => 'Die Notiz und alle Änhänge werden dauerhaft gelöscht.';

  @override
  String get noteToday => 'Heute';

  @override
  String get noteYesterday => 'Gestern';

  @override
  String get noteAllNotes => 'Alle Notizen';

  @override
  String get noteCalendar => 'Kalender';

  @override
  String get noteNoneOnDay => 'An diesem Tag nichts geschrieben';

  @override
  String get noteAddOnDay => 'Notiz für diesen Tag';

  @override
  String get notePrevMonth => 'Vorheriger Monat';

  @override
  String get noteNextMonth => 'Nächster Monat';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Notizen diesen Monat',
      one: '1 Notiz diesen Monat',
      zero: 'Keine Notizen diese Monat',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'MESSUNGEN';

  @override
  String get measuresHint =>
      'Vom Hals bis zur Wade: beobachte, wie sich dein Körper verändert, nicht nur die Hantel.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Messungen',
      one: '1 Messung',
      zero: 'Nichts protokolliert',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Noch nicht protokolliert';

  @override
  String get measureHistory => 'VERLAUF';

  @override
  String get measureNeck => 'Hals';

  @override
  String get measureShoulders => 'Schultern';

  @override
  String get measureChest => 'Brust';

  @override
  String get measureArm => 'Arm';

  @override
  String get measureForearm => 'Unterarm';

  @override
  String get measureWaist => 'Taille';

  @override
  String get measureHips => 'Hüfte';

  @override
  String get measureThigh => 'Oberschenkel';

  @override
  String get measureCalf => 'Wade';

  @override
  String get measureBodyfat => 'Körperfett';

  @override
  String get timeline => 'ZEITVERLAUF';

  @override
  String get hidePhotos => 'Fotos ausblenden';

  @override
  String get showPhotos => 'Fotos anzeigen';

  @override
  String get timelineHint =>
      'Gleiche Pose, gleicher Ort, gleiches Licht. In einem Jahr wirst du es kaum glauben.';

  @override
  String get timelineEmptyTitle => 'Dein erstes Foto startet die Zeitreise';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Fotos',
      one: '1 Foto',
      zero: 'Keine Fotos',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Vorne';

  @override
  String get poseSide => 'Seite';

  @override
  String get poseBack => 'Hinten';

  @override
  String get photoEvery => 'ERINNERE MICH';

  @override
  String photoEveryDays(int n) {
    return 'Alle $n Tage';
  }

  @override
  String get photoEveryOff => 'Nie';

  @override
  String get timelineEvery => 'GRUPPIEREN ALLE';

  @override
  String get custom => 'Eigene';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Nächstes Foto in $n Tagen',
      one: 'Nächstes Foto morgen',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Foto fällig: mach es heute';

  @override
  String get addTodayPhotos => 'HEUTIGE FOTOS HINZUFÜGEN';

  @override
  String posePhoto(String pose) {
    return '$pose-Foto';
  }

  @override
  String get compare => 'VERGLEICHEN';

  @override
  String get compareNeedTwo =>
      'Nimm dieselbe Pose an zwei verschiedenen Tagen auf, um sie hier zu vergleichen.';

  @override
  String dayNumber(int n) {
    return 'Tag $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Tage Abstand',
      one: '1 Tag Abstand',
      zero: 'Am selben Tag',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Diesen Tag löschen';

  @override
  String get deleteDayBody => 'Die Fotos dieses Tages werden ebenfalls endgültig gelöscht.';

  @override
  String get timelinePhotos => 'Fotos';

  @override
  String get timelineBody => 'Muskelkarte';

  @override
  String get timelineBodyEmpty =>
      'Protokolliere ein Training und deine Muskelkarte füllt sich hier, ganz ohne Fotos.';

  @override
  String get timelineBodyHint => 'Aus deinen eigenen Sätzen erstellt, nichts muss hochgeladen werden.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings',
      one: '1 Training',
      zero: 'Keine Trainings',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Fortschrittsfotos';

  @override
  String get notifPhotoChannelWhy => 'Eine Erinnerung, wenn dein nächstes Fortschrittsfoto fällig ist.';

  @override
  String get notifPhotoTitle => 'Zeit für dein Fortschrittsfoto';

  @override
  String notifPhotoBody(int n) {
    return 'Seit dem letzten Foto sind $n Tage vergangen. Gleiche Pose, gleiches Licht.';
  }

  @override
  String get share => 'TEILEN';

  @override
  String get sharePick => 'Was möchtest du zeigen?';

  @override
  String get shareStreak => 'Serie und Beständigkeit';

  @override
  String get shareBody => 'Trainierte Muskeln';

  @override
  String get shareCompare => 'Vorher und nachher';

  @override
  String get shareHint =>
      'Die Karte wird auf deinem Handy erstellt. Nichts verlässt es, bevor du auswählst, wohin sie soll.';

  @override
  String get shareFailed => 'Die Karte konnte nicht erstellt werden';

  @override
  String get shareWeekOf => 'LETZTE 7 TAGE';

  @override
  String get shareStreakLabel => 'TAGE SERIE';

  @override
  String get shareSessionsLabel => 'TRAININGS';

  @override
  String get shareVolumeLabel => 'VOLUMEN';

  @override
  String get restForExercise => 'PAUSE FÜR DIESE ÜBUNG';

  @override
  String get restUsingDefault => 'Deine Standardeinstellung';

  @override
  String get restCustom => 'Nur für diese Übung';

  @override
  String get setType => 'SATZART';

  @override
  String get setTypeNormal => 'Arbeitssatz';

  @override
  String get setTypeWarmup => 'Aufwärmsatz';

  @override
  String get setTypeDrop => 'Dropsatz';

  @override
  String get setTypeFailure => 'Bis zum Muskelversagen';

  @override
  String get addWarmup => 'AUFWÄRMEN';

  @override
  String platesPerSide(String plates) {
    return 'Pro Seite: $plates';
  }

  @override
  String get howTo => 'ANLEITUNG';

  @override
  String get similar => 'ÄHNLICH';

  @override
  String get primaryLabel => 'PRIMÄR';

  @override
  String get secondaryLabel => 'SEKUNDÄR';

  @override
  String get none => 'Keine';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Sätze', one: '$n Satz');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v Volumen';
  }

  @override
  String get weeklyPlan => 'WOCHENPLAN';

  @override
  String get yourRoutines => 'DEINE TRAININGSPLÄNE';

  @override
  String get noRoutines => 'Noch keine Trainingspläne. Erstelle einen und füge deine Übungen hinzu.';

  @override
  String get newRoutine => 'NEUER TRAININGSPLAN';

  @override
  String get routineName => 'Name des Trainingsplans';

  @override
  String get schedule => 'ZEITPLAN';

  @override
  String get addFromList => 'Füge Übungen aus der Liste unten hinzu.';

  @override
  String get addExercises => 'Übungen hinzufügen';

  @override
  String get deleteRoutine => 'Diesen Trainingsplan löschen?';

  @override
  String exercisesWithCount(int n) {
    return 'ÜBUNGEN · $n';
  }

  @override
  String setDay(String day) {
    return '$day FESTLEGEN';
  }

  @override
  String get newRoutineName => 'Neuer Trainingsplan';

  @override
  String get dragToReorder => 'Zieh am Punkte-Griff, um die Reihenfolge zu ändern, so trainierst du.';

  @override
  String reorderHandle(String name) {
    return '$name neu sortieren';
  }

  @override
  String get removeFromRoutine => 'Aus Trainingsplan entfernen';

  @override
  String get dropExercise => 'Diese Übung entfernen?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" wird aus diesem Training entfernt. Nichts Protokolliertes geht verloren.';
  }

  @override
  String get drop => 'Entfernen';

  @override
  String get resetData => 'Alle meine Daten löschen';

  @override
  String get resetTitle => 'Alles löschen?';

  @override
  String get resetBody =>
      'Trainings, Rekorde, Trainingspläne, Notizen und Profil. Dies kann nicht rückgängig gemacht werden: exportiere vorher ein Backup, falls du es noch brauchen könntest.';

  @override
  String get resetConfirm => 'Alles löschen';

  @override
  String get resetDone => 'Alle Daten gelöscht';

  @override
  String get support => 'HILFE';

  @override
  String get reportBug => 'Fehler melden';

  @override
  String get requestFeature => 'Funktion vorschlagen';

  @override
  String get starOnGithub => 'Auf GitHub mit Stern markieren';

  @override
  String get buyCoffee => 'Kauf mir einen Kaffee';

  @override
  String get cantOpenLink => 'Der Link konnte nicht geöffnet werden';

  @override
  String get theme => 'Erscheinungsbild';

  @override
  String get darkTheme => 'Dunkel';

  @override
  String get lightTheme => 'Hell';

  @override
  String get amoledTheme => 'AMOLED-Schwarz';

  @override
  String get editDuration => 'Trainingsdauer';

  @override
  String get sessionName => 'Name des Trainings';

  @override
  String get nameWorkout => 'Benennen';

  @override
  String get sessionNameHint => 'z. B. Beine, Push, Ganzkörper';

  @override
  String get secondaryPickHint => 'Tippe die weiteren Muskeln an, die diese Übung trainiert.';

  @override
  String get languageLabel => 'Sprache';

  @override
  String get unitsLabel => 'Einheiten';

  @override
  String get restTimer => 'Pausentimer';

  @override
  String get alarmBlockedTitle => 'Benachrichtigungen sind deaktiviert';

  @override
  String get alarmBlockedBody => 'Der Pausenalarm ertönt nicht, wenn der Bildschirm gesperrt ist';

  @override
  String get alarmBlockedAction => 'AKTIVIEREN';

  @override
  String get alarmSound => 'Alarmton';

  @override
  String get alarmDefaultName => 'Standard';

  @override
  String get alarmSoundHint => 'Verwende deinen eigenen Ton, bis zu 15 Sekunden';

  @override
  String get alarmChoose => 'Ton auswählen…';

  @override
  String get alarmPreview => 'Aktuellen Ton abspielen';

  @override
  String get alarmReset => 'Auf Standard zurücksetzen';

  @override
  String get alarmTooLong => 'Dieser Ton ist länger als 15 Sekunden';

  @override
  String get alarmInvalid => 'Diese Audiodatei konnte nicht gelesen werden';

  @override
  String alarmChanged(String name) {
    return 'Alarmton auf \"$name\" gesetzt';
  }

  @override
  String get alarmChangedDefault => 'Zurück zum Standardton';

  @override
  String get addActivityWidget => 'Aktivitäts-Widget hinzufügen';

  @override
  String get addStatsWidget => 'Statistik-Widget hinzufügen';

  @override
  String get pinUnsupported => 'Füge es über das Widget-Menü deines Launchers hinzu';

  @override
  String get background => 'Hintergrund';

  @override
  String get bgNone => 'Keiner';

  @override
  String get bgDots => 'Punkte';

  @override
  String get bgGrid => 'Raster';

  @override
  String get exportCsv => 'Trainings exportieren (CSV)';

  @override
  String get exportBackup => 'Backup exportieren (ZIP)';

  @override
  String get importBackup => 'Backup importieren';

  @override
  String get importHint =>
      'Wähle ein aus GymMane exportiertes .zip- (oder älteres .json-) Backup. Es ersetzt deine aktuellen Daten, einschließlich Medien.';

  @override
  String get import => 'Importieren';

  @override
  String get chooseFile => 'Datei auswählen';

  @override
  String get importFromApp => 'Aus einer anderen App importieren';

  @override
  String get importUnknownFormat =>
      'Diese Datei benötigt Spalten für Datum, Übung, Wiederholungen und Gewicht';

  @override
  String get importZipNoWeights => 'Dieses ZIP enthält keine Gewichtsdatei';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Wiegungen importiert',
      one: '$n Wiegung importiert',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Diese Datei konnte nicht gelesen werden';

  @override
  String get importUnitTitle => 'In welcher Einheit ist diese Datei?';

  @override
  String get importUnitBody => 'Dieser Export gibt nicht an, in welcher Einheit die Gewichte angegeben sind.';

  @override
  String get importNothing => 'Nichts Neues zu importieren';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings importiert',
      one: '$n Training importiert',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'Über GymMane';

  @override
  String get yourProfile => 'DEIN PROFIL';

  @override
  String get autofills => 'Füllt die Rechner automatisch aus';

  @override
  String get onbUnitsWhy =>
      'Für Gewichte, Maße und Strecken. Du kannst es jederzeit in den Einstellungen ändern.';

  @override
  String get nameLabel => 'NAME';

  @override
  String get sexLabel => 'GESCHLECHT';

  @override
  String get macroProtein => 'EIWEISS';

  @override
  String get macroCarbs => 'KOHLENHYDRATE';

  @override
  String get macroFat => 'FETT';

  @override
  String get male => 'Männlich';

  @override
  String get female => 'Weiblich';

  @override
  String get ageLabel => 'ALTER';

  @override
  String get heightLabel => 'GRÖSSE';

  @override
  String get weightLabel => 'GEWICHT';

  @override
  String get weeklyGoal => 'WOCHENZIEL';

  @override
  String get activityLabel => 'AKTIVITÄT';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get removePhoto => 'Foto entfernen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get chooseGallery => 'Aus Galerie auswählen';

  @override
  String get backupImported => 'Backup importiert';

  @override
  String get backupFailed => 'Dieses Backup konnte nicht gelesen werden';

  @override
  String get nothingToExport => 'Noch nichts zu exportieren: protokolliere zuerst ein Training';

  @override
  String calculatorsCount(int n) {
    return '$n Rechner für dein Training';
  }

  @override
  String get result => 'ERGEBNIS';

  @override
  String get weightLifted => 'GEHOBENES GEWICHT';

  @override
  String get repsPerformed => 'AUSGEFÜHRTE WIEDERHOLUNGEN';

  @override
  String get neck => 'HALS';

  @override
  String get waist => 'TAILLE';

  @override
  String get hip => 'HÜFTE (für Frauen)';

  @override
  String get targetWeight => 'ZIELGEWICHT';

  @override
  String get workingWeight => 'ARBEITSGEWICHT';

  @override
  String get activityLevel => 'AKTIVITÄTSSTUFE';

  @override
  String get barWeight => 'STANGENGEWICHT';

  @override
  String get perSide => 'PRO SEITE';

  @override
  String get justTheBar => 'Nur die Stange.';

  @override
  String perSideCount(int n) {
    return '× $n pro Seite';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'Kalorien';

  @override
  String get toolNameBf => 'Körperfett';

  @override
  String get toolNamePlate => 'Gewichtsplatten';

  @override
  String get toolNameWarmup => 'Aufwärmen';

  @override
  String get toolTitleRm => '1RM-Rechner';

  @override
  String get toolTitleBmi => 'BMI-Rechner';

  @override
  String get toolTitleCal => 'Kalorien & Makros';

  @override
  String get toolTitleBf => 'Körperfett %';

  @override
  String get toolTitlePlate => 'Plattenrechner';

  @override
  String get toolTitleWarmup => 'Aufwärmsätze';

  @override
  String get toolHintRm => 'Geschätztes 1RM (Epley-Formel)';

  @override
  String get toolHintCal => 'Geschätzter täglicher Erhaltungsbedarf';

  @override
  String get toolHintBf => 'Schätzung nach der US-Navy-Methode';

  @override
  String get toolHintPlate => 'Gesamtgewicht der Langhantel';

  @override
  String get toolHintWarmup => 'Ziel Arbeitsgewicht';

  @override
  String get toolDescRm => 'Geschätztes Einer-Wiederholungsmaximum';

  @override
  String get toolDescBmi => 'Body-Mass-Index';

  @override
  String get toolDescCal => 'Kalorien & Makros';

  @override
  String get toolDescBf => 'Körperfettanteil';

  @override
  String get toolDescPlate => 'Rechner für Hantelscheiben';

  @override
  String get toolDescWarmup => 'Aufwärmsätze';

  @override
  String get bmiUnderweight => 'Untergewichtig';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Übergewichtig';

  @override
  String get bmiObese => 'Stark Übergewichtig';

  @override
  String get actSedentary => 'Sitzend';

  @override
  String get actLight => 'Leicht aktiv';

  @override
  String get actActive => 'Aktiv';

  @override
  String get actModerate => 'Mäßig aktiv';

  @override
  String get muscleChest => 'Brust';

  @override
  String get muscleBack => 'Rücken';

  @override
  String get muscleLowerBack => 'Unterer Rücken';

  @override
  String get muscleShoulders => 'Schultern';

  @override
  String get muscleBiceps => 'Bizeps';

  @override
  String get muscleTriceps => 'Trizeps';

  @override
  String get muscleForearm => 'Unterarm';

  @override
  String get muscleTrapezius => 'Trapezmuskel';

  @override
  String get muscleAbdomen => 'Bauch';

  @override
  String get muscleObliques => 'Schräge Bauchmuskeln';

  @override
  String get muscleQuads => 'Quadrizeps';

  @override
  String get muscleHamstrings => 'Beinbeuger';

  @override
  String get muscleGlutes => 'Gesäß';

  @override
  String get muscleCalves => 'Waden';

  @override
  String get mgChest => 'Brust';

  @override
  String get mgBack => 'Rücken';

  @override
  String get mgLegs => 'Beine';

  @override
  String get mgShoulders => 'Schultern';

  @override
  String get mgArms => 'Arme';

  @override
  String get mgCore => 'Rumpf';

  @override
  String get equipBarbell => 'Langhantel';

  @override
  String get equipDumbbell => 'Kurzhantel';

  @override
  String get equipCable => 'Kabelzug';

  @override
  String get equipMachine => 'Maschine';

  @override
  String get equipBodyweight => 'Körpergewicht';

  @override
  String get equipWeighted => 'Mit Zusatzgewicht';

  @override
  String get equipBand => 'Band';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Ringe';

  @override
  String get equipOther => 'Sonstiges';

  @override
  String get diffBeginner => 'Anfänger';

  @override
  String get diffAdvanced => 'Fortgeschritten';

  @override
  String get diffIntermediate => 'Mittelstufe';

  @override
  String get about => 'ÜBER';

  @override
  String version(String v) {
    return 'Version $v';
  }

  @override
  String get aboutBlurb => 'Von Trainierenden für Trainierende.';

  @override
  String get freeForever => 'Für immer kostenlos';

  @override
  String get freeForeverWhy => 'Kein Abo, keine Werbung, nichts hinter einer Bezahlschranke.';

  @override
  String get fullyOffline => 'Vollständig offline';

  @override
  String get fullyOfflineWhy => 'Kein Konto, keine Server. Dein Training verlässt dieses Handy nie.';

  @override
  String get yoursToTake => 'Deine Daten gehören dir';

  @override
  String get yoursToTakeWhy => 'Exportiere sie jederzeit als CSV und lösche alles mit einem Fingertipp.';

  @override
  String get whatsInside => 'WAS ENTHALTEN IST';

  @override
  String exercisesInside(int n) {
    return '$n Übungen';
  }

  @override
  String get exercisesInsideWhy => 'Jede Übung mit Animation und Schritt-für-Schritt-Anleitung.';

  @override
  String get calculatorsInside => '10 Rechner';

  @override
  String get calculatorsInsideWhy =>
      '1RM, Scheiben, BMI, Kalorien, Körperfett, FFMI, Aufwärmen, Gewicht nach RPE und Kraftwertungen (DOTS und Wilks), alle mit veröffentlichten Formeln.';

  @override
  String get mathInside => 'Ehrliche Mathematik';

  @override
  String get mathInsideWhy =>
      'Volumen, Rekorde und Serien stammen aus deinen eigenen Sätzen. Nichts hier ist bloße Dekoration.';

  @override
  String get streakCaps => 'SERIE';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Tage', one: 'Tag');
    return '$_temp0';
  }

  @override
  String get reset => 'ZURÜCKSETZEN';

  @override
  String get welcomeKicker => 'WILLKOMMEN BEI';

  @override
  String get welcomeBlurb => 'Alles bleibt auf deinem Handy. Kein Konto, kein Internet, nichts zu bezahlen.';

  @override
  String get welcomeStart => 'LOSLEGEN';

  @override
  String onbStep(int i, int n) {
    return 'SCHRITT $i VON $n';
  }

  @override
  String get onbNameTitle => 'Wie sollen wir dich nennen?';

  @override
  String get onbNameHint => 'Dein Name';

  @override
  String get onbPhotoAdd => 'Foto hinzufügen';

  @override
  String get onbPhotoChange => 'Foto ändern';

  @override
  String get onbPhotoTitle => 'Gib deinem Profil ein Gesicht';

  @override
  String get onbPhotoWhy =>
      'Optional. Es bleibt auf deinem Handy und du kannst es jederzeit im Profil ändern.';

  @override
  String get onbPhotoLater => 'SPÄTER';

  @override
  String get onbNameWhy => 'Wird nur zur Begrüßung verwendet und verlässt das Handy nie.';

  @override
  String get onbBodyTitle => 'Ein paar Zahlen';

  @override
  String get onbBodyWhy =>
      'Sie versorgen die Rechner mit Daten. Du kannst sie jederzeit in den Einstellungen ändern.';

  @override
  String get onbGoalTitle => 'Wie oft trainierst du?';

  @override
  String get onbGoalWhy => 'Legt deinen wöchentlichen Zielring fest. Sei ehrlich, nicht ehrgeizig.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings pro Woche',
      one: '$n Training pro Woche',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Kilo oder Pfund?';

  @override
  String get next => 'WEITER';

  @override
  String get back => 'ZURÜCK';

  @override
  String get skip2 => 'Überspringen';

  @override
  String get madeWithLoveBy => 'MIT LIEBE GEMACHT VON';

  @override
  String get sourceCode => 'QUELLCODE';

  @override
  String get suggested => 'VORGESCHLAGEN';

  @override
  String get results => 'ERGEBNISSE';

  @override
  String get noMatches => 'Keine Übung passt zu dieser Suche.';

  @override
  String get tapToEdit =>
      'Tippe auf den Stift, um einen Eintrag zu korrigieren, oder auf den Papierkorb, um ihn zu entfernen.';

  @override
  String get editEntry => 'Bearbeiten';

  @override
  String get editEntryHint => 'Korrigiere die Wiederholungen oder das Gewicht eines Satzes.';

  @override
  String get removeSet => 'Satz entfernen';

  @override
  String get continueWorkout => 'WEITER';

  @override
  String get continueWorkoutBody =>
      'Das Training wird fortgesetzt und die Sätze bleiben markiert. Wenn du es erneut beendest, wird es am ursprünglichen Tag gespeichert.';

  @override
  String get addBodyWidget => 'Muskelkarten-Widget hinzufügen';

  @override
  String get repsOnly => 'Nur Wiederholungen';

  @override
  String get repsOnlyHint => 'Protokolliere diese Übung ohne Gewicht.';

  @override
  String get eachSide => 'Jede Seite';

  @override
  String get eachSideHint => 'Der Timer läuft einmal pro Seite, die Pause beginnt nach beiden.';

  @override
  String get useDefaultArt => 'Zur Standardgrafik zurückkehren';

  @override
  String daysShort(int n) {
    return '${n}d';
  }

  @override
  String get focusCard => 'Heutiger Fokus';

  @override
  String get autoAdvance => 'Automatisch fortfahren';

  @override
  String get keepScreenOn => 'Bildschirm beim Training anlassen';

  @override
  String get lockWorkout => 'Bildschirm sperren';

  @override
  String get unlockWorkout => 'Entsperren';

  @override
  String get holdToUnlock => 'Zum Entsperren gedrückt halten';

  @override
  String get liveChannel => 'Laufendes Training';

  @override
  String get liveChannelWhy => 'Zeigt Übung, Satz und Pausentimer, während du trainierst';

  @override
  String liveSet(int n, int total) {
    return 'Satz $n von $total';
  }

  @override
  String get liveResting => 'Pause';

  @override
  String get liveAllDone => 'Alle Sätze erledigt';

  @override
  String get autoAdvanceHint => 'Nach dem letzten Satz weiter';

  @override
  String get placePlates => 'Scheiben und Stange';

  @override
  String get platesAll => 'Alles Verfügbare';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Größen', one: '$n Größe');
    return '$_temp0';
  }

  @override
  String get platePairs => 'PAARE';

  @override
  String plateAchievable(String w) {
    return 'Nächstmögliche Beladung: $w';
  }

  @override
  String get autoWarmup => 'Mit Aufwärmsätzen beginnen';

  @override
  String get autoWarmupHint => 'Fügt beim Öffnen des Trainings die Aufwärmsätze hinzu.';

  @override
  String get trainReminder => 'Trainingserinnerung';

  @override
  String get trainReminderHint =>
      'Eine Erinnerung zu dieser Zeit, nur an den Tagen, an denen dein Trainingsplan vorgesehen ist.';

  @override
  String get reminderExactTime => 'Genaue Uhrzeit';

  @override
  String get toastSoundSetting => 'Ton bei Hinweisen';

  @override
  String get toastSoundHint => 'Ein sanfter Ton bei jedem Hinweis';

  @override
  String get notifTrainChannel => 'Trainingserinnerung';

  @override
  String get notifTrainChannelWhy => 'Eine Erinnerung zum Trainieren an den geplanten Tagen.';

  @override
  String get notifTrainTitle => 'Zeit zu trainieren';

  @override
  String get notifTrainBody => 'Dein Trainingsplan wartet.';

  @override
  String get planIntro => 'Erstelle mir einen Trainingsplan, der nur die Übungen aus dieser Liste verwendet.';

  @override
  String get planFormat => 'Antworte ausschließlich mit JSON in dieser Form:';

  @override
  String get planNothing => 'Keine Übung aus dieser Datei passt zu deiner Bibliothek';

  @override
  String get planFailed => 'Diese Datei ist kein lesbarer Trainingsplan';

  @override
  String get routineGroup => 'Gruppe';

  @override
  String get newGroup => 'Neue Gruppe';

  @override
  String get noGroup => 'Keine Gruppe';

  @override
  String get groupNameHint => 'Drücken / Ziehen / Beine, 5×5…';

  @override
  String get filters => 'Filter';

  @override
  String get setsPlannedHint =>
      'Wähle, wie viele Sätze du von jeder Übung möchtest. Beim Öffnen des Trainings sind sie bereits vorbereitet.';

  @override
  String get nextTime => 'NÄCHSTES MAL';

  @override
  String get nextHold => 'gleiches Gewicht, bis du jede Wiederholung schaffst';

  @override
  String get bgPhoto => 'Dein Foto';

  @override
  String get bgPhotoPick => 'Foto auswählen';

  @override
  String get bgPhotoChange => 'Foto ändern';

  @override
  String get bgPhotoRemove => 'Foto entfernen';

  @override
  String get bgDim => 'WIE DUNKEL';

  @override
  String get dimSoft => 'Sanft';

  @override
  String get dimMedium => 'Mittel';

  @override
  String get dimStrong => 'Stark';

  @override
  String get bgPhotoHint => 'Es ist gedimmt hinter allem, damit die App lesbar bleibt.';

  @override
  String get reminderSmart => 'Intelligent';

  @override
  String get reminderFixed => 'Feste Zeit';

  @override
  String get reminderSmartHint =>
      'Verwendet die Tage und die Zeit, zu denen du tatsächlich trainierst, und bleibt an einem bereits absolvierten Trainingstag ruhig.';

  @override
  String get reminderSmartEmpty =>
      'Protokolliere noch ein paar Trainings, dann lernt die Funktion deine Tage.';

  @override
  String habitFocus(String day) {
    return 'was du normalerweise am $day trainierst';
  }

  @override
  String get duplicateRoutine => 'Trainingsplan duplizieren';

  @override
  String copySuffix(String name) {
    return '$name (Kopie)';
  }

  @override
  String get saveAsRoutine => 'ALS TRAININGSPLAN SPEICHERN';

  @override
  String get savedAsRoutine => 'Als Trainingsplan gespeichert';

  @override
  String get templates => 'Fertige Trainingspläne';

  @override
  String get templatesHint =>
      'Klassische Programme aus deiner eigenen Bibliothek. Du kannst danach alles ändern.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainingspläne hinzugefügt',
      one: '$n Trainingsplan hinzugefügt',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Drei Ganzkörpertage pro Woche. Der beste Einstieg.';

  @override
  String get tplPpl => 'Drücken, Ziehen und Beine. Drei oder sechs Tage pro Woche.';

  @override
  String get tplArnold => 'Brust und Rücken, Schultern und Arme, Beine. Der klassische Sechs-Tage-Split.';

  @override
  String get tplUpperlower => 'Ober- und Unterkörper, vier Tage pro Woche.';

  @override
  String get tplStronglifts => 'Zwei Trainings, abwechselnd fünf Sätze mit fünf Wiederholungen.';

  @override
  String get tplStartingstrength => 'Kniebeugen in jedem Training, zwei abwechselnde Trainings.';

  @override
  String get tplHome => 'Nichts außer einer Klimmzugstange und dem Boden.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Tage', one: '$n Tag');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Anstrengung protokollieren (RPE)';

  @override
  String get rpeHint =>
      '10 bedeutet, dass keine Wiederholung mehr möglich ist; bei 8 bleiben zwei Wiederholungen übrig.';

  @override
  String get superset => 'Supersatz';

  @override
  String get supersetLink => 'Mit der nächsten Übung verknüpfen';

  @override
  String get supersetUnlink => 'Von der nächsten Übung trennen';

  @override
  String get supersetHint => 'Keine Pause zwischen verknüpften Übungen, du gehst direkt zur nächsten.';

  @override
  String get aiRoutine => 'Trainingsplan mit KI';

  @override
  String get aiIntro =>
      'GymMane spricht nie mit einer KI. Du exportierst deine Übungsliste, fügst sie in einen Assistenten deiner Wahl ein und importierst dessen Antwort wieder. Dein Handy sendet von selbst nichts nach außen.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Namen waren nicht in deiner Bibliothek',
      one: '1 Name war nicht in deiner Bibliothek',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Welche Apps gelesen werden';

  @override
  String get importOtherCsv => 'Jede andere CSV mit Datum, Übung, Wiederholungen und Gewicht';

  @override
  String get importAskApp => 'Du brauchst eine andere App? Frag danach';

  @override
  String get awardFirstStepName => 'Erster Schritt';

  @override
  String get awardFirstStepLine => 'Willkommen bei GymMane. Das hier geht aufs haus.';

  @override
  String get awardFirstWorkoutName => 'Erstes Training';

  @override
  String get awardFirstWorkoutLine => 'Das erste Training ist protokolliert. Das war der schwierige Teil.';

  @override
  String get awardFirstRoutineName => 'Erster Trainingsplan';

  @override
  String get awardFirstRoutineLine => 'Du hast jetzt einen Plan, zu dem du zurückkehren kannst.';

  @override
  String get awardFirstRecordName => 'Erster Rekord';

  @override
  String get awardFirstRecordLine => 'Du hast deine Bestleistung bei einer Übung übertroffen.';

  @override
  String get awardStreak3Name => 'Drei hintereinander';

  @override
  String get awardStreak3Line => 'Drei Tage am Stück. So beginnt es.';

  @override
  String get awardTonne1Name => 'Eine Tonne';

  @override
  String get awardTonne1Line => 'Über deine Sätze hast du tausend Kilo bewegt.';

  @override
  String get awardSets100Name => 'Hundert Sätze';

  @override
  String get awardSets100Line => 'Hundert Sätze geschafft, einen nach dem anderen.';

  @override
  String get awardHours10Name => 'Zehn Stunden';

  @override
  String get awardHours10Line => 'Zehn Stunden Training auf der Uhr.';

  @override
  String get awardWorkouts50Name => 'Fünfzig Trainings';

  @override
  String get awardWorkouts50Line => 'Fünfzig Trainings liegen hinter dir.';

  @override
  String get awardHours50Name => 'Fünfzig Stunden';

  @override
  String get awardHours50Line => 'Fünfzig Stunden im Fitnessstudio.';

  @override
  String get awardsTitle => 'Medaillen';

  @override
  String get yearTitle => 'Dein Jahr';

  @override
  String get yearBestMonth => 'Bester Monat';

  @override
  String get yearMonths => 'Monate';

  @override
  String get awardSpinHint => 'Ziehe die Medaille, um sie zu drehen';

  @override
  String get awardUnlocked => 'Neue Auszeichnung freigeschaltet';

  @override
  String get awardNice => 'Großartig!';

  @override
  String get awardSaveImage => 'Bild speichern';

  @override
  String get awardSaved => 'In deiner Galerie gespeichert';

  @override
  String get awardStreak7Name => 'Sieben Tage';

  @override
  String get awardStreak7Line => 'Eine volle Woche ohne einen Tag auszulassen.';

  @override
  String get awardStreak30Name => 'Dreißig Tage';

  @override
  String get awardStreak30Line => 'Ein ganzer Monat. Das ist jetzt eine Gewohnheit.';

  @override
  String get awardWorkouts100Name => 'Einhundert Trainings';

  @override
  String get awardWorkouts100Line => 'Einhundert Trainings von Anfang bis Ende protokolliert.';

  @override
  String get awardTonnes100Name => 'Einhundert Tonnen';

  @override
  String get awardTonnes100Line => 'Alles, was du gehoben hast, ergibt zusammen 100.000 kg.';

  @override
  String get awardSets1000Name => 'Tausend Sätze';

  @override
  String get awardSets1000Line => 'Ein Satz nach dem anderen, tausend davon.';

  @override
  String get profile => 'Profil';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get pickBadge => 'Abzeichen';

  @override
  String get statWorkouts => 'Trainings';

  @override
  String get statTrained => 'Trainiert';

  @override
  String get statSets => 'Sätze';

  @override
  String get statLifted => 'Gehoben';

  @override
  String get statStreak => 'Serie';

  @override
  String get statDays => 'Tage';

  @override
  String get unitHours => 'h';

  @override
  String get unitDays => 'Tage';

  @override
  String get snapshots => 'Fotos';

  @override
  String get snapNow => 'Aufnehmen';

  @override
  String get addCover => 'Titelbild hinzufügen';

  @override
  String get addTodayWidget => 'Heute erledigt oder nicht';

  @override
  String get photosCard => 'Deine Fotos';

  @override
  String get handleLabel => 'Benutzername';

  @override
  String get setupTitle => 'Fülle diese Angaben aus, der Rest der Seite füllt sich automatisch';

  @override
  String get setupHint => 'Jede Zahl hier stammt aus deinen Protokollen. Nichts wird irgendwohin gesendet.';

  @override
  String get setupWorkout => 'Erstes Training protokollieren';

  @override
  String get setupWeight => 'Körpergewicht eintragen';

  @override
  String get setupMeasures => 'Deine Maße nehmen';

  @override
  String get setupPhoto => 'Erstes Fortschrittsfoto aufnehmen';

  @override
  String get progressTitle => 'Fortschritt';

  @override
  String get tileVolume30 => 'Volumen · 30 Tage';

  @override
  String get tileAddWeight => 'Deins hinzufügen';

  @override
  String get heatToneTitle => 'Heat-Farbe';

  @override
  String get heatToneHint => 'Ändert nur, wie Raster und Körper eingefärbt werden.';

  @override
  String get thisWeekTitle => 'Diese Woche';

  @override
  String get momentsEmptyTitle => 'Noch nichts hier';

  @override
  String get deletePhotoTitle => 'Dieses Foto löschen?';

  @override
  String get deletePhotoBody => 'Es wird endgültig gelöscht.';

  @override
  String get awardsEarned => 'Verdient';

  @override
  String get awardsLocked => 'Gesperrt';

  @override
  String get awardStreak100Name => 'Einhundert Tage';

  @override
  String get awardWorkouts10Name => 'Zehn Trainings';

  @override
  String get awardWorkouts10Line => 'Die ersten Zehn entscheiden.';

  @override
  String get awardWorkouts365Name => 'Dreihundertfünfundsechzig';

  @override
  String get awardWorkouts365Line => 'Ein Training für jeden Tag eines Jahres, einzeln protokolliert.';

  @override
  String get awardTonnes10Name => 'Zehn Tonnen';

  @override
  String get awardTonnes10Line => 'Zehntausend Kilo sind durch deine Hände gegangen.';

  @override
  String get awardHours100Name => 'Einhundert Stunden';

  @override
  String get awardHours100Line => 'Einhundert Stunden unter der Hantel, mit der Stoppuhr in der Hand.';

  @override
  String awardWonOn(String date) {
    return 'Verdient am $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Gold',
      'blue': 'Blau',
      'green': 'Grün',
      'other': 'Abzeichen',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Dabei seit $date';
  }

  @override
  String levelShort(int n) {
    return 'Stufe $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings bis Stufe $next',
      one: '1 Training bis Stufe $next',
    );
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n cm';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'Rot',
      'green': 'Grün',
      'blue': 'Blau',
      'mono': 'Grau',
      'other': 'Farbe',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n Sätze';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n von $goal diese Woche';
  }

  @override
  String momentCount(int n) {
    return '$n Fotos';
  }

  @override
  String photosSelected(int n) {
    return '$n ausgewählt';
  }

  @override
  String deletePhotosTitle(int n) {
    return '$n Fotos löschen?';
  }

  @override
  String get momentsEmptyHint =>
      'Fotografiere das Fitnessstudio, das Whiteboard, eine Scheiben-Kombination. Alles, woran du dich erinnern möchtest. Die Fotos bleiben auf dem Handy und nur du kannst sie sehen.';

  @override
  String get awardStreak100Line =>
      'Einhundert Tage am Stück. Das ist keine Motivation mehr, das bist einfach du.';

  @override
  String get coverLabel => 'TITELBILD';

  @override
  String get removeCover => 'Titelbild entfernen';

  @override
  String get startTitle => 'Training starten';

  @override
  String get logTitle => 'Training protokollieren';

  @override
  String get logHint => 'Kein Timer, trage einfach ein, was du gemacht hast.';

  @override
  String get orStartFrom => 'Oder beginne mit';

  @override
  String get pickExercisesOption => 'Übungen auswählen';

  @override
  String get chooseFocusOption => 'Fokus auswählen';

  @override
  String get plannedRoutine => 'GEPLANT';

  @override
  String get logWorkoutAction => 'TRAINING PROTOKOLLIEREN';

  @override
  String get logging => 'PROTOKOLLIEREN';

  @override
  String get placesLabel => 'Meine Orte';

  @override
  String get undo => 'Rückgängig';

  @override
  String get deleteSet => 'Satz löschen';

  @override
  String get setDeleted => 'Satz gelöscht';

  @override
  String get removeWarmup => 'Aufwärmen entfernen';

  @override
  String get addWeightAction => 'Gewicht hinzufügen';

  @override
  String get workoutOverview => 'Dieses Training';

  @override
  String get allExercisesShort => 'Alle';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total Sätze';
  }

  @override
  String get nowLabel => 'Jetzt';

  @override
  String get deleteWorkout => 'Training löschen';

  @override
  String get deleteWorkoutBody => 'Dieses Training und alle seine Sätze werden aus deinem Verlauf entfernt.';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeAutoHint => 'Wie das Handy';

  @override
  String get demoSizeTitle => 'Übungsdemo beim Training';

  @override
  String get demoLarge => 'Groß';

  @override
  String get demoSmall => 'Klein';

  @override
  String get demoOff => 'Aus';

  @override
  String get demoLoopTitle => 'Demo-Animation';

  @override
  String get demoLoopAlways => 'Endlos';

  @override
  String get demoLoopShort => '10 Sekunden';

  @override
  String get demoLoopHint =>
      'Läuft etwa 10 Sekunden und bleibt in der Ausgangsposition stehen. Tippe auf die Demo, um sie erneut anzusehen.';

  @override
  String get alarmStyleTitle => 'Wenn die Pause endet';

  @override
  String get alarmStyleLoud => 'Immer klingeln';

  @override
  String get alarmStyleQuiet => 'Lautlos beachten';

  @override
  String get alarmStyleVibrate => 'Nur vibrieren';

  @override
  String get alarmStyleHint =>
      '„Immer klingeln“ nutzt die Weckerlautstärke, auch im Lautlos-Modus. „Lautlos beachten“ nutzt die Benachrichtigungslautstärke und vibriert nur, wenn dein Handy stumm ist.';

  @override
  String get suggestedPicks => 'Vorschläge für dich';

  @override
  String get moreOptions => 'Weitere Optionen';

  @override
  String get suggestInWorkouts => 'In schnellen Trainings vorschlagen';

  @override
  String get suggestInWorkoutsHint =>
      'Aus: Die Übung taucht nicht mehr in den Vorschlägen auf. Von Hand hinzufügen kannst du sie trotzdem.';

  @override
  String get onbPlaceTitle => 'Wo trainierst du?';

  @override
  String get onbPlaceWhy =>
      'Wähle alle Orte, an denen du trainierst. Wir schlagen nur vor, was du dort jeweils machen kannst.';

  @override
  String get onbPlaceGear => 'Was hast du dort?';

  @override
  String distanceCol(String unit) {
    return 'DISTANZ ($unit)';
  }

  @override
  String get timeCol => 'ZEIT';

  @override
  String get timePerSideCol => 'ZEIT / SEITE';

  @override
  String get timeMinutesTitle => 'Zeit (Minuten)';

  @override
  String get timeSecondsTitle => 'Zeit (Sekunden)';

  @override
  String distanceTitle(String unit) {
    return 'Distanz ($unit)';
  }

  @override
  String get holdLabel => 'Halten';

  @override
  String get stopLabel => 'Stopp';

  @override
  String startHold(String time) {
    return 'Start · $time';
  }

  @override
  String get exerciseTypeLabel => 'Erfassen nach';

  @override
  String get typeReps => 'Wdh. & Gewicht';

  @override
  String get typeTime => 'Zeit';

  @override
  String get typeCardio => 'Distanz & Zeit';

  @override
  String get exerciseTypeHint =>
      'Cardio wie Laufen oder Schwimmen erfasst Distanz und Zeit. Halteübungen wie der Plank nur die Zeit.';

  @override
  String get howToLabel => 'Ausführung (optional)';

  @override
  String get howToHint => 'Ein Schritt pro Zeile';

  @override
  String get editExercise => 'Übung bearbeiten';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get noStepsYet =>
      'Noch keine Schritte. Schreib deine eigenen auf, damit du dich erinnerst, wie du sie machst.';

  @override
  String get addSteps => 'Schritte schreiben';

  @override
  String get setTypeRestPause => 'Rest-Pause';

  @override
  String get setTypeNormalInfo => 'Ein normaler Satz. Zählt für dein Volumen und deine Rekorde.';

  @override
  String get setTypeWarmupInfo => 'Leichte Sätze zum Aufwärmen. Zählen nicht für Volumen oder Rekorde.';

  @override
  String get setTypeDropInfo => 'Direkt nach dem Satz das Gewicht senken und ohne Pause weitermachen.';

  @override
  String get setTypeFailureInfo =>
      'Weitermachen, bis keine saubere Wiederholung mehr geht. Trag die Wiederholungen ein, die du wirklich geschafft hast.';

  @override
  String get setTypeRestPauseInfo =>
      'Nach dem Satz 10 bis 20 Sekunden Pause, dann noch ein paar Wiederholungen herausholen.';

  @override
  String get planFormatNotes =>
      'Verwende die Übungsnamen genau wie in der Liste. \"sets\", \"reps\", \"weight\" (in der angegebenen Einheit), \"rest\" in Sekunden und \"days\" sind optional. \"superset\": true verbindet eine Übung mit der nächsten. Für mehrere Wochen gruppiere die Routinen in \"weeks\" wie im zweiten Beispiel.';

  @override
  String get planSets => 'Sätze planen';

  @override
  String get planSetsHint =>
      'Wähle Typ, Wiederholungen und Gewicht jedes Satzes. Lass das Gewicht auf Auto, um bei deiner letzten Einheit anzuknüpfen.';

  @override
  String get planHintReps =>
      'Wähle Typ und Wiederholungen jedes Satzes. Auto knüpft an deine letzte Einheit an.';

  @override
  String get planHintTime => 'Wähle Typ und Zeit jedes Satzes. Auto knüpft an deine letzte Einheit an.';

  @override
  String get planHintTimeWeight =>
      'Wähle Typ, Zeit und Gewicht jedes Satzes. Auto knüpft an deine letzte Einheit an.';

  @override
  String get planHintCardio => 'Wähle Distanz und Zeit jedes Satzes. Auto knüpft an deine letzte Einheit an.';

  @override
  String get timeOnly => 'Nur Zeit';

  @override
  String get autoValue => 'Auto';

  @override
  String get clearPlan => 'Plan löschen';

  @override
  String get shareRoutine => 'Routine teilen';

  @override
  String get shareWeek => 'Meine Woche teilen';

  @override
  String get shareWeekHint => 'Alle deine Routinen und an welchem Tag sie jeweils sind.';

  @override
  String shareMessage(String name) {
    return '$name: öffne die Datei mit GymMane, um sie hinzuzufügen.';
  }

  @override
  String get importRoutines => 'Routinen importieren';

  @override
  String get importPasteHint =>
      'Füge hier eine Routine ein: aus GymMane geteilt, eine KI-Antwort, JSON oder CSV.';

  @override
  String get pasteAction => 'Einfügen';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Routinen', one: '1 Routine');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Auch den Wochenplan übernehmen';

  @override
  String get useTheirScheduleHint => 'Die mitgebrachten Tage ersetzen, was du an ihnen geplant hast.';

  @override
  String get addToMyRoutines => 'Zu meinen Routinen hinzufügen';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Routinen hinzugefügt',
      one: '1 Routine hinzugefügt',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Hier ist nichts, was GymMane importieren kann';

  @override
  String get aiStepCopy =>
      'Kopiere die Anfrage. Sie enthält deine Übungsliste und das Format, das GymMane liest.';

  @override
  String get aiStepAsk =>
      'Füge sie in eine beliebige KI ein und sag, was du willst: Tage pro Woche, Ziel, wie viele Wochen.';

  @override
  String get aiStepPaste => 'Füge die Antwort unten ein und importiere sie. Keine Datei nötig.';

  @override
  String get copyForAi => 'Für die KI kopieren';

  @override
  String get copiedDone => 'Kopiert';

  @override
  String get aiPasteHint => 'Füge hier die Antwort der KI ein';

  @override
  String get importAction => 'Importieren';

  @override
  String get showFormat => 'Format ansehen';

  @override
  String get shareAsFile => 'Als Datei teilen';

  @override
  String get recoveryTab => 'Erholung';

  @override
  String recoveryOverall(int pct) {
    return 'Körper zu $pct % erholt';
  }

  @override
  String get recoveryAllFresh => 'Alles ist erholt. Guter Tag, um alles zu trainieren.';

  @override
  String recoveryStill(String muscles) {
    return 'Erholt sich noch: $muscles';
  }

  @override
  String get recoveryTired => 'Ermüdet';

  @override
  String get recoveryFresh => 'Frisch';

  @override
  String get recoveryHint =>
      'Tippe auf einen Muskel, um zu sehen, wie erholt er ist. Frische Sätze zählen mehr, harte (nach RPE) noch mehr.';

  @override
  String recoveryPct(int pct) {
    return 'zu $pct % erholt';
  }

  @override
  String readyInHours(int h) {
    return 'bereit in ~$h Std.';
  }

  @override
  String get tplAbcd => 'Vier Tage: Brust und Trizeps, Rücken und Bizeps, Beine, Schultern und Bauch.';

  @override
  String get tplAbcde => 'Fünf Tage, je eine Muskelgruppe: Brust, Rücken, Beine, Schultern, Arme.';

  @override
  String get elapsedCaps => 'VERSTRICHEN';

  @override
  String get tapToChange => 'Tippen zum Ändern';

  @override
  String get swipeToSkipHint => 'Wische den Timer zur Seite, um die Pause zu überspringen.';

  @override
  String get screenLocked => 'Bildschirm gesperrt';

  @override
  String get lockedHint => 'Halte den Fingerabdruck oben gedrückt, um zu entsperren';

  @override
  String get liveDoneSet => 'Satz fertig';

  @override
  String get liveSkipRest => 'Pause überspringen';

  @override
  String get livePause => 'Pausieren';

  @override
  String get liveResume => 'Fortsetzen';

  @override
  String get liveNext => 'Weiter';

  @override
  String liveUpNext(String name) {
    return 'Danach: $name';
  }

  @override
  String get stickerOpen => 'Auf einem Foto teilen';

  @override
  String get stickerNoPhoto => 'Ohne Foto';

  @override
  String get stickerWorkout => 'Training';

  @override
  String get stickerStreak => 'Serie';

  @override
  String get stickerDate => 'Datum';

  @override
  String get stickerHint => 'Zum Verschieben ziehen, mit zwei Fingern skalieren oder drehen';

  @override
  String get stickerSaved => 'In der Galerie gespeichert';

  @override
  String get stickerWeek => 'Diese Woche';

  @override
  String get getReady => 'Mach dich bereit';

  @override
  String sideOfTwo(String n) {
    return 'Seite $n von 2';
  }

  @override
  String get switchSides => 'Seite wechseln';

  @override
  String get stickerGallery => 'Galerie';

  @override
  String get stickerCamera => 'Kamera';

  @override
  String get shareIntroTitle => 'Teile diesen Plan';

  @override
  String get shareIntroBody =>
      'Schick ihn deinem Partner, einem Freund oder deiner Familie. Sie bekommen eine kleine Datei, die sich in GymMane öffnet und ihn mit einem Tipp hinzufügt, samt Sätzen und Gewichten.';

  @override
  String get removedFromRoutine => 'Aus dem Plan entfernt';

  @override
  String get radarTitle => 'Letzte 30 Tage';

  @override
  String get radarHint => 'Sieh, welche Bereiche mehr Arbeit brauchen';

  @override
  String get radarEmpty => 'Trainiere ein paar Tage, um deine Balance zu sehen';

  @override
  String get radarBalanced => 'Bisher gut ausgewogen';

  @override
  String radarFocus(String list) {
    return 'Braucht mehr: $list';
  }

  @override
  String get countdownReady => 'Mach dich bereit';

  @override
  String get countdownSkip => 'Tippen, um sofort zu starten';

  @override
  String get countdownSetting => 'Countdown vor dem Start';

  @override
  String get effortSetting => 'Anstrengung notieren';

  @override
  String get effortHint =>
      'RPE: 10 heißt, keine Wiederholung mehr, 8 heißt, zwei wären noch gegangen. RIR zählt die Wiederholungen, die übrig waren. Hat ein Satz einen Wert, nutzt das geschätzte 1RM die RPE-Tabelle.';

  @override
  String get rirHint => '0 heißt, keine Wiederholung mehr, 2 heißt, zwei wären noch gegangen.';

  @override
  String get addWeekWidget => 'Wochen-Widget hinzufügen';

  @override
  String get gamificationSetting => 'Medaillen und Stufen';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Wdh.', one: '$n Wdh.');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Bester Satz';

  @override
  String get weekStartSetting => 'Woche beginnt am';

  @override
  String get stepOutOfWorkout => 'Pausieren und verlassen';

  @override
  String get saveToRoutine => 'ÄNDERUNGEN IM TRAININGSPLAN SPEICHERN';

  @override
  String get routineUpdated => 'Trainingsplan aktualisiert';

  @override
  String saveChangesTitle(String name) {
    return 'Änderungen in $name speichern?';
  }

  @override
  String get saveChangesBody =>
      'Wenn du ihn das nächste Mal startest, hat der Trainingsplan diese Änderungen.';

  @override
  String get routineOrderChanged => 'Neue Reihenfolge der Übungen';

  @override
  String get mineOnly => 'Von dir erstellt';

  @override
  String createNamed(String name) {
    return 'Nicht dabei? „$name“ erstellen';
  }

  @override
  String get orStartWith => 'Oder starte mit';

  @override
  String get warmupFocus => 'Aufwärmen';

  @override
  String get warmupFocusHint => 'Mobilität und Aktivierung, mit oder ohne Geräte';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Laufen, Rad, Rudern oder Seilspringen, nach Strecke und Zeit';

  @override
  String get homeRecommended => 'Empfehlungen auf der Startseite';

  @override
  String get homeRoutines => 'Routinen auf der Startseite';

  @override
  String get homeRoutinesHint => 'Zuletzt gemacht zuerst';

  @override
  String get homeWeekStats => 'Diese Woche auf der Startseite';

  @override
  String get homeWeekStatsHint => 'Volumen, Sätze und PRs der Woche';

  @override
  String get stepsSetting => 'Schritte aus Health Connect';

  @override
  String get stepsSettingHint => 'Heutige Schritte auf Start';

  @override
  String get stepsToday => 'Schritte heute';

  @override
  String stepsOfGoal(String goal) {
    return 'von $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count Schritte heute';
  }

  @override
  String get stepsGoal => 'Tägliches Schrittziel';

  @override
  String get stepsNoAccess => 'Kein Zugriff auf deine Schritte';

  @override
  String get stepsGrant => 'Tippe, um es in Health Connect zu erlauben';

  @override
  String get stepsInfoRead =>
      'Liest nur deine Schrittzahl. Liest nie etwas anderes und schreibt nichts in Health Connect.';

  @override
  String get stepsInfoLocal =>
      'Deine Schritte bleiben auf deinem Handy. GymMane verbindet sich nie mit dem Internet.';

  @override
  String get stepsInfoOff => 'Jederzeit abschaltbar, in den Einstellungen oder in Health Connect.';

  @override
  String get stepsManage => 'Berechtigung verwalten';

  @override
  String get routineDoneToday => 'Für heute erledigt · stark';

  @override
  String get trainAgain => 'Nochmal trainieren';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Vor $n Tagen',
      one: 'Gestern gemacht',
      zero: 'Heute gemacht',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Archiviert';

  @override
  String get archiveExercise => 'Übung archivieren';

  @override
  String get restoreExercise => 'Wiederherstellen';

  @override
  String get archivedToast => 'Übung archiviert';

  @override
  String get archivedToastHint => 'Du findest sie unter Übungen › Archiviert';

  @override
  String get archivedBanner =>
      'Archiviert. Sie erscheint nicht in Listen und Vorschlägen; dein Verlauf bleibt erhalten.';

  @override
  String get videoMarksHint =>
      'Pausiere bei einem Schritt und tippe auf die Nadel, um nächstes Mal dorthin zu springen.';

  @override
  String get videoMarkHere => 'Diesen Schritt hier markieren';

  @override
  String get sectionGeneral => 'Allgemein';

  @override
  String get sectionTraining => 'Training';

  @override
  String get sectionAlerts => 'Erinnerungen & Alarm';

  @override
  String get sectionHome => 'Startseite';

  @override
  String get sectionWidgets => 'Widgets';

  @override
  String get sectionData => 'Daten & Sicherung';

  @override
  String get multiPlanSetting => 'Mehrere Pläne pro Tag';

  @override
  String get multiPlanHint =>
      'Tippe jeden Plan für diesen Tag an. Sie laufen in der Reihenfolge, in der du sie hinzufügst.';

  @override
  String routineOfDay(int n, int total) {
    return '$n von $total heute';
  }

  @override
  String get nextToday => 'Als Nächstes heute';

  @override
  String get planAboutMe => 'Über mich:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age Jahre, $height groß, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Ich möchte $n Tage pro Woche trainieren.';
  }

  @override
  String get planNoHistory =>
      'Noch keine Trainings erfasst: Behandle mich als Anfänger und halte Volumen und Gewichte vorsichtig.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings in den letzten 30 Tagen.',
      one: '1 Training in den letzten 30 Tagen.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Beste Sätze zuletzt';

  @override
  String get planAskFirst =>
      'Wenn du mein Ziel (Kraft, Muskeln, Fettabbau oder allgemeine Fitness) oder die Dauer einer Einheit nicht kennst, frag mich zuerst in einer kurzen Nachricht. Danach antworte nur mit JSON.';

  @override
  String get backToTop => 'Nach oben';

  @override
  String get deleteExerciseTitle => 'Diese Übung löschen?';

  @override
  String deleteExerciseBody(String name) {
    return '„$name“ wird aus deiner Bibliothek und deinen Plänen entfernt. Deine bisherigen Sätze bleiben erhalten.';
  }

  @override
  String get exportForStravaHint =>
      'Lade die Datei im Browser auf strava.com/upload/select hoch (die Strava-App kann keine Dateien importieren). Sie erscheint als Krafttraining mit deinen Sätzen.';

  @override
  String get manualStartTime => 'Startzeit';

  @override
  String get manualDuration => 'Dauer';

  @override
  String get manualDurationUnset => 'Dauer eintragen';

  @override
  String get stravaRow => 'Zu Strava exportieren (Beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Wähle ein Training für Strava. Du bekommst eine .fit-Datei: Lade sie im Browser auf strava.com/upload/select hoch, dann erscheint sie als Krafttraining mit deinen Sätzen.';

  @override
  String get stravaEmpty => 'Noch keine Trainings zum Exportieren.';

  @override
  String get tapToPause => 'Tippen zum Pausieren';

  @override
  String get holdPausedHint => 'Pausiert · tippen zum Fortsetzen';

  @override
  String get finishHoldNow => 'Satz jetzt beenden';

  @override
  String get barWeightExercise => 'Gewicht von Stange oder Schlitten';

  @override
  String get barWeightHint => 'Wird vom Scheibenrechner genutzt';

  @override
  String get barWeightCustom => 'Eigenes · tippen zum Zurücksetzen';

  @override
  String get groupRename => 'Gruppe umbenennen';

  @override
  String get groupUngroup => 'Gruppe auflösen, Routinen behalten';

  @override
  String get groupDeleteAll => 'Gruppe und Routinen löschen';

  @override
  String groupDeleteTitle(String name) {
    return '„$name“ löschen?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count werden gelöscht. Dein Trainingsverlauf bleibt erhalten.';
  }

  @override
  String get tplRr =>
      'Der Klassiker von r/bodyweightfitness: Ganzkörper an drei Tagen pro Woche. Geh eine Stufe höher, wenn es leicht wird.';

  @override
  String get levelUpKicker => 'NÄCHSTE STUFE';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps bei $name in zwei Trainings hintereinander. Bereit für die nächste Stufe?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'In $routine tauschen';
  }

  @override
  String get levelUpSee => 'So geht\'s';

  @override
  String get levelUpLater => 'Jetzt nicht';

  @override
  String get levelUpStay => 'Bei dieser bleiben';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name ist jetzt in $routine';
  }

  @override
  String get levelUpStayed => 'Keine Stufen-Tipps mehr für diese Übung';

  @override
  String get levelHintsSetting => 'Nächste Stufe vorschlagen';

  @override
  String get heatmapLabelsSetting => 'Tage und Monate in der Aktivitätskarte';

  @override
  String get rmPercent => 'PROZENT';

  @override
  String rmAtPercent(String pct) {
    return '$pct deines Maximums';
  }

  @override
  String get copyWorkout => 'Als Text kopieren';

  @override
  String get goalSet => 'Ziel setzen';

  @override
  String get goalTargetReps => 'ZIEL-WIEDERHOLUNGEN';

  @override
  String goalToGo(String value) {
    return 'Noch $value';
  }

  @override
  String get goalReached => 'Ziel erreicht';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Noch $n Tage', one: 'Noch 1 Tag');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Datum überschritten';

  @override
  String get goalDeadline => 'FRIST';

  @override
  String get goalNoDeadline => 'Keine Frist';

  @override
  String get goalRemove => 'Ziel entfernen';

  @override
  String get exerciseNameMissing => 'Gib ihr einen Namen';

  @override
  String get aliasesLabel => 'Auch genannt (optional)';

  @override
  String get aliasesHint => 'Weitere Namen, durch Kommas getrennt';

  @override
  String alsoCalled(String names) {
    return 'Auch: $names';
  }

  @override
  String get addToRoutine => 'Zum Trainingsplan hinzufügen';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'In $n Trainingsplänen',
      one: 'In 1 Trainingsplan',
      zero: 'Noch in keinem Trainingsplan',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Schon drin';

  @override
  String get restInRoutine => 'Pause in diesem Plan';

  @override
  String get restInRoutineHint => 'Wie bei der Übung';

  @override
  String get restInRoutineReset => 'Nur hier · tippen zum Zurücksetzen';

  @override
  String get swapExercise => 'Übung tauschen';

  @override
  String get swapShort => 'Tauschen';

  @override
  String swapHint(String name) {
    return 'Statt $name, nur heute. Am Ende kannst du sie im Plan behalten.';
  }

  @override
  String get swapKeepsDone => 'Erledigte Sätze bleiben; die neue Übung macht mit dem Rest weiter.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Gleicher Muskel · $muscle';
  }

  @override
  String get swapDoneBefore => 'Schon gemacht';

  @override
  String get multiPlanSettingHint => 'Mehr als ein Plan am selben Wochentag';

  @override
  String get levelHintsHint => 'Schlägt die schwerere Variante vor';

  @override
  String get focusCardHint => 'Der heutige Plan, ganz oben auf der Startseite';

  @override
  String get gamificationHint => 'Medaillen, Level und Jubel';

  @override
  String get exerciseSettings => 'Einstellungen dieser Übung';

  @override
  String get placeActiveNow => 'Du bist hier';

  @override
  String get placeTapToUse => 'tippen, um hier zu trainieren';

  @override
  String get intervalDays => 'Tage';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target Tage';
  }

  @override
  String get toolNameRpe => 'Gewicht nach RPE';

  @override
  String get toolTitleRpe => 'Gewicht nach RPE';

  @override
  String get toolDescRpe => 'Welches Gewicht für die gewünschte Anstrengung';

  @override
  String get toolNameDots => 'Kraftlevel';

  @override
  String get toolTitleDots => 'Kraftlevel (DOTS)';

  @override
  String get toolDescDots => 'Deine Kraft im Verhältnis zum Gewicht';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Für $reps Wdh. bei RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Ein Satz, den du gerade gemacht hast';

  @override
  String get rpeGoal => 'Was du machen willst';

  @override
  String rpeOneRmLine(String value) {
    return 'Geschätztes 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 heißt: keine Wiederholung mehr möglich; 8: zwei wären noch gegangen.';

  @override
  String get dotsBestLifts => 'Deine Bestleistungen';

  @override
  String get dotsSquat => 'KNIEBEUGE';

  @override
  String get dotsBench => 'BANKDRÜCKEN';

  @override
  String get dotsDeadlift => 'KREUZHEBEN';

  @override
  String dotsTotalLine(String value) {
    return 'Gesamt: $value';
  }

  @override
  String get dotsExplain =>
      'Vergleicht deine Kraft mit der von allen, egal wie schwer. Nimm deine beste Einzelwiederholung oder dein geschätztes 1RM.';

  @override
  String get dotsLevel0 => 'Anfänger';

  @override
  String get dotsLevel1 => 'Fortgeschritten';

  @override
  String get dotsLevel2 => 'Erfahren';

  @override
  String get dotsLevel3 => 'Sehr erfahren';

  @override
  String get dotsLevel4 => 'Elite';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks-Punkte';

  @override
  String get toolDescWilks => 'Die klassische Powerlifting-Wertung';

  @override
  String get wilksExplain =>
      'Die klassische Powerlifting-Formel. DOTS hat sie 2020 abgelöst, aber viele Wettkämpfe und Ranglisten nutzen sie noch.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Fettfreie-Masse-Index';

  @override
  String get toolDescFfmi => 'Wie viel Muskel für deine Größe';

  @override
  String get ffmiBodyFat => 'KÖRPERFETT';

  @override
  String ffmiLeanLine(String value) {
    return 'Magermasse: $value';
  }

  @override
  String get ffmiExplain =>
      'Wie der BMI, nur ohne Fett: Er zählt nur deine fettfreie Masse. An deine Größe angepasst, damit Große und Kleine fair verglichen werden.';

  @override
  String get ffmiLevel0 => 'Unterdurchschnittlich';

  @override
  String get ffmiLevel1 => 'Durchschnittlich';

  @override
  String get ffmiLevel2 => 'Überdurchschnittlich';

  @override
  String get ffmiLevel3 => 'Sehr gut';

  @override
  String get ffmiLevel4 => 'Herausragend';

  @override
  String get rpeEffortLabel => 'Anstrengung (RPE)';

  @override
  String get restRowHint => 'Zwischen den Sätzen, außer die Übung hat eine eigene';

  @override
  String get effortRowHint => 'RPE oder RIR bei jedem Satz notieren';

  @override
  String get countdownHint => '3, 2, 1 vor dem ersten Satz';

  @override
  String get keepScreenOnHint => 'Der Bildschirm bleibt beim Training an';

  @override
  String get demoSizeRowHint => 'Die Übungszeichnung während des Trainings';

  @override
  String get demoLoopRowHint => 'Ob die Animation wiederholt oder stoppt';

  @override
  String get trainReminderRowHint => 'Eine Erinnerung an Trainingstagen';

  @override
  String get alarmSoundRowHint => 'Was am Ende der Pause klingt';

  @override
  String get alarmStyleRowHint => 'Ob es im Lautlosmodus klingelt';

  @override
  String get recommendedRowHint => 'Übungen, die wir auf der Startseite vorschlagen';

  @override
  String get weightStepSetting => 'Gewichtsschritt';

  @override
  String get weightStepHint => 'Was die Tasten − und + hinzufügen';

  @override
  String get prBestWorkout => 'Bestes Training';

  @override
  String get mergeExercise => 'Zusammenführen';

  @override
  String mergeExerciseInto(String name) {
    return '$name zusammenführen mit…';
  }

  @override
  String get mergeExerciseTitle => 'Übungen zusammenführen?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Der gesamte Verlauf von „$from“ geht auf „$to“ über. „$from“ bleibt in deiner Bibliothek. Das lässt sich nicht rückgängig machen.';
  }

  @override
  String get mergedToast => 'Verlauf zusammengeführt';

  @override
  String get nutrition => 'Ernährung';

  @override
  String get nutritionHomeEmpty => 'Wasser, Protein und Kalorien';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g Protein';
  }

  @override
  String get nutritionToday => 'Heute';

  @override
  String get nutritionYesterday => 'Gestern';

  @override
  String get nutritionGoals => 'Tagesziele';

  @override
  String get kcalLabel => 'KALORIEN';

  @override
  String get kcalOver => 'drüber';

  @override
  String get waterLabel => 'WASSER';

  @override
  String get waterDone => 'Ziel erreicht';

  @override
  String get waterCustom => 'Andere Menge';

  @override
  String get glassSize => 'Glasgröße';

  @override
  String get supplementsLabel => 'NAHRUNGSERGÄNZUNG';

  @override
  String get supplementsEmpty => 'Tippe eins an, um es hinzuzufügen, oder + für ein eigenes.';

  @override
  String get addSupplement => 'Neues Supplement';

  @override
  String get supplementNameHint => 'Kreatin, Vitamin D…';

  @override
  String removeSupplementTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get removeSupplementBody => 'Die Tage, an denen du es abgehakt hast, werden mit gelöscht.';

  @override
  String get suppCreatine => 'Kreatin';

  @override
  String get suppVitaminD => 'Vitamin D';

  @override
  String get suppOmega3 => 'Omega-3';

  @override
  String get suppMagnesium => 'Magnesium';

  @override
  String get suppMultivitamin => 'Multivitamin';

  @override
  String get suppCaffeine => 'Koffein';

  @override
  String get myFoods => 'Meine Lebensmittel';

  @override
  String get newFood => 'Neues Lebensmittel';

  @override
  String get editFood => 'Lebensmittel bearbeiten';

  @override
  String get foodNameHint => 'Whey, Haferflocken, Brot…';

  @override
  String get servingLabel => 'PORTION';

  @override
  String get servingHint => '1 Messlöffel · 30 g';

  @override
  String get perServing => 'PRO PORTION';

  @override
  String get servingsLabel => 'Portionen';

  @override
  String get foodPhotoHint => 'Auf einfarbigem Hintergrund wird daraus ein Sticker.';

  @override
  String get cutoutWorking => 'Wird ausgeschnitten…';

  @override
  String get cutoutTry => 'Ausschneiden';

  @override
  String get cutoutKeep => 'Ganzes Foto';

  @override
  String deleteFoodTitle(String name) {
    return '$name löschen?';
  }

  @override
  String get deleteFoodBody => 'Es verschwindet aus deinen Lebensmitteln. Bereits Eingetragenes bleibt.';

  @override
  String get mealBreakfast => 'Frühstück';

  @override
  String get mealLunch => 'Mittagessen';

  @override
  String get mealDinner => 'Abendessen';

  @override
  String get mealSnacks => 'Snacks';

  @override
  String get nothingLogged => 'Noch nichts eingetragen.';

  @override
  String addToMeal(String meal) {
    return 'Zu $meal hinzufügen';
  }

  @override
  String get quickAdd => 'Schnell eintragen';

  @override
  String get quickAddHint => 'Nur die Zahlen, ohne ein Lebensmittel zu speichern.';

  @override
  String get quickAddName => 'Was war es? (optional)';

  @override
  String get logFood => 'Eintragen';

  @override
  String loggedToast(String meal) {
    return 'Zu $meal hinzugefügt';
  }

  @override
  String get entryRemoved => 'Entfernt';

  @override
  String get goalsFromProfile => 'Aus meinem Profil berechnen';

  @override
  String get goalsFromProfileHint =>
      'Kalorien aus deinem Profil, 1,8 g Protein und 35 ml Wasser pro kg Körpergewicht.';

  @override
  String get kcalEaten => 'Gegessen';

  @override
  String get kcalRemaining => 'Übrig';

  @override
  String waterTapHint(String amount) {
    return 'Tippe aufs Glas: + $amount';
  }

  @override
  String get shakeEmpty => 'Tippen, um deinen Shake zu wählen';

  @override
  String shakeTapHint(String name) {
    return 'Tippen: + $name';
  }

  @override
  String get shakePick => 'Dein Shake';

  @override
  String get shakePickHint => 'Tippe aufs Glas und er wird in einem Rutsch eingetragen.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'K';

  @override
  String get fatLetter => 'F';

  @override
  String get addBurnedLabel => 'Verbrannte Kalorien addieren';

  @override
  String get addBurnedHint => 'Verbrannte Kalorien werden aus Trainingsdauer und Körpergewicht geschätzt.';

  @override
  String get amountLabel => 'Menge';

  @override
  String amountIn(String unit) {
    return 'Menge ($unit)';
  }

  @override
  String get bodyweightLabel => 'Gewicht';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Lebensmittel kopiert',
      one: '1 Lebensmittel kopiert',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Bereits Eingetragenes bleibt, wie es ist.';

  @override
  String get fiberLabel => 'Ballaststoffe';

  @override
  String get sugarLabel => 'Zucker';

  @override
  String get sodiumLabel => 'Natrium';

  @override
  String get foodDatabase => 'Lebensmittel-Datenbank';

  @override
  String get kcalBurned => 'Verbrannt';

  @override
  String get mealOptions => 'Mahlzeit-Optionen';

  @override
  String get moreNutrients => 'Ballaststoffe, Zucker und Natrium';

  @override
  String ofGoal(int goal, String unit) {
    return 'von $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'pro 100 $unit';
  }

  @override
  String get perServingShort => 'pro Portion';

  @override
  String get foodCategory => 'KATEGORIE';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Stück', one: '1 Stück');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Scheiben',
      one: '1 Scheibe',
    );
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messlöffel',
      one: '1 Messlöffel',
    );
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count EL', one: '1 EL');
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count TL', one: '1 TL');
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Tassen', one: '1 Tasse');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Gläser', one: '1 Glas');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Zuletzt';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Lebensmittel',
      one: '1 Lebensmittel',
    );
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Umbenennen';

  @override
  String get repeatFrom => 'Wiederholen von';

  @override
  String get repeatNone => 'An anderen Tagen ist für diese Mahlzeit noch nichts eingetragen.';

  @override
  String get restDayGoals => 'Andere Ziele an Ruhetagen';

  @override
  String get trainingDays => 'Trainingstage';

  @override
  String get restDays => 'Ruhetage';

  @override
  String get trainingDay => 'Trainingstag';

  @override
  String get saveAsMeal => 'Als Mahlzeit speichern';

  @override
  String get savedMealNameHint => 'z. B. Übliches Frühstück';

  @override
  String get savedMealToast => 'Mahlzeit gespeichert';

  @override
  String get savedMeals => 'Gespeicherte Mahlzeiten';

  @override
  String get searchFoodsHint => 'Lebensmittel suchen';

  @override
  String get searchFoodsEmpty => 'Suche unter über 500 Lebensmitteln mit Foto oder lege eigene an.';

  @override
  String searchFoodsNone(String query) {
    return 'Nichts gefunden für „$query“. Leg es als eigenes Lebensmittel an.';
  }

  @override
  String get servingWeight => 'GRAMM';

  @override
  String get weekAverage => 'Diese Woche';

  @override
  String get weekAvgEnergy => 'Tagesdurchschnitt';

  @override
  String get weekAvgProtein => 'Protein pro Tag';

  @override
  String get weekEnergyOnTarget => 'Kalorien im Ziel';

  @override
  String get weekProteinOnTarget => 'Protein im Ziel';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g Protein pro Tag';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met von $days Tagen im Ziel';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage eingetragen',
      one: '1 Tag eingetragen',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Noch nichts eingetragen';

  @override
  String get weekOnTargetHint =>
      'Im Ziel: Kalorien höchstens 10 % neben dem Ziel und mindestens 90 % des Proteins.';

  @override
  String get weightGoalLabel => 'Zielgewicht';

  @override
  String weightGoalTitle(String unit) {
    return 'Zielgewicht ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Ziel $weight';
  }

  @override
  String get weightGoalNone => 'Gedrückt halten für ein Ziel';

  @override
  String get weightGoalReached => 'Ziel erreicht';

  @override
  String weightToLose(String weight) {
    return 'Noch $weight abnehmen';
  }

  @override
  String weightToGain(String weight) {
    return 'Noch $weight zunehmen';
  }

  @override
  String get aminoHis => 'Histidin';

  @override
  String get aminoIle => 'Isoleucin';

  @override
  String get aminoLeu => 'Leucin';

  @override
  String get aminoLys => 'Lysin';

  @override
  String get aminoSaa => 'Methionin';

  @override
  String get aminoAaa => 'Phenylalanin';

  @override
  String get aminoThr => 'Threonin';

  @override
  String get aminoTrp => 'Tryptophan';

  @override
  String get aminoVal => 'Valin';

  @override
  String get animalProtein => 'Tierisches Protein';

  @override
  String get proteinQuality => 'Proteinqualität';

  @override
  String get qualityComplete => 'Vollständig';

  @override
  String get qualityAlmost => 'Fast vollständig';

  @override
  String get qualityIncomplete => 'Unvollständig';

  @override
  String get qualityNoData => 'Noch keine Daten';

  @override
  String get qualityNoDataHint => 'Trage Lebensmittel aus der Datenbank ein, um deine Aminosäuren zu sehen.';

  @override
  String get qualityAllCovered => 'Alle neun essenziellen Aminosäuren sind abgedeckt.';

  @override
  String qualityLimiting(String amino) {
    return 'Zu wenig $amino. Kombiniere es mit Lebensmitteln, die viel davon haben.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Berechnet mit $pct % deines Proteins: eigene Lebensmittel haben keine Aminosäure-Daten.';
  }

  @override
  String get fatTypes => 'Fettarten';

  @override
  String get fatSaturated => 'Gesättigt';

  @override
  String get fatMono => 'Einfach';

  @override
  String get fatPoly => 'Mehrfach';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Gesättigt $grams g von max. $limit g (10 % der Kalorien)';
  }

  @override
  String get sugarSodium => 'Zucker und Natrium';

  @override
  String get shakeCard => 'Proteinshake';

  @override
  String get mealOther => 'Mahlzeit';

  @override
  String get mealAdd => 'Mahlzeit hinzufügen';

  @override
  String get mealAddHint => 'z. B. Pre-Workout';

  @override
  String get mealsOfDay => 'Mahlzeiten des Tages';

  @override
  String get mealsHint =>
      'Leg so viele an, wie du willst. Löschst du eine, wandert ihr Inhalt in die darüber.';

  @override
  String get trackersTitle => 'Anpassen';

  @override
  String get trackersHint => 'Zeig nur, was du verfolgen willst.';

  @override
  String get trackersDaily => 'Tagesübersicht';

  @override
  String get trackersDetail => 'Im Detail';

  @override
  String get trackersCards => 'Karten';

  @override
  String get prepTitle => 'Meal Prep';

  @override
  String get prepNewShort => 'Neue Charge';

  @override
  String get prepNew => 'Neue Charge';

  @override
  String get prepEdit => 'Charge bearbeiten';

  @override
  String get prepHint => 'Den ganzen Topf einmal eintragen und dann Stück für Stück essen.';

  @override
  String get prepEmpty =>
      'Für mehrere Tage gekocht? Einmal eintragen und dann nur sagen, wie viel vom Rest du gegessen hast.';

  @override
  String get prepNameHint => 'z. B. Hähnchen mit Reis';

  @override
  String get prepDefaultName => 'Charge';

  @override
  String get prepIngredients => 'Zutaten';

  @override
  String get prepAddIngredient => 'Zutat hinzufügen';

  @override
  String get prepCookedWeight => 'GEWICHT GEKOCHT';

  @override
  String prepCookedHint(String grams) {
    return 'Wieg den Topf gekocht für genaue Werte. Leer = Rohgewicht gesamt ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Gib das gekochte Gewicht an: einige Zutaten haben keine Grammangabe.';

  @override
  String prepLeftOf(String left, String total) {
    return '$left übrig von $total';
  }

  @override
  String get prepOfWhatsLeft => '% vom Rest';

  @override
  String get prepAll => 'Alles';

  @override
  String prepLogAmount(String grams) {
    return '$grams eintragen';
  }

  @override
  String get prepWeighLeft => 'Rest wiegen';

  @override
  String get prepFinished => 'Diese Charge ist aufgegessen.';

  @override
  String get approxValues => 'Ungefähr';

  @override
  String get editValues => 'Werte bearbeiten';

  @override
  String get editValuesHint =>
      'Ändert nur diesen Eintrag. Um das Lebensmittel künftig zu korrigieren, bearbeite es unter Meine Lebensmittel.';

  @override
  String get editLibraryHint => 'Wird als eigenes Lebensmittel gespeichert, mit demselben Foto';

  @override
  String per100Line(String energy, String unit) {
    return '$energy pro 100 $unit';
  }

  @override
  String get rawLabel => 'Roh';

  @override
  String get cookedLabel => 'Gekocht';

  @override
  String get rawHint => 'Gewicht vor dem Kochen';

  @override
  String cookedHint(String factor) {
    return 'Gewicht nach dem Kochen (×$factor des Rohgewichts)';
  }

  @override
  String get servingsUnit => 'Portionen';

  @override
  String logAmount(String energy) {
    return 'Eintragen · $energy';
  }

  @override
  String get catFruit => 'Obst';

  @override
  String get catVeg => 'Gemüse';

  @override
  String get catMeat => 'Fleisch';

  @override
  String get catFish => 'Fisch';

  @override
  String get catEgg => 'Eier';

  @override
  String get catDairy => 'Milchprodukte';

  @override
  String get catGrain => 'Getreide';

  @override
  String get catBakery => 'Brot';

  @override
  String get catLegume => 'Hülsenfrüchte';

  @override
  String get catNut => 'Nüsse';

  @override
  String get catOil => 'Öle';

  @override
  String get catPantry => 'Vorrat';

  @override
  String get catDrink => 'Getränke';

  @override
  String get catSauce => 'Soßen';

  @override
  String get catSpice => 'Gewürze';

  @override
  String get searchFoodsPrompt => 'Was hast du gegessen?';

  @override
  String get shelfEmpty =>
      'Such ein Lebensmittel oder fotografier deins: hier erscheinen die, die du am häufigsten einträgst.';

  @override
  String get repeatEntry => 'Nochmal';

  @override
  String get notifSuppChannel => 'Nahrungsergänzung';

  @override
  String get notifSuppChannelWhy => 'Tägliche Erinnerung an deine Supplements';

  @override
  String get energySplit => 'Woher die Kalorien kommen';

  @override
  String get typicalServing => 'Typische Portion';

  @override
  String cookedYieldLine(String factor) {
    return 'Wiegt $factor× so viel wie roh';
  }

  @override
  String get readyDishes => 'Gerichte';

  @override
  String weightLastLine(String weight) {
    return 'Letzte Wägung $weight';
  }

  @override
  String get proteinAnimalShort => 'Tierisch';

  @override
  String get proteinPlantShort => 'Pflanzlich';

  @override
  String kcalFromMacros(String value) {
    return 'Diese Makros ergeben etwa $value';
  }

  @override
  String get useValue => 'Übernehmen';

  @override
  String get suppRowHint => 'Tippen zum Abhaken · halten für Details';

  @override
  String get suppPhoto => 'Foto';

  @override
  String get suppDose => 'Dosis';

  @override
  String get suppDoseHint => '5 g, 2 Kapseln…';

  @override
  String get suppRemind => 'Erinnern';

  @override
  String mealPlanDefault(int n) {
    return 'Plan $n';
  }

  @override
  String get mealPlansTitle => 'Ernährungspläne';

  @override
  String get mealPlanNew => 'Neuer Plan';

  @override
  String fromPlan(String name) {
    return 'Aus $name';
  }

  @override
  String get logPlan => 'Eintragen';

  @override
  String get planFromDay => 'Diesen Tag kopieren';

  @override
  String get planNewHint =>
      'Plane deine Tage wie deine Trainingspläne und trage dann eine ganze Mahlzeit mit einem Tipp ein.';

  @override
  String get planLogDay => 'Leere Mahlzeiten eintragen';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Lebensmittel eingetragen',
      one: '1 Lebensmittel eingetragen',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'Kein Plan';

  @override
  String get planWeekHint => 'Tippe auf einen Tag, um ihm einen Plan zu geben.';

  @override
  String get planDuplicate => 'Duplizieren';

  @override
  String planDeleteTitle(String name) {
    return '$name löschen?';
  }

  @override
  String get planDeleteBody => 'Deine Routinen bleiben. Nur diese gespeicherte Woche wird entfernt.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Ernährung';

  @override
  String get nutritionBetaHint => 'Mahlzeiten, Wasser und Supplements';

  @override
  String get nutritionAboutTitle => 'Über Ernährung';

  @override
  String get nutritionAboutSub => 'Was es ist und was es nie sein wird.';

  @override
  String get nutritionAboutWhatTitle => 'Teil deines Trainings';

  @override
  String get nutritionAboutWhat =>
      'Eine einfache Art, Mahlzeiten, Wasser, Protein und Supplements direkt neben deinen Workouts festzuhalten. GymMane ist zuerst eine Gym-App: Ernährung ist da, damit du alles an einem Ort hast, nicht um eine richtige Diät-App zu ersetzen.';

  @override
  String get nutritionAboutScanTitle => 'Kein Scanner, niemals';

  @override
  String get nutritionAboutScan =>
      'Einen Barcode zu scannen und alles automatisch ausgefüllt zu bekommen, wäre praktisch. Aber dafür braucht es Internet und eine riesige Online-Lebensmitteldatenbank, und was du isst, landet auf fremden Servern. Diese Daten zeigen, wann du isst, was du isst und wie du auf deinen Körper achtest, und sie können für Werbung genutzt oder an große Konzerne weitergegeben werden. Deshalb gibt es keinen Scanner, und es wird auch keinen geben.';

  @override
  String get nutritionAboutLocalTitle => 'Alles auf deinem Handy';

  @override
  String get nutritionAboutLocal =>
      'Über 500 Lebensmittel mit Fotos sind in der App enthalten. Du kannst eigene hinzufügen, ihre Fotos ändern und ihre Werte bearbeiten. Alles bleibt auf deinem Handy, wie der Rest von GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Noch in der Beta';

  @override
  String get nutritionAboutBeta =>
      'Wenn dir etwas fehlt, schlag es auf GitHub vor. Nur keinen Scanner und keine größere Lebensmitteldatenbank: Abgesehen von deiner Privatsphäre würde das die App viel schwerer machen. Brauchst du Ernährung nicht? Schalte sie in den Einstellungen aus, deine Daten bleiben erhalten.';

  @override
  String get nutritionAboutSuggest => 'Idee vorschlagen';

  @override
  String get nutritionAboutOk => 'Verstanden';

  @override
  String get planShare => 'Teilen';

  @override
  String get planImport => 'Plan importieren';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Pläne importiert',
      one: '1 Plan importiert',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'Diese Datei enthält keine Ernährungspläne.';

  @override
  String get planMoveUp => 'Nach oben';

  @override
  String get planMoveDown => 'Nach unten';

  @override
  String get cutoutEdit => 'Ausschnitt nachbessern';

  @override
  String get cutoutEditHint =>
      'Ziehen zum Radieren oder Wiederherstellen. Tippe auf einen Bereich, um ihn ganz zu entfernen oder zurückzuholen. Mit zwei Fingern zoomen.';

  @override
  String get cutoutErase => 'Radieren';

  @override
  String get cutoutRestore => 'Wiederherstellen';

  @override
  String get cutoutReset => 'Zurück zu automatisch';

  @override
  String get cutoutByHand => 'Von Hand ausschneiden';

  @override
  String notifSuppTitleFor(String names) {
    return 'Zeit für: $names';
  }

  @override
  String get notifSuppTap => 'Hake es in GymMane ab, sobald du es genommen hast.';

  @override
  String get suppNoneToday => 'Heute nichts einzunehmen.';

  @override
  String get suppOtherDays => 'Andere Tage';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Alle $n Tage', one: 'Jeden Tag');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Jeden Tag';

  @override
  String suppFromDate(String date) {
    return 'ab $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'bis $date';
  }

  @override
  String get suppSomeDays => 'An bestimmten Tagen';

  @override
  String get suppEveryShort => 'Alle X Tage';

  @override
  String get suppWhen => 'Wann';

  @override
  String get suppEveryLead => 'Alle';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Tage', one: 'Tag');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Beginn';

  @override
  String get suppEnds => 'Ende';

  @override
  String get suppTomorrow => 'Morgen';

  @override
  String get suppPickDate => 'Datum wählen';

  @override
  String get suppNever => 'Nie';

  @override
  String get suppOneWeek => 'In 1 Woche';

  @override
  String get suppOneMonth => 'In 1 Monat';

  @override
  String get planPickHint => 'Wähle den Plan für diesen Tag oder erstelle einen neuen.';

  @override
  String planSetForDay(String day) {
    return 'Plan für $day festgelegt';
  }

  @override
  String get planSaved => 'Plan gespeichert';

  @override
  String get planDiscardTitle => 'Änderungen verwerfen?';

  @override
  String get planDiscardBody => 'Was du geändert hast, wird nicht gespeichert.';

  @override
  String get planDiscard => 'Verwerfen';

  @override
  String get planEdit => 'Plan bearbeiten';

  @override
  String get planNameHint => 'Sommer, Reise…';

  @override
  String get planDaysQuestion => 'An welchen Tagen?';

  @override
  String get planDaysHint =>
      'An diesen Tagen erscheint er unter Ernährung, damit du ihn mit einem Tipp einträgst.';

  @override
  String get planDaysNone => 'Wähle mindestens einen Tag, sonst erscheint er nirgends.';

  @override
  String get planNothingToLog => 'Diese Mahlzeiten sind schon eingetragen';

  @override
  String get planSave => 'Plan speichern';

  @override
  String get planToday => 'Heutiger Plan';

  @override
  String get planLogRest => 'Den Rest eintragen';

  @override
  String get dishNew => 'Mein Gericht erstellen';

  @override
  String get dishNewHint => 'Wähle Zutaten und Mengen, speichere es und trage es mit einem Tipp ein.';

  @override
  String get dishEdit => 'Gericht bearbeiten';

  @override
  String get dishNameHint => 'z. B. Omas Linsen';

  @override
  String get dishIngredients => 'Zutaten';

  @override
  String get dishEmptyHint => 'Füge hinzu, was hineinkommt, mit der Menge, die du sonst isst.';

  @override
  String get dishSave => 'Gericht speichern';

  @override
  String get dishNeedsName => 'Gib ihm einen Namen';

  @override
  String get dishNeedsItems => 'Füge mindestens eine Zutat hinzu';

  @override
  String get suppHistory => 'Letzte 14 Tage';

  @override
  String suppTakenOf(int n, int total) {
    return '$n von $total genommen';
  }

  @override
  String get suppNoReminder => 'Keine Erinnerung';

  @override
  String get suppMarkTaken => 'Als genommen markieren';

  @override
  String get suppUnmark => 'Markierung aufheben';

  @override
  String get suppEdit => 'Bearbeiten';

  @override
  String get mealMoveTo => 'Verschieben nach';

  @override
  String get mealClear => 'Mahlzeit leeren';

  @override
  String get mealCleared => 'Mahlzeit geleert';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Lebensmittel verschoben',
      one: '1 Lebensmittel verschoben',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Ganzen Tag wiederholen';

  @override
  String createFoodNamed(String name) {
    return '„$name“ erstellen';
  }

  @override
  String get entryDay => 'Tag';

  @override
  String get movedToDay => 'Verschoben';

  @override
  String get favFoodsHint => 'Tippe bei einem Lebensmittel auf ☆';

  @override
  String get favFoodsEmpty => 'Tippe bei einem Lebensmittel auf den Stern, um es hier griffbereit zu haben.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Mahlzeiten',
      one: '1 Mahlzeit',
    );
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty =>
      'Speichere eine Mahlzeit über ihr •••-Menü oder stelle dein eigenes Gericht zusammen.';

  @override
  String get sugarLimitLabel => 'Zuckerlimit';

  @override
  String get sodiumLimitLabel => 'Natriumlimit';

  @override
  String get waterOptions => 'Wasser-Optionen';

  @override
  String get waterNone => 'Noch kein Wasser eingetragen.';

  @override
  String get waterDailyGoal => 'Wasser pro Tag';

  @override
  String get trackersScreen => 'Bildschirm';

  @override
  String get vesselMotion => 'Bewegtes Wasser und Shake';

  @override
  String get vesselMotionHint =>
      'Schalte es aus, wenn der Bildschirm träge wirkt: Die Gläser füllen sich weiter, sie bewegen sich nur nicht mehr.';

  @override
  String get planFixedWeek => 'Feste Woche';

  @override
  String get planRotation => 'Rotation';

  @override
  String get rotationTitle => 'ROTATION';

  @override
  String get rotationHint => 'Dran ist immer die nächste nach deinem letzten Training, egal welcher Tag.';

  @override
  String get rotationEmpty => 'Füge deine Routinen in der Reihenfolge hinzu, in der du sie machst: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done von $total in dieser Runde erledigt';
  }

  @override
  String get rotationNext => 'Als Nächstes';

  @override
  String get rotationAdd => 'Routinen hinzufügen';

  @override
  String get rotationPickHint => 'Sie kommen in der Reihenfolge, in der du sie antippst.';

  @override
  String get rotationSkip => 'Zur nächsten springen';

  @override
  String get rotationRestart => 'Neue Runde starten';

  @override
  String get rotationMakeNext => 'Als Nächstes machen';

  @override
  String get rotationRemove => 'Aus der Rotation entfernen';

  @override
  String rotationPlace(int n, int total) {
    return '$n von $total in der Rotation';
  }

  @override
  String get moveToDay => 'Auf einen anderen Tag legen';

  @override
  String get moveToDayHint => 'Nur dieses Mal; dein Wochenplan bleibt gleich.';

  @override
  String get movedToast => 'Training verschoben';

  @override
  String get backToPlan => 'Zurück zum Wochenplan';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get untrainedTab => 'Untrainiert';

  @override
  String get untrainedRecent => 'Kürzlich';

  @override
  String get untrainedLong => 'Lange her';

  @override
  String untrainedWaiting(String list) {
    return 'Am längsten nicht dran: $list';
  }

  @override
  String get untrainedAllRecent => 'Jeder Muskel hat diese Woche gearbeitet. Stark.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Vor $n Tagen',
      one: 'Gestern trainiert',
      zero: 'Heute trainiert',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Noch nicht trainiert';

  @override
  String get layoutSetting => 'Trainingsansicht';

  @override
  String get layoutCards => 'Karten';

  @override
  String get layoutList => 'Liste';

  @override
  String get layoutHint =>
      'Karten zeigen eine Übung nach der anderen. Die Liste zeigt das ganze Training auf einem Bildschirm, Satz für Satz.';

  @override
  String get layoutRowHint => 'Eine Übung nach der anderen oder alles als Liste';

  @override
  String get previousCol => 'LETZTES';

  @override
  String get usePrevious => 'Werte vom letzten Mal übernehmen';

  @override
  String get skipShort => 'Überspringen';

  @override
  String get moveUp => 'Nach oben';

  @override
  String get moveDown => 'Nach unten';

  @override
  String get widgetNutritionOff =>
      'Schalte Ernährung unter Einstellungen › Beta ein, um dieses Widget zu nutzen.';

  @override
  String get widgetPickShake => 'Wähle deinen Shake';

  @override
  String get heatRangeSetting => 'Aktivitätskalender';

  @override
  String get heatRangeWeeks => '12 Wochen';

  @override
  String get heatRangeYear => '12 Monate';

  @override
  String get heatRangeHint =>
      '12 Monate zeigen das ganze Jahr. Wisch seitlich, um zurückzugehen – bis zu deinem ersten Training.';

  @override
  String get pdfPlan => 'Plan als PDF';

  @override
  String get pdfPlanHint =>
      'Ein sauberes Blatt mit deiner Woche und jeder Routine – zum Drucken oder Senden.';

  @override
  String get pdfExport => 'Als PDF exportieren';

  @override
  String get pdfFooter => 'Kostenlos, Open Source und offline';

  @override
  String get shakeTag => 'Das ist ein Shake';

  @override
  String get shakeTagHint => 'Erscheint unter Dein Shake';

  @override
  String get shakeNone => 'Markiere deine Shakes und nur diese erscheinen hier.';

  @override
  String get shakeMarkLabel => 'ALS SHAKE MARKIEREN';

  @override
  String get shakeNew => 'Neuer Shake';

  @override
  String get shakeUntag => 'Kein Shake';

  @override
  String get pdfKicker => 'TRAININGSPLAN';

  @override
  String get pdfStatDays => 'TAGE / WOCHE';

  @override
  String get pdfStatMinutes => 'MIN / TRAINING';

  @override
  String pdfMinutes(int n) {
    return '≈ $n Min.';
  }

  @override
  String get workoutNotesTitle => 'Übungsnotizen';

  @override
  String get workoutNoteEvery => 'Jedes Mal';

  @override
  String get workoutNoteNext => 'Nächstes Mal';

  @override
  String get workoutNoteEveryHint =>
      'Erscheint bei jeder Ausführung. Ideal für Sitz- oder Seilzug-Einstellungen.';

  @override
  String get workoutNoteNextHint => 'Erscheint nur beim nächsten Mal, dann verschwindet sie.';

  @override
  String workoutNoteFromLast(String date) {
    return 'Vom letzten Mal · $date';
  }

  @override
  String get workoutNoteHint => 'Sitz auf Loch 2, Seilzug auf 19…';

  @override
  String get notePinWorkout => 'Im Training zeigen';

  @override
  String get assistedSetting => 'Unterstützte Maschine';

  @override
  String get assistedSettingHint =>
      'Das Gewicht hilft dir, also ist weniger besser: Rekorde und Vorschläge gehen nach unten.';

  @override
  String get assistedRecordHint => 'Wenigste Hilfe';

  @override
  String get trainAgainLabel => 'Noch nicht trainiert? Nochmal erinnern';

  @override
  String get trainAgainOff => 'Nein';

  @override
  String trainAgainAfter(int n) {
    return '+$n Std.';
  }

  @override
  String get trainAgainHint => 'Nur einmal und nur, wenn du an dem Tag noch kein Training eingetragen hast.';

  @override
  String get notifTrainAgainBody => 'Du hast heute noch Zeit zu trainieren.';

  @override
  String nextDeload(int n) {
    return 'leichter: $n Trainings in Folge ohne alle Wdh.';
  }

  @override
  String get historyTitle => 'Verlauf';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n TRAININGS', one: '1 TRAINING');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Keine Trainings in diesem Monat';

  @override
  String get historyEmptyHint => 'Wisch zur Seite oder nutze die Pfeile für andere Monate.';

  @override
  String historyMore(int n) {
    return '+$n weitere';
  }

  @override
  String get stopwatch => 'Stoppuhr';

  @override
  String get proteinSource => 'Proteinquelle';

  @override
  String get proteinMixedShort => 'Gemischt';

  @override
  String get kcalActive => 'aktiv';

  @override
  String get kcalEstimated => 'geschätzt';

  @override
  String get kcalYours => 'dein Wert';

  @override
  String kcalTotalRest(String value) {
    return '$value insgesamt, inklusive Ruheumsatz';
  }

  @override
  String get inclineLabel => 'Steigung';

  @override
  String get kcalUseOwn => 'Meinen Wert nutzen';

  @override
  String get kcalBackToEstimate => 'Zurück zur Schätzung';

  @override
  String get kcalNeedsData => 'Gib Distanz und Zeit ein, um die Kalorien zu schätzen';

  @override
  String get kcalHowEstimated => 'Geschätzt aus Distanz, Zeit, Steigung und deinem Gewicht (ACSM-Formel).';

  @override
  String get kcalOwnTitle => 'Aktive Kalorien';

  @override
  String get planMine => 'Mein Plan';

  @override
  String get planNew => 'Neuer Plan';

  @override
  String get planSaveWeek => 'Diese Woche speichern';

  @override
  String get planSaveWeekHint => 'Behalte die aktuelle Woche als Plan, zu dem du zurückkehren kannst';

  @override
  String get planEmptyWeek => 'Leere Woche beginnen';

  @override
  String get planEmptyWeekHint => 'Deine aktuelle Woche bleibt als Plan gespeichert';

  @override
  String get planName => 'Name des Plans';

  @override
  String get planRename => 'Umbenennen';

  @override
  String get planDelete => 'Plan löschen';

  @override
  String get plansHint => 'Änderungen an der Woche werden im gewählten Plan gespeichert';

  @override
  String get progression => 'Progression';

  @override
  String get progManual => 'Manuell';

  @override
  String get progManualHint => 'Keine Vorschläge: du wählst jedes Gewicht.';

  @override
  String get progLinear => 'Linear';

  @override
  String get progLinearHint => 'Schaffst du alle Wiederholungen, steigt das Gewicht.';

  @override
  String get progDouble => 'Doppelte Progression';

  @override
  String get progDoubleHint => 'Mehr Wiederholungen bis zum oberen Ende, dann mehr Gewicht.';

  @override
  String get progVolume => 'Wdh., Sätze und Gewicht';

  @override
  String get progVolumeHint => 'Wiederholungen bis oben, dann ein Satz mehr, dann mehr Gewicht.';

  @override
  String get progAmrap => 'Letzter Satz bis zum Maximum';

  @override
  String get progAmrapHint =>
      'Letzter Satz: so viele Wiederholungen wie möglich. Doppeltes Ziel, doppelter Sprung.';

  @override
  String get progStep => 'Gewichtssprung';

  @override
  String get progRange => 'Wiederholungsbereich';

  @override
  String get progSets => 'Sätze';

  @override
  String get progDeload => 'Leichter nach';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Fehlversuchen',
      one: '1 Fehlversuch',
    );
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Reduzieren um';

  @override
  String get progApply => 'Nächstes Training ausfüllen';

  @override
  String get progApplyHint => 'Aus: erscheint nur als Vorschlag.';

  @override
  String get nextMoreReps => 'gleiches Gewicht, eine Wdh. mehr';

  @override
  String get nextAddSet => 'ein Satz mehr';

  @override
  String get nextAmrap => 'letzter Satz: so viele wie möglich';

  @override
  String fillDay(String amount) {
    return 'Fülle deinen Tag · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'Dir bleiben $kcal';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'Dir bleiben $kcal und $grams g Protein';
  }

  @override
  String leftAfterOver(String kcal) {
    return '$kcal über deinem Ziel';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit pro Tag';
  }

  @override
  String get byZone => 'Nach Bereich';

  @override
  String get importAlreadyHave => 'Diese Routinen hast du schon. Du kannst sie als Kopie erneut hinzufügen.';

  @override
  String get importAsCopy => 'Als Kopie hinzufügen';

  @override
  String get importOwned => 'Schon da';

  @override
  String get setDuplicated => 'Satz dupliziert';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'Ein Satz, aufgeteilt in kleine Blöcke mit 15–30 Sekunden Pause dazwischen. Trag die Gesamtwiederholungen ein.';

  @override
  String timesBodyweight(String value) {
    return '$value× dein Körpergewicht';
  }

  @override
  String get archiveRoutine => 'Routine archivieren';

  @override
  String get routineArchived => 'Routine archiviert';

  @override
  String get archivedRoutines => 'Archiviert';

  @override
  String get autoBackup => 'Automatische Sicherung';

  @override
  String get autoBackupHint =>
      'Speichert eine ZIP mit allen Daten in einem Ordner deiner Wahl. Synchronisiere ihn mit Nextcloud, Syncthing oder einer anderen App, damit die Kopie nicht nur auf dem Handy liegt.';

  @override
  String get autoBackupFolder => 'Ordner wählen';

  @override
  String get autoBackupNoFolder => 'Noch kein Ordner';

  @override
  String get autoBackupOff => 'Aus';

  @override
  String get autoBackupWorkout => 'Nach jedem Training';

  @override
  String get autoBackupDaily => 'Einmal am Tag';

  @override
  String get autoBackupWeekly => 'Einmal pro Woche';

  @override
  String get autoBackupOnLeave => 'Beim Verlassen der App';

  @override
  String get autoBackupKeep => 'Kopien behalten';

  @override
  String get autoBackupNow => 'Jetzt sichern';

  @override
  String autoBackupLast(String when) {
    return 'Letzte Sicherung $when';
  }

  @override
  String get autoBackupNever => 'Noch keine Sicherung';

  @override
  String get autoBackupLost => 'Die letzte Sicherung ging nicht. Wähle den Ordner erneut.';

  @override
  String get autoBackupSaved => 'Sicherung gespeichert';

  @override
  String get prepPortions => 'Portionen';

  @override
  String get rotationAddRest => 'Ruhetag hinzufügen';

  @override
  String get rotationRestHint => 'Geht am nächsten Tag von selbst weiter';

  @override
  String get rotationRestToday => 'Heute';

  @override
  String get rotationSkipRest => 'Diesen Ruhetag überspringen';

  @override
  String rotationRestUpNext(String name) {
    return 'Danach: $name';
  }

  @override
  String get trainAnyway => 'Trotzdem trainieren';

  @override
  String get healthTitle => 'Gesundheit';

  @override
  String get healthSetting => 'Gesundheitsdaten';

  @override
  String get healthSettingHint => 'Health-Connect-Daten in Fortschritt';

  @override
  String get healthPickTitle => 'Gesundheitsdaten';

  @override
  String get healthPickHint =>
      'Wähle, was aus Health Connect geholt wird. Android fragt einmal pro Wert. Es wird nur gelesen und verlässt nie dein Handy.';

  @override
  String get healthGroupHeart => 'Herz';

  @override
  String get healthGroupVitals => 'Vitalwerte';

  @override
  String get healthGroupActivity => 'Aktivität';

  @override
  String get healthRestingHr => 'Ruhepuls';

  @override
  String get healthHeartRate => 'Durchschnittspuls';

  @override
  String get healthHrv => 'Herzfrequenzvariabilität';

  @override
  String get healthSpo2 => 'Blutsauerstoff';

  @override
  String get healthRespiration => 'Atemfrequenz';

  @override
  String get healthBloodPressure => 'Blutdruck';

  @override
  String get healthTemperature => 'Körpertemperatur';

  @override
  String get healthSleep => 'Schlaf';

  @override
  String get healthDistance => 'Distanz';

  @override
  String get healthFloors => 'Gestiegene Etagen';

  @override
  String get healthElevation => 'Höhenmeter';

  @override
  String get healthActiveKcal => 'Aktive Kalorien';

  @override
  String get healthNoData => 'Noch keine Daten';

  @override
  String get healthReadFailed => 'Konnte nicht gelesen werden';

  @override
  String get healthAllow => 'Tippen zum Erlauben';

  @override
  String get healthLast7 => 'Letzte 7 Tage';

  @override
  String get healthAvg30 => 'Ø 30 Tage';

  @override
  String get healthLow => 'Niedrigster';

  @override
  String get healthHigh => 'Höchster';

  @override
  String get healthFrom => 'Aus Health Connect · letzte 30 Tage';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'Atemz./min';

  @override
  String get weekTab => 'Woche';

  @override
  String get muscleSetsList => 'Sätze pro Muskel';

  @override
  String get fatTrans => 'Trans';

  @override
  String get fatTypesHint => 'Optional. Lass leer, was nicht auf dem Etikett steht.';

  @override
  String get sessionPhotos => 'Trainingsfotos';

  @override
  String get sessionPhotosAdd => 'Fotos hinzufügen';

  @override
  String get sessionPhotosHint => 'Sie landen auch in Deine Fotos.';

  @override
  String get ladderTitle => 'Progression';

  @override
  String get ladderHint =>
      'Ordne die Schritte von leicht nach schwer. Schaffst du zwei Einheiten hintereinander 3 Sätze à 8 (5 bei langsamen), schlägt GymMane den nächsten vor.';

  @override
  String get ladderBuiltIn =>
      'Basiert auf der Progression der App. Füge Schritte hinzu, entferne oder sortiere sie, dann gehört sie zu dieser Routine.';

  @override
  String get ladderNone => 'Noch keine. Tippen, um eine zu erstellen.';

  @override
  String ladderStep(int n, int total) {
    return 'Schritt $n von $total';
  }

  @override
  String get ladderAdd => 'Schritt hinzufügen';

  @override
  String get ladderInRoutine => 'In der Routine';

  @override
  String get ladderClear => 'Die der App nutzen';

  @override
  String get ladderPick => 'Schritt wählen';

  @override
  String get periodWeek => 'diese Woche';

  @override
  String get periodMonth => 'diesen Monat';

  @override
  String get periodYear => 'dieses Jahr';

  @override
  String get periodAll => 'insgesamt';

  @override
  String get settingsSearch => 'Einstellungen durchsuchen';

  @override
  String get settingsNoResults => 'Keine Einstellung mit diesem Namen';

  @override
  String get settingsGroupApp => 'Deine App';

  @override
  String get settingsGroupHome => 'Start und Extras';

  @override
  String get settingsGroupData => 'Daten und Hilfe';

  @override
  String get healthAllowAll => 'Alle einschalten';

  @override
  String get healthSeeAll => 'Alle ansehen';

  @override
  String get healthPinTitle => 'Auf der Karte';

  @override
  String get healthPinHint => 'Wähl bis zu 3 für die Fortschritt-Karte.';

  @override
  String get blurSetting => 'Unschärfe-Effekte';

  @override
  String get blurSettingHint => 'Aus, wenn dein Handy langsam ist';

  @override
  String get lowEndTitle => 'Dein Handy hat wenig Speicher';

  @override
  String get lowEndBody =>
      'Ohne Unschärfe läuft alles flüssiger darauf. Du kannst sie unter Einstellungen → Allgemein wieder einschalten.';

  @override
  String get lowEndOff => 'Unschärfe ausschalten';

  @override
  String get lowEndKeep => 'Beibehalten';

  @override
  String get momentsThisMonth => 'Diesen Monat';

  @override
  String get momentsDays => 'Tage mit Foto';

  @override
  String get awardsPick => 'Fürs Profil auswählen';

  @override
  String get awardsPickHint => 'Tipp die an, die du im Profil willst';

  @override
  String get gymPassPicture => 'Ein Foto des Codes speichern';

  @override
  String get gymPassPictureHint =>
      'Für Codes, die die App nicht lesen kann: zeigt dein Foto mit voller Helligkeit';

  @override
  String get gymPassPictureFormat => 'Foto';

  @override
  String get gymPassUsePicture => 'Foto speichern';

  @override
  String get gymPassChangePicture => 'Foto ändern';

  @override
  String get cropTitle => 'Code zuschneiden';

  @override
  String get cropHint => 'Zieh die Ecken, bis nur der Code drin ist';

  @override
  String get rotatePhoto => 'Drehen';

  @override
  String get cardioNoSets => 'Cardio zählt nicht zu deinen Wochensätzen pro Muskel';

  @override
  String get countsAsWater => 'Zählt als Wasser';

  @override
  String get countsAsWaterHint => 'Für Shakes mit Wasser: Beim Eintragen zählt es auch zu deinem Wasser';

  @override
  String get waterPerServing => 'Wasser pro Portion';

  @override
  String get estOneRm => 'geschätztes 1RM';

  @override
  String get newInWorkout => 'Neu in diesem Training';

  @override
  String newInWorkoutHint(String routine) {
    return 'Füg es mit den Sätzen von eben zu $routine hinzu. Der Rest des Plans bleibt gleich.';
  }

  @override
  String get addedToRoutine => 'Hinzugefügt';

  @override
  String get addShort => 'Hinzufügen';

  @override
  String get allTimeLifted => 'GEHOBEN';

  @override
  String get pctBodyweight => '% Körpergewicht';

  @override
  String get ofBodyweight => 'deines Körpergewichts';

  @override
  String get recoveryStateMid => 'Erholt sich';

  @override
  String get recoveryStateReady => 'Bereit';

  @override
  String recoveringIn(String time) {
    return 'Erholt in $time';
  }

  @override
  String readyIn(String time) {
    return 'Bereit in $time';
  }

  @override
  String get recoveryReadyNow => 'Bereit fürs nächste Training';

  @override
  String get restAfterThisSet => 'Pause nach diesem Satz';

  @override
  String restUsual(String time) {
    return 'Üblich: $time';
  }

  @override
  String get restJustToday => 'Nur für diesen Satz, heute';

  @override
  String get restUseUsual => 'Zurück zur üblichen Pause';

  @override
  String get restChange => 'Ändern';

  @override
  String get noRestTimer => 'Kein Timer';

  @override
  String get sessionMuscles => 'Muskeln in diesem Training';

  @override
  String get sessionMusclesHint =>
      'Blass kommt noch, kräftig ist erledigt. Sätze pro Muskel, Nebenmuskeln zählen halb.';

  @override
  String get miniBodySetting => 'Kleine Muskelkarte bei Plänen';

  @override
  String get miniBodySettingHint => 'Muskeln jeder Routine';

  @override
  String get balanceTitle => 'Kraftbalance';

  @override
  String get balanceWhy => 'So funktioniert es';

  @override
  String get balanceGood => 'Deine Grundübungen sind im Gleichgewicht';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift hinkt hinterher: etwa $gap fehlen';
  }

  @override
  String get balanceHint =>
      'Vergleicht deine geschätzten 1RM der letzten 4 Monate mit klassischen Verhältnissen: Kniebeuge 100 %, Kreuzheben 120 %, Bankdrücken 75 %, Rudern 52 %, Schulterdrücken 45 %. Eine Übung weit unter den anderen ist meist eine Schwachstelle.';

  @override
  String get balanceEven => 'Im Gleichgewicht';

  @override
  String get balanceBehindShort => 'Hinten';

  @override
  String get balanceAheadShort => 'Vorne';

  @override
  String get holdProgress => 'Steigerung über Zeit';

  @override
  String get holdProgressHint => 'Mehr Sekunden, wenn du jeden Satz hältst';

  @override
  String holdProgressOn(int s) {
    return '+$s s jedes Mal, wenn du jeden Satz hältst';
  }

  @override
  String get paceTitle => 'Wochentempo';

  @override
  String get paceOn => 'Im Plan';

  @override
  String get paceTooFast => 'Schneller als dein Bereich';

  @override
  String get paceTooSlow => 'Langsamer als dein Bereich';

  @override
  String get paceWrongWay => 'In die falsche Richtung';

  @override
  String get paceDrifting => 'Mehr Bewegung, als Halten erlaubt';

  @override
  String get paceSetAim => 'Tippe, um dein Ziel festzulegen';

  @override
  String get paceBasis =>
      'Trend deiner Wiegungen der letzten 3 Wochen, damit ein salziges Abendessen dich nicht täuscht.';

  @override
  String get paceAimTitle => 'Was ist dein Ziel?';

  @override
  String get paceAimHint => 'Die Karte zeigt, ob dein Wochentempo passt';

  @override
  String get paceLose => 'Abnehmen';

  @override
  String get paceHold => 'Halten';

  @override
  String get paceGain => 'Zunehmen';

  @override
  String get paceAuto => 'Automatisch';

  @override
  String get paceLoseRange => '0,5 bis 1 % deines Gewichts pro Woche';

  @override
  String get paceHoldRange => 'Innerhalb von 0,25 % pro Woche';

  @override
  String get paceGainRange => '0,25 bis 0,5 % deines Gewichts pro Woche';

  @override
  String get paceAutoHint => 'Aus deinem Zielgewicht';

  @override
  String get weekShort => 'Wo.';

  @override
  String get weightStack => 'Gewichtsblock';

  @override
  String get weightStackHint =>
      'Die Gewichte, die diese Maschine wirklich hat. + und −, Steigerung und Deloads landen nur darauf.';

  @override
  String get weightStackOff => 'Aus: normale Gewichtsschritte';

  @override
  String get stackFrom => 'Von';

  @override
  String get stackTo => 'Bis';

  @override
  String get stackEvery => 'Alle';

  @override
  String get stackFill => 'Block füllen';

  @override
  String get stackTapToFix => 'Tippe auf ein Gewicht, um ein ungerades zu korrigieren oder zu entfernen.';

  @override
  String get stackAddWeight => 'Gewicht hinzufügen';

  @override
  String get stackEditWeight => 'Gewicht am Stift';

  @override
  String get stackClear => 'Block entfernen';

  @override
  String stackCount(int n) {
    return '$n Gewichte';
  }

  @override
  String get healthLinksTitle => 'Mit deinen Trainings';

  @override
  String get healthLinkHeart => 'Puls von deiner Uhr';

  @override
  String get healthLinkHeartHint =>
      'Durchschnitts- und Maximalpuls jedes Trainings, egal welche Uhr ihn aufgezeichnet hat';

  @override
  String get healthLinkWeight => 'Wiegungen aus anderen Apps';

  @override
  String get healthLinkWeightHint =>
      'Die Wiegungen deiner Waage der letzten 30 Tage. Überschreibt nie eine, die du eingetippt hast.';

  @override
  String get healthLinkDenied => 'Health Connect hat keine Erlaubnis gegeben';

  @override
  String get healthOpenSettings => 'Öffnen';

  @override
  String hrMaxShort(int bpm) {
    return 'max. $bpm';
  }

  @override
  String get setNote => 'Notiz zu diesem Satz';

  @override
  String get setNoteHint => 'Griff, ein Ziehen, ein Tipp, der geholfen hat…';

  @override
  String setNoteLast(String note) {
    return 'Letztes Mal: $note';
  }

  @override
  String get lastTimeNotes => 'Letztes Mal';

  @override
  String setNoteLine(int n, String note) {
    return 'Satz $n · $note';
  }

  @override
  String get newMeasure => 'Neues Maß';

  @override
  String get newMeasureHint => 'Was du verfolgen willst: Handgelenk, Ruhepuls, Körperwasser…';

  @override
  String get measureKindLength => 'Länge';

  @override
  String get measureKindLengthHint => 'In cm oder Zoll, wie die anderen';

  @override
  String get measureKindOther => 'Andere';

  @override
  String get measureKindOtherHint => 'Mit deiner eigenen Einheit';

  @override
  String get measureUnit => 'Einheit';

  @override
  String get measureUnitHint => 'mm, bpm, kg…';

  @override
  String get measureNameHint => 'Handgelenk, Ruhepuls…';

  @override
  String get measureRename => 'Umbenennen';

  @override
  String measureDeleteTitle(String name) {
    return '$name löschen?';
  }

  @override
  String get measureDeleteBody => 'Alle Werte, die du dafür eingetragen hast, gehen mit.';

  @override
  String get measureDelete => 'Dieses Maß löschen';

  @override
  String get measureEvery => 'Erinnere mich ans Messen';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'In $n Tagen',
      one: 'Morgen',
      zero: 'Heute',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'Zeit zum Messen';

  @override
  String get notifMeasureChannel => 'Körpermaße';

  @override
  String get notifMeasureChannelWhy => 'Ein Hinweis, wenn es Zeit ist, wieder zu messen.';

  @override
  String get notifMeasureTitle => 'Zeit zum Messen';

  @override
  String notifMeasureBody(int n) {
    return '$n Tage seit dem letzten Mal. Gleiche Stelle, gleiche Tageszeit.';
  }

  @override
  String get healthLinkWrite => 'Deine Trainings speichern';

  @override
  String get healthLinkWriteHint =>
      'Jedes beendete Training geht mit Zeit und Art an Health Connect, damit andere Apps es auch zählen. Schickt auch die letzten 30 Tage.';

  @override
  String get healthWorkoutTitle => 'Training';

  @override
  String get circuits => 'Zirkel auf Zeit';

  @override
  String get circuitsHint => 'Arbeit und Pause nach der Uhr, Runde für Runde';

  @override
  String get newCircuit => 'Neuer Zirkel';

  @override
  String get editCircuit => 'Zirkel bearbeiten';

  @override
  String get circuitDefaultName => 'Zirkel';

  @override
  String get circuitNameHint => 'Name, z. B. Core-Finisher';

  @override
  String get circuitRounds => 'Runden';

  @override
  String get circuitRoundRest => 'Pause zwischen Runden';

  @override
  String get circuitWork => 'Arbeit';

  @override
  String get circuitRest => 'Pause';

  @override
  String get circuitAdd => 'Übung hinzufügen';

  @override
  String get circuitEmpty =>
      'Füg die Übungen in der Reihenfolge hinzu, in der du sie machst. Eine darf zweimal vorkommen, z. B. Seitstütz für jede Seite.';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(steps, locale: localeName, other: '$steps Übungen', one: '1 Übung');
    String _temp1 = intl.Intl.pluralLogic(
      rounds,
      locale: localeName,
      other: '$rounds Runden',
      one: '1 Runde',
    );
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'Start';

  @override
  String get circuitGetReady => 'Mach dich bereit';

  @override
  String circuitRoundOf(int n, int total) {
    return 'Runde $n von $total';
  }

  @override
  String circuitNext(String name) {
    return 'Als Nächstes: $name';
  }

  @override
  String get circuitFinishLine => 'Die letzte, dann fertig';

  @override
  String get circuitDone => 'Zirkel geschafft';

  @override
  String circuitDoneBody(String time) {
    return '$time · in deinem Verlauf gespeichert';
  }

  @override
  String get circuitStopTitle => 'Zirkel stoppen?';

  @override
  String get circuitStopBody => 'Was du bisher gemacht hast, wird in deinem Verlauf gespeichert.';

  @override
  String get circuitStop => 'Stoppen';

  @override
  String get circuitKeepGoing => 'Weitermachen';

  @override
  String circuitDeleteTitle(String name) {
    return '$name löschen?';
  }

  @override
  String get circuitDeleteBody => 'Trainings, die du damit schon gemacht hast, bleiben in deinem Verlauf.';

  @override
  String get circuitPickExercise => 'Wähle eine Übung';

  @override
  String get circuitNoSteps => 'Füg mindestens eine Übung hinzu';

  @override
  String get circuitPrevious => 'Zurück';

  @override
  String get circuitUpNext => 'Gleich kommt';

  @override
  String get foodGroupNew => 'Neue Kategorie';

  @override
  String get foodGroupHint => 'Fertiggerichte, Tiefkühl…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Lebensmittel',
      one: '1 Lebensmittel',
      zero: 'Noch keine Lebensmittel',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return '$name löschen?';
  }

  @override
  String get foodGroupDeleteBody => 'Deine Lebensmittel bleiben, nur ohne diese Kategorie.';

  @override
  String onbHello(String name) {
    return 'Hallo, $name';
  }

  @override
  String get onbPlaceHero => 'Übungen, die du machen kannst';

  @override
  String get settingsRests => 'Pausen';

  @override
  String get settingsDuring => 'Beim Training';

  @override
  String get settingsLook => 'Darstellung';

  @override
  String get importCardTitle => 'Bring deine Workouts hierher';

  @override
  String get importCardBody => 'Aus Hevy, Strong, FitNotes und mehr';

  @override
  String get checkInTitle => 'Wie warst du drauf?';

  @override
  String get checkInSleep => 'Schlaf';

  @override
  String get checkInEnergy => 'Energie';

  @override
  String get checkInSkip => 'Optional';

  @override
  String get checkInLevel1 => 'Mies';

  @override
  String get checkInLevel2 => 'Schwach';

  @override
  String get checkInLevel3 => 'Okay';

  @override
  String get checkInLevel4 => 'Gut';

  @override
  String get checkInLevel5 => 'Top';

  @override
  String get checkInSetting => 'Schlaf und Energie';

  @override
  String get checkInSettingHint => 'Nach jedem Training fragen';

  @override
  String get readinessTitle => 'Schlaf und Energie';

  @override
  String get readinessWaiting => 'Bewerte weiter deine Trainings';

  @override
  String get readinessWaitingHint =>
      'Nach ein paar guten und schlechten Tagen siehst du, wie sie deine Leistung verändern.';

  @override
  String readinessSleepLess(int n) {
    return 'An Tagen mit wenig Schlaf hebst du $n % weniger';
  }

  @override
  String readinessSleepMore(int n) {
    return 'Witzig: an Tagen mit wenig Schlaf hebst du $n % mehr';
  }

  @override
  String get readinessSleepNone => 'Schlaf ändert deine Leistung kaum';

  @override
  String readinessEnergyLess(int n) {
    return 'An Tagen mit wenig Energie hebst du $n % weniger';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'An Tagen mit wenig Energie hebst du trotzdem $n % mehr';
  }

  @override
  String get readinessEnergyNone => 'Deine Energie ändert deine Leistung kaum';

  @override
  String get readinessHint => 'Vergleicht jedes geschätzte 1RM mit deinem Bestwert der 90 Tage davor.';

  @override
  String get readinessLast30 => 'Durchschnitt der letzten 30 Tage';

  @override
  String get kindSport => 'Sport';

  @override
  String get clearWorkouts => 'Nur Trainings löschen';

  @override
  String get clearWorkoutsNone => 'Es gibt keine Trainings zum Löschen';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings löschen?',
      one: '1 Training löschen?',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'Verlauf, Rekorde und Medaillen gehen. Routinen, Übungen, Fotos, Maße, Ernährung und Einstellungen bleiben. Mach vorher eine Sicherung, falls du sie zurückwillst.';

  @override
  String get clearWorkoutsConfirm => 'Trainings löschen';

  @override
  String get clearWorkoutsDone => 'Trainings gelöscht';

  @override
  String get reportTitle => 'Bericht';

  @override
  String get reportHint => 'Wähle die Daten und teile ihn als PDF oder CSV';

  @override
  String get reportCustom => 'Andere';

  @override
  String get reportPickRange => 'Daten wählen';

  @override
  String get reportEmpty => 'Zwischen diesen Daten ist nichts eingetragen.';

  @override
  String get reportKicker => 'TRAININGSBERICHT';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Tage', one: '1 Tag');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'TRAININGS';

  @override
  String get reportPerWeek => 'PRO WOCHE';

  @override
  String get reportHours => 'STUNDEN';

  @override
  String get reportVsPrev => 'Die Prozente vergleichen mit gleich vielen Tagen direkt davor.';

  @override
  String get reportRecords => 'Neue Rekorde';

  @override
  String get reportLifts => 'Übungen';

  @override
  String get reportSessionsCol => 'TAGE';

  @override
  String get reportBestCol => 'BESTES 1RM';

  @override
  String get reportChangeCol => 'ÄNDERUNG';

  @override
  String get reportBestHint =>
      'Das beste 1RM wird aus deinen Sätzen geschätzt. Die Änderung vergleicht den ersten und letzten Tag der Übung in diesem Bericht.';

  @override
  String get reportMuscles => 'Sätze pro Muskel';

  @override
  String get reportBody => 'Körper und Erholung';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Ernährung · Schnitt aus $n Tagen',
      one: 'Ernährung · Schnitt aus 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n neue Rekorde',
      one: '1 neuer Rekord',
    );
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Übungen', one: '1 Übung');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '$kcal und $protein g Protein pro Tag · $days Tage eingetragen';
  }

  @override
  String get reportSharePdf => 'PDF teilen';

  @override
  String get reportShareCsv => 'CSV exportieren';

  @override
  String get reportExportZip => 'Export report ZIP';

  @override
  String get reportSummaryEmpty => 'No workouts, food, or weigh-ins to summarize for these dates.';

  @override
  String get reportZipHint => 'Choose what to include. Missing steps or synced sleep are left blank.';

  @override
  String get reportWeighIns => 'Weigh-ins';

  @override
  String get reportSyncedSleep => 'Synced sleep';

  @override
  String get reportSessionDetails => 'Workout session details';

  @override
  String get reportZipFailed => 'Could not export the report ZIP.';

  @override
  String get reportShareCsvBoth => 'CSV exportieren (Trainings und Ernährung)';

  @override
  String fastMinutes(int n) {
    return '$n Min.';
  }

  @override
  String fastHours(int n) {
    return '$n Std.';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h Std. $m Min.';
  }

  @override
  String get fastTracker => 'Intervallfasten';

  @override
  String fastTitle(int fast, int eat) {
    return 'Fasten $fast:$eat';
  }

  @override
  String get fastOptions => 'Fasten-Optionen';

  @override
  String get fastWindowOpen => 'Essensfenster offen';

  @override
  String get fastLeft => 'Übrig';

  @override
  String get fastDoneLabel => 'Ziel erreicht';

  @override
  String get fastIdle => 'Starte es nach deiner letzten Mahlzeit';

  @override
  String fastLast(String time) {
    return 'Letztes Fasten: $time';
  }

  @override
  String fastStreak(int n) {
    return '$n in Folge';
  }

  @override
  String fastReached(String time) {
    return '$time über deinem Ziel';
  }

  @override
  String fastEndsAt(String time) {
    return 'Endet um $time';
  }

  @override
  String fastSince(String time) {
    return 'Seit $time';
  }

  @override
  String get fastStartedAt => 'Wann hast du mit dem Fasten begonnen?';

  @override
  String get fastStart => 'Fasten starten';

  @override
  String fastFromMeal(String time) {
    return 'Ab $time';
  }

  @override
  String get fastEnd => 'Fasten beenden';

  @override
  String get fastCancel => 'Dieses Fasten abbrechen';

  @override
  String get fastPlan => 'Fastenplan';

  @override
  String get fastPlanHint => 'Stunden fasten : Stunden essen';

  @override
  String get fastThisWeek => 'Letzte 7 Tage';

  @override
  String get fastCount => 'Fastentage';

  @override
  String get fastReachedCount => 'Erreicht';

  @override
  String get fastAverage => 'Durchschnitt';

  @override
  String get fastHistory => 'Letzte Fastenzeiten';

  @override
  String get notifFastLiveChannel => 'Fasten läuft';

  @override
  String get notifFastLiveChannelWhy => 'Ein ruhiger Countdown, während du fastest.';

  @override
  String get notifFastChannel => 'Fasten';

  @override
  String get notifFastChannelWhy => 'Sagt dir, wann dein Fasten geschafft ist.';

  @override
  String get notifFastLiveTitle => 'Fasten';

  @override
  String notifFastLiveBody(String time) {
    return 'Dein Essensfenster öffnet um $time';
  }

  @override
  String get notifFastDoneTitle => 'Fasten geschafft';

  @override
  String notifFastDoneBody(int n) {
    return '$n Stunden. Dein Essensfenster ist offen.';
  }

  @override
  String get newExerciseHint =>
      'Nur der Name ist Pflicht. Der Rest hilft, du kannst ihn aber später ergänzen.';

  @override
  String get supportThanksTitle => 'Danke, dass du da bist 🤍';

  @override
  String get supportThanksBody =>
      'GymMane ist und bleibt kostenlos, ohne Werbung und ohne Haken.\n\nWenn es dir beim Training hilft, macht mir ein Kaffee den Tag ☕\nUnd wenn nicht, kein Problem: ein Stern auf GitHub auch ⭐';

  @override
  String get perfSetting => 'Leistung';

  @override
  String get perfSheetHint =>
      'Wie viel von deinem Handy GymMane nutzt. Unten kannst du jeden Teil einzeln ändern.';

  @override
  String get perfLite => 'Sparmodus';

  @override
  String get perfLiteHint => 'Keine Unschärfe und ruhigere Bewegungen. Für Handys, die sich schwertun.';

  @override
  String get perfBalanced => 'Ausgewogen';

  @override
  String get perfBalancedHint => 'Unschärfe und Animationen, ohne den Akku leerzusaugen.';

  @override
  String get perfMax => 'Maximum';

  @override
  String perfMaxHint(int hz) {
    return 'Feinere Unschärfe und der Bildschirm mit $hz Hz. Für Spitzenhandys.';
  }

  @override
  String get perfMaxHintNoHz => 'Überall feinere Unschärfe. Für Spitzenhandys.';

  @override
  String get perfCustom => 'Eigene';

  @override
  String get perfTweak => 'Feineinstellung';

  @override
  String get perfFine => 'Feine Unschärfe';

  @override
  String get perfFineHint => 'Weichere Kanten und ein schärferer Hintergrund hinter Fenstern';

  @override
  String perfHz(int hz) {
    return 'Bildschirm mit $hz Hz';
  }

  @override
  String get perfHzHint => 'Alles scrollt flüssiger, bei etwas mehr Akkuverbrauch';

  @override
  String get lowEndLiteBody =>
      'Im Sparmodus (keine Unschärfe, ruhigere Bewegungen) läuft es darauf flüssiger. Du kannst es unter Einstellungen → Allgemein → Leistung ändern.';

  @override
  String get lowEndLiteOn => 'Sparmodus einschalten';

  @override
  String get dayOffHint => 'Deine Serie und die Erinnerung lassen diesen Tag in Ruhe';

  @override
  String get dayOffTrained => 'Ich habe trainiert, nur nicht eingetragen';

  @override
  String get dayOffSick => 'Krankheit';

  @override
  String get dayOffTravel => 'Reise';

  @override
  String get dayOffInjury => 'Verletzung';

  @override
  String get dayOffRest => 'Ruhe';

  @override
  String get altsTitle => 'Ersatzübungen';

  @override
  String get altsHint => 'Falls das Gerät belegt ist';

  @override
  String altsPickHint(int count) {
    return 'Wähle bis zu $count. Ist das Gerät belegt, tauschst du mit einem Tipp.';
  }

  @override
  String get placeDumbbells => 'Kurzhanteln';

  @override
  String get dumbbellsHint =>
      'Das Gewicht einer Kurzhantel. Progression und die Tasten + und − landen hier nur auf diesen Werten.';

  @override
  String get dumbbellOther => 'Anderes Gewicht';

  @override
  String get tuneTitle => 'Heutiges Volumen';

  @override
  String get tuneHint =>
      'Sag mir, wie sich jeder Muskel angefühlt hat, und ich passe die Sätze fürs nächste Mal an.';

  @override
  String get tuneLess => 'Zu wenig';

  @override
  String get tuneRight => 'Passt';

  @override
  String get tuneMore => 'Zu viel';

  @override
  String tuneNext(String sets, String name) {
    return 'Nächstes Mal: $sets von $name';
  }

  @override
  String get tuneSame => 'Bleibt nächstes Mal gleich';

  @override
  String get tuneSetting => 'Sätze pro Muskel anpassen';

  @override
  String get tuneSettingHint => 'Bewerte nach einem Training jeden Muskel und die Sätze passen sich an';

  @override
  String insightLoad(int pct) {
    return '$pct % mehr Sätze als in deiner üblichen Woche. Achte auf deine Erholung.';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: seit $days Tagen nicht trainiert.';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'Du drückst mehr, als du ziehst: $a Sätze gegen $b in vier Wochen.';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'Du ziehst mehr, als du drückst: $a Sätze gegen $b in vier Wochen.';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: $pct % stärker als letzten Monat.';
  }

  @override
  String recapPull(String month) {
    return 'Weiter ziehen, um deinen $month zu sehen';
  }

  @override
  String get recapRelease => 'Loslassen';

  @override
  String recapHi(String name) {
    return 'Hallo, $name';
  }

  @override
  String recapReady(String month) {
    return 'Schauen wir, was du im $month gemacht hast?';
  }

  @override
  String get recapGo => 'Los geht\'s';

  @override
  String recapEmpty(String month) {
    return 'Noch keine Trainings im $month. Dein erstes schaltet das hier frei.';
  }

  @override
  String get recapClose => 'Schließen';

  @override
  String get recapShare => 'Teilen';

  @override
  String get recapWorkoutsKicker => 'Diesen Monat hast du';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Trainings', one: 'Training');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'An $n verschiedenen Tagen',
      one: 'An einem Tag',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'Zeit unter der Hantel';

  @override
  String recapLongest(String time, String date) {
    return 'Längste Einheit: $time, am $date';
  }

  @override
  String get recapVolumeKicker => 'Du hast bewegt';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Als hättest du $count Autos gehoben',
      one: 'Als hättest du ein Auto gehoben',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'Am meisten: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'Muskel des Monats';

  @override
  String get recapRecordsKicker => 'Neue Rekorde';

  @override
  String recapNoRecords(int n) {
    return 'Diesmal keine Rekorde, aber $n Sätze mehr auf dem Konto.';
  }

  @override
  String get recapHabitKicker => 'Deine Zeit';

  @override
  String recapHabitStart(String time) {
    return 'Du fängst meist um $time an';
  }

  @override
  String get recapShareKicker => 'Dein Monat, bereit zum Teilen';

  @override
  String get recapTickWorkouts => 'Trainings';

  @override
  String get recapTickTime => 'Zeit';

  @override
  String get recapTickVolume => 'Last';

  @override
  String get recapTickRecords => 'Rekorde';

  @override
  String recapAvg(int n) {
    return 'Im Schnitt $n Min pro Training';
  }

  @override
  String get recapLiftKicker => 'Übung des Monats';

  @override
  String get recapBest => 'Bestwert';

  @override
  String get recapTimes => 'Tage';

  @override
  String get recapDaysLabel => 'Tage';

  @override
  String get recapAvgLabel => 'Schnitt';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$workouts Trainings an $days Tagen';
  }

  @override
  String get recapFavLabel => 'Dein Tag';

  @override
  String get recapWatermark => 'kostenloses Trainingstagebuch';

  @override
  String get recapTickSteps => 'Schritte';

  @override
  String get recapTickFood => 'Essen';

  @override
  String get recapCardioKicker => 'Cardio';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Trainings',
      one: 'einem Training',
    );
    return '$minutes Min in $_temp0';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Cardio-Trainings',
      one: 'Ein Cardio-Training',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'Dein Favorit: $name';
  }

  @override
  String get recapStepsKicker => 'Du bist gelaufen';

  @override
  String get recapStepsWord => 'Schritte';

  @override
  String recapStepsAvg(String value) {
    return 'Im Schnitt $value pro Tag';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'Bester Tag: $value, $date';
  }

  @override
  String get recapFoodKicker => 'Auf deinem Teller';

  @override
  String get recapLiftRest => 'Dicht dahinter';

  @override
  String recapSameAs(String month) {
    return 'Genauso wie im $month';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$value mehr als im $month';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$value weniger als im $month';
  }

  @override
  String get recapTickMedals => 'Medaillen';

  @override
  String get recapTickSleep => 'Schlaf';

  @override
  String get recapMedalsKicker => 'Deine Medaillen';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Und $n weitere',
      one: 'Und noch eine',
    );
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'Du hast geschlafen';

  @override
  String get recapSleepAvg => 'pro Nacht im Schnitt';

  @override
  String recapSleepBest(String value, String date) {
    return 'Beste Nacht: $value, $date';
  }

  @override
  String get recapCardSummary => 'Übersicht';

  @override
  String get recapCardCalendar => 'Kalender';

  @override
  String get recapCardLift => 'Übung';

  @override
  String get recapPeakKicker => 'Deine härteste Einheit';

  @override
  String get recapTickPeak => 'Einheit';

  @override
  String get recapFreshKicker => 'Zum ersten Mal diesen Monat';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'neue Übungen', one: 'neue Übung');
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'Neu';

  @override
  String recapStreak(int n) {
    return '$n Tage am Stück, deine längste Serie';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Trainings', one: '1 Training');
    return 'Vor einem Jahr: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'Diesen Monat vergessen: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'Protein am Tag · Ziel $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Tage auf deinem Teller',
      one: '1 Tag auf deinem Teller',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'Protein · g/Tag';

  @override
  String get recapFoodGoalDays => 'Ziel erreicht';

  @override
  String get recapFoodWaterLabel => 'Wasser/Tag';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Tage', one: '1 Tag');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'Dein Essen des Monats';

  @override
  String get onbSpeedTitle => 'Damit es flüssig läuft';

  @override
  String get onbSpeedWhy =>
      'Dein Handy scheint sich anzustrengen. Schalte das aus und alles läuft runder: Probier es aus und sieh dir die Vorschau an.';

  @override
  String get onbSpeedMotion => 'Animationen';

  @override
  String get onbSpeedBlurHint => 'Milchglas hinter Fenstern und Leisten';

  @override
  String get onbSpeedMotionHint => 'Bildschirme und Fenster, die hereingleiten';

  @override
  String get onbSpeedLater => 'Du kannst es jederzeit unter Einstellungen › Allgemein › Leistung ändern.';

  @override
  String get notifSoundSetting => 'Benachrichtigungstöne';

  @override
  String get notifSoundRowHint => 'Wie jede Art von Erinnerung klingt';

  @override
  String get notifSoundHint =>
      'Wähle einen Ton für jede Art von Erinnerung. „Vom Handy“ öffnet die Töne deines Handys, und auf den meisten Handys kannst du dort auch einen eigenen Song hinzufügen.';

  @override
  String get notifSoundTrain => 'Trainings';

  @override
  String get notifSoundFood => 'Essen, Nahrungsergänzung und Fasten';

  @override
  String get notifSoundOther => 'Fotos und Maße';

  @override
  String get notifSoundNormal => 'Normal';

  @override
  String get notifSoundPhone => 'Vom Handy';

  @override
  String get notifSoundSilent => 'Stumm';

  @override
  String get notifSoundPhoneHint => 'Tippe einen an, um ihn zu hören. Er wird sofort gespeichert.';

  @override
  String get notifSoundMore => 'Andere Datei…';

  @override
  String get notifSoundChange => 'Ändern';

  @override
  String get workoutNoteAdd => 'Angeheftete Notiz: Sitz, Griff, Gerät…';

  @override
  String get autoProgressSetting => 'Automatische Progression';

  @override
  String get autoProgressRowHint => 'Was es fürs nächste Mal vorschlägt';

  @override
  String get autoProgressOff => 'Aus';

  @override
  String get autoProgressWeight => 'Gewicht erhöhen';

  @override
  String get autoProgressReps => 'Wiederholungen erhöhen';

  @override
  String get autoProgressHint =>
      'Wenn du ein Training startest, trägt GymMane für jede Übung den nächsten Schritt ein. Mit „Wiederholungen erhöhen“ kommt pro Satz eine Wiederholung dazu, bis 12; dann steigt das Gewicht und du fängst wieder bei 8 an. Jede Übung kannst du trotzdem auf ihrer Seite anpassen.';

  @override
  String get noteFolders => 'Ordner';

  @override
  String get noteFolderNew => 'Neuer Ordner';

  @override
  String get noteFolderEdit => 'Ordner bearbeiten';

  @override
  String get noteFolderName => 'Ordnername';

  @override
  String get noteFolderLabel => 'Ordner';

  @override
  String get noteFolderNone => 'Kein Ordner';

  @override
  String get noteFolderDelete => 'Ordner löschen?';

  @override
  String get noteFolderDeleteBody => 'Die Notizen bleiben erhalten: Sie verlassen nur den Ordner.';

  @override
  String get foodArchivedToast => 'Lebensmittel archiviert';

  @override
  String get planArchivedToast => 'Plan archiviert';

  @override
  String get suppArchivedToast => 'Präparat archiviert';

  @override
  String get voiceSetting => 'Trainingsstimme';

  @override
  String get voiceSettingHint =>
      'Sagt deinen nächsten Satz an und zählt das Ende der Pause herunter, mit der Stimme deines Handys';

  @override
  String get voiceHello => 'Stimme an';

  @override
  String voiceRest(String time) {
    return 'Pause $time.';
  }

  @override
  String voiceNext(String name, String load) {
    return 'Als Nächstes: $name, $load.';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$reps Wiederholungen mit $weight';
  }

  @override
  String voiceReps(int reps) {
    return '$reps Wiederholungen';
  }

  @override
  String get voiceGo => 'Los geht\'s!';

  @override
  String get deloadSetting => 'Deload-Woche';

  @override
  String get deloadOff => 'Nie';

  @override
  String deloadEvery(int weeks) {
    return 'Alle $weeks Wochen';
  }

  @override
  String get deloadHint =>
      'Alle paar Wochen eine leichtere zur Erholung: halb so viele Sätze und 10 % weniger Gewicht. Diese Woche zählt nicht für die Progression.';

  @override
  String get deloadRowHint => 'Alle paar Wochen eine leichte Woche';

  @override
  String get deloadNow => 'Deload-Woche';

  @override
  String get deloadNowHint => 'Heute halb so viele Sätze und 10 % weniger Gewicht';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'In $weeks Wochen',
      one: 'Nächste Woche',
      zero: 'Diese Woche',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'Normal trainieren';

  @override
  String get voiceSheetTitle => 'So funktioniert die Stimme';

  @override
  String get voicePointRest =>
      'Wenn du einen Satz abhakst, sagt sie dir die Pausenzeit und was als Nächstes kommt.';

  @override
  String get voicePointCount => 'Am Ende der Pause zählt sie 3, 2, 1 und ruft dich zurück.';

  @override
  String get voicePointPhone => 'Sie nutzt die Stimme deines Handys und spielt über deine Musik.';

  @override
  String get voiceTry => 'Stimme testen';

  @override
  String get voiceNoEngine => 'Auf deinem Handy ist keine Sprachausgabe aktiviert.';

  @override
  String get voiceNoLang =>
      'Die Stimme für deine Sprache fehlt. Lade sie in den Spracheinstellungen deines Handys herunter.';

  @override
  String get voiceOpenSettings => 'Spracheinstellungen';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minuten',
      one: '1 Minute',
    );
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sekunden',
      one: '1 Sekunde',
    );
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'und';

  @override
  String get repRecordsTitle => 'Bestes Gewicht nach Wiederholungen';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Kapseln', one: 'Kapsel');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Tabletten', one: 'Tablette');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Messlöffel', one: 'Messlöffel');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Tropfen', one: 'Tropfen');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Portionen', one: 'Portion');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IE';

  @override
  String get suppLeft => 'Vorrat';

  @override
  String get suppLeftHint => 'Optional';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Reicht noch $n Tage',
      one: 'Reicht noch 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Tage', one: '1 Tag');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'Aufgebraucht';

  @override
  String get lightSession => 'Leichte Einheit';

  @override
  String get lightSessionHint =>
      'Wird in deinem Verlauf und deiner Statistik gespeichert, ändert aber deine nächsten Ziele nicht.';

  @override
  String get lightSessionNote => 'Zählt nicht für die Progression';

  @override
  String get lightSessionOff => 'Ausschalten';

  @override
  String get eachSideRepsHint =>
      'Trage linke und rechte Wiederholungen getrennt ein. Die Progression richtet sich nach der schwächeren Seite.';

  @override
  String get repsLeftCol => 'WDH. L';

  @override
  String get repsRightCol => 'WDH. R';

  @override
  String get repsLeftTitle => 'WIEDERHOLUNGEN LINKS';

  @override
  String get repsRightTitle => 'WIEDERHOLUNGEN RECHTS';

  @override
  String sidesReps(int l, int r) {
    return 'L$l R$r';
  }

  @override
  String get progSchemeTitle => 'Gewichtsprogression';

  @override
  String get groupMoveUp => 'Gruppe nach oben';

  @override
  String get groupMoveDown => 'Gruppe nach unten';

  @override
  String get mealAiRow => 'Eine KI fragen';

  @override
  String get mealAiRowHint => 'Anfrage kopieren, Antwort einfügen';

  @override
  String get mealAiTitle => 'Mahlzeiten mit KI';

  @override
  String get mealAiSubtitle => 'Funktioniert mit jedem Chatbot. Die App bleibt offline.';

  @override
  String get mealAiStepAsk => 'Fragen';

  @override
  String get mealAiStepPaste => 'Einfügen';

  @override
  String get mealAiWholeDay => 'Ganzer Tag';

  @override
  String get mealAiTarget => 'Ziel';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'Dir bleiben heute $kcal und $protein g Protein';
  }

  @override
  String get mealAiStyle => 'Dein Geschmack';

  @override
  String get mealAiTagProtein => 'Proteinreich';

  @override
  String get mealAiTagVeggie => 'Vegetarisch';

  @override
  String get mealAiTagVegan => 'Vegan';

  @override
  String get mealAiTagNoGluten => 'Glutenfrei';

  @override
  String get mealAiTagNoLactose => 'Laktosefrei';

  @override
  String get mealAiTagQuick => 'Schnell';

  @override
  String get mealAiTagNoCook => 'Ohne Kochen';

  @override
  String get mealAiTagCheap => 'Günstig';

  @override
  String get mealAiNotesHint => 'Ich habe zu Hause… Ich mag kein… Allergien…';

  @override
  String get mealAiOptions => 'Optionen';

  @override
  String get mealAiCopy => 'Anfrage kopieren';

  @override
  String get mealAiCopied => 'Anfrage kopiert';

  @override
  String get mealAiCopiedHint => 'Füge sie in deine KI ein und komm mit der Antwort hierher zurück';

  @override
  String get mealAiShowText => 'Anfrage ansehen';

  @override
  String get mealAiHideText => 'Anfrage ausblenden';

  @override
  String get mealAiPasteHint => 'Füge hier die Antwort der KI ein';

  @override
  String get mealAiReview => 'Antwort prüfen';

  @override
  String get mealAiUnreadable => 'Ich habe in diesem Text kein Lebensmittel gefunden';

  @override
  String get mealAiUnreadableHint =>
      'Bitte die KI, nur das JSON in einem Codeblock zu schicken, im Format der Anfrage.';

  @override
  String get mealAiCopyFix => 'Diesen Satz kopieren';

  @override
  String mealAiOption(int n) {
    return 'Option $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return 'Zu $meal hinzufügen';
  }

  @override
  String get mealAiAddDay => 'Zu heute hinzufügen';

  @override
  String get mealAiAddPick => 'Hinzufügen';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Lebensmittel hinzugefügt',
      one: '1 Lebensmittel hinzugefügt',
    );
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'Als Rezept speichern';

  @override
  String get mealAiSavePlan => 'Als Plan speichern';

  @override
  String get mealAiRecipeSaved => 'Rezept gespeichert';

  @override
  String get mealAiPlanSaved => 'Plan gespeichert';

  @override
  String get mealAiFlagEstimated => 'Von der KI geschätzt';

  @override
  String get mealAiFlagAdjusted => 'Kalorien an die Makros angepasst';

  @override
  String get mealAiFlagDoubtful => 'Passt nicht zusammen, prüf es';

  @override
  String get mealAiFlagNoValues => 'Keine Nährwerte';

  @override
  String get mealAiFlagNoAmount => 'Keine Menge angegeben';

  @override
  String get mealAiTruncated =>
      'Die Antwort scheint abgeschnitten. Ich habe die vollständigen Lebensmittel behalten.';

  @override
  String get mealAiAmount => 'Menge';

  @override
  String mealAiTargetLine(String kcal) {
    return 'Ziel $kcal';
  }

  @override
  String get mealAiNothingChosen => 'Schalte mindestens ein Lebensmittel ein';

  @override
  String get cholesterolLabel => 'Cholesterin';

  @override
  String get mealAiFlagMatched => 'Wie ein Lebensmittel, das du gespeichert hast';

  @override
  String get mealAiNotSame => 'Nicht dasselbe';

  @override
  String get homeOrderRow => 'Reihenfolge der Bereiche';

  @override
  String get homeOrderHint => 'Halten und ziehen, um die Reihenfolge auf Start zu ändern.';

  @override
  String get homeOrderFolders => 'Verknüpfungen';

  @override
  String get equipNew => 'Neu';

  @override
  String get equipNewTitle => 'Neue Ausrüstung';

  @override
  String get equipNewHint => 'z. B. Gewichthebergürtel';

  @override
  String get homeOrderWeekdays => 'Wochenhäkchen';

  @override
  String get repsMaxTitle => 'Wiederholungen bis';

  @override
  String get repsRangeHint => 'Halte die Wiederholungen gedrückt, um einen Bereich wie 8-12 festzulegen.';

  @override
  String get repsRangeClear => 'Bereich entfernen';

  @override
  String get noteLinksLabel => 'LINKS';

  @override
  String get noteLinkAdd => 'Link hinzufügen';

  @override
  String get noteLinkEdit => 'Link bearbeiten';

  @override
  String get noteLinkNameHint => 'Name';

  @override
  String get noteLinkUrlHint => 'Webadresse';

  @override
  String get noteLinkInvalid => 'Diese Adresse sieht nicht richtig aus';

  @override
  String get changeRest => 'Pause zwischen Übungen';

  @override
  String get changeRestHint => 'Nach dem letzten Satz, vor der nächsten Übung';

  @override
  String get notifSuppTake => 'Genommen';

  @override
  String get sideRest => 'Pause zwischen Seiten';

  @override
  String get sideRestHint => 'Einseitige Übungen: Das erste ✓ beendet eine Seite';

  @override
  String get gfxCompat => 'Kompatible Grafik';

  @override
  String get gfxCompatHint =>
      'Für Handys, auf denen Buchstaben kaputt aussehen. Die Unschärfe bleibt, ein paar Effekte werden einfacher';

  @override
  String get gfxRestartTitle => 'GymMane neu starten?';

  @override
  String get gfxRestartBody =>
      'Es schließt sich und öffnet sich wieder, um die Darstellung zu ändern. Nichts Gespeichertes geht verloren.';

  @override
  String get gfxRestart => 'Neu starten';

  @override
  String get webSynced => 'Mit Änderungen von einem anderen Gerät aktualisiert';

  @override
  String get webSyncedPhone => 'Die Änderungen deines Handys sind da';

  @override
  String get webWelcomeBlurb =>
      'Alles bleibt auf deinem eigenen Server. Kein Konto, keine Cloud, nichts zu bezahlen.';

  @override
  String get webOwnServer => 'Dein Server, deine Regeln';

  @override
  String get webOwnServerWhy =>
      'Keine Konten und keine fremde Cloud. Deine Daten liegen dort, wo du es betreibst.';

  @override
  String get webServerSaved => 'Auf deinem Server gespeichert';

  @override
  String get webServerOffline => 'Dein Server ist nicht erreichbar';

  @override
  String get webServerLocal => 'In diesem Browser gespeichert';

  @override
  String get webServerTitle => 'Dein Server';

  @override
  String webPhoneLast(String date) {
    return 'Letzte Kopie von deinem Handy: $date';
  }

  @override
  String get webPhoneNone => 'Noch keine Kopie von deinem Handy';

  @override
  String get webPhoneScan => 'Vom Handy holen';

  @override
  String get webPhoneExport => 'Ans Handy senden';

  @override
  String get webPhoneExportDone => 'Im geteilten Ordner abgelegt. Dein Handy holt es beim Synchronisieren';

  @override
  String get webPhoneImported => 'Die Änderungen deines Handys sind da';

  @override
  String get webPhoneNothing => 'Nichts Neues von deinem Handy';

  @override
  String get webPhoneHow =>
      'Schalte auf deinem Handy die automatische Sicherung in einen Ordner ein, den du mit Syncthing synchronisierst. Server und Handy holen sich die Änderungen des anderen von selbst, und beim Zusammenführen wird nie etwas gelöscht.';

  @override
  String get webPhoneGuide => 'So richtest du es ein';

  @override
  String get webPhoneOff => 'Die Synchronisierung mit dem Handy ist auf diesem Server aus';

  @override
  String get toolGroupBody => 'Körper';

  @override
  String get toolNameProtein => 'Protein';

  @override
  String get toolTitleProtein => 'Protein pro Tag';

  @override
  String get toolDescProtein => 'Wie viel Protein am Tag';

  @override
  String get toolHintProtein => 'Gramm pro Tag, auf deine Mahlzeiten verteilt';

  @override
  String get proteinGoalLabel => 'Ziel';

  @override
  String get proteinExplain =>
      'Basiert auf dem Bereich, auf den sich die meisten Studien für Trainierende einigen: mehr, wenn du abnimmst, um deine Muskeln zu halten. Darüber zu liegen ist unbedenklich, bringt nur wenig zusätzlich.';

  @override
  String get toolNameWater => 'Wasser';

  @override
  String get toolTitleWater => 'Wasser pro Tag';

  @override
  String get toolDescWater => 'Wie viel du am Tag trinken solltest';

  @override
  String get toolHintWater => 'Liter pro Tag, Essen eingerechnet';

  @override
  String get waterTrainingLabel => 'Training pro Tag';

  @override
  String get waterExplain =>
      'Etwa 35 ml pro Kilo Körpergewicht, plus etwas extra für jede Trainingsminute. An heißen Tagen mehr trinken.';

  @override
  String get autoBackupSync => 'Jetzt synchronisieren';

  @override
  String get autoBackupMerged => 'Die Änderungen deiner anderen Geräte sind da';

  @override
  String get autoBackupSyncHint =>
      'Teile diesen Ordner mit Syncthing, und jedes Gerät holt sich, was die anderen hier ablegen. Beim Zusammenführen wird nie etwas gelöscht.';

  @override
  String get webPhoneFolder => 'Geteilter Ordner';

  @override
  String get webPhoneFolderHow =>
      'Wird bei der Installation des Servers festgelegt. Um ihn zu ändern, setze GYMMANE_SYNC in der .env-Datei des Servers und starte ihn neu.';

  @override
  String get webPhoneOffHow =>
      'Zum Einschalten entferne GYMMANE_SYNC=off aus der .env-Datei des Servers und starte ihn neu.';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Handys synchronisiert',
      one: '1 Handy synchronisiert',
      zero: 'Noch kein Handy synchronisiert',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'Ordner konnte nicht gelesen werden: $error';
  }

  @override
  String get duplicateExercise => 'Duplizieren';

  @override
  String exerciseCopyName(String name) {
    return '$name (Kopie)';
  }
}
