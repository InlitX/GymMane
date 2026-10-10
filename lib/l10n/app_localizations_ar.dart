// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get languageName => 'العربية';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% مقارنة بالشهر الماضي';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'المستوى $level · $streak';
  }

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get cancelCaps => 'إلغاء';

  @override
  String get deleteCaps => 'حذف';

  @override
  String get done => 'تم';

  @override
  String get set => 'مجموعة';

  @override
  String get home => 'الرئيسية';

  @override
  String get progress => 'التقدم';

  @override
  String get exercises => 'التمارين';

  @override
  String get settings => 'الإعدادات';

  @override
  String get today => 'اليوم';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get recommended => 'موصى به';

  @override
  String get goal => 'الهدف';

  @override
  String get volume => 'الحجم';

  @override
  String get setsToday => 'مجموعات اليوم';

  @override
  String get prs => 'الأرقام القياسية';

  @override
  String get todaysFocus => 'تركيز اليوم';

  @override
  String get todaysRoutine => 'روتين اليوم';

  @override
  String get startWorkout => 'ابدأ التمرين';

  @override
  String get routines => 'الروتينات';

  @override
  String get tools => 'الأدوات';

  @override
  String get firstSessionHint => 'اختر عضلاتك وسجّل تمرينك الأول';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n تمارين', one: 'تمرين واحد');
    return '$_temp0';
  }

  @override
  String get pushDay => 'يوم الدفع';

  @override
  String get pullDay => 'يوم السحب';

  @override
  String get legDay => 'الأرجل';

  @override
  String get pushFocus => 'الصدر · الكتفين · الترايسبس';

  @override
  String get pullFocus => 'الظهر · البايسبس · الترابيس';

  @override
  String get legFocus => 'الرباعية · أوتار الركبة · الألوية';

  @override
  String get train => 'تدرّب';

  @override
  String get step1 => 'الخطوة 1 من 2';

  @override
  String get step2 => 'الخطوة 2 من 2';

  @override
  String get chooseFocus => 'اختر تركيزك';

  @override
  String get buildSession => 'أنشئ تمرينك';

  @override
  String get tapMuscles => 'اضغط على العضلات التي تريد تدريبها — من الأمام والخلف.';

  @override
  String get continueBtn => 'متابعة';

  @override
  String get nothingForFocus => 'لا توجد تمارين لهذا التركيز';

  @override
  String get goBackPick => 'ارجع واختر عضلة لها تمارين في مكتبتك.';

  @override
  String pickedHint(int n) {
    return 'جهزنا لك تمرينًا — اضغط لإضافة أو إزالة أي من التمارين الـ $n.';
  }

  @override
  String get pickAnExercise => 'اختر تمرينًا';

  @override
  String get searchAllExercises => 'ابحث عن تمرين…';

  @override
  String get noExercisesMatch => 'لا توجد تمارين مطابقة';

  @override
  String get createItInstead => 'أنشئ تمرينك الخاص بدلًا من ذلك';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n تمارين', one: 'تمرين واحد');
    return 'ابدأ · $_temp0';
  }

  @override
  String get inProgress => 'قيد التنفيذ';

  @override
  String get paused => 'متوقف مؤقتًا';

  @override
  String get last => 'الأخير';

  @override
  String get rest => 'راحة';

  @override
  String get skip => 'تخطَّ';

  @override
  String get addSet => '+ إضافة مجموعة';

  @override
  String get finishSession => 'إنهاء التمرين';

  @override
  String get setDone => 'اكتملت المجموعة';

  @override
  String get nextExercise => 'التمرين التالي';

  @override
  String get dropExerciseAction => 'إزالة التمرين';

  @override
  String get restOff => 'متوقف';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'التكرارات';

  @override
  String weightCol(String unit) {
    return 'الوزن ($unit)';
  }

  @override
  String get repsTitle => 'التكرارات';

  @override
  String weightTitle(String unit) {
    return 'الوزن ($unit)';
  }

  @override
  String get sessionComplete => 'تم تسجيل التمرين';

  @override
  String get finishHeadlinePr => 'رقم شخصي جديد';

  @override
  String get finishHeadlineGoal => 'تم تحقيق الهدف الأسبوعي';

  @override
  String get finishHeadlineStreak => 'تم الحفاظ على السلسلة';

  @override
  String get finishHeadlineDefault => 'تمرين آخر في الرصيد';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs تمارين', one: 'تمرين واحد');
    return 'رفعت وزنًا أكبر من أي وقت مضى في $_temp0. تم حفظه في سجلاتك.';
  }

  @override
  String get finishBodyGoal => 'أكملت عدد التمارين الذي خططت له هذا الأسبوع.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak أيام متتالية. الأصعب هو ألا تتوقف.';
  }

  @override
  String get finishBodyDefault => 'تم التسجيل والاحتساب. الاستمرارية هي ما يصنع التقدم.';

  @override
  String get vsLastTime => 'مقارنة بالمرة السابقة';

  @override
  String get firstTime => 'أول تسجيل';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n أرقام قياسية جديدة',
      one: 'رقم قياسي جديد واحد',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'المدة';

  @override
  String get setsCaps => 'المجموعات';

  @override
  String exerciseXofY(int i, int n) {
    return 'التمرين $i من $n';
  }

  @override
  String get decrease => 'تقليل';

  @override
  String get increase => 'زيادة';

  @override
  String markSet(int n) {
    return 'وضع علامة على المجموعة $n كمكتملة';
  }

  @override
  String get pauseWorkout => 'إيقاف التمرين مؤقتًا';

  @override
  String get resumeWorkout => 'استئناف التمرين';

  @override
  String get discardTitle => 'تجاهل التمرين؟';

  @override
  String get discardBody => 'ستفقد مجموعات هذا التمرين.';

  @override
  String get keepTraining => 'متابعة التمرين';

  @override
  String get discard => 'تجاهل';

  @override
  String get notifRestChannel => 'مؤقت الراحة';

  @override
  String get notifRestChannelWhy => 'يخبرك عند انتهاء الراحة بين المجموعات';

  @override
  String get notifAlertChannel => 'مؤقت الراحة (تنبيه)';

  @override
  String get notifAlertChannelWhy => 'يعرض إشعارًا فور انتهاء الراحة';

  @override
  String get restOverTitle => 'انتهت الراحة';

  @override
  String get restOverBody => 'عد إلى التمرين — المجموعة التالية تنتظرك.';

  @override
  String get allTimeSessions => 'التمارين';

  @override
  String get allTimeTime => 'الوقت';

  @override
  String get allTimeSets => 'المجموعات';

  @override
  String get consistency => 'الاستمرارية';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تم تسجيل $n تمارين',
      one: 'تم تسجيل تمرين واحد',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'سلسلة $n أيام';
  }

  @override
  String get bodyweight => 'وزن الجسم';

  @override
  String get logBodyweight => 'تسجيل الوزن';

  @override
  String get trackWeight => 'تتبّع وزنك مع مرور الوقت';

  @override
  String get muscleMap => 'خريطة العضلات';

  @override
  String get days7 => '7 أيام';

  @override
  String get days30 => '30 يومًا';

  @override
  String get heatLow => 'غير مُدرَّب';

  @override
  String get heatHigh => 'أقصى حجم';

  @override
  String get muscleMapEmpty => 'سجّل تمرينًا وسيبدأ جسمك بالإضاءة هنا.';

  @override
  String get muscleMapHint => 'اضغط على عضلة لترى مقدار تمرينها.';

  @override
  String muscleMapBehind(String names) {
    return 'متأخرة: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% من الهدف';
  }

  @override
  String get muscleSplit => 'توزيع العضلات';

  @override
  String get personalRecords => 'الأرقام الشخصية';

  @override
  String get strength1rm => 'القوة · 1RM مقدر';

  @override
  String get strengthEmpty => 'سجّل تمرينًا مرتين لتظهر منحنيات القوة هنا.';

  @override
  String oneRmEst(String w) {
    return '1RM المقدر: $w';
  }

  @override
  String get restDayShort => 'يوم راحة';

  @override
  String get restDay => 'يوم راحة — لم يُسجل شيء.';

  @override
  String get delete => 'حذف';

  @override
  String get deleteEntry => 'حذف هذا الإدخال؟';

  @override
  String deleteEntryBody(String name) {
    return 'ستتم إزالة \"$name\" من هذا اليوم ومن سجلاتك ورسومك البيانية.';
  }

  @override
  String get bodyweightHistory => 'السجل';

  @override
  String get exercisesCaps => 'التمارين';

  @override
  String get timeCaps => 'الوقت';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمارين في مكتبتك',
      one: 'تمرين واحد في مكتبتك',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'البحث عن تمارين';

  @override
  String get muscleFilter => 'العضلة';

  @override
  String get levelFilter => 'المستوى';

  @override
  String get kindLabel => 'النوع';

  @override
  String get kindStrength => 'قوة';

  @override
  String get kindCalisthenics => 'كاليستينكس';

  @override
  String get kindCardio => 'كارديو';

  @override
  String get kindStretch => 'إطالة';

  @override
  String get newExercise => 'تمرين جديد';

  @override
  String get exerciseName => 'اسم التمرين';

  @override
  String get equipmentLabel => 'المعدات';

  @override
  String get addExercise => 'إضافة تمرين';

  @override
  String get advanced => 'متقدم';

  @override
  String get demoMedia => 'عرض توضيحي';

  @override
  String get addMedia => 'إضافة وسائط';

  @override
  String get mediaHint => 'صورة أو GIF أو فيديو';

  @override
  String get changeMedia => 'تغيير';

  @override
  String get videoSelected => 'تم اختيار الفيديو';

  @override
  String get favouritesOnly => 'المفضلة';

  @override
  String get noFavouritesYet => 'لا توجد مفضلة بعد';

  @override
  String get noFavouritesHint => 'اضغط على نجمة التمرين للاحتفاظ به هنا.';

  @override
  String get clearFilters => 'مسح عوامل التصفية';

  @override
  String get noExercisesFound => 'لم يتم العثور على تمارين';

  @override
  String get noExercisesHint => 'جرّب بحثًا آخر أو امسح عوامل التصفية.';

  @override
  String get personalRecord => 'رقم شخصي';

  @override
  String get history => 'السجل';

  @override
  String get noHistory => 'لا توجد جلسات مسجلة بعد. تدرب على هذا التمرين لبناء السجل.';

  @override
  String get notes => 'ملاحظات';

  @override
  String get notePlaceholder => 'ملاحظات، إعداد، شعور…';

  @override
  String notHere(String gear, String place) {
    return 'لا يوجد $gear في $place';
  }

  @override
  String get notHereWhy => 'استبدله بشيء يمكنك استخدامه فعليًا اليوم.';

  @override
  String get altHere => 'ما يمكنك فعله هنا';

  @override
  String get places => 'أماكني';

  @override
  String get placesHint => 'حدّد المعدات الموجودة في كل مكان وستعرض المكتبة فقط ما يمكنك فعله هناك.';

  @override
  String get placeAll => 'في أي مكان';

  @override
  String get placeNew => 'مكان جديد';

  @override
  String get placeNamePlaceholder => 'المنزل، النادي، الحديقة…';

  @override
  String get placeGearLabel => 'المعدات المتاحة';

  @override
  String placeExercises(int n) {
    return '$n تمارين هنا';
  }

  @override
  String get placeEmptyTitle => 'تمرّن أينما كنت';

  @override
  String get placeEmptyBody => 'المكان هو قائمة بالمعدات الموجودة فيه. اختر واحدًا للبدء وعدّله لاحقًا.';

  @override
  String get placeDeleteTitle => 'حذف المكان';

  @override
  String get placeDeleteBody => 'سيُحذف المكان فقط — ستبقى تمارينك وجلساتك.';

  @override
  String get placeGym => 'النادي الرياضي';

  @override
  String get placeHome => 'المنزل';

  @override
  String get placeOutdoors => 'في الخارج';

  @override
  String get placeFilterLabel => 'المكان';

  @override
  String get noGearOnly => 'بدون معدات';

  @override
  String placeActive(String name) {
    return 'التمرين في $name';
  }

  @override
  String get journal => 'اليوميات';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ملاحظات',
      one: 'ملاحظة واحدة',
      zero: 'لا توجد ملاحظات',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'ملاحظة';

  @override
  String get noteKindPlan => 'خطة';

  @override
  String get noteKindDone => 'إنجاز';

  @override
  String get noteKindPain => 'ألم بسيط';

  @override
  String get noteFilterAll => 'الكل';

  @override
  String get newNote => 'ملاحظة جديدة';

  @override
  String get editNote => 'تعديل الملاحظة';

  @override
  String get addNote => 'إضافة ملاحظة';

  @override
  String get noteEmptyTitle => 'لم يُكتب شيء بعد';

  @override
  String get noteEmptyBody =>
      'سجّل الملاحظات وخطط المرة القادمة وشعورك بعد التمرين — مع صور أو فيديو إن أردت.';

  @override
  String get noteNoneForExercise => 'لا توجد ملاحظات لهذا التمرين بعد.';

  @override
  String get noteKindLabel => 'النوع';

  @override
  String get noteTextLabel => 'ملاحظة';

  @override
  String get noteDateLabel => 'التاريخ';

  @override
  String get noteExerciseLabel => 'التمرين';

  @override
  String get noteMediaLabel => 'الصور والفيديو';

  @override
  String get noteGeneral => 'بدون تمرين';

  @override
  String get noteAttach => 'إرفاق';

  @override
  String get noteRemoveMedia => 'إزالة المرفق';

  @override
  String get deleteNoteTitle => 'حذف الملاحظة';

  @override
  String get deleteNoteBody => 'سيتم حذف الملاحظة وجميع مرفقاتها نهائيًا.';

  @override
  String get noteToday => 'اليوم';

  @override
  String get noteYesterday => 'أمس';

  @override
  String get noteAllNotes => 'كل الملاحظات';

  @override
  String get noteCalendar => 'التقويم';

  @override
  String get noteNoneOnDay => 'لم يُكتب شيء في هذا اليوم';

  @override
  String get noteAddOnDay => 'إضافة ملاحظة لهذا اليوم';

  @override
  String get notePrevMonth => 'الشهر السابق';

  @override
  String get noteNextMonth => 'الشهر التالي';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ملاحظات هذا الشهر',
      one: 'ملاحظة واحدة هذا الشهر',
      zero: 'لا توجد ملاحظات هذا الشهر',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'القياسات';

  @override
  String get measuresHint => 'من الرقبة إلى ربلة الساق — راقب تغير جسمك لا البار فقط.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n قياسات',
      one: 'قياس واحد',
      zero: 'لا توجد قياسات',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'لم يُقَس بعد';

  @override
  String get measureHistory => 'السجل';

  @override
  String get measureNeck => 'الرقبة';

  @override
  String get measureShoulders => 'الكتفان';

  @override
  String get measureChest => 'الصدر';

  @override
  String get measureArm => 'الذراع';

  @override
  String get measureForearm => 'الساعد';

  @override
  String get measureWaist => 'الخصر';

  @override
  String get measureHips => 'الورك';

  @override
  String get measureThigh => 'الفخذ';

  @override
  String get measureCalf => 'ربلة الساق';

  @override
  String get measureBodyfat => 'دهون الجسم';

  @override
  String get timeline => 'الخط الزمني';

  @override
  String get timelineHint => 'نفس الوضعية والمكان والإضاءة. بعد سنة لن تصدق الفرق.';

  @override
  String get timelineEmptyTitle => 'صورتك الأولى تبدأ التتبع';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n صور',
      one: 'صورة واحدة',
      zero: 'لا توجد صور',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'أمام';

  @override
  String get poseSide => 'جانب';

  @override
  String get poseBack => 'خلف';

  @override
  String get photoEvery => 'ذكّرني';

  @override
  String photoEveryDays(int n) {
    return 'كل $n أيام';
  }

  @override
  String get photoEveryOff => 'أبدًا';

  @override
  String get timelineEvery => 'تجميع كل';

  @override
  String get custom => 'مخصص';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'الصورة التالية بعد $n أيام',
      one: 'الصورة التالية غدًا',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'حان وقت الصورة — التقطها اليوم';

  @override
  String get addTodayPhotos => 'إضافة صور اليوم';

  @override
  String posePhoto(String pose) {
    return 'صورة $pose';
  }

  @override
  String get compare => 'مقارنة';

  @override
  String get compareNeedTwo => 'التقط نفس الوضعية في يومين مختلفين لتتمكن من المقارنة هنا.';

  @override
  String dayNumber(int n) {
    return 'اليوم $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'بفارق $n أيام',
      one: 'بفارق يوم واحد',
      zero: 'في اليوم نفسه',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'حذف هذا اليوم';

  @override
  String get deleteDayBody => 'ستُحذف صور هذا اليوم نهائيًا أيضًا.';

  @override
  String get timelinePhotos => 'الصور';

  @override
  String get timelineBody => 'خريطة العضلات';

  @override
  String get timelineBodyEmpty => 'سجّل تمرينًا وستبدأ خريطة العضلات بالامتلاء هنا — دون حاجة إلى صور.';

  @override
  String get timelineBodyHint => 'مبنية من مجموعاتك أنت — لا يتم رفع أي شيء.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمارين',
      one: 'تمرين واحد',
      zero: 'لا توجد تمارين',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'صور التقدم';

  @override
  String get notifPhotoChannelWhy => 'تذكير عندما يحين موعد صورة التقدم التالية.';

  @override
  String get notifPhotoTitle => 'حان وقت صورة التقدم';

  @override
  String notifPhotoBody(int n) {
    return 'مرّ $n أيام منذ الأخيرة. نفس الوضعية ونفس الإضاءة.';
  }

  @override
  String get share => 'مشاركة';

  @override
  String get sharePick => 'ماذا تريد أن تعرض؟';

  @override
  String get shareStreak => 'السلسلة والاستمرارية';

  @override
  String get shareBody => 'العضلات المستهدفة';

  @override
  String get shareCompare => 'قبل / بعد';

  @override
  String get shareHint => 'يتم إنشاء البطاقة على هاتفك. لا يغادر شيء الهاتف حتى تختار وجهة الإرسال.';

  @override
  String get shareFailed => 'تعذر إنشاء البطاقة';

  @override
  String get shareWeekOf => 'آخر 7 أيام';

  @override
  String get shareStreakLabel => 'أيام متتالية';

  @override
  String get shareSessionsLabel => 'التمارين';

  @override
  String get shareVolumeLabel => 'الحجم';

  @override
  String get restForExercise => 'الراحة لهذا التمرين';

  @override
  String get restUsingDefault => 'استخدام المدة الافتراضية';

  @override
  String get restCustom => 'لهذا فقط';

  @override
  String get setType => 'نوع المجموعة';

  @override
  String get setTypeNormal => 'عمل';

  @override
  String get setTypeWarmup => 'إحماء';

  @override
  String get setTypeDrop => 'مجموعة إسقاط';

  @override
  String get setTypeFailure => 'حتى الفشل';

  @override
  String get addWarmup => 'إحماء';

  @override
  String platesPerSide(String plates) {
    return 'لكل جانب: $plates';
  }

  @override
  String get howTo => 'كيفية الأداء';

  @override
  String get similar => 'مشابهة';

  @override
  String get primaryLabel => 'أساسي';

  @override
  String get secondaryLabel => 'ثانوي';

  @override
  String get none => 'لا شيء';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n مجموعات', one: 'مجموعة واحدة');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'حجم $v';
  }

  @override
  String get weeklyPlan => 'الخطة الأسبوعية';

  @override
  String get yourRoutines => 'روتيناتك';

  @override
  String get noRoutines => 'لا توجد روتينات بعد. أنشئ واحدًا وأضف تمارينك.';

  @override
  String get newRoutine => 'روتين جديد';

  @override
  String get routineName => 'اسم الروتين';

  @override
  String get schedule => 'الجدول';

  @override
  String get addFromList => 'أضف تمارين من القائمة أدناه.';

  @override
  String get addExercises => 'إضافة تمارين';

  @override
  String get deleteRoutine => 'حذف هذا الروتين؟';

  @override
  String exercisesWithCount(int n) {
    return 'التمارين · $n';
  }

  @override
  String setDay(String day) {
    return 'تعيين $day';
  }

  @override
  String get newRoutineName => 'روتين جديد';

  @override
  String get dragToReorder => 'اسحب المقبض المنقّط لإعادة الترتيب — هذا هو ترتيب تمرينك.';

  @override
  String reorderHandle(String name) {
    return 'إعادة ترتيب $name';
  }

  @override
  String get removeFromRoutine => 'إزالة من الروتين';

  @override
  String get dropExercise => 'إزالة هذا التمرين؟';

  @override
  String dropExerciseBody(String name) {
    return 'ستتم إزالة \"$name\" من هذا التمرين. لن تفقد أي بيانات مسجلة.';
  }

  @override
  String get drop => 'إزالة';

  @override
  String get resetData => 'حذف جميع بياناتي';

  @override
  String get resetTitle => 'حذف كل شيء؟';

  @override
  String get resetBody =>
      'التمارين والسجلات والروتينات والملاحظات والملف الشخصي. لا يمكن التراجع عن ذلك — صدّر نسخة احتياطية أولًا إذا قد تحتاجها.';

  @override
  String get resetConfirm => 'حذف كل شيء';

  @override
  String get resetDone => 'تم حذف جميع البيانات';

  @override
  String get support => 'الدعم';

  @override
  String get reportBug => 'الإبلاغ عن خطأ';

  @override
  String get requestFeature => 'اقتراح ميزة';

  @override
  String get starOnGithub => 'أضف نجمة على GitHub';

  @override
  String get buyCoffee => 'اشترِ لي قهوة';

  @override
  String get cantOpenLink => 'تعذر فتح الرابط';

  @override
  String get theme => 'السمة';

  @override
  String get darkTheme => 'داكن';

  @override
  String get lightTheme => 'فاتح';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get unitsLabel => 'الوحدات';

  @override
  String get restTimer => 'مؤقت الراحة';

  @override
  String get alarmBlockedTitle => 'الإشعارات متوقفة';

  @override
  String get alarmBlockedBody => 'لن يصدر منبه الراحة صوتًا عندما تكون الشاشة مقفلة';

  @override
  String get alarmBlockedAction => 'تشغيل';

  @override
  String get alarmSound => 'صوت المنبه';

  @override
  String get alarmDefaultName => 'افتراضي';

  @override
  String get alarmSoundHint => 'استخدم صوتك الخاص — حتى 15 ثانية';

  @override
  String get alarmChoose => 'اختر صوتًا…';

  @override
  String get alarmPreview => 'تشغيل الصوت الحالي';

  @override
  String get alarmReset => 'إعادة الضبط إلى الصوت الافتراضي';

  @override
  String get alarmTooLong => 'هذا الصوت أطول من 15 ثانية';

  @override
  String get alarmInvalid => 'تعذر قراءة ملف الصوت هذا';

  @override
  String alarmChanged(String name) {
    return 'تم تعيين صوت المنبه إلى \"$name\"';
  }

  @override
  String get alarmChangedDefault => 'تمت استعادة الصوت الافتراضي';

  @override
  String get addActivityWidget => 'إضافة أداة النشاط';

  @override
  String get addStatsWidget => 'إضافة أداة الإحصاءات';

  @override
  String get pinUnsupported => 'أضفه من قائمة الأدوات في المشغّل';

  @override
  String get background => 'الخلفية';

  @override
  String get bgNone => 'لا شيء';

  @override
  String get bgDots => 'نقاط';

  @override
  String get bgGrid => 'شبكة';

  @override
  String get exportCsv => 'تصدير التمارين (CSV)';

  @override
  String get exportBackup => 'تصدير نسخة احتياطية (ZIP)';

  @override
  String get importBackup => 'استيراد نسخة احتياطية';

  @override
  String get importHint =>
      'اختر نسخة احتياطية .zip (أو .json أقدم) تم تصديرها من GymMane. سيؤدي ذلك إلى استبدال بياناتك الحالية بما فيها الوسائط.';

  @override
  String get import => 'استيراد';

  @override
  String get chooseFile => 'اختر ملفًا';

  @override
  String get importFromApp => 'الاستيراد من تطبيق آخر';

  @override
  String get importUnknownFormat => 'يجب أن يحتوي الملف على أعمدة التاريخ والتمرين والتكرارات والوزن';

  @override
  String get importZipNoWeights => 'ملف ZIP هذا لا يحتوي على ملف وزن';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تم استيراد $n قياسات وزن',
      one: 'تم استيراد قياس وزن واحد',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'تعذر قراءة هذا الملف';

  @override
  String get importUnitTitle => 'ما الوحدة المستخدمة في هذا الملف؟';

  @override
  String get importUnitBody => 'لا يحدد هذا التصدير وحدة الأوزان.';

  @override
  String get importNothing => 'لا يوجد شيء جديد لاستيراده';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تم استيراد $n تمارين',
      one: 'تم استيراد تمرين واحد',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'حول GymMane';

  @override
  String get yourProfile => 'ملفك الشخصي';

  @override
  String get autofills => 'يملأ الحاسبات تلقائيًا';

  @override
  String get nameLabel => 'الاسم';

  @override
  String get sexLabel => 'الجنس';

  @override
  String get macroProtein => 'البروتين';

  @override
  String get macroCarbs => 'الكربوهيدرات';

  @override
  String get macroFat => 'الدهون';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get ageLabel => 'العمر';

  @override
  String get heightLabel => 'الطول';

  @override
  String get weightLabel => 'الوزن';

  @override
  String get weeklyGoal => 'الهدف الأسبوعي';

  @override
  String get activityLabel => 'النشاط';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get removePhoto => 'إزالة الصورة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get chooseGallery => 'اختر من المعرض';

  @override
  String get backupImported => 'تم استيراد النسخة الاحتياطية';

  @override
  String get backupFailed => 'تعذر قراءة هذه النسخة الاحتياطية';

  @override
  String get nothingToExport => 'لا يوجد شيء لتصديره بعد — سجّل تمرينًا أولًا';

  @override
  String calculatorsCount(int n) {
    return '$n حاسبات لتدريبك';
  }

  @override
  String get result => 'النتيجة';

  @override
  String get weightLifted => 'الوزن المرفوع';

  @override
  String get repsPerformed => 'التكرارات المنفذة';

  @override
  String get neck => 'الرقبة';

  @override
  String get waist => 'الخصر';

  @override
  String get hip => 'الورك (للنساء)';

  @override
  String get targetWeight => 'الوزن المستهدف';

  @override
  String get workingWeight => 'وزن العمل';

  @override
  String get activityLevel => 'مستوى النشاط';

  @override
  String get barWeight => 'وزن البار';

  @override
  String get perSide => 'لكل جانب';

  @override
  String get justTheBar => 'البار فقط.';

  @override
  String perSideCount(int n) {
    return '× $n لكل جانب';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'مؤشر كتلة الجسم';

  @override
  String get toolNameCal => 'السعرات الحرارية';

  @override
  String get toolNameBf => 'دهون الجسم';

  @override
  String get toolNamePlate => 'الأقراص';

  @override
  String get toolNameWarmup => 'الإحماء';

  @override
  String get toolTitleRm => 'حاسبة 1RM';

  @override
  String get toolTitleBmi => 'حاسبة مؤشر كتلة الجسم';

  @override
  String get toolTitleCal => 'السعرات والمغذيات الكبرى';

  @override
  String get toolTitleBf => 'نسبة دهون الجسم';

  @override
  String get toolTitlePlate => 'حاسبة الأقراص';

  @override
  String get toolTitleWarmup => 'مجموعات الإحماء';

  @override
  String get toolHintRm => 'الحد الأقصى المقدر لتكرار واحد (معادلة إبلي)';

  @override
  String get toolHintCal => 'تقدير احتياجات الصيانة اليومية';

  @override
  String get toolHintBf => 'تقدير بطريقة البحرية الأمريكية';

  @override
  String get toolHintPlate => 'الوزن الإجمالي للبار';

  @override
  String get toolHintWarmup => 'وزن العمل المستهدف';

  @override
  String get toolDescRm => 'الحد الأقصى المقدر لتكرار واحد';

  @override
  String get toolDescBmi => 'مؤشر كتلة الجسم';

  @override
  String get toolDescCal => 'السعرات والمغذيات الكبرى';

  @override
  String get toolDescBf => 'نسبة دهون الجسم';

  @override
  String get toolDescPlate => 'حاسبة أقراص الأوزان';

  @override
  String get toolDescWarmup => 'مجموعات إحماء تصاعدية';

  @override
  String get bmiUnderweight => 'نقص الوزن';

  @override
  String get bmiNormal => 'وزن طبيعي';

  @override
  String get bmiOverweight => 'زيادة الوزن';

  @override
  String get bmiObese => 'السمنة';

  @override
  String get actSedentary => 'خامل';

  @override
  String get actLight => 'خفيف';

  @override
  String get actActive => 'نشط';

  @override
  String get actModerate => 'متوسط';

  @override
  String get muscleChest => 'الصدر';

  @override
  String get muscleBack => 'الظهر';

  @override
  String get muscleLowerBack => 'أسفل الظهر';

  @override
  String get muscleShoulders => 'الكتفان';

  @override
  String get muscleBiceps => 'البايسبس';

  @override
  String get muscleTriceps => 'الترايسبس';

  @override
  String get muscleForearm => 'الساعد';

  @override
  String get muscleTrapezius => 'الترابيس';

  @override
  String get muscleAbdomen => 'البطن';

  @override
  String get muscleObliques => 'العضلات المائلة';

  @override
  String get muscleQuads => 'العضلة الرباعية';

  @override
  String get muscleHamstrings => 'أوتار الركبة';

  @override
  String get muscleGlutes => 'الألوية';

  @override
  String get muscleCalves => 'ربلة الساق';

  @override
  String get mgChest => 'الصدر';

  @override
  String get mgBack => 'الظهر';

  @override
  String get mgLegs => 'الأرجل';

  @override
  String get mgShoulders => 'الكتفان';

  @override
  String get mgArms => 'الذراعان';

  @override
  String get mgCore => 'الجذع';

  @override
  String get equipBarbell => 'بار حديد';

  @override
  String get equipDumbbell => 'دمبل';

  @override
  String get equipCable => 'كابل';

  @override
  String get equipMachine => 'آلة';

  @override
  String get equipBodyweight => 'وزن الجسم';

  @override
  String get equipWeighted => 'بوزن إضافي';

  @override
  String get equipBand => 'شريط مقاومة';

  @override
  String get equipKettlebell => 'كيتل بيل';

  @override
  String get equipRings => 'حلقات';

  @override
  String get equipOther => 'أخرى';

  @override
  String get diffBeginner => 'مبتدئ';

  @override
  String get diffAdvanced => 'متقدم';

  @override
  String get diffIntermediate => 'متوسط';

  @override
  String get about => 'حول';

  @override
  String version(String v) {
    return 'الإصدار $v';
  }

  @override
  String get aboutBlurb => 'صنعه متدربون للمتدربين.';

  @override
  String get freeForever => 'مجاني إلى الأبد';

  @override
  String get freeForeverWhy => 'لا اشتراك ولا إعلانات ولا ميزات محجوبة بالدفع.';

  @override
  String get fullyOffline => '100% دون اتصال';

  @override
  String get fullyOfflineWhy => 'لا حساب ولا خادم. تمارينك لا تغادر هذا الهاتف أبدًا.';

  @override
  String get yoursToTake => 'بياناتك ملكك';

  @override
  String get yoursToTakeWhy => 'صدّرها بصيغة CSV متى شئت واحذف كل شيء بخطوة واحدة.';

  @override
  String get whatsInside => 'المحتوى';

  @override
  String exercisesInside(int n) {
    return '$n تمارين';
  }

  @override
  String get exercisesInsideWhy => 'لكل تمرين رسوم متحركة وتعليمات خطوة بخطوة.';

  @override
  String get calculatorsInside => '10 حاسبات';

  @override
  String get calculatorsInsideWhy =>
      '1RM والأقراص ومؤشر كتلة الجسم والسعرات ودهون الجسم وFFMI والإحماء والوزن حسب RPE ونقاط القوة DOTS وWilks — كلها مبنية على معادلات منشورة.';

  @override
  String get mathInside => 'حسابات شفافة';

  @override
  String get mathInsideWhy =>
      'يتم حساب الحجم والأرقام القياسية والمجموعات من بياناتك أنت. لا شيء للزينة فقط.';

  @override
  String get streakCaps => 'السلسلة';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'أيام', one: 'يوم');
    return '$_temp0';
  }

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get welcomeKicker => 'مرحبًا بك في';

  @override
  String get welcomeBlurb => 'كل شيء يبقى على هاتفك. لا حساب ولا إنترنت ولا دفع.';

  @override
  String get welcomeStart => 'ابدأ';

  @override
  String onbStep(int i, int n) {
    return 'الخطوة $i من $n';
  }

  @override
  String get onbNameTitle => 'ماذا نادِيك؟';

  @override
  String get onbNameHint => 'اسمك الأول';

  @override
  String get onbNameWhy => 'يُستخدم فقط لتحيتك. لا يغادر هاتفك أبدًا.';

  @override
  String get onbBodyTitle => 'بعض البيانات';

  @override
  String get onbBodyWhy => 'تُستخدم في الحاسبات. يمكنك تغييرها في الإعدادات في أي وقت.';

  @override
  String get onbGoalTitle => 'كم مرة تتمرن؟';

  @override
  String get onbGoalWhy => 'يحدد هدفك الأسبوعي. كن واقعيًا ولا تبالغ في الطموح.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمارين في الأسبوع',
      one: 'تمرين واحد في الأسبوع',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'كيلوغرام أم رطل؟';

  @override
  String get next => 'التالي';

  @override
  String get back => 'رجوع';

  @override
  String get skip2 => 'تخطَّ';

  @override
  String get madeWithLoveBy => 'صُنع بحب بواسطة';

  @override
  String get sourceCode => 'الكود المصدري';

  @override
  String get suggested => 'مقترح';

  @override
  String get results => 'النتائج';

  @override
  String get noMatches => 'لا يوجد تمرين يطابق هذا البحث.';

  @override
  String get tapToEdit => 'اضغط على القلم لتعديل الإدخال أو سلة المهملات لحذفه.';

  @override
  String get editEntry => 'تعديل';

  @override
  String get editEntryHint => 'صحح التكرارات أو الوزن لأي مجموعة.';

  @override
  String get removeSet => 'حذف المجموعة';

  @override
  String get continueWorkout => 'متابعة';

  @override
  String get continueWorkoutBody =>
      'سيستأنف التمرين مع المجموعات المحددة مسبقًا. عند إنهائه مرة أخرى سيُحفظ بتاريخِه الأصلي.';

  @override
  String get addBodyWidget => 'إضافة أداة خريطة العضلات';

  @override
  String get repsOnly => 'تكرارات فقط';

  @override
  String get repsOnlyHint => 'سجّل هذا التمرين دون وزن.';

  @override
  String get useDefaultArt => 'العودة إلى الرسم الافتراضي';

  @override
  String daysShort(int n) {
    return '$n ي';
  }

  @override
  String get focusCard => 'تركيز اليوم';

  @override
  String get autoAdvance => 'الانتقال تلقائيًا إلى التالي';

  @override
  String get keepScreenOn => 'إبقاء الشاشة مضاءة أثناء التمرين';

  @override
  String get lockWorkout => 'قفل الشاشة';

  @override
  String get unlockWorkout => 'فتح القفل';

  @override
  String get holdToUnlock => 'اضغط مطولًا لفتح القفل';

  @override
  String get liveChannel => 'تمرين جارٍ';

  @override
  String get liveChannelWhy => 'يعرض التمرين الحالي والمجموعة ومؤقت الراحة أثناء التمرين';

  @override
  String liveSet(int n, int total) {
    return 'المجموعة $n من $total';
  }

  @override
  String get liveResting => 'راحة';

  @override
  String get liveAllDone => 'اكتملت كل المجموعات';

  @override
  String get autoAdvanceHint => 'عند تحديد آخر مجموعة للتمرين، ينتقل التمرين تلقائيًا إلى التمرين التالي.';

  @override
  String get autoProgress => 'أضف وزنًا في المرة القادمة';

  @override
  String autoProgressHint(String w) {
    return 'أكمل كل التكرارات وسيبدأ التمرين التالي بزيادة $w.';
  }

  @override
  String get placePlates => 'الأقراص والبار';

  @override
  String get platesAll => 'كل شيء متاح';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n مقاسات', one: 'مقاس واحد');
    return '$_temp0';
  }

  @override
  String get platePairs => 'الأزواج';

  @override
  String plateAchievable(String w) {
    return 'أقرب وزن ممكن: $w';
  }

  @override
  String get autoWarmup => 'ابدأ بمجموعات الإحماء';

  @override
  String get autoWarmupHint => 'يضيف مجموعات إحماء تصاعدية عند فتح التمرين.';

  @override
  String get trainReminder => 'تذكير بالتمرين';

  @override
  String get trainReminderHint => 'تذكير في هذا الوقت، فقط في الأيام التي يكون فيها روتينك مجدولًا.';

  @override
  String get reminderExactTime => 'الوقت بالضبط';

  @override
  String get toastSoundSetting => 'صوت التنبيهات';

  @override
  String get toastSoundHint => 'نغمة خفيفة عند ظهور تنبيه في الأعلى.';

  @override
  String get notifTrainChannel => 'تذكير بالتمرين';

  @override
  String get notifTrainChannelWhy => 'تذكير للتمرن في الأيام التي خططت لها.';

  @override
  String get notifTrainTitle => 'حان وقت التمرين';

  @override
  String get notifTrainBody => 'روتينك بانتظارك.';

  @override
  String get planIntro => 'أنشئ لي روتين تدريب باستخدام التمارين الموجودة في هذه القائمة فقط.';

  @override
  String get planFormat => 'أجب بصيغة JSON فقط، بهذا الشكل:';

  @override
  String get planNothing => 'لا يوجد تمرين في هذا الملف يطابق مكتبتك';

  @override
  String get planFailed => 'هذا الملف ليس روتينًا يمكن لـ GymMane قراءته';

  @override
  String get routineGroup => 'مجموعة';

  @override
  String get newGroup => 'مجموعة جديدة';

  @override
  String get noGroup => 'بدون مجموعة';

  @override
  String get groupNameHint => 'دفع / سحب / أرجل، 5×5…';

  @override
  String get filters => 'عوامل التصفية';

  @override
  String get setsPlannedHint => 'اختر عدد المجموعات لكل تمرين. سيفتح التمرين وكل شيء جاهز.';

  @override
  String get nextTime => 'المرة القادمة';

  @override
  String get nextHold => 'حافظ على نفس الوزن حتى تكمل كل التكرارات';

  @override
  String get bgPhoto => 'صورتك';

  @override
  String get bgPhotoPick => 'اختر صورة';

  @override
  String get bgPhotoChange => 'تغيير الصورة';

  @override
  String get bgPhotoRemove => 'إزالة الصورة';

  @override
  String get bgDim => 'التعتيم';

  @override
  String get dimSoft => 'خفيف';

  @override
  String get dimMedium => 'متوسط';

  @override
  String get dimStrong => 'قوي';

  @override
  String get bgPhotoHint => 'تظهر خلف الواجهة كلها مع تعتيمها للحفاظ على وضوح التطبيق.';

  @override
  String get reminderSmart => 'ذكي';

  @override
  String get reminderFixed => 'وقت ثابت';

  @override
  String get reminderSmartHint =>
      'يستخدم الأيام والأوقات التي تتمرن فيها فعليًا ويبقى صامتًا إذا كنت قد تمرنت في ذلك اليوم بالفعل.';

  @override
  String get reminderSmartEmpty => 'سجّل بضعة تمارين أخرى ليتعلم عاداتك.';

  @override
  String habitFocus(String day) {
    return 'ما تتمرن عليه عادةً يوم $day';
  }

  @override
  String get duplicateRoutine => 'تكرار الروتين';

  @override
  String copySuffix(String name) {
    return '$name (نسخة)';
  }

  @override
  String get saveAsRoutine => 'حفظ كروتين';

  @override
  String get savedAsRoutine => 'تم الحفظ كروتين';

  @override
  String get templates => 'روتينات جاهزة';

  @override
  String get templatesHint => 'روتينات كلاسيكية مبنية من مكتبتك. يمكنك تعديل كل شيء بعدها.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تمت إضافة $n روتينات',
      one: 'تمت إضافة روتين واحد',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'ثلاث تمارين لكامل الجسم أسبوعيًا. مثالي للبداية.';

  @override
  String get tplPpl => 'دفع وسحب وأرجل. ثلاثة أو ستة أيام أسبوعيًا.';

  @override
  String get tplUpperlower => 'الجزء العلوي والسفلي، أربعة أيام أسبوعيًا.';

  @override
  String get tplStronglifts => 'تمرينان بالتناوب، خمس مجموعات من خمس تكرارات.';

  @override
  String get tplStartingstrength => 'قرفصاء في كل تمرين، مع تمرينين بالتناوب.';

  @override
  String get tplHome => 'لا شيء سوى عقلة وأرضية.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n أيام', one: 'يوم واحد');
    return '$_temp0';
  }

  @override
  String get logRpe => 'تسجيل الجهد (RPE)';

  @override
  String get rpeHint => '10 = لا يمكن تكرار إضافي؛ 8 = نحو تكرارين احتياطيين.';

  @override
  String get superset => 'سوبر سيت';

  @override
  String get supersetLink => 'ربط بالتالي';

  @override
  String get supersetHint => 'لا راحة بين التمارين المرتبطة — تنتقل مباشرة إلى التالي.';

  @override
  String get aiRoutine => 'روتين بالذكاء الاصطناعي';

  @override
  String get aiIntro =>
      'لا يتواصل GymMane مباشرةً مع أي ذكاء اصطناعي. تصدّر قائمة تمارينك وتلصقها في المساعد الذي تستخدمه ثم تستورد رده. لا شيء يغادر هاتفك تلقائيًا.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n أسماء غير موجودة في مكتبتك',
      one: 'اسم واحد غير موجود في مكتبتك',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'التطبيقات المدعومة';

  @override
  String get importOtherCsv => 'أي ملف CSV آخر يحتوي على التاريخ والتمرين والتكرارات والوزن';

  @override
  String get importAskApp => 'تحتاج تطبيقًا آخر؟ اطلب إضافته';

  @override
  String get awardFirstStepName => 'الخطوة الأولى';

  @override
  String get awardFirstStepLine => 'مرحبًا بك في GymMane. هذه هدية لك.';

  @override
  String get awardFirstWorkoutName => 'التمرين الأول';

  @override
  String get awardFirstWorkoutLine => 'تم تسجيل الأول. وهو الأصعب.';

  @override
  String get awardFirstRoutineName => 'الروتين الأول';

  @override
  String get awardFirstRoutineLine => 'لديك الآن خطة يمكنك العودة إليها.';

  @override
  String get awardFirstRecordName => 'الرقم القياسي الأول';

  @override
  String get awardFirstRecordLine => 'تفوقت على أفضل نتيجة لك في تمرين.';

  @override
  String get awardStreak3Name => 'ثلاثة متتالية';

  @override
  String get awardStreak3Line => 'ثلاثة أيام متتالية. هكذا تبدأ العادة.';

  @override
  String get awardTonne1Name => 'طن واحد';

  @override
  String get awardTonne1Line => 'رفعت ألف كيلوغرام إجمالًا عبر مجموعاتك.';

  @override
  String get awardSets100Name => 'مئة مجموعة';

  @override
  String get awardSets100Line => 'أكملت مئة مجموعة، واحدة تلو الأخرى.';

  @override
  String get awardHours10Name => 'عشر ساعات';

  @override
  String get awardHours10Line => 'عشر ساعات من التدريب على العداد.';

  @override
  String get awardWorkouts50Name => 'خمسون تمرينًا';

  @override
  String get awardWorkouts50Line => 'خمسون تمرينًا أصبحت خلفك.';

  @override
  String get awardHours50Name => 'خمسون ساعة';

  @override
  String get awardHours50Line => 'خمسون ساعة قضيتها في التدريب.';

  @override
  String get awardsTitle => 'الميداليات';

  @override
  String get yearTitle => 'سنتك';

  @override
  String get yearBestMonth => 'أفضل شهر';

  @override
  String get yearMonths => 'أشهر';

  @override
  String get awardSpinHint => 'اسحب على الميدالية لتدويرها';

  @override
  String get awardUnlocked => 'تم فتح إنجاز جديد';

  @override
  String get awardNice => 'رائع!';

  @override
  String get awardSaveImage => 'حفظ الصورة';

  @override
  String get awardSaved => 'تم الحفظ في معرض الصور';

  @override
  String get awardStreak7Name => 'سبعة أيام';

  @override
  String get awardStreak7Line => 'أسبوع كامل دون تفويت يوم.';

  @override
  String get awardStreak30Name => 'ثلاثون يومًا';

  @override
  String get awardStreak30Line => 'شهر كامل متواصل. أصبحت عادة الآن.';

  @override
  String get awardWorkouts100Name => 'مئة تمرين';

  @override
  String get awardWorkouts100Line => 'تم تسجيل مئة تمرين من البداية حتى النهاية.';

  @override
  String get awardTonnes100Name => 'مئة طن';

  @override
  String get awardTonnes100Line => 'بلغ مجموع ما رفعته 100,000 كغ.';

  @override
  String get awardSets1000Name => 'ألف مجموعة';

  @override
  String get awardSets1000Line => 'مجموعة تلو الأخرى حتى الألف.';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get pickBadge => 'شارة';

  @override
  String get statWorkouts => 'التمارين';

  @override
  String get statTrained => 'التدريب';

  @override
  String get statSets => 'المجموعات';

  @override
  String get statLifted => 'مرفوع';

  @override
  String get statStreak => 'السلسلة';

  @override
  String get statDays => 'أيام';

  @override
  String get unitHours => 'س';

  @override
  String get unitDays => 'أيام';

  @override
  String get snapshots => 'الصور';

  @override
  String get snapNow => 'التقاط الآن';

  @override
  String get addCover => 'إضافة غلاف';

  @override
  String get addTodayWidget => 'هل تم تمرين اليوم أم لا';

  @override
  String get photosCard => 'صورك';

  @override
  String get handleLabel => 'اسم المستخدم';

  @override
  String get setupTitle => 'املأ هذه البيانات وسيتم ملء بقية الصفحة تلقائيًا';

  @override
  String get setupHint => 'كل رقم هنا يأتي مما تسجله. لا يتم إرسال شيء إلى أي مكان.';

  @override
  String get setupWorkout => 'سجّل تمرينك الأول';

  @override
  String get setupWeight => 'سجّل وزن جسمك';

  @override
  String get setupMeasures => 'خذ قياسات جسمك';

  @override
  String get setupPhoto => 'التقط أول صورة تقدم';

  @override
  String get progressTitle => 'التقدم';

  @override
  String get tileVolume30 => 'الحجم · 30 يومًا';

  @override
  String get tileAddWeight => 'أضف قيمتك';

  @override
  String get heatToneTitle => 'لون الخريطة الحرارية';

  @override
  String get heatToneHint => 'يغير لون الشبكة والجسم فقط.';

  @override
  String get thisWeekTitle => 'هذا الأسبوع';

  @override
  String get momentsEmptyTitle => 'لا يوجد شيء هنا بعد';

  @override
  String get deletePhotoTitle => 'حذف هذه الصورة؟';

  @override
  String get deletePhotoBody => 'سيتم حذفها نهائيًا.';

  @override
  String get awardsEarned => 'مكتسبة';

  @override
  String get awardsLocked => 'مقفلة';

  @override
  String get awardStreak100Name => 'مئة يوم';

  @override
  String get awardWorkouts10Name => 'عشرة تمارين';

  @override
  String get awardWorkouts10Line => 'العشرة الأولى هي التي تصنع الفرق.';

  @override
  String get awardWorkouts365Name => 'ثلاثمئة وخمسة وستون';

  @override
  String get awardWorkouts365Line => 'تمرين لكل يوم من أيام السنة، مسجل واحدًا تلو الآخر.';

  @override
  String get awardTonnes10Name => 'عشرة أطنان';

  @override
  String get awardTonnes10Line => 'مرّ عشرة آلاف كيلوغرام بين يديك.';

  @override
  String get awardHours100Name => 'مئة ساعة';

  @override
  String get awardHours100Line => 'مئة ساعة تحت البار، والمؤقت يعمل.';

  @override
  String awardWonOn(String date) {
    return 'تم الحصول عليها في $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'ذهبي',
      'blue': 'أزرق',
      'green': 'أخضر',
      'other': 'شارة',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'منذ $date';
  }

  @override
  String levelShort(int n) {
    return 'المستوى $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمارين حتى المستوى $next',
      one: 'تمرين واحد حتى المستوى $next',
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
      'ember': 'جمر',
      'green': 'أخضر',
      'blue': 'أزرق',
      'mono': 'رمادي',
      'other': 'لون',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n مجموعات';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n من $goal هذا الأسبوع';
  }

  @override
  String momentCount(int n) {
    return '$n صور';
  }

  @override
  String photosSelected(int n) {
    return '$n محددة';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'حذف $n صور؟';
  }

  @override
  String get momentsEmptyHint =>
      'التقط صورة للنادي أو اللوح أو بار محمّل — أي شيء تريد تذكره. تبقى الصور على هاتفك ولا يراها سواك.';

  @override
  String get awardStreak100Line => 'مئة يوم متتالية. لم يعد الأمر دافعًا، بل أصبح عادة.';

  @override
  String get coverLabel => 'الغلاف';

  @override
  String get removeCover => 'إزالة الغلاف';

  @override
  String get startTitle => 'بدء تمرين';

  @override
  String get logTitle => 'تسجيل تمرين';

  @override
  String get logHint => 'بدون مؤقت — فقط أدخل ما فعلته.';

  @override
  String get orStartFrom => 'أو ابدأ بـ';

  @override
  String get pickExercisesOption => 'اختيار تمارين';

  @override
  String get chooseFocusOption => 'اختيار التركيز';

  @override
  String get plannedRoutine => 'مخطط';

  @override
  String get logWorkoutAction => 'تسجيل تمرين';

  @override
  String get logging => 'جارٍ التسجيل';

  @override
  String get placesLabel => 'أماكني';

  @override
  String get undo => 'تراجع';

  @override
  String get deleteSet => 'حذف المجموعة';

  @override
  String get setDeleted => 'حُذفت المجموعة';

  @override
  String get removeWarmup => 'إزالة الإحماء';

  @override
  String get addWeightAction => 'إضافة وزن';

  @override
  String get workoutOverview => 'هذا التمرين';

  @override
  String get allExercisesShort => 'الكل';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total مجموعات';
  }

  @override
  String get nowLabel => 'الآن';

  @override
  String get deleteWorkout => 'حذف التمرين';

  @override
  String get deleteWorkoutBody => 'سيُحذف هذا التمرين وكل مجموعاته من سجلك.';

  @override
  String get themeAuto => 'تلقائي';

  @override
  String get themeAutoHint => 'يتبع هاتفك';

  @override
  String get demoSizeTitle => 'عرض التمرين أثناء التدريب';

  @override
  String get demoLarge => 'كبير';

  @override
  String get demoSmall => 'صغير';

  @override
  String get demoOff => 'مخفي';

  @override
  String get demoLoopTitle => 'حركة العرض';

  @override
  String get demoLoopAlways => 'متكررة';

  @override
  String get demoLoopShort => '10 ثوانٍ';

  @override
  String get demoLoopHint => 'تتحرك نحو 10 ثوانٍ ثم تتوقف عند وضعية البداية. المس العرض لمشاهدته مرة أخرى.';

  @override
  String get alarmStyleTitle => 'عند انتهاء الراحة';

  @override
  String get alarmStyleLoud => 'رنين دائمًا';

  @override
  String get alarmStyleQuiet => 'اتباع الوضع الصامت';

  @override
  String get alarmStyleVibrate => 'اهتزاز فقط';

  @override
  String get alarmStyleHint =>
      '«رنين دائمًا» يستخدم صوت المنبه حتى في الوضع الصامت. «اتباع الوضع الصامت» يستخدم صوت الإشعارات ويهتز فقط عندما يكون الهاتف صامتًا.';

  @override
  String get suggestedPicks => 'مقترحة لك';

  @override
  String get moreOptions => 'خيارات أخرى';

  @override
  String get suggestInWorkouts => 'اقتراحه في التمارين السريعة';

  @override
  String get suggestInWorkoutsHint => 'عند إيقافه لن يظهر في الاقتراحات. يمكنك دائمًا إضافته يدويًا.';

  @override
  String get onbPlaceTitle => 'أين تتمرن؟';

  @override
  String get onbPlaceWhy => 'اختر كل الأماكن التي تتمرن فيها. سنقترح فقط ما يمكنك فعله في كل منها.';

  @override
  String get onbPlaceGear => 'ماذا لديك هناك؟';

  @override
  String distanceCol(String unit) {
    return 'المسافة ($unit)';
  }

  @override
  String get timeCol => 'الوقت';

  @override
  String get timeMinutesTitle => 'الوقت (دقائق)';

  @override
  String get timeSecondsTitle => 'الوقت (ثوانٍ)';

  @override
  String distanceTitle(String unit) {
    return 'المسافة ($unit)';
  }

  @override
  String get holdLabel => 'ثبات';

  @override
  String get stopLabel => 'إيقاف';

  @override
  String startHold(String time) {
    return 'ابدأ · $time';
  }

  @override
  String get exerciseTypeLabel => 'التسجيل حسب';

  @override
  String get typeReps => 'التكرارات والوزن';

  @override
  String get typeTime => 'الوقت';

  @override
  String get typeCardio => 'المسافة والوقت';

  @override
  String get exerciseTypeHint =>
      'الكارديو مثل الجري أو السباحة يسجل المسافة والوقت. تمارين الثبات مثل البلانك تسجل الوقت.';

  @override
  String get howToLabel => 'طريقة الأداء (اختياري)';

  @override
  String get howToHint => 'خطوة في كل سطر';

  @override
  String get editExercise => 'تعديل التمرين';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get noStepsYet => 'لا توجد خطوات بعد. اكتب خطواتك لتتذكر كيف تؤديه.';

  @override
  String get addSteps => 'اكتب الخطوات';

  @override
  String get setTypeRestPause => 'راحة-توقف';

  @override
  String get setTypeNormalInfo => 'مجموعة عادية. تُحتسب في الحجم والأرقام القياسية.';

  @override
  String get setTypeWarmupInfo => 'مجموعات خفيفة للتهيئة. لا تُحتسب في الحجم ولا في الأرقام القياسية.';

  @override
  String get setTypeDropInfo => 'بعد المجموعة مباشرة، خفّف الوزن وتابع دون راحة.';

  @override
  String get setTypeFailureInfo =>
      'استمر حتى لا تستطيع تكرارًا نظيفًا آخر. سجّل التكرارات التي أنجزتها فعلًا.';

  @override
  String get setTypeRestPauseInfo => 'استرح من 10 إلى 20 ثانية بعد المجموعة، ثم أضف بضع تكرارات أخرى.';

  @override
  String get planFormatNotes =>
      'استخدم أسماء التمارين كما تظهر في القائمة تمامًا. الحقول \"sets\" و\"reps\" و\"weight\" (بالوحدة المحددة) و\"rest\" بالثواني و\"days\" اختيارية. \"superset\": true يربط التمرين بالتالي. لعدة أسابيع، اجمع الروتينات داخل \"weeks\" كما في المثال الثاني.';

  @override
  String get planSets => 'تخطيط المجموعات';

  @override
  String get planSetsHint =>
      'اختر النوع والتكرارات والوزن لكل مجموعة. اترك الوزن على «تلقائي» لتبدأ من آخر تمرين.';

  @override
  String get planHintReps => 'اختر نوع كل مجموعة وعدد تكراراتها. «تلقائي» يبدأ من جلستك الأخيرة.';

  @override
  String get planHintTime => 'اختر نوع كل مجموعة ومدتها. «تلقائي» يبدأ من جلستك الأخيرة.';

  @override
  String get planHintTimeWeight => 'اختر نوع كل مجموعة ومدتها ووزنها. «تلقائي» يبدأ من جلستك الأخيرة.';

  @override
  String get planHintCardio => 'اختر مسافة كل مجموعة ومدتها. «تلقائي» يبدأ من جلستك الأخيرة.';

  @override
  String get timeOnly => 'الوقت فقط';

  @override
  String get autoValue => 'تلقائي';

  @override
  String get clearPlan => 'مسح الخطة';

  @override
  String get shareRoutine => 'مشاركة الروتين';

  @override
  String get shareWeek => 'مشاركة أسبوعي';

  @override
  String get shareWeekHint => 'كل روتيناتك واليوم المخصص لكل منها.';

  @override
  String shareMessage(String name) {
    return '$name — افتح الملف باستخدام GymMane لإضافته.';
  }

  @override
  String get importRoutines => 'استيراد روتينات';

  @override
  String get importPasteHint => 'الصق روتينًا هنا: مشارك من GymMane أو رد من ذكاء اصطناعي أو JSON أو CSV.';

  @override
  String get pasteAction => 'لصق';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n روتين',
      few: '$n روتينات',
      two: 'روتينان',
      one: 'روتين واحد',
    );
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'استخدام جدوله الأسبوعي أيضًا';

  @override
  String get useTheirScheduleHint => 'الأيام التي يحملها تحل محل ما خططت له في تلك الأيام.';

  @override
  String get addToMyRoutines => 'إضافة إلى روتيناتي';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'أُضيف $n روتين',
      few: 'أُضيفت $n روتينات',
      two: 'أُضيف روتينان',
      one: 'أُضيف روتين واحد',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'لا يوجد هنا ما يمكن لـ GymMane استيراده';

  @override
  String get aiStepCopy => 'انسخ الطلب. يحتوي على قائمة تمارينك والتنسيق الذي يقرؤه GymMane.';

  @override
  String get aiStepAsk => 'الصقه في أي ذكاء اصطناعي وقل ما تريد: أيام في الأسبوع، الهدف، عدد الأسابيع.';

  @override
  String get aiStepPaste => 'الصق رده بالأسفل واستورده. لا حاجة لملف.';

  @override
  String get copyForAi => 'نسخ للذكاء الاصطناعي';

  @override
  String get copiedDone => 'تم النسخ';

  @override
  String get aiPasteHint => 'الصق رد الذكاء الاصطناعي هنا';

  @override
  String get importAction => 'استيراد';

  @override
  String get showFormat => 'عرض التنسيق';

  @override
  String get shareAsFile => 'مشاركة كملف';

  @override
  String get recoveryTab => 'التعافي';

  @override
  String recoveryOverall(int pct) {
    return 'الجسم متعافٍ بنسبة $pct%';
  }

  @override
  String get recoveryAllFresh => 'كل شيء متعافٍ. يوم جيد لتمرين أي شيء.';

  @override
  String recoveryStill(String muscles) {
    return 'ما زال يتعافى: $muscles';
  }

  @override
  String get recoveryTired => 'مُجهد';

  @override
  String get recoveryFresh => 'منتعش';

  @override
  String get recoveryHint =>
      'اضغط على عضلة لترى مدى تعافيها. المجموعات الأحدث تُحتسب أكثر، والأصعب (حسب RPE) أكثر بعد.';

  @override
  String recoveryPct(int pct) {
    return 'متعافٍ بنسبة $pct%';
  }

  @override
  String readyInHours(int h) {
    return 'جاهز خلال ~$h س';
  }

  @override
  String get tplAbcd => 'أربعة أيام: صدر وترايسبس، ظهر وبايسبس، أرجل، أكتاف وبطن.';

  @override
  String get tplAbcde => 'خمسة أيام، مجموعة عضلية لكل يوم: صدر، ظهر، أرجل، أكتاف، ذراعان.';

  @override
  String get elapsedCaps => 'المنقضي';

  @override
  String get tapToSkip => 'اضغط للتخطي';

  @override
  String get screenLocked => 'الشاشة مقفلة';

  @override
  String get lockedHint => 'اضغط مطولًا على البصمة في الأعلى لفتح القفل';

  @override
  String get liveDoneSet => 'انتهت المجموعة';

  @override
  String get liveSkipRest => 'تخطي الراحة';

  @override
  String get livePause => 'إيقاف مؤقت';

  @override
  String get liveResume => 'استئناف';

  @override
  String get liveNext => 'التالي';

  @override
  String liveUpNext(String name) {
    return 'التالي: $name';
  }

  @override
  String get stickerOpen => 'مشاركة على صورة';

  @override
  String get stickerNoPhoto => 'بدون صورة';

  @override
  String get stickerWorkout => 'تمرين';

  @override
  String get stickerStreak => 'سلسلة';

  @override
  String get stickerDate => 'التاريخ';

  @override
  String get stickerHint => 'اسحبها لتحريكها، واقرص لتغيير حجمها أو تدويرها';

  @override
  String get stickerSaved => 'حُفظت في معرض الصور';

  @override
  String get stickerWeek => 'هذا الأسبوع';

  @override
  String get getReady => 'استعد';

  @override
  String get stickerGallery => 'المعرض';

  @override
  String get stickerCamera => 'الكاميرا';

  @override
  String get shareIntroTitle => 'شارك هذا الروتين';

  @override
  String get shareIntroBody =>
      'أرسله إلى شريكك أو صديق أو عائلتك. سيصلهم ملف صغير يُفتح في GymMane ويضيف الروتين بلمسة واحدة، مع مجموعاته وأوزانه.';

  @override
  String get removedFromRoutine => 'أُزيل من الروتين';

  @override
  String get radarTitle => 'آخر 30 يومًا';

  @override
  String get radarHint => 'اعرف أي المناطق تحتاج إلى تمرين أكثر';

  @override
  String get radarEmpty => 'تمرن بضعة أيام لترى توازنك';

  @override
  String get radarBalanced => 'توازن جيد حتى الآن';

  @override
  String radarFocus(String list) {
    return 'يحتاج إلى المزيد: $list';
  }

  @override
  String get countdownReady => 'استعد';

  @override
  String get countdownSkip => 'اضغط للبدء الآن';

  @override
  String get countdownSetting => 'عدّ تنازلي قبل البدء';

  @override
  String get effortSetting => 'سجّل الجهد';

  @override
  String get effortHint =>
      'RPE: ‏10 يعني أنك لا تستطيع تكرارًا آخر، و8 يعني أنه بقي لديك تكراران. RIR يعدّ التكرارات المتبقية. إذا كانت المجموعة تحتوي عليه، يستخدم الحد الأقصى المقدَّر جدول RPE.';

  @override
  String get rirHint => '0 يعني أنك لا تستطيع تكرارًا آخر، و2 يعني أنه بقي لديك تكراران.';

  @override
  String get addWeekWidget => 'إضافة أداة الأسبوع';

  @override
  String get gamificationSetting => 'الميداليات والمستويات';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تكرارًا',
      few: '$n تكرارات',
      two: 'تكراران',
      one: 'تكرار واحد',
    );
    return '$_temp0';
  }

  @override
  String get prBestSet => 'أفضل مجموعة';

  @override
  String get weekStartSetting => 'يبدأ الأسبوع يوم';

  @override
  String get stepOutOfWorkout => 'إيقاف مؤقت والخروج';

  @override
  String get saveToRoutine => 'حفظ التغييرات في الروتين';

  @override
  String get routineUpdated => 'تم تحديث الروتين';

  @override
  String saveChangesTitle(String name) {
    return 'حفظ التغييرات في $name؟';
  }

  @override
  String get saveChangesBody => 'في المرة القادمة التي تبدأه فيها، سيتضمن الروتين هذه التغييرات.';

  @override
  String get routineOrderChanged => 'ترتيب جديد للتمارين';

  @override
  String get mineOnly => 'من إنشائك';

  @override
  String createNamed(String name) {
    return 'غير موجود؟ أنشئ «$name»';
  }

  @override
  String get orStartWith => 'أو ابدأ بـ';

  @override
  String get warmupFocus => 'الإحماء';

  @override
  String get warmupFocusHint => 'مرونة وتنشيط، بأدوات أو بدونها';

  @override
  String get cardioFocus => 'كارديو';

  @override
  String get cardioFocusHint => 'جري أو دراجة أو تجديف أو حبل، بالمسافة والوقت';

  @override
  String get homeRecommended => 'المقترحات في الرئيسية';

  @override
  String get archivedFilter => 'المؤرشفة';

  @override
  String get archiveExercise => 'أرشفة التمرين';

  @override
  String get restoreExercise => 'استعادة';

  @override
  String get archivedToast => 'تمت أرشفة التمرين';

  @override
  String get archivedToastHint => 'تجده في التمارين › المؤرشفة';

  @override
  String get archivedBanner => 'مؤرشف. لا يظهر في القوائم ولا الاقتراحات، ويبقى سجلك محفوظًا.';

  @override
  String get videoMarksHint => 'أوقف مؤقتًا عند خطوة واضغط الدبوس لتنتقل إليها في المرة القادمة.';

  @override
  String get videoMarkHere => 'حدّد هذه الخطوة هنا';

  @override
  String get sectionGeneral => 'عام';

  @override
  String get sectionTraining => 'التمرين';

  @override
  String get sectionAlerts => 'التذكيرات والمنبّه';

  @override
  String get sectionHome => 'الرئيسية';

  @override
  String get sectionWidgets => 'الأدوات';

  @override
  String get sectionData => 'البيانات والنسخ الاحتياطي';

  @override
  String get multiPlanSetting => 'أكثر من روتين في اليوم';

  @override
  String get multiPlanHint => 'اضغط كل روتين لهذا اليوم. تأتي بالترتيب الذي تضيفها به.';

  @override
  String routineOfDay(int n, int total) {
    return '$n من $total اليوم';
  }

  @override
  String get nextToday => 'التالي اليوم';

  @override
  String get planAboutMe => 'عني:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex، $age سنة، الطول $height، الوزن $weight.';
  }

  @override
  String planDays(int n) {
    return 'أريد التمرين $n أيام في الأسبوع.';
  }

  @override
  String get planNoHistory => 'لم أسجّل أي تمرين بعد: اعتبرني مبتدئًا وكن حذرًا في الحجم والأوزان.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمارين في آخر 30 يومًا.',
      one: 'تمرين واحد في آخر 30 يومًا.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'أفضل المجموعات الأخيرة';

  @override
  String get planAskFirst =>
      'إذا لم تكن تعرف هدفي (قوة أو عضل أو خسارة دهون أو لياقة عامة) أو مدة كل حصة، فاسألني أولًا برسالة قصيرة. بعدها أجب بـ JSON فقط.';

  @override
  String get backToTop => 'العودة للأعلى';

  @override
  String get deleteExerciseTitle => 'حذف هذا التمرين؟';

  @override
  String deleteExerciseBody(String name) {
    return 'سيُزال «$name» من مكتبتك ومن روتيناتك. تبقى مجموعاتك السابقة محفوظة.';
  }

  @override
  String get exportForStravaHint =>
      'ارفعه من المتصفح على strava.com/upload/select (تطبيق Strava لا يستورد الملفات). سيظهر كتمرين أوزان مع مجموعاتك.';

  @override
  String get manualStartTime => 'وقت البدء';

  @override
  String get manualDuration => 'المدة';

  @override
  String get manualDurationUnset => 'أضف المدة';

  @override
  String get stravaRow => 'تصدير إلى Strava (تجريبي)';

  @override
  String get stravaBeta => 'تجريبي';

  @override
  String get stravaIntro =>
      'اختر تمرينًا لنقله إلى Strava. ستحصل على ملف .fit: ارفعه من المتصفح على strava.com/upload/select وسيظهر كتمرين أوزان مع مجموعاتك.';

  @override
  String get stravaEmpty => 'لا توجد تمارين للتصدير بعد.';

  @override
  String get tapToPause => 'اضغط للإيقاف المؤقت';

  @override
  String get holdPausedHint => 'متوقف مؤقتًا · اضغط للمتابعة';

  @override
  String get finishHoldNow => 'أنهِ المجموعة الآن';

  @override
  String get barWeightExercise => 'وزن البار أو المزلجة';

  @override
  String get barWeightHint => 'تستخدمه حاسبة الأقراص';

  @override
  String get barWeightCustom => 'مخصص · اضغط لإعادة الضبط';

  @override
  String get groupRename => 'إعادة تسمية المجموعة';

  @override
  String get groupUngroup => 'إزالة المجموعة مع إبقاء الروتينات';

  @override
  String get groupDeleteAll => 'حذف المجموعة وروتيناتها';

  @override
  String groupDeleteTitle(String name) {
    return 'حذف «$name»؟';
  }

  @override
  String groupDeleteBody(String count) {
    return 'سيتم حذف $count. يبقى سجل تمارينك كما هو.';
  }

  @override
  String get tplRr =>
      'الروتين الكلاسيكي من r/bodyweightfitness: الجسم كله ثلاثة أيام في الأسبوع. انتقل إلى المستوى التالي حين يصبح سهلًا.';

  @override
  String get levelUpKicker => 'الخطوة التالية';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps في $name في تمرينين متتاليين. هل أنت مستعد للخطوة التالية؟';
  }

  @override
  String levelUpSwap(String routine) {
    return 'استبدله في $routine';
  }

  @override
  String get levelUpSee => 'شاهد طريقة الأداء';

  @override
  String get levelUpLater => 'ليس الآن';

  @override
  String get levelUpStay => 'سأبقى على هذا';

  @override
  String levelUpSwapped(String name, String routine) {
    return 'أصبح $name في $routine';
  }

  @override
  String get levelUpStayed => 'لن نقترح الترقي في هذا التمرين';

  @override
  String get levelHintsSetting => 'اقتراح الخطوة التالية';

  @override
  String get heatmapLabelsSetting => 'الأيام والأشهر على خريطة النشاط';

  @override
  String get rmPercent => 'النسبة';

  @override
  String rmAtPercent(String pct) {
    return '$pct من حدك الأقصى';
  }

  @override
  String get copyWorkout => 'نسخ كنص';

  @override
  String get goalSet => 'حدّد هدفًا';

  @override
  String get goalTargetReps => 'التكرارات المستهدفة';

  @override
  String goalToGo(String value) {
    return 'بقي $value';
  }

  @override
  String get goalReached => 'تم بلوغ الهدف';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'بقي $n يوم', one: 'بقي يوم واحد');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'فات الموعد';

  @override
  String get goalDeadline => 'الموعد النهائي';

  @override
  String get goalNoDeadline => 'بلا موعد';

  @override
  String get goalRemove => 'إزالة الهدف';

  @override
  String get exerciseNameMissing => 'أعطه اسمًا';

  @override
  String get aliasesLabel => 'أسماء أخرى (اختياري)';

  @override
  String get aliasesHint => 'أسماء أخرى، مفصولة بفواصل';

  @override
  String alsoCalled(String names) {
    return 'يُعرف أيضًا بـ: $names';
  }

  @override
  String get addToRoutine => 'إضافة إلى روتين';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'في $n روتينات',
      one: 'في روتين واحد',
      zero: 'ليس في أي روتين بعد',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'موجود بالفعل';

  @override
  String get restInRoutine => 'الراحة في هذا الروتين';

  @override
  String get restInRoutineHint => 'نفس راحة التمرين';

  @override
  String get restInRoutineReset => 'هنا فقط · اضغط للإلغاء';

  @override
  String get swapExercise => 'تبديل التمرين';

  @override
  String get swapShort => 'تبديل';

  @override
  String swapHint(String name) {
    return 'بدلًا من $name، لهذا اليوم فقط. عند الانتهاء يمكنك إبقاؤه في الروتين.';
  }

  @override
  String get swapKeepsDone => 'المجموعات التي أنهيتها تبقى؛ والتمرين الجديد يكمل الباقي.';

  @override
  String swapSameMuscle(String muscle) {
    return 'نفس العضلة · $muscle';
  }

  @override
  String get swapDoneBefore => 'قمت به من قبل';

  @override
  String get multiPlanSettingHint => 'أكثر من روتين في نفس يوم الأسبوع.';

  @override
  String get levelHintsHint => 'عندما يصبح التمرين سهلًا، يقترح عليك النسخة الأصعب.';

  @override
  String get focusCardHint => 'روتين اليوم في أعلى الصفحة الرئيسية.';

  @override
  String get gamificationHint => 'الميداليات ومستواك والاحتفال عند الانتهاء.';

  @override
  String get exerciseSettings => 'إعدادات هذا التمرين';

  @override
  String get placeActiveNow => 'أنت هنا';

  @override
  String get placeTapToUse => 'اضغط للتمرن هنا';

  @override
  String get intervalDays => 'أيام';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target أيام';
  }

  @override
  String get toolNameRpe => 'الوزن حسب RPE';

  @override
  String get toolTitleRpe => 'الوزن حسب RPE';

  @override
  String get toolDescRpe => 'أي وزن للجهد الذي تريده';

  @override
  String get toolNameDots => 'مستوى القوة';

  @override
  String get toolTitleDots => 'مستوى القوة (DOTS)';

  @override
  String get toolDescDots => 'قوتك بالنسبة لوزنك';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'لـ $reps تكرارات عند RPE $rpe';
  }

  @override
  String get rpeYourSet => 'مجموعة أنهيتها للتو';

  @override
  String get rpeGoal => 'ما تريد فعله';

  @override
  String rpeOneRmLine(String value) {
    return 'الحد الأقصى المقدّر: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 يعني أنك لم تستطع تكرارًا آخر؛ 8 يعني أنه بقي لديك اثنان.';

  @override
  String get dotsBestLifts => 'أفضل أرقامك';

  @override
  String get dotsSquat => 'القرفصاء';

  @override
  String get dotsBench => 'ضغط البنش';

  @override
  String get dotsDeadlift => 'الرفعة الميتة';

  @override
  String dotsTotalLine(String value) {
    return 'المجموع: $value';
  }

  @override
  String get dotsExplain =>
      'يقارن قوتك بقوة أي شخص مهما كان وزنه. استخدم أفضل تكرار واحد لك أو الحد الأقصى المقدّر.';

  @override
  String get dotsLevel0 => 'مبتدئ';

  @override
  String get dotsLevel1 => 'متوسط';

  @override
  String get dotsLevel2 => 'متقدم';

  @override
  String get dotsLevel3 => 'متقدم جدًا';

  @override
  String get dotsLevel4 => 'نخبة';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'نقاط Wilks';

  @override
  String get toolDescWilks => 'النقاط الكلاسيكية لرفع القوة';

  @override
  String get wilksExplain =>
      'المعادلة الكلاسيكية لرفع القوة. حلّت DOTS محلها في 2020، لكن كثيرًا من البطولات والتصنيفات ما زالت تستخدمها.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'مؤشر الكتلة الخالية من الدهون';

  @override
  String get toolDescFfmi => 'كمية العضل بالنسبة لطولك';

  @override
  String get ffmiBodyFat => 'دهون الجسم';

  @override
  String ffmiLeanLine(String value) {
    return 'الكتلة الخالية من الدهون: $value';
  }

  @override
  String get ffmiExplain =>
      'مثل مؤشر كتلة الجسم لكن بدون الدهون: يحسب كتلتك الخالية من الدهون فقط، ومعدّل حسب طولك لتكون المقارنة عادلة بين الطوال والقصار.';

  @override
  String get ffmiLevel0 => 'أقل من المتوسط';

  @override
  String get ffmiLevel1 => 'متوسط';

  @override
  String get ffmiLevel2 => 'فوق المتوسط';

  @override
  String get ffmiLevel3 => 'ممتاز';

  @override
  String get ffmiLevel4 => 'استثنائي';

  @override
  String get rpeEffortLabel => 'الجهد (RPE)';

  @override
  String get restRowHint => 'بين المجموعات، إن لم يكن للتمرين وقته الخاص.';

  @override
  String get effortRowHint => 'سجّل RPE أو RIR في كل مجموعة.';

  @override
  String get countdownHint => '3، 2، 1 قبل أول مجموعة.';

  @override
  String get keepScreenOnHint => 'تبقى الشاشة مضاءة أثناء التمرين.';

  @override
  String get demoSizeRowHint => 'رسم التمرين أثناء الحصة.';

  @override
  String get demoLoopRowHint => 'هل تتكرر الحركة أم تتوقف.';

  @override
  String get trainReminderRowHint => 'تذكير في أيام تمرينك.';

  @override
  String get alarmSoundRowHint => 'ما يرن عند انتهاء الراحة.';

  @override
  String get alarmStyleRowHint => 'هل يرن في الوضع الصامت.';

  @override
  String get recommendedRowHint => 'تمارين نقترحها في الرئيسية.';

  @override
  String get weightStepSetting => 'خطوة الوزن';

  @override
  String get weightStepHint => 'ما تضيفه زرّا − و+.';

  @override
  String get prBestWorkout => 'أفضل تمرين';
}
