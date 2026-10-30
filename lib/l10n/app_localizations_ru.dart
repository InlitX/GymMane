// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get languageName => 'Русский';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% к прошлому месяцу';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Уровень $level · $streak';
  }

  @override
  String get save => 'СОХРАНИТЬ';

  @override
  String get cancel => 'Отмена';

  @override
  String get cancelCaps => 'ОТМЕНА';

  @override
  String get deleteCaps => 'УДАЛИТЬ';

  @override
  String get done => 'ГОТОВО';

  @override
  String get set => 'Задать';

  @override
  String get home => 'ГЛАВНАЯ';

  @override
  String get progress => 'ПРОГРЕСС';

  @override
  String get exercises => 'УПРАЖНЕНИЯ';

  @override
  String get settings => 'НАСТРОЙКИ';

  @override
  String get today => 'СЕГОДНЯ';

  @override
  String get thisWeek => 'ЭТА НЕДЕЛЯ';

  @override
  String get recommended => 'РЕКОМЕНДУЕМ';

  @override
  String get goal => 'ЦЕЛЬ';

  @override
  String get volume => 'ОБЪЁМ';

  @override
  String get setsToday => 'ПОДХОДОВ СЕГОДНЯ';

  @override
  String get prs => 'РЕКОРДЫ';

  @override
  String get todaysFocus => 'ФОКУС ДНЯ';

  @override
  String get todaysRoutine => 'ПРОГРАММА НА СЕГОДНЯ';

  @override
  String get startWorkout => 'НАЧАТЬ ТРЕНИРОВКУ';

  @override
  String get routines => 'ПРОГРАММЫ';

  @override
  String get tools => 'ИНСТРУМЕНТЫ';

  @override
  String get firstSessionHint => 'Выбери мышцы и запиши первую тренировку';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n упражнения',
      many: '$n упражнений',
      few: '$n упражнения',
      one: '$n упражнение',
    );
    return '$_temp0';
  }

  @override
  String get pushDay => 'ЖИМОВОЙ ДЕНЬ';

  @override
  String get pullDay => 'ТЯГОВЫЙ ДЕНЬ';

  @override
  String get legDay => 'ДЕНЬ НОГ';

  @override
  String get pushFocus => 'Грудь · Плечи · Трицепс';

  @override
  String get pullFocus => 'Спина · Бицепс · Трапеции';

  @override
  String get legFocus => 'Квадрицепс · Бицепс бедра · Ягодицы';

  @override
  String get train => 'ТРЕНИРОВКА';

  @override
  String get step1 => 'ШАГ 1 ИЗ 2';

  @override
  String get step2 => 'ШАГ 2 ИЗ 2';

  @override
  String get chooseFocus => 'ВЫБЕРИ ФОКУС';

  @override
  String get buildSession => 'СОБЕРИ ТРЕНИРОВКУ';

  @override
  String get tapMuscles => 'Нажми на мышцы, которые хочешь нагрузить — спереди и сзади.';

  @override
  String get continueBtn => 'ДАЛЬШЕ';

  @override
  String get nothingForFocus => 'Для этого фокуса пока ничего нет';

  @override
  String get goBackPick => 'Вернись и выбери мышцу, для которой в библиотеке есть упражнения.';

  @override
  String pickedHint(int n) {
    return 'Мы собрали тренировку за тебя — нажми, чтобы добавить или убрать любое из $n.';
  }

  @override
  String get pickAnExercise => 'ВЫБЕРИ УПРАЖНЕНИЕ';

  @override
  String get searchAllExercises => 'Найти любое упражнение…';

  @override
  String get noExercisesMatch => 'Ничего не найдено';

  @override
  String get createItInstead => 'Создать своё упражнение';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n УПРАЖНЕНИЯ',
      many: '$n УПРАЖНЕНИЙ',
      few: '$n УПРАЖНЕНИЯ',
      one: '$n УПРАЖНЕНИЕ',
    );
    return 'СТАРТ · $_temp0';
  }

  @override
  String get inProgress => 'ИДЁТ';

  @override
  String get paused => 'ПАУЗА';

  @override
  String get last => 'ПРОШЛЫЙ';

  @override
  String get rest => 'ОТДЫХ';

  @override
  String get skip => 'ПРОПУСТИТЬ';

  @override
  String get addSet => '+ ПОДХОД';

  @override
  String get finishSession => 'ЗАВЕРШИТЬ';

  @override
  String get setDone => 'ПОДХОД СДЕЛАН';

  @override
  String get nextExercise => 'СЛЕДУЮЩЕЕ УПРАЖНЕНИЕ';

  @override
  String get dropExerciseAction => 'Убрать упражнение';

  @override
  String get restOff => 'Выключен';

  @override
  String get miniRest => 'Отдых в рест-паузе и кластере';

  @override
  String get miniRestHint =>
      'Короткий отдых перед подходом рест-паузы или кластера. Остальные подходы — с обычным отдыхом.';

  @override
  String get gymPass => 'Абонемент в зал';

  @override
  String get gymPassEmpty => 'Храните здесь код своего зала и проходите без карты';

  @override
  String get gymPassAdd => 'Добавить абонемент';

  @override
  String get gymPassScan => 'Сфотографировать код';

  @override
  String get gymPassScanHint => 'Камерой телефона';

  @override
  String get gymPassPhoto => 'Из фото или скриншота';

  @override
  String get gymPassPhotoHint => 'Например, скриншот из приложения вашего зала';

  @override
  String get gymPassType => 'Ввести номер';

  @override
  String get gymPassTypeHint => 'Для штрихкодов: номер, напечатанный под ним';

  @override
  String get gymPassNotFound => 'На этом изображении нет QR-кода. Попробуйте более чёткое или введите номер.';

  @override
  String get gymPassName => 'Название зала';

  @override
  String get gymPassDefaultName => 'Мой зал';

  @override
  String get gymPassCode => 'Код';

  @override
  String get gymPassFormat => 'Тип кода';

  @override
  String get gymPassInvalid => 'Этот номер не подходит для этого типа кода';

  @override
  String get gymPassShowHint => 'Поднесите к считывателю. Яркость поднимется сама.';

  @override
  String get gymPassDeleted => 'Абонемент удалён';

  @override
  String get gymPassEdit => 'Изменить абонемент';

  @override
  String get gymPassShow => 'Показать на входе';

  @override
  String get gymPassPrivate => 'Хранится только на вашем телефоне. Ничего не загружается.';

  @override
  String get gymPassColor => 'Цвет';

  @override
  String get gymPassRescan => 'Считать код заново';

  @override
  String get gymPassReading => 'Считываем код…';

  @override
  String get gymPassSettingHint => 'Карта зала в профиле, готова для входа';

  @override
  String get gymPassMember => 'Участник';

  @override
  String get widgetHintActivity => 'Ваша карта тренировочных дней';

  @override
  String get widgetHintStats => 'Серия, объём и тренировки за неделю';

  @override
  String get widgetHintBody => 'Мышцы, которые вы проработали';

  @override
  String get widgetHintToday => 'Коротко: тренировались ли вы сегодня?';

  @override
  String get widgetHintWeek => 'План недели по дням';

  @override
  String get supportHintBug => 'Расскажите на GitHub, что сломалось';

  @override
  String get supportHintFeature => 'Предложите идею для приложения';

  @override
  String get supportHintStar => 'Помогает другим его найти';

  @override
  String get supportHintCoffee => 'Поддержка разработки. Бесплатно и без рекламы';

  @override
  String get bodyweightNoteHint => 'Добавьте заметку: самочувствие, что пробуете… (необязательно)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'Использовать $unit в этом упражнении';
  }

  @override
  String get setCol => '№';

  @override
  String get repsCol => 'ПОВТОРЫ';

  @override
  String weightCol(String unit) {
    return 'ВЕС ($unit)';
  }

  @override
  String get repsTitle => 'ПОВТОРЫ';

  @override
  String weightTitle(String unit) {
    return 'ВЕС ($unit)';
  }

  @override
  String get sessionComplete => 'ТРЕНИРОВКА ЗАПИСАНА';

  @override
  String get finishHeadlinePr => 'Новый личный рекорд';

  @override
  String get finishHeadlineGoal => 'Недельная цель взята';

  @override
  String get finishHeadlineStreak => 'Серия жива';

  @override
  String get finishHeadlineDefault => 'Ещё одна в копилку';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs упражнениях',
      many: '$prs упражнениях',
      few: '$prs упражнениях',
      one: 'одном упражнении',
    );
    return 'Ты поднял больше, чем когда-либо, в $_temp0. Теперь это в твоих рекордах.';
  }

  @override
  String get finishBodyGoal => 'Ты сделал столько тренировок, сколько наметил на эту неделю.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak дней подряд. Самое трудное — не останавливаться.';
  }

  @override
  String get finishBodyDefault => 'Записано и учтено. Цифры двигает регулярность.';

  @override
  String get vsLastTime => 'ПРОТИВ ПРОШЛОГО РАЗА';

  @override
  String get firstTime => 'Записано впервые';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n новых рекорда',
      many: '$n новых рекордов',
      few: '$n новых рекорда',
      one: '$n новый рекорд',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'ДЛИТЕЛЬНОСТЬ';

  @override
  String get setsCaps => 'ПОДХОДЫ';

  @override
  String exerciseXofY(int i, int n) {
    return 'УПРАЖНЕНИЕ $i ИЗ $n';
  }

  @override
  String get decrease => 'Уменьшить';

  @override
  String get increase => 'Увеличить';

  @override
  String markSet(int n) {
    return 'Отметить подход $n как выполненный';
  }

  @override
  String get pauseWorkout => 'Поставить тренировку на паузу';

  @override
  String get resumeWorkout => 'Продолжить тренировку';

  @override
  String get discardTitle => 'Отменить тренировку?';

  @override
  String get discardBody => 'Подходы этой тренировки будут потеряны.';

  @override
  String get keepTraining => 'Продолжить';

  @override
  String get discard => 'Отменить';

  @override
  String get notifRestChannel => 'Таймер отдыха';

  @override
  String get notifRestChannelWhy => 'Сообщает, когда отдых между подходами закончился';

  @override
  String get notifAlertChannel => 'Таймер отдыха (сигнал)';

  @override
  String get notifAlertChannelWhy => 'Показывает баннер, как только отдых закончился';

  @override
  String get restOverTitle => 'Отдых окончен';

  @override
  String get restOverBody => 'Возвращайся — следующий подход ждёт.';

  @override
  String get allTimeSessions => 'ТРЕНИРОВОК';

  @override
  String get allTimeTime => 'ВРЕМЯ';

  @override
  String get allTimeSets => 'ПОДХОДОВ';

  @override
  String get consistency => 'РЕГУЛЯРНОСТЬ';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'записано $n тренировки',
      many: 'записано $n тренировок',
      few: 'записано $n тренировки',
      one: 'записана $n тренировка',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'серия $n дн.';
  }

  @override
  String get bodyweight => 'ВЕС ТЕЛА';

  @override
  String get logBodyweight => 'ЗАПИСАТЬ ВЕС';

  @override
  String get trackWeight => 'Следи за своим весом со временем';

  @override
  String get muscleMap => 'КАРТА МЫШЦ';

  @override
  String get days7 => '7Д';

  @override
  String get days30 => '30Д';

  @override
  String get days90 => '90Д';

  @override
  String get days365 => '1Г';

  @override
  String get daysAll => 'Всё';

  @override
  String get weeklyAvgTitle => 'Среднее за неделю';

  @override
  String weekOfDate(String date) {
    return 'Неделя с $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change за этот период';
  }

  @override
  String get heatLow => 'Не тронуто';

  @override
  String get heatHigh => 'Полный объём';

  @override
  String get muscleMapEmpty => 'Запиши тренировку — и тело начнёт подсвечиваться здесь.';

  @override
  String get muscleMapHint => 'Нажми на мышцу, чтобы увидеть, сколько ей досталось.';

  @override
  String muscleMapBehind(String names) {
    return 'Отстают: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% от цели';
  }

  @override
  String get muscleSplit => 'РАСПРЕДЕЛЕНИЕ ОБЪЁМА';

  @override
  String get personalRecords => 'ЛИЧНЫЕ РЕКОРДЫ';

  @override
  String get strength1rm => 'СИЛА · ОЦЕНКА 1ПМ';

  @override
  String get strengthEmpty => 'Запиши упражнение дважды — и здесь появится кривая силы.';

  @override
  String oneRmEst(String w) {
    return '1ПМ ≈ $w';
  }

  @override
  String get restDayShort => 'День отдыха';

  @override
  String get restDay => 'День отдыха — ничего не записано.';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteEntry => 'Удалить эту запись?';

  @override
  String deleteEntryBody(String name) {
    return '«$name» исчезнет из этого дня, а также из рекордов и графиков.';
  }

  @override
  String get bodyweightHistory => 'ИСТОРИЯ';

  @override
  String get exercisesCaps => 'УПРАЖНЕНИЯ';

  @override
  String get timeCaps => 'ВРЕМЯ';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n упражнения в твоей библиотеке',
      many: '$n упражнений в твоей библиотеке',
      few: '$n упражнения в твоей библиотеке',
      one: '$n упражнение в твоей библиотеке',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Поиск упражнений';

  @override
  String get muscleFilter => 'МЫШЦА';

  @override
  String get levelFilter => 'УРОВЕНЬ';

  @override
  String get kindLabel => 'ТИП';

  @override
  String get kindStrength => 'Силовые';

  @override
  String get kindCalisthenics => 'Калистеника';

  @override
  String get kindCardio => 'Кардио';

  @override
  String get kindStretch => 'Растяжка';

  @override
  String get newExercise => 'НОВОЕ УПРАЖНЕНИЕ';

  @override
  String get exerciseName => 'Название упражнения';

  @override
  String get equipmentLabel => 'ИНВЕНТАРЬ';

  @override
  String get addExercise => 'ДОБАВИТЬ УПРАЖНЕНИЕ';

  @override
  String get advanced => 'ДОПОЛНИТЕЛЬНО';

  @override
  String get demoMedia => 'ДЕМО';

  @override
  String get addMedia => 'Добавить медиа';

  @override
  String get mediaHint => 'Изображение, GIF или видео';

  @override
  String get changeMedia => 'Заменить';

  @override
  String get videoSelected => 'Видео выбрано';

  @override
  String get favouritesOnly => 'Избранное';

  @override
  String get noFavouritesYet => 'Пока нет избранного';

  @override
  String get noFavouritesHint => 'Нажми на звёздочку у упражнения, чтобы оно осталось здесь.';

  @override
  String get clearFilters => 'Сбросить фильтры';

  @override
  String get noExercisesFound => 'Упражнения не найдены';

  @override
  String get noExercisesHint => 'Попробуй другой запрос или сбрось фильтры.';

  @override
  String get personalRecord => 'ЛИЧНЫЙ РЕКОРД';

  @override
  String get history => 'ИСТОРИЯ';

  @override
  String get noHistory => 'Тренировок пока нет. Потренируй это упражнение, чтобы набрать историю.';

  @override
  String get notes => 'ЗАМЕТКИ';

  @override
  String get notePlaceholder => 'Подсказки, настройка, ощущения…';

  @override
  String notHere(String gear, String place) {
    return 'Нет «$gear» в «$place»';
  }

  @override
  String get notHereWhy => 'Замени на то, что действительно можешь взять сегодня.';

  @override
  String get altHere => 'ЧТО МОЖНО ДЕЛАТЬ ЗДЕСЬ';

  @override
  String get places => 'МОИ МЕСТА';

  @override
  String get placesHint =>
      'Укажи, что есть в каждом месте, и библиотека покажет только то, что там реально можно сделать.';

  @override
  String get placeAll => 'Везде';

  @override
  String get placeNew => 'Новое место';

  @override
  String get placeNamePlaceholder => 'Дом, зал, парк…';

  @override
  String get placeGearLabel => 'ЧТО ТАМ ЕСТЬ';

  @override
  String placeExercises(int n) {
    return 'Упражнений здесь: $n';
  }

  @override
  String get placeEmptyTitle => 'Тренируйся где угодно';

  @override
  String get placeEmptyBody =>
      'Место — это список инвентаря, который там есть. Выбери одно для начала, потом отредактируешь.';

  @override
  String get placeDeleteTitle => 'Удалить место';

  @override
  String get placeDeleteBody => 'Уйдёт только место — упражнения и тренировки останутся.';

  @override
  String get placeGym => 'Зал';

  @override
  String get placeHome => 'Дом';

  @override
  String get placeOutdoors => 'Улица';

  @override
  String get placeFilterLabel => 'МЕСТО';

  @override
  String get noGearOnly => 'Без инвентаря';

  @override
  String placeActive(String name) {
    return 'Тренируешься здесь: $name';
  }

  @override
  String get journal => 'ДНЕВНИК';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n заметки',
      many: '$n заметок',
      few: '$n заметки',
      one: '$n заметка',
      zero: 'Нет заметок',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Заметка';

  @override
  String get noteKindPlan => 'План';

  @override
  String get noteKindDone => 'Победа';

  @override
  String get noteKindPain => 'Болячка';

  @override
  String get noteFilterAll => 'Все';

  @override
  String get newNote => 'Новая заметка';

  @override
  String get editNote => 'Изменить заметку';

  @override
  String get addNote => 'ДОБАВИТЬ ЗАМЕТКУ';

  @override
  String get noteEmptyTitle => 'Пока ничего не записано';

  @override
  String get noteEmptyBody =>
      'Подсказки, планы на следующий раз, ощущения от тренировки — с фото или видео, если хочешь.';

  @override
  String get noteNoneForExercise => 'Заметок по этому упражнению пока нет.';

  @override
  String get noteKindLabel => 'ТИП';

  @override
  String get noteTextLabel => 'ЗАМЕТКА';

  @override
  String get noteDateLabel => 'ДАТА';

  @override
  String get noteExerciseLabel => 'УПРАЖНЕНИЕ';

  @override
  String get noteMediaLabel => 'ФОТО И ВИДЕО';

  @override
  String get noteGeneral => 'Без упражнения';

  @override
  String get noteAttach => 'Прикрепить';

  @override
  String get noteRemoveMedia => 'Убрать вложение';

  @override
  String get deleteNoteTitle => 'Удалить заметку';

  @override
  String get deleteNoteBody => 'Заметка и всё вложенное исчезнут навсегда.';

  @override
  String get noteToday => 'Сегодня';

  @override
  String get noteYesterday => 'Вчера';

  @override
  String get noteAllNotes => 'Все заметки';

  @override
  String get noteCalendar => 'Календарь';

  @override
  String get noteNoneOnDay => 'В этот день ничего не записано';

  @override
  String get noteAddOnDay => 'Заметка на этот день';

  @override
  String get notePrevMonth => 'Предыдущий месяц';

  @override
  String get noteNextMonth => 'Следующий месяц';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n заметки в этом месяце',
      many: '$n заметок в этом месяце',
      few: '$n заметки в этом месяце',
      one: '$n заметка в этом месяце',
      zero: 'В этом месяце нет заметок',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'ЗАМЕРЫ';

  @override
  String get measuresHint => 'От шеи до икр — следи, как меняется тело, а не только штанга.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n замера',
      many: '$n замеров',
      few: '$n замера',
      one: '$n замер',
      zero: 'Ничего не записано',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Ещё не записано';

  @override
  String get measureHistory => 'ИСТОРИЯ';

  @override
  String get measureNeck => 'Шея';

  @override
  String get measureShoulders => 'Плечи';

  @override
  String get measureChest => 'Грудь';

  @override
  String get measureArm => 'Рука';

  @override
  String get measureForearm => 'Предплечье';

  @override
  String get measureWaist => 'Талия';

  @override
  String get measureHips => 'Бёдра';

  @override
  String get measureThigh => 'Бедро';

  @override
  String get measureCalf => 'Икра';

  @override
  String get measureBodyfat => 'Жир';

  @override
  String get timeline => 'ЛЕНТА';

  @override
  String get hidePhotos => 'Скрыть фото';

  @override
  String get showPhotos => 'Показать фото';

  @override
  String get timelineHint => 'Та же поза, то же место, тот же свет. Через год сам не поверишь.';

  @override
  String get timelineEmptyTitle => 'Первое фото запускает отсчёт';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n фото',
      many: '$n фото',
      few: '$n фото',
      one: '$n фото',
      zero: 'Нет фото',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Спереди';

  @override
  String get poseSide => 'Сбоку';

  @override
  String get poseBack => 'Сзади';

  @override
  String get photoEvery => 'НАПОМИНАТЬ';

  @override
  String photoEveryDays(int n) {
    return 'Каждые $n дн.';
  }

  @override
  String get photoEveryOff => 'Никогда';

  @override
  String get timelineEvery => 'ГРУППИРОВАТЬ КАЖДЫЕ';

  @override
  String get custom => 'Другое';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Следующее фото через $n дн.',
      one: 'Следующее фото завтра',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Пора сделать фото — прямо сегодня';

  @override
  String get addTodayPhotos => 'ДОБАВИТЬ ФОТО ЗА СЕГОДНЯ';

  @override
  String posePhoto(String pose) {
    return 'Фото: $pose';
  }

  @override
  String get compare => 'СРАВНИТЬ';

  @override
  String get compareNeedTwo => 'Сними одну и ту же позу в два разных дня — и сможешь сравнить их здесь.';

  @override
  String dayNumber(int n) {
    return 'День $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'разница $n дня',
      many: 'разница $n дней',
      few: 'разница $n дня',
      one: 'разница $n день',
      zero: 'Тот же день',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Удалить этот день';

  @override
  String get deleteDayBody => 'Его фото уйдут вместе с ним, навсегда.';

  @override
  String get timelinePhotos => 'Фото';

  @override
  String get timelineBody => 'Карта мышц';

  @override
  String get timelineBodyEmpty =>
      'Запиши тренировку — и карта мышц начнёт заполняться здесь, без всяких фото.';

  @override
  String get timelineBodyHint => 'Построена по твоим подходам — ничего загружать не нужно.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренировки',
      many: '$n тренировок',
      few: '$n тренировки',
      one: '$n тренировка',
      zero: 'Нет тренировок',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Фото прогресса';

  @override
  String get notifPhotoChannelWhy => 'Напоминание, когда пора сделать следующее фото прогресса.';

  @override
  String get notifPhotoTitle => 'Пора сделать фото прогресса';

  @override
  String notifPhotoBody(int n) {
    return '$n дн. с прошлого раза. Та же поза, тот же свет.';
  }

  @override
  String get share => 'ПОДЕЛИТЬСЯ';

  @override
  String get sharePick => 'Что показать?';

  @override
  String get shareStreak => 'Серию и регулярность';

  @override
  String get shareBody => 'Проработанные мышцы';

  @override
  String get shareCompare => 'До и после';

  @override
  String get shareHint =>
      'Карточка собирается на твоём телефоне. Никуда ничего не уйдёт, пока сам не выберешь куда.';

  @override
  String get shareFailed => 'Не удалось собрать карточку';

  @override
  String get shareWeekOf => 'ПОСЛЕДНИЕ 7 ДНЕЙ';

  @override
  String get shareStreakLabel => 'ДНЕЙ ПОДРЯД';

  @override
  String get shareSessionsLabel => 'ТРЕНИРОВОК';

  @override
  String get shareVolumeLabel => 'ОБЪЁМ';

  @override
  String get restForExercise => 'ОТДЫХ ДЛЯ ЭТОГО УПРАЖНЕНИЯ';

  @override
  String get restUsingDefault => 'Как по умолчанию';

  @override
  String get restCustom => 'Только для этого';

  @override
  String get setType => 'ТИП ПОДХОДА';

  @override
  String get setTypeNormal => 'Рабочий';

  @override
  String get setTypeWarmup => 'Разминочный';

  @override
  String get setTypeDrop => 'Дроп-сет';

  @override
  String get setTypeFailure => 'До отказа';

  @override
  String get addWarmup => 'РАЗМИНКА';

  @override
  String platesPerSide(String plates) {
    return 'На сторону: $plates';
  }

  @override
  String get howTo => 'КАК ДЕЛАТЬ';

  @override
  String get similar => 'ПОХОЖИЕ';

  @override
  String get primaryLabel => 'ОСНОВНЫЕ';

  @override
  String get secondaryLabel => 'ВСПОМОГАТЕЛЬНЫЕ';

  @override
  String get none => 'Нет';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n подхода',
      many: '$n подходов',
      few: '$n подхода',
      one: '$n подход',
    );
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'объём $v';
  }

  @override
  String get weeklyPlan => 'ПЛАН НА НЕДЕЛЮ';

  @override
  String get yourRoutines => 'ТВОИ ПРОГРАММЫ';

  @override
  String get noRoutines => 'Программ пока нет. Создай одну и добавь упражнения.';

  @override
  String get newRoutine => 'НОВАЯ ПРОГРАММА';

  @override
  String get routineName => 'Название программы';

  @override
  String get schedule => 'РАСПИСАНИЕ';

  @override
  String get addFromList => 'Добавь упражнения из списка ниже.';

  @override
  String get addExercises => 'Добавить упражнения';

  @override
  String get deleteRoutine => 'Удалить эту программу?';

  @override
  String exercisesWithCount(int n) {
    return 'УПРАЖНЕНИЯ · $n';
  }

  @override
  String setDay(String day) {
    return 'НАЗНАЧИТЬ НА $day';
  }

  @override
  String get newRoutineName => 'Новая программа';

  @override
  String get dragToReorder => 'Потяните за ручку с точками, чтобы изменить порядок — в нём вы тренируетесь.';

  @override
  String reorderHandle(String name) {
    return 'Переместить $name';
  }

  @override
  String get removeFromRoutine => 'Убрать из программы';

  @override
  String get dropExercise => 'Убрать это упражнение?';

  @override
  String dropExerciseBody(String name) {
    return '«$name» уйдёт из этой тренировки. Ничего записанного не потеряется.';
  }

  @override
  String get drop => 'Убрать';

  @override
  String get resetData => 'Удалить все мои данные';

  @override
  String get resetTitle => 'Удалить всё?';

  @override
  String get resetBody =>
      'Тренировки, рекорды, программы, заметки и профиль. Это необратимо — сначала выгрузи резервную копию, если она может понадобиться.';

  @override
  String get resetConfirm => 'Удалить всё';

  @override
  String get resetDone => 'Все данные удалены';

  @override
  String get support => 'ПОДДЕРЖКА';

  @override
  String get reportBug => 'Сообщить об ошибке';

  @override
  String get requestFeature => 'Предложить функцию';

  @override
  String get starOnGithub => 'Звезда на GitHub';

  @override
  String get buyCoffee => 'Купить мне кофе';

  @override
  String get cantOpenLink => 'Не удалось открыть ссылку';

  @override
  String get theme => 'Тема';

  @override
  String get darkTheme => 'Тёмная';

  @override
  String get lightTheme => 'Светлая';

  @override
  String get amoledTheme => 'Чёрная AMOLED';

  @override
  String get editDuration => 'Длительность тренировки';

  @override
  String get sessionName => 'Название тренировки';

  @override
  String get nameWorkout => 'Назвать';

  @override
  String get sessionNameHint => 'напр. Ноги, Жимы, Всё тело';

  @override
  String get secondaryPickHint => 'Отметь другие мышцы, которые работают в этом упражнении.';

  @override
  String get languageLabel => 'Язык';

  @override
  String get unitsLabel => 'Единицы';

  @override
  String get restTimer => 'Таймер отдыха';

  @override
  String get alarmBlockedTitle => 'Уведомления выключены';

  @override
  String get alarmBlockedBody => 'Сигнал отдыха не сработает при заблокированном экране';

  @override
  String get alarmBlockedAction => 'ВКЛЮЧИТЬ';

  @override
  String get alarmSound => 'Звук сигнала';

  @override
  String get alarmDefaultName => 'Стандартный';

  @override
  String get alarmSoundHint => 'Поставь свой — до 15 секунд';

  @override
  String get alarmChoose => 'Выбрать звук…';

  @override
  String get alarmPreview => 'Проиграть текущий звук';

  @override
  String get alarmReset => 'Вернуть стандартный';

  @override
  String get alarmTooLong => 'Этот звук длиннее 15 секунд';

  @override
  String get alarmInvalid => 'Не удалось прочитать этот аудиофайл';

  @override
  String alarmChanged(String name) {
    return 'Звук сигнала: «$name»';
  }

  @override
  String get alarmChangedDefault => 'Вернулись к стандартному звуку';

  @override
  String get addActivityWidget => 'Добавить виджет активности';

  @override
  String get addStatsWidget => 'Добавить виджет статистики';

  @override
  String get pinUnsupported => 'Добавь его из меню виджетов твоего лаунчера';

  @override
  String get background => 'Фон';

  @override
  String get bgNone => 'Нет';

  @override
  String get bgDots => 'Точки';

  @override
  String get bgGrid => 'Сетка';

  @override
  String get exportCsv => 'Выгрузить тренировки (CSV)';

  @override
  String get exportBackup => 'Выгрузить резервную копию (ZIP)';

  @override
  String get importBackup => 'Загрузить резервную копию';

  @override
  String get importHint =>
      'Выбери .zip (или старый .json), выгруженный из GymMane. Это заменит текущие данные вместе с медиа.';

  @override
  String get import => 'Загрузить';

  @override
  String get chooseFile => 'Выбрать файл';

  @override
  String get importFromApp => 'Импорт из другого приложения';

  @override
  String get importUnknownFormat => 'Этот файл — не выгрузка из Hevy, Strong или FitNotes';

  @override
  String get importZipNoWeights => 'В этом zip нет файла с весом';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Загружено $n взвешивания',
      many: 'Загружено $n взвешиваний',
      few: 'Загружено $n взвешивания',
      one: 'Загружено $n взвешивание',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Не удалось прочитать этот файл';

  @override
  String get importUnitTitle => 'В каких единицах этот файл?';

  @override
  String get importUnitBody => 'В этой выгрузке не сказано, в каких единицах указан вес.';

  @override
  String get importNothing => 'Нового для загрузки нет';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Загружено $n тренировки',
      many: 'Загружено $n тренировок',
      few: 'Загружено $n тренировки',
      one: 'Загружена $n тренировка',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'О GymMane';

  @override
  String get yourProfile => 'ТВОЙ ПРОФИЛЬ';

  @override
  String get autofills => 'Подставляется в калькуляторы';

  @override
  String get onbUnitsWhy =>
      'Для весов, замеров и расстояний. Это можно изменить в любой момент в Настройках.';

  @override
  String get nameLabel => 'ИМЯ';

  @override
  String get sexLabel => 'ПОЛ';

  @override
  String get macroProtein => 'БЕЛКИ';

  @override
  String get macroCarbs => 'УГЛЕВОДЫ';

  @override
  String get macroFat => 'ЖИРЫ';

  @override
  String get male => 'Мужской';

  @override
  String get female => 'Женский';

  @override
  String get ageLabel => 'ВОЗРАСТ';

  @override
  String get heightLabel => 'РОСТ';

  @override
  String get weightLabel => 'ВЕС';

  @override
  String get weeklyGoal => 'ЦЕЛЬ НА НЕДЕЛЮ';

  @override
  String get activityLabel => 'АКТИВНОСТЬ';

  @override
  String get addPhoto => 'Добавить фото';

  @override
  String get removePhoto => 'Убрать фото';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get chooseGallery => 'Выбрать из галереи';

  @override
  String get backupImported => 'Резервная копия загружена';

  @override
  String get backupFailed => 'Не удалось прочитать эту копию';

  @override
  String get nothingToExport => 'Выгружать пока нечего — сначала запиши тренировку';

  @override
  String calculatorsCount(int n) {
    return 'Калькуляторов для твоих тренировок: $n';
  }

  @override
  String get result => 'РЕЗУЛЬТАТ';

  @override
  String get weightLifted => 'ПОДНЯТЫЙ ВЕС';

  @override
  String get repsPerformed => 'СДЕЛАНО ПОВТОРОВ';

  @override
  String get neck => 'ШЕЯ';

  @override
  String get waist => 'ТАЛИЯ';

  @override
  String get hip => 'БЁДРА (для женщин)';

  @override
  String get targetWeight => 'ЦЕЛЕВОЙ ВЕС';

  @override
  String get workingWeight => 'РАБОЧИЙ ВЕС';

  @override
  String get activityLevel => 'УРОВЕНЬ АКТИВНОСТИ';

  @override
  String get barWeight => 'ВЕС ГРИФА';

  @override
  String get perSide => 'НА СТОРОНУ';

  @override
  String get justTheBar => 'Только гриф.';

  @override
  String perSideCount(int n) {
    return '× $n на сторону';
  }

  @override
  String get toolNameRm => '1ПМ';

  @override
  String get toolNameBmi => 'ИМТ';

  @override
  String get toolNameCal => 'Калории';

  @override
  String get toolNameBf => 'Жир';

  @override
  String get toolNamePlate => 'Блины';

  @override
  String get toolNameWarmup => 'Разминка';

  @override
  String get toolTitleRm => 'Калькулятор 1ПМ';

  @override
  String get toolTitleBmi => 'Калькулятор ИМТ';

  @override
  String get toolTitleCal => 'Калории и БЖУ';

  @override
  String get toolTitleBf => 'Процент жира';

  @override
  String get toolTitlePlate => 'Калькулятор блинов';

  @override
  String get toolTitleWarmup => 'Разминочные подходы';

  @override
  String get toolHintRm => 'Оценка максимума на 1 повтор (формула Эпли)';

  @override
  String get toolHintCal => 'Оценка суточной нормы поддержания';

  @override
  String get toolHintBf => 'Оценка по методу ВМС США';

  @override
  String get toolHintPlate => 'Общий вес штанги';

  @override
  String get toolHintWarmup => 'Целевой рабочий вес';

  @override
  String get toolDescRm => 'Расчётный максимум на 1 повтор';

  @override
  String get toolDescBmi => 'Индекс массы тела';

  @override
  String get toolDescCal => 'Калории и БЖУ';

  @override
  String get toolDescBf => 'Процент жира в теле';

  @override
  String get toolDescPlate => 'Расчёт блинов на штангу';

  @override
  String get toolDescWarmup => 'Подводящие подходы';

  @override
  String get bmiUnderweight => 'Недовес';

  @override
  String get bmiNormal => 'Норма';

  @override
  String get bmiOverweight => 'Избыток';

  @override
  String get bmiObese => 'Ожирение';

  @override
  String get actSedentary => 'Сидячая';

  @override
  String get actLight => 'Лёгкая';

  @override
  String get actActive => 'Высокая';

  @override
  String get actModerate => 'Умеренная';

  @override
  String get muscleChest => 'Грудь';

  @override
  String get muscleBack => 'Спина';

  @override
  String get muscleLowerBack => 'Поясница';

  @override
  String get muscleShoulders => 'Плечи';

  @override
  String get muscleBiceps => 'Бицепс';

  @override
  String get muscleTriceps => 'Трицепс';

  @override
  String get muscleForearm => 'Предплечье';

  @override
  String get muscleTrapezius => 'Трапеция';

  @override
  String get muscleAbdomen => 'Пресс';

  @override
  String get muscleObliques => 'Косые';

  @override
  String get muscleQuads => 'Квадрицепс';

  @override
  String get muscleHamstrings => 'Бицепс бедра';

  @override
  String get muscleGlutes => 'Ягодицы';

  @override
  String get muscleCalves => 'Икры';

  @override
  String get mgChest => 'Грудь';

  @override
  String get mgBack => 'Спина';

  @override
  String get mgLegs => 'Ноги';

  @override
  String get mgShoulders => 'Плечи';

  @override
  String get mgArms => 'Руки';

  @override
  String get mgCore => 'Кор';

  @override
  String get equipBarbell => 'Штанга';

  @override
  String get equipDumbbell => 'Гантели';

  @override
  String get equipCable => 'Блок';

  @override
  String get equipMachine => 'Тренажёр';

  @override
  String get equipBodyweight => 'Свой вес';

  @override
  String get equipWeighted => 'С отягощением';

  @override
  String get equipBand => 'Резина';

  @override
  String get equipKettlebell => 'Гиря';

  @override
  String get equipRings => 'Кольца';

  @override
  String get equipOther => 'Другое';

  @override
  String get diffBeginner => 'Новичок';

  @override
  String get diffAdvanced => 'Продвинутый';

  @override
  String get diffIntermediate => 'Средний';

  @override
  String get about => 'О ПРИЛОЖЕНИИ';

  @override
  String version(String v) {
    return 'Версия $v';
  }

  @override
  String get aboutBlurb => 'Сделано теми, кто тягает, для тех, кто тягает.';

  @override
  String get freeForever => 'Бесплатно навсегда';

  @override
  String get freeForeverWhy => 'Без подписок, без рекламы, ничего не спрятано за платной стеной.';

  @override
  String get fullyOffline => 'Полностью офлайн';

  @override
  String get fullyOfflineWhy => 'Без аккаунта и серверов. Твои тренировки не покидают этот телефон.';

  @override
  String get yoursToTake => 'Данные — твои';

  @override
  String get yoursToTakeWhy => 'Выгружай их в CSV когда захочешь и удали всё одним нажатием.';

  @override
  String get whatsInside => 'ЧТО ВНУТРИ';

  @override
  String exercisesInside(int n) {
    return '$n упражнений';
  }

  @override
  String get exercisesInsideWhy => 'Каждое с анимацией и пошаговой инструкцией.';

  @override
  String get calculatorsInside => '10 калькуляторов';

  @override
  String get calculatorsInsideWhy =>
      '1ПМ, блины, ИМТ, калории, жир, FFMI, разминка, вес по RPE и очки силы DOTS и Wilks — все по опубликованным формулам.';

  @override
  String get mathInside => 'Честная математика';

  @override
  String get mathInsideWhy =>
      'Объём, рекорды и серии считаются по твоим подходам. Здесь ничего не нарисовано для красоты.';

  @override
  String get streakCaps => 'СЕРИЯ';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'дня',
      many: 'дней',
      few: 'дня',
      one: 'день',
    );
    return '$_temp0';
  }

  @override
  String get reset => 'СБРОС';

  @override
  String get welcomeKicker => 'ДОБРО ПОЖАЛОВАТЬ В';

  @override
  String get welcomeBlurb => 'Всё остаётся на твоём телефоне. Без аккаунта, без интернета, без оплаты.';

  @override
  String get welcomeStart => 'НАЧАТЬ';

  @override
  String onbStep(int i, int n) {
    return 'ШАГ $i ИЗ $n';
  }

  @override
  String get onbNameTitle => 'Как к тебе обращаться?';

  @override
  String get onbNameHint => 'Твоё имя';

  @override
  String get onbPhotoAdd => 'Добавить фото';

  @override
  String get onbPhotoChange => 'Сменить фото';

  @override
  String get onbPhotoTitle => 'Добавь лицо в профиль';

  @override
  String get onbPhotoWhy =>
      'Необязательно. Фото останется на телефоне, его можно сменить в профиле в любой момент.';

  @override
  String get onbPhotoLater => 'ПОЗЖЕ';

  @override
  String get onbNameWhy => 'Нужно только для приветствия. Телефон оно не покидает.';

  @override
  String get onbBodyTitle => 'Пара цифр';

  @override
  String get onbBodyWhy => 'Они питают калькуляторы. Поменять их можно в любой момент в настройках.';

  @override
  String get onbGoalTitle => 'Как часто ты тренируешься?';

  @override
  String get onbGoalWhy => 'Задаёт кольцо недельной цели. Будь честен, а не амбициозен.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренировки в неделю',
      many: '$n тренировок в неделю',
      few: '$n тренировки в неделю',
      one: '$n тренировка в неделю',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Килограммы или фунты?';

  @override
  String get next => 'ДАЛЕЕ';

  @override
  String get back => 'НАЗАД';

  @override
  String get skip2 => 'Пропустить';

  @override
  String get madeWithLoveBy => 'СДЕЛАНО С ЛЮБОВЬЮ';

  @override
  String get sourceCode => 'ИСХОДНЫЙ КОД';

  @override
  String get suggested => 'ПОДБОРКА';

  @override
  String get results => 'РЕЗУЛЬТАТЫ';

  @override
  String get noMatches => 'По этому запросу упражнений нет.';

  @override
  String get tapToEdit => 'Нажми на карандаш, чтобы исправить запись, или на корзину, чтобы удалить.';

  @override
  String get editEntry => 'Изменить';

  @override
  String get editEntryHint => 'Исправь повторы или вес в любом подходе.';

  @override
  String get removeSet => 'Убрать подход';

  @override
  String get continueWorkout => 'ПРОДОЛЖИТЬ';

  @override
  String get continueWorkoutBody =>
      'Тренировка снова станет активной, с уже отмеченными подходами. Повторное завершение сохранит её в исходный день.';

  @override
  String get addBodyWidget => 'Добавить виджет карты мышц';

  @override
  String get repsOnly => 'Только повторы';

  @override
  String get repsOnlyHint => 'Записывать это упражнение без веса.';

  @override
  String get eachSide => 'Каждая сторона';

  @override
  String get eachSideHint => 'Таймер идёт на каждую сторону, отдых начинается после обеих.';

  @override
  String get useDefaultArt => 'Вернуть стандартную картинку';

  @override
  String daysShort(int n) {
    return '$n д';
  }

  @override
  String get focusCard => 'Фокус на сегодня';

  @override
  String get autoAdvance => 'Переходить дальше сам';

  @override
  String get keepScreenOn => 'Не гасить экран во время тренировки';

  @override
  String get lockWorkout => 'Заблокировать экран';

  @override
  String get unlockWorkout => 'Разблокировать';

  @override
  String get holdToUnlock => 'Удерживай, чтобы разблокировать';

  @override
  String get liveChannel => 'Текущая тренировка';

  @override
  String get liveChannelWhy => 'Показывает упражнение, подход и отдых во время тренировки';

  @override
  String liveSet(int n, int total) {
    return 'Подход $n из $total';
  }

  @override
  String get liveResting => 'Отдых';

  @override
  String get liveAllDone => 'Все подходы выполнены';

  @override
  String get autoAdvanceHint =>
      'Когда отметишь последний подход упражнения, тренировка перейдёт к следующему.';

  @override
  String get placePlates => 'Блины и гриф';

  @override
  String get platesAll => 'Всё доступно';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n размера',
      many: '$n размеров',
      few: '$n размера',
      one: '$n размер',
    );
    return '$_temp0';
  }

  @override
  String get platePairs => 'ПАРЫ';

  @override
  String plateAchievable(String w) {
    return 'Ближайший вес, который соберётся: $w';
  }

  @override
  String get autoWarmup => 'Начинать с разминки';

  @override
  String get autoWarmupHint => 'Добавляет разминочные подходы при открытии тренировки.';

  @override
  String get trainReminder => 'Напоминание о тренировке';

  @override
  String get trainReminderHint => 'Напомнит в это время, только в те дни, на которые стоит программа.';

  @override
  String get reminderExactTime => 'Точное время';

  @override
  String get toastSoundSetting => 'Звук уведомлений';

  @override
  String get toastSoundHint => 'Мягкий звук, когда сверху появляется уведомление.';

  @override
  String get notifTrainChannel => 'Напоминание о тренировке';

  @override
  String get notifTrainChannelWhy => 'Толчок потренироваться в те дни, что ты запланировал.';

  @override
  String get notifTrainTitle => 'Пора тренироваться';

  @override
  String get notifTrainBody => 'Твоя программа ждёт.';

  @override
  String get planIntro => 'Составь мне программу тренировок, используя только упражнения из этого списка.';

  @override
  String get planFormat => 'Ответь только в JSON, вот в таком виде:';

  @override
  String get planNothing => 'Ни одного упражнения из этого файла нет в твоей библиотеке';

  @override
  String get planFailed => 'Этот файл — не программа, его не прочитать';

  @override
  String get routineGroup => 'Группа';

  @override
  String get newGroup => 'Новая группа';

  @override
  String get noGroup => 'Без группы';

  @override
  String get groupNameHint => 'Push / Pull / Ноги, 5×5…';

  @override
  String get filters => 'Фильтры';

  @override
  String get setsPlannedHint => 'Выбери, сколько подходов хочешь в каждом. Тренировка откроется уже с ними.';

  @override
  String get nextTime => 'СЛЕДУЮЩИЙ';

  @override
  String get nextHold => 'тот же вес, пока не сделаешь все повторения';

  @override
  String get bgPhoto => 'Твоё фото';

  @override
  String get bgPhotoPick => 'Выбрать фото';

  @override
  String get bgPhotoChange => 'Поменять фото';

  @override
  String get bgPhotoRemove => 'Убрать фото';

  @override
  String get bgDim => 'НАСКОЛЬКО ТЕМНО';

  @override
  String get dimSoft => 'Слабо';

  @override
  String get dimMedium => 'Средне';

  @override
  String get dimStrong => 'Сильно';

  @override
  String get bgPhotoHint => 'Оно стоит за всем, затемнённое, чтобы приложение читалось.';

  @override
  String get reminderSmart => 'Умное';

  @override
  String get reminderFixed => 'В точное время';

  @override
  String get reminderSmartHint =>
      'Берёт дни и время, когда ты реально тренируешься, и молчит, если в этот день ты уже потренировался.';

  @override
  String get reminderSmartEmpty => 'Запиши ещё несколько тренировок, и оно выучит твои дни.';

  @override
  String habitFocus(String day) {
    return 'что ты обычно тренируешь в $day';
  }

  @override
  String get duplicateRoutine => 'Дублировать программу';

  @override
  String copySuffix(String name) {
    return '$name (копия)';
  }

  @override
  String get saveAsRoutine => 'СОХРАНИТЬ КАК ПРОГРАММУ';

  @override
  String get savedAsRoutine => 'Сохранено как программа';

  @override
  String get templates => 'Готовые программы';

  @override
  String get templatesHint =>
      'Классические программы, собранные из твоей библиотеки. Потом можно поменять что угодно.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'добавлено $n программы',
      many: 'добавлено $n программ',
      few: 'добавлено $n программы',
      one: 'добавлена $n программа',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Три дня в неделю на всё тело. С этого и начинают.';

  @override
  String get tplPpl => 'Жим, тяга и ноги. Три или шесть дней в неделю.';

  @override
  String get tplArnold => 'Грудь и спина, плечи и руки, ноги. Классический шестидневный сплит.';

  @override
  String get tplUpperlower => 'Верх и низ, четыре дня в неделю.';

  @override
  String get tplStronglifts => 'Две тренировки, пять подходов по пять, по очереди.';

  @override
  String get tplStartingstrength => 'Присед каждый раз, две чередующиеся тренировки.';

  @override
  String get tplHome => 'Только перекладина и пол.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дня',
      many: '$n дней',
      few: '$n дня',
      one: '$n день',
    );
    return '$_temp0';
  }

  @override
  String get logRpe => 'Записывать усилие (RPE)';

  @override
  String get rpeHint => '10 — больше ни одного повторения; 8 — оставалось ещё два.';

  @override
  String get superset => 'Суперсет';

  @override
  String get supersetLink => 'Связать со следующим';

  @override
  String get supersetUnlink => 'Отвязать от следующего';

  @override
  String get supersetHint => 'Между связанными упражнениями отдыха нет: сразу идёшь к следующему.';

  @override
  String get aiRoutine => 'Программа с ИИ';

  @override
  String get aiIntro =>
      'GymMane ни с каким ИИ не общается. Ты сам выгружаешь список упражнений, вставляешь его в тот ассистент, которым уже пользуешься, и приносишь ответ обратно. С телефона само ничего не уходит.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n названий не нашлось в твоей библиотеке',
      many: '$n названий не нашлось в твоей библиотеке',
      few: '$n названия не нашлись в твоей библиотеке',
      one: '$n название не нашлось в твоей библиотеке',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Какие приложения читает';

  @override
  String get importOtherCsv => 'Любой другой CSV с датой, упражнением, повторениями и весом';

  @override
  String get importAskApp => 'Нужно другое приложение? Попроси';

  @override
  String get awardFirstStepName => 'Первый шаг';

  @override
  String get awardFirstStepLine => 'Добро пожаловать в GymMane. Эта — от заведения.';

  @override
  String get awardFirstWorkoutName => 'Первая тренировка';

  @override
  String get awardFirstWorkoutLine => 'Первая записана. Она и есть самая трудная.';

  @override
  String get awardFirstRoutineName => 'Первая программа';

  @override
  String get awardFirstRoutineLine => 'Теперь есть план, к которому возвращаться.';

  @override
  String get awardFirstRecordName => 'Первый рекорд';

  @override
  String get awardFirstRecordLine => 'Ты побил свой лучший результат в упражнении.';

  @override
  String get awardStreak3Name => 'Три подряд';

  @override
  String get awardStreak3Line => 'Три дня подряд. Так всё и начинается.';

  @override
  String get awardTonne1Name => 'Одна тонна';

  @override
  String get awardTonne1Line => 'Тысяча килограммов, поднятая за все подходы.';

  @override
  String get awardSets100Name => 'Сто подходов';

  @override
  String get awardSets100Line => 'Сто подходов сделано, по одному за раз.';

  @override
  String get awardHours10Name => 'Десять часов';

  @override
  String get awardHours10Line => 'Десять часов тренировок по секундомеру.';

  @override
  String get awardWorkouts50Name => 'Пятьдесят тренировок';

  @override
  String get awardWorkouts50Line => 'Пятьдесят занятий позади.';

  @override
  String get awardHours50Name => 'Пятьдесят часов';

  @override
  String get awardHours50Line => 'Пятьдесят часов в зале.';

  @override
  String get awardsTitle => 'Медали';

  @override
  String get yearTitle => 'Твой год';

  @override
  String get yearBestMonth => 'Лучший месяц';

  @override
  String get yearMonths => 'месяцы';

  @override
  String get awardSpinHint => 'Потяни медаль, чтобы покрутить';

  @override
  String get awardUnlocked => 'Новое достижение открыто';

  @override
  String get awardNice => 'Отлично!';

  @override
  String get awardSaveImage => 'Сохранить картинку';

  @override
  String get awardSaved => 'Сохранено в галерею';

  @override
  String get awardStreak7Name => 'Семь дней';

  @override
  String get awardStreak7Line => 'Целая неделя без единого пропуска.';

  @override
  String get awardStreak30Name => 'Тридцать дней';

  @override
  String get awardStreak30Line => 'Месяц подряд. Это уже привычка.';

  @override
  String get awardWorkouts100Name => 'Сто тренировок';

  @override
  String get awardWorkouts100Line => 'Сто занятий записано от начала до конца.';

  @override
  String get awardTonnes100Name => 'Сто тонн';

  @override
  String get awardTonnes100Line => 'Всё, что ты поднял, складывается в 100 000 кг.';

  @override
  String get awardSets1000Name => 'Тысяча подходов';

  @override
  String get awardSets1000Line => 'По одному подходу за раз — и вот их тысяча.';

  @override
  String get profile => 'Профиль';

  @override
  String get editProfile => 'Изменить профиль';

  @override
  String get pickBadge => 'Значок';

  @override
  String get statWorkouts => 'Тренировки';

  @override
  String get statTrained => 'Тренировался';

  @override
  String get statSets => 'Подходы';

  @override
  String get statLifted => 'Поднято';

  @override
  String get statStreak => 'Серия';

  @override
  String get statDays => 'дней';

  @override
  String get unitHours => 'ч';

  @override
  String get unitDays => 'дней';

  @override
  String get snapshots => 'Фото';

  @override
  String get snapNow => 'Сделать фото';

  @override
  String get addCover => 'Поставь обложку';

  @override
  String get addTodayWidget => 'Сегодня: сделано или нет';

  @override
  String get photosCard => 'Твои фото';

  @override
  String get handleLabel => 'Имя пользователя';

  @override
  String get setupTitle => 'Заполни это, и остальная страница заполнится сама';

  @override
  String get setupHint =>
      'Каждая цифра здесь берётся из того, что ты записываешь. Никуда ничего не отправляется.';

  @override
  String get setupWorkout => 'Запиши первую тренировку';

  @override
  String get setupWeight => 'Запиши свой вес';

  @override
  String get setupMeasures => 'Сними мерки';

  @override
  String get setupPhoto => 'Сделай первое фото прогресса';

  @override
  String get progressTitle => 'Прогресс';

  @override
  String get tileVolume30 => 'Объём · 30 дн';

  @override
  String get tileAddWeight => 'Записать';

  @override
  String get heatToneTitle => 'Цвет карты';

  @override
  String get heatToneHint => 'Меняет только то, каким цветом рисуются сетка и тело.';

  @override
  String get thisWeekTitle => 'Эта неделя';

  @override
  String get momentsEmptyTitle => 'Здесь пока пусто';

  @override
  String get deletePhotoTitle => 'Удалить это фото?';

  @override
  String get deletePhotoBody => 'Уйдёт навсегда.';

  @override
  String get awardsEarned => 'Получены';

  @override
  String get awardsLocked => 'Закрыты';

  @override
  String get awardStreak100Name => 'Сто дней';

  @override
  String get awardWorkouts10Name => 'Десять тренировок';

  @override
  String get awardWorkouts10Line => 'Первые десять — те, что всё решают.';

  @override
  String get awardWorkouts365Name => 'Триста шестьдесят пять';

  @override
  String get awardWorkouts365Line => 'По тренировке на каждый день года, записаны одна за другой.';

  @override
  String get awardTonnes10Name => 'Десять тонн';

  @override
  String get awardTonnes10Line => 'Десять тысяч килограммов прошли через твои руки.';

  @override
  String get awardHours100Name => 'Сто часов';

  @override
  String get awardHours100Line => 'Сто часов под штангой, с секундомером в руке.';

  @override
  String awardWonOn(String date) {
    return 'Получена $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Золотой',
      'blue': 'Синий',
      'green': 'Зелёный',
      'other': 'Значок',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'С $date';
  }

  @override
  String levelShort(int n) {
    return 'Уровень $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренировки до уровня $next',
      many: '$n тренировок до уровня $next',
      few: '$n тренировки до уровня $next',
      one: '$n тренировка до уровня $next',
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
      'ember': 'Уголь',
      'green': 'Зелёный',
      'blue': 'Синий',
      'mono': 'Серый',
      'other': 'Цвет',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return 'подходов: $n';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n из $goal на этой неделе';
  }

  @override
  String momentCount(int n) {
    return '$n фото';
  }

  @override
  String photosSelected(int n) {
    return 'Выбрано: $n';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Удалить фото ($n)?';
  }

  @override
  String get momentsEmptyHint =>
      'Сфотографируй зал, доску, как ты набрал блины — всё, что хочешь запомнить. Они останутся в телефоне, и видишь их только ты.';

  @override
  String get awardStreak100Line => 'Сто дней подряд. Это уже не мотивация, это ты.';

  @override
  String get coverLabel => 'ОБЛОЖКА';

  @override
  String get removeCover => 'Убрать обложку';

  @override
  String get startTitle => 'Начать тренировку';

  @override
  String get logTitle => 'Записать тренировку';

  @override
  String get logHint => 'Без секундомера: просто заполни, что ты сделал.';

  @override
  String get orStartFrom => 'Или начни с';

  @override
  String get pickExercisesOption => 'Выбрать упражнения';

  @override
  String get chooseFocusOption => 'Выбрать по мышцам';

  @override
  String get plannedRoutine => 'ЗАПЛАНИРОВАНО';

  @override
  String get logWorkoutAction => 'ЗАПИСАТЬ ТРЕНИРОВКУ';

  @override
  String get logging => 'ЗАПИСЬ';

  @override
  String get placesLabel => 'Мои места';

  @override
  String get undo => 'Отменить';

  @override
  String get deleteSet => 'Удалить подход';

  @override
  String get setDeleted => 'Подход удалён';

  @override
  String get removeWarmup => 'Убрать разминку';

  @override
  String get addWeightAction => 'Добавить вес';

  @override
  String get workoutOverview => 'Эта тренировка';

  @override
  String get allExercisesShort => 'Все';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total подх.';
  }

  @override
  String get nowLabel => 'Сейчас';

  @override
  String get deleteWorkout => 'Удалить тренировку';

  @override
  String get deleteWorkoutBody => 'Тренировка и все её подходы будут удалены из истории.';

  @override
  String get themeAuto => 'Авто';

  @override
  String get themeAutoHint => 'Как в системе';

  @override
  String get demoSizeTitle => 'Демонстрация во время тренировки';

  @override
  String get demoLarge => 'Крупно';

  @override
  String get demoSmall => 'Мелко';

  @override
  String get demoOff => 'Скрыта';

  @override
  String get demoLoopTitle => 'Анимация демо';

  @override
  String get demoLoopAlways => 'По кругу';

  @override
  String get demoLoopShort => '10 секунд';

  @override
  String get demoLoopHint =>
      'Двигается около 10 секунд и останавливается в исходной позе. Нажмите на демо, чтобы посмотреть снова.';

  @override
  String get alarmStyleTitle => 'Когда отдых закончится';

  @override
  String get alarmStyleLoud => 'Всегда звонить';

  @override
  String get alarmStyleQuiet => 'Учитывать беззвучный';

  @override
  String get alarmStyleVibrate => 'Только вибрация';

  @override
  String get alarmStyleHint =>
      '«Всегда звонить» использует громкость будильника даже в беззвучном режиме. «Учитывать беззвучный» использует громкость уведомлений и только вибрирует, если звук выключен.';

  @override
  String get suggestedPicks => 'Рекомендуем';

  @override
  String get moreOptions => 'Ещё варианты';

  @override
  String get suggestInWorkouts => 'Предлагать в быстрых тренировках';

  @override
  String get suggestInWorkoutsHint =>
      'Если выключить, упражнение не попадёт в подборку. Добавить его вручную всё равно можно.';

  @override
  String get onbPlaceTitle => 'Где ты тренируешься?';

  @override
  String get onbPlaceWhy =>
      'Отметь все места, где тренируешься. Предложим только то, что можно сделать в каждом.';

  @override
  String get onbPlaceGear => 'Что у тебя там есть?';

  @override
  String distanceCol(String unit) {
    return 'ДИСТАНЦИЯ ($unit)';
  }

  @override
  String get timeCol => 'ВРЕМЯ';

  @override
  String get timePerSideCol => 'ВРЕМЯ / СТОРОНА';

  @override
  String get timeMinutesTitle => 'Время (минуты)';

  @override
  String get timeSecondsTitle => 'Время (секунды)';

  @override
  String distanceTitle(String unit) {
    return 'Дистанция ($unit)';
  }

  @override
  String get holdLabel => 'Держи';

  @override
  String get stopLabel => 'Стоп';

  @override
  String startHold(String time) {
    return 'Начать · $time';
  }

  @override
  String get exerciseTypeLabel => 'Что записывать';

  @override
  String get typeReps => 'Повторы и вес';

  @override
  String get typeTime => 'Время';

  @override
  String get typeCardio => 'Дистанция и время';

  @override
  String get exerciseTypeHint =>
      'Кардио, например бег или плавание, записывается дистанцией и временем. Статика, как планка, — временем.';

  @override
  String get howToLabel => 'Техника (необязательно)';

  @override
  String get howToHint => 'Один шаг на строку';

  @override
  String get editExercise => 'Изменить упражнение';

  @override
  String get saveChanges => 'Сохранить';

  @override
  String get noStepsYet => 'Шагов пока нет. Запиши свои, чтобы не забыть, как ты это делаешь.';

  @override
  String get addSteps => 'Записать шаги';

  @override
  String get setTypeRestPause => 'Отдых-пауза';

  @override
  String get setTypeNormalInfo => 'Обычный подход. Учитывается в объёме и рекордах.';

  @override
  String get setTypeWarmupInfo => 'Лёгкие подходы для разминки. Не учитываются в объёме и рекордах.';

  @override
  String get setTypeDropInfo => 'Сразу после подхода снизьте вес и продолжайте без отдыха.';

  @override
  String get setTypeFailureInfo =>
      'Продолжайте, пока не сможете сделать ещё одно чистое повторение. Записывайте, сколько сделали на самом деле.';

  @override
  String get setTypeRestPauseInfo =>
      'Отдохните 10–20 секунд после подхода и выжмите ещё несколько повторений.';

  @override
  String get planFormatNotes =>
      'Используй названия упражнений точно как в списке. \"sets\", \"reps\", \"weight\" (в указанных единицах), \"rest\" в секундах и \"days\" необязательны. \"superset\": true связывает упражнение со следующим. Для нескольких недель сгруппируй тренировки внутри \"weeks\", как во втором примере.';

  @override
  String get planSets => 'Спланировать подходы';

  @override
  String get planSetsHint =>
      'Выбери тип, повторы и вес каждого подхода. Оставь вес на «Авто», чтобы начать с прошлой тренировки.';

  @override
  String get planHintReps =>
      'Выбери тип и число повторений каждого подхода. «Авто» берёт данные прошлой тренировки.';

  @override
  String get planHintTime => 'Выбери тип и время каждого подхода. «Авто» берёт данные прошлой тренировки.';

  @override
  String get planHintTimeWeight =>
      'Выбери тип, время и вес каждого подхода. «Авто» берёт данные прошлой тренировки.';

  @override
  String get planHintCardio =>
      'Выбери дистанцию и время каждого подхода. «Авто» берёт данные прошлой тренировки.';

  @override
  String get timeOnly => 'Только время';

  @override
  String get autoValue => 'Авто';

  @override
  String get clearPlan => 'Сбросить план';

  @override
  String get shareRoutine => 'Поделиться тренировкой';

  @override
  String get shareWeek => 'Поделиться неделей';

  @override
  String get shareWeekHint => 'Все твои тренировки и дни, на которые они стоят.';

  @override
  String shareMessage(String name) {
    return '$name — открой файл в GymMane, чтобы добавить.';
  }

  @override
  String get importRoutines => 'Импорт тренировок';

  @override
  String get importPasteHint => 'Вставь сюда тренировку: отправленную из GymMane, ответ ИИ, JSON или CSV.';

  @override
  String get pasteAction => 'Вставить';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренировки',
      many: '$n тренировок',
      few: '$n тренировки',
      one: '$n тренировка',
    );
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Применить и расписание по дням';

  @override
  String get useTheirScheduleHint => 'Дни из файла заменят то, что у тебя на них запланировано.';

  @override
  String get addToMyRoutines => 'Добавить к моим тренировкам';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Добавлено $n тренировки',
      many: 'Добавлено $n тренировок',
      few: 'Добавлено $n тренировки',
      one: 'Добавлена $n тренировка',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Здесь нет ничего, что GymMane может импортировать';

  @override
  String get aiStepCopy =>
      'Скопируй запрос. В нём твой список упражнений и формат, который понимает GymMane.';

  @override
  String get aiStepAsk => 'Вставь его в любой ИИ и скажи, что нужно: дни в неделю, цель, сколько недель.';

  @override
  String get aiStepPaste => 'Вставь ответ ниже и импортируй. Никаких файлов.';

  @override
  String get copyForAi => 'Скопировать для ИИ';

  @override
  String get copiedDone => 'Скопировано';

  @override
  String get aiPasteHint => 'Вставь сюда ответ ИИ';

  @override
  String get importAction => 'Импортировать';

  @override
  String get showFormat => 'Показать формат';

  @override
  String get shareAsFile => 'Отправить файлом';

  @override
  String get recoveryTab => 'Восстановление';

  @override
  String recoveryOverall(int pct) {
    return 'Тело восстановлено на $pct%';
  }

  @override
  String get recoveryAllFresh => 'Всё восстановлено. Хороший день, чтобы тренировать что угодно.';

  @override
  String recoveryStill(String muscles) {
    return 'Ещё восстанавливаются: $muscles';
  }

  @override
  String get recoveryTired => 'Устал';

  @override
  String get recoveryFresh => 'Свежий';

  @override
  String get recoveryHint =>
      'Нажми на мышцу, чтобы увидеть, насколько она восстановилась. Недавние подходы весят больше, а тяжёлые (по RPE) — ещё больше.';

  @override
  String recoveryPct(int pct) {
    return 'восстановлено на $pct%';
  }

  @override
  String readyInHours(int h) {
    return 'готово через ~$h ч';
  }

  @override
  String get tplAbcd => 'Четыре дня: грудь и трицепс, спина и бицепс, ноги, плечи и пресс.';

  @override
  String get tplAbcde => 'Пять дней, по группе мышц на каждый: грудь, спина, ноги, плечи, руки.';

  @override
  String get elapsedCaps => 'ПРОШЛО';

  @override
  String get tapToChange => 'Нажми, чтобы изменить';

  @override
  String get swipeToSkipHint => 'Смахни таймер в сторону, чтобы пропустить отдых.';

  @override
  String get screenLocked => 'Экран заблокирован';

  @override
  String get lockedHint => 'Нажми и удерживай отпечаток сверху, чтобы разблокировать';

  @override
  String get liveDoneSet => 'Подход готов';

  @override
  String get liveSkipRest => 'Пропустить отдых';

  @override
  String get livePause => 'Пауза';

  @override
  String get liveResume => 'Продолжить';

  @override
  String get liveNext => 'Дальше';

  @override
  String liveUpNext(String name) {
    return 'Дальше: $name';
  }

  @override
  String get stickerOpen => 'Поделиться на фото';

  @override
  String get stickerNoPhoto => 'Без фото';

  @override
  String get stickerWorkout => 'Тренировка';

  @override
  String get stickerStreak => 'Серия';

  @override
  String get stickerDate => 'Дата';

  @override
  String get stickerHint => 'Перетащи, чтобы сдвинуть, и сведи пальцы, чтобы изменить размер или повернуть';

  @override
  String get stickerSaved => 'Сохранено в галерею';

  @override
  String get stickerWeek => 'Эта неделя';

  @override
  String get getReady => 'Приготовься';

  @override
  String sideOfTwo(String n) {
    return 'Сторона $n из 2';
  }

  @override
  String get switchSides => 'Смени сторону';

  @override
  String get stickerGallery => 'Галерея';

  @override
  String get stickerCamera => 'Камера';

  @override
  String get shareIntroTitle => 'Поделись этой программой';

  @override
  String get shareIntroBody =>
      'Отправь её партнёру, другу или семье. Они получат небольшой файл, который открывается в GymMane и добавляет программу одним касанием, с подходами и весами.';

  @override
  String get removedFromRoutine => 'Убрано из программы';

  @override
  String get radarTitle => 'Последние 30 дней';

  @override
  String get radarHint => 'Посмотри, каким зонам нужно больше работы';

  @override
  String get radarEmpty => 'Потренируйтесь несколько дней, чтобы увидеть баланс';

  @override
  String get radarBalanced => 'Пока всё сбалансировано';

  @override
  String radarFocus(String list) {
    return 'Нужно больше: $list';
  }

  @override
  String get countdownReady => 'Приготовься';

  @override
  String get countdownSkip => 'Нажми, чтобы начать сразу';

  @override
  String get countdownSetting => 'Обратный отсчёт перед стартом';

  @override
  String get effortSetting => 'Отмечать усилие';

  @override
  String get effortHint =>
      'RPE: 10 — больше ни одного повтора, 8 — оставалось два. RIR — сколько повторов оставалось в запасе. Если у подхода есть оценка, 1ПМ считается по таблице RPE.';

  @override
  String get rirHint => '0 — больше ни одного повтора, 2 — оставалось два.';

  @override
  String get addWeekWidget => 'Добавить виджет недели';

  @override
  String get gamificationSetting => 'Медали и уровни';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n повтора',
      many: '$n повторов',
      few: '$n повтора',
      one: '$n повтор',
    );
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Лучший подход';

  @override
  String get weekStartSetting => 'Неделя начинается с';

  @override
  String get stepOutOfWorkout => 'Пауза и выход';

  @override
  String get saveToRoutine => 'СОХРАНИТЬ ИЗМЕНЕНИЯ В ПРОГРАММЕ';

  @override
  String get routineUpdated => 'Программа обновлена';

  @override
  String saveChangesTitle(String name) {
    return 'Сохранить изменения в $name?';
  }

  @override
  String get saveChangesBody => 'В следующий раз, когда ты её начнёшь, в программе будут эти изменения.';

  @override
  String get routineOrderChanged => 'Новый порядок упражнений';

  @override
  String get mineOnly => 'Созданные вами';

  @override
  String createNamed(String name) {
    return 'Нет в списке? Создать «$name»';
  }

  @override
  String get orStartWith => 'Или начните с';

  @override
  String get warmupFocus => 'Разминка';

  @override
  String get warmupFocusHint => 'Подвижность и активация, с инвентарём или без';

  @override
  String get cardioFocus => 'Кардио';

  @override
  String get cardioFocusHint => 'Бег, велосипед, гребля или скакалка — по дистанции и времени';

  @override
  String get homeRecommended => 'Рекомендации на главной';

  @override
  String get homeRoutines => 'Тренировки на главной';

  @override
  String get homeRoutinesHint => 'Твои тренировки, последняя сделанная первой. Нажми, чтобы начать.';

  @override
  String get homeWeekStats => 'Эта неделя на главной';

  @override
  String get homeWeekStatsHint => 'Объём, подходы и рекорды за неделю.';

  @override
  String get stepsSetting => 'Шаги из Health Connect';

  @override
  String get stepsSettingHint => 'Показывает шаги за сегодня на главном экране. Ничего не покидает телефон.';

  @override
  String get stepsToday => 'Шаги сегодня';

  @override
  String stepsOfGoal(String goal) {
    return 'из $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return 'Сегодня шагов: $count';
  }

  @override
  String get stepsGoal => 'Дневная цель по шагам';

  @override
  String get stepsNoAccess => 'Нет доступа к шагам';

  @override
  String get stepsGrant => 'Нажми, чтобы разрешить в Health Connect';

  @override
  String get stepsInfoRead =>
      'Читает только число шагов. Больше ничего не читает и ничего не пишет в Health Connect.';

  @override
  String get stepsInfoLocal => 'Шаги остаются на телефоне. GymMane никогда не подключается к интернету.';

  @override
  String get stepsInfoOff => 'Можно отключить в любой момент в Настройках или в Health Connect.';

  @override
  String get stepsManage => 'Управлять разрешением';

  @override
  String get routineDoneToday => 'На сегодня всё · отличная работа';

  @override
  String get trainAgain => 'Тренироваться ещё';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дня назад',
      many: '$n дней назад',
      few: '$n дня назад',
      one: '$n день назад',
      zero: 'Сделано сегодня',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Архив';

  @override
  String get archiveExercise => 'Архивировать упражнение';

  @override
  String get restoreExercise => 'Восстановить';

  @override
  String get archivedToast => 'Упражнение в архиве';

  @override
  String get archivedToastHint => 'Оно в разделе Упражнения › Архив';

  @override
  String get archivedBanner => 'В архиве. Не показывается в списках и подсказках; история сохраняется.';

  @override
  String get videoMarksHint =>
      'Поставьте паузу на шаге и нажмите на булавку, чтобы в следующий раз перейти туда.';

  @override
  String get videoMarkHere => 'Отметить этот шаг здесь';

  @override
  String get sectionGeneral => 'Общие';

  @override
  String get sectionTraining => 'Тренировка';

  @override
  String get sectionAlerts => 'Напоминания и сигнал';

  @override
  String get sectionHome => 'Главная';

  @override
  String get sectionWidgets => 'Виджеты';

  @override
  String get sectionData => 'Данные и резервная копия';

  @override
  String get multiPlanSetting => 'Несколько программ в день';

  @override
  String get multiPlanHint => 'Отметьте каждую программу на этот день. Они идут в порядке добавления.';

  @override
  String routineOfDay(int n, int total) {
    return '$n из $total сегодня';
  }

  @override
  String get nextToday => 'Далее сегодня';

  @override
  String get planAboutMe => 'Обо мне:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age лет, рост $height, вес $weight.';
  }

  @override
  String planDays(int n) {
    return 'Хочу тренироваться $n дней в неделю.';
  }

  @override
  String get planNoHistory =>
      'Тренировок пока нет: считай меня новичком и будь осторожен с объёмом и весами.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n тренировки за последние 30 дней.',
      many: '$n тренировок за последние 30 дней.',
      few: '$n тренировки за последние 30 дней.',
      one: '$n тренировка за последние 30 дней.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Лучшие недавние подходы';

  @override
  String get planAskFirst =>
      'Если ты не знаешь мою цель (сила, мышцы, сжигание жира или общая форма) или сколько может длиться тренировка, сначала спроси меня одним коротким сообщением. Потом отвечай только JSON.';

  @override
  String get backToTop => 'Наверх';

  @override
  String get deleteExerciseTitle => 'Удалить это упражнение?';

  @override
  String deleteExerciseBody(String name) {
    return '«$name» будет удалено из библиотеки и программ. Прошлые подходы сохранятся.';
  }

  @override
  String get exportForStravaHint =>
      'Загрузите в браузере на strava.com/upload/select (приложение Strava не импортирует файлы). Появится как силовая тренировка с вашими подходами.';

  @override
  String get manualStartTime => 'Время начала';

  @override
  String get manualDuration => 'Длительность';

  @override
  String get manualDurationUnset => 'Указать длительность';

  @override
  String get stravaRow => 'Экспорт в Strava (бета)';

  @override
  String get stravaBeta => 'БЕТА';

  @override
  String get stravaIntro =>
      'Выберите тренировку для Strava. Вы получите файл .fit: загрузите его в браузере на strava.com/upload/select, и он появится как силовая тренировка с подходами.';

  @override
  String get stravaEmpty => 'Пока нет тренировок для экспорта.';

  @override
  String get tapToPause => 'Нажмите для паузы';

  @override
  String get holdPausedHint => 'Пауза · нажмите, чтобы продолжить';

  @override
  String get finishHoldNow => 'Завершить подход сейчас';

  @override
  String get barWeightExercise => 'Вес грифа или платформы';

  @override
  String get barWeightHint => 'Используется калькулятором блинов';

  @override
  String get barWeightCustom => 'Свой · нажмите, чтобы сбросить';

  @override
  String get groupRename => 'Переименовать группу';

  @override
  String get groupUngroup => 'Убрать группу, оставить программы';

  @override
  String get groupDeleteAll => 'Удалить группу и программы';

  @override
  String groupDeleteTitle(String name) {
    return 'Удалить «$name»?';
  }

  @override
  String groupDeleteBody(String count) {
    return 'Будут удалены: $count. История тренировок сохранится.';
  }

  @override
  String get tplRr =>
      'Классика r/bodyweightfitness: всё тело три дня в неделю. Переходи на следующую ступень, когда станет легко.';

  @override
  String get levelUpKicker => 'СЛЕДУЮЩИЙ ШАГ';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps в «$name» две тренировки подряд. Готов к следующему шагу?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Заменить в «$routine»';
  }

  @override
  String get levelUpSee => 'Как выполнять';

  @override
  String get levelUpLater => 'Не сейчас';

  @override
  String get levelUpStay => 'Оставить это';

  @override
  String levelUpSwapped(String name, String routine) {
    return '«$name» теперь в «$routine»';
  }

  @override
  String get levelUpStayed => 'Больше не предлагать усложнение для этого';

  @override
  String get levelHintsSetting => 'Предлагать следующий шаг';

  @override
  String get heatmapLabelsSetting => 'Дни и месяцы на карте активности';

  @override
  String get rmPercent => 'ПРОЦЕНТ';

  @override
  String rmAtPercent(String pct) {
    return '$pct от твоего максимума';
  }

  @override
  String get copyWorkout => 'Скопировать текстом';

  @override
  String get goalSet => 'Поставить цель';

  @override
  String get goalTargetReps => 'ЦЕЛЕВЫЕ ПОВТОРЫ';

  @override
  String goalToGo(String value) {
    return 'Осталось $value';
  }

  @override
  String get goalReached => 'Цель достигнута';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Осталось $n дней',
      few: 'Осталось $n дня',
      one: 'Остался $n день',
    );
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Срок прошёл';

  @override
  String get goalDeadline => 'СРОК';

  @override
  String get goalNoDeadline => 'Без срока';

  @override
  String get goalRemove => 'Убрать цель';

  @override
  String get exerciseNameMissing => 'Дайте название';

  @override
  String get aliasesLabel => 'Другие названия (необязательно)';

  @override
  String get aliasesHint => 'Другие названия через запятую';

  @override
  String alsoCalled(String names) {
    return 'Ещё: $names';
  }

  @override
  String get addToRoutine => 'Добавить в программу';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'В $n программах',
      one: 'В 1 программе',
      zero: 'Пока ни в одной программе',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Уже есть';

  @override
  String get restInRoutine => 'Отдых в этой программе';

  @override
  String get restInRoutineHint => 'Как у упражнения';

  @override
  String get restInRoutineReset => 'Только здесь · нажмите, чтобы сбросить';

  @override
  String get swapExercise => 'Заменить упражнение';

  @override
  String get swapShort => 'Заменить';

  @override
  String swapHint(String name) {
    return 'Вместо «$name», только сегодня. В конце можно оставить его в программе.';
  }

  @override
  String get swapKeepsDone => 'Сделанные подходы останутся; новое продолжит оставшиеся.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Та же мышца · $muscle';
  }

  @override
  String get swapDoneBefore => 'Уже делали';

  @override
  String get multiPlanSettingHint => 'Больше одной программы в один день недели.';

  @override
  String get levelHintsHint => 'Когда упражнение даётся легко, предложит более сложный вариант.';

  @override
  String get focusCardHint => 'Программа на сегодня — вверху главного экрана.';

  @override
  String get gamificationHint => 'Медали, ваш уровень и праздник в конце.';

  @override
  String get exerciseSettings => 'Настройки упражнения';

  @override
  String get placeActiveNow => 'Вы здесь';

  @override
  String get placeTapToUse => 'нажмите, чтобы тренироваться здесь';

  @override
  String get intervalDays => 'дней';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target дн.';
  }

  @override
  String get toolNameRpe => 'Вес по RPE';

  @override
  String get toolTitleRpe => 'Вес по RPE';

  @override
  String get toolDescRpe => 'Какой вес взять под нужное усилие';

  @override
  String get toolNameDots => 'Уровень силы';

  @override
  String get toolTitleDots => 'Уровень силы (DOTS)';

  @override
  String get toolDescDots => 'Ваша сила относительно веса';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'На $reps повт. при RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Подход, который вы только что сделали';

  @override
  String get rpeGoal => 'Что хотите сделать';

  @override
  String rpeOneRmLine(String value) {
    return 'Расчётный 1ПМ: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 — больше ни одного повтора; 8 — оставалось два.';

  @override
  String get dotsBestLifts => 'Ваши лучшие результаты';

  @override
  String get dotsSquat => 'ПРИСЕД';

  @override
  String get dotsBench => 'ЖИМ ЛЁЖА';

  @override
  String get dotsDeadlift => 'СТАНОВАЯ ТЯГА';

  @override
  String dotsTotalLine(String value) {
    return 'Сумма: $value';
  }

  @override
  String get dotsExplain =>
      'Сравнивает вашу силу с силой любого человека, независимо от веса. Используйте лучший разовый результат или расчётный 1ПМ.';

  @override
  String get dotsLevel0 => 'Новичок';

  @override
  String get dotsLevel1 => 'Средний';

  @override
  String get dotsLevel2 => 'Продвинутый';

  @override
  String get dotsLevel3 => 'Очень продвинутый';

  @override
  String get dotsLevel4 => 'Элита';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Очки Wilks';

  @override
  String get toolDescWilks => 'Классическая оценка в пауэрлифтинге';

  @override
  String get wilksExplain =>
      'Классическая формула пауэрлифтинга. В 2020 её заменила DOTS, но многие соревнования и рейтинги всё ещё её используют.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Индекс безжировой массы';

  @override
  String get toolDescFfmi => 'Сколько мышц для твоего роста';

  @override
  String get ffmiBodyFat => 'ЖИР';

  @override
  String ffmiLeanLine(String value) {
    return 'Безжировая масса: $value';
  }

  @override
  String get ffmiExplain =>
      'Как ИМТ, но без жира: учитывается только безжировая масса. С поправкой на рост, чтобы честно сравнивать высоких и невысоких.';

  @override
  String get ffmiLevel0 => 'Ниже среднего';

  @override
  String get ffmiLevel1 => 'Средний';

  @override
  String get ffmiLevel2 => 'Выше среднего';

  @override
  String get ffmiLevel3 => 'Отличный';

  @override
  String get ffmiLevel4 => 'Исключительный';

  @override
  String get rpeEffortLabel => 'Усилие (RPE)';

  @override
  String get restRowHint => 'Между подходами, если у упражнения нет своего.';

  @override
  String get effortRowHint => 'Отмечайте RPE или RIR в каждом подходе.';

  @override
  String get countdownHint => '3, 2, 1 перед первым подходом.';

  @override
  String get keepScreenOnHint => 'Экран не гаснет во время тренировки.';

  @override
  String get demoSizeRowHint => 'Рисунок упражнения во время тренировки.';

  @override
  String get demoLoopRowHint => 'Повторяется анимация или останавливается.';

  @override
  String get trainReminderRowHint => 'Напоминание в дни тренировок.';

  @override
  String get alarmSoundRowHint => 'Что звучит в конце отдыха.';

  @override
  String get alarmStyleRowHint => 'Звонит ли в беззвучном режиме.';

  @override
  String get recommendedRowHint => 'Упражнения, которые мы предлагаем на главной.';

  @override
  String get weightStepSetting => 'Шаг веса';

  @override
  String get weightStepHint => 'Сколько добавляют кнопки − и +.';

  @override
  String get prBestWorkout => 'Лучшая тренировка';

  @override
  String get mergeExercise => 'Объединить';

  @override
  String mergeExerciseInto(String name) {
    return 'Объединить $name с…';
  }

  @override
  String get mergeExerciseTitle => 'Объединить упражнения?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Вся история «$from» перейдёт в «$to». «$from» останется в библиотеке. Это нельзя отменить.';
  }

  @override
  String get mergedToast => 'История объединена';

  @override
  String get nutrition => 'Питание';

  @override
  String get nutritionHomeEmpty => 'Вода, белок и калории';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein г белка';
  }

  @override
  String get nutritionToday => 'Сегодня';

  @override
  String get nutritionYesterday => 'Вчера';

  @override
  String get nutritionGoals => 'Цели на день';

  @override
  String get kcalLabel => 'КАЛОРИИ';

  @override
  String get kcalOver => 'сверх';

  @override
  String get waterLabel => 'ВОДА';

  @override
  String get waterDone => 'Цель достигнута';

  @override
  String get waterCustom => 'Другое количество';

  @override
  String get glassSize => 'Размер стакана';

  @override
  String get supplementsLabel => 'ДОБАВКИ';

  @override
  String get supplementsEmpty => 'Нажми, чтобы добавить, или + для своей.';

  @override
  String get addSupplement => 'Новая добавка';

  @override
  String get supplementNameHint => 'Креатин, витамин D…';

  @override
  String removeSupplementTitle(String name) {
    return 'Удалить $name?';
  }

  @override
  String get removeSupplementBody => 'Дни, когда ты её отмечал, удалятся вместе с ней.';

  @override
  String get suppCreatine => 'Креатин';

  @override
  String get suppVitaminD => 'Витамин D';

  @override
  String get suppOmega3 => 'Омега-3';

  @override
  String get suppMagnesium => 'Магний';

  @override
  String get suppMultivitamin => 'Мультивитамины';

  @override
  String get suppCaffeine => 'Кофеин';

  @override
  String get myFoods => 'Мои продукты';

  @override
  String get newFood => 'Новый продукт';

  @override
  String get editFood => 'Изменить продукт';

  @override
  String get foodNameHint => 'Протеин, овсянка, хлеб…';

  @override
  String get servingLabel => 'ПОРЦИЯ';

  @override
  String get servingHint => '1 мерная ложка · 30 г';

  @override
  String get perServing => 'НА ПОРЦИЮ';

  @override
  String get servingsLabel => 'Порции';

  @override
  String get foodPhotoHint => 'На однотонном фоне превращается в стикер.';

  @override
  String get cutoutWorking => 'Вырезаем…';

  @override
  String get cutoutTry => 'Вырезать';

  @override
  String get cutoutKeep => 'Всё фото';

  @override
  String deleteFoodTitle(String name) {
    return 'Удалить $name?';
  }

  @override
  String get deleteFoodBody => 'Исчезнет из твоих продуктов. Уже записанное останется.';

  @override
  String get mealBreakfast => 'Завтрак';

  @override
  String get mealLunch => 'Обед';

  @override
  String get mealDinner => 'Ужин';

  @override
  String get mealSnacks => 'Перекусы';

  @override
  String get nothingLogged => 'Пока ничего не записано.';

  @override
  String addToMeal(String meal) {
    return 'Добавить: $meal';
  }

  @override
  String get quickAdd => 'Быстро добавить';

  @override
  String get quickAddHint => 'Только цифры, без сохранения продукта.';

  @override
  String get quickAddName => 'Что это было? (необязательно)';

  @override
  String get logFood => 'Добавить';

  @override
  String loggedToast(String meal) {
    return 'Добавлено: $meal';
  }

  @override
  String get entryRemoved => 'Удалено';

  @override
  String get goalsFromProfile => 'Рассчитать по профилю';

  @override
  String get goalsFromProfileHint => 'Калории из профиля, 1,8 г белка и 35 мл воды на кг веса.';

  @override
  String get kcalEaten => 'Съедено';

  @override
  String get kcalRemaining => 'Осталось';

  @override
  String waterTapHint(String amount) {
    return 'Нажми на стакан: + $amount';
  }

  @override
  String get shakeEmpty => 'Нажми, чтобы выбрать коктейль';

  @override
  String shakeTapHint(String name) {
    return 'Нажми: + $name';
  }

  @override
  String get shakePick => 'Твой коктейль';

  @override
  String get shakePickHint => 'Нажми на стакан — и он запишется сразу.';

  @override
  String get proteinLetter => 'Б';

  @override
  String get carbsLetter => 'У';

  @override
  String get fatLetter => 'Ж';

  @override
  String get addBurnedLabel => 'Учитывать сожжённые калории';

  @override
  String get addBurnedHint => 'Сожжённые калории считаются по длительности тренировок и твоему весу.';

  @override
  String get amountLabel => 'Количество';

  @override
  String amountIn(String unit) {
    return 'Количество ($unit)';
  }

  @override
  String get bodyweightLabel => 'Вес';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Скопировано $count продуктов',
      few: 'Скопировано $count продукта',
      one: 'Скопирован 1 продукт',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Уже записанное останется как есть.';

  @override
  String get fiberLabel => 'Клетчатка';

  @override
  String get sugarLabel => 'Сахар';

  @override
  String get sodiumLabel => 'Натрий';

  @override
  String get foodDatabase => 'База продуктов';

  @override
  String get kcalBurned => 'Сожжено';

  @override
  String get mealOptions => 'Параметры приёма пищи';

  @override
  String get moreNutrients => 'Клетчатка, сахар и натрий';

  @override
  String ofGoal(int goal, String unit) {
    return 'из $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'на 100 $unit';
  }

  @override
  String get perServingShort => 'на порцию';

  @override
  String get foodCategory => 'CATEGORY';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count штук',
      few: '$count штуки',
      one: '1 штука',
    );
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ломтиков',
      few: '$count ломтика',
      one: '1 ломтик',
    );
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count мерных ложек',
      few: '$count мерные ложки',
      one: '1 мерная ложка',
    );
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ст. л.', one: '1 ст. л.');
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ч. л.', one: '1 ч. л.');
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count чашек',
      few: '$count чашки',
      one: '1 чашка',
    );
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count стаканов',
      few: '$count стакана',
      one: '1 стакан',
    );
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Недавние';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count продуктов',
      few: '$count продукта',
      one: '1 продукт',
    );
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Переименовать';

  @override
  String get repeatFrom => 'Повторить из';

  @override
  String get repeatNone => 'В другие дни для этого приёма пищи ещё ничего нет.';

  @override
  String get restDayGoals => 'Другие цели в дни отдыха';

  @override
  String get trainingDays => 'Дни тренировок';

  @override
  String get restDays => 'Дни отдыха';

  @override
  String get trainingDay => 'День тренировки';

  @override
  String get saveAsMeal => 'Сохранить как приём пищи';

  @override
  String get savedMealNameHint => 'напр. Обычный завтрак';

  @override
  String get savedMealToast => 'Сохранено';

  @override
  String get savedMeals => 'Сохранённые приёмы пищи';

  @override
  String get searchFoodsHint => 'Поиск продуктов';

  @override
  String get searchFoodsEmpty => 'Ищи среди более чем 500 продуктов с фото или добавь свои.';

  @override
  String searchFoodsNone(String query) {
    return 'По запросу «$query» ничего. Создай его как свой продукт.';
  }

  @override
  String get servingWeight => 'ГРАММЫ';

  @override
  String get weekAverage => 'Эта неделя';

  @override
  String get weekAvgEnergy => 'В среднем в день';

  @override
  String get weekAvgProtein => 'Белок в день';

  @override
  String get weekEnergyOnTarget => 'Калории в цели';

  @override
  String get weekProteinOnTarget => 'Белок в цели';

  @override
  String weekProteinAvg(int grams) {
    return '$grams г белка в день';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met из $days дней в цели';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дней записано',
      few: '$count дня записано',
      one: '1 день записан',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Пока ничего не записано';

  @override
  String get weekOnTargetHint => 'В цели: калории в пределах 10 % от цели и не меньше 90 % белка.';

  @override
  String get weightGoalLabel => 'Целевой вес';

  @override
  String weightGoalTitle(String unit) {
    return 'Целевой вес ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Цель $weight';
  }

  @override
  String get weightGoalNone => 'Удерживай, чтобы задать цель';

  @override
  String get weightGoalReached => 'Цель достигнута';

  @override
  String weightToLose(String weight) {
    return 'Сбросить ещё $weight';
  }

  @override
  String weightToGain(String weight) {
    return 'Набрать ещё $weight';
  }

  @override
  String get aminoHis => 'гистидин';

  @override
  String get aminoIle => 'изолейцин';

  @override
  String get aminoLeu => 'лейцин';

  @override
  String get aminoLys => 'лизин';

  @override
  String get aminoSaa => 'метионин';

  @override
  String get aminoAaa => 'фенилаланин';

  @override
  String get aminoThr => 'треонин';

  @override
  String get aminoTrp => 'триптофан';

  @override
  String get aminoVal => 'валин';

  @override
  String get animalProtein => 'Животный белок';

  @override
  String get proteinQuality => 'Качество белка';

  @override
  String get qualityComplete => 'Полноценный';

  @override
  String get qualityAlmost => 'Почти полноценный';

  @override
  String get qualityIncomplete => 'Неполноценный';

  @override
  String get qualityNoData => 'Данных пока нет';

  @override
  String get qualityNoDataHint => 'Записывай продукты из базы, чтобы видеть свои аминокислоты.';

  @override
  String get qualityAllCovered => 'Все девять незаменимых аминокислот покрыты.';

  @override
  String qualityLimiting(String amino) {
    return 'Не хватает: $amino. Сочетай с продуктами, где её много.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Посчитано по $pct % белка: в своих продуктах нет данных об аминокислотах.';
  }

  @override
  String get fatTypes => 'Виды жиров';

  @override
  String get fatSaturated => 'Насыщенные';

  @override
  String get fatMono => 'Мононенас.';

  @override
  String get fatPoly => 'Полиненас.';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Насыщенные $grams г из макс. $limit г (10 % калорий)';
  }

  @override
  String get sugarSodium => 'Сахар и натрий';

  @override
  String get shakeCard => 'Протеиновый коктейль';

  @override
  String get mealOther => 'Приём пищи';

  @override
  String get mealAdd => 'Добавить приём пищи';

  @override
  String get mealAddHint => 'напр. Перед тренировкой';

  @override
  String get mealsOfDay => 'Приёмы пищи за день';

  @override
  String get mealsHint => 'Создавай сколько хочешь. При удалении его записи переходят в тот, что выше.';

  @override
  String get trackersTitle => 'Настроить';

  @override
  String get trackersHint => 'Оставь только то, что хочешь отслеживать.';

  @override
  String get trackersDaily => 'Итоги дня';

  @override
  String get trackersDetail => 'Подробно';

  @override
  String get trackersCards => 'Карточки';

  @override
  String get prepTitle => 'Заготовки';

  @override
  String get prepNewShort => 'Новая заготовка';

  @override
  String get prepNew => 'Новая заготовка';

  @override
  String get prepEdit => 'Изменить заготовку';

  @override
  String get prepHint => 'Запиши всю кастрюлю один раз и ешь понемногу.';

  @override
  String get prepEmpty =>
      'Приготовил на несколько дней? Запиши один раз, а потом просто укажи, сколько съел от остатка.';

  @override
  String get prepNameHint => 'напр. Курица с рисом';

  @override
  String get prepDefaultName => 'Заготовка';

  @override
  String get prepIngredients => 'Ингредиенты';

  @override
  String get prepAddIngredient => 'Добавить ингредиент';

  @override
  String get prepCookedWeight => 'ВЕС ГОТОВОГО';

  @override
  String prepCookedHint(String grams) {
    return 'Взвесь кастрюлю после готовки для точных цифр. Пусто = общий сырой вес ($grams г).';
  }

  @override
  String get prepNeedWeight => 'Укажи вес готового: у некоторых ингредиентов нет граммов.';

  @override
  String prepLeftOf(String left, String total) {
    return 'Осталось $left из $total';
  }

  @override
  String get prepOfWhatsLeft => '% от остатка';

  @override
  String get prepAll => 'Всё';

  @override
  String prepLogAmount(String grams) {
    return 'Записать $grams';
  }

  @override
  String get prepWeighLeft => 'Взвесить остаток';

  @override
  String get prepFinished => 'Эта заготовка закончилась.';

  @override
  String get approxValues => 'Приблизительно';

  @override
  String get editValues => 'Изменить значения';

  @override
  String get editValuesHint =>
      'Меняет только эту запись. Чтобы исправить продукт на будущее, измени его в «Мои продукты».';

  @override
  String get editLibraryHint => 'Сохранится как твой продукт, с тем же фото';

  @override
  String per100Line(String energy, String unit) {
    return '$energy на 100 $unit';
  }

  @override
  String get rawLabel => 'Сырой';

  @override
  String get cookedLabel => 'Готовый';

  @override
  String get rawHint => 'Вес до готовки';

  @override
  String cookedHint(String factor) {
    return 'Вес после готовки (×$factor от сырого)';
  }

  @override
  String get servingsUnit => 'порций';

  @override
  String logAmount(String energy) {
    return 'Записать · $energy';
  }

  @override
  String get catFruit => 'Фрукты';

  @override
  String get catVeg => 'Овощи';

  @override
  String get catMeat => 'Мясо';

  @override
  String get catFish => 'Рыба';

  @override
  String get catEgg => 'Яйца';

  @override
  String get catDairy => 'Молочное';

  @override
  String get catGrain => 'Крупы';

  @override
  String get catBakery => 'Хлеб';

  @override
  String get catLegume => 'Бобовые';

  @override
  String get catNut => 'Орехи';

  @override
  String get catOil => 'Масла';

  @override
  String get catPantry => 'Кладовая';

  @override
  String get catDrink => 'Напитки';

  @override
  String get catSauce => 'Соусы';

  @override
  String get catSpice => 'Специи';

  @override
  String get searchFoodsPrompt => 'Что ты съел?';

  @override
  String get shelfEmpty =>
      'Найди продукт или сфотографируй свой: здесь появятся те, что ты записываешь чаще всего.';

  @override
  String get repeatEntry => 'Повторить';

  @override
  String get notifSuppChannel => 'Добавки';

  @override
  String get notifSuppChannelWhy => 'Ежедневное напоминание о добавках';

  @override
  String get energySplit => 'Откуда калории';

  @override
  String get typicalServing => 'Обычная порция';

  @override
  String cookedYieldLine(String factor) {
    return 'Весит в $factor раза больше сырого';
  }

  @override
  String get readyDishes => 'Dishes';

  @override
  String weightLastLine(String weight) {
    return 'Last weigh-in $weight';
  }

  @override
  String get proteinAnimalShort => 'Animal';

  @override
  String get proteinPlantShort => 'Plant';

  @override
  String kcalFromMacros(String value) {
    return 'These macros add up to about $value';
  }

  @override
  String get useValue => 'Use';

  @override
  String get suppRowHint => 'Tap to mark · hold for details';

  @override
  String get suppPhoto => 'Photo';

  @override
  String get suppDose => 'Dose';

  @override
  String get suppDoseHint => '5 g, 2 capsules…';

  @override
  String get suppRemind => 'Remind me';

  @override
  String mealPlanDefault(int n) {
    return 'Plan $n';
  }

  @override
  String get mealPlansTitle => 'Meal plans';

  @override
  String get mealPlanNew => 'New plan';

  @override
  String fromPlan(String name) {
    return 'From $name';
  }

  @override
  String get logPlan => 'Log';

  @override
  String get planFromDay => 'Copy this day';

  @override
  String get planNewHint => 'Plan your days like your routines, then log a whole meal with one tap.';

  @override
  String get planLogDay => 'Log the empty meals';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n foods logged',
      one: '1 food logged',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'No plan';

  @override
  String get planWeekHint => 'Tap a day to give it a plan.';

  @override
  String get planDuplicate => 'Duplicate';

  @override
  String planDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get planDeleteBody => 'Ваши программы останутся. Удаляется только эта сохранённая неделя.';

  @override
  String get sectionBeta => 'Бета';

  @override
  String get nutritionBeta => 'Питание';

  @override
  String get nutritionBetaHint =>
      'Еда, вода, белок и добавки. Ещё в разработке: данные сохранятся, даже если отключить.';

  @override
  String get nutritionAboutTitle => 'О питании';

  @override
  String get nutritionAboutSub => 'Что это и чем оно никогда не станет.';

  @override
  String get nutritionAboutWhatTitle => 'Часть твоих тренировок';

  @override
  String get nutritionAboutWhat =>
      'Простой способ записывать еду, воду, белок и добавки рядом с тренировками. GymMane — прежде всего приложение для зала: питание здесь, чтобы всё было в одном месте, а не чтобы заменить приложение для диеты.';

  @override
  String get nutritionAboutScanTitle => 'Без сканера, никогда';

  @override
  String get nutritionAboutScan =>
      'Отсканировать штрихкод и получить всё заполненным было бы удобно. Но для этого нужны интернет и огромная онлайн-база продуктов, а то, что ты ешь, оказывается на чужих серверах. Эти данные показывают, когда ты ешь, что ты ешь и как следишь за своим телом, и их могут использовать для рекламы или передать крупным компаниям. Поэтому сканера нет и не будет.';

  @override
  String get nutritionAboutLocalTitle => 'Всё на твоём телефоне';

  @override
  String get nutritionAboutLocal =>
      'В приложении уже есть более 500 продуктов с фото. Можно добавлять свои, менять им фото и редактировать значения. Всё остаётся на твоём телефоне, как и всё остальное в GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Пока в бете';

  @override
  String get nutritionAboutBeta =>
      'Если чего-то не хватает, предложи это на GitHub. Только не сканер и не большую базу продуктов: помимо приватности, приложение стало бы намного тяжелее. Питание не нужно? Отключи его в настройках, данные сохранятся.';

  @override
  String get nutritionAboutSuggest => 'Предложить идею';

  @override
  String get nutritionAboutOk => 'Понятно';

  @override
  String get planShare => 'Share';

  @override
  String get planImport => 'Import a plan';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n plans imported',
      one: '1 plan imported',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'That file has no meal plans.';

  @override
  String get planMoveUp => 'Move up';

  @override
  String get planMoveDown => 'Move down';

  @override
  String get cutoutEdit => 'Touch up cutout';

  @override
  String get cutoutEditHint =>
      'Drag to erase or restore. Tap an area to remove or bring it back whole. Pinch to zoom.';

  @override
  String get cutoutErase => 'Erase';

  @override
  String get cutoutRestore => 'Restore';

  @override
  String get cutoutReset => 'Back to automatic';

  @override
  String get cutoutByHand => 'Cut out by hand';

  @override
  String notifSuppTitleFor(String names) {
    return 'Time to take: $names';
  }

  @override
  String get notifSuppTap => 'Tick it off in GymMane once you\'ve taken it.';

  @override
  String get suppNoneToday => 'Nothing to take today.';

  @override
  String get suppOtherDays => 'Other days';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Every $n days', one: 'Every day');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Every day';

  @override
  String suppFromDate(String date) {
    return 'from $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'until $date';
  }

  @override
  String get suppSomeDays => 'Some days';

  @override
  String get suppEveryShort => 'Every X days';

  @override
  String get suppWhen => 'When';

  @override
  String get suppEveryLead => 'Every';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'days', one: 'day');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Starts';

  @override
  String get suppEnds => 'Ends';

  @override
  String get suppTomorrow => 'Tomorrow';

  @override
  String get suppPickDate => 'Pick a date';

  @override
  String get suppNever => 'Never';

  @override
  String get suppOneWeek => 'In 1 week';

  @override
  String get suppOneMonth => 'In 1 month';

  @override
  String get planPickHint => 'Pick the plan for this day, or make a new one.';

  @override
  String planSetForDay(String day) {
    return 'Plan set for $day';
  }

  @override
  String get planSaved => 'Plan saved';

  @override
  String get planDiscardTitle => 'Discard changes?';

  @override
  String get planDiscardBody => 'What you changed won\'t be saved.';

  @override
  String get planDiscard => 'Discard';

  @override
  String get planEdit => 'Edit plan';

  @override
  String get planNameHint => 'Лето, поездка…';

  @override
  String get planDaysQuestion => 'Which days?';

  @override
  String get planDaysHint => 'On those days it shows up in Nutrition so you can log it in one tap.';

  @override
  String get planDaysNone => 'Pick at least one day, or it won\'t show up anywhere.';

  @override
  String get planNothingToLog => 'Those meals are already logged';

  @override
  String get planSave => 'Save plan';

  @override
  String get planToday => 'Today\'s plan';

  @override
  String get planLogRest => 'Log the rest';

  @override
  String get dishNew => 'Create my dish';

  @override
  String get dishNewHint => 'Pick ingredients and amounts, save it and log it in one tap.';

  @override
  String get dishEdit => 'Edit dish';

  @override
  String get dishNameHint => 'E.g. Mum\'s lentils';

  @override
  String get dishIngredients => 'Ingredients';

  @override
  String get dishEmptyHint => 'Add what goes in it with the amount you usually eat.';

  @override
  String get dishSave => 'Save dish';

  @override
  String get dishNeedsName => 'Give it a name';

  @override
  String get dishNeedsItems => 'Add at least one ingredient';

  @override
  String get suppHistory => 'Last 14 days';

  @override
  String suppTakenOf(int n, int total) {
    return '$n of $total taken';
  }

  @override
  String get suppNoReminder => 'No reminder';

  @override
  String get suppMarkTaken => 'Mark as taken';

  @override
  String get suppUnmark => 'Unmark';

  @override
  String get suppEdit => 'Edit';

  @override
  String get mealMoveTo => 'Move to';

  @override
  String get mealClear => 'Clear meal';

  @override
  String get mealCleared => 'Meal cleared';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count foods moved',
      one: '1 food moved',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Repeat the whole day';

  @override
  String createFoodNamed(String name) {
    return 'Create “$name”';
  }

  @override
  String get entryDay => 'Day';

  @override
  String get movedToDay => 'Moved';

  @override
  String get favFoodsHint => 'Tap ☆ on a food';

  @override
  String get favFoodsEmpty => 'Tap the star on any food to keep it here, one tap away.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count meals', one: '1 meal');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'Save a meal from its ••• menu, or build your own dish.';

  @override
  String get sugarLimitLabel => 'Sugar limit';

  @override
  String get sodiumLimitLabel => 'Sodium limit';

  @override
  String get waterOptions => 'Water options';

  @override
  String get waterNone => 'No water logged yet.';

  @override
  String get waterDailyGoal => 'Daily water';

  @override
  String get trackersScreen => 'Screen';

  @override
  String get vesselMotion => 'Moving water and shake';

  @override
  String get vesselMotionHint =>
      'Turn it off if the screen feels slow: the glasses still fill up, they just stop moving.';

  @override
  String get planFixedWeek => 'Фикс. неделя';

  @override
  String get planRotation => 'Ротация';

  @override
  String get rotationTitle => 'РОТАЦИЯ';

  @override
  String get rotationHint => 'Следующая — та, что идёт после последней тренировки, в любой день.';

  @override
  String get rotationEmpty => 'Добавь программы в том порядке, в каком будешь их делать: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done из $total сделано в этом круге';
  }

  @override
  String get rotationNext => 'Следующая';

  @override
  String get rotationAdd => 'Добавить программы';

  @override
  String get rotationPickHint => 'Добавляются в том порядке, в каком нажимаешь.';

  @override
  String get rotationSkip => 'Перейти к следующей';

  @override
  String get rotationRestart => 'Начать новый круг';

  @override
  String get rotationMakeNext => 'Сделать следующей';

  @override
  String get rotationRemove => 'Убрать из ротации';

  @override
  String rotationPlace(int n, int total) {
    return '$n из $total в ротации';
  }

  @override
  String get moveToDay => 'Перенести на другой день';

  @override
  String get moveToDayHint => 'Только в этот раз; план на неделю не меняется.';

  @override
  String get movedToast => 'Тренировка перенесена';

  @override
  String get backToPlan => 'Вернуть недельный план';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get untrainedTab => 'Без нагрузки';

  @override
  String get untrainedRecent => 'Недавно';

  @override
  String get untrainedLong => 'Давно';

  @override
  String untrainedWaiting(String list) {
    return 'Дольше всех ждут: $list';
  }

  @override
  String get untrainedAllRecent => 'Все мышцы поработали на этой неделе. Отлично.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дня назад',
      many: '$n дней назад',
      few: '$n дня назад',
      one: '$n день назад',
      zero: 'Сегодня',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Ещё не тренировалась';

  @override
  String get layoutSetting => 'Вид тренировки';

  @override
  String get layoutCards => 'Карточки';

  @override
  String get layoutList => 'Список';

  @override
  String get layoutHint =>
      'Карточки показывают по одному упражнению. Список — всю тренировку на одном экране, подход за подходом.';

  @override
  String get layoutRowHint => 'По одному упражнению или всё списком';

  @override
  String get previousCol => 'ПРОШЛЫЙ';

  @override
  String get usePrevious => 'Взять прошлые значения';

  @override
  String get skipShort => 'Пропустить';

  @override
  String get moveUp => 'Выше';

  @override
  String get moveDown => 'Ниже';

  @override
  String get widgetNutritionOff => 'Turn on Nutrition in Settings › Beta to use this widget.';

  @override
  String get widgetPickShake => 'Pick your shake';

  @override
  String get heatRangeSetting => 'Календарь активности';

  @override
  String get heatRangeWeeks => '12 недель';

  @override
  String get heatRangeYear => '12 месяцев';

  @override
  String get heatRangeHint =>
      '12 месяцев показывают весь год. Листай вбок, чтобы вернуться назад, до первой тренировки.';

  @override
  String get pdfPlan => 'План в PDF';

  @override
  String get pdfPlanHint =>
      'Аккуратный лист с неделей и всеми программами — можно распечатать или отправить.';

  @override
  String get pdfExport => 'Экспорт в PDF';

  @override
  String get pdfFooter => 'Бесплатно, с открытым кодом и офлайн';

  @override
  String get shakeTag => 'It’s a shake';

  @override
  String get shakeTagHint => 'It shows up in Your shake';

  @override
  String get shakeNone => 'Mark your shakes and only those show up here.';

  @override
  String get shakeMarkLabel => 'MARK AS A SHAKE';

  @override
  String get shakeNew => 'New shake';

  @override
  String get shakeUntag => 'Not a shake';

  @override
  String get pdfKicker => 'ПЛАН ТРЕНИРОВОК';

  @override
  String get pdfStatDays => 'ДНЕЙ / НЕД.';

  @override
  String get pdfStatMinutes => 'МИН / ТРЕНИРОВКА';

  @override
  String pdfMinutes(int n) {
    return '≈ $n мин';
  }

  @override
  String get workoutNotesTitle => 'Заметки к упражнению';

  @override
  String get workoutNoteEvery => 'Каждый раз';

  @override
  String get workoutNoteNext => 'В следующий раз';

  @override
  String get workoutNoteEveryHint => 'Показывается каждый раз. Удобно для настроек сиденья или блока.';

  @override
  String get workoutNoteNextHint => 'Покажется только в следующий раз, потом исчезнет.';

  @override
  String workoutNoteFromLast(String date) {
    return 'С прошлого раза · $date';
  }

  @override
  String get workoutNoteHint => 'Сиденье на 2, блок на 19…';

  @override
  String get notePinWorkout => 'Показывать на тренировке';

  @override
  String get assistedSetting => 'Гравитрон';

  @override
  String get assistedSettingHint => 'Вес помогает, поэтому меньше — лучше: рекорды и подсказки идут вниз.';

  @override
  String get assistedRecordHint => 'Меньше всего помощи';

  @override
  String get trainAgainLabel => 'Ещё не тренировался? Напомнить снова';

  @override
  String get trainAgainOff => 'Нет';

  @override
  String trainAgainAfter(int n) {
    return '+$n ч';
  }

  @override
  String get trainAgainHint => 'Один раз и только если в этот день ты ещё не записал тренировку.';

  @override
  String get notifTrainAgainBody => 'Ещё есть время потренироваться сегодня.';

  @override
  String nextDeload(int n) {
    return 'легче: $n тренировки подряд без всех повторов';
  }

  @override
  String get historyTitle => 'История';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ТРЕНИРОВКИ',
      many: '$n ТРЕНИРОВОК',
      few: '$n ТРЕНИРОВКИ',
      one: '$n ТРЕНИРОВКА',
    );
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'В этом месяце тренировок нет';

  @override
  String get historyEmptyHint => 'Листай вбок или нажимай стрелки, чтобы увидеть другие месяцы.';

  @override
  String historyMore(int n) {
    return 'ещё $n';
  }

  @override
  String get stopwatch => 'Секундомер';

  @override
  String get proteinSource => 'Protein source';

  @override
  String get proteinMixedShort => 'Mixed';

  @override
  String get kcalActive => 'активные';

  @override
  String get kcalEstimated => 'оценка';

  @override
  String get kcalYours => 'ваше значение';

  @override
  String kcalTotalRest(String value) {
    return '$value всего, с учётом расхода в покое';
  }

  @override
  String get inclineLabel => 'Наклон';

  @override
  String get kcalUseOwn => 'Указать своё';

  @override
  String get kcalBackToEstimate => 'Вернуть оценку';

  @override
  String get kcalNeedsData => 'Добавьте дистанцию и время, чтобы оценить калории';

  @override
  String get kcalHowEstimated => 'Оценка по дистанции, времени, наклону и вашему весу (формула ACSM).';

  @override
  String get kcalOwnTitle => 'Активные калории';

  @override
  String get planMine => 'Мой план';

  @override
  String get planNew => 'Новый план';

  @override
  String get planSaveWeek => 'Сохранить эту неделю';

  @override
  String get planSaveWeekHint => 'Сохраните текущую неделю как план, к которому можно вернуться';

  @override
  String get planEmptyWeek => 'Начать пустую неделю';

  @override
  String get planEmptyWeekHint => 'Текущая неделя останется сохранённой как план';

  @override
  String get planName => 'Название плана';

  @override
  String get planRename => 'Переименовать';

  @override
  String get planDelete => 'Удалить план';

  @override
  String get plansHint => 'Изменения недели сохраняются в выбранном плане';

  @override
  String get progression => 'Прогрессия';

  @override
  String get progManual => 'Вручную';

  @override
  String get progManualHint => 'Без подсказок: вы сами выбираете каждый вес.';

  @override
  String get progLinear => 'Линейная';

  @override
  String get progLinearHint => 'Выполнили все повторения — вес растёт.';

  @override
  String get progDouble => 'Двойная прогрессия';

  @override
  String get progDoubleHint => 'Больше повторений до верхней границы, затем больший вес.';

  @override
  String get progVolume => 'Повторы, подходы и вес';

  @override
  String get progVolumeHint => 'Повторы до верха, затем ещё подход, затем больший вес.';

  @override
  String get progAmrap => 'Последний подход до отказа';

  @override
  String get progAmrapHint => 'Последний подход: сколько сможете. Удвоите цель — вес вырастет вдвое.';

  @override
  String get progStep => 'Шаг веса';

  @override
  String get progRange => 'Диапазон повторений';

  @override
  String get progSets => 'Подходы';

  @override
  String get progDeload => 'Легче после';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n неудач', one: '1 неудачи');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Снизить на';

  @override
  String get progApply => 'Заполнять следующую тренировку';

  @override
  String get progApplyHint => 'Выключено: только подсказка.';

  @override
  String get nextMoreReps => 'тот же вес, на повтор больше';

  @override
  String get nextAddSet => 'на подход больше';

  @override
  String get nextAmrap => 'последний подход: сколько сможете';

  @override
  String fillDay(String amount) {
    return 'Fill your day · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'You\'ll have $kcal left';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'You\'ll have $kcal and $grams g protein left';
  }

  @override
  String leftAfterOver(String kcal) {
    return '$kcal over your goal';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit a day';
  }

  @override
  String get byZone => 'По зонам';

  @override
  String get importAlreadyHave => 'Эти программы у вас уже есть. Можно добавить их ещё раз как копию.';

  @override
  String get importAsCopy => 'Добавить копию';

  @override
  String get importOwned => 'Уже есть';

  @override
  String get setDuplicated => 'Подход скопирован';

  @override
  String get setTypeCluster => 'Кластер';

  @override
  String get setTypeClusterInfo =>
      'Подход, разбитый на короткие блоки с паузой 15–30 секунд. Записывайте общее число повторений.';

  @override
  String timesBodyweight(String value) {
    return '$value× вашего веса';
  }

  @override
  String get archiveRoutine => 'Архивировать программу';

  @override
  String get routineArchived => 'Программа в архиве';

  @override
  String get archivedRoutines => 'Архив';

  @override
  String get autoBackup => 'Автокопия';

  @override
  String get autoBackupHint =>
      'Сохраняет ZIP со всеми данными в выбранную папку. Синхронизируйте её с Nextcloud, Syncthing или другим приложением, чтобы копия была не только на телефоне.';

  @override
  String get autoBackupFolder => 'Выбрать папку';

  @override
  String get autoBackupNoFolder => 'Папка не выбрана';

  @override
  String get autoBackupOff => 'Выключено';

  @override
  String get autoBackupWorkout => 'После каждой тренировки';

  @override
  String get autoBackupDaily => 'Раз в день';

  @override
  String get autoBackupWeekly => 'Раз в неделю';

  @override
  String get autoBackupOnLeave => 'При выходе из приложения';

  @override
  String get autoBackupKeep => 'Хранить копий';

  @override
  String get autoBackupNow => 'Сделать копию сейчас';

  @override
  String autoBackupLast(String when) {
    return 'Последняя копия $when';
  }

  @override
  String get autoBackupNever => 'Копий пока нет';

  @override
  String get autoBackupLost => 'Не удалось сохранить последнюю копию. Выберите папку заново.';

  @override
  String get autoBackupSaved => 'Копия сохранена';

  @override
  String get prepPortions => 'Порции';

  @override
  String get rotationAddRest => 'Добавить день отдыха';

  @override
  String get rotationRestHint => 'Сам сменится на следующий день';

  @override
  String get rotationRestToday => 'Сегодня';

  @override
  String get rotationSkipRest => 'Пропустить этот отдых';

  @override
  String rotationRestUpNext(String name) {
    return 'Дальше: $name';
  }

  @override
  String get trainAnyway => 'Всё равно тренироваться';

  @override
  String get healthTitle => 'Здоровье';

  @override
  String get healthSetting => 'Данные о здоровье';

  @override
  String get healthSettingHint => 'Сердце, сон и показатели из Health Connect — в Прогрессе.';

  @override
  String get healthPickTitle => 'Данные о здоровье';

  @override
  String get healthPickHint =>
      'Выберите, что брать из Health Connect. Android спросит один раз для каждого. Данные только читаются и не покидают телефон.';

  @override
  String get healthGroupHeart => 'Сердце';

  @override
  String get healthGroupVitals => 'Показатели';

  @override
  String get healthGroupActivity => 'Активность';

  @override
  String get healthRestingHr => 'Пульс в покое';

  @override
  String get healthHeartRate => 'Средний пульс';

  @override
  String get healthHrv => 'Вариабельность пульса';

  @override
  String get healthSpo2 => 'Кислород в крови';

  @override
  String get healthRespiration => 'Частота дыхания';

  @override
  String get healthBloodPressure => 'Давление';

  @override
  String get healthTemperature => 'Температура тела';

  @override
  String get healthSleep => 'Сон';

  @override
  String get healthDistance => 'Дистанция';

  @override
  String get healthFloors => 'Пройдено этажей';

  @override
  String get healthElevation => 'Набор высоты';

  @override
  String get healthActiveKcal => 'Активные калории';

  @override
  String get healthNoData => 'Пока нет данных';

  @override
  String get healthAllow => 'Нажмите, чтобы разрешить';

  @override
  String get healthLast7 => 'Последние 7 дней';

  @override
  String get healthAvg30 => 'Среднее за 30 дней';

  @override
  String get healthLow => 'Минимум';

  @override
  String get healthHigh => 'Максимум';

  @override
  String get healthFrom => 'Из Health Connect · последние 30 дней';

  @override
  String get healthBpm => 'уд/мин';

  @override
  String get healthBreaths => 'вд/мин';

  @override
  String get weekTab => 'Неделя';

  @override
  String get muscleSetsList => 'Подходы по мышцам';

  @override
  String get fatTrans => 'Транс';

  @override
  String get fatTypesHint => 'Необязательно. Оставь пустым то, чего нет на этикетке.';

  @override
  String get sessionPhotos => 'Фото тренировки';

  @override
  String get sessionPhotosAdd => 'Добавить фото';

  @override
  String get sessionPhotosHint => 'Они сохраняются и в «Твои фото».';

  @override
  String get ladderTitle => 'Прогрессия';

  @override
  String get ladderHint =>
      'Расставьте шаги от лёгкого к трудному. Когда сделаете 3 подхода по 8 две тренировки подряд (5 в медленных), GymMane предложит следующий.';

  @override
  String get ladderBuiltIn =>
      'Основана на прогрессии приложения. Добавьте, уберите или переставьте шаги — и она станет прогрессией этой тренировки.';

  @override
  String get ladderNone => 'Пока нет. Нажмите, чтобы создать.';

  @override
  String ladderStep(int n, int total) {
    return 'Шаг $n из $total';
  }

  @override
  String get ladderAdd => 'Добавить шаг';

  @override
  String get ladderInRoutine => 'В тренировке';

  @override
  String get ladderClear => 'Взять из приложения';

  @override
  String get ladderPick => 'Выберите шаг';

  @override
  String get periodWeek => 'на этой неделе';

  @override
  String get periodMonth => 'в этом месяце';

  @override
  String get periodYear => 'в этом году';

  @override
  String get periodAll => 'за всё время';

  @override
  String get settingsSearch => 'Поиск по настройкам';

  @override
  String get settingsNoResults => 'Нет настройки с таким названием';

  @override
  String get settingsGroupApp => 'Ваше приложение';

  @override
  String get settingsGroupHome => 'Главная и дополнительно';

  @override
  String get settingsGroupData => 'Данные и помощь';

  @override
  String get healthAllowAll => 'Включить всё';

  @override
  String get healthSeeAll => 'Смотреть все';

  @override
  String get healthPinTitle => 'На карточке';

  @override
  String get healthPinHint => 'Выберите до 3 для карточки «Прогресс».';

  @override
  String get blurSetting => 'Эффекты размытия';

  @override
  String get blurSettingHint => 'Стекло и мягкие края. Отключите, если телефон тормозит.';

  @override
  String get lowEndTitle => 'На телефоне мало памяти';

  @override
  String get lowEndBody => 'Без размытия всё работает плавнее. Вернуть можно в Настройки → Общие.';

  @override
  String get lowEndOff => 'Отключить размытие';

  @override
  String get lowEndKeep => 'Оставить';

  @override
  String get momentsThisMonth => 'В этом месяце';

  @override
  String get momentsDays => 'Дни с фото';

  @override
  String get awardsPick => 'Выбрать для профиля';

  @override
  String get awardsPickHint => 'Нажмите на те, что хотите видеть в профиле';
}
