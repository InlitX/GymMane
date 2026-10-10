// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get languageName => 'Українська';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% до минулого місяця';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Рівень $level · $streak';
  }

  @override
  String get save => 'ЗБЕРЕГТИ';

  @override
  String get cancel => 'Скасувати';

  @override
  String get cancelCaps => 'СКАСУВАТИ';

  @override
  String get deleteCaps => 'ВИДАЛИТИ';

  @override
  String get done => 'ГОТОВО';

  @override
  String get set => 'Підхід';

  @override
  String get home => 'ГОЛОВНА';

  @override
  String get progress => 'ПРОГРЕС';

  @override
  String get exercises => 'ВПРАВИ';

  @override
  String get settings => 'НАЛАШТУВАННЯ';

  @override
  String get today => 'СЬОГОДНІ';

  @override
  String get thisWeek => 'ЦЬОГО ТИЖНЯ';

  @override
  String get recommended => 'РЕКОМЕНДОВАНО';

  @override
  String get goal => 'ЦІЛЬ';

  @override
  String get volume => 'ОБСЯГ';

  @override
  String get setsToday => 'ПІДХОДИ СЬОГОДНІ';

  @override
  String get prs => 'РЕКОРДИ';

  @override
  String get todaysFocus => 'ФОКУС НА СЬОГОДНІ';

  @override
  String get todaysRoutine => 'ПЛАН НА СЬОГОДНІ';

  @override
  String get startWorkout => 'ПОЧАТИ ТРЕНУВАННЯ';

  @override
  String get routines => 'ПРОГРАМИ';

  @override
  String get tools => 'ІНСТРУМЕНТИ';

  @override
  String get firstSessionHint => 'Обери м’язи та запиши перше тренування';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n вправ', one: '$n вправа');
    return '$_temp0';
  }

  @override
  String get pushDay => 'ДЕНЬ PUSH';

  @override
  String get pullDay => 'ДЕНЬ PULL';

  @override
  String get legDay => 'НОГИ';

  @override
  String get pushFocus => 'Груди · Плечі · Трицепс';

  @override
  String get pullFocus => 'Спина · Біцепс · Трапеції';

  @override
  String get legFocus => 'Квадрицепс · Задня поверхня стегна · Сідниці';

  @override
  String get train => 'ТРЕНУВАТИСЯ';

  @override
  String get step1 => 'КРОК 1 З 2';

  @override
  String get step2 => 'КРОК 2 З 2';

  @override
  String get chooseFocus => 'ОБЕРИ ФОКУС';

  @override
  String get buildSession => 'СКЛАДИ ТРЕНУВАННЯ';

  @override
  String get tapMuscles => 'Торкнися м’язів, які хочеш тренувати — спереду та ззаду.';

  @override
  String get continueBtn => 'ПРОДОВЖИТИ';

  @override
  String get nothingForFocus => 'Для цього фокусу вправ немає';

  @override
  String get goBackPick => 'Повернися й обери м’яз, для якого є вправи в бібліотеці.';

  @override
  String pickedHint(int n) {
    return 'Ми підібрали тренування — торкнися, щоб додати або прибрати будь-яку з $n вправ.';
  }

  @override
  String get pickAnExercise => 'ОБРАТИ ВПРАВУ';

  @override
  String get searchAllExercises => 'Пошук вправи…';

  @override
  String get noExercisesMatch => 'Немає відповідних вправ';

  @override
  String get createItInstead => 'Створити власну вправу';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ВПРАВ', one: '$n ВПРАВА');
    return 'ПОЧАТИ · $_temp0';
  }

  @override
  String get inProgress => 'ТРИВАЄ';

  @override
  String get paused => 'ПАУЗА';

  @override
  String get last => 'ОСТАННЄ';

  @override
  String get rest => 'ВІДПОЧИНОК';

  @override
  String get skip => 'ПРОПУСТИТИ';

  @override
  String get addSet => '+ ДОДАТИ ПІДХІД';

  @override
  String get finishSession => 'ЗАВЕРШИТИ ТРЕНУВАННЯ';

  @override
  String get setDone => 'ПІДХІД ВИКОНАНО';

  @override
  String get nextExercise => 'НАСТУПНА ВПРАВА';

  @override
  String get dropExerciseAction => 'Прибрати вправу';

  @override
  String get restOff => 'Вимк.';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'ПОВТОРЕННЯ';

  @override
  String weightCol(String unit) {
    return 'ВАГА ($unit)';
  }

  @override
  String get repsTitle => 'ПОВТОРЕННЯ';

  @override
  String weightTitle(String unit) {
    return 'ВАГА ($unit)';
  }

  @override
  String get sessionComplete => 'ТРЕНУВАННЯ ЗАПИСАНО';

  @override
  String get finishHeadlinePr => 'Новий особистий рекорд';

  @override
  String get finishHeadlineGoal => 'Тижневу ціль досягнуто';

  @override
  String get finishHeadlineStreak => 'Серію збережено';

  @override
  String get finishHeadlineDefault => 'Ще одне тренування позаду';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs вправах',
      one: 'одній вправі',
    );
    return 'Ти підняв більше, ніж будь-коли, у $_temp0. Результат збережено.';
  }

  @override
  String get finishBodyGoal => 'Ти виконав заплановану кількість тренувань цього тижня.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak днів поспіль. Найважче — не зупинятися.';
  }

  @override
  String get finishBodyDefault => 'Записано й враховано. Прогрес дає регулярність.';

  @override
  String get vsLastTime => 'ПОРІВНЯНО З МИНУЛИМ РАЗОМ';

  @override
  String get firstTime => 'Перший запис';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n нових рекордів',
      one: '$n новий рекорд',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'ТРИВАЛІСТЬ';

  @override
  String get setsCaps => 'ПІДХОДИ';

  @override
  String exerciseXofY(int i, int n) {
    return 'ВПРАВА $i З $n';
  }

  @override
  String get decrease => 'Зменшити';

  @override
  String get increase => 'Збільшити';

  @override
  String markSet(int n) {
    return 'Позначити підхід $n як виконаний';
  }

  @override
  String get pauseWorkout => 'Призупинити тренування';

  @override
  String get resumeWorkout => 'Продовжити тренування';

  @override
  String get discardTitle => 'Відкинути тренування?';

  @override
  String get discardBody => 'Підходи з цього тренування буде втрачено.';

  @override
  String get keepTraining => 'Продовжити тренування';

  @override
  String get discard => 'Відкинути';

  @override
  String get notifRestChannel => 'Таймер відпочинку';

  @override
  String get notifRestChannelWhy => 'Сповіщає, коли відпочинок між підходами завершився';

  @override
  String get notifAlertChannel => 'Таймер відпочинку (сповіщення)';

  @override
  String get notifAlertChannelWhy => 'Показує банер одразу після завершення відпочинку';

  @override
  String get restOverTitle => 'Відпочинок завершено';

  @override
  String get restOverBody => 'Час продовжувати — наступний підхід чекає.';

  @override
  String get allTimeSessions => 'ТРЕНУВАННЯ';

  @override
  String get allTimeTime => 'ЧАС';

  @override
  String get allTimeSets => 'ПІДХОДИ';

  @override
  String get consistency => 'РЕГУЛЯРНІСТЬ';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренувань записано',
      one: '$n тренування записано',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'Серія $n днів';
  }

  @override
  String get bodyweight => 'ВАГА ТІЛА';

  @override
  String get logBodyweight => 'ЗАПИСАТИ ВАГУ';

  @override
  String get trackWeight => 'Відстежуй вагу з часом';

  @override
  String get muscleMap => 'КАРТА М’ЯЗІВ';

  @override
  String get days7 => '7 Д';

  @override
  String get days30 => '30 Д';

  @override
  String get heatLow => 'Не тренувалося';

  @override
  String get heatHigh => 'Максимальний обсяг';

  @override
  String get muscleMapEmpty => 'Запиши тренування, і тіло почне підсвічуватися тут.';

  @override
  String get muscleMapHint => 'Торкнися м’яза, щоб побачити, як він працював.';

  @override
  String muscleMapBehind(String names) {
    return 'Відстають: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% від цілі';
  }

  @override
  String get muscleSplit => 'РОЗПОДІЛ ЗА М’ЯЗАМИ';

  @override
  String get personalRecords => 'ОСОБИСТІ РЕКОРДИ';

  @override
  String get strength1rm => 'СИЛА · ОЦІН. 1ПМ';

  @override
  String get strengthEmpty => 'Запиши вправу двічі, і тут з’явиться крива сили.';

  @override
  String oneRmEst(String w) {
    return 'Оцін. 1ПМ: $w';
  }

  @override
  String get restDayShort => 'День відпочинку';

  @override
  String get restDay => 'День відпочинку — нічого не записано.';

  @override
  String get delete => 'Видалити';

  @override
  String get deleteEntry => 'Видалити цей запис?';

  @override
  String deleteEntryBody(String name) {
    return '«$name» буде видалено з цього дня, рекордів і графіків.';
  }

  @override
  String get bodyweightHistory => 'ІСТОРІЯ';

  @override
  String get exercisesCaps => 'ВПРАВИ';

  @override
  String get timeCaps => 'ЧАС';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n вправ у бібліотеці',
      one: '$n вправа в бібліотеці',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Пошук вправ';

  @override
  String get muscleFilter => 'М’ЯЗ';

  @override
  String get levelFilter => 'РІВЕНЬ';

  @override
  String get kindLabel => 'ТИП';

  @override
  String get kindStrength => 'Силові';

  @override
  String get kindCalisthenics => 'Калістеніка';

  @override
  String get kindCardio => 'Кардіо';

  @override
  String get kindStretch => 'Розтяжка';

  @override
  String get newExercise => 'НОВА ВПРАВА';

  @override
  String get exerciseName => 'Назва вправи';

  @override
  String get equipmentLabel => 'ОБЛАДНАННЯ';

  @override
  String get addExercise => 'ДОДАТИ ВПРАВУ';

  @override
  String get advanced => 'ПРОСУНУТИЙ';

  @override
  String get demoMedia => 'ДЕМО';

  @override
  String get addMedia => 'Додати медіа';

  @override
  String get mediaHint => 'Зображення, GIF або відео';

  @override
  String get changeMedia => 'Змінити';

  @override
  String get videoSelected => 'Відео вибрано';

  @override
  String get favouritesOnly => 'Обране';

  @override
  String get noFavouritesYet => 'Обраного ще немає';

  @override
  String get noFavouritesHint => 'Торкнися зірочки біля вправи, щоб зберегти її тут.';

  @override
  String get clearFilters => 'Очистити фільтри';

  @override
  String get noExercisesFound => 'Вправ не знайдено';

  @override
  String get noExercisesHint => 'Спробуй інший пошук або очисти фільтри.';

  @override
  String get personalRecord => 'ОСОБИСТИЙ РЕКОРД';

  @override
  String get history => 'ІСТОРІЯ';

  @override
  String get noHistory => 'Тренувань ще не записано. Виконуй цю вправу, щоб з’явилася історія.';

  @override
  String get notes => 'НОТАТКИ';

  @override
  String get notePlaceholder => 'Підказки, техніка, відчуття…';

  @override
  String notHere(String gear, String place) {
    return 'Немає $gear у $place';
  }

  @override
  String get notHereWhy => 'Заміни на те, що реально можеш використати сьогодні.';

  @override
  String get altHere => 'ЩО МОЖНА РОБИТИ ТУТ';

  @override
  String get places => 'МОЇ МІСЦЯ';

  @override
  String get placesHint =>
      'Вкажи обладнання в кожному місці, і бібліотека покаже лише те, що там можна виконати.';

  @override
  String get placeAll => 'Будь-де';

  @override
  String get placeNew => 'Нове місце';

  @override
  String get placeNamePlaceholder => 'Дім, зал, парк…';

  @override
  String get placeGearLabel => 'ДОСТУПНЕ ОБЛАДНАННЯ';

  @override
  String placeExercises(int n) {
    return '$n вправ тут';
  }

  @override
  String get placeEmptyTitle => 'Тренуйся де завгодно';

  @override
  String get placeEmptyBody =>
      'Місце — це список обладнання, яке там є. Обери одне для початку й відредагуй пізніше.';

  @override
  String get placeDeleteTitle => 'Видалити місце';

  @override
  String get placeDeleteBody => 'Видалиться лише місце — вправи й тренування залишаться.';

  @override
  String get placeGym => 'Спортзал';

  @override
  String get placeHome => 'Дім';

  @override
  String get placeOutdoors => 'Надворі';

  @override
  String get placeFilterLabel => 'МІСЦЕ';

  @override
  String get noGearOnly => 'Без обладнання';

  @override
  String placeActive(String name) {
    return 'Тренування в $name';
  }

  @override
  String get journal => 'ЩОДЕННИК';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n нотаток',
      one: '1 нотатка',
      zero: 'Немає нотаток',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Нотатка';

  @override
  String get noteKindPlan => 'План';

  @override
  String get noteKindDone => 'Успіх';

  @override
  String get noteKindPain => 'Дискомфорт';

  @override
  String get noteFilterAll => 'Усі';

  @override
  String get newNote => 'Нова нотатка';

  @override
  String get editNote => 'Редагувати нотатку';

  @override
  String get addNote => 'ДОДАТИ НОТАТКУ';

  @override
  String get noteEmptyTitle => 'Поки нічого не записано';

  @override
  String get noteEmptyBody =>
      'Підказки, плани на наступний раз, відчуття від тренування — за бажанням із фото чи відео.';

  @override
  String get noteNoneForExercise => 'Нотаток до цієї вправи ще немає.';

  @override
  String get noteKindLabel => 'ТИП';

  @override
  String get noteTextLabel => 'НОТАТКА';

  @override
  String get noteDateLabel => 'ДАТА';

  @override
  String get noteExerciseLabel => 'ВПРАВА';

  @override
  String get noteMediaLabel => 'ФОТО ТА ВІДЕО';

  @override
  String get noteGeneral => 'Без вправи';

  @override
  String get noteAttach => 'Прикріпити';

  @override
  String get noteRemoveMedia => 'Видалити вкладення';

  @override
  String get deleteNoteTitle => 'Видалити нотатку';

  @override
  String get deleteNoteBody => 'Нотатку й усі вкладення буде видалено назавжди.';

  @override
  String get noteToday => 'Сьогодні';

  @override
  String get noteYesterday => 'Вчора';

  @override
  String get noteAllNotes => 'Усі нотатки';

  @override
  String get noteCalendar => 'Календар';

  @override
  String get noteNoneOnDay => 'Цього дня нічого не записано';

  @override
  String get noteAddOnDay => 'Додати нотатку на цей день';

  @override
  String get notePrevMonth => 'Попередній місяць';

  @override
  String get noteNextMonth => 'Наступний місяць';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n нотаток цього місяця',
      one: '1 нотатка цього місяця',
      zero: 'Немає нотаток цього місяця',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'ВИМІРИ';

  @override
  String get measuresHint => 'Від шиї до литки — стеж за змінами тіла, а не лише за штангою.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n вимірів',
      one: '1 вимір',
      zero: 'Немає вимірів',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Ще не виміряно';

  @override
  String get measureHistory => 'ІСТОРІЯ';

  @override
  String get measureNeck => 'Шия';

  @override
  String get measureShoulders => 'Плечі';

  @override
  String get measureChest => 'Груди';

  @override
  String get measureArm => 'Рука';

  @override
  String get measureForearm => 'Передпліччя';

  @override
  String get measureWaist => 'Талія';

  @override
  String get measureHips => 'Стегна';

  @override
  String get measureThigh => 'Стегно';

  @override
  String get measureCalf => 'Литка';

  @override
  String get measureBodyfat => 'Жирова маса';

  @override
  String get timeline => 'ХРОНОЛОГІЯ';

  @override
  String get timelineHint => 'Та сама поза, те саме місце, те саме світло. За рік не повіриш.';

  @override
  String get timelineEmptyTitle => 'Перше фото запускає відстеження';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n фото',
      one: '1 фото',
      zero: 'Немає фото',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Спереду';

  @override
  String get poseSide => 'Збоку';

  @override
  String get poseBack => 'Ззаду';

  @override
  String get photoEvery => 'НАГАДАТИ';

  @override
  String photoEveryDays(int n) {
    return 'Кожні $n днів';
  }

  @override
  String get photoEveryOff => 'Ніколи';

  @override
  String get timelineEvery => 'ГРУПУВАТИ КОЖНІ';

  @override
  String get custom => 'Власне';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Наступне фото через $n днів',
      one: 'Наступне фото завтра',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Час для фото — зроби сьогодні';

  @override
  String get addTodayPhotos => 'ДОДАТИ СЬОГОДНІШНІ ФОТО';

  @override
  String posePhoto(String pose) {
    return 'Фото: $pose';
  }

  @override
  String get compare => 'ПОРІВНЯТИ';

  @override
  String get compareNeedTwo => 'Зніми ту саму позу у два різні дні, щоб порівняти їх тут.';

  @override
  String dayNumber(int n) {
    return 'День $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Різниця $n днів',
      one: 'Різниця 1 день',
      zero: 'Того ж дня',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Видалити цей день';

  @override
  String get deleteDayBody => 'Фото цього дня також буде видалено назавжди.';

  @override
  String get timelinePhotos => 'Фото';

  @override
  String get timelineBody => 'Карта м’язів';

  @override
  String get timelineBodyEmpty => 'Запиши тренування, і карта м’язів почне заповнюватися тут — без фото.';

  @override
  String get timelineBodyHint => 'Створено з твоїх підходів — нічого не завантажується.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренувань',
      one: '1 тренування',
      zero: 'Немає тренувань',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Фото прогресу';

  @override
  String get notifPhotoChannelWhy => 'Нагадування, коли час зробити наступне фото прогресу.';

  @override
  String get notifPhotoTitle => 'Час зробити фото прогресу';

  @override
  String notifPhotoBody(int n) {
    return '$n днів від попереднього фото. Та сама поза, те саме світло.';
  }

  @override
  String get share => 'ПОДІЛИТИСЯ';

  @override
  String get sharePick => 'Що хочеш показати?';

  @override
  String get shareStreak => 'Серія та регулярність';

  @override
  String get shareBody => 'Опрацьовані м’язи';

  @override
  String get shareCompare => 'До / після';

  @override
  String get shareHint =>
      'Картка створюється на телефоні. Нічого не залишає його, доки ти не вибереш, куди надіслати.';

  @override
  String get shareFailed => 'Не вдалося створити картку';

  @override
  String get shareWeekOf => 'ОСТАННІ 7 ДНІВ';

  @override
  String get shareStreakLabel => 'ДНІВ ПОСПІЛЬ';

  @override
  String get shareSessionsLabel => 'ТРЕНУВАННЯ';

  @override
  String get shareVolumeLabel => 'ОБСЯГ';

  @override
  String get restForExercise => 'ВІДПОЧИНОК ДЛЯ ЦІЄЇ ВПРАВИ';

  @override
  String get restUsingDefault => 'Використовується стандартний час';

  @override
  String get restCustom => 'Лише для цього';

  @override
  String get setType => 'ТИП ПІДХОДУ';

  @override
  String get setTypeNormal => 'Робочий';

  @override
  String get setTypeWarmup => 'Розминка';

  @override
  String get setTypeDrop => 'Дроп-сет';

  @override
  String get setTypeFailure => 'До відмови';

  @override
  String get addWarmup => 'РОЗМИНКА';

  @override
  String platesPerSide(String plates) {
    return 'На сторону: $plates';
  }

  @override
  String get howTo => 'ЯК ВИКОНУВАТИ';

  @override
  String get similar => 'СХОЖІ';

  @override
  String get primaryLabel => 'ОСНОВНИЙ';

  @override
  String get secondaryLabel => 'ДРУГОРЯДНИЙ';

  @override
  String get none => 'Немає';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n підходів', one: '$n підхід');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'обсяг $v';
  }

  @override
  String get weeklyPlan => 'ТИЖНЕВИЙ ПЛАН';

  @override
  String get yourRoutines => 'ТВОЇ ПРОГРАМИ';

  @override
  String get noRoutines => 'Програм ще немає. Створи одну й додай вправи.';

  @override
  String get newRoutine => 'НОВА ПРОГРАМА';

  @override
  String get routineName => 'Назва програми';

  @override
  String get schedule => 'РОЗКЛАД';

  @override
  String get addFromList => 'Додай вправи зі списку нижче.';

  @override
  String get addExercises => 'Додати вправи';

  @override
  String get deleteRoutine => 'Видалити цю програму?';

  @override
  String exercisesWithCount(int n) {
    return 'ВПРАВИ · $n';
  }

  @override
  String setDay(String day) {
    return 'ВСТАНОВИТИ $day';
  }

  @override
  String get newRoutineName => 'Нова програма';

  @override
  String get dragToReorder => 'Потягніть за ручку з крапками, щоб змінити порядок — у ньому ви тренуєтеся.';

  @override
  String reorderHandle(String name) {
    return 'Змінити порядок: $name';
  }

  @override
  String get removeFromRoutine => 'Видалити з програми';

  @override
  String get dropExercise => 'Прибрати цю вправу?';

  @override
  String dropExerciseBody(String name) {
    return '«$name» буде вилучено з тренування. Уже записані дані не втратяться.';
  }

  @override
  String get drop => 'Прибрати';

  @override
  String get resetData => 'Видалити всі мої дані';

  @override
  String get resetTitle => 'Видалити все?';

  @override
  String get resetBody =>
      'Тренування, рекорди, програми, нотатки та профіль. Це незворотно — спочатку експортуй резервну копію, якщо дані можуть знадобитися.';

  @override
  String get resetConfirm => 'Видалити все';

  @override
  String get resetDone => 'Усі дані видалено';

  @override
  String get support => 'ПІДТРИМКА';

  @override
  String get reportBug => 'Повідомити про помилку';

  @override
  String get requestFeature => 'Запропонувати функцію';

  @override
  String get starOnGithub => 'Поставити зірку на GitHub';

  @override
  String get buyCoffee => 'Пригостити мене кавою';

  @override
  String get cantOpenLink => 'Не вдалося відкрити посилання';

  @override
  String get theme => 'Тема';

  @override
  String get darkTheme => 'Темна';

  @override
  String get lightTheme => 'Світла';

  @override
  String get languageLabel => 'Мова';

  @override
  String get unitsLabel => 'Одиниці';

  @override
  String get restTimer => 'Таймер відпочинку';

  @override
  String get alarmBlockedTitle => 'Сповіщення вимкнено';

  @override
  String get alarmBlockedBody => 'Сигнал відпочинку не спрацює, коли екран заблоковано';

  @override
  String get alarmBlockedAction => 'УВІМКНУТИ';

  @override
  String get alarmSound => 'Звук сигналу';

  @override
  String get alarmDefaultName => 'За замовчуванням';

  @override
  String get alarmSoundHint => 'Використовуй власний звук — до 15 секунд';

  @override
  String get alarmChoose => 'Вибрати звук…';

  @override
  String get alarmPreview => 'Відтворити поточний звук';

  @override
  String get alarmReset => 'Відновити стандартний звук';

  @override
  String get alarmTooLong => 'Цей звук довший за 15 секунд';

  @override
  String get alarmInvalid => 'Не вдалося прочитати аудіофайл';

  @override
  String alarmChanged(String name) {
    return 'Звук сигналу встановлено на «$name»';
  }

  @override
  String get alarmChangedDefault => 'Відновлено стандартний звук';

  @override
  String get addActivityWidget => 'Додати віджет активності';

  @override
  String get addStatsWidget => 'Додати віджет статистики';

  @override
  String get pinUnsupported => 'Додай через меню віджетів лаунчера';

  @override
  String get background => 'Фон';

  @override
  String get bgNone => 'Немає';

  @override
  String get bgDots => 'Крапки';

  @override
  String get bgGrid => 'Сітка';

  @override
  String get exportCsv => 'Експорт тренувань (CSV)';

  @override
  String get exportBackup => 'Експорт резервної копії (ZIP)';

  @override
  String get importBackup => 'Імпорт резервної копії';

  @override
  String get importHint =>
      'Обери резервну копію .zip (або старий .json), експортовану з GymMane. Поточні дані, включно з медіа, буде замінено.';

  @override
  String get import => 'Імпортувати';

  @override
  String get chooseFile => 'Вибрати файл';

  @override
  String get importFromApp => 'Імпортувати з іншого застосунку';

  @override
  String get importUnknownFormat => 'У файлі мають бути стовпці дати, вправи, повторень і ваги';

  @override
  String get importZipNoWeights => 'У ZIP немає файлу з вагою';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n вимірів ваги імпортовано',
      one: '$n вимір ваги імпортовано',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Не вдалося прочитати файл';

  @override
  String get importUnitTitle => 'Які одиниці використовує цей файл?';

  @override
  String get importUnitBody => 'У цьому експорті не вказано одиницю ваги.';

  @override
  String get importNothing => 'Немає нових даних для імпорту';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренувань імпортовано',
      one: '$n тренування імпортовано',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'Про GymMane';

  @override
  String get yourProfile => 'ТВІЙ ПРОФІЛЬ';

  @override
  String get autofills => 'Автоматично заповнює калькулятори';

  @override
  String get nameLabel => 'ІМ’Я';

  @override
  String get sexLabel => 'СТАТЬ';

  @override
  String get macroProtein => 'БІЛОК';

  @override
  String get macroCarbs => 'ВУГЛЕВОДИ';

  @override
  String get macroFat => 'ЖИРИ';

  @override
  String get male => 'Чоловіча';

  @override
  String get female => 'Жіноча';

  @override
  String get ageLabel => 'ВІК';

  @override
  String get heightLabel => 'ЗРІСТ';

  @override
  String get weightLabel => 'ВАГА';

  @override
  String get weeklyGoal => 'ТИЖНЕВА ЦІЛЬ';

  @override
  String get activityLabel => 'АКТИВНІСТЬ';

  @override
  String get addPhoto => 'Додати фото';

  @override
  String get removePhoto => 'Видалити фото';

  @override
  String get takePhoto => 'Зробити фото';

  @override
  String get chooseGallery => 'Вибрати з галереї';

  @override
  String get backupImported => 'Резервну копію імпортовано';

  @override
  String get backupFailed => 'Не вдалося прочитати резервну копію';

  @override
  String get nothingToExport => 'Поки немає чого експортувати — спочатку запиши тренування';

  @override
  String calculatorsCount(int n) {
    return '$n калькуляторів для тренувань';
  }

  @override
  String get result => 'РЕЗУЛЬТАТ';

  @override
  String get weightLifted => 'ПІДНЯТА ВАГА';

  @override
  String get repsPerformed => 'ВИКОНАНІ ПОВТОРЕННЯ';

  @override
  String get neck => 'ШИЯ';

  @override
  String get waist => 'ТАЛІЯ';

  @override
  String get hip => 'СТЕГНА (для жінок)';

  @override
  String get targetWeight => 'ЦІЛЬОВА ВАГА';

  @override
  String get workingWeight => 'РОБОЧА ВАГА';

  @override
  String get activityLevel => 'РІВЕНЬ АКТИВНОСТІ';

  @override
  String get barWeight => 'ВАГА ГРИФА';

  @override
  String get perSide => 'НА СТОРОНУ';

  @override
  String get justTheBar => 'Лише гриф.';

  @override
  String perSideCount(int n) {
    return '× $n на сторону';
  }

  @override
  String get toolNameRm => '1ПМ';

  @override
  String get toolNameBmi => 'ІМТ';

  @override
  String get toolNameCal => 'Калорії';

  @override
  String get toolNameBf => 'Жирова маса';

  @override
  String get toolNamePlate => 'Диски';

  @override
  String get toolNameWarmup => 'Розминка';

  @override
  String get toolTitleRm => 'Калькулятор 1ПМ';

  @override
  String get toolTitleBmi => 'Калькулятор ІМТ';

  @override
  String get toolTitleCal => 'Калорії та макроси';

  @override
  String get toolTitleBf => '% жиру';

  @override
  String get toolTitlePlate => 'Калькулятор дисків';

  @override
  String get toolTitleWarmup => 'Розминкові підходи';

  @override
  String get toolHintRm => 'Оцінений максимум на 1 повторення (формула Еплі)';

  @override
  String get toolHintCal => 'Оцінка добової норми для підтримання ваги';

  @override
  String get toolHintBf => 'Оцінка за методом ВМС США';

  @override
  String get toolHintPlate => 'Загальна вага штанги';

  @override
  String get toolHintWarmup => 'Цільова робоча вага';

  @override
  String get toolDescRm => 'Оцінений максимум на одне повторення';

  @override
  String get toolDescBmi => 'Індекс маси тіла';

  @override
  String get toolDescCal => 'Калорії та макронутрієнти';

  @override
  String get toolDescBf => 'Відсоток жиру в тілі';

  @override
  String get toolDescPlate => 'Калькулятор дисків';

  @override
  String get toolDescWarmup => 'Розминкові підходи з нарощуванням ваги';

  @override
  String get bmiUnderweight => 'Недостатня вага';

  @override
  String get bmiNormal => 'Нормальна вага';

  @override
  String get bmiOverweight => 'Надмірна вага';

  @override
  String get bmiObese => 'Ожиріння';

  @override
  String get actSedentary => 'Малорухливий';

  @override
  String get actLight => 'Легка';

  @override
  String get actActive => 'Активний';

  @override
  String get actModerate => 'Помірний';

  @override
  String get muscleChest => 'Груди';

  @override
  String get muscleBack => 'Спина';

  @override
  String get muscleLowerBack => 'Поперек';

  @override
  String get muscleShoulders => 'Плечі';

  @override
  String get muscleBiceps => 'Біцепс';

  @override
  String get muscleTriceps => 'Трицепс';

  @override
  String get muscleForearm => 'Передпліччя';

  @override
  String get muscleTrapezius => 'Трапеції';

  @override
  String get muscleAbdomen => 'Прес';

  @override
  String get muscleObliques => 'Косі м’язи';

  @override
  String get muscleQuads => 'Квадрицепс';

  @override
  String get muscleHamstrings => 'Задня поверхня стегна';

  @override
  String get muscleGlutes => 'Сідниці';

  @override
  String get muscleCalves => 'Литки';

  @override
  String get mgChest => 'Груди';

  @override
  String get mgBack => 'Спина';

  @override
  String get mgLegs => 'Ноги';

  @override
  String get mgShoulders => 'Плечі';

  @override
  String get mgArms => 'Руки';

  @override
  String get mgCore => 'Кор';

  @override
  String get equipBarbell => 'Штанга';

  @override
  String get equipDumbbell => 'Гантеля';

  @override
  String get equipCable => 'Трос';

  @override
  String get equipMachine => 'Тренажер';

  @override
  String get equipBodyweight => 'Вага тіла';

  @override
  String get equipWeighted => 'З обтяженням';

  @override
  String get equipBand => 'Еспандер';

  @override
  String get equipKettlebell => 'Гиря';

  @override
  String get equipRings => 'Кільця';

  @override
  String get equipOther => 'Інше';

  @override
  String get diffBeginner => 'Початківець';

  @override
  String get diffAdvanced => 'Просунутий';

  @override
  String get diffIntermediate => 'Середній';

  @override
  String get about => 'ПРО ЗАСТОСУНОК';

  @override
  String version(String v) {
    return 'Версія $v';
  }

  @override
  String get aboutBlurb => 'Створено тими, хто тренується, для тих, хто тренується.';

  @override
  String get freeForever => 'Безкоштовно назавжди';

  @override
  String get freeForeverWhy => 'Без підписки, без реклами, без платних обмежень.';

  @override
  String get fullyOffline => '100% офлайн';

  @override
  String get fullyOfflineWhy => 'Без облікового запису й серверів. Тренування ніколи не залишають телефон.';

  @override
  String get yoursToTake => 'Твої дані належать тобі';

  @override
  String get yoursToTakeWhy => 'Експортуй у CSV будь-коли й видаляй усе однією дією.';

  @override
  String get whatsInside => 'ЩО ВСЕРЕДИНІ';

  @override
  String exercisesInside(int n) {
    return '$n вправ';
  }

  @override
  String get exercisesInsideWhy => 'Кожна має анімацію та покрокові інструкції.';

  @override
  String get calculatorsInside => '10 калькуляторів';

  @override
  String get calculatorsInsideWhy =>
      '1ПМ, диски, ІМТ, калорії, жир, FFMI, розминка, вага за RPE і бали сили DOTS та Wilks — усе базується на опублікованих формулах.';

  @override
  String get mathInside => 'Прозорі розрахунки';

  @override
  String get mathInsideWhy =>
      'Обсяг, рекорди й підходи розраховуються з твоїх даних. Нічого просто для краси.';

  @override
  String get streakCaps => 'СЕРІЯ';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'днів', one: 'день');
    return '$_temp0';
  }

  @override
  String get reset => 'СКИНУТИ';

  @override
  String get welcomeKicker => 'ЛАСКАВО ПРОСИМО ДО';

  @override
  String get welcomeBlurb => 'Усе залишається на телефоні. Без облікового запису, без інтернету, без оплати.';

  @override
  String get welcomeStart => 'ПОЧАТИ';

  @override
  String onbStep(int i, int n) {
    return 'КРОК $i З $n';
  }

  @override
  String get onbNameTitle => 'Як до тебе звертатися?';

  @override
  String get onbNameHint => 'Твоє ім’я';

  @override
  String get onbNameWhy => 'Використовується лише для привітання. Ніколи не залишає телефон.';

  @override
  String get onbBodyTitle => 'Кілька даних';

  @override
  String get onbBodyWhy =>
      'Вони використовуються в калькуляторах. Їх можна змінити в Налаштуваннях будь-коли.';

  @override
  String get onbGoalTitle => 'Як часто ти тренуєшся?';

  @override
  String get onbGoalWhy => 'Встановлює тижневу ціль. Будь реалістичним, не надто амбітним.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренувань на тиждень',
      one: '$n тренування на тиждень',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Кілограми чи фунти?';

  @override
  String get next => 'ДАЛІ';

  @override
  String get back => 'НАЗАД';

  @override
  String get skip2 => 'Пропустити';

  @override
  String get madeWithLoveBy => 'ЗРОБЛЕНО З ЛЮБОВ’Ю';

  @override
  String get sourceCode => 'ВИХІДНИЙ КОД';

  @override
  String get suggested => 'РЕКОМЕНДОВАНО';

  @override
  String get results => 'РЕЗУЛЬТАТИ';

  @override
  String get noMatches => 'Жодна вправа не відповідає пошуку.';

  @override
  String get tapToEdit => 'Торкнися олівця, щоб виправити запис, або кошика, щоб видалити.';

  @override
  String get editEntry => 'Редагувати';

  @override
  String get editEntryHint => 'Виправ повторення або вагу будь-якого підходу.';

  @override
  String get removeSet => 'Видалити підхід';

  @override
  String get continueWorkout => 'ПРОДОВЖИТИ';

  @override
  String get continueWorkoutBody =>
      'Тренування продовжиться з уже позначеними підходами. Після повторного завершення воно збережеться з початковою датою.';

  @override
  String get addBodyWidget => 'Додати віджет карти м’язів';

  @override
  String get repsOnly => 'Лише повторення';

  @override
  String get repsOnlyHint => 'Записувати цю вправу без ваги.';

  @override
  String get useDefaultArt => 'Повернути стандартну ілюстрацію';

  @override
  String daysShort(int n) {
    return '$n д';
  }

  @override
  String get focusCard => 'Фокус на сьогодні';

  @override
  String get autoAdvance => 'Автоматично переходити далі';

  @override
  String get keepScreenOn => 'Не вимикати екран під час тренування';

  @override
  String get lockWorkout => 'Заблокувати екран';

  @override
  String get unlockWorkout => 'Розблокувати';

  @override
  String get holdToUnlock => 'Утримуйте, щоб розблокувати';

  @override
  String get liveChannel => 'Тренування триває';

  @override
  String get liveChannelWhy => 'Показує поточну вправу, підхід і таймер відпочинку під час тренування';

  @override
  String liveSet(int n, int total) {
    return 'Підхід $n з $total';
  }

  @override
  String get liveResting => 'Відпочинок';

  @override
  String get liveAllDone => 'Усі підходи виконано';

  @override
  String get autoAdvanceHint =>
      'Коли останній підхід вправи позначено, тренування автоматично переходить до наступної.';

  @override
  String get autoProgress => 'Додати вагу наступного разу';

  @override
  String autoProgressHint(String w) {
    return 'Виконай усі повторення, і наступне тренування почнеться з додаванням $w.';
  }

  @override
  String get placePlates => 'Диски та гриф';

  @override
  String get platesAll => 'Усе доступно';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n розмірів', one: '$n розмір');
    return '$_temp0';
  }

  @override
  String get platePairs => 'ПАРИ';

  @override
  String plateAchievable(String w) {
    return 'Найближча доступна вага: $w';
  }

  @override
  String get autoWarmup => 'Починати з розминкових підходів';

  @override
  String get autoWarmupHint => 'Додає розминкові підходи при відкритті тренування.';

  @override
  String get trainReminder => 'Нагадування про тренування';

  @override
  String get trainReminderHint => 'Нагадування в цей час лише в дні, коли заплановано програму.';

  @override
  String get reminderExactTime => 'Точний час';

  @override
  String get toastSoundSetting => 'Звук сповіщень';

  @override
  String get toastSoundHint => 'Мʼякий звук, коли зверху зʼявляється сповіщення.';

  @override
  String get notifTrainChannel => 'Нагадування про тренування';

  @override
  String get notifTrainChannelWhy => 'Нагадування тренуватися у заплановані дні.';

  @override
  String get notifTrainTitle => 'Час тренуватися';

  @override
  String get notifTrainBody => 'Твоя програма чекає.';

  @override
  String get planIntro => 'Склади мені програму тренувань, використовуючи лише вправи з цього списку.';

  @override
  String get planFormat => 'Відповідай лише у JSON, у такому форматі:';

  @override
  String get planNothing => 'Жодна вправа з файлу не відповідає бібліотеці';

  @override
  String get planFailed => 'Цей файл не є програмою, яку GymMane може прочитати';

  @override
  String get routineGroup => 'Група';

  @override
  String get newGroup => 'Нова група';

  @override
  String get noGroup => 'Без групи';

  @override
  String get groupNameHint => 'Push / Pull / Ноги, 5×5…';

  @override
  String get filters => 'Фільтри';

  @override
  String get setsPlannedHint =>
      'Обери кількість підходів для кожної вправи. Тренування відкриється вже підготовленим.';

  @override
  String get nextTime => 'НАСТУПНОГО РАЗУ';

  @override
  String get nextHold => 'залишай ту саму вагу, доки не виконаєш усі повторення';

  @override
  String get bgPhoto => 'Твоє фото';

  @override
  String get bgPhotoPick => 'Вибрати фото';

  @override
  String get bgPhotoChange => 'Змінити фото';

  @override
  String get bgPhotoRemove => 'Видалити фото';

  @override
  String get bgDim => 'ЗАТЕМНЕННЯ';

  @override
  String get dimSoft => 'Легке';

  @override
  String get dimMedium => 'Середнє';

  @override
  String get dimStrong => 'Сильне';

  @override
  String get bgPhotoHint => 'Фото відображається за всім інтерфейсом і затемнюється для читабельності.';

  @override
  String get reminderSmart => 'Розумне';

  @override
  String get reminderFixed => 'Фіксований час';

  @override
  String get reminderSmartHint =>
      'Використовує дні й час, коли ти реально тренуєшся, і мовчить, якщо цього дня тренування вже було.';

  @override
  String get reminderSmartEmpty => 'Запиши ще кілька тренувань, щоб застосунок вивчив звички.';

  @override
  String habitFocus(String day) {
    return 'що ти зазвичай тренуєш у $day';
  }

  @override
  String get duplicateRoutine => 'Дублювати програму';

  @override
  String copySuffix(String name) {
    return '$name (копія)';
  }

  @override
  String get saveAsRoutine => 'ЗБЕРЕГТИ ЯК ПРОГРАМУ';

  @override
  String get savedAsRoutine => 'Збережено як програму';

  @override
  String get templates => 'Готові програми';

  @override
  String get templatesHint => 'Класичні програми, складені з твоєї бібліотеки. Потім можна змінити все.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n програм додано',
      one: '$n програму додано',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Три тренування на все тіло на тиждень. Чудово для початку.';

  @override
  String get tplPpl => 'Push, pull і ноги. Три або шість днів на тиждень.';

  @override
  String get tplUpperlower => 'Верх і низ тіла, чотири дні на тиждень.';

  @override
  String get tplStronglifts => 'Два тренування, що чергуються, по п’ять підходів по п’ять.';

  @override
  String get tplStartingstrength => 'Присідання на кожному тренуванні, два тренування чергуються.';

  @override
  String get tplHome => 'Нічого, крім турніка й підлоги.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n днів', one: '$n день');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Записувати зусилля (RPE)';

  @override
  String get rpeHint => '10 = більше жодного повторення; 8 = приблизно два повторення в запасі.';

  @override
  String get superset => 'Суперсет';

  @override
  String get supersetLink => 'Поєднати з наступною';

  @override
  String get supersetHint => 'Без відпочинку між поєднаними вправами — одразу переходиш до наступної.';

  @override
  String get aiRoutine => 'Програма з ШІ';

  @override
  String get aiIntro =>
      'GymMane ніколи напряму не зв’язується зі ШІ. Ти експортуєш список вправ, вставляєш його в асистент, яким уже користуєшся, а потім імпортуєш відповідь. Нічого саме не залишає телефон.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n назв не було в бібліотеці',
      one: '1 назви не було в бібліотеці',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Підтримувані застосунки';

  @override
  String get importOtherCsv => 'Будь-який інший CSV з датою, вправою, повтореннями та вагою';

  @override
  String get importAskApp => 'Потрібен інший застосунок? Попроси додати його';

  @override
  String get awardFirstStepName => 'Перший крок';

  @override
  String get awardFirstStepLine => 'Ласкаво просимо до GymMane. Ця нагорода — подарунок.';

  @override
  String get awardFirstWorkoutName => 'Перше тренування';

  @override
  String get awardFirstWorkoutLine => 'Перше записано. Воно найважче.';

  @override
  String get awardFirstRoutineName => 'Перша програма';

  @override
  String get awardFirstRoutineLine => 'Тепер у тебе є план, до якого можна повертатися.';

  @override
  String get awardFirstRecordName => 'Перший рекорд';

  @override
  String get awardFirstRecordLine => 'Ти покращив свій найкращий результат у вправі.';

  @override
  String get awardStreak3Name => 'Три поспіль';

  @override
  String get awardStreak3Line => 'Три дні поспіль. Так усе починається.';

  @override
  String get awardTonne1Name => 'Одна тонна';

  @override
  String get awardTonne1Line => 'Загалом тисячу кілограмів піднято за підходи.';

  @override
  String get awardSets100Name => 'Сто підходів';

  @override
  String get awardSets100Line => 'Сто виконаних підходів, один за одним.';

  @override
  String get awardHours10Name => 'Десять годин';

  @override
  String get awardHours10Line => 'Десять годин тренувань на рахунку.';

  @override
  String get awardWorkouts50Name => 'П’ятдесят тренувань';

  @override
  String get awardWorkouts50Line => 'П’ятдесят тренувань позаду.';

  @override
  String get awardHours50Name => 'П’ятдесят годин';

  @override
  String get awardHours50Line => 'П’ятдесят годин тренувань.';

  @override
  String get awardsTitle => 'Медалі';

  @override
  String get yearTitle => 'Твій рік';

  @override
  String get yearBestMonth => 'Найкращий місяць';

  @override
  String get yearMonths => 'місяців';

  @override
  String get awardSpinHint => 'Проведи по медалі, щоб повернути її';

  @override
  String get awardUnlocked => 'Відкрито нове досягнення';

  @override
  String get awardNice => 'Круто!';

  @override
  String get awardSaveImage => 'Зберегти зображення';

  @override
  String get awardSaved => 'Збережено в галереї';

  @override
  String get awardStreak7Name => 'Сім днів';

  @override
  String get awardStreak7Line => 'Цілий тиждень без пропусків.';

  @override
  String get awardStreak30Name => 'Тридцять днів';

  @override
  String get awardStreak30Line => 'Місяць поспіль. Тепер це звичка.';

  @override
  String get awardWorkouts100Name => 'Сто тренувань';

  @override
  String get awardWorkouts100Line => 'Сто тренувань записано від початку до кінця.';

  @override
  String get awardTonnes100Name => 'Сто тонн';

  @override
  String get awardTonnes100Line => 'Усе, що ти підняв, сягнуло 100 000 кг.';

  @override
  String get awardSets1000Name => 'Тисяча підходів';

  @override
  String get awardSets1000Line => 'Підхід за підходом, аж до тисячі.';

  @override
  String get profile => 'Профіль';

  @override
  String get editProfile => 'Редагувати профіль';

  @override
  String get pickBadge => 'Значок';

  @override
  String get statWorkouts => 'Тренування';

  @override
  String get statTrained => 'Тренування';

  @override
  String get statSets => 'Підходи';

  @override
  String get statLifted => 'Піднято';

  @override
  String get statStreak => 'Серія';

  @override
  String get statDays => 'днів';

  @override
  String get unitHours => 'год';

  @override
  String get unitDays => 'дні';

  @override
  String get snapshots => 'Фото';

  @override
  String get snapNow => 'Зробити зараз';

  @override
  String get addCover => 'Додати обкладинку';

  @override
  String get addTodayWidget => 'Сьогоднішнє тренування виконано чи ні';

  @override
  String get photosCard => 'Твої фото';

  @override
  String get handleLabel => 'Ім’я користувача';

  @override
  String get setupTitle => 'Заповни ці дані, і решта сторінки заповниться автоматично';

  @override
  String get setupHint => 'Усі цифри тут беруться з твоїх записів. Нічого нікуди не надсилається.';

  @override
  String get setupWorkout => 'Запиши перше тренування';

  @override
  String get setupWeight => 'Запиши вагу тіла';

  @override
  String get setupMeasures => 'Зніми мірки тіла';

  @override
  String get setupPhoto => 'Зроби перше фото прогресу';

  @override
  String get progressTitle => 'Прогрес';

  @override
  String get tileVolume30 => 'Обсяг · 30 д';

  @override
  String get tileAddWeight => 'Додати своє';

  @override
  String get heatToneTitle => 'Колір теплової карти';

  @override
  String get heatToneHint => 'Змінює лише колір сітки й тіла.';

  @override
  String get thisWeekTitle => 'Цей тиждень';

  @override
  String get momentsEmptyTitle => 'Тут поки нічого немає';

  @override
  String get deletePhotoTitle => 'Видалити це фото?';

  @override
  String get deletePhotoBody => 'Його буде видалено назавжди.';

  @override
  String get awardsEarned => 'Здобуто';

  @override
  String get awardsLocked => 'Заблоковано';

  @override
  String get awardStreak100Name => 'Сто днів';

  @override
  String get awardWorkouts10Name => 'Десять тренувань';

  @override
  String get awardWorkouts10Line => 'Перші десять — ті, що змінюють усе.';

  @override
  String get awardWorkouts365Name => 'Триста шістдесят п’ять';

  @override
  String get awardWorkouts365Line => 'По тренуванню на кожен день року, записаному одне за одним.';

  @override
  String get awardTonnes10Name => 'Десять тонн';

  @override
  String get awardTonnes10Line => 'Десять тисяч кілограмів пройшли через твої руки.';

  @override
  String get awardHours100Name => 'Сто годин';

  @override
  String get awardHours100Line => 'Сто годин під штангою, з увімкненим таймером.';

  @override
  String awardWonOn(String date) {
    return 'Здобуто $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Золотий',
      'blue': 'Синій',
      'green': 'Зелений',
      'other': 'Значок',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'З $date';
  }

  @override
  String levelShort(int n) {
    return 'Рівень $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренувань до рівня $next',
      one: '1 тренування до рівня $next',
    );
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n см';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'Жар',
      'green': 'Зелений',
      'blue': 'Синій',
      'mono': 'Сірий',
      'other': 'Колір',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n підходів';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n з $goal цього тижня';
  }

  @override
  String momentCount(int n) {
    return '$n фото';
  }

  @override
  String photosSelected(int n) {
    return 'Вибрано: $n';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Видалити фото ($n)?';
  }

  @override
  String get momentsEmptyHint =>
      'Сфотографуй зал, дошку, зібрану штангу — усе, що хочеш запам’ятати. Фото залишаються на телефоні й видимі лише тобі.';

  @override
  String get awardStreak100Line => 'Сто днів поспіль. Це вже не мотивація, а звичка.';

  @override
  String get coverLabel => 'ОБКЛАДИНКА';

  @override
  String get removeCover => 'Видалити обкладинку';

  @override
  String get startTitle => 'Почати тренування';

  @override
  String get logTitle => 'Записати тренування';

  @override
  String get logHint => 'Без таймера — просто вкажи, що зробив.';

  @override
  String get orStartFrom => 'Або почати з';

  @override
  String get pickExercisesOption => 'Вибрати вправи';

  @override
  String get chooseFocusOption => 'Вибрати фокус';

  @override
  String get plannedRoutine => 'ЗАПЛАНОВАНО';

  @override
  String get logWorkoutAction => 'ЗАПИСАТИ ТРЕНУВАННЯ';

  @override
  String get logging => 'ЗАПИС';

  @override
  String get placesLabel => 'Мої місця';

  @override
  String get undo => 'Скасувати';

  @override
  String get deleteSet => 'Видалити підхід';

  @override
  String get setDeleted => 'Підхід видалено';

  @override
  String get removeWarmup => 'Прибрати розминку';

  @override
  String get addWeightAction => 'Додати вагу';

  @override
  String get workoutOverview => 'Це тренування';

  @override
  String get allExercisesShort => 'Усі';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total підходів';
  }

  @override
  String get nowLabel => 'Зараз';

  @override
  String get deleteWorkout => 'Видалити тренування';

  @override
  String get deleteWorkoutBody => 'Це тренування і всі його підходи буде видалено з історії.';

  @override
  String get themeAuto => 'Авто';

  @override
  String get themeAutoHint => 'Як у телефоні';

  @override
  String get demoSizeTitle => 'Демо вправи під час тренування';

  @override
  String get demoLarge => 'Велике';

  @override
  String get demoSmall => 'Мале';

  @override
  String get demoOff => 'Приховане';

  @override
  String get demoLoopTitle => 'Анімація демо';

  @override
  String get demoLoopAlways => 'По колу';

  @override
  String get demoLoopShort => '10 секунд';

  @override
  String get demoLoopHint =>
      'Рухається близько 10 секунд і зупиняється у вихідній позі. Торкніться демо, щоб переглянути знову.';

  @override
  String get alarmStyleTitle => 'Коли закінчиться відпочинок';

  @override
  String get alarmStyleLoud => 'Завжди дзвонити';

  @override
  String get alarmStyleQuiet => 'Враховувати беззвучний режим';

  @override
  String get alarmStyleVibrate => 'Лише вібрація';

  @override
  String get alarmStyleHint =>
      '«Завжди дзвонити» використовує гучність будильника навіть у беззвучному режимі. «Враховувати беззвучний режим» використовує гучність сповіщень і лише вібрує, коли звук вимкнено.';

  @override
  String get suggestedPicks => 'Рекомендовано для вас';

  @override
  String get moreOptions => 'Більше варіантів';

  @override
  String get suggestInWorkouts => 'Пропонувати у швидких тренуваннях';

  @override
  String get suggestInWorkoutsHint => 'Вимкнене не потрапить у пропозиції. Додати вручну все одно можна.';

  @override
  String get onbPlaceTitle => 'Де ви тренуєтеся?';

  @override
  String get onbPlaceWhy =>
      'Познач усі місця, де тренуєшся. Пропонуватимемо лише те, що можна зробити в кожному.';

  @override
  String get onbPlaceGear => 'Що у вас там є?';

  @override
  String distanceCol(String unit) {
    return 'ДИСТАНЦІЯ ($unit)';
  }

  @override
  String get timeCol => 'ЧАС';

  @override
  String get timeMinutesTitle => 'Час (хвилини)';

  @override
  String get timeSecondsTitle => 'Час (секунди)';

  @override
  String distanceTitle(String unit) {
    return 'Дистанція ($unit)';
  }

  @override
  String get holdLabel => 'Утримання';

  @override
  String get stopLabel => 'Стоп';

  @override
  String startHold(String time) {
    return 'Старт · $time';
  }

  @override
  String get exerciseTypeLabel => 'Записувати за';

  @override
  String get typeReps => 'Повтори й вага';

  @override
  String get typeTime => 'Час';

  @override
  String get typeCardio => 'Дистанція й час';

  @override
  String get exerciseTypeHint =>
      'Кардіо, як біг чи плавання, записує дистанцію й час. Статичні вправи, як планка, записують час.';

  @override
  String get howToLabel => 'Як виконувати (необов\'язково)';

  @override
  String get howToHint => 'Один крок на рядок';

  @override
  String get editExercise => 'Редагувати вправу';

  @override
  String get saveChanges => 'Зберегти зміни';

  @override
  String get noStepsYet => 'Кроків ще немає. Запишіть свої, щоб пам\'ятати, як ви це робите.';

  @override
  String get addSteps => 'Записати кроки';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Звичайний підхід. Враховується в обсязі та рекордах.';

  @override
  String get setTypeWarmupInfo => 'Легкі підходи для розминки. Не враховуються в обсязі та рекордах.';

  @override
  String get setTypeDropInfo => 'Одразу після підходу зменште вагу й продовжуйте без відпочинку.';

  @override
  String get setTypeFailureInfo =>
      'Продовжуйте, доки не зможете зробити ще одне чисте повторення. Записуйте, скільки зробили насправді.';

  @override
  String get setTypeRestPauseInfo => 'Відпочиньте 10–20 секунд після підходу й вичавіть ще кілька повторень.';

  @override
  String get planFormatNotes =>
      'Використовуйте назви вправ точно як у списку. \"sets\", \"reps\", \"weight\" (у вказаній одиниці), \"rest\" у секундах і \"days\" — необов\'язкові. \"superset\": true поєднує вправу з наступною. Для кількох тижнів згрупуйте програми всередині \"weeks\", як у другому прикладі.';

  @override
  String get planSets => 'Спланувати підходи';

  @override
  String get planSetsHint =>
      'Виберіть тип, повтори й вагу кожного підходу. Залиште вагу на Авто, щоб почати з останнього тренування.';

  @override
  String get planHintReps =>
      'Обери тип і кількість повторень кожного підходу. «Авто» бере дані минулого тренування.';

  @override
  String get planHintTime => 'Обери тип і час кожного підходу. «Авто» бере дані минулого тренування.';

  @override
  String get planHintTimeWeight =>
      'Обери тип, час і вагу кожного підходу. «Авто» бере дані минулого тренування.';

  @override
  String get planHintCardio => 'Обери дистанцію і час кожного підходу. «Авто» бере дані минулого тренування.';

  @override
  String get timeOnly => 'Лише час';

  @override
  String get autoValue => 'Авто';

  @override
  String get clearPlan => 'Очистити план';

  @override
  String get shareRoutine => 'Поділитися програмою';

  @override
  String get shareWeek => 'Поділитися моїм тижнем';

  @override
  String get shareWeekHint => 'Усі ваші програми й день кожної.';

  @override
  String shareMessage(String name) {
    return '$name — відкрийте файл у GymMane, щоб додати.';
  }

  @override
  String get importRoutines => 'Імпортувати програми';

  @override
  String get importPasteHint => 'Вставте програму сюди: поширену з GymMane, відповідь ШІ, JSON або CSV.';

  @override
  String get pasteAction => 'Вставити';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n програм',
      few: '$n програми',
      one: '1 програма',
    );
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Також використати її тижневий розклад';

  @override
  String get useTheirScheduleHint => 'Дні з неї замінять те, що ви запланували на ці дні.';

  @override
  String get addToMyRoutines => 'Додати до моїх програм';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Додано $n програм',
      few: 'Додано $n програми',
      one: 'Додано 1 програму',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Тут немає нічого, що GymMane може імпортувати';

  @override
  String get aiStepCopy => 'Скопіюйте запит. У ньому ваш список вправ і формат, який читає GymMane.';

  @override
  String get aiStepAsk =>
      'Вставте його в будь-який ШІ й скажіть, чого хочете: днів на тиждень, мета, скільки тижнів.';

  @override
  String get aiStepPaste => 'Вставте відповідь нижче й імпортуйте. Файл не потрібен.';

  @override
  String get copyForAi => 'Копіювати для ШІ';

  @override
  String get copiedDone => 'Скопійовано';

  @override
  String get aiPasteHint => 'Вставте сюди відповідь ШІ';

  @override
  String get importAction => 'Імпортувати';

  @override
  String get showFormat => 'Переглянути формат';

  @override
  String get shareAsFile => 'Поділитися файлом';

  @override
  String get recoveryTab => 'Відновлення';

  @override
  String recoveryOverall(int pct) {
    return 'Тіло відновлене на $pct%';
  }

  @override
  String get recoveryAllFresh => 'Усе відновлено. Гарний день, щоб тренувати будь-що.';

  @override
  String recoveryStill(String muscles) {
    return 'Ще відновлюється: $muscles';
  }

  @override
  String get recoveryTired => 'Втома';

  @override
  String get recoveryFresh => 'Свіжий';

  @override
  String get recoveryHint =>
      'Торкніться м\'яза, щоб побачити, наскільки він відновився. Нещодавні підходи важать більше, а важчі (за RPE) — ще більше.';

  @override
  String recoveryPct(int pct) {
    return 'Відновлено на $pct%';
  }

  @override
  String readyInHours(int h) {
    return 'готово за ~$h год';
  }

  @override
  String get tplAbcd => 'Чотири дні: груди й трицепс, спина й біцепс, ноги, плечі й прес.';

  @override
  String get tplAbcde => 'П\'ять днів, одна група на день: груди, спина, ноги, плечі, руки.';

  @override
  String get elapsedCaps => 'МИНУЛО';

  @override
  String get tapToSkip => 'Торкніться, щоб пропустити';

  @override
  String get screenLocked => 'Екран заблоковано';

  @override
  String get lockedHint => 'Утримуйте відбиток угорі, щоб розблокувати';

  @override
  String get liveDoneSet => 'Підхід виконано';

  @override
  String get liveSkipRest => 'Пропустити відпочинок';

  @override
  String get livePause => 'Пауза';

  @override
  String get liveResume => 'Продовжити';

  @override
  String get liveNext => 'Далі';

  @override
  String liveUpNext(String name) {
    return 'Далі: $name';
  }

  @override
  String get stickerOpen => 'Поділитися на фото';

  @override
  String get stickerNoPhoto => 'Без фото';

  @override
  String get stickerWorkout => 'Тренування';

  @override
  String get stickerStreak => 'Серія';

  @override
  String get stickerDate => 'Дата';

  @override
  String get stickerHint => 'Перетягніть, щоб перемістити, зведіть пальці, щоб змінити розмір або повернути';

  @override
  String get stickerSaved => 'Збережено в галерею';

  @override
  String get stickerWeek => 'Цей тиждень';

  @override
  String get getReady => 'Приготуйтеся';

  @override
  String get stickerGallery => 'Галерея';

  @override
  String get stickerCamera => 'Камера';

  @override
  String get shareIntroTitle => 'Поділіться цією програмою';

  @override
  String get shareIntroBody =>
      'Надішліть її партнеру, другу чи родині. Вони отримають невеликий файл, який відкривається в GymMane і додає програму одним дотиком, разом із підходами та вагами.';

  @override
  String get removedFromRoutine => 'Прибрано з програми';

  @override
  String get radarTitle => 'Останні 30 днів';

  @override
  String get radarHint => 'Подивіться, яким зонам потрібно більше роботи';

  @override
  String get radarEmpty => 'Потренуйтеся кілька днів, щоб побачити баланс';

  @override
  String get radarBalanced => 'Поки що все збалансовано';

  @override
  String radarFocus(String list) {
    return 'Потрібно більше: $list';
  }

  @override
  String get countdownReady => 'Приготуйтеся';

  @override
  String get countdownSkip => 'Торкніться, щоб почати одразу';

  @override
  String get countdownSetting => 'Зворотний відлік перед стартом';

  @override
  String get effortSetting => 'Відмічати зусилля';

  @override
  String get effortHint =>
      'RPE: 10 — більше жодного повторення, 8 — залишалося два. RIR — скільки повторень залишалося в запасі. Якщо підхід має оцінку, 1ПМ рахується за таблицею RPE.';

  @override
  String get rirHint => '0 — більше жодного повторення, 2 — залишалося два.';

  @override
  String get addWeekWidget => 'Додати віджет тижня';

  @override
  String get gamificationSetting => 'Медалі та рівні';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n повтору',
      many: '$n повторів',
      few: '$n повтори',
      one: '$n повтор',
    );
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Найкращий підхід';

  @override
  String get weekStartSetting => 'Тиждень починається з';

  @override
  String get stepOutOfWorkout => 'Пауза й вихід';

  @override
  String get saveToRoutine => 'ЗБЕРЕГТИ ЗМІНИ В ПРОГРАМІ';

  @override
  String get routineUpdated => 'Програму оновлено';

  @override
  String saveChangesTitle(String name) {
    return 'Зберегти зміни в $name?';
  }

  @override
  String get saveChangesBody => 'Наступного разу, коли ти її почнеш, у програмі будуть ці зміни.';

  @override
  String get routineOrderChanged => 'Новий порядок вправ';

  @override
  String get mineOnly => 'Створені вами';

  @override
  String createNamed(String name) {
    return 'Немає? Створити «$name»';
  }

  @override
  String get orStartWith => 'Або почніть з';

  @override
  String get warmupFocus => 'Розминка';

  @override
  String get warmupFocusHint => 'Рухливість і активація, з інвентарем чи без';

  @override
  String get cardioFocus => 'Кардіо';

  @override
  String get cardioFocusHint => 'Біг, велосипед, веслування чи скакалка — за дистанцією і часом';

  @override
  String get homeRecommended => 'Рекомендації на головній';

  @override
  String get archivedFilter => 'Архів';

  @override
  String get archiveExercise => 'Архівувати вправу';

  @override
  String get restoreExercise => 'Відновити';

  @override
  String get archivedToast => 'Вправу заархівовано';

  @override
  String get archivedToastHint => 'Вона в розділі Вправи › Архів';

  @override
  String get archivedBanner => 'В архіві. Не з’являється у списках і підказках; історія зберігається.';

  @override
  String get videoMarksHint =>
      'Поставте паузу на кроці й торкніться шпильки, щоб наступного разу перейти туди.';

  @override
  String get videoMarkHere => 'Позначити цей крок тут';

  @override
  String get sectionGeneral => 'Загальні';

  @override
  String get sectionTraining => 'Тренування';

  @override
  String get sectionAlerts => 'Нагадування і сигнал';

  @override
  String get sectionHome => 'Головна';

  @override
  String get sectionWidgets => 'Віджети';

  @override
  String get sectionData => 'Дані й резервна копія';

  @override
  String get multiPlanSetting => 'Кілька програм на день';

  @override
  String get multiPlanHint => 'Позначте кожну програму на цей день. Вони йдуть у порядку додавання.';

  @override
  String routineOfDay(int n, int total) {
    return '$n з $total сьогодні';
  }

  @override
  String get nextToday => 'Далі сьогодні';

  @override
  String get planAboutMe => 'Про мене:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age років, зріст $height, вага $weight.';
  }

  @override
  String planDays(int n) {
    return 'Хочу тренуватися $n днів на тиждень.';
  }

  @override
  String get planNoHistory => 'Тренувань ще немає: вважай мене новачком і будь обережним з обсягом і вагами.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренування за останні 30 днів.',
      many: '$n тренувань за останні 30 днів.',
      few: '$n тренування за останні 30 днів.',
      one: '$n тренування за останні 30 днів.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Найкращі нещодавні підходи';

  @override
  String get planAskFirst =>
      'Якщо ти не знаєш моєї мети (сила, м’язи, схуднення чи загальна форма) або тривалості тренування, спершу спитай мене одним коротким повідомленням. Потім відповідай лише JSON.';

  @override
  String get backToTop => 'Угору';

  @override
  String get deleteExerciseTitle => 'Видалити цю вправу?';

  @override
  String deleteExerciseBody(String name) {
    return '«$name» буде видалено з бібліотеки та програм. Попередні підходи збережуться.';
  }

  @override
  String get exportForStravaHint =>
      'Завантажте в браузері на strava.com/upload/select (застосунок Strava не імпортує файли). З’явиться як силове тренування з вашими підходами.';

  @override
  String get manualStartTime => 'Час початку';

  @override
  String get manualDuration => 'Тривалість';

  @override
  String get manualDurationUnset => 'Додати тривалість';

  @override
  String get stravaRow => 'Експорт у Strava (бета)';

  @override
  String get stravaBeta => 'БЕТА';

  @override
  String get stravaIntro =>
      'Оберіть тренування для Strava. Ви отримаєте файл .fit: завантажте його в браузері на strava.com/upload/select, і воно з’явиться як силове тренування з підходами.';

  @override
  String get stravaEmpty => 'Поки немає тренувань для експорту.';

  @override
  String get tapToPause => 'Торкніться для паузи';

  @override
  String get holdPausedHint => 'Пауза · торкніться, щоб продовжити';

  @override
  String get finishHoldNow => 'Завершити підхід зараз';

  @override
  String get barWeightExercise => 'Вага грифа чи платформи';

  @override
  String get barWeightHint => 'Використовує калькулятор млинців';

  @override
  String get barWeightCustom => 'Власна · торкніться, щоб скинути';

  @override
  String get groupRename => 'Перейменувати групу';

  @override
  String get groupUngroup => 'Прибрати групу, залишити програми';

  @override
  String get groupDeleteAll => 'Видалити групу й програми';

  @override
  String groupDeleteTitle(String name) {
    return 'Видалити «$name»?';
  }

  @override
  String groupDeleteBody(String count) {
    return 'Буде видалено: $count. Історія тренувань збережеться.';
  }

  @override
  String get tplRr =>
      'Класика r/bodyweightfitness: усе тіло три дні на тиждень. Переходь на наступний щабель, коли стане легко.';

  @override
  String get levelUpKicker => 'НАСТУПНИЙ КРОК';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps у «$name» два тренування поспіль. Готовий до наступного кроку?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Замінити в «$routine»';
  }

  @override
  String get levelUpSee => 'Як виконувати';

  @override
  String get levelUpLater => 'Не зараз';

  @override
  String get levelUpStay => 'Залишити цю';

  @override
  String levelUpSwapped(String name, String routine) {
    return '«$name» тепер у «$routine»';
  }

  @override
  String get levelUpStayed => 'Більше не пропонувати ускладнення для цієї';

  @override
  String get levelHintsSetting => 'Пропонувати наступний крок';

  @override
  String get heatmapLabelsSetting => 'Дні й місяці на карті активності';

  @override
  String get rmPercent => 'ВІДСОТОК';

  @override
  String rmAtPercent(String pct) {
    return '$pct від твого максимуму';
  }

  @override
  String get copyWorkout => 'Скопіювати текстом';

  @override
  String get goalSet => 'Поставити ціль';

  @override
  String get goalTargetReps => 'ЦІЛЬОВІ ПОВТОРИ';

  @override
  String goalToGo(String value) {
    return 'Залишилось $value';
  }

  @override
  String get goalReached => 'Ціль досягнуто';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Залишилось $n днів',
      few: 'Залишилось $n дні',
      one: 'Залишився $n день',
    );
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Термін минув';

  @override
  String get goalDeadline => 'ТЕРМІН';

  @override
  String get goalNoDeadline => 'Без терміну';

  @override
  String get goalRemove => 'Прибрати ціль';

  @override
  String get exerciseNameMissing => 'Дайте назву';

  @override
  String get aliasesLabel => 'Інші назви (необов\'язково)';

  @override
  String get aliasesHint => 'Інші назви через кому';

  @override
  String alsoCalled(String names) {
    return 'Також: $names';
  }

  @override
  String get addToRoutine => 'Додати до програми';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'У $n програмах',
      one: 'У 1 програмі',
      zero: 'Поки в жодній програмі',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Уже є';

  @override
  String get restInRoutine => 'Відпочинок у цій програмі';

  @override
  String get restInRoutineHint => 'Як у вправи';

  @override
  String get restInRoutineReset => 'Лише тут · торкніться, щоб скинути';

  @override
  String get swapExercise => 'Замінити вправу';

  @override
  String get swapShort => 'Замінити';

  @override
  String swapHint(String name) {
    return 'Замість «$name», лише сьогодні. Наприкінці можна залишити її в програмі.';
  }

  @override
  String get swapKeepsDone => 'Виконані підходи залишаться; нова продовжить решту.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Той самий м’яз · $muscle';
  }

  @override
  String get swapDoneBefore => 'Уже робили';

  @override
  String get multiPlanSettingHint => 'Більше однієї програми в один день тижня.';

  @override
  String get levelHintsHint => 'Коли вправа стає легкою, запропонує складніший варіант.';

  @override
  String get focusCardHint => 'Програма на сьогодні — вгорі головного екрана.';

  @override
  String get gamificationHint => 'Медалі, ваш рівень і свято наприкінці.';

  @override
  String get exerciseSettings => 'Налаштування вправи';

  @override
  String get placeActiveNow => 'Ви тут';

  @override
  String get placeTapToUse => 'торкніться, щоб тренуватися тут';

  @override
  String get intervalDays => 'днів';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target дн.';
  }

  @override
  String get toolNameRpe => 'Вага за RPE';

  @override
  String get toolTitleRpe => 'Вага за RPE';

  @override
  String get toolDescRpe => 'Яку вагу взяти під потрібне зусилля';

  @override
  String get toolNameDots => 'Рівень сили';

  @override
  String get toolTitleDots => 'Рівень сили (DOTS)';

  @override
  String get toolDescDots => 'Ваша сила відносно ваги';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'На $reps повт. при RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Підхід, який ви щойно зробили';

  @override
  String get rpeGoal => 'Що хочете зробити';

  @override
  String rpeOneRmLine(String value) {
    return 'Розрахунковий 1ПМ: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 — більше жодного повтору; 8 — залишалося два.';

  @override
  String get dotsBestLifts => 'Ваші найкращі результати';

  @override
  String get dotsSquat => 'ПРИСІД';

  @override
  String get dotsBench => 'ЖИМ ЛЕЖАЧИ';

  @override
  String get dotsDeadlift => 'СТАНОВА ТЯГА';

  @override
  String dotsTotalLine(String value) {
    return 'Сума: $value';
  }

  @override
  String get dotsExplain =>
      'Порівнює вашу силу з силою будь-кого, незалежно від ваги. Використайте найкращий разовий результат або розрахунковий 1ПМ.';

  @override
  String get dotsLevel0 => 'Новачок';

  @override
  String get dotsLevel1 => 'Середній';

  @override
  String get dotsLevel2 => 'Просунутий';

  @override
  String get dotsLevel3 => 'Дуже просунутий';

  @override
  String get dotsLevel4 => 'Еліта';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Бали Wilks';

  @override
  String get toolDescWilks => 'Класична оцінка в пауерліфтингу';

  @override
  String get wilksExplain =>
      'Класична формула пауерліфтингу. У 2020 її замінила DOTS, але багато змагань і рейтингів досі її використовують.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Індекс знежиреної маси';

  @override
  String get toolDescFfmi => 'Скільки м’язів для твого зросту';

  @override
  String get ffmiBodyFat => 'ЖИРОВА МАСА';

  @override
  String ffmiLeanLine(String value) {
    return 'Знежирена маса: $value';
  }

  @override
  String get ffmiExplain =>
      'Як ІМТ, але без жиру: враховує лише знежирену масу. З поправкою на зріст, щоб чесно порівнювати високих і невисоких.';

  @override
  String get ffmiLevel0 => 'Нижче середнього';

  @override
  String get ffmiLevel1 => 'Середній';

  @override
  String get ffmiLevel2 => 'Вище середнього';

  @override
  String get ffmiLevel3 => 'Відмінний';

  @override
  String get ffmiLevel4 => 'Винятковий';

  @override
  String get rpeEffortLabel => 'Зусилля (RPE)';

  @override
  String get restRowHint => 'Між підходами, якщо у вправи немає свого.';

  @override
  String get effortRowHint => 'Позначайте RPE або RIR у кожному підході.';

  @override
  String get countdownHint => '3, 2, 1 перед першим підходом.';

  @override
  String get keepScreenOnHint => 'Екран не гасне під час тренування.';

  @override
  String get demoSizeRowHint => 'Малюнок вправи під час тренування.';

  @override
  String get demoLoopRowHint => 'Повторюється анімація чи зупиняється.';

  @override
  String get trainReminderRowHint => 'Нагадування в дні тренувань.';

  @override
  String get alarmSoundRowHint => 'Що звучить наприкінці відпочинку.';

  @override
  String get alarmStyleRowHint => 'Чи дзвонить у беззвучному режимі.';

  @override
  String get recommendedRowHint => 'Вправи, які ми пропонуємо на головній.';

  @override
  String get weightStepSetting => 'Крок ваги';

  @override
  String get weightStepHint => 'Скільки додають кнопки − і +.';

  @override
  String get prBestWorkout => 'Найкраще тренування';
}
