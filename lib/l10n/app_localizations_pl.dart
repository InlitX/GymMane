// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get languageName => 'Polski';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% vs poprzedni miesiąc';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Poziom $level · $streak';
  }

  @override
  String get save => 'ZAPISZ';

  @override
  String get cancel => 'Anuluj';

  @override
  String get cancelCaps => 'ANULUJ';

  @override
  String get deleteCaps => 'USUŃ';

  @override
  String get done => 'GOTOWE';

  @override
  String get set => 'Seria';

  @override
  String get home => 'START';

  @override
  String get progress => 'POSTĘP';

  @override
  String get exercises => 'ĆWICZENIA';

  @override
  String get settings => 'USTAWIENIA';

  @override
  String get today => 'DZISIAJ';

  @override
  String get thisWeek => 'TEN TYDZIEŃ';

  @override
  String get recommended => 'POLECANE';

  @override
  String get goal => 'CEL';

  @override
  String get volume => 'OBJĘTOŚĆ';

  @override
  String get setsToday => 'SERIE DZISIAJ';

  @override
  String get prs => 'REKORDY';

  @override
  String get todaysFocus => 'DZISIEJSZY CEL';

  @override
  String get todaysRoutine => 'DZISIEJSZY PLAN';

  @override
  String get startWorkout => 'ROZPOCZNIJ TRENING';

  @override
  String get routines => 'PLANY';

  @override
  String get tools => 'NARZĘDZIA';

  @override
  String get firstSessionHint => 'Wybierz mięśnie i zapisz pierwszy trening';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ćwiczeń', one: '$n ćwiczenie');
    return '$_temp0';
  }

  @override
  String get pushDay => 'DZIEŃ PUSH';

  @override
  String get pullDay => 'DZIEŃ PULL';

  @override
  String get legDay => 'NOGI';

  @override
  String get pushFocus => 'Klatka · Barki · Triceps';

  @override
  String get pullFocus => 'Plecy · Biceps · Kaptury';

  @override
  String get legFocus => 'Czworogłowe · Dwugłowe uda · Pośladki';

  @override
  String get train => 'TRENUJ';

  @override
  String get step1 => 'KROK 1 Z 2';

  @override
  String get step2 => 'KROK 2 Z 2';

  @override
  String get chooseFocus => 'WYBIERZ CEL';

  @override
  String get buildSession => 'UŁÓŻ TRENING';

  @override
  String get tapMuscles => 'Dotknij mięśni, które chcesz trenować — z przodu i z tyłu.';

  @override
  String get continueBtn => 'DALEJ';

  @override
  String get nothingForFocus => 'Brak ćwiczeń dla tego celu';

  @override
  String get goBackPick => 'Wróć i wybierz mięsień, dla którego masz ćwiczenia w bibliotece.';

  @override
  String pickedHint(int n) {
    return 'Ułożyliśmy trening — dotknij, aby dodać lub usunąć dowolne z $n ćwiczeń.';
  }

  @override
  String get pickAnExercise => 'WYBIERZ ĆWICZENIE';

  @override
  String get searchAllExercises => 'Szukaj ćwiczenia…';

  @override
  String get noExercisesMatch => 'Brak pasujących ćwiczeń';

  @override
  String get createItInstead => 'Utwórz własne ćwiczenie';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ĆWICZEŃ', one: '$n ĆWICZENIE');
    return 'START · $_temp0';
  }

  @override
  String get inProgress => 'W TOKU';

  @override
  String get paused => 'WSTRZYMANO';

  @override
  String get last => 'OSTATNIO';

  @override
  String get rest => 'ODPOCZYNEK';

  @override
  String get skip => 'POMIŃ';

  @override
  String get addSet => '+ DODAJ SERIĘ';

  @override
  String get finishSession => 'ZAKOŃCZ TRENING';

  @override
  String get setDone => 'SERIA UKOŃCZONA';

  @override
  String get nextExercise => 'NASTĘPNE ĆWICZENIE';

  @override
  String get dropExerciseAction => 'Usuń ćwiczenie';

  @override
  String get restOff => 'Wył.';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'POWTÓRZENIA';

  @override
  String weightCol(String unit) {
    return 'CIĘŻAR ($unit)';
  }

  @override
  String get repsTitle => 'POWTÓRZENIA';

  @override
  String weightTitle(String unit) {
    return 'CIĘŻAR ($unit)';
  }

  @override
  String get sessionComplete => 'TRENING ZAPISANY';

  @override
  String get finishHeadlinePr => 'Nowy rekord życiowy';

  @override
  String get finishHeadlineGoal => 'Cel tygodniowy osiągnięty';

  @override
  String get finishHeadlineStreak => 'Seria utrzymana';

  @override
  String get finishHeadlineDefault => 'Kolejny trening za tobą';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs ćwiczeniach',
      one: 'jednym ćwiczeniu',
    );
    return 'Podniosłeś więcej niż kiedykolwiek w $_temp0. Wynik został zapisany.';
  }

  @override
  String get finishBodyGoal => 'Udało ci się wykonać zaplanowaną liczbę treningów w tym tygodniu.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak dni z rzędu. Najtrudniejsze jest nie przestawać.';
  }

  @override
  String get finishBodyDefault => 'Zapisane i policzone. To regularność napędza postęp.';

  @override
  String get vsLastTime => 'VS POPRZEDNIO';

  @override
  String get firstTime => 'Pierwszy zapis';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nowe rekordy',
      one: '$n nowy rekord',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'CZAS';

  @override
  String get setsCaps => 'SERIE';

  @override
  String exerciseXofY(int i, int n) {
    return 'ĆWICZENIE $i Z $n';
  }

  @override
  String get decrease => 'Zmniejsz';

  @override
  String get increase => 'Zwiększ';

  @override
  String markSet(int n) {
    return 'Oznacz serię $n jako ukończoną';
  }

  @override
  String get pauseWorkout => 'Wstrzymaj trening';

  @override
  String get resumeWorkout => 'Wznów trening';

  @override
  String get discardTitle => 'Odrzucić trening?';

  @override
  String get discardBody => 'Serie z tego treningu zostaną utracone.';

  @override
  String get keepTraining => 'Trenuj dalej';

  @override
  String get discard => 'Odrzuć';

  @override
  String get notifRestChannel => 'Minutnik odpoczynku';

  @override
  String get notifRestChannelWhy => 'Powiadamia, gdy przerwa między seriami się skończy';

  @override
  String get notifAlertChannel => 'Minutnik odpoczynku (alert)';

  @override
  String get notifAlertChannelWhy => 'Wyświetla baner od razu po zakończeniu przerwy';

  @override
  String get restOverTitle => 'Koniec odpoczynku';

  @override
  String get restOverBody => 'Wracamy — następna seria czeka.';

  @override
  String get allTimeSessions => 'TRENINGI';

  @override
  String get allTimeTime => 'CZAS';

  @override
  String get allTimeSets => 'SERIE';

  @override
  String get consistency => 'REGULARNOŚĆ';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n zapisanych treningów',
      one: '$n zapisany trening',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'Seria $n dni';
  }

  @override
  String get bodyweight => 'MASA CIAŁA';

  @override
  String get logBodyweight => 'ZAPISZ MASĘ';

  @override
  String get trackWeight => 'Śledź swoją masę w czasie';

  @override
  String get muscleMap => 'MAPA MIĘŚNI';

  @override
  String get days7 => '7 D';

  @override
  String get days30 => '30 D';

  @override
  String get heatLow => 'Nietrenowane';

  @override
  String get heatHigh => 'Maksymalna objętość';

  @override
  String get muscleMapEmpty => 'Zapisz trening, a twoje ciało zacznie się tutaj podświetlać.';

  @override
  String get muscleMapHint => 'Dotknij mięśnia, aby zobaczyć, ile pracował.';

  @override
  String muscleMapBehind(String names) {
    return 'W tyle: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% celu';
  }

  @override
  String get muscleSplit => 'PODZIAŁ MIĘŚNI';

  @override
  String get personalRecords => 'REKORDY OSOBISTE';

  @override
  String get strength1rm => 'SIŁA · SZAC. 1RM';

  @override
  String get strengthEmpty => 'Zapisz ćwiczenie dwa razy, a pojawi się tutaj jego krzywa siły.';

  @override
  String oneRmEst(String w) {
    return 'Szac. 1RM: $w';
  }

  @override
  String get restDayShort => 'Dzień odpoczynku';

  @override
  String get restDay => 'Dzień odpoczynku — nic nie zapisano.';

  @override
  String get delete => 'Usuń';

  @override
  String get deleteEntry => 'Usunąć ten wpis?';

  @override
  String deleteEntryBody(String name) {
    return '„$name” zostanie usunięte z tego dnia oraz z rekordów i wykresów.';
  }

  @override
  String get bodyweightHistory => 'HISTORIA';

  @override
  String get exercisesCaps => 'ĆWICZENIA';

  @override
  String get timeCaps => 'CZAS';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ćwiczeń w bibliotece',
      one: '$n ćwiczenie w bibliotece',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Szukaj ćwiczeń';

  @override
  String get muscleFilter => 'MIĘSIEŃ';

  @override
  String get levelFilter => 'POZIOM';

  @override
  String get kindLabel => 'RODZAJ';

  @override
  String get kindStrength => 'Siła';

  @override
  String get kindCalisthenics => 'Kalistenika';

  @override
  String get kindCardio => 'Cardio';

  @override
  String get kindStretch => 'Rozciąganie';

  @override
  String get newExercise => 'NOWE ĆWICZENIE';

  @override
  String get exerciseName => 'Nazwa ćwiczenia';

  @override
  String get equipmentLabel => 'SPRZĘT';

  @override
  String get addExercise => 'DODAJ ĆWICZENIE';

  @override
  String get advanced => 'ZAAWANSOWANE';

  @override
  String get demoMedia => 'DEMO';

  @override
  String get addMedia => 'Dodaj multimedia';

  @override
  String get mediaHint => 'Obraz, GIF lub wideo';

  @override
  String get changeMedia => 'Zmień';

  @override
  String get videoSelected => 'Wybrano wideo';

  @override
  String get favouritesOnly => 'Ulubione';

  @override
  String get noFavouritesYet => 'Brak ulubionych';

  @override
  String get noFavouritesHint => 'Dotknij gwiazdki przy ćwiczeniu, aby zachować je tutaj.';

  @override
  String get clearFilters => 'Wyczyść filtry';

  @override
  String get noExercisesFound => 'Nie znaleziono ćwiczeń';

  @override
  String get noExercisesHint => 'Spróbuj innego wyszukiwania lub wyczyść filtry.';

  @override
  String get personalRecord => 'REKORD OSOBISTY';

  @override
  String get history => 'HISTORIA';

  @override
  String get noHistory => 'Nie zapisano jeszcze treningów. Wykonuj to ćwiczenie, aby zbudować historię.';

  @override
  String get notes => 'NOTATKI';

  @override
  String get notePlaceholder => 'Wskazówki, ustawienie, odczucia…';

  @override
  String notHere(String gear, String place) {
    return 'Brak $gear w $place';
  }

  @override
  String get notHereWhy => 'Zamień na coś, czego możesz dziś faktycznie użyć.';

  @override
  String get altHere => 'CO MOŻESZ TU ZROBIĆ';

  @override
  String get places => 'MOJE MIEJSCA';

  @override
  String get placesHint =>
      'Podaj sprzęt dostępny w każdym miejscu, a biblioteka pokaże tylko to, co możesz tam wykonać.';

  @override
  String get placeAll => 'Wszędzie';

  @override
  String get placeNew => 'Nowe miejsce';

  @override
  String get placeNamePlaceholder => 'Dom, siłownia, park…';

  @override
  String get placeGearLabel => 'DOSTĘPNY SPRZĘT';

  @override
  String placeExercises(int n) {
    return '$n ćwiczeń tutaj';
  }

  @override
  String get placeEmptyTitle => 'Trenuj, gdziekolwiek jesteś';

  @override
  String get placeEmptyBody =>
      'Miejsce to lista sprzętu, który masz w danej lokalizacji. Wybierz jedno na początek i edytuj później.';

  @override
  String get placeDeleteTitle => 'Usuń miejsce';

  @override
  String get placeDeleteBody => 'Usunięte zostanie tylko miejsce — ćwiczenia i treningi zostaną.';

  @override
  String get placeGym => 'Siłownia';

  @override
  String get placeHome => 'Dom';

  @override
  String get placeOutdoors => 'Na zewnątrz';

  @override
  String get placeFilterLabel => 'MIEJSCE';

  @override
  String get noGearOnly => 'Bez sprzętu';

  @override
  String placeActive(String name) {
    return 'Trening w $name';
  }

  @override
  String get journal => 'DZIENNIK';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notatek',
      one: '1 notatka',
      zero: 'Brak notatek',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Notatka';

  @override
  String get noteKindPlan => 'Plan';

  @override
  String get noteKindDone => 'Sukces';

  @override
  String get noteKindPain => 'Dolegliwość';

  @override
  String get noteFilterAll => 'Wszystkie';

  @override
  String get newNote => 'Nowa notatka';

  @override
  String get editNote => 'Edytuj notatkę';

  @override
  String get addNote => 'DODAJ NOTATKĘ';

  @override
  String get noteEmptyTitle => 'Jeszcze nic nie zapisano';

  @override
  String get noteEmptyBody =>
      'Wskazówki, plany na następny raz, odczucia po treningu — opcjonalnie ze zdjęciami lub filmem.';

  @override
  String get noteNoneForExercise => 'Brak notatek do tego ćwiczenia.';

  @override
  String get noteKindLabel => 'TYP';

  @override
  String get noteTextLabel => 'NOTATKA';

  @override
  String get noteDateLabel => 'DATA';

  @override
  String get noteExerciseLabel => 'ĆWICZENIE';

  @override
  String get noteMediaLabel => 'ZDJĘCIA I WIDEO';

  @override
  String get noteGeneral => 'Brak ćwiczenia';

  @override
  String get noteAttach => 'Dołącz';

  @override
  String get noteRemoveMedia => 'Usuń załącznik';

  @override
  String get deleteNoteTitle => 'Usuń notatkę';

  @override
  String get deleteNoteBody => 'Notatka i wszystkie załączniki zostaną trwale usunięte.';

  @override
  String get noteToday => 'Dzisiaj';

  @override
  String get noteYesterday => 'Wczoraj';

  @override
  String get noteAllNotes => 'Wszystkie notatki';

  @override
  String get noteCalendar => 'Kalendarz';

  @override
  String get noteNoneOnDay => 'Nic nie zapisano tego dnia';

  @override
  String get noteAddOnDay => 'Dodaj notatkę na ten dzień';

  @override
  String get notePrevMonth => 'Poprzedni miesiąc';

  @override
  String get noteNextMonth => 'Następny miesiąc';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notatek w tym miesiącu',
      one: '1 notatka w tym miesiącu',
      zero: 'Brak notatek w tym miesiącu',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'POMIARY';

  @override
  String get measuresHint => 'Od szyi po łydkę — obserwuj zmiany ciała, nie tylko ciężar na sztandze.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pomiarów',
      one: '1 pomiar',
      zero: 'Brak pomiarów',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Jeszcze nie zmierzono';

  @override
  String get measureHistory => 'HISTORIA';

  @override
  String get measureNeck => 'Szyja';

  @override
  String get measureShoulders => 'Barki';

  @override
  String get measureChest => 'Klatka';

  @override
  String get measureArm => 'Ramię';

  @override
  String get measureForearm => 'Przedramię';

  @override
  String get measureWaist => 'Talia';

  @override
  String get measureHips => 'Biodra';

  @override
  String get measureThigh => 'Udo';

  @override
  String get measureCalf => 'Łydka';

  @override
  String get measureBodyfat => 'Tkanka tłuszczowa';

  @override
  String get timeline => 'OŚ CZASU';

  @override
  String get timelineHint => 'Ta sama poza, to samo miejsce, to samo światło. Za rok nie uwierzysz.';

  @override
  String get timelineEmptyTitle => 'Pierwsze zdjęcie rozpoczyna śledzenie';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n zdjęć',
      one: '1 zdjęcie',
      zero: 'Brak zdjęć',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Przód';

  @override
  String get poseSide => 'Bok';

  @override
  String get poseBack => 'Tył';

  @override
  String get photoEvery => 'PRZYPOMNIJ';

  @override
  String photoEveryDays(int n) {
    return 'Co $n dni';
  }

  @override
  String get photoEveryOff => 'Nigdy';

  @override
  String get timelineEvery => 'GRUPUJ CO';

  @override
  String get custom => 'Niestandardowo';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Następne zdjęcie za $n dni',
      one: 'Następne zdjęcie jutro',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Czas na zdjęcie — zrób je dziś';

  @override
  String get addTodayPhotos => 'DODAJ DZISIEJSZE ZDJĘCIA';

  @override
  String posePhoto(String pose) {
    return 'Zdjęcie: $pose';
  }

  @override
  String get compare => 'PORÓWNAJ';

  @override
  String get compareNeedTwo => 'Zrób tę samą pozę w dwa różne dni, aby porównać je tutaj.';

  @override
  String dayNumber(int n) {
    return 'Dzień $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n dni różnicy',
      one: '1 dzień różnicy',
      zero: 'Ten sam dzień',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Usuń ten dzień';

  @override
  String get deleteDayBody => 'Zdjęcia z tego dnia zostaną również trwale usunięte.';

  @override
  String get timelinePhotos => 'Zdjęcia';

  @override
  String get timelineBody => 'Mapa mięśni';

  @override
  String get timelineBodyEmpty => 'Zapisz trening, a mapa mięśni zacznie się tutaj wypełniać — bez zdjęć.';

  @override
  String get timelineBodyHint => 'Tworzone z twoich serii — nic nie jest wysyłane.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treningów',
      one: '1 trening',
      zero: 'Brak treningów',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Zdjęcia postępów';

  @override
  String get notifPhotoChannelWhy => 'Przypomnienie, gdy nadejdzie czas na kolejne zdjęcie postępów.';

  @override
  String get notifPhotoTitle => 'Czas na zdjęcie postępów';

  @override
  String notifPhotoBody(int n) {
    return '$n dni od poprzedniego. Ta sama poza, to samo światło.';
  }

  @override
  String get share => 'UDOSTĘPNIJ';

  @override
  String get sharePick => 'Co chcesz pokazać?';

  @override
  String get shareStreak => 'Seria i regularność';

  @override
  String get shareBody => 'Trenowane mięśnie';

  @override
  String get shareCompare => 'Przed / po';

  @override
  String get shareHint =>
      'Karta powstaje na telefonie. Nic go nie opuszcza, dopóki nie wybierzesz, gdzie ją wysłać.';

  @override
  String get shareFailed => 'Nie udało się utworzyć karty';

  @override
  String get shareWeekOf => 'OSTATNIE 7 DNI';

  @override
  String get shareStreakLabel => 'DNI Z RZĘDU';

  @override
  String get shareSessionsLabel => 'TRENINGI';

  @override
  String get shareVolumeLabel => 'OBJĘTOŚĆ';

  @override
  String get restForExercise => 'ODPOCZYNEK DLA TEGO ĆWICZENIA';

  @override
  String get restUsingDefault => 'Używa domyślnego czasu';

  @override
  String get restCustom => 'Tylko dla tego';

  @override
  String get setType => 'TYP SERII';

  @override
  String get setTypeNormal => 'Robocza';

  @override
  String get setTypeWarmup => 'Rozgrzewka';

  @override
  String get setTypeDrop => 'Drop set';

  @override
  String get setTypeFailure => 'Do upadku';

  @override
  String get addWarmup => 'ROZGRZEWKA';

  @override
  String platesPerSide(String plates) {
    return 'Na stronę: $plates';
  }

  @override
  String get howTo => 'JAK WYKONAĆ';

  @override
  String get similar => 'PODOBNE';

  @override
  String get primaryLabel => 'GŁÓWNY';

  @override
  String get secondaryLabel => 'DRUGORZĘDNY';

  @override
  String get none => 'Brak';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n serii', one: '$n seria');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'objętość $v';
  }

  @override
  String get weeklyPlan => 'PLAN TYGODNIOWY';

  @override
  String get yourRoutines => 'TWOJE PLANY';

  @override
  String get noRoutines => 'Brak planów. Utwórz jeden i dodaj ćwiczenia.';

  @override
  String get newRoutine => 'NOWY PLAN';

  @override
  String get routineName => 'Nazwa planu';

  @override
  String get schedule => 'HARMONOGRAM';

  @override
  String get addFromList => 'Dodaj ćwiczenia z poniższej listy.';

  @override
  String get addExercises => 'Dodaj ćwiczenia';

  @override
  String get deleteRoutine => 'Usunąć ten plan?';

  @override
  String exercisesWithCount(int n) {
    return 'ĆWICZENIA · $n';
  }

  @override
  String setDay(String day) {
    return 'USTAW $day';
  }

  @override
  String get newRoutineName => 'Nowy plan';

  @override
  String get dragToReorder =>
      'Przeciągnij uchwyt z kropkami, aby zmienić kolejność — w tej kolejności trenujesz.';

  @override
  String reorderHandle(String name) {
    return 'Zmień kolejność: $name';
  }

  @override
  String get removeFromRoutine => 'Usuń z planu';

  @override
  String get dropExercise => 'Usunąć to ćwiczenie?';

  @override
  String dropExerciseBody(String name) {
    return '„$name” zostanie usunięte z treningu. Zapisane dane nie zostaną utracone.';
  }

  @override
  String get drop => 'Usuń';

  @override
  String get resetData => 'Usuń wszystkie moje dane';

  @override
  String get resetTitle => 'Usunąć wszystko?';

  @override
  String get resetBody =>
      'Treningi, rekordy, plany, notatki i profil. Tego nie można cofnąć — najpierw wyeksportuj kopię zapasową, jeśli możesz ich potrzebować.';

  @override
  String get resetConfirm => 'Usuń wszystko';

  @override
  String get resetDone => 'Wszystkie dane usunięte';

  @override
  String get support => 'POMOC';

  @override
  String get reportBug => 'Zgłoś błąd';

  @override
  String get requestFeature => 'Zaproponuj funkcję';

  @override
  String get starOnGithub => 'Dodaj gwiazdkę na GitHubie';

  @override
  String get buyCoffee => 'Postaw mi kawę';

  @override
  String get cantOpenLink => 'Nie udało się otworzyć linku';

  @override
  String get theme => 'Motyw';

  @override
  String get darkTheme => 'Ciemny';

  @override
  String get lightTheme => 'Jasny';

  @override
  String get languageLabel => 'Język';

  @override
  String get unitsLabel => 'Jednostki';

  @override
  String get restTimer => 'Minutnik odpoczynku';

  @override
  String get alarmBlockedTitle => 'Powiadomienia są wyłączone';

  @override
  String get alarmBlockedBody => 'Alarm odpoczynku nie zabrzmi przy zablokowanym ekranie';

  @override
  String get alarmBlockedAction => 'WŁĄCZ';

  @override
  String get alarmSound => 'Dźwięk alarmu';

  @override
  String get alarmDefaultName => 'Domyślny';

  @override
  String get alarmSoundHint => 'Użyj własnego dźwięku — maksymalnie 15 sekund';

  @override
  String get alarmChoose => 'Wybierz dźwięk…';

  @override
  String get alarmPreview => 'Odtwórz bieżący dźwięk';

  @override
  String get alarmReset => 'Przywróć domyślny dźwięk';

  @override
  String get alarmTooLong => 'Ten dźwięk trwa dłużej niż 15 sekund';

  @override
  String get alarmInvalid => 'Nie udało się odczytać pliku audio';

  @override
  String alarmChanged(String name) {
    return 'Ustawiono dźwięk alarmu na „$name”';
  }

  @override
  String get alarmChangedDefault => 'Przywrócono domyślny dźwięk';

  @override
  String get addActivityWidget => 'Dodaj widżet aktywności';

  @override
  String get addStatsWidget => 'Dodaj widżet statystyk';

  @override
  String get pinUnsupported => 'Dodaj go z menu widżetów programu uruchamiającego';

  @override
  String get background => 'Tło';

  @override
  String get bgNone => 'Brak';

  @override
  String get bgDots => 'Kropki';

  @override
  String get bgGrid => 'Siatka';

  @override
  String get exportCsv => 'Eksportuj treningi (CSV)';

  @override
  String get exportBackup => 'Eksportuj kopię zapasową (ZIP)';

  @override
  String get importBackup => 'Importuj kopię zapasową';

  @override
  String get importHint =>
      'Wybierz kopię .zip (lub starszy .json) wyeksportowaną z GymMane. Zastąpi ona bieżące dane, w tym multimedia.';

  @override
  String get import => 'Importuj';

  @override
  String get chooseFile => 'Wybierz plik';

  @override
  String get importFromApp => 'Importuj z innej aplikacji';

  @override
  String get importUnknownFormat => 'Plik musi zawierać kolumny: data, ćwiczenie, powtórzenia i ciężar';

  @override
  String get importZipNoWeights => 'Ten plik ZIP nie zawiera pliku z wagą';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pomiarów masy zaimportowano',
      one: '$n pomiar masy zaimportowany',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Nie udało się odczytać pliku';

  @override
  String get importUnitTitle => 'Jakiej jednostki używa ten plik?';

  @override
  String get importUnitBody => 'Ten eksport nie podaje jednostki wagi.';

  @override
  String get importNothing => 'Brak nowych danych do importu';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treningów zaimportowano',
      one: '$n trening zaimportowany',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'O GymMane';

  @override
  String get yourProfile => 'TWÓJ PROFIL';

  @override
  String get autofills => 'Automatycznie uzupełnia kalkulatory';

  @override
  String get nameLabel => 'IMIĘ';

  @override
  String get sexLabel => 'PŁEĆ';

  @override
  String get macroProtein => 'BIAŁKO';

  @override
  String get macroCarbs => 'WĘGLOWODANY';

  @override
  String get macroFat => 'TŁUSZCZ';

  @override
  String get male => 'Mężczyzna';

  @override
  String get female => 'Kobieta';

  @override
  String get ageLabel => 'WIEK';

  @override
  String get heightLabel => 'WZROST';

  @override
  String get weightLabel => 'WAGA';

  @override
  String get weeklyGoal => 'CEL TYGODNIOWY';

  @override
  String get activityLabel => 'AKTYWNOŚĆ';

  @override
  String get addPhoto => 'Dodaj zdjęcie';

  @override
  String get removePhoto => 'Usuń zdjęcie';

  @override
  String get takePhoto => 'Zrób zdjęcie';

  @override
  String get chooseGallery => 'Wybierz z galerii';

  @override
  String get backupImported => 'Kopia zapasowa zaimportowana';

  @override
  String get backupFailed => 'Nie udało się odczytać kopii zapasowej';

  @override
  String get nothingToExport => 'Nie ma jeszcze czego eksportować — najpierw zapisz trening';

  @override
  String calculatorsCount(int n) {
    return '$n kalkulatorów do treningu';
  }

  @override
  String get result => 'WYNIK';

  @override
  String get weightLifted => 'PODNIESIONY CIĘŻAR';

  @override
  String get repsPerformed => 'WYKONANE POWTÓRZENIA';

  @override
  String get neck => 'SZYJA';

  @override
  String get waist => 'TALIA';

  @override
  String get hip => 'BIODRA (kobiety)';

  @override
  String get targetWeight => 'WAGA DOCELOWA';

  @override
  String get workingWeight => 'CIĘŻAR ROBOCZY';

  @override
  String get activityLevel => 'POZIOM AKTYWNOŚCI';

  @override
  String get barWeight => 'WAGA GRYFU';

  @override
  String get perSide => 'NA STRONĘ';

  @override
  String get justTheBar => 'Tylko gryf.';

  @override
  String perSideCount(int n) {
    return '× $n na stronę';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'Kalorie';

  @override
  String get toolNameBf => 'Tkanka tłuszczowa';

  @override
  String get toolNamePlate => 'Talerze';

  @override
  String get toolNameWarmup => 'Rozgrzewka';

  @override
  String get toolTitleRm => 'Kalkulator 1RM';

  @override
  String get toolTitleBmi => 'Kalkulator BMI';

  @override
  String get toolTitleCal => 'Kalorie i makro';

  @override
  String get toolTitleBf => '% tkanki tłuszczowej';

  @override
  String get toolTitlePlate => 'Kalkulator talerzy';

  @override
  String get toolTitleWarmup => 'Serie rozgrzewkowe';

  @override
  String get toolHintRm => 'Szacowane maksimum na 1 powtórzenie (wzór Epleya)';

  @override
  String get toolHintCal => 'Szacowane dzienne zapotrzebowanie na utrzymanie';

  @override
  String get toolHintBf => 'Szacunek metodą US Navy';

  @override
  String get toolHintPlate => 'Łączny ciężar sztangi';

  @override
  String get toolHintWarmup => 'Docelowy ciężar roboczy';

  @override
  String get toolDescRm => 'Szacowane maksimum na jedno powtórzenie';

  @override
  String get toolDescBmi => 'Wskaźnik masy ciała';

  @override
  String get toolDescCal => 'Kalorie i makroskładniki';

  @override
  String get toolDescBf => 'Procent tkanki tłuszczowej';

  @override
  String get toolDescPlate => 'Kalkulator talerzy';

  @override
  String get toolDescWarmup => 'Serie narastające rozgrzewki';

  @override
  String get bmiUnderweight => 'Niedowaga';

  @override
  String get bmiNormal => 'Prawidłowa masa';

  @override
  String get bmiOverweight => 'Nadwaga';

  @override
  String get bmiObese => 'Otyłość';

  @override
  String get actSedentary => 'Siedzący';

  @override
  String get actLight => 'Lekki';

  @override
  String get actActive => 'Aktywny';

  @override
  String get actModerate => 'Umiarkowany';

  @override
  String get muscleChest => 'Klatka piersiowa';

  @override
  String get muscleBack => 'Plecy';

  @override
  String get muscleShoulders => 'Barki';

  @override
  String get muscleBiceps => 'Biceps';

  @override
  String get muscleTriceps => 'Triceps';

  @override
  String get muscleForearm => 'Przedramię';

  @override
  String get muscleTrapezius => 'Kaptury';

  @override
  String get muscleAbdomen => 'Brzuch';

  @override
  String get muscleObliques => 'Mięśnie skośne';

  @override
  String get muscleQuads => 'Czworogłowe';

  @override
  String get muscleHamstrings => 'Dwugłowe uda';

  @override
  String get muscleGlutes => 'Pośladki';

  @override
  String get muscleCalves => 'Łydki';

  @override
  String get mgChest => 'Klatka';

  @override
  String get mgBack => 'Plecy';

  @override
  String get mgLegs => 'Nogi';

  @override
  String get mgShoulders => 'Barki';

  @override
  String get mgArms => 'Ramiona';

  @override
  String get mgCore => 'Core';

  @override
  String get equipBarbell => 'Sztanga';

  @override
  String get equipDumbbell => 'Hantla';

  @override
  String get equipCable => 'Wyciąg';

  @override
  String get equipMachine => 'Maszyna';

  @override
  String get equipBodyweight => 'Masa ciała';

  @override
  String get equipWeighted => 'Z obciążeniem';

  @override
  String get equipBand => 'Guma';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Kółka';

  @override
  String get equipOther => 'Inne';

  @override
  String get diffBeginner => 'Początkujący';

  @override
  String get diffAdvanced => 'Zaawansowany';

  @override
  String get diffIntermediate => 'Średniozaawansowany';

  @override
  String get about => 'O APLIKACJI';

  @override
  String version(String v) {
    return 'Wersja $v';
  }

  @override
  String get aboutBlurb => 'Stworzone przez ćwiczących dla ćwiczących.';

  @override
  String get freeForever => 'Darmowe na zawsze';

  @override
  String get freeForeverWhy => 'Bez subskrypcji, bez reklam, bez płatnych blokad.';

  @override
  String get fullyOffline => '100% offline';

  @override
  String get fullyOfflineWhy => 'Bez konta, bez serwera. Twoje treningi nigdy nie opuszczają telefonu.';

  @override
  String get yoursToTake => 'Twoje dane należą do ciebie';

  @override
  String get yoursToTakeWhy => 'Eksportuj do CSV kiedy chcesz i usuń wszystko jednym ruchem.';

  @override
  String get whatsInside => 'ZAWARTOŚĆ';

  @override
  String exercisesInside(int n) {
    return '$n ćwiczeń';
  }

  @override
  String get exercisesInsideWhy => 'Każde z animacją i instrukcją krok po kroku.';

  @override
  String get calculatorsInside => '8 kalkulatorów';

  @override
  String get calculatorsInsideWhy =>
      '1RM, talerze, BMI, kalorie, tkanka tłuszczowa, rozgrzewka, ciężar według RPE i poziom siły DOTS — wszystko na podstawie opublikowanych wzorów.';

  @override
  String get mathInside => 'Przejrzyste obliczenia';

  @override
  String get mathInsideWhy =>
      'Objętość, rekordy i serie są liczone z twoich danych. Nic nie jest tylko ozdobą.';

  @override
  String get streakCaps => 'SERIA';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'dni', one: 'dzień');
    return '$_temp0';
  }

  @override
  String get reset => 'RESETUJ';

  @override
  String get welcomeKicker => 'WITAJ W';

  @override
  String get welcomeBlurb => 'Wszystko zostaje na telefonie. Bez konta, bez internetu, bez opłat.';

  @override
  String get welcomeStart => 'ZACZNIJ';

  @override
  String onbStep(int i, int n) {
    return 'KROK $i Z $n';
  }

  @override
  String get onbNameTitle => 'Jak mamy się do ciebie zwracać?';

  @override
  String get onbNameHint => 'Twoje imię';

  @override
  String get onbNameWhy => 'Używane tylko do powitania. Nigdy nie opuszcza telefonu.';

  @override
  String get onbBodyTitle => 'Kilka danych';

  @override
  String get onbBodyWhy => 'Służą do kalkulatorów. Możesz je zmienić w Ustawieniach w dowolnym momencie.';

  @override
  String get onbGoalTitle => 'Jak często trenujesz?';

  @override
  String get onbGoalWhy => 'Ustala cel tygodniowy. Bądź realistą, nie przesadzaj z ambicją.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treningów tygodniowo',
      one: '$n trening tygodniowo',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Kilogramy czy funty?';

  @override
  String get next => 'DALEJ';

  @override
  String get back => 'WSTECZ';

  @override
  String get skip2 => 'Pomiń';

  @override
  String get madeWithLoveBy => 'STWORZONE Z MIŁOŚCIĄ PRZEZ';

  @override
  String get sourceCode => 'KOD ŹRÓDŁOWY';

  @override
  String get suggested => 'SUGEROWANE';

  @override
  String get results => 'WYNIKI';

  @override
  String get noMatches => 'Żadne ćwiczenie nie pasuje do wyszukiwania.';

  @override
  String get tapToEdit => 'Dotknij ołówka, aby poprawić wpis, lub kosza, aby go usunąć.';

  @override
  String get editEntry => 'Edytuj';

  @override
  String get editEntryHint => 'Popraw powtórzenia lub ciężar dowolnej serii.';

  @override
  String get removeSet => 'Usuń serię';

  @override
  String get continueWorkout => 'KONTYNUUJ';

  @override
  String get continueWorkoutBody =>
      'Trening zostanie wznowiony z już zaznaczonymi seriami. Po ponownym zakończeniu zostanie zapisany z pierwotną datą.';

  @override
  String get addBodyWidget => 'Dodaj widżet mapy mięśni';

  @override
  String get repsOnly => 'Tylko powtórzenia';

  @override
  String get repsOnlyHint => 'Zapisuj to ćwiczenie bez ciężaru.';

  @override
  String get useDefaultArt => 'Przywróć domyślną ilustrację';

  @override
  String daysShort(int n) {
    return '$n d';
  }

  @override
  String get focusCard => 'Dzisiejszy cel';

  @override
  String get autoAdvance => 'Automatycznie przechodź dalej';

  @override
  String get keepScreenOn => 'Nie wygaszaj ekranu podczas treningu';

  @override
  String get lockWorkout => 'Zablokuj ekran';

  @override
  String get unlockWorkout => 'Odblokuj';

  @override
  String get holdToUnlock => 'Przytrzymaj, aby odblokować';

  @override
  String get liveChannel => 'Trwający trening';

  @override
  String get liveChannelWhy => 'Pokazuje bieżące ćwiczenie, serię i czas przerwy podczas treningu';

  @override
  String liveSet(int n, int total) {
    return 'Seria $n z $total';
  }

  @override
  String get liveResting => 'Przerwa';

  @override
  String get liveAllDone => 'Wszystkie serie zrobione';

  @override
  String get autoAdvanceHint =>
      'Po zaznaczeniu ostatniej serii ćwiczenia trening automatycznie przejdzie dalej.';

  @override
  String get autoProgress => 'Dodaj ciężar następnym razem';

  @override
  String autoProgressHint(String w) {
    return 'Wykonaj wszystkie powtórzenia, a następny trening zacznie się z ciężarem większym o $w.';
  }

  @override
  String get placePlates => 'Talerze i gryf';

  @override
  String get platesAll => 'Wszystko dostępne';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rozmiarów', one: '$n rozmiar');
    return '$_temp0';
  }

  @override
  String get platePairs => 'PARY';

  @override
  String plateAchievable(String w) {
    return 'Najbliższy możliwy ciężar: $w';
  }

  @override
  String get autoWarmup => 'Zacznij od serii rozgrzewkowych';

  @override
  String get autoWarmupHint => 'Dodaje serie narastające po otwarciu treningu.';

  @override
  String get trainReminder => 'Przypomnienie o treningu';

  @override
  String get trainReminderHint => 'Przypomnienie o tej porze tylko w dni, na które zaplanowano plan.';

  @override
  String get reminderExactTime => 'Dokładna godzina';

  @override
  String get toastSoundSetting => 'Dźwięk powiadomień';

  @override
  String get toastSoundHint => 'Delikatny dźwięk, gdy u góry pojawia się powiadomienie.';

  @override
  String get notifTrainChannel => 'Przypomnienie o treningu';

  @override
  String get notifTrainChannelWhy => 'Przypomnienie o treningu w zaplanowane dni.';

  @override
  String get notifTrainTitle => 'Czas na trening';

  @override
  String get notifTrainBody => 'Twój plan czeka.';

  @override
  String get planIntro => 'Ułóż mi plan treningowy używając tylko ćwiczeń z tej listy.';

  @override
  String get planFormat => 'Odpowiedz wyłącznie w JSON, w tym formacie:';

  @override
  String get planNothing => 'Żadne ćwiczenie z tego pliku nie pasuje do twojej biblioteki';

  @override
  String get planFailed => 'Ten plik nie jest planem, który GymMane potrafi odczytać';

  @override
  String get routineGroup => 'Grupa';

  @override
  String get newGroup => 'Nowa grupa';

  @override
  String get noGroup => 'Brak grupy';

  @override
  String get groupNameHint => 'Push / Pull / Nogi, 5×5…';

  @override
  String get filters => 'Filtry';

  @override
  String get setsPlannedHint =>
      'Wybierz liczbę serii dla każdego ćwiczenia. Trening otworzy się z gotowym planem.';

  @override
  String get nextTime => 'NASTĘPNYM RAZEM';

  @override
  String get nextHold => 'utrzymuj ten sam ciężar, aż wykonasz wszystkie powtórzenia';

  @override
  String get bgPhoto => 'Twoje zdjęcie';

  @override
  String get bgPhotoPick => 'Wybierz zdjęcie';

  @override
  String get bgPhotoChange => 'Zmień zdjęcie';

  @override
  String get bgPhotoRemove => 'Usuń zdjęcie';

  @override
  String get bgDim => 'PRZYCIEMNIENIE';

  @override
  String get dimSoft => 'Lekkie';

  @override
  String get dimMedium => 'Średnie';

  @override
  String get dimStrong => 'Mocne';

  @override
  String get bgPhotoHint =>
      'Pojawia się za całym interfejsem, przyciemnione, aby aplikacja pozostała czytelna.';

  @override
  String get reminderSmart => 'Inteligentne';

  @override
  String get reminderFixed => 'Stała godzina';

  @override
  String get reminderSmartHint =>
      'Używa dni i godzin, w których faktycznie trenujesz, i milczy, jeśli tego dnia trening już był.';

  @override
  String get reminderSmartEmpty => 'Zapisz jeszcze kilka treningów, aby aplikacja poznała twoje nawyki.';

  @override
  String habitFocus(String day) {
    return 'co zwykle trenujesz w $day';
  }

  @override
  String get duplicateRoutine => 'Duplikuj plan';

  @override
  String copySuffix(String name) {
    return '$name (kopia)';
  }

  @override
  String get saveAsRoutine => 'ZAPISZ JAKO PLAN';

  @override
  String get savedAsRoutine => 'Zapisano jako plan';

  @override
  String get templates => 'Gotowe plany';

  @override
  String get templatesHint => 'Klasyczne plany zbudowane z twojej biblioteki. Potem możesz wszystko zmienić.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n plany dodane',
      one: '$n plan dodany',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Trzy treningi całego ciała w tygodniu. Idealne na początek.';

  @override
  String get tplPpl => 'Push, pull i nogi. Trzy lub sześć dni w tygodniu.';

  @override
  String get tplUpperlower => 'Góra i dół ciała, cztery dni w tygodniu.';

  @override
  String get tplStronglifts => 'Dwa naprzemienne treningi po pięć serii po pięć powtórzeń.';

  @override
  String get tplStartingstrength => 'Przysiad na każdym treningu, z dwoma naprzemiennymi zestawami.';

  @override
  String get tplHome => 'Tylko drążek do podciągania i podłoga.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dni', one: '$n dzień');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Zapisuj wysiłek (RPE)';

  @override
  String get rpeHint => '10 = brak możliwości kolejnego powtórzenia; 8 = około dwa powtórzenia w zapasie.';

  @override
  String get superset => 'Superseria';

  @override
  String get supersetLink => 'Połącz z następnym';

  @override
  String get supersetHint =>
      'Bez odpoczynku między połączonymi ćwiczeniami — przechodzisz od razu do następnego.';

  @override
  String get aiRoutine => 'Plan z AI';

  @override
  String get aiIntro =>
      'GymMane nigdy nie łączy się bezpośrednio z AI. Eksportujesz listę ćwiczeń, wklejasz ją do używanego asystenta, a potem importujesz jego odpowiedź. Nic samo nie opuszcza telefonu.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nazw nie było w bibliotece',
      one: '1 nazwy nie było w bibliotece',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Obsługiwane aplikacje';

  @override
  String get importOtherCsv => 'Każdy inny CSV z datą, ćwiczeniem, powtórzeniami i ciężarem';

  @override
  String get importAskApp => 'Potrzebujesz innej aplikacji? Poproś o jej dodanie';

  @override
  String get awardFirstStepName => 'Pierwszy krok';

  @override
  String get awardFirstStepLine => 'Witaj w GymMane. Ten dostajesz w prezencie.';

  @override
  String get awardFirstWorkoutName => 'Pierwszy trening';

  @override
  String get awardFirstWorkoutLine => 'Pierwszy zapisany. To najtrudniejszy.';

  @override
  String get awardFirstRoutineName => 'Pierwszy plan';

  @override
  String get awardFirstRoutineLine => 'Masz teraz plan, do którego możesz wracać.';

  @override
  String get awardFirstRecordName => 'Pierwszy rekord';

  @override
  String get awardFirstRecordLine => 'Pobiłeś swój najlepszy wynik w ćwiczeniu.';

  @override
  String get awardStreak3Name => 'Trzy z rzędu';

  @override
  String get awardStreak3Line => 'Trzy dni z rzędu. Tak to się zaczyna.';

  @override
  String get awardTonne1Name => 'Jedna tona';

  @override
  String get awardTonne1Line => 'Łącznie tysiąc kilogramów podniesionych w seriach.';

  @override
  String get awardSets100Name => 'Sto serii';

  @override
  String get awardSets100Line => 'Sto ukończonych serii, jedna po drugiej.';

  @override
  String get awardHours10Name => 'Dziesięć godzin';

  @override
  String get awardHours10Line => 'Dziesięć godzin treningu na liczniku.';

  @override
  String get awardWorkouts50Name => 'Pięćdziesiąt treningów';

  @override
  String get awardWorkouts50Line => 'Pięćdziesiąt treningów za tobą.';

  @override
  String get awardHours50Name => 'Pięćdziesiąt godzin';

  @override
  String get awardHours50Line => 'Pięćdziesiąt godzin spędzonych na treningu.';

  @override
  String get awardsTitle => 'Medale';

  @override
  String get yearTitle => 'Twój rok';

  @override
  String get yearBestMonth => 'Najlepszy miesiąc';

  @override
  String get yearMonths => 'miesięcy';

  @override
  String get awardSpinHint => 'Przeciągnij medal, aby go obrócić';

  @override
  String get awardUnlocked => 'Odblokowano nowe osiągnięcie';

  @override
  String get awardNice => 'Brawo!';

  @override
  String get awardSaveImage => 'Zapisz obraz';

  @override
  String get awardSaved => 'Zapisano w galerii';

  @override
  String get awardStreak7Name => 'Siedem dni';

  @override
  String get awardStreak7Line => 'Cały tydzień bez opuszczenia dnia.';

  @override
  String get awardStreak30Name => 'Trzydzieści dni';

  @override
  String get awardStreak30Line => 'Miesiąc z rzędu. Teraz to już nawyk.';

  @override
  String get awardWorkouts100Name => 'Sto treningów';

  @override
  String get awardWorkouts100Line => 'Sto treningów zapisanych od początku do końca.';

  @override
  String get awardTonnes100Name => 'Sto ton';

  @override
  String get awardTonnes100Line => 'Wszystko, co podniosłeś, daje 100 000 kg.';

  @override
  String get awardSets1000Name => 'Tysiąc serii';

  @override
  String get awardSets1000Line => 'Seria po serii, aż do tysiąca.';

  @override
  String get profile => 'Profil';

  @override
  String get editProfile => 'Edytuj profil';

  @override
  String get pickBadge => 'Odznaka';

  @override
  String get statWorkouts => 'Treningi';

  @override
  String get statTrained => 'Trening';

  @override
  String get statSets => 'Serie';

  @override
  String get statLifted => 'Podniesiono';

  @override
  String get statStreak => 'Seria';

  @override
  String get statDays => 'dni';

  @override
  String get unitHours => 'g';

  @override
  String get unitDays => 'dni';

  @override
  String get snapshots => 'Zdjęcia';

  @override
  String get snapNow => 'Zrób teraz';

  @override
  String get addCover => 'Dodaj okładkę';

  @override
  String get addTodayWidget => 'Czy dzisiejszy trening wykonany';

  @override
  String get photosCard => 'Twoje zdjęcia';

  @override
  String get handleLabel => 'Nazwa użytkownika';

  @override
  String get setupTitle => 'Uzupełnij te dane, a reszta strony wypełni się automatycznie';

  @override
  String get setupHint => 'Każda liczba pochodzi z twoich zapisów. Nic nie jest nigdzie wysyłane.';

  @override
  String get setupWorkout => 'Zapisz pierwszy trening';

  @override
  String get setupWeight => 'Zapisz masę ciała';

  @override
  String get setupMeasures => 'Zrób pomiary ciała';

  @override
  String get setupPhoto => 'Zrób pierwsze zdjęcie postępów';

  @override
  String get progressTitle => 'Postęp';

  @override
  String get tileVolume30 => 'Objętość · 30 d';

  @override
  String get tileAddWeight => 'Dodaj swoje';

  @override
  String get heatToneTitle => 'Kolor mapy cieplnej';

  @override
  String get heatToneHint => 'Zmienia tylko kolor siatki i ciała.';

  @override
  String get thisWeekTitle => 'Ten tydzień';

  @override
  String get momentsEmptyTitle => 'Jeszcze nic tu nie ma';

  @override
  String get deletePhotoTitle => 'Usunąć to zdjęcie?';

  @override
  String get deletePhotoBody => 'Zostanie trwale usunięte.';

  @override
  String get awardsEarned => 'Zdobyte';

  @override
  String get awardsLocked => 'Zablokowane';

  @override
  String get awardStreak100Name => 'Sto dni';

  @override
  String get awardWorkouts10Name => 'Dziesięć treningów';

  @override
  String get awardWorkouts10Line => 'Pierwsze dziesięć robi różnicę.';

  @override
  String get awardWorkouts365Name => 'Trzysta sześćdziesiąt pięć';

  @override
  String get awardWorkouts365Line => 'Trening na każdy dzień roku, zapisywany jeden po drugim.';

  @override
  String get awardTonnes10Name => 'Dziesięć ton';

  @override
  String get awardTonnes10Line => 'Dziesięć tysięcy kilogramów przeszło przez twoje ręce.';

  @override
  String get awardHours100Name => 'Sto godzin';

  @override
  String get awardHours100Line => 'Sto godzin pod sztangą, z włączonym zegarem.';

  @override
  String awardWonOn(String date) {
    return 'Zdobyto $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Złota',
      'blue': 'Niebieska',
      'green': 'Zielona',
      'other': 'Odznaka',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Od $date';
  }

  @override
  String levelShort(int n) {
    return 'Poziom $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treningów do poziomu $next',
      one: '1 trening do poziomu $next',
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
      'ember': 'Żar',
      'green': 'Zielony',
      'blue': 'Niebieski',
      'mono': 'Szary',
      'other': 'Kolor',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n serii';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n z $goal w tym tygodniu';
  }

  @override
  String momentCount(int n) {
    return '$n zdjęć';
  }

  @override
  String photosSelected(int n) {
    return 'Zaznaczono: $n';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Usunąć zdjęcia ($n)?';
  }

  @override
  String get momentsEmptyHint =>
      'Zrób zdjęcie siłowni, tablicy, załadowanej sztangi — czegokolwiek, co chcesz zapamiętać. Zostaje na telefonie i tylko ty je widzisz.';

  @override
  String get awardStreak100Line => 'Sto dni z rzędu. To już nie motywacja, to nawyk.';

  @override
  String get coverLabel => 'OKŁADKA';

  @override
  String get removeCover => 'Usuń okładkę';

  @override
  String get startTitle => 'Rozpocznij trening';

  @override
  String get logTitle => 'Zapisz trening';

  @override
  String get logHint => 'Bez minutnika — po prostu wpisz, co zrobiłeś.';

  @override
  String get orStartFrom => 'Lub zacznij od';

  @override
  String get pickExercisesOption => 'Wybierz ćwiczenia';

  @override
  String get chooseFocusOption => 'Wybierz cel';

  @override
  String get plannedRoutine => 'ZAPLANOWANE';

  @override
  String get logWorkoutAction => 'ZAPISZ TRENING';

  @override
  String get logging => 'ZAPISYWANIE';

  @override
  String get placesLabel => 'Moje miejsca';

  @override
  String get undo => 'Cofnij';

  @override
  String get deleteSet => 'Usuń serię';

  @override
  String get setDeleted => 'Seria usunięta';

  @override
  String get removeWarmup => 'Usuń rozgrzewkę';

  @override
  String get addWeightAction => 'Dodaj ciężar';

  @override
  String get workoutOverview => 'Ten trening';

  @override
  String get allExercisesShort => 'Wszystkie';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total serii';
  }

  @override
  String get nowLabel => 'Teraz';

  @override
  String get deleteWorkout => 'Usuń trening';

  @override
  String get deleteWorkoutBody => 'Ten trening i wszystkie jego serie zostaną usunięte z historii.';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeAutoHint => 'Jak w telefonie';

  @override
  String get demoSizeTitle => 'Demo ćwiczenia podczas treningu';

  @override
  String get demoLarge => 'Duże';

  @override
  String get demoSmall => 'Małe';

  @override
  String get demoOff => 'Ukryte';

  @override
  String get demoLoopTitle => 'Animacja demo';

  @override
  String get demoLoopAlways => 'W pętli';

  @override
  String get demoLoopShort => '10 sekund';

  @override
  String get demoLoopHint =>
      'Porusza się przez około 10 sekund i zatrzymuje w pozycji wyjściowej. Stuknij demo, aby obejrzeć je ponownie.';

  @override
  String get alarmStyleTitle => 'Po końcu przerwy';

  @override
  String get alarmStyleLoud => 'Zawsze dzwoń';

  @override
  String get alarmStyleQuiet => 'Szanuj tryb cichy';

  @override
  String get alarmStyleVibrate => 'Tylko wibracje';

  @override
  String get alarmStyleHint =>
      '„Zawsze dzwoń” używa głośności alarmu, nawet w trybie cichym. „Szanuj tryb cichy” używa głośności powiadomień i tylko wibruje, gdy telefon jest wyciszony.';

  @override
  String get suggestedPicks => 'Polecane dla ciebie';

  @override
  String get moreOptions => 'Więcej opcji';

  @override
  String get suggestInWorkouts => 'Proponuj w szybkich treningach';

  @override
  String get suggestInWorkoutsHint => 'Wyłączone nie trafia do propozycji. Nadal możesz dodać je ręcznie.';

  @override
  String get onbPlaceTitle => 'Gdzie trenujesz?';

  @override
  String get onbPlaceWhy =>
      'Zaznacz wszystkie miejsca, w których trenujesz. Zaproponujemy tylko to, co możesz zrobić w każdym z nich.';

  @override
  String get onbPlaceGear => 'Co tam masz?';

  @override
  String distanceCol(String unit) {
    return 'DYSTANS ($unit)';
  }

  @override
  String get timeCol => 'CZAS';

  @override
  String get timeMinutesTitle => 'Czas (minuty)';

  @override
  String get timeSecondsTitle => 'Czas (sekundy)';

  @override
  String distanceTitle(String unit) {
    return 'Dystans ($unit)';
  }

  @override
  String get holdLabel => 'Utrzymaj';

  @override
  String get stopLabel => 'Stop';

  @override
  String startHold(String time) {
    return 'Start · $time';
  }

  @override
  String get exerciseTypeLabel => 'Zapisuj';

  @override
  String get typeReps => 'Powtórzenia i ciężar';

  @override
  String get typeTime => 'Czas';

  @override
  String get typeCardio => 'Dystans i czas';

  @override
  String get exerciseTypeHint =>
      'Cardio, jak bieganie czy pływanie, zapisuje dystans i czas. Pozycje statyczne, jak deska, zapisują czas.';

  @override
  String get howToLabel => 'Jak wykonać (opcjonalnie)';

  @override
  String get howToHint => 'Jeden krok w linii';

  @override
  String get editExercise => 'Edytuj ćwiczenie';

  @override
  String get saveChanges => 'Zapisz zmiany';

  @override
  String get noStepsYet => 'Brak kroków. Zapisz własne, żeby pamiętać, jak to robisz.';

  @override
  String get addSteps => 'Zapisz kroki';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Zwykła seria. Liczy się do objętości i rekordów.';

  @override
  String get setTypeWarmupInfo => 'Lekkie serie na rozgrzewkę. Nie liczą się do objętości ani rekordów.';

  @override
  String get setTypeDropInfo => 'Zaraz po serii zmniejsz ciężar i kontynuuj bez odpoczynku.';

  @override
  String get setTypeFailureInfo =>
      'Ćwicz, aż nie dasz rady zrobić kolejnego czystego powtórzenia. Zapisz te, które faktycznie zrobiłeś.';

  @override
  String get setTypeRestPauseInfo =>
      'Odpocznij 10–20 sekund po serii, a potem wyciśnij jeszcze kilka powtórzeń.';

  @override
  String get planFormatNotes =>
      'Używaj nazw ćwiczeń dokładnie tak, jak na liście. \"sets\", \"reps\", \"weight\" (w podanej jednostce), \"rest\" w sekundach i \"days\" są opcjonalne. \"superset\": true łączy ćwiczenie z następnym. Dla kilku tygodni zgrupuj rutyny w \"weeks\", jak w drugim przykładzie.';

  @override
  String get planSets => 'Zaplanuj serie';

  @override
  String get planSetsHint =>
      'Wybierz typ, powtórzenia i ciężar każdej serii. Zostaw ciężar na Auto, by zacząć od ostatniego treningu.';

  @override
  String get autoValue => 'Auto';

  @override
  String get clearPlan => 'Wyczyść plan';

  @override
  String get shareRoutine => 'Udostępnij rutynę';

  @override
  String get shareWeek => 'Udostępnij mój tydzień';

  @override
  String get shareWeekHint => 'Wszystkie twoje rutyny i dzień każdej z nich.';

  @override
  String shareMessage(String name) {
    return '$name — otwórz plik w GymMane, aby go dodać.';
  }

  @override
  String get importRoutines => 'Importuj rutyny';

  @override
  String get importPasteHint => 'Wklej tu rutynę: udostępnioną z GymMane, odpowiedź AI, JSON lub CSV.';

  @override
  String get pasteAction => 'Wklej';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rutyn',
      few: '$n rutyny',
      one: '1 rutyna',
    );
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Użyj też jej planu tygodnia';

  @override
  String get useTheirScheduleHint => 'Dni, które zawiera, zastąpią to, co masz zaplanowane na te dni.';

  @override
  String get addToMyRoutines => 'Dodaj do moich rutyn';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Dodano $n rutyn',
      few: 'Dodano $n rutyny',
      one: 'Dodano 1 rutynę',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Nic tu nie da się zaimportować';

  @override
  String get aiStepCopy => 'Skopiuj prośbę. Zawiera listę twoich ćwiczeń i format, który czyta GymMane.';

  @override
  String get aiStepAsk =>
      'Wklej ją do dowolnej AI i powiedz, czego chcesz: dni w tygodniu, cel, ile tygodni.';

  @override
  String get aiStepPaste => 'Wklej odpowiedź poniżej i zaimportuj. Plik niepotrzebny.';

  @override
  String get copyForAi => 'Kopiuj dla AI';

  @override
  String get copiedDone => 'Skopiowano';

  @override
  String get aiPasteHint => 'Wklej tu odpowiedź AI';

  @override
  String get importAction => 'Importuj';

  @override
  String get showFormat => 'Zobacz format';

  @override
  String get shareAsFile => 'Udostępnij jako plik';

  @override
  String get recoveryTab => 'Regeneracja';

  @override
  String recoveryOverall(int pct) {
    return 'Ciało zregenerowane w $pct%';
  }

  @override
  String get recoveryAllFresh => 'Wszystko zregenerowane. Dobry dzień na każdy trening.';

  @override
  String recoveryStill(String muscles) {
    return 'Jeszcze się regeneruje: $muscles';
  }

  @override
  String get recoveryTired => 'Zmęczony';

  @override
  String get recoveryFresh => 'Wypoczęty';

  @override
  String get recoveryHint =>
      'Dotknij mięśnia, by zobaczyć, jak jest zregenerowany. Niedawne serie ważą więcej, a cięższe (wg RPE) jeszcze więcej.';

  @override
  String recoveryPct(int pct) {
    return 'Zregenerowany w $pct%';
  }

  @override
  String readyInHours(int h) {
    return 'gotowy za ~$h h';
  }

  @override
  String get tplAbcd => 'Cztery dni: klatka i triceps, plecy i biceps, nogi, barki i brzuch.';

  @override
  String get tplAbcde => 'Pięć dni, jedna partia dziennie: klatka, plecy, nogi, barki, ramiona.';

  @override
  String get elapsedCaps => 'UPŁYNĘŁO';

  @override
  String get tapToSkip => 'Dotknij, by pominąć';

  @override
  String get screenLocked => 'Ekran zablokowany';

  @override
  String get lockedHint => 'Przytrzymaj odcisk palca u góry, aby odblokować';

  @override
  String get liveDoneSet => 'Seria zrobiona';

  @override
  String get liveSkipRest => 'Pomiń przerwę';

  @override
  String get livePause => 'Pauza';

  @override
  String get liveResume => 'Wznów';

  @override
  String get liveNext => 'Dalej';

  @override
  String liveUpNext(String name) {
    return 'Następne: $name';
  }

  @override
  String get stickerOpen => 'Udostępnij na zdjęciu';

  @override
  String get stickerNoPhoto => 'Bez zdjęcia';

  @override
  String get stickerWorkout => 'Trening';

  @override
  String get stickerStreak => 'Seria';

  @override
  String get stickerDate => 'Data';

  @override
  String get stickerHint => 'Przeciągnij, by przesunąć, uszczypnij, by zmienić rozmiar lub obrócić';

  @override
  String get stickerSaved => 'Zapisano w galerii';

  @override
  String get stickerWeek => 'Ten tydzień';

  @override
  String get getReady => 'Przygotuj się';

  @override
  String get stickerGallery => 'Galeria';

  @override
  String get stickerCamera => 'Aparat';

  @override
  String get shareIntroTitle => 'Udostępnij tę rutynę';

  @override
  String get shareIntroBody =>
      'Wyślij ją partnerowi, znajomemu lub rodzinie. Dostaną mały plik, który otwiera się w GymMane i dodaje rutynę jednym dotknięciem, z seriami i ciężarami.';

  @override
  String get removedFromRoutine => 'Usunięto z rutyny';

  @override
  String get radarTitle => 'Ostatnie 30 dni';

  @override
  String get radarHint => 'Zobacz, które partie potrzebują więcej pracy';

  @override
  String get radarEmpty => 'Potrenuj kilka dni, by zobaczyć swoją równowagę';

  @override
  String get radarBalanced => 'Na razie dobra równowaga';

  @override
  String radarFocus(String list) {
    return 'Potrzeba więcej: $list';
  }

  @override
  String get countdownReady => 'Przygotuj się';

  @override
  String get countdownSkip => 'Dotknij, aby zacząć od razu';

  @override
  String get countdownSetting => 'Odliczanie przed startem';

  @override
  String get effortSetting => 'Zapisuj wysiłek';

  @override
  String get effortHint =>
      'RPE: 10 to brak sił na kolejne powtórzenie, 8 to jeszcze dwa w zapasie. RIR liczy powtórzenia, które zostały. Jeśli seria go ma, szacowany 1RM korzysta z tabeli RPE.';

  @override
  String get rirHint => '0 to brak sił na kolejne powtórzenie, 2 to jeszcze dwa w zapasie.';

  @override
  String get addWeekWidget => 'Dodaj widżet tygodnia';

  @override
  String get gamificationSetting => 'Medale i poziomy';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n powt.', one: '$n powt.');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Najlepsza seria';

  @override
  String get weekStartSetting => 'Tydzień zaczyna się w';

  @override
  String get stepOutOfWorkout => 'Wstrzymaj i wyjdź';

  @override
  String get saveToRoutine => 'ZAPISZ ZMIANY W PLANIE';

  @override
  String get routineUpdated => 'Plan zaktualizowany';

  @override
  String saveChangesTitle(String name) {
    return 'Zapisać zmiany w $name?';
  }

  @override
  String get saveChangesBody => 'Następnym razem ten plan zacznie się tak.';

  @override
  String get routineOrderChanged => 'Nowa kolejność ćwiczeń';

  @override
  String get mineOnly => 'Utworzone przez ciebie';

  @override
  String createNamed(String name) {
    return 'Nie ma? Utwórz „$name”';
  }

  @override
  String get orStartWith => 'Albo zacznij od';

  @override
  String get warmupFocus => 'Rozgrzewka';

  @override
  String get warmupFocusHint => 'Mobilność i aktywacja, ze sprzętem lub bez';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Bieg, rower, wioślarz lub skakanka, na dystans i czas';

  @override
  String get homeRecommended => 'Polecane na ekranie głównym';

  @override
  String get archivedFilter => 'Zarchiwizowane';

  @override
  String get archiveExercise => 'Archiwizuj ćwiczenie';

  @override
  String get restoreExercise => 'Przywróć';

  @override
  String get archivedToast => 'Ćwiczenie zarchiwizowane';

  @override
  String get archivedToastHint => 'Znajdziesz je w Ćwiczenia › Zarchiwizowane';

  @override
  String get archivedBanner =>
      'Zarchiwizowane. Nie pojawia się na listach ani w propozycjach; historia zostaje.';

  @override
  String get videoMarksHint => 'Zatrzymaj na kroku i dotknij pinezki, aby następnym razem tam przeskoczyć.';

  @override
  String get videoMarkHere => 'Oznacz tu ten krok';

  @override
  String get sectionGeneral => 'Ogólne';

  @override
  String get sectionTraining => 'Trening';

  @override
  String get sectionAlerts => 'Przypomnienia i alarm';

  @override
  String get sectionHome => 'Ekran główny';

  @override
  String get sectionWidgets => 'Widżety';

  @override
  String get sectionData => 'Dane i kopia zapasowa';

  @override
  String get multiPlanSetting => 'Kilka planów dziennie';

  @override
  String get multiPlanHint => 'Dotknij każdego planu na ten dzień. Idą w kolejności dodania.';

  @override
  String routineOfDay(int n, int total) {
    return '$n z $total dziś';
  }

  @override
  String get planAboutMe => 'O mnie:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age lat, $height wzrostu, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Chcę trenować $n dni w tygodniu.';
  }

  @override
  String get planNoHistory =>
      'Nie mam jeszcze zapisanych treningów: traktuj mnie jak początkującego i ostrożnie dobieraj objętość i ciężary.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treningów w ostatnich 30 dniach.',
      one: '1 trening w ostatnich 30 dniach.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Najlepsze ostatnie serie';

  @override
  String get planAskFirst =>
      'Jeśli nie znasz mojego celu (siła, mięśnie, redukcja lub ogólna forma) albo długości sesji, najpierw zapytaj mnie krótko. Potem odpowiedz wyłącznie w JSON.';

  @override
  String get backToTop => 'Na górę';

  @override
  String get deleteExerciseTitle => 'Usunąć to ćwiczenie?';

  @override
  String deleteExerciseBody(String name) {
    return '„$name” zniknie z biblioteki i planów. Wcześniejsze serie zostaną.';
  }

  @override
  String get exportForStravaHint =>
      'Prześlij w przeglądarce na strava.com/upload/select (aplikacja Strava nie importuje plików). Pojawi się jako trening siłowy z twoimi seriami.';

  @override
  String get manualStartTime => 'Godzina rozpoczęcia';

  @override
  String get manualDuration => 'Czas trwania';

  @override
  String get manualDurationUnset => 'Dodaj czas trwania';

  @override
  String get stravaRow => 'Eksport do Stravy (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Wybierz trening do Stravy. Dostaniesz plik .fit: prześlij go w przeglądarce na strava.com/upload/select, a pojawi się jako trening siłowy z seriami.';

  @override
  String get stravaEmpty => 'Brak treningów do eksportu.';

  @override
  String get tapToPause => 'Dotknij, aby wstrzymać';

  @override
  String get holdPausedHint => 'Wstrzymane · dotknij, aby wznowić';

  @override
  String get finishHoldNow => 'Zakończ serię teraz';

  @override
  String get barWeightExercise => 'Waga sztangi lub sanek';

  @override
  String get barWeightHint => 'Używana przez kalkulator talerzy';

  @override
  String get barWeightCustom => 'Własna · dotknij, aby przywrócić';

  @override
  String get groupRename => 'Zmień nazwę grupy';

  @override
  String get groupUngroup => 'Usuń grupę, zachowaj rutyny';

  @override
  String get groupDeleteAll => 'Usuń grupę i rutyny';

  @override
  String groupDeleteTitle(String name) {
    return 'Usunąć „$name”?';
  }

  @override
  String groupDeleteBody(String count) {
    return 'Zostaną usunięte: $count. Historia treningów zostaje.';
  }

  @override
  String get tplRr =>
      'Klasyk z r/bodyweightfitness: całe ciało trzy dni w tygodniu. Przejdź o krok wyżej, gdy zrobi się łatwo.';

  @override
  String get levelUpKicker => 'NASTĘPNY KROK';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps w $name dwa treningi z rzędu. Gotowy na następny krok?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Zamień w $routine';
  }

  @override
  String get levelUpSee => 'Zobacz, jak to zrobić';

  @override
  String get levelUpLater => 'Nie teraz';

  @override
  String get levelUpStay => 'Zostaję przy tym';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name jest teraz w $routine';
  }

  @override
  String get levelUpStayed => 'Koniec podpowiedzi o progresji dla tego ćwiczenia';

  @override
  String get levelHintsSetting => 'Podpowiadaj następny krok';

  @override
  String get heatmapLabelsSetting => 'Dni i miesiące na mapie aktywności';

  @override
  String get rmPercent => 'PROCENT';

  @override
  String rmAtPercent(String pct) {
    return '$pct twojego maksimum';
  }

  @override
  String get copyWorkout => 'Kopiuj jako tekst';

  @override
  String get goalSet => 'Ustaw cel';

  @override
  String get goalTargetReps => 'DOCELOWE POWTÓRZENIA';

  @override
  String goalToGo(String value) {
    return 'Brakuje $value';
  }

  @override
  String get goalReached => 'Cel osiągnięty';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Zostało $n dni',
      few: 'Zostały $n dni',
      one: 'Został 1 dzień',
    );
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Termin minął';

  @override
  String get goalDeadline => 'TERMIN';

  @override
  String get goalNoDeadline => 'Bez terminu';

  @override
  String get goalRemove => 'Usuń cel';

  @override
  String get exerciseNameMissing => 'Nadaj nazwę';

  @override
  String get aliasesLabel => 'Inne nazwy (opcjonalnie)';

  @override
  String get aliasesHint => 'Inne nazwy, oddzielone przecinkami';

  @override
  String alsoCalled(String names) {
    return 'Też: $names';
  }

  @override
  String get addToRoutine => 'Dodaj do planu';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'W $n planach',
      one: 'W 1 planie',
      zero: 'Jeszcze w żadnym planie',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Już jest w planie';

  @override
  String get restInRoutine => 'Przerwa w tym planie';

  @override
  String get restInRoutineHint => 'Taka sama jak w ćwiczeniu';

  @override
  String get restInRoutineReset => 'Tylko tutaj · dotknij, by cofnąć';

  @override
  String get swapExercise => 'Zamień ćwiczenie';

  @override
  String get swapShort => 'Zamień';

  @override
  String swapHint(String name) {
    return 'Zamiast $name, tylko dziś. Na koniec możesz zostawić je w planie.';
  }

  @override
  String get swapKeepsDone => 'Zrobione serie zostają; nowe ćwiczenie dokończy resztę.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Ta sama partia · $muscle';
  }

  @override
  String get swapDoneBefore => 'Już robione';

  @override
  String get multiPlanSettingHint => 'Więcej niż jeden plan w tym samym dniu tygodnia.';

  @override
  String get levelHintsHint => 'Gdy ćwiczenie staje się łatwe, proponuje trudniejszą wersję.';

  @override
  String get focusCardHint => 'Dzisiejszy plan na górze ekranu głównego.';

  @override
  String get gamificationHint => 'Medale, twój poziom i świętowanie na koniec.';

  @override
  String get exerciseSettings => 'Ustawienia tego ćwiczenia';

  @override
  String get placeActiveNow => 'Jesteś tutaj';

  @override
  String get placeTapToUse => 'dotknij, by trenować tutaj';

  @override
  String get intervalDays => 'dni';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target dni';
  }

  @override
  String get toolNameRpe => 'Ciężar wg RPE';

  @override
  String get toolTitleRpe => 'Ciężar wg RPE';

  @override
  String get toolDescRpe => 'Jaki ciężar na wybrany wysiłek';

  @override
  String get toolNameDots => 'Poziom siły';

  @override
  String get toolTitleDots => 'Poziom siły (DOTS)';

  @override
  String get toolDescDots => 'Twoja siła względem masy ciała';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Na $reps powt. przy RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Seria, którą właśnie zrobiłeś';

  @override
  String get rpeGoal => 'Co chcesz zrobić';

  @override
  String rpeOneRmLine(String value) {
    return 'Szacowane 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 to brak siły na kolejne powtórzenie; 8 – zostały dwa.';

  @override
  String get dotsBestLifts => 'Twoje rekordy';

  @override
  String get dotsSquat => 'PRZYSIAD';

  @override
  String get dotsBench => 'WYCISKANIE NA ŁAWCE';

  @override
  String get dotsDeadlift => 'MARTWY CIĄG';

  @override
  String dotsTotalLine(String value) {
    return 'Suma: $value';
  }

  @override
  String get dotsExplain =>
      'Porównuje twoją siłę z każdym, niezależnie od wagi. Użyj najlepszego pojedynczego powtórzenia albo szacowanego 1RM.';

  @override
  String get dotsLevel0 => 'Początkujący';

  @override
  String get dotsLevel1 => 'Średnio zaawansowany';

  @override
  String get dotsLevel2 => 'Zaawansowany';

  @override
  String get dotsLevel3 => 'Bardzo zaawansowany';

  @override
  String get dotsLevel4 => 'Elita';

  @override
  String get rpeEffortLabel => 'Wysiłek (RPE)';

  @override
  String get restRowHint => 'Między seriami, chyba że ćwiczenie ma własną.';

  @override
  String get effortRowHint => 'Zapisuj RPE lub RIR przy każdej serii.';

  @override
  String get countdownHint => '3, 2, 1 przed pierwszą serią.';

  @override
  String get keepScreenOnHint => 'Ekran nie gaśnie podczas treningu.';

  @override
  String get demoSizeRowHint => 'Rysunek ćwiczenia podczas treningu.';

  @override
  String get demoLoopRowHint => 'Czy animacja się powtarza, czy zatrzymuje.';

  @override
  String get trainReminderRowHint => 'Przypomnienie w dni treningowe.';

  @override
  String get alarmSoundRowHint => 'Co gra po końcu przerwy.';

  @override
  String get alarmStyleRowHint => 'Czy dzwoni w trybie cichym.';

  @override
  String get recommendedRowHint => 'Ćwiczenia proponowane na ekranie głównym.';
}
