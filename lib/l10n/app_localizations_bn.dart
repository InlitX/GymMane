// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get languageName => 'বাংলা';

  @override
  String vsLastMonthLabel(String pct) {
    return 'গত মাসের তুলনায় $pct%';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'লেভেল $level · $streak';
  }

  @override
  String get save => 'সেভ করো';

  @override
  String get cancel => 'বাতিল';

  @override
  String get cancelCaps => 'বাতিল';

  @override
  String get deleteCaps => 'মুছে ফেলো';

  @override
  String get done => 'হয়ে গেছে';

  @override
  String get set => 'সেট';

  @override
  String get home => 'হোম';

  @override
  String get progress => 'অগ্রগতি';

  @override
  String get exercises => 'ব্যায়াম';

  @override
  String get settings => 'সেটিংস';

  @override
  String get today => 'আজ';

  @override
  String get thisWeek => 'এই সপ্তাহ';

  @override
  String get recommended => 'প্রস্তাবিত';

  @override
  String get goal => 'লক্ষ্য';

  @override
  String get volume => 'ভলিউম';

  @override
  String get setsToday => 'আজকের সেট';

  @override
  String get prs => 'PR';

  @override
  String get todaysFocus => 'আজকের ফোকাস';

  @override
  String get todaysRoutine => 'আজকের রুটিন';

  @override
  String get startWorkout => 'ওয়ার্কআউট শুরু করো';

  @override
  String get routines => 'রুটিন';

  @override
  String get tools => 'টুলস';

  @override
  String get firstSessionHint => 'তোমার পেশি বেছে নাও আর প্রথম সেশন লিখে রাখো';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ব্যায়াম',
      one: '$nটি ব্যায়াম',
    );
    return '$_temp0';
  }

  @override
  String get pushDay => 'পুশ ডে';

  @override
  String get pullDay => 'পুল ডে';

  @override
  String get legDay => 'লেগ ডে';

  @override
  String get pushFocus => 'বুক · কাঁধ · ট্রাইসেপস';

  @override
  String get pullFocus => 'পিঠ · বাইসেপস · ট্র্যাপস';

  @override
  String get legFocus => 'কোয়াড · হ্যামস্ট্রিং · গ্লুট';

  @override
  String get train => 'ট্রেনিং';

  @override
  String get step1 => 'ধাপ 1 / 2';

  @override
  String get step2 => 'ধাপ 2 / 2';

  @override
  String get chooseFocus => 'তোমার ফোকাস বেছে নাও';

  @override
  String get buildSession => 'তোমার সেশন সাজাও';

  @override
  String get tapMuscles => 'যে পেশিগুলো ট্রেন করতে চাও সেগুলোতে ট্যাপ করো, সামনে আর পেছনে।';

  @override
  String get continueBtn => 'এগিয়ে যাও';

  @override
  String get nothingForFocus => 'এই ফোকাসের জন্য এখনও কিছু নেই';

  @override
  String get goBackPick => 'ফিরে যাও আর এমন একটা পেশি বেছে নাও যার ব্যায়াম তোমার লাইব্রেরিতে আছে।';

  @override
  String pickedHint(int n) {
    return 'আমরা তোমার জন্য একটা সেশন বেছে দিয়েছি। $nটির যেকোনোটা যোগ বা বাদ দিতে ট্যাপ করো।';
  }

  @override
  String get pickAnExercise => 'একটা ব্যায়াম বেছে নাও';

  @override
  String get searchAllExercises => 'যেকোনো ব্যায়াম খোঁজো…';

  @override
  String get noExercisesMatch => 'কোনো ব্যায়াম মেলেনি';

  @override
  String get createItInstead => 'বরং নিজের ব্যায়াম হিসেবে বানাও';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ব্যায়াম',
      one: '$nটি ব্যায়াম',
    );
    return 'শুরু · $_temp0';
  }

  @override
  String get inProgress => 'চলছে';

  @override
  String get paused => 'থামানো';

  @override
  String get last => 'শেষবার';

  @override
  String get rest => 'বিশ্রাম';

  @override
  String get skip => 'বাদ দাও';

  @override
  String get addSet => '+ সেট যোগ করো';

  @override
  String get finishSession => 'সেশন শেষ করো';

  @override
  String get setDone => 'সেট শেষ';

  @override
  String get nextExercise => 'পরের ব্যায়াম';

  @override
  String get dropExerciseAction => 'ব্যায়াম বাদ দাও';

  @override
  String get restOff => 'বন্ধ';

  @override
  String get miniRest => 'রেস্ট-পজ আর ক্লাস্টার বিশ্রাম';

  @override
  String get miniRestHint => 'রেস্ট-পজ বা ক্লাস্টার সেটের আগে';

  @override
  String get gymPass => 'জিম পাস';

  @override
  String get gymPassEmpty => 'তোমার জিমের কোড এখানে রাখো আর কার্ড ছাড়াই ঢোকো';

  @override
  String get gymPassAdd => 'পাস যোগ করো';

  @override
  String get gymPassScan => 'কোডের ছবি তোলো';

  @override
  String get gymPassScanHint => 'ফোনের ক্যামেরা দিয়ে';

  @override
  String get gymPassPhoto => 'ছবি বা স্ক্রিনশট থেকে';

  @override
  String get gymPassPhotoHint => 'যেমন, তোমার জিমের অ্যাপের স্ক্রিনশট';

  @override
  String get gymPassType => 'নম্বরটা টাইপ করো';

  @override
  String get gymPassTypeHint => 'বারকোডের জন্য: এর নিচে ছাপা নম্বর';

  @override
  String get gymPassNotFound => 'ওই ছবিতে কোনো QR কোড নেই। আরও স্পষ্ট ছবি দাও বা নম্বরটা টাইপ করো।';

  @override
  String get gymPassName => 'জিমের নাম';

  @override
  String get gymPassDefaultName => 'আমার জিম';

  @override
  String get gymPassCode => 'কোড';

  @override
  String get gymPassFormat => 'কোডের ধরন';

  @override
  String get gymPassInvalid => 'ওই নম্বর এই কোডের ধরনের সাথে মেলে না';

  @override
  String get gymPassShowHint => 'রিডারের কাছে ধরো। উজ্জ্বলতা নিজে থেকেই বাড়বে।';

  @override
  String get gymPassDeleted => 'পাস মুছে ফেলা হয়েছে';

  @override
  String get gymPassEdit => 'পাস বদলাও';

  @override
  String get gymPassShow => 'দরজায় দেখাও';

  @override
  String get gymPassPrivate => 'শুধু তোমার ফোনে থাকে। কিছুই আপলোড হয় না।';

  @override
  String get gymPassColor => 'রং';

  @override
  String get gymPassRescan => 'কোডটা আবার পড়ো';

  @override
  String get gymPassReading => 'কোড পড়া হচ্ছে…';

  @override
  String get gymPassSettingHint => 'প্রোফাইলে তোমার জিম কার্ড';

  @override
  String get gymPassMember => 'সদস্য';

  @override
  String get widgetHintActivity => 'তোমার ট্রেনিংয়ের দিনগুলোর মানচিত্র';

  @override
  String get widgetHintStats => 'এই সপ্তাহের স্ট্রিক, ভলিউম আর সেশন';

  @override
  String get widgetHintBody => 'যে পেশিগুলোতে কাজ করেছ';

  @override
  String get widgetHintToday => 'এক নজরে: আজ ট্রেনিং হয়েছে?';

  @override
  String get widgetHintWeek => 'তোমার সপ্তাহের প্ল্যান, দিন ধরে ধরে';

  @override
  String get supportHintBug => 'GitHub-এ জানাও কী ভেঙেছে';

  @override
  String get supportHintFeature => 'অ্যাপের জন্য একটা আইডিয়া দাও';

  @override
  String get supportHintStar => 'আরও মানুষ এটা খুঁজে পায়';

  @override
  String get supportHintCoffee => 'উন্নয়নে সাহায্য করে। বিনামূল্যে আর বিজ্ঞাপন ছাড়া';

  @override
  String get bodyweightNoteHint => 'একটা নোট যোগ করো: কেমন লাগছে, কী চেষ্টা করছ… (ঐচ্ছিক)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'এই ব্যায়ামে $unit ব্যবহার করো';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'রেপ';

  @override
  String weightCol(String unit) {
    return 'ওজন ($unit)';
  }

  @override
  String get repsTitle => 'রেপ';

  @override
  String weightTitle(String unit) {
    return 'ওজন ($unit)';
  }

  @override
  String get sessionComplete => 'ওয়ার্কআউট লেখা হয়েছে';

  @override
  String get finishHeadlinePr => 'নতুন ব্যক্তিগত রেকর্ড';

  @override
  String get finishHeadlineGoal => 'সাপ্তাহিক লক্ষ্য পূরণ';

  @override
  String get finishHeadlineStreak => 'স্ট্রিক টিকে আছে';

  @override
  String get finishHeadlineDefault => 'আরও একটা খাতায় উঠল';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prsটি ব্যায়ামে',
      one: 'একটি ব্যায়ামে',
    );
    return 'তুমি $_temp0 আগের চেয়ে বেশি তুলেছ। এখন এটা তোমার রেকর্ডে আছে।';
  }

  @override
  String get finishBodyGoal => 'এই সপ্তাহে যতগুলো সেশন ঠিক করেছিলে, সব করেছ।';

  @override
  String finishBodyStreak(int streak) {
    return 'টানা $streak দিন। কঠিন অংশ হলো না থামা।';
  }

  @override
  String get finishBodyDefault => 'লেখা হলো, গোনা হলো। ধারাবাহিকতাই সংখ্যা বাড়ায়।';

  @override
  String get vsLastTime => 'গতবারের তুলনায়';

  @override
  String get firstTime => 'প্রথমবার লেখা';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি নতুন রেকর্ড',
      one: '$nটি নতুন রেকর্ড',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'সময়কাল';

  @override
  String get setsCaps => 'সেট';

  @override
  String exerciseXofY(int i, int n) {
    return 'ব্যায়াম $i / $n';
  }

  @override
  String get decrease => 'কমাও';

  @override
  String get increase => 'বাড়াও';

  @override
  String markSet(int n) {
    return 'সেট $n শেষ বলে চিহ্নিত করো';
  }

  @override
  String get pauseWorkout => 'ওয়ার্কআউট থামাও';

  @override
  String get resumeWorkout => 'ওয়ার্কআউট আবার শুরু করো';

  @override
  String get discardTitle => 'ওয়ার্কআউট বাদ দেবে?';

  @override
  String get discardBody => 'এই সেশনের তোমার সেটগুলো হারিয়ে যাবে।';

  @override
  String get keepTraining => 'ট্রেনিং চালিয়ে যাও';

  @override
  String get discard => 'বাদ দাও';

  @override
  String get notifRestChannel => 'বিশ্রাম টাইমার';

  @override
  String get notifRestChannelWhy => 'সেটের মাঝের বিশ্রাম শেষ হলে জানায়';

  @override
  String get notifAlertChannel => 'বিশ্রাম টাইমার (সতর্কতা)';

  @override
  String get notifAlertChannelWhy => 'বিশ্রাম শেষ হওয়ার মুহূর্তে একটা ব্যানার দেখায়';

  @override
  String get restOverTitle => 'বিশ্রাম শেষ';

  @override
  String get restOverBody => 'চলো, পরের সেট অপেক্ষা করছে।';

  @override
  String get allTimeSessions => 'সেশন';

  @override
  String get allTimeTime => 'সময়';

  @override
  String get allTimeSets => 'সেট';

  @override
  String get consistency => 'ধারাবাহিকতা';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি সেশন লেখা',
      one: '$nটি সেশন লেখা',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n দিনের স্ট্রিক';
  }

  @override
  String get bodyweight => 'শরীরের ওজন';

  @override
  String get logBodyweight => 'ওজন লিখে রাখো';

  @override
  String get trackWeight => 'সময়ের সাথে তোমার ওজন দেখো';

  @override
  String get muscleMap => 'পেশির মানচিত্র';

  @override
  String get days7 => '7দি';

  @override
  String get days30 => '30দি';

  @override
  String get days90 => '90দি';

  @override
  String get days365 => '1ব';

  @override
  String get daysAll => 'সব';

  @override
  String get weeklyAvgTitle => 'সাপ্তাহিক গড়';

  @override
  String weekOfDate(String date) {
    return '$date-এর সপ্তাহ';
  }

  @override
  String weightChangeRange(String change) {
    return 'এই সময়ে $change';
  }

  @override
  String get heatLow => 'অছোঁয়া';

  @override
  String get heatHigh => 'পূর্ণ ভলিউম';

  @override
  String get muscleMapEmpty => 'একটা সেশন লেখো আর তোমার শরীর এখানে জ্বলে উঠতে শুরু করবে।';

  @override
  String get muscleMapHint => 'একটা পেশিতে ট্যাপ করে দেখো সেটা কী পেয়েছে।';

  @override
  String muscleMapBehind(String names) {
    return 'পিছিয়ে আছে: $names';
  }

  @override
  String ofTarget(int pct) {
    return 'লক্ষ্যের $pct%';
  }

  @override
  String get muscleSplit => 'পেশির ভাগ';

  @override
  String get personalRecords => 'ব্যক্তিগত রেকর্ড';

  @override
  String get strength1rm => 'শক্তি · আনুমানিক 1RM';

  @override
  String get strengthEmpty => 'একটা ব্যায়াম দুবার লেখো আর এখানে তার শক্তির রেখা দেখা যাবে।';

  @override
  String oneRmEst(String w) {
    return 'আনুমানিক 1RM $w';
  }

  @override
  String get restDayShort => 'বিশ্রামের দিন';

  @override
  String get restDay => 'বিশ্রামের দিন, কিছু লেখা নেই।';

  @override
  String get delete => 'মুছে ফেলো';

  @override
  String get deleteEntry => 'এই এন্ট্রি মুছবে?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" এই দিন থেকে, আর তোমার রেকর্ড ও চার্ট থেকে মুছে যাবে।';
  }

  @override
  String get bodyweightHistory => 'ইতিহাস';

  @override
  String get exercisesCaps => 'ব্যায়াম';

  @override
  String get timeCaps => 'সময়';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'তোমার লাইব্রেরিতে $nটি ব্যায়াম',
      one: 'তোমার লাইব্রেরিতে $nটি ব্যায়াম',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'ব্যায়াম খোঁজো';

  @override
  String get muscleFilter => 'পেশি';

  @override
  String get levelFilter => 'স্তর';

  @override
  String get kindLabel => 'ধরন';

  @override
  String get kindStrength => 'শক্তি';

  @override
  String get kindCalisthenics => 'ক্যালিসথেনিক্স';

  @override
  String get kindCardio => 'কার্ডিও';

  @override
  String get kindStretch => 'স্ট্রেচিং';

  @override
  String get newExercise => 'নতুন ব্যায়াম';

  @override
  String get exerciseName => 'ব্যায়ামের নাম';

  @override
  String get equipmentLabel => 'সরঞ্জাম';

  @override
  String get addExercise => 'ব্যায়াম যোগ করো';

  @override
  String get advanced => 'উন্নত';

  @override
  String get demoMedia => 'ডেমো';

  @override
  String get addMedia => 'মিডিয়া যোগ করো';

  @override
  String get mediaHint => 'ছবি, GIF বা ভিডিও';

  @override
  String get changeMedia => 'বদলাও';

  @override
  String get videoSelected => 'ভিডিও বেছে নেওয়া হয়েছে';

  @override
  String get favouritesOnly => 'প্রিয়';

  @override
  String get noFavouritesYet => 'এখনও কোনো প্রিয় নেই';

  @override
  String get noFavouritesHint => 'কোনো ব্যায়ামের তারায় ট্যাপ করো, এখানে থাকবে।';

  @override
  String get clearFilters => 'ফিল্টার সরাও';

  @override
  String get quickAddAmount => 'কতটা খেয়েছ';

  @override
  String get homeCardsTitle => 'হোমের কার্ড';

  @override
  String get homeCardsHint => 'যা চালু করবে তা হোমে দেখা যাবে';

  @override
  String get homeCardFocus => 'আজ';

  @override
  String get homeCardSteps => 'পদক্ষেপ';

  @override
  String get homeCardWeek => 'এই সপ্তাহ';

  @override
  String get homeCardRoutines => 'রুটিন';

  @override
  String get homeCardRecommended => 'পরামর্শ';

  @override
  String get textSizeSetting => 'লেখার আকার';

  @override
  String get textSizeSmall => 'ছোট';

  @override
  String get textSizeNormal => 'সাধারণ';

  @override
  String get textSizeLarge => 'বড়';

  @override
  String get textSizeHint => 'ফোনের লেখার আকারের উপরে';

  @override
  String get calmMotionSetting => 'নড়াচড়া কমাও';

  @override
  String get calmMotionHint => 'স্ক্রিন স্লাইড না করেই আসে';

  @override
  String get dishArchive => 'আর্কাইভ করো';

  @override
  String get dishUnarchive => 'ফিরিয়ে আনো';

  @override
  String get dishArchivedToast => 'পদ আর্কাইভ হয়েছে';

  @override
  String get filterShowLabel => 'দেখাও';

  @override
  String get noExercisesFound => 'কোনো ব্যায়াম পাওয়া যায়নি';

  @override
  String get noExercisesHint => 'অন্য কিছু খোঁজো বা ফিল্টার সরাও।';

  @override
  String get personalRecord => 'ব্যক্তিগত রেকর্ড';

  @override
  String get history => 'ইতিহাস';

  @override
  String get noHistory => 'এখনও কোনো সেশন লেখা নেই। ইতিহাস গড়তে এই ব্যায়ামটা করো।';

  @override
  String get notes => 'নোট';

  @override
  String get notePlaceholder => 'টিপস, সেটআপ, কেমন লাগল…';

  @override
  String notHere(String gear, String place) {
    return '$place-এ $gear নেই';
  }

  @override
  String get notHereWhy => 'এমন কিছু দিয়ে বদলাও যা আজ সত্যিই করতে পারবে।';

  @override
  String get altHere => 'এখানে যা করতে পারো';

  @override
  String get places => 'আমার জায়গা';

  @override
  String get placesHint =>
      'বলো প্রতিটা জায়গায় তোমার কী আছে, আর লাইব্রেরি শুধু সেটাই দেখাবে যা সেখানে সত্যিই করতে পারো।';

  @override
  String get placeAll => 'যেকোনো জায়গা';

  @override
  String get placeNew => 'নতুন জায়গা';

  @override
  String get placeNamePlaceholder => 'বাড়ি, জিম, পার্ক…';

  @override
  String get placeGearLabel => 'সেখানে কী আছে';

  @override
  String placeExercises(int n) {
    return 'এখানে $nটি ব্যায়াম';
  }

  @override
  String get placeEmptyTitle => 'যেখানেই থাকো, ট্রেনিং করো';

  @override
  String get placeEmptyBody =>
      'জায়গা মানে সেখানে থাকা সরঞ্জামের তালিকা। শুরু করতে একটা বেছে নাও, পরে বদলাও।';

  @override
  String get placeDeleteTitle => 'জায়গা মুছে ফেলো';

  @override
  String get placeDeleteBody => 'শুধু জায়গাটা যাবে। তোমার ব্যায়াম আর সেশন থেকে যাবে।';

  @override
  String get placeGym => 'জিম';

  @override
  String get placeHome => 'বাড়ি';

  @override
  String get placeOutdoors => 'বাইরে';

  @override
  String get placeFilterLabel => 'জায়গা';

  @override
  String get noGearOnly => 'সরঞ্জাম ছাড়া';

  @override
  String placeActive(String name) {
    return '$name-এ ট্রেনিং';
  }

  @override
  String get journal => 'ডায়েরি';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি নোট',
      one: '1টি নোট',
      zero: 'কোনো নোট নেই',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'নোট';

  @override
  String get noteKindPlan => 'প্ল্যান';

  @override
  String get noteKindDone => 'জয়';

  @override
  String get noteKindPain => 'অস্বস্তি';

  @override
  String get noteFilterAll => 'সব';

  @override
  String get newNote => 'নতুন নোট';

  @override
  String get editNote => 'নোট বদলাও';

  @override
  String get addNote => 'নোট যোগ করো';

  @override
  String get noteEmptyTitle => 'এখনও কিছু লেখা নেই';

  @override
  String get noteEmptyBody => 'টিপস, পরেরবারের প্ল্যান, সেশনটা কেমন লাগল। চাইলে ছবি বা ভিডিও সহ।';

  @override
  String get noteNoneForExercise => 'এই ব্যায়ামে এখনও কোনো নোট নেই।';

  @override
  String get noteKindLabel => 'ধরন';

  @override
  String get noteTextLabel => 'নোট';

  @override
  String get noteDateLabel => 'তারিখ';

  @override
  String get noteExerciseLabel => 'ব্যায়াম';

  @override
  String get noteMediaLabel => 'ছবি ও ভিডিও';

  @override
  String get noteGeneral => 'কোনো ব্যায়াম নয়';

  @override
  String get noteAttach => 'যুক্ত করো';

  @override
  String get noteRemoveMedia => 'সংযুক্তি সরাও';

  @override
  String get deleteNoteTitle => 'নোট মুছে ফেলো';

  @override
  String get deleteNoteBody => 'নোট আর এর সাথে যুক্ত সবকিছু চিরতরে চলে যাবে।';

  @override
  String get noteToday => 'আজ';

  @override
  String get noteYesterday => 'গতকাল';

  @override
  String get noteAllNotes => 'সব নোট';

  @override
  String get noteCalendar => 'ক্যালেন্ডার';

  @override
  String get noteNoneOnDay => 'এই দিনে কিছু লেখা নেই';

  @override
  String get noteAddOnDay => 'এই দিনের নোট';

  @override
  String get notePrevMonth => 'আগের মাস';

  @override
  String get noteNextMonth => 'পরের মাস';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'এই মাসে $nটি নোট',
      one: 'এই মাসে 1টি নোট',
      zero: 'এই মাসে কোনো নোট নেই',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'মাপ';

  @override
  String get measuresHint => 'গলা থেকে পায়ের ডিম পর্যন্ত: শুধু বার নয়, শরীরের বদল দেখো।';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি মাপ',
      one: '1টি মাপ',
      zero: 'কিছু লেখা নেই',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'এখনও লেখা হয়নি';

  @override
  String get measureHistory => 'ইতিহাস';

  @override
  String get measureNeck => 'গলা';

  @override
  String get measureShoulders => 'কাঁধ';

  @override
  String get measureChest => 'বুক';

  @override
  String get measureArm => 'বাহু';

  @override
  String get measureForearm => 'বাহুর নিচের অংশ';

  @override
  String get measureWaist => 'কোমর';

  @override
  String get measureHips => 'নিতম্ব';

  @override
  String get measureThigh => 'উরু';

  @override
  String get measureCalf => 'পায়ের ডিম';

  @override
  String get measureBodyfat => 'বডি ফ্যাট';

  @override
  String get timeline => 'টাইমলাইন';

  @override
  String get hidePhotos => 'ছবি লুকাও';

  @override
  String get showPhotos => 'ছবি দেখাও';

  @override
  String get timelineHint => 'একই ভঙ্গি, একই জায়গা, একই আলো। এক বছর পর নিজেই বিশ্বাস করতে পারবে না।';

  @override
  String get timelineEmptyTitle => 'তোমার প্রথম ছবি থেকেই গোনা শুরু';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ছবি',
      one: '1টি ছবি',
      zero: 'কোনো ছবি নেই',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'সামনে';

  @override
  String get poseSide => 'পাশে';

  @override
  String get poseBack => 'পেছনে';

  @override
  String get photoEvery => 'মনে করিয়ে দাও';

  @override
  String photoEveryDays(int n) {
    return 'প্রতি $n দিনে';
  }

  @override
  String get photoEveryOff => 'কখনো না';

  @override
  String get timelineEvery => 'এই ব্যবধানে দল';

  @override
  String get custom => 'কাস্টম';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'পরের ছবি $n দিন পরে',
      one: 'পরের ছবি আগামীকাল',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'ছবির সময়: আজই তুলে নাও';

  @override
  String get addTodayPhotos => 'আজকের ছবি যোগ করো';

  @override
  String posePhoto(String pose) {
    return '$pose ছবি';
  }

  @override
  String get compare => 'তুলনা';

  @override
  String get compareNeedTwo => 'তোমার পরের ছবি এখানে আগে আর পরে দেখাবে।';

  @override
  String dayNumber(int n) {
    return 'দিন $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n দিনের ব্যবধান',
      one: '1 দিনের ব্যবধান',
      zero: 'একই দিন',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'এই দিনটা মুছে ফেলো';

  @override
  String get deleteDayBody => 'এর ছবিগুলোও চিরতরে চলে যাবে।';

  @override
  String get timelinePhotos => 'ছবি';

  @override
  String get timelineBody => 'পেশির মানচিত্র';

  @override
  String get timelineBodyEmpty =>
      'একটা সেশন লেখো আর তোমার পেশির মানচিত্র এখানে ভরতে শুরু করবে, ছবি লাগবে না।';

  @override
  String get timelineBodyHint => 'তোমার নিজের সেট থেকে তৈরি, কিছুই আপলোড হয় না।';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি সেশন',
      one: '1টি সেশন',
      zero: 'কোনো সেশন নেই',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'অগ্রগতির ছবি';

  @override
  String get notifPhotoChannelWhy => 'পরের অগ্রগতির ছবির সময় হলে মনে করিয়ে দেয়।';

  @override
  String get notifPhotoTitle => 'অগ্রগতির ছবির সময়';

  @override
  String notifPhotoBody(int n) {
    return 'শেষটার পর $n দিন। একই ভঙ্গি, একই আলো।';
  }

  @override
  String get share => 'শেয়ার করো';

  @override
  String get sharePick => 'কী দেখাতে চাও?';

  @override
  String get shareStreak => 'স্ট্রিক আর ধারাবাহিকতা';

  @override
  String get shareBody => 'যে পেশিতে কাজ হয়েছে';

  @override
  String get shareCompare => 'আগে আর পরে';

  @override
  String get shareHint =>
      'কার্ডটা তোমার ফোনেই তৈরি হয়। তুমি কোথায় পাঠাবে বেছে না নেওয়া পর্যন্ত কিছুই বাইরে যায় না।';

  @override
  String get shareFailed => 'কার্ডটা তৈরি করা গেল না';

  @override
  String get shareWeekOf => 'শেষ 7 দিন';

  @override
  String get shareStreakLabel => 'দিনের স্ট্রিক';

  @override
  String get shareSessionsLabel => 'সেশন';

  @override
  String get shareVolumeLabel => 'ভলিউম';

  @override
  String get restForExercise => 'এই ব্যায়ামের বিশ্রাম';

  @override
  String get restUsingDefault => 'তোমার ডিফল্ট';

  @override
  String get restCustom => 'শুধু এটার জন্য';

  @override
  String get setType => 'সেটের ধরন';

  @override
  String get setTypeNormal => 'ওয়ার্কিং';

  @override
  String get setTypeWarmup => 'ওয়ার্ম-আপ';

  @override
  String get setTypeDrop => 'ড্রপ সেট';

  @override
  String get setTypeFailure => 'ফেলিওর পর্যন্ত';

  @override
  String get addWarmup => 'ওয়ার্ম-আপ';

  @override
  String platesPerSide(String plates) {
    return 'প্রতি পাশে: $plates';
  }

  @override
  String get howTo => 'কীভাবে করবে';

  @override
  String get similar => 'একই রকম';

  @override
  String get primaryLabel => 'প্রধান';

  @override
  String get secondaryLabel => 'সহায়ক';

  @override
  String get none => 'কিছু না';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nটি সেট', one: '$nটি সেট');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v ভলিউম';
  }

  @override
  String get weeklyPlan => 'সাপ্তাহিক প্ল্যান';

  @override
  String get yourRoutines => 'তোমার রুটিন';

  @override
  String get noRoutines => 'এখনও কোনো রুটিন নেই। একটা বানাও আর তোমার ব্যায়াম যোগ করো।';

  @override
  String get newRoutine => 'নতুন রুটিন';

  @override
  String get routineName => 'রুটিনের নাম';

  @override
  String get schedule => 'সময়সূচি';

  @override
  String get addFromList => 'নিচের তালিকা থেকে ব্যায়াম যোগ করো।';

  @override
  String get addExercises => 'ব্যায়াম যোগ করো';

  @override
  String get deleteRoutine => 'এই রুটিন মুছবে?';

  @override
  String exercisesWithCount(int n) {
    return 'ব্যায়াম · $n';
  }

  @override
  String setDay(String day) {
    return '$day ঠিক করো';
  }

  @override
  String get newRoutineName => 'নতুন রুটিন';

  @override
  String get dragToReorder => 'ক্রম বদলাতে বিন্দু দেওয়া হাতলটা টানো, এই ক্রমেই তুমি ট্রেনিং করবে।';

  @override
  String reorderHandle(String name) {
    return '$name-এর ক্রম বদলাও';
  }

  @override
  String get removeFromRoutine => 'রুটিন থেকে সরাও';

  @override
  String get dropExercise => 'এই ব্যায়াম বাদ দেবে?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" এই ওয়ার্কআউট থেকে বাদ যাবে। যা লেখা আছে তা হারাবে না।';
  }

  @override
  String get drop => 'বাদ দাও';

  @override
  String get resetData => 'আমার সব ডেটা মুছে ফেলো';

  @override
  String get resetTitle => 'সবকিছু মুছবে?';

  @override
  String get resetBody =>
      'সেশন, রেকর্ড, রুটিন, নোট আর প্রোফাইল। এটা ফেরানো যাবে না: পরে লাগতে পারে মনে হলে আগে একটা ব্যাকআপ এক্সপোর্ট করে নাও।';

  @override
  String get resetConfirm => 'সব মুছে ফেলো';

  @override
  String get resetDone => 'সব ডেটা মুছে ফেলা হয়েছে';

  @override
  String get support => 'সাপোর্ট';

  @override
  String get reportBug => 'বাগ রিপোর্ট করো';

  @override
  String get requestFeature => 'ফিচার চাও';

  @override
  String get starOnGithub => 'GitHub-এ স্টার দাও';

  @override
  String get buyCoffee => 'আমাকে একটা কফি খাওয়াও';

  @override
  String get cantOpenLink => 'লিংকটা খোলা গেল না';

  @override
  String get theme => 'থিম';

  @override
  String get darkTheme => 'ডার্ক';

  @override
  String get lightTheme => 'লাইট';

  @override
  String get amoledTheme => 'AMOLED কালো';

  @override
  String get editDuration => 'ওয়ার্কআউটের সময়কাল';

  @override
  String get sessionName => 'ওয়ার্কআউটের নাম';

  @override
  String get nameWorkout => 'নাম দাও';

  @override
  String get sessionNameHint => 'যেমন লেগস, পুশ, ফুল বডি';

  @override
  String get secondaryPickHint => 'এই ব্যায়াম আর যে পেশিগুলোতে কাজ করে সেগুলোতে ট্যাপ করো।';

  @override
  String get languageLabel => 'ভাষা';

  @override
  String get unitsLabel => 'একক';

  @override
  String get restTimer => 'বিশ্রাম টাইমার';

  @override
  String get alarmBlockedTitle => 'নোটিফিকেশন বন্ধ';

  @override
  String get alarmBlockedBody => 'স্ক্রিন লক থাকলে বিশ্রামের অ্যালার্ম বাজবে না';

  @override
  String get alarmBlockedAction => 'চালু করো';

  @override
  String get alarmSound => 'অ্যালার্মের শব্দ';

  @override
  String get alarmDefaultName => 'ডিফল্ট';

  @override
  String get alarmSoundHint => 'নিজের শব্দ দাও, 15 সেকেন্ড পর্যন্ত';

  @override
  String get alarmChoose => 'একটা শব্দ বেছে নাও…';

  @override
  String get alarmPreview => 'বর্তমান শব্দ বাজাও';

  @override
  String get alarmReset => 'ডিফল্টে ফেরাও';

  @override
  String get alarmTooLong => 'ওই শব্দটা 15 সেকেন্ডের বেশি';

  @override
  String get alarmInvalid => 'ওই অডিও ফাইলটা পড়া গেল না';

  @override
  String alarmChanged(String name) {
    return 'অ্যালার্মের শব্দ \"$name\" করা হয়েছে';
  }

  @override
  String get alarmChangedDefault => 'ডিফল্ট শব্দে ফেরানো হয়েছে';

  @override
  String get addActivityWidget => 'অ্যাক্টিভিটি উইজেট যোগ করো';

  @override
  String get addStatsWidget => 'পরিসংখ্যান উইজেট যোগ করো';

  @override
  String get pinUnsupported => 'তোমার লঞ্চারের উইজেট মেনু থেকে যোগ করো';

  @override
  String get background => 'ব্যাকগ্রাউন্ড';

  @override
  String get bgNone => 'কিছু না';

  @override
  String get bgDots => 'বিন্দু';

  @override
  String get bgGrid => 'গ্রিড';

  @override
  String get exportCsv => 'ওয়ার্কআউট এক্সপোর্ট করো (CSV)';

  @override
  String get exportBackup => 'ব্যাকআপ এক্সপোর্ট করো (ZIP)';

  @override
  String get importBackup => 'ব্যাকআপ ইমপোর্ট করো';

  @override
  String get importHint =>
      'GymMane থেকে এক্সপোর্ট করা একটা .zip (বা পুরোনো .json) ব্যাকআপ বেছে নাও। এতে তোমার বর্তমান ডেটা, মিডিয়াসহ, বদলে যাবে।';

  @override
  String get import => 'ইমপোর্ট করো';

  @override
  String get chooseFile => 'ফাইল বেছে নাও';

  @override
  String get importFromApp => 'অন্য অ্যাপ থেকে ইমপোর্ট করো';

  @override
  String get importUnknownFormat => 'ওই ফাইলে তারিখ, ব্যায়াম, রেপ আর ওজনের কলাম লাগবে';

  @override
  String get importZipNoWeights => 'ওই zip-এ কোনো ওজনের ফাইল নেই';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ওজন ইমপোর্ট হয়েছে',
      one: '$nটি ওজন ইমপোর্ট হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'ওই ফাইলটা পড়া গেল না';

  @override
  String get importUnitTitle => 'ওই ফাইল কোন এককে?';

  @override
  String get importUnitBody => 'এই এক্সপোর্টে বলা নেই ওজন কোন এককে।';

  @override
  String get importNothing => 'ইমপোর্ট করার মতো নতুন কিছু নেই';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি সেশন ইমপোর্ট হয়েছে',
      one: '$nটি সেশন ইমপোর্ট হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'GymMane সম্পর্কে';

  @override
  String get yourProfile => 'তোমার প্রোফাইল';

  @override
  String get autofills => 'ক্যালকুলেটর নিজে থেকে ভরে';

  @override
  String get onbUnitsWhy => 'ওজন, মাপ আর দূরত্বের জন্য। সেটিংসে যেকোনো সময় বদলাতে পারো।';

  @override
  String get nameLabel => 'নাম';

  @override
  String get sexLabel => 'লিঙ্গ';

  @override
  String get macroProtein => 'প্রোটিন';

  @override
  String get macroCarbs => 'কার্বস';

  @override
  String get macroFat => 'ফ্যাট';

  @override
  String get male => 'পুরুষ';

  @override
  String get female => 'মহিলা';

  @override
  String get ageLabel => 'বয়স';

  @override
  String get heightLabel => 'উচ্চতা';

  @override
  String get weightLabel => 'ওজন';

  @override
  String get weeklyGoal => 'সাপ্তাহিক লক্ষ্য';

  @override
  String get activityLabel => 'অ্যাক্টিভিটি';

  @override
  String get addPhoto => 'ছবি যোগ করো';

  @override
  String get removePhoto => 'ছবি সরাও';

  @override
  String get takePhoto => 'ছবি তোলো';

  @override
  String get chooseGallery => 'গ্যালারি থেকে বেছে নাও';

  @override
  String get backupImported => 'ব্যাকআপ ইমপোর্ট হয়েছে';

  @override
  String get backupFailed => 'ওই ব্যাকআপটা পড়া গেল না';

  @override
  String get nothingToExport => 'এখনও এক্সপোর্ট করার কিছু নেই: আগে একটা সেশন লেখো';

  @override
  String calculatorsCount(int n) {
    return 'তোমার ট্রেনিংয়ের জন্য $nটি ক্যালকুলেটর';
  }

  @override
  String get result => 'ফলাফল';

  @override
  String get weightLifted => 'তোলা ওজন';

  @override
  String get repsPerformed => 'করা রেপ';

  @override
  String get neck => 'গলা';

  @override
  String get waist => 'কোমর';

  @override
  String get hip => 'নিতম্ব (মহিলাদের জন্য)';

  @override
  String get targetWeight => 'লক্ষ্য ওজন';

  @override
  String get workingWeight => 'ওয়ার্কিং ওজন';

  @override
  String get activityLevel => 'অ্যাক্টিভিটির মাত্রা';

  @override
  String get barWeight => 'বারের ওজন';

  @override
  String get perSide => 'প্রতি পাশে';

  @override
  String get justTheBar => 'শুধু বার।';

  @override
  String perSideCount(int n) {
    return '× $n প্রতি পাশে';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'ক্যালরি';

  @override
  String get toolNameBf => 'বডি ফ্যাট';

  @override
  String get toolNamePlate => 'প্লেট';

  @override
  String get toolNameWarmup => 'ওয়ার্ম-আপ';

  @override
  String get toolTitleRm => '1RM ক্যালকুলেটর';

  @override
  String get toolTitleBmi => 'BMI ক্যালকুলেটর';

  @override
  String get toolTitleCal => 'ক্যালরি ও ম্যাক্রো';

  @override
  String get toolTitleBf => 'বডি ফ্যাট %';

  @override
  String get toolTitlePlate => 'প্লেট ক্যালকুলেটর';

  @override
  String get toolTitleWarmup => 'ওয়ার্ম-আপ সেট';

  @override
  String get toolHintRm => 'আনুমানিক 1-রেপ ম্যাক্স (Epley সূত্র)';

  @override
  String get toolHintCal => 'আনুমানিক দৈনিক রক্ষণাবেক্ষণ';

  @override
  String get toolHintBf => 'US Navy পদ্ধতিতে অনুমান';

  @override
  String get toolHintPlate => 'বারবেলের মোট ওজন';

  @override
  String get toolHintWarmup => 'ওয়ার্কিং ওজনের লক্ষ্য';

  @override
  String get toolDescRm => 'আনুমানিক ওয়ান-রেপ ম্যাক্স';

  @override
  String get toolDescBmi => 'বডি মাস ইনডেক্স';

  @override
  String get toolDescCal => 'ক্যালরি ও ম্যাক্রো';

  @override
  String get toolDescBf => 'বডি ফ্যাটের শতাংশ';

  @override
  String get toolDescPlate => 'বারবেল প্লেট ক্যালকুলেটর';

  @override
  String get toolDescWarmup => 'ধাপে ধাপে বাড়ানো সেট';

  @override
  String get bmiUnderweight => 'কম ওজন';

  @override
  String get bmiNormal => 'স্বাভাবিক';

  @override
  String get bmiOverweight => 'বেশি ওজন';

  @override
  String get bmiObese => 'স্থূল';

  @override
  String get actSedentary => 'বসে থাকা';

  @override
  String get actLight => 'হালকা';

  @override
  String get actActive => 'সক্রিয়';

  @override
  String get actModerate => 'মাঝারি';

  @override
  String get muscleChest => 'বুক';

  @override
  String get muscleBack => 'পিঠ';

  @override
  String get muscleLowerBack => 'নিচের পিঠ';

  @override
  String get muscleShoulders => 'কাঁধ';

  @override
  String get muscleBiceps => 'বাইসেপস';

  @override
  String get muscleTriceps => 'ট্রাইসেপস';

  @override
  String get muscleForearm => 'বাহুর নিচের অংশ';

  @override
  String get muscleTrapezius => 'ট্র্যাপিজিয়াস';

  @override
  String get muscleAbdomen => 'পেট';

  @override
  String get muscleObliques => 'অবলিক';

  @override
  String get muscleQuads => 'কোয়াড';

  @override
  String get muscleHamstrings => 'হ্যামস্ট্রিং';

  @override
  String get muscleGlutes => 'গ্লুট';

  @override
  String get muscleCalves => 'পায়ের ডিম';

  @override
  String get mgChest => 'বুক';

  @override
  String get mgBack => 'পিঠ';

  @override
  String get mgLegs => 'পা';

  @override
  String get mgShoulders => 'কাঁধ';

  @override
  String get mgArms => 'বাহু';

  @override
  String get mgCore => 'কোর';

  @override
  String get equipBarbell => 'বারবেল';

  @override
  String get equipDumbbell => 'ডাম্বেল';

  @override
  String get equipCable => 'কেবল';

  @override
  String get equipMachine => 'মেশিন';

  @override
  String get equipBodyweight => 'শরীরের ওজন';

  @override
  String get equipWeighted => 'ওজনসহ';

  @override
  String get equipBand => 'ব্যান্ড';

  @override
  String get equipKettlebell => 'কেটলবেল';

  @override
  String get equipRings => 'রিং';

  @override
  String get equipOther => 'অন্যান্য';

  @override
  String get diffBeginner => 'শিক্ষানবিশ';

  @override
  String get diffAdvanced => 'উন্নত';

  @override
  String get diffIntermediate => 'মাঝারি';

  @override
  String get about => 'সম্পর্কে';

  @override
  String version(String v) {
    return 'ভার্সন $v';
  }

  @override
  String get aboutBlurb => 'যারা ওজন তোলে, তাদেরই হাতে তৈরি, তাদের জন্য।';

  @override
  String get freeForever => 'চিরকাল বিনামূল্যে';

  @override
  String get freeForeverWhy => 'কোনো সাবস্ক্রিপশন নেই, বিজ্ঞাপন নেই, কিছুই টাকার দেয়ালের পেছনে বন্ধ নয়।';

  @override
  String get fullyOffline => 'পুরোপুরি অফলাইন';

  @override
  String get fullyOfflineWhy => 'অ্যাকাউন্ট নেই, সার্ভার নেই। তোমার ট্রেনিং কখনো এই ফোন ছাড়ে না।';

  @override
  String get yoursToTake => 'তোমার ডেটা তোমারই';

  @override
  String get yoursToTakeWhy => 'যখন খুশি CSV-তে এক্সপোর্ট করো, আর এক ট্যাপে সব মুছে ফেলো।';

  @override
  String get whatsInside => 'ভেতরে কী আছে';

  @override
  String exercisesInside(int n) {
    return '$nটি ব্যায়াম';
  }

  @override
  String get exercisesInsideWhy => 'প্রতিটার সাথে অ্যানিমেশন আর ধাপে ধাপে নির্দেশনা।';

  @override
  String get calculatorsInside => '10টি ক্যালকুলেটর';

  @override
  String get calculatorsInsideWhy =>
      '1RM, প্লেট, BMI, ক্যালরি, বডি ফ্যাট, FFMI, ওয়ার্ম-আপ, RPE লোড, আর DOTS ও Wilks শক্তির স্কোর, সবই প্রকাশিত সূত্রে।';

  @override
  String get mathInside => 'সৎ হিসাব';

  @override
  String get mathInsideWhy => 'ভলিউম, রেকর্ড আর স্ট্রিক আসে তোমার নিজের সেট থেকে। এখানে কিছুই শুধু সাজ নয়।';

  @override
  String get streakCaps => 'স্ট্রিক';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'দিন', one: 'দিন');
    return '$_temp0';
  }

  @override
  String get reset => 'রিসেট';

  @override
  String get welcomeKicker => 'স্বাগতম';

  @override
  String get welcomeBlurb => 'সবকিছু তোমার ফোনেই থাকে। অ্যাকাউন্ট নেই, ইন্টারনেট নেই, কোনো খরচ নেই।';

  @override
  String get welcomeStart => 'শুরু করো';

  @override
  String onbStep(int i, int n) {
    return 'ধাপ $i / $n';
  }

  @override
  String get onbNameTitle => 'তোমাকে কী নামে ডাকব?';

  @override
  String get onbNameHint => 'তোমার নাম';

  @override
  String get onbPhotoAdd => 'ছবি যোগ করো';

  @override
  String get onbPhotoChange => 'ছবি বদলাও';

  @override
  String get onbPhotoTitle => 'তোমার প্রোফাইলে একটা মুখ দাও';

  @override
  String get onbPhotoWhy => 'ঐচ্ছিক। এটা তোমার ফোনেই থাকে আর প্রোফাইল থেকে যেকোনো সময় বদলাতে পারো।';

  @override
  String get onbPhotoLater => 'পরে';

  @override
  String get onbNameWhy => 'শুধু তোমাকে শুভেচ্ছা জানাতে। এটা কখনো ফোন ছাড়ে না।';

  @override
  String get onbBodyTitle => 'কয়েকটা সংখ্যা';

  @override
  String get onbBodyWhy => 'এগুলো ক্যালকুলেটরে কাজে লাগে। সেটিংসে যেকোনো সময় বদলাতে পারো।';

  @override
  String get onbGoalTitle => 'কত ঘন ঘন ট্রেনিং করো?';

  @override
  String get onbGoalWhy => 'তোমার সাপ্তাহিক লক্ষ্যের রিং ঠিক করে। সৎ থাকো, উচ্চাকাঙ্ক্ষী নয়।';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'সপ্তাহে $nটি সেশন',
      one: 'সপ্তাহে $nটি সেশন',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'কিলো না পাউন্ড?';

  @override
  String get next => 'পরের';

  @override
  String get back => 'পেছনে';

  @override
  String get skip2 => 'বাদ দাও';

  @override
  String get madeWithLoveBy => 'ভালোবাসায় তৈরি';

  @override
  String get sourceCode => 'সোর্স কোড';

  @override
  String get suggested => 'প্রস্তাবিত';

  @override
  String get results => 'ফলাফল';

  @override
  String get noMatches => 'এই খোঁজার সাথে কোনো ব্যায়াম মেলে না।';

  @override
  String get tapToEdit => 'এন্ট্রি ঠিক করতে পেনসিলে, মুছতে ঝুড়িতে ট্যাপ করো।';

  @override
  String get editEntry => 'বদলাও';

  @override
  String get editEntryHint => 'যেকোনো সেটের রেপ বা ওজন ঠিক করো।';

  @override
  String get removeSet => 'সেট সরাও';

  @override
  String get continueWorkout => 'চালিয়ে যাও';

  @override
  String get continueWorkoutBody =>
      'ওয়ার্কআউট আবার চলমান হবে, আগে টিক দেওয়া সেটসহ। আবার শেষ করলে মূল দিনেই সেভ হবে।';

  @override
  String get addBodyWidget => 'পেশির মানচিত্রের উইজেট যোগ করো';

  @override
  String get repsOnly => 'শুধু রেপ';

  @override
  String get repsOnlyHint => 'এই ব্যায়ামটা ওজন ছাড়া লেখো।';

  @override
  String get eachSide => 'প্রতি পাশে';

  @override
  String get eachSideHint => 'টাইমার প্রতি পাশে একবার চলে আর দুই পাশের পরে বিশ্রাম শুরু হয়।';

  @override
  String get useDefaultArt => 'ডিফল্ট ছবিতে ফেরো';

  @override
  String daysShort(int n) {
    return '$nদি';
  }

  @override
  String get focusCard => 'আজকের ফোকাস';

  @override
  String get autoAdvance => 'নিজে থেকে এগিয়ে যাও';

  @override
  String get keepScreenOn => 'ট্রেনিংয়ের সময় স্ক্রিন চালু রাখো';

  @override
  String get lockWorkout => 'স্ক্রিন লক করো';

  @override
  String get unlockWorkout => 'আনলক করো';

  @override
  String get holdToUnlock => 'আনলক করতে চেপে ধরো';

  @override
  String get liveChannel => 'চলমান ওয়ার্কআউট';

  @override
  String get liveChannelWhy => 'ট্রেনিংয়ের সময় বর্তমান ব্যায়াম, সেট আর বিশ্রাম টাইমার দেখায়';

  @override
  String liveSet(int n, int total) {
    return 'সেট $n / $total';
  }

  @override
  String get liveResting => 'বিশ্রাম';

  @override
  String get liveAllDone => 'সব সেট শেষ';

  @override
  String get autoAdvanceHint => 'শেষ সেটের পরে এগিয়ে যায়';

  @override
  String get placePlates => 'প্লেট আর বার';

  @override
  String get platesAll => 'সব আছে';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nটি সাইজ', one: '$nটি সাইজ');
    return '$_temp0';
  }

  @override
  String get platePairs => 'জোড়া';

  @override
  String plateAchievable(String w) {
    return 'সবচেয়ে কাছের যা লাগাতে পারো: $w';
  }

  @override
  String get autoWarmup => 'ওয়ার্ম-আপ সেট দিয়ে শুরু করো';

  @override
  String get autoWarmupHint => 'ওয়ার্কআউট খুললেই ধাপে ধাপে বাড়ানো সেট যোগ করে।';

  @override
  String get trainReminder => 'ট্রেনিং রিমাইন্ডার';

  @override
  String get trainReminderHint => 'এই সময়ে একটা খোঁচা, শুধু যেদিন তোমার রুটিন ঠিক করা আছে।';

  @override
  String get reminderExactTime => 'ঠিক সময়';

  @override
  String get toastSoundSetting => 'নোটিশের শব্দ';

  @override
  String get toastSoundHint => 'প্রতিটা নোটিশে একটা নরম ঘণ্টা';

  @override
  String get notifTrainChannel => 'ট্রেনিং রিমাইন্ডার';

  @override
  String get notifTrainChannelWhy => 'যেদিন ঠিক করেছ সেদিন ট্রেনিংয়ের খোঁচা।';

  @override
  String get notifTrainTitle => 'ট্রেনিংয়ের সময়';

  @override
  String get notifTrainBody => 'তোমার রুটিন অপেক্ষা করছে।';

  @override
  String get planIntro => 'শুধু এই তালিকার ব্যায়াম দিয়ে আমার জন্য একটা ট্রেনিং রুটিন বানাও।';

  @override
  String get planFormat => 'শুধু JSON-এ উত্তর দাও, এই আকারে:';

  @override
  String get planNothing => 'ওই ফাইলের কোনো ব্যায়াম তোমার লাইব্রেরির সাথে মেলেনি';

  @override
  String get planFailed => 'ওই ফাইলটা এমন রুটিন নয় যা আমরা পড়তে পারি';

  @override
  String get routineGroup => 'দল';

  @override
  String get newGroup => 'নতুন দল';

  @override
  String get noGroup => 'কোনো দল নয়';

  @override
  String get groupNameHint => 'পুশ / পুল / লেগস, 5×5…';

  @override
  String get filters => 'ফিল্টার';

  @override
  String get setsPlannedHint => 'প্রতিটার কয়টা সেট চাও বেছে নাও। ওয়ার্কআউট সেগুলো তৈরি রেখে খুলবে।';

  @override
  String get nextTime => 'পরেরবার';

  @override
  String get nextHold => 'সব রেপ না হওয়া পর্যন্ত একই ওজন';

  @override
  String get bgPhoto => 'তোমার ছবি';

  @override
  String get bgPhotoPick => 'ছবি বেছে নাও';

  @override
  String get bgPhotoChange => 'ছবি বদলাও';

  @override
  String get bgPhotoRemove => 'ছবি সরাও';

  @override
  String get bgDim => 'কতটা গাঢ়';

  @override
  String get dimSoft => 'হালকা';

  @override
  String get dimMedium => 'মাঝারি';

  @override
  String get dimStrong => 'গাঢ়';

  @override
  String get bgPhotoHint => 'এটা সবকিছুর পেছনে থাকে, ঝাপসা করে যাতে অ্যাপ পড়া যায়।';

  @override
  String get reminderSmart => 'স্মার্ট';

  @override
  String get reminderFixed => 'নির্দিষ্ট সময়';

  @override
  String get reminderSmartHint =>
      'যে দিন আর সময়ে তুমি সত্যিই ট্রেনিং করো সেটা ব্যবহার করে, আর যেদিন ট্রেনিং হয়ে গেছে সেদিন চুপ থাকে।';

  @override
  String get reminderSmartEmpty => 'আরও কয়েকটা সেশন লেখো, তোমার দিনগুলো শিখে নেবে।';

  @override
  String habitFocus(String day) {
    return '$day-এ তুমি সাধারণত যা ট্রেন করো';
  }

  @override
  String get duplicateRoutine => 'রুটিনের কপি বানাও';

  @override
  String copySuffix(String name) {
    return '$name (কপি)';
  }

  @override
  String get saveAsRoutine => 'রুটিন হিসেবে সেভ করো';

  @override
  String get savedAsRoutine => 'রুটিন হিসেবে সেভ হয়েছে';

  @override
  String get templates => 'তৈরি প্ল্যান';

  @override
  String get templatesHint => 'ক্লাসিক প্রোগ্রাম, তোমার নিজের লাইব্রেরি দিয়ে তৈরি। পরে যা খুশি বদলাতে পারো।';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি রুটিন যোগ হয়েছে',
      one: '$nটি রুটিন যোগ হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'সপ্তাহে তিনদিন ফুল বডি। শুরু করার জন্য এটাই।';

  @override
  String get tplPpl => 'পুশ, পুল ও লেগস—সাপ্তাহিক পরিকল্পনায় বিশ্রামের দিনসহ।';

  @override
  String get tplArnold => 'বুক আর পিঠ, কাঁধ আর বাহু, পা। ক্লাসিক ছয় দিনের ভাগ।';

  @override
  String get tplUpperlower => 'উপরের আর নিচের শরীর, সপ্তাহে চার দিন।';

  @override
  String get tplStronglifts => 'দুটো ওয়ার্কআউট, পাঁচটার পাঁচ সেট, পালা করে।';

  @override
  String get tplStartingstrength => 'প্রতি সেশনে স্কোয়াট, দুটো ওয়ার্কআউট পালা করে।';

  @override
  String get tplHome => 'শুধু ঝোলার মতো একটা বার আর মেঝে।';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n দিন', one: '$n দিন');
    return '$_temp0';
  }

  @override
  String get logRpe => 'পরিশ্রম লেখো (RPE)';

  @override
  String get rpeHint => '10 মানে আর কিছু বাকি নেই, 8 মানে দুটো রেপ বাকি ছিল।';

  @override
  String get superset => 'সুপারসেট';

  @override
  String get supersetLink => 'পরেরটার সাথে জোড়ো';

  @override
  String get supersetUnlink => 'পরেরটা থেকে আলাদা করো';

  @override
  String get supersetHint => 'জোড়া ব্যায়ামের মাঝে বিশ্রাম নেই, সরাসরি পরেরটায়।';

  @override
  String get aiRoutine => 'AI দিয়ে রুটিন';

  @override
  String get aiIntro =>
      'GymMane কখনো কোনো AI-এর সাথে কথা বলে না। তুমি তোমার ব্যায়ামের তালিকা বের করো, যে অ্যাসিস্ট্যান্ট আগে থেকে ব্যবহার করো তাতে পেস্ট করো, আর তার উত্তর ফিরিয়ে আনো। ফোন থেকে নিজে থেকে কিছুই বাইরে যায় না।';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি নাম তোমার লাইব্রেরিতে ছিল না',
      one: '1টি নাম তোমার লাইব্রেরিতে ছিল না',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'কোন কোন অ্যাপ পড়ে';

  @override
  String get importOtherCsv => 'তারিখ, ব্যায়াম, রেপ আর ওজনসহ যেকোনো CSV';

  @override
  String get importAskApp => 'অন্য অ্যাপ লাগবে? চেয়ে নাও';

  @override
  String get awardFirstStepName => 'প্রথম পদক্ষেপ';

  @override
  String get awardFirstStepLine => 'GymMane-এ স্বাগতম। এটা আমাদের পক্ষ থেকে।';

  @override
  String get awardFirstWorkoutName => 'প্রথম ওয়ার্কআউট';

  @override
  String get awardFirstWorkoutLine => 'প্রথমটা লেখা হলো। সেটাই সবচেয়ে কঠিন।';

  @override
  String get awardFirstRoutineName => 'প্রথম রুটিন';

  @override
  String get awardFirstRoutineLine => 'এখন তোমার ফিরে আসার মতো একটা প্ল্যান আছে।';

  @override
  String get awardFirstRecordName => 'প্রথম রেকর্ড';

  @override
  String get awardFirstRecordLine => 'একটা ব্যায়ামে তুমি তোমার সেরা লিফট ভেঙেছ।';

  @override
  String get awardStreak3Name => 'টানা তিন';

  @override
  String get awardStreak3Line => 'টানা তিন দিন। এভাবেই শুরু হয়।';

  @override
  String get awardTonne1Name => 'এক টন';

  @override
  String get awardTonne1Line => 'তোমার সব সেট মিলিয়ে এক হাজার কিলো তোলা।';

  @override
  String get awardSets100Name => 'একশো সেট';

  @override
  String get awardSets100Line => 'একশো সেট শেষ, একটা একটা করে।';

  @override
  String get awardHours10Name => 'দশ ঘণ্টা';

  @override
  String get awardHours10Line => 'ঘড়িতে দশ ঘণ্টার ট্রেনিং।';

  @override
  String get awardWorkouts50Name => 'পঞ্চাশ ওয়ার্কআউট';

  @override
  String get awardWorkouts50Line => 'পঞ্চাশটা সেশন পেছনে ফেলে এসেছ।';

  @override
  String get awardHours50Name => 'পঞ্চাশ ঘণ্টা';

  @override
  String get awardHours50Line => 'জিমের ভেতরে পঞ্চাশ ঘণ্টা।';

  @override
  String get awardsTitle => 'মেডেল';

  @override
  String get yearTitle => 'তোমার বছর';

  @override
  String get yearBestMonth => 'সেরা মাস';

  @override
  String get yearMonths => 'মাস';

  @override
  String get awardSpinHint => 'মেডেল ঘোরাতে টানো';

  @override
  String get awardUnlocked => 'নতুন অর্জন খুলেছে';

  @override
  String get awardNice => 'দারুণ!';

  @override
  String get awardSaveImage => 'ছবি সেভ করো';

  @override
  String get awardSaved => 'তোমার গ্যালারিতে সেভ হয়েছে';

  @override
  String get awardStreak7Name => 'সাত দিন';

  @override
  String get awardStreak7Line => 'একদিনও বাদ না দিয়ে পুরো এক সপ্তাহ।';

  @override
  String get awardStreak30Name => 'তিরিশ দিন';

  @override
  String get awardStreak30Line => 'টানা এক মাস। এখন এটা অভ্যাস।';

  @override
  String get awardWorkouts100Name => 'একশো ওয়ার্কআউট';

  @override
  String get awardWorkouts100Line => 'একশো সেশন লেখা, শুরু থেকে শেষ।';

  @override
  String get awardTonnes100Name => 'একশো টন';

  @override
  String get awardTonnes100Line => 'তুমি যা কিছু তুলেছ সব মিলিয়ে 1,00,000 কিলো।';

  @override
  String get awardSets1000Name => 'এক হাজার সেট';

  @override
  String get awardSets1000Line => 'একটা একটা সেট করে, পুরো এক হাজার।';

  @override
  String get profile => 'প্রোফাইল';

  @override
  String get editProfile => 'প্রোফাইল বদলাও';

  @override
  String get pickBadge => 'ব্যাজ';

  @override
  String get statWorkouts => 'ওয়ার্কআউট';

  @override
  String get statTrained => 'ট্রেনিং';

  @override
  String get statSets => 'সেট';

  @override
  String get statLifted => 'তোলা';

  @override
  String get statStreak => 'স্ট্রিক';

  @override
  String get statDays => 'দিন';

  @override
  String get unitHours => 'ঘ';

  @override
  String get unitDays => 'দিন';

  @override
  String get snapshots => 'ছবি';

  @override
  String get snapNow => 'একটা তোলো';

  @override
  String get addCover => 'কভার যোগ করো';

  @override
  String get addTodayWidget => 'আজ হলো কি না';

  @override
  String get photosCard => 'তোমার ছবি';

  @override
  String get handleLabel => 'ইউজারনেম';

  @override
  String get setupTitle => 'এগুলো ভরো, বাকি পাতা নিজেই ভরে যাবে';

  @override
  String get setupHint => 'এখানের প্রতিটা সংখ্যা তোমার লেখা থেকে আসে। কিছুই কোথাও পাঠানো হয় না।';

  @override
  String get setupWorkout => 'তোমার প্রথম ওয়ার্কআউট লেখো';

  @override
  String get setupWeight => 'তোমার ওজন লেখো';

  @override
  String get setupMeasures => 'তোমার মাপ নাও';

  @override
  String get setupPhoto => 'তোমার প্রথম অগ্রগতির ছবি তোলো';

  @override
  String get progressTitle => 'অগ্রগতি';

  @override
  String get tileVolume30 => 'ভলিউম · 30দি';

  @override
  String get tileAddWeight => 'তোমারটা যোগ করো';

  @override
  String get heatToneTitle => 'হিটের রং';

  @override
  String get heatToneHint => 'শুধু গ্রিড আর শরীরের রং বদলায়।';

  @override
  String get thisWeekTitle => 'এই সপ্তাহ';

  @override
  String get momentsEmptyTitle => 'এখানে এখনও কিছু নেই';

  @override
  String get deletePhotoTitle => 'এই ছবিটা মুছবে?';

  @override
  String get deletePhotoBody => 'এটা চিরতরে চলে যাবে।';

  @override
  String get awardsEarned => 'অর্জিত';

  @override
  String get awardsLocked => 'বন্ধ';

  @override
  String get awardStreak100Name => 'একশো দিন';

  @override
  String get awardWorkouts10Name => 'দশ ওয়ার্কআউট';

  @override
  String get awardWorkouts10Line => 'প্রথম দশটাই সব ঠিক করে দেয়।';

  @override
  String get awardWorkouts365Name => 'তিনশো পঁয়ষট্টি';

  @override
  String get awardWorkouts365Line => 'বছরের প্রতিটা দিনের সমান একটা করে ওয়ার্কআউট, একটা একটা করে লেখা।';

  @override
  String get awardTonnes10Name => 'দশ টন';

  @override
  String get awardTonnes10Line => 'দশ হাজার কিলো তোমার হাত দিয়ে গেছে।';

  @override
  String get awardHours100Name => 'একশো ঘণ্টা';

  @override
  String get awardHours100Line => 'বারের নিচে একশো ঘণ্টা, হাতে স্টপওয়াচ।';

  @override
  String awardWonOn(String date) {
    return '$date তারিখে অর্জিত';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'সোনালি',
      'blue': 'নীল',
      'green': 'সবুজ',
      'other': 'ব্যাজ',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '$date থেকে';
  }

  @override
  String levelShort(int n) {
    return 'লেভেল $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'লেভেল $next পর্যন্ত $nটি ওয়ার্কআউট',
      one: 'লেভেল $next পর্যন্ত 1টি ওয়ার্কআউট',
    );
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n সেমি';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'অঙ্গার',
      'green': 'সবুজ',
      'blue': 'নীল',
      'mono': 'ধূসর',
      'other': 'রং',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$nটি সেট';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return 'এই সপ্তাহে $goal-এর মধ্যে $n';
  }

  @override
  String momentCount(int n) {
    return '$nটি ছবি';
  }

  @override
  String photosSelected(int n) {
    return '$nটি বাছাই';
  }

  @override
  String deletePhotosTitle(int n) {
    return '$nটি ছবি মুছবে?';
  }

  @override
  String get momentsEmptyHint =>
      'জিম, হোয়াইটবোর্ড, প্লেট সাজানো, যা মনে রাখতে চাও তার ছবি তোলো। এগুলো ফোনেই থাকে আর শুধু তুমি দেখো।';

  @override
  String get awardStreak100Line => 'টানা একশো দিন। এটা আর প্রেরণা নয়, এটাই তুমি।';

  @override
  String get coverLabel => 'কভার';

  @override
  String get removeCover => 'কভার সরাও';

  @override
  String get startTitle => 'ওয়ার্কআউট শুরু করো';

  @override
  String get logTitle => 'ওয়ার্কআউট লেখো';

  @override
  String get logHint => 'টাইমার নেই, শুধু যা করেছ তা ভরো।';

  @override
  String get orStartFrom => 'অথবা এখান থেকে শুরু করো';

  @override
  String get pickExercisesOption => 'ব্যায়াম বেছে নাও';

  @override
  String get chooseFocusOption => 'ফোকাস বেছে নাও';

  @override
  String get plannedRoutine => 'পরিকল্পিত';

  @override
  String get logWorkoutAction => 'ওয়ার্কআউট লেখো';

  @override
  String get logging => 'লেখা হচ্ছে';

  @override
  String get placesLabel => 'আমার জায়গা';

  @override
  String get undo => 'ফেরাও';

  @override
  String get deleteSet => 'সেট মুছে ফেলো';

  @override
  String get setDeleted => 'সেট মুছে ফেলা হয়েছে';

  @override
  String get removeWarmup => 'ওয়ার্ম-আপ সরাও';

  @override
  String get addWeightAction => 'ওজন যোগ করো';

  @override
  String get workoutOverview => 'এই ওয়ার্কআউট';

  @override
  String get allExercisesShort => 'সব';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total সেট';
  }

  @override
  String get nowLabel => 'এখন';

  @override
  String get deleteWorkout => 'ওয়ার্কআউট মুছে ফেলো';

  @override
  String get deleteWorkoutBody => 'এই ওয়ার্কআউট আর এর সব সেট তোমার ইতিহাস থেকে মুছে যাবে।';

  @override
  String get themeAuto => 'অটো';

  @override
  String get themeAutoHint => 'ফোন অনুযায়ী';

  @override
  String get demoSizeTitle => 'ট্রেনিংয়ের সময় ব্যায়ামের ডেমো';

  @override
  String get demoLarge => 'বড়';

  @override
  String get demoSmall => 'ছোট';

  @override
  String get demoOff => 'লুকানো';

  @override
  String get demoLoopTitle => 'ডেমো অ্যানিমেশন';

  @override
  String get demoLoopAlways => 'লুপ';

  @override
  String get demoLoopShort => '10 সেকেন্ড';

  @override
  String get demoLoopHint => 'প্রায় 10 সেকেন্ড চলে আর শুরুর ভঙ্গিতে থামে। আবার দেখতে ডেমোতে ট্যাপ করো।';

  @override
  String get alarmStyleTitle => 'বিশ্রাম শেষ হলে';

  @override
  String get alarmStyleLoud => 'সবসময় বাজবে';

  @override
  String get alarmStyleQuiet => 'সাইলেন্ট মোড মানবে';

  @override
  String get alarmStyleVibrate => 'শুধু ভাইব্রেট';

  @override
  String get alarmStyleHint =>
      'সবসময় বাজবে অ্যালার্মের ভলিউম ব্যবহার করে, সাইলেন্টেও। সাইলেন্ট মোড মানবে নোটিফিকেশনের ভলিউম ব্যবহার করে আর ফোন মিউট থাকলে শুধু ভাইব্রেট করে।';

  @override
  String get suggestedPicks => 'তোমার জন্য পরামর্শ';

  @override
  String get moreOptions => 'আরও বিকল্প';

  @override
  String get suggestInWorkouts => 'দ্রুত ওয়ার্কআউটে পরামর্শ দাও';

  @override
  String get suggestInWorkoutsHint =>
      'বন্ধ থাকলে তোমার জন্য বাছাইয়ে এটা আসবে না। হাতে করে তবুও যোগ করতে পারবে।';

  @override
  String get onbPlaceTitle => 'কোথায় ট্রেনিং করো?';

  @override
  String get onbPlaceWhy =>
      'যেখানে যেখানে ট্রেনিং করো সব বেছে নাও। আমরা প্রতিটায় শুধু সেটাই পরামর্শ দেব যা সেখানে করতে পারো।';

  @override
  String get onbPlaceGear => 'সেখানে কী কী আছে?';

  @override
  String distanceCol(String unit) {
    return 'দূরত্ব ($unit)';
  }

  @override
  String get timeCol => 'সময়';

  @override
  String get timePerSideCol => 'সময় / পাশ';

  @override
  String get timeMinutesTitle => 'সময় (মিনিট)';

  @override
  String get timeSecondsTitle => 'সময় (সেকেন্ড)';

  @override
  String distanceTitle(String unit) {
    return 'দূরত্ব ($unit)';
  }

  @override
  String get holdLabel => 'ধরে রাখো';

  @override
  String get stopLabel => 'থামো';

  @override
  String startHold(String time) {
    return 'শুরু · $time';
  }

  @override
  String get exerciseTypeLabel => 'কী দিয়ে লিখবে';

  @override
  String get typeReps => 'রেপ ও ওজন';

  @override
  String get typeTime => 'সময়';

  @override
  String get typeCardio => 'দূরত্ব ও সময়';

  @override
  String get exerciseTypeHint =>
      'দৌড় বা সাঁতারের মতো কার্ডিও দূরত্ব আর সময় লেখে। প্ল্যাঙ্কের মতো ধরে রাখার ব্যায়াম সময় লেখে।';

  @override
  String get howToLabel => 'কীভাবে করবে (ঐচ্ছিক)';

  @override
  String get howToHint => 'প্রতি লাইনে একটা ধাপ';

  @override
  String get editExercise => 'ব্যায়াম বদলাও';

  @override
  String get saveChanges => 'পরিবর্তন সেভ করো';

  @override
  String get noStepsYet => 'এখনও কোনো ধাপ নেই। নিজে লেখো যাতে মনে থাকে তুমি কীভাবে করো।';

  @override
  String get addSteps => 'ধাপগুলো লেখো';

  @override
  String get setTypeRestPause => 'রেস্ট-পজ';

  @override
  String get setTypeNormalInfo => 'সাধারণ সেট। তোমার ভলিউম আর রেকর্ডে গোনা হয়।';

  @override
  String get setTypeWarmupInfo => 'প্রস্তুত হওয়ার হালকা সেট। ভলিউম বা রেকর্ডে গোনা হয় না।';

  @override
  String get setTypeDropInfo => 'একটা সেটের ঠিক পরে ওজন কমাও আর বিশ্রাম না নিয়ে চালিয়ে যাও।';

  @override
  String get setTypeFailureInfo =>
      'যতক্ষণ না আর একটা পরিষ্কার রেপ করতে পারছ ততক্ষণ চালাও। সত্যিই যতগুলো রেপ করেছ সেটাই লেখো।';

  @override
  String get setTypeRestPauseInfo =>
      'সেটের পরে 10 থেকে 20 সেকেন্ড বিশ্রাম নাও, তারপর আরও কয়েকটা রেপ বের করো।';

  @override
  String get planFormatNotes =>
      'ব্যায়ামের নাম ঠিক তালিকায় যেমন আছে তেমনই লেখো। \"sets\", \"reps\" (একটা সংখ্যা বা \"8-12\"-এর মতো পরিসর), \"weight\" (দেওয়া এককে), সেকেন্ডে \"rest\" আর \"days\" ঐচ্ছিক। তালিকায় কার্ডিও বা সময় চিহ্নিত ব্যায়ামের জন্য \"reps\"-এর বদলে \"time\" (সেকেন্ডে, বা \"30:00\"-এর মতো) আর \"distance\" (কিমিতে) ব্যবহার করো; প্রতিটা সেটকে আলাদা মান দিতে \"plan\"-এ লেখো, প্রতি সেটের জন্য একটা এন্ট্রি তার নিজের \"reps\" আর \"weight\" সহ (ওয়ার্ম-আপ সেটের জন্য \"type\": \"warmup\" যোগ করো)। \"superset\": true একটা ব্যায়ামকে পরেরটার সাথে জোড়ে। কয়েক সপ্তাহের জন্য রুটিনগুলো \"weeks\"-এর ভেতরে দলবদ্ধ করো, দ্বিতীয় উদাহরণের মতো।';

  @override
  String get planSets => 'সেট ঠিক করো';

  @override
  String get planSetsHint =>
      'প্রতিটা সেটের ধরন, রেপ আর ওজন বেছে নাও। শেষ সেশন থেকে শুরু করতে ওজন অটোতে রাখো।';

  @override
  String get planHintReps => 'প্রতিটা সেটের ধরন আর রেপ বেছে নাও। অটো শেষ সেশন থেকে শুরু করে।';

  @override
  String get planHintTime => 'প্রতিটা সেটের ধরন আর সময় বেছে নাও। অটো শেষ সেশন থেকে শুরু করে।';

  @override
  String get planHintTimeWeight => 'প্রতিটা সেটের ধরন, সময় আর ওজন বেছে নাও। অটো শেষ সেশন থেকে শুরু করে।';

  @override
  String get planHintCardio => 'প্রতিটা সেটের দূরত্ব আর সময় বেছে নাও। অটো শেষ সেশন থেকে শুরু করে।';

  @override
  String get timeOnly => 'শুধু সময়';

  @override
  String get autoValue => 'অটো';

  @override
  String get clearPlan => 'প্ল্যান মুছে ফেলো';

  @override
  String get shareRoutine => 'রুটিন শেয়ার করো';

  @override
  String get shareWeek => 'আমার সপ্তাহ শেয়ার করো';

  @override
  String get shareWeekHint => 'তোমার সব রুটিন আর প্রতিটার দিন।';

  @override
  String shareMessage(String name) {
    return '$name: যোগ করতে ফাইলটা GymMane দিয়ে খোলো।';
  }

  @override
  String get importRoutines => 'রুটিন ইমপোর্ট করো';

  @override
  String get importPasteHint =>
      'এখানে একটা রুটিন পেস্ট করো: GymMane থেকে শেয়ার করা, AI-এর উত্তর, JSON বা CSV।';

  @override
  String get pasteAction => 'পেস্ট করো';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nটি রুটিন', one: '1টি রুটিন');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'এর সাপ্তাহিক সময়সূচিও ব্যবহার করো';

  @override
  String get useTheirScheduleHint => 'এর আনা দিনগুলো সেই দিনের তোমার প্ল্যানের জায়গা নেবে।';

  @override
  String get addToMyRoutines => 'আমার রুটিনে যোগ করো';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি রুটিন যোগ হয়েছে',
      one: '1টি রুটিন যোগ হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'এখানে GymMane ইমপোর্ট করার মতো কিছু নেই';

  @override
  String get aiStepCopy => 'অনুরোধটা কপি করো। এতে তোমার ব্যায়ামের তালিকা আর GymMane যে ফরম্যাট পড়ে তা আছে।';

  @override
  String get aiStepAsk => 'যেকোনো AI-তে পেস্ট করো আর বলো কী চাও: সপ্তাহে কয় দিন, লক্ষ্য, কয় সপ্তাহ।';

  @override
  String get aiStepPaste => 'এর উত্তর নিচে পেস্ট করো আর ইমপোর্ট করো। ফাইল লাগবে না।';

  @override
  String get copyForAi => 'AI-এর জন্য কপি করো';

  @override
  String get copiedDone => 'কপি হয়েছে';

  @override
  String get aiPasteHint => 'AI-এর উত্তর এখানে পেস্ট করো';

  @override
  String get importAction => 'ইমপোর্ট করো';

  @override
  String get showFormat => 'ফরম্যাট দেখো';

  @override
  String get shareAsFile => 'ফাইল হিসেবে শেয়ার করো';

  @override
  String get recoveryTab => 'রিকভারি';

  @override
  String recoveryOverall(int pct) {
    return 'শরীর $pct% রিকভার';
  }

  @override
  String get recoveryAllFresh => 'সব রিকভার হয়ে গেছে। যা খুশি ট্রেন করার ভালো দিন।';

  @override
  String recoveryStill(String muscles) {
    return 'এখনও রিকভার হচ্ছে: $muscles';
  }

  @override
  String get recoveryTired => 'ক্লান্ত';

  @override
  String get recoveryFresh => 'তাজা';

  @override
  String get recoveryHint =>
      'পেশিতে ট্যাপ করে দেখো কতটা রিকভার হয়েছে। সাম্প্রতিক সেট বেশি গুরুত্ব পায়, আর ভারী সেট (RPE অনুযায়ী) আরও বেশি।';

  @override
  String recoveryPct(int pct) {
    return '$pct% রিকভার';
  }

  @override
  String readyInHours(int h) {
    return '~$h ঘ-এ তৈরি';
  }

  @override
  String get tplAbcd => 'চার দিন: বুক আর ট্রাইসেপস, পিঠ আর বাইসেপস, পা, কাঁধ আর পেট।';

  @override
  String get tplAbcde => 'পাঁচ দিন, প্রতিদিন একটা পেশির দল: বুক, পিঠ, পা, কাঁধ, বাহু।';

  @override
  String get elapsedCaps => 'কেটেছে';

  @override
  String get tapToChange => 'বদলাতে ট্যাপ করো';

  @override
  String get swipeToSkipHint => 'বিশ্রাম বাদ দিতে টাইমারটা পাশে সোয়াইপ করো।';

  @override
  String get screenLocked => 'স্ক্রিন লক';

  @override
  String get lockedHint => 'আনলক করতে উপরের আঙুলের ছাপে চেপে ধরো';

  @override
  String get liveDoneSet => 'সেট শেষ';

  @override
  String get liveSkipRest => 'বিশ্রাম বাদ দাও';

  @override
  String get livePause => 'থামাও';

  @override
  String get liveResume => 'চালিয়ে যাও';

  @override
  String get liveNext => 'পরের';

  @override
  String liveUpNext(String name) {
    return 'এরপর: $name';
  }

  @override
  String get stickerOpen => 'ছবির উপর শেয়ার করো';

  @override
  String get stickerNoPhoto => 'ছবি ছাড়া';

  @override
  String get stickerWorkout => 'ওয়ার্কআউট';

  @override
  String get stickerStreak => 'স্ট্রিক';

  @override
  String get stickerDate => 'তারিখ';

  @override
  String get stickerHint => 'সরাতে টানো, আকার বদলাতে বা ঘোরাতে পিঞ্চ করো';

  @override
  String get stickerSaved => 'তোমার গ্যালারিতে সেভ হয়েছে';

  @override
  String get stickerWeek => 'এই সপ্তাহ';

  @override
  String get getReady => 'তৈরি হও';

  @override
  String sideOfTwo(String n) {
    return 'পাশ $n / 2';
  }

  @override
  String get switchSides => 'পাশ বদলাও';

  @override
  String get stickerGallery => 'গ্যালারি';

  @override
  String get stickerCamera => 'ক্যামেরা';

  @override
  String get shareIntroTitle => 'এই রুটিন শেয়ার করো';

  @override
  String get shareIntroBody =>
      'তোমার সঙ্গী, বন্ধু বা পরিবারকে পাঠাও। ওরা একটা ছোট ফাইল পাবে যা GymMane-এ খোলে আর এক ট্যাপে যোগ হয়, সেট আর ওজনসহ।';

  @override
  String get removedFromRoutine => 'রুটিন থেকে সরানো হয়েছে';

  @override
  String get radarTitle => 'শেষ 30 দিন';

  @override
  String get radarHint => 'দেখো কোন অংশে আরও কাজ লাগবে';

  @override
  String get radarEmpty => 'তোমার ভারসাম্য দেখতে কয়েক দিন ট্রেনিং করো';

  @override
  String get radarBalanced => 'এখন পর্যন্ত ভালো ভারসাম্য';

  @override
  String radarFocus(String list) {
    return 'আরও লাগবে: $list';
  }

  @override
  String get countdownReady => 'তৈরি হও';

  @override
  String get countdownSkip => 'এখনই শুরু করতে ট্যাপ করো';

  @override
  String get countdownSetting => 'শুরুর আগে কাউন্টডাউন';

  @override
  String get effortSetting => 'প্রতি সেটে পরিশ্রম লেখো';

  @override
  String get effortHint =>
      'RPE: 10 মানে আর কিছু বাকি নেই, 8 মানে দুটো রেপ বাকি ছিল। RIR বাকি থাকা রেপ গোনে। কোনো সেটে এটা থাকলে আনুমানিক 1RM RPE চার্ট ব্যবহার করে।';

  @override
  String get rirHint => '0 মানে আর কিছু বাকি নেই, 2 মানে দুটো রেপ বাকি ছিল।';

  @override
  String get addWeekWidget => 'সপ্তাহের উইজেট যোগ করো';

  @override
  String get gamificationSetting => 'মেডেল আর লেভেল';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nটি রেপ', one: '$nটি রেপ');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'সেরা সেট';

  @override
  String get weekStartSetting => 'সপ্তাহ শুরু হয়';

  @override
  String get stepOutOfWorkout => 'থামাও আর বেরোও';

  @override
  String get saveToRoutine => 'পরিবর্তন রুটিনে সেভ করো';

  @override
  String get routineUpdated => 'রুটিন আপডেট হয়েছে';

  @override
  String saveChangesTitle(String name) {
    return '$name-এ পরিবর্তন সেভ করবে?';
  }

  @override
  String get saveChangesBody => 'পরেরবার শুরু করলে রুটিনে এই পরিবর্তনগুলো থাকবে।';

  @override
  String get routineOrderChanged => 'ব্যায়ামের নতুন ক্রম';

  @override
  String get mineOnly => 'তোমার বানানো';

  @override
  String createNamed(String name) {
    return 'এখানে নেই? “$name” বানাও';
  }

  @override
  String get orStartWith => 'অথবা এটা দিয়ে শুরু করো';

  @override
  String get warmupFocus => 'ওয়ার্ম-আপ';

  @override
  String get warmupFocusHint => 'মোবিলিটি আর অ্যাক্টিভেশন, সরঞ্জামসহ বা ছাড়া';

  @override
  String get cardioFocus => 'কার্ডিও';

  @override
  String get cardioFocusHint => 'দৌড়, সাইকেল, রোয়িং বা স্কিপিং, দূরত্ব আর সময় দিয়ে';

  @override
  String get homeRecommended => 'হোমে প্রস্তাবিত';

  @override
  String get homeRoutines => 'হোমে রুটিন';

  @override
  String get homeRoutinesHint => 'সবশেষে করাটা আগে';

  @override
  String get homeWeekStats => 'হোমে এই সপ্তাহ';

  @override
  String get homeWeekStatsHint => 'সপ্তাহের ভলিউম, সেট আর PR';

  @override
  String get stepsSetting => 'Health Connect থেকে পদক্ষেপ';

  @override
  String get stepsSettingHint => 'হোমে আজকের পদক্ষেপ';

  @override
  String get stepsToday => 'আজকের পদক্ষেপ';

  @override
  String stepsOfGoal(String goal) {
    return '$goal-এর মধ্যে';
  }

  @override
  String stepsTodayCount(String count) {
    return 'আজ $count পদক্ষেপ';
  }

  @override
  String get stepsGoal => 'দৈনিক পদক্ষেপের লক্ষ্য';

  @override
  String get stepsNoAccess => 'তোমার পদক্ষেপে প্রবেশাধিকার নেই';

  @override
  String get stepsGrant => 'Health Connect-এ অনুমতি দিতে ট্যাপ করো';

  @override
  String get stepsInfoRead =>
      'এটা শুধু তোমার পদক্ষেপের সংখ্যা পড়ে। অন্য কিছু কখনো পড়ে না, আর Health Connect-এ লেখেও না।';

  @override
  String get stepsInfoLocal => 'তোমার পদক্ষেপ তোমার ফোনেই থাকে। GymMane কখনো ইন্টারনেটে যুক্ত হয় না।';

  @override
  String get stepsInfoOff => 'সেটিংস বা Health Connect-এ যেকোনো সময় বন্ধ করো।';

  @override
  String get stepsManage => 'অনুমতি সামলাও';

  @override
  String get routineDoneToday => 'আজকের মতো শেষ · দারুণ';

  @override
  String get trainAgain => 'আবার ট্রেনিং করো';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n দিন আগে',
      one: 'গতকাল করা',
      zero: 'আজ করা',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'আর্কাইভ';

  @override
  String get archiveExercise => 'ব্যায়াম আর্কাইভ করো';

  @override
  String get restoreExercise => 'ফিরিয়ে আনো';

  @override
  String get archivedToast => 'ব্যায়াম আর্কাইভ হয়েছে';

  @override
  String get archivedToastHint => 'ব্যায়াম › আর্কাইভ-এ খুঁজে পাবে';

  @override
  String get archivedBanner => 'আর্কাইভ। এটা তালিকা আর পরামর্শের বাইরে থাকে; তোমার ইতিহাস রাখা আছে।';

  @override
  String get videoMarksHint => 'কোনো ধাপে থামাও আর পিনে ট্যাপ করো, পরেরবার সরাসরি সেখানে যেতে।';

  @override
  String get videoMarkHere => 'এই ধাপটা এখানে চিহ্নিত করো';

  @override
  String get sectionGeneral => 'সাধারণ';

  @override
  String get sectionTraining => 'ট্রেনিং';

  @override
  String get sectionAlerts => 'রিমাইন্ডার ও অ্যালার্ম';

  @override
  String get sectionHome => 'হোম';

  @override
  String get sectionWidgets => 'উইজেট';

  @override
  String get sectionData => 'ডেটা ও ব্যাকআপ';

  @override
  String get multiPlanSetting => 'দিনে কয়েকটা রুটিন';

  @override
  String get multiPlanHint => 'এই দিনের প্রতিটা রুটিনে ট্যাপ করো। যে ক্রমে যোগ করবে সেই ক্রমে চলবে।';

  @override
  String routineOfDay(int n, int total) {
    return 'আজ $total-এর মধ্যে $n';
  }

  @override
  String get nextToday => 'আজ এরপর';

  @override
  String get planAboutMe => 'আমার সম্পর্কে:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age বছর, উচ্চতা $height, $weight।';
  }

  @override
  String planDays(int n) {
    return 'আমি সপ্তাহে $n দিন ট্রেনিং করতে চাই।';
  }

  @override
  String get planNoHistory =>
      'এখনও কোনো ওয়ার্কআউট লেখা নেই: আমাকে শিক্ষানবিশ ধরো আর ভলিউম ও ওজন সাবধানে রাখো।';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'শেষ 30 দিনে $nটি ওয়ার্কআউট লেখা।',
      one: 'শেষ 30 দিনে 1টি ওয়ার্কআউট লেখা।',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'সাম্প্রতিক সেরা সেট';

  @override
  String get planAskFirst =>
      'যদি আমার লক্ষ্য (শক্তি, পেশি, চর্বি কমানো বা সাধারণ ফিটনেস) বা প্রতিটা সেশন কতক্ষণ হতে পারে না জানো, আগে একটা ছোট বার্তায় জিজ্ঞেস করো। উত্তর পেলে শুধু JSON-এ উত্তর দাও।';

  @override
  String get backToTop => 'উপরে ফেরো';

  @override
  String get deleteExerciseTitle => 'এই ব্যায়াম মুছবে?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" তোমার লাইব্রেরি আর রুটিন থেকে মুছে যাবে। তোমার আগের সেট রাখা থাকবে।';
  }

  @override
  String get exportForStravaHint =>
      'ব্রাউজারে strava.com/upload/select-এ আপলোড করো (Strava অ্যাপ ফাইল ইমপোর্ট করতে পারে না)। এটা তোমার সেটসহ Weight Training হিসেবে দেখা যাবে।';

  @override
  String get manualStartTime => 'শুরুর সময়';

  @override
  String get manualDuration => 'সময়কাল';

  @override
  String get manualDurationUnset => 'সময়কাল যোগ করো';

  @override
  String get stravaRow => 'Strava-য় এক্সপোর্ট করো (বেটা)';

  @override
  String get stravaBeta => 'বেটা';

  @override
  String get stravaIntro =>
      'Strava-য় নিতে একটা ওয়ার্কআউট বেছে নাও। একটা .fit ফাইল পাবে: ব্রাউজারে strava.com/upload/select-এ আপলোড করো আর এটা তোমার সেটসহ Weight Training হিসেবে দেখা যাবে।';

  @override
  String get stravaEmpty => 'এখনও এক্সপোর্ট করার মতো ওয়ার্কআউট নেই।';

  @override
  String get tapToPause => 'থামাতে ট্যাপ করো';

  @override
  String get holdPausedHint => 'থামানো · চালাতে ট্যাপ করো';

  @override
  String get finishHoldNow => 'সেট এখনই শেষ করো';

  @override
  String get barWeightExercise => 'বার বা স্লেজের ওজন';

  @override
  String get barWeightHint => 'প্লেট ক্যালকুলেটর ব্যবহার করে';

  @override
  String get barWeightCustom => 'তোমার · রিসেট করতে ট্যাপ করো';

  @override
  String get groupRename => 'দলের নাম বদলাও';

  @override
  String get groupUngroup => 'দল সরাও, রুটিন রাখো';

  @override
  String get groupDeleteAll => 'দল আর রুটিন মুছে ফেলো';

  @override
  String groupDeleteTitle(String name) {
    return '“$name” মুছবে?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count মুছে যাবে। তোমার ওয়ার্কআউটের ইতিহাস রাখা থাকবে।';
  }

  @override
  String get tplRr => 'r/bodyweightfitness-এর ক্লাসিক: সপ্তাহে তিন দিন ফুল বডি। সহজ লাগলে এক ধাপ উপরে।';

  @override
  String get levelUpKicker => 'পরের ধাপ';

  @override
  String levelUpBody(int reps, String name) {
    return '$name-এ টানা দুটো ওয়ার্কআউটে 3×$reps। পরের ধাপের জন্য তৈরি?';
  }

  @override
  String levelUpSwap(String routine) {
    return '$routine-এ বদলাও';
  }

  @override
  String get levelUpSee => 'কীভাবে করে দেখো';

  @override
  String get levelUpLater => 'এখন না';

  @override
  String get levelUpStay => 'এটাই রাখো';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name এখন $routine-এ';
  }

  @override
  String get levelUpStayed => 'এটার জন্য আর লেভেল-আপের পরামর্শ নয়';

  @override
  String get levelHintsSetting => 'পরের ধাপের পরামর্শ দাও';

  @override
  String get heatmapLabelsSetting => 'অ্যাক্টিভিটি মানচিত্রে দিন আর মাস';

  @override
  String get rmPercent => 'শতাংশ';

  @override
  String rmAtPercent(String pct) {
    return 'তোমার সর্বোচ্চের $pct';
  }

  @override
  String get copyWorkout => 'লেখা হিসেবে কপি করো';

  @override
  String get goalSet => 'লক্ষ্য ঠিক করো';

  @override
  String get goalTargetReps => 'লক্ষ্য রেপ';

  @override
  String goalToGo(String value) {
    return 'আর $value';
  }

  @override
  String get goalReached => 'লক্ষ্য পূরণ';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n দিন বাকি', one: '1 দিন বাকি');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'তারিখ পেরিয়ে গেছে';

  @override
  String get goalDeadline => 'শেষ তারিখ';

  @override
  String get goalNoDeadline => 'শেষ তারিখ নেই';

  @override
  String get goalRemove => 'লক্ষ্য সরাও';

  @override
  String get exerciseNameMissing => 'একটা নাম দাও';

  @override
  String get aliasesLabel => 'অন্য নাম (ঐচ্ছিক)';

  @override
  String get aliasesHint => 'অন্য নাম, কমা দিয়ে আলাদা';

  @override
  String alsoCalled(String names) {
    return 'আরও: $names';
  }

  @override
  String get addToRoutine => 'রুটিনে যোগ করো';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি রুটিনে',
      one: '1টি রুটিনে',
      zero: 'এখনও কোনো রুটিনে নেই',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'আগে থেকেই আছে';

  @override
  String get restInRoutine => 'এই রুটিনে বিশ্রাম';

  @override
  String get restInRoutineHint => 'ব্যায়ামের মতোই';

  @override
  String get restInRoutineReset => 'শুধু এখানে · ফেরাতে ট্যাপ করো';

  @override
  String get swapExercise => 'ব্যায়াম বদলাও';

  @override
  String get swapShort => 'বদলাও';

  @override
  String swapHint(String name) {
    return '$name-এর বদলে, শুধু আজকের জন্য। শেষ করলে এটা রুটিনে রাখতে পারবে।';
  }

  @override
  String get swapKeepsDone => 'যে সেটগুলো করে ফেলেছ সেগুলো লেখা থাকবে; নতুনটা বাকিটা সামলাবে।';

  @override
  String swapSameMuscle(String muscle) {
    return 'একই পেশি · $muscle';
  }

  @override
  String get swapDoneBefore => 'আগে করা';

  @override
  String get multiPlanSettingHint => 'একই দিনে একাধিক রুটিন';

  @override
  String get levelHintsHint => 'কঠিন সংস্করণের পরামর্শ দেয়';

  @override
  String get focusCardHint => 'আজকের রুটিন, হোমের একদম উপরে';

  @override
  String get gamificationHint => 'মেডেল, লেভেল আর উদযাপন';

  @override
  String get exerciseSettings => 'এই ব্যায়ামের সেটিংস';

  @override
  String get placeActiveNow => 'তুমি এখানে';

  @override
  String get placeTapToUse => 'এখানে ট্রেনিং করতে ট্যাপ করো';

  @override
  String get intervalDays => 'দিন';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target দিন';
  }

  @override
  String get toolNameRpe => 'RPE লোড';

  @override
  String get toolTitleRpe => 'RPE অনুযায়ী লোড';

  @override
  String get toolDescRpe => 'যে পরিশ্রম চাও তার জন্য ওজন';

  @override
  String get toolNameDots => 'শক্তির স্তর';

  @override
  String get toolTitleDots => 'শক্তির স্তর (DOTS)';

  @override
  String get toolDescDots => 'তোমার ওজনের তুলনায় তোমার শক্তি';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'RPE $rpe-এ $reps রেপের জন্য';
  }

  @override
  String get rpeYourSet => 'এইমাত্র করা একটা সেট';

  @override
  String get rpeGoal => 'যা করতে চাও';

  @override
  String rpeOneRmLine(String value) {
    return 'আনুমানিক 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 মানে আর একটাও হতো না; 8 মানে দুটো বাকি ছিল।';

  @override
  String get dotsBestLifts => 'তোমার সেরা লিফট';

  @override
  String get dotsSquat => 'স্কোয়াট';

  @override
  String get dotsBench => 'বেঞ্চ প্রেস';

  @override
  String get dotsDeadlift => 'ডেডলিফট';

  @override
  String dotsTotalLine(String value) {
    return 'মোট: $value';
  }

  @override
  String get dotsExplain =>
      'তোমার শক্তি যে কারও সাথে তুলনা করে, তার ওজন যা-ই হোক। তোমার সেরা একক রেপ, বা আনুমানিক 1RM ব্যবহার করো।';

  @override
  String get dotsLevel0 => 'শিক্ষানবিশ';

  @override
  String get dotsLevel1 => 'মাঝারি';

  @override
  String get dotsLevel2 => 'উন্নত';

  @override
  String get dotsLevel3 => 'খুব উন্নত';

  @override
  String get dotsLevel4 => 'এলিট';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks স্কোর';

  @override
  String get toolDescWilks => 'ক্লাসিক পাওয়ারলিফটিং স্কোর';

  @override
  String get wilksExplain =>
      'ক্লাসিক পাওয়ারলিফটিং সূত্র। 2020 সালে DOTS এর জায়গা নিয়েছে, কিন্তু অনেক প্রতিযোগিতা আর র‍্যাঙ্কিং এখনও এটা ব্যবহার করে।';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'চর্বিহীন ভর সূচক';

  @override
  String get toolDescFfmi => 'তোমার উচ্চতার তুলনায় কতটা পেশি';

  @override
  String get ffmiBodyFat => 'বডি ফ্যাট';

  @override
  String ffmiLeanLine(String value) {
    return 'চর্বিহীন ভর: $value';
  }

  @override
  String get ffmiExplain =>
      'BMI-এর মতো, তবে চর্বি বাদে: শুধু তোমার চর্বিহীন ভর গোনে। উচ্চতা অনুযায়ী সমন্বয় করা, যাতে লম্বা আর খাটো মানুষের তুলনা ন্যায্য হয়।';

  @override
  String get ffmiLevel0 => 'গড়ের নিচে';

  @override
  String get ffmiLevel1 => 'গড়';

  @override
  String get ffmiLevel2 => 'গড়ের উপরে';

  @override
  String get ffmiLevel3 => 'চমৎকার';

  @override
  String get ffmiLevel4 => 'অসাধারণ';

  @override
  String get rpeEffortLabel => 'পরিশ্রম (RPE)';

  @override
  String get restRowHint => 'সেটের মাঝে, যদি না ব্যায়ামের নিজের থাকে';

  @override
  String get effortRowHint => 'প্রতিটা সেটে RPE বা RIR লেখো';

  @override
  String get countdownHint => 'প্রথম সেটের আগে 3, 2, 1';

  @override
  String get keepScreenOnHint => 'ট্রেনিংয়ের সময় স্ক্রিন চালু থাকে';

  @override
  String get demoSizeRowHint => 'ওয়ার্কআউটের সময় ব্যায়ামের ছবি';

  @override
  String get demoLoopRowHint => 'অ্যানিমেশন বারবার চলবে নাকি থামবে';

  @override
  String get trainReminderRowHint => 'ট্রেনিংয়ের দিনে একটা খোঁচা';

  @override
  String get alarmSoundRowHint => 'বিশ্রাম শেষ হলে কী বাজবে';

  @override
  String get alarmStyleRowHint => 'সাইলেন্ট মোডে বাজবে কি না';

  @override
  String get recommendedRowHint => 'হোমে আমাদের প্রস্তাবিত ব্যায়াম';

  @override
  String get weightStepSetting => 'ওজনের ধাপ';

  @override
  String get weightStepHint => '− আর + বোতাম কতটা যোগ করে';

  @override
  String get prBestWorkout => 'সেরা ওয়ার্কআউট';

  @override
  String get mergeExercise => 'মেশাও';

  @override
  String mergeExerciseInto(String name) {
    return '$name-কে মেশাও এর সাথে…';
  }

  @override
  String get mergeExerciseTitle => 'ব্যায়াম মেশাবে?';

  @override
  String mergeExerciseBody(String from, String to) {
    return '\"$from\"-এর পুরো ইতিহাস \"$to\"-তে চলে যাবে। \"$from\" তোমার লাইব্রেরিতে থেকে যাবে। এটা ফেরানো যাবে না।';
  }

  @override
  String get mergedToast => 'ইতিহাস মেশানো হয়েছে';

  @override
  String get nutrition => 'পুষ্টি';

  @override
  String get nutritionHomeEmpty => 'পানি, প্রোটিন আর ক্যালরি';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein গ্রা প্রোটিন';
  }

  @override
  String get nutritionToday => 'আজ';

  @override
  String get nutritionYesterday => 'গতকাল';

  @override
  String get nutritionGoals => 'দৈনিক লক্ষ্য';

  @override
  String get kcalLabel => 'ক্যালরি';

  @override
  String get kcalOver => 'বেশি';

  @override
  String get waterLabel => 'পানি';

  @override
  String get waterDone => 'লক্ষ্য পূরণ';

  @override
  String get waterCustom => 'অন্য পরিমাণ';

  @override
  String get glassSize => 'গ্লাসের আকার';

  @override
  String get supplementsLabel => 'সাপ্লিমেন্ট';

  @override
  String get supplementsEmpty => 'যোগ করতে একটায় ট্যাপ করো, বা নিজের জন্য +।';

  @override
  String get addSupplement => 'নতুন সাপ্লিমেন্ট';

  @override
  String get supplementNameHint => 'ক্রিয়েটিন, ভিটামিন D…';

  @override
  String removeSupplementTitle(String name) {
    return '$name সরাবে?';
  }

  @override
  String get removeSupplementBody => 'যে দিনগুলো খাওয়া বলে চিহ্নিত করেছিলে সেগুলোও যাবে।';

  @override
  String get suppCreatine => 'ক্রিয়েটিন';

  @override
  String get suppVitaminD => 'ভিটামিন D';

  @override
  String get suppOmega3 => 'ওমেগা-3';

  @override
  String get suppMagnesium => 'ম্যাগনেসিয়াম';

  @override
  String get suppMultivitamin => 'মাল্টিভিটামিন';

  @override
  String get suppCaffeine => 'ক্যাফেইন';

  @override
  String get myFoods => 'আমার খাবার';

  @override
  String get newFood => 'নতুন খাবার';

  @override
  String get editFood => 'খাবার বদলাও';

  @override
  String get foodNameHint => 'হুয়ে প্রোটিন, ওটস, পাউরুটি…';

  @override
  String get servingLabel => 'পরিবেশন';

  @override
  String get servingHint => '1 স্কুপ · 30 গ্রা';

  @override
  String get perServing => 'প্রতি পরিবেশনে';

  @override
  String get servingsLabel => 'পরিবেশন';

  @override
  String get foodPhotoHint => 'সাদামাটা ব্যাকগ্রাউন্ডে এটা স্টিকার হয়ে যায়।';

  @override
  String get cutoutWorking => 'কাটা হচ্ছে…';

  @override
  String get cutoutTry => 'ব্যাকগ্রাউন্ড সরাও';

  @override
  String get cutoutKeep => 'পুরো ছবি';

  @override
  String deleteFoodTitle(String name) {
    return '$name মুছবে?';
  }

  @override
  String get deleteFoodBody => 'এটা তোমার খাবার থেকে চলে যাবে। যা আগে লিখেছ তা থাকবে।';

  @override
  String get mealBreakfast => 'সকালের নাস্তা';

  @override
  String get mealLunch => 'দুপুরের খাবার';

  @override
  String get mealDinner => 'রাতের খাবার';

  @override
  String get mealSnacks => 'জলখাবার';

  @override
  String get nothingLogged => 'এখনও কিছু লেখা নেই।';

  @override
  String addToMeal(String meal) {
    return '$meal-এ যোগ করো';
  }

  @override
  String get quickAdd => 'দ্রুত যোগ';

  @override
  String get quickAddHint => 'শুধু সংখ্যা, খাবার সেভ না করে।';

  @override
  String get quickAddName => 'কী ছিল? (ঐচ্ছিক)';

  @override
  String get logFood => 'যোগ করো';

  @override
  String loggedToast(String meal) {
    return '$meal-এ যোগ হয়েছে';
  }

  @override
  String get entryRemoved => 'সরানো হয়েছে';

  @override
  String get goalsFromProfile => 'আমার প্রোফাইল থেকে হিসাব করো';

  @override
  String get goalsFromProfileHint =>
      'তোমার প্রোফাইল থেকে ক্যালরি, আর শরীরের প্রতি কিলোতে 1.8 গ্রা প্রোটিন ও 35 মিলি পানি।';

  @override
  String get kcalEaten => 'খাওয়া';

  @override
  String get kcalRemaining => 'বাকি';

  @override
  String waterTapHint(String amount) {
    return 'গ্লাসে ট্যাপ করো: + $amount';
  }

  @override
  String get shakeEmpty => 'তোমার শেক বেছে নিতে ট্যাপ করো';

  @override
  String shakeTapHint(String name) {
    return 'ট্যাপ করো: + $name';
  }

  @override
  String get shakePick => 'তোমার শেক';

  @override
  String get shakePickHint => 'শেকারে ট্যাপ করো, এক বারেই লেখা হয়ে যাবে।';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'C';

  @override
  String get fatLetter => 'F';

  @override
  String get addBurnedLabel => 'পোড়ানো ক্যালরি যোগ করো';

  @override
  String get addBurnedHint =>
      'তোমার লক্ষ্য আগে থেকেই তোমার সাধারণ অ্যাক্টিভিটি গোনে। শুধু যদি নিজেকে বসে থাকা হিসেবে ঠিক করে থাকো তবেই চালু করো: এটা বিশ্রামের উপরে প্রতিটা ওয়ার্কআউটে পোড়া ক্যালরি যোগ করে।';

  @override
  String get amountLabel => 'পরিমাণ';

  @override
  String amountIn(String unit) {
    return 'পরিমাণ ($unit)';
  }

  @override
  String get bodyweightLabel => 'শরীরের ওজন';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি খাবার কপি হয়েছে',
      one: '1টি খাবার কপি হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'যা আগে লিখেছ তা যেমন আছে তেমনই থাকবে।';

  @override
  String get fiberLabel => 'ফাইবার';

  @override
  String get sugarLabel => 'চিনি';

  @override
  String get sodiumLabel => 'সোডিয়াম';

  @override
  String get foodDatabase => 'খাবারের ডেটাবেস';

  @override
  String get kcalBurned => 'পোড়ানো';

  @override
  String get mealOptions => 'খাবারের বিকল্প';

  @override
  String get moreNutrients => 'ফাইবার, চিনি আর সোডিয়াম';

  @override
  String ofGoal(int goal, String unit) {
    return '$goal $unit-এর মধ্যে';
  }

  @override
  String per100(String unit) {
    return 'প্রতি 100 $unit';
  }

  @override
  String get perServingShort => 'প্রতি পরিবেশনে';

  @override
  String get foodCategory => 'বিভাগ';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$countটি', one: '1টি');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count টুকরো', one: '1 টুকরো');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count স্কুপ', one: '1 স্কুপ');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count টেবিল চামচ',
      one: '1 টেবিল চামচ',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count চা চামচ',
      one: '1 চা চামচ',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count কাপ', one: '1 কাপ');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count গ্লাস', one: '1 গ্লাস');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'সাম্প্রতিক';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি খাবার',
      one: '1টি খাবার',
    );
    return '$_temp0';
  }

  @override
  String get renameLabel => 'নাম বদলাও';

  @override
  String get repeatFrom => 'এখান থেকে আবার';

  @override
  String get repeatNone => 'অন্য দিনে এই খাবারের জন্য এখনও কিছু লেখা নেই।';

  @override
  String get restDayGoals => 'বিশ্রামের দিনে আলাদা লক্ষ্য';

  @override
  String get trainingDays => 'ট্রেনিংয়ের দিন';

  @override
  String get restDays => 'বিশ্রামের দিন';

  @override
  String get trainingDay => 'ট্রেনিংয়ের দিন';

  @override
  String get saveAsMeal => 'খাবার হিসেবে সেভ করো';

  @override
  String get savedMealNameHint => 'যেমন রোজকার নাস্তা';

  @override
  String get savedMealToast => 'খাবার সেভ হয়েছে';

  @override
  String get savedMeals => 'সেভ করা খাবার';

  @override
  String get searchFoodsHint => 'খাবার খোঁজো';

  @override
  String get searchFoodsEmpty => 'ছবিসহ 500-র বেশি খাবার খোঁজো, বা নিজের যোগ করো।';

  @override
  String searchFoodsNone(String query) {
    return '\"$query\"-এর জন্য কিছু পাওয়া যায়নি। নিজের খাবার হিসেবে বানাও।';
  }

  @override
  String get servingWeight => 'গ্রাম';

  @override
  String get weekAverage => 'এই সপ্তাহ';

  @override
  String get weekAvgEnergy => 'দৈনিক গড়';

  @override
  String get weekAvgProtein => 'দিনে প্রোটিন';

  @override
  String get weekEnergyOnTarget => 'ক্যালরি লক্ষ্যে';

  @override
  String get weekProteinOnTarget => 'প্রোটিন লক্ষ্যে';

  @override
  String weekProteinAvg(int grams) {
    return 'দিনে $grams গ্রা প্রোটিন';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$days দিনের মধ্যে $met দিন লক্ষ্যে';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count দিন লেখা',
      one: '1 দিন লেখা',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'এখনও কিছু লেখা নেই';

  @override
  String get weekOnTargetHint => 'লক্ষ্যে মানে: ক্যালরি লক্ষ্যের 10%-এর মধ্যে আর অন্তত 90% প্রোটিন।';

  @override
  String get weightGoalLabel => 'লক্ষ্য ওজন';

  @override
  String weightGoalTitle(String unit) {
    return 'লক্ষ্য ওজন ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'লক্ষ্য $weight';
  }

  @override
  String get weightGoalNone => 'লক্ষ্য ঠিক করতে চেপে ধরো';

  @override
  String get weightGoalReached => 'লক্ষ্য পূরণ';

  @override
  String weightToLose(String weight) {
    return 'আরও $weight কমাতে হবে';
  }

  @override
  String weightToGain(String weight) {
    return 'আরও $weight বাড়াতে হবে';
  }

  @override
  String get aminoHis => 'হিস্টিডিন';

  @override
  String get aminoIle => 'আইসোলিউসিন';

  @override
  String get aminoLeu => 'লিউসিন';

  @override
  String get aminoLys => 'লাইসিন';

  @override
  String get aminoSaa => 'মেথিওনিন';

  @override
  String get aminoAaa => 'ফিনাইলঅ্যালানিন';

  @override
  String get aminoThr => 'থ্রিওনিন';

  @override
  String get aminoTrp => 'ট্রিপটোফ্যান';

  @override
  String get aminoVal => 'ভ্যালিন';

  @override
  String get animalProtein => 'প্রাণিজ প্রোটিন';

  @override
  String get proteinQuality => 'প্রোটিনের মান';

  @override
  String get qualityComplete => 'সম্পূর্ণ';

  @override
  String get qualityAlmost => 'প্রায় সম্পূর্ণ';

  @override
  String get qualityIncomplete => 'অসম্পূর্ণ';

  @override
  String get qualityNoData => 'এখনও ডেটা নেই';

  @override
  String get qualityNoDataHint => 'তোমার অ্যামিনো অ্যাসিড দেখতে ডেটাবেস থেকে খাবার লেখো।';

  @override
  String get qualityAllCovered => 'নয়টি প্রয়োজনীয় অ্যামিনো অ্যাসিডই পূরণ হয়েছে।';

  @override
  String qualityLimiting(String amino) {
    return '$amino কম। এতে ভরপুর খাবারের সাথে মিলিয়ে খাও।';
  }

  @override
  String qualityCoverage(int pct) {
    return 'তোমার প্রোটিনের $pct%-এর ভিত্তিতে: তোমার নিজের খাবারে অ্যামিনো অ্যাসিডের ডেটা নেই।';
  }

  @override
  String get fatTypes => 'চর্বির ধরন';

  @override
  String get fatSaturated => 'স্যাচুরেটেড';

  @override
  String get fatMono => 'মনো';

  @override
  String get fatPoly => 'পলি';

  @override
  String satLimitLine(String grams, int limit) {
    return 'স্যাচুরেটেড $grams গ্রা, সর্বোচ্চ $limit গ্রা (ক্যালরির 10%)';
  }

  @override
  String get sugarSodium => 'চিনি আর সোডিয়াম';

  @override
  String get shakeCard => 'প্রোটিন শেক';

  @override
  String get mealOther => 'খাবার';

  @override
  String get mealAdd => 'একটা খাবার যোগ করো';

  @override
  String get mealAddHint => 'যেমন প্রি-ওয়ার্কআউট';

  @override
  String get mealsOfDay => 'দিনের খাবার';

  @override
  String get mealsHint => 'যত খুশি বানাও। একটা সরালে তাতে যা লিখেছিলে তা উপরেরটায় চলে যায়।';

  @override
  String get trackersTitle => 'সাজিয়ে নাও';

  @override
  String get trackersHint => 'শুধু সেটাই দেখাও যা ট্র্যাক করতে চাও।';

  @override
  String get trackersDaily => 'দৈনিক সারাংশ';

  @override
  String get trackersDetail => 'বিস্তারিত';

  @override
  String get trackersCards => 'কার্ড';

  @override
  String get prepTitle => 'মিল প্রেপ';

  @override
  String get prepNewShort => 'নতুন ব্যাচ';

  @override
  String get prepNew => 'নতুন ব্যাচ';

  @override
  String get prepEdit => 'ব্যাচ বদলাও';

  @override
  String get prepHint => 'পুরো হাঁড়ি একবার লেখো, তারপর একটু একটু করে খাও।';

  @override
  String get prepEmpty => 'বড় করে রান্না করেছ? একবার লেখো, তারপর শুধু বলো বাকিটার কতটা খেলে।';

  @override
  String get prepNameHint => 'যেমন চিকেন আর ভাত';

  @override
  String get prepDefaultName => 'ব্যাচ';

  @override
  String get prepIngredients => 'উপকরণ';

  @override
  String get prepAddIngredient => 'উপকরণ যোগ করো';

  @override
  String get prepCookedWeight => 'রান্নার পরের ওজন';

  @override
  String prepCookedHint(String grams) {
    return 'সঠিক সংখ্যার জন্য রান্নার পর হাঁড়িটা মাপো। খালি রাখলে কাঁচা মোট ($grams গ্রা) ব্যবহার হবে।';
  }

  @override
  String get prepNeedWeight => 'রান্নার পরের ওজন যোগ করো: কিছু উপকরণের গ্রাম নেই।';

  @override
  String prepLeftOf(String left, String total) {
    return '$total-এর মধ্যে $left বাকি';
  }

  @override
  String get prepOfWhatsLeft => 'বাকির %';

  @override
  String get prepAll => 'সব';

  @override
  String prepLogAmount(String grams) {
    return '$grams লেখো';
  }

  @override
  String get prepWeighLeft => 'বাকিটা মাপো';

  @override
  String get prepFinished => 'এই ব্যাচ শেষ।';

  @override
  String get approxValues => 'আনুমানিক';

  @override
  String get editValues => 'মান বদলাও';

  @override
  String get editValuesHint => 'শুধু এই এন্ট্রি বদলায়। পরের জন্য খাবারটা ঠিক করতে আমার খাবার থেকে বদলাও।';

  @override
  String get editLibraryHint => 'তোমার নিজের খাবার হিসেবে সেভ, একই ছবিসহ';

  @override
  String per100Line(String energy, String unit) {
    return 'প্রতি 100 $unit-এ $energy';
  }

  @override
  String get rawLabel => 'কাঁচা';

  @override
  String get cookedLabel => 'রান্না করা';

  @override
  String get rawHint => 'রান্নার আগের ওজন';

  @override
  String cookedHint(String factor) {
    return 'রান্নার পরের ওজন (কাঁচা ওজনের ×$factor)';
  }

  @override
  String get servingsUnit => 'পরিবেশন';

  @override
  String logAmount(String energy) {
    return 'লেখো · $energy';
  }

  @override
  String get catFruit => 'ফল';

  @override
  String get catVeg => 'সবজি';

  @override
  String get catMeat => 'মাংস';

  @override
  String get catFish => 'মাছ';

  @override
  String get catEgg => 'ডিম';

  @override
  String get catDairy => 'দুগ্ধজাত';

  @override
  String get catGrain => 'শস্য';

  @override
  String get catBakery => 'বেকারি';

  @override
  String get catLegume => 'ডাল';

  @override
  String get catNut => 'বাদাম';

  @override
  String get catOil => 'তেল';

  @override
  String get catPantry => 'ভাঁড়ার';

  @override
  String get catDrink => 'পানীয়';

  @override
  String get catSauce => 'সস';

  @override
  String get catSpice => 'মশলা';

  @override
  String get searchFoodsPrompt => 'কী খেয়েছ?';

  @override
  String get shelfEmpty =>
      'একটা খাবার খোঁজো বা নিজের খাবারের ছবি তোলো: যেগুলো সবচেয়ে বেশি লেখো সেগুলো এখানে দেখা যাবে।';

  @override
  String get repeatEntry => 'আবার লেখো';

  @override
  String get notifSuppChannel => 'সাপ্লিমেন্ট';

  @override
  String get notifSuppChannelWhy => 'সাপ্লিমেন্ট খাওয়ার দৈনিক রিমাইন্ডার';

  @override
  String get energySplit => 'ক্যালরি কোথা থেকে আসে';

  @override
  String get typicalServing => 'সাধারণ পরিবেশন';

  @override
  String cookedYieldLine(String factor) {
    return 'কাঁচা ওজনের $factor× হয়';
  }

  @override
  String get readyDishes => 'পদ';

  @override
  String weightLastLine(String weight) {
    return 'শেষ ওজন $weight';
  }

  @override
  String get proteinAnimalShort => 'প্রাণিজ';

  @override
  String get proteinPlantShort => 'উদ্ভিজ্জ';

  @override
  String kcalFromMacros(String value) {
    return 'এই ম্যাক্রো মিলিয়ে প্রায় $value';
  }

  @override
  String get useValue => 'ব্যবহার করো';

  @override
  String get suppRowHint => 'চিহ্নিত করতে ট্যাপ · বিস্তারিত দেখতে চেপে ধরো';

  @override
  String get suppPhoto => 'ছবি';

  @override
  String get suppDose => 'ডোজ';

  @override
  String get suppDoseHint => '5 গ্রা, 2টি ক্যাপসুল…';

  @override
  String get suppRemind => 'মনে করিয়ে দাও';

  @override
  String mealPlanDefault(int n) {
    return 'প্ল্যান $n';
  }

  @override
  String get mealPlansTitle => 'খাবারের প্ল্যান';

  @override
  String get mealPlanNew => 'নতুন প্ল্যান';

  @override
  String fromPlan(String name) {
    return '$name থেকে';
  }

  @override
  String get logPlan => 'লেখো';

  @override
  String get planFromDay => 'এই দিনটা কপি করো';

  @override
  String get planNewHint => 'রুটিনের মতো দিনগুলো প্ল্যান করো, তারপর এক ট্যাপে পুরো খাবার লেখো।';

  @override
  String get planLogDay => 'খালি খাবারগুলো লেখো';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি খাবার লেখা হয়েছে',
      one: '1টি খাবার লেখা হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'প্ল্যান নেই';

  @override
  String get planWeekHint => 'একটা দিনে প্ল্যান দিতে সেই দিনে ট্যাপ করো।';

  @override
  String get planDuplicate => 'কপি বানাও';

  @override
  String planDeleteTitle(String name) {
    return '$name মুছবে?';
  }

  @override
  String get planDeleteBody => 'তোমার লেখা দিনগুলো যেমন আছে তেমনই থাকবে।';

  @override
  String get sectionBeta => 'বেটা';

  @override
  String get nutritionBeta => 'পুষ্টি';

  @override
  String get nutritionBetaHint => 'খাবার, পানি আর সাপ্লিমেন্ট';

  @override
  String get nutritionAboutTitle => 'পুষ্টি সম্পর্কে';

  @override
  String get nutritionAboutSub => 'এটা কী, আর এটা কখনো কী হবে না।';

  @override
  String get nutritionAboutWhatTitle => 'তোমার ট্রেনিংয়ের অংশ';

  @override
  String get nutritionAboutWhat =>
      'ওয়ার্কআউটের ঠিক পাশে খাবার, পানি, প্রোটিন আর সাপ্লিমেন্ট লেখার সহজ উপায়। GymMane আগে জিম অ্যাপ: পুষ্টি এখানে আছে যাতে সব এক জায়গায় রাখতে পারো, কোনো আলাদা ডায়েট অ্যাপের জায়গা নিতে নয়।';

  @override
  String get nutritionAboutScanTitle => 'স্ক্যানিং কখনো নয়';

  @override
  String get nutritionAboutScan =>
      'বারকোড স্ক্যান করলেই সব তথ্য ভরে গেলে সুবিধা হতো। কিন্তু তার জন্য ইন্টারনেট আর বিশাল এক অনলাইন খাবারের ডেটাবেস লাগে, আর তুমি কী খাও তা অন্য কারও সার্ভারে গিয়ে পৌঁছায়। সেই ডেটা দেখায় তুমি কখন খাও, কী খাও আর শরীরের কীভাবে যত্ন নাও, আর এটা বিজ্ঞাপনে ব্যবহার হতে পারে বা বড় কোম্পানির হাতে যেতে পারে। তাই কোনো স্ক্যানার নেই, আর কখনো থাকবেও না।';

  @override
  String get nutritionAboutLocalTitle => 'সব তোমার ফোনে';

  @override
  String get nutritionAboutLocal =>
      'ছবিসহ 500-র বেশি খাবার অ্যাপের ভেতরেই আছে। তুমি নিজের খাবার যোগ করতে, ছবি বদলাতে আর মান সম্পাদনা করতে পারো। GymMane-এর বাকি সবকিছুর মতো, সব তোমার ফোনেই থাকে।';

  @override
  String get nutritionAboutBetaTitle => 'এখনও বেটায়';

  @override
  String get nutritionAboutBeta =>
      'কিছু কম মনে হলে GitHub-এ জানাও। শুধু স্ক্যানিং বা আরও বড় খাবারের ডেটাবেস নয়: তোমার গোপনীয়তার পাশাপাশি এতে অ্যাপটা অনেক ভারী হয়ে যাবে। পুষ্টি লাগবে না? সেটিংসে বন্ধ করো, তোমার ডেটা থেকে যাবে।';

  @override
  String get nutritionAboutSuggest => 'আইডিয়া দাও';

  @override
  String get nutritionAboutOk => 'বুঝেছি';

  @override
  String get planShare => 'শেয়ার করো';

  @override
  String get planImport => 'প্ল্যান ইমপোর্ট করো';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি প্ল্যান ইমপোর্ট হয়েছে',
      one: '1টি প্ল্যান ইমপোর্ট হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'ওই ফাইলে কোনো খাবারের প্ল্যান নেই।';

  @override
  String get planMoveUp => 'উপরে সরাও';

  @override
  String get planMoveDown => 'নিচে সরাও';

  @override
  String get cutoutEdit => 'কাটআউট ঠিক করো';

  @override
  String get cutoutEditHint =>
      'মুছতে বা ফেরাতে টানো। একটা অংশ পুরো সরাতে বা ফেরাতে তাতে ট্যাপ করো। জুম করতে পিঞ্চ করো।';

  @override
  String get cutoutErase => 'মুছে ফেলো';

  @override
  String get cutoutRestore => 'ফেরাও';

  @override
  String get cutoutReset => 'স্বয়ংক্রিয়তে ফেরো';

  @override
  String get cutoutByHand => 'হাতে কাটো';

  @override
  String notifSuppTitleFor(String names) {
    return 'খাওয়ার সময়: $names';
  }

  @override
  String get notifSuppTap => 'খাওয়ার পর GymMane-এ টিক দাও।';

  @override
  String get suppNoneToday => 'আজ কিছু খাওয়ার নেই।';

  @override
  String get suppOtherDays => 'অন্য দিন';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'প্রতি $n দিনে', one: 'প্রতিদিন');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'প্রতিদিন';

  @override
  String suppFromDate(String date) {
    return '$date থেকে';
  }

  @override
  String suppUntilDate(String date) {
    return '$date পর্যন্ত';
  }

  @override
  String get suppSomeDays => 'কিছু দিন';

  @override
  String get suppEveryShort => 'প্রতি X দিনে';

  @override
  String get suppWhen => 'কখন';

  @override
  String get suppEveryLead => 'প্রতি';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'দিনে');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'শুরু';

  @override
  String get suppEnds => 'শেষ';

  @override
  String get suppTomorrow => 'আগামীকাল';

  @override
  String get suppPickDate => 'তারিখ বেছে নাও';

  @override
  String get suppNever => 'কখনো না';

  @override
  String get suppOneWeek => '1 সপ্তাহ পরে';

  @override
  String get suppOneMonth => '1 মাস পরে';

  @override
  String get planPickHint => 'এই দিনের প্ল্যান বেছে নাও, বা নতুন বানাও।';

  @override
  String planSetForDay(String day) {
    return '$day-এর জন্য প্ল্যান ঠিক হয়েছে';
  }

  @override
  String get planSaved => 'প্ল্যান সেভ হয়েছে';

  @override
  String get planDiscardTitle => 'পরিবর্তন বাদ দেবে?';

  @override
  String get planDiscardBody => 'যা বদলেছ তা সেভ হবে না।';

  @override
  String get planDiscard => 'বাদ দাও';

  @override
  String get planEdit => 'প্ল্যান বদলাও';

  @override
  String get planNameHint => 'প্ল্যানের নাম';

  @override
  String get planDaysQuestion => 'কোন কোন দিন?';

  @override
  String get planDaysHint => 'সেই দিনগুলোতে এটা পুষ্টিতে দেখা যাবে যাতে এক ট্যাপে লিখতে পারো।';

  @override
  String get planDaysNone => 'অন্তত একটা দিন বেছে নাও, নইলে কোথাও দেখা যাবে না।';

  @override
  String get planNothingToLog => 'ওই খাবারগুলো আগেই লেখা আছে';

  @override
  String get planSave => 'প্ল্যান সেভ করো';

  @override
  String get planToday => 'আজকের প্ল্যান';

  @override
  String get planLogRest => 'বাকিটা লেখো';

  @override
  String get dishNew => 'আমার পদ বানাও';

  @override
  String get dishNewHint => 'উপকরণ আর পরিমাণ বেছে নাও, সেভ করো আর এক ট্যাপে লেখো।';

  @override
  String get dishEdit => 'পদ বদলাও';

  @override
  String get dishNameHint => 'যেমন মায়ের ডাল';

  @override
  String get dishIngredients => 'উপকরণ';

  @override
  String get dishEmptyHint => 'এতে যা যায় তা সাধারণত যতটা খাও সেই পরিমাণে যোগ করো।';

  @override
  String get dishSave => 'পদ সেভ করো';

  @override
  String get dishNeedsName => 'একটা নাম দাও';

  @override
  String get dishNeedsItems => 'অন্তত একটা উপকরণ যোগ করো';

  @override
  String get suppHistory => 'শেষ 14 দিন';

  @override
  String suppTakenOf(int n, int total) {
    return '$total-এর মধ্যে $n খাওয়া';
  }

  @override
  String get suppNoReminder => 'রিমাইন্ডার নেই';

  @override
  String get suppMarkTaken => 'খাওয়া হয়েছে বলে চিহ্নিত করো';

  @override
  String get suppUnmark => 'চিহ্ন সরাও';

  @override
  String get suppEdit => 'বদলাও';

  @override
  String get mealMoveTo => 'এখানে সরাও';

  @override
  String get mealClear => 'খাবার খালি করো';

  @override
  String get mealCleared => 'খাবার খালি হয়েছে';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি খাবার সরানো হয়েছে',
      one: '1টি খাবার সরানো হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'পুরো দিনটা আবার করো';

  @override
  String createFoodNamed(String name) {
    return '“$name” বানাও';
  }

  @override
  String get entryDay => 'দিন';

  @override
  String get movedToDay => 'সরানো হয়েছে';

  @override
  String get favFoodsHint => 'কোনো খাবারে ☆ ট্যাপ করো';

  @override
  String get favFoodsEmpty => 'যেকোনো খাবারের তারায় ট্যাপ করো যাতে এখানে এক ট্যাপ দূরে থাকে।';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি খাবার',
      one: '1টি খাবার',
    );
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'একটা খাবার তার ••• মেনু থেকে সেভ করো, বা নিজের পদ বানাও।';

  @override
  String get sugarLimitLabel => 'চিনির সীমা';

  @override
  String get sodiumLimitLabel => 'সোডিয়ামের সীমা';

  @override
  String get waterOptions => 'পানির বিকল্প';

  @override
  String get waterNone => 'এখনও পানি লেখা নেই।';

  @override
  String get waterDailyGoal => 'দৈনিক পানি';

  @override
  String get trackersScreen => 'স্ক্রিন';

  @override
  String get vesselMotion => 'নড়তে থাকা পানি আর শেক';

  @override
  String get vesselMotionHint => 'স্ক্রিন ধীর মনে হলে বন্ধ করো: গ্লাস তবুও ভরে, শুধু নড়া বন্ধ হয়।';

  @override
  String get planFixedWeek => 'নির্দিষ্ট সপ্তাহ';

  @override
  String get planRotation => 'রোটেশন';

  @override
  String get rotationTitle => 'রোটেশন';

  @override
  String get rotationHint => 'পরেরটা হলো তোমার শেষ ওয়ার্কআউটের পরে যেটা আসে, দিন যা-ই হোক।';

  @override
  String get rotationEmpty => 'যে ক্রমে করবে সেই ক্রমে রুটিন যোগ করো: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return 'এই রাউন্ডে $total-এর মধ্যে $done শেষ';
  }

  @override
  String get rotationNext => 'পরের';

  @override
  String get rotationAdd => 'রুটিন যোগ করো';

  @override
  String get rotationPickHint => 'যে ক্রমে ট্যাপ করবে সেই ক্রমে যাবে।';

  @override
  String get rotationSkip => 'পরেরটায় যাও';

  @override
  String get rotationRestart => 'নতুন রাউন্ড শুরু করো';

  @override
  String get rotationMakeNext => 'এটাকে পরেরটা করো';

  @override
  String get rotationRemove => 'রোটেশন থেকে সরাও';

  @override
  String rotationPlace(int n, int total) {
    return 'রোটেশনে $total-এর মধ্যে $n';
  }

  @override
  String get moveToDay => 'অন্য দিনে সরাও';

  @override
  String get moveToDayHint => 'শুধু এবারের জন্য; তোমার সাপ্তাহিক প্ল্যান একই থাকবে।';

  @override
  String get movedToast => 'ওয়ার্কআউট সরানো হয়েছে';

  @override
  String get backToPlan => 'সাপ্তাহিক প্ল্যানে ফেরো';

  @override
  String get tomorrow => 'আগামীকাল';

  @override
  String get untrainedTab => 'ট্রেন না করা';

  @override
  String get untrainedRecent => 'সাম্প্রতিক';

  @override
  String get untrainedLong => 'অনেক আগে';

  @override
  String untrainedWaiting(String list) {
    return 'সবচেয়ে বেশি অপেক্ষায়: $list';
  }

  @override
  String get untrainedAllRecent => 'এই সপ্তাহে প্রতিটা পেশিতে কাজ হয়েছে। দারুণ।';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n দিন আগে',
      one: 'গতকাল ট্রেন করা',
      zero: 'আজ ট্রেন করা',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'এখনও ট্রেন করা হয়নি';

  @override
  String get layoutSetting => 'ওয়ার্কআউটের বিন্যাস';

  @override
  String get layoutCards => 'কার্ড';

  @override
  String get layoutList => 'তালিকা';

  @override
  String get layoutHint =>
      'কার্ড একবারে একটা ব্যায়াম দেখায়। তালিকা পুরো ওয়ার্কআউট এক স্ক্রিনে, সেট ধরে ধরে দেখায়।';

  @override
  String get layoutRowHint => 'একবারে একটা ব্যায়াম, বা পুরো ওয়ার্কআউট তালিকায়';

  @override
  String get previousCol => 'আগের';

  @override
  String get usePrevious => 'গতবারের সংখ্যা ব্যবহার করো';

  @override
  String get skipShort => 'বাদ দাও';

  @override
  String get moveUp => 'উপরে সরাও';

  @override
  String get moveDown => 'নিচে সরাও';

  @override
  String get widgetNutritionOff => 'এই উইজেট ব্যবহার করতে সেটিংস › বেটা-তে পুষ্টি চালু করো।';

  @override
  String get widgetPickShake => 'তোমার শেক বেছে নাও';

  @override
  String get heatRangeSetting => 'অ্যাক্টিভিটি ক্যালেন্ডার';

  @override
  String get heatRangeWeeks => '12 সপ্তাহ';

  @override
  String get heatRangeYear => '12 মাস';

  @override
  String get heatRangeHint =>
      '12 মাস পুরো বছর দেখায়। পেছনে যেতে পাশে সোয়াইপ করো, একদম প্রথম ওয়ার্কআউট পর্যন্ত।';

  @override
  String get pdfPlan => 'প্ল্যান PDF হিসেবে';

  @override
  String get pdfPlanHint =>
      'তোমার সপ্তাহ আর প্রতিটা রুটিন নিয়ে একটা পরিষ্কার পাতা, প্রিন্ট বা পাঠানোর জন্য তৈরি।';

  @override
  String get pdfExport => 'PDF হিসেবে এক্সপোর্ট করো';

  @override
  String get pdfFooter => 'বিনামূল্যে, ওপেন সোর্স আর অফলাইন';

  @override
  String get shakeTag => 'এটা একটা শেক';

  @override
  String get shakeTagHint => 'এটা তোমার শেক-এ দেখা যায়';

  @override
  String get shakeNone => 'তোমার শেকগুলো চিহ্নিত করো, এখানে শুধু সেগুলোই দেখা যাবে।';

  @override
  String get shakeMarkLabel => 'শেক হিসেবে চিহ্নিত করো';

  @override
  String get shakeNew => 'নতুন শেক';

  @override
  String get shakeUntag => 'শেক নয়';

  @override
  String get pdfKicker => 'ট্রেনিং প্ল্যান';

  @override
  String get pdfStatDays => 'দিন / সপ্তাহ';

  @override
  String get pdfStatMinutes => 'মিনিট / ওয়ার্কআউট';

  @override
  String pdfMinutes(int n) {
    return '≈ $n মিনিট';
  }

  @override
  String get workoutNotesTitle => 'ব্যায়ামের নোট';

  @override
  String get workoutNoteEvery => 'প্রতিবার';

  @override
  String get workoutNoteNext => 'পরেরবার';

  @override
  String get workoutNoteEveryHint => 'প্রতিবার এই ব্যায়াম করলে দেখা যায়। সিট বা পুলির সেটিংয়ের জন্য ভালো।';

  @override
  String get workoutNoteNextHint => 'শুধু পরেরবার দেখা যায়, তারপর চলে যায়।';

  @override
  String workoutNoteFromLast(String date) {
    return 'গতবার থেকে · $date';
  }

  @override
  String get workoutNoteHint => 'সিট গর্ত 2-এ, পুলি 19-এ…';

  @override
  String get notePinWorkout => 'ওয়ার্কআউটের সময় দেখাও';

  @override
  String get assistedSetting => 'সহায়ক মেশিন';

  @override
  String get assistedSettingHint =>
      'ওজন তোমাকে সাহায্য করে, তাই কম মানে ভালো: তোমার রেকর্ড আর পরামর্শ নিচে নামে।';

  @override
  String get assistedRecordHint => 'সবচেয়ে কম সাহায্য';

  @override
  String get trainAgainLabel => 'এখনও ট্রেনিং হয়নি? আবার মনে করিয়ে দাও';

  @override
  String get trainAgainOff => 'না';

  @override
  String trainAgainAfter(int n) {
    return '+$n ঘ';
  }

  @override
  String get trainAgainHint => 'শুধু একবার, আর শুধু যদি সেদিন কোনো ওয়ার্কআউট লেখা না থাকে।';

  @override
  String get notifTrainAgainBody => 'আজ ট্রেনিংয়ের এখনও সময় আছে।';

  @override
  String nextDeload(int n) {
    return 'হালকা: টানা $nটি ওয়ার্কআউটে সব রেপ হয়নি';
  }

  @override
  String get historyTitle => 'ইতিহাস';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ওয়ার্কআউট',
      one: '1টি ওয়ার্কআউট',
    );
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'এই মাসে কোনো ওয়ার্কআউট নেই';

  @override
  String get historyEmptyHint => 'অন্য মাস দেখতে পাশে সোয়াইপ করো বা তীর ব্যবহার করো।';

  @override
  String historyMore(int n) {
    return '+$n আরও';
  }

  @override
  String get stopwatch => 'স্টপওয়াচ';

  @override
  String get proteinSource => 'প্রোটিনের উৎস';

  @override
  String get proteinMixedShort => 'মিশ্র';

  @override
  String get kcalActive => 'সক্রিয়';

  @override
  String get kcalEstimated => 'আনুমানিক';

  @override
  String get kcalYours => 'তোমার মান';

  @override
  String kcalTotalRest(String value) {
    return 'মোট $value, বিশ্রামে পোড়া ক্যালরিসহ';
  }

  @override
  String get inclineLabel => 'ঢাল';

  @override
  String get kcalUseOwn => 'আমার মান ব্যবহার করো';

  @override
  String get kcalBackToEstimate => 'অনুমানে ফেরো';

  @override
  String get kcalNeedsData => 'ক্যালরি অনুমান করতে দূরত্ব আর সময় যোগ করো';

  @override
  String get kcalHowEstimated => 'দূরত্ব, সময়, ঢাল আর তোমার ওজন থেকে অনুমান (ACSM সূত্র)।';

  @override
  String get kcalOwnTitle => 'সক্রিয় ক্যালরি';

  @override
  String get planMine => 'আমার প্ল্যান';

  @override
  String get planNew => 'নতুন প্ল্যান';

  @override
  String get planSaveWeek => 'এই সপ্তাহ সেভ করো';

  @override
  String get planSaveWeekHint => 'বর্তমান সপ্তাহটা এমন প্ল্যান হিসেবে রাখো যাতে ফিরে আসতে পারো';

  @override
  String get planEmptyWeek => 'খালি সপ্তাহ শুরু করো';

  @override
  String get planEmptyWeekHint => 'তোমার বর্তমান সপ্তাহ প্ল্যান হিসেবে সেভ থাকবে';

  @override
  String get planName => 'প্ল্যানের নাম';

  @override
  String get planRename => 'নাম বদলাও';

  @override
  String get planDelete => 'প্ল্যান মুছে ফেলো';

  @override
  String get plansHint => 'সপ্তাহের পরিবর্তন বেছে নেওয়া প্ল্যানে সেভ হয়';

  @override
  String get progression => 'প্রোগ্রেশন';

  @override
  String get progManual => 'হাতে';

  @override
  String get progManualHint => 'কোনো পরামর্শ নেই: প্রতিটা ওজন তুমি বেছে নাও।';

  @override
  String get progLinear => 'লিনিয়ার';

  @override
  String get progLinearHint => 'সব রেপ হলে ওজন বাড়ে।';

  @override
  String get progDouble => 'ডাবল প্রোগ্রেশন';

  @override
  String get progDoubleHint => 'পরিসরের উপর পর্যন্ত রেপ বাড়াও, তারপর ওজন।';

  @override
  String get progVolume => 'রেপ, সেট আর ওজন';

  @override
  String get progVolumeHint => 'উপর পর্যন্ত রেপ, তারপর আরও একটা সেট, তারপর বেশি ওজন।';

  @override
  String get progAmrap => 'শেষ সেট পুরো জোরে';

  @override
  String get progAmrapHint => 'শেষ সেট: যত রেপ পারো। লক্ষ্যের দ্বিগুণ হলে দুবার লাফ দেয়।';

  @override
  String get progStep => 'ওজনের লাফ';

  @override
  String get progRange => 'রেপের পরিসর';

  @override
  String get progSets => 'সেট';

  @override
  String get progDeload => 'এর পরে হালকা';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nটি ব্যর্থতা', one: '1টি ব্যর্থতা');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'এতটা হালকা করো';

  @override
  String get progApply => 'পরের ওয়ার্কআউট ভরো';

  @override
  String get progApplyHint => 'বন্ধ থাকলে শুধু পরামর্শ হিসেবে দেখা যায়।';

  @override
  String get nextMoreReps => 'একই ওজন, আরও একটা রেপ';

  @override
  String get nextAddSet => 'আরও একটা সেট';

  @override
  String get nextAmrap => 'শেষ সেট: যত পারো';

  @override
  String fillDay(String amount) {
    return 'তোমার দিন পূরণ করো · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'তোমার $kcal বাকি থাকবে';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'তোমার $kcal আর $grams গ্রা প্রোটিন বাকি থাকবে';
  }

  @override
  String leftAfterOver(String kcal) {
    return 'লক্ষ্যের চেয়ে $kcal বেশি';
  }

  @override
  String perDayUnit(String unit) {
    return 'দিনে $unit';
  }

  @override
  String get byZone => 'অংশ অনুযায়ী';

  @override
  String get importAlreadyHave => 'এই রুটিনগুলো আগেই তোমার আছে। কপি হিসেবে আবার যোগ করতে পারো।';

  @override
  String get importAsCopy => 'কপি হিসেবে যোগ করো';

  @override
  String get importOwned => 'আগেই তোমার';

  @override
  String get setDuplicated => 'সেটের কপি হয়েছে';

  @override
  String get setTypeCluster => 'ক্লাস্টার';

  @override
  String get setTypeClusterInfo => 'একটা সেট ছোট ছোট খণ্ডে ভাগ, মাঝে 15–30 সেকেন্ড। মোট রেপ লেখো।';

  @override
  String timesBodyweight(String value) {
    return 'তোমার ওজনের $value×';
  }

  @override
  String get archiveRoutine => 'রুটিন আর্কাইভ করো';

  @override
  String get routineArchived => 'রুটিন আর্কাইভ হয়েছে';

  @override
  String get archivedRoutines => 'আর্কাইভ';

  @override
  String get autoBackup => 'অটো ব্যাকআপ';

  @override
  String get autoBackupHint =>
      'তোমার সব ডেটা নিয়ে একটা ZIP তোমার বেছে নেওয়া ফোল্ডারে সেভ করে। ফোনের বাইরে কপি রাখতে Nextcloud, Syncthing বা যেকোনো সিঙ্ক অ্যাপ সেই ফোল্ডারে লাগাও।';

  @override
  String get autoBackupFolder => 'ফোল্ডার বেছে নাও';

  @override
  String get autoBackupNoFolder => 'এখনও ফোল্ডার নেই';

  @override
  String get autoBackupOff => 'বন্ধ';

  @override
  String get autoBackupWorkout => 'প্রতিটা ওয়ার্কআউটের পরে';

  @override
  String get autoBackupDaily => 'দিনে একবার';

  @override
  String get autoBackupWeekly => 'সপ্তাহে একবার';

  @override
  String get autoBackupOnLeave => 'অ্যাপ থেকে বেরোলে';

  @override
  String get autoBackupKeep => 'কয়টা কপি রাখবে';

  @override
  String get autoBackupNow => 'এখনই ব্যাকআপ নাও';

  @override
  String autoBackupLast(String when) {
    return 'শেষ ব্যাকআপ $when';
  }

  @override
  String get autoBackupNever => 'এখনও কোনো ব্যাকআপ নেই';

  @override
  String get autoBackupLost => 'শেষ ব্যাকআপ সেভ করা যায়নি। ফোল্ডারটা আবার বেছে নাও।';

  @override
  String get autoBackupSaved => 'ব্যাকআপ সেভ হয়েছে';

  @override
  String get prepPortions => 'ভাগ';

  @override
  String get rotationAddRest => 'একটা বিশ্রামের দিন যোগ করো';

  @override
  String get rotationRestHint => 'পরের দিন নিজে থেকেই এগিয়ে যায়';

  @override
  String get rotationRestToday => 'আজ';

  @override
  String get rotationSkipRest => 'এই বিশ্রামের দিন বাদ দাও';

  @override
  String rotationRestUpNext(String name) {
    return 'এরপর: $name';
  }

  @override
  String get trainAnyway => 'তবুও ট্রেনিং করো';

  @override
  String get healthTitle => 'স্বাস্থ্য';

  @override
  String get healthSetting => 'স্বাস্থ্যের ডেটা';

  @override
  String get healthSettingHint => 'অগ্রগতিতে Health Connect-এর ডেটা';

  @override
  String get healthPickTitle => 'স্বাস্থ্যের ডেটা';

  @override
  String get healthPickHint =>
      'Health Connect থেকে কী আনবে বেছে নাও। Android প্রতিটার জন্য একবার জিজ্ঞেস করে। এটা শুধু পড়া হয়, আর কখনো ফোন ছাড়ে না।';

  @override
  String get healthGroupHeart => 'হৃদয়';

  @override
  String get healthGroupVitals => 'প্রাণচিহ্ন';

  @override
  String get healthGroupActivity => 'অ্যাক্টিভিটি';

  @override
  String get healthRestingHr => 'বিশ্রামের হৃৎস্পন্দন';

  @override
  String get healthHeartRate => 'গড় হৃৎস্পন্দন';

  @override
  String get healthHrv => 'হৃৎস্পন্দনের পরিবর্তনশীলতা';

  @override
  String get healthSpo2 => 'রক্তে অক্সিজেন';

  @override
  String get healthRespiration => 'শ্বাসের হার';

  @override
  String get healthBloodPressure => 'রক্তচাপ';

  @override
  String get healthTemperature => 'শরীরের তাপমাত্রা';

  @override
  String get healthSleep => 'ঘুম';

  @override
  String get healthDistance => 'দূরত্ব';

  @override
  String get healthFloors => 'ওঠা তলা';

  @override
  String get healthElevation => 'ওঠা উচ্চতা';

  @override
  String get healthActiveKcal => 'সক্রিয় ক্যালরি';

  @override
  String get healthNoData => 'এখনও ডেটা নেই';

  @override
  String get healthReadFailed => 'পড়া গেল না';

  @override
  String get healthAllow => 'অনুমতি দিতে ট্যাপ করো';

  @override
  String get healthLast7 => 'শেষ 7 দিন';

  @override
  String get healthAvg30 => '30 দিনের গড়';

  @override
  String get healthLow => 'সর্বনিম্ন';

  @override
  String get healthHigh => 'সর্বোচ্চ';

  @override
  String get healthFrom => 'Health Connect থেকে · শেষ 30 দিন';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'শ্বাস/মিনিট';

  @override
  String get weekTab => 'সপ্তাহ';

  @override
  String get muscleSetsList => 'প্রতি পেশির সেট';

  @override
  String get fatTrans => 'ট্রান্স';

  @override
  String get fatTypesHint => 'ঐচ্ছিক। লেবেলে যা লেখা নেই তা খালি রাখো।';

  @override
  String get sessionPhotos => 'ওয়ার্কআউটের ছবি';

  @override
  String get sessionPhotosAdd => 'ছবি যোগ করো';

  @override
  String get sessionPhotosHint => 'এগুলো তোমার ছবিতেও রাখা হয়।';

  @override
  String get ladderTitle => 'প্রোগ্রেশন';

  @override
  String get ladderHint =>
      'ধাপগুলো সবচেয়ে সহজ থেকে সবচেয়ে কঠিন ক্রমে সাজাও। টানা দুই সেশনে 8-এর 3 সেট করলে (ধীরগুলোতে 5), GymMane পরের ধাপ প্রস্তাব করবে।';

  @override
  String get ladderBuiltIn =>
      'অ্যাপের প্রোগ্রেশন থেকে শুরু হয়। ধাপ যোগ করো, সরাও বা ক্রম বদলাও, তাহলে এটা এই রুটিনের নিজের হয়ে যাবে।';

  @override
  String get ladderNone => 'এখনও নেই। বানাতে ট্যাপ করো।';

  @override
  String ladderStep(int n, int total) {
    return 'ধাপ $n / $total';
  }

  @override
  String get ladderAdd => 'ধাপ যোগ করো';

  @override
  String get ladderInRoutine => 'রুটিনে';

  @override
  String get ladderClear => 'অ্যাপের প্রোগ্রেশন ব্যবহার করো';

  @override
  String get ladderPick => 'একটা ধাপ বেছে নাও';

  @override
  String get periodWeek => 'এই সপ্তাহে';

  @override
  String get periodMonth => 'এই মাসে';

  @override
  String get periodYear => 'এই বছরে';

  @override
  String get periodAll => 'সব মিলিয়ে';

  @override
  String get settingsSearch => 'সেটিংস খোঁজো';

  @override
  String get settingsNoResults => 'এই নামে কোনো সেটিং নেই';

  @override
  String get settingsGroupApp => 'তোমার অ্যাপ';

  @override
  String get settingsGroupHome => 'হোম আর বাড়তি';

  @override
  String get settingsGroupData => 'ডেটা আর সাহায্য';

  @override
  String get healthAllowAll => 'সব চালু করো';

  @override
  String get healthSeeAll => 'সব দেখো';

  @override
  String get healthPinTitle => 'কার্ডে';

  @override
  String get healthPinHint => 'অগ্রগতি কার্ডের জন্য 3টি পর্যন্ত বেছে নাও।';

  @override
  String get blurSetting => 'ব্লার ইফেক্ট';

  @override
  String get blurSettingHint => 'ফোন ধীর মনে হলে বন্ধ করো';

  @override
  String get lowEndTitle => 'তোমার ফোনে মেমরি কম';

  @override
  String get lowEndBody => 'ব্লার বন্ধ করলে এতে সবকিছু আরও মসৃণ চলে। সেটিংস → সাধারণ-এ আবার চালু করতে পারো।';

  @override
  String get lowEndOff => 'ব্লার বন্ধ করো';

  @override
  String get lowEndKeep => 'রেখে দাও';

  @override
  String get momentsThisMonth => 'এই মাস';

  @override
  String get momentsDays => 'ছবিওয়ালা দিন';

  @override
  String get awardsPick => 'তোমার প্রোফাইলের জন্য বেছে নাও';

  @override
  String get awardsPickHint => 'প্রোফাইলে যেগুলো চাও সেগুলোতে ট্যাপ করো';

  @override
  String get gymPassPicture => 'কোডের ছবি সেভ করো';

  @override
  String get gymPassPictureHint => 'যে কোড অ্যাপ পড়তে পারে না তার জন্য: তোমার ছবি পুরো উজ্জ্বলতায় দেখায়';

  @override
  String get gymPassPictureFormat => 'ছবি';

  @override
  String get gymPassUsePicture => 'ছবিটা সেভ করো';

  @override
  String get gymPassChangePicture => 'ছবিটা বদলাও';

  @override
  String get cropTitle => 'কোডটা কাটো';

  @override
  String get cropHint => 'কোণগুলো টানো যাতে ভেতরে শুধু কোড থাকে';

  @override
  String get rotatePhoto => 'ঘোরাও';

  @override
  String get cardioNoSets => 'কার্ডিও প্রতি পেশির সাপ্তাহিক সেটে যোগ হয় না';

  @override
  String get countsAsWater => 'পানি হিসেবে গোনা হয়';

  @override
  String get countsAsWaterHint => 'পানিতে বানানো শেকের জন্য: লিখলে তোমার পানিতেও যোগ হয়';

  @override
  String get waterPerServing => 'প্রতি পরিবেশনে পানি';

  @override
  String get estOneRm => 'আনু. 1RM';

  @override
  String get newInWorkout => 'এই ওয়ার্কআউটে নতুন';

  @override
  String newInWorkoutHint(String routine) {
    return 'এইমাত্র করা সেটসহ এটা $routine-এ যোগ করো। রুটিনের বাকিটা যেমন আছে তেমনই থাকবে।';
  }

  @override
  String get addedToRoutine => 'যোগ হয়েছে';

  @override
  String get addShort => 'যোগ করো';

  @override
  String get allTimeLifted => 'তোলা';

  @override
  String get pctBodyweight => '% শরীরের ওজন';

  @override
  String get ofBodyweight => 'তোমার শরীরের ওজনের';

  @override
  String get recoveryStateMid => 'রিকভার হচ্ছে';

  @override
  String get recoveryStateReady => 'তৈরি';

  @override
  String recoveringIn(String time) {
    return '$time-এ রিকভার';
  }

  @override
  String readyIn(String time) {
    return '$time-এ তৈরি';
  }

  @override
  String get recoveryReadyNow => 'আবার ট্রেন করার জন্য তৈরি';

  @override
  String get restAfterThisSet => 'এই সেটের পরে বিশ্রাম';

  @override
  String restUsual(String time) {
    return 'সাধারণত: $time';
  }

  @override
  String get restJustToday => 'শুধু এই সেটের জন্য, আজ';

  @override
  String get restUseUsual => 'সাধারণ বিশ্রামে ফেরো';

  @override
  String get restChange => 'বদলাও';

  @override
  String get noRestTimer => 'টাইমার নেই';

  @override
  String get sessionMuscles => 'এই ওয়ার্কআউটের পেশি';

  @override
  String get sessionMusclesHint =>
      'হালকা মানে এখনও বাকি, উজ্জ্বল মানে শেষ। প্রতি পেশির সেট, সহায়কগুলো অর্ধেক গোনা হয়।';

  @override
  String get miniBodySetting => 'রুটিনে ছোট শরীরের মানচিত্র';

  @override
  String get miniBodySettingHint => 'প্রতিটা রুটিন কোন পেশিতে কাজ করে';

  @override
  String get balanceTitle => 'শক্তির ভারসাম্য';

  @override
  String get balanceWhy => 'কীভাবে কাজ করে';

  @override
  String get balanceGood => 'তোমার প্রধান লিফটগুলো ভারসাম্যে আছে';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift পিছিয়ে: সমান হতে প্রায় $gap';
  }

  @override
  String get balanceHint =>
      'শেষ 4 মাসের তোমার আনুমানিক 1RM ক্লাসিক অনুপাতের সাথে তুলনা করে: স্কোয়াট 100%, ডেডলিফট 120%, বেঞ্চ 75%, রো 52%, ওভারহেড প্রেস 45%। যে লিফট বাকিগুলোর চেয়ে অনেক নিচে, সেটা সাধারণত দুর্বল জায়গা যেখানে আরও কাজ দরকার।';

  @override
  String get balanceEven => 'ভারসাম্যে';

  @override
  String get balanceBehindShort => 'পিছিয়ে';

  @override
  String get balanceAheadShort => 'এগিয়ে';

  @override
  String get holdProgress => 'সময় দিয়ে অগ্রগতি';

  @override
  String get holdProgressHint => 'প্রতিটা সেট ধরে রাখতে পারলে সেকেন্ড যোগ করে';

  @override
  String holdProgressOn(int s) {
    return 'প্রতিটা সেট ধরে রাখলে প্রতিবার +$s সে';
  }

  @override
  String get paceTitle => 'সাপ্তাহিক হার';

  @override
  String get paceOn => 'হার ঠিক আছে';

  @override
  String get paceTooFast => 'তোমার ঠিক করা পরিসরের চেয়ে দ্রুত';

  @override
  String get paceTooSlow => 'তোমার ঠিক করা পরিসরের চেয়ে ধীর';

  @override
  String get paceWrongWay => 'উল্টো দিকে যাচ্ছে';

  @override
  String get paceDrifting => 'ধরে রাখার সীমার চেয়ে বেশি বদলাচ্ছে';

  @override
  String get paceSetAim => 'তোমার লক্ষ্য ঠিক করতে ট্যাপ করো';

  @override
  String get paceBasis => 'শেষ 3 সপ্তাহের ওজনের প্রবণতা, তাই এক রাতের নোনতা খাবার একে বোকা বানাতে পারে না।';

  @override
  String get paceAimTitle => 'তোমার লক্ষ্য কী?';

  @override
  String get paceAimHint => 'কার্ড বলে দেয় তোমার সাপ্তাহিক হার এর সাথে মেলে কি না';

  @override
  String get paceLose => 'কমানো';

  @override
  String get paceHold => 'ধরে রাখা';

  @override
  String get paceGain => 'বাড়ানো';

  @override
  String get paceAuto => 'স্বয়ংক্রিয়';

  @override
  String get paceLoseRange => 'সপ্তাহে ওজনের 0.5 থেকে 1%';

  @override
  String get paceHoldRange => 'সপ্তাহে 0.25%-এর মধ্যে';

  @override
  String get paceGainRange => 'সপ্তাহে ওজনের 0.25 থেকে 0.5%';

  @override
  String get paceAutoHint => 'তোমার লক্ষ্য ওজন থেকে';

  @override
  String get weekShort => 'সপ্তাহ';

  @override
  String get weightStack => 'ওজনের স্ট্যাক';

  @override
  String get weightStackHint =>
      'এই মেশিনে সত্যিই যে ওজনগুলো আছে। + আর − বোতাম, প্রোগ্রেশন আর ডিলোড শুধু এগুলোতেই পড়ে।';

  @override
  String get weightStackOff => 'বন্ধ: সাধারণ ওজনের ধাপ';

  @override
  String get stackFrom => 'থেকে';

  @override
  String get stackTo => 'পর্যন্ত';

  @override
  String get stackEvery => 'প্রতি';

  @override
  String get stackFill => 'স্ট্যাক ভরো';

  @override
  String get stackTapToFix => 'কোনো অদ্ভুত ওজন ঠিক করতে বা সরাতে তাতে ট্যাপ করো।';

  @override
  String get stackAddWeight => 'ওজন যোগ করো';

  @override
  String get stackEditWeight => 'পিনের ওজন';

  @override
  String get stackClear => 'স্ট্যাক সরাও';

  @override
  String stackCount(int n) {
    return '$nটি ওজন';
  }

  @override
  String get healthLinksTitle => 'তোমার ওয়ার্কআউটের সাথে';

  @override
  String get healthLinkHeart => 'ঘড়ি থেকে হৃৎস্পন্দন';

  @override
  String get healthLinkHeartHint => 'প্রতিটা ওয়ার্কআউটের গড় আর সর্বোচ্চ হৃৎস্পন্দন, যে ঘড়িই রেকর্ড করুক';

  @override
  String get healthLinkWeight => 'অন্য অ্যাপ থেকে ওজন';

  @override
  String get healthLinkWeightHint => 'শেষ 30 দিনের তোমার স্কেলের ওজন। তোমার টাইপ করা কখনো বদলায় না।';

  @override
  String get healthLinkDenied => 'Health Connect অনুমতি দেয়নি';

  @override
  String get healthOpenSettings => 'খোলো';

  @override
  String hrMaxShort(int bpm) {
    return 'সর্বোচ্চ $bpm';
  }

  @override
  String get setNote => 'এই সেটের নোট';

  @override
  String get setNoteHint => 'গ্রিপ, ব্যথা, কাজে লাগা কোনো টিপ…';

  @override
  String setNoteLast(String note) {
    return 'গতবার: $note';
  }

  @override
  String get lastTimeNotes => 'গতবার';

  @override
  String setNoteLine(int n, String note) {
    return 'সেট $n · $note';
  }

  @override
  String get newMeasure => 'নতুন মাপ';

  @override
  String get newMeasureHint => 'যা অনুসরণ করতে চাও: কব্জি, বিশ্রামের নাড়ি, শরীরের পানি…';

  @override
  String get measureKindLength => 'দৈর্ঘ্য';

  @override
  String get measureKindLengthHint => 'সেমি বা ইঞ্চিতে, বাকিগুলোর মতো';

  @override
  String get measureKindOther => 'অন্যান্য';

  @override
  String get measureKindOtherHint => 'নিজের এককে';

  @override
  String get measureUnit => 'একক';

  @override
  String get measureUnitHint => 'মিমি, bpm, কেজি…';

  @override
  String get measureNameHint => 'কব্জি, বিশ্রামের নাড়ি…';

  @override
  String get measureRename => 'নাম বদলাও';

  @override
  String measureDeleteTitle(String name) {
    return '$name মুছবে?';
  }

  @override
  String get measureDeleteBody => 'এর জন্য লেখা প্রতিটা মানও চলে যাবে।';

  @override
  String get measureDelete => 'এই মাপ মুছে ফেলো';

  @override
  String get measureEvery => 'মাপার কথা মনে করিয়ে দাও';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n দিন পরে',
      one: 'আগামীকাল',
      zero: 'আজ',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'মাপার সময়';

  @override
  String get notifMeasureChannel => 'শরীরের মাপ';

  @override
  String get notifMeasureChannelWhy => 'আবার মাপার সময় হলে মনে করিয়ে দেয়।';

  @override
  String get notifMeasureTitle => 'মাপার সময়';

  @override
  String notifMeasureBody(int n) {
    return 'গতবারের পর $n দিন। একই জায়গা, দিনের একই সময়।';
  }

  @override
  String get healthLinkWrite => 'তোমার ওয়ার্কআউট সেভ করো';

  @override
  String get healthLinkWriteHint =>
      'প্রতিটা শেষ করা ওয়ার্কআউট তার সময় আর ধরনসহ Health Connect-এ যায়, যাতে অন্য অ্যাপও গোনে। শেষ 30 দিনও পাঠায়।';

  @override
  String get healthWorkoutTitle => 'ওয়ার্কআউট';

  @override
  String get circuits => 'সময় ধরা সার্কিট';

  @override
  String get circuitsHint => 'ঘড়ি ধরে কাজ আর বিশ্রাম, রাউন্ডের পর রাউন্ড';

  @override
  String get newCircuit => 'নতুন সার্কিট';

  @override
  String get editCircuit => 'সার্কিট বদলাও';

  @override
  String get circuitDefaultName => 'সার্কিট';

  @override
  String get circuitNameHint => 'নাম, যেমন কোর ফিনিশার';

  @override
  String get circuitRounds => 'রাউন্ড';

  @override
  String get circuitRoundRest => 'রাউন্ডের মাঝে বিশ্রাম';

  @override
  String get circuitWork => 'কাজ';

  @override
  String get circuitRest => 'বিশ্রাম';

  @override
  String get circuitAdd => 'ব্যায়াম যোগ করো';

  @override
  String get circuitEmpty =>
      'যে ক্রমে করবে সেই ক্রমে ব্যায়াম যোগ করো। একটা দুবারও রাখতে পারো, যেমন প্রতি পাশের জন্য সাইড প্ল্যাঙ্ক।';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      steps,
      locale: localeName,
      other: '$stepsটি ব্যায়াম',
      one: '1টি ব্যায়াম',
    );
    String _temp1 = intl.Intl.pluralLogic(
      rounds,
      locale: localeName,
      other: '$rounds রাউন্ড',
      one: '1 রাউন্ড',
    );
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'শুরু';

  @override
  String get circuitGetReady => 'তৈরি হও';

  @override
  String circuitRoundOf(int n, int total) {
    return 'রাউন্ড $n / $total';
  }

  @override
  String circuitNext(String name) {
    return 'এরপর: $name';
  }

  @override
  String get circuitFinishLine => 'এটাই শেষ, তারপর শেষ';

  @override
  String get circuitDone => 'সার্কিট শেষ';

  @override
  String circuitDoneBody(String time) {
    return '$time · তোমার ইতিহাসে সেভ হয়েছে';
  }

  @override
  String get circuitStopTitle => 'সার্কিট থামাবে?';

  @override
  String get circuitStopBody => 'এখন পর্যন্ত যা করেছ তা তোমার ইতিহাসে সেভ হবে।';

  @override
  String get circuitStop => 'থামাও';

  @override
  String get circuitKeepGoing => 'চালিয়ে যাও';

  @override
  String circuitDeleteTitle(String name) {
    return '$name মুছবে?';
  }

  @override
  String get circuitDeleteBody => 'এটা দিয়ে করা ওয়ার্কআউটগুলো তোমার ইতিহাসে থেকে যাবে।';

  @override
  String get circuitPickExercise => 'একটা ব্যায়াম বেছে নাও';

  @override
  String get circuitNoSteps => 'অন্তত একটা ব্যায়াম যোগ করো';

  @override
  String get circuitPrevious => 'আগের';

  @override
  String get circuitUpNext => 'এরপর';

  @override
  String get foodGroupNew => 'নতুন বিভাগ';

  @override
  String get foodGroupHint => 'তৈরি খাবার, হিমায়িত…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি খাবার',
      one: '1টি খাবার',
      zero: 'এখনও কোনো খাবার নেই',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return '$name মুছবে?';
  }

  @override
  String get foodGroupDeleteBody => 'তোমার খাবারগুলো থাকবে, শুধু এই বিভাগ ছাড়া।';

  @override
  String onbHello(String name) {
    return 'হাই, $name';
  }

  @override
  String get onbPlaceHero => 'যে ব্যায়ামগুলো করতে পারো';

  @override
  String get settingsRests => 'বিশ্রাম';

  @override
  String get settingsDuring => 'ট্রেনিংয়ের সময়';

  @override
  String get settingsLook => 'দেখতে কেমন';

  @override
  String get importCardTitle => 'তোমার ওয়ার্কআউট এখানে আনো';

  @override
  String get importCardBody => 'Hevy, Strong, FitNotes আর আরও থেকে';

  @override
  String get checkInTitle => 'আজ কেমন ছিলে?';

  @override
  String get checkInSleep => 'ঘুম';

  @override
  String get checkInEnergy => 'শক্তি';

  @override
  String get checkInSkip => 'ঐচ্ছিক';

  @override
  String get checkInLevel1 => 'খুব খারাপ';

  @override
  String get checkInLevel2 => 'খারাপ';

  @override
  String get checkInLevel3 => 'চলনসই';

  @override
  String get checkInLevel4 => 'ভালো';

  @override
  String get checkInLevel5 => 'দারুণ';

  @override
  String get checkInSetting => 'ঘুম আর শক্তি';

  @override
  String get checkInSettingHint => 'ওয়ার্কআউট শেষ করলে জিজ্ঞেস করে';

  @override
  String get readinessTitle => 'ঘুম আর শক্তি';

  @override
  String get readinessWaiting => 'তোমার ওয়ার্কআউটগুলো রেট করতে থাকো';

  @override
  String get readinessWaitingHint => 'কয়েকটা ভালো আর খারাপ দিনের পর দেখবে এগুলো তোমার লিফট কীভাবে বদলায়।';

  @override
  String readinessSleepLess(int n) {
    return 'কম ঘুমের দিনে তুমি $n% কম তোলো';
  }

  @override
  String readinessSleepMore(int n) {
    return 'মজার ব্যাপার: কম ঘুমের দিনে তুমি $n% বেশি তোলো';
  }

  @override
  String get readinessSleepNone => 'ঘুমে তোমার লিফট প্রায় বদলায় না';

  @override
  String readinessEnergyLess(int n) {
    return 'কম শক্তির দিনে তুমি $n% কম তোলো';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'কম শক্তির দিনেও তুমি $n% বেশি তোলো';
  }

  @override
  String get readinessEnergyNone => 'তোমার শক্তিতে লিফট প্রায় বদলায় না';

  @override
  String get readinessHint => 'প্রতিটা আনুমানিক 1RM আগের 90 দিনের তোমার সেরার সাথে তুলনা করে।';

  @override
  String get readinessLast30 => 'শেষ 30 দিনের গড়';

  @override
  String get kindSport => 'খেলা';

  @override
  String get clearWorkouts => 'শুধু ওয়ার্কআউট মুছে ফেলো';

  @override
  String get clearWorkoutsNone => 'মোছার মতো কোনো ওয়ার্কআউট নেই';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ওয়ার্কআউট মুছবে?',
      one: '1টি ওয়ার্কআউট মুছবে?',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'তোমার ইতিহাস, রেকর্ড আর মেডেল চলে যাবে। রুটিন, ব্যায়াম, ছবি, মাপ, পুষ্টি আর সেটিংস থাকবে। পরে ফেরত চাইতে পারো মনে হলে আগে একটা ব্যাকআপ এক্সপোর্ট করো।';

  @override
  String get clearWorkoutsConfirm => 'ওয়ার্কআউট মুছে ফেলো';

  @override
  String get clearWorkoutsDone => 'ওয়ার্কআউট মুছে ফেলা হয়েছে';

  @override
  String get reportTitle => 'রিপোর্ট';

  @override
  String get reportHint => 'তারিখ বেছে নাও আর PDF বা CSV হিসেবে শেয়ার করো';

  @override
  String get reportCustom => 'অন্যান্য';

  @override
  String get reportPickRange => 'তারিখ বেছে নাও';

  @override
  String get reportEmpty => 'এই তারিখগুলোর মধ্যে কিছু লেখা নেই।';

  @override
  String get reportKicker => 'ট্রেনিং রিপোর্ট';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n দিন', one: '1 দিন');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'ওয়ার্কআউট';

  @override
  String get reportPerWeek => 'প্রতি সপ্তাহে';

  @override
  String get reportHours => 'ঘণ্টা';

  @override
  String get reportVsPrev => 'শতাংশের তুলনা ঠিক আগের সমান সংখ্যক দিনের সাথে।';

  @override
  String get reportRecords => 'নতুন রেকর্ড';

  @override
  String get reportLifts => 'ব্যায়াম';

  @override
  String get reportSessionsCol => 'দিন';

  @override
  String get reportBestCol => 'সেরা 1RM';

  @override
  String get reportChangeCol => 'পরিবর্তন';

  @override
  String get reportBestHint =>
      'সেরা 1RM তোমার সেট থেকে অনুমান করা। পরিবর্তন এই রিপোর্টে ব্যায়ামের প্রথম আর শেষ দিনের তুলনা করে।';

  @override
  String get reportMuscles => 'প্রতি পেশির সেট';

  @override
  String get reportBody => 'শরীর আর রিকভারি';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'পুষ্টি · $n দিনের গড়',
      one: 'পুষ্টি · 1 দিনের গড়',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি নতুন রেকর্ড',
      one: '1টি নতুন রেকর্ড',
    );
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nটি ব্যায়াম', one: '1টি ব্যায়াম');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return 'দিনে $kcal আর $protein গ্রা প্রোটিন · $days দিন লেখা';
  }

  @override
  String get reportSharePdf => 'PDF শেয়ার করো';

  @override
  String get reportShareCsv => 'CSV এক্সপোর্ট করো';

  @override
  String get reportShareCsvBoth => 'CSV এক্সপোর্ট করো (ওয়ার্কআউট আর পুষ্টি)';

  @override
  String fastMinutes(int n) {
    return '$n মিনিট';
  }

  @override
  String fastHours(int n) {
    return '$n ঘ';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h ঘ $m মিনিট';
  }

  @override
  String get fastTracker => 'ইন্টারমিটেন্ট ফাস্টিং';

  @override
  String fastTitle(int fast, int eat) {
    return 'ফাস্টিং $fast:$eat';
  }

  @override
  String get fastOptions => 'ফাস্টিংয়ের বিকল্প';

  @override
  String get fastWindowOpen => 'খাওয়ার সময় খোলা';

  @override
  String get fastLeft => 'বাকি';

  @override
  String get fastDoneLabel => 'লক্ষ্য পূরণ';

  @override
  String get fastIdle => 'শেষ খাবারের পরে শুরু করো';

  @override
  String fastLast(String time) {
    return 'শেষ ফাস্টিং: $time';
  }

  @override
  String fastStreak(int n) {
    return 'টানা $n';
  }

  @override
  String fastReached(String time) {
    return 'লক্ষ্যের চেয়ে $time বেশি';
  }

  @override
  String fastEndsAt(String time) {
    return '$time-এ শেষ';
  }

  @override
  String fastSince(String time) {
    return '$time থেকে';
  }

  @override
  String get fastStartedAt => 'কখন ফাস্টিং শুরু করেছ?';

  @override
  String get fastStart => 'ফাস্টিং শুরু করো';

  @override
  String fastFromMeal(String time) {
    return '$time থেকে';
  }

  @override
  String get fastEnd => 'ফাস্টিং শেষ করো';

  @override
  String get fastCancel => 'এই ফাস্টিং বাতিল করো';

  @override
  String get fastPlan => 'ফাস্টিং প্ল্যান';

  @override
  String get fastPlanHint => 'ফাস্টিংয়ের ঘণ্টা : খাওয়ার ঘণ্টা';

  @override
  String get fastThisWeek => 'শেষ 7 দিন';

  @override
  String get fastCount => 'ফাস্টিং';

  @override
  String get fastReachedCount => 'পূরণ';

  @override
  String get fastAverage => 'গড়';

  @override
  String get fastHistory => 'সাম্প্রতিক ফাস্টিং';

  @override
  String get notifFastLiveChannel => 'ফাস্টিং চলছে';

  @override
  String get notifFastLiveChannelWhy => 'ফাস্টিংয়ের সময় একটা শান্ত কাউন্টডাউন।';

  @override
  String get notifFastChannel => 'ফাস্টিং';

  @override
  String get notifFastChannelWhy => 'ফাস্টিং শেষ হলে জানায়।';

  @override
  String get notifFastLiveTitle => 'ফাস্টিং';

  @override
  String notifFastLiveBody(String time) {
    return 'খাওয়ার সময় খুলবে $time-এ';
  }

  @override
  String get notifFastDoneTitle => 'ফাস্টিং শেষ';

  @override
  String notifFastDoneBody(int n) {
    return '$n ঘণ্টা। খাওয়ার সময় খোলা।';
  }

  @override
  String get newExerciseHint => 'শুধু নাম দরকার। বাকিটা সাহায্য করে, তবে পরে যোগ করতে পারো।';

  @override
  String get supportThanksTitle => 'এখানে থাকার জন্য ধন্যবাদ 🤍';

  @override
  String get supportThanksBody =>
      'GymMane বিনামূল্যে আর সবসময় তাই থাকবে, বিজ্ঞাপন ছাড়া আর কিছু লুকানো ছাড়া।\n\nএটা যদি তোমার ট্রেনিংয়ে কাজে লাগে, আমাকে একটা কফি খাওয়ালে আমার দিনটা ভালো হয়ে যাবে ☕\nআর না পারলে চিন্তা নেই: GitHub-এ একটা স্টারও অনেক ⭐';

  @override
  String get perfSetting => 'পারফরম্যান্স';

  @override
  String get perfSheetHint => 'GymMane তোমার ফোনের কতটা ব্যবহার করবে। নিচে প্রতিটা অংশ বদলাতে পারো।';

  @override
  String get perfLite => 'সাশ্রয়ী';

  @override
  String get perfLiteHint => 'ব্লার নেই আর শান্ত নড়াচড়া। যে ফোনগুলো হিমশিম খায় তাদের জন্য।';

  @override
  String get perfBalanced => 'ভারসাম্য';

  @override
  String get perfBalancedHint => 'ব্যাটারি না ফুরিয়ে ব্লার আর অ্যানিমেশন।';

  @override
  String get perfMax => 'সর্বোচ্চ';

  @override
  String perfMaxHint(int hz) {
    return 'আরও সূক্ষ্ম ব্লার আর $hz Hz স্ক্রিন। হাই-এন্ড ফোনের জন্য।';
  }

  @override
  String get perfMaxHintNoHz => 'সব জায়গায় আরও সূক্ষ্ম ব্লার। হাই-এন্ড ফোনের জন্য।';

  @override
  String get perfCustom => 'কাস্টম';

  @override
  String get perfTweak => 'সূক্ষ্ম সমন্বয়';

  @override
  String get perfFine => 'সূক্ষ্ম ব্লার';

  @override
  String get perfFineHint => 'প্যানেলের পেছনে নরম কিনারা আর আরও স্পষ্ট ব্যাকগ্রাউন্ড';

  @override
  String perfHz(int hz) {
    return '$hz Hz স্ক্রিন';
  }

  @override
  String get perfHzHint => 'সবকিছু আরও মসৃণ স্ক্রল হয়, একটু বেশি ব্যাটারিতে';

  @override
  String get lowEndLiteBody =>
      'সাশ্রয়ী মোড (ব্লার নেই, শান্ত নড়াচড়া) এতে আরও মসৃণ চলবে। সেটিংস → সাধারণ → পারফরম্যান্স-এ বদলাতে পারো।';

  @override
  String get lowEndLiteOn => 'সাশ্রয়ী চালু করো';

  @override
  String get dayOffHint => 'তোমার স্ট্রিক আর রিমাইন্ডার এই দিনটা ছুঁয়েও দেখবে না';

  @override
  String get dayOffTrained => 'ট্রেনিং করেছি, শুধু লেখা হয়নি';

  @override
  String get dayOffSick => 'অসুস্থতা';

  @override
  String get dayOffTravel => 'ভ্রমণ';

  @override
  String get dayOffInjury => 'চোট';

  @override
  String get dayOffRest => 'বিশ্রাম';

  @override
  String get altsTitle => 'বিকল্প';

  @override
  String get altsHint => 'যদি মেশিনটা ব্যস্ত থাকে';

  @override
  String altsPickHint(int count) {
    return '$countটি পর্যন্ত বেছে নাও। মেশিন ব্যস্ত থাকলে এক ট্যাপে বদলাও।';
  }

  @override
  String get placeDumbbells => 'ডাম্বেল';

  @override
  String get dumbbellsHint => 'একটা ডাম্বেলের ওজন। এখানে প্রোগ্রেশন আর + ও − বোতাম শুধু এগুলোতেই পড়বে।';

  @override
  String get dumbbellOther => 'অন্য ওজন';

  @override
  String get tuneTitle => 'আজকের ভলিউম';

  @override
  String get tuneHint => 'বলো প্রতিটা পেশি কেমন লাগল, পরেরবারের সেট সেই অনুযায়ী ঠিক হয়ে যাবে।';

  @override
  String get tuneLess => 'খুব কম';

  @override
  String get tuneRight => 'ঠিক';

  @override
  String get tuneMore => 'খুব বেশি';

  @override
  String tuneNext(String sets, String name) {
    return 'পরেরবার: $name-এর $sets';
  }

  @override
  String get tuneSame => 'পরেরবারও একই থাকবে';

  @override
  String get tuneSetting => 'প্রতি পেশিতে সেট ঠিক করো';

  @override
  String get tuneSettingHint => 'রুটিনের পরে প্রতিটা পেশিকে রেট করো, সেট নিজে থেকে মানিয়ে নেবে';

  @override
  String insightLoad(int pct) {
    return 'তোমার সাধারণ সপ্তাহের চেয়ে $pct % বেশি সেট। রিকভারির দিকে খেয়াল রাখো।';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: $days দিন ছোঁয়া হয়নি।';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'তুমি টানার চেয়ে বেশি ঠেলো: চার সপ্তাহে $a সেট বনাম $b।';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'তুমি ঠেলার চেয়ে বেশি টানো: চার সপ্তাহে $a সেট বনাম $b।';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: গত মাসের চেয়ে $pct % বেশি শক্তিশালী।';
  }

  @override
  String recapPull(String month) {
    return 'তোমার $month দেখতে টানতে থাকো';
  }

  @override
  String get recapRelease => 'ছেড়ে দাও';

  @override
  String recapHi(String name) {
    return 'হাই, $name';
  }

  @override
  String recapReady(String month) {
    return '$month-এ তুমি কী করেছ দেখবে?';
  }

  @override
  String get recapGo => 'চলো';

  @override
  String recapEmpty(String month) {
    return '$month-এ এখনও কোনো ওয়ার্কআউট নেই। তোমার প্রথমটাই এটা খুলবে।';
  }

  @override
  String get recapClose => 'বন্ধ করো';

  @override
  String get recapShare => 'শেয়ার করো';

  @override
  String get recapWorkoutsKicker => 'এই মাসে তুমি ট্রেন করেছ';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ওয়ার্কআউট', one: 'ওয়ার্কআউট');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nটি আলাদা দিনে', one: 'এক দিনে');
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'বারের নিচে সময়';

  @override
  String recapLongest(String time, String date) {
    return 'সবচেয়ে লম্বা সেশন: $time, $date-এ';
  }

  @override
  String get recapVolumeKicker => 'তুমি সরিয়েছ';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$countটা গাড়ি তোলার মতো',
      one: 'একটা গাড়ি তোলার মতো',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'সবচেয়ে বেশি: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'মাসের পেশি';

  @override
  String get recapRecordsKicker => 'নতুন রেকর্ড';

  @override
  String recapNoRecords(int n) {
    return 'এবার কোনো রেকর্ড নেই, তবে $nটি সেট জমা হয়েছে।';
  }

  @override
  String get recapHabitKicker => 'তোমার সময়';

  @override
  String recapHabitStart(String time) {
    return 'তুমি সাধারণত $time-এ শুরু করো';
  }

  @override
  String get recapShareKicker => 'তোমার মাস, শেয়ারের জন্য তৈরি';

  @override
  String get recapTickWorkouts => 'ওয়ার্কআউট';

  @override
  String get recapTickTime => 'সময়';

  @override
  String get recapTickVolume => 'ভার';

  @override
  String get recapTickRecords => 'রেকর্ড';

  @override
  String recapAvg(int n) {
    return 'প্রতি ওয়ার্কআউটে গড়ে $n মিনিট';
  }

  @override
  String get recapLiftKicker => 'মাসের ব্যায়াম';

  @override
  String get recapBest => 'সেরা';

  @override
  String get recapTimes => 'দিন';

  @override
  String get recapDaysLabel => 'দিন';

  @override
  String get recapAvgLabel => 'গড়';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$days দিনে $workoutsটি ওয়ার্কআউট';
  }

  @override
  String get recapFavLabel => 'তোমার দিন';

  @override
  String get recapWatermark => 'ফ্রি জিম লগ';

  @override
  String get recapTickSteps => 'পদক্ষেপ';

  @override
  String get recapTickFood => 'খাবার';

  @override
  String get recapCardioKicker => 'কার্ডিও';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ওয়ার্কআউটে',
      one: 'একটা ওয়ার্কআউটে',
    );
    return '$_temp0 $minutes মিনিট';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি কার্ডিও ওয়ার্কআউট',
      one: 'একটা কার্ডিও ওয়ার্কআউট',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'তোমার প্রিয়: $name';
  }

  @override
  String get recapStepsKicker => 'তুমি হেঁটেছ';

  @override
  String get recapStepsWord => 'পদক্ষেপ';

  @override
  String recapStepsAvg(String value) {
    return 'দিনে গড়ে $value';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'সেরা দিন: $value, $date';
  }

  @override
  String get recapFoodKicker => 'তোমার প্লেটে';

  @override
  String get recapLiftRest => 'ঠিক পেছনে';

  @override
  String recapSameAs(String month) {
    return '$month-এর মতোই';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$month-এর চেয়ে $value বেশি';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$month-এর চেয়ে $value কম';
  }

  @override
  String get recapTickMedals => 'মেডেল';

  @override
  String get recapTickSleep => 'ঘুম';

  @override
  String get recapMedalsKicker => 'তোমার জেতা মেডেল';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'আর $nটি', one: 'আর একটা');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'তুমি ঘুমিয়েছ';

  @override
  String get recapSleepAvg => 'রাতে গড়ে';

  @override
  String recapSleepBest(String value, String date) {
    return 'সেরা রাত: $value, $date';
  }

  @override
  String get recapCardSummary => 'সারসংক্ষেপ';

  @override
  String get recapCardCalendar => 'ক্যালেন্ডার';

  @override
  String get recapCardLift => 'ব্যায়াম';

  @override
  String get recapPeakKicker => 'তোমার সবচেয়ে কঠিন সেশন';

  @override
  String get recapTickPeak => 'সেশন';

  @override
  String get recapFreshKicker => 'এই মাসে প্রথমবার';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'নতুন ব্যায়াম',
      one: 'নতুন ব্যায়াম',
    );
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'নতুন';

  @override
  String recapStreak(int n) {
    return 'টানা $n দিন, তোমার সবচেয়ে লম্বা স্ট্রিক';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ওয়ার্কআউট',
      one: '1টি ওয়ার্কআউট',
    );
    return 'এক বছর আগে: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'এই মাসে বাদ পড়েছে: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'দিনে প্রোটিন · লক্ষ্য $goal গ্রা';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n দিন তোমার প্লেটে',
      one: '1 দিন তোমার প্লেটে',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'প্রোটিন · গ্রা/দিন';

  @override
  String get recapFoodGoalDays => 'লক্ষ্য পূরণ';

  @override
  String get recapFoodWaterLabel => 'পানি/দিন';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n দিন', one: '1 দিন');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'মাসের তোমার খাবার';

  @override
  String get onbSpeedTitle => 'মসৃণ করে চালাও';

  @override
  String get onbSpeedWhy =>
      'তোমার ফোন মনে হচ্ছে বেশ খাটছে। এগুলো বন্ধ করলে সবকিছু আরও ভালো চলবে: চেষ্টা করো আর প্রিভিউ দেখো।';

  @override
  String get onbSpeedMotion => 'অ্যানিমেশন';

  @override
  String get onbSpeedBlurHint => 'শিট আর বারের পেছনে ঘষা কাচ';

  @override
  String get onbSpeedMotionHint => 'স্লাইড করে আসা স্ক্রিন আর শিট';

  @override
  String get onbSpeedLater => 'যেকোনো সময় সেটিংস › সাধারণ › পারফরম্যান্স-এ বদলাতে পারো।';

  @override
  String get notifSoundSetting => 'নোটিফিকেশনের শব্দ';

  @override
  String get notifSoundRowHint => 'প্রতিটা ধরনের রিমাইন্ডার কেমন শোনায়';

  @override
  String get notifSoundHint =>
      'প্রতিটা ধরনের রিমাইন্ডারের জন্য একটা শব্দ বেছে নাও। ফোন থেকে তোমার ফোনের শব্দগুলো খোলে, আর বেশিরভাগ ফোনে সেখানে নিজের গানও যোগ করতে পারো।';

  @override
  String get notifSoundTrain => 'ওয়ার্কআউট';

  @override
  String get notifSoundFood => 'খাবার, সাপ্লিমেন্ট আর ফাস্টিং';

  @override
  String get notifSoundOther => 'ছবি আর মাপ';

  @override
  String get notifSoundNormal => 'সাধারণ';

  @override
  String get notifSoundPhone => 'ফোন থেকে';

  @override
  String get notifSoundSilent => 'নীরব';

  @override
  String get notifSoundPhoneHint => 'শুনতে একটায় ট্যাপ করো। সঙ্গে সঙ্গে সেভ হয়।';

  @override
  String get notifSoundMore => 'অন্য ফাইল…';

  @override
  String get notifSoundChange => 'বদলাও';

  @override
  String get workoutNoteAdd => 'পিন করা নোট: সিট, গ্রিপ, মেশিন…';

  @override
  String get autoProgressSetting => 'স্বয়ংক্রিয় প্রোগ্রেশন';

  @override
  String get autoProgressRowHint => 'পরেরবারের জন্য কী প্রস্তাব করে';

  @override
  String get autoProgressOff => 'বন্ধ';

  @override
  String get autoProgressWeight => 'ওজন যোগ করো';

  @override
  String get autoProgressReps => 'রেপ যোগ করো';

  @override
  String get autoProgressHint =>
      'ওয়ার্কআউট শুরু করলে GymMane প্রতিটা ব্যায়ামের পরের ধাপ ভরে দেয়। রেপ যোগ করো দিয়ে প্রতি সেটে এক রেপ করে 12 পর্যন্ত বাড়াও, তারপর ওজন বাড়ে আর আবার 8 থেকে শুরু করো। প্রতিটা ব্যায়াম তার পেজে আলাদা করেও ঠিক করতে পারো।';

  @override
  String get noteFolders => 'ফোল্ডার';

  @override
  String get noteFolderNew => 'নতুন ফোল্ডার';

  @override
  String get noteFolderEdit => 'ফোল্ডার বদলাও';

  @override
  String get noteFolderName => 'ফোল্ডারের নাম';

  @override
  String get noteFolderLabel => 'ফোল্ডার';

  @override
  String get noteFolderNone => 'ফোল্ডার নেই';

  @override
  String get noteFolderDelete => 'ফোল্ডার মুছবে?';

  @override
  String get noteFolderDeleteBody => 'নোটগুলো থাকবে: শুধু ফোল্ডার থেকে বেরিয়ে যাবে।';

  @override
  String get foodArchivedToast => 'খাবার আর্কাইভ করা হয়েছে';

  @override
  String get planArchivedToast => 'প্ল্যান আর্কাইভ করা হয়েছে';

  @override
  String get suppArchivedToast => 'সাপ্লিমেন্ট আর্কাইভ করা হয়েছে';

  @override
  String get voiceSetting => 'ওয়ার্কআউটের কণ্ঠ';

  @override
  String get voiceSettingHint => 'ফোনের কণ্ঠে তোমার পরের সেট বলে আর বিশ্রামের শেষটা গুনে দেয়';

  @override
  String get voiceHello => 'কণ্ঠ চালু';

  @override
  String voiceRest(String time) {
    return 'বিশ্রাম $time।';
  }

  @override
  String voiceNext(String name, String load) {
    return 'এরপর: $name, $load।';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$weight-এ $reps রেপ';
  }

  @override
  String voiceReps(int reps) {
    return '$reps রেপ';
  }

  @override
  String get voiceGo => 'চলো শুরু করি!';

  @override
  String get deloadSetting => 'ডিলোড সপ্তাহ';

  @override
  String get deloadOff => 'কখনো না';

  @override
  String deloadEvery(int weeks) {
    return 'প্রতি $weeks সপ্তাহে';
  }

  @override
  String get deloadHint =>
      'কয়েক সপ্তাহ পরপর রিকভারির জন্য একটা হালকা সপ্তাহ: অর্ধেক সেট আর 10 % কম ওজন। সেই সপ্তাহ প্রোগ্রেশনে গোনা হয় না।';

  @override
  String get deloadRowHint => 'কয়েক সপ্তাহ পরপর একটা হালকা সপ্তাহ';

  @override
  String get deloadNow => 'ডিলোড সপ্তাহ';

  @override
  String get deloadNowHint => 'আজ, অর্ধেক সেট আর 10 % কম ওজন';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks সপ্তাহ পরে',
      one: 'আগামী সপ্তাহে',
      zero: 'এই সপ্তাহে',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'সাধারণভাবে ট্রেন করো';

  @override
  String get voiceSheetTitle => 'কণ্ঠ কীভাবে কাজ করে';

  @override
  String get voicePointRest => 'একটা সেট টিক দিলে বিশ্রামের সময় আর এরপর কী আছে তা বলে।';

  @override
  String get voicePointCount => 'বিশ্রামের শেষে 3, 2, 1 গুনে তোমাকে ডেকে আনে।';

  @override
  String get voicePointPhone => 'তোমার ফোনের কণ্ঠ ব্যবহার করে আর তোমার গানের ওপর দিয়ে বাজে।';

  @override
  String get voiceTry => 'কণ্ঠ চেষ্টা করো';

  @override
  String get voiceNoEngine => 'তোমার ফোনে কোনো ভয়েস ইঞ্জিন চালু নেই।';

  @override
  String get voiceNoLang => 'তোমার ভাষার কণ্ঠ নেই। ফোনের ভয়েস সেটিংসে ডাউনলোড করো।';

  @override
  String get voiceOpenSettings => 'ভয়েস সেটিংস';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count মিনিট', one: '1 মিনিট');
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count সেকেন্ড',
      one: '1 সেকেন্ড',
    );
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'এবং';

  @override
  String get repRecordsTitle => 'রেপ অনুযায়ী সেরা ওজন';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ক্যাপসুল', one: 'ক্যাপসুল');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'বড়ি', one: 'বড়ি');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'স্কুপ', one: 'স্কুপ');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ফোঁটা', one: 'ফোঁটা');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'সার্ভিং', one: 'সার্ভিং');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IU';

  @override
  String get suppLeft => 'বাকি';

  @override
  String get suppLeftHint => 'ঐচ্ছিক';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n দিনের জন্য বাকি',
      one: '1 দিনের জন্য বাকি',
    );
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n দিন', one: '1 দিন');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'ফুরিয়ে গেছে';

  @override
  String get lightSession => 'হালকা সেশন';

  @override
  String get lightSessionHint => 'তোমার ইতিহাস আর পরিসংখ্যানে সেভ হয়, তবে তোমার পরের লক্ষ্য বদলাবে না।';

  @override
  String get lightSessionNote => 'প্রোগ্রেশনে গোনা হয় না';

  @override
  String get lightSessionOff => 'বন্ধ করো';

  @override
  String get eachSideRepsHint => 'বাম আর ডান রেপ আলাদা করে লেখো। প্রোগ্রেশন দুর্বল পাশ অনুসরণ করে।';

  @override
  String get repsLeftCol => 'রেপ বা';

  @override
  String get repsRightCol => 'রেপ ডা';

  @override
  String get repsLeftTitle => 'বাম রেপ';

  @override
  String get repsRightTitle => 'ডান রেপ';

  @override
  String sidesReps(int l, int r) {
    return 'বা$l ডা$r';
  }

  @override
  String get progSchemeTitle => 'ওজনের প্রোগ্রেশন';

  @override
  String get groupMoveUp => 'গ্রুপ ওপরে নাও';

  @override
  String get groupMoveDown => 'গ্রুপ নিচে নাও';

  @override
  String get mealAiRow => 'AI-কে জিজ্ঞেস করো';

  @override
  String get mealAiRowHint => 'একটা অনুরোধ কপি করো, উত্তর পেস্ট করো';

  @override
  String get mealAiTitle => 'AI দিয়ে খাবার';

  @override
  String get mealAiSubtitle => 'যেকোনো চ্যাটবটে কাজ করে। অ্যাপ অফলাইনেই থাকে।';

  @override
  String get mealAiStepAsk => 'জিজ্ঞেস করো';

  @override
  String get mealAiStepPaste => 'পেস্ট করো';

  @override
  String get mealAiWholeDay => 'পুরো দিন';

  @override
  String get mealAiTarget => 'লক্ষ্য';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'আজ তোমার $kcal আর $protein গ্রা প্রোটিন বাকি';
  }

  @override
  String get mealAiStyle => 'তোমার রুচি';

  @override
  String get mealAiTagProtein => 'উচ্চ প্রোটিন';

  @override
  String get mealAiTagVeggie => 'নিরামিষ';

  @override
  String get mealAiTagVegan => 'ভেগান';

  @override
  String get mealAiTagNoGluten => 'গ্লুটেন ছাড়া';

  @override
  String get mealAiTagNoLactose => 'ল্যাকটোজ ছাড়া';

  @override
  String get mealAiTagQuick => 'দ্রুত';

  @override
  String get mealAiTagNoCook => 'রান্না ছাড়া';

  @override
  String get mealAiTagCheap => 'কম খরচে';

  @override
  String get mealAiNotesHint => 'বাড়িতে আছে… পছন্দ করি না… অ্যালার্জি…';

  @override
  String get mealAiOptions => 'বিকল্প';

  @override
  String get mealAiCopy => 'অনুরোধ কপি করো';

  @override
  String get mealAiCopied => 'অনুরোধ কপি হয়েছে';

  @override
  String get mealAiCopiedHint => 'তোমার AI-তে পেস্ট করো আর উত্তর নিয়ে এখানে ফিরে এসো';

  @override
  String get mealAiShowText => 'অনুরোধ দেখো';

  @override
  String get mealAiHideText => 'অনুরোধ লুকাও';

  @override
  String get mealAiPasteHint => 'AI-এর উত্তর এখানে পেস্ট করো';

  @override
  String get mealAiReview => 'উত্তর দেখো';

  @override
  String get mealAiUnreadable => 'ওই লেখায় কোনো খাবার খুঁজে পাইনি';

  @override
  String get mealAiUnreadableHint => 'AI-কে বলো শুধু JSON পাঠাতে, একটা কোড ব্লকে, অনুরোধের ফরম্যাটে।';

  @override
  String get mealAiCopyFix => 'ওই বাক্যটা কপি করো';

  @override
  String mealAiOption(int n) {
    return 'বিকল্প $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return '$meal-এ যোগ করো';
  }

  @override
  String get mealAiAddDay => 'আজকে যোগ করো';

  @override
  String get mealAiAddPick => 'যোগ করো';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি খাবার যোগ হয়েছে',
      one: '1টি খাবার যোগ হয়েছে',
    );
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'রেসিপি হিসেবে সেভ করো';

  @override
  String get mealAiSavePlan => 'প্ল্যান হিসেবে সেভ করো';

  @override
  String get mealAiRecipeSaved => 'রেসিপি সেভ হয়েছে';

  @override
  String get mealAiPlanSaved => 'প্ল্যান সেভ হয়েছে';

  @override
  String get mealAiFlagEstimated => 'AI-এর অনুমান';

  @override
  String get mealAiFlagAdjusted => 'ম্যাক্রোর সাথে মেলাতে ক্যালোরি ঠিক করা হয়েছে';

  @override
  String get mealAiFlagDoubtful => 'হিসাব মিলছে না, দেখে নাও';

  @override
  String get mealAiFlagNoValues => 'পুষ্টিমান নেই';

  @override
  String get mealAiFlagNoAmount => 'পরিমাণ দেওয়া নেই';

  @override
  String get mealAiTruncated => 'উত্তরটা কাটা মনে হচ্ছে। সম্পূর্ণ খাবারগুলো রেখেছি।';

  @override
  String get mealAiAmount => 'পরিমাণ';

  @override
  String mealAiTargetLine(String kcal) {
    return 'লক্ষ্য $kcal';
  }

  @override
  String get mealAiNothingChosen => 'অন্তত একটা খাবার চালু করো';

  @override
  String get cholesterolLabel => 'কোলেস্টেরল';

  @override
  String get mealAiFlagMatched => 'তোমার সেভ করা একটা খাবারের মতোই';

  @override
  String get mealAiNotSame => 'একই নয়';

  @override
  String get homeOrderRow => 'অংশগুলোর ক্রম';

  @override
  String get homeOrderHint => 'হোমের ক্রম বদলাতে ধরে রেখে টেনে আনো।';

  @override
  String get homeOrderFolders => 'শর্টকাট';

  @override
  String get equipNew => 'নতুন';

  @override
  String get equipNewTitle => 'নতুন সরঞ্জাম';

  @override
  String get equipNewHint => 'যেমন ওয়েট বেল্ট';

  @override
  String get homeOrderWeekdays => 'সপ্তাহের টিক';

  @override
  String get repsMaxTitle => 'রেপ পর্যন্ত';

  @override
  String get repsRangeHint => '8-12-এর মতো পরিসর দিতে রেপে লং প্রেস করো।';

  @override
  String get repsRangeClear => 'পরিসর সরাও';

  @override
  String get noteLinksLabel => 'লিংক';

  @override
  String get noteLinkAdd => 'লিংক যোগ করো';

  @override
  String get noteLinkEdit => 'লিংক বদলাও';

  @override
  String get noteLinkNameHint => 'নাম';

  @override
  String get noteLinkUrlHint => 'ওয়েব ঠিকানা';

  @override
  String get noteLinkInvalid => 'ঠিকানাটা ঠিক মনে হচ্ছে না';

  @override
  String get changeRest => 'ব্যায়ামের মাঝে বিশ্রাম';

  @override
  String get changeRestHint => 'শেষ সেটের পরে, পরের ব্যায়ামের আগে';

  @override
  String get notifSuppTake => 'নেওয়া হয়েছে';

  @override
  String get sideRest => 'দুই পাশের মাঝে বিশ্রাম';

  @override
  String get sideRestHint => 'প্রতি পাশের ব্যায়াম: প্রথম ✓ একটা পাশ শেষ করে';

  @override
  String get gfxCompat => 'সামঞ্জস্যপূর্ণ গ্রাফিক্স';

  @override
  String get gfxCompatHint => 'যে ফোনে অক্ষর ভাঙা দেখায় তাদের জন্য। ব্লার থাকে, কয়েকটা ইফেক্ট সরল হয়';

  @override
  String get gfxRestartTitle => 'GymMane রিস্টার্ট করবে?';

  @override
  String get gfxRestartBody =>
      'স্ক্রিন আঁকার ধরন বদলাতে এটা বন্ধ হয়ে আবার খোলে। তোমার সেভ করা কিছুই হারাবে না।';

  @override
  String get gfxRestart => 'রিস্টার্ট';

  @override
  String get webSynced => 'অন্য ডিভাইসের পরিবর্তন দিয়ে আপডেট হয়েছে';

  @override
  String get webSyncedPhone => 'তোমার ফোনের পরিবর্তন এসে গেছে';

  @override
  String get webWelcomeBlurb =>
      'সবকিছু তোমার নিজের সার্ভারেই থাকে। কোনো অ্যাকাউন্ট নেই, ক্লাউড নেই, কিছু দিতে হয় না।';

  @override
  String get webOwnServer => 'তোমার সার্ভার, তোমার নিয়ম';

  @override
  String get webOwnServerWhy =>
      'কোনো অ্যাকাউন্ট নেই আর অন্য কারো ক্লাউড নেই। তুমি যেখানে চালাও তোমার ডেটা সেখানেই থাকে।';

  @override
  String get webServerSaved => 'তোমার সার্ভারে সেভ হয়েছে';

  @override
  String get webServerOffline => 'তোমার সার্ভারে পৌঁছানো যাচ্ছে না';

  @override
  String get webServerLocal => 'এই ব্রাউজারে সেভ হয়েছে';

  @override
  String get webServerTitle => 'তোমার সার্ভার';

  @override
  String webPhoneLast(String date) {
    return 'তোমার ফোন থেকে শেষ কপি: $date';
  }

  @override
  String get webPhoneNone => 'এখনও তোমার ফোন থেকে কোনো কপি নেই';

  @override
  String get webPhoneScan => 'ফোন থেকে আনো';

  @override
  String get webPhoneExport => 'ফোনে পাঠাও';

  @override
  String get webPhoneExportDone => 'শেয়ার করা ফোল্ডারে রাখা হয়েছে। সিঙ্ক হলে তোমার ফোন এটা নিয়ে নেবে';

  @override
  String get webPhoneImported => 'তোমার ফোনের পরিবর্তন এসে গেছে';

  @override
  String get webPhoneNothing => 'তোমার ফোন থেকে নতুন কিছু নেই';

  @override
  String get webPhoneHow =>
      'তোমার ফোনে স্বয়ংক্রিয় ব্যাকআপ চালু করো এমন একটা ফোল্ডারে যা Syncthing দিয়ে সিঙ্ক করো। সার্ভার আর ফোন নিজে থেকেই একে অপরের পরিবর্তন নিয়ে আসে, আর মেলানোর সময় কিছুই মোছে না।';

  @override
  String get webPhoneGuide => 'কীভাবে সেট আপ করবে';

  @override
  String get webPhoneOff => 'এই সার্ভারে ফোন সিঙ্ক বন্ধ';

  @override
  String get toolGroupBody => 'শরীর';

  @override
  String get toolNameProtein => 'প্রোটিন';

  @override
  String get toolTitleProtein => 'দৈনিক প্রোটিন';

  @override
  String get toolDescProtein => 'দিনে কতটা প্রোটিন';

  @override
  String get toolHintProtein => 'দিনে গ্রাম, তোমার খাবারগুলোতে ভাগ করে';

  @override
  String get proteinGoalLabel => 'লক্ষ্য';

  @override
  String get proteinExplain =>
      'যারা ট্রেন করে তাদের জন্য বেশিরভাগ গবেষণা যে পরিসরে একমত তার ওপর ভিত্তি করে: ওজন কমানোর সময় বেশি, যাতে পেশি থাকে। এর বেশি খাওয়া নিরাপদ, শুধু তেমন কিছু যোগ করে না।';

  @override
  String get toolNameWater => 'পানি';

  @override
  String get toolTitleWater => 'দৈনিক পানি';

  @override
  String get toolDescWater => 'দিনে কতটা পানি খাবে';

  @override
  String get toolHintWater => 'দিনে লিটার, খাবারসহ';

  @override
  String get waterTrainingLabel => 'দিনে ট্রেনিং';

  @override
  String get waterExplain =>
      'শরীরের ওজনের প্রতি কেজিতে প্রায় 35 মিলি, আর ট্রেনিংয়ের প্রতি মিনিটে একটু বেশি। গরমের দিনে বেশি খাও।';

  @override
  String get autoBackupSync => 'এখন সিঙ্ক করো';

  @override
  String get autoBackupMerged => 'তোমার অন্য ডিভাইসের পরিবর্তন এসে গেছে';

  @override
  String get autoBackupSyncHint =>
      'এই ফোল্ডার Syncthing দিয়ে শেয়ার করো, প্রতিটা ডিভাইস অন্যরা এখানে যা রাখে তা নিয়ে আসবে। মেলানোর সময় কিছুই মোছে না।';

  @override
  String get webPhoneFolder => 'শেয়ার করা ফোল্ডার';

  @override
  String get webPhoneFolderHow =>
      'সার্ভার ইনস্টল করার সময় বেছে নেওয়া হয়। বদলাতে সার্ভারের .env ফাইলে GYMMANE_SYNC দাও আর রিস্টার্ট করো।';

  @override
  String get webPhoneOffHow => 'চালু করতে সার্ভারের .env ফাইল থেকে GYMMANE_SYNC=off সরাও আর রিস্টার্ট করো।';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি ফোন সিঙ্ক হয়েছে',
      one: '1টি ফোন সিঙ্ক হয়েছে',
      zero: 'এখনও কোনো ফোন সিঙ্ক হয়নি',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'ফোল্ডার পড়া গেল না: $error';
  }

  @override
  String get duplicateExercise => 'ডুপ্লিকেট';

  @override
  String exerciseCopyName(String name) {
    return '$name (কপি)';
  }
}
