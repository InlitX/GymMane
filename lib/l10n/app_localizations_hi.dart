// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get languageName => 'हिन्दी';

  @override
  String vsLastMonthLabel(String pct) {
    return 'पिछले महीने से $pct%';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'लेवल $level · $streak';
  }

  @override
  String get save => 'सेव करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get cancelCaps => 'रद्द करें';

  @override
  String get deleteCaps => 'हटाएँ';

  @override
  String get done => 'हो गया';

  @override
  String get set => 'सेट';

  @override
  String get home => 'होम';

  @override
  String get progress => 'प्रगति';

  @override
  String get exercises => 'एक्सरसाइज़';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get today => 'आज';

  @override
  String get thisWeek => 'इस हफ़्ते';

  @override
  String get recommended => 'सुझाए गए';

  @override
  String get goal => 'लक्ष्य';

  @override
  String get volume => 'वॉल्यूम';

  @override
  String get setsToday => 'आज के सेट';

  @override
  String get prs => 'PR';

  @override
  String get todaysFocus => 'आज का फ़ोकस';

  @override
  String get todaysRoutine => 'आज का रूटीन';

  @override
  String get startWorkout => 'वर्कआउट शुरू करें';

  @override
  String get routines => 'रूटीन';

  @override
  String get tools => 'टूल्स';

  @override
  String get firstSessionHint => 'अपनी मांसपेशियाँ चुनो और पहला सेशन दर्ज करो';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n एक्सरसाइज़',
      one: '$n एक्सरसाइज़',
    );
    return '$_temp0';
  }

  @override
  String get pushDay => 'पुश डे';

  @override
  String get pullDay => 'पुल डे';

  @override
  String get legDay => 'लेग डे';

  @override
  String get pushFocus => 'छाती · कंधे · ट्राइसेप्स';

  @override
  String get pullFocus => 'पीठ · बाइसेप्स · ट्रैप्स';

  @override
  String get legFocus => 'क्वाड्स · हैमस्ट्रिंग · ग्लूट्स';

  @override
  String get train => 'ट्रेनिंग';

  @override
  String get step1 => 'चरण 1 / 2';

  @override
  String get step2 => 'चरण 2 / 2';

  @override
  String get chooseFocus => 'अपना फ़ोकस चुनो';

  @override
  String get buildSession => 'अपना सेशन बनाओ';

  @override
  String get tapMuscles => 'जिन मांसपेशियों को ट्रेन करना है उन पर टैप करो, आगे और पीछे।';

  @override
  String get continueBtn => 'आगे बढ़ें';

  @override
  String get nothingForFocus => 'इस फ़ोकस के लिए अभी कुछ नहीं';

  @override
  String get goBackPick => 'वापस जाओ और ऐसी मांसपेशी चुनो जिसकी एक्सरसाइज़ तुम्हारी लाइब्रेरी में हों।';

  @override
  String pickedHint(int n) {
    return 'हमने तुम्हारे लिए एक सेशन चुना है। $n में से किसी को जोड़ने या हटाने के लिए टैप करो।';
  }

  @override
  String get pickAnExercise => 'एक एक्सरसाइज़ चुनो';

  @override
  String get searchAllExercises => 'कोई भी एक्सरसाइज़ खोजो…';

  @override
  String get noExercisesMatch => 'कोई एक्सरसाइज़ मेल नहीं खाती';

  @override
  String get createItInstead => 'इसे अपनी एक्सरसाइज़ के रूप में बनाओ';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n एक्सरसाइज़',
      one: '$n एक्सरसाइज़',
    );
    return 'शुरू करें · $_temp0';
  }

  @override
  String get inProgress => 'जारी है';

  @override
  String get paused => 'रुका हुआ';

  @override
  String get last => 'पिछला';

  @override
  String get rest => 'आराम';

  @override
  String get skip => 'छोड़ें';

  @override
  String get addSet => '+ सेट जोड़ें';

  @override
  String get finishSession => 'सेशन ख़त्म करें';

  @override
  String get setDone => 'सेट पूरा';

  @override
  String get nextExercise => 'अगली एक्सरसाइज़';

  @override
  String get dropExerciseAction => 'एक्सरसाइज़ हटाएँ';

  @override
  String get restOff => 'बंद';

  @override
  String get miniRest => 'रेस्ट-पॉज़ और क्लस्टर आराम';

  @override
  String get miniRestHint => 'रेस्ट-पॉज़ या क्लस्टर सेट से पहले';

  @override
  String get gymPass => 'जिम पास';

  @override
  String get gymPassEmpty => 'अपने जिम का कोड यहाँ रखो और बिना कार्ड के अंदर जाओ';

  @override
  String get gymPassAdd => 'पास जोड़ें';

  @override
  String get gymPassScan => 'कोड की फ़ोटो लो';

  @override
  String get gymPassScanHint => 'फ़ोन के कैमरे से';

  @override
  String get gymPassPhoto => 'फ़ोटो या स्क्रीनशॉट से';

  @override
  String get gymPassPhotoHint => 'जैसे, तुम्हारे जिम ऐप का स्क्रीनशॉट';

  @override
  String get gymPassType => 'नंबर टाइप करो';

  @override
  String get gymPassTypeHint => 'बारकोड के लिए: उसके नीचे छपा नंबर';

  @override
  String get gymPassNotFound => 'उस तस्वीर में कोई QR कोड नहीं है। साफ़ तस्वीर आज़माओ या नंबर टाइप करो।';

  @override
  String get gymPassName => 'जिम का नाम';

  @override
  String get gymPassDefaultName => 'मेरा जिम';

  @override
  String get gymPassCode => 'कोड';

  @override
  String get gymPassFormat => 'कोड का प्रकार';

  @override
  String get gymPassInvalid => 'वह नंबर इस कोड प्रकार से मेल नहीं खाता';

  @override
  String get gymPassShowHint => 'इसे रीडर के पास रखो। ब्राइटनेस अपने-आप बढ़ जाती है।';

  @override
  String get gymPassDeleted => 'पास हटाया गया';

  @override
  String get gymPassEdit => 'पास बदलें';

  @override
  String get gymPassShow => 'दरवाज़े पर दिखाएँ';

  @override
  String get gymPassPrivate => 'सिर्फ़ तुम्हारे फ़ोन पर रहता है। कुछ भी अपलोड नहीं होता।';

  @override
  String get gymPassColor => 'रंग';

  @override
  String get gymPassRescan => 'कोड फिर से पढ़ें';

  @override
  String get gymPassReading => 'कोड पढ़ा जा रहा है…';

  @override
  String get gymPassSettingHint => 'प्रोफ़ाइल में तुम्हारा जिम कार्ड';

  @override
  String get gymPassMember => 'सदस्य';

  @override
  String get widgetHintActivity => 'तुम्हारे ट्रेनिंग वाले दिनों का नक्शा';

  @override
  String get widgetHintStats => 'इस हफ़्ते की स्ट्रीक, वॉल्यूम और सेशन';

  @override
  String get widgetHintBody => 'जिन मांसपेशियों पर काम किया';

  @override
  String get widgetHintToday => 'एक नज़र में: आज ट्रेनिंग हुई?';

  @override
  String get widgetHintWeek => 'तुम्हारे हफ़्ते का प्लान, दिन-ब-दिन';

  @override
  String get supportHintBug => 'GitHub पर बताओ क्या टूटा';

  @override
  String get supportHintFeature => 'ऐप के लिए कोई आइडिया सुझाओ';

  @override
  String get supportHintStar => 'इससे और लोग इसे ढूँढ पाते हैं';

  @override
  String get supportHintCoffee => 'डेवलपमेंट में मदद करता है। मुफ़्त और बिना विज्ञापन';

  @override
  String get bodyweightNoteHint => 'नोट जोड़ो: कैसा महसूस हो रहा है, क्या आज़मा रहे हो… (वैकल्पिक)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'इस एक्सरसाइज़ के लिए $unit इस्तेमाल करें';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'रेप्स';

  @override
  String weightCol(String unit) {
    return 'वज़न ($unit)';
  }

  @override
  String get repsTitle => 'रेप्स';

  @override
  String weightTitle(String unit) {
    return 'वज़न ($unit)';
  }

  @override
  String get sessionComplete => 'वर्कआउट दर्ज हुआ';

  @override
  String get finishHeadlinePr => 'नया पर्सनल रिकॉर्ड';

  @override
  String get finishHeadlineGoal => 'हफ़्ते का लक्ष्य पूरा';

  @override
  String get finishHeadlineStreak => 'स्ट्रीक जारी है';

  @override
  String get finishHeadlineDefault => 'एक और खाते में';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs एक्सरसाइज़',
      one: 'एक एक्सरसाइज़',
    );
    return 'तुमने $_temp0 में अब तक का सबसे ज़्यादा उठाया। अब यह तुम्हारे रिकॉर्ड में है।';
  }

  @override
  String get finishBodyGoal => 'इस हफ़्ते जितने सेशन तय किए थे, सब पूरे किए।';

  @override
  String finishBodyStreak(int streak) {
    return 'लगातार $streak दिन। मुश्किल हिस्सा रुकना नहीं है।';
  }

  @override
  String get finishBodyDefault => 'दर्ज हुआ और गिना गया। निरंतरता ही आँकड़े बढ़ाती है।';

  @override
  String get vsLastTime => 'पिछली बार से';

  @override
  String get firstTime => 'पहली बार दर्ज';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n नए रिकॉर्ड',
      one: '$n नया रिकॉर्ड',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'अवधि';

  @override
  String get setsCaps => 'सेट';

  @override
  String exerciseXofY(int i, int n) {
    return 'एक्सरसाइज़ $i / $n';
  }

  @override
  String get decrease => 'घटाएँ';

  @override
  String get increase => 'बढ़ाएँ';

  @override
  String markSet(int n) {
    return 'सेट $n को पूरा चिह्नित करें';
  }

  @override
  String get pauseWorkout => 'वर्कआउट रोकें';

  @override
  String get resumeWorkout => 'वर्कआउट फिर शुरू करें';

  @override
  String get discardTitle => 'वर्कआउट छोड़ दें?';

  @override
  String get discardBody => 'इस सेशन के तुम्हारे सेट खो जाएँगे।';

  @override
  String get keepTraining => 'ट्रेनिंग जारी रखें';

  @override
  String get discard => 'छोड़ दें';

  @override
  String get notifRestChannel => 'आराम टाइमर';

  @override
  String get notifRestChannelWhy => 'बताता है कि सेट के बीच का आराम कब ख़त्म हुआ';

  @override
  String get notifAlertChannel => 'आराम टाइमर (अलर्ट)';

  @override
  String get notifAlertChannelWhy => 'आराम ख़त्म होते ही बैनर दिखाता है';

  @override
  String get restOverTitle => 'आराम ख़त्म';

  @override
  String get restOverBody => 'चलो, अगला सेट इंतज़ार कर रहा है।';

  @override
  String get allTimeSessions => 'सेशन';

  @override
  String get allTimeTime => 'समय';

  @override
  String get allTimeSets => 'सेट';

  @override
  String get consistency => 'निरंतरता';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n सेशन दर्ज', one: '$n सेशन दर्ज');
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n दिन की स्ट्रीक';
  }

  @override
  String get bodyweight => 'शरीर का वज़न';

  @override
  String get logBodyweight => 'वज़न दर्ज करें';

  @override
  String get trackWeight => 'समय के साथ अपना वज़न देखो';

  @override
  String get muscleMap => 'मसल मैप';

  @override
  String get days7 => '7दि';

  @override
  String get days30 => '30दि';

  @override
  String get days90 => '90दि';

  @override
  String get days365 => '1व';

  @override
  String get daysAll => 'सब';

  @override
  String get weeklyAvgTitle => 'साप्ताहिक औसत';

  @override
  String weekOfDate(String date) {
    return '$date का हफ़्ता';
  }

  @override
  String weightChangeRange(String change) {
    return 'इस अवधि में $change';
  }

  @override
  String get heatLow => 'अछूता';

  @override
  String get heatHigh => 'पूरा वॉल्यूम';

  @override
  String get muscleMapEmpty => 'एक सेशन दर्ज करो और तुम्हारा शरीर यहाँ चमकने लगेगा।';

  @override
  String get muscleMapHint => 'मांसपेशी पर टैप करके देखो उसे क्या मिला।';

  @override
  String muscleMapBehind(String names) {
    return 'पीछे रह गई: $names';
  }

  @override
  String ofTarget(int pct) {
    return 'लक्ष्य का $pct%';
  }

  @override
  String get muscleSplit => 'मसल स्प्लिट';

  @override
  String get personalRecords => 'पर्सनल रिकॉर्ड';

  @override
  String get strength1rm => 'ताक़त · अनुमानित 1RM';

  @override
  String get strengthEmpty => 'किसी एक्सरसाइज़ को दो बार दर्ज करो और उसकी ताक़त का ग्राफ़ यहाँ दिखेगा।';

  @override
  String oneRmEst(String w) {
    return 'अनुमानित 1RM $w';
  }

  @override
  String get restDayShort => 'आराम का दिन';

  @override
  String get restDay => 'आराम का दिन, कुछ दर्ज नहीं।';

  @override
  String get delete => 'हटाएँ';

  @override
  String get deleteEntry => 'यह एंट्री हटाएँ?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" इस दिन से, और तुम्हारे रिकॉर्ड व ग्राफ़ से हट जाएगा।';
  }

  @override
  String get bodyweightHistory => 'इतिहास';

  @override
  String get exercisesCaps => 'एक्सरसाइज़';

  @override
  String get timeCaps => 'समय';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'लाइब्रेरी में $n एक्सरसाइज़',
      one: 'लाइब्रेरी में $n एक्सरसाइज़',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'एक्सरसाइज़ खोजें';

  @override
  String get muscleFilter => 'मांसपेशी';

  @override
  String get levelFilter => 'स्तर';

  @override
  String get kindLabel => 'प्रकार';

  @override
  String get kindStrength => 'स्ट्रेंथ';

  @override
  String get kindCalisthenics => 'कैलिस्थेनिक्स';

  @override
  String get kindCardio => 'कार्डियो';

  @override
  String get kindStretch => 'स्ट्रेचिंग';

  @override
  String get newExercise => 'नई एक्सरसाइज़';

  @override
  String get exerciseName => 'एक्सरसाइज़ का नाम';

  @override
  String get equipmentLabel => 'उपकरण';

  @override
  String get addExercise => 'एक्सरसाइज़ जोड़ें';

  @override
  String get advanced => 'एडवांस्ड';

  @override
  String get demoMedia => 'डेमो';

  @override
  String get addMedia => 'मीडिया जोड़ें';

  @override
  String get mediaHint => 'इमेज, GIF या वीडियो';

  @override
  String get changeMedia => 'बदलें';

  @override
  String get videoSelected => 'वीडियो चुना गया';

  @override
  String get favouritesOnly => 'पसंदीदा';

  @override
  String get noFavouritesYet => 'अभी कोई पसंदीदा नहीं';

  @override
  String get noFavouritesHint => 'किसी एक्सरसाइज़ के स्टार पर टैप करके उसे यहाँ रखो।';

  @override
  String get clearFilters => 'फ़िल्टर हटाएँ';

  @override
  String get quickAddAmount => 'तुमने कितना खाया';

  @override
  String get homeCardsTitle => 'होम कार्ड';

  @override
  String get homeCardsHint => 'जो चालू करोगे वह होम पर दिखेगा';

  @override
  String get homeCardFocus => 'आज';

  @override
  String get homeCardSteps => 'क़दम';

  @override
  String get homeCardWeek => 'इस हफ़्ते';

  @override
  String get homeCardRoutines => 'रूटीन';

  @override
  String get homeCardRecommended => 'सुझाव';

  @override
  String get textSizeSetting => 'टेक्स्ट का आकार';

  @override
  String get textSizeSmall => 'छोटा';

  @override
  String get textSizeNormal => 'सामान्य';

  @override
  String get textSizeLarge => 'बड़ा';

  @override
  String get textSizeHint => 'फ़ोन के टेक्स्ट आकार के ऊपर';

  @override
  String get calmMotionSetting => 'मोशन कम करें';

  @override
  String get calmMotionHint => 'स्क्रीन बिना स्लाइड हुए दिखती हैं';

  @override
  String get dishArchive => 'आर्काइव करें';

  @override
  String get dishUnarchive => 'वापस लाएँ';

  @override
  String get dishArchivedToast => 'डिश आर्काइव की गई';

  @override
  String get filterShowLabel => 'दिखाएँ';

  @override
  String get noExercisesFound => 'कोई एक्सरसाइज़ नहीं मिली';

  @override
  String get noExercisesHint => 'कुछ और खोजो या फ़िल्टर हटाओ।';

  @override
  String get personalRecord => 'पर्सनल रिकॉर्ड';

  @override
  String get history => 'इतिहास';

  @override
  String get noHistory => 'अभी कोई सेशन दर्ज नहीं। इतिहास बनाने के लिए यह एक्सरसाइज़ करो।';

  @override
  String get notes => 'नोट्स';

  @override
  String get notePlaceholder => 'टिप्स, सेटअप, कैसा लगा…';

  @override
  String notHere(String gear, String place) {
    return '$place में $gear नहीं है';
  }

  @override
  String get notHereWhy => 'इसे किसी ऐसी चीज़ से बदलो जो आज सच में कर सको।';

  @override
  String get altHere => 'यहाँ तुम क्या कर सकते हो';

  @override
  String get places => 'मेरी जगहें';

  @override
  String get placesHint =>
      'बताओ हर जगह तुम्हारे पास क्या है, और लाइब्रेरी सिर्फ़ वही दिखाएगी जो तुम वहाँ सच में कर सकते हो।';

  @override
  String get placeAll => 'कहीं भी';

  @override
  String get placeNew => 'नई जगह';

  @override
  String get placeNamePlaceholder => 'घर, जिम, पार्क…';

  @override
  String get placeGearLabel => 'वहाँ क्या है';

  @override
  String placeExercises(int n) {
    return 'यहाँ $n एक्सरसाइज़';
  }

  @override
  String get placeEmptyTitle => 'जहाँ भी हो, वहीं ट्रेनिंग करो';

  @override
  String get placeEmptyBody => 'जगह यानी वहाँ मौजूद सामान की सूची। शुरू करने के लिए एक चुनो और बाद में बदलो।';

  @override
  String get placeDeleteTitle => 'जगह हटाएँ';

  @override
  String get placeDeleteBody => 'सिर्फ़ जगह हटेगी। तुम्हारी एक्सरसाइज़ और सेशन बने रहेंगे।';

  @override
  String get placeGym => 'जिम';

  @override
  String get placeHome => 'घर';

  @override
  String get placeOutdoors => 'बाहर';

  @override
  String get placeFilterLabel => 'जगह';

  @override
  String get noGearOnly => 'बिना सामान';

  @override
  String placeActive(String name) {
    return '$name में ट्रेनिंग';
  }

  @override
  String get journal => 'डायरी';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n नोट',
      one: '1 नोट',
      zero: 'कोई नोट नहीं',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'नोट';

  @override
  String get noteKindPlan => 'प्लान';

  @override
  String get noteKindDone => 'जीत';

  @override
  String get noteKindPain => 'तकलीफ़';

  @override
  String get noteFilterAll => 'सब';

  @override
  String get newNote => 'नया नोट';

  @override
  String get editNote => 'नोट बदलें';

  @override
  String get addNote => 'नोट जोड़ें';

  @override
  String get noteEmptyTitle => 'अभी कुछ लिखा नहीं';

  @override
  String get noteEmptyBody => 'टिप्स, अगली बार के प्लान, सेशन कैसा लगा। चाहो तो फ़ोटो या वीडियो के साथ।';

  @override
  String get noteNoneForExercise => 'इस एक्सरसाइज़ पर अभी कोई नोट नहीं।';

  @override
  String get noteKindLabel => 'प्रकार';

  @override
  String get noteTextLabel => 'नोट';

  @override
  String get noteDateLabel => 'तारीख़';

  @override
  String get noteExerciseLabel => 'एक्सरसाइज़';

  @override
  String get noteMediaLabel => 'फ़ोटो और वीडियो';

  @override
  String get noteGeneral => 'कोई एक्सरसाइज़ नहीं';

  @override
  String get noteAttach => 'जोड़ें';

  @override
  String get noteRemoveMedia => 'अटैचमेंट हटाएँ';

  @override
  String get deleteNoteTitle => 'नोट हटाएँ';

  @override
  String get deleteNoteBody => 'नोट और उससे जुड़ी हर चीज़ हमेशा के लिए चली जाएगी।';

  @override
  String get noteToday => 'आज';

  @override
  String get noteYesterday => 'कल';

  @override
  String get noteAllNotes => 'सभी नोट';

  @override
  String get noteCalendar => 'कैलेंडर';

  @override
  String get noteNoneOnDay => 'इस दिन कुछ नहीं लिखा';

  @override
  String get noteAddOnDay => 'इस दिन का नोट';

  @override
  String get notePrevMonth => 'पिछला महीना';

  @override
  String get noteNextMonth => 'अगला महीना';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'इस महीने $n नोट',
      one: 'इस महीने 1 नोट',
      zero: 'इस महीने कोई नोट नहीं',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'माप';

  @override
  String get measuresHint => 'गर्दन से पिंडली तक: सिर्फ़ बार नहीं, शरीर बदलते देखो।';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n माप',
      one: '1 माप',
      zero: 'कुछ दर्ज नहीं',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'अभी दर्ज नहीं';

  @override
  String get measureHistory => 'इतिहास';

  @override
  String get measureNeck => 'गर्दन';

  @override
  String get measureShoulders => 'कंधे';

  @override
  String get measureChest => 'छाती';

  @override
  String get measureArm => 'बाँह';

  @override
  String get measureForearm => 'अग्रबाहु';

  @override
  String get measureWaist => 'कमर';

  @override
  String get measureHips => 'कूल्हे';

  @override
  String get measureThigh => 'जांघ';

  @override
  String get measureCalf => 'पिंडली';

  @override
  String get measureBodyfat => 'बॉडी फ़ैट';

  @override
  String get timeline => 'टाइमलाइन';

  @override
  String get hidePhotos => 'फ़ोटो छुपाएँ';

  @override
  String get showPhotos => 'फ़ोटो दिखाएँ';

  @override
  String get timelineHint => 'वही पोज़, वही जगह, वही रोशनी। एक साल बाद तुम्हें यक़ीन नहीं होगा।';

  @override
  String get timelineEmptyTitle => 'तुम्हारी पहली फ़ोटो से गिनती शुरू होती है';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n फ़ोटो',
      one: '1 फ़ोटो',
      zero: 'कोई फ़ोटो नहीं',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'सामने';

  @override
  String get poseSide => 'बगल';

  @override
  String get poseBack => 'पीछे';

  @override
  String get photoEvery => 'याद दिलाएँ';

  @override
  String photoEveryDays(int n) {
    return 'हर $n दिन';
  }

  @override
  String get photoEveryOff => 'कभी नहीं';

  @override
  String get timelineEvery => 'हर इतने में समूह';

  @override
  String get custom => 'कस्टम';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'अगली फ़ोटो $n दिन में',
      one: 'अगली फ़ोटो कल',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'फ़ोटो का समय: आज ले लो';

  @override
  String get addTodayPhotos => 'आज की फ़ोटो जोड़ें';

  @override
  String posePhoto(String pose) {
    return '$pose फ़ोटो';
  }

  @override
  String get compare => 'तुलना';

  @override
  String get compareNeedTwo => 'तुम्हारी अगली फ़ोटो यहाँ पहले और बाद दिखाएगी।';

  @override
  String dayNumber(int n) {
    return 'दिन $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n दिन का अंतर',
      one: '1 दिन का अंतर',
      zero: 'एक ही दिन',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'यह दिन हटाएँ';

  @override
  String get deleteDayBody => 'इसकी फ़ोटो भी हमेशा के लिए चली जाएँगी।';

  @override
  String get timelinePhotos => 'फ़ोटो';

  @override
  String get timelineBody => 'मसल मैप';

  @override
  String get timelineBodyEmpty =>
      'एक सेशन दर्ज करो और तुम्हारा मसल मैप यहाँ भरने लगेगा, फ़ोटो की ज़रूरत नहीं।';

  @override
  String get timelineBodyHint => 'तुम्हारे अपने सेट से बना, कुछ अपलोड नहीं होता।';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n सेशन',
      one: '1 सेशन',
      zero: 'कोई सेशन नहीं',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'प्रगति फ़ोटो';

  @override
  String get notifPhotoChannelWhy => 'अगली प्रगति फ़ोटो का समय होने पर याद दिलाता है।';

  @override
  String get notifPhotoTitle => 'प्रगति फ़ोटो का समय';

  @override
  String notifPhotoBody(int n) {
    return 'पिछली के बाद $n दिन हो गए। वही पोज़, वही रोशनी।';
  }

  @override
  String get share => 'शेयर करें';

  @override
  String get sharePick => 'क्या दिखाना चाहते हो?';

  @override
  String get shareStreak => 'स्ट्रीक और निरंतरता';

  @override
  String get shareBody => 'जिन मांसपेशियों पर काम हुआ';

  @override
  String get shareCompare => 'पहले और बाद';

  @override
  String get shareHint => 'कार्ड तुम्हारे फ़ोन पर बनता है। जब तक तुम जगह न चुनो, कुछ बाहर नहीं जाता।';

  @override
  String get shareFailed => 'कार्ड नहीं बन पाया';

  @override
  String get shareWeekOf => 'पिछले 7 दिन';

  @override
  String get shareStreakLabel => 'दिन की स्ट्रीक';

  @override
  String get shareSessionsLabel => 'सेशन';

  @override
  String get shareVolumeLabel => 'वॉल्यूम';

  @override
  String get restForExercise => 'इस एक्सरसाइज़ का आराम';

  @override
  String get restUsingDefault => 'तुम्हारा डिफ़ॉल्ट';

  @override
  String get restCustom => 'सिर्फ़ इसके लिए';

  @override
  String get setType => 'सेट का प्रकार';

  @override
  String get setTypeNormal => 'वर्किंग';

  @override
  String get setTypeWarmup => 'वार्म-अप';

  @override
  String get setTypeDrop => 'ड्रॉप सेट';

  @override
  String get setTypeFailure => 'फ़ेलियर तक';

  @override
  String get addWarmup => 'वार्म-अप';

  @override
  String platesPerSide(String plates) {
    return 'हर तरफ़: $plates';
  }

  @override
  String get howTo => 'कैसे करें';

  @override
  String get similar => 'मिलती-जुलती';

  @override
  String get primaryLabel => 'मुख्य';

  @override
  String get secondaryLabel => 'सहायक';

  @override
  String get none => 'कोई नहीं';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n सेट', one: '$n सेट');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v वॉल्यूम';
  }

  @override
  String get weeklyPlan => 'साप्ताहिक प्लान';

  @override
  String get yourRoutines => 'तुम्हारे रूटीन';

  @override
  String get noRoutines => 'अभी कोई रूटीन नहीं। एक बनाओ और अपनी एक्सरसाइज़ जोड़ो।';

  @override
  String get newRoutine => 'नया रूटीन';

  @override
  String get routineName => 'रूटीन का नाम';

  @override
  String get schedule => 'शेड्यूल';

  @override
  String get addFromList => 'नीचे की सूची से एक्सरसाइज़ जोड़ो।';

  @override
  String get addExercises => 'एक्सरसाइज़ जोड़ें';

  @override
  String get deleteRoutine => 'यह रूटीन हटाएँ?';

  @override
  String exercisesWithCount(int n) {
    return 'एक्सरसाइज़ · $n';
  }

  @override
  String setDay(String day) {
    return '$day तय करें';
  }

  @override
  String get newRoutineName => 'नया रूटीन';

  @override
  String get dragToReorder => 'क्रम बदलने के लिए डॉट वाले हैंडल को खींचो, इसी क्रम में तुम ट्रेनिंग करोगे।';

  @override
  String reorderHandle(String name) {
    return '$name का क्रम बदलें';
  }

  @override
  String get removeFromRoutine => 'रूटीन से हटाएँ';

  @override
  String get dropExercise => 'यह एक्सरसाइज़ हटाएँ?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" इस वर्कआउट से हट जाएगी। जो दर्ज है वह नहीं खोएगा।';
  }

  @override
  String get drop => 'हटाएँ';

  @override
  String get resetData => 'मेरा सारा डेटा हटाएँ';

  @override
  String get resetTitle => 'सब कुछ हटाएँ?';

  @override
  String get resetBody =>
      'सेशन, रिकॉर्ड, रूटीन, नोट्स और प्रोफ़ाइल। यह वापस नहीं होगा: अगर बाद में चाहिए हो सकता है तो पहले बैकअप एक्सपोर्ट कर लो।';

  @override
  String get resetConfirm => 'सब हटाएँ';

  @override
  String get resetDone => 'सारा डेटा हटा दिया गया';

  @override
  String get support => 'सपोर्ट';

  @override
  String get reportBug => 'बग की रिपोर्ट करें';

  @override
  String get requestFeature => 'फ़ीचर माँगें';

  @override
  String get starOnGithub => 'GitHub पर स्टार दें';

  @override
  String get buyCoffee => 'मुझे कॉफ़ी पिलाओ';

  @override
  String get cantOpenLink => 'लिंक नहीं खुल पाया';

  @override
  String get theme => 'थीम';

  @override
  String get darkTheme => 'डार्क';

  @override
  String get lightTheme => 'लाइट';

  @override
  String get amoledTheme => 'AMOLED ब्लैक';

  @override
  String get editDuration => 'वर्कआउट की अवधि';

  @override
  String get sessionName => 'वर्कआउट का नाम';

  @override
  String get nameWorkout => 'नाम दो';

  @override
  String get sessionNameHint => 'जैसे लेग्स, पुश, फ़ुल बॉडी';

  @override
  String get secondaryPickHint => 'उन बाकी मांसपेशियों पर टैप करो जिन पर यह एक्सरसाइज़ काम करती है।';

  @override
  String get languageLabel => 'भाषा';

  @override
  String get unitsLabel => 'इकाइयाँ';

  @override
  String get restTimer => 'आराम टाइमर';

  @override
  String get alarmBlockedTitle => 'नोटिफ़िकेशन बंद हैं';

  @override
  String get alarmBlockedBody => 'स्क्रीन लॉक होने पर आराम का अलार्म नहीं बजेगा';

  @override
  String get alarmBlockedAction => 'चालू करें';

  @override
  String get alarmSound => 'अलार्म की आवाज़';

  @override
  String get alarmDefaultName => 'डिफ़ॉल्ट';

  @override
  String get alarmSoundHint => 'अपनी आवाज़ लगाओ, 15 सेकंड तक';

  @override
  String get alarmChoose => 'आवाज़ चुनो…';

  @override
  String get alarmPreview => 'मौजूदा आवाज़ चलाएँ';

  @override
  String get alarmReset => 'डिफ़ॉल्ट पर लौटें';

  @override
  String get alarmTooLong => 'वह आवाज़ 15 सेकंड से लंबी है';

  @override
  String get alarmInvalid => 'वह ऑडियो फ़ाइल नहीं पढ़ी जा सकी';

  @override
  String alarmChanged(String name) {
    return 'अलार्म की आवाज़ \"$name\" पर सेट';
  }

  @override
  String get alarmChangedDefault => 'डिफ़ॉल्ट आवाज़ पर वापस';

  @override
  String get addActivityWidget => 'एक्टिविटी विजेट जोड़ें';

  @override
  String get addStatsWidget => 'आँकड़ों का विजेट जोड़ें';

  @override
  String get pinUnsupported => 'इसे अपने लॉन्चर के विजेट मेन्यू से जोड़ो';

  @override
  String get background => 'बैकग्राउंड';

  @override
  String get bgNone => 'कोई नहीं';

  @override
  String get bgDots => 'बिंदु';

  @override
  String get bgGrid => 'ग्रिड';

  @override
  String get exportCsv => 'वर्कआउट एक्सपोर्ट करें (CSV)';

  @override
  String get exportBackup => 'बैकअप एक्सपोर्ट करें (ZIP)';

  @override
  String get importBackup => 'बैकअप इंपोर्ट करें';

  @override
  String get importHint =>
      'GymMane से एक्सपोर्ट किया गया .zip (या पुराना .json) बैकअप चुनो। इससे तुम्हारा मौजूदा डेटा, मीडिया समेत, बदल जाएगा।';

  @override
  String get import => 'इंपोर्ट करें';

  @override
  String get chooseFile => 'फ़ाइल चुनें';

  @override
  String get importFromApp => 'दूसरे ऐप से इंपोर्ट करें';

  @override
  String get importUnknownFormat => 'उस फ़ाइल में तारीख़, एक्सरसाइज़, रेप्स और वज़न के कॉलम चाहिए';

  @override
  String get importZipNoWeights => 'उस zip में वज़न की कोई फ़ाइल नहीं है';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n वज़न इंपोर्ट हुए',
      one: '$n वज़न इंपोर्ट हुआ',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'वह फ़ाइल नहीं पढ़ी जा सकी';

  @override
  String get importUnitTitle => 'उस फ़ाइल में कौन-सी इकाई है?';

  @override
  String get importUnitBody => 'यह एक्सपोर्ट नहीं बताता कि वज़न किस इकाई में हैं।';

  @override
  String get importNothing => 'इंपोर्ट करने को कुछ नया नहीं';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n सेशन इंपोर्ट हुए',
      one: '$n सेशन इंपोर्ट हुआ',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'GymMane के बारे में';

  @override
  String get yourProfile => 'तुम्हारी प्रोफ़ाइल';

  @override
  String get autofills => 'कैलकुलेटर अपने-आप भरता है';

  @override
  String get onbUnitsWhy => 'वज़न, माप और दूरी के लिए। सेटिंग्स में कभी भी बदल सकते हो।';

  @override
  String get nameLabel => 'नाम';

  @override
  String get sexLabel => 'लिंग';

  @override
  String get macroProtein => 'प्रोटीन';

  @override
  String get macroCarbs => 'कार्ब्स';

  @override
  String get macroFat => 'फ़ैट';

  @override
  String get male => 'पुरुष';

  @override
  String get female => 'महिला';

  @override
  String get ageLabel => 'उम्र';

  @override
  String get heightLabel => 'लंबाई';

  @override
  String get weightLabel => 'वज़न';

  @override
  String get weeklyGoal => 'साप्ताहिक लक्ष्य';

  @override
  String get activityLabel => 'एक्टिविटी';

  @override
  String get addPhoto => 'फ़ोटो जोड़ें';

  @override
  String get removePhoto => 'फ़ोटो हटाएँ';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get chooseGallery => 'गैलरी से चुनें';

  @override
  String get backupImported => 'बैकअप इंपोर्ट हुआ';

  @override
  String get backupFailed => 'वह बैकअप नहीं पढ़ा जा सका';

  @override
  String get nothingToExport => 'अभी एक्सपोर्ट करने को कुछ नहीं: पहले एक सेशन दर्ज करो';

  @override
  String calculatorsCount(int n) {
    return 'तुम्हारी ट्रेनिंग के लिए $n कैलकुलेटर';
  }

  @override
  String get result => 'नतीजा';

  @override
  String get weightLifted => 'उठाया गया वज़न';

  @override
  String get repsPerformed => 'किए गए रेप्स';

  @override
  String get neck => 'गर्दन';

  @override
  String get waist => 'कमर';

  @override
  String get hip => 'कूल्हा (महिलाओं के लिए)';

  @override
  String get targetWeight => 'लक्ष्य वज़न';

  @override
  String get workingWeight => 'वर्किंग वज़न';

  @override
  String get activityLevel => 'एक्टिविटी स्तर';

  @override
  String get barWeight => 'बार का वज़न';

  @override
  String get perSide => 'हर तरफ़';

  @override
  String get justTheBar => 'सिर्फ़ बार।';

  @override
  String perSideCount(int n) {
    return '× $n हर तरफ़';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'कैलोरी';

  @override
  String get toolNameBf => 'बॉडी फ़ैट';

  @override
  String get toolNamePlate => 'प्लेट्स';

  @override
  String get toolNameWarmup => 'वार्म-अप';

  @override
  String get toolTitleRm => '1RM कैलकुलेटर';

  @override
  String get toolTitleBmi => 'BMI कैलकुलेटर';

  @override
  String get toolTitleCal => 'कैलोरी और मैक्रोज़';

  @override
  String get toolTitleBf => 'बॉडी फ़ैट %';

  @override
  String get toolTitlePlate => 'प्लेट कैलकुलेटर';

  @override
  String get toolTitleWarmup => 'वार्म-अप सेट';

  @override
  String get toolHintRm => 'अनुमानित 1-रेप मैक्स (Epley फ़ॉर्मूला)';

  @override
  String get toolHintCal => 'अनुमानित रोज़ का मेंटेनेंस';

  @override
  String get toolHintBf => 'US Navy तरीक़े से अनुमान';

  @override
  String get toolHintPlate => 'बारबेल का कुल वज़न';

  @override
  String get toolHintWarmup => 'वर्किंग वज़न का लक्ष्य';

  @override
  String get toolDescRm => 'अनुमानित वन-रेप मैक्स';

  @override
  String get toolDescBmi => 'बॉडी मास इंडेक्स';

  @override
  String get toolDescCal => 'कैलोरी और मैक्रोज़';

  @override
  String get toolDescBf => 'बॉडी फ़ैट प्रतिशत';

  @override
  String get toolDescPlate => 'बारबेल प्लेट कैलकुलेटर';

  @override
  String get toolDescWarmup => 'धीरे-धीरे बढ़ते सेट';

  @override
  String get bmiUnderweight => 'कम वज़न';

  @override
  String get bmiNormal => 'सामान्य';

  @override
  String get bmiOverweight => 'ज़्यादा वज़न';

  @override
  String get bmiObese => 'मोटापा';

  @override
  String get actSedentary => 'बैठे रहने वाला';

  @override
  String get actLight => 'हल्का';

  @override
  String get actActive => 'सक्रिय';

  @override
  String get actModerate => 'मध्यम';

  @override
  String get muscleChest => 'छाती';

  @override
  String get muscleBack => 'पीठ';

  @override
  String get muscleLowerBack => 'निचली पीठ';

  @override
  String get muscleShoulders => 'कंधे';

  @override
  String get muscleBiceps => 'बाइसेप्स';

  @override
  String get muscleTriceps => 'ट्राइसेप्स';

  @override
  String get muscleForearm => 'अग्रबाहु';

  @override
  String get muscleTrapezius => 'ट्रैपेज़ियस';

  @override
  String get muscleAbdomen => 'पेट';

  @override
  String get muscleObliques => 'ऑब्लिक्स';

  @override
  String get muscleQuads => 'क्वाड्स';

  @override
  String get muscleHamstrings => 'हैमस्ट्रिंग';

  @override
  String get muscleGlutes => 'ग्लूट्स';

  @override
  String get muscleCalves => 'पिंडलियाँ';

  @override
  String get mgChest => 'छाती';

  @override
  String get mgBack => 'पीठ';

  @override
  String get mgLegs => 'पैर';

  @override
  String get mgShoulders => 'कंधे';

  @override
  String get mgArms => 'बाँहें';

  @override
  String get mgCore => 'कोर';

  @override
  String get equipBarbell => 'बारबेल';

  @override
  String get equipDumbbell => 'डम्बल';

  @override
  String get equipCable => 'केबल';

  @override
  String get equipMachine => 'मशीन';

  @override
  String get equipBodyweight => 'बॉडीवेट';

  @override
  String get equipWeighted => 'वज़न के साथ';

  @override
  String get equipBand => 'बैंड';

  @override
  String get equipKettlebell => 'केटलबेल';

  @override
  String get equipRings => 'रिंग्स';

  @override
  String get equipOther => 'अन्य';

  @override
  String get diffBeginner => 'शुरुआती';

  @override
  String get diffAdvanced => 'एडवांस्ड';

  @override
  String get diffIntermediate => 'मध्यम';

  @override
  String get about => 'बारे में';

  @override
  String version(String v) {
    return 'वर्ज़न $v';
  }

  @override
  String get aboutBlurb => 'वज़न उठाने वालों ने, वज़न उठाने वालों के लिए बनाया।';

  @override
  String get freeForever => 'हमेशा मुफ़्त';

  @override
  String get freeForeverWhy => 'न सब्सक्रिप्शन, न विज्ञापन, कुछ भी पेवॉल के पीछे बंद नहीं।';

  @override
  String get fullyOffline => 'पूरी तरह ऑफ़लाइन';

  @override
  String get fullyOfflineWhy => 'न अकाउंट, न सर्वर। तुम्हारी ट्रेनिंग कभी इस फ़ोन से बाहर नहीं जाती।';

  @override
  String get yoursToTake => 'तुम्हारा डेटा तुम्हारा है';

  @override
  String get yoursToTakeWhy => 'जब चाहो CSV में एक्सपोर्ट करो, और एक टैप में सब हटा दो।';

  @override
  String get whatsInside => 'अंदर क्या है';

  @override
  String exercisesInside(int n) {
    return '$n एक्सरसाइज़';
  }

  @override
  String get exercisesInsideWhy => 'हर एक के साथ एनिमेशन और क़दम-दर-क़दम निर्देश।';

  @override
  String get calculatorsInside => '10 कैलकुलेटर';

  @override
  String get calculatorsInsideWhy =>
      '1RM, प्लेट्स, BMI, कैलोरी, बॉडी फ़ैट, FFMI, वार्म-अप, RPE लोड, और DOTS व Wilks स्ट्रेंथ स्कोर, सब प्रकाशित फ़ॉर्मूलों के साथ।';

  @override
  String get mathInside => 'ईमानदार हिसाब';

  @override
  String get mathInsideWhy =>
      'वॉल्यूम, रिकॉर्ड और स्ट्रीक तुम्हारे अपने सेट से आते हैं। यहाँ कुछ भी सिर्फ़ सजावट नहीं।';

  @override
  String get streakCaps => 'स्ट्रीक';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'दिन', one: 'दिन');
    return '$_temp0';
  }

  @override
  String get reset => 'रीसेट';

  @override
  String get welcomeKicker => 'स्वागत है';

  @override
  String get welcomeBlurb => 'सब कुछ तुम्हारे फ़ोन पर रहता है। न अकाउंट, न इंटरनेट, न कोई पैसा।';

  @override
  String get welcomeStart => 'शुरू करें';

  @override
  String onbStep(int i, int n) {
    return 'चरण $i / $n';
  }

  @override
  String get onbNameTitle => 'तुम्हें क्या बुलाएँ?';

  @override
  String get onbNameHint => 'तुम्हारा नाम';

  @override
  String get onbPhotoAdd => 'फ़ोटो जोड़ें';

  @override
  String get onbPhotoChange => 'फ़ोटो बदलें';

  @override
  String get onbPhotoTitle => 'अपनी प्रोफ़ाइल को चेहरा दो';

  @override
  String get onbPhotoWhy => 'वैकल्पिक। यह तुम्हारे फ़ोन पर रहती है और प्रोफ़ाइल से कभी भी बदल सकते हो।';

  @override
  String get onbPhotoLater => 'बाद में';

  @override
  String get onbNameWhy => 'सिर्फ़ तुम्हें नमस्ते कहने के लिए। यह फ़ोन से कभी बाहर नहीं जाता।';

  @override
  String get onbBodyTitle => 'कुछ आँकड़े';

  @override
  String get onbBodyWhy => 'ये कैलकुलेटर में काम आते हैं। सेटिंग्स में कभी भी बदल सकते हो।';

  @override
  String get onbGoalTitle => 'कितनी बार ट्रेनिंग करते हो?';

  @override
  String get onbGoalWhy => 'तुम्हारे साप्ताहिक लक्ष्य की रिंग तय करता है। ईमानदार रहो, महत्वाकांक्षी नहीं।';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'हफ़्ते में $n सेशन',
      one: 'हफ़्ते में $n सेशन',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'किलो या पाउंड?';

  @override
  String get next => 'आगे';

  @override
  String get back => 'वापस';

  @override
  String get skip2 => 'छोड़ें';

  @override
  String get madeWithLoveBy => 'प्यार से बनाया';

  @override
  String get sourceCode => 'सोर्स कोड';

  @override
  String get suggested => 'सुझाए गए';

  @override
  String get results => 'नतीजे';

  @override
  String get noMatches => 'इस खोज से कोई एक्सरसाइज़ मेल नहीं खाती।';

  @override
  String get tapToEdit => 'एंट्री ठीक करने के लिए पेंसिल पर, हटाने के लिए डिब्बे पर टैप करो।';

  @override
  String get editEntry => 'बदलें';

  @override
  String get editEntryHint => 'किसी भी सेट के रेप्स या वज़न ठीक करो।';

  @override
  String get removeSet => 'सेट हटाएँ';

  @override
  String get continueWorkout => 'जारी रखें';

  @override
  String get continueWorkoutBody =>
      'वर्कआउट फिर से जारी हो जाएगा, पहले से टिक किए सेट के साथ। दोबारा ख़त्म करने पर यह अपने मूल दिन पर सेव होगा।';

  @override
  String get addBodyWidget => 'मसल मैप विजेट जोड़ें';

  @override
  String get repsOnly => 'सिर्फ़ रेप्स';

  @override
  String get repsOnlyHint => 'इस एक्सरसाइज़ को बिना वज़न दर्ज करो।';

  @override
  String get eachSide => 'हर तरफ़';

  @override
  String get eachSideHint => 'टाइमर हर तरफ़ एक बार चलता है और दोनों के बाद आराम शुरू होता है।';

  @override
  String get useDefaultArt => 'डिफ़ॉल्ट चित्र पर लौटें';

  @override
  String daysShort(int n) {
    return '$nदि';
  }

  @override
  String get focusCard => 'आज का फ़ोकस';

  @override
  String get autoAdvance => 'अपने-आप आगे बढ़ें';

  @override
  String get keepScreenOn => 'ट्रेनिंग के दौरान स्क्रीन चालू रखें';

  @override
  String get lockWorkout => 'स्क्रीन लॉक करें';

  @override
  String get unlockWorkout => 'अनलॉक करें';

  @override
  String get holdToUnlock => 'अनलॉक करने के लिए दबाकर रखें';

  @override
  String get liveChannel => 'चल रहा वर्कआउट';

  @override
  String get liveChannelWhy => 'ट्रेनिंग के दौरान मौजूदा एक्सरसाइज़, सेट और आराम टाइमर दिखाता है';

  @override
  String liveSet(int n, int total) {
    return 'सेट $n / $total';
  }

  @override
  String get liveResting => 'आराम';

  @override
  String get liveAllDone => 'सभी सेट पूरे';

  @override
  String get autoAdvanceHint => 'आख़िरी सेट के बाद आगे बढ़ता है';

  @override
  String get placePlates => 'प्लेट्स और बार';

  @override
  String get platesAll => 'सब उपलब्ध';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n साइज़', one: '$n साइज़');
    return '$_temp0';
  }

  @override
  String get platePairs => 'जोड़ी';

  @override
  String plateAchievable(String w) {
    return 'सबसे क़रीब जो लगा सकते हो: $w';
  }

  @override
  String get autoWarmup => 'वार्म-अप सेट से शुरू करें';

  @override
  String get autoWarmupHint => 'वर्कआउट खुलते ही बढ़ते सेट जोड़ देता है।';

  @override
  String get trainReminder => 'ट्रेनिंग रिमाइंडर';

  @override
  String get trainReminderHint => 'इस समय एक याद, सिर्फ़ उन दिनों जब तुम्हारा रूटीन तय है।';

  @override
  String get reminderExactTime => 'सटीक समय';

  @override
  String get toastSoundSetting => 'सूचना की आवाज़';

  @override
  String get toastSoundHint => 'हर सूचना के साथ एक हल्की घंटी';

  @override
  String get notifTrainChannel => 'ट्रेनिंग रिमाइंडर';

  @override
  String get notifTrainChannelWhy => 'तय किए दिनों पर ट्रेनिंग की याद।';

  @override
  String get notifTrainTitle => 'ट्रेनिंग का समय';

  @override
  String get notifTrainBody => 'तुम्हारा रूटीन इंतज़ार कर रहा है।';

  @override
  String get planIntro => 'सिर्फ़ इस सूची की एक्सरसाइज़ से मेरे लिए एक ट्रेनिंग रूटीन बनाओ।';

  @override
  String get planFormat => 'सिर्फ़ JSON में जवाब दो, इस रूप में:';

  @override
  String get planNothing => 'उस फ़ाइल की कोई एक्सरसाइज़ तुम्हारी लाइब्रेरी से मेल नहीं खाती';

  @override
  String get planFailed => 'वह फ़ाइल ऐसा रूटीन नहीं जिसे हम पढ़ सकें';

  @override
  String get routineGroup => 'समूह';

  @override
  String get newGroup => 'नया समूह';

  @override
  String get noGroup => 'कोई समूह नहीं';

  @override
  String get groupNameHint => 'पुश / पुल / लेग्स, 5×5…';

  @override
  String get filters => 'फ़िल्टर';

  @override
  String get setsPlannedHint => 'हर एक के कितने सेट चाहिए, चुनो। वर्कआउट उन्हें तैयार रखकर खुलेगा।';

  @override
  String get nextTime => 'अगली बार';

  @override
  String get nextHold => 'वही वज़न जब तक हर रेप पूरा न हो';

  @override
  String get bgPhoto => 'तुम्हारी फ़ोटो';

  @override
  String get bgPhotoPick => 'फ़ोटो चुनें';

  @override
  String get bgPhotoChange => 'फ़ोटो बदलें';

  @override
  String get bgPhotoRemove => 'फ़ोटो हटाएँ';

  @override
  String get bgDim => 'कितना गहरा';

  @override
  String get dimSoft => 'हल्का';

  @override
  String get dimMedium => 'मध्यम';

  @override
  String get dimStrong => 'गहरा';

  @override
  String get bgPhotoHint => 'यह सबके पीछे रहती है, धुंधली ताकि ऐप पढ़ने लायक़ रहे।';

  @override
  String get reminderSmart => 'स्मार्ट';

  @override
  String get reminderFixed => 'तय समय';

  @override
  String get reminderSmartHint =>
      'उन दिनों और समय का इस्तेमाल करता है जब तुम सच में ट्रेनिंग करते हो, और जिस दिन ट्रेनिंग हो चुकी हो उस दिन चुप रहता है।';

  @override
  String get reminderSmartEmpty => 'कुछ और सेशन दर्ज करो और यह तुम्हारे दिन सीख लेगा।';

  @override
  String habitFocus(String day) {
    return 'जो तुम आमतौर पर $day को ट्रेन करते हो';
  }

  @override
  String get duplicateRoutine => 'रूटीन की कॉपी बनाएँ';

  @override
  String copySuffix(String name) {
    return '$name (कॉपी)';
  }

  @override
  String get saveAsRoutine => 'रूटीन के रूप में सेव करें';

  @override
  String get savedAsRoutine => 'रूटीन के रूप में सेव हुआ';

  @override
  String get templates => 'तैयार प्लान';

  @override
  String get templatesHint =>
      'क्लासिक प्रोग्राम, तुम्हारी अपनी लाइब्रेरी से बने। बाद में कुछ भी बदल सकते हो।';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n रूटीन जोड़े गए',
      one: '$n रूटीन जोड़ा गया',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'हफ़्ते में तीन फ़ुल-बॉडी दिन। शुरुआत के लिए यही।';

  @override
  String get tplPpl => 'पुश, पुल और लेग्स। हफ़्ते में तीन या छह दिन।';

  @override
  String get tplArnold => 'छाती और पीठ, कंधे और बाँहें, पैर। क्लासिक छह दिन का स्प्लिट।';

  @override
  String get tplUpperlower => 'ऊपरी और निचला शरीर, हफ़्ते में चार दिन।';

  @override
  String get tplStronglifts => 'दो वर्कआउट, पाँच के पाँच सेट, बारी-बारी से।';

  @override
  String get tplStartingstrength => 'हर सेशन में स्क्वाट, दो वर्कआउट बारी-बारी से।';

  @override
  String get tplHome => 'सिर्फ़ लटकने के लिए एक बार और फ़र्श।';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n दिन', one: '$n दिन');
    return '$_temp0';
  }

  @override
  String get logRpe => 'मेहनत दर्ज करें (RPE)';

  @override
  String get rpeHint => '10 यानी कुछ बाक़ी नहीं, 8 यानी दो रेप बचे थे।';

  @override
  String get superset => 'सुपरसेट';

  @override
  String get supersetLink => 'अगली से जोड़ें';

  @override
  String get supersetUnlink => 'अगली से अलग करें';

  @override
  String get supersetHint => 'जुड़ी एक्सरसाइज़ के बीच आराम नहीं, सीधे अगली पर।';

  @override
  String get aiRoutine => 'AI के साथ रूटीन';

  @override
  String get aiIntro =>
      'GymMane कभी किसी AI से बात नहीं करता। तुम अपनी एक्सरसाइज़ सूची निकालते हो, जिस असिस्टेंट को पहले से इस्तेमाल करते हो उसमें पेस्ट करते हो, और उसका जवाब वापस लाते हो। फ़ोन से अपने-आप कुछ बाहर नहीं जाता।';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n नाम तुम्हारी लाइब्रेरी में नहीं थे',
      one: '1 नाम तुम्हारी लाइब्रेरी में नहीं था',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'यह किन ऐप्स को पढ़ता है';

  @override
  String get importOtherCsv => 'तारीख़, एक्सरसाइज़, रेप्स और वज़न वाली कोई भी CSV';

  @override
  String get importAskApp => 'कोई और ऐप चाहिए? माँग लो';

  @override
  String get awardFirstStepName => 'पहला क़दम';

  @override
  String get awardFirstStepLine => 'GymMane में स्वागत है। यह हमारी तरफ़ से।';

  @override
  String get awardFirstWorkoutName => 'पहला वर्कआउट';

  @override
  String get awardFirstWorkoutLine => 'पहला दर्ज हो गया। वही सबसे मुश्किल होता है।';

  @override
  String get awardFirstRoutineName => 'पहला रूटीन';

  @override
  String get awardFirstRoutineLine => 'अब तुम्हारे पास लौटने के लिए एक प्लान है।';

  @override
  String get awardFirstRecordName => 'पहला रिकॉर्ड';

  @override
  String get awardFirstRecordLine => 'तुमने किसी एक्सरसाइज़ में अपना सबसे अच्छा लिफ़्ट तोड़ा।';

  @override
  String get awardStreak3Name => 'लगातार तीन';

  @override
  String get awardStreak3Line => 'लगातार तीन दिन। ऐसे ही शुरुआत होती है।';

  @override
  String get awardTonne1Name => 'एक टन';

  @override
  String get awardTonne1Line => 'तुम्हारे सेट में मिलाकर एक हज़ार किलो उठाया।';

  @override
  String get awardSets100Name => 'सौ सेट';

  @override
  String get awardSets100Line => 'सौ सेट पूरे, एक-एक करके।';

  @override
  String get awardHours10Name => 'दस घंटे';

  @override
  String get awardHours10Line => 'घड़ी पर दस घंटे की ट्रेनिंग।';

  @override
  String get awardWorkouts50Name => 'पचास वर्कआउट';

  @override
  String get awardWorkouts50Line => 'पचास सेशन पीछे छोड़ दिए।';

  @override
  String get awardHours50Name => 'पचास घंटे';

  @override
  String get awardHours50Line => 'जिम के अंदर पचास घंटे।';

  @override
  String get awardsTitle => 'मेडल';

  @override
  String get yearTitle => 'तुम्हारा साल';

  @override
  String get yearBestMonth => 'सबसे अच्छा महीना';

  @override
  String get yearMonths => 'महीने';

  @override
  String get awardSpinHint => 'मेडल घुमाने के लिए खींचो';

  @override
  String get awardUnlocked => 'नई उपलब्धि मिली';

  @override
  String get awardNice => 'शानदार!';

  @override
  String get awardSaveImage => 'इमेज सेव करें';

  @override
  String get awardSaved => 'गैलरी में सेव हुआ';

  @override
  String get awardStreak7Name => 'सात दिन';

  @override
  String get awardStreak7Line => 'एक भी दिन छोड़े बिना पूरा हफ़्ता।';

  @override
  String get awardStreak30Name => 'तीस दिन';

  @override
  String get awardStreak30Line => 'लगातार एक महीना। अब यह आदत है।';

  @override
  String get awardWorkouts100Name => 'सौ वर्कआउट';

  @override
  String get awardWorkouts100Line => 'सौ सेशन दर्ज, शुरू से आख़िर तक।';

  @override
  String get awardTonnes100Name => 'सौ टन';

  @override
  String get awardTonnes100Line => 'तुमने जो कुछ उठाया, सब मिलाकर 1,00,000 किलो।';

  @override
  String get awardSets1000Name => 'हज़ार सेट';

  @override
  String get awardSets1000Line => 'एक-एक सेट करके, पूरे हज़ार।';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get editProfile => 'प्रोफ़ाइल बदलें';

  @override
  String get pickBadge => 'बैज';

  @override
  String get statWorkouts => 'वर्कआउट';

  @override
  String get statTrained => 'ट्रेनिंग';

  @override
  String get statSets => 'सेट';

  @override
  String get statLifted => 'उठाया';

  @override
  String get statStreak => 'स्ट्रीक';

  @override
  String get statDays => 'दिन';

  @override
  String get unitHours => 'घं';

  @override
  String get unitDays => 'दिन';

  @override
  String get snapshots => 'फ़ोटो';

  @override
  String get snapNow => 'एक लो';

  @override
  String get addCover => 'कवर जोड़ें';

  @override
  String get addTodayWidget => 'आज हुआ या नहीं';

  @override
  String get photosCard => 'तुम्हारी फ़ोटो';

  @override
  String get handleLabel => 'यूज़रनेम';

  @override
  String get setupTitle => 'ये भरो और बाक़ी पेज अपने-आप भर जाएगा';

  @override
  String get setupHint =>
      'यहाँ का हर आँकड़ा तुम्हारी दर्ज की गई चीज़ों से आता है। कुछ भी कहीं नहीं भेजा जाता।';

  @override
  String get setupWorkout => 'अपना पहला वर्कआउट दर्ज करो';

  @override
  String get setupWeight => 'अपना वज़न लिखो';

  @override
  String get setupMeasures => 'अपने माप लो';

  @override
  String get setupPhoto => 'अपनी पहली प्रगति फ़ोटो लो';

  @override
  String get progressTitle => 'प्रगति';

  @override
  String get tileVolume30 => 'वॉल्यूम · 30दि';

  @override
  String get tileAddWeight => 'अपना जोड़ो';

  @override
  String get heatToneTitle => 'हीट का रंग';

  @override
  String get heatToneHint => 'सिर्फ़ ग्रिड और शरीर का रंग बदलता है।';

  @override
  String get thisWeekTitle => 'इस हफ़्ते';

  @override
  String get momentsEmptyTitle => 'अभी यहाँ कुछ नहीं';

  @override
  String get deletePhotoTitle => 'यह फ़ोटो हटाएँ?';

  @override
  String get deletePhotoBody => 'यह हमेशा के लिए चली जाएगी।';

  @override
  String get awardsEarned => 'मिले';

  @override
  String get awardsLocked => 'बंद';

  @override
  String get awardStreak100Name => 'सौ दिन';

  @override
  String get awardWorkouts10Name => 'दस वर्कआउट';

  @override
  String get awardWorkouts10Line => 'पहले दस ही तय करते हैं।';

  @override
  String get awardWorkouts365Name => 'तीन सौ पैंसठ';

  @override
  String get awardWorkouts365Line => 'साल के हर दिन के बराबर एक वर्कआउट, एक-एक करके दर्ज।';

  @override
  String get awardTonnes10Name => 'दस टन';

  @override
  String get awardTonnes10Line => 'दस हज़ार किलो तुम्हारे हाथों से गुज़रा।';

  @override
  String get awardHours100Name => 'सौ घंटे';

  @override
  String get awardHours100Line => 'बार के नीचे सौ घंटे, हाथ में स्टॉपवॉच।';

  @override
  String awardWonOn(String date) {
    return '$date को मिला';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'सोना',
      'blue': 'नीला',
      'green': 'हरा',
      'other': 'बैज',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '$date से';
  }

  @override
  String levelShort(int n) {
    return 'लेवल $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'लेवल $next तक $n वर्कआउट',
      one: 'लेवल $next तक 1 वर्कआउट',
    );
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n सेमी';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'अंगार',
      'green': 'हरा',
      'blue': 'नीला',
      'mono': 'स्लेटी',
      'other': 'रंग',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n सेट';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return 'इस हफ़्ते $goal में से $n';
  }

  @override
  String momentCount(int n) {
    return '$n फ़ोटो';
  }

  @override
  String photosSelected(int n) {
    return '$n चुनी गईं';
  }

  @override
  String deletePhotosTitle(int n) {
    return '$n फ़ोटो हटाएँ?';
  }

  @override
  String get momentsEmptyHint =>
      'जिम, व्हाइटबोर्ड, प्लेटों की सेटिंग, कुछ भी जो याद रखना हो, उसकी फ़ोटो लो। ये फ़ोन पर रहती हैं और सिर्फ़ तुम देखते हो।';

  @override
  String get awardStreak100Line => 'लगातार सौ दिन। अब यह मोटिवेशन नहीं, यह तुम हो।';

  @override
  String get coverLabel => 'कवर';

  @override
  String get removeCover => 'कवर हटाएँ';

  @override
  String get startTitle => 'वर्कआउट शुरू करें';

  @override
  String get logTitle => 'वर्कआउट दर्ज करें';

  @override
  String get logHint => 'कोई टाइमर नहीं, बस जो किया वह भरो।';

  @override
  String get orStartFrom => 'या यहाँ से शुरू करो';

  @override
  String get pickExercisesOption => 'एक्सरसाइज़ चुनो';

  @override
  String get chooseFocusOption => 'फ़ोकस चुनो';

  @override
  String get plannedRoutine => 'तय';

  @override
  String get logWorkoutAction => 'वर्कआउट दर्ज करें';

  @override
  String get logging => 'दर्ज हो रहा है';

  @override
  String get placesLabel => 'मेरी जगहें';

  @override
  String get undo => 'वापस लें';

  @override
  String get deleteSet => 'सेट हटाएँ';

  @override
  String get setDeleted => 'सेट हटाया गया';

  @override
  String get removeWarmup => 'वार्म-अप हटाएँ';

  @override
  String get addWeightAction => 'वज़न जोड़ें';

  @override
  String get workoutOverview => 'यह वर्कआउट';

  @override
  String get allExercisesShort => 'सब';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total सेट';
  }

  @override
  String get nowLabel => 'अभी';

  @override
  String get deleteWorkout => 'वर्कआउट हटाएँ';

  @override
  String get deleteWorkoutBody => 'यह वर्कआउट और इसके सभी सेट तुम्हारे इतिहास से हट जाएँगे।';

  @override
  String get themeAuto => 'ऑटो';

  @override
  String get themeAutoHint => 'फ़ोन के हिसाब से';

  @override
  String get demoSizeTitle => 'ट्रेनिंग के दौरान एक्सरसाइज़ डेमो';

  @override
  String get demoLarge => 'बड़ा';

  @override
  String get demoSmall => 'छोटा';

  @override
  String get demoOff => 'छुपा';

  @override
  String get demoLoopTitle => 'डेमो एनिमेशन';

  @override
  String get demoLoopAlways => 'लूप';

  @override
  String get demoLoopShort => '10 सेकंड';

  @override
  String get demoLoopHint =>
      'लगभग 10 सेकंड चलता है और शुरुआती पोज़ पर रुकता है। फिर देखने के लिए डेमो पर टैप करो।';

  @override
  String get alarmStyleTitle => 'जब आराम ख़त्म हो';

  @override
  String get alarmStyleLoud => 'हमेशा बजे';

  @override
  String get alarmStyleQuiet => 'साइलेंट मोड माने';

  @override
  String get alarmStyleVibrate => 'सिर्फ़ वाइब्रेट';

  @override
  String get alarmStyleHint =>
      'हमेशा बजे अलार्म वॉल्यूम इस्तेमाल करता है, साइलेंट पर भी। साइलेंट मोड माने नोटिफ़िकेशन वॉल्यूम इस्तेमाल करता है और फ़ोन म्यूट हो तो सिर्फ़ वाइब्रेट करता है।';

  @override
  String get suggestedPicks => 'तुम्हारे लिए सुझाव';

  @override
  String get moreOptions => 'और विकल्प';

  @override
  String get suggestInWorkouts => 'क्विक वर्कआउट में सुझाएँ';

  @override
  String get suggestInWorkoutsHint =>
      'बंद करने पर यह तुम्हारे लिए किए चुनावों में नहीं आएगी। हाथ से फिर भी जोड़ सकते हो।';

  @override
  String get onbPlaceTitle => 'तुम कहाँ ट्रेनिंग करते हो?';

  @override
  String get onbPlaceWhy =>
      'हर वह जगह चुनो जहाँ ट्रेनिंग करते हो। हम हर जगह सिर्फ़ वही सुझाएँगे जो वहाँ कर सकते हो।';

  @override
  String get onbPlaceGear => 'वहाँ क्या-क्या है?';

  @override
  String distanceCol(String unit) {
    return 'दूरी ($unit)';
  }

  @override
  String get timeCol => 'समय';

  @override
  String get timePerSideCol => 'समय / तरफ़';

  @override
  String get timeMinutesTitle => 'समय (मिनट)';

  @override
  String get timeSecondsTitle => 'समय (सेकंड)';

  @override
  String distanceTitle(String unit) {
    return 'दूरी ($unit)';
  }

  @override
  String get holdLabel => 'होल्ड';

  @override
  String get stopLabel => 'रोकें';

  @override
  String startHold(String time) {
    return 'शुरू करें · $time';
  }

  @override
  String get exerciseTypeLabel => 'किस हिसाब से दर्ज करें';

  @override
  String get typeReps => 'रेप्स और वज़न';

  @override
  String get typeTime => 'समय';

  @override
  String get typeCardio => 'दूरी और समय';

  @override
  String get exerciseTypeHint =>
      'दौड़ या तैराकी जैसा कार्डियो दूरी और समय दर्ज करता है। प्लैंक जैसे होल्ड समय दर्ज करते हैं।';

  @override
  String get howToLabel => 'कैसे करें (वैकल्पिक)';

  @override
  String get howToHint => 'हर लाइन में एक क़दम';

  @override
  String get editExercise => 'एक्सरसाइज़ बदलें';

  @override
  String get saveChanges => 'बदलाव सेव करें';

  @override
  String get noStepsYet => 'अभी कोई क़दम नहीं। अपने लिखो ताकि याद रहे तुम इसे कैसे करते हो।';

  @override
  String get addSteps => 'क़दम लिखो';

  @override
  String get setTypeRestPause => 'रेस्ट-पॉज़';

  @override
  String get setTypeNormalInfo => 'सामान्य सेट। यह तुम्हारे वॉल्यूम और रिकॉर्ड में गिना जाता है।';

  @override
  String get setTypeWarmupInfo => 'तैयार होने के लिए हल्के सेट। ये वॉल्यूम या रिकॉर्ड में नहीं गिने जाते।';

  @override
  String get setTypeDropInfo => 'सेट के तुरंत बाद वज़न घटाओ और बिना आराम के जारी रखो।';

  @override
  String get setTypeFailureInfo =>
      'तब तक करो जब तक एक और साफ़ रेप न हो सके। जितने रेप सच में किए वही दर्ज करो।';

  @override
  String get setTypeRestPauseInfo => 'सेट के बाद 10 से 20 सेकंड आराम करो, फिर कुछ और रेप निकालो।';

  @override
  String get planFormatNotes =>
      'एक्सरसाइज़ के नाम ठीक वैसे ही लिखो जैसे सूची में हैं। \"sets\", \"reps\" (एक संख्या या \"8-12\" जैसी रेंज), \"weight\" (दी गई इकाई में), सेकंड में \"rest\" और \"days\" वैकल्पिक हैं। सूची में कार्डियो या समय वाली एक्सरसाइज़ के लिए \"reps\" की जगह \"time\" (सेकंड में, या \"30:00\" जैसा) और \"distance\" (किमी में) इस्तेमाल करो; हर सेट को अलग मान देने के लिए उन्हें \"plan\" में लिखो, हर सेट की एक एंट्री, उसके अपने \"reps\" और \"weight\" के साथ (वार्म-अप सेट के लिए \"type\": \"warmup\" जोड़ो)। \"superset\": true एक्सरसाइज़ को अगली से जोड़ता है। कई हफ़्तों के लिए रूटीन को \"weeks\" के अंदर समूह में रखो, दूसरे उदाहरण की तरह।';

  @override
  String get planSets => 'सेट तय करें';

  @override
  String get planSetsHint =>
      'हर सेट का प्रकार, रेप्स और वज़न चुनो। पिछले सेशन से शुरू करने के लिए वज़न को ऑटो पर छोड़ दो।';

  @override
  String get planHintReps => 'हर सेट का प्रकार और रेप्स चुनो। ऑटो पिछले सेशन से शुरू होता है।';

  @override
  String get planHintTime => 'हर सेट का प्रकार और समय चुनो। ऑटो पिछले सेशन से शुरू होता है।';

  @override
  String get planHintTimeWeight => 'हर सेट का प्रकार, समय और वज़न चुनो। ऑटो पिछले सेशन से शुरू होता है।';

  @override
  String get planHintCardio => 'हर सेट की दूरी और समय चुनो। ऑटो पिछले सेशन से शुरू होता है।';

  @override
  String get timeOnly => 'सिर्फ़ समय';

  @override
  String get autoValue => 'ऑटो';

  @override
  String get clearPlan => 'प्लान हटाएँ';

  @override
  String get shareRoutine => 'रूटीन शेयर करें';

  @override
  String get shareWeek => 'मेरा हफ़्ता शेयर करें';

  @override
  String get shareWeekHint => 'तुम्हारे सभी रूटीन और हर एक का दिन।';

  @override
  String shareMessage(String name) {
    return '$name: इसे जोड़ने के लिए फ़ाइल को GymMane से खोलो।';
  }

  @override
  String get importRoutines => 'रूटीन इंपोर्ट करें';

  @override
  String get importPasteHint => 'यहाँ रूटीन पेस्ट करो: GymMane से शेयर किया हुआ, AI का जवाब, JSON या CSV।';

  @override
  String get pasteAction => 'पेस्ट करें';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n रूटीन', one: '1 रूटीन');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'इसका साप्ताहिक शेड्यूल भी इस्तेमाल करें';

  @override
  String get useTheirScheduleHint => 'इसके लाए दिन उन दिनों के तुम्हारे प्लान की जगह ले लेंगे।';

  @override
  String get addToMyRoutines => 'मेरे रूटीन में जोड़ें';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n रूटीन जोड़े गए',
      one: '1 रूटीन जोड़ा गया',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'यहाँ GymMane के इंपोर्ट करने लायक़ कुछ नहीं';

  @override
  String get aiStepCopy =>
      'अनुरोध कॉपी करो। इसमें तुम्हारी एक्सरसाइज़ सूची और वह फ़ॉर्मेट है जिसे GymMane पढ़ता है।';

  @override
  String get aiStepAsk =>
      'इसे किसी भी AI में पेस्ट करो और बताओ क्या चाहिए: हफ़्ते में कितने दिन, लक्ष्य, कितने हफ़्ते।';

  @override
  String get aiStepPaste => 'उसका जवाब नीचे पेस्ट करो और इंपोर्ट करो। फ़ाइल की ज़रूरत नहीं।';

  @override
  String get copyForAi => 'AI के लिए कॉपी करें';

  @override
  String get copiedDone => 'कॉपी हुआ';

  @override
  String get aiPasteHint => 'AI का जवाब यहाँ पेस्ट करो';

  @override
  String get importAction => 'इंपोर्ट करें';

  @override
  String get showFormat => 'फ़ॉर्मेट देखें';

  @override
  String get shareAsFile => 'फ़ाइल के रूप में शेयर करें';

  @override
  String get recoveryTab => 'रिकवरी';

  @override
  String recoveryOverall(int pct) {
    return 'शरीर $pct% रिकवर';
  }

  @override
  String get recoveryAllFresh => 'सब रिकवर हो चुका है। कुछ भी ट्रेन करने के लिए अच्छा दिन।';

  @override
  String recoveryStill(String muscles) {
    return 'अभी रिकवर हो रहे हैं: $muscles';
  }

  @override
  String get recoveryTired => 'थकी हुई';

  @override
  String get recoveryFresh => 'ताज़ा';

  @override
  String get recoveryHint =>
      'मांसपेशी पर टैप करके देखो वह कितनी रिकवर हुई। हाल के सेट ज़्यादा मायने रखते हैं, और भारी वाले (RPE से) और भी ज़्यादा।';

  @override
  String recoveryPct(int pct) {
    return '$pct% रिकवर';
  }

  @override
  String readyInHours(int h) {
    return '~$h घं में तैयार';
  }

  @override
  String get tplAbcd => 'चार दिन: छाती और ट्राइसेप्स, पीठ और बाइसेप्स, पैर, कंधे और पेट।';

  @override
  String get tplAbcde => 'पाँच दिन, हर दिन एक मसल ग्रुप: छाती, पीठ, पैर, कंधे, बाँहें।';

  @override
  String get elapsedCaps => 'बीता';

  @override
  String get tapToChange => 'बदलने के लिए टैप करो';

  @override
  String get swipeToSkipHint => 'आराम छोड़ने के लिए टाइमर को बगल में स्वाइप करो।';

  @override
  String get screenLocked => 'स्क्रीन लॉक है';

  @override
  String get lockedHint => 'अनलॉक करने के लिए ऊपर के फ़िंगरप्रिंट को दबाकर रखो';

  @override
  String get liveDoneSet => 'सेट पूरा';

  @override
  String get liveSkipRest => 'आराम छोड़ें';

  @override
  String get livePause => 'रोकें';

  @override
  String get liveResume => 'जारी रखें';

  @override
  String get liveNext => 'अगला';

  @override
  String liveUpNext(String name) {
    return 'अगला: $name';
  }

  @override
  String get stickerOpen => 'फ़ोटो पर शेयर करें';

  @override
  String get stickerNoPhoto => 'बिना फ़ोटो';

  @override
  String get stickerWorkout => 'वर्कआउट';

  @override
  String get stickerStreak => 'स्ट्रीक';

  @override
  String get stickerDate => 'तारीख़';

  @override
  String get stickerHint => 'हिलाने के लिए खींचो, आकार बदलने या घुमाने के लिए पिंच करो';

  @override
  String get stickerSaved => 'गैलरी में सेव हुआ';

  @override
  String get stickerWeek => 'इस हफ़्ते';

  @override
  String get getReady => 'तैयार हो जाओ';

  @override
  String sideOfTwo(String n) {
    return 'तरफ़ $n / 2';
  }

  @override
  String get switchSides => 'तरफ़ बदलो';

  @override
  String get stickerGallery => 'गैलरी';

  @override
  String get stickerCamera => 'कैमरा';

  @override
  String get shareIntroTitle => 'यह रूटीन शेयर करें';

  @override
  String get shareIntroBody =>
      'इसे अपने पार्टनर, दोस्त या परिवार को भेजो। उन्हें एक छोटी फ़ाइल मिलेगी जो GymMane में खुलती है और एक टैप में जुड़ जाती है, सेट और वज़न के साथ।';

  @override
  String get removedFromRoutine => 'रूटीन से हटाया गया';

  @override
  String get radarTitle => 'पिछले 30 दिन';

  @override
  String get radarHint => 'देखो किन हिस्सों पर और काम चाहिए';

  @override
  String get radarEmpty => 'अपना संतुलन देखने के लिए कुछ दिन ट्रेनिंग करो';

  @override
  String get radarBalanced => 'अब तक अच्छा संतुलन';

  @override
  String radarFocus(String list) {
    return 'और चाहिए: $list';
  }

  @override
  String get countdownReady => 'तैयार हो जाओ';

  @override
  String get countdownSkip => 'अभी शुरू करने के लिए टैप करो';

  @override
  String get countdownSetting => 'शुरू करने से पहले उल्टी गिनती';

  @override
  String get effortSetting => 'हर सेट की मेहनत दर्ज करें';

  @override
  String get effortHint =>
      'RPE: 10 यानी कुछ बाक़ी नहीं, 8 यानी दो रेप बचे थे। RIR बचे हुए रेप गिनता है। जिस सेट में यह हो, अनुमानित 1RM RPE चार्ट इस्तेमाल करता है।';

  @override
  String get rirHint => '0 यानी कुछ बाक़ी नहीं, 2 यानी दो रेप बचे थे।';

  @override
  String get addWeekWidget => 'हफ़्ते का विजेट जोड़ें';

  @override
  String get gamificationSetting => 'मेडल और लेवल';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n रेप्स', one: '$n रेप');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'सबसे अच्छा सेट';

  @override
  String get weekStartSetting => 'हफ़्ता शुरू होता है';

  @override
  String get stepOutOfWorkout => 'रोकें और बाहर जाएँ';

  @override
  String get saveToRoutine => 'बदलाव रूटीन में सेव करें';

  @override
  String get routineUpdated => 'रूटीन अपडेट हुआ';

  @override
  String saveChangesTitle(String name) {
    return '$name में बदलाव सेव करें?';
  }

  @override
  String get saveChangesBody => 'अगली बार शुरू करने पर रूटीन में ये बदलाव होंगे।';

  @override
  String get routineOrderChanged => 'एक्सरसाइज़ का नया क्रम';

  @override
  String get mineOnly => 'तुम्हारी बनाई';

  @override
  String createNamed(String name) {
    return 'यहाँ नहीं? “$name” बनाओ';
  }

  @override
  String get orStartWith => 'या इससे शुरू करो';

  @override
  String get warmupFocus => 'वार्म-अप';

  @override
  String get warmupFocusHint => 'मोबिलिटी और एक्टिवेशन, सामान के साथ या बिना';

  @override
  String get cardioFocus => 'कार्डियो';

  @override
  String get cardioFocusHint => 'दौड़, साइकिल, रोइंग या रस्सी कूद, दूरी और समय से';

  @override
  String get homeRecommended => 'होम पर सुझाव';

  @override
  String get homeRoutines => 'होम पर रूटीन';

  @override
  String get homeRoutinesHint => 'हाल में किए गए पहले';

  @override
  String get homeWeekStats => 'होम पर इस हफ़्ते';

  @override
  String get homeWeekStatsHint => 'हफ़्ते का वॉल्यूम, सेट और PR';

  @override
  String get stepsSetting => 'Health Connect से क़दम';

  @override
  String get stepsSettingHint => 'होम पर आज के क़दम';

  @override
  String get stepsToday => 'आज के क़दम';

  @override
  String stepsOfGoal(String goal) {
    return '$goal में से';
  }

  @override
  String stepsTodayCount(String count) {
    return 'आज $count क़दम';
  }

  @override
  String get stepsGoal => 'रोज़ के क़दमों का लक्ष्य';

  @override
  String get stepsNoAccess => 'तुम्हारे क़दमों तक पहुँच नहीं';

  @override
  String get stepsGrant => 'Health Connect में अनुमति देने के लिए टैप करो';

  @override
  String get stepsInfoRead =>
      'यह सिर्फ़ तुम्हारे क़दमों की गिनती पढ़ता है। कभी कुछ और नहीं पढ़ता और न Health Connect में लिखता है।';

  @override
  String get stepsInfoLocal => 'तुम्हारे क़दम तुम्हारे फ़ोन पर रहते हैं। GymMane कभी इंटरनेट से नहीं जुड़ता।';

  @override
  String get stepsInfoOff => 'सेटिंग्स या Health Connect में कभी भी बंद करो।';

  @override
  String get stepsManage => 'अनुमति प्रबंधित करें';

  @override
  String get routineDoneToday => 'आज के लिए पूरा · शाबाश';

  @override
  String get trainAgain => 'फिर से ट्रेनिंग करें';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n दिन पहले',
      one: 'कल किया',
      zero: 'आज किया',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'आर्काइव';

  @override
  String get archiveExercise => 'एक्सरसाइज़ आर्काइव करें';

  @override
  String get restoreExercise => 'वापस लाएँ';

  @override
  String get archivedToast => 'एक्सरसाइज़ आर्काइव हुई';

  @override
  String get archivedToastHint => 'इसे एक्सरसाइज़ › आर्काइव में ढूँढो';

  @override
  String get archivedBanner => 'आर्काइव। यह सूचियों और सुझावों से बाहर रहती है; तुम्हारा इतिहास सुरक्षित है।';

  @override
  String get videoMarksHint => 'किसी क़दम पर रोको और पिन पर टैप करो, अगली बार सीधे वहाँ जाने के लिए।';

  @override
  String get videoMarkHere => 'यह क़दम यहाँ चिह्नित करें';

  @override
  String get sectionGeneral => 'सामान्य';

  @override
  String get sectionTraining => 'ट्रेनिंग';

  @override
  String get sectionAlerts => 'रिमाइंडर और अलार्म';

  @override
  String get sectionHome => 'होम';

  @override
  String get sectionWidgets => 'विजेट';

  @override
  String get sectionData => 'डेटा और बैकअप';

  @override
  String get multiPlanSetting => 'एक दिन में कई रूटीन';

  @override
  String get multiPlanHint => 'इस दिन के हर रूटीन पर टैप करो। वे उसी क्रम में चलेंगे जिसमें जोड़ोगे।';

  @override
  String routineOfDay(int n, int total) {
    return 'आज $total में से $n';
  }

  @override
  String get nextToday => 'आज अगला';

  @override
  String get planAboutMe => 'मेरे बारे में:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age साल, लंबाई $height, $weight।';
  }

  @override
  String planDays(int n) {
    return 'मुझे हफ़्ते में $n दिन ट्रेनिंग करनी है।';
  }

  @override
  String get planNoHistory =>
      'अभी कोई वर्कआउट दर्ज नहीं: मुझे शुरुआती मानो और वॉल्यूम व वज़न सावधानी से रखो।';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'पिछले 30 दिनों में $n वर्कआउट दर्ज।',
      one: 'पिछले 30 दिनों में 1 वर्कआउट दर्ज।',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'हाल के सबसे अच्छे सेट';

  @override
  String get planAskFirst =>
      'अगर तुम्हें मेरा लक्ष्य (ताक़त, मसल, फ़ैट कम करना या सामान्य फ़िटनेस) या हर सेशन कितना लंबा हो सकता है यह नहीं पता, तो पहले एक छोटे संदेश में पूछ लो। जवाब मिलने के बाद सिर्फ़ JSON में जवाब दो।';

  @override
  String get backToTop => 'ऊपर जाएँ';

  @override
  String get deleteExerciseTitle => 'यह एक्सरसाइज़ हटाएँ?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" तुम्हारी लाइब्रेरी और रूटीन से हट जाएगी। तुम्हारे पुराने सेट बने रहेंगे।';
  }

  @override
  String get exportForStravaHint =>
      'इसे ब्राउज़र में strava.com/upload/select पर अपलोड करो (Strava ऐप फ़ाइल इंपोर्ट नहीं कर सकता)। यह तुम्हारे सेट के साथ Weight Training के रूप में दिखेगा।';

  @override
  String get manualStartTime => 'शुरू होने का समय';

  @override
  String get manualDuration => 'अवधि';

  @override
  String get manualDurationUnset => 'अवधि जोड़ें';

  @override
  String get stravaRow => 'Strava पर एक्सपोर्ट करें (बीटा)';

  @override
  String get stravaBeta => 'बीटा';

  @override
  String get stravaIntro =>
      'Strava पर ले जाने के लिए एक वर्कआउट चुनो। तुम्हें एक .fit फ़ाइल मिलेगी: इसे ब्राउज़र में strava.com/upload/select पर अपलोड करो और यह तुम्हारे सेट के साथ Weight Training के रूप में दिखेगा।';

  @override
  String get stravaEmpty => 'अभी एक्सपोर्ट करने को कोई वर्कआउट नहीं।';

  @override
  String get tapToPause => 'रोकने के लिए टैप करो';

  @override
  String get holdPausedHint => 'रुका · जारी रखने के लिए टैप करो';

  @override
  String get finishHoldNow => 'सेट अभी ख़त्म करें';

  @override
  String get barWeightExercise => 'बार या स्लेज का वज़न';

  @override
  String get barWeightHint => 'प्लेट कैलकुलेटर इस्तेमाल करता है';

  @override
  String get barWeightCustom => 'तुम्हारा · रीसेट के लिए टैप करो';

  @override
  String get groupRename => 'समूह का नाम बदलें';

  @override
  String get groupUngroup => 'समूह हटाएँ, रूटीन रखें';

  @override
  String get groupDeleteAll => 'समूह और रूटीन हटाएँ';

  @override
  String groupDeleteTitle(String name) {
    return '“$name” हटाएँ?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count हट जाएँगे। तुम्हारा वर्कआउट इतिहास बना रहेगा।';
  }

  @override
  String get tplRr =>
      'r/bodyweightfitness का क्लासिक: हफ़्ते में तीन दिन फ़ुल बॉडी। आसान लगे तो एक क़दम ऊपर।';

  @override
  String get levelUpKicker => 'अगला क़दम';

  @override
  String levelUpBody(int reps, String name) {
    return '$name पर लगातार दो वर्कआउट में 3×$reps। अगले क़दम के लिए तैयार?';
  }

  @override
  String levelUpSwap(String routine) {
    return '$routine में बदलें';
  }

  @override
  String get levelUpSee => 'देखो कैसे करते हैं';

  @override
  String get levelUpLater => 'अभी नहीं';

  @override
  String get levelUpStay => 'यही रखें';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name अब $routine में है';
  }

  @override
  String get levelUpStayed => 'इसके लिए अब और लेवल-अप सुझाव नहीं';

  @override
  String get levelHintsSetting => 'अगला क़दम सुझाएँ';

  @override
  String get heatmapLabelsSetting => 'एक्टिविटी मैप पर दिन और महीने';

  @override
  String get rmPercent => 'प्रतिशत';

  @override
  String rmAtPercent(String pct) {
    return 'तुम्हारे मैक्स का $pct';
  }

  @override
  String get copyWorkout => 'टेक्स्ट के रूप में कॉपी करें';

  @override
  String get goalSet => 'लक्ष्य तय करें';

  @override
  String get goalTargetReps => 'लक्ष्य रेप्स';

  @override
  String goalToGo(String value) {
    return '$value बाक़ी';
  }

  @override
  String get goalReached => 'लक्ष्य पूरा';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n दिन बाक़ी', one: '1 दिन बाक़ी');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'तारीख़ निकल गई';

  @override
  String get goalDeadline => 'समय सीमा';

  @override
  String get goalNoDeadline => 'कोई समय सीमा नहीं';

  @override
  String get goalRemove => 'लक्ष्य हटाएँ';

  @override
  String get exerciseNameMissing => 'इसका नाम दो';

  @override
  String get aliasesLabel => 'दूसरे नाम (वैकल्पिक)';

  @override
  String get aliasesHint => 'दूसरे नाम, कॉमा से अलग';

  @override
  String alsoCalled(String names) {
    return 'यह भी: $names';
  }

  @override
  String get addToRoutine => 'रूटीन में जोड़ें';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n रूटीन में',
      one: '1 रूटीन में',
      zero: 'अभी किसी रूटीन में नहीं',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'पहले से इसमें है';

  @override
  String get restInRoutine => 'इस रूटीन में आराम';

  @override
  String get restInRoutineHint => 'एक्सरसाइज़ जैसा ही';

  @override
  String get restInRoutineReset => 'सिर्फ़ यहाँ · वापस लेने के लिए टैप करो';

  @override
  String get swapExercise => 'एक्सरसाइज़ बदलें';

  @override
  String get swapShort => 'बदलें';

  @override
  String swapHint(String name) {
    return '$name की जगह, सिर्फ़ आज के लिए। ख़त्म करने पर इसे रूटीन में रख सकते हो।';
  }

  @override
  String get swapKeepsDone => 'जो सेट कर चुके वे दर्ज रहेंगे; नई एक्सरसाइज़ बाक़ी संभालेगी।';

  @override
  String swapSameMuscle(String muscle) {
    return 'वही मांसपेशी · $muscle';
  }

  @override
  String get swapDoneBefore => 'पहले की है';

  @override
  String get multiPlanSettingHint => 'एक ही दिन में एक से ज़्यादा रूटीन';

  @override
  String get levelHintsHint => 'कठिन वर्ज़न सुझाता है';

  @override
  String get focusCardHint => 'आज का रूटीन, होम में सबसे ऊपर';

  @override
  String get gamificationHint => 'मेडल, लेवल और जश्न';

  @override
  String get exerciseSettings => 'इस एक्सरसाइज़ की सेटिंग्स';

  @override
  String get placeActiveNow => 'तुम यहाँ हो';

  @override
  String get placeTapToUse => 'यहाँ ट्रेनिंग के लिए टैप करो';

  @override
  String get intervalDays => 'दिन';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target दिन';
  }

  @override
  String get toolNameRpe => 'RPE लोड';

  @override
  String get toolTitleRpe => 'RPE के हिसाब से लोड';

  @override
  String get toolDescRpe => 'चाही गई मेहनत के लिए वज़न';

  @override
  String get toolNameDots => 'ताक़त का स्तर';

  @override
  String get toolTitleDots => 'ताक़त का स्तर (DOTS)';

  @override
  String get toolDescDots => 'तुम्हारे वज़न के हिसाब से तुम्हारी ताक़त';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'RPE $rpe पर $reps रेप्स के लिए';
  }

  @override
  String get rpeYourSet => 'अभी किया गया सेट';

  @override
  String get rpeGoal => 'जो करना चाहते हो';

  @override
  String rpeOneRmLine(String value) {
    return 'अनुमानित 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 यानी एक और नहीं हो सकता था; 8 यानी दो बचे थे।';

  @override
  String get dotsBestLifts => 'तुम्हारे सबसे अच्छे लिफ़्ट';

  @override
  String get dotsSquat => 'स्क्वाट';

  @override
  String get dotsBench => 'बेंच प्रेस';

  @override
  String get dotsDeadlift => 'डेडलिफ़्ट';

  @override
  String dotsTotalLine(String value) {
    return 'कुल: $value';
  }

  @override
  String get dotsExplain =>
      'तुम्हारी ताक़त की तुलना किसी से भी करता है, चाहे उसका वज़न कुछ भी हो। अपना सबसे अच्छा सिंगल रेप या अनुमानित 1RM इस्तेमाल करो।';

  @override
  String get dotsLevel0 => 'शुरुआती';

  @override
  String get dotsLevel1 => 'मध्यम';

  @override
  String get dotsLevel2 => 'एडवांस्ड';

  @override
  String get dotsLevel3 => 'बहुत एडवांस्ड';

  @override
  String get dotsLevel4 => 'एलीट';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks स्कोर';

  @override
  String get toolDescWilks => 'क्लासिक पावरलिफ़्टिंग स्कोर';

  @override
  String get wilksExplain =>
      'क्लासिक पावरलिफ़्टिंग फ़ॉर्मूला। 2020 में DOTS ने इसकी जगह ली, पर कई प्रतियोगिताएँ और रैंकिंग अब भी इसे इस्तेमाल करती हैं।';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'फ़ैट-फ़्री मास इंडेक्स';

  @override
  String get toolDescFfmi => 'तुम्हारी लंबाई के हिसाब से कितनी मसल';

  @override
  String get ffmiBodyFat => 'बॉडी फ़ैट';

  @override
  String ffmiLeanLine(String value) {
    return 'लीन मास: $value';
  }

  @override
  String get ffmiExplain =>
      'BMI जैसा, पर फ़ैट के बिना: यह सिर्फ़ लीन मास गिनता है। लंबाई के हिसाब से समायोजित ताकि लंबे और छोटे लोगों की तुलना बराबरी से हो।';

  @override
  String get ffmiLevel0 => 'औसत से कम';

  @override
  String get ffmiLevel1 => 'औसत';

  @override
  String get ffmiLevel2 => 'औसत से ऊपर';

  @override
  String get ffmiLevel3 => 'बहुत बढ़िया';

  @override
  String get ffmiLevel4 => 'असाधारण';

  @override
  String get rpeEffortLabel => 'मेहनत (RPE)';

  @override
  String get restRowHint => 'सेट के बीच, जब तक एक्सरसाइज़ का अपना न हो';

  @override
  String get effortRowHint => 'हर सेट पर RPE या RIR दर्ज करो';

  @override
  String get countdownHint => 'पहले सेट से पहले 3, 2, 1';

  @override
  String get keepScreenOnHint => 'ट्रेनिंग के दौरान स्क्रीन चालू रहती है';

  @override
  String get demoSizeRowHint => 'वर्कआउट के दौरान एक्सरसाइज़ का चित्र';

  @override
  String get demoLoopRowHint => 'एनिमेशन दोहराए या रुके';

  @override
  String get trainReminderRowHint => 'ट्रेनिंग वाले दिनों पर याद';

  @override
  String get alarmSoundRowHint => 'आराम ख़त्म होने पर क्या बजे';

  @override
  String get alarmStyleRowHint => 'साइलेंट मोड में बजे या नहीं';

  @override
  String get recommendedRowHint => 'होम पर सुझाई गई एक्सरसाइज़';

  @override
  String get weightStepSetting => 'वज़न का क़दम';

  @override
  String get weightStepHint => '− और + बटन कितना जोड़ते हैं';

  @override
  String get prBestWorkout => 'सबसे अच्छा वर्कआउट';

  @override
  String get mergeExercise => 'मिलाएँ';

  @override
  String mergeExerciseInto(String name) {
    return '$name को इसमें मिलाएँ…';
  }

  @override
  String get mergeExerciseTitle => 'एक्सरसाइज़ मिलाएँ?';

  @override
  String mergeExerciseBody(String from, String to) {
    return '\"$from\" का पूरा इतिहास \"$to\" में चला जाएगा। \"$from\" तुम्हारी लाइब्रेरी में बनी रहेगी। यह वापस नहीं होगा।';
  }

  @override
  String get mergedToast => 'इतिहास मिला दिया';

  @override
  String get nutrition => 'न्यूट्रिशन';

  @override
  String get nutritionHomeEmpty => 'पानी, प्रोटीन और कैलोरी';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein ग्रा प्रोटीन';
  }

  @override
  String get nutritionToday => 'आज';

  @override
  String get nutritionYesterday => 'कल';

  @override
  String get nutritionGoals => 'रोज़ के लक्ष्य';

  @override
  String get kcalLabel => 'कैलोरी';

  @override
  String get kcalOver => 'ज़्यादा';

  @override
  String get waterLabel => 'पानी';

  @override
  String get waterDone => 'लक्ष्य पूरा';

  @override
  String get waterCustom => 'दूसरी मात्रा';

  @override
  String get glassSize => 'गिलास का आकार';

  @override
  String get supplementsLabel => 'सप्लीमेंट';

  @override
  String get supplementsEmpty => 'जोड़ने के लिए किसी पर टैप करो, या अपने लिए + पर।';

  @override
  String get addSupplement => 'नया सप्लीमेंट';

  @override
  String get supplementNameHint => 'क्रिएटिन, विटामिन D…';

  @override
  String removeSupplementTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get removeSupplementBody => 'जिन दिनों इसे लिया चिह्नित किया, वे भी हट जाएँगे।';

  @override
  String get suppCreatine => 'क्रिएटिन';

  @override
  String get suppVitaminD => 'विटामिन D';

  @override
  String get suppOmega3 => 'ओमेगा-3';

  @override
  String get suppMagnesium => 'मैग्नीशियम';

  @override
  String get suppMultivitamin => 'मल्टीविटामिन';

  @override
  String get suppCaffeine => 'कैफ़ीन';

  @override
  String get myFoods => 'मेरा खाना';

  @override
  String get newFood => 'नया खाना';

  @override
  String get editFood => 'खाना बदलें';

  @override
  String get foodNameHint => 'व्हे प्रोटीन, ओट्स, ब्रेड…';

  @override
  String get servingLabel => 'सर्विंग';

  @override
  String get servingHint => '1 स्कूप · 30 ग्रा';

  @override
  String get perServing => 'प्रति सर्विंग';

  @override
  String get servingsLabel => 'सर्विंग';

  @override
  String get foodPhotoHint => 'सादे बैकग्राउंड पर यह स्टिकर बन जाती है।';

  @override
  String get cutoutWorking => 'काटा जा रहा है…';

  @override
  String get cutoutTry => 'बैकग्राउंड हटाएँ';

  @override
  String get cutoutKeep => 'पूरी फ़ोटो';

  @override
  String deleteFoodTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get deleteFoodBody => 'यह तुम्हारे खानों से हट जाएगा। जो पहले दर्ज किया वह बना रहेगा।';

  @override
  String get mealBreakfast => 'नाश्ता';

  @override
  String get mealLunch => 'दोपहर का खाना';

  @override
  String get mealDinner => 'रात का खाना';

  @override
  String get mealSnacks => 'स्नैक्स';

  @override
  String get nothingLogged => 'अभी कुछ दर्ज नहीं।';

  @override
  String addToMeal(String meal) {
    return '$meal में जोड़ें';
  }

  @override
  String get quickAdd => 'जल्दी जोड़ें';

  @override
  String get quickAddHint => 'सिर्फ़ आँकड़े, खाना सेव किए बिना।';

  @override
  String get quickAddName => 'क्या था? (वैकल्पिक)';

  @override
  String get logFood => 'जोड़ें';

  @override
  String loggedToast(String meal) {
    return '$meal में जोड़ा गया';
  }

  @override
  String get entryRemoved => 'हटाया गया';

  @override
  String get goalsFromProfile => 'मेरी प्रोफ़ाइल से गणना करें';

  @override
  String get goalsFromProfileHint =>
      'तुम्हारी प्रोफ़ाइल से कैलोरी, और शरीर के हर किलो पर 1.8 ग्रा प्रोटीन व 35 मिली पानी।';

  @override
  String get kcalEaten => 'खाया';

  @override
  String get kcalRemaining => 'बाक़ी';

  @override
  String waterTapHint(String amount) {
    return 'गिलास पर टैप करो: + $amount';
  }

  @override
  String get shakeEmpty => 'अपना शेक चुनने के लिए टैप करो';

  @override
  String shakeTapHint(String name) {
    return 'टैप करो: + $name';
  }

  @override
  String get shakePick => 'तुम्हारा शेक';

  @override
  String get shakePickHint => 'शेकर पर टैप करो और यह एक बार में दर्ज हो जाएगा।';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'C';

  @override
  String get fatLetter => 'F';

  @override
  String get addBurnedLabel => 'जली कैलोरी जोड़ें';

  @override
  String get addBurnedHint =>
      'तुम्हारा लक्ष्य पहले से तुम्हारी सामान्य एक्टिविटी गिनता है। इसे तभी चालू करो जब तुमने ख़ुद को बैठे रहने वाला चुना हो: यह आराम के ऊपर हर वर्कआउट में जली कैलोरी जोड़ता है।';

  @override
  String get amountLabel => 'मात्रा';

  @override
  String amountIn(String unit) {
    return 'मात्रा ($unit)';
  }

  @override
  String get bodyweightLabel => 'शरीर का वज़न';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count खाने कॉपी हुए',
      one: '1 खाना कॉपी हुआ',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'जो पहले दर्ज किया वह वैसा ही रहेगा।';

  @override
  String get fiberLabel => 'फ़ाइबर';

  @override
  String get sugarLabel => 'चीनी';

  @override
  String get sodiumLabel => 'सोडियम';

  @override
  String get foodDatabase => 'खाने का डेटाबेस';

  @override
  String get kcalBurned => 'जली';

  @override
  String get mealOptions => 'भोजन के विकल्प';

  @override
  String get moreNutrients => 'फ़ाइबर, चीनी और सोडियम';

  @override
  String ofGoal(int goal, String unit) {
    return '$goal $unit में से';
  }

  @override
  String per100(String unit) {
    return 'प्रति 100 $unit';
  }

  @override
  String get perServingShort => 'प्रति सर्विंग';

  @override
  String get foodCategory => 'श्रेणी';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count नग', one: '1 नग');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count स्लाइस', one: '1 स्लाइस');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count स्कूप', one: '1 स्कूप');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बड़े चम्मच',
      one: '1 बड़ा चम्मच',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count छोटे चम्मच',
      one: '1 छोटा चम्मच',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count कप', one: '1 कप');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count गिलास', one: '1 गिलास');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'हाल के';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count खाने', one: '1 खाना');
    return '$_temp0';
  }

  @override
  String get renameLabel => 'नाम बदलें';

  @override
  String get repeatFrom => 'यहाँ से दोहराएँ';

  @override
  String get repeatNone => 'दूसरे दिनों में इस भोजन के लिए अभी कुछ दर्ज नहीं।';

  @override
  String get restDayGoals => 'आराम के दिनों के लिए अलग लक्ष्य';

  @override
  String get trainingDays => 'ट्रेनिंग के दिन';

  @override
  String get restDays => 'आराम के दिन';

  @override
  String get trainingDay => 'ट्रेनिंग का दिन';

  @override
  String get saveAsMeal => 'भोजन के रूप में सेव करें';

  @override
  String get savedMealNameHint => 'जैसे रोज़ का नाश्ता';

  @override
  String get savedMealToast => 'भोजन सेव हुआ';

  @override
  String get savedMeals => 'सेव किए भोजन';

  @override
  String get searchFoodsHint => 'खाना खोजें';

  @override
  String get searchFoodsEmpty => 'फ़ोटो के साथ 500 से ज़्यादा खाने खोजो, या अपना जोड़ो।';

  @override
  String searchFoodsNone(String query) {
    return '\"$query\" के लिए कुछ नहीं मिला। इसे अपने खाने के रूप में बनाओ।';
  }

  @override
  String get servingWeight => 'ग्राम';

  @override
  String get weekAverage => 'इस हफ़्ते';

  @override
  String get weekAvgEnergy => 'रोज़ का औसत';

  @override
  String get weekAvgProtein => 'रोज़ का प्रोटीन';

  @override
  String get weekEnergyOnTarget => 'कैलोरी लक्ष्य पर';

  @override
  String get weekProteinOnTarget => 'प्रोटीन लक्ष्य पर';

  @override
  String weekProteinAvg(int grams) {
    return 'रोज़ $grams ग्रा प्रोटीन';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$days में से $met दिन लक्ष्य पर';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन दर्ज',
      one: '1 दिन दर्ज',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'अभी कुछ दर्ज नहीं';

  @override
  String get weekOnTargetHint => 'लक्ष्य पर: कैलोरी लक्ष्य के 10% के भीतर और कम से कम 90% प्रोटीन।';

  @override
  String get weightGoalLabel => 'लक्ष्य वज़न';

  @override
  String weightGoalTitle(String unit) {
    return 'लक्ष्य वज़न ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'लक्ष्य $weight';
  }

  @override
  String get weightGoalNone => 'लक्ष्य तय करने के लिए दबाकर रखो';

  @override
  String get weightGoalReached => 'लक्ष्य पूरा';

  @override
  String weightToLose(String weight) {
    return '$weight घटाना बाक़ी';
  }

  @override
  String weightToGain(String weight) {
    return '$weight बढ़ाना बाक़ी';
  }

  @override
  String get aminoHis => 'हिस्टिडीन';

  @override
  String get aminoIle => 'आइसोल्यूसीन';

  @override
  String get aminoLeu => 'ल्यूसीन';

  @override
  String get aminoLys => 'लाइसीन';

  @override
  String get aminoSaa => 'मेथियोनीन';

  @override
  String get aminoAaa => 'फ़ेनिलएलानीन';

  @override
  String get aminoThr => 'थ्रियोनीन';

  @override
  String get aminoTrp => 'ट्रिप्टोफ़ैन';

  @override
  String get aminoVal => 'वैलीन';

  @override
  String get animalProtein => 'पशु प्रोटीन';

  @override
  String get proteinQuality => 'प्रोटीन की गुणवत्ता';

  @override
  String get qualityComplete => 'पूरा';

  @override
  String get qualityAlmost => 'लगभग पूरा';

  @override
  String get qualityIncomplete => 'अधूरा';

  @override
  String get qualityNoData => 'अभी डेटा नहीं';

  @override
  String get qualityNoDataHint => 'अपने अमीनो एसिड देखने के लिए डेटाबेस से खाना दर्ज करो।';

  @override
  String get qualityAllCovered => 'सभी नौ ज़रूरी अमीनो एसिड पूरे हैं।';

  @override
  String qualityLimiting(String amino) {
    return '$amino कम है। इससे भरपूर खाने के साथ लो।';
  }

  @override
  String qualityCoverage(int pct) {
    return 'तुम्हारे $pct% प्रोटीन पर आधारित: तुम्हारे अपने खानों में अमीनो एसिड का डेटा नहीं है।';
  }

  @override
  String get fatTypes => 'फ़ैट के प्रकार';

  @override
  String get fatSaturated => 'सैचुरेटेड';

  @override
  String get fatMono => 'मोनो';

  @override
  String get fatPoly => 'पॉली';

  @override
  String satLimitLine(String grams, int limit) {
    return 'सैचुरेटेड $grams ग्रा, अधिकतम $limit ग्रा (कैलोरी का 10%)';
  }

  @override
  String get sugarSodium => 'चीनी और सोडियम';

  @override
  String get shakeCard => 'प्रोटीन शेक';

  @override
  String get mealOther => 'भोजन';

  @override
  String get mealAdd => 'भोजन जोड़ें';

  @override
  String get mealAddHint => 'जैसे प्री-वर्कआउट';

  @override
  String get mealsOfDay => 'दिन के भोजन';

  @override
  String get mealsHint => 'जितने चाहो बनाओ। किसी को हटाने पर उसमें दर्ज चीज़ें ऊपर वाले में चली जाती हैं।';

  @override
  String get trackersTitle => 'अपने हिसाब से बनाएँ';

  @override
  String get trackersHint => 'सिर्फ़ वही दिखाओ जो ट्रैक करना चाहते हो।';

  @override
  String get trackersDaily => 'रोज़ का सारांश';

  @override
  String get trackersDetail => 'विस्तार से';

  @override
  String get trackersCards => 'कार्ड';

  @override
  String get prepTitle => 'मील प्रेप';

  @override
  String get prepNewShort => 'नया बैच';

  @override
  String get prepNew => 'नया बैच';

  @override
  String get prepEdit => 'बैच बदलें';

  @override
  String get prepHint => 'पूरा बर्तन एक बार दर्ज करो, फिर थोड़ा-थोड़ा खाओ।';

  @override
  String get prepEmpty =>
      'एक बड़ा बैच बनाया? उसे एक बार दर्ज करो और फिर बस बताओ कि बचे हुए में से कितना खाया।';

  @override
  String get prepNameHint => 'जैसे चिकन और चावल';

  @override
  String get prepDefaultName => 'बैच';

  @override
  String get prepIngredients => 'सामग्री';

  @override
  String get prepAddIngredient => 'सामग्री जोड़ें';

  @override
  String get prepCookedWeight => 'पका हुआ वज़न';

  @override
  String prepCookedHint(String grams) {
    return 'सटीक आँकड़ों के लिए पकने के बाद बर्तन तौलो। ख़ाली छोड़ने पर कच्चा कुल ($grams ग्रा) इस्तेमाल होगा।';
  }

  @override
  String get prepNeedWeight => 'पका हुआ वज़न जोड़ो: कुछ सामग्रियों के ग्राम नहीं हैं।';

  @override
  String prepLeftOf(String left, String total) {
    return '$total में से $left बचा';
  }

  @override
  String get prepOfWhatsLeft => 'बचे हुए का %';

  @override
  String get prepAll => 'सब';

  @override
  String prepLogAmount(String grams) {
    return '$grams दर्ज करें';
  }

  @override
  String get prepWeighLeft => 'बचा हुआ तौलें';

  @override
  String get prepFinished => 'यह बैच ख़त्म हो गया।';

  @override
  String get approxValues => 'लगभग';

  @override
  String get editValues => 'मान बदलें';

  @override
  String get editValuesHint => 'सिर्फ़ यह एंट्री बदलती है। आगे के लिए खाना ठीक करना हो तो मेरा खाना से बदलो।';

  @override
  String get editLibraryHint => 'तुम्हारे अपने खाने के रूप में सेव, उसी फ़ोटो के साथ';

  @override
  String per100Line(String energy, String unit) {
    return 'प्रति 100 $unit $energy';
  }

  @override
  String get rawLabel => 'कच्चा';

  @override
  String get cookedLabel => 'पका हुआ';

  @override
  String get rawHint => 'पकाने से पहले का वज़न';

  @override
  String cookedHint(String factor) {
    return 'पकने के बाद का वज़न (कच्चे वज़न का ×$factor)';
  }

  @override
  String get servingsUnit => 'सर्विंग';

  @override
  String logAmount(String energy) {
    return 'दर्ज करें · $energy';
  }

  @override
  String get catFruit => 'फल';

  @override
  String get catVeg => 'सब्ज़ियाँ';

  @override
  String get catMeat => 'मांस';

  @override
  String get catFish => 'मछली';

  @override
  String get catEgg => 'अंडे';

  @override
  String get catDairy => 'डेयरी';

  @override
  String get catGrain => 'अनाज';

  @override
  String get catBakery => 'बेकरी';

  @override
  String get catLegume => 'दालें';

  @override
  String get catNut => 'मेवे';

  @override
  String get catOil => 'तेल';

  @override
  String get catPantry => 'रसोई का सामान';

  @override
  String get catDrink => 'पेय';

  @override
  String get catSauce => 'सॉस';

  @override
  String get catSpice => 'मसाले';

  @override
  String get searchFoodsPrompt => 'तुमने क्या खाया?';

  @override
  String get shelfEmpty =>
      'कोई खाना खोजो या अपने खाने की फ़ोटो लो: जो सबसे ज़्यादा दर्ज करोगे वे यहाँ दिखेंगे।';

  @override
  String get repeatEntry => 'फिर से दर्ज करें';

  @override
  String get notifSuppChannel => 'सप्लीमेंट';

  @override
  String get notifSuppChannelWhy => 'सप्लीमेंट लेने की रोज़ की याद';

  @override
  String get energySplit => 'कैलोरी कहाँ से आती है';

  @override
  String get typicalServing => 'आम सर्विंग';

  @override
  String cookedYieldLine(String factor) {
    return 'कच्चे वज़न का $factor× होता है';
  }

  @override
  String get readyDishes => 'डिश';

  @override
  String weightLastLine(String weight) {
    return 'आख़िरी वज़न $weight';
  }

  @override
  String get proteinAnimalShort => 'पशु';

  @override
  String get proteinPlantShort => 'पौधा';

  @override
  String kcalFromMacros(String value) {
    return 'ये मैक्रोज़ लगभग $value होते हैं';
  }

  @override
  String get useValue => 'इस्तेमाल करें';

  @override
  String get suppRowHint => 'चिह्नित करने के लिए टैप · विवरण के लिए दबाकर रखो';

  @override
  String get suppPhoto => 'फ़ोटो';

  @override
  String get suppDose => 'ख़ुराक';

  @override
  String get suppDoseHint => '5 ग्रा, 2 कैप्सूल…';

  @override
  String get suppRemind => 'याद दिलाएँ';

  @override
  String mealPlanDefault(int n) {
    return 'प्लान $n';
  }

  @override
  String get mealPlansTitle => 'भोजन प्लान';

  @override
  String get mealPlanNew => 'नया प्लान';

  @override
  String fromPlan(String name) {
    return '$name से';
  }

  @override
  String get logPlan => 'दर्ज करें';

  @override
  String get planFromDay => 'यह दिन कॉपी करें';

  @override
  String get planNewHint => 'अपने दिन रूटीन की तरह प्लान करो, फिर एक टैप में पूरा भोजन दर्ज करो।';

  @override
  String get planLogDay => 'ख़ाली भोजन दर्ज करें';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n खाने दर्ज हुए',
      one: '1 खाना दर्ज हुआ',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'कोई प्लान नहीं';

  @override
  String get planWeekHint => 'किसी दिन को प्लान देने के लिए उस पर टैप करो।';

  @override
  String get planDuplicate => 'कॉपी बनाएँ';

  @override
  String planDeleteTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get planDeleteBody => 'तुम्हारे दर्ज दिन वैसे ही रहेंगे।';

  @override
  String get sectionBeta => 'बीटा';

  @override
  String get nutritionBeta => 'न्यूट्रिशन';

  @override
  String get nutritionBetaHint => 'भोजन, पानी और सप्लीमेंट';

  @override
  String get nutritionAboutTitle => 'न्यूट्रिशन के बारे में';

  @override
  String get nutritionAboutSub => 'यह क्या है, और यह कभी क्या नहीं बनेगा।';

  @override
  String get nutritionAboutWhatTitle => 'तुम्हारी ट्रेनिंग का हिस्सा';

  @override
  String get nutritionAboutWhat =>
      'वर्कआउट के ठीक बगल में भोजन, पानी, प्रोटीन और सप्लीमेंट दर्ज करने का आसान तरीक़ा। GymMane पहले जिम ऐप है: न्यूट्रिशन इसलिए है कि सब एक जगह रहे, किसी डाइट ऐप की जगह लेने के लिए नहीं।';

  @override
  String get nutritionAboutScanTitle => 'स्कैनिंग कभी नहीं';

  @override
  String get nutritionAboutScan =>
      'बारकोड स्कैन करके हर जानकारी अपने-आप भर जाए तो आसान होता। पर उसके लिए इंटरनेट और एक बहुत बड़ा ऑनलाइन फ़ूड डेटाबेस चाहिए, और तुम क्या खाते हो वह किसी और के सर्वर पर पहुँच जाता है। वह डेटा बताता है कि तुम कब खाते हो, क्या खाते हो और अपने शरीर का कैसे ख़याल रखते हो, और इसका इस्तेमाल विज्ञापनों के लिए हो सकता है या बड़ी कंपनियों को दिया जा सकता है। इसीलिए स्कैनर नहीं है, और कभी नहीं होगा।';

  @override
  String get nutritionAboutLocalTitle => 'सब कुछ तुम्हारे फ़ोन पर';

  @override
  String get nutritionAboutLocal =>
      'फ़ोटो के साथ 500 से ज़्यादा खाने ऐप के अंदर ही आते हैं। तुम अपने खाने जोड़ सकते हो, उनकी फ़ोटो बदल सकते हो और मान बदल सकते हो। बाक़ी GymMane की तरह, सब तुम्हारे फ़ोन पर रहता है।';

  @override
  String get nutritionAboutBetaTitle => 'अभी बीटा में';

  @override
  String get nutritionAboutBeta =>
      'अगर कुछ कमी लगे तो GitHub पर सुझाओ। बस स्कैनिंग या बड़ा फ़ूड डेटाबेस नहीं: तुम्हारी प्राइवेसी के अलावा, इससे ऐप बहुत भारी हो जाएगा। न्यूट्रिशन नहीं चाहिए? सेटिंग्स में बंद करो, तुम्हारा डेटा बना रहेगा।';

  @override
  String get nutritionAboutSuggest => 'आइडिया सुझाएँ';

  @override
  String get nutritionAboutOk => 'ठीक है';

  @override
  String get planShare => 'शेयर करें';

  @override
  String get planImport => 'प्लान इंपोर्ट करें';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n प्लान इंपोर्ट हुए',
      one: '1 प्लान इंपोर्ट हुआ',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'उस फ़ाइल में कोई भोजन प्लान नहीं है।';

  @override
  String get planMoveUp => 'ऊपर ले जाएँ';

  @override
  String get planMoveDown => 'नीचे ले जाएँ';

  @override
  String get cutoutEdit => 'कटआउट सुधारें';

  @override
  String get cutoutEditHint =>
      'मिटाने या वापस लाने के लिए खींचो। किसी हिस्से को पूरा हटाने या वापस लाने के लिए उस पर टैप करो। ज़ूम के लिए पिंच करो।';

  @override
  String get cutoutErase => 'मिटाएँ';

  @override
  String get cutoutRestore => 'वापस लाएँ';

  @override
  String get cutoutReset => 'ऑटोमैटिक पर लौटें';

  @override
  String get cutoutByHand => 'हाथ से काटें';

  @override
  String notifSuppTitleFor(String names) {
    return 'लेने का समय: $names';
  }

  @override
  String get notifSuppTap => 'लेने के बाद GymMane में टिक कर दो।';

  @override
  String get suppNoneToday => 'आज कुछ लेना नहीं है।';

  @override
  String get suppOtherDays => 'दूसरे दिन';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'हर $n दिन', one: 'हर दिन');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'हर दिन';

  @override
  String suppFromDate(String date) {
    return '$date से';
  }

  @override
  String suppUntilDate(String date) {
    return '$date तक';
  }

  @override
  String get suppSomeDays => 'कुछ दिन';

  @override
  String get suppEveryShort => 'हर X दिन';

  @override
  String get suppWhen => 'कब';

  @override
  String get suppEveryLead => 'हर';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'दिन');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'शुरू';

  @override
  String get suppEnds => 'ख़त्म';

  @override
  String get suppTomorrow => 'कल';

  @override
  String get suppPickDate => 'तारीख़ चुनें';

  @override
  String get suppNever => 'कभी नहीं';

  @override
  String get suppOneWeek => '1 हफ़्ते में';

  @override
  String get suppOneMonth => '1 महीने में';

  @override
  String get planPickHint => 'इस दिन का प्लान चुनो, या नया बनाओ।';

  @override
  String planSetForDay(String day) {
    return '$day के लिए प्लान तय';
  }

  @override
  String get planSaved => 'प्लान सेव हुआ';

  @override
  String get planDiscardTitle => 'बदलाव छोड़ दें?';

  @override
  String get planDiscardBody => 'जो बदला वह सेव नहीं होगा।';

  @override
  String get planDiscard => 'छोड़ दें';

  @override
  String get planEdit => 'प्लान बदलें';

  @override
  String get planNameHint => 'प्लान का नाम';

  @override
  String get planDaysQuestion => 'कौन-से दिन?';

  @override
  String get planDaysHint => 'उन दिनों यह न्यूट्रिशन में दिखेगा ताकि एक टैप में दर्ज कर सको।';

  @override
  String get planDaysNone => 'कम से कम एक दिन चुनो, नहीं तो यह कहीं नहीं दिखेगा।';

  @override
  String get planNothingToLog => 'वे भोजन पहले से दर्ज हैं';

  @override
  String get planSave => 'प्लान सेव करें';

  @override
  String get planToday => 'आज का प्लान';

  @override
  String get planLogRest => 'बाक़ी दर्ज करें';

  @override
  String get dishNew => 'अपनी डिश बनाएँ';

  @override
  String get dishNewHint => 'सामग्री और मात्रा चुनो, सेव करो और एक टैप में दर्ज करो।';

  @override
  String get dishEdit => 'डिश बदलें';

  @override
  String get dishNameHint => 'जैसे माँ की दाल';

  @override
  String get dishIngredients => 'सामग्री';

  @override
  String get dishEmptyHint => 'इसमें जो जाता है उसे उस मात्रा में जोड़ो जितना आमतौर पर खाते हो।';

  @override
  String get dishSave => 'डिश सेव करें';

  @override
  String get dishNeedsName => 'इसका नाम दो';

  @override
  String get dishNeedsItems => 'कम से कम एक सामग्री जोड़ो';

  @override
  String get suppHistory => 'पिछले 14 दिन';

  @override
  String suppTakenOf(int n, int total) {
    return '$total में से $n लिए';
  }

  @override
  String get suppNoReminder => 'कोई याद नहीं';

  @override
  String get suppMarkTaken => 'लिया हुआ चिह्नित करें';

  @override
  String get suppUnmark => 'चिह्न हटाएँ';

  @override
  String get suppEdit => 'बदलें';

  @override
  String get mealMoveTo => 'यहाँ ले जाएँ';

  @override
  String get mealClear => 'भोजन ख़ाली करें';

  @override
  String get mealCleared => 'भोजन ख़ाली हुआ';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count खाने ले जाए गए',
      one: '1 खाना ले जाया गया',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'पूरा दिन दोहराएँ';

  @override
  String createFoodNamed(String name) {
    return '“$name” बनाएँ';
  }

  @override
  String get entryDay => 'दिन';

  @override
  String get movedToDay => 'ले जाया गया';

  @override
  String get favFoodsHint => 'किसी खाने पर ☆ टैप करो';

  @override
  String get favFoodsEmpty => 'किसी भी खाने के स्टार पर टैप करो ताकि वह यहाँ एक टैप की दूरी पर रहे।';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count भोजन', one: '1 भोजन');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'किसी भोजन को उसके ••• मेन्यू से सेव करो, या अपनी डिश बनाओ।';

  @override
  String get sugarLimitLabel => 'चीनी की सीमा';

  @override
  String get sodiumLimitLabel => 'सोडियम की सीमा';

  @override
  String get waterOptions => 'पानी के विकल्प';

  @override
  String get waterNone => 'अभी पानी दर्ज नहीं।';

  @override
  String get waterDailyGoal => 'रोज़ का पानी';

  @override
  String get trackersScreen => 'स्क्रीन';

  @override
  String get vesselMotion => 'हिलता पानी और शेक';

  @override
  String get vesselMotionHint =>
      'स्क्रीन धीमी लगे तो बंद करो: गिलास फिर भी भरते हैं, बस हिलना बंद हो जाता है।';

  @override
  String get planFixedWeek => 'तय हफ़्ता';

  @override
  String get planRotation => 'रोटेशन';

  @override
  String get rotationTitle => 'रोटेशन';

  @override
  String get rotationHint => 'अगला वही है जो तुम्हारे पिछले वर्कआउट के बाद आता है, दिन चाहे कोई भी हो।';

  @override
  String get rotationEmpty => 'अपने रूटीन उसी क्रम में जोड़ो जिसमें करोगे: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return 'इस राउंड में $total में से $done पूरे';
  }

  @override
  String get rotationNext => 'अगला';

  @override
  String get rotationAdd => 'रूटीन जोड़ें';

  @override
  String get rotationPickHint => 'जिस क्रम में टैप करोगे, उसी क्रम में जाएँगे।';

  @override
  String get rotationSkip => 'अगले पर जाएँ';

  @override
  String get rotationRestart => 'नया राउंड शुरू करें';

  @override
  String get rotationMakeNext => 'इसे अगला बनाएँ';

  @override
  String get rotationRemove => 'रोटेशन से हटाएँ';

  @override
  String rotationPlace(int n, int total) {
    return 'रोटेशन में $total में से $n';
  }

  @override
  String get moveToDay => 'दूसरे दिन ले जाएँ';

  @override
  String get moveToDayHint => 'सिर्फ़ इस बार; तुम्हारा साप्ताहिक प्लान वैसा ही रहेगा।';

  @override
  String get movedToast => 'वर्कआउट ले जाया गया';

  @override
  String get backToPlan => 'साप्ताहिक प्लान पर लौटें';

  @override
  String get tomorrow => 'कल';

  @override
  String get untrainedTab => 'बिना ट्रेनिंग';

  @override
  String get untrainedRecent => 'हाल में';

  @override
  String get untrainedLong => 'काफ़ी पहले';

  @override
  String untrainedWaiting(String list) {
    return 'सबसे लंबे इंतज़ार में: $list';
  }

  @override
  String get untrainedAllRecent => 'इस हफ़्ते हर मांसपेशी पर काम हुआ। बढ़िया।';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n दिन पहले',
      one: 'कल ट्रेन किया',
      zero: 'आज ट्रेन किया',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'अभी ट्रेन नहीं किया';

  @override
  String get layoutSetting => 'वर्कआउट लेआउट';

  @override
  String get layoutCards => 'कार्ड';

  @override
  String get layoutList => 'सूची';

  @override
  String get layoutHint =>
      'कार्ड एक बार में एक एक्सरसाइज़ दिखाते हैं। सूची पूरा वर्कआउट एक स्क्रीन पर, सेट दर सेट दिखाती है।';

  @override
  String get layoutRowHint => 'एक बार में एक एक्सरसाइज़, या पूरा वर्कआउट सूची में';

  @override
  String get previousCol => 'पिछला';

  @override
  String get usePrevious => 'पिछली बार के आँकड़े इस्तेमाल करें';

  @override
  String get skipShort => 'छोड़ें';

  @override
  String get moveUp => 'ऊपर ले जाएँ';

  @override
  String get moveDown => 'नीचे ले जाएँ';

  @override
  String get widgetNutritionOff => 'इस विजेट के लिए सेटिंग्स › बीटा में न्यूट्रिशन चालू करो।';

  @override
  String get widgetPickShake => 'अपना शेक चुनो';

  @override
  String get heatRangeSetting => 'एक्टिविटी कैलेंडर';

  @override
  String get heatRangeWeeks => '12 हफ़्ते';

  @override
  String get heatRangeYear => '12 महीने';

  @override
  String get heatRangeHint =>
      '12 महीने पूरा साल दिखाता है। पीछे जाने के लिए बगल में स्वाइप करो, पहले वर्कआउट तक।';

  @override
  String get pdfPlan => 'प्लान PDF में';

  @override
  String get pdfPlanHint => 'तुम्हारे हफ़्ते और हर रूटीन वाला साफ़ पेज, प्रिंट या भेजने के लिए तैयार।';

  @override
  String get pdfExport => 'PDF में एक्सपोर्ट करें';

  @override
  String get pdfFooter => 'मुफ़्त, ओपन सोर्स और ऑफ़लाइन';

  @override
  String get shakeTag => 'यह एक शेक है';

  @override
  String get shakeTagHint => 'यह तुम्हारा शेक में दिखता है';

  @override
  String get shakeNone => 'अपने शेक चिह्नित करो और यहाँ सिर्फ़ वही दिखेंगे।';

  @override
  String get shakeMarkLabel => 'शेक के रूप में चिह्नित करें';

  @override
  String get shakeNew => 'नया शेक';

  @override
  String get shakeUntag => 'शेक नहीं';

  @override
  String get pdfKicker => 'ट्रेनिंग प्लान';

  @override
  String get pdfStatDays => 'दिन / हफ़्ता';

  @override
  String get pdfStatMinutes => 'मिनट / वर्कआउट';

  @override
  String pdfMinutes(int n) {
    return '≈ $n मिनट';
  }

  @override
  String get workoutNotesTitle => 'एक्सरसाइज़ नोट्स';

  @override
  String get workoutNoteEvery => 'हर बार';

  @override
  String get workoutNoteNext => 'अगली बार';

  @override
  String get workoutNoteEveryHint =>
      'हर बार यह एक्सरसाइज़ करने पर दिखता है। सीट या पुली की सेटिंग के लिए अच्छा।';

  @override
  String get workoutNoteNextHint => 'सिर्फ़ अगली बार दिखता है, फिर चला जाता है।';

  @override
  String workoutNoteFromLast(String date) {
    return 'पिछली बार से · $date';
  }

  @override
  String get workoutNoteHint => 'सीट छेद 2 में, पुली 19 पर…';

  @override
  String get notePinWorkout => 'वर्कआउट के दौरान दिखाएँ';

  @override
  String get assistedSetting => 'असिस्टेड मशीन';

  @override
  String get assistedSettingHint =>
      'वज़न तुम्हारी मदद करता है, तो कम बेहतर: तुम्हारे रिकॉर्ड और सुझाव नीचे जाते हैं।';

  @override
  String get assistedRecordHint => 'सबसे कम मदद';

  @override
  String get trainAgainLabel => 'अभी ट्रेनिंग नहीं हुई? फिर याद दिलाओ';

  @override
  String get trainAgainOff => 'नहीं';

  @override
  String trainAgainAfter(int n) {
    return '+$n घं';
  }

  @override
  String get trainAgainHint => 'सिर्फ़ एक बार, और तभी जब उस दिन कोई वर्कआउट दर्ज न हो।';

  @override
  String get notifTrainAgainBody => 'आज ट्रेनिंग के लिए अभी भी समय है।';

  @override
  String nextDeload(int n) {
    return 'हल्का: लगातार $n वर्कआउट हर रेप के बिना';
  }

  @override
  String get historyTitle => 'इतिहास';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n वर्कआउट', one: '1 वर्कआउट');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'इस महीने कोई वर्कआउट नहीं';

  @override
  String get historyEmptyHint => 'दूसरे महीने देखने के लिए बगल में स्वाइप करो या तीर इस्तेमाल करो।';

  @override
  String historyMore(int n) {
    return '+$n और';
  }

  @override
  String get stopwatch => 'स्टॉपवॉच';

  @override
  String get proteinSource => 'प्रोटीन का स्रोत';

  @override
  String get proteinMixedShort => 'मिश्रित';

  @override
  String get kcalActive => 'सक्रिय';

  @override
  String get kcalEstimated => 'अनुमानित';

  @override
  String get kcalYours => 'तुम्हारा मान';

  @override
  String kcalTotalRest(String value) {
    return 'कुल $value, आराम में जली कैलोरी समेत';
  }

  @override
  String get inclineLabel => 'ढलान';

  @override
  String get kcalUseOwn => 'मेरा मान इस्तेमाल करें';

  @override
  String get kcalBackToEstimate => 'अनुमान पर लौटें';

  @override
  String get kcalNeedsData => 'कैलोरी का अनुमान लगाने के लिए दूरी और समय जोड़ो';

  @override
  String get kcalHowEstimated => 'दूरी, समय, ढलान और तुम्हारे वज़न से अनुमानित (ACSM फ़ॉर्मूला)।';

  @override
  String get kcalOwnTitle => 'सक्रिय कैलोरी';

  @override
  String get planMine => 'मेरा प्लान';

  @override
  String get planNew => 'नया प्लान';

  @override
  String get planSaveWeek => 'यह हफ़्ता सेव करें';

  @override
  String get planSaveWeekHint => 'मौजूदा हफ़्ते को ऐसे प्लान के रूप में रखो जिस पर लौट सको';

  @override
  String get planEmptyWeek => 'ख़ाली हफ़्ता शुरू करें';

  @override
  String get planEmptyWeekHint => 'तुम्हारा मौजूदा हफ़्ता प्लान के रूप में सेव रहेगा';

  @override
  String get planName => 'प्लान का नाम';

  @override
  String get planRename => 'नाम बदलें';

  @override
  String get planDelete => 'प्लान हटाएँ';

  @override
  String get plansHint => 'हफ़्ते के बदलाव चुने गए प्लान में सेव होते हैं';

  @override
  String get progression => 'प्रोग्रेशन';

  @override
  String get progManual => 'मैनुअल';

  @override
  String get progManualHint => 'कोई सुझाव नहीं: हर वज़न तुम चुनते हो।';

  @override
  String get progLinear => 'लीनियर';

  @override
  String get progLinearHint => 'हर रेप पूरा करो और वज़न बढ़ जाता है।';

  @override
  String get progDouble => 'डबल प्रोग्रेशन';

  @override
  String get progDoubleHint => 'रेंज के ऊपर तक रेप्स बढ़ाओ, फिर वज़न।';

  @override
  String get progVolume => 'रेप्स, सेट और वज़न';

  @override
  String get progVolumeHint => 'ऊपर तक रेप्स, फिर एक और सेट, फिर ज़्यादा वज़न।';

  @override
  String get progAmrap => 'आख़िरी सेट पूरी ताक़त से';

  @override
  String get progAmrapHint => 'आख़िरी सेट: जितने हो सकें उतने रेप्स। लक्ष्य से दोगुने हुए तो दो बार बढ़ेगा।';

  @override
  String get progStep => 'वज़न की छलाँग';

  @override
  String get progRange => 'रेप रेंज';

  @override
  String get progSets => 'सेट';

  @override
  String get progDeload => 'इसके बाद हल्का';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n चूक', one: '1 चूक');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'इतना हल्का करें';

  @override
  String get progApply => 'अगला वर्कआउट भरें';

  @override
  String get progApplyHint => 'बंद होने पर यह सिर्फ़ सुझाव के रूप में दिखता है।';

  @override
  String get nextMoreReps => 'वही वज़न, एक रेप और';

  @override
  String get nextAddSet => 'एक सेट और';

  @override
  String get nextAmrap => 'आख़िरी सेट: जितने हो सकें';

  @override
  String fillDay(String amount) {
    return 'अपना दिन पूरा करो · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'तुम्हारे पास $kcal बचेंगी';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'तुम्हारे पास $kcal और $grams ग्रा प्रोटीन बचेगा';
  }

  @override
  String leftAfterOver(String kcal) {
    return 'लक्ष्य से $kcal ज़्यादा';
  }

  @override
  String perDayUnit(String unit) {
    return 'रोज़ $unit';
  }

  @override
  String get byZone => 'हिस्से के हिसाब से';

  @override
  String get importAlreadyHave =>
      'ये रूटीन पहले से तुम्हारे पास हैं। इन्हें कॉपी के रूप में फिर से जोड़ सकते हो।';

  @override
  String get importAsCopy => 'कॉपी के रूप में जोड़ें';

  @override
  String get importOwned => 'पहले से तुम्हारा';

  @override
  String get setDuplicated => 'सेट की कॉपी बनी';

  @override
  String get setTypeCluster => 'क्लस्टर';

  @override
  String get setTypeClusterInfo => 'एक सेट छोटे-छोटे हिस्सों में, बीच में 15–30 सेकंड। कुल रेप्स दर्ज करो।';

  @override
  String timesBodyweight(String value) {
    return 'तुम्हारे वज़न का $value×';
  }

  @override
  String get archiveRoutine => 'रूटीन आर्काइव करें';

  @override
  String get routineArchived => 'रूटीन आर्काइव हुआ';

  @override
  String get archivedRoutines => 'आर्काइव';

  @override
  String get autoBackup => 'ऑटो बैकअप';

  @override
  String get autoBackupHint =>
      'तुम्हारे सारे डेटा वाली एक ZIP तुम्हारे चुने फ़ोल्डर में सेव करता है। फ़ोन के बाहर कॉपी रखने के लिए Nextcloud, Syncthing या कोई भी सिंक ऐप उस फ़ोल्डर पर लगाओ।';

  @override
  String get autoBackupFolder => 'फ़ोल्डर चुनें';

  @override
  String get autoBackupNoFolder => 'अभी कोई फ़ोल्डर नहीं';

  @override
  String get autoBackupOff => 'बंद';

  @override
  String get autoBackupWorkout => 'हर वर्कआउट के बाद';

  @override
  String get autoBackupDaily => 'दिन में एक बार';

  @override
  String get autoBackupWeekly => 'हफ़्ते में एक बार';

  @override
  String get autoBackupOnLeave => 'ऐप से बाहर जाने पर';

  @override
  String get autoBackupKeep => 'रखी जाने वाली कॉपी';

  @override
  String get autoBackupNow => 'अभी बैकअप लें';

  @override
  String autoBackupLast(String when) {
    return 'आख़िरी बैकअप $when';
  }

  @override
  String get autoBackupNever => 'अभी कोई बैकअप नहीं';

  @override
  String get autoBackupLost => 'आख़िरी बैकअप सेव नहीं हो सका। फ़ोल्डर फिर से चुनो।';

  @override
  String get autoBackupSaved => 'बैकअप सेव हुआ';

  @override
  String get prepPortions => 'हिस्से';

  @override
  String get rotationAddRest => 'आराम का दिन जोड़ें';

  @override
  String get rotationRestHint => 'अगले दिन अपने-आप आगे बढ़ता है';

  @override
  String get rotationRestToday => 'आज';

  @override
  String get rotationSkipRest => 'यह आराम का दिन छोड़ें';

  @override
  String rotationRestUpNext(String name) {
    return 'अगला: $name';
  }

  @override
  String get trainAnyway => 'फिर भी ट्रेनिंग करें';

  @override
  String get healthTitle => 'सेहत';

  @override
  String get healthSetting => 'सेहत का डेटा';

  @override
  String get healthSettingHint => 'प्रगति में Health Connect का डेटा';

  @override
  String get healthPickTitle => 'सेहत का डेटा';

  @override
  String get healthPickHint =>
      'चुनो Health Connect से क्या लाना है। Android हर एक के लिए एक बार पूछता है। यह सिर्फ़ पढ़ा जाता है, और कभी फ़ोन से बाहर नहीं जाता।';

  @override
  String get healthGroupHeart => 'दिल';

  @override
  String get healthGroupVitals => 'वाइटल्स';

  @override
  String get healthGroupActivity => 'एक्टिविटी';

  @override
  String get healthRestingHr => 'आराम की धड़कन';

  @override
  String get healthHeartRate => 'औसत धड़कन';

  @override
  String get healthHrv => 'धड़कन में बदलाव (HRV)';

  @override
  String get healthSpo2 => 'ख़ून में ऑक्सीजन';

  @override
  String get healthRespiration => 'साँस की दर';

  @override
  String get healthBloodPressure => 'ब्लड प्रेशर';

  @override
  String get healthTemperature => 'शरीर का तापमान';

  @override
  String get healthSleep => 'नींद';

  @override
  String get healthDistance => 'दूरी';

  @override
  String get healthFloors => 'चढ़ी मंज़िलें';

  @override
  String get healthElevation => 'चढ़ी ऊँचाई';

  @override
  String get healthActiveKcal => 'सक्रिय कैलोरी';

  @override
  String get healthNoData => 'अभी डेटा नहीं';

  @override
  String get healthReadFailed => 'पढ़ा नहीं जा सका';

  @override
  String get healthAllow => 'अनुमति के लिए टैप करो';

  @override
  String get healthLast7 => 'पिछले 7 दिन';

  @override
  String get healthAvg30 => '30 दिन का औसत';

  @override
  String get healthLow => 'सबसे कम';

  @override
  String get healthHigh => 'सबसे ज़्यादा';

  @override
  String get healthFrom => 'Health Connect से · पिछले 30 दिन';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'साँस/मिनट';

  @override
  String get weekTab => 'हफ़्ता';

  @override
  String get muscleSetsList => 'हर मांसपेशी के सेट';

  @override
  String get fatTrans => 'ट्रांस';

  @override
  String get fatTypesHint => 'वैकल्पिक। जो लेबल पर न लिखा हो उसे ख़ाली छोड़ दो।';

  @override
  String get sessionPhotos => 'वर्कआउट की फ़ोटो';

  @override
  String get sessionPhotosAdd => 'फ़ोटो जोड़ें';

  @override
  String get sessionPhotosHint => 'ये तुम्हारी फ़ोटो में भी रखी जाती हैं।';

  @override
  String get ladderTitle => 'प्रोग्रेशन';

  @override
  String get ladderHint =>
      'क़दमों को सबसे आसान से सबसे कठिन क्रम में रखो। जब लगातार दो सेशन में 8 के 3 सेट करोगे (धीमे वालों में 5), GymMane अगला क़दम सुझाएगा।';

  @override
  String get ladderBuiltIn =>
      'ऐप के प्रोग्रेशन से शुरू होता है। क़दम जोड़ो, हटाओ या क्रम बदलो और यह इस रूटीन का अपना बन जाता है।';

  @override
  String get ladderNone => 'अभी कोई नहीं। बनाने के लिए टैप करो।';

  @override
  String ladderStep(int n, int total) {
    return 'क़दम $n / $total';
  }

  @override
  String get ladderAdd => 'क़दम जोड़ें';

  @override
  String get ladderInRoutine => 'रूटीन में';

  @override
  String get ladderClear => 'ऐप का प्रोग्रेशन इस्तेमाल करें';

  @override
  String get ladderPick => 'क़दम चुनें';

  @override
  String get periodWeek => 'इस हफ़्ते';

  @override
  String get periodMonth => 'इस महीने';

  @override
  String get periodYear => 'इस साल';

  @override
  String get periodAll => 'अब तक';

  @override
  String get settingsSearch => 'सेटिंग्स खोजें';

  @override
  String get settingsNoResults => 'इस नाम की कोई सेटिंग नहीं';

  @override
  String get settingsGroupApp => 'तुम्हारा ऐप';

  @override
  String get settingsGroupHome => 'होम और अतिरिक्त';

  @override
  String get settingsGroupData => 'डेटा और मदद';

  @override
  String get healthAllowAll => 'सब चालू करें';

  @override
  String get healthSeeAll => 'सब देखें';

  @override
  String get healthPinTitle => 'कार्ड पर';

  @override
  String get healthPinHint => 'प्रगति कार्ड के लिए 3 तक चुनो।';

  @override
  String get blurSetting => 'ब्लर इफ़ेक्ट';

  @override
  String get blurSettingHint => 'फ़ोन धीमा लगे तो बंद करो';

  @override
  String get lowEndTitle => 'तुम्हारे फ़ोन में मेमोरी कम है';

  @override
  String get lowEndBody =>
      'ब्लर बंद करने से इस पर सब कुछ ज़्यादा स्मूद चलता है। इसे सेटिंग्स → सामान्य में वापस ला सकते हो।';

  @override
  String get lowEndOff => 'ब्लर बंद करें';

  @override
  String get lowEndKeep => 'रहने दें';

  @override
  String get momentsThisMonth => 'इस महीने';

  @override
  String get momentsDays => 'फ़ोटो वाले दिन';

  @override
  String get awardsPick => 'अपनी प्रोफ़ाइल के लिए चुनो';

  @override
  String get awardsPickHint => 'जिन्हें प्रोफ़ाइल पर चाहते हो उन पर टैप करो';

  @override
  String get gymPassPicture => 'कोड की तस्वीर सेव करें';

  @override
  String get gymPassPictureHint =>
      'उन कोड के लिए जिन्हें ऐप नहीं पढ़ पाता: यह तुम्हारी फ़ोटो पूरी ब्राइटनेस पर दिखाता है';

  @override
  String get gymPassPictureFormat => 'फ़ोटो';

  @override
  String get gymPassUsePicture => 'फ़ोटो सेव करें';

  @override
  String get gymPassChangePicture => 'फ़ोटो बदलें';

  @override
  String get cropTitle => 'कोड क्रॉप करें';

  @override
  String get cropHint => 'कोनों को खींचो ताकि अंदर सिर्फ़ कोड रहे';

  @override
  String get rotatePhoto => 'घुमाएँ';

  @override
  String get cardioNoSets => 'कार्डियो हर मांसपेशी के साप्ताहिक सेट में नहीं जुड़ता';

  @override
  String get countsAsWater => 'पानी में गिना जाता है';

  @override
  String get countsAsWaterHint => 'पानी से बने शेक के लिए: इसे दर्ज करने से तुम्हारा पानी भी बढ़ता है';

  @override
  String get waterPerServing => 'प्रति सर्विंग पानी';

  @override
  String get estOneRm => 'अनु. 1RM';

  @override
  String get newInWorkout => 'इस वर्कआउट में नया';

  @override
  String newInWorkoutHint(String routine) {
    return 'अभी किए सेट के साथ इसे $routine में जोड़ो। बाक़ी रूटीन वैसा ही रहेगा।';
  }

  @override
  String get addedToRoutine => 'जोड़ा गया';

  @override
  String get addShort => 'जोड़ें';

  @override
  String get allTimeLifted => 'उठाया';

  @override
  String get pctBodyweight => '% शरीर का वज़न';

  @override
  String get ofBodyweight => 'तुम्हारे वज़न का';

  @override
  String get recoveryStateMid => 'रिकवर हो रही है';

  @override
  String get recoveryStateReady => 'तैयार';

  @override
  String recoveringIn(String time) {
    return '$time में रिकवर';
  }

  @override
  String readyIn(String time) {
    return '$time में तैयार';
  }

  @override
  String get recoveryReadyNow => 'फिर से ट्रेनिंग के लिए तैयार';

  @override
  String get restAfterThisSet => 'इस सेट के बाद आराम';

  @override
  String restUsual(String time) {
    return 'आमतौर पर: $time';
  }

  @override
  String get restJustToday => 'सिर्फ़ इस सेट के लिए, आज';

  @override
  String get restUseUsual => 'सामान्य आराम पर लौटें';

  @override
  String get restChange => 'बदलें';

  @override
  String get noRestTimer => 'टाइमर नहीं';

  @override
  String get sessionMuscles => 'इस वर्कआउट की मांसपेशियाँ';

  @override
  String get sessionMusclesHint =>
      'हल्की यानी अभी बाक़ी, चमकीली यानी हो गई। हर मांसपेशी के सेट, सहायक वाली आधी गिनी जाती हैं।';

  @override
  String get miniBodySetting => 'रूटीन पर छोटा बॉडी मैप';

  @override
  String get miniBodySettingHint => 'हर रूटीन किन मांसपेशियों पर काम करता है';

  @override
  String get balanceTitle => 'ताक़त का संतुलन';

  @override
  String get balanceWhy => 'यह कैसे काम करता है';

  @override
  String get balanceGood => 'तुम्हारे मुख्य लिफ़्ट संतुलन में हैं';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift पीछे है: बराबर होने के लिए लगभग $gap';
  }

  @override
  String get balanceHint =>
      'पिछले 4 महीनों के अनुमानित 1RM की तुलना क्लासिक अनुपात से करता है: स्क्वाट 100%, डेडलिफ़्ट 120%, बेंच 75%, रो 52%, ओवरहेड प्रेस 45%। जो लिफ़्ट बाक़ियों से बहुत नीचे हो, वह आमतौर पर कमज़ोर कड़ी होती है जिस पर और काम चाहिए।';

  @override
  String get balanceEven => 'संतुलन में';

  @override
  String get balanceBehindShort => 'पीछे';

  @override
  String get balanceAheadShort => 'आगे';

  @override
  String get holdProgress => 'समय से प्रगति';

  @override
  String get holdProgressHint => 'हर सेट होल्ड करने पर सेकंड जोड़ता है';

  @override
  String holdProgressOn(int s) {
    return 'हर सेट होल्ड करने पर हर बार +$s सेकंड';
  }

  @override
  String get paceTitle => 'साप्ताहिक रफ़्तार';

  @override
  String get paceOn => 'रफ़्तार सही';

  @override
  String get paceTooFast => 'तुम्हारी तय रेंज से तेज़';

  @override
  String get paceTooSlow => 'तुम्हारी तय रेंज से धीमी';

  @override
  String get paceWrongWay => 'उल्टी दिशा में';

  @override
  String get paceDrifting => 'बनाए रखने की सीमा से ज़्यादा बदल रहा है';

  @override
  String get paceSetAim => 'अपना लक्ष्य तय करने के लिए टैप करो';

  @override
  String get paceBasis => 'पिछले 3 हफ़्तों के वज़न का रुझान, ताकि एक नमकीन डिनर इसे धोखा न दे सके।';

  @override
  String get paceAimTitle => 'तुम्हारा लक्ष्य क्या है?';

  @override
  String get paceAimHint => 'कार्ड बताता है कि तुम्हारी साप्ताहिक रफ़्तार उससे मेल खाती है या नहीं';

  @override
  String get paceLose => 'घटाना';

  @override
  String get paceHold => 'बनाए रखना';

  @override
  String get paceGain => 'बढ़ाना';

  @override
  String get paceAuto => 'ऑटोमैटिक';

  @override
  String get paceLoseRange => 'हफ़्ते में वज़न का 0.5 से 1%';

  @override
  String get paceHoldRange => 'हफ़्ते में 0.25% के भीतर';

  @override
  String get paceGainRange => 'हफ़्ते में वज़न का 0.25 से 0.5%';

  @override
  String get paceAutoHint => 'तुम्हारे लक्ष्य वज़न से';

  @override
  String get weekShort => 'हफ़्ता';

  @override
  String get weightStack => 'वेट स्टैक';

  @override
  String get weightStackHint =>
      'इस मशीन में सच में मौजूद वज़न। + और − बटन, प्रोग्रेशन और डीलोड सिर्फ़ इन्हीं पर आते हैं।';

  @override
  String get weightStackOff => 'बंद: सामान्य वज़न के क़दम';

  @override
  String get stackFrom => 'से';

  @override
  String get stackTo => 'तक';

  @override
  String get stackEvery => 'हर';

  @override
  String get stackFill => 'स्टैक भरें';

  @override
  String get stackTapToFix => 'कोई अजीब वज़न ठीक करने या हटाने के लिए उस पर टैप करो।';

  @override
  String get stackAddWeight => 'वज़न जोड़ें';

  @override
  String get stackEditWeight => 'पिन पर वज़न';

  @override
  String get stackClear => 'स्टैक हटाएँ';

  @override
  String stackCount(int n) {
    return '$n वज़न';
  }

  @override
  String get healthLinksTitle => 'तुम्हारे वर्कआउट के साथ';

  @override
  String get healthLinkHeart => 'घड़ी से धड़कन';

  @override
  String get healthLinkHeartHint => 'हर वर्कआउट की औसत और सबसे ऊँची धड़कन, जिस भी घड़ी ने रिकॉर्ड की';

  @override
  String get healthLinkWeight => 'दूसरे ऐप्स से वज़न';

  @override
  String get healthLinkWeightHint =>
      'पिछले 30 दिनों के तुम्हारे स्केल के वज़न। तुम्हारा टाइप किया हुआ कभी नहीं बदलता।';

  @override
  String get healthLinkDenied => 'Health Connect ने अनुमति नहीं दी';

  @override
  String get healthOpenSettings => 'खोलें';

  @override
  String hrMaxShort(int bpm) {
    return 'अधिकतम $bpm';
  }

  @override
  String get setNote => 'इस सेट का नोट';

  @override
  String get setNoteHint => 'ग्रिप, दर्द, कोई काम की टिप…';

  @override
  String setNoteLast(String note) {
    return 'पिछली बार: $note';
  }

  @override
  String get lastTimeNotes => 'पिछली बार';

  @override
  String setNoteLine(int n, String note) {
    return 'सेट $n · $note';
  }

  @override
  String get newMeasure => 'नया माप';

  @override
  String get newMeasureHint => 'जो भी ट्रैक करना हो: कलाई, आराम की नब्ज़, शरीर का पानी…';

  @override
  String get measureKindLength => 'लंबाई';

  @override
  String get measureKindLengthHint => 'सेमी या इंच में, बाक़ियों की तरह';

  @override
  String get measureKindOther => 'अन्य';

  @override
  String get measureKindOtherHint => 'अपनी इकाई के साथ';

  @override
  String get measureUnit => 'इकाई';

  @override
  String get measureUnitHint => 'मिमी, bpm, किलो…';

  @override
  String get measureNameHint => 'कलाई, आराम की नब्ज़…';

  @override
  String get measureRename => 'नाम बदलें';

  @override
  String measureDeleteTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get measureDeleteBody => 'इसके लिए दर्ज हर मान भी हट जाएगा।';

  @override
  String get measureDelete => 'यह माप हटाएँ';

  @override
  String get measureEvery => 'मापने की याद दिलाएँ';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n दिन में', one: 'कल', zero: 'आज');
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'मापने का समय';

  @override
  String get notifMeasureChannel => 'शरीर के माप';

  @override
  String get notifMeasureChannelWhy => 'फिर से मापने का समय होने पर याद दिलाता है।';

  @override
  String get notifMeasureTitle => 'मापने का समय';

  @override
  String notifMeasureBody(int n) {
    return 'पिछली बार से $n दिन। वही जगह, दिन का वही समय।';
  }

  @override
  String get healthLinkWrite => 'अपने वर्कआउट सेव करें';

  @override
  String get healthLinkWriteHint =>
      'हर पूरा वर्कआउट अपने समय और प्रकार के साथ Health Connect में जाता है, ताकि दूसरे ऐप भी उसे गिनें। पिछले 30 दिन भी भेजता है।';

  @override
  String get healthWorkoutTitle => 'वर्कआउट';

  @override
  String get circuits => 'समय वाले सर्किट';

  @override
  String get circuitsHint => 'घड़ी के हिसाब से काम और आराम, राउंड दर राउंड';

  @override
  String get newCircuit => 'नया सर्किट';

  @override
  String get editCircuit => 'सर्किट बदलें';

  @override
  String get circuitDefaultName => 'सर्किट';

  @override
  String get circuitNameHint => 'नाम, जैसे कोर फ़िनिशर';

  @override
  String get circuitRounds => 'राउंड';

  @override
  String get circuitRoundRest => 'राउंड के बीच आराम';

  @override
  String get circuitWork => 'काम';

  @override
  String get circuitRest => 'आराम';

  @override
  String get circuitAdd => 'एक्सरसाइज़ जोड़ें';

  @override
  String get circuitEmpty =>
      'एक्सरसाइज़ उसी क्रम में जोड़ो जिसमें करोगे। एक को दो बार रख सकते हो, जैसे हर तरफ़ के लिए साइड प्लैंक।';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      steps,
      locale: localeName,
      other: '$steps एक्सरसाइज़',
      one: '1 एक्सरसाइज़',
    );
    String _temp1 = intl.Intl.pluralLogic(rounds, locale: localeName, other: '$rounds राउंड', one: '1 राउंड');
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'शुरू करें';

  @override
  String get circuitGetReady => 'तैयार हो जाओ';

  @override
  String circuitRoundOf(int n, int total) {
    return 'राउंड $n / $total';
  }

  @override
  String circuitNext(String name) {
    return 'अगला: $name';
  }

  @override
  String get circuitFinishLine => 'बस यह आख़िरी, फिर ख़त्म';

  @override
  String get circuitDone => 'सर्किट पूरा';

  @override
  String circuitDoneBody(String time) {
    return '$time · इतिहास में सेव';
  }

  @override
  String get circuitStopTitle => 'सर्किट रोकें?';

  @override
  String get circuitStopBody => 'अब तक जो किया वह इतिहास में सेव हो जाएगा।';

  @override
  String get circuitStop => 'रोकें';

  @override
  String get circuitKeepGoing => 'जारी रखें';

  @override
  String circuitDeleteTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get circuitDeleteBody => 'इससे किए गए वर्कआउट इतिहास में बने रहेंगे।';

  @override
  String get circuitPickExercise => 'एक्सरसाइज़ चुनें';

  @override
  String get circuitNoSteps => 'कम से कम एक एक्सरसाइज़ जोड़ो';

  @override
  String get circuitPrevious => 'पिछला';

  @override
  String get circuitUpNext => 'अगला';

  @override
  String get foodGroupNew => 'नई श्रेणी';

  @override
  String get foodGroupHint => 'रेडी मील, फ़्रोज़न…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n खाने',
      one: '1 खाना',
      zero: 'अभी कोई खाना नहीं',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get foodGroupDeleteBody => 'तुम्हारे खाने बने रहेंगे, बस इस श्रेणी के बिना।';

  @override
  String onbHello(String name) {
    return 'नमस्ते, $name';
  }

  @override
  String get onbPlaceHero => 'एक्सरसाइज़ जो तुम कर सकते हो';

  @override
  String get settingsRests => 'आराम';

  @override
  String get settingsDuring => 'ट्रेनिंग के दौरान';

  @override
  String get settingsLook => 'कैसा दिखता है';

  @override
  String get importCardTitle => 'अपने वर्कआउट यहाँ लाओ';

  @override
  String get importCardBody => 'Hevy, Strong, FitNotes और दूसरों से';

  @override
  String get checkInTitle => 'आज कैसा महसूस हुआ?';

  @override
  String get checkInSleep => 'नींद';

  @override
  String get checkInEnergy => 'ऊर्जा';

  @override
  String get checkInSkip => 'वैकल्पिक';

  @override
  String get checkInLevel1 => 'बहुत बुरा';

  @override
  String get checkInLevel2 => 'ख़राब';

  @override
  String get checkInLevel3 => 'ठीक-ठाक';

  @override
  String get checkInLevel4 => 'अच्छा';

  @override
  String get checkInLevel5 => 'बहुत बढ़िया';

  @override
  String get checkInSetting => 'नींद और ऊर्जा';

  @override
  String get checkInSettingHint => 'वर्कआउट ख़त्म करने पर पूछता है';

  @override
  String get readinessTitle => 'नींद और ऊर्जा';

  @override
  String get readinessWaiting => 'अपने वर्कआउट को रेट करते रहो';

  @override
  String get readinessWaitingHint =>
      'कुछ अच्छे और बुरे दिनों के बाद दिखेगा कि ये तुम्हारे लिफ़्ट को कैसे बदलते हैं।';

  @override
  String readinessSleepLess(int n) {
    return 'कम नींद वाले दिनों में तुम $n% कम उठाते हो';
  }

  @override
  String readinessSleepMore(int n) {
    return 'मज़ेदार: कम नींद वाले दिनों में तुम $n% ज़्यादा उठाते हो';
  }

  @override
  String get readinessSleepNone => 'नींद से तुम्हारे लिफ़्ट में मुश्किल से फ़र्क़ पड़ता है';

  @override
  String readinessEnergyLess(int n) {
    return 'कम ऊर्जा वाले दिनों में तुम $n% कम उठाते हो';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'कम ऊर्जा वाले दिनों में भी तुम $n% ज़्यादा उठाते हो';
  }

  @override
  String get readinessEnergyNone => 'ऊर्जा से तुम्हारे लिफ़्ट में मुश्किल से फ़र्क़ पड़ता है';

  @override
  String get readinessHint => 'हर अनुमानित 1RM की तुलना पिछले 90 दिनों के तुम्हारे सबसे अच्छे से करता है।';

  @override
  String get readinessLast30 => 'पिछले 30 दिनों का औसत';

  @override
  String get kindSport => 'खेल';

  @override
  String get clearWorkouts => 'सिर्फ़ वर्कआउट हटाएँ';

  @override
  String get clearWorkoutsNone => 'हटाने को कोई वर्कआउट नहीं';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n वर्कआउट हटाएँ?',
      one: '1 वर्कआउट हटाएँ?',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'तुम्हारा इतिहास, रिकॉर्ड और मेडल चले जाएँगे। रूटीन, एक्सरसाइज़, फ़ोटो, माप, न्यूट्रिशन और सेटिंग्स बनी रहेंगी। अगर वापस चाहिए हो सकते हैं तो पहले बैकअप एक्सपोर्ट करो।';

  @override
  String get clearWorkoutsConfirm => 'वर्कआउट हटाएँ';

  @override
  String get clearWorkoutsDone => 'वर्कआउट हटाए गए';

  @override
  String get reportTitle => 'रिपोर्ट';

  @override
  String get reportHint => 'तारीख़ें चुनो और PDF या CSV के रूप में शेयर करो';

  @override
  String get reportCustom => 'अन्य';

  @override
  String get reportPickRange => 'तारीख़ें चुनें';

  @override
  String get reportEmpty => 'इन तारीख़ों के बीच कुछ दर्ज नहीं।';

  @override
  String get reportKicker => 'ट्रेनिंग रिपोर्ट';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n दिन', one: '1 दिन');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'वर्कआउट';

  @override
  String get reportPerWeek => 'प्रति हफ़्ता';

  @override
  String get reportHours => 'घंटे';

  @override
  String get reportVsPrev => 'प्रतिशत की तुलना ठीक पहले के उतने ही दिनों से होती है।';

  @override
  String get reportRecords => 'नए रिकॉर्ड';

  @override
  String get reportLifts => 'एक्सरसाइज़';

  @override
  String get reportSessionsCol => 'दिन';

  @override
  String get reportBestCol => 'बेस्ट 1RM';

  @override
  String get reportChangeCol => 'बदलाव';

  @override
  String get reportBestHint =>
      'बेस्ट 1RM तुम्हारे सेट से अनुमानित है। बदलाव इस रिपोर्ट में एक्सरसाइज़ के पहले और आख़िरी दिन की तुलना करता है।';

  @override
  String get reportMuscles => 'हर मांसपेशी के सेट';

  @override
  String get reportBody => 'शरीर और रिकवरी';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'न्यूट्रिशन · $n दिनों का औसत',
      one: 'न्यूट्रिशन · 1 दिन का औसत',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n नए रिकॉर्ड',
      one: '1 नया रिकॉर्ड',
    );
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n एक्सरसाइज़', one: '1 एक्सरसाइज़');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return 'रोज़ $kcal और $protein ग्रा प्रोटीन · $days दिन दर्ज';
  }

  @override
  String get reportSharePdf => 'PDF शेयर करें';

  @override
  String get reportShareCsv => 'CSV एक्सपोर्ट करें';

  @override
  String get reportShareCsvBoth => 'CSV एक्सपोर्ट करें (वर्कआउट और न्यूट्रिशन)';

  @override
  String fastMinutes(int n) {
    return '$n मिनट';
  }

  @override
  String fastHours(int n) {
    return '$n घं';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h घं $m मिनट';
  }

  @override
  String get fastTracker => 'इंटरमिटेंट फ़ास्टिंग';

  @override
  String fastTitle(int fast, int eat) {
    return 'फ़ास्टिंग $fast:$eat';
  }

  @override
  String get fastOptions => 'फ़ास्टिंग के विकल्प';

  @override
  String get fastWindowOpen => 'खाने का समय खुला है';

  @override
  String get fastLeft => 'बाक़ी';

  @override
  String get fastDoneLabel => 'लक्ष्य पूरा';

  @override
  String get fastIdle => 'आख़िरी भोजन के बाद शुरू करो';

  @override
  String fastLast(String time) {
    return 'पिछली फ़ास्टिंग: $time';
  }

  @override
  String fastStreak(int n) {
    return 'लगातार $n';
  }

  @override
  String fastReached(String time) {
    return 'लक्ष्य से $time ज़्यादा';
  }

  @override
  String fastEndsAt(String time) {
    return '$time पर ख़त्म';
  }

  @override
  String fastSince(String time) {
    return '$time से';
  }

  @override
  String get fastStartedAt => 'फ़ास्टिंग कब शुरू की?';

  @override
  String get fastStart => 'फ़ास्टिंग शुरू करें';

  @override
  String fastFromMeal(String time) {
    return '$time से';
  }

  @override
  String get fastEnd => 'फ़ास्टिंग ख़त्म करें';

  @override
  String get fastCancel => 'यह फ़ास्टिंग रद्द करें';

  @override
  String get fastPlan => 'फ़ास्टिंग प्लान';

  @override
  String get fastPlanHint => 'फ़ास्टिंग के घंटे : खाने के घंटे';

  @override
  String get fastThisWeek => 'पिछले 7 दिन';

  @override
  String get fastCount => 'फ़ास्टिंग';

  @override
  String get fastReachedCount => 'पूरी';

  @override
  String get fastAverage => 'औसत';

  @override
  String get fastHistory => 'हाल की फ़ास्टिंग';

  @override
  String get notifFastLiveChannel => 'फ़ास्टिंग जारी';

  @override
  String get notifFastLiveChannelWhy => 'फ़ास्टिंग के दौरान एक शांत उल्टी गिनती।';

  @override
  String get notifFastChannel => 'फ़ास्टिंग';

  @override
  String get notifFastChannelWhy => 'फ़ास्टिंग पूरी होने पर बताता है।';

  @override
  String get notifFastLiveTitle => 'फ़ास्टिंग';

  @override
  String notifFastLiveBody(String time) {
    return 'खाने का समय $time पर खुलेगा';
  }

  @override
  String get notifFastDoneTitle => 'फ़ास्टिंग पूरी';

  @override
  String notifFastDoneBody(int n) {
    return '$n घंटे। खाने का समय खुला है।';
  }

  @override
  String get newExerciseHint => 'सिर्फ़ नाम ज़रूरी है। बाक़ी मदद करता है, पर बाद में जोड़ सकते हो।';

  @override
  String get supportThanksTitle => 'यहाँ होने के लिए शुक्रिया 🤍';

  @override
  String get supportThanksBody =>
      'GymMane मुफ़्त है और हमेशा रहेगा, बिना विज्ञापन और बिना कुछ छुपाए।\n\nअगर यह तुम्हारी ट्रेनिंग में मदद करता है, तो मुझे एक कॉफ़ी पिलाना मेरा दिन बना देगा ☕\nऔर अगर नहीं कर सकते, तो कोई बात नहीं: GitHub पर एक स्टार भी बहुत है ⭐';

  @override
  String get perfSetting => 'परफ़ॉर्मेंस';

  @override
  String get perfSheetHint => 'GymMane तुम्हारे फ़ोन का कितना इस्तेमाल करे। नीचे हर हिस्सा बदल सकते हो।';

  @override
  String get perfLite => 'सेवर';

  @override
  String get perfLiteHint => 'ब्लर नहीं और शांत मोशन। उन फ़ोन के लिए जो मुश्किल से चलते हैं।';

  @override
  String get perfBalanced => 'संतुलित';

  @override
  String get perfBalancedHint => 'बैटरी ख़त्म किए बिना ब्लर और एनिमेशन।';

  @override
  String get perfMax => 'अधिकतम';

  @override
  String perfMaxHint(int hz) {
    return 'बारीक ब्लर और $hz Hz स्क्रीन। हाई-एंड फ़ोन के लिए।';
  }

  @override
  String get perfMaxHintNoHz => 'हर जगह बारीक ब्लर। हाई-एंड फ़ोन के लिए।';

  @override
  String get perfCustom => 'कस्टम';

  @override
  String get perfTweak => 'बारीक समायोजन';

  @override
  String get perfFine => 'बारीक ब्लर';

  @override
  String get perfFineHint => 'पैनलों के पीछे नरम किनारे और साफ़ बैकग्राउंड';

  @override
  String perfHz(int hz) {
    return '$hz Hz स्क्रीन';
  }

  @override
  String get perfHzHint => 'सब कुछ ज़्यादा स्मूद स्क्रॉल होता है, थोड़ी ज़्यादा बैटरी में';

  @override
  String get lowEndLiteBody =>
      'सेवर मोड (ब्लर नहीं, शांत मोशन) इस पर ज़्यादा स्मूद चलेगा। इसे सेटिंग्स → सामान्य → परफ़ॉर्मेंस में बदल सकते हो।';

  @override
  String get lowEndLiteOn => 'सेवर चालू करें';

  @override
  String get dayOffHint => 'तुम्हारी स्ट्रीक और याद इस दिन को नहीं छेड़ेंगे';

  @override
  String get dayOffTrained => 'ट्रेनिंग की, बस दर्ज नहीं की';

  @override
  String get dayOffSick => 'बीमारी';

  @override
  String get dayOffTravel => 'यात्रा';

  @override
  String get dayOffInjury => 'चोट';

  @override
  String get dayOffRest => 'आराम';

  @override
  String get altsTitle => 'विकल्प';

  @override
  String get altsHint => 'अगर मशीन किसी के पास हो';

  @override
  String altsPickHint(int count) {
    return '$count तक चुनो। मशीन व्यस्त हो तो एक टैप में बदलो।';
  }

  @override
  String get placeDumbbells => 'डम्बल';

  @override
  String get dumbbellsHint => 'एक डम्बल का वज़न। प्रोग्रेशन और + व − बटन यहाँ सिर्फ़ इन्हीं पर आएँगे।';

  @override
  String get dumbbellOther => 'दूसरा वज़न';

  @override
  String get tuneTitle => 'आज का वॉल्यूम';

  @override
  String get tuneHint => 'बताओ हर मांसपेशी को कैसा लगा, और अगली बार के सेट उसी हिसाब से ठीक हो जाएँगे।';

  @override
  String get tuneLess => 'बहुत कम';

  @override
  String get tuneRight => 'ठीक';

  @override
  String get tuneMore => 'बहुत ज़्यादा';

  @override
  String tuneNext(String sets, String name) {
    return 'अगली बार: $name के $sets';
  }

  @override
  String get tuneSame => 'अगली बार भी वैसा ही';

  @override
  String get tuneSetting => 'हर मांसपेशी के सेट ठीक करें';

  @override
  String get tuneSettingHint => 'रूटीन के बाद हर मांसपेशी को रेट करो और सेट अपने-आप ठीक होंगे';

  @override
  String insightLoad(int pct) {
    return 'तुम्हारे सामान्य हफ़्ते से $pct % ज़्यादा सेट। रिकवरी पर ध्यान दो।';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: $days दिन से नहीं छुई गई।';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'तुम खींचने से ज़्यादा धकेलते हो: चार हफ़्तों में $a सेट बनाम $b।';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'तुम धकेलने से ज़्यादा खींचते हो: चार हफ़्तों में $a सेट बनाम $b।';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: पिछले महीने से $pct % ज़्यादा ताक़तवर।';
  }

  @override
  String recapPull(String month) {
    return 'अपना $month देखने के लिए खींचते रहो';
  }

  @override
  String get recapRelease => 'छोड़ दो';

  @override
  String recapHi(String name) {
    return 'नमस्ते, $name';
  }

  @override
  String recapReady(String month) {
    return 'देखें $month में तुमने क्या किया?';
  }

  @override
  String get recapGo => 'चलो';

  @override
  String recapEmpty(String month) {
    return '$month में अभी कोई वर्कआउट नहीं। तुम्हारा पहला इसे खोलेगा।';
  }

  @override
  String get recapClose => 'बंद करें';

  @override
  String get recapShare => 'शेयर करें';

  @override
  String get recapWorkoutsKicker => 'इस महीने तुमने ट्रेनिंग की';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'वर्कआउट', one: 'वर्कआउट');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n अलग-अलग दिनों में',
      one: 'एक दिन में',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'बार के नीचे बिताया समय';

  @override
  String recapLongest(String time, String date) {
    return 'सबसे लंबा सेशन: $time, $date को';
  }

  @override
  String get recapVolumeKicker => 'तुमने उठाया';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'जैसे $count कारें उठाना',
      one: 'जैसे एक कार उठाना',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'सबसे ज़्यादा: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'महीने की मांसपेशी';

  @override
  String get recapRecordsKicker => 'नए रिकॉर्ड';

  @override
  String recapNoRecords(int n) {
    return 'इस बार कोई रिकॉर्ड नहीं, पर $n सेट खाते में गए।';
  }

  @override
  String get recapHabitKicker => 'तुम्हारा समय';

  @override
  String recapHabitStart(String time) {
    return 'तुम आमतौर पर $time बजे शुरू करते हो';
  }

  @override
  String get recapShareKicker => 'तुम्हारा महीना, शेयर के लिए तैयार';

  @override
  String get recapTickWorkouts => 'वर्कआउट';

  @override
  String get recapTickTime => 'समय';

  @override
  String get recapTickVolume => 'लोड';

  @override
  String get recapTickRecords => 'रिकॉर्ड';

  @override
  String recapAvg(int n) {
    return 'हर वर्कआउट औसतन $n मिनट';
  }

  @override
  String get recapLiftKicker => 'महीने की एक्सरसाइज़';

  @override
  String get recapBest => 'सबसे अच्छा';

  @override
  String get recapTimes => 'दिन';

  @override
  String get recapDaysLabel => 'दिन';

  @override
  String get recapAvgLabel => 'औसत';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$days दिनों में $workouts वर्कआउट';
  }

  @override
  String get recapFavLabel => 'तुम्हारा दिन';

  @override
  String get recapWatermark => 'मुफ़्त जिम लॉग';

  @override
  String get recapTickSteps => 'क़दम';

  @override
  String get recapTickFood => 'खाना';

  @override
  String get recapCardioKicker => 'कार्डियो';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n वर्कआउट', one: 'एक वर्कआउट');
    return '$_temp0 में $minutes मिनट';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n कार्डियो वर्कआउट',
      one: 'एक कार्डियो वर्कआउट',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'तुम्हारा पसंदीदा: $name';
  }

  @override
  String get recapStepsKicker => 'तुम चले';

  @override
  String get recapStepsWord => 'क़दम';

  @override
  String recapStepsAvg(String value) {
    return 'रोज़ औसतन $value';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'सबसे अच्छा दिन: $value, $date';
  }

  @override
  String get recapFoodKicker => 'तुम्हारी थाली में';

  @override
  String get recapLiftRest => 'ठीक उसके पीछे';

  @override
  String recapSameAs(String month) {
    return '$month जैसा ही';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$month से $value ज़्यादा';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$month से $value कम';
  }

  @override
  String get recapTickMedals => 'मेडल';

  @override
  String get recapTickSleep => 'नींद';

  @override
  String get recapMedalsKicker => 'जीते हुए मेडल';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'और $n', one: 'और एक');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'तुम सोए';

  @override
  String get recapSleepAvg => 'रात में औसतन';

  @override
  String recapSleepBest(String value, String date) {
    return 'सबसे अच्छी रात: $value, $date';
  }

  @override
  String get recapCardSummary => 'सारांश';

  @override
  String get recapCardCalendar => 'कैलेंडर';

  @override
  String get recapCardLift => 'एक्सरसाइज़';

  @override
  String get recapPeakKicker => 'तुम्हारा सबसे कठिन सेशन';

  @override
  String get recapTickPeak => 'सेशन';

  @override
  String get recapFreshKicker => 'इस महीने पहली बार';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'नई एक्सरसाइज़',
      one: 'नई एक्सरसाइज़',
    );
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'नई';

  @override
  String recapStreak(int n) {
    return 'लगातार $n दिन, तुम्हारी सबसे लंबी स्ट्रीक';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n वर्कआउट', one: '1 वर्कआउट');
    return 'एक साल पहले: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'इस महीने छूट गई: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'रोज़ प्रोटीन · लक्ष्य $goal ग्रा';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'तुम्हारी थाली में $n दिन',
      one: 'तुम्हारी थाली में 1 दिन',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'प्रोटीन · ग्रा/दिन';

  @override
  String get recapFoodGoalDays => 'लक्ष्य पूरा';

  @override
  String get recapFoodWaterLabel => 'पानी/दिन';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n दिन', one: '1 दिन');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'महीने का तुम्हारा खाना';

  @override
  String get onbSpeedTitle => 'इसे स्मूद चलाओ';

  @override
  String get onbSpeedWhy =>
      'लगता है तुम्हारा फ़ोन ज़ोर लगा रहा है। इन्हें बंद करो और सब बेहतर चलेगा: आज़माओ और प्रीव्यू देखो।';

  @override
  String get onbSpeedMotion => 'एनिमेशन';

  @override
  String get onbSpeedBlurHint => 'पैनलों और पट्टियों के पीछे धुंधला काँच';

  @override
  String get onbSpeedMotionHint => 'स्लाइड होकर आती स्क्रीन और पैनल';

  @override
  String get onbSpeedLater => 'इसे सेटिंग्स › सामान्य › परफ़ॉर्मेंस में कभी भी बदल सकते हो।';

  @override
  String get notifSoundSetting => 'नोटिफ़िकेशन की आवाज़ें';

  @override
  String get notifSoundRowHint => 'हर तरह की याद की आवाज़';

  @override
  String get notifSoundHint =>
      'हर तरह की याद के लिए एक आवाज़ चुनो। फ़ोन से तुम्हारे फ़ोन की आवाज़ें खोलता है, और ज़्यादातर फ़ोन में वहाँ अपना गाना भी जोड़ सकते हो।';

  @override
  String get notifSoundTrain => 'वर्कआउट';

  @override
  String get notifSoundFood => 'खाना, सप्लीमेंट और फ़ास्टिंग';

  @override
  String get notifSoundOther => 'फ़ोटो और माप';

  @override
  String get notifSoundNormal => 'सामान्य';

  @override
  String get notifSoundPhone => 'फ़ोन से';

  @override
  String get notifSoundSilent => 'साइलेंट';

  @override
  String get notifSoundPhoneHint => 'सुनने के लिए किसी पर टैप करो। तुरंत सेव हो जाता है।';

  @override
  String get notifSoundMore => 'दूसरी फ़ाइल…';

  @override
  String get notifSoundChange => 'बदलें';

  @override
  String get workoutNoteAdd => 'पिन किया नोट: सीट, ग्रिप, मशीन…';

  @override
  String get autoProgressSetting => 'ऑटो प्रोग्रेशन';

  @override
  String get autoProgressRowHint => 'अगली बार के लिए क्या सुझाता है';

  @override
  String get autoProgressOff => 'बंद';

  @override
  String get autoProgressWeight => 'वज़न बढ़ाएँ';

  @override
  String get autoProgressReps => 'रेप्स बढ़ाएँ';

  @override
  String get autoProgressHint =>
      'वर्कआउट शुरू करने पर GymMane हर एक्सरसाइज़ का अगला क़दम भर देता है। रेप्स बढ़ाएँ से हर सेट में 12 तक एक रेप जुड़ता है, फिर वज़न बढ़ता है और तुम फिर से 8 से शुरू करते हो। हर एक्सरसाइज़ को उसके पेज पर अब भी ठीक कर सकते हो।';

  @override
  String get noteFolders => 'फ़ोल्डर';

  @override
  String get noteFolderNew => 'नया फ़ोल्डर';

  @override
  String get noteFolderEdit => 'फ़ोल्डर बदलें';

  @override
  String get noteFolderName => 'फ़ोल्डर का नाम';

  @override
  String get noteFolderLabel => 'फ़ोल्डर';

  @override
  String get noteFolderNone => 'कोई फ़ोल्डर नहीं';

  @override
  String get noteFolderDelete => 'फ़ोल्डर हटाएँ?';

  @override
  String get noteFolderDeleteBody => 'नोट बने रहेंगे: बस फ़ोल्डर से बाहर हो जाएँगे।';

  @override
  String get foodArchivedToast => 'खाना आर्काइव हुआ';

  @override
  String get planArchivedToast => 'प्लान आर्काइव हुआ';

  @override
  String get suppArchivedToast => 'सप्लीमेंट आर्काइव हुआ';

  @override
  String get voiceSetting => 'वर्कआउट वॉइस';

  @override
  String get voiceSettingHint => 'फ़ोन की आवाज़ में अगला सेट बताता है और आराम के अंत की उल्टी गिनती करता है';

  @override
  String get voiceHello => 'वॉइस चालू';

  @override
  String voiceRest(String time) {
    return 'आराम $time।';
  }

  @override
  String voiceNext(String name, String load) {
    return 'अगला: $name, $load।';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$weight के साथ $reps रेप्स';
  }

  @override
  String voiceReps(int reps) {
    return '$reps रेप्स';
  }

  @override
  String get voiceGo => 'चलो!';

  @override
  String get deloadSetting => 'डीलोड हफ़्ता';

  @override
  String get deloadOff => 'कभी नहीं';

  @override
  String deloadEvery(int weeks) {
    return 'हर $weeks हफ़्ते';
  }

  @override
  String get deloadHint =>
      'हर कुछ हफ़्तों में रिकवरी के लिए एक आसान हफ़्ता: आधे सेट और 10 % कम वज़न। वह हफ़्ता प्रोग्रेशन में नहीं गिना जाता।';

  @override
  String get deloadRowHint => 'हर कुछ हफ़्तों में एक हल्का हफ़्ता';

  @override
  String get deloadNow => 'डीलोड हफ़्ता';

  @override
  String get deloadNowHint => 'आज आधे सेट और 10 % कम वज़न';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks हफ़्ते में',
      one: 'अगले हफ़्ते',
      zero: 'इस हफ़्ते',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'हमेशा की तरह ट्रेनिंग';

  @override
  String get voiceSheetTitle => 'वॉइस कैसे काम करती है';

  @override
  String get voicePointRest => 'सेट टिक करने पर यह आराम का समय और आगे क्या है बताती है।';

  @override
  String get voicePointCount => 'आराम के अंत में 3, 2, 1 गिनती है और तुम्हें वापस बुलाती है।';

  @override
  String get voicePointPhone =>
      'यह तुम्हारे फ़ोन की आवाज़ इस्तेमाल करती है और तुम्हारे संगीत के ऊपर चलती है।';

  @override
  String get voiceTry => 'वॉइस आज़माएँ';

  @override
  String get voiceNoEngine => 'तुम्हारे फ़ोन में कोई वॉइस इंजन चालू नहीं है।';

  @override
  String get voiceNoLang => 'तुम्हारी भाषा की आवाज़ नहीं है। इसे फ़ोन की वॉइस सेटिंग्स में डाउनलोड करो।';

  @override
  String get voiceOpenSettings => 'वॉइस सेटिंग्स';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count मिनट', one: '1 मिनट');
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count सेकंड', one: '1 सेकंड');
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'और';

  @override
  String get repRecordsTitle => 'रेप्स के हिसाब से सबसे अच्छा वज़न';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'कैप्सूल', one: 'कैप्सूल');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'गोलियाँ', one: 'गोली');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'स्कूप', one: 'स्कूप');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'बूँदें', one: 'बूँद');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'सर्विंग', one: 'सर्विंग');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IU';

  @override
  String get suppLeft => 'बचा';

  @override
  String get suppLeftHint => 'वैकल्पिक';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n दिनों के लिए बचा',
      one: '1 दिन के लिए बचा',
    );
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n दिन', one: '1 दिन');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'ख़त्म';

  @override
  String get lightSession => 'हल्का सेशन';

  @override
  String get lightSessionHint => 'इतिहास और आँकड़ों में सेव होता है, पर तुम्हारे अगले लक्ष्य नहीं बदलता।';

  @override
  String get lightSessionNote => 'प्रोग्रेशन में नहीं गिना जाता';

  @override
  String get lightSessionOff => 'बंद करें';

  @override
  String get eachSideRepsHint =>
      'बाएँ और दाएँ के रेप्स अलग दर्ज करो। प्रोग्रेशन कमज़ोर तरफ़ के हिसाब से चलता है।';

  @override
  String get repsLeftCol => 'रेप्स बा';

  @override
  String get repsRightCol => 'रेप्स दा';

  @override
  String get repsLeftTitle => 'बाएँ रेप्स';

  @override
  String get repsRightTitle => 'दाएँ रेप्स';

  @override
  String sidesReps(int l, int r) {
    return 'बा$l दा$r';
  }

  @override
  String get progSchemeTitle => 'वज़न प्रोग्रेशन';

  @override
  String get groupMoveUp => 'समूह ऊपर ले जाएँ';

  @override
  String get groupMoveDown => 'समूह नीचे ले जाएँ';

  @override
  String get mealAiRow => 'AI से पूछें';

  @override
  String get mealAiRowHint => 'अनुरोध कॉपी करो, जवाब पेस्ट करो';

  @override
  String get mealAiTitle => 'AI के साथ भोजन';

  @override
  String get mealAiSubtitle => 'किसी भी चैटबॉट के साथ चलता है। ऐप ऑफ़लाइन रहता है।';

  @override
  String get mealAiStepAsk => 'पूछें';

  @override
  String get mealAiStepPaste => 'पेस्ट करें';

  @override
  String get mealAiWholeDay => 'पूरा दिन';

  @override
  String get mealAiTarget => 'लक्ष्य';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'आज तुम्हारे पास $kcal और $protein ग्रा प्रोटीन बचा है';
  }

  @override
  String get mealAiStyle => 'तुम्हारा स्वाद';

  @override
  String get mealAiTagProtein => 'हाई प्रोटीन';

  @override
  String get mealAiTagVeggie => 'शाकाहारी';

  @override
  String get mealAiTagVegan => 'वीगन';

  @override
  String get mealAiTagNoGluten => 'ग्लूटेन फ़्री';

  @override
  String get mealAiTagNoLactose => 'लैक्टोज़ फ़्री';

  @override
  String get mealAiTagQuick => 'जल्दी';

  @override
  String get mealAiTagNoCook => 'बिना पकाए';

  @override
  String get mealAiTagCheap => 'बजट';

  @override
  String get mealAiNotesHint => 'घर पर है… मुझे पसंद नहीं… एलर्जी…';

  @override
  String get mealAiOptions => 'विकल्प';

  @override
  String get mealAiCopy => 'अनुरोध कॉपी करें';

  @override
  String get mealAiCopied => 'अनुरोध कॉपी हुआ';

  @override
  String get mealAiCopiedHint => 'इसे अपने AI में पेस्ट करो और जवाब लेकर यहाँ लौटो';

  @override
  String get mealAiShowText => 'अनुरोध देखें';

  @override
  String get mealAiHideText => 'अनुरोध छुपाएँ';

  @override
  String get mealAiPasteHint => 'AI का जवाब यहाँ पेस्ट करो';

  @override
  String get mealAiReview => 'जवाब जाँचें';

  @override
  String get mealAiUnreadable => 'उस टेक्स्ट में कोई खाना नहीं मिला';

  @override
  String get mealAiUnreadableHint =>
      'AI से कहो कि सिर्फ़ JSON भेजे, एक कोड ब्लॉक में, अनुरोध के फ़ॉर्मेट में।';

  @override
  String get mealAiCopyFix => 'वह वाक्य कॉपी करें';

  @override
  String mealAiOption(int n) {
    return 'विकल्प $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return '$meal में जोड़ें';
  }

  @override
  String get mealAiAddDay => 'आज में जोड़ें';

  @override
  String get mealAiAddPick => 'जोड़ें';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n खाने जोड़े गए',
      one: '1 खाना जोड़ा गया',
    );
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'रेसिपी के रूप में सेव करें';

  @override
  String get mealAiSavePlan => 'प्लान के रूप में सेव करें';

  @override
  String get mealAiRecipeSaved => 'रेसिपी सेव हुई';

  @override
  String get mealAiPlanSaved => 'प्लान सेव हुआ';

  @override
  String get mealAiFlagEstimated => 'AI का अनुमान';

  @override
  String get mealAiFlagAdjusted => 'कैलोरी मैक्रोज़ के हिसाब से ठीक की गई';

  @override
  String get mealAiFlagDoubtful => 'हिसाब नहीं बैठता, जाँच लो';

  @override
  String get mealAiFlagNoValues => 'पोषण मान नहीं';

  @override
  String get mealAiFlagNoAmount => 'मात्रा नहीं दी';

  @override
  String get mealAiTruncated => 'जवाब अधूरा लगता है। पूरे खाने रख लिए गए।';

  @override
  String get mealAiAmount => 'मात्रा';

  @override
  String mealAiTargetLine(String kcal) {
    return 'लक्ष्य $kcal';
  }

  @override
  String get mealAiNothingChosen => 'कम से कम एक खाना चालू करो';

  @override
  String get cholesterolLabel => 'कोलेस्ट्रॉल';

  @override
  String get mealAiFlagMatched => 'तुम्हारे सेव किए खाने जैसा';

  @override
  String get mealAiNotSame => 'वैसा नहीं';

  @override
  String get homeOrderRow => 'हिस्सों का क्रम';

  @override
  String get homeOrderHint => 'होम का क्रम बदलने के लिए दबाकर रखो और खींचो।';

  @override
  String get homeOrderFolders => 'शॉर्टकट';

  @override
  String get equipNew => 'नया';

  @override
  String get equipNewTitle => 'नया उपकरण';

  @override
  String get equipNewHint => 'जैसे वेट बेल्ट';

  @override
  String get homeOrderWeekdays => 'हफ़्ते के टिक';

  @override
  String get repsMaxTitle => 'रेप्स तक';

  @override
  String get repsRangeHint => '8-12 जैसी रेंज तय करने के लिए रेप्स को देर तक दबाओ।';

  @override
  String get repsRangeClear => 'रेंज हटाएँ';

  @override
  String get noteLinksLabel => 'लिंक';

  @override
  String get noteLinkAdd => 'लिंक जोड़ें';

  @override
  String get noteLinkEdit => 'लिंक बदलें';

  @override
  String get noteLinkNameHint => 'नाम';

  @override
  String get noteLinkUrlHint => 'वेब पता';

  @override
  String get noteLinkInvalid => 'वह पता सही नहीं लगता';

  @override
  String get changeRest => 'एक्सरसाइज़ के बीच आराम';

  @override
  String get changeRestHint => 'आख़िरी सेट के बाद, अगली एक्सरसाइज़ से पहले';

  @override
  String get notifSuppTake => 'ले लिया';

  @override
  String get sideRest => 'दोनों तरफ़ के बीच आराम';

  @override
  String get sideRestHint => 'हर तरफ़ वाली एक्सरसाइज़: पहला ✓ एक तरफ़ ख़त्म करता है';

  @override
  String get gfxCompat => 'संगत ग्राफ़िक्स';

  @override
  String get gfxCompatHint =>
      'उन फ़ोन के लिए जिनमें अक्षर टूटे दिखते हैं। ब्लर रहता है, कुछ इफ़ेक्ट आसान हो जाते हैं';

  @override
  String get gfxRestartTitle => 'GymMane रीस्टार्ट करें?';

  @override
  String get gfxRestartBody =>
      'स्क्रीन बनाने का तरीक़ा बदलने के लिए यह बंद होकर फिर खुलेगा। तुम्हारा सेव किया कुछ नहीं खोएगा।';

  @override
  String get gfxRestart => 'रीस्टार्ट करें';

  @override
  String get webSynced => 'दूसरे डिवाइस के बदलावों से अपडेट हुआ';

  @override
  String get webSyncedPhone => 'तुम्हारे फ़ोन के बदलाव आ गए';

  @override
  String get webWelcomeBlurb => 'सब कुछ तुम्हारे अपने सर्वर पर रहता है। न अकाउंट, न क्लाउड, न कोई पैसा।';

  @override
  String get webOwnServer => 'तुम्हारा सर्वर, तुम्हारे नियम';

  @override
  String get webOwnServerWhy =>
      'न अकाउंट, न किसी और का क्लाउड। तुम्हारा डेटा वहीं रहता है जहाँ तुम इसे चलाते हो।';

  @override
  String get webServerSaved => 'तुम्हारे सर्वर पर सेव';

  @override
  String get webServerOffline => 'तुम्हारे सर्वर तक नहीं पहुँच पा रहे';

  @override
  String get webServerLocal => 'इस ब्राउज़र में सेव';

  @override
  String get webServerTitle => 'तुम्हारा सर्वर';

  @override
  String webPhoneLast(String date) {
    return 'फ़ोन की आख़िरी कॉपी: $date';
  }

  @override
  String get webPhoneNone => 'अभी फ़ोन से कोई कॉपी नहीं';

  @override
  String get webPhoneScan => 'फ़ोन से लाएँ';

  @override
  String get webPhoneExport => 'फ़ोन पर भेजें';

  @override
  String get webPhoneExportDone => 'साझा फ़ोल्डर में रख दिया। सिंक होने पर तुम्हारा फ़ोन इसे ले लेगा';

  @override
  String get webPhoneImported => 'तुम्हारे फ़ोन के बदलाव आ गए';

  @override
  String get webPhoneNothing => 'फ़ोन से कुछ नया नहीं';

  @override
  String get webPhoneHow =>
      'फ़ोन पर ऑटो बैकअप ऐसे फ़ोल्डर में चालू करो जिसे Syncthing से सिंक करते हो। सर्वर और फ़ोन एक-दूसरे के बदलाव अपने-आप ले लेते हैं, और मिलाने पर कभी कुछ नहीं हटता।';

  @override
  String get webPhoneGuide => 'इसे कैसे सेट करें';

  @override
  String get webPhoneOff => 'इस सर्वर पर फ़ोन सिंक बंद है';

  @override
  String get toolGroupBody => 'शरीर';

  @override
  String get toolNameProtein => 'प्रोटीन';

  @override
  String get toolTitleProtein => 'रोज़ का प्रोटीन';

  @override
  String get toolDescProtein => 'रोज़ कितना प्रोटीन';

  @override
  String get toolHintProtein => 'रोज़ के ग्राम, भोजन में बाँटकर';

  @override
  String get proteinGoalLabel => 'लक्ष्य';

  @override
  String get proteinExplain =>
      'ट्रेनिंग करने वालों के लिए ज़्यादातर अध्ययन जिस रेंज पर सहमत हैं, उस पर आधारित: वज़न घटाते समय ज़्यादा, ताकि मसल बनी रहे। इससे ऊपर जाना सुरक्षित है, बस फ़ायदा थोड़ा ही बढ़ता है।';

  @override
  String get toolNameWater => 'पानी';

  @override
  String get toolTitleWater => 'रोज़ का पानी';

  @override
  String get toolDescWater => 'रोज़ कितना पीना है';

  @override
  String get toolHintWater => 'रोज़ के लीटर, खाने समेत';

  @override
  String get waterTrainingLabel => 'रोज़ की ट्रेनिंग';

  @override
  String get waterExplain =>
      'शरीर के हर किलो पर लगभग 35 मिली, और ट्रेनिंग के हर मिनट के लिए थोड़ा ज़्यादा। गर्म दिनों में ज़्यादा पियो।';

  @override
  String get autoBackupSync => 'अभी सिंक करें';

  @override
  String get autoBackupMerged => 'तुम्हारे दूसरे डिवाइस के बदलाव आ गए';

  @override
  String get autoBackupSyncHint =>
      'इस फ़ोल्डर को Syncthing से साझा करो और हर डिवाइस वह ले लेगा जो दूसरे यहाँ छोड़ते हैं। मिलाने पर कभी कुछ नहीं हटता।';

  @override
  String get webPhoneFolder => 'साझा फ़ोल्डर';

  @override
  String get webPhoneFolderHow =>
      'सर्वर इंस्टॉल करते समय चुना जाता है। बदलने के लिए सर्वर की .env फ़ाइल में GYMMANE_SYNC सेट करो और उसे रीस्टार्ट करो।';

  @override
  String get webPhoneOffHow =>
      'चालू करने के लिए सर्वर की .env फ़ाइल से GYMMANE_SYNC=off हटाओ और उसे रीस्टार्ट करो।';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n फ़ोन सिंक हुए',
      one: '1 फ़ोन सिंक हुआ',
      zero: 'अभी किसी फ़ोन ने सिंक नहीं किया',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'फ़ोल्डर नहीं पढ़ा जा सका: $error';
  }
}
