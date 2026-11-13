// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get languageName => 'اردو';

  @override
  String vsLastMonthLabel(String pct) {
    return 'پچھلے مہینے کے مقابلے میں $pct%';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'لیول $level · $streak';
  }

  @override
  String get save => 'محفوظ کرو';

  @override
  String get cancel => 'منسوخ';

  @override
  String get cancelCaps => 'منسوخ';

  @override
  String get deleteCaps => 'حذف کرو';

  @override
  String get done => 'ہو گیا';

  @override
  String get set => 'سیٹ';

  @override
  String get home => 'ہوم';

  @override
  String get progress => 'پیش رفت';

  @override
  String get exercises => 'ورزشیں';

  @override
  String get settings => 'ترتیبات';

  @override
  String get today => 'آج';

  @override
  String get thisWeek => 'اس ہفتے';

  @override
  String get recommended => 'تجویز کردہ';

  @override
  String get goal => 'ہدف';

  @override
  String get volume => 'حجم';

  @override
  String get setsToday => 'آج کے سیٹ';

  @override
  String get prs => 'ریکارڈ';

  @override
  String get todaysFocus => 'آج کی توجہ';

  @override
  String get todaysRoutine => 'آج کی روٹین';

  @override
  String get startWorkout => 'ورزش شروع کرو';

  @override
  String get routines => 'روٹینز';

  @override
  String get tools => 'اوزار';

  @override
  String get firstSessionHint => 'اپنے پٹھے چنو اور اپنا پہلا سیشن درج کرو';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ورزشیں', one: '$n ورزش');
    return '$_temp0';
  }

  @override
  String get pushDay => 'پُش ڈے';

  @override
  String get pullDay => 'پُل ڈے';

  @override
  String get legDay => 'ٹانگوں کا دن';

  @override
  String get pushFocus => 'سینہ · کندھے · ٹرائسیپس';

  @override
  String get pullFocus => 'کمر · بائسیپس · ٹریپس';

  @override
  String get legFocus => 'کواڈز · ہیمسٹرنگز · کولہے';

  @override
  String get train => 'ٹریننگ';

  @override
  String get step1 => 'مرحلہ 1 از 2';

  @override
  String get step2 => 'مرحلہ 2 از 2';

  @override
  String get chooseFocus => 'اپنی توجہ چنو';

  @override
  String get buildSession => 'اپنا سیشن بناؤ';

  @override
  String get tapMuscles => 'جن پٹھوں کی ٹریننگ کرنی ہے ان پر ٹیپ کرو، آگے اور پیچھے۔';

  @override
  String get continueBtn => 'جاری رکھو';

  @override
  String get nothingForFocus => 'اس توجہ کے لیے ابھی کچھ نہیں';

  @override
  String get goBackPick => 'واپس جاؤ اور ایسا پٹھا چنو جس کی ورزشیں تمہاری لائبریری میں ہوں۔';

  @override
  String pickedHint(int n) {
    return 'ہم نے تمہارے لیے ایک سیشن چن لیا ہے۔ $n میں سے کسی کو شامل یا ہٹانے کے لیے ٹیپ کرو۔';
  }

  @override
  String get pickAnExercise => 'ایک ورزش چنو';

  @override
  String get searchAllExercises => 'کوئی بھی ورزش تلاش کرو…';

  @override
  String get noExercisesMatch => 'کوئی ورزش نہیں ملی';

  @override
  String get createItInstead => 'اسے اپنی ورزش کے طور پر بنا لو';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ورزشیں', one: '$n ورزش');
    return 'شروع · $_temp0';
  }

  @override
  String get inProgress => 'جاری ہے';

  @override
  String get paused => 'رکا ہوا';

  @override
  String get last => 'پچھلی بار';

  @override
  String get rest => 'آرام';

  @override
  String get skip => 'چھوڑو';

  @override
  String get addSet => '+ سیٹ شامل کرو';

  @override
  String get finishSession => 'سیشن ختم کرو';

  @override
  String get setDone => 'سیٹ مکمل';

  @override
  String get nextExercise => 'اگلی ورزش';

  @override
  String get dropExerciseAction => 'ورزش ہٹاؤ';

  @override
  String get restOff => 'بند';

  @override
  String get miniRest => 'ریسٹ پاز اور کلسٹر آرام';

  @override
  String get miniRestHint => 'ریسٹ پاز یا کلسٹر سیٹ سے پہلے';

  @override
  String get gymPass => 'جم پاس';

  @override
  String get gymPassEmpty => 'اپنے جم کا کوڈ یہاں رکھو اور کارڈ کے بغیر اندر جاؤ';

  @override
  String get gymPassAdd => 'پاس شامل کرو';

  @override
  String get gymPassScan => 'کوڈ کی تصویر لو';

  @override
  String get gymPassScanHint => 'اپنے فون کے کیمرے سے';

  @override
  String get gymPassPhoto => 'تصویر یا اسکرین شاٹ سے';

  @override
  String get gymPassPhotoHint => 'مثلاً تمہارے جم کی ایپ کا اسکرین شاٹ';

  @override
  String get gymPassType => 'نمبر لکھو';

  @override
  String get gymPassTypeHint => 'بارکوڈ کے لیے: اس کے نیچے چھپا نمبر';

  @override
  String get gymPassNotFound => 'اس تصویر میں کوئی QR کوڈ نہیں۔ زیادہ صاف تصویر آزماؤ یا نمبر لکھو۔';

  @override
  String get gymPassName => 'جم کا نام';

  @override
  String get gymPassDefaultName => 'میرا جم';

  @override
  String get gymPassCode => 'کوڈ';

  @override
  String get gymPassFormat => 'کوڈ کی قسم';

  @override
  String get gymPassInvalid => 'یہ نمبر اس کوڈ کی قسم سے میل نہیں کھاتا';

  @override
  String get gymPassShowHint => 'اسے ریڈر کے سامنے رکھو۔ روشنی خود بڑھ جاتی ہے۔';

  @override
  String get gymPassDeleted => 'پاس حذف ہو گیا';

  @override
  String get gymPassEdit => 'پاس میں ترمیم کرو';

  @override
  String get gymPassShow => 'دروازے پر دکھاؤ';

  @override
  String get gymPassPrivate => 'صرف تمہارے فون پر رہتا ہے۔ کچھ بھی اپلوڈ نہیں ہوتا۔';

  @override
  String get gymPassColor => 'رنگ';

  @override
  String get gymPassRescan => 'کوڈ دوبارہ پڑھو';

  @override
  String get gymPassReading => 'کوڈ پڑھا جا رہا ہے…';

  @override
  String get gymPassSettingHint => 'تمہارے پروفائل میں تمہارا جم کارڈ';

  @override
  String get gymPassMember => 'ممبر';

  @override
  String get widgetHintActivity => 'ٹریننگ والے دنوں کا تمہارا نقشہ';

  @override
  String get widgetHintStats => 'اس ہفتے کا سلسلہ، حجم اور سیشن';

  @override
  String get widgetHintBody => 'جن پٹھوں پر تم نے کام کیا';

  @override
  String get widgetHintToday => 'ایک نظر میں: کیا آج ٹریننگ کی؟';

  @override
  String get widgetHintWeek => 'تمہارے ہفتے کا منصوبہ، دن بہ دن';

  @override
  String get supportHintBug => 'GitHub پر بتاؤ کیا خراب ہوا';

  @override
  String get supportHintFeature => 'ایپ کے لیے کوئی خیال تجویز کرو';

  @override
  String get supportHintStar => 'زیادہ لوگوں کو اسے ڈھونڈنے میں مدد دیتا ہے';

  @override
  String get supportHintCoffee => 'ترقی میں مدد کرتا ہے۔ مفت اور اشتہارات کے بغیر';

  @override
  String get bodyweightNoteHint => 'نوٹ شامل کرو: کیسا محسوس ہو رہا ہے، کیا آزمایا جا رہا ہے… (اختیاری)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'اس ورزش کے لیے $unit استعمال کرو';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'ریپس';

  @override
  String weightCol(String unit) {
    return 'وزن ($unit)';
  }

  @override
  String get repsTitle => 'ریپس';

  @override
  String weightTitle(String unit) {
    return 'وزن ($unit)';
  }

  @override
  String get sessionComplete => 'ورزش درج ہو گئی';

  @override
  String get finishHeadlinePr => 'نیا ذاتی ریکارڈ';

  @override
  String get finishHeadlineGoal => 'ہفتہ وار ہدف پورا';

  @override
  String get finishHeadlineStreak => 'سلسلہ جاری ہے';

  @override
  String get finishHeadlineDefault => 'ایک اور جمع ہو گیا';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs ورزشوں', one: 'ایک ورزش');
    return 'تم نے $_temp0 میں پہلے سے زیادہ اٹھایا۔ اب یہ تمہارے ریکارڈ میں ہے۔';
  }

  @override
  String get finishBodyGoal => 'تم نے اس ہفتے کے طے شدہ سیشن پورے کر لیے۔';

  @override
  String finishBodyStreak(int streak) {
    return 'لگاتار $streak دن۔ مشکل کام رکنا نہیں ہے۔';
  }

  @override
  String get finishBodyDefault => 'درج اور شمار ہو گیا۔ مستقل مزاجی ہی نمبر بدلتی ہے۔';

  @override
  String get vsLastTime => 'پچھلی بار کے مقابلے میں';

  @override
  String get firstTime => 'پہلی بار درج';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نئے ریکارڈ',
      one: '$n نیا ریکارڈ',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'دورانیہ';

  @override
  String get setsCaps => 'سیٹ';

  @override
  String exerciseXofY(int i, int n) {
    return 'ورزش $i از $n';
  }

  @override
  String get decrease => 'کم کرو';

  @override
  String get increase => 'بڑھاؤ';

  @override
  String markSet(int n) {
    return 'سیٹ $n کو مکمل نشان زد کرو';
  }

  @override
  String get pauseWorkout => 'ورزش روکو';

  @override
  String get resumeWorkout => 'ورزش جاری رکھو';

  @override
  String get discardTitle => 'ورزش ضائع کرو؟';

  @override
  String get discardBody => 'اس سیشن کے تمہارے سیٹ ضائع ہو جائیں گے۔';

  @override
  String get keepTraining => 'ٹریننگ جاری رکھو';

  @override
  String get discard => 'ضائع کرو';

  @override
  String get notifRestChannel => 'آرام کا ٹائمر';

  @override
  String get notifRestChannelWhy => 'سیٹوں کے درمیان آرام ختم ہونے پر بتاتا ہے';

  @override
  String get notifAlertChannel => 'آرام کا ٹائمر (الرٹ)';

  @override
  String get notifAlertChannelWhy => 'آرام ختم ہوتے ہی ایک بینر دکھاتا ہے';

  @override
  String get restOverTitle => 'آرام ختم';

  @override
  String get restOverBody => 'واپس آؤ، اگلا سیٹ انتظار کر رہا ہے۔';

  @override
  String get allTimeSessions => 'سیشن';

  @override
  String get allTimeTime => 'وقت';

  @override
  String get allTimeSets => 'سیٹ';

  @override
  String get consistency => 'مستقل مزاجی';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n سیشن درج', one: '$n سیشن درج');
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n دن کا سلسلہ';
  }

  @override
  String get bodyweight => 'جسمانی وزن';

  @override
  String get logBodyweight => 'جسمانی وزن درج کرو';

  @override
  String get trackWeight => 'وقت کے ساتھ اپنے وزن پر نظر رکھو';

  @override
  String get muscleMap => 'پٹھوں کا نقشہ';

  @override
  String get days7 => '7 دن';

  @override
  String get days30 => '30 دن';

  @override
  String get days90 => '90 دن';

  @override
  String get days365 => '1 سال';

  @override
  String get daysAll => 'سب';

  @override
  String get weeklyAvgTitle => 'ہفتہ وار اوسط';

  @override
  String weekOfDate(String date) {
    return '$date کا ہفتہ';
  }

  @override
  String weightChangeRange(String change) {
    return 'اس عرصے میں $change';
  }

  @override
  String get heatLow => 'اچھوتا';

  @override
  String get heatHigh => 'پورا حجم';

  @override
  String get muscleMapEmpty => 'ایک سیشن درج کرو اور تمہارا جسم یہاں روشن ہونے لگے گا۔';

  @override
  String get muscleMapHint => 'کسی پٹھے پر ٹیپ کر کے دیکھو اسے کیا ملا۔';

  @override
  String muscleMapBehind(String names) {
    return 'پیچھے رہ رہے ہیں: $names';
  }

  @override
  String ofTarget(int pct) {
    return 'ہدف کا $pct%';
  }

  @override
  String get muscleSplit => 'پٹھوں کی تقسیم';

  @override
  String get personalRecords => 'ذاتی ریکارڈ';

  @override
  String get strength1rm => 'طاقت · اندازاً 1RM';

  @override
  String get strengthEmpty => 'کوئی ورزش دو بار درج کرو اور اس کی طاقت کا خط یہاں نظر آئے گا۔';

  @override
  String oneRmEst(String w) {
    return 'اندازاً 1RM $w';
  }

  @override
  String get restDayShort => 'آرام کا دن';

  @override
  String get restDay => 'آرام کا دن، کچھ درج نہیں۔';

  @override
  String get delete => 'حذف کرو';

  @override
  String get deleteEntry => 'یہ اندراج حذف کرو؟';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" اس دن سے، اور تمہارے ریکارڈ اور چارٹس سے ہٹا دیا جائے گا۔';
  }

  @override
  String get bodyweightHistory => 'تاریخچہ';

  @override
  String get exercisesCaps => 'ورزشیں';

  @override
  String get timeCaps => 'وقت';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تمہاری لائبریری میں $n ورزشیں',
      one: 'تمہاری لائبریری میں $n ورزش',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'ورزشیں تلاش کرو';

  @override
  String get muscleFilter => 'پٹھا';

  @override
  String get levelFilter => 'لیول';

  @override
  String get kindLabel => 'قسم';

  @override
  String get kindStrength => 'طاقت';

  @override
  String get kindCalisthenics => 'کیلستھینکس';

  @override
  String get kindCardio => 'کارڈیو';

  @override
  String get kindStretch => 'اسٹریچنگ';

  @override
  String get newExercise => 'نئی ورزش';

  @override
  String get exerciseName => 'ورزش کا نام';

  @override
  String get equipmentLabel => 'سامان';

  @override
  String get addExercise => 'ورزش شامل کرو';

  @override
  String get advanced => 'ایڈوانسڈ';

  @override
  String get demoMedia => 'ڈیمو';

  @override
  String get addMedia => 'میڈیا شامل کرو';

  @override
  String get mediaHint => 'تصویر، GIF یا ویڈیو';

  @override
  String get changeMedia => 'بدلو';

  @override
  String get videoSelected => 'ویڈیو منتخب';

  @override
  String get favouritesOnly => 'پسندیدہ';

  @override
  String get noFavouritesYet => 'ابھی کوئی پسندیدہ نہیں';

  @override
  String get noFavouritesHint => 'کسی ورزش کو یہاں رکھنے کے لیے اس کے ستارے پر ٹیپ کرو۔';

  @override
  String get clearFilters => 'فلٹر صاف کرو';

  @override
  String get quickAddAmount => 'تم نے کتنا لیا';

  @override
  String get homeCardsTitle => 'ہوم کارڈز';

  @override
  String get homeCardsHint => 'جو آن ہوگا وہ ہوم میں نظر آئے گا';

  @override
  String get homeCardFocus => 'آج';

  @override
  String get homeCardSteps => 'قدم';

  @override
  String get homeCardWeek => 'اس ہفتے';

  @override
  String get homeCardRoutines => 'روٹینز';

  @override
  String get homeCardRecommended => 'تجویز کردہ';

  @override
  String get textSizeSetting => 'متن کا سائز';

  @override
  String get textSizeSmall => 'چھوٹا';

  @override
  String get textSizeNormal => 'عام';

  @override
  String get textSizeLarge => 'بڑا';

  @override
  String get textSizeHint => 'تمہارے فون کے متن کے سائز کے اوپر';

  @override
  String get calmMotionSetting => 'حرکت کم کرو';

  @override
  String get calmMotionHint => 'اسکرینیں سلائیڈ ہوئے بغیر نظر آتی ہیں';

  @override
  String get dishArchive => 'آرکائیو';

  @override
  String get dishUnarchive => 'بحال کرو';

  @override
  String get dishArchivedToast => 'ڈش آرکائیو ہو گئی';

  @override
  String get filterShowLabel => 'دکھاؤ';

  @override
  String get noExercisesFound => 'کوئی ورزش نہیں ملی';

  @override
  String get noExercisesHint => 'کوئی اور تلاش آزماؤ یا اپنے فلٹر صاف کرو۔';

  @override
  String get personalRecord => 'ذاتی ریکارڈ';

  @override
  String get history => 'تاریخچہ';

  @override
  String get noHistory => 'ابھی کوئی سیشن درج نہیں۔ تاریخچہ بنانے کے لیے یہ ورزش کرو۔';

  @override
  String get notes => 'نوٹس';

  @override
  String get notePlaceholder => 'اشارے، سیٹ اپ، کیسا لگا…';

  @override
  String notHere(String gear, String place) {
    return '$place میں $gear نہیں';
  }

  @override
  String get notHereWhy => 'اسے کسی ایسی چیز سے بدلو جس پر آج واقعی وزن ڈال سکو۔';

  @override
  String get altHere => 'یہاں کیا کیا جا سکتا ہے';

  @override
  String get places => 'میری جگہیں';

  @override
  String get placesHint =>
      'بتاؤ ہر جگہ تمہارے پاس کیا ہے اور لائبریری صرف وہی دکھائے گی جو وہاں واقعی ممکن ہو۔';

  @override
  String get placeAll => 'کہیں بھی';

  @override
  String get placeNew => 'نئی جگہ';

  @override
  String get placeNamePlaceholder => 'گھر، جم، پارک…';

  @override
  String get placeGearLabel => 'وہاں کیا ہے';

  @override
  String placeExercises(int n) {
    return 'یہاں $n ورزشیں';
  }

  @override
  String get placeEmptyTitle => 'جہاں بھی ہو ٹریننگ کرو';

  @override
  String get placeEmptyBody =>
      'جگہ وہاں موجود تمہارے سامان کی فہرست ہے۔ شروع کرنے کے لیے ایک چنو اور بعد میں ترمیم کرو۔';

  @override
  String get placeDeleteTitle => 'جگہ حذف کرو';

  @override
  String get placeDeleteBody => 'صرف جگہ جائے گی۔ تمہاری ورزشیں اور سیشن رہیں گے۔';

  @override
  String get placeGym => 'جم';

  @override
  String get placeHome => 'گھر';

  @override
  String get placeOutdoors => 'باہر';

  @override
  String get placeFilterLabel => 'جگہ';

  @override
  String get noGearOnly => 'سامان کے بغیر';

  @override
  String placeActive(String name) {
    return '$name میں ٹریننگ';
  }

  @override
  String get journal => 'روزنامچہ';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نوٹس',
      one: '1 نوٹ',
      zero: 'کوئی نوٹ نہیں',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'نوٹ';

  @override
  String get noteKindPlan => 'منصوبہ';

  @override
  String get noteKindDone => 'کامیابی';

  @override
  String get noteKindPain => 'ہلکا درد';

  @override
  String get noteFilterAll => 'سب';

  @override
  String get newNote => 'نیا نوٹ';

  @override
  String get editNote => 'نوٹ میں ترمیم کرو';

  @override
  String get addNote => 'نوٹ شامل کرو';

  @override
  String get noteEmptyTitle => 'ابھی کچھ نہیں لکھا';

  @override
  String get noteEmptyBody => 'اشارے، اگلی بار کے منصوبے، سیشن کیسا لگا۔ چاہو تو تصاویر یا ویڈیو کے ساتھ۔';

  @override
  String get noteNoneForExercise => 'اس ورزش پر ابھی کوئی نوٹ نہیں۔';

  @override
  String get noteKindLabel => 'قسم';

  @override
  String get noteTextLabel => 'نوٹ';

  @override
  String get noteDateLabel => 'تاریخ';

  @override
  String get noteExerciseLabel => 'ورزش';

  @override
  String get noteMediaLabel => 'تصاویر اور ویڈیو';

  @override
  String get noteGeneral => 'کوئی ورزش نہیں';

  @override
  String get noteAttach => 'منسلک کرو';

  @override
  String get noteRemoveMedia => 'منسلکہ ہٹاؤ';

  @override
  String get deleteNoteTitle => 'نوٹ حذف کرو';

  @override
  String get deleteNoteBody => 'نوٹ اور اس سے منسلک ہر چیز ہمیشہ کے لیے چلی جائے گی۔';

  @override
  String get noteToday => 'آج';

  @override
  String get noteYesterday => 'کل';

  @override
  String get noteAllNotes => 'تمام نوٹس';

  @override
  String get noteCalendar => 'کیلنڈر';

  @override
  String get noteNoneOnDay => 'اس دن کچھ نہیں لکھا';

  @override
  String get noteAddOnDay => 'اس دن پر نوٹ';

  @override
  String get notePrevMonth => 'پچھلا مہینہ';

  @override
  String get noteNextMonth => 'اگلا مہینہ';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'اس مہینے $n نوٹس',
      one: 'اس مہینے 1 نوٹ',
      zero: 'اس مہینے کوئی نوٹ نہیں',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'پیمائشیں';

  @override
  String get measuresHint => 'گردن سے پنڈلی تک: صرف بار نہیں، اپنے جسم کو بدلتے دیکھو۔';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n پیمائشیں',
      one: '1 پیمائش',
      zero: 'کچھ درج نہیں',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'ابھی درج نہیں';

  @override
  String get measureHistory => 'تاریخچہ';

  @override
  String get measureNeck => 'گردن';

  @override
  String get measureShoulders => 'کندھے';

  @override
  String get measureChest => 'سینہ';

  @override
  String get measureArm => 'بازو';

  @override
  String get measureForearm => 'ساعد';

  @override
  String get measureWaist => 'کمر';

  @override
  String get measureHips => 'کولہے';

  @override
  String get measureThigh => 'ران';

  @override
  String get measureCalf => 'پنڈلی';

  @override
  String get measureBodyfat => 'جسمانی چربی';

  @override
  String get timeline => 'ٹائم لائن';

  @override
  String get hidePhotos => 'تصاویر چھپاؤ';

  @override
  String get showPhotos => 'تصاویر دکھاؤ';

  @override
  String get timelineHint => 'وہی انداز، وہی جگہ، وہی روشنی۔ ایک سال میں تمہیں یقین نہیں آئے گا۔';

  @override
  String get timelineEmptyTitle => 'تمہاری پہلی تصویر گھڑی چلا دیتی ہے';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تصاویر',
      one: '1 تصویر',
      zero: 'کوئی تصویر نہیں',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'سامنے';

  @override
  String get poseSide => 'پہلو';

  @override
  String get poseBack => 'پیچھے';

  @override
  String get photoEvery => 'مجھے یاد دلاؤ';

  @override
  String photoEveryDays(int n) {
    return 'ہر $n دن';
  }

  @override
  String get photoEveryOff => 'کبھی نہیں';

  @override
  String get timelineEvery => 'گروپ بندی ہر';

  @override
  String get custom => 'اپنی مرضی';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'اگلی تصویر $n دن میں',
      one: 'اگلی تصویر کل',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'تصویر کا وقت: آج لے لو';

  @override
  String get addTodayPhotos => 'آج کی تصاویر شامل کرو';

  @override
  String posePhoto(String pose) {
    return '$pose کی تصویر';
  }

  @override
  String get compare => 'موازنہ';

  @override
  String get compareNeedTwo => 'تمہاری اگلی تصویر یہاں پہلے اور بعد دکھائے گی۔';

  @override
  String dayNumber(int n) {
    return 'دن $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n دن کا فرق',
      one: '1 دن کا فرق',
      zero: 'ایک ہی دن',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'یہ دن حذف کرو';

  @override
  String get deleteDayBody => 'اس کی تصاویر بھی ہمیشہ کے لیے چلی جائیں گی۔';

  @override
  String get timelinePhotos => 'تصاویر';

  @override
  String get timelineBody => 'پٹھوں کا نقشہ';

  @override
  String get timelineBodyEmpty =>
      'ایک سیشن درج کرو اور تمہارا پٹھوں کا نقشہ یہاں بھرنے لگے گا، تصاویر کی ضرورت نہیں۔';

  @override
  String get timelineBodyHint => 'تمہارے اپنے سیٹوں سے بنا، اپلوڈ کرنے کو کچھ نہیں۔';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n سیشن',
      one: '1 سیشن',
      zero: 'کوئی سیشن نہیں',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'پیش رفت کی تصاویر';

  @override
  String get notifPhotoChannelWhy => 'جب تمہاری اگلی پیش رفت کی تصویر کا وقت ہو تو ایک یاد دہانی۔';

  @override
  String get notifPhotoTitle => 'پیش رفت کی تصویر کا وقت';

  @override
  String notifPhotoBody(int n) {
    return 'پچھلی کے بعد $n دن۔ وہی انداز، وہی روشنی۔';
  }

  @override
  String get share => 'شیئر کرو';

  @override
  String get sharePick => 'کیا دکھانا ہے؟';

  @override
  String get shareStreak => 'سلسلہ اور مستقل مزاجی';

  @override
  String get shareBody => 'جن پٹھوں پر کام ہوا';

  @override
  String get shareCompare => 'پہلے اور بعد';

  @override
  String get shareHint => 'کارڈ تمہارے فون پر بنتا ہے۔ جب تک تم جگہ نہ چنو کچھ باہر نہیں جاتا۔';

  @override
  String get shareFailed => 'کارڈ نہیں بن سکا';

  @override
  String get shareWeekOf => 'پچھلے 7 دن';

  @override
  String get shareStreakLabel => 'دن کا سلسلہ';

  @override
  String get shareSessionsLabel => 'سیشن';

  @override
  String get shareVolumeLabel => 'حجم';

  @override
  String get restForExercise => 'اس ورزش کے لیے آرام';

  @override
  String get restUsingDefault => 'تمہارا ڈیفالٹ استعمال ہو رہا ہے';

  @override
  String get restCustom => 'صرف اس کے لیے';

  @override
  String get setType => 'سیٹ کی قسم';

  @override
  String get setTypeNormal => 'ورکنگ';

  @override
  String get setTypeWarmup => 'وارم اپ';

  @override
  String get setTypeDrop => 'ڈراپ سیٹ';

  @override
  String get setTypeFailure => 'ناکامی تک';

  @override
  String get addWarmup => 'وارم اپ';

  @override
  String platesPerSide(String plates) {
    return 'ہر طرف: $plates';
  }

  @override
  String get howTo => 'طریقہ';

  @override
  String get similar => 'ملتی جلتی';

  @override
  String get primaryLabel => 'بنیادی';

  @override
  String get secondaryLabel => 'ثانوی';

  @override
  String get none => 'کوئی نہیں';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n سیٹ', one: '$n سیٹ');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v حجم';
  }

  @override
  String get weeklyPlan => 'ہفتہ وار منصوبہ';

  @override
  String get yourRoutines => 'تمہاری روٹینز';

  @override
  String get noRoutines => 'ابھی کوئی روٹین نہیں۔ ایک بناؤ اور اپنی ورزشیں شامل کرو۔';

  @override
  String get newRoutine => 'نئی روٹین';

  @override
  String get routineName => 'روٹین کا نام';

  @override
  String get schedule => 'شیڈول';

  @override
  String get addFromList => 'نیچے کی فہرست سے ورزشیں شامل کرو۔';

  @override
  String get addExercises => 'ورزشیں شامل کرو';

  @override
  String get deleteRoutine => 'یہ روٹین حذف کرو؟';

  @override
  String exercisesWithCount(int n) {
    return 'ورزشیں · $n';
  }

  @override
  String setDay(String day) {
    return '$day مقرر کرو';
  }

  @override
  String get newRoutineName => 'نئی روٹین';

  @override
  String get dragToReorder => 'ترتیب بدلنے کے لیے نقطوں والا ہینڈل کھینچو، یہی ٹریننگ کی ترتیب ہے۔';

  @override
  String reorderHandle(String name) {
    return '$name کی ترتیب بدلو';
  }

  @override
  String get removeFromRoutine => 'روٹین سے ہٹاؤ';

  @override
  String get dropExercise => 'یہ ورزش ہٹاؤ؟';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" اس ورزش سے نکل جائے گی۔ درج کی ہوئی کوئی چیز ضائع نہیں ہوگی۔';
  }

  @override
  String get drop => 'ہٹاؤ';

  @override
  String get resetData => 'میرا سارا ڈیٹا حذف کرو';

  @override
  String get resetTitle => 'سب کچھ حذف کرو؟';

  @override
  String get resetBody =>
      'سیشن، ریکارڈ، روٹینز، نوٹس اور پروفائل۔ اسے واپس نہیں کیا جا سکتا: اگر شاید ضرورت پڑے تو پہلے بیک اپ ایکسپورٹ کرو۔';

  @override
  String get resetConfirm => 'سب کچھ حذف کرو';

  @override
  String get resetDone => 'سارا ڈیٹا حذف ہو گیا';

  @override
  String get support => 'مدد';

  @override
  String get reportBug => 'خرابی کی اطلاع دو';

  @override
  String get requestFeature => 'فیچر کی درخواست کرو';

  @override
  String get starOnGithub => 'GitHub پر اسٹار دو';

  @override
  String get buyCoffee => 'مجھے کافی پلاؤ';

  @override
  String get cantOpenLink => 'لنک نہیں کھل سکا';

  @override
  String get theme => 'تھیم';

  @override
  String get darkTheme => 'گہرا';

  @override
  String get lightTheme => 'ہلکا';

  @override
  String get amoledTheme => 'AMOLED سیاہ';

  @override
  String get editDuration => 'ورزش کا دورانیہ';

  @override
  String get sessionName => 'ورزش کا نام';

  @override
  String get nameWorkout => 'نام دو';

  @override
  String get sessionNameHint => 'مثلاً ٹانگیں، پُش، پورا جسم';

  @override
  String get secondaryPickHint => 'دوسرے پٹھوں پر ٹیپ کرو جن پر یہ ورزش کام کرتی ہے۔';

  @override
  String get languageLabel => 'زبان';

  @override
  String get unitsLabel => 'اکائیاں';

  @override
  String get restTimer => 'آرام کا ٹائمر';

  @override
  String get alarmBlockedTitle => 'اطلاعات بند ہیں';

  @override
  String get alarmBlockedBody => 'اسکرین لاک ہونے پر آرام کا الارم نہیں بجے گا';

  @override
  String get alarmBlockedAction => 'آن کرو';

  @override
  String get alarmSound => 'الارم کی آواز';

  @override
  String get alarmDefaultName => 'ڈیفالٹ';

  @override
  String get alarmSoundHint => 'اپنی آواز استعمال کرو، 15 سیکنڈ تک';

  @override
  String get alarmChoose => 'آواز چنو…';

  @override
  String get alarmPreview => 'موجودہ آواز چلاؤ';

  @override
  String get alarmReset => 'ڈیفالٹ پر واپس';

  @override
  String get alarmTooLong => 'یہ آواز 15 سیکنڈ سے لمبی ہے';

  @override
  String get alarmInvalid => 'یہ آڈیو فائل نہیں پڑھی جا سکی';

  @override
  String alarmChanged(String name) {
    return 'الارم کی آواز \"$name\" مقرر ہو گئی';
  }

  @override
  String get alarmChangedDefault => 'ڈیفالٹ آواز پر واپس';

  @override
  String get addActivityWidget => 'سرگرمی کا ویجٹ شامل کرو';

  @override
  String get addStatsWidget => 'اعداد و شمار کا ویجٹ شامل کرو';

  @override
  String get pinUnsupported => 'اسے اپنے لانچر کے ویجٹ مینو سے شامل کرو';

  @override
  String get background => 'پس منظر';

  @override
  String get bgNone => 'کوئی نہیں';

  @override
  String get bgDots => 'نقطے';

  @override
  String get bgGrid => 'جالی';

  @override
  String get exportCsv => 'ورزشیں ایکسپورٹ کرو (CSV)';

  @override
  String get exportBackup => 'بیک اپ ایکسپورٹ کرو (ZIP)';

  @override
  String get importBackup => 'بیک اپ امپورٹ کرو';

  @override
  String get importHint =>
      'GymMane سے ایکسپورٹ کیا ہوا ‎.zip (یا پرانا ‎.json) بیک اپ چنو۔ یہ تمہارے موجودہ ڈیٹا کو، میڈیا سمیت، بدل دے گا۔';

  @override
  String get import => 'امپورٹ';

  @override
  String get chooseFile => 'فائل چنو';

  @override
  String get importFromApp => 'کسی اور ایپ سے امپورٹ کرو';

  @override
  String get importUnknownFormat => 'اس فائل میں تاریخ، ورزش، ریپس اور وزن کے کالم ہونے چاہئیں';

  @override
  String get importZipNoWeights => 'اس zip میں وزن کی کوئی فائل نہیں';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n وزن امپورٹ ہوئے',
      one: '$n وزن امپورٹ ہوا',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'یہ فائل نہیں پڑھی جا سکی';

  @override
  String get importUnitTitle => 'یہ فائل کس اکائی میں ہے؟';

  @override
  String get importUnitBody => 'یہ ایکسپورٹ نہیں بتاتا کہ وزن کس اکائی میں ہیں۔';

  @override
  String get importNothing => 'امپورٹ کرنے کو کچھ نیا نہیں';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n سیشن امپورٹ ہوئے',
      one: '$n سیشن امپورٹ ہوا',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'GymMane کے بارے میں';

  @override
  String get yourProfile => 'تمہارا پروفائل';

  @override
  String get autofills => 'کیلکولیٹرز خود بھرتا ہے';

  @override
  String get onbUnitsWhy => 'وزن، پیمائشوں اور فاصلوں کے لیے۔ ترتیبات میں کبھی بھی بدلا جا سکتا ہے۔';

  @override
  String get nameLabel => 'نام';

  @override
  String get sexLabel => 'جنس';

  @override
  String get macroProtein => 'پروٹین';

  @override
  String get macroCarbs => 'کاربز';

  @override
  String get macroFat => 'چربی';

  @override
  String get male => 'مرد';

  @override
  String get female => 'عورت';

  @override
  String get ageLabel => 'عمر';

  @override
  String get heightLabel => 'قد';

  @override
  String get weightLabel => 'وزن';

  @override
  String get weeklyGoal => 'ہفتہ وار ہدف';

  @override
  String get activityLabel => 'سرگرمی';

  @override
  String get addPhoto => 'تصویر شامل کرو';

  @override
  String get removePhoto => 'تصویر ہٹاؤ';

  @override
  String get takePhoto => 'تصویر لو';

  @override
  String get chooseGallery => 'گیلری سے چنو';

  @override
  String get backupImported => 'بیک اپ امپورٹ ہو گیا';

  @override
  String get backupFailed => 'یہ بیک اپ نہیں پڑھا جا سکا';

  @override
  String get nothingToExport => 'ابھی ایکسپورٹ کرنے کو کچھ نہیں: پہلے ایک سیشن درج کرو';

  @override
  String calculatorsCount(int n) {
    return 'تمہاری ٹریننگ کے لیے $n کیلکولیٹرز';
  }

  @override
  String get result => 'نتیجہ';

  @override
  String get weightLifted => 'اٹھایا گیا وزن';

  @override
  String get repsPerformed => 'کیے گئے ریپس';

  @override
  String get neck => 'گردن';

  @override
  String get waist => 'کمر';

  @override
  String get hip => 'کولہے (خواتین کے لیے)';

  @override
  String get targetWeight => 'ہدف وزن';

  @override
  String get workingWeight => 'ورکنگ وزن';

  @override
  String get activityLevel => 'سرگرمی کی سطح';

  @override
  String get barWeight => 'بار کا وزن';

  @override
  String get perSide => 'ہر طرف';

  @override
  String get justTheBar => 'صرف بار۔';

  @override
  String perSideCount(int n) {
    return '× $n ہر طرف';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'کیلوریز';

  @override
  String get toolNameBf => 'جسمانی چربی';

  @override
  String get toolNamePlate => 'پلیٹیں';

  @override
  String get toolNameWarmup => 'وارم اپ';

  @override
  String get toolTitleRm => '1RM کیلکولیٹر';

  @override
  String get toolTitleBmi => 'BMI کیلکولیٹر';

  @override
  String get toolTitleCal => 'کیلوریز اور میکروز';

  @override
  String get toolTitleBf => 'جسمانی چربی %';

  @override
  String get toolTitlePlate => 'پلیٹ کیلکولیٹر';

  @override
  String get toolTitleWarmup => 'وارم اپ سیٹ';

  @override
  String get toolHintRm => 'اندازاً ایک ریپ کا زیادہ سے زیادہ وزن (Epley فارمولا)';

  @override
  String get toolHintCal => 'اندازاً روزانہ برقراری';

  @override
  String get toolHintBf => 'US Navy طریقے کا اندازہ';

  @override
  String get toolHintPlate => 'باربل کا کل وزن';

  @override
  String get toolHintWarmup => 'ورکنگ وزن کا ہدف';

  @override
  String get toolDescRm => 'اندازاً ایک ریپ کا زیادہ سے زیادہ وزن';

  @override
  String get toolDescBmi => 'باڈی ماس انڈیکس';

  @override
  String get toolDescCal => 'کیلوریز اور میکروز';

  @override
  String get toolDescBf => 'جسمانی چربی کا فیصد';

  @override
  String get toolDescPlate => 'باربل پلیٹ کیلکولیٹر';

  @override
  String get toolDescWarmup => 'بتدریج وارم اپ سیٹ';

  @override
  String get bmiUnderweight => 'کم وزن';

  @override
  String get bmiNormal => 'نارمل';

  @override
  String get bmiOverweight => 'زیادہ وزن';

  @override
  String get bmiObese => 'موٹاپا';

  @override
  String get actSedentary => 'بیٹھے رہنے والا';

  @override
  String get actLight => 'ہلکی';

  @override
  String get actActive => 'فعال';

  @override
  String get actModerate => 'درمیانی';

  @override
  String get muscleChest => 'سینہ';

  @override
  String get muscleBack => 'کمر';

  @override
  String get muscleLowerBack => 'نچلی کمر';

  @override
  String get muscleShoulders => 'کندھے';

  @override
  String get muscleBiceps => 'بائسیپس';

  @override
  String get muscleTriceps => 'ٹرائسیپس';

  @override
  String get muscleForearm => 'ساعد';

  @override
  String get muscleTrapezius => 'ٹریپیزیئس';

  @override
  String get muscleAbdomen => 'پیٹ';

  @override
  String get muscleObliques => 'اوبلیکس';

  @override
  String get muscleQuads => 'کواڈز';

  @override
  String get muscleHamstrings => 'ہیمسٹرنگز';

  @override
  String get muscleGlutes => 'کولہے';

  @override
  String get muscleCalves => 'پنڈلیاں';

  @override
  String get mgChest => 'سینہ';

  @override
  String get mgBack => 'کمر';

  @override
  String get mgLegs => 'ٹانگیں';

  @override
  String get mgShoulders => 'کندھے';

  @override
  String get mgArms => 'بازو';

  @override
  String get mgCore => 'کور';

  @override
  String get equipBarbell => 'باربل';

  @override
  String get equipDumbbell => 'ڈمبل';

  @override
  String get equipCable => 'کیبل';

  @override
  String get equipMachine => 'مشین';

  @override
  String get equipBodyweight => 'جسمانی وزن';

  @override
  String get equipWeighted => 'وزن کے ساتھ';

  @override
  String get equipBand => 'بینڈ';

  @override
  String get equipKettlebell => 'کیٹل بیل';

  @override
  String get equipRings => 'رِنگز';

  @override
  String get equipOther => 'دیگر';

  @override
  String get diffBeginner => 'مبتدی';

  @override
  String get diffAdvanced => 'ماہر';

  @override
  String get diffIntermediate => 'درمیانہ';

  @override
  String get about => 'تعارف';

  @override
  String version(String v) {
    return 'ورژن $v';
  }

  @override
  String get aboutBlurb => 'وزن اٹھانے والوں کا بنایا، وزن اٹھانے والوں کے لیے۔';

  @override
  String get freeForever => 'ہمیشہ مفت';

  @override
  String get freeForeverWhy => 'کوئی سبسکرپشن نہیں، کوئی اشتہار نہیں، کچھ بھی پے وال کے پیچھے بند نہیں۔';

  @override
  String get fullyOffline => 'مکمل آف لائن';

  @override
  String get fullyOfflineWhy =>
      'کوئی اکاؤنٹ نہیں، کوئی سرور نہیں۔ تمہاری ٹریننگ کبھی اس فون سے باہر نہیں جاتی۔';

  @override
  String get yoursToTake => 'تمہارا ڈیٹا تمہارا ہے';

  @override
  String get yoursToTakeWhy => 'جب چاہو CSV میں ایکسپورٹ کرو، اور ایک ٹیپ میں سب حذف کرو۔';

  @override
  String get whatsInside => 'اندر کیا ہے';

  @override
  String exercisesInside(int n) {
    return '$n ورزشیں';
  }

  @override
  String get exercisesInsideWhy => 'ہر ایک کے ساتھ اینیمیشن اور مرحلہ وار ہدایات۔';

  @override
  String get calculatorsInside => '10 کیلکولیٹرز';

  @override
  String get calculatorsInsideWhy =>
      '1RM، پلیٹیں، BMI، کیلوریز، جسمانی چربی، FFMI، وارم اپ، RPE وزن، اور DOTS اور Wilks طاقت اسکور، سب شائع شدہ فارمولوں کے ساتھ۔';

  @override
  String get mathInside => 'ایماندار حساب';

  @override
  String get mathInsideWhy => 'حجم، ریکارڈ اور سلسلے تمہارے اپنے سیٹوں سے آتے ہیں۔ یہاں کچھ بھی سجاوٹ نہیں۔';

  @override
  String get streakCaps => 'سلسلہ';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'دن', one: 'دن');
    return '$_temp0';
  }

  @override
  String get reset => 'ری سیٹ';

  @override
  String get welcomeKicker => 'خوش آمدید';

  @override
  String get welcomeBlurb => 'سب کچھ تمہارے فون پر رہتا ہے۔ کوئی اکاؤنٹ نہیں، انٹرنیٹ نہیں، کچھ دینا نہیں۔';

  @override
  String get welcomeStart => 'شروع کرو';

  @override
  String onbStep(int i, int n) {
    return 'مرحلہ $i از $n';
  }

  @override
  String get onbNameTitle => 'ہم تمہیں کیا کہہ کر بلائیں؟';

  @override
  String get onbNameHint => 'تمہارا نام';

  @override
  String get onbPhotoAdd => 'تصویر شامل کرو';

  @override
  String get onbPhotoChange => 'تصویر بدلو';

  @override
  String get onbPhotoTitle => 'اپنے پروفائل کو چہرہ دو';

  @override
  String get onbPhotoWhy => 'اختیاری۔ یہ تمہارے فون پر رہتی ہے اور اپنے پروفائل سے کبھی بھی بدلی جا سکتی ہے۔';

  @override
  String get onbPhotoLater => 'بعد میں';

  @override
  String get onbNameWhy => 'صرف تمہیں سلام کرنے کے لیے۔ یہ کبھی فون سے باہر نہیں جاتا۔';

  @override
  String get onbBodyTitle => 'چند نمبر';

  @override
  String get onbBodyWhy => 'یہ کیلکولیٹرز کو چلاتے ہیں۔ ترتیبات میں کبھی بھی بدلے جا سکتے ہیں۔';

  @override
  String get onbGoalTitle => 'ہفتے میں کتنی بار ٹریننگ ہوتی ہے؟';

  @override
  String get onbGoalWhy => 'تمہارا ہفتہ وار ہدف کا دائرہ مقرر کرتا ہے۔ ایماندار رہو، پرعزم نہیں۔';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'ہفتے میں $n سیشن',
      one: 'ہفتے میں $n سیشن',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'کلو یا پاؤنڈ؟';

  @override
  String get next => 'آگے';

  @override
  String get back => 'پیچھے';

  @override
  String get skip2 => 'چھوڑو';

  @override
  String get madeWithLoveBy => 'محبت سے بنایا';

  @override
  String get sourceCode => 'سورس کوڈ';

  @override
  String get suggested => 'تجویز کردہ';

  @override
  String get results => 'نتائج';

  @override
  String get noMatches => 'اس تلاش سے کوئی ورزش میل نہیں کھاتی۔';

  @override
  String get tapToEdit => 'اندراج درست کرنے کے لیے پنسل پر، یا ہٹانے کے لیے کوڑے دان پر ٹیپ کرو۔';

  @override
  String get editEntry => 'ترمیم';

  @override
  String get editEntryHint => 'کسی بھی سیٹ کے ریپس یا وزن درست کرو۔';

  @override
  String get removeSet => 'سیٹ ہٹاؤ';

  @override
  String get continueWorkout => 'جاری رکھو';

  @override
  String get continueWorkoutBody =>
      'ورزش دوبارہ جاری حالت میں آ جاتی ہے، اپنے سیٹ پہلے سے نشان زد کے ساتھ۔ دوبارہ ختم کرنے پر یہ اپنے اصل دن پر محفوظ ہوتی ہے۔';

  @override
  String get addBodyWidget => 'پٹھوں کے نقشے کا ویجٹ شامل کرو';

  @override
  String get repsOnly => 'صرف ریپس';

  @override
  String get repsOnlyHint => 'یہ ورزش وزن کے بغیر درج کرو۔';

  @override
  String get eachSide => 'ہر طرف';

  @override
  String get eachSideHint => 'ٹائمر ہر طرف کے لیے ایک بار چلتا ہے اور آرام دونوں کے بعد شروع ہوتا ہے۔';

  @override
  String get useDefaultArt => 'ڈیفالٹ تصویر پر واپس';

  @override
  String daysShort(int n) {
    return '$n دن';
  }

  @override
  String get focusCard => 'آج کی توجہ';

  @override
  String get autoAdvance => 'خود بخود آگے بڑھو';

  @override
  String get keepScreenOn => 'ٹریننگ کے دوران اسکرین آن رکھو';

  @override
  String get lockWorkout => 'اسکرین لاک کرو';

  @override
  String get unlockWorkout => 'ان لاک کرو';

  @override
  String get holdToUnlock => 'ان لاک کرنے کے لیے دبائے رکھو';

  @override
  String get liveChannel => 'جاری ورزش';

  @override
  String get liveChannelWhy => 'ٹریننگ کے دوران موجودہ ورزش، سیٹ اور آرام کا ٹائمر دکھاتا ہے';

  @override
  String liveSet(int n, int total) {
    return 'سیٹ $n از $total';
  }

  @override
  String get liveResting => 'آرام';

  @override
  String get liveAllDone => 'تمام سیٹ مکمل';

  @override
  String get autoAdvanceHint => 'آخری سیٹ کے بعد آگے بڑھ جاتا ہے';

  @override
  String get placePlates => 'پلیٹیں اور بار';

  @override
  String get platesAll => 'سب دستیاب';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n سائز', one: '$n سائز');
    return '$_temp0';
  }

  @override
  String get platePairs => 'جوڑے';

  @override
  String plateAchievable(String w) {
    return 'سب سے قریب جو لگایا جا سکتا ہے: $w';
  }

  @override
  String get autoWarmup => 'وارم اپ سیٹ سے شروع کرو';

  @override
  String get autoWarmupHint => 'ورزش کھلنے پر بتدریج سیٹ شامل کرتا ہے۔';

  @override
  String get trainReminder => 'ٹریننگ کی یاد دہانی';

  @override
  String get trainReminderHint => 'اس وقت ایک یاد دہانی، صرف ان دنوں جب تمہاری روٹین طے ہو۔';

  @override
  String get reminderExactTime => 'عین وقت';

  @override
  String get toastSoundSetting => 'اطلاع کی آواز';

  @override
  String get toastSoundHint => 'ہر اطلاع کے ساتھ ہلکی گھنٹی';

  @override
  String get notifTrainChannel => 'ٹریننگ کی یاد دہانی';

  @override
  String get notifTrainChannelWhy => 'طے شدہ دنوں میں ٹریننگ کی یاد دہانی۔';

  @override
  String get notifTrainTitle => 'ٹریننگ کا وقت';

  @override
  String get notifTrainBody => 'تمہاری روٹین انتظار کر رہی ہے۔';

  @override
  String get planIntro => 'صرف اس فہرست کی ورزشیں استعمال کر کے میرے لیے ایک ٹریننگ روٹین بناؤ۔';

  @override
  String get planFormat => 'صرف JSON میں جواب دو، اس شکل میں:';

  @override
  String get planNothing => 'اس فائل کی کوئی ورزش تمہاری لائبریری سے میل نہیں کھاتی';

  @override
  String get planFailed => 'یہ فائل ایسی روٹین نہیں جو ہم پڑھ سکیں';

  @override
  String get routineGroup => 'گروپ';

  @override
  String get newGroup => 'نیا گروپ';

  @override
  String get noGroup => 'کوئی گروپ نہیں';

  @override
  String get groupNameHint => 'پُش / پُل / ٹانگیں، 5×5…';

  @override
  String get filters => 'فلٹرز';

  @override
  String get setsPlannedHint => 'ہر ایک کے کتنے سیٹ چاہئیں چنو۔ ورزش انہیں تیار لے کر کھلتی ہے۔';

  @override
  String get nextTime => 'اگلی بار';

  @override
  String get nextHold => 'ہر ریپ پورا ہونے تک وہی وزن';

  @override
  String get bgPhoto => 'تمہاری تصویر';

  @override
  String get bgPhotoPick => 'تصویر چنو';

  @override
  String get bgPhotoChange => 'تصویر بدلو';

  @override
  String get bgPhotoRemove => 'تصویر ہٹاؤ';

  @override
  String get bgDim => 'کتنا گہرا';

  @override
  String get dimSoft => 'ہلکا';

  @override
  String get dimMedium => 'درمیانہ';

  @override
  String get dimStrong => 'گہرا';

  @override
  String get bgPhotoHint => 'یہ ہر چیز کے پیچھے رہتی ہے، مدھم تاکہ ایپ پڑھنے کے قابل رہے۔';

  @override
  String get reminderSmart => 'سمارٹ';

  @override
  String get reminderFixed => 'مقررہ وقت';

  @override
  String get reminderSmartHint =>
      'یہ ان دنوں اور اس وقت کو استعمال کرتا ہے جب واقعی ٹریننگ ہوتی ہے، اور جس دن ٹریننگ ہو چکی ہو اس دن خاموش رہتا ہے۔';

  @override
  String get reminderSmartEmpty => 'چند اور سیشن درج کرو اور یہ تمہارے دن سیکھ لے گا۔';

  @override
  String habitFocus(String day) {
    return 'جو عام طور پر $day کو ہوتا ہے';
  }

  @override
  String get duplicateRoutine => 'روٹین کی نقل بناؤ';

  @override
  String copySuffix(String name) {
    return '$name (نقل)';
  }

  @override
  String get saveAsRoutine => 'روٹین کے طور پر محفوظ کرو';

  @override
  String get savedAsRoutine => 'روٹین کے طور پر محفوظ ہو گئی';

  @override
  String get templates => 'تیار منصوبے';

  @override
  String get templatesHint => 'کلاسیک پروگرام، تمہاری اپنی لائبریری سے بنے۔ بعد میں کچھ بھی بدلا جا سکتا ہے۔';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روٹینز شامل ہوئیں',
      one: '$n روٹین شامل ہوئی',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'ہفتے میں تین دن پورا جسم۔ شروع کرنے کے لیے یہی۔';

  @override
  String get tplPpl => 'پُش، پُل اور ٹانگیں۔ ہفتے میں تین یا چھ دن۔';

  @override
  String get tplArnold => 'سینہ اور کمر، کندھے اور بازو، ٹانگیں۔ چھ دن کی کلاسیک تقسیم۔';

  @override
  String get tplUpperlower => 'اوپری اور نچلا جسم، ہفتے میں چار دن۔';

  @override
  String get tplStronglifts => 'دو ورزشیں، پانچ کے پانچ سیٹ، باری باری۔';

  @override
  String get tplStartingstrength => 'ہر سیشن میں اسکواٹ، دو باری باری ورزشیں۔';

  @override
  String get tplHome => 'لٹکنے کے لیے ایک بار اور فرش کے سوا کچھ نہیں۔';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n دن', one: '$n دن');
    return '$_temp0';
  }

  @override
  String get logRpe => 'مشقت درج کرو (RPE)';

  @override
  String get rpeHint => '10 مطلب ٹینک میں کچھ نہیں بچا، 8 مطلب دو ریپ باقی ہیں۔';

  @override
  String get superset => 'سپر سیٹ';

  @override
  String get supersetLink => 'اگلی کے ساتھ جوڑو';

  @override
  String get supersetUnlink => 'اگلی سے الگ کرو';

  @override
  String get supersetHint => 'جڑی ہوئی ورزشوں کے درمیان آرام نہیں، سیدھا اگلی پر جاؤ۔';

  @override
  String get aiRoutine => 'AI کے ساتھ روٹین';

  @override
  String get aiIntro =>
      'GymMane کبھی کسی AI سے بات نہیں کرتا۔ اپنی ورزشوں کی فہرست نکالو، جو بھی اسسٹنٹ پہلے سے استعمال میں ہے اس میں پیسٹ کرو، اور اس کا جواب واپس لاؤ۔ کچھ بھی خود بخود فون سے باہر نہیں جاتا۔';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نام تمہاری لائبریری میں نہیں تھے',
      one: '1 نام تمہاری لائبریری میں نہیں تھا',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'یہ کون سی ایپس پڑھتا ہے';

  @override
  String get importOtherCsv => 'کوئی بھی اور CSV جس میں تاریخ، ورزش، ریپس اور وزن ہو';

  @override
  String get importAskApp => 'کوئی اور ایپ چاہیے؟ درخواست کرو';

  @override
  String get awardFirstStepName => 'پہلا قدم';

  @override
  String get awardFirstStepLine => 'GymMane میں خوش آمدید۔ یہ ہماری طرف سے۔';

  @override
  String get awardFirstWorkoutName => 'پہلی ورزش';

  @override
  String get awardFirstWorkoutLine => 'پہلی درج ہو گئی۔ وہی سب سے مشکل ہوتی ہے۔';

  @override
  String get awardFirstRoutineName => 'پہلی روٹین';

  @override
  String get awardFirstRoutineLine => 'تمہارے پاس واپس آنے کے لیے ایک منصوبہ ہے۔';

  @override
  String get awardFirstRecordName => 'پہلا ریکارڈ';

  @override
  String get awardFirstRecordLine => 'کسی ورزش میں تمہارا بہترین وزن ٹوٹ گیا۔';

  @override
  String get awardStreak3Name => 'لگاتار تین';

  @override
  String get awardStreak3Line => 'لگاتار تین دن۔ ایسے ہی شروع ہوتا ہے۔';

  @override
  String get awardTonne1Name => 'ایک ٹن';

  @override
  String get awardTonne1Line => 'تمہارے سیٹوں میں ایک ہزار کلو اٹھایا گیا۔';

  @override
  String get awardSets100Name => 'سو سیٹ';

  @override
  String get awardSets100Line => 'سو سیٹ مکمل، ایک ایک کر کے۔';

  @override
  String get awardHours10Name => 'دس گھنٹے';

  @override
  String get awardHours10Line => 'گھڑی پر دس گھنٹے کی ٹریننگ۔';

  @override
  String get awardWorkouts50Name => 'پچاس ورزشیں';

  @override
  String get awardWorkouts50Line => 'پچاس سیشن پیچھے چھوڑ دیے۔';

  @override
  String get awardHours50Name => 'پچاس گھنٹے';

  @override
  String get awardHours50Line => 'جم کے اندر پچاس گھنٹے۔';

  @override
  String get awardsTitle => 'تمغے';

  @override
  String get yearTitle => 'تمہارا سال';

  @override
  String get yearBestMonth => 'بہترین مہینہ';

  @override
  String get yearMonths => 'مہینے';

  @override
  String get awardSpinHint => 'تمغہ گھمانے کے لیے کھینچو';

  @override
  String get awardUnlocked => 'نئی کامیابی کھل گئی';

  @override
  String get awardNice => 'زبردست!';

  @override
  String get awardSaveImage => 'تصویر محفوظ کرو';

  @override
  String get awardSaved => 'تمہاری گیلری میں محفوظ ہو گئی';

  @override
  String get awardStreak7Name => 'سات دن';

  @override
  String get awardStreak7Line => 'ایک دن چھوڑے بغیر پورا ہفتہ۔';

  @override
  String get awardStreak30Name => 'تیس دن';

  @override
  String get awardStreak30Line => 'لگاتار ایک مہینہ۔ اب یہ عادت ہے۔';

  @override
  String get awardWorkouts100Name => 'سو ورزشیں';

  @override
  String get awardWorkouts100Line => 'سو سیشن درج، شروع سے آخر تک۔';

  @override
  String get awardTonnes100Name => 'سو ٹن';

  @override
  String get awardTonnes100Line => 'جو کچھ تم نے اٹھایا اس کا مجموعہ 100,000 کلو ہے۔';

  @override
  String get awardSets1000Name => 'ایک ہزار سیٹ';

  @override
  String get awardSets1000Line => 'ایک وقت میں ایک سیٹ، ایسے ایک ہزار۔';

  @override
  String get profile => 'پروفائل';

  @override
  String get editProfile => 'پروفائل میں ترمیم کرو';

  @override
  String get pickBadge => 'بیج';

  @override
  String get statWorkouts => 'ورزشیں';

  @override
  String get statTrained => 'ٹریننگ';

  @override
  String get statSets => 'سیٹ';

  @override
  String get statLifted => 'اٹھایا';

  @override
  String get statStreak => 'سلسلہ';

  @override
  String get statDays => 'دن';

  @override
  String get unitHours => 'گھ';

  @override
  String get unitDays => 'دن';

  @override
  String get snapshots => 'تصاویر';

  @override
  String get snapNow => 'ایک لو';

  @override
  String get addCover => 'کور شامل کرو';

  @override
  String get addTodayWidget => 'آج ہوا یا نہیں';

  @override
  String get photosCard => 'تمہاری تصاویر';

  @override
  String get handleLabel => 'یوزر نیم';

  @override
  String get setupTitle => 'یہ بھرو اور باقی صفحہ خود بھر جائے گا';

  @override
  String get setupHint => 'یہاں کا ہر نمبر تمہارے اندراج سے آتا ہے۔ کچھ بھی کہیں نہیں بھیجا جاتا۔';

  @override
  String get setupWorkout => 'اپنی پہلی ورزش درج کرو';

  @override
  String get setupWeight => 'اپنا جسمانی وزن لکھو';

  @override
  String get setupMeasures => 'اپنی پیمائشیں لو';

  @override
  String get setupPhoto => 'پیش رفت کی پہلی تصویر لو';

  @override
  String get progressTitle => 'پیش رفت';

  @override
  String get tileVolume30 => 'حجم · 30 دن';

  @override
  String get tileAddWeight => 'اپنا شامل کرو';

  @override
  String get heatToneTitle => 'حرارت کا رنگ';

  @override
  String get heatToneHint => 'صرف یہ بدلتا ہے کہ جالی اور جسم کیسے رنگے جاتے ہیں۔';

  @override
  String get thisWeekTitle => 'اس ہفتے';

  @override
  String get momentsEmptyTitle => 'یہاں ابھی کچھ نہیں';

  @override
  String get deletePhotoTitle => 'یہ تصویر حذف کرو؟';

  @override
  String get deletePhotoBody => 'یہ ہمیشہ کے لیے چلی جائے گی۔';

  @override
  String get awardsEarned => 'حاصل کیے';

  @override
  String get awardsLocked => 'بند';

  @override
  String get awardStreak100Name => 'سو دن';

  @override
  String get awardWorkouts10Name => 'دس ورزشیں';

  @override
  String get awardWorkouts10Line => 'پہلی دس ہی فیصلہ کرتی ہیں۔';

  @override
  String get awardWorkouts365Name => 'تین سو پینسٹھ';

  @override
  String get awardWorkouts365Line => 'سال کے ہر دن کے لیے ایک ورزش، ایک ایک کر کے درج۔';

  @override
  String get awardTonnes10Name => 'دس ٹن';

  @override
  String get awardTonnes10Line => 'دس ہزار کلو تمہارے ہاتھوں سے گزر چکے ہیں۔';

  @override
  String get awardHours100Name => 'سو گھنٹے';

  @override
  String get awardHours100Line => 'بار کے نیچے سو گھنٹے، ہاتھ میں اسٹاپ واچ۔';

  @override
  String awardWonOn(String date) {
    return '$date کو حاصل کیا';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'سونا',
      'blue': 'نیلا',
      'green': 'سبز',
      'other': 'بیج',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '$date سے';
  }

  @override
  String levelShort(int n) {
    return 'لیول $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'لیول $next تک $n ورزشیں',
      one: 'لیول $next تک 1 ورزش',
    );
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n سم';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'انگارہ',
      'green': 'سبز',
      'blue': 'نیلا',
      'mono': 'سرمئی',
      'other': 'رنگ',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n سیٹ';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return 'اس ہفتے $goal میں سے $n';
  }

  @override
  String momentCount(int n) {
    return '$n تصاویر';
  }

  @override
  String photosSelected(int n) {
    return '$n منتخب';
  }

  @override
  String deletePhotosTitle(int n) {
    return '$n تصاویر حذف کرو؟';
  }

  @override
  String get momentsEmptyHint =>
      'جم، وائٹ بورڈ، پلیٹوں کی ترتیب کی تصویر لو۔ جو بھی یاد رکھنا ہو۔ یہ فون پر رہتی ہیں اور صرف تمہیں نظر آتی ہیں۔';

  @override
  String get awardStreak100Line => 'لگاتار سو دن۔ یہ اب حوصلہ نہیں، یہ تمہاری پہچان ہے۔';

  @override
  String get coverLabel => 'کور';

  @override
  String get removeCover => 'کور ہٹاؤ';

  @override
  String get startTitle => 'ورزش شروع کرو';

  @override
  String get logTitle => 'ورزش درج کرو';

  @override
  String get logHint => 'ٹائمر نہیں، بس جو کیا وہ بھرو۔';

  @override
  String get orStartFrom => 'یا یہاں سے شروع کرو';

  @override
  String get pickExercisesOption => 'ورزشیں چنو';

  @override
  String get chooseFocusOption => 'توجہ چنو';

  @override
  String get plannedRoutine => 'طے شدہ';

  @override
  String get logWorkoutAction => 'ورزش درج کرو';

  @override
  String get logging => 'اندراج';

  @override
  String get placesLabel => 'میری جگہیں';

  @override
  String get undo => 'واپس';

  @override
  String get deleteSet => 'سیٹ حذف کرو';

  @override
  String get setDeleted => 'سیٹ حذف ہو گیا';

  @override
  String get removeWarmup => 'وارم اپ ہٹاؤ';

  @override
  String get addWeightAction => 'وزن شامل کرو';

  @override
  String get workoutOverview => 'یہ ورزش';

  @override
  String get allExercisesShort => 'سب';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total سیٹ';
  }

  @override
  String get nowLabel => 'ابھی';

  @override
  String get deleteWorkout => 'ورزش حذف کرو';

  @override
  String get deleteWorkoutBody => 'یہ ورزش اور اس کے تمام سیٹ تمہارے تاریخچے سے ہٹا دیے جائیں گے۔';

  @override
  String get themeAuto => 'خودکار';

  @override
  String get themeAutoHint => 'تمہارے فون کے مطابق';

  @override
  String get demoSizeTitle => 'ٹریننگ کے دوران ورزش کا ڈیمو';

  @override
  String get demoLarge => 'بڑا';

  @override
  String get demoSmall => 'چھوٹا';

  @override
  String get demoOff => 'چھپا ہوا';

  @override
  String get demoLoopTitle => 'ڈیمو اینیمیشن';

  @override
  String get demoLoopAlways => 'لوپ';

  @override
  String get demoLoopShort => '10 سیکنڈ';

  @override
  String get demoLoopHint =>
      'تقریباً 10 سیکنڈ چلتی ہے اور شروع کے انداز پر رک جاتی ہے۔ دوبارہ دیکھنے کے لیے ڈیمو پر ٹیپ کرو۔';

  @override
  String get alarmStyleTitle => 'آرام ختم ہونے پر';

  @override
  String get alarmStyleLoud => 'ہمیشہ بجے';

  @override
  String get alarmStyleQuiet => 'خاموش موڈ کے مطابق';

  @override
  String get alarmStyleVibrate => 'صرف وائبریٹ';

  @override
  String get alarmStyleHint =>
      'ہمیشہ بجے الارم کا والیوم استعمال کرتا ہے، خاموش موڈ میں بھی۔ خاموش موڈ کے مطابق اطلاع کا والیوم استعمال کرتا ہے اور فون خاموش ہو تو صرف وائبریٹ کرتا ہے۔';

  @override
  String get suggestedPicks => 'تمہارے لیے تجویز کردہ';

  @override
  String get moreOptions => 'مزید اختیارات';

  @override
  String get suggestInWorkouts => 'فوری ورزشوں میں تجویز کرو';

  @override
  String get suggestInWorkoutsHint =>
      'بند کرنے سے یہ تمہارے لیے کیے گئے انتخاب سے باہر رہتی ہے۔ ہاتھ سے پھر بھی شامل کی جا سکتی ہے۔';

  @override
  String get onbPlaceTitle => 'ٹریننگ کہاں ہوتی ہے؟';

  @override
  String get onbPlaceWhy =>
      'ہر وہ جگہ چنو جہاں ٹریننگ ہوتی ہے۔ ہم صرف وہی تجویز کریں گے جو ہر ایک میں ممکن ہو۔';

  @override
  String get onbPlaceGear => 'وہاں کیا کیا ہے؟';

  @override
  String distanceCol(String unit) {
    return 'فاصلہ ($unit)';
  }

  @override
  String get timeCol => 'وقت';

  @override
  String get timePerSideCol => 'وقت / طرف';

  @override
  String get timeMinutesTitle => 'وقت (منٹ)';

  @override
  String get timeSecondsTitle => 'وقت (سیکنڈ)';

  @override
  String distanceTitle(String unit) {
    return 'فاصلہ ($unit)';
  }

  @override
  String get holdLabel => 'روکے رکھو';

  @override
  String get stopLabel => 'رکو';

  @override
  String startHold(String time) {
    return 'شروع · $time';
  }

  @override
  String get exerciseTypeLabel => 'اندراج بذریعہ';

  @override
  String get typeReps => 'ریپس اور وزن';

  @override
  String get typeTime => 'وقت';

  @override
  String get typeCardio => 'فاصلہ اور وقت';

  @override
  String get exerciseTypeHint =>
      'دوڑنے یا تیراکی جیسا کارڈیو فاصلہ اور وقت درج کرتا ہے۔ پلانک جیسی ہولڈ وقت درج کرتی ہے۔';

  @override
  String get howToLabel => 'طریقہ (اختیاری)';

  @override
  String get howToHint => 'ہر سطر میں ایک مرحلہ';

  @override
  String get editExercise => 'ورزش میں ترمیم کرو';

  @override
  String get saveChanges => 'تبدیلیاں محفوظ کرو';

  @override
  String get noStepsYet => 'ابھی کوئی مرحلہ نہیں۔ اپنے لکھو تاکہ یاد رہے کہ اسے کیسے کرنا ہے۔';

  @override
  String get addSteps => 'مراحل لکھو';

  @override
  String get setTypeRestPause => 'ریسٹ پاز';

  @override
  String get setTypeNormalInfo => 'عام سیٹ۔ یہ تمہارے حجم اور ریکارڈ میں شمار ہوتا ہے۔';

  @override
  String get setTypeWarmupInfo => 'تیار ہونے کے لیے ہلکے سیٹ۔ یہ حجم یا ریکارڈ میں شمار نہیں ہوتے۔';

  @override
  String get setTypeDropInfo => 'سیٹ کے فوراً بعد وزن کم کرو اور آرام کیے بغیر جاری رکھو۔';

  @override
  String get setTypeFailureInfo =>
      'تب تک جاری رکھو جب تک ایک اور صاف ریپ نہ ہو سکے۔ جتنے ریپ واقعی کیے وہ درج کرو۔';

  @override
  String get setTypeRestPauseInfo => 'سیٹ کے بعد 10 سے 20 سیکنڈ آرام کرو، پھر چند اور ریپ نکالو۔';

  @override
  String get planFormatNotes =>
      'ورزشوں کے نام بالکل ویسے ہی استعمال کرو جیسے فہرست میں ہیں۔ \"sets\"، \"reps\" (ایک نمبر یا \"8-12\" جیسی حد)، \"weight\" (دی گئی اکائی میں)، \"rest\" سیکنڈوں میں اور \"days\" اختیاری ہیں۔ فہرست میں cardio یا time کے نشان والی ورزشوں کے لیے \"reps\" کی جگہ \"time\" (سیکنڈ، یا \"30:00\" کی طرح) اور \"distance\" (km میں) استعمال کرو؛ ہر سیٹ کو الگ قدریں دینے کے لیے انہیں \"plan\" میں لکھو، ہر سیٹ کے لیے ایک اندراج اپنے \"reps\" اور \"weight\" کے ساتھ (وارم اپ سیٹ کے لیے \"type\": \"warmup\" شامل کرو)۔ \"superset\": true ایک ورزش کو اگلی سے جوڑتا ہے۔ کئی ہفتوں کے لیے روٹینز کو \"weeks\" کے اندر گروپ کرو جیسے دوسری مثال میں۔';

  @override
  String get planSets => 'سیٹ طے کرو';

  @override
  String get planSetsHint =>
      'ہر سیٹ کی قسم، ریپس اور وزن چنو۔ پچھلے سیشن سے شروع کرنے کے لیے وزن خودکار پر چھوڑ دو۔';

  @override
  String get planHintReps => 'ہر سیٹ کی قسم اور ریپس چنو۔ خودکار پچھلے سیشن سے شروع کرتا ہے۔';

  @override
  String get planHintTime => 'ہر سیٹ کی قسم اور وقت چنو۔ خودکار پچھلے سیشن سے شروع کرتا ہے۔';

  @override
  String get planHintTimeWeight => 'ہر سیٹ کی قسم، وقت اور وزن چنو۔ خودکار پچھلے سیشن سے شروع کرتا ہے۔';

  @override
  String get planHintCardio => 'ہر سیٹ کا فاصلہ اور وقت چنو۔ خودکار پچھلے سیشن سے شروع کرتا ہے۔';

  @override
  String get timeOnly => 'صرف وقت';

  @override
  String get autoValue => 'خودکار';

  @override
  String get clearPlan => 'منصوبہ صاف کرو';

  @override
  String get shareRoutine => 'روٹین شیئر کرو';

  @override
  String get shareWeek => 'میرا ہفتہ شیئر کرو';

  @override
  String get shareWeekHint => 'تمہاری تمام روٹینز اور ہر ایک کا دن۔';

  @override
  String shareMessage(String name) {
    return '$name: اسے شامل کرنے کے لیے فائل GymMane سے کھولو۔';
  }

  @override
  String get importRoutines => 'روٹینز امپورٹ کرو';

  @override
  String get importPasteHint => 'یہاں ایک روٹین پیسٹ کرو: GymMane سے شیئر کی ہوئی، AI کا جواب، JSON یا CSV۔';

  @override
  String get pasteAction => 'پیسٹ';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n روٹینز', one: '1 روٹین');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'اس کا ہفتہ وار شیڈول بھی استعمال کرو';

  @override
  String get useTheirScheduleHint => 'جو دن یہ لاتی ہے وہ ان دنوں کے تمہارے منصوبے کی جگہ لے لیتے ہیں۔';

  @override
  String get addToMyRoutines => 'میری روٹینز میں شامل کرو';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روٹینز شامل ہوئیں',
      one: '1 روٹین شامل ہوئی',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'یہاں ایسا کچھ نہیں جو GymMane امپورٹ کر سکے';

  @override
  String get aiStepCopy =>
      'درخواست کاپی کرو۔ اس میں تمہاری ورزشوں کی فہرست اور وہ فارمیٹ ہے جو GymMane پڑھتا ہے۔';

  @override
  String get aiStepAsk => 'اسے کسی بھی AI میں پیسٹ کرو اور بتاؤ کیا چاہیے: ہفتے میں کتنے دن، ہدف، کتنے ہفتے۔';

  @override
  String get aiStepPaste => 'اس کا جواب نیچے پیسٹ کرو اور امپورٹ کرو۔ فائل کی ضرورت نہیں۔';

  @override
  String get copyForAi => 'AI کے لیے کاپی کرو';

  @override
  String get copiedDone => 'کاپی ہو گیا';

  @override
  String get aiPasteHint => 'AI کا جواب یہاں پیسٹ کرو';

  @override
  String get importAction => 'امپورٹ';

  @override
  String get showFormat => 'فارمیٹ دیکھو';

  @override
  String get shareAsFile => 'فائل کے طور پر شیئر کرو';

  @override
  String get recoveryTab => 'بحالی';

  @override
  String recoveryOverall(int pct) {
    return 'جسم $pct% بحال';
  }

  @override
  String get recoveryAllFresh => 'سب کچھ بحال ہے۔ کسی بھی چیز کی ٹریننگ کے لیے اچھا دن۔';

  @override
  String recoveryStill(String muscles) {
    return 'ابھی بحال ہو رہے ہیں: $muscles';
  }

  @override
  String get recoveryTired => 'تھکا ہوا';

  @override
  String get recoveryFresh => 'تازہ';

  @override
  String get recoveryHint =>
      'کسی پٹھے پر ٹیپ کر کے دیکھو وہ کتنا بحال ہے۔ حالیہ سیٹ زیادہ وزن رکھتے ہیں، اور مشکل والے (RPE کے حساب سے) اور بھی زیادہ۔';

  @override
  String recoveryPct(int pct) {
    return '$pct% بحال';
  }

  @override
  String readyInHours(int h) {
    return '~$h گھ میں تیار';
  }

  @override
  String get tplAbcd => 'چار دن: سینہ اور ٹرائسیپس، کمر اور بائسیپس، ٹانگیں، کندھے اور پیٹ۔';

  @override
  String get tplAbcde => 'پانچ دن، ہر ایک میں ایک پٹھوں کا گروپ: سینہ، کمر، ٹانگیں، کندھے، بازو۔';

  @override
  String get elapsedCaps => 'گزرا وقت';

  @override
  String get tapToChange => 'بدلنے کے لیے ٹیپ کرو';

  @override
  String get swipeToSkipHint => 'آرام چھوڑنے کے لیے ٹائمر کو ایک طرف سوائپ کرو۔';

  @override
  String get screenLocked => 'اسکرین لاک ہے';

  @override
  String get lockedHint => 'ان لاک کرنے کے لیے اوپر فنگر پرنٹ کو دبائے رکھو';

  @override
  String get liveDoneSet => 'سیٹ مکمل';

  @override
  String get liveSkipRest => 'آرام چھوڑو';

  @override
  String get livePause => 'روکو';

  @override
  String get liveResume => 'جاری رکھو';

  @override
  String get liveNext => 'اگلا';

  @override
  String liveUpNext(String name) {
    return 'اگلی: $name';
  }

  @override
  String get stickerOpen => 'تصویر پر شیئر کرو';

  @override
  String get stickerNoPhoto => 'کوئی تصویر نہیں';

  @override
  String get stickerWorkout => 'ورزش';

  @override
  String get stickerStreak => 'سلسلہ';

  @override
  String get stickerDate => 'تاریخ';

  @override
  String get stickerHint => 'ہلانے کے لیے کھینچو، سائز بدلنے یا گھمانے کے لیے چٹکی لو';

  @override
  String get stickerSaved => 'تمہاری گیلری میں محفوظ ہو گئی';

  @override
  String get stickerWeek => 'اس ہفتے';

  @override
  String get getReady => 'تیار ہو جاؤ';

  @override
  String sideOfTwo(String n) {
    return 'طرف $n از 2';
  }

  @override
  String get switchSides => 'طرف بدلو';

  @override
  String get stickerGallery => 'گیلری';

  @override
  String get stickerCamera => 'کیمرہ';

  @override
  String get shareIntroTitle => 'یہ روٹین شیئر کرو';

  @override
  String get shareIntroBody =>
      'اسے اپنے ساتھی، دوست یا خاندان کو بھیجو۔ انہیں ایک چھوٹی فائل ملتی ہے جو GymMane میں کھلتی ہے اور ایک ٹیپ میں اسے سیٹوں اور وزن سمیت شامل کر دیتی ہے۔';

  @override
  String get removedFromRoutine => 'روٹین سے ہٹا دی گئی';

  @override
  String get radarTitle => 'پچھلے 30 دن';

  @override
  String get radarHint => 'دیکھو کن حصوں پر مزید کام چاہیے';

  @override
  String get radarEmpty => 'اپنا توازن دیکھنے کے لیے چند دن ٹریننگ کرو';

  @override
  String get radarBalanced => 'اب تک اچھا توازن';

  @override
  String radarFocus(String list) {
    return 'مزید چاہیے: $list';
  }

  @override
  String get countdownReady => 'تیار ہو جاؤ';

  @override
  String get countdownSkip => 'ابھی شروع کرنے کے لیے ٹیپ کرو';

  @override
  String get countdownSetting => 'شروع سے پہلے الٹی گنتی';

  @override
  String get effortSetting => 'ہر سیٹ کی مشقت درج کرو';

  @override
  String get effortHint =>
      'RPE: 10 مطلب کچھ نہیں بچا، 8 مطلب دو ریپ باقی۔ RIR بچے ہوئے ریپ گنتا ہے۔ جب سیٹ میں یہ ہو تو اندازاً 1RM، RPE چارٹ استعمال کرتا ہے۔';

  @override
  String get rirHint => '0 مطلب ٹینک میں کچھ نہیں بچا، 2 مطلب دو ریپ باقی۔';

  @override
  String get addWeekWidget => 'ہفتے کا ویجٹ شامل کرو';

  @override
  String get gamificationSetting => 'تمغے اور لیول';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ریپس', one: '$n ریپ');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'بہترین سیٹ';

  @override
  String get weekStartSetting => 'ہفتہ شروع ہوتا ہے';

  @override
  String get stepOutOfWorkout => 'روکو اور نکلو';

  @override
  String get saveToRoutine => 'تبدیلیاں روٹین میں محفوظ کرو';

  @override
  String get routineUpdated => 'روٹین اپڈیٹ ہو گئی';

  @override
  String saveChangesTitle(String name) {
    return 'تبدیلیاں $name میں محفوظ کرو؟';
  }

  @override
  String get saveChangesBody => 'اگلی بار شروع کرنے پر روٹین میں یہ تبدیلیاں ہوں گی۔';

  @override
  String get routineOrderChanged => 'ورزشوں کی نئی ترتیب';

  @override
  String get mineOnly => 'تمہاری بنائی ہوئی';

  @override
  String createNamed(String name) {
    return 'یہاں نہیں؟ “$name” بناؤ';
  }

  @override
  String get orStartWith => 'یا اس سے شروع کرو';

  @override
  String get warmupFocus => 'وارم اپ';

  @override
  String get warmupFocusHint => 'لچک اور ایکٹیویشن، سامان کے ساتھ یا بغیر';

  @override
  String get cardioFocus => 'کارڈیو';

  @override
  String get cardioFocusHint => 'دوڑ، سائیکل، روئنگ یا رسی، فاصلے اور وقت سے';

  @override
  String get homeRecommended => 'ہوم پر تجویز کردہ';

  @override
  String get homeRoutines => 'ہوم پر روٹینز';

  @override
  String get homeRoutinesHint => 'آخری کی ہوئی پہلے';

  @override
  String get homeWeekStats => 'ہوم پر اس ہفتے';

  @override
  String get homeWeekStatsHint => 'ہفتے کا حجم، سیٹ اور ریکارڈ';

  @override
  String get stepsSetting => 'Health Connect سے قدم';

  @override
  String get stepsSettingHint => 'ہوم پر آج کے قدم';

  @override
  String get stepsToday => 'آج کے قدم';

  @override
  String stepsOfGoal(String goal) {
    return '$goal میں سے';
  }

  @override
  String stepsTodayCount(String count) {
    return 'آج $count قدم';
  }

  @override
  String get stepsGoal => 'روزانہ قدموں کا ہدف';

  @override
  String get stepsNoAccess => 'تمہارے قدموں تک رسائی نہیں';

  @override
  String get stepsGrant => 'Health Connect میں اجازت دینے کے لیے ٹیپ کرو';

  @override
  String get stepsInfoRead =>
      'یہ صرف تمہارے قدموں کی گنتی پڑھتا ہے۔ کبھی کچھ اور نہیں پڑھتا اور Health Connect میں نہیں لکھتا۔';

  @override
  String get stepsInfoLocal => 'تمہارے قدم تمہارے فون پر رہتے ہیں۔ GymMane کبھی انٹرنیٹ سے نہیں جڑتا۔';

  @override
  String get stepsInfoOff => 'ترتیبات یا Health Connect میں کبھی بھی بند کرو۔';

  @override
  String get stepsManage => 'اجازت کا انتظام';

  @override
  String get routineDoneToday => 'آج کے لیے مکمل · بہت خوب';

  @override
  String get trainAgain => 'دوبارہ ٹریننگ کرو';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n دن پہلے',
      one: 'کل کی',
      zero: 'آج کی',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'آرکائیو';

  @override
  String get archiveExercise => 'ورزش آرکائیو کرو';

  @override
  String get restoreExercise => 'بحال کرو';

  @override
  String get archivedToast => 'ورزش آرکائیو ہو گئی';

  @override
  String get archivedToastHint => 'ورزشیں › آرکائیو میں ملے گی';

  @override
  String get archivedBanner => 'آرکائیو میں۔ یہ فہرستوں اور تجاویز سے باہر رہتی ہے؛ تمہارا تاریخچہ محفوظ ہے۔';

  @override
  String get videoMarksHint => 'کسی مرحلے پر روکو اور اگلی بار وہاں جانے کے لیے پن پر ٹیپ کرو۔';

  @override
  String get videoMarkHere => 'یہ مرحلہ یہاں نشان زد کرو';

  @override
  String get sectionGeneral => 'عمومی';

  @override
  String get sectionTraining => 'ٹریننگ';

  @override
  String get sectionAlerts => 'یاد دہانیاں اور الارم';

  @override
  String get sectionHome => 'ہوم';

  @override
  String get sectionWidgets => 'ویجٹس';

  @override
  String get sectionData => 'ڈیٹا اور بیک اپ';

  @override
  String get multiPlanSetting => 'دن میں کئی روٹینز';

  @override
  String get multiPlanHint => 'اس دن کی ہر روٹین پر ٹیپ کرو۔ یہ اسی ترتیب میں جاتی ہیں جس میں تم شامل کرو۔';

  @override
  String routineOfDay(int n, int total) {
    return 'آج $total میں سے $n';
  }

  @override
  String get nextToday => 'آج اگلی';

  @override
  String get planAboutMe => 'میرے بارے میں:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex، عمر $age سال، قد $height، وزن $weight۔';
  }

  @override
  String planDays(int n) {
    return 'مجھے ہفتے میں $n دن ٹریننگ کرنی ہے۔';
  }

  @override
  String get planNoHistory => 'ابھی کوئی ورزش درج نہیں: مجھے مبتدی سمجھو اور حجم اور وزن محتاط رکھو۔';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'پچھلے 30 دنوں میں $n ورزشیں درج۔',
      one: 'پچھلے 30 دنوں میں 1 ورزش درج۔',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'حالیہ بہترین سیٹ';

  @override
  String get planAskFirst =>
      'اگر میرا ہدف (طاقت، پٹھے، چربی کم کرنا یا عمومی فٹنس) یا ہر سیشن کتنا لمبا ہو سکتا ہے معلوم نہیں تو پہلے ایک مختصر پیغام میں مجھ سے پوچھو۔ جب معلوم ہو جائے تو صرف JSON میں جواب دو۔';

  @override
  String get backToTop => 'اوپر واپس';

  @override
  String get deleteExerciseTitle => 'یہ ورزش حذف کرو؟';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" تمہاری لائبریری اور روٹینز سے ہٹا دی جائے گی۔ تمہارے پچھلے سیٹ محفوظ رہیں گے۔';
  }

  @override
  String get exportForStravaHint =>
      'اسے براؤزر میں strava.com/upload/select پر اپلوڈ کرو (Strava ایپ فائلیں امپورٹ نہیں کر سکتی)۔ یہ تمہارے سیٹوں کے ساتھ Weight Training کے طور پر نظر آئے گی۔';

  @override
  String get manualStartTime => 'شروع کا وقت';

  @override
  String get manualDuration => 'دورانیہ';

  @override
  String get manualDurationUnset => 'دورانیہ شامل کرو';

  @override
  String get stravaRow => 'Strava پر ایکسپورٹ کرو (بیٹا)';

  @override
  String get stravaBeta => 'بیٹا';

  @override
  String get stravaIntro =>
      'Strava پر لے جانے کے لیے ایک ورزش چنو۔ تمہیں ایک ‎.fit فائل ملے گی: اسے براؤزر میں strava.com/upload/select پر اپلوڈ کرو اور یہ تمہارے سیٹوں کے ساتھ Weight Training کے طور پر نظر آئے گی۔';

  @override
  String get stravaEmpty => 'ابھی ایکسپورٹ کرنے کو کوئی ورزش نہیں۔';

  @override
  String get tapToPause => 'روکنے کے لیے ٹیپ کرو';

  @override
  String get holdPausedHint => 'رکا ہوا · جاری رکھنے کے لیے ٹیپ کرو';

  @override
  String get finishHoldNow => 'سیٹ ابھی ختم کرو';

  @override
  String get barWeightExercise => 'بار یا سلیڈ کا وزن';

  @override
  String get barWeightHint => 'پلیٹ کیلکولیٹر میں استعمال ہوتا ہے';

  @override
  String get barWeightCustom => 'تمہارا اپنا · ری سیٹ کے لیے ٹیپ کرو';

  @override
  String get groupRename => 'گروپ کا نام بدلو';

  @override
  String get groupUngroup => 'گروپ ہٹاؤ، روٹینز رکھو';

  @override
  String get groupDeleteAll => 'گروپ اور روٹینز حذف کرو';

  @override
  String groupDeleteTitle(String name) {
    return '“$name” حذف کرو؟';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count حذف ہو جائیں گی۔ تمہارا ورزش کا تاریخچہ محفوظ رہے گا۔';
  }

  @override
  String get tplRr =>
      'r/bodyweightfitness کی کلاسیک: ہفتے میں تین دن پورا جسم۔ آسان لگنے پر اگلے مرحلے پر جاؤ۔';

  @override
  String get levelUpKicker => 'اگلا مرحلہ';

  @override
  String levelUpBody(int reps, String name) {
    return '$name میں لگاتار دو ورزشوں میں 3×$reps۔ اگلے مرحلے کے لیے تیار؟';
  }

  @override
  String levelUpSwap(String routine) {
    return '$routine میں بدلو';
  }

  @override
  String get levelUpSee => 'دیکھو کیسے کرتے ہیں';

  @override
  String get levelUpLater => 'ابھی نہیں';

  @override
  String get levelUpStay => 'یہی رکھو';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name اب $routine میں ہے';
  }

  @override
  String get levelUpStayed => 'اس کے لیے اگلے مرحلے کی مزید تجاویز نہیں';

  @override
  String get levelHintsSetting => 'اگلا مرحلہ تجویز کرو';

  @override
  String get heatmapLabelsSetting => 'سرگرمی کے نقشے پر دن اور مہینے';

  @override
  String get rmPercent => 'فیصد';

  @override
  String rmAtPercent(String pct) {
    return 'تمہارے زیادہ سے زیادہ کا $pct';
  }

  @override
  String get copyWorkout => 'متن کے طور پر کاپی کرو';

  @override
  String get goalSet => 'ہدف مقرر کرو';

  @override
  String get goalTargetReps => 'ہدف ریپس';

  @override
  String goalToGo(String value) {
    return '$value باقی';
  }

  @override
  String get goalReached => 'ہدف پورا';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n دن باقی', one: '1 دن باقی');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'تاریخ گزر گئی';

  @override
  String get goalDeadline => 'آخری تاریخ';

  @override
  String get goalNoDeadline => 'کوئی آخری تاریخ نہیں';

  @override
  String get goalRemove => 'ہدف ہٹاؤ';

  @override
  String get exerciseNameMissing => 'اسے ایک نام دو';

  @override
  String get aliasesLabel => 'دوسرے نام (اختیاری)';

  @override
  String get aliasesHint => 'دوسرے نام، کوما سے الگ';

  @override
  String alsoCalled(String names) {
    return 'یہ بھی: $names';
  }

  @override
  String get addToRoutine => 'روٹین میں شامل کرو';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روٹینز میں',
      one: '1 روٹین میں',
      zero: 'ابھی کسی روٹین میں نہیں',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'پہلے سے اس میں ہے';

  @override
  String get restInRoutine => 'اس روٹین میں آرام';

  @override
  String get restInRoutineHint => 'ورزش جیسا';

  @override
  String get restInRoutineReset => 'صرف یہاں · واپس کرنے کے لیے ٹیپ کرو';

  @override
  String get swapExercise => 'ورزش بدلو';

  @override
  String get swapShort => 'بدلو';

  @override
  String swapHint(String name) {
    return '$name کی جگہ، صرف آج کے لیے۔ ختم کرنے پر اسے روٹین میں رکھا جا سکتا ہے۔';
  }

  @override
  String get swapKeepsDone => 'جو سیٹ پہلے کر چکے وہ درج رہیں گے؛ نئی باقی سنبھال لے گی۔';

  @override
  String swapSameMuscle(String muscle) {
    return 'وہی پٹھا · $muscle';
  }

  @override
  String get swapDoneBefore => 'پہلے کی ہوئی';

  @override
  String get multiPlanSettingHint => 'ہفتے کے ایک ہی دن ایک سے زیادہ روٹین';

  @override
  String get levelHintsHint => 'مشکل ورژن تجویز کرتا ہے';

  @override
  String get focusCardHint => 'آج کی روٹین، ہوم کے اوپر';

  @override
  String get gamificationHint => 'تمغے، لیول اور جشن';

  @override
  String get exerciseSettings => 'اس ورزش کی ترتیبات';

  @override
  String get placeActiveNow => 'تم یہاں ہو';

  @override
  String get placeTapToUse => 'یہاں ٹریننگ کے لیے ٹیپ کرو';

  @override
  String get intervalDays => 'دن';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target دن';
  }

  @override
  String get toolNameRpe => 'RPE وزن';

  @override
  String get toolTitleRpe => 'RPE سے وزن';

  @override
  String get toolDescRpe => 'مطلوبہ مشقت کے لیے وزن';

  @override
  String get toolNameDots => 'طاقت کی سطح';

  @override
  String get toolTitleDots => 'طاقت کی سطح (DOTS)';

  @override
  String get toolDescDots => 'تمہارے جسمانی وزن کے حساب سے تمہاری طاقت';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'RPE $rpe پر $reps ریپس کے لیے';
  }

  @override
  String get rpeYourSet => 'ابھی کیا ہوا سیٹ';

  @override
  String get rpeGoal => 'جو کرنا ہے';

  @override
  String rpeOneRmLine(String value) {
    return 'اندازاً 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 مطلب ایک اور نہیں ہو سکتا تھا؛ 8 مطلب دو باقی تھے۔';

  @override
  String get dotsBestLifts => 'تمہارے بہترین لفٹ';

  @override
  String get dotsSquat => 'اسکواٹ';

  @override
  String get dotsBench => 'بینچ پریس';

  @override
  String get dotsDeadlift => 'ڈیڈ لفٹ';

  @override
  String dotsTotalLine(String value) {
    return 'کل: $value';
  }

  @override
  String get dotsExplain =>
      'تمہاری طاقت کا کسی سے بھی موازنہ کرتا ہے، چاہے ان کا وزن کچھ بھی ہو۔ اپنا بہترین ایک ریپ، یا اندازاً 1RM استعمال کرو۔';

  @override
  String get dotsLevel0 => 'مبتدی';

  @override
  String get dotsLevel1 => 'درمیانہ';

  @override
  String get dotsLevel2 => 'ماہر';

  @override
  String get dotsLevel3 => 'بہت ماہر';

  @override
  String get dotsLevel4 => 'ایلیٹ';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks اسکور';

  @override
  String get toolDescWilks => 'پاور لفٹنگ کا کلاسیک اسکور';

  @override
  String get wilksExplain =>
      'پاور لفٹنگ کا کلاسیک فارمولا۔ 2020 میں DOTS نے اس کی جگہ لی، لیکن کئی مقابلے اور درجہ بندیاں اب بھی اسے استعمال کرتی ہیں۔';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'چربی سے پاک ماس انڈیکس';

  @override
  String get toolDescFfmi => 'تمہارے قد کے حساب سے کتنے پٹھے';

  @override
  String get ffmiBodyFat => 'جسمانی چربی';

  @override
  String ffmiLeanLine(String value) {
    return 'خالص ماس: $value';
  }

  @override
  String get ffmiExplain =>
      'BMI جیسا، لیکن چربی کے بغیر: یہ صرف تمہارا خالص ماس گنتا ہے۔ قد کے مطابق ایڈجسٹ تاکہ لمبے اور چھوٹے لوگوں کا منصفانہ موازنہ ہو۔';

  @override
  String get ffmiLevel0 => 'اوسط سے کم';

  @override
  String get ffmiLevel1 => 'اوسط';

  @override
  String get ffmiLevel2 => 'اوسط سے زیادہ';

  @override
  String get ffmiLevel3 => 'بہترین';

  @override
  String get ffmiLevel4 => 'غیر معمولی';

  @override
  String get rpeEffortLabel => 'مشقت (RPE)';

  @override
  String get restRowHint => 'سیٹوں کے درمیان، اگر ورزش کا اپنا نہ ہو';

  @override
  String get effortRowHint => 'ہر سیٹ پر RPE یا RIR درج کرو';

  @override
  String get countdownHint => 'پہلے سیٹ سے پہلے 3، 2، 1';

  @override
  String get keepScreenOnHint => 'ٹریننگ کے دوران اسکرین آن رہتی ہے';

  @override
  String get demoSizeRowHint => 'ورزش کے دوران ورزش کی تصویر';

  @override
  String get demoLoopRowHint => 'اینیمیشن دہرائی جائے یا رک جائے';

  @override
  String get trainReminderRowHint => 'ٹریننگ کے دنوں میں یاد دہانی';

  @override
  String get alarmSoundRowHint => 'آرام ختم ہونے پر کیا بجتا ہے';

  @override
  String get alarmStyleRowHint => 'خاموش موڈ میں بجے یا نہیں';

  @override
  String get recommendedRowHint => 'ہوم پر ہماری تجویز کردہ ورزشیں';

  @override
  String get weightStepSetting => 'وزن کا قدم';

  @override
  String get weightStepHint => '− اور + بٹن کتنا شامل کرتے ہیں';

  @override
  String get prBestWorkout => 'بہترین ورزش';

  @override
  String get mergeExercise => 'ضم کرو';

  @override
  String mergeExerciseInto(String name) {
    return '$name کو اس میں ضم کرو…';
  }

  @override
  String get mergeExerciseTitle => 'ورزشیں ضم کرو؟';

  @override
  String mergeExerciseBody(String from, String to) {
    return '\"$from\" کا سارا تاریخچہ \"$to\" میں چلا جائے گا۔ \"$from\" تمہاری لائبریری میں رہے گی۔ اسے واپس نہیں کیا جا سکتا۔';
  }

  @override
  String get mergedToast => 'تاریخچہ ضم ہو گیا';

  @override
  String get nutrition => 'غذائیت';

  @override
  String get nutritionHomeEmpty => 'پانی، پروٹین اور کیلوریز';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein گرام پروٹین';
  }

  @override
  String get nutritionToday => 'آج';

  @override
  String get nutritionYesterday => 'کل';

  @override
  String get nutritionGoals => 'روزانہ اہداف';

  @override
  String get kcalLabel => 'کیلوریز';

  @override
  String get kcalOver => 'زیادہ';

  @override
  String get waterLabel => 'پانی';

  @override
  String get waterDone => 'ہدف پورا';

  @override
  String get waterCustom => 'دوسری مقدار';

  @override
  String get glassSize => 'گلاس کا سائز';

  @override
  String get supplementsLabel => 'سپلیمنٹس';

  @override
  String get supplementsEmpty => 'شامل کرنے کے لیے کسی ایک پر ٹیپ کرو، یا اپنے لیے +۔';

  @override
  String get addSupplement => 'نیا سپلیمنٹ';

  @override
  String get supplementNameHint => 'کریٹین، وٹامن D…';

  @override
  String removeSupplementTitle(String name) {
    return '$name ہٹاؤ؟';
  }

  @override
  String get removeSupplementBody => 'جن دنوں تم نے اسے لیا ہوا نشان زد کیا وہ بھی ساتھ چلے جائیں گے۔';

  @override
  String get suppCreatine => 'کریٹین';

  @override
  String get suppVitaminD => 'وٹامن D';

  @override
  String get suppOmega3 => 'اومیگا 3';

  @override
  String get suppMagnesium => 'میگنیشیم';

  @override
  String get suppMultivitamin => 'ملٹی وٹامن';

  @override
  String get suppCaffeine => 'کیفین';

  @override
  String get myFoods => 'میری غذائیں';

  @override
  String get newFood => 'نئی غذا';

  @override
  String get editFood => 'غذا میں ترمیم کرو';

  @override
  String get foodNameHint => 'وے پروٹین، جئی، روٹی…';

  @override
  String get servingLabel => 'سرونگ';

  @override
  String get servingHint => '1 اسکوپ · 30 گرام';

  @override
  String get perServing => 'فی سرونگ';

  @override
  String get servingsLabel => 'سرونگز';

  @override
  String get foodPhotoHint => 'سادہ پس منظر پر یہ اسٹیکر بن جاتی ہے۔';

  @override
  String get cutoutWorking => 'کاٹا جا رہا ہے…';

  @override
  String get cutoutTry => 'کاٹو';

  @override
  String get cutoutKeep => 'پوری تصویر';

  @override
  String deleteFoodTitle(String name) {
    return '$name حذف کرو؟';
  }

  @override
  String get deleteFoodBody => 'یہ تمہاری غذاؤں سے نکل جائے گی۔ جو پہلے درج کیا وہ رہے گا۔';

  @override
  String get mealBreakfast => 'ناشتہ';

  @override
  String get mealLunch => 'دوپہر کا کھانا';

  @override
  String get mealDinner => 'رات کا کھانا';

  @override
  String get mealSnacks => 'اسنیکس';

  @override
  String get nothingLogged => 'ابھی کچھ درج نہیں۔';

  @override
  String addToMeal(String meal) {
    return '$meal میں شامل کرو';
  }

  @override
  String get quickAdd => 'فوری اندراج';

  @override
  String get quickAddHint => 'صرف نمبر، غذا محفوظ کیے بغیر۔';

  @override
  String get quickAddName => 'یہ کیا تھا؟ (اختیاری)';

  @override
  String get logFood => 'شامل کرو';

  @override
  String loggedToast(String meal) {
    return '$meal میں شامل ہو گیا';
  }

  @override
  String get entryRemoved => 'ہٹا دیا گیا';

  @override
  String get goalsFromProfile => 'میرے پروفائل سے حساب لگاؤ';

  @override
  String get goalsFromProfileHint =>
      'تمہارے پروفائل سے کیلوریز، فی کلو جسمانی وزن 1.8 گرام پروٹین اور 35 ملی لیٹر پانی۔';

  @override
  String get kcalEaten => 'کھایا';

  @override
  String get kcalRemaining => 'باقی';

  @override
  String waterTapHint(String amount) {
    return 'گلاس پر ٹیپ کرو: + $amount';
  }

  @override
  String get shakeEmpty => 'اپنا شیک چننے کے لیے ٹیپ کرو';

  @override
  String shakeTapHint(String name) {
    return 'ٹیپ: + $name';
  }

  @override
  String get shakePick => 'تمہارا شیک';

  @override
  String get shakePickHint => 'شیکر پر ٹیپ کرو اور یہ ایک ہی بار میں درج ہو جائے گا۔';

  @override
  String get proteinLetter => 'پ';

  @override
  String get carbsLetter => 'ک';

  @override
  String get fatLetter => 'چ';

  @override
  String get addBurnedLabel => 'جلی ہوئی کیلوریز شامل کرو';

  @override
  String get addBurnedHint =>
      'تمہارا ہدف پہلے ہی تمہاری عام سرگرمی گنتا ہے۔ اسے صرف تب آن کرو اگر تم نے خود کو بیٹھے رہنے والا چنا ہو: یہ آرام کے علاوہ ہر ورزش میں جلنے والی کیلوریز شامل کرتا ہے۔';

  @override
  String get amountLabel => 'مقدار';

  @override
  String amountIn(String unit) {
    return 'مقدار ($unit)';
  }

  @override
  String get bodyweightLabel => 'جسمانی وزن';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count غذائیں کاپی ہوئیں',
      one: '1 غذا کاپی ہوئی',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'جو پہلے درج کیا وہ ویسے ہی رہے گا۔';

  @override
  String get fiberLabel => 'فائبر';

  @override
  String get sugarLabel => 'چینی';

  @override
  String get sodiumLabel => 'سوڈیم';

  @override
  String get foodDatabase => 'غذاؤں کا ڈیٹا بیس';

  @override
  String get kcalBurned => 'جلی';

  @override
  String get mealOptions => 'کھانے کے اختیارات';

  @override
  String get moreNutrients => 'فائبر، چینی اور سوڈیم';

  @override
  String ofGoal(int goal, String unit) {
    return '$goal $unit میں سے';
  }

  @override
  String per100(String unit) {
    return 'فی 100 $unit';
  }

  @override
  String get perServingShort => 'فی سرونگ';

  @override
  String get foodCategory => 'زمرہ';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count عدد', one: '1 عدد');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ٹکڑے', one: '1 ٹکڑا');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count اسکوپ', one: '1 اسکوپ');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count بڑے چمچ',
      one: '1 بڑا چمچ',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count چھوٹے چمچ',
      one: '1 چھوٹا چمچ',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count کپ', one: '1 کپ');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count گلاس', one: '1 گلاس');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'حالیہ';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count غذائیں', one: '1 غذا');
    return '$_temp0';
  }

  @override
  String get renameLabel => 'نام بدلو';

  @override
  String get repeatFrom => 'یہاں سے دہراؤ';

  @override
  String get repeatNone => 'دوسرے دنوں میں اس کھانے کے لیے ابھی کچھ درج نہیں۔';

  @override
  String get restDayGoals => 'آرام کے دنوں میں الگ اہداف';

  @override
  String get trainingDays => 'ٹریننگ کے دن';

  @override
  String get restDays => 'آرام کے دن';

  @override
  String get trainingDay => 'ٹریننگ کا دن';

  @override
  String get saveAsMeal => 'کھانے کے طور پر محفوظ کرو';

  @override
  String get savedMealNameHint => 'مثلاً معمول کا ناشتہ';

  @override
  String get savedMealToast => 'کھانا محفوظ ہو گیا';

  @override
  String get savedMeals => 'محفوظ کھانے';

  @override
  String get searchFoodsHint => 'غذائیں تلاش کرو';

  @override
  String get searchFoodsEmpty => 'تصاویر کے ساتھ 500 سے زیادہ غذائیں تلاش کرو، یا اپنی شامل کرو۔';

  @override
  String searchFoodsNone(String query) {
    return '\"$query\" کے لیے کچھ نہیں ملا۔ اسے اپنی غذا کے طور پر بناؤ۔';
  }

  @override
  String get servingWeight => 'گرام';

  @override
  String get weekAverage => 'اس ہفتے';

  @override
  String get weekAvgEnergy => 'روزانہ اوسط';

  @override
  String get weekAvgProtein => 'روزانہ پروٹین';

  @override
  String get weekEnergyOnTarget => 'کیلوریز ہدف پر';

  @override
  String get weekProteinOnTarget => 'پروٹین ہدف پر';

  @override
  String weekProteinAvg(int grams) {
    return 'روزانہ $grams گرام پروٹین';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$days میں سے $met دن ہدف پر';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count دن درج', one: '1 دن درج');
    return '$_temp0';
  }

  @override
  String get weekNoData => 'ابھی کچھ درج نہیں';

  @override
  String get weekOnTargetHint => 'ہدف پر: کیلوریز ہدف کے 10% کے اندر اور کم از کم 90% پروٹین۔';

  @override
  String get weightGoalLabel => 'ہدف وزن';

  @override
  String weightGoalTitle(String unit) {
    return 'ہدف وزن ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'ہدف $weight';
  }

  @override
  String get weightGoalNone => 'ہدف مقرر کرنے کے لیے دبائے رکھو';

  @override
  String get weightGoalReached => 'ہدف پورا';

  @override
  String weightToLose(String weight) {
    return '$weight کم کرنا ہے';
  }

  @override
  String weightToGain(String weight) {
    return '$weight بڑھانا ہے';
  }

  @override
  String get aminoHis => 'ہسٹیڈین';

  @override
  String get aminoIle => 'آئسولیوسین';

  @override
  String get aminoLeu => 'لیوسین';

  @override
  String get aminoLys => 'لائسین';

  @override
  String get aminoSaa => 'میتھیونین';

  @override
  String get aminoAaa => 'فینائل ایلانین';

  @override
  String get aminoThr => 'تھریونین';

  @override
  String get aminoTrp => 'ٹرپٹوفین';

  @override
  String get aminoVal => 'ویلین';

  @override
  String get animalProtein => 'حیوانی پروٹین';

  @override
  String get proteinQuality => 'پروٹین کا معیار';

  @override
  String get qualityComplete => 'مکمل';

  @override
  String get qualityAlmost => 'تقریباً مکمل';

  @override
  String get qualityIncomplete => 'نامکمل';

  @override
  String get qualityNoData => 'ابھی کوئی ڈیٹا نہیں';

  @override
  String get qualityNoDataHint => 'اپنے امینو ایسڈ دیکھنے کے لیے ڈیٹا بیس سے غذائیں درج کرو۔';

  @override
  String get qualityAllCovered => 'تمام نو ضروری امینو ایسڈ پورے ہیں۔';

  @override
  String qualityLimiting(String amino) {
    return '$amino کم ہے۔ اسے ان غذاؤں کے ساتھ ملاؤ جن میں یہ زیادہ ہو۔';
  }

  @override
  String qualityCoverage(int pct) {
    return 'تمہارے پروٹین کے $pct% پر مبنی: تمہاری اپنی غذاؤں میں امینو ایسڈ کا ڈیٹا نہیں۔';
  }

  @override
  String get fatTypes => 'چربی کی اقسام';

  @override
  String get fatSaturated => 'سیچوریٹڈ';

  @override
  String get fatMono => 'مونو';

  @override
  String get fatPoly => 'پولی';

  @override
  String satLimitLine(String grams, int limit) {
    return 'سیچوریٹڈ $grams گرام، زیادہ سے زیادہ $limit گرام (کیلوریز کا 10%)';
  }

  @override
  String get sugarSodium => 'چینی اور سوڈیم';

  @override
  String get shakeCard => 'پروٹین شیک';

  @override
  String get mealOther => 'کھانا';

  @override
  String get mealAdd => 'کھانا شامل کرو';

  @override
  String get mealAddHint => 'مثلاً ورزش سے پہلے';

  @override
  String get mealsOfDay => 'دن کے کھانے';

  @override
  String get mealsHint => 'جتنے چاہو بناؤ۔ کسی کو ہٹانے سے اس میں درج چیزیں اوپر والے میں چلی جاتی ہیں۔';

  @override
  String get trackersTitle => 'اپنی مرضی کے مطابق';

  @override
  String get trackersHint => 'صرف وہی دکھاؤ جس پر نظر رکھنی ہو۔';

  @override
  String get trackersDaily => 'روزانہ خلاصہ';

  @override
  String get trackersDetail => 'تفصیل میں';

  @override
  String get trackersCards => 'کارڈز';

  @override
  String get prepTitle => 'میل پریپ';

  @override
  String get prepNewShort => 'نئی کھیپ';

  @override
  String get prepNew => 'نئی کھیپ';

  @override
  String get prepEdit => 'کھیپ میں ترمیم کرو';

  @override
  String get prepHint => 'پوری دیگ ایک بار درج کرو، پھر تھوڑا تھوڑا کھاؤ۔';

  @override
  String get prepEmpty => 'بڑی کھیپ پکائی؟ ایک بار درج کرو اور پھر بس بتاؤ بچے ہوئے میں سے کتنا کھایا۔';

  @override
  String get prepNameHint => 'مثلاً چکن اور چاول';

  @override
  String get prepDefaultName => 'کھیپ';

  @override
  String get prepIngredients => 'اجزاء';

  @override
  String get prepAddIngredient => 'جزو شامل کرو';

  @override
  String get prepCookedWeight => 'پکا ہوا وزن';

  @override
  String prepCookedHint(String grams) {
    return 'درست نمبروں کے لیے پکنے کے بعد دیگ تولو۔ خالی چھوڑنے پر کچا کل ($grams گرام) استعمال ہوتا ہے۔';
  }

  @override
  String get prepNeedWeight => 'پکا ہوا وزن شامل کرو: کچھ اجزاء کے گرام نہیں۔';

  @override
  String prepLeftOf(String left, String total) {
    return '$total میں سے $left باقی';
  }

  @override
  String get prepOfWhatsLeft => 'بچے ہوئے کا %';

  @override
  String get prepAll => 'سب';

  @override
  String prepLogAmount(String grams) {
    return '$grams درج کرو';
  }

  @override
  String get prepWeighLeft => 'بچا ہوا تولو';

  @override
  String get prepFinished => 'یہ کھیپ ختم ہو گئی۔';

  @override
  String get approxValues => 'تقریباً';

  @override
  String get editValues => 'قدریں بدلو';

  @override
  String get editValuesHint =>
      'صرف یہ اندراج بدلتا ہے۔ اگلی بار کے لیے غذا درست کرنے کو میری غذائیں سے ترمیم کرو۔';

  @override
  String get editLibraryHint => 'اسی تصویر کے ساتھ تمہاری اپنی غذا کے طور پر محفوظ';

  @override
  String per100Line(String energy, String unit) {
    return 'فی 100 $unit میں $energy';
  }

  @override
  String get rawLabel => 'کچا';

  @override
  String get cookedLabel => 'پکا';

  @override
  String get rawHint => 'پکانے سے پہلے کا وزن';

  @override
  String cookedHint(String factor) {
    return 'پکنے کے بعد کا وزن (کچے وزن کا ×$factor)';
  }

  @override
  String get servingsUnit => 'سرونگز';

  @override
  String logAmount(String energy) {
    return 'درج کرو · $energy';
  }

  @override
  String get catFruit => 'پھل';

  @override
  String get catVeg => 'سبزیاں';

  @override
  String get catMeat => 'گوشت';

  @override
  String get catFish => 'مچھلی';

  @override
  String get catEgg => 'انڈے';

  @override
  String get catDairy => 'دودھ کی اشیاء';

  @override
  String get catGrain => 'اناج';

  @override
  String get catBakery => 'بیکری';

  @override
  String get catLegume => 'دالیں';

  @override
  String get catNut => 'میوے';

  @override
  String get catOil => 'تیل';

  @override
  String get catPantry => 'پینٹری';

  @override
  String get catDrink => 'مشروبات';

  @override
  String get catSauce => 'چٹنیاں';

  @override
  String get catSpice => 'مصالحے';

  @override
  String get searchFoodsPrompt => 'تم نے کیا کھایا؟';

  @override
  String get shelfEmpty =>
      'کوئی غذا تلاش کرو یا اپنی کی تصویر لو: سب سے زیادہ درج ہونے والی یہاں نظر آئیں گی۔';

  @override
  String get repeatEntry => 'دوبارہ درج کرو';

  @override
  String get notifSuppChannel => 'سپلیمنٹس';

  @override
  String get notifSuppChannelWhy => 'سپلیمنٹس لینے کی روزانہ یاد دہانی';

  @override
  String get energySplit => 'کیلوریز کہاں سے آتی ہیں';

  @override
  String get typicalServing => 'عام سرونگ';

  @override
  String cookedYieldLine(String factor) {
    return 'کچے وزن کا $factor× وزن';
  }

  @override
  String get readyDishes => 'ڈشیں';

  @override
  String weightLastLine(String weight) {
    return 'آخری وزن $weight';
  }

  @override
  String get proteinAnimalShort => 'حیوانی';

  @override
  String get proteinPlantShort => 'نباتاتی';

  @override
  String kcalFromMacros(String value) {
    return 'یہ میکروز تقریباً $value بنتے ہیں';
  }

  @override
  String get useValue => 'استعمال کرو';

  @override
  String get suppRowHint => 'نشان کے لیے ٹیپ · تفصیل کے لیے دبائے رکھو';

  @override
  String get suppPhoto => 'تصویر';

  @override
  String get suppDose => 'خوراک';

  @override
  String get suppDoseHint => '5 گرام، 2 کیپسول…';

  @override
  String get suppRemind => 'مجھے یاد دلاؤ';

  @override
  String mealPlanDefault(int n) {
    return 'منصوبہ $n';
  }

  @override
  String get mealPlansTitle => 'کھانے کے منصوبے';

  @override
  String get mealPlanNew => 'نیا منصوبہ';

  @override
  String fromPlan(String name) {
    return '$name سے';
  }

  @override
  String get logPlan => 'درج کرو';

  @override
  String get planFromDay => 'یہ دن کاپی کرو';

  @override
  String get planNewHint => 'اپنے دنوں کی منصوبہ بندی روٹینز کی طرح کرو، پھر ایک ٹیپ میں پورا کھانا درج کرو۔';

  @override
  String get planLogDay => 'خالی کھانے درج کرو';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n غذائیں درج ہوئیں',
      one: '1 غذا درج ہوئی',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'کوئی منصوبہ نہیں';

  @override
  String get planWeekHint => 'کسی دن کو منصوبہ دینے کے لیے اس پر ٹیپ کرو۔';

  @override
  String get planDuplicate => 'نقل بناؤ';

  @override
  String planDeleteTitle(String name) {
    return '$name حذف کرو؟';
  }

  @override
  String get planDeleteBody => 'تمہارے درج کیے دن ویسے ہی رہیں گے۔';

  @override
  String get sectionBeta => 'بیٹا';

  @override
  String get nutritionBeta => 'غذائیت';

  @override
  String get nutritionBetaHint => 'کھانے، پانی اور سپلیمنٹس';

  @override
  String get nutritionAboutTitle => 'غذائیت کے بارے میں';

  @override
  String get nutritionAboutSub => 'یہ کیا ہے، اور کبھی کیا نہیں ہوگا۔';

  @override
  String get nutritionAboutWhatTitle => 'تمہاری ٹریننگ کا حصہ';

  @override
  String get nutritionAboutWhat =>
      'اپنی ورزشوں کے ساتھ ہی کھانے، پانی، پروٹین اور سپلیمنٹس درج کرنے کا ایک آسان طریقہ۔ GymMane سب سے پہلے جم ایپ ہے: غذائیت یہاں اس لیے ہے کہ تم سب کچھ ایک جگہ رکھ سکو، کسی مخصوص ڈائٹ ایپ کی جگہ لینے کے لیے نہیں۔';

  @override
  String get nutritionAboutScanTitle => 'اسکیننگ کبھی نہیں';

  @override
  String get nutritionAboutScan =>
      'بارکوڈ اسکین کرنا اور ہر تفصیل خود بخود بھر جانا آسان ہوتا۔ لیکن اس کے لیے انٹرنیٹ اور غذاؤں کا ایک بہت بڑا آن لائن ڈیٹا بیس چاہیے، اور جو کچھ کھایا جائے وہ کسی اور کے سرورز پر پہنچ جاتا ہے۔ وہ ڈیٹا دکھاتا ہے کہ کب اور کیا کھایا جاتا ہے اور جسم کا کیسے خیال رکھا جاتا ہے، اور اسے اشتہارات کے لیے استعمال کیا جا سکتا ہے یا بڑی کمپنیوں کو دیا جا سکتا ہے۔ اسی لیے کوئی اسکینر نہیں، اور نہ ہوگا۔';

  @override
  String get nutritionAboutLocalTitle => 'سب کچھ تمہارے فون پر';

  @override
  String get nutritionAboutLocal =>
      'تصاویر کے ساتھ 500 سے زیادہ غذائیں ایپ کے اندر آتی ہیں۔ اپنی غذائیں شامل کرو، ان کی تصاویر بدلو اور ان کی قدریں ترمیم کرو۔ یہ سب تمہارے فون پر رہتا ہے، باقی GymMane کی طرح۔';

  @override
  String get nutritionAboutBetaTitle => 'ابھی بیٹا میں';

  @override
  String get nutritionAboutBeta =>
      'اگر کچھ کمی محسوس ہو تو GitHub پر تجویز کرو۔ بس اسکیننگ یا بڑا ڈیٹا بیس نہیں: تمہاری پرائیویسی کے علاوہ، اس سے ایپ بہت بھاری ہو جائے گی۔ غذائیت کی ضرورت نہیں؟ ترتیبات میں بند کرو اور تمہارا ڈیٹا رہے گا۔';

  @override
  String get nutritionAboutSuggest => 'خیال تجویز کرو';

  @override
  String get nutritionAboutOk => 'ٹھیک ہے';

  @override
  String get planShare => 'شیئر کرو';

  @override
  String get planImport => 'منصوبہ امپورٹ کرو';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n منصوبے امپورٹ ہوئے',
      one: '1 منصوبہ امپورٹ ہوا',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'اس فائل میں کھانے کے منصوبے نہیں۔';

  @override
  String get planMoveUp => 'اوپر لے جاؤ';

  @override
  String get planMoveDown => 'نیچے لے جاؤ';

  @override
  String get cutoutEdit => 'کٹ آؤٹ درست کرو';

  @override
  String get cutoutEditHint =>
      'مٹانے یا بحال کرنے کے لیے کھینچو۔ کسی حصے کو پورا ہٹانے یا واپس لانے کے لیے ٹیپ کرو۔ زوم کے لیے چٹکی لو۔';

  @override
  String get cutoutErase => 'مٹاؤ';

  @override
  String get cutoutRestore => 'بحال کرو';

  @override
  String get cutoutReset => 'خودکار پر واپس';

  @override
  String get cutoutByHand => 'ہاتھ سے کاٹو';

  @override
  String notifSuppTitleFor(String names) {
    return 'لینے کا وقت: $names';
  }

  @override
  String get notifSuppTap => 'لینے کے بعد GymMane میں نشان لگاؤ۔';

  @override
  String get suppNoneToday => 'آج لینے کو کچھ نہیں۔';

  @override
  String get suppOtherDays => 'دوسرے دن';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ہر $n دن', one: 'ہر دن');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'ہر دن';

  @override
  String suppFromDate(String date) {
    return '$date سے';
  }

  @override
  String suppUntilDate(String date) {
    return '$date تک';
  }

  @override
  String get suppSomeDays => 'کچھ دن';

  @override
  String get suppEveryShort => 'ہر X دن';

  @override
  String get suppWhen => 'کب';

  @override
  String get suppEveryLead => 'ہر';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'دن', one: 'دن');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'شروع';

  @override
  String get suppEnds => 'ختم';

  @override
  String get suppTomorrow => 'کل';

  @override
  String get suppPickDate => 'تاریخ چنو';

  @override
  String get suppNever => 'کبھی نہیں';

  @override
  String get suppOneWeek => '1 ہفتے میں';

  @override
  String get suppOneMonth => '1 مہینے میں';

  @override
  String get planPickHint => 'اس دن کے لیے منصوبہ چنو، یا نیا بناؤ۔';

  @override
  String planSetForDay(String day) {
    return '$day کے لیے منصوبہ مقرر';
  }

  @override
  String get planSaved => 'منصوبہ محفوظ ہو گیا';

  @override
  String get planDiscardTitle => 'تبدیلیاں ضائع کرو؟';

  @override
  String get planDiscardBody => 'جو تم نے بدلا وہ محفوظ نہیں ہوگا۔';

  @override
  String get planDiscard => 'ضائع کرو';

  @override
  String get planEdit => 'منصوبے میں ترمیم کرو';

  @override
  String get planNameHint => 'منصوبے کا نام';

  @override
  String get planDaysQuestion => 'کون سے دن؟';

  @override
  String get planDaysHint => 'ان دنوں یہ غذائیت میں نظر آتا ہے تاکہ ایک ٹیپ میں درج کر سکو۔';

  @override
  String get planDaysNone => 'کم از کم ایک دن چنو، ورنہ یہ کہیں نظر نہیں آئے گا۔';

  @override
  String get planNothingToLog => 'وہ کھانے پہلے سے درج ہیں';

  @override
  String get planSave => 'منصوبہ محفوظ کرو';

  @override
  String get planToday => 'آج کا منصوبہ';

  @override
  String get planLogRest => 'باقی درج کرو';

  @override
  String get dishNew => 'اپنی ڈش بناؤ';

  @override
  String get dishNewHint => 'اجزاء اور مقداریں چنو، محفوظ کرو اور ایک ٹیپ میں درج کرو۔';

  @override
  String get dishEdit => 'ڈش میں ترمیم کرو';

  @override
  String get dishNameHint => 'مثلاً امی کی دال';

  @override
  String get dishIngredients => 'اجزاء';

  @override
  String get dishEmptyHint => 'جو اس میں جاتا ہے وہ اس مقدار کے ساتھ شامل کرو جو عام طور پر کھائی جاتی ہے۔';

  @override
  String get dishSave => 'ڈش محفوظ کرو';

  @override
  String get dishNeedsName => 'اسے ایک نام دو';

  @override
  String get dishNeedsItems => 'کم از کم ایک جزو شامل کرو';

  @override
  String get suppHistory => 'پچھلے 14 دن';

  @override
  String suppTakenOf(int n, int total) {
    return '$total میں سے $n لیے';
  }

  @override
  String get suppNoReminder => 'کوئی یاد دہانی نہیں';

  @override
  String get suppMarkTaken => 'لیا ہوا نشان زد کرو';

  @override
  String get suppUnmark => 'نشان ہٹاؤ';

  @override
  String get suppEdit => 'ترمیم';

  @override
  String get mealMoveTo => 'یہاں منتقل کرو';

  @override
  String get mealClear => 'کھانا صاف کرو';

  @override
  String get mealCleared => 'کھانا صاف ہو گیا';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count غذائیں منتقل ہوئیں',
      one: '1 غذا منتقل ہوئی',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'پورا دن دہراؤ';

  @override
  String createFoodNamed(String name) {
    return '“$name” بناؤ';
  }

  @override
  String get entryDay => 'دن';

  @override
  String get movedToDay => 'منتقل ہو گیا';

  @override
  String get favFoodsHint => 'کسی غذا پر ☆ ٹیپ کرو';

  @override
  String get favFoodsEmpty => 'کسی بھی غذا کو یہاں ایک ٹیپ کی دوری پر رکھنے کے لیے اس کے ستارے پر ٹیپ کرو۔';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count کھانے', one: '1 کھانا');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'کسی کھانے کو اس کے ••• مینو سے محفوظ کرو، یا اپنی ڈش بناؤ۔';

  @override
  String get sugarLimitLabel => 'چینی کی حد';

  @override
  String get sodiumLimitLabel => 'سوڈیم کی حد';

  @override
  String get waterOptions => 'پانی کے اختیارات';

  @override
  String get waterNone => 'ابھی کوئی پانی درج نہیں۔';

  @override
  String get waterDailyGoal => 'روزانہ پانی';

  @override
  String get trackersScreen => 'اسکرین';

  @override
  String get vesselMotion => 'ہلتا پانی اور شیک';

  @override
  String get vesselMotionHint =>
      'اگر اسکرین سست لگے تو بند کرو: گلاس پھر بھی بھرتے ہیں، بس ہلنا بند ہو جاتا ہے۔';

  @override
  String get planFixedWeek => 'مقررہ ہفتہ';

  @override
  String get planRotation => 'گردش';

  @override
  String get rotationTitle => 'گردش';

  @override
  String get rotationHint => 'اگلی وہی ہے جو تمہاری آخری ورزش کے بعد آتی ہے، دن کوئی بھی ہو۔';

  @override
  String get rotationEmpty => 'اپنی روٹینز اسی ترتیب میں شامل کرو جس میں کرنی ہیں: A، B، C…';

  @override
  String rotationProgress(int done, int total) {
    return 'اس دور میں $total میں سے $done مکمل';
  }

  @override
  String get rotationNext => 'اگلی';

  @override
  String get rotationAdd => 'روٹینز شامل کرو';

  @override
  String get rotationPickHint => 'یہ اسی ترتیب میں جاتی ہیں جس میں تم ٹیپ کرو۔';

  @override
  String get rotationSkip => 'اگلی پر جاؤ';

  @override
  String get rotationRestart => 'نیا دور شروع کرو';

  @override
  String get rotationMakeNext => 'اسے اگلی بناؤ';

  @override
  String get rotationRemove => 'گردش سے ہٹاؤ';

  @override
  String rotationPlace(int n, int total) {
    return 'گردش میں $total میں سے $n';
  }

  @override
  String get moveToDay => 'دوسرے دن پر منتقل کرو';

  @override
  String get moveToDayHint => 'صرف اس بار؛ تمہارا ہفتہ وار منصوبہ ویسا ہی رہے گا۔';

  @override
  String get movedToast => 'ورزش منتقل ہو گئی';

  @override
  String get backToPlan => 'ہفتہ وار منصوبے پر واپس';

  @override
  String get tomorrow => 'کل';

  @override
  String get untrainedTab => 'بغیر ٹریننگ';

  @override
  String get untrainedRecent => 'حالیہ';

  @override
  String get untrainedLong => 'کافی پہلے';

  @override
  String untrainedWaiting(String list) {
    return 'سب سے زیادہ انتظار میں: $list';
  }

  @override
  String get untrainedAllRecent => 'اس ہفتے ہر پٹھے پر کام ہوا۔ بہت خوب۔';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n دن پہلے',
      one: 'کل ٹریننگ ہوئی',
      zero: 'آج ٹریننگ ہوئی',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'ابھی ٹریننگ نہیں ہوئی';

  @override
  String get layoutSetting => 'ورزش کا لے آؤٹ';

  @override
  String get layoutCards => 'کارڈز';

  @override
  String get layoutList => 'فہرست';

  @override
  String get layoutHint =>
      'کارڈز ایک وقت میں ایک ورزش دکھاتے ہیں۔ فہرست پوری ورزش ایک اسکرین پر، سیٹ بہ سیٹ دکھاتی ہے۔';

  @override
  String get layoutRowHint => 'ایک وقت میں ایک ورزش، یا پوری ورزش فہرست کے طور پر';

  @override
  String get previousCol => 'پچھلا';

  @override
  String get usePrevious => 'پچھلی بار کے نمبر استعمال کرو';

  @override
  String get skipShort => 'چھوڑو';

  @override
  String get moveUp => 'اوپر لے جاؤ';

  @override
  String get moveDown => 'نیچے لے جاؤ';

  @override
  String get widgetNutritionOff => 'یہ ویجٹ استعمال کرنے کے لیے ترتیبات › بیٹا میں غذائیت آن کرو۔';

  @override
  String get widgetPickShake => 'اپنا شیک چنو';

  @override
  String get heatRangeSetting => 'سرگرمی کا کیلنڈر';

  @override
  String get heatRangeWeeks => '12 ہفتے';

  @override
  String get heatRangeYear => '12 مہینے';

  @override
  String get heatRangeHint =>
      '12 مہینے پورا سال دکھاتا ہے۔ پیچھے جانے کے لیے ایک طرف سوائپ کرو، اپنی پہلی ورزش تک۔';

  @override
  String get pdfPlan => 'منصوبہ PDF میں';

  @override
  String get pdfPlanHint => 'تمہارے ہفتے اور ہر روٹین کے ساتھ ایک صاف صفحہ، پرنٹ کرنے یا بھیجنے کے لیے تیار۔';

  @override
  String get pdfExport => 'PDF میں ایکسپورٹ کرو';

  @override
  String get pdfFooter => 'مفت، اوپن سورس اور آف لائن';

  @override
  String get shakeTag => 'یہ شیک ہے';

  @override
  String get shakeTagHint => 'یہ تمہارا شیک میں نظر آتا ہے';

  @override
  String get shakeNone => 'اپنے شیک نشان زد کرو اور یہاں صرف وہی نظر آئیں گے۔';

  @override
  String get shakeMarkLabel => 'شیک کے طور پر نشان زد کرو';

  @override
  String get shakeNew => 'نیا شیک';

  @override
  String get shakeUntag => 'شیک نہیں';

  @override
  String get pdfKicker => 'ٹریننگ کا منصوبہ';

  @override
  String get pdfStatDays => 'دن / ہفتہ';

  @override
  String get pdfStatMinutes => 'منٹ / ورزش';

  @override
  String pdfMinutes(int n) {
    return '≈ $n منٹ';
  }

  @override
  String get workoutNotesTitle => 'ورزش کے نوٹس';

  @override
  String get workoutNoteEvery => 'ہر بار';

  @override
  String get workoutNoteNext => 'اگلی بار';

  @override
  String get workoutNoteEveryHint => 'ہر بار یہ ورزش کرنے پر نظر آتا ہے۔ سیٹ یا پُلی کی ترتیب کے لیے اچھا۔';

  @override
  String get workoutNoteNextHint => 'صرف اگلی بار نظر آتا ہے، پھر چلا جاتا ہے۔';

  @override
  String workoutNoteFromLast(String date) {
    return 'پچھلی بار سے · $date';
  }

  @override
  String get workoutNoteHint => 'سیٹ سوراخ 2 میں، پُلی 19 پر…';

  @override
  String get notePinWorkout => 'ورزش کے دوران دکھاؤ';

  @override
  String get assistedSetting => 'معاون مشین';

  @override
  String get assistedSettingHint =>
      'وزن تمہاری مدد کرتا ہے، اس لیے کم بہتر ہے: تمہارے ریکارڈ اور تجاویز نیچے جاتی ہیں۔';

  @override
  String get assistedRecordHint => 'سب سے کم مدد';

  @override
  String get trainAgainLabel => 'ابھی ٹریننگ نہیں ہوئی؟ پھر یاد دلاؤ';

  @override
  String get trainAgainOff => 'نہیں';

  @override
  String trainAgainAfter(int n) {
    return '+$n گھ';
  }

  @override
  String get trainAgainHint => 'صرف ایک بار، اور صرف اگر اس دن کوئی ورزش درج نہ ہوئی ہو۔';

  @override
  String get notifTrainAgainBody => 'آج ٹریننگ کے لیے ابھی وقت ہے۔';

  @override
  String nextDeload(int n) {
    return 'ہلکا: لگاتار $n ورزشیں ہر ریپ کے بغیر';
  }

  @override
  String get historyTitle => 'تاریخچہ';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ورزشیں', one: '1 ورزش');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'اس مہینے کوئی ورزش نہیں';

  @override
  String get historyEmptyHint => 'دوسرے مہینے دیکھنے کے لیے ایک طرف سوائپ کرو یا تیر استعمال کرو۔';

  @override
  String historyMore(int n) {
    return '+$n مزید';
  }

  @override
  String get stopwatch => 'اسٹاپ واچ';

  @override
  String get proteinSource => 'پروٹین کا ذریعہ';

  @override
  String get proteinMixedShort => 'ملا جلا';

  @override
  String get kcalActive => 'فعال';

  @override
  String get kcalEstimated => 'اندازاً';

  @override
  String get kcalYours => 'تمہاری قدر';

  @override
  String kcalTotalRest(String value) {
    return 'کل $value، آرام میں جلنے والی سمیت';
  }

  @override
  String get inclineLabel => 'ڈھلوان';

  @override
  String get kcalUseOwn => 'میری قدر استعمال کرو';

  @override
  String get kcalBackToEstimate => 'اندازے پر واپس';

  @override
  String get kcalNeedsData => 'کیلوریز کا اندازہ لگانے کے لیے فاصلہ اور وقت شامل کرو';

  @override
  String get kcalHowEstimated => 'فاصلے، وقت، ڈھلوان اور تمہارے وزن سے اندازہ (ACSM فارمولا)۔';

  @override
  String get kcalOwnTitle => 'فعال کیلوریز';

  @override
  String get planMine => 'میرا منصوبہ';

  @override
  String get planNew => 'نیا منصوبہ';

  @override
  String get planSaveWeek => 'یہ ہفتہ محفوظ کرو';

  @override
  String get planSaveWeekHint => 'موجودہ ہفتہ ایک منصوبے کے طور پر رکھو جس پر واپس آ سکو';

  @override
  String get planEmptyWeek => 'خالی ہفتہ شروع کرو';

  @override
  String get planEmptyWeekHint => 'تمہارا موجودہ ہفتہ منصوبے کے طور پر محفوظ رہے گا';

  @override
  String get planName => 'منصوبے کا نام';

  @override
  String get planRename => 'نام بدلو';

  @override
  String get planDelete => 'منصوبہ حذف کرو';

  @override
  String get plansHint => 'ہفتے کی تبدیلیاں منتخب منصوبے میں محفوظ ہوتی ہیں';

  @override
  String get progression => 'پیش رفت';

  @override
  String get progManual => 'دستی';

  @override
  String get progManualHint => 'کوئی تجویز نہیں: ہر وزن خود چنو۔';

  @override
  String get progLinear => 'لکیری';

  @override
  String get progLinearHint => 'ہر ریپ پورا کرو اور وزن بڑھ جائے گا۔';

  @override
  String get progDouble => 'دوہری پیش رفت';

  @override
  String get progDoubleHint => 'حد کے اوپر تک زیادہ ریپس، پھر زیادہ وزن۔';

  @override
  String get progVolume => 'ریپس، سیٹ اور وزن';

  @override
  String get progVolumeHint => 'ریپس اوپر تک، پھر ایک اور سیٹ، پھر زیادہ وزن۔';

  @override
  String get progAmrap => 'آخری سیٹ پوری طاقت سے';

  @override
  String get progAmrapHint => 'آخری سیٹ: جتنے ریپ ہو سکیں۔ ہدف کا دوگنا کرو اور یہ دو بار بڑھتا ہے۔';

  @override
  String get progStep => 'وزن کا اضافہ';

  @override
  String get progRange => 'ریپس کی حد';

  @override
  String get progSets => 'سیٹ';

  @override
  String get progDeload => 'اس کے بعد ہلکا';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n چوکیں', one: '1 چوک');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'اتنا ہلکا کرو';

  @override
  String get progApply => 'اگلی ورزش بھرو';

  @override
  String get progApplyHint => 'بند ہو تو صرف تجویز کے طور پر نظر آتا ہے۔';

  @override
  String get nextMoreReps => 'وہی وزن، ایک ریپ زیادہ';

  @override
  String get nextAddSet => 'ایک اور سیٹ';

  @override
  String get nextAmrap => 'آخری سیٹ: جتنے ہو سکیں';

  @override
  String fillDay(String amount) {
    return 'اپنا دن بھرو · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'تمہارے پاس $kcal باقی رہیں گی';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'تمہارے پاس $kcal اور $grams گرام پروٹین باقی رہے گا';
  }

  @override
  String leftAfterOver(String kcal) {
    return 'ہدف سے $kcal زیادہ';
  }

  @override
  String perDayUnit(String unit) {
    return 'روزانہ $unit';
  }

  @override
  String get byZone => 'حصے کے لحاظ سے';

  @override
  String get importAlreadyHave =>
      'یہ روٹینز تمہارے پاس پہلے سے ہیں۔ انہیں نقل کے طور پر دوبارہ شامل کیا جا سکتا ہے۔';

  @override
  String get importAsCopy => 'نقل کے طور پر شامل کرو';

  @override
  String get importOwned => 'پہلے سے تمہاری';

  @override
  String get setDuplicated => 'سیٹ کی نقل بن گئی';

  @override
  String get setTypeCluster => 'کلسٹر';

  @override
  String get setTypeClusterInfo =>
      'ایک سیٹ چھوٹے حصوں میں بٹا ہوا جن کے درمیان 15–30 سیکنڈ ہوں۔ کل ریپس درج کرو۔';

  @override
  String timesBodyweight(String value) {
    return 'تمہارے جسمانی وزن کا $value×';
  }

  @override
  String get archiveRoutine => 'روٹین آرکائیو کرو';

  @override
  String get routineArchived => 'روٹین آرکائیو ہو گئی';

  @override
  String get archivedRoutines => 'آرکائیو';

  @override
  String get autoBackup => 'خودکار بیک اپ';

  @override
  String get autoBackupHint =>
      'تمہارے سارے ڈیٹا کے ساتھ ایک ZIP تمہارے چنے ہوئے فولڈر میں محفوظ کرتا ہے۔ فون سے باہر ایک نقل رکھنے کے لیے Nextcloud، Syncthing یا کسی بھی سنک ایپ کو اس فولڈر پر لگاؤ۔';

  @override
  String get autoBackupFolder => 'فولڈر چنو';

  @override
  String get autoBackupNoFolder => 'ابھی کوئی فولڈر نہیں';

  @override
  String get autoBackupOff => 'بند';

  @override
  String get autoBackupWorkout => 'ہر ورزش کے بعد';

  @override
  String get autoBackupDaily => 'دن میں ایک بار';

  @override
  String get autoBackupWeekly => 'ہفتے میں ایک بار';

  @override
  String get autoBackupOnLeave => 'ایپ چھوڑنے پر';

  @override
  String get autoBackupKeep => 'رکھنے والی نقلیں';

  @override
  String get autoBackupNow => 'ابھی بیک اپ لو';

  @override
  String autoBackupLast(String when) {
    return 'آخری بیک اپ $when';
  }

  @override
  String get autoBackupNever => 'ابھی کوئی بیک اپ نہیں';

  @override
  String get autoBackupLost => 'آخری بیک اپ محفوظ نہیں ہو سکا۔ فولڈر دوبارہ چنو۔';

  @override
  String get autoBackupSaved => 'بیک اپ محفوظ ہو گیا';

  @override
  String get prepPortions => 'حصے';

  @override
  String get rotationAddRest => 'آرام کا دن شامل کرو';

  @override
  String get rotationRestHint => 'اگلے دن خود آگے بڑھ جاتا ہے';

  @override
  String get rotationRestToday => 'آج';

  @override
  String get rotationSkipRest => 'یہ آرام کا دن چھوڑو';

  @override
  String rotationRestUpNext(String name) {
    return 'اگلی: $name';
  }

  @override
  String get trainAnyway => 'پھر بھی ٹریننگ کرو';

  @override
  String get healthTitle => 'صحت';

  @override
  String get healthSetting => 'صحت کا ڈیٹا';

  @override
  String get healthSettingHint => 'پیش رفت میں Health Connect کا ڈیٹا';

  @override
  String get healthPickTitle => 'صحت کا ڈیٹا';

  @override
  String get healthPickHint =>
      'چنو کہ Health Connect سے کیا لانا ہے۔ Android ہر ایک کے لیے ایک بار پوچھتا ہے۔ یہ صرف پڑھا جاتا ہے، اور کبھی تمہارے فون سے باہر نہیں جاتا۔';

  @override
  String get healthGroupHeart => 'دل';

  @override
  String get healthGroupVitals => 'اہم علامات';

  @override
  String get healthGroupActivity => 'سرگرمی';

  @override
  String get healthRestingHr => 'آرام کی حالت میں دل کی دھڑکن';

  @override
  String get healthHeartRate => 'اوسط دل کی دھڑکن';

  @override
  String get healthHrv => 'دل کی دھڑکن میں تغیر';

  @override
  String get healthSpo2 => 'خون میں آکسیجن';

  @override
  String get healthRespiration => 'سانس کی رفتار';

  @override
  String get healthBloodPressure => 'بلڈ پریشر';

  @override
  String get healthTemperature => 'جسم کا درجہ حرارت';

  @override
  String get healthSleep => 'نیند';

  @override
  String get healthDistance => 'فاصلہ';

  @override
  String get healthFloors => 'چڑھی گئی منزلیں';

  @override
  String get healthElevation => 'حاصل کی گئی بلندی';

  @override
  String get healthActiveKcal => 'فعال کیلوریز';

  @override
  String get healthNoData => 'ابھی کوئی ڈیٹا نہیں';

  @override
  String get healthReadFailed => 'پڑھا نہیں جا سکا';

  @override
  String get healthAllow => 'اجازت کے لیے ٹیپ کرو';

  @override
  String get healthLast7 => 'پچھلے 7 دن';

  @override
  String get healthAvg30 => '30 دن کی اوسط';

  @override
  String get healthLow => 'سب سے کم';

  @override
  String get healthHigh => 'سب سے زیادہ';

  @override
  String get healthFrom => 'Health Connect سے · پچھلے 30 دن';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'سانس/منٹ';

  @override
  String get weekTab => 'ہفتہ';

  @override
  String get muscleSetsList => 'فی پٹھا سیٹ';

  @override
  String get fatTrans => 'ٹرانس';

  @override
  String get fatTypesHint => 'اختیاری۔ جو لیبل پر نہ ہو اسے خالی چھوڑ دو۔';

  @override
  String get sessionPhotos => 'ورزش کی تصاویر';

  @override
  String get sessionPhotosAdd => 'تصاویر شامل کرو';

  @override
  String get sessionPhotosHint => 'یہ تمہاری تصاویر میں بھی رکھی جاتی ہیں۔';

  @override
  String get ladderTitle => 'پیش رفت';

  @override
  String get ladderHint =>
      'مراحل کو آسان سے مشکل تک ترتیب دو۔ جب تم لگاتار دو سیشن میں 8 کے 3 سیٹ کرو (سست والوں میں 5)، GymMane اگلا مرحلہ پیش کرتا ہے۔';

  @override
  String get ladderBuiltIn =>
      'ایپ کی پیش رفت سے شروع ہوتی ہے۔ مراحل شامل کرو، ہٹاؤ یا ترتیب بدلو اور یہ اس روٹین کی اپنی بن جائے گی۔';

  @override
  String get ladderNone => 'ابھی کوئی نہیں۔ بنانے کے لیے ٹیپ کرو۔';

  @override
  String ladderStep(int n, int total) {
    return 'مرحلہ $n از $total';
  }

  @override
  String get ladderAdd => 'مرحلہ شامل کرو';

  @override
  String get ladderInRoutine => 'روٹین میں';

  @override
  String get ladderClear => 'ایپ کی پیش رفت استعمال کرو';

  @override
  String get ladderPick => 'ایک مرحلہ چنو';

  @override
  String get periodWeek => 'اس ہفتے';

  @override
  String get periodMonth => 'اس مہینے';

  @override
  String get periodYear => 'اس سال';

  @override
  String get periodAll => 'ہمیشہ سے';

  @override
  String get settingsSearch => 'ترتیبات تلاش کرو';

  @override
  String get settingsNoResults => 'اس نام کی کوئی ترتیب نہیں';

  @override
  String get settingsGroupApp => 'تمہاری ایپ';

  @override
  String get settingsGroupHome => 'ہوم اور اضافی';

  @override
  String get settingsGroupData => 'ڈیٹا اور مدد';

  @override
  String get healthAllowAll => 'سب آن کرو';

  @override
  String get healthSeeAll => 'سب دیکھو';

  @override
  String get healthPinTitle => 'کارڈ پر';

  @override
  String get healthPinHint => 'پیش رفت کارڈ کے لیے 3 تک چنو۔';

  @override
  String get blurSetting => 'دھندلے اثرات';

  @override
  String get blurSettingHint => 'اگر فون سست لگے تو بند کرو';

  @override
  String get lowEndTitle => 'تمہارے فون میں میموری کم ہے';

  @override
  String get lowEndBody =>
      'دھندلاہٹ بند کرنے سے اس پر سب کچھ زیادہ ہموار ہو جاتا ہے۔ ترتیبات → عمومی میں اسے واپس لایا جا سکتا ہے۔';

  @override
  String get lowEndOff => 'دھندلاہٹ بند کرو';

  @override
  String get lowEndKeep => 'رہنے دو';

  @override
  String get momentsThisMonth => 'اس مہینے';

  @override
  String get momentsDays => 'تصویر والے دن';

  @override
  String get awardsPick => 'اپنے پروفائل کے لیے چنو';

  @override
  String get awardsPickHint => 'جو اپنے پروفائل پر چاہیے ان پر ٹیپ کرو';

  @override
  String get gymPassPicture => 'کوڈ کی تصویر محفوظ کرو';

  @override
  String get gymPassPictureHint =>
      'ان کوڈز کے لیے جو ایپ نہیں پڑھ سکتی: یہ تمہاری تصویر پوری روشنی میں دکھاتی ہے';

  @override
  String get gymPassPictureFormat => 'تصویر';

  @override
  String get gymPassUsePicture => 'تصویر محفوظ کرو';

  @override
  String get gymPassChangePicture => 'تصویر بدلو';

  @override
  String get cropTitle => 'کوڈ کو کاٹو';

  @override
  String get cropHint => 'کونے کھینچو تاکہ صرف کوڈ اندر رہے';

  @override
  String get rotatePhoto => 'گھماؤ';

  @override
  String get cardioNoSets => 'کارڈیو فی پٹھا ہفتہ وار سیٹوں میں شامل نہیں ہوتا';

  @override
  String get countsAsWater => 'پانی میں شمار ہوتا ہے';

  @override
  String get countsAsWaterHint => 'پانی سے بنے شیک کے لیے: درج کرنے سے تمہارا پانی بھی بڑھتا ہے';

  @override
  String get waterPerServing => 'فی سرونگ پانی';

  @override
  String get estOneRm => 'اندازاً 1RM';

  @override
  String get newInWorkout => 'اس ورزش میں نئی';

  @override
  String newInWorkoutHint(String routine) {
    return 'ابھی کیے ہوئے سیٹوں کے ساتھ اسے $routine میں شامل کرو۔ باقی روٹین ویسی ہی رہے گی۔';
  }

  @override
  String get addedToRoutine => 'شامل ہو گئی';

  @override
  String get addShort => 'شامل کرو';

  @override
  String get allTimeLifted => 'اٹھایا';

  @override
  String get pctBodyweight => '% جسمانی وزن';

  @override
  String get ofBodyweight => 'تمہارے جسمانی وزن کا';

  @override
  String get recoveryStateMid => 'بحال ہو رہا ہے';

  @override
  String get recoveryStateReady => 'تیار';

  @override
  String recoveringIn(String time) {
    return '$time میں بحال';
  }

  @override
  String readyIn(String time) {
    return '$time میں تیار';
  }

  @override
  String get recoveryReadyNow => 'دوبارہ ٹریننگ کے لیے تیار';

  @override
  String get restAfterThisSet => 'اس سیٹ کے بعد آرام';

  @override
  String restUsual(String time) {
    return 'معمول: $time';
  }

  @override
  String get restJustToday => 'صرف اس سیٹ کے لیے، آج';

  @override
  String get restUseUsual => 'معمول کے آرام پر واپس';

  @override
  String get restChange => 'بدلو';

  @override
  String get noRestTimer => 'ٹائمر نہیں';

  @override
  String get sessionMuscles => 'اس ورزش کے پٹھے';

  @override
  String get sessionMusclesHint => 'مدھم ابھی باقی ہے، روشن مکمل ہے۔ فی پٹھا سیٹ، ثانوی آدھے گنے جاتے ہیں۔';

  @override
  String get miniBodySetting => 'روٹینز پر چھوٹا جسمانی نقشہ';

  @override
  String get miniBodySettingHint => 'ہر روٹین کن پٹھوں پر کام کرتی ہے';

  @override
  String get balanceTitle => 'طاقت کا توازن';

  @override
  String get balanceWhy => 'یہ کیسے کام کرتا ہے';

  @override
  String get balanceGood => 'تمہارے بنیادی لفٹ توازن میں ہیں';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift پیچھے ہے: برابر آنے کو تقریباً $gap';
  }

  @override
  String get balanceHint =>
      'پچھلے 4 مہینوں کے تمہارے اندازاً 1RM کا کلاسیک تناسب سے موازنہ کرتا ہے: اسکواٹ 100%، ڈیڈ لفٹ 120%، بینچ 75%، رو 52%، اوور ہیڈ پریس 45%۔ جو لفٹ باقیوں سے بہت نیچے ہو وہ عموماً کمزور جگہ ہوتی ہے جس پر مزید کام چاہیے۔';

  @override
  String get balanceEven => 'توازن میں';

  @override
  String get balanceBehindShort => 'پیچھے';

  @override
  String get balanceAheadShort => 'آگے';

  @override
  String get holdProgress => 'وقت سے پیش رفت';

  @override
  String get holdProgressHint => 'جب ہر سیٹ پورا روکے رکھو تو سیکنڈ بڑھاتا ہے';

  @override
  String holdProgressOn(int s) {
    return 'ہر سیٹ پورا روکنے پر ہر بار +$s سیکنڈ';
  }

  @override
  String get paceTitle => 'ہفتہ وار رفتار';

  @override
  String get paceOn => 'رفتار ٹھیک ہے';

  @override
  String get paceTooFast => 'تمہاری مقرر کردہ حد سے تیز';

  @override
  String get paceTooSlow => 'تمہاری مقرر کردہ حد سے سست';

  @override
  String get paceWrongWay => 'الٹی سمت جا رہا ہے';

  @override
  String get paceDrifting => 'برقرار رکھنے کی حد سے زیادہ بدل رہا ہے';

  @override
  String get paceSetAim => 'اپنا ہدف مقرر کرنے کے لیے ٹیپ کرو';

  @override
  String get paceBasis => 'پچھلے 3 ہفتوں کے وزن کا رجحان، تاکہ ایک نمکین رات کا کھانا اسے دھوکا نہ دے سکے۔';

  @override
  String get paceAimTitle => 'ہدف کیا ہے؟';

  @override
  String get paceAimHint => 'کارڈ بتاتا ہے کہ تمہاری ہفتہ وار رفتار اس سے میل کھاتی ہے یا نہیں';

  @override
  String get paceLose => 'کم کرنا';

  @override
  String get paceHold => 'برقرار رکھنا';

  @override
  String get paceGain => 'بڑھانا';

  @override
  String get paceAuto => 'خودکار';

  @override
  String get paceLoseRange => 'ہفتے میں وزن کا 0.5 سے 1%';

  @override
  String get paceHoldRange => 'ہفتے میں 0.25% کے اندر';

  @override
  String get paceGainRange => 'ہفتے میں وزن کا 0.25 سے 0.5%';

  @override
  String get paceAutoHint => 'تمہارے ہدف وزن سے';

  @override
  String get weekShort => 'ہفتہ';

  @override
  String get weightStack => 'وزن کا اسٹیک';

  @override
  String get weightStackHint =>
      'وہ وزن جو اس مشین میں واقعی ہیں۔ + اور − بٹن، پیش رفت اور ڈی لوڈ صرف انہی پر آتے ہیں۔';

  @override
  String get weightStackOff => 'بند: عام وزن کے قدم';

  @override
  String get stackFrom => 'سے';

  @override
  String get stackTo => 'تک';

  @override
  String get stackEvery => 'ہر';

  @override
  String get stackFill => 'اسٹیک بھرو';

  @override
  String get stackTapToFix => 'کسی عجیب وزن کو درست کرنے یا ہٹانے کے لیے اس پر ٹیپ کرو۔';

  @override
  String get stackAddWeight => 'وزن شامل کرو';

  @override
  String get stackEditWeight => 'پن پر وزن';

  @override
  String get stackClear => 'اسٹیک ہٹاؤ';

  @override
  String stackCount(int n) {
    return '$n وزن';
  }

  @override
  String get healthLinksTitle => 'تمہاری ورزشوں کے ساتھ';

  @override
  String get healthLinkHeart => 'گھڑی سے دل کی دھڑکن';

  @override
  String get healthLinkHeartHint => 'ہر ورزش کی اوسط اور زیادہ سے زیادہ دل کی دھڑکن، جو بھی گھڑی ریکارڈ کرے';

  @override
  String get healthLinkWeight => 'دوسری ایپس سے وزن';

  @override
  String get healthLinkWeightHint => 'پچھلے 30 دنوں کے تمہارے ترازو کے وزن۔ تمہارا لکھا ہوا کبھی نہیں بدلتا۔';

  @override
  String get healthLinkDenied => 'Health Connect نے اجازت نہیں دی';

  @override
  String get healthOpenSettings => 'کھولو';

  @override
  String hrMaxShort(int bpm) {
    return 'زیادہ سے زیادہ $bpm';
  }

  @override
  String get setNote => 'اس سیٹ کا نوٹ';

  @override
  String get setNoteHint => 'گرفت، درد، کام آنے والا اشارہ…';

  @override
  String setNoteLast(String note) {
    return 'پچھلی بار: $note';
  }

  @override
  String get lastTimeNotes => 'پچھلی بار';

  @override
  String setNoteLine(int n, String note) {
    return 'سیٹ $n · $note';
  }

  @override
  String get newMeasure => 'نئی پیمائش';

  @override
  String get newMeasureHint => 'جس پر بھی نظر رکھنی ہو: کلائی، آرام کی نبض، جسم کا پانی…';

  @override
  String get measureKindLength => 'لمبائی';

  @override
  String get measureKindLengthHint => 'سم یا انچ میں، باقیوں کی طرح';

  @override
  String get measureKindOther => 'دیگر';

  @override
  String get measureKindOtherHint => 'اپنی اکائی کے ساتھ';

  @override
  String get measureUnit => 'اکائی';

  @override
  String get measureUnitHint => 'ملی میٹر، bpm، کلو…';

  @override
  String get measureNameHint => 'کلائی، آرام کی نبض…';

  @override
  String get measureRename => 'نام بدلو';

  @override
  String measureDeleteTitle(String name) {
    return '$name حذف کرو؟';
  }

  @override
  String get measureDeleteBody => 'اس کے لیے درج کی گئی ہر قدر بھی چلی جائے گی۔';

  @override
  String get measureDelete => 'یہ پیمائش حذف کرو';

  @override
  String get measureEvery => 'پیمائش کی یاد دلاؤ';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n دن میں', one: 'کل', zero: 'آج');
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'پیمائش کا وقت';

  @override
  String get notifMeasureChannel => 'جسمانی پیمائشیں';

  @override
  String get notifMeasureChannelWhy => 'دوبارہ پیمائش کا وقت ہونے پر یاد دہانی۔';

  @override
  String get notifMeasureTitle => 'پیمائش کا وقت';

  @override
  String notifMeasureBody(int n) {
    return 'پچھلی بار کے بعد $n دن۔ وہی جگہ، دن کا وہی وقت۔';
  }

  @override
  String get healthLinkWrite => 'اپنی ورزشیں محفوظ کرو';

  @override
  String get healthLinkWriteHint =>
      'ہر مکمل ورزش اپنے وقت اور قسم کے ساتھ Health Connect میں جاتی ہے، تاکہ دوسری ایپس بھی اسے گنیں۔ پچھلے 30 دن بھی بھیجتا ہے۔';

  @override
  String get healthWorkoutTitle => 'ورزش';

  @override
  String get circuits => 'وقت والے سرکٹ';

  @override
  String get circuitsHint => 'گھڑی کے حساب سے کام اور آرام، دور کے بعد دور';

  @override
  String get newCircuit => 'نیا سرکٹ';

  @override
  String get editCircuit => 'سرکٹ میں ترمیم کرو';

  @override
  String get circuitDefaultName => 'سرکٹ';

  @override
  String get circuitNameHint => 'نام، جیسے کور فنشر';

  @override
  String get circuitRounds => 'دور';

  @override
  String get circuitRoundRest => 'دوروں کے درمیان آرام';

  @override
  String get circuitWork => 'کام';

  @override
  String get circuitRest => 'آرام';

  @override
  String get circuitAdd => 'ورزش شامل کرو';

  @override
  String get circuitEmpty =>
      'ورزشیں اسی ترتیب میں شامل کرو جس میں کرنی ہیں۔ ایک دو بار بھی آ سکتی ہے، جیسے ہر طرف کے لیے سائیڈ پلانک۔';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(steps, locale: localeName, other: '$steps ورزشیں', one: '1 ورزش');
    String _temp1 = intl.Intl.pluralLogic(rounds, locale: localeName, other: '$rounds دور', one: '1 دور');
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'شروع';

  @override
  String get circuitGetReady => 'تیار ہو جاؤ';

  @override
  String circuitRoundOf(int n, int total) {
    return 'دور $n از $total';
  }

  @override
  String circuitNext(String name) {
    return 'اگلی: $name';
  }

  @override
  String get circuitFinishLine => 'آخری، پھر مکمل';

  @override
  String get circuitDone => 'سرکٹ مکمل';

  @override
  String circuitDoneBody(String time) {
    return '$time · تمہارے تاریخچے میں محفوظ';
  }

  @override
  String get circuitStopTitle => 'سرکٹ روکو؟';

  @override
  String get circuitStopBody => 'اب تک جو کیا وہ تمہارے تاریخچے میں محفوظ ہو جائے گا۔';

  @override
  String get circuitStop => 'روکو';

  @override
  String get circuitKeepGoing => 'جاری رکھو';

  @override
  String circuitDeleteTitle(String name) {
    return '$name حذف کرو؟';
  }

  @override
  String get circuitDeleteBody => 'اس کے ساتھ کی ہوئی ورزشیں تمہارے تاریخچے میں رہیں گی۔';

  @override
  String get circuitPickExercise => 'ایک ورزش چنو';

  @override
  String get circuitNoSteps => 'کم از کم ایک ورزش شامل کرو';

  @override
  String get circuitPrevious => 'پچھلی';

  @override
  String get circuitUpNext => 'اگلی';

  @override
  String get foodGroupNew => 'نیا زمرہ';

  @override
  String get foodGroupHint => 'تیار کھانے، منجمد…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n غذائیں',
      one: '1 غذا',
      zero: 'ابھی کوئی غذا نہیں',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return '$name حذف کرو؟';
  }

  @override
  String get foodGroupDeleteBody => 'تمہاری غذائیں رہیں گی، بس اس زمرے کے بغیر۔';

  @override
  String onbHello(String name) {
    return 'ہیلو، $name';
  }

  @override
  String get onbPlaceHero => 'ورزشیں جو ممکن ہیں';

  @override
  String get settingsRests => 'آرام';

  @override
  String get settingsDuring => 'ٹریننگ کے دوران';

  @override
  String get settingsLook => 'یہ کیسا دکھتا ہے';

  @override
  String get importCardTitle => 'اپنی ورزشیں یہاں لاؤ';

  @override
  String get importCardBody => 'Hevy، Strong، FitNotes اور مزید سے';

  @override
  String get checkInTitle => 'آج کیسا رہا؟';

  @override
  String get checkInSleep => 'نیند';

  @override
  String get checkInEnergy => 'توانائی';

  @override
  String get checkInSkip => 'اختیاری';

  @override
  String get checkInLevel1 => 'بہت برا';

  @override
  String get checkInLevel2 => 'برا';

  @override
  String get checkInLevel3 => 'ٹھیک';

  @override
  String get checkInLevel4 => 'اچھا';

  @override
  String get checkInLevel5 => 'بہترین';

  @override
  String get checkInSetting => 'نیند اور توانائی';

  @override
  String get checkInSettingHint => 'ورزش ختم ہونے پر پوچھو';

  @override
  String get readinessTitle => 'نیند اور توانائی';

  @override
  String get readinessWaiting => 'اپنی ورزشوں کی درجہ بندی جاری رکھو';

  @override
  String get readinessWaitingHint =>
      'چند اچھے اور برے دنوں کے بعد نظر آئے گا کہ یہ تمہارے لفٹ کیسے بدلتے ہیں۔';

  @override
  String readinessSleepLess(int n) {
    return 'کم نیند والے دنوں میں لفٹ $n% کم ہوتی ہے';
  }

  @override
  String readinessSleepMore(int n) {
    return 'دلچسپ: کم نیند والے دنوں میں لفٹ $n% زیادہ ہوتی ہے';
  }

  @override
  String get readinessSleepNone => 'نیند سے تمہاری لفٹ میں مشکل سے فرق پڑتا ہے';

  @override
  String readinessEnergyLess(int n) {
    return 'کم توانائی والے دنوں میں لفٹ $n% کم ہوتی ہے';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'کم توانائی والے دنوں میں بھی لفٹ $n% زیادہ ہوتی ہے';
  }

  @override
  String get readinessEnergyNone => 'توانائی سے تمہاری لفٹ میں مشکل سے فرق پڑتا ہے';

  @override
  String get readinessHint => 'ہر اندازاً 1RM کا پچھلے 90 دنوں کے تمہارے بہترین سے موازنہ کرتا ہے۔';

  @override
  String get readinessLast30 => 'پچھلے 30 دنوں کی اوسط';

  @override
  String get kindSport => 'کھیل';

  @override
  String get clearWorkouts => 'صرف ورزشیں حذف کرو';

  @override
  String get clearWorkoutsNone => 'حذف کرنے کو کوئی ورزش نہیں';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ورزشیں حذف کرو؟',
      one: '1 ورزش حذف کرو؟',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'تمہارا تاریخچہ، ریکارڈ اور تمغے چلے جائیں گے۔ روٹینز، ورزشیں، تصاویر، پیمائشیں، غذائیت اور ترتیبات رہیں گی۔ اگر شاید واپس چاہیے ہوں تو پہلے بیک اپ ایکسپورٹ کرو۔';

  @override
  String get clearWorkoutsConfirm => 'ورزشیں حذف کرو';

  @override
  String get clearWorkoutsDone => 'ورزشیں حذف ہو گئیں';

  @override
  String get reportTitle => 'رپورٹ';

  @override
  String get reportHint => 'تاریخیں چنو اور PDF یا CSV کے طور پر شیئر کرو';

  @override
  String get reportCustom => 'دیگر';

  @override
  String get reportPickRange => 'تاریخیں چنو';

  @override
  String get reportEmpty => 'ان تاریخوں کے درمیان کچھ درج نہیں۔';

  @override
  String get reportKicker => 'ٹریننگ رپورٹ';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n دن', one: '1 دن');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'ورزشیں';

  @override
  String get reportPerWeek => 'فی ہفتہ';

  @override
  String get reportHours => 'گھنٹے';

  @override
  String get reportVsPrev => 'فیصد کا موازنہ بالکل پہلے کے اتنے ہی دنوں سے ہے۔';

  @override
  String get reportRecords => 'نئے ریکارڈ';

  @override
  String get reportLifts => 'ورزشیں';

  @override
  String get reportSessionsCol => 'دن';

  @override
  String get reportBestCol => 'بہترین 1RM';

  @override
  String get reportChangeCol => 'تبدیلی';

  @override
  String get reportBestHint =>
      'بہترین 1RM تمہارے سیٹوں سے اندازاً ہے۔ تبدیلی اس رپورٹ میں ورزش کے پہلے اور آخری دن کا موازنہ کرتی ہے۔';

  @override
  String get reportMuscles => 'فی پٹھا سیٹ';

  @override
  String get reportBody => 'جسم اور بحالی';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'غذائیت · $n دنوں کی اوسط',
      one: 'غذائیت · 1 دن کی اوسط',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n نئے ریکارڈ', one: '1 نیا ریکارڈ');
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ورزشیں', one: '1 ورزش');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return 'روزانہ $kcal اور $protein گرام پروٹین · $days دن درج';
  }

  @override
  String get reportSharePdf => 'PDF شیئر کرو';

  @override
  String get reportShareCsv => 'CSV ایکسپورٹ کرو';

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
  String get reportShareCsvBoth => 'CSV ایکسپورٹ کرو (ورزشیں اور غذائیت)';

  @override
  String fastMinutes(int n) {
    return '$n منٹ';
  }

  @override
  String fastHours(int n) {
    return '$n گھ';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h گھ $m منٹ';
  }

  @override
  String get fastTracker => 'وقفے وقفے سے روزہ';

  @override
  String fastTitle(int fast, int eat) {
    return 'روزہ $fast:$eat';
  }

  @override
  String get fastOptions => 'روزے کے اختیارات';

  @override
  String get fastWindowOpen => 'کھانے کا وقت کھلا ہے';

  @override
  String get fastLeft => 'باقی';

  @override
  String get fastDoneLabel => 'ہدف پورا';

  @override
  String get fastIdle => 'اپنے آخری کھانے کے بعد شروع کرو';

  @override
  String fastLast(String time) {
    return 'آخری روزہ: $time';
  }

  @override
  String fastStreak(int n) {
    return 'لگاتار $n';
  }

  @override
  String fastReached(String time) {
    return 'ہدف سے $time زیادہ';
  }

  @override
  String fastEndsAt(String time) {
    return '$time پر ختم';
  }

  @override
  String fastSince(String time) {
    return '$time سے';
  }

  @override
  String get fastStartedAt => 'روزہ کب شروع کیا؟';

  @override
  String get fastStart => 'روزہ شروع کرو';

  @override
  String fastFromMeal(String time) {
    return '$time سے';
  }

  @override
  String get fastEnd => 'روزہ ختم کرو';

  @override
  String get fastCancel => 'یہ روزہ منسوخ کرو';

  @override
  String get fastPlan => 'روزے کا منصوبہ';

  @override
  String get fastPlanHint => 'روزے کے گھنٹے : کھانے کے گھنٹے';

  @override
  String get fastThisWeek => 'پچھلے 7 دن';

  @override
  String get fastCount => 'روزے';

  @override
  String get fastReachedCount => 'پورے';

  @override
  String get fastAverage => 'اوسط';

  @override
  String get fastHistory => 'حالیہ روزے';

  @override
  String get notifFastLiveChannel => 'روزہ جاری ہے';

  @override
  String get notifFastLiveChannelWhy => 'روزے کے دوران ایک خاموش الٹی گنتی۔';

  @override
  String get notifFastChannel => 'روزہ';

  @override
  String get notifFastChannelWhy => 'روزہ مکمل ہونے پر بتاتا ہے۔';

  @override
  String get notifFastLiveTitle => 'روزہ';

  @override
  String notifFastLiveBody(String time) {
    return 'کھانے کا وقت $time پر کھلے گا';
  }

  @override
  String get notifFastDoneTitle => 'روزہ مکمل';

  @override
  String notifFastDoneBody(int n) {
    return '$n گھنٹے۔ کھانے کا وقت کھل گیا ہے۔';
  }

  @override
  String get newExerciseHint => 'صرف نام ضروری ہے۔ باقی مدد کرتا ہے، لیکن بعد میں بھی شامل کیا جا سکتا ہے۔';

  @override
  String get supportThanksTitle => 'یہاں ہونے کا شکریہ 🤍';

  @override
  String get supportThanksBody =>
      'GymMane مفت ہے اور ہمیشہ رہے گا، بغیر اشتہارات اور بغیر کچھ چھپائے۔\n\nاگر یہ تمہاری ٹریننگ میں مدد کرتا ہے تو مجھے ایک کافی پلانا میرا دن بنا دیتا ہے ☕\nاور اگر ممکن نہ ہو تو کوئی بات نہیں: GitHub پر ایک اسٹار بھی کافی ہے ⭐';

  @override
  String get perfSetting => 'کارکردگی';

  @override
  String get perfSheetHint => 'GymMane تمہارے فون کا کتنا حصہ استعمال کرتا ہے۔ نیچے ہر حصہ بدلا جا سکتا ہے۔';

  @override
  String get perfLite => 'بچت';

  @override
  String get perfLiteHint => 'دھندلاہٹ نہیں اور پرسکون حرکت۔ مشکل میں رہنے والے فونز کے لیے۔';

  @override
  String get perfBalanced => 'متوازن';

  @override
  String get perfBalancedHint => 'بیٹری ختم کیے بغیر دھندلاہٹ اور اینیمیشن۔';

  @override
  String get perfMax => 'زیادہ سے زیادہ';

  @override
  String perfMaxHint(int hz) {
    return 'باریک دھندلاہٹ اور اسکرین $hz Hz پر۔ اعلیٰ درجے کے فونز کے لیے۔';
  }

  @override
  String get perfMaxHintNoHz => 'ہر جگہ باریک دھندلاہٹ۔ اعلیٰ درجے کے فونز کے لیے۔';

  @override
  String get perfCustom => 'اپنی مرضی';

  @override
  String get perfTweak => 'باریک ترتیب';

  @override
  String get perfFine => 'باریک دھندلاہٹ';

  @override
  String get perfFineHint => 'پینلز کے پیچھے نرم کنارے اور زیادہ صاف پس منظر';

  @override
  String perfHz(int hz) {
    return 'اسکرین $hz Hz پر';
  }

  @override
  String get perfHzHint => 'سب کچھ زیادہ ہموار اسکرول ہوتا ہے، تھوڑی زیادہ بیٹری پر';

  @override
  String get lowEndLiteBody =>
      'بچت موڈ (دھندلاہٹ نہیں، پرسکون حرکت) اس پر زیادہ ہموار چلے گا۔ ترتیبات → عمومی → کارکردگی میں بدلا جا سکتا ہے۔';

  @override
  String get lowEndLiteOn => 'بچت آن کرو';

  @override
  String get dayOffHint => 'تمہارا سلسلہ اور یاد دہانی اس دن کو نہیں چھیڑیں گے';

  @override
  String get dayOffTrained => 'ٹریننگ کی، بس درج نہیں کی';

  @override
  String get dayOffSick => 'بیماری';

  @override
  String get dayOffTravel => 'سفر';

  @override
  String get dayOffInjury => 'چوٹ';

  @override
  String get dayOffRest => 'آرام';

  @override
  String get altsTitle => 'متبادل';

  @override
  String get altsHint => 'اگر مشین مصروف ہو';

  @override
  String altsPickHint(int count) {
    return '$count تک چنو۔ مشین مصروف ہو تو ایک ٹیپ میں بدلو۔';
  }

  @override
  String get placeDumbbells => 'ڈمبل';

  @override
  String get dumbbellsHint => 'ایک ڈمبل کا وزن۔ یہاں پیش رفت اور + اور − بٹن صرف انہی پر آئیں گے۔';

  @override
  String get dumbbellOther => 'دوسرا وزن';

  @override
  String get tuneTitle => 'آج کا حجم';

  @override
  String get tuneHint => 'بتاؤ ہر پٹھا کیسا لگا، اگلی بار کے سیٹ اسی کے مطابق بدل جائیں گے۔';

  @override
  String get tuneLess => 'بہت کم';

  @override
  String get tuneRight => 'ٹھیک';

  @override
  String get tuneMore => 'بہت زیادہ';

  @override
  String tuneNext(String sets, String name) {
    return 'اگلی بار: $name کے $sets';
  }

  @override
  String get tuneSame => 'اگلی بار ویسا ہی رہے گا';

  @override
  String get tuneSetting => 'فی پٹھا سیٹ ایڈجسٹ کرو';

  @override
  String get tuneSettingHint => 'روٹین کے بعد ہر پٹھے کی درجہ بندی کرو اور سیٹ خود ایڈجسٹ ہو جائیں گے';

  @override
  String insightLoad(int pct) {
    return 'تمہارے عام ہفتے سے $pct % زیادہ سیٹ۔ اپنی بحالی کا خیال رکھو۔';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: $days دن سے اچھوتا۔';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'پُش پُل سے زیادہ ہے: چار ہفتوں میں $a سیٹ بمقابلہ $b۔';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'پُل پُش سے زیادہ ہے: چار ہفتوں میں $a سیٹ بمقابلہ $b۔';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: پچھلے مہینے سے $pct % زیادہ مضبوط۔';
  }

  @override
  String recapPull(String month) {
    return 'اپنا $month دیکھنے کے لیے کھینچتے رہو';
  }

  @override
  String get recapRelease => 'چھوڑ دو';

  @override
  String recapHi(String name) {
    return 'ہیلو، $name';
  }

  @override
  String recapReady(String month) {
    return 'دیکھیں $month میں کیا کیا؟';
  }

  @override
  String get recapGo => 'چلو';

  @override
  String recapEmpty(String month) {
    return '$month میں ابھی کوئی ورزش نہیں۔ تمہاری پہلی ورزش اسے کھول دے گی۔';
  }

  @override
  String get recapClose => 'بند کرو';

  @override
  String get recapShare => 'شیئر کرو';

  @override
  String get recapWorkoutsKicker => 'اس مہینے تمہاری ٹریننگ';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ورزشیں', one: 'ورزش');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n مختلف دنوں میں',
      one: 'ایک دن میں',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'بار کے نیچے وقت';

  @override
  String recapLongest(String time, String date) {
    return 'سب سے لمبا سیشن: $time، $date کو';
  }

  @override
  String get recapVolumeKicker => 'تم نے اٹھایا';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$count گاڑیاں اٹھانے جیسا',
      one: 'ایک گاڑی اٹھانے جیسا',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'سب سے زیادہ: $name، $volume';
  }

  @override
  String get recapMuscleKicker => 'مہینے کا پٹھا';

  @override
  String get recapRecordsKicker => 'نئے ریکارڈ';

  @override
  String recapNoRecords(int n) {
    return 'اس بار کوئی ریکارڈ نہیں، لیکن $n سیٹ جمع ہو گئے۔';
  }

  @override
  String get recapHabitKicker => 'تمہارا وقت';

  @override
  String recapHabitStart(String time) {
    return 'عام طور پر شروع $time پر ہوتا ہے';
  }

  @override
  String get recapShareKicker => 'تمہارا مہینہ، شیئر کے لیے تیار';

  @override
  String get recapTickWorkouts => 'ورزشیں';

  @override
  String get recapTickTime => 'وقت';

  @override
  String get recapTickVolume => 'بوجھ';

  @override
  String get recapTickRecords => 'ریکارڈ';

  @override
  String recapAvg(int n) {
    return 'فی ورزش اوسطاً $n منٹ';
  }

  @override
  String get recapLiftKicker => 'مہینے کی ورزش';

  @override
  String get recapBest => 'بہترین';

  @override
  String get recapTimes => 'دن';

  @override
  String get recapDaysLabel => 'دن';

  @override
  String get recapAvgLabel => 'اوسط';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$days دنوں میں $workouts ورزشیں';
  }

  @override
  String get recapFavLabel => 'تمہارا دن';

  @override
  String get recapWatermark => 'مفت جم لاگ';

  @override
  String get recapTickSteps => 'قدم';

  @override
  String get recapTickFood => 'غذا';

  @override
  String get recapCardioKicker => 'کارڈیو';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ورزشوں میں', one: 'ایک ورزش میں');
    return '$_temp0 $minutes منٹ';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n کارڈیو ورزشیں',
      one: 'ایک کارڈیو ورزش',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'تمہاری پسندیدہ: $name';
  }

  @override
  String get recapStepsKicker => 'پیدل چلنا';

  @override
  String get recapStepsWord => 'قدم';

  @override
  String recapStepsAvg(String value) {
    return 'روزانہ اوسطاً $value';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'بہترین دن: $value، $date';
  }

  @override
  String get recapFoodKicker => 'تمہاری پلیٹ میں';

  @override
  String get recapLiftRest => 'ٹھیک پیچھے';

  @override
  String recapSameAs(String month) {
    return '$month جیسا ہی';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$month سے $value زیادہ';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$month سے $value کم';
  }

  @override
  String get recapTickMedals => 'تمغے';

  @override
  String get recapTickSleep => 'نیند';

  @override
  String get recapMedalsKicker => 'تمہارے جیتے تمغے';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'اور $n', one: 'اور ایک');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'تمہاری نیند';

  @override
  String get recapSleepAvg => 'فی رات اوسطاً';

  @override
  String recapSleepBest(String value, String date) {
    return 'بہترین رات: $value، $date';
  }

  @override
  String get recapCardSummary => 'خلاصہ';

  @override
  String get recapCardCalendar => 'کیلنڈر';

  @override
  String get recapCardLift => 'ورزش';

  @override
  String get recapPeakKicker => 'تمہارا سب سے مشکل سیشن';

  @override
  String get recapTickPeak => 'سیشن';

  @override
  String get recapFreshKicker => 'اس مہینے پہلی بار';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'نئی ورزشیں', one: 'نئی ورزش');
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'نئی';

  @override
  String recapStreak(int n) {
    return 'لگاتار $n دن، تمہارا سب سے لمبا سلسلہ';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ورزشیں', one: '1 ورزش');
    return 'ایک سال پہلے: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'اس مہینے رہ گیا: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'روزانہ پروٹین · ہدف $goal گرام';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n دن تمہاری پلیٹ میں',
      one: '1 دن تمہاری پلیٹ میں',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'پروٹین · گرام/دن';

  @override
  String get recapFoodGoalDays => 'ہدف پورا';

  @override
  String get recapFoodWaterLabel => 'پانی/دن';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n دن', one: '1 دن');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'مہینے کی تمہاری غذا';

  @override
  String get onbSpeedTitle => 'اسے ہموار چلاؤ';

  @override
  String get onbSpeedWhy =>
      'لگتا ہے تمہارا فون کافی محنت کر رہا ہے۔ یہ بند کرو اور سب کچھ بہتر چلے گا: آزماؤ اور پیش نظارہ دیکھو۔';

  @override
  String get onbSpeedMotion => 'اینیمیشن';

  @override
  String get onbSpeedBlurHint => 'شیٹس اور بارز کے پیچھے دھندلا شیشہ';

  @override
  String get onbSpeedMotionHint => 'سلائیڈ ہو کر آنے والی اسکرینیں اور شیٹس';

  @override
  String get onbSpeedLater => 'ترتیبات › عمومی › کارکردگی میں کبھی بھی بدلا جا سکتا ہے۔';

  @override
  String get notifSoundSetting => 'اطلاعات کی آوازیں';

  @override
  String get notifSoundRowHint => 'ہر قسم کی یاد دہانی کیسی سنائی دیتی ہے';

  @override
  String get notifSoundHint =>
      'ہر قسم کی یاد دہانی کے لیے ایک آواز چنو۔ فون سے تمہارے فون کی آوازیں کھولتا ہے، اور زیادہ تر فونز میں وہاں اپنا گانا بھی شامل کیا جا سکتا ہے۔';

  @override
  String get notifSoundTrain => 'ورزشیں';

  @override
  String get notifSoundFood => 'غذا، سپلیمنٹس اور روزہ';

  @override
  String get notifSoundOther => 'تصاویر اور پیمائشیں';

  @override
  String get notifSoundNormal => 'عام';

  @override
  String get notifSoundPhone => 'فون سے';

  @override
  String get notifSoundSilent => 'خاموش';

  @override
  String get notifSoundPhoneHint => 'سننے کے لیے کسی پر ٹیپ کرو۔ یہ فوراً محفوظ ہو جاتی ہے۔';

  @override
  String get notifSoundMore => 'دوسری فائل…';

  @override
  String get notifSoundChange => 'بدلو';

  @override
  String get workoutNoteAdd => 'پن کیا نوٹ: سیٹ، گرفت، مشین…';

  @override
  String get autoProgressSetting => 'خودکار پیش رفت';

  @override
  String get autoProgressRowHint => 'اگلی بار کے لیے کیا تجویز کرتا ہے';

  @override
  String get autoProgressOff => 'بند';

  @override
  String get autoProgressWeight => 'وزن بڑھاؤ';

  @override
  String get autoProgressReps => 'ریپس بڑھاؤ';

  @override
  String get autoProgressHint =>
      'ورزش شروع کرنے پر GymMane ہر ورزش کا اگلا قدم بھر دیتا ہے۔ ریپس بڑھاؤ کے ساتھ ہر سیٹ میں ایک ریپ 12 تک بڑھتا ہے، پھر وزن بڑھتا ہے اور دوبارہ 8 سے شروع ہوتا ہے۔ ہر ورزش کو اس کے صفحے پر الگ سے بھی ایڈجسٹ کیا جا سکتا ہے۔';

  @override
  String get noteFolders => 'فولڈرز';

  @override
  String get noteFolderNew => 'نیا فولڈر';

  @override
  String get noteFolderEdit => 'فولڈر میں ترمیم کرو';

  @override
  String get noteFolderName => 'فولڈر کا نام';

  @override
  String get noteFolderLabel => 'فولڈر';

  @override
  String get noteFolderNone => 'کوئی فولڈر نہیں';

  @override
  String get noteFolderDelete => 'فولڈر حذف کرو؟';

  @override
  String get noteFolderDeleteBody => 'نوٹس رہیں گے: بس فولڈر سے نکل جائیں گے۔';

  @override
  String get foodArchivedToast => 'غذا آرکائیو ہو گئی';

  @override
  String get planArchivedToast => 'منصوبہ آرکائیو ہو گیا';

  @override
  String get suppArchivedToast => 'سپلیمنٹ آرکائیو ہو گیا';

  @override
  String get voiceSetting => 'ورزش کی آواز';

  @override
  String get voiceSettingHint =>
      'فون کی آواز میں تمہارا اگلا سیٹ بتاتی ہے اور آرام کے آخر کی الٹی گنتی کرتی ہے';

  @override
  String get voiceHello => 'آواز آن';

  @override
  String voiceRest(String time) {
    return 'آرام $time۔';
  }

  @override
  String voiceNext(String name, String load) {
    return 'اگلی: $name، $load۔';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$weight پر $reps ریپس';
  }

  @override
  String voiceReps(int reps) {
    return '$reps ریپس';
  }

  @override
  String get voiceGo => 'چلو شروع کریں!';

  @override
  String get deloadSetting => 'ڈی لوڈ ہفتہ';

  @override
  String get deloadOff => 'کبھی نہیں';

  @override
  String deloadEvery(int weeks) {
    return 'ہر $weeks ہفتے';
  }

  @override
  String get deloadHint =>
      'ہر چند ہفتوں بعد بحالی کے لیے ایک آسان ہفتہ: آدھے سیٹ اور 10 % کم وزن۔ وہ ہفتہ پیش رفت میں شمار نہیں ہوتا۔';

  @override
  String get deloadRowHint => 'ہر چند ہفتوں بعد ایک آسان ہفتہ';

  @override
  String get deloadNow => 'ڈی لوڈ ہفتہ';

  @override
  String get deloadNowHint => 'آج، آدھے سیٹ اور 10 % کم وزن';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks ہفتوں میں',
      one: 'اگلے ہفتے',
      zero: 'اس ہفتے',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'معمول کے مطابق ٹریننگ کرو';

  @override
  String get voiceSheetTitle => 'آواز کیسے کام کرتی ہے';

  @override
  String get voicePointRest => 'سیٹ پر نشان لگانے پر یہ آرام کا وقت اور آگے کیا ہے بتاتی ہے۔';

  @override
  String get voicePointCount => 'آرام کے آخر میں 3، 2، 1 گنتی ہے اور تمہیں واپس بلاتی ہے۔';

  @override
  String get voicePointPhone => 'یہ تمہارے فون کی آواز استعمال کرتی ہے اور تمہاری موسیقی کے اوپر بجتی ہے۔';

  @override
  String get voiceTry => 'آواز آزماؤ';

  @override
  String get voiceNoEngine => 'تمہارے فون میں کوئی وائس انجن آن نہیں۔';

  @override
  String get voiceNoLang => 'تمہاری زبان کی آواز موجود نہیں۔ اسے فون کی وائس ترتیبات میں ڈاؤن لوڈ کرو۔';

  @override
  String get voiceOpenSettings => 'وائس ترتیبات';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count منٹ', one: '1 منٹ');
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count سیکنڈ', one: '1 سیکنڈ');
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'اور';

  @override
  String get repRecordsTitle => 'ریپس کے لحاظ سے بہترین وزن';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'کیپسول', one: 'کیپسول');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'گولیاں', one: 'گولی');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'اسکوپ', one: 'اسکوپ');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'قطرے', one: 'قطرہ');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'سرونگز', one: 'سرونگ');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IU';

  @override
  String get suppLeft => 'باقی';

  @override
  String get suppLeftHint => 'اختیاری';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n دنوں کے لیے باقی',
      one: '1 دن کے لیے باقی',
    );
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n دن', one: '1 دن');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'ختم ہو گیا';

  @override
  String get lightSession => 'ہلکا سیشن';

  @override
  String get lightSessionHint =>
      'تمہارے تاریخچے اور اعداد و شمار میں محفوظ ہوتا ہے، لیکن تمہارے اگلے اہداف نہیں بدلے گا۔';

  @override
  String get lightSessionNote => 'پیش رفت میں شمار نہیں';

  @override
  String get lightSessionOff => 'بند کرو';

  @override
  String get eachSideRepsHint => 'بائیں اور دائیں ریپس الگ الگ درج کرو۔ پیش رفت کمزور طرف کے مطابق چلتی ہے۔';

  @override
  String get repsLeftCol => 'ریپس با';

  @override
  String get repsRightCol => 'ریپس دا';

  @override
  String get repsLeftTitle => 'بائیں ریپس';

  @override
  String get repsRightTitle => 'دائیں ریپس';

  @override
  String sidesReps(int l, int r) {
    return 'با$l دا$r';
  }

  @override
  String get progSchemeTitle => 'وزن کی پیش رفت';

  @override
  String get groupMoveUp => 'گروپ اوپر لے جاؤ';

  @override
  String get groupMoveDown => 'گروپ نیچے لے جاؤ';

  @override
  String get mealAiRow => 'AI سے پوچھو';

  @override
  String get mealAiRowHint => 'درخواست کاپی کرو، جواب پیسٹ کرو';

  @override
  String get mealAiTitle => 'AI کے ساتھ کھانے';

  @override
  String get mealAiSubtitle => 'کسی بھی چیٹ بوٹ کے ساتھ کام کرتا ہے۔ ایپ آف لائن ہی رہتی ہے۔';

  @override
  String get mealAiStepAsk => 'پوچھو';

  @override
  String get mealAiStepPaste => 'پیسٹ کرو';

  @override
  String get mealAiWholeDay => 'پورا دن';

  @override
  String get mealAiTarget => 'ہدف';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'آج تمہارے پاس $kcal اور $protein گرام پروٹین باقی ہے';
  }

  @override
  String get mealAiStyle => 'تمہارا ذائقہ';

  @override
  String get mealAiTagProtein => 'زیادہ پروٹین';

  @override
  String get mealAiTagVeggie => 'سبزی خور';

  @override
  String get mealAiTagVegan => 'ویگن';

  @override
  String get mealAiTagNoGluten => 'گلوٹن سے پاک';

  @override
  String get mealAiTagNoLactose => 'لیکٹوز سے پاک';

  @override
  String get mealAiTagQuick => 'جلدی';

  @override
  String get mealAiTagNoCook => 'پکائے بغیر';

  @override
  String get mealAiTagCheap => 'کم خرچ';

  @override
  String get mealAiNotesHint => 'گھر میں ہے… پسند نہیں… الرجی…';

  @override
  String get mealAiOptions => 'اختیارات';

  @override
  String get mealAiCopy => 'درخواست کاپی کرو';

  @override
  String get mealAiCopied => 'درخواست کاپی ہو گئی';

  @override
  String get mealAiCopiedHint => 'اسے اپنے AI میں پیسٹ کرو اور جواب لے کر یہاں واپس آؤ';

  @override
  String get mealAiShowText => 'درخواست دیکھو';

  @override
  String get mealAiHideText => 'درخواست چھپاؤ';

  @override
  String get mealAiPasteHint => 'AI کا جواب یہاں پیسٹ کرو';

  @override
  String get mealAiReview => 'جواب دیکھو';

  @override
  String get mealAiUnreadable => 'اس متن میں کوئی غذا نہیں ملی';

  @override
  String get mealAiUnreadableHint => 'AI سے کہو کہ صرف JSON بھیجے، ایک کوڈ بلاک میں، درخواست کے فارمیٹ میں۔';

  @override
  String get mealAiCopyFix => 'وہ جملہ کاپی کرو';

  @override
  String mealAiOption(int n) {
    return 'اختیار $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return '$meal میں شامل کرو';
  }

  @override
  String get mealAiAddDay => 'آج میں شامل کرو';

  @override
  String get mealAiAddPick => 'شامل کرو';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n غذائیں شامل ہوئیں',
      one: '1 غذا شامل ہوئی',
    );
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'ترکیب کے طور پر محفوظ کرو';

  @override
  String get mealAiSavePlan => 'منصوبے کے طور پر محفوظ کرو';

  @override
  String get mealAiRecipeSaved => 'ترکیب محفوظ ہو گئی';

  @override
  String get mealAiPlanSaved => 'منصوبہ محفوظ ہو گیا';

  @override
  String get mealAiFlagEstimated => 'AI کا اندازہ';

  @override
  String get mealAiFlagAdjusted => 'میکروز سے ملانے کے لیے کیلوریز درست کی گئیں';

  @override
  String get mealAiFlagDoubtful => 'حساب نہیں ملتا، دیکھ لو';

  @override
  String get mealAiFlagNoValues => 'غذائی قدریں نہیں';

  @override
  String get mealAiFlagNoAmount => 'مقدار نہیں دی گئی';

  @override
  String get mealAiTruncated => 'جواب کٹا ہوا لگتا ہے۔ مکمل غذائیں رکھ لی گئیں۔';

  @override
  String get mealAiAmount => 'مقدار';

  @override
  String mealAiTargetLine(String kcal) {
    return 'ہدف $kcal';
  }

  @override
  String get mealAiNothingChosen => 'کم از کم ایک غذا آن کرو';

  @override
  String get cholesterolLabel => 'کولیسٹرول';

  @override
  String get mealAiFlagMatched => 'تمہاری محفوظ کی ہوئی ایک غذا جیسی';

  @override
  String get mealAiNotSame => 'ایک جیسی نہیں';

  @override
  String get homeOrderRow => 'حصوں کی ترتیب';

  @override
  String get homeOrderHint => 'ہوم کی ترتیب بدلنے کے لیے دبائے رکھو اور کھینچو۔';

  @override
  String get homeOrderFolders => 'شارٹ کٹس';

  @override
  String get equipNew => 'نیا';

  @override
  String get equipNewTitle => 'نیا سامان';

  @override
  String get equipNewHint => 'مثلاً ویٹ بیلٹ';

  @override
  String get homeOrderWeekdays => 'ہفتے کے نشان';

  @override
  String get repsMaxTitle => 'ریپس تک';

  @override
  String get repsRangeHint => '8-12 جیسی حد دینے کے لیے ریپس کو دیر تک دباؤ۔';

  @override
  String get repsRangeClear => 'حد ہٹاؤ';

  @override
  String get noteLinksLabel => 'لنکس';

  @override
  String get noteLinkAdd => 'لنک شامل کرو';

  @override
  String get noteLinkEdit => 'لنک میں ترمیم کرو';

  @override
  String get noteLinkNameHint => 'نام';

  @override
  String get noteLinkUrlHint => 'ویب ایڈریس';

  @override
  String get noteLinkInvalid => 'یہ ایڈریس درست نہیں لگتا';

  @override
  String get changeRest => 'ورزشوں کے درمیان آرام';

  @override
  String get changeRestHint => 'آخری سیٹ کے بعد، اگلی ورزش سے پہلے';

  @override
  String get notifSuppTake => 'لے لیا';

  @override
  String get sideRest => 'دونوں طرف کے درمیان آرام';

  @override
  String get sideRestHint => 'ہر طرف والی ورزشیں: پہلا ✓ ایک طرف ختم کرتا ہے';

  @override
  String get gfxCompat => 'مطابقت والی گرافکس';

  @override
  String get gfxCompatHint =>
      'ان فونز کے لیے جن میں حروف ٹوٹے نظر آتے ہیں۔ دھندلاہٹ رہتی ہے، کچھ اثرات سادہ ہو جاتے ہیں';

  @override
  String get gfxRestartTitle => 'GymMane دوبارہ شروع کرو؟';

  @override
  String get gfxRestartBody =>
      'اسکرین بنانے کا طریقہ بدلنے کے لیے یہ بند ہو کر دوبارہ کھلتا ہے۔ تمہارا محفوظ کیا کچھ بھی ضائع نہیں ہوتا۔';

  @override
  String get gfxRestart => 'دوبارہ شروع کرو';

  @override
  String get webSynced => 'دوسرے آلے کی تبدیلیوں سے اپڈیٹ ہو گیا';

  @override
  String get webSyncedPhone => 'تمہارے فون کی تبدیلیاں آ گئیں';

  @override
  String get webWelcomeBlurb =>
      'سب کچھ تمہارے اپنے سرور پر رہتا ہے۔ کوئی اکاؤنٹ نہیں، کلاؤڈ نہیں، کچھ دینا نہیں۔';

  @override
  String get webOwnServer => 'تمہارا سرور، تمہارے اصول';

  @override
  String get webOwnServerWhy =>
      'کوئی اکاؤنٹ نہیں اور کسی اور کا کلاؤڈ نہیں۔ تمہارا ڈیٹا وہیں رہتا ہے جہاں اسے چلایا جائے۔';

  @override
  String get webServerSaved => 'تمہارے سرور پر محفوظ';

  @override
  String get webServerOffline => 'تمہارے سرور تک رسائی نہیں ہو رہی';

  @override
  String get webServerLocal => 'اس براؤزر میں محفوظ';

  @override
  String get webServerTitle => 'تمہارا سرور';

  @override
  String webPhoneLast(String date) {
    return 'تمہارے فون سے آخری نقل: $date';
  }

  @override
  String get webPhoneNone => 'ابھی تمہارے فون سے کوئی نقل نہیں';

  @override
  String get webPhoneScan => 'فون سے لاؤ';

  @override
  String get webPhoneExport => 'فون پر بھیجو';

  @override
  String get webPhoneExportDone => 'شیئر فولڈر میں رکھ دیا گیا۔ سنک ہونے پر تمہارا فون اسے لے آئے گا';

  @override
  String get webPhoneImported => 'تمہارے فون کی تبدیلیاں آ گئیں';

  @override
  String get webPhoneNothing => 'تمہارے فون سے کچھ نیا نہیں';

  @override
  String get webPhoneHow =>
      'اپنے فون پر خودکار بیک اپ ایسے فولڈر میں آن کرو جو Syncthing سے سنک ہوتا ہو۔ سرور اور فون خود ہی ایک دوسرے کی تبدیلیاں لے آتے ہیں، اور ضم کرنے سے کبھی کچھ حذف نہیں ہوتا۔';

  @override
  String get webPhoneGuide => 'اسے کیسے سیٹ کریں';

  @override
  String get webPhoneOff => 'اس سرور پر فون سنک بند ہے';

  @override
  String get toolGroupBody => 'جسم';

  @override
  String get toolNameProtein => 'پروٹین';

  @override
  String get toolTitleProtein => 'روزانہ پروٹین';

  @override
  String get toolDescProtein => 'روزانہ کتنا پروٹین';

  @override
  String get toolHintProtein => 'روزانہ گرام، تمہارے کھانوں میں تقسیم';

  @override
  String get proteinGoalLabel => 'ہدف';

  @override
  String get proteinExplain =>
      'ٹریننگ کرنے والوں کے لیے اس حد پر مبنی جس پر زیادہ تر تحقیق متفق ہے: وزن کم کرتے وقت زیادہ، تاکہ پٹھے بچے رہیں۔ اس سے زیادہ لینا محفوظ ہے، بس زیادہ فائدہ نہیں دیتا۔';

  @override
  String get toolNameWater => 'پانی';

  @override
  String get toolTitleWater => 'روزانہ پانی';

  @override
  String get toolDescWater => 'روزانہ کتنا پینا ہے';

  @override
  String get toolHintWater => 'روزانہ لیٹر، غذا سمیت';

  @override
  String get waterTrainingLabel => 'روزانہ ٹریننگ';

  @override
  String get waterExplain =>
      'جسمانی وزن کے ہر کلو پر تقریباً 35 ملی لیٹر، اور ٹریننگ کے ہر منٹ کے لیے تھوڑا اضافی۔ گرم دنوں میں زیادہ پیو۔';

  @override
  String get autoBackupSync => 'ابھی سنک کرو';

  @override
  String get autoBackupMerged => 'تمہارے دوسرے آلات کی تبدیلیاں آ گئیں';

  @override
  String get autoBackupSyncHint =>
      'اس فولڈر کو Syncthing سے شیئر کرو اور ہر آلہ وہ لے آئے گا جو دوسرے یہاں چھوڑیں۔ ضم کرنے سے کبھی کچھ حذف نہیں ہوتا۔';

  @override
  String get webPhoneFolder => 'شیئر فولڈر';

  @override
  String get webPhoneFolderHow =>
      'سرور انسٹال کرتے وقت چنا جاتا ہے۔ بدلنے کے لیے سرور کی ‎.env فائل میں GYMMANE_SYNC مقرر کرو اور اسے دوبارہ شروع کرو۔';

  @override
  String get webPhoneOffHow =>
      'آن کرنے کے لیے سرور کی ‎.env فائل سے GYMMANE_SYNC=off ہٹاؤ اور اسے دوبارہ شروع کرو۔';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n فون سنک ہوئے',
      one: '1 فون سنک ہوا',
      zero: 'ابھی کوئی فون سنک نہیں ہوا',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'فولڈر نہیں پڑھا جا سکا: $error';
  }

  @override
  String get duplicateExercise => 'ڈپلیکیٹ کریں';

  @override
  String exerciseCopyName(String name) {
    return '$name (کاپی)';
  }
}
