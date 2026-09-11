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
  String get noMusclesYet => 'Мышцы ещё не выбраны — нажми на тело, чтобы начать.';

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
  String get setDone => 'SET DONE';

  @override
  String get nextExercise => 'NEXT EXERCISE';

  @override
  String get skipExercise => 'Skip this exercise?';

  @override
  String skipExerciseBody(String name) {
    return 'You haven\'t marked any set as done, so nothing gets logged for \"$name\".';
  }

  @override
  String get dropExerciseAction => 'Drop exercise';

  @override
  String get restOff => 'Off';

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
  String get saveAndExit => 'СОХРАНИТЬ И ВЫЙТИ';

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
  String get totalVolume30d => 'ОБЩИЙ ОБЪЁМ · 30 ДНЕЙ';

  @override
  String get volumeCumulative => 'Нарастающий итог каждого поднятого килограмма';

  @override
  String get volumeChartEmpty => 'Запиши тренировку — и кривая начнётся здесь';

  @override
  String get weekRhythm => 'РИТМ НЕДЕЛИ';

  @override
  String get weekRhythmHint => 'В какие дни ты реально приходишь.';

  @override
  String weekRhythmBest(String day) {
    return '$day — твой день';
  }

  @override
  String get weekRhythmEmpty => 'Запиши тренировку — и неделя обретёт форму.';

  @override
  String get allTime => 'ЗА ВСЁ ВРЕМЯ';

  @override
  String get allTimeSessions => 'ТРЕНИРОВОК';

  @override
  String get allTimeTime => 'ВРЕМЯ';

  @override
  String get allTimeVolume => 'ПОДНЯТО';

  @override
  String get allTimeSets => 'ПОДХОДОВ';

  @override
  String allTimeAvg(String time) {
    return 'В среднем $time на тренировку';
  }

  @override
  String hoursShort(int n) {
    return '$n ч';
  }

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
  String get notLoggedYet => 'Ещё не записано';

  @override
  String get logShort => '+ ЗАПИСАТЬ';

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
  String get splitEmpty => 'Тренируйся, чтобы увидеть, как объём делится по мышечным группам.';

  @override
  String get personalRecords => 'ЛИЧНЫЕ РЕКОРДЫ';

  @override
  String get prEmpty => 'Рекорды появятся здесь по мере записи подходов.';

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
  String get noBodyweightYet => 'Пока ничего не записано.';

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
  String showAllNotes(int n) {
    return 'Показать все заметки ($n)';
  }

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
  String get placesShort => 'Места';

  @override
  String get placesHint =>
      'Укажи, что есть в каждом месте, и библиотека покажет только то, что там реально можно сделать.';

  @override
  String get placeAll => 'Везде';

  @override
  String get placeNew => 'Новое место';

  @override
  String get placeNameLabel => 'НАЗВАНИЕ';

  @override
  String get placeNamePlaceholder => 'Дом, зал, парк…';

  @override
  String get placeGearLabel => 'ЧТО ТАМ ЕСТЬ';

  @override
  String placeGearCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n вида инвентаря',
      many: '$n видов инвентаря',
      few: '$n вида инвентаря',
      one: '$n вид инвентаря',
      zero: 'Ничего не отмечено',
    );
    return '$_temp0';
  }

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
  String get shareSession => 'Последнюю тренировку';

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
  String get shareSetsLabel => 'ПОДХОДОВ';

  @override
  String get shareNothing => 'Сначала запиши тренировку — показывать пока нечего';

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
  String get setTypeHint => 'Разминочные не идут в объём и рекорды.';

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
  String get dragToReorder => 'Удерживай и перетаскивай, чтобы изменить порядок — в нём ты и тренируешься.';

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
  String get addToWorkout => 'ДОБАВИТЬ УПРАЖНЕНИЕ';

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
  String get preferences => 'ПРЕДПОЧТЕНИЯ';

  @override
  String get theme => 'Тема';

  @override
  String get darkTheme => 'Тёмная';

  @override
  String get lightTheme => 'Светлая';

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
  String get homeWidgets => 'ГЛАВНЫЙ ЭКРАН';

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
  String get data => 'ДАННЫЕ';

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
  String get backupCopied => 'Резервная копия скопирована в буфер обмена';

  @override
  String get backupImported => 'Резервная копия загружена';

  @override
  String get backupFailed => 'Не удалось прочитать эту копию';

  @override
  String get nothingToExport => 'Выгружать пока нечего — сначала запиши тренировку';

  @override
  String get athlete => 'Атлет';

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
  String rampSet(String pct, int reps) {
    return '$pct · $reps повт.';
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
  String get calculatorsInside => '6 калькуляторов';

  @override
  String get calculatorsInsideWhy =>
      '1ПМ, блины, ИМТ, калории, жир и разминка — все по опубликованным формулам.';

  @override
  String get mathInside => 'Честная математика';

  @override
  String get mathInsideWhy =>
      'Объём, рекорды и серии считаются по твоим подходам. Здесь ничего не нарисовано для красоты.';

  @override
  String get yourNumbers => 'ТВОИ ЦИФРЫ';

  @override
  String get sessionsCaps => 'ТРЕНИРОВОК';

  @override
  String get liftedCaps => 'ПОДНЯТО';

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
  String get restDefaultLabel => 'Таймер отдыха';

  @override
  String restDefault(int s) {
    return 'По умолчанию $s с — измени в настройках';
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
  String get useDefaultArt => 'Вернуть стандартную картинку';

  @override
  String daysShort(int n) {
    return '$n д';
  }

  @override
  String get focusCard => 'Today’s focus';

  @override
  String get autoAdvance => 'Move on automatically';

  @override
  String get autoAdvanceHint => 'When the last set of an exercise is ticked, the workout moves on.';

  @override
  String get autoProgress => 'Add weight next time';

  @override
  String autoProgressHint(String w) {
    return 'Hit every rep and the next session starts $w heavier.';
  }

  @override
  String get placePlates => 'Plates and bar';

  @override
  String get platesAll => 'Everything available';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sizes', one: '$n size');
    return '$_temp0';
  }

  @override
  String get platePairs => 'PAIRS';

  @override
  String plateAchievable(String w) {
    return 'Closest you can load: $w';
  }

  @override
  String get autoWarmup => 'Start with warm-up sets';

  @override
  String get autoWarmupHint => 'Adds the ramp-up sets when the workout opens.';

  @override
  String get trainReminder => 'Training reminder';

  @override
  String get trainReminderHint => 'A nudge at this time, only on the days your routine is planned.';

  @override
  String get notifTrainChannel => 'Training reminder';

  @override
  String get notifTrainChannelWhy => 'A nudge to train on the days you planned.';

  @override
  String get notifTrainTitle => 'Time to train';

  @override
  String get notifTrainBody => 'Your routine is waiting.';

  @override
  String get exportCatalog => 'Export exercise list';

  @override
  String get importRoutine => 'Import a routine (JSON)';

  @override
  String get planIntro => 'Build me a training routine using only the exercises in this list.';

  @override
  String get planFormat => 'Answer with JSON only, in this shape:';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n exercises added to the routine',
      one: '$n exercise added to the routine',
    );
    return '$_temp0';
  }

  @override
  String get planNothing => 'No exercise in that file matched your library';

  @override
  String get planFailed => 'That file is not a routine we can read';

  @override
  String get routineGroup => 'Group';

  @override
  String get newGroup => 'New group';

  @override
  String get noGroup => 'No group';

  @override
  String get groupNameHint => 'Push / Pull / Legs, 5×5…';

  @override
  String get filters => 'Filters';

  @override
  String get setsPlannedHint => 'Pick how many sets you want of each one. The workout opens with them ready.';

  @override
  String get nextTime => 'NEXT';

  @override
  String get nextHold => 'same weight until you hit every rep';

  @override
  String get bgPhoto => 'Your photo';

  @override
  String get bgPhotoPick => 'Choose a photo';

  @override
  String get bgPhotoChange => 'Change photo';

  @override
  String get bgPhotoRemove => 'Remove photo';

  @override
  String get bgDim => 'HOW DARK';

  @override
  String get dimSoft => 'Soft';

  @override
  String get dimMedium => 'Medium';

  @override
  String get dimStrong => 'Strong';

  @override
  String get bgPhotoHint => 'It sits behind everything, dimmed so the app stays readable.';

  @override
  String get reminderSmart => 'Smart';

  @override
  String get reminderFixed => 'Fixed time';

  @override
  String get reminderSmartHint =>
      'It uses the days and the time you actually train, and stays quiet on a day you already trained.';

  @override
  String get reminderSmartEmpty => 'Log a few more sessions and it will learn your days.';

  @override
  String habitFocus(String day) {
    return 'what you usually train on $day';
  }

  @override
  String get duplicateRoutine => 'Duplicate routine';

  @override
  String copySuffix(String name) {
    return '$name (copy)';
  }

  @override
  String get saveAsRoutine => 'SAVE AS A ROUTINE';

  @override
  String get savedAsRoutine => 'Saved as a routine';

  @override
  String get templates => 'Ready-made plans';

  @override
  String get templatesHint =>
      'Classic programmes, built from your own library. You can change anything afterwards.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n routines added',
      one: '$n routine added',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Three full-body days a week. The one to start with.';

  @override
  String get tplPpl => 'Push, pull and legs. Three or six days a week.';

  @override
  String get tplUpperlower => 'Upper and lower body, four days a week.';

  @override
  String get tplStronglifts => 'Two workouts, five sets of five, alternating.';

  @override
  String get tplStartingstrength => 'Squat every session, two alternating workouts.';

  @override
  String get tplHome => 'Nothing but a bar to hang from and the floor.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n days', one: '$n day');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Log effort (RPE)';

  @override
  String get rpeTitle => 'EFFORT (RPE)';

  @override
  String get rpeHint => '10 is nothing left in the tank, 8 is two reps to spare.';

  @override
  String get superset => 'Superset';

  @override
  String get supersetLink => 'Chain with the next one';

  @override
  String get supersetHint => 'No rest between chained exercises — you go straight to the next one.';

  @override
  String get aiRoutine => 'Routine with AI';

  @override
  String get aiIntro =>
      'GymMane never talks to an AI. You take your exercise list out, you paste it into whatever assistant you already use, and you bring its answer back in. Nothing leaves the phone on its own.';

  @override
  String get aiStep1 =>
      'Export your exercise list. If you picked a place, it only includes what you can do there.';

  @override
  String get aiStep2 => 'Hand that file to any AI and ask it for a routine.';

  @override
  String get aiStep3 => 'Save its answer as a file — JSON or plain text, either works.';

  @override
  String get aiStep4 =>
      'Import it here. The names are matched against your library and the routine is built.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n names were not in your library',
      one: '1 name was not in your library',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Which apps it reads';

  @override
  String get importOtherCsv => 'Any other CSV with date, exercise, reps and weight';

  @override
  String get importAskApp => 'Need another app? Ask for it';
}
