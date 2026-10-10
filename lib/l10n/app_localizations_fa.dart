// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get languageName => 'فارسی';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct٪ نسبت به ماه قبل';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'سطح $level · $streak';
  }

  @override
  String get save => 'ذخیره';

  @override
  String get cancel => 'لغو';

  @override
  String get cancelCaps => 'لغو';

  @override
  String get deleteCaps => 'حذف';

  @override
  String get done => 'تمام';

  @override
  String get set => 'ست';

  @override
  String get home => 'خانه';

  @override
  String get progress => 'پیشرفت';

  @override
  String get exercises => 'حرکات';

  @override
  String get settings => 'تنظیمات';

  @override
  String get today => 'امروز';

  @override
  String get thisWeek => 'این هفته';

  @override
  String get recommended => 'پیشنهادی';

  @override
  String get goal => 'هدف';

  @override
  String get volume => 'حجم';

  @override
  String get setsToday => 'ست‌های امروز';

  @override
  String get prs => 'رکوردها';

  @override
  String get todaysFocus => 'تمرکز امروز';

  @override
  String get todaysRoutine => 'روتین امروز';

  @override
  String get startWorkout => 'شروع تمرین';

  @override
  String get routines => 'روتین‌ها';

  @override
  String get tools => 'ابزارها';

  @override
  String get firstSessionHint => 'عضلاتت را انتخاب کن و اولین جلسه تمرینت را ثبت کن';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n حرکت', one: '$n حرکت');
    return '$_temp0';
  }

  @override
  String get pushDay => 'روز پرس';

  @override
  String get pullDay => 'روز کشش';

  @override
  String get legDay => 'روز پا';

  @override
  String get pushFocus => 'سینه · شانه · پشت‌بازو';

  @override
  String get pullFocus => 'پشت · جلو‌بازو · تراپز';

  @override
  String get legFocus => 'چهارسر · همسترینگ · باسن';

  @override
  String get train => 'تمرین';

  @override
  String get step1 => 'مرحله ۱ از ۲';

  @override
  String get step2 => 'مرحله ۲ از ۲';

  @override
  String get chooseFocus => 'تمرکزت را انتخاب کن';

  @override
  String get buildSession => 'جلسه تمرینت را بساز';

  @override
  String get tapMuscles => 'عضله‌هایی که می‌خواهی تمرین کنی را لمس کن — جلو و پشت.';

  @override
  String get continueBtn => 'ادامه';

  @override
  String get nothingForFocus => 'هنوز چیزی برای این تمرکز نیست';

  @override
  String get goBackPick => 'برگرد و عضله‌ای را انتخاب کن که در کتابخانه‌ات حرکت دارد.';

  @override
  String pickedHint(int n) {
    return 'یک جلسه تمرین برایت چیدیم — هر کدام از این $n تا را برای اضافه یا حذف لمس کن.';
  }

  @override
  String get pickAnExercise => 'یک حرکت انتخاب کن';

  @override
  String get searchAllExercises => 'جستجوی هر حرکت…';

  @override
  String get noExercisesMatch => 'حرکتی پیدا نشد';

  @override
  String get createItInstead => 'به‌جایش حرکت خودت را بساز';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n حرکت', one: '$n حرکت');
    return 'شروع · $_temp0';
  }

  @override
  String get inProgress => 'در حال انجام';

  @override
  String get paused => 'توقف';

  @override
  String get last => 'قبلی';

  @override
  String get rest => 'استراحت';

  @override
  String get skip => 'رد کردن';

  @override
  String get addSet => '+ افزودن ست';

  @override
  String get finishSession => 'پایان جلسه تمرین';

  @override
  String get setDone => 'ست انجام شد';

  @override
  String get nextExercise => 'حرکت بعدی';

  @override
  String get dropExerciseAction => 'حذف حرکت';

  @override
  String get restOff => 'خاموش';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'تکرار';

  @override
  String weightCol(String unit) {
    return 'وزن ($unit)';
  }

  @override
  String get repsTitle => 'تکرار';

  @override
  String weightTitle(String unit) {
    return 'وزن ($unit)';
  }

  @override
  String get sessionComplete => 'تمرین ثبت شد';

  @override
  String get finishHeadlinePr => 'رکورد شخصی جدید';

  @override
  String get finishHeadlineGoal => 'به هدف هفتگی رسیدی';

  @override
  String get finishHeadlineStreak => 'استریک ادامه دارد';

  @override
  String get finishHeadlineDefault => 'یک تمرین دیگر تمام شد';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs حرکت', one: 'یک حرکت');
    return 'روی $_temp0 از همیشه سنگین‌تر زدی. الان توی رکوردهایت ثبت است.';
  }

  @override
  String get finishBodyGoal => 'هدف جلسه‌های تمرین این هفته را زدی.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak روز پشت‌سرهم. سخت‌ترین بخش متوقف نشدن است.';
  }

  @override
  String get finishBodyDefault => 'ثبت شد و شمرده شد. ثبات است که آمار را جلو می‌برد.';

  @override
  String get vsLastTime => 'نسبت به دفعه قبل';

  @override
  String get firstTime => 'اولین ثبت';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n رکورد جدید',
      one: '$n رکورد جدید',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'مدت';

  @override
  String get setsCaps => 'ست‌ها';

  @override
  String exerciseXofY(int i, int n) {
    return 'حرکت $i از $n';
  }

  @override
  String get decrease => 'کم کردن';

  @override
  String get increase => 'زیاد کردن';

  @override
  String markSet(int n) {
    return 'ست $n را انجام‌شده علامت بزن';
  }

  @override
  String get pauseWorkout => 'توقف تمرین';

  @override
  String get resumeWorkout => 'ادامه تمرین';

  @override
  String get discardTitle => 'تمرین دور انداخته شود؟';

  @override
  String get discardBody => 'ست‌های این جلسه تمرین از بین می‌روند.';

  @override
  String get keepTraining => 'ادامه تمرین';

  @override
  String get discard => 'دور انداختن';

  @override
  String get notifRestChannel => 'تایمر استراحت';

  @override
  String get notifRestChannelWhy => 'وقتی استراحت بین ست‌ها تمام شد خبرت می‌کند';

  @override
  String get notifAlertChannel => 'تایمر استراحت (هشدار)';

  @override
  String get notifAlertChannelWhy => 'همان لحظه که استراحت تمام شد بنر نشان می‌دهد';

  @override
  String get restOverTitle => 'استراحت تمام شد';

  @override
  String get restOverBody => 'برگرد سر تمرین — ست بعدی منتظر است.';

  @override
  String get allTimeSessions => 'جلسه‌های تمرین';

  @override
  String get allTimeTime => 'زمان';

  @override
  String get allTimeSets => 'ست‌ها';

  @override
  String get consistency => 'ثبات';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n جلسه تمرین ثبت‌شده',
      one: '$n جلسه تمرین ثبت‌شده',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'استریک $n روزه';
  }

  @override
  String get bodyweight => 'وزن بدن';

  @override
  String get logBodyweight => 'ثبت وزن بدن';

  @override
  String get trackWeight => 'وزنت را در طول زمان دنبال کن';

  @override
  String get muscleMap => 'نقشه عضلات';

  @override
  String get days7 => '۷ر';

  @override
  String get days30 => '۳۰ر';

  @override
  String get heatLow => 'بدون تمرین';

  @override
  String get heatHigh => 'حجم کامل';

  @override
  String get muscleMapEmpty => 'یک جلسه تمرین ثبت کن تا بدنت اینجا مشخص شود.';

  @override
  String get muscleMapHint => 'یک عضله را لمس کن تا ببینی چقدر کار کرده.';

  @override
  String muscleMapBehind(String names) {
    return 'عقب‌مانده: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct٪ از هدف';
  }

  @override
  String get muscleSplit => 'تقسیم عضلات';

  @override
  String get personalRecords => 'رکوردهای شخصی';

  @override
  String get strength1rm => 'قدرت · تخمین 1RM';

  @override
  String get strengthEmpty => 'یک حرکت را دو بار ثبت کن تا نمودار قدرتش اینجا بیاید.';

  @override
  String oneRmEst(String w) {
    return 'تخمین 1RM $w';
  }

  @override
  String get restDayShort => 'روز استراحت';

  @override
  String get restDay => 'روز استراحت — چیزی ثبت نشده.';

  @override
  String get delete => 'حذف';

  @override
  String get deleteEntry => 'این مورد حذف شود؟';

  @override
  String deleteEntryBody(String name) {
    return '«$name» از این روز و از رکوردها و نمودارهایت حذف می‌شود.';
  }

  @override
  String get bodyweightHistory => 'تاریخچه';

  @override
  String get exercisesCaps => 'حرکات';

  @override
  String get timeCaps => 'زمان';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n حرکت در کتابخانه‌ات',
      one: '$n حرکت در کتابخانه‌ات',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'جستجوی حرکات';

  @override
  String get muscleFilter => 'عضله';

  @override
  String get levelFilter => 'سطح';

  @override
  String get kindLabel => 'نوع';

  @override
  String get kindStrength => 'قدرتی';

  @override
  String get kindCalisthenics => 'کالیستنیکس';

  @override
  String get kindCardio => 'هوازی';

  @override
  String get kindStretch => 'کشش';

  @override
  String get newExercise => 'حرکت جدید';

  @override
  String get exerciseName => 'نام حرکت';

  @override
  String get equipmentLabel => 'تجهیزات';

  @override
  String get addExercise => 'افزودن حرکت';

  @override
  String get advanced => 'پیشرفته';

  @override
  String get demoMedia => 'دمو';

  @override
  String get addMedia => 'افزودن رسانه';

  @override
  String get mediaHint => 'تصویر، GIF یا ویدیو';

  @override
  String get changeMedia => 'تغییر';

  @override
  String get videoSelected => 'ویدیو انتخاب شد';

  @override
  String get favouritesOnly => 'علاقه‌مندی‌ها';

  @override
  String get noFavouritesYet => 'هنوز علاقه‌مندی نداری';

  @override
  String get noFavouritesHint => 'ستاره روی یک حرکت را لمس کن تا اینجا بماند.';

  @override
  String get clearFilters => 'پاک کردن فیلترها';

  @override
  String get noExercisesFound => 'حرکتی پیدا نشد';

  @override
  String get noExercisesHint => 'جستجوی دیگری امتحان کن یا فیلترها را پاک کن.';

  @override
  String get personalRecord => 'رکورد شخصی';

  @override
  String get history => 'تاریخچه';

  @override
  String get noHistory => 'هنوز جلسه تمرینی ثبت نشده. این حرکت را تمرین کن تا تاریخچه ساخته شود.';

  @override
  String get notes => 'یادداشت‌ها';

  @override
  String get notePlaceholder => 'نکته، آماده‌سازی، حس حرکت…';

  @override
  String notHere(String gear, String place) {
    return 'در $place $gear نیست';
  }

  @override
  String get notHereWhy => 'با چیزی عوضش کن که امروز واقعاً می‌توانی بزنی.';

  @override
  String get altHere => 'اینجا چه می‌توانی بزنی';

  @override
  String get places => 'مکان‌های من';

  @override
  String get placesHint =>
      'بگو در هر مکان چه داری تا کتابخانه فقط چیزهایی را نشان دهد که واقعاً آنجا می‌توانی بزنی.';

  @override
  String get placeAll => 'همه‌جا';

  @override
  String get placeNew => 'مکان جدید';

  @override
  String get placeNamePlaceholder => 'خانه، باشگاه، پارک…';

  @override
  String get placeGearLabel => 'چه چیزی هست';

  @override
  String placeExercises(int n) {
    return '$n حرکت اینجا';
  }

  @override
  String get placeEmptyTitle => 'هرجا که هستی تمرین کن';

  @override
  String get placeEmptyBody =>
      'یک مکان، فهرستی از وسیله‌هایی است که آنجا داری. یکی را برای شروع بساز و بعداً ویرایش کن.';

  @override
  String get placeDeleteTitle => 'حذف مکان';

  @override
  String get placeDeleteBody => 'فقط مکان حذف می‌شود — حرکات و جلسه‌های تمرین می‌مانند.';

  @override
  String get placeGym => 'باشگاه';

  @override
  String get placeHome => 'خانه';

  @override
  String get placeOutdoors => 'فضای باز';

  @override
  String get placeFilterLabel => 'مکان';

  @override
  String get noGearOnly => 'بدون وسیله';

  @override
  String placeActive(String name) {
    return 'تمرین در $name';
  }

  @override
  String get journal => 'ژورنال';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n یادداشت',
      one: '۱ یادداشت',
      zero: 'بدون یادداشت',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'یادداشت';

  @override
  String get noteKindPlan => 'برنامه';

  @override
  String get noteKindDone => 'برد';

  @override
  String get noteKindPain => 'درد خفیف';

  @override
  String get noteFilterAll => 'همه';

  @override
  String get newNote => 'یادداشت جدید';

  @override
  String get editNote => 'ویرایش یادداشت';

  @override
  String get addNote => 'افزودن یادداشت';

  @override
  String get noteEmptyTitle => 'هنوز چیزی نوشته نشده';

  @override
  String get noteEmptyBody => 'نکته، برنامه برای دفعه بعد، حس جلسه تمرین — با عکس یا ویدیو اگر بخواهی.';

  @override
  String get noteNoneForExercise => 'هنوز یادداشتی روی این حرکت نیست.';

  @override
  String get noteKindLabel => 'نوع';

  @override
  String get noteTextLabel => 'یادداشت';

  @override
  String get noteDateLabel => 'تاریخ';

  @override
  String get noteExerciseLabel => 'حرکت';

  @override
  String get noteMediaLabel => 'عکس و ویدیو';

  @override
  String get noteGeneral => 'بدون حرکت';

  @override
  String get noteAttach => 'پیوست';

  @override
  String get noteRemoveMedia => 'حذف پیوست';

  @override
  String get deleteNoteTitle => 'حذف یادداشت';

  @override
  String get deleteNoteBody => 'یادداشت و هرچه به آن پیوست شده برای همیشه پاک می‌شود.';

  @override
  String get noteToday => 'امروز';

  @override
  String get noteYesterday => 'دیروز';

  @override
  String get noteAllNotes => 'همه یادداشت‌ها';

  @override
  String get noteCalendar => 'تقویم';

  @override
  String get noteNoneOnDay => 'در این روز چیزی نوشته نشده';

  @override
  String get noteAddOnDay => 'یادداشت در این روز';

  @override
  String get notePrevMonth => 'ماه قبل';

  @override
  String get noteNextMonth => 'ماه بعد';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n یادداشت این ماه',
      one: '۱ یادداشت این ماه',
      zero: 'این ماه یادداشتی نیست',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'اندازه‌گیری‌ها';

  @override
  String get measuresHint => 'از گردن تا ساق — بدنت را ببین، نه فقط میله را.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n اندازه‌گیری',
      one: '۱ اندازه‌گیری',
      zero: 'چیزی ثبت نشده',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'هنوز ثبت نشده';

  @override
  String get measureHistory => 'تاریخچه';

  @override
  String get measureNeck => 'گردن';

  @override
  String get measureShoulders => 'شانه‌ها';

  @override
  String get measureChest => 'سینه';

  @override
  String get measureArm => 'بازو';

  @override
  String get measureForearm => 'ساعد';

  @override
  String get measureWaist => 'کمر';

  @override
  String get measureHips => 'باسن';

  @override
  String get measureThigh => 'ران';

  @override
  String get measureCalf => 'ساق';

  @override
  String get measureBodyfat => 'چربی بدن';

  @override
  String get timeline => 'تایم‌لاین';

  @override
  String get timelineHint => 'همان ژست، همان جا، همان نور. یک سال بعد باور نمی‌کنی.';

  @override
  String get timelineEmptyTitle => 'با اولین عکس، تایم‌لاین شروع می‌شود';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n عکس',
      one: '۱ عکس',
      zero: 'بدون عکس',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'جلو';

  @override
  String get poseSide => 'پهلو';

  @override
  String get poseBack => 'پشت';

  @override
  String get photoEvery => 'یادم بینداز';

  @override
  String photoEveryDays(int n) {
    return 'هر $n روز';
  }

  @override
  String get photoEveryOff => 'هرگز';

  @override
  String get timelineEvery => 'گروه‌بندی هر';

  @override
  String get custom => 'سفارشی';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'عکس بعدی تا $n روز دیگر',
      one: 'عکس بعدی فردا',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'وقت عکس است — امروز بگیر';

  @override
  String get addTodayPhotos => 'افزودن عکس‌های امروز';

  @override
  String posePhoto(String pose) {
    return 'عکس $pose';
  }

  @override
  String get compare => 'مقایسه';

  @override
  String get compareNeedTwo => 'همان ژست را در دو روز مختلف بگیر تا اینجا مقایسه کنی.';

  @override
  String dayNumber(int n) {
    return 'روز $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روز فاصله',
      one: '۱ روز فاصله',
      zero: 'همان روز',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'حذف این روز';

  @override
  String get deleteDayBody => 'عکس‌هایش هم برای همیشه پاک می‌شوند.';

  @override
  String get timelinePhotos => 'عکس‌ها';

  @override
  String get timelineBody => 'نقشه عضلات';

  @override
  String get timelineBodyEmpty => 'یک جلسه تمرین ثبت کن تا نقشه عضلات اینجا پر شود، بدون نیاز به عکس.';

  @override
  String get timelineBodyHint => 'از ست‌های خودت ساخته شده — چیزی برای آپلود نیست.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n جلسه تمرین',
      one: '۱ جلسه تمرین',
      zero: 'بدون جلسه تمرین',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'عکس پیشرفت';

  @override
  String get notifPhotoChannelWhy => 'وقتی عکس پیشرفت بعدی‌ات موعد شد یک یادآوری.';

  @override
  String get notifPhotoTitle => 'وقت عکس پیشرفت';

  @override
  String notifPhotoBody(int n) {
    return '$n روز از قبلی گذشته. همان ژست، همان نور.';
  }

  @override
  String get share => 'اشتراک‌گذاری';

  @override
  String get sharePick => 'چه چیزی را می‌خواهی نشان بدهی؟';

  @override
  String get shareStreak => 'استریک و ثبات';

  @override
  String get shareBody => 'عضلات کارشده';

  @override
  String get shareCompare => 'قبل و بعد';

  @override
  String get shareHint => 'کارت روی گوشی‌ات ساخته می‌شود. تا جایی را انتخاب نکنی چیزی بیرون نمی‌رود.';

  @override
  String get shareFailed => 'کارت ساخته نشد';

  @override
  String get shareWeekOf => '۷ روز اخیر';

  @override
  String get shareStreakLabel => 'استریک روزانه';

  @override
  String get shareSessionsLabel => 'جلسه‌های تمرین';

  @override
  String get shareVolumeLabel => 'حجم';

  @override
  String get restForExercise => 'استراحت برای این حرکت';

  @override
  String get restUsingDefault => 'با پیش‌فرض تو';

  @override
  String get restCustom => 'فقط برای همین';

  @override
  String get setType => 'نوع ست';

  @override
  String get setTypeNormal => 'ست کاری';

  @override
  String get setTypeWarmup => 'گرم‌کردن';

  @override
  String get setTypeDrop => 'دراپ ست';

  @override
  String get setTypeFailure => 'تا ناتوانی';

  @override
  String get addWarmup => 'گرم‌کردن';

  @override
  String platesPerSide(String plates) {
    return 'هر طرف: $plates';
  }

  @override
  String get howTo => 'نحوه اجرا';

  @override
  String get similar => 'مشابه';

  @override
  String get primaryLabel => 'اصلی';

  @override
  String get secondaryLabel => 'فرعی';

  @override
  String get none => 'هیچ';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ست', one: '$n ست');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'حجم $v';
  }

  @override
  String get weeklyPlan => 'برنامه هفتگی';

  @override
  String get yourRoutines => 'روتین‌های تو';

  @override
  String get noRoutines => 'هنوز روتینی نیست. یکی بساز و حرکاتت را اضافه کن.';

  @override
  String get newRoutine => 'روتین جدید';

  @override
  String get routineName => 'نام روتین';

  @override
  String get schedule => 'زمان‌بندی';

  @override
  String get addFromList => 'حرکات را از فهرست زیر اضافه کن.';

  @override
  String get addExercises => 'افزودن حرکات';

  @override
  String get deleteRoutine => 'این روتین حذف شود؟';

  @override
  String exercisesWithCount(int n) {
    return 'حرکات · $n';
  }

  @override
  String setDay(String day) {
    return 'تنظیم $day';
  }

  @override
  String get newRoutineName => 'روتین جدید';

  @override
  String get dragToReorder => 'نگه‌دار و بکش تا جابه‌جا کنی — ترتیب تمرینت همین است.';

  @override
  String reorderHandle(String name) {
    return 'جابه‌جایی $name';
  }

  @override
  String get removeFromRoutine => 'حذف از روتین';

  @override
  String get dropExercise => 'این حرکت حذف شود؟';

  @override
  String dropExerciseBody(String name) {
    return '«$name» از این تمرین خارج می‌شود. چیزی که ثبت شده از بین نمی‌رود.';
  }

  @override
  String get drop => 'حذف';

  @override
  String get resetData => 'حذف همه داده‌هایم';

  @override
  String get resetTitle => 'همه‌چیز حذف شود؟';

  @override
  String get resetBody =>
      'جلسه‌های تمرین، رکوردها، روتین‌ها، یادداشت‌ها و پروفایل. برگشتی نیست — اگر ممکن است بخواهی، اول یک بکاپ خروجی بگیر.';

  @override
  String get resetConfirm => 'حذف همه‌چیز';

  @override
  String get resetDone => 'همه داده‌ها حذف شد';

  @override
  String get support => 'پشتیبانی';

  @override
  String get reportBug => 'گزارش باگ';

  @override
  String get requestFeature => 'درخواست قابلیت';

  @override
  String get starOnGithub => 'ستاره در GitHub';

  @override
  String get buyCoffee => 'یک قهوه مهمانم کن';

  @override
  String get cantOpenLink => 'لینک باز نشد';

  @override
  String get theme => 'تم';

  @override
  String get darkTheme => 'تاریک';

  @override
  String get lightTheme => 'روشن';

  @override
  String get amoledTheme => 'مشکی AMOLED';

  @override
  String get editDuration => 'مدت تمرین';

  @override
  String get secondaryPickHint => 'عضله‌های دیگری را که این حرکت درگیر می‌کند لمس کن.';

  @override
  String get languageLabel => 'زبان';

  @override
  String get unitsLabel => 'واحدها';

  @override
  String get restTimer => 'تایمر استراحت';

  @override
  String get alarmBlockedTitle => 'اعلان‌ها خاموش‌اند';

  @override
  String get alarmBlockedBody => 'وقتی صفحه قفل است، آلارم استراحت زنگ نمی‌زند';

  @override
  String get alarmBlockedAction => 'روشن کردن';

  @override
  String get alarmSound => 'صدای آلارم';

  @override
  String get alarmDefaultName => 'پیش‌فرض';

  @override
  String get alarmSoundHint => 'مال خودت را بگذار — تا ۱۵ ثانیه';

  @override
  String get alarmChoose => 'انتخاب صدا…';

  @override
  String get alarmPreview => 'پخش صدای فعلی';

  @override
  String get alarmReset => 'بازگشت به پیش‌فرض';

  @override
  String get alarmTooLong => 'آن صدا بیشتر از ۱۵ ثانیه است';

  @override
  String get alarmInvalid => 'خواندن آن فایل صوتی ممکن نشد';

  @override
  String alarmChanged(String name) {
    return 'صدای آلارم روی «$name» تنظیم شد';
  }

  @override
  String get alarmChangedDefault => 'برگشت به صدای پیش‌فرض';

  @override
  String get addActivityWidget => 'افزودن ویجت فعالیت';

  @override
  String get addStatsWidget => 'افزودن ویجت آمار';

  @override
  String get pinUnsupported => 'از منوی ویجت لانچرت اضافه‌اش کن';

  @override
  String get background => 'پس‌زمینه';

  @override
  String get bgNone => 'هیچ';

  @override
  String get bgDots => 'نقطه‌ها';

  @override
  String get bgGrid => 'شبکه';

  @override
  String get exportCsv => 'خروجی تمرین‌ها (CSV)';

  @override
  String get exportBackup => 'خروجی بکاپ (ZIP)';

  @override
  String get importBackup => 'وارد کردن بکاپ';

  @override
  String get importHint =>
      'یک بکاپ .zip (یا .json قدیمی‌تر) خروجی‌گرفته از Gymo را انتخاب کن. این کار داده‌های فعلی‌ات را جایگزین می‌کند، با رسانه‌ها.';

  @override
  String get import => 'وارد کردن';

  @override
  String get chooseFile => 'انتخاب فایل';

  @override
  String get importFromApp => 'وارد کردن از اپ دیگر';

  @override
  String get importUnknownFormat => 'آن فایل به ستون‌های تاریخ، حرکت، تکرار و وزن نیاز دارد';

  @override
  String get importZipNoWeights => 'آن zip فایل وزن‌کشی ندارد';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n وزن‌کشی وارد شد',
      one: '$n وزن‌کشی وارد شد',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'خواندن آن فایل ممکن نشد';

  @override
  String get importUnitTitle => 'آن فایل با کدام واحد است؟';

  @override
  String get importUnitBody => 'این خروجی نگفته وزن‌ها با کدام واحد هستند.';

  @override
  String get importNothing => 'چیز جدیدی برای وارد کردن نیست';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n جلسه تمرین وارد شد',
      one: '$n جلسه تمرین وارد شد',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'درباره Gymo';

  @override
  String get yourProfile => 'پروفایل تو';

  @override
  String get autofills => 'ماشین‌حساب‌ها را پر می‌کند';

  @override
  String get nameLabel => 'نام';

  @override
  String get sexLabel => 'جنسیت';

  @override
  String get macroProtein => 'پروتئین';

  @override
  String get macroCarbs => 'کربو';

  @override
  String get macroFat => 'چربی';

  @override
  String get male => 'مرد';

  @override
  String get female => 'زن';

  @override
  String get ageLabel => 'سن';

  @override
  String get heightLabel => 'قد';

  @override
  String get weightLabel => 'وزن';

  @override
  String get weeklyGoal => 'هدف هفتگی';

  @override
  String get activityLabel => 'فعالیت';

  @override
  String get addPhoto => 'افزودن عکس';

  @override
  String get removePhoto => 'حذف عکس';

  @override
  String get takePhoto => 'گرفتن عکس';

  @override
  String get chooseGallery => 'انتخاب از گالری';

  @override
  String get backupImported => 'بکاپ وارد شد';

  @override
  String get backupFailed => 'خواندن آن بکاپ ممکن نشد';

  @override
  String get nothingToExport => 'هنوز چیزی برای خروجی نیست — اول یک جلسه تمرین ثبت کن';

  @override
  String calculatorsCount(int n) {
    return '$n ماشین‌حساب برای تمرینت';
  }

  @override
  String get result => 'نتیجه';

  @override
  String get weightLifted => 'وزن جابه‌جاشده';

  @override
  String get repsPerformed => 'تکرار انجام‌شده';

  @override
  String get neck => 'گردن';

  @override
  String get waist => 'کمر';

  @override
  String get hip => 'باسن (برای زنان)';

  @override
  String get targetWeight => 'وزن هدف';

  @override
  String get workingWeight => 'وزن کاری';

  @override
  String get activityLevel => 'سطح فعالیت';

  @override
  String get barWeight => 'وزن میله';

  @override
  String get perSide => 'هر طرف';

  @override
  String get justTheBar => 'فقط میله.';

  @override
  String perSideCount(int n) {
    return '× $n هر طرف';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'کالری';

  @override
  String get toolNameBf => 'چربی بدن';

  @override
  String get toolNamePlate => 'وزنه';

  @override
  String get toolNameWarmup => 'گرم‌کردن';

  @override
  String get toolTitleRm => 'ماشین‌حساب 1RM';

  @override
  String get toolTitleBmi => 'ماشین‌حساب BMI';

  @override
  String get toolTitleCal => 'کالری و ماکرو';

  @override
  String get toolTitleBf => 'درصد چربی بدن';

  @override
  String get toolTitlePlate => 'ماشین‌حساب وزنه';

  @override
  String get toolTitleWarmup => 'ست‌های گرم‌کردن';

  @override
  String get toolHintRm => 'تخمین یک‌تکرار بیشینه (فرمول Epley)';

  @override
  String get toolHintCal => 'تخمین کالری نگهداری روزانه';

  @override
  String get toolHintBf => 'تخمین روش نیروی دریایی آمریکا';

  @override
  String get toolHintPlate => 'وزن کل هالتر';

  @override
  String get toolHintWarmup => 'هدف وزن کاری';

  @override
  String get toolDescRm => 'تخمین یک‌تکرار بیشینه';

  @override
  String get toolDescBmi => 'شاخص توده بدنی';

  @override
  String get toolDescCal => 'کالری و ماکرو';

  @override
  String get toolDescBf => 'درصد چربی بدن';

  @override
  String get toolDescPlate => 'ماشین‌حساب وزنه هالتر';

  @override
  String get toolDescWarmup => 'ست‌های گرم‌کردن پلکانی';

  @override
  String get bmiUnderweight => 'کم‌وزن';

  @override
  String get bmiNormal => 'طبیعی';

  @override
  String get bmiOverweight => 'اضافه‌وزن';

  @override
  String get bmiObese => 'چاق';

  @override
  String get actSedentary => 'کم‌تحرک';

  @override
  String get actLight => 'سبک';

  @override
  String get actActive => 'فعال';

  @override
  String get actModerate => 'متوسط';

  @override
  String get muscleChest => 'سینه';

  @override
  String get muscleBack => 'پشت';

  @override
  String get muscleLowerBack => 'پایین کمر';

  @override
  String get muscleShoulders => 'شانه‌ها';

  @override
  String get muscleBiceps => 'جلو‌بازو';

  @override
  String get muscleTriceps => 'پشت‌بازو';

  @override
  String get muscleForearm => 'ساعد';

  @override
  String get muscleTrapezius => 'تراپز';

  @override
  String get muscleAbdomen => 'شکم';

  @override
  String get muscleObliques => 'مایل شکم';

  @override
  String get muscleQuads => 'چهارسر';

  @override
  String get muscleHamstrings => 'همسترینگ';

  @override
  String get muscleGlutes => 'باسن';

  @override
  String get muscleCalves => 'ساق';

  @override
  String get mgChest => 'سینه';

  @override
  String get mgBack => 'پشت';

  @override
  String get mgLegs => 'پاها';

  @override
  String get mgShoulders => 'شانه‌ها';

  @override
  String get mgArms => 'بازوها';

  @override
  String get mgCore => 'مرکز بدن';

  @override
  String get equipBarbell => 'هالتر';

  @override
  String get equipDumbbell => 'دمبل';

  @override
  String get equipCable => 'کابل';

  @override
  String get equipMachine => 'دستگاه';

  @override
  String get equipBodyweight => 'وزن بدن';

  @override
  String get equipWeighted => 'با وزنه';

  @override
  String get equipBand => 'کش';

  @override
  String get equipKettlebell => 'کتل‌بل';

  @override
  String get equipRings => 'حلقه';

  @override
  String get equipOther => 'دیگر';

  @override
  String get diffBeginner => 'مبتدی';

  @override
  String get diffAdvanced => 'پیشرفته';

  @override
  String get diffIntermediate => 'متوسط';

  @override
  String get about => 'درباره';

  @override
  String version(String v) {
    return 'نسخه $v';
  }

  @override
  String get aboutBlurb => 'ساخته توسط وزنه‌زن‌ها، برای وزنه‌زن‌ها.';

  @override
  String get freeForever => 'برای همیشه رایگان';

  @override
  String get freeForeverWhy => 'بدون اشتراک، بدون تبلیغ، بدون پرداخت اجباری.';

  @override
  String get fullyOffline => 'کاملاً آفلاین';

  @override
  String get fullyOfflineWhy => 'بدون حساب، بدون سرور. تمرینت هرگز از این گوشی خارج نمی‌شود.';

  @override
  String get yoursToTake => 'داده‌ات مال توست';

  @override
  String get yoursToTakeWhy => 'هر وقت خواستی به CSV خروجی بگیر و با یک ضربه همه‌اش را پاک کن.';

  @override
  String get whatsInside => 'امکانات';

  @override
  String exercisesInside(int n) {
    return '$n حرکت';
  }

  @override
  String get exercisesInsideWhy => 'هر کدام با انیمیشن و دستور گام‌به‌گام.';

  @override
  String get calculatorsInside => '۱۰ ماشین‌حساب';

  @override
  String get calculatorsInsideWhy =>
      '1RM، وزنه، BMI، کالری، چربی بدن، FFMI، گرم‌کردن، وزن بر اساس RPE و امتیاز قدرت DOTS و Wilks — همه با فرمول‌های منتشرشده.';

  @override
  String get mathInside => 'آمار واقعی';

  @override
  String get mathInsideWhy => 'حجم، رکورد و استریک از ست‌های خودت می‌آید. اینجا چیزی تزئینی نیست.';

  @override
  String get streakCaps => 'استریک';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'روز', one: 'روز');
    return '$_temp0';
  }

  @override
  String get reset => 'بازنشانی';

  @override
  String get welcomeKicker => 'خوش‌آمدی به';

  @override
  String get welcomeBlurb => 'همه‌چیز روی گوشی‌ات می‌ماند. بدون حساب، بدون اینترنت، بدون پرداخت.';

  @override
  String get welcomeStart => 'شروع کن';

  @override
  String onbStep(int i, int n) {
    return 'مرحله $i از $n';
  }

  @override
  String get onbNameTitle => 'چه صدایت کنیم؟';

  @override
  String get onbNameHint => 'نامت';

  @override
  String get onbNameWhy => 'فقط برای سلام. هرگز از گوشی خارج نمی‌شود.';

  @override
  String get onbBodyTitle => 'چند عدد';

  @override
  String get onbBodyWhy => 'برای ماشین‌حساب‌ها لازم‌اند. هر وقت در تنظیمات عوضشان کن.';

  @override
  String get onbGoalTitle => 'چند وقت یک‌بار تمرین می‌کنی؟';

  @override
  String get onbGoalWhy => 'حلقه هدف هفتگی‌ات را تنظیم می‌کند. صادق باش، نه بلندپرواز.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n جلسه تمرین در هفته',
      one: '$n جلسه تمرین در هفته',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'کیلو یا پوند؟';

  @override
  String get next => 'بعدی';

  @override
  String get back => 'قبلی';

  @override
  String get skip2 => 'رد کردن';

  @override
  String get madeWithLoveBy => 'ساخته با عشق به‌دست';

  @override
  String get sourceCode => 'کد منبع';

  @override
  String get suggested => 'پیشنهادی';

  @override
  String get results => 'نتایج';

  @override
  String get noMatches => 'حرکتی با آن جستجو جور نیست.';

  @override
  String get tapToEdit => 'مداد را برای اصلاح لمس کن، یا سطل را برای حذف.';

  @override
  String get editEntry => 'ویرایش';

  @override
  String get editEntryHint => 'تکرار یا وزن هر ست را اصلاح کن.';

  @override
  String get removeSet => 'حذف ست';

  @override
  String get continueWorkout => 'ادامه';

  @override
  String get continueWorkoutBody =>
      'تمرین دوباره به حالت در حال انجام برمی‌گردد، با ست‌های انجام‌شده. تمام کردنش دوباره همان روز اصلی را ذخیره می‌کند.';

  @override
  String get addBodyWidget => 'افزودن ویجت نقشه عضلات';

  @override
  String get repsOnly => 'فقط تکرار';

  @override
  String get repsOnlyHint => 'این حرکت را بدون وزن ثبت کن.';

  @override
  String get useDefaultArt => 'بازگشت به تصویر پیش‌فرض';

  @override
  String daysShort(int n) {
    return '$nر';
  }

  @override
  String get focusCard => 'تمرکز امروز';

  @override
  String get autoAdvance => 'رفتن خودکار به حرکت بعد';

  @override
  String get keepScreenOn => 'صفحه هنگام تمرین روشن بماند';

  @override
  String get lockWorkout => 'قفل صفحه';

  @override
  String get unlockWorkout => 'باز کردن';

  @override
  String get holdToUnlock => 'نگه‌دار تا باز شود';

  @override
  String get liveChannel => 'تمرین جاری';

  @override
  String get liveChannelWhy => 'حرکت فعلی، ست و تایمر استراحت را هنگام تمرین نشان می‌دهد';

  @override
  String liveSet(int n, int total) {
    return 'ست $n از $total';
  }

  @override
  String get liveResting => 'در حال استراحت';

  @override
  String get liveAllDone => 'همه ست‌ها انجام شد';

  @override
  String get autoAdvanceHint => 'وقتی آخرین ست یک حرکت انجام‌شده شد، تمرین جلو می‌رود.';

  @override
  String get autoProgress => 'دفعه بعد وزن اضافه کن';

  @override
  String autoProgressHint(String w) {
    return 'همه تکرارها را بزن و جلسه تمرین بعد $w سنگین‌تر شروع می‌شود.';
  }

  @override
  String get placePlates => 'وزنه و میله';

  @override
  String get platesAll => 'همه‌چیز موجود';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n سایز', one: '$n سایز');
    return '$_temp0';
  }

  @override
  String get platePairs => 'جفت';

  @override
  String plateAchievable(String w) {
    return 'نزدیک‌ترین باری که می‌توانی ببندی: $w';
  }

  @override
  String get autoWarmup => 'شروع با ست‌های گرم‌کردن';

  @override
  String get autoWarmupHint => 'وقتی تمرین باز می‌شود ست‌های گرم‌کردن پلکانی را اضافه می‌کند.';

  @override
  String get trainReminder => 'یادآور تمرین';

  @override
  String get trainReminderHint => 'فقط در روزهای برنامه‌ریزی‌شده روتین، همین ساعت یادآوری می‌کند.';

  @override
  String get reminderExactTime => 'ساعت دقیق';

  @override
  String get toastSoundSetting => 'صدای اعلان‌ها';

  @override
  String get toastSoundHint => 'یک صدای ملایم وقتی اعلانی بالا ظاهر می‌شود.';

  @override
  String get notifTrainChannel => 'یادآور تمرین';

  @override
  String get notifTrainChannelWhy => 'در روزهایی که برنامه‌ریزی کردی برای تمرین یادآوری‌ات می‌کند.';

  @override
  String get notifTrainTitle => 'وقت تمرین';

  @override
  String get notifTrainBody => 'روتینت منتظر است.';

  @override
  String get planIntro => 'یک روتین تمرینی فقط با حرکات این فهرست برایم بساز.';

  @override
  String get planFormat => 'فقط با JSON جواب بده، به این شکل:';

  @override
  String get planNothing => 'هیچ حرکتی در آن فایل با کتابخانه‌ات جور نبود';

  @override
  String get planFailed => 'آن فایل روتینی نیست که بتوانیم بخوانیم';

  @override
  String get routineGroup => 'گروه';

  @override
  String get newGroup => 'گروه جدید';

  @override
  String get noGroup => 'بدون گروه';

  @override
  String get groupNameHint => 'پرس / کشش / پا، ۵×۵…';

  @override
  String get filters => 'فیلترها';

  @override
  String get setsPlannedHint => 'بگو از هر کدام چند ست می‌خواهی. تمرین با آن‌ها آماده باز می‌شود.';

  @override
  String get nextTime => 'دفعه بعد';

  @override
  String get nextHold => 'همان وزن تا همه تکرارها را بزنی';

  @override
  String get bgPhoto => 'عکس تو';

  @override
  String get bgPhotoPick => 'انتخاب عکس';

  @override
  String get bgPhotoChange => 'تغییر عکس';

  @override
  String get bgPhotoRemove => 'حذف عکس';

  @override
  String get bgDim => 'چقدر تیره';

  @override
  String get dimSoft => 'ملایم';

  @override
  String get dimMedium => 'متوسط';

  @override
  String get dimStrong => 'قوی';

  @override
  String get bgPhotoHint => 'پشت همه‌چیز قرار می‌گیرد، تیره‌شده تا اپ خوانا بماند.';

  @override
  String get reminderSmart => 'هوشمند';

  @override
  String get reminderFixed => 'ساعت ثابت';

  @override
  String get reminderSmartHint =>
      'روزها و ساعتی که واقعاً تمرین می‌کنی را استفاده می‌کند و روزی که تمرین کرده‌ای ساکت می‌ماند.';

  @override
  String get reminderSmartEmpty => 'چند جلسه تمرین دیگر ثبت کن تا روزهایت را یاد بگیرد.';

  @override
  String habitFocus(String day) {
    return 'آنچه معمولاً در $day تمرین می‌کنی';
  }

  @override
  String get duplicateRoutine => 'کپی روتین';

  @override
  String copySuffix(String name) {
    return '$name (کپی)';
  }

  @override
  String get saveAsRoutine => 'ذخیره به‌عنوان روتین';

  @override
  String get savedAsRoutine => 'به‌عنوان روتین ذخیره شد';

  @override
  String get templates => 'برنامه‌های آماده';

  @override
  String get templatesHint => 'برنامه‌های کلاسیک، از کتابخانه خودت. بعداً هرچیزی را عوض کن.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روتین اضافه شد',
      one: '$n روتین اضافه شد',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'سه روز فول‌بادی در هفته. برای شروع.';

  @override
  String get tplPpl => 'پرس، کشش و پا. سه یا شش روز در هفته.';

  @override
  String get tplUpperlower => 'بالاتنه و پایین‌تنه، چهار روز در هفته.';

  @override
  String get tplStronglifts => 'دو تمرین، پنج ست پنج‌تایی، یکی در میان.';

  @override
  String get tplStartingstrength => 'اسکوات هر جلسه تمرین، دو تمرین یکی در میان.';

  @override
  String get tplHome => 'فقط میله بارفیکس و کف زمین.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n روز', one: '$n روز');
    return '$_temp0';
  }

  @override
  String get logRpe => 'ثبت تلاش (RPE)';

  @override
  String get rpeHint => '۱۰ یعنی دیگر نمی‌توانی، ۸ یعنی دو تکرار مانده.';

  @override
  String get superset => 'سوپرست';

  @override
  String get supersetLink => 'وصل به بعدی';

  @override
  String get supersetHint => 'بین حرکات سوپرست استراحت نیست — مستقیم می‌روی سراغ بعدی.';

  @override
  String get aiRoutine => 'روتین با AI';

  @override
  String get aiIntro =>
      'Gymo هرگز با AI حرف نمی‌زند. فهرست حرکاتت را بیرون می‌بری، در هر دستیار که داری پیست می‌کنی، و جوابش را برمی‌گردانی. چیزی خودبه‌خود از گوشی خارج نمی‌شود.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نام در کتابخانه‌ات نبود',
      one: '۱ نام در کتابخانه‌ات نبود',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'کدام اپ‌ها را می‌خواند';

  @override
  String get importOtherCsv => 'هر CSV دیگری با تاریخ، حرکت، تکرار و وزن';

  @override
  String get importAskApp => 'اپ دیگری می‌خواهی؟ بخواهش';

  @override
  String get awardFirstStepName => 'اولین قدم';

  @override
  String get awardFirstStepLine => 'به Gymo خوش آمدی. این یکی مهمان ماست.';

  @override
  String get awardFirstWorkoutName => 'اولین تمرین';

  @override
  String get awardFirstWorkoutLine => 'اولی ثبت شد. سخت‌ترین همان است.';

  @override
  String get awardFirstRoutineName => 'اولین روتین';

  @override
  String get awardFirstRoutineLine => 'برنامه‌ای داری که برگردی سراغش.';

  @override
  String get awardFirstRecordName => 'اولین رکورد';

  @override
  String get awardFirstRecordLine => 'بهترین وزنه‌ات را روی یک حرکت شکستی.';

  @override
  String get awardStreak3Name => 'سه تا پشت‌سرهم';

  @override
  String get awardStreak3Line => 'سه روز پشت‌سرهم. این‌طور شروع می‌شود.';

  @override
  String get awardTonne1Name => 'یک تن';

  @override
  String get awardTonne1Line => 'هزار کیلو در ست‌هایت جابه‌جا شد.';

  @override
  String get awardSets100Name => 'صد ست';

  @override
  String get awardSets100Line => 'صد ست تمام‌شده، یکی‌یکی.';

  @override
  String get awardHours10Name => 'ده ساعت';

  @override
  String get awardHours10Line => 'ده ساعت تمرین ثبت‌شده.';

  @override
  String get awardWorkouts50Name => 'پنجاه تمرین';

  @override
  String get awardWorkouts50Line => 'پنجاه جلسه تمرین پشت سرت.';

  @override
  String get awardHours50Name => 'پنجاه ساعت';

  @override
  String get awardHours50Line => 'پنجاه ساعت داخل باشگاه.';

  @override
  String get awardsTitle => 'مدال‌ها';

  @override
  String get yearTitle => 'سال تو';

  @override
  String get yearBestMonth => 'بهترین ماه';

  @override
  String get yearMonths => 'ماه';

  @override
  String get awardSpinHint => 'مدال را بکش تا بچرخد';

  @override
  String get awardUnlocked => 'مدال جدید باز شد';

  @override
  String get awardNice => 'عالی!';

  @override
  String get awardSaveImage => 'ذخیره تصویر';

  @override
  String get awardSaved => 'در گالری ذخیره شد';

  @override
  String get awardStreak7Name => 'هفت روز';

  @override
  String get awardStreak7Line => 'یک هفته کامل بدون جا انداختن.';

  @override
  String get awardStreak30Name => 'سی روز';

  @override
  String get awardStreak30Line => 'یک ماه پشت‌سرهم. حالا عادت شده.';

  @override
  String get awardWorkouts100Name => 'صد تمرین';

  @override
  String get awardWorkouts100Line => 'صد جلسه تمرین از اول تا آخر ثبت شد.';

  @override
  String get awardTonnes100Name => 'صد تن';

  @override
  String get awardTonnes100Line => 'هرچه جابه‌جا کرده‌ای به ۱۰۰٬۰۰۰ کیلو می‌رسد.';

  @override
  String get awardSets1000Name => 'هزار ست';

  @override
  String get awardSets1000Line => 'یکی‌یکی، هزار تا از آن‌ها.';

  @override
  String get profile => 'پروفایل';

  @override
  String get editProfile => 'ویرایش پروفایل';

  @override
  String get pickBadge => 'نشان';

  @override
  String get statWorkouts => 'تمرین‌ها';

  @override
  String get statTrained => 'مدت تمرین';

  @override
  String get statSets => 'ست‌ها';

  @override
  String get statLifted => 'جابه‌جاشده';

  @override
  String get statStreak => 'استریک';

  @override
  String get statDays => 'روز';

  @override
  String get unitHours => 'ساعت';

  @override
  String get unitDays => 'روز';

  @override
  String get snapshots => 'عکس‌ها';

  @override
  String get snapNow => 'یکی بگیر';

  @override
  String get addCover => 'افزودن کاور';

  @override
  String get addTodayWidget => 'وضعیت امروز';

  @override
  String get photosCard => 'عکس‌های تو';

  @override
  String get handleLabel => 'نام کاربری';

  @override
  String get setupTitle => 'این‌ها را پر کن تا بقیه صفحه خودش پر شود';

  @override
  String get setupHint => 'هر عدد اینجا از چیزی که ثبت می‌کنی می‌آید. جایی فرستاده نمی‌شود.';

  @override
  String get setupWorkout => 'اولین تمرینت را ثبت کن';

  @override
  String get setupWeight => 'وزن بدنت را بنویس';

  @override
  String get setupMeasures => 'اندازه‌گیری‌هایت را بگیر';

  @override
  String get setupPhoto => 'اولین عکس پیشرفتت را بگیر';

  @override
  String get progressTitle => 'پیشرفت';

  @override
  String get tileVolume30 => 'حجم · ۳۰ر';

  @override
  String get tileAddWeight => 'وزنت را اضافه کن';

  @override
  String get heatToneTitle => 'رنگ نقشه';

  @override
  String get heatToneHint => 'فقط نحوه رنگ‌آمیزی شبکه و بدن را عوض می‌کند.';

  @override
  String get thisWeekTitle => 'این هفته';

  @override
  String get momentsEmptyTitle => 'هنوز چیزی اینجا نیست';

  @override
  String get deletePhotoTitle => 'این عکس حذف شود؟';

  @override
  String get deletePhotoBody => 'برای همیشه پاک می‌شود.';

  @override
  String get awardsEarned => 'گرفته‌شده';

  @override
  String get awardsLocked => 'قفل';

  @override
  String get awardStreak100Name => 'صد روز';

  @override
  String get awardWorkouts10Name => 'ده تمرین';

  @override
  String get awardWorkouts10Line => 'ده تای اول همان‌هایی‌اند که کار را جدی می‌کنند.';

  @override
  String get awardWorkouts365Name => 'سیصد و شصت و پنج';

  @override
  String get awardWorkouts365Line => 'یک تمرین برای هر روز سال، یکی‌یکی ثبت‌شده.';

  @override
  String get awardTonnes10Name => 'ده تن';

  @override
  String get awardTonnes10Line => 'ده هزار کیلو از دستانت گذشته.';

  @override
  String get awardHours100Name => 'صد ساعت';

  @override
  String get awardHours100Line => 'صد ساعت زیر میله، کرونومتر در دست.';

  @override
  String awardWonOn(String date) {
    return 'گرفته‌شده در $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'طلایی',
      'blue': 'آبی',
      'green': 'سبز',
      'other': 'نشان',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'از $date';
  }

  @override
  String levelShort(int n) {
    return 'سطح $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمرین تا سطح $next',
      one: '۱ تمرین تا سطح $next',
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
      'ember': 'اخگر',
      'green': 'سبز',
      'blue': 'آبی',
      'mono': 'خاکستری',
      'other': 'رنگ',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n ست';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n از $goal این هفته';
  }

  @override
  String momentCount(int n) {
    return '$n عکس';
  }

  @override
  String photosSelected(int n) {
    return '$n انتخاب شده';
  }

  @override
  String deletePhotosTitle(int n) {
    return '$n عکس حذف شود؟';
  }

  @override
  String get momentsEmptyHint =>
      'از باشگاه، وایت‌بورد، چیدمان وزنه عکس بگیر — هرچه می‌خواهی یادت بماند. روی گوشی می‌مانند و فقط تو می‌بینی‌شان.';

  @override
  String get awardStreak100Line => 'صد روز پشت‌سرهم. دیگر انگیزه نیست، خودتی.';

  @override
  String get coverLabel => 'کاور';

  @override
  String get removeCover => 'حذف کاور';

  @override
  String get startTitle => 'شروع تمرین';

  @override
  String get logTitle => 'ثبت تمرین';

  @override
  String get logHint => 'بدون تایمر — فقط آنچه کردی را پر کن.';

  @override
  String get orStartFrom => 'یا شروع کن از';

  @override
  String get pickExercisesOption => 'انتخاب حرکات';

  @override
  String get chooseFocusOption => 'انتخاب تمرکز';

  @override
  String get plannedRoutine => 'طبق برنامه';

  @override
  String get logWorkoutAction => 'ثبت تمرین';

  @override
  String get logging => 'در حال ثبت';

  @override
  String get placesLabel => 'مکان‌های من';

  @override
  String get undo => 'برگردان';

  @override
  String get deleteSet => 'حذف ست';

  @override
  String get setDeleted => 'ست حذف شد';

  @override
  String get removeWarmup => 'حذف گرم‌کردن';

  @override
  String get addWeightAction => 'افزودن وزن';

  @override
  String get workoutOverview => 'این تمرین';

  @override
  String get allExercisesShort => 'همه';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total ست';
  }

  @override
  String get nowLabel => 'الان';

  @override
  String get deleteWorkout => 'حذف تمرین';

  @override
  String get deleteWorkoutBody => 'این تمرین و همه ست‌هایش از تاریخچه‌ات حذف می‌شوند.';

  @override
  String get themeAuto => 'خودکار';

  @override
  String get themeAutoHint => 'از گوشی‌ات پیروی می‌کند';

  @override
  String get demoSizeTitle => 'دموی حرکت هنگام تمرین';

  @override
  String get demoLarge => 'بزرگ';

  @override
  String get demoSmall => 'کوچک';

  @override
  String get demoOff => 'پنهان';

  @override
  String get demoLoopTitle => 'انیمیشن نمایش';

  @override
  String get demoLoopAlways => 'تکرار پیوسته';

  @override
  String get demoLoopShort => '۱۰ ثانیه';

  @override
  String get demoLoopHint =>
      'حدود ۱۰ ثانیه پخش می‌شود و روی حالت شروع می‌ایستد. برای دیدن دوباره، روی نمایش بزنید.';

  @override
  String get alarmStyleTitle => 'وقتی استراحت تمام شد';

  @override
  String get alarmStyleLoud => 'همیشه زنگ بزن';

  @override
  String get alarmStyleQuiet => 'پیروی از حالت بی‌صدا';

  @override
  String get alarmStyleVibrate => 'فقط لرزش';

  @override
  String get alarmStyleHint =>
      'همیشه زنگ بزن از حجم آلارم استفاده می‌کند، حتی در بی‌صدا. پیروی از بی‌صدا از حجم اعلان استفاده می‌کند و وقتی گوشی بی‌صداست فقط می‌لرزد.';

  @override
  String get suggestedPicks => 'پیشنهادی برای تو';

  @override
  String get moreOptions => 'گزینه‌های بیشتر';

  @override
  String get suggestInWorkouts => 'پیشنهاد در تمرین‌های سریع';

  @override
  String get suggestInWorkoutsHint =>
      'اگر خاموش باشد در پیشنهادهایی که برایت می‌آید نشان داده نمی‌شود. هنوز می‌توانی دستی اضافه‌اش کنی.';

  @override
  String get onbPlaceTitle => 'کجا تمرین می‌کنی؟';

  @override
  String get onbPlaceWhy =>
      'هر جایی که تمرین می‌کنی را انتخاب کن. فقط چیزهایی را پیشنهاد می‌دهیم که آنجا می‌توانی بزنی.';

  @override
  String get onbPlaceGear => 'آنجا چه داری؟';

  @override
  String distanceCol(String unit) {
    return 'مسافت ($unit)';
  }

  @override
  String get timeCol => 'زمان';

  @override
  String get timeMinutesTitle => 'زمان (دقیقه)';

  @override
  String get timeSecondsTitle => 'زمان (ثانیه)';

  @override
  String distanceTitle(String unit) {
    return 'مسافت ($unit)';
  }

  @override
  String get holdLabel => 'نگه‌داشتن';

  @override
  String get stopLabel => 'توقف';

  @override
  String startHold(String time) {
    return 'شروع · $time';
  }

  @override
  String get exerciseTypeLabel => 'ثبت بر اساس';

  @override
  String get typeReps => 'تکرار و وزن';

  @override
  String get typeTime => 'زمان';

  @override
  String get typeCardio => 'مسافت و زمان';

  @override
  String get exerciseTypeHint =>
      'کاردیو مثل دویدن یا شنا مسافت و زمان ثبت می‌کند. نگه‌داشتن مثل پلانک فقط زمان.';

  @override
  String get howToLabel => 'نحوه اجرا (اختیاری)';

  @override
  String get howToHint => 'هر خط یک گام';

  @override
  String get editExercise => 'ویرایش حرکت';

  @override
  String get saveChanges => 'ذخیره تغییرات';

  @override
  String get noStepsYet => 'هنوز گامی نیست. مال خودت را بنویس تا یادت بماند چطور می‌زنی.';

  @override
  String get addSteps => 'نوشتن گام‌ها';

  @override
  String get setTypeRestPause => 'رست-پاز';

  @override
  String get setTypeNormalInfo => 'یک ست معمولی. در حجم و رکوردهایت حساب می‌شود.';

  @override
  String get setTypeWarmupInfo => 'ست‌های سبک برای گرم شدن. در حجم و رکوردها حساب نمی‌شوند.';

  @override
  String get setTypeDropInfo => 'بلافاصله بعد از ست، وزنه را کم کن و بدون استراحت ادامه بده.';

  @override
  String get setTypeFailureInfo =>
      'ادامه بده تا جایی که دیگر یک تکرار تمیز هم ممکن نباشد. تکرارهایی را که واقعاً زدی ثبت کن.';

  @override
  String get setTypeRestPauseInfo => 'بعد از ست ۱۰ تا ۲۰ ثانیه استراحت کن، بعد چند تکرار دیگر بزن.';

  @override
  String get planFormatNotes =>
      'نام حرکات را دقیقاً همان‌طور که در فهرست آمده استفاده کن. «sets»، «reps»، «weight» (با واحد داده‌شده)، «rest» به ثانیه و «days» اختیاری‌اند. «superset»: true یک حرکت را به بعدی وصل می‌کند. برای چند هفته، روتین‌ها را داخل «weeks» مثل مثال دوم گروه‌بندی کن.';

  @override
  String get planSets => 'برنامه ست‌ها';

  @override
  String get planSetsHint =>
      'نوع، تکرار و وزن هر ست را انتخاب کن. وزن را روی خودکار بگذار تا از آخرین جلسه تمرینت شروع شود.';

  @override
  String get planHintReps => 'نوع و تکرار هر ست را انتخاب کن. «خودکار» از آخرین جلسه‌ات شروع می‌کند.';

  @override
  String get planHintTime => 'نوع و زمان هر ست را انتخاب کن. «خودکار» از آخرین جلسه‌ات شروع می‌کند.';

  @override
  String get planHintTimeWeight =>
      'نوع، زمان و وزن هر ست را انتخاب کن. «خودکار» از آخرین جلسه‌ات شروع می‌کند.';

  @override
  String get planHintCardio => 'مسافت و زمان هر ست را انتخاب کن. «خودکار» از آخرین جلسه‌ات شروع می‌کند.';

  @override
  String get timeOnly => 'فقط زمان';

  @override
  String get autoValue => 'خودکار';

  @override
  String get clearPlan => 'پاک کردن برنامه';

  @override
  String get shareRoutine => 'اشتراک روتین';

  @override
  String get shareWeek => 'اشتراک هفته‌ام';

  @override
  String get shareWeekHint => 'همه روتین‌هایت و روز هر کدام.';

  @override
  String shareMessage(String name) {
    return '$name — فایل را با Gymo باز کن تا اضافه‌اش کند.';
  }

  @override
  String get importRoutines => 'وارد کردن روتین‌ها';

  @override
  String get importPasteHint => 'اینجا یک روتین پیست کن: یکی که از Gymo اشتراک شده، جواب AI، JSON یا CSV.';

  @override
  String get pasteAction => 'پیست';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n روتین', one: '۱ روتین');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'زمان‌بندی هفتگی‌اش را هم استفاده کن';

  @override
  String get useTheirScheduleHint => 'روزهایی که می‌آورد جایگزین آنچه روی آن‌ها برنامه‌ریزی کرده‌ای می‌شود.';

  @override
  String get addToMyRoutines => 'افزودن به روتین‌هایم';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روتین اضافه شد',
      one: '۱ روتین اضافه شد',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'اینجا چیزی نیست که Gymo بتواند وارد کند';

  @override
  String get aiStepCopy => 'درخواست را کپی کن. فهرست حرکاتت و فرمتی که Gymo می‌خواند را همراه دارد.';

  @override
  String get aiStepAsk => 'آن را در هر AI پیست کن و بگو چه می‌خواهی: روز در هفته، هدف، چند هفته.';

  @override
  String get aiStepPaste => 'جوابش را پایین پیست کن و وارد کن. نیازی به فایل نیست.';

  @override
  String get copyForAi => 'کپی برای AI';

  @override
  String get copiedDone => 'کپی شد';

  @override
  String get aiPasteHint => 'جواب AI را اینجا پیست کن';

  @override
  String get importAction => 'وارد کردن';

  @override
  String get showFormat => 'دیدن فرمت';

  @override
  String get shareAsFile => 'اشتراک به‌عنوان فایل';

  @override
  String get recoveryTab => 'ریکاوری';

  @override
  String recoveryOverall(int pct) {
    return 'بدن $pct٪ ریکاوری شده';
  }

  @override
  String get recoveryAllFresh => 'همه‌چیز ریکاوری شده. روز خوبی برای تمرین هر چیزی.';

  @override
  String recoveryStill(String muscles) {
    return 'هنوز در ریکاوری: $muscles';
  }

  @override
  String get recoveryTired => 'خسته';

  @override
  String get recoveryFresh => 'آماده';

  @override
  String get recoveryHint =>
      'یک عضله را لمس کن تا ببینی چقدر ریکاوری شده. ست‌های اخیر تأثیر بیشتری دارند، و سخت‌ترها (بر اساس RPE) بیشتر.';

  @override
  String recoveryPct(int pct) {
    return '$pct٪ ریکاوری';
  }

  @override
  String readyInHours(int h) {
    return 'حدود $h ساعت دیگر آماده';
  }

  @override
  String get tplAbcd => 'چهار روز: سینه و پشت‌بازو، پشت و جلو‌بازو، پا، شانه و شکم.';

  @override
  String get tplAbcde => 'پنج روز، هر کدام یک گروه عضلانی: سینه، پشت، پا، شانه، بازو.';

  @override
  String get elapsedCaps => 'گذشته';

  @override
  String get tapToSkip => 'لمس برای رد کردن';

  @override
  String get screenLocked => 'صفحه قفل است';

  @override
  String get lockedHint => 'اثر انگشت بالای صفحه را فشار بده و نگه‌دار تا باز شود';

  @override
  String get liveDoneSet => 'ست انجام شد';

  @override
  String get liveSkipRest => 'رد کردن استراحت';

  @override
  String get livePause => 'توقف';

  @override
  String get liveResume => 'ادامه';

  @override
  String get liveNext => 'بعدی';

  @override
  String liveUpNext(String name) {
    return 'بعدی: $name';
  }

  @override
  String get stickerOpen => 'اشتراک روی عکس';

  @override
  String get stickerNoPhoto => 'بدون عکس';

  @override
  String get stickerWorkout => 'تمرین';

  @override
  String get stickerStreak => 'استریک';

  @override
  String get stickerDate => 'تاریخ';

  @override
  String get stickerHint => 'بکش تا جابه‌جا شود، با دو انگشت اندازه یا چرخش را عوض کن';

  @override
  String get stickerSaved => 'در گالری ذخیره شد';

  @override
  String get stickerWeek => 'این هفته';

  @override
  String get getReady => 'آماده شو';

  @override
  String get stickerGallery => 'گالری';

  @override
  String get stickerCamera => 'دوربین';

  @override
  String get shareIntroTitle => 'اشتراک این روتین';

  @override
  String get shareIntroBody =>
      'برای پارتنر، دوست یا خانواده‌ات بفرست. یک فایل کوچک می‌گیرند که در Gymo باز می‌شود و با یک ضربه اضافه‌اش می‌کند، با ست‌ها و وزن‌ها.';

  @override
  String get removedFromRoutine => 'از روتین حذف شد';

  @override
  String get radarTitle => '۳۰ روز اخیر';

  @override
  String get radarHint => 'ببین کدام نواحی کار بیشتری می‌خواهند';

  @override
  String get radarEmpty => 'چند روز تمرین کنید تا تعادلتان را ببینید';

  @override
  String get radarBalanced => 'تا اینجا تعادل خوب است';

  @override
  String radarFocus(String list) {
    return 'بیشتر کار می‌خواهد: $list';
  }

  @override
  String get countdownReady => 'آماده شو';

  @override
  String get countdownSkip => 'لمس برای شروع الان';

  @override
  String get countdownSetting => 'شمارش معکوس قبل از شروع';

  @override
  String get effortSetting => 'ثبت تلاش در هر ست';

  @override
  String get effortHint =>
      'RPE: ۱۰ یعنی دیگر نمی‌توانی، ۸ یعنی دو تکرار مانده. RIR تکرارهای مانده را می‌شمارد. وقتی ستی آن را دارد، تخمین 1RM از جدول RPE استفاده می‌کند.';

  @override
  String get rirHint => '۰ یعنی دیگر نمی‌توانی، ۲ یعنی دو تکرار مانده.';

  @override
  String get addWeekWidget => 'افزودن ویجت هفته';

  @override
  String get gamificationSetting => 'مدال‌ها و سطوح';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n تکرار', one: '۱ تکرار');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'بهترین ست';

  @override
  String get weekStartSetting => 'شروع هفته';

  @override
  String get stepOutOfWorkout => 'مکث و خروج';

  @override
  String get saveToRoutine => 'ذخیره تغییرات در روتین';

  @override
  String get routineUpdated => 'روتین به‌روز شد';

  @override
  String saveChangesTitle(String name) {
    return 'تغییرات «$name» ذخیره شود؟';
  }

  @override
  String get saveChangesBody => 'دفعه بعد که شروعش کنی، روتین این تغییرات را خواهد داشت.';

  @override
  String get routineOrderChanged => 'ترتیب جدید حرکات';

  @override
  String get mineOnly => 'ساخته خودت';

  @override
  String createNamed(String name) {
    return 'اینجا نیست؟ «$name» را بساز';
  }

  @override
  String get orStartWith => 'یا شروع با';

  @override
  String get warmupFocus => 'گرم کردن';

  @override
  String get warmupFocusHint => 'تحرک و فعال‌سازی، با وسیله یا بدون آن';

  @override
  String get cardioFocus => 'کاردیو';

  @override
  String get cardioFocusHint => 'دویدن، دوچرخه، روئینگ یا طناب، بر اساس مسافت و زمان';

  @override
  String get homeRecommended => 'پیشنهادی در خانه';

  @override
  String get homeRoutines => 'روتین‌ها در خانه';

  @override
  String get homeRoutinesHint => 'روتین‌هایت، آخرین انجام‌شده اول. روی یکی بزن تا شروع شود.';

  @override
  String get homeWeekStats => 'این هفته در خانه';

  @override
  String get homeWeekStatsHint => 'حجم، ست‌ها و رکوردهای هفته.';

  @override
  String get routineDoneToday => 'برای امروز تمام شد · عالی بود';

  @override
  String get trainAgain => 'دوباره تمرین کن';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روز پیش',
      one: 'دیروز انجام شد',
      zero: 'امروز انجام شد',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'بایگانی';

  @override
  String get archiveExercise => 'بایگانی حرکت';

  @override
  String get restoreExercise => 'بازگردانی';

  @override
  String get archivedToast => 'حرکت بایگانی شد';

  @override
  String get archivedToastHint => 'پیدایش کن در حرکات › بایگانی';

  @override
  String get archivedBanner => 'بایگانی شده. در فهرست‌ها و پیشنهادها نمی‌آید؛ تاریخچه‌ات می‌ماند.';

  @override
  String get videoMarksHint => 'روی یک گام مکث کن و سنجاق را بزن تا دفعه بعد همان‌جا بروی.';

  @override
  String get videoMarkHere => 'این گام را همین‌جا علامت بزن';

  @override
  String get sectionGeneral => 'عمومی';

  @override
  String get sectionTraining => 'تمرین';

  @override
  String get sectionAlerts => 'یادآوری و زنگ';

  @override
  String get sectionHome => 'خانه';

  @override
  String get sectionWidgets => 'ویجت‌ها';

  @override
  String get sectionData => 'داده و بکاپ';

  @override
  String get multiPlanSetting => 'چند روتین در روز';

  @override
  String get multiPlanHint => 'هر روتین این روز را لمس کن. به ترتیبی که اضافه می‌کنی می‌آیند.';

  @override
  String routineOfDay(int n, int total) {
    return '$n از $total امروز';
  }

  @override
  String get nextToday => 'بعدی امروز';

  @override
  String get planAboutMe => 'درباره من:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex، $age ساله، قد $height، وزن $weight.';
  }

  @override
  String planDays(int n) {
    return 'می‌خواهم هفته‌ای $n روز تمرین کنم.';
  }

  @override
  String get planNoHistory =>
      'هنوز تمرینی ثبت نشده: من را مبتدی حساب کن و حجم و وزن‌ها را محافظه‌کارانه نگه دار.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمرین در ۳۰ روز اخیر ثبت شده.',
      one: '۱ تمرین در ۳۰ روز اخیر ثبت شده.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'بهترین ست‌های اخیر';

  @override
  String get planAskFirst =>
      'اگر هدفم (قدرت، عضله، چربی‌سوزی یا آمادگی عمومی) یا مدت هر جلسه را نمی‌دانی، اول در یک پیام کوتاه بپرس. وقتی داشتی، فقط با JSON جواب بده.';

  @override
  String get backToTop => 'بازگشت به بالا';

  @override
  String get deleteExerciseTitle => 'این حرکت حذف شود؟';

  @override
  String deleteExerciseBody(String name) {
    return '«$name» از کتابخانه و روتین‌های شما حذف می‌شود. ست‌های قبلی‌تان باقی می‌مانند.';
  }

  @override
  String get exportForStravaHint =>
      'آن را در مرورگر از strava.com/upload/select بارگذاری کنید (اپ Strava نمی‌تواند فایل وارد کند). به‌صورت «تمرین با وزنه» همراه با ست‌هایتان نمایش داده می‌شود.';

  @override
  String get manualStartTime => 'زمان شروع';

  @override
  String get manualDuration => 'مدت';

  @override
  String get manualDurationUnset => 'افزودن مدت';

  @override
  String get stravaRow => 'خروجی به Strava (بتا)';

  @override
  String get stravaBeta => 'بتا';

  @override
  String get stravaIntro =>
      'یک تمرین انتخاب کنید تا به Strava ببرید. یک فایل ‎.fit‎ دریافت می‌کنید: آن را در مرورگر از strava.com/upload/select بارگذاری کنید تا به‌صورت «تمرین با وزنه» همراه با ست‌هایتان نمایش داده شود.';

  @override
  String get stravaEmpty => 'هنوز تمرینی برای خروجی نیست.';

  @override
  String get tapToPause => 'برای توقف موقت لمس کنید';

  @override
  String get holdPausedHint => 'متوقف شده · برای ادامه لمس کنید';

  @override
  String get finishHoldNow => 'همین حالا ست را تمام کن';

  @override
  String get barWeightExercise => 'وزن هالتر یا سورتمه';

  @override
  String get barWeightHint => 'در ماشین‌حساب صفحه‌ها استفاده می‌شود';

  @override
  String get barWeightCustom => 'وزن شما · برای بازنشانی لمس کنید';

  @override
  String get groupRename => 'تغییر نام گروه';

  @override
  String get groupUngroup => 'حذف گروه، نگه‌داشتن روتین‌ها';

  @override
  String get groupDeleteAll => 'حذف گروه و روتین‌ها';

  @override
  String groupDeleteTitle(String name) {
    return '«$name» حذف شود؟';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count حذف می‌شود. سابقهٔ تمرین‌هایت باقی می‌ماند.';
  }

  @override
  String get tplRr =>
      'روتین کلاسیک r/bodyweightfitness: کل بدن، سه روز در هفته. وقتی آسان شد یک پله بالاتر برو.';

  @override
  String get levelUpKicker => 'قدم بعدی';

  @override
  String levelUpBody(int reps, String name) {
    return 'دو تمرین پشت سر هم ۳×$reps در $name. آماده‌ی قدم بعدی هستی؟';
  }

  @override
  String levelUpSwap(String routine) {
    return 'جایگزین کن در $routine';
  }

  @override
  String get levelUpSee => 'ببین چطور انجام می‌شود';

  @override
  String get levelUpLater => 'الان نه';

  @override
  String get levelUpStay => 'همین را نگه می‌دارم';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name حالا در $routine است';
  }

  @override
  String get levelUpStayed => 'دیگر برای این حرکت پیشنهاد پیشرفت نمی‌دهیم';

  @override
  String get levelHintsSetting => 'پیشنهاد قدم بعدی';

  @override
  String get heatmapLabelsSetting => 'روزها و ماه‌ها روی نقشهٔ فعالیت';

  @override
  String get rmPercent => 'درصد';

  @override
  String rmAtPercent(String pct) {
    return '$pct از حداکثر تو';
  }

  @override
  String get copyWorkout => 'کپی به‌صورت متن';

  @override
  String get goalSet => 'یک هدف بگذار';

  @override
  String get goalTargetReps => 'تکرارهای هدف';

  @override
  String goalToGo(String value) {
    return '$value مانده';
  }

  @override
  String get goalReached => 'به هدف رسیدی';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n روز مانده', one: '۱ روز مانده');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'تاریخ گذشته';

  @override
  String get goalDeadline => 'مهلت';

  @override
  String get goalNoDeadline => 'بدون مهلت';

  @override
  String get goalRemove => 'حذف هدف';

  @override
  String get exerciseNameMissing => 'یک نام بگذارید';

  @override
  String get aliasesLabel => 'نام‌های دیگر (اختیاری)';

  @override
  String get aliasesHint => 'نام‌های دیگر، با کاما جدا شوند';

  @override
  String alsoCalled(String names) {
    return 'نام دیگر: $names';
  }

  @override
  String get addToRoutine => 'افزودن به روتین';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'در $n روتین',
      one: 'در ۱ روتین',
      zero: 'هنوز در هیچ روتینی نیست',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'از قبل هست';

  @override
  String get restInRoutine => 'استراحت در این روتین';

  @override
  String get restInRoutineHint => 'همان استراحت حرکت';

  @override
  String get restInRoutineReset => 'فقط اینجا · برای حذف بزنید';

  @override
  String get swapExercise => 'تعویض حرکت';

  @override
  String get swapShort => 'تعویض';

  @override
  String swapHint(String name) {
    return 'به‌جای $name، فقط امروز. در پایان می‌توانید آن را در روتین نگه دارید.';
  }

  @override
  String get swapKeepsDone => 'ست‌های انجام‌شده می‌مانند؛ حرکت جدید بقیه را ادامه می‌دهد.';

  @override
  String swapSameMuscle(String muscle) {
    return 'همان عضله · $muscle';
  }

  @override
  String get swapDoneBefore => 'قبلاً انجام داده‌اید';

  @override
  String get multiPlanSettingHint => 'بیش از یک روتین در یک روز هفته.';

  @override
  String get levelHintsHint => 'وقتی حرکتی آسان شد، نسخهٔ سخت‌ترش را پیشنهاد می‌کند.';

  @override
  String get focusCardHint => 'روتین امروز، بالای صفحهٔ خانه.';

  @override
  String get gamificationHint => 'مدال‌ها، سطح شما و جشن پایان تمرین.';

  @override
  String get exerciseSettings => 'تنظیمات این حرکت';

  @override
  String get placeActiveNow => 'اینجا هستید';

  @override
  String get placeTapToUse => 'برای تمرین اینجا بزنید';

  @override
  String get intervalDays => 'روز';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target روز';
  }

  @override
  String get toolNameRpe => 'وزنه بر اساس RPE';

  @override
  String get toolTitleRpe => 'وزنه بر اساس RPE';

  @override
  String get toolDescRpe => 'چه وزنی برای فشار دلخواه';

  @override
  String get toolNameDots => 'سطح قدرت';

  @override
  String get toolTitleDots => 'سطح قدرت (DOTS)';

  @override
  String get toolDescDots => 'قدرت شما نسبت به وزنتان';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'برای $reps تکرار با RPE $rpe';
  }

  @override
  String get rpeYourSet => 'ستی که همین الان زدید';

  @override
  String get rpeGoal => 'کاری که می‌خواهید بکنید';

  @override
  String rpeOneRmLine(String value) {
    return '۱RM تخمینی: $value';
  }

  @override
  String get rpeExplain => 'RPE ۱۰ یعنی یک تکرار دیگر نمی‌شد؛ ۸ یعنی دو تکرار مانده بود.';

  @override
  String get dotsBestLifts => 'بهترین رکوردهای شما';

  @override
  String get dotsSquat => 'اسکوات';

  @override
  String get dotsBench => 'پرس سینه';

  @override
  String get dotsDeadlift => 'ددلیفت';

  @override
  String dotsTotalLine(String value) {
    return 'مجموع: $value';
  }

  @override
  String get dotsExplain =>
      'قدرت شما را با هر کسی، با هر وزنی، مقایسه می‌کند. بهترین تک‌تکرار یا ۱RM تخمینی‌تان را بزنید.';

  @override
  String get dotsLevel0 => 'مبتدی';

  @override
  String get dotsLevel1 => 'متوسط';

  @override
  String get dotsLevel2 => 'پیشرفته';

  @override
  String get dotsLevel3 => 'خیلی پیشرفته';

  @override
  String get dotsLevel4 => 'نخبه';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'امتیاز Wilks';

  @override
  String get toolDescWilks => 'امتیاز کلاسیک پاورلیفتینگ';

  @override
  String get wilksExplain =>
      'فرمول کلاسیک پاورلیفتینگ. DOTS در ۲۰۲۰ جایگزینش شد، اما هنوز بسیاری از مسابقات و رده‌بندی‌ها از آن استفاده می‌کنند.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'شاخص توده بدون چربی';

  @override
  String get toolDescFfmi => 'چقدر عضله نسبت به قدت داری';

  @override
  String get ffmiBodyFat => 'چربی بدن';

  @override
  String ffmiLeanLine(String value) {
    return 'توده بدون چربی: $value';
  }

  @override
  String get ffmiExplain =>
      'مثل BMI، اما بدون چربی: فقط توده بدون چربی‌ات را حساب می‌کند. بر اساس قد تنظیم شده تا افراد بلند و کوتاه منصفانه مقایسه شوند.';

  @override
  String get ffmiLevel0 => 'زیر میانگین';

  @override
  String get ffmiLevel1 => 'میانگین';

  @override
  String get ffmiLevel2 => 'بالای میانگین';

  @override
  String get ffmiLevel3 => 'عالی';

  @override
  String get ffmiLevel4 => 'استثنایی';

  @override
  String get rpeEffortLabel => 'فشار (RPE)';

  @override
  String get restRowHint => 'بین ست‌ها، اگر حرکت زمان خودش را ندارد.';

  @override
  String get effortRowHint => 'در هر ست RPE یا RIR ثبت کنید.';

  @override
  String get countdownHint => '۳، ۲، ۱ قبل از اولین ست.';

  @override
  String get keepScreenOnHint => 'صفحه هنگام تمرین خاموش نمی‌شود.';

  @override
  String get demoSizeRowHint => 'تصویر حرکت هنگام تمرین.';

  @override
  String get demoLoopRowHint => 'انیمیشن تکرار شود یا بایستد.';

  @override
  String get trainReminderRowHint => 'یادآوری در روزهای تمرین.';

  @override
  String get alarmSoundRowHint => 'صدایی که پایان استراحت پخش می‌شود.';

  @override
  String get alarmStyleRowHint => 'آیا در حالت بی‌صدا زنگ بزند.';

  @override
  String get recommendedRowHint => 'حرکت‌هایی که در خانه پیشنهاد می‌دهیم.';

  @override
  String get weightStepSetting => 'گام وزن';

  @override
  String get weightStepHint => 'مقداری که دکمه‌های − و + اضافه می‌کنند.';

  @override
  String get prBestWorkout => 'بهترین تمرین';

  @override
  String get mergeExercise => 'ادغام';

  @override
  String mergeExerciseInto(String name) {
    return 'ادغام $name با…';
  }

  @override
  String get mergeExerciseTitle => 'حرکات ادغام شوند؟';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'تمام سابقهٔ «$from» به «$to» منتقل می‌شود. «$from» در کتابخانه‌ات می‌ماند. این کار برگشت‌پذیر نیست.';
  }

  @override
  String get mergedToast => 'سابقه ادغام شد';
}
