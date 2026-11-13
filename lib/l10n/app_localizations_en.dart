// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% vs last month';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Level $level · $streak';
  }

  @override
  String get save => 'SAVE';

  @override
  String get cancel => 'Cancel';

  @override
  String get cancelCaps => 'CANCEL';

  @override
  String get deleteCaps => 'DELETE';

  @override
  String get done => 'DONE';

  @override
  String get set => 'Set';

  @override
  String get home => 'HOME';

  @override
  String get progress => 'PROGRESS';

  @override
  String get exercises => 'EXERCISES';

  @override
  String get settings => 'SETTINGS';

  @override
  String get today => 'TODAY';

  @override
  String get thisWeek => 'THIS WEEK';

  @override
  String get recommended => 'RECOMMENDED';

  @override
  String get goal => 'GOAL';

  @override
  String get volume => 'VOLUME';

  @override
  String get setsToday => 'SETS TODAY';

  @override
  String get prs => 'PRs';

  @override
  String get todaysFocus => 'TODAY\'S FOCUS';

  @override
  String get todaysRoutine => 'TODAY\'S ROUTINE';

  @override
  String get startWorkout => 'START WORKOUT';

  @override
  String get routines => 'ROUTINES';

  @override
  String get tools => 'TOOLS';

  @override
  String get firstSessionHint => 'Pick your muscles and log your first session';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n exercises', one: '$n exercise');
    return '$_temp0';
  }

  @override
  String get pushDay => 'PUSH DAY';

  @override
  String get pullDay => 'PULL DAY';

  @override
  String get legDay => 'LEG DAY';

  @override
  String get pushFocus => 'Chest · Shoulders · Triceps';

  @override
  String get pullFocus => 'Back · Biceps · Traps';

  @override
  String get legFocus => 'Quads · Hamstrings · Glutes';

  @override
  String get train => 'TRAIN';

  @override
  String get step1 => 'STEP 1 OF 2';

  @override
  String get step2 => 'STEP 2 OF 2';

  @override
  String get chooseFocus => 'CHOOSE YOUR FOCUS';

  @override
  String get buildSession => 'BUILD YOUR SESSION';

  @override
  String get tapMuscles => 'Tap the muscles you want to train, front and back.';

  @override
  String get continueBtn => 'CONTINUE';

  @override
  String get nothingForFocus => 'Nothing for this focus yet';

  @override
  String get goBackPick => 'Go back and pick a muscle with exercises in your library.';

  @override
  String pickedHint(int n) {
    return 'We picked a session for you. Tap to add or drop any of the $n.';
  }

  @override
  String get pickAnExercise => 'PICK AN EXERCISE';

  @override
  String get searchAllExercises => 'Search any exercise…';

  @override
  String get noExercisesMatch => 'No exercises match';

  @override
  String get createItInstead => 'Create it as your own instead';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n EXERCISES', one: '$n EXERCISE');
    return 'START · $_temp0';
  }

  @override
  String get inProgress => 'IN PROGRESS';

  @override
  String get paused => 'PAUSED';

  @override
  String get last => 'LAST';

  @override
  String get rest => 'REST';

  @override
  String get skip => 'SKIP';

  @override
  String get addSet => '+ ADD SET';

  @override
  String get finishSession => 'FINISH SESSION';

  @override
  String get setDone => 'SET DONE';

  @override
  String get nextExercise => 'NEXT EXERCISE';

  @override
  String get dropExerciseAction => 'Drop exercise';

  @override
  String get restOff => 'Off';

  @override
  String get miniRest => 'Rest-pause and cluster rest';

  @override
  String get miniRestHint => 'Before rest-pause or cluster sets';

  @override
  String get gymPass => 'Gym pass';

  @override
  String get gymPassEmpty => 'Keep your gym\'s code here and get in without the card';

  @override
  String get gymPassAdd => 'Add pass';

  @override
  String get gymPassScan => 'Take a photo of the code';

  @override
  String get gymPassScanHint => 'With your phone\'s camera';

  @override
  String get gymPassPhoto => 'From a photo or screenshot';

  @override
  String get gymPassPhotoHint => 'For example, a screenshot from your gym\'s app';

  @override
  String get gymPassType => 'Type the number';

  @override
  String get gymPassTypeHint => 'For barcodes: the number printed under it';

  @override
  String get gymPassNotFound => 'No QR code in that picture. Try a sharper one or type the number.';

  @override
  String get gymPassName => 'Gym name';

  @override
  String get gymPassDefaultName => 'My gym';

  @override
  String get gymPassCode => 'Code';

  @override
  String get gymPassFormat => 'Code type';

  @override
  String get gymPassInvalid => 'That number doesn\'t fit this code type';

  @override
  String get gymPassShowHint => 'Hold it to the reader. Brightness goes up on its own.';

  @override
  String get gymPassDeleted => 'Pass deleted';

  @override
  String get gymPassEdit => 'Edit pass';

  @override
  String get gymPassShow => 'Show at the door';

  @override
  String get gymPassPrivate => 'Stays on your phone only. Nothing is uploaded.';

  @override
  String get gymPassColor => 'Colour';

  @override
  String get gymPassRescan => 'Read the code again';

  @override
  String get gymPassReading => 'Reading the code…';

  @override
  String get gymPassSettingHint => 'Your gym card in your profile';

  @override
  String get gymPassMember => 'Member';

  @override
  String get widgetHintActivity => 'Your map of trained days';

  @override
  String get widgetHintStats => 'Streak, volume and sessions this week';

  @override
  String get widgetHintBody => 'The muscles you have worked';

  @override
  String get widgetHintToday => 'At a glance: did you train today?';

  @override
  String get widgetHintWeek => 'Your week\'s plan, day by day';

  @override
  String get supportHintBug => 'Tell me what broke, on GitHub';

  @override
  String get supportHintFeature => 'Suggest an idea for the app';

  @override
  String get supportHintStar => 'Helps more people find it';

  @override
  String get supportHintCoffee => 'Supports development. Free and with no ads';

  @override
  String get bodyweightNoteHint => 'Add a note: how you feel, what you are trying… (optional)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'Use $unit for this exercise';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'REPS';

  @override
  String weightCol(String unit) {
    return 'WEIGHT ($unit)';
  }

  @override
  String get repsTitle => 'REPS';

  @override
  String weightTitle(String unit) {
    return 'WEIGHT ($unit)';
  }

  @override
  String get sessionComplete => 'WORKOUT LOGGED';

  @override
  String get finishHeadlinePr => 'New personal record';

  @override
  String get finishHeadlineGoal => 'Weekly goal reached';

  @override
  String get finishHeadlineStreak => 'Streak alive';

  @override
  String get finishHeadlineDefault => 'Another one in the bank';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs exercises',
      one: 'an exercise',
    );
    return 'You lifted more than ever on $_temp0. It is in your records now.';
  }

  @override
  String get finishBodyGoal => 'You hit the sessions you set out to do this week.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak days in a row. The hard part is not stopping.';
  }

  @override
  String get finishBodyDefault => 'Logged and counted. Consistency is what moves the numbers.';

  @override
  String get vsLastTime => 'VS LAST TIME';

  @override
  String get firstTime => 'First time logged';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n new records',
      one: '$n new record',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'DURATION';

  @override
  String get setsCaps => 'SETS';

  @override
  String exerciseXofY(int i, int n) {
    return 'EXERCISE $i OF $n';
  }

  @override
  String get decrease => 'Decrease';

  @override
  String get increase => 'Increase';

  @override
  String markSet(int n) {
    return 'Mark set $n as done';
  }

  @override
  String get pauseWorkout => 'Pause workout';

  @override
  String get resumeWorkout => 'Resume workout';

  @override
  String get discardTitle => 'Discard workout?';

  @override
  String get discardBody => 'Your sets from this session will be lost.';

  @override
  String get keepTraining => 'Keep training';

  @override
  String get discard => 'Discard';

  @override
  String get notifRestChannel => 'Rest timer';

  @override
  String get notifRestChannelWhy => 'Tells you when your rest between sets is over';

  @override
  String get notifAlertChannel => 'Rest timer (alert)';

  @override
  String get notifAlertChannelWhy => 'Shows a banner the moment your rest is over';

  @override
  String get restOverTitle => 'Rest over';

  @override
  String get restOverBody => 'Back to it, next set is waiting.';

  @override
  String get allTimeSessions => 'SESSIONS';

  @override
  String get allTimeTime => 'TIME';

  @override
  String get allTimeSets => 'SETS';

  @override
  String get consistency => 'CONSISTENCY';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessions logged',
      one: '$n session logged',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n-day streak';
  }

  @override
  String get bodyweight => 'BODYWEIGHT';

  @override
  String get logBodyweight => 'LOG BODYWEIGHT';

  @override
  String get trackWeight => 'Track your weight over time';

  @override
  String get muscleMap => 'MUSCLE MAP';

  @override
  String get days7 => '7D';

  @override
  String get days30 => '30D';

  @override
  String get days90 => '90D';

  @override
  String get days365 => '1Y';

  @override
  String get daysAll => 'All';

  @override
  String get weeklyAvgTitle => 'Weekly average';

  @override
  String weekOfDate(String date) {
    return 'Week of $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change in this period';
  }

  @override
  String get heatLow => 'Untouched';

  @override
  String get heatHigh => 'Full volume';

  @override
  String get muscleMapEmpty => 'Log a session and your body starts lighting up here.';

  @override
  String get muscleMapHint => 'Tap a muscle to see what it got.';

  @override
  String muscleMapBehind(String names) {
    return 'Falling behind: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% of target';
  }

  @override
  String get muscleSplit => 'MUSCLE SPLIT';

  @override
  String get personalRecords => 'PERSONAL RECORDS';

  @override
  String get strength1rm => 'STRENGTH · EST. 1RM';

  @override
  String get strengthEmpty => 'Log an exercise twice and its strength curve shows up here.';

  @override
  String oneRmEst(String w) {
    return '1RM est. $w';
  }

  @override
  String get restDayShort => 'Rest day';

  @override
  String get restDay => 'Rest day, nothing logged.';

  @override
  String get delete => 'Delete';

  @override
  String get deleteEntry => 'Delete this entry?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" will be removed from this day, and from your records and charts.';
  }

  @override
  String get bodyweightHistory => 'HISTORY';

  @override
  String get exercisesCaps => 'EXERCISES';

  @override
  String get timeCaps => 'TIME';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n exercises in your library',
      one: '$n exercise in your library',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Search exercises';

  @override
  String get muscleFilter => 'MUSCLE';

  @override
  String get levelFilter => 'LEVEL';

  @override
  String get kindLabel => 'TYPE';

  @override
  String get kindStrength => 'Strength';

  @override
  String get kindCalisthenics => 'Calisthenics';

  @override
  String get kindCardio => 'Cardio';

  @override
  String get kindStretch => 'Stretching';

  @override
  String get newExercise => 'NEW EXERCISE';

  @override
  String get exerciseName => 'Exercise name';

  @override
  String get equipmentLabel => 'EQUIPMENT';

  @override
  String get addExercise => 'ADD EXERCISE';

  @override
  String get advanced => 'ADVANCED';

  @override
  String get demoMedia => 'DEMO';

  @override
  String get addMedia => 'Add media';

  @override
  String get mediaHint => 'Image, GIF or video';

  @override
  String get changeMedia => 'Change';

  @override
  String get videoSelected => 'Video selected';

  @override
  String get favouritesOnly => 'Favourites';

  @override
  String get noFavouritesYet => 'No favourites yet';

  @override
  String get noFavouritesHint => 'Tap the star on an exercise to keep it here.';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get quickAddAmount => 'How much you had';

  @override
  String get homeCardsTitle => 'Home cards';

  @override
  String get homeCardsHint => 'What you switch on shows up in Home';

  @override
  String get homeCardFocus => 'Today';

  @override
  String get homeCardSteps => 'Steps';

  @override
  String get homeCardWeek => 'This week';

  @override
  String get homeCardRoutines => 'Routines';

  @override
  String get homeCardRecommended => 'Suggested';

  @override
  String get textSizeSetting => 'Text size';

  @override
  String get textSizeSmall => 'Small';

  @override
  String get textSizeNormal => 'Normal';

  @override
  String get textSizeLarge => 'Large';

  @override
  String get textSizeHint => 'On top of your phone\'s text size';

  @override
  String get calmMotionSetting => 'Reduce motion';

  @override
  String get calmMotionHint => 'Screens appear without sliding in';

  @override
  String get dishArchive => 'Archive';

  @override
  String get dishUnarchive => 'Restore';

  @override
  String get dishArchivedToast => 'Dish archived';

  @override
  String get filterShowLabel => 'Show';

  @override
  String get noExercisesFound => 'No exercises found';

  @override
  String get noExercisesHint => 'Try a different search or clear your filters.';

  @override
  String get personalRecord => 'PERSONAL RECORD';

  @override
  String get history => 'HISTORY';

  @override
  String get noHistory => 'No sessions logged yet. Train this exercise to build history.';

  @override
  String get notes => 'NOTES';

  @override
  String get notePlaceholder => 'Cues, setup, how it felt…';

  @override
  String notHere(String gear, String place) {
    return 'No $gear at $place';
  }

  @override
  String get notHereWhy => 'Swap it for something you can actually load today.';

  @override
  String get altHere => 'WHAT YOU CAN DO HERE';

  @override
  String get places => 'MY PLACES';

  @override
  String get placesHint =>
      'Say what you have in each place and the library only shows what you can actually do there.';

  @override
  String get placeAll => 'Anywhere';

  @override
  String get placeNew => 'New place';

  @override
  String get placeNamePlaceholder => 'Home, gym, the park…';

  @override
  String get placeGearLabel => 'WHAT IS THERE';

  @override
  String placeExercises(int n) {
    return '$n exercises here';
  }

  @override
  String get placeEmptyTitle => 'Train wherever you are';

  @override
  String get placeEmptyBody =>
      'A place is a list of the kit you have there. Pick one to start and edit it later.';

  @override
  String get placeDeleteTitle => 'Delete place';

  @override
  String get placeDeleteBody => 'Only the place goes. Your exercises and sessions stay.';

  @override
  String get placeGym => 'Gym';

  @override
  String get placeHome => 'Home';

  @override
  String get placeOutdoors => 'Outdoors';

  @override
  String get placeFilterLabel => 'PLACE';

  @override
  String get noGearOnly => 'No kit';

  @override
  String placeActive(String name) {
    return 'Training at $name';
  }

  @override
  String get journal => 'JOURNAL';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notes',
      one: '1 note',
      zero: 'No notes',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Note';

  @override
  String get noteKindPlan => 'Plan';

  @override
  String get noteKindDone => 'Win';

  @override
  String get noteKindPain => 'Niggle';

  @override
  String get noteFilterAll => 'All';

  @override
  String get newNote => 'New note';

  @override
  String get editNote => 'Edit note';

  @override
  String get addNote => 'ADD NOTE';

  @override
  String get noteEmptyTitle => 'Nothing written down yet';

  @override
  String get noteEmptyBody =>
      'Cues, plans for next time, how a session felt. With photos or video if you want.';

  @override
  String get noteNoneForExercise => 'No notes on this exercise yet.';

  @override
  String get noteKindLabel => 'TYPE';

  @override
  String get noteTextLabel => 'NOTE';

  @override
  String get noteDateLabel => 'DATE';

  @override
  String get noteExerciseLabel => 'EXERCISE';

  @override
  String get noteMediaLabel => 'PHOTOS & VIDEO';

  @override
  String get noteGeneral => 'No exercise';

  @override
  String get noteAttach => 'Attach';

  @override
  String get noteRemoveMedia => 'Remove attachment';

  @override
  String get deleteNoteTitle => 'Delete note';

  @override
  String get deleteNoteBody => 'The note and anything attached to it go for good.';

  @override
  String get noteToday => 'Today';

  @override
  String get noteYesterday => 'Yesterday';

  @override
  String get noteAllNotes => 'All notes';

  @override
  String get noteCalendar => 'Calendar';

  @override
  String get noteNoneOnDay => 'Nothing written on this day';

  @override
  String get noteAddOnDay => 'Note on this day';

  @override
  String get notePrevMonth => 'Previous month';

  @override
  String get noteNextMonth => 'Next month';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notes this month',
      one: '1 note this month',
      zero: 'No notes this month',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'MEASUREMENTS';

  @override
  String get measuresHint => 'Neck to calf: watch your body change, not just the bar.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n readings',
      one: '1 reading',
      zero: 'Nothing logged',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Not logged yet';

  @override
  String get measureHistory => 'HISTORY';

  @override
  String get measureNeck => 'Neck';

  @override
  String get measureShoulders => 'Shoulders';

  @override
  String get measureChest => 'Chest';

  @override
  String get measureArm => 'Arm';

  @override
  String get measureForearm => 'Forearm';

  @override
  String get measureWaist => 'Waist';

  @override
  String get measureHips => 'Hips';

  @override
  String get measureThigh => 'Thigh';

  @override
  String get measureCalf => 'Calf';

  @override
  String get measureBodyfat => 'Body fat';

  @override
  String get timeline => 'TIMELINE';

  @override
  String get hidePhotos => 'Hide photos';

  @override
  String get showPhotos => 'Show photos';

  @override
  String get timelineHint => 'Same pose, same spot, same light. In a year you will not believe it.';

  @override
  String get timelineEmptyTitle => 'Your first photo starts the clock';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n photos',
      one: '1 photo',
      zero: 'No photos',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Front';

  @override
  String get poseSide => 'Side';

  @override
  String get poseBack => 'Back';

  @override
  String get photoEvery => 'REMIND ME';

  @override
  String photoEveryDays(int n) {
    return 'Every $n days';
  }

  @override
  String get photoEveryOff => 'Never';

  @override
  String get timelineEvery => 'GROUP EVERY';

  @override
  String get custom => 'Custom';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Next photo in $n days',
      one: 'Next photo tomorrow',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Photo due: grab it today';

  @override
  String get addTodayPhotos => 'ADD TODAY\'S PHOTOS';

  @override
  String posePhoto(String pose) {
    return '$pose photo';
  }

  @override
  String get compare => 'COMPARE';

  @override
  String get compareNeedTwo => 'Your next photo will show the before and after here.';

  @override
  String dayNumber(int n) {
    return 'Day $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days apart',
      one: '1 day apart',
      zero: 'Same day',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Delete this day';

  @override
  String get deleteDayBody => 'Its photos go with it, for good.';

  @override
  String get timelinePhotos => 'Photos';

  @override
  String get timelineBody => 'Muscle map';

  @override
  String get timelineBodyEmpty =>
      'Log a session and your muscle map starts filling in here, no photos needed.';

  @override
  String get timelineBodyHint => 'Built from your own sets, nothing to upload.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessions',
      one: '1 session',
      zero: 'No sessions',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Progress photos';

  @override
  String get notifPhotoChannelWhy => 'A nudge when your next progress photo is due.';

  @override
  String get notifPhotoTitle => 'Time for your progress photo';

  @override
  String notifPhotoBody(int n) {
    return '$n days since the last one. Same pose, same light.';
  }

  @override
  String get share => 'SHARE';

  @override
  String get sharePick => 'What do you want to show?';

  @override
  String get shareStreak => 'Streak and consistency';

  @override
  String get shareBody => 'Muscles worked';

  @override
  String get shareCompare => 'Before and after';

  @override
  String get shareHint => 'The card is built on your phone. Nothing leaves until you pick where it goes.';

  @override
  String get shareFailed => 'The card could not be built';

  @override
  String get shareWeekOf => 'LAST 7 DAYS';

  @override
  String get shareStreakLabel => 'DAY STREAK';

  @override
  String get shareSessionsLabel => 'SESSIONS';

  @override
  String get shareVolumeLabel => 'VOLUME';

  @override
  String get restForExercise => 'REST FOR THIS EXERCISE';

  @override
  String get restUsingDefault => 'Using your default';

  @override
  String get restCustom => 'Only for this one';

  @override
  String get setType => 'SET TYPE';

  @override
  String get setTypeNormal => 'Working';

  @override
  String get setTypeWarmup => 'Warm-up';

  @override
  String get setTypeDrop => 'Drop set';

  @override
  String get setTypeFailure => 'To failure';

  @override
  String get addWarmup => 'WARM-UP';

  @override
  String platesPerSide(String plates) {
    return 'Per side: $plates';
  }

  @override
  String get howTo => 'HOW TO';

  @override
  String get similar => 'SIMILAR';

  @override
  String get primaryLabel => 'PRIMARY';

  @override
  String get secondaryLabel => 'SECONDARY';

  @override
  String get none => 'None';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sets', one: '$n set');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v volume';
  }

  @override
  String get weeklyPlan => 'WEEKLY PLAN';

  @override
  String get yourRoutines => 'YOUR ROUTINES';

  @override
  String get noRoutines => 'No routines yet. Create one and add your exercises.';

  @override
  String get newRoutine => 'NEW ROUTINE';

  @override
  String get routineName => 'Routine name';

  @override
  String get schedule => 'SCHEDULE';

  @override
  String get addFromList => 'Add exercises from the list below.';

  @override
  String get addExercises => 'Add exercises';

  @override
  String get deleteRoutine => 'Delete this routine?';

  @override
  String exercisesWithCount(int n) {
    return 'EXERCISES · $n';
  }

  @override
  String setDay(String day) {
    return 'SET $day';
  }

  @override
  String get newRoutineName => 'New routine';

  @override
  String get dragToReorder => 'Drag the dotted handle to reorder, this is the order you train in.';

  @override
  String reorderHandle(String name) {
    return 'Reorder $name';
  }

  @override
  String get removeFromRoutine => 'Remove from routine';

  @override
  String get dropExercise => 'Drop this exercise?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" leaves this workout. Nothing logged is lost.';
  }

  @override
  String get drop => 'Drop';

  @override
  String get resetData => 'Delete all my data';

  @override
  String get resetTitle => 'Delete everything?';

  @override
  String get resetBody =>
      'Sessions, records, routines, notes and profile. This cannot be undone: export a backup first if you might want it.';

  @override
  String get resetConfirm => 'Delete everything';

  @override
  String get resetDone => 'All data deleted';

  @override
  String get support => 'SUPPORT';

  @override
  String get reportBug => 'Report a bug';

  @override
  String get requestFeature => 'Request a feature';

  @override
  String get starOnGithub => 'Star on GitHub';

  @override
  String get buyCoffee => 'Buy me a coffee';

  @override
  String get cantOpenLink => 'Couldn\'t open the link';

  @override
  String get theme => 'Theme';

  @override
  String get darkTheme => 'Dark';

  @override
  String get lightTheme => 'Light';

  @override
  String get amoledTheme => 'AMOLED black';

  @override
  String get editDuration => 'Workout length';

  @override
  String get sessionName => 'Workout name';

  @override
  String get nameWorkout => 'Name it';

  @override
  String get sessionNameHint => 'e.g. Legs, Push, Full body';

  @override
  String get secondaryPickHint => 'Tap the other muscles this exercise works.';

  @override
  String get languageLabel => 'Language';

  @override
  String get unitsLabel => 'Units';

  @override
  String get restTimer => 'Rest timer';

  @override
  String get alarmBlockedTitle => 'Notifications are off';

  @override
  String get alarmBlockedBody => 'The rest alarm won\'t go off with the screen locked';

  @override
  String get alarmBlockedAction => 'TURN ON';

  @override
  String get alarmSound => 'Alarm sound';

  @override
  String get alarmDefaultName => 'Default';

  @override
  String get alarmSoundHint => 'Use your own, up to 15 seconds';

  @override
  String get alarmChoose => 'Choose a sound…';

  @override
  String get alarmPreview => 'Play current sound';

  @override
  String get alarmReset => 'Reset to default';

  @override
  String get alarmTooLong => 'That sound is longer than 15 seconds';

  @override
  String get alarmInvalid => 'Couldn\'t read that audio file';

  @override
  String alarmChanged(String name) {
    return 'Alarm sound set to \"$name\"';
  }

  @override
  String get alarmChangedDefault => 'Back to the default sound';

  @override
  String get addActivityWidget => 'Add activity widget';

  @override
  String get addStatsWidget => 'Add stats widget';

  @override
  String get pinUnsupported => 'Add it from your launcher\'s widget menu';

  @override
  String get background => 'Background';

  @override
  String get bgNone => 'None';

  @override
  String get bgDots => 'Dots';

  @override
  String get bgGrid => 'Grid';

  @override
  String get exportCsv => 'Export workouts (CSV)';

  @override
  String get exportBackup => 'Export backup (ZIP)';

  @override
  String get importBackup => 'Import backup';

  @override
  String get importHint =>
      'Choose a .zip (or older .json) backup exported from GymMane. This replaces your current data, media included.';

  @override
  String get import => 'Import';

  @override
  String get chooseFile => 'Choose file';

  @override
  String get importFromApp => 'Import from another app';

  @override
  String get importUnknownFormat => 'That file needs date, exercise, reps and weight columns';

  @override
  String get importZipNoWeights => 'That zip has no weight file in it';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Imported $n weigh-ins',
      one: 'Imported $n weigh-in',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Couldn\'t read that file';

  @override
  String get importUnitTitle => 'Which unit is that file in?';

  @override
  String get importUnitBody => 'This export doesn\'t say which unit the weights are in.';

  @override
  String get importNothing => 'Nothing new to import';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Imported $n sessions',
      one: 'Imported $n session',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'About GymMane';

  @override
  String get yourProfile => 'YOUR PROFILE';

  @override
  String get autofills => 'Autofills the calculators';

  @override
  String get onbUnitsWhy => 'For weights, measurements and distances. You can change it anytime in Settings.';

  @override
  String get nameLabel => 'NAME';

  @override
  String get sexLabel => 'SEX';

  @override
  String get macroProtein => 'PROTEIN';

  @override
  String get macroCarbs => 'CARBS';

  @override
  String get macroFat => 'FAT';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get ageLabel => 'AGE';

  @override
  String get heightLabel => 'HEIGHT';

  @override
  String get weightLabel => 'WEIGHT';

  @override
  String get weeklyGoal => 'WEEKLY GOAL';

  @override
  String get activityLabel => 'ACTIVITY';

  @override
  String get addPhoto => 'Add a photo';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseGallery => 'Choose from gallery';

  @override
  String get backupImported => 'Backup imported';

  @override
  String get backupFailed => 'Couldn\'t read that backup';

  @override
  String get nothingToExport => 'Nothing to export yet: log a session first';

  @override
  String calculatorsCount(int n) {
    return '$n calculators for your training';
  }

  @override
  String get result => 'RESULT';

  @override
  String get weightLifted => 'WEIGHT LIFTED';

  @override
  String get repsPerformed => 'REPS PERFORMED';

  @override
  String get neck => 'NECK';

  @override
  String get waist => 'WAIST';

  @override
  String get hip => 'HIP (for women)';

  @override
  String get targetWeight => 'TARGET WEIGHT';

  @override
  String get workingWeight => 'WORKING WEIGHT';

  @override
  String get activityLevel => 'ACTIVITY LEVEL';

  @override
  String get barWeight => 'BAR WEIGHT';

  @override
  String get perSide => 'PER SIDE';

  @override
  String get justTheBar => 'Just the bar.';

  @override
  String perSideCount(int n) {
    return '× $n per side';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'Calories';

  @override
  String get toolNameBf => 'Body Fat';

  @override
  String get toolNamePlate => 'Plates';

  @override
  String get toolNameWarmup => 'Warm-up';

  @override
  String get toolTitleRm => '1RM Calculator';

  @override
  String get toolTitleBmi => 'BMI Calculator';

  @override
  String get toolTitleCal => 'Calories & Macros';

  @override
  String get toolTitleBf => 'Body Fat %';

  @override
  String get toolTitlePlate => 'Plate Calculator';

  @override
  String get toolTitleWarmup => 'Warm-up Sets';

  @override
  String get toolHintRm => 'Estimated 1-rep max (Epley formula)';

  @override
  String get toolHintCal => 'Estimated daily maintenance';

  @override
  String get toolHintBf => 'US Navy method estimate';

  @override
  String get toolHintPlate => 'Total barbell weight';

  @override
  String get toolHintWarmup => 'Working weight target';

  @override
  String get toolDescRm => 'Estimated one-rep max';

  @override
  String get toolDescBmi => 'Body mass index';

  @override
  String get toolDescCal => 'Calories & macros';

  @override
  String get toolDescBf => 'Body fat percentage';

  @override
  String get toolDescPlate => 'Barbell plate calculator';

  @override
  String get toolDescWarmup => 'Ramp-up sets';

  @override
  String get bmiUnderweight => 'Underweight';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Overweight';

  @override
  String get bmiObese => 'Obese';

  @override
  String get actSedentary => 'Sedentary';

  @override
  String get actLight => 'Light';

  @override
  String get actActive => 'Active';

  @override
  String get actModerate => 'Moderate';

  @override
  String get muscleChest => 'Chest';

  @override
  String get muscleBack => 'Back';

  @override
  String get muscleLowerBack => 'Lower back';

  @override
  String get muscleShoulders => 'Shoulders';

  @override
  String get muscleBiceps => 'Biceps';

  @override
  String get muscleTriceps => 'Triceps';

  @override
  String get muscleForearm => 'Forearm';

  @override
  String get muscleTrapezius => 'Trapezius';

  @override
  String get muscleAbdomen => 'Abdomen';

  @override
  String get muscleObliques => 'Obliques';

  @override
  String get muscleQuads => 'Quads';

  @override
  String get muscleHamstrings => 'Hamstrings';

  @override
  String get muscleGlutes => 'Glutes';

  @override
  String get muscleCalves => 'Calves';

  @override
  String get mgChest => 'Chest';

  @override
  String get mgBack => 'Back';

  @override
  String get mgLegs => 'Legs';

  @override
  String get mgShoulders => 'Shoulders';

  @override
  String get mgArms => 'Arms';

  @override
  String get mgCore => 'Core';

  @override
  String get equipBarbell => 'Barbell';

  @override
  String get equipDumbbell => 'Dumbbell';

  @override
  String get equipCable => 'Cable';

  @override
  String get equipMachine => 'Machine';

  @override
  String get equipBodyweight => 'Bodyweight';

  @override
  String get equipWeighted => 'Weighted';

  @override
  String get equipBand => 'Band';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Rings';

  @override
  String get equipOther => 'Other';

  @override
  String get diffBeginner => 'Beginner';

  @override
  String get diffAdvanced => 'Advanced';

  @override
  String get diffIntermediate => 'Intermediate';

  @override
  String get about => 'ABOUT';

  @override
  String version(String v) {
    return 'Version $v';
  }

  @override
  String get aboutBlurb => 'Built by lifters, for lifters.';

  @override
  String get freeForever => 'Free forever';

  @override
  String get freeForeverWhy => 'No subscription, no ads, nothing locked behind a paywall.';

  @override
  String get fullyOffline => 'Fully offline';

  @override
  String get fullyOfflineWhy => 'No account, no servers. Your training never leaves this phone.';

  @override
  String get yoursToTake => 'Your data is yours';

  @override
  String get yoursToTakeWhy => 'Export it to CSV whenever you like, and delete it all in one tap.';

  @override
  String get whatsInside => 'WHAT\'S INSIDE';

  @override
  String exercisesInside(int n) {
    return '$n exercises';
  }

  @override
  String get exercisesInsideWhy => 'Every one with an animation and step-by-step instructions.';

  @override
  String get calculatorsInside => '10 calculators';

  @override
  String get calculatorsInsideWhy =>
      '1RM, plates, BMI, calories, body fat, FFMI, warm-up, RPE load, and DOTS and Wilks strength scores, all with published formulas.';

  @override
  String get mathInside => 'Honest maths';

  @override
  String get mathInsideWhy =>
      'Volume, records and streaks come from your own sets. Nothing here is decoration.';

  @override
  String get streakCaps => 'STREAK';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'days', one: 'day');
    return '$_temp0';
  }

  @override
  String get reset => 'RESET';

  @override
  String get welcomeKicker => 'WELCOME TO';

  @override
  String get welcomeBlurb => 'Everything stays on your phone. No account, no internet, nothing to pay.';

  @override
  String get welcomeStart => 'GET STARTED';

  @override
  String onbStep(int i, int n) {
    return 'STEP $i OF $n';
  }

  @override
  String get onbNameTitle => 'What should we call you?';

  @override
  String get onbNameHint => 'Your name';

  @override
  String get onbPhotoAdd => 'Add a photo';

  @override
  String get onbPhotoChange => 'Change photo';

  @override
  String get onbPhotoTitle => 'Put a face to your profile';

  @override
  String get onbPhotoWhy =>
      'Optional. It stays on your phone and you can change it any time from your profile.';

  @override
  String get onbPhotoLater => 'LATER';

  @override
  String get onbNameWhy => 'Only used to greet you. It never leaves the phone.';

  @override
  String get onbBodyTitle => 'A few numbers';

  @override
  String get onbBodyWhy => 'They feed the calculators. You can change them any time in Settings.';

  @override
  String get onbGoalTitle => 'How often do you train?';

  @override
  String get onbGoalWhy => 'Sets your weekly goal ring. Be honest, not ambitious.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessions a week',
      one: '$n session a week',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Kilos or pounds?';

  @override
  String get next => 'NEXT';

  @override
  String get back => 'BACK';

  @override
  String get skip2 => 'Skip';

  @override
  String get madeWithLoveBy => 'MADE WITH LOVE BY';

  @override
  String get sourceCode => 'SOURCE CODE';

  @override
  String get suggested => 'SUGGESTED';

  @override
  String get results => 'RESULTS';

  @override
  String get noMatches => 'No exercise matches that search.';

  @override
  String get tapToEdit => 'Tap the pencil to fix an entry, or the bin to remove it.';

  @override
  String get editEntry => 'Edit';

  @override
  String get editEntryHint => 'Fix the reps or the weight of any set.';

  @override
  String get removeSet => 'Remove set';

  @override
  String get continueWorkout => 'CONTINUE';

  @override
  String get continueWorkoutBody =>
      'The workout goes back to being in progress, with its sets already ticked. Finishing it again saves it on its original day.';

  @override
  String get addBodyWidget => 'Add muscle map widget';

  @override
  String get repsOnly => 'Reps only';

  @override
  String get repsOnlyHint => 'Log this exercise without weight.';

  @override
  String get eachSide => 'Each side';

  @override
  String get eachSideHint => 'The timer runs once per side and the rest starts after both.';

  @override
  String get useDefaultArt => 'Back to the default art';

  @override
  String daysShort(int n) {
    return '${n}d';
  }

  @override
  String get focusCard => 'Today’s focus';

  @override
  String get autoAdvance => 'Move on automatically';

  @override
  String get keepScreenOn => 'Keep the screen on while training';

  @override
  String get lockWorkout => 'Lock the screen';

  @override
  String get unlockWorkout => 'Unlock';

  @override
  String get holdToUnlock => 'Hold to unlock';

  @override
  String get liveChannel => 'Ongoing workout';

  @override
  String get liveChannelWhy => 'Shows the current exercise, set and rest timer while you train';

  @override
  String liveSet(int n, int total) {
    return 'Set $n of $total';
  }

  @override
  String get liveResting => 'Resting';

  @override
  String get liveAllDone => 'All sets done';

  @override
  String get autoAdvanceHint => 'Moves on after the last set';

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
  String get reminderExactTime => 'Exact time';

  @override
  String get toastSoundSetting => 'Notice sound';

  @override
  String get toastSoundHint => 'A soft chime with each notice';

  @override
  String get notifTrainChannel => 'Training reminder';

  @override
  String get notifTrainChannelWhy => 'A nudge to train on the days you planned.';

  @override
  String get notifTrainTitle => 'Time to train';

  @override
  String get notifTrainBody => 'Your routine is waiting.';

  @override
  String get planIntro => 'Build me a training routine using only the exercises in this list.';

  @override
  String get planFormat => 'Answer with JSON only, in this shape:';

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
  String get tplArnold => 'Chest and back, shoulders and arms, legs. The classic six-day split.';

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
  String get rpeHint => '10 is nothing left in the tank, 8 is two reps to spare.';

  @override
  String get superset => 'Superset';

  @override
  String get supersetLink => 'Chain with the next one';

  @override
  String get supersetUnlink => 'Unchain from the next one';

  @override
  String get supersetHint => 'No rest between chained exercises, you go straight to the next one.';

  @override
  String get aiRoutine => 'Routine with AI';

  @override
  String get aiIntro =>
      'GymMane never talks to an AI. You take your exercise list out, you paste it into whatever assistant you already use, and you bring its answer back in. Nothing leaves the phone on its own.';

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

  @override
  String get awardFirstStepName => 'First step';

  @override
  String get awardFirstStepLine => 'Welcome to GymMane. This one is on the house.';

  @override
  String get awardFirstWorkoutName => 'First workout';

  @override
  String get awardFirstWorkoutLine => 'The first one is logged. That is the hard one.';

  @override
  String get awardFirstRoutineName => 'First routine';

  @override
  String get awardFirstRoutineLine => 'You have a plan to come back to.';

  @override
  String get awardFirstRecordName => 'First record';

  @override
  String get awardFirstRecordLine => 'You beat your best lift on an exercise.';

  @override
  String get awardStreak3Name => 'Three in a row';

  @override
  String get awardStreak3Line => 'Three days straight. This is how it starts.';

  @override
  String get awardTonne1Name => 'One tonne';

  @override
  String get awardTonne1Line => 'A thousand kilos lifted across your sets.';

  @override
  String get awardSets100Name => 'One hundred sets';

  @override
  String get awardSets100Line => 'A hundred sets finished, one at a time.';

  @override
  String get awardHours10Name => 'Ten hours';

  @override
  String get awardHours10Line => 'Ten hours of training on the clock.';

  @override
  String get awardWorkouts50Name => 'Fifty workouts';

  @override
  String get awardWorkouts50Line => 'Fifty sessions behind you.';

  @override
  String get awardHours50Name => 'Fifty hours';

  @override
  String get awardHours50Line => 'Fifty hours inside the gym.';

  @override
  String get awardsTitle => 'Medals';

  @override
  String get yearTitle => 'Your year';

  @override
  String get yearBestMonth => 'Best month';

  @override
  String get yearMonths => 'months';

  @override
  String get awardSpinHint => 'Drag the medal to spin it';

  @override
  String get awardUnlocked => 'New achievement unlocked';

  @override
  String get awardNice => 'Awesome!';

  @override
  String get awardSaveImage => 'Save image';

  @override
  String get awardSaved => 'Saved to your gallery';

  @override
  String get awardStreak7Name => 'Seven days';

  @override
  String get awardStreak7Line => 'A full week without missing a day.';

  @override
  String get awardStreak30Name => 'Thirty days';

  @override
  String get awardStreak30Line => 'A month straight. This is a habit now.';

  @override
  String get awardWorkouts100Name => 'One hundred workouts';

  @override
  String get awardWorkouts100Line => 'A hundred sessions logged, start to finish.';

  @override
  String get awardTonnes100Name => 'One hundred tonnes';

  @override
  String get awardTonnes100Line => 'Everything you have lifted adds up to 100,000 kg.';

  @override
  String get awardSets1000Name => 'A thousand sets';

  @override
  String get awardSets1000Line => 'One set at a time, a thousand of them.';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get pickBadge => 'Badge';

  @override
  String get statWorkouts => 'Workouts';

  @override
  String get statTrained => 'Trained';

  @override
  String get statSets => 'Sets';

  @override
  String get statLifted => 'Lifted';

  @override
  String get statStreak => 'Streak';

  @override
  String get statDays => 'days';

  @override
  String get unitHours => 'h';

  @override
  String get unitDays => 'days';

  @override
  String get snapshots => 'Photos';

  @override
  String get snapNow => 'Take one';

  @override
  String get addCover => 'Add a cover';

  @override
  String get addTodayWidget => 'Today done or not';

  @override
  String get photosCard => 'Your photos';

  @override
  String get handleLabel => 'Username';

  @override
  String get setupTitle => 'Fill these in and the rest of the page fills itself';

  @override
  String get setupHint => 'Every number here comes from what you log. Nothing is sent anywhere.';

  @override
  String get setupWorkout => 'Log your first workout';

  @override
  String get setupWeight => 'Write down your body weight';

  @override
  String get setupMeasures => 'Take your measurements';

  @override
  String get setupPhoto => 'Take your first progress photo';

  @override
  String get progressTitle => 'Progress';

  @override
  String get tileVolume30 => 'Volume · 30d';

  @override
  String get tileAddWeight => 'Add yours';

  @override
  String get heatToneTitle => 'Heat colour';

  @override
  String get heatToneHint => 'Only changes how the grid and the body are painted.';

  @override
  String get thisWeekTitle => 'This week';

  @override
  String get momentsEmptyTitle => 'Nothing here yet';

  @override
  String get deletePhotoTitle => 'Delete this photo?';

  @override
  String get deletePhotoBody => 'It goes for good.';

  @override
  String get awardsEarned => 'Earned';

  @override
  String get awardsLocked => 'Locked';

  @override
  String get awardStreak100Name => 'One hundred days';

  @override
  String get awardWorkouts10Name => 'Ten workouts';

  @override
  String get awardWorkouts10Line => 'The first ten are the ones that decide it.';

  @override
  String get awardWorkouts365Name => 'Three hundred and sixty-five';

  @override
  String get awardWorkouts365Line => 'A workout for every day of a year, logged one by one.';

  @override
  String get awardTonnes10Name => 'Ten tonnes';

  @override
  String get awardTonnes10Line => 'Ten thousand kilos have gone through your hands.';

  @override
  String get awardHours100Name => 'One hundred hours';

  @override
  String get awardHours100Line => 'A hundred hours under the bar, stopwatch in hand.';

  @override
  String awardWonOn(String date) {
    return 'Earned on $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Gold',
      'blue': 'Blue',
      'green': 'Green',
      'other': 'Badge',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Since $date';
  }

  @override
  String levelShort(int n) {
    return 'Level $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n workouts to level $next',
      one: '1 workout to level $next',
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
      'ember': 'Ember',
      'green': 'Green',
      'blue': 'Blue',
      'mono': 'Grey',
      'other': 'Colour',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n sets';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n of $goal this week';
  }

  @override
  String momentCount(int n) {
    return '$n photos';
  }

  @override
  String photosSelected(int n) {
    return '$n selected';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Delete $n photos?';
  }

  @override
  String get momentsEmptyHint =>
      'Snap the gym, the whiteboard, a plate setup. Anything you want to remember. They stay on the phone and only you see them.';

  @override
  String get awardStreak100Line =>
      'A hundred days in a row. That is not motivation any more, that is who you are.';

  @override
  String get coverLabel => 'COVER';

  @override
  String get removeCover => 'Remove cover';

  @override
  String get startTitle => 'Start workout';

  @override
  String get logTitle => 'Log a workout';

  @override
  String get logHint => 'No timer, just fill in what you did.';

  @override
  String get orStartFrom => 'Or start from';

  @override
  String get pickExercisesOption => 'Pick exercises';

  @override
  String get chooseFocusOption => 'Choose a focus';

  @override
  String get plannedRoutine => 'PLANNED';

  @override
  String get logWorkoutAction => 'LOG A WORKOUT';

  @override
  String get logging => 'LOGGING';

  @override
  String get placesLabel => 'My places';

  @override
  String get undo => 'Undo';

  @override
  String get deleteSet => 'Delete set';

  @override
  String get setDeleted => 'Set deleted';

  @override
  String get removeWarmup => 'Remove warm-up';

  @override
  String get addWeightAction => 'Add weight';

  @override
  String get workoutOverview => 'This workout';

  @override
  String get allExercisesShort => 'All';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total sets';
  }

  @override
  String get nowLabel => 'Now';

  @override
  String get deleteWorkout => 'Delete workout';

  @override
  String get deleteWorkoutBody => 'This workout and all its sets will be removed from your history.';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeAutoHint => 'Follows your phone';

  @override
  String get demoSizeTitle => 'Exercise demo while training';

  @override
  String get demoLarge => 'Large';

  @override
  String get demoSmall => 'Small';

  @override
  String get demoOff => 'Hidden';

  @override
  String get demoLoopTitle => 'Demo animation';

  @override
  String get demoLoopAlways => 'Loop';

  @override
  String get demoLoopShort => '10 seconds';

  @override
  String get demoLoopHint =>
      'Plays for about 10 seconds and stops on the starting pose. Tap the demo to watch it again.';

  @override
  String get alarmStyleTitle => 'When rest ends';

  @override
  String get alarmStyleLoud => 'Always ring';

  @override
  String get alarmStyleQuiet => 'Follow silent mode';

  @override
  String get alarmStyleVibrate => 'Vibrate only';

  @override
  String get alarmStyleHint =>
      'Always ring uses the alarm volume, even on silent. Follow silent mode uses the notification volume and just vibrates when your phone is muted.';

  @override
  String get suggestedPicks => 'Suggested for you';

  @override
  String get moreOptions => 'More options';

  @override
  String get suggestInWorkouts => 'Suggest in quick workouts';

  @override
  String get suggestInWorkoutsHint =>
      'Off keeps it out of the picks made for you. You can still add it by hand.';

  @override
  String get onbPlaceTitle => 'Where do you train?';

  @override
  String get onbPlaceWhy => 'Pick every place you train. We\'ll only suggest what you can do in each one.';

  @override
  String get onbPlaceGear => 'What do you have there?';

  @override
  String distanceCol(String unit) {
    return 'DISTANCE ($unit)';
  }

  @override
  String get timeCol => 'TIME';

  @override
  String get timePerSideCol => 'TIME / SIDE';

  @override
  String get timeMinutesTitle => 'Time (minutes)';

  @override
  String get timeSecondsTitle => 'Time (seconds)';

  @override
  String distanceTitle(String unit) {
    return 'Distance ($unit)';
  }

  @override
  String get holdLabel => 'Hold';

  @override
  String get stopLabel => 'Stop';

  @override
  String startHold(String time) {
    return 'Start · $time';
  }

  @override
  String get exerciseTypeLabel => 'Log by';

  @override
  String get typeReps => 'Reps & weight';

  @override
  String get typeTime => 'Time';

  @override
  String get typeCardio => 'Distance & time';

  @override
  String get exerciseTypeHint =>
      'Cardio like running or swimming logs distance and time. Holds like a plank log time.';

  @override
  String get howToLabel => 'How to (optional)';

  @override
  String get howToHint => 'One step per line';

  @override
  String get editExercise => 'Edit exercise';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get noStepsYet => 'No steps yet. Write your own so you remember how you do it.';

  @override
  String get addSteps => 'Write the steps';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'A regular set. It counts toward your volume and records.';

  @override
  String get setTypeWarmupInfo => 'Light sets to get ready. They don\'t count toward volume or records.';

  @override
  String get setTypeDropInfo => 'Straight after a set, lower the weight and keep going without resting.';

  @override
  String get setTypeFailureInfo =>
      'Keep going until you can\'t do another clean rep. Log the reps you actually did.';

  @override
  String get setTypeRestPauseInfo => 'Rest 10 to 20 seconds after the set, then squeeze out a few more reps.';

  @override
  String get planFormatNotes =>
      'Use the exercise names exactly as they appear in the list. \"sets\", \"reps\" (a number or a range like \"8-12\"), \"weight\" (in the unit given), \"rest\" in seconds and \"days\" are optional. For exercises marked cardio or time in the list, use \"time\" (seconds, or like \"30:00\") and \"distance\" (in km) instead of \"reps\"; to give each set its own values, list them in \"plan\", one entry per set with its own \"reps\" and \"weight\" (add \"type\": \"warmup\" for warm-up sets). \"superset\": true links an exercise with the next one. For several weeks, group the routines inside \"weeks\" like the second example.';

  @override
  String get planSets => 'Plan sets';

  @override
  String get planSetsHint =>
      'Choose the type, reps and weight of each set. Leave the weight on Auto to start from your last session.';

  @override
  String get planHintReps => 'Choose the type and reps of each set. Auto starts from your last session.';

  @override
  String get planHintTime => 'Choose the type and time of each set. Auto starts from your last session.';

  @override
  String get planHintTimeWeight =>
      'Choose the type, time and weight of each set. Auto starts from your last session.';

  @override
  String get planHintCardio =>
      'Choose the distance and time of each set. Auto starts from your last session.';

  @override
  String get timeOnly => 'Time only';

  @override
  String get autoValue => 'Auto';

  @override
  String get clearPlan => 'Clear plan';

  @override
  String get shareRoutine => 'Share routine';

  @override
  String get shareWeek => 'Share my week';

  @override
  String get shareWeekHint => 'All your routines and the day each one is on.';

  @override
  String shareMessage(String name) {
    return '$name: open the file with GymMane to add it.';
  }

  @override
  String get importRoutines => 'Import routines';

  @override
  String get importPasteHint => 'Paste a routine here: one shared from GymMane, an AI answer, JSON or CSV.';

  @override
  String get pasteAction => 'Paste';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n routines', one: '1 routine');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Also use its weekly schedule';

  @override
  String get useTheirScheduleHint => 'The days it brings replace what you have planned on them.';

  @override
  String get addToMyRoutines => 'Add to my routines';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n routines added',
      one: '1 routine added',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Nothing here GymMane can import';

  @override
  String get aiStepCopy => 'Copy the request. It carries your exercise list and the format GymMane reads.';

  @override
  String get aiStepAsk => 'Paste it into any AI and say what you want: days per week, goal, how many weeks.';

  @override
  String get aiStepPaste => 'Paste its answer below and import it. No file needed.';

  @override
  String get copyForAi => 'Copy for the AI';

  @override
  String get copiedDone => 'Copied';

  @override
  String get aiPasteHint => 'Paste the AI\'s answer here';

  @override
  String get importAction => 'Import';

  @override
  String get showFormat => 'See the format';

  @override
  String get shareAsFile => 'Share as a file';

  @override
  String get recoveryTab => 'Recovery';

  @override
  String recoveryOverall(int pct) {
    return 'Body $pct% recovered';
  }

  @override
  String get recoveryAllFresh => 'Everything is recovered. Good day to train anything.';

  @override
  String recoveryStill(String muscles) {
    return 'Still recovering: $muscles';
  }

  @override
  String get recoveryTired => 'Fatigued';

  @override
  String get recoveryFresh => 'Fresh';

  @override
  String get recoveryHint =>
      'Tap a muscle to see how recovered it is. Recent sets weigh more, and harder ones (by RPE) more still.';

  @override
  String recoveryPct(int pct) {
    return '$pct% recovered';
  }

  @override
  String readyInHours(int h) {
    return 'ready in ~$h h';
  }

  @override
  String get tplAbcd => 'Four days: chest and triceps, back and biceps, legs, shoulders and abs.';

  @override
  String get tplAbcde => 'Five days, one muscle group each: chest, back, legs, shoulders, arms.';

  @override
  String get elapsedCaps => 'ELAPSED';

  @override
  String get tapToChange => 'Tap to change';

  @override
  String get swipeToSkipHint => 'Swipe the timer sideways to skip the rest.';

  @override
  String get screenLocked => 'Screen locked';

  @override
  String get lockedHint => 'Press and hold the fingerprint at the top to unlock';

  @override
  String get liveDoneSet => 'Set done';

  @override
  String get liveSkipRest => 'Skip rest';

  @override
  String get livePause => 'Pause';

  @override
  String get liveResume => 'Resume';

  @override
  String get liveNext => 'Next';

  @override
  String liveUpNext(String name) {
    return 'Up next: $name';
  }

  @override
  String get stickerOpen => 'Share on a photo';

  @override
  String get stickerNoPhoto => 'No photo';

  @override
  String get stickerWorkout => 'Workout';

  @override
  String get stickerStreak => 'Streak';

  @override
  String get stickerDate => 'Date';

  @override
  String get stickerHint => 'Drag to move it, pinch to resize or turn it';

  @override
  String get stickerSaved => 'Saved to your gallery';

  @override
  String get stickerWeek => 'This week';

  @override
  String get getReady => 'Get ready';

  @override
  String sideOfTwo(String n) {
    return 'Side $n of 2';
  }

  @override
  String get switchSides => 'Switch sides';

  @override
  String get stickerGallery => 'Gallery';

  @override
  String get stickerCamera => 'Camera';

  @override
  String get shareIntroTitle => 'Share this routine';

  @override
  String get shareIntroBody =>
      'Send it to your partner, a friend or your family. They get a small file that opens in GymMane and adds it in one tap, with its sets and weights.';

  @override
  String get removedFromRoutine => 'Removed from the routine';

  @override
  String get radarTitle => 'Last 30 days';

  @override
  String get radarHint => 'See which areas need more work';

  @override
  String get radarEmpty => 'Train a few days to see your balance';

  @override
  String get radarBalanced => 'Good balance so far';

  @override
  String radarFocus(String list) {
    return 'Needs more: $list';
  }

  @override
  String get countdownReady => 'Get ready';

  @override
  String get countdownSkip => 'Tap to start now';

  @override
  String get countdownSetting => 'Countdown before starting';

  @override
  String get effortSetting => 'Log effort per set';

  @override
  String get effortHint =>
      'RPE: 10 means nothing left, 8 means two reps to spare. RIR counts the reps you had left. When a set has it, the estimated 1RM uses the RPE chart.';

  @override
  String get rirHint => '0 is nothing left in the tank, 2 is two reps to spare.';

  @override
  String get addWeekWidget => 'Add week widget';

  @override
  String get gamificationSetting => 'Medals and levels';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n reps', one: '$n rep');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Best set';

  @override
  String get weekStartSetting => 'Week starts on';

  @override
  String get stepOutOfWorkout => 'Pause and leave';

  @override
  String get saveToRoutine => 'SAVE CHANGES TO ROUTINE';

  @override
  String get routineUpdated => 'Routine updated';

  @override
  String saveChangesTitle(String name) {
    return 'Save changes to $name?';
  }

  @override
  String get saveChangesBody => 'Next time you start it, the routine will have these changes.';

  @override
  String get routineOrderChanged => 'New exercise order';

  @override
  String get mineOnly => 'Created by you';

  @override
  String createNamed(String name) {
    return 'Not here? Create “$name”';
  }

  @override
  String get orStartWith => 'Or start with';

  @override
  String get warmupFocus => 'Warm-up';

  @override
  String get warmupFocusHint => 'Mobility and activation, with or without kit';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Run, bike, row or skip, by distance and time';

  @override
  String get homeRecommended => 'Recommended on home';

  @override
  String get homeRoutines => 'Routines on home';

  @override
  String get homeRoutinesHint => 'Last done first';

  @override
  String get homeWeekStats => 'This week on home';

  @override
  String get homeWeekStatsHint => 'Volume, sets and PRs of the week';

  @override
  String get stepsSetting => 'Steps from Health Connect';

  @override
  String get stepsSettingHint => 'Today\'s steps on Home';

  @override
  String get stepsToday => 'Steps today';

  @override
  String stepsOfGoal(String goal) {
    return 'of $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count steps today';
  }

  @override
  String get stepsGoal => 'Daily step goal';

  @override
  String get stepsNoAccess => 'No access to your steps';

  @override
  String get stepsGrant => 'Tap to allow it in Health Connect';

  @override
  String get stepsInfoRead =>
      'It only reads your step count. It never reads anything else or writes to Health Connect.';

  @override
  String get stepsInfoLocal => 'Your steps stay on your phone. GymMane never connects to the internet.';

  @override
  String get stepsInfoOff => 'Turn it off anytime in Settings or in Health Connect.';

  @override
  String get stepsManage => 'Manage permission';

  @override
  String get routineDoneToday => 'Done for today · nice work';

  @override
  String get trainAgain => 'Train again';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days ago',
      one: 'Done yesterday',
      zero: 'Done today',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Archived';

  @override
  String get archiveExercise => 'Archive exercise';

  @override
  String get restoreExercise => 'Restore';

  @override
  String get archivedToast => 'Exercise archived';

  @override
  String get archivedToastHint => 'Find it under Exercises › Archived';

  @override
  String get archivedBanner => 'Archived. It stays out of lists and suggestions; your history is kept.';

  @override
  String get videoMarksHint => 'Pause on a step and tap the pin to jump there next time.';

  @override
  String get videoMarkHere => 'Mark this step here';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionTraining => 'Training';

  @override
  String get sectionAlerts => 'Reminders & alarm';

  @override
  String get sectionHome => 'Home';

  @override
  String get sectionWidgets => 'Widgets';

  @override
  String get sectionData => 'Data & backup';

  @override
  String get multiPlanSetting => 'Several routines a day';

  @override
  String get multiPlanHint => 'Tap every routine for this day. They go in the order you add them.';

  @override
  String routineOfDay(int n, int total) {
    return '$n of $total today';
  }

  @override
  String get nextToday => 'Next today';

  @override
  String get planAboutMe => 'About me:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age years old, $height tall, $weight.';
  }

  @override
  String planDays(int n) {
    return 'I want to train $n days a week.';
  }

  @override
  String get planNoHistory =>
      'No workouts logged yet: treat me as a beginner and keep volume and weights conservative.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n workouts logged in the last 30 days.',
      one: '1 workout logged in the last 30 days.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Best recent sets';

  @override
  String get planAskFirst =>
      'If you don’t know my goal (strength, muscle, fat loss or general fitness) or how long each session can last, ask me first in one short message. Once you have it, answer with JSON only.';

  @override
  String get backToTop => 'Back to top';

  @override
  String get deleteExerciseTitle => 'Delete this exercise?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" will be removed from your library and routines. Your past sets are kept.';
  }

  @override
  String get exportForStravaHint =>
      'Upload it in a browser at strava.com/upload/select (the Strava app can\'t import files). It shows up as a Weight Training with your sets.';

  @override
  String get manualStartTime => 'Start time';

  @override
  String get manualDuration => 'Duration';

  @override
  String get manualDurationUnset => 'Add duration';

  @override
  String get stravaRow => 'Export to Strava (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Pick a workout to take it to Strava. You get a .fit file: upload it in a browser at strava.com/upload/select and it shows up as a Weight Training with your sets.';

  @override
  String get stravaEmpty => 'No workouts to export yet.';

  @override
  String get tapToPause => 'Tap to pause';

  @override
  String get holdPausedHint => 'Paused · tap to resume';

  @override
  String get finishHoldNow => 'Finish set now';

  @override
  String get barWeightExercise => 'Bar or sled weight';

  @override
  String get barWeightHint => 'Used by the plate calculator';

  @override
  String get barWeightCustom => 'Your own · tap to reset';

  @override
  String get groupRename => 'Rename group';

  @override
  String get groupUngroup => 'Remove group, keep routines';

  @override
  String get groupDeleteAll => 'Delete group and routines';

  @override
  String groupDeleteTitle(String name) {
    return 'Delete “$name”?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count will be deleted. Your workout history is kept.';
  }

  @override
  String get tplRr =>
      'The r/bodyweightfitness classic: full body three days a week. Move up a step when it gets easy.';

  @override
  String get levelUpKicker => 'NEXT STEP';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps on $name two workouts in a row. Ready for the next step?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Swap it in $routine';
  }

  @override
  String get levelUpSee => 'See how it\'s done';

  @override
  String get levelUpLater => 'Not now';

  @override
  String get levelUpStay => 'Keep this one';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name is now in $routine';
  }

  @override
  String get levelUpStayed => 'No more step-up tips for this one';

  @override
  String get levelHintsSetting => 'Suggest the next step';

  @override
  String get heatmapLabelsSetting => 'Days and months on the activity map';

  @override
  String get rmPercent => 'PERCENTAGE';

  @override
  String rmAtPercent(String pct) {
    return '$pct of your max';
  }

  @override
  String get copyWorkout => 'Copy as text';

  @override
  String get goalSet => 'Set a goal';

  @override
  String get goalTargetReps => 'TARGET REPS';

  @override
  String goalToGo(String value) {
    return '$value to go';
  }

  @override
  String get goalReached => 'Goal reached';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n days left', one: '1 day left');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Past the date';

  @override
  String get goalDeadline => 'DEADLINE';

  @override
  String get goalNoDeadline => 'No deadline';

  @override
  String get goalRemove => 'Remove goal';

  @override
  String get exerciseNameMissing => 'Give it a name';

  @override
  String get aliasesLabel => 'Also called (optional)';

  @override
  String get aliasesHint => 'Other names, separated by commas';

  @override
  String alsoCalled(String names) {
    return 'Also: $names';
  }

  @override
  String get addToRoutine => 'Add to routine';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'In $n routines',
      one: 'In 1 routine',
      zero: 'Not in any routine yet',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Already in it';

  @override
  String get restInRoutine => 'Rest in this routine';

  @override
  String get restInRoutineHint => 'Same as the exercise';

  @override
  String get restInRoutineReset => 'Only here · tap to undo';

  @override
  String get swapExercise => 'Swap exercise';

  @override
  String get swapShort => 'Swap';

  @override
  String swapHint(String name) {
    return 'Instead of $name, only for today. When you finish, you can keep it in the routine.';
  }

  @override
  String get swapKeepsDone => 'The sets you already did stay logged; the new one picks up the rest.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Same muscle · $muscle';
  }

  @override
  String get swapDoneBefore => 'Done before';

  @override
  String get multiPlanSettingHint => 'More than one routine on the same weekday';

  @override
  String get levelHintsHint => 'Suggests the harder version';

  @override
  String get focusCardHint => 'Today’s routine, at the top of Home';

  @override
  String get gamificationHint => 'Medals, level and celebration';

  @override
  String get exerciseSettings => 'Settings for this exercise';

  @override
  String get placeActiveNow => 'You’re here';

  @override
  String get placeTapToUse => 'tap to train here';

  @override
  String get intervalDays => 'days';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target days';
  }

  @override
  String get toolNameRpe => 'RPE load';

  @override
  String get toolTitleRpe => 'Load by RPE';

  @override
  String get toolDescRpe => 'Weight for the effort you want';

  @override
  String get toolNameDots => 'Strength level';

  @override
  String get toolTitleDots => 'Strength level (DOTS)';

  @override
  String get toolDescDots => 'Your strength for your bodyweight';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'For $reps reps at RPE $rpe';
  }

  @override
  String get rpeYourSet => 'A set you just did';

  @override
  String get rpeGoal => 'What you want to do';

  @override
  String rpeOneRmLine(String value) {
    return 'Estimated 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 means you couldn’t do one more; 8 means you had two left.';

  @override
  String get dotsBestLifts => 'Your best lifts';

  @override
  String get dotsSquat => 'SQUAT';

  @override
  String get dotsBench => 'BENCH PRESS';

  @override
  String get dotsDeadlift => 'DEADLIFT';

  @override
  String dotsTotalLine(String value) {
    return 'Total: $value';
  }

  @override
  String get dotsExplain =>
      'Compares your strength with anyone’s, whatever they weigh. Use your best single rep, or your estimated 1RM.';

  @override
  String get dotsLevel0 => 'Beginner';

  @override
  String get dotsLevel1 => 'Intermediate';

  @override
  String get dotsLevel2 => 'Advanced';

  @override
  String get dotsLevel3 => 'Very advanced';

  @override
  String get dotsLevel4 => 'Elite';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks score';

  @override
  String get toolDescWilks => 'The classic powerlifting score';

  @override
  String get wilksExplain =>
      'The classic powerlifting formula. DOTS replaced it in 2020, but many meets and rankings still use it.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Fat-free mass index';

  @override
  String get toolDescFfmi => 'How much muscle for your height';

  @override
  String get ffmiBodyFat => 'BODY FAT';

  @override
  String ffmiLeanLine(String value) {
    return 'Lean mass: $value';
  }

  @override
  String get ffmiExplain =>
      'Like BMI, but without the fat: it only counts your lean mass. Adjusted to your height so tall and short people compare fairly.';

  @override
  String get ffmiLevel0 => 'Below average';

  @override
  String get ffmiLevel1 => 'Average';

  @override
  String get ffmiLevel2 => 'Above average';

  @override
  String get ffmiLevel3 => 'Excellent';

  @override
  String get ffmiLevel4 => 'Exceptional';

  @override
  String get rpeEffortLabel => 'Effort (RPE)';

  @override
  String get restRowHint => 'Between sets, unless the exercise has its own';

  @override
  String get effortRowHint => 'Log RPE or RIR on each set';

  @override
  String get countdownHint => '3, 2, 1 before the first set';

  @override
  String get keepScreenOnHint => 'The screen stays on while you train';

  @override
  String get demoSizeRowHint => 'The exercise drawing during the workout';

  @override
  String get demoLoopRowHint => 'Whether the animation repeats or stops';

  @override
  String get trainReminderRowHint => 'A nudge on the days you train';

  @override
  String get alarmSoundRowHint => 'What plays when the rest ends';

  @override
  String get alarmStyleRowHint => 'Whether it rings in silent mode';

  @override
  String get recommendedRowHint => 'Exercises we suggest on Home';

  @override
  String get weightStepSetting => 'Weight step';

  @override
  String get weightStepHint => 'What the − and + buttons add';

  @override
  String get prBestWorkout => 'Best workout';

  @override
  String get mergeExercise => 'Merge';

  @override
  String mergeExerciseInto(String name) {
    return 'Merge $name into…';
  }

  @override
  String get mergeExerciseTitle => 'Merge exercises?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'All the history of \"$from\" moves to \"$to\". \"$from\" stays in your library. This can\'t be undone.';
  }

  @override
  String get mergedToast => 'History merged';

  @override
  String get nutrition => 'Nutrition';

  @override
  String get nutritionHomeEmpty => 'Water, protein and calories';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g protein';
  }

  @override
  String get nutritionToday => 'Today';

  @override
  String get nutritionYesterday => 'Yesterday';

  @override
  String get nutritionGoals => 'Daily goals';

  @override
  String get kcalLabel => 'CALORIES';

  @override
  String get kcalOver => 'over';

  @override
  String get waterLabel => 'WATER';

  @override
  String get waterDone => 'Goal reached';

  @override
  String get waterCustom => 'Other amount';

  @override
  String get glassSize => 'Glass size';

  @override
  String get supplementsLabel => 'SUPPLEMENTS';

  @override
  String get supplementsEmpty => 'Tap one to add it, or + for your own.';

  @override
  String get addSupplement => 'New supplement';

  @override
  String get supplementNameHint => 'Creatine, vitamin D…';

  @override
  String removeSupplementTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get removeSupplementBody => 'The days you marked it as taken go with it.';

  @override
  String get suppCreatine => 'Creatine';

  @override
  String get suppVitaminD => 'Vitamin D';

  @override
  String get suppOmega3 => 'Omega-3';

  @override
  String get suppMagnesium => 'Magnesium';

  @override
  String get suppMultivitamin => 'Multivitamin';

  @override
  String get suppCaffeine => 'Caffeine';

  @override
  String get myFoods => 'My foods';

  @override
  String get newFood => 'New food';

  @override
  String get editFood => 'Edit food';

  @override
  String get foodNameHint => 'Whey protein, oats, bread…';

  @override
  String get servingLabel => 'SERVING';

  @override
  String get servingHint => '1 scoop · 30 g';

  @override
  String get perServing => 'PER SERVING';

  @override
  String get servingsLabel => 'Servings';

  @override
  String get foodPhotoHint => 'On a plain background it turns into a sticker.';

  @override
  String get cutoutWorking => 'Cutting out…';

  @override
  String get cutoutTry => 'Cut out';

  @override
  String get cutoutKeep => 'Whole photo';

  @override
  String deleteFoodTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get deleteFoodBody => 'It leaves your foods. What you already logged stays.';

  @override
  String get mealBreakfast => 'Breakfast';

  @override
  String get mealLunch => 'Lunch';

  @override
  String get mealDinner => 'Dinner';

  @override
  String get mealSnacks => 'Snacks';

  @override
  String get nothingLogged => 'Nothing logged yet.';

  @override
  String addToMeal(String meal) {
    return 'Add to $meal';
  }

  @override
  String get quickAdd => 'Quick add';

  @override
  String get quickAddHint => 'Just the numbers, without saving a food.';

  @override
  String get quickAddName => 'What was it? (optional)';

  @override
  String get logFood => 'Add';

  @override
  String loggedToast(String meal) {
    return 'Added to $meal';
  }

  @override
  String get entryRemoved => 'Removed';

  @override
  String get goalsFromProfile => 'Calculate from my profile';

  @override
  String get goalsFromProfileHint =>
      'Calories from your profile, 1.8 g of protein and 35 ml of water per kg of bodyweight.';

  @override
  String get kcalEaten => 'Eaten';

  @override
  String get kcalRemaining => 'Remaining';

  @override
  String waterTapHint(String amount) {
    return 'Tap the glass: + $amount';
  }

  @override
  String get shakeEmpty => 'Tap to pick your shake';

  @override
  String shakeTapHint(String name) {
    return 'Tap: + $name';
  }

  @override
  String get shakePick => 'Your shake';

  @override
  String get shakePickHint => 'Tap the shaker and it gets logged in one go.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'C';

  @override
  String get fatLetter => 'F';

  @override
  String get addBurnedLabel => 'Add burned calories';

  @override
  String get addBurnedHint =>
      'Your goal already counts your usual activity. Turn this on only if you set yourself as sedentary: it adds what each workout burns on top of resting.';

  @override
  String get amountLabel => 'Amount';

  @override
  String amountIn(String unit) {
    return 'Amount ($unit)';
  }

  @override
  String get bodyweightLabel => 'Bodyweight';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count foods copied',
      one: '1 food copied',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'What you already logged stays as it is.';

  @override
  String get fiberLabel => 'Fiber';

  @override
  String get sugarLabel => 'Sugar';

  @override
  String get sodiumLabel => 'Sodium';

  @override
  String get foodDatabase => 'Food database';

  @override
  String get kcalBurned => 'Burned';

  @override
  String get mealOptions => 'Meal options';

  @override
  String get moreNutrients => 'Fiber, sugar and sodium';

  @override
  String ofGoal(int goal, String unit) {
    return 'of $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'per 100 $unit';
  }

  @override
  String get perServingShort => 'per serving';

  @override
  String get foodCategory => 'CATEGORY';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pieces', one: '1 piece');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count slices', one: '1 slice');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count scoops', one: '1 scoop');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tbsp', one: '1 tbsp');
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tsp', one: '1 tsp');
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count cups', one: '1 cup');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count glasses', one: '1 glass');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Recent';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count foods', one: '1 food');
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Rename';

  @override
  String get repeatFrom => 'Repeat from';

  @override
  String get repeatNone => 'Nothing logged for this meal on other days yet.';

  @override
  String get restDayGoals => 'Different goals on rest days';

  @override
  String get trainingDays => 'Training days';

  @override
  String get restDays => 'Rest days';

  @override
  String get trainingDay => 'Training day';

  @override
  String get saveAsMeal => 'Save as a meal';

  @override
  String get savedMealNameHint => 'e.g. Usual breakfast';

  @override
  String get savedMealToast => 'Meal saved';

  @override
  String get savedMeals => 'Saved meals';

  @override
  String get searchFoodsHint => 'Search foods';

  @override
  String get searchFoodsEmpty => 'Search over 500 foods with photos, or add your own.';

  @override
  String searchFoodsNone(String query) {
    return 'Nothing found for \"$query\". Create it as your own food.';
  }

  @override
  String get servingWeight => 'GRAMS';

  @override
  String get weekAverage => 'This week';

  @override
  String get weekAvgEnergy => 'Daily average';

  @override
  String get weekAvgProtein => 'Protein per day';

  @override
  String get weekEnergyOnTarget => 'Calories on target';

  @override
  String get weekProteinOnTarget => 'Protein on target';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g protein a day';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met of $days days on target';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days logged',
      one: '1 day logged',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Nothing logged yet';

  @override
  String get weekOnTargetHint =>
      'On target: calories within 10% of the goal and at least 90% of the protein.';

  @override
  String get weightGoalLabel => 'Goal weight';

  @override
  String weightGoalTitle(String unit) {
    return 'Goal weight ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Goal $weight';
  }

  @override
  String get weightGoalNone => 'Hold to set a goal';

  @override
  String get weightGoalReached => 'Goal reached';

  @override
  String weightToLose(String weight) {
    return '$weight to lose';
  }

  @override
  String weightToGain(String weight) {
    return '$weight to gain';
  }

  @override
  String get aminoHis => 'histidine';

  @override
  String get aminoIle => 'isoleucine';

  @override
  String get aminoLeu => 'leucine';

  @override
  String get aminoLys => 'lysine';

  @override
  String get aminoSaa => 'methionine';

  @override
  String get aminoAaa => 'phenylalanine';

  @override
  String get aminoThr => 'threonine';

  @override
  String get aminoTrp => 'tryptophan';

  @override
  String get aminoVal => 'valine';

  @override
  String get animalProtein => 'Animal protein';

  @override
  String get proteinQuality => 'Protein quality';

  @override
  String get qualityComplete => 'Complete';

  @override
  String get qualityAlmost => 'Almost complete';

  @override
  String get qualityIncomplete => 'Incomplete';

  @override
  String get qualityNoData => 'No data yet';

  @override
  String get qualityNoDataHint => 'Log foods from the database to see your amino acids.';

  @override
  String get qualityAllCovered => 'All nine essential amino acids are covered.';

  @override
  String qualityLimiting(String amino) {
    return 'Short on $amino. Pair it with foods rich in it.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Based on $pct% of your protein: your own foods have no amino acid data.';
  }

  @override
  String get fatTypes => 'Fat types';

  @override
  String get fatSaturated => 'Saturated';

  @override
  String get fatMono => 'Mono';

  @override
  String get fatPoly => 'Poly';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Saturated $grams g of $limit g max (10% of calories)';
  }

  @override
  String get sugarSodium => 'Sugar and sodium';

  @override
  String get shakeCard => 'Protein shake';

  @override
  String get mealOther => 'Meal';

  @override
  String get mealAdd => 'Add a meal';

  @override
  String get mealAddHint => 'e.g. Pre-workout';

  @override
  String get mealsOfDay => 'Meals of the day';

  @override
  String get mealsHint =>
      'Create as many as you want. Removing one moves what you logged in it to the one above.';

  @override
  String get trackersTitle => 'Customize';

  @override
  String get trackersHint => 'Show only what you want to track.';

  @override
  String get trackersDaily => 'Daily summary';

  @override
  String get trackersDetail => 'In detail';

  @override
  String get trackersCards => 'Cards';

  @override
  String get prepTitle => 'Meal prep';

  @override
  String get prepNewShort => 'New batch';

  @override
  String get prepNew => 'New batch';

  @override
  String get prepEdit => 'Edit batch';

  @override
  String get prepHint => 'Log the whole pot once, then eat it bit by bit.';

  @override
  String get prepEmpty =>
      'Cooked a big batch? Log it once and then just say how much of what is left you ate.';

  @override
  String get prepNameHint => 'e.g. Chicken and rice';

  @override
  String get prepDefaultName => 'Batch';

  @override
  String get prepIngredients => 'Ingredients';

  @override
  String get prepAddIngredient => 'Add ingredient';

  @override
  String get prepCookedWeight => 'COOKED WEIGHT';

  @override
  String prepCookedHint(String grams) {
    return 'Weigh the pot once cooked for exact numbers. Empty uses the raw total ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Add the cooked weight: some ingredients have no grams.';

  @override
  String prepLeftOf(String left, String total) {
    return '$left left of $total';
  }

  @override
  String get prepOfWhatsLeft => '% of what is left';

  @override
  String get prepAll => 'All';

  @override
  String prepLogAmount(String grams) {
    return 'Log $grams';
  }

  @override
  String get prepWeighLeft => 'Weigh what is left';

  @override
  String get prepFinished => 'This batch is finished.';

  @override
  String get approxValues => 'Approximate';

  @override
  String get editValues => 'Edit values';

  @override
  String get editValuesHint =>
      'Only changes this entry. To fix the food for next time, edit it from My foods.';

  @override
  String get editLibraryHint => 'Saved as your own food, with the same photo';

  @override
  String per100Line(String energy, String unit) {
    return '$energy per 100 $unit';
  }

  @override
  String get rawLabel => 'Raw';

  @override
  String get cookedLabel => 'Cooked';

  @override
  String get rawHint => 'Weight before cooking';

  @override
  String cookedHint(String factor) {
    return 'Weight once cooked (×$factor the raw weight)';
  }

  @override
  String get servingsUnit => 'servings';

  @override
  String logAmount(String energy) {
    return 'Log · $energy';
  }

  @override
  String get catFruit => 'Fruit';

  @override
  String get catVeg => 'Veggies';

  @override
  String get catMeat => 'Meat';

  @override
  String get catFish => 'Fish';

  @override
  String get catEgg => 'Eggs';

  @override
  String get catDairy => 'Dairy';

  @override
  String get catGrain => 'Grains';

  @override
  String get catBakery => 'Bakery';

  @override
  String get catLegume => 'Legumes';

  @override
  String get catNut => 'Nuts';

  @override
  String get catOil => 'Oils';

  @override
  String get catPantry => 'Pantry';

  @override
  String get catDrink => 'Drinks';

  @override
  String get catSauce => 'Sauces';

  @override
  String get catSpice => 'Spices';

  @override
  String get searchFoodsPrompt => 'What did you eat?';

  @override
  String get shelfEmpty => 'Search a food or take a photo of yours: the ones you log most will show up here.';

  @override
  String get repeatEntry => 'Log again';

  @override
  String get notifSuppChannel => 'Supplements';

  @override
  String get notifSuppChannelWhy => 'Daily reminder to take your supplements';

  @override
  String get energySplit => 'Where the calories come from';

  @override
  String get typicalServing => 'Typical serving';

  @override
  String cookedYieldLine(String factor) {
    return 'Weighs $factor× its raw weight';
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
  String get planDeleteBody => 'Your logged days stay as they are.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Nutrition';

  @override
  String get nutritionBetaHint => 'Meals, water and supplements';

  @override
  String get nutritionAboutTitle => 'About Nutrition';

  @override
  String get nutritionAboutSub => 'What it is, and what it will never be.';

  @override
  String get nutritionAboutWhatTitle => 'Part of your training';

  @override
  String get nutritionAboutWhat =>
      'A simple way to log meals, water, protein and supplements right next to your workouts. GymMane is a gym app first: Nutrition is here so you can keep everything in one place, not to replace a dedicated diet app.';

  @override
  String get nutritionAboutScanTitle => 'No scanning, ever';

  @override
  String get nutritionAboutScan =>
      'Scanning a barcode and having every detail filled in for you would be handy. But it needs the internet and a huge online food database, and what you eat ends up on someone else\'s servers. That data shows when you eat, what you eat and how you look after your body, and it can be used for advertising or passed on to big companies. That\'s why there\'s no scanner, and there won\'t be one.';

  @override
  String get nutritionAboutLocalTitle => 'Everything on your phone';

  @override
  String get nutritionAboutLocal =>
      'More than 500 foods with photos come inside the app. You can add your own, change their photos and edit their values. It all stays on your phone, like the rest of GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Still in beta';

  @override
  String get nutritionAboutBeta =>
      'If you miss something, suggest it on GitHub. Just not scanning or a bigger food database: besides your privacy, it would make the app much heavier. Don\'t need Nutrition? Turn it off in Settings and your data stays.';

  @override
  String get nutritionAboutSuggest => 'Suggest an idea';

  @override
  String get nutritionAboutOk => 'Got it';

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
  String get planNameHint => 'Plan name';

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
  String get planFixedWeek => 'Fixed week';

  @override
  String get planRotation => 'Rotation';

  @override
  String get rotationTitle => 'ROTATION';

  @override
  String get rotationHint => 'Next up is whatever follows your last workout, whatever the day.';

  @override
  String get rotationEmpty => 'Add your routines in the order you’ll do them: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done of $total done this round';
  }

  @override
  String get rotationNext => 'Next';

  @override
  String get rotationAdd => 'Add routines';

  @override
  String get rotationPickHint => 'They go in the order you tap them.';

  @override
  String get rotationSkip => 'Skip to the next one';

  @override
  String get rotationRestart => 'Start a new round';

  @override
  String get rotationMakeNext => 'Make it the next one';

  @override
  String get rotationRemove => 'Remove from rotation';

  @override
  String rotationPlace(int n, int total) {
    return '$n of $total in the rotation';
  }

  @override
  String get moveToDay => 'Move to another day';

  @override
  String get moveToDayHint => 'Just this once; your weekly plan stays the same.';

  @override
  String get movedToast => 'Workout moved';

  @override
  String get backToPlan => 'Back to the weekly plan';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get untrainedTab => 'Untrained';

  @override
  String get untrainedRecent => 'Recent';

  @override
  String get untrainedLong => 'Long ago';

  @override
  String untrainedWaiting(String list) {
    return 'Waiting the longest: $list';
  }

  @override
  String get untrainedAllRecent => 'Every muscle got work this week. Nice.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days ago',
      one: 'Trained yesterday',
      zero: 'Trained today',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Not trained yet';

  @override
  String get layoutSetting => 'Workout layout';

  @override
  String get layoutCards => 'Cards';

  @override
  String get layoutList => 'List';

  @override
  String get layoutHint =>
      'Cards show one exercise at a time. List shows the whole workout on one screen, set by set.';

  @override
  String get layoutRowHint => 'One exercise at a time, or the whole workout as a list';

  @override
  String get previousCol => 'PREVIOUS';

  @override
  String get usePrevious => 'Use last time’s numbers';

  @override
  String get skipShort => 'Skip';

  @override
  String get moveUp => 'Move up';

  @override
  String get moveDown => 'Move down';

  @override
  String get widgetNutritionOff => 'Turn on Nutrition in Settings › Beta to use this widget.';

  @override
  String get widgetPickShake => 'Pick your shake';

  @override
  String get heatRangeSetting => 'Activity calendar';

  @override
  String get heatRangeWeeks => '12 weeks';

  @override
  String get heatRangeYear => '12 months';

  @override
  String get heatRangeHint =>
      '12 months shows the whole year. Swipe it sideways to go back, all the way to your first workout.';

  @override
  String get pdfPlan => 'Plan as PDF';

  @override
  String get pdfPlanHint => 'A clean sheet with your week and every routine, ready to print or send.';

  @override
  String get pdfExport => 'Export as PDF';

  @override
  String get pdfFooter => 'Free, open source and offline';

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
  String get pdfKicker => 'TRAINING PLAN';

  @override
  String get pdfStatDays => 'DAYS / WEEK';

  @override
  String get pdfStatMinutes => 'MIN / WORKOUT';

  @override
  String pdfMinutes(int n) {
    return '≈ $n min';
  }

  @override
  String get workoutNotesTitle => 'Exercise notes';

  @override
  String get workoutNoteEvery => 'Every time';

  @override
  String get workoutNoteNext => 'Next time';

  @override
  String get workoutNoteEveryHint =>
      'Shows each time you do this exercise. Good for seat or pulley settings.';

  @override
  String get workoutNoteNextHint => 'Shows the next time only, then goes away.';

  @override
  String workoutNoteFromLast(String date) {
    return 'From last time · $date';
  }

  @override
  String get workoutNoteHint => 'Seat in hole 2, pulley at 19…';

  @override
  String get notePinWorkout => 'Show during workouts';

  @override
  String get assistedSetting => 'Assisted machine';

  @override
  String get assistedSettingHint =>
      'The weight helps you, so less is better: your records and suggestions go down.';

  @override
  String get assistedRecordHint => 'Least assistance';

  @override
  String get trainAgainLabel => 'Haven’t trained yet? Remind me again';

  @override
  String get trainAgainOff => 'No';

  @override
  String trainAgainAfter(int n) {
    return '+$n h';
  }

  @override
  String get trainAgainHint => 'Just once, and only if you haven’t logged a workout that day.';

  @override
  String get notifTrainAgainBody => 'There’s still time to train today.';

  @override
  String nextDeload(int n) {
    return 'lighter: $n workouts in a row without every rep';
  }

  @override
  String get historyTitle => 'History';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n WORKOUTS', one: '1 WORKOUT');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'No workouts this month';

  @override
  String get historyEmptyHint => 'Swipe sideways or use the arrows to see other months.';

  @override
  String historyMore(int n) {
    return '+$n more';
  }

  @override
  String get stopwatch => 'Stopwatch';

  @override
  String get proteinSource => 'Protein source';

  @override
  String get proteinMixedShort => 'Mixed';

  @override
  String get kcalActive => 'active';

  @override
  String get kcalEstimated => 'estimated';

  @override
  String get kcalYours => 'your value';

  @override
  String kcalTotalRest(String value) {
    return '$value in total, counting what you burn at rest';
  }

  @override
  String get inclineLabel => 'Incline';

  @override
  String get kcalUseOwn => 'Use my value';

  @override
  String get kcalBackToEstimate => 'Back to the estimate';

  @override
  String get kcalNeedsData => 'Add distance and time to estimate the calories';

  @override
  String get kcalHowEstimated => 'Estimated from distance, time, incline and your weight (ACSM formula).';

  @override
  String get kcalOwnTitle => 'Active calories';

  @override
  String get planMine => 'My plan';

  @override
  String get planNew => 'New plan';

  @override
  String get planSaveWeek => 'Save this week';

  @override
  String get planSaveWeekHint => 'Keep the current week as a plan you can come back to';

  @override
  String get planEmptyWeek => 'Start an empty week';

  @override
  String get planEmptyWeekHint => 'Your current week stays saved as a plan';

  @override
  String get planName => 'Plan name';

  @override
  String get planRename => 'Rename';

  @override
  String get planDelete => 'Delete plan';

  @override
  String get plansHint => 'Changes to the week are saved in the selected plan';

  @override
  String get progression => 'Progression';

  @override
  String get progManual => 'Manual';

  @override
  String get progManualHint => 'No suggestions: you choose every weight.';

  @override
  String get progLinear => 'Linear';

  @override
  String get progLinearHint => 'Hit every rep and the weight goes up.';

  @override
  String get progDouble => 'Double progression';

  @override
  String get progDoubleHint => 'More reps up to the top of the range, then more weight.';

  @override
  String get progVolume => 'Reps, sets and weight';

  @override
  String get progVolumeHint => 'Reps to the top, then one more set, then more weight.';

  @override
  String get progAmrap => 'Last set all-out';

  @override
  String get progAmrapHint => 'Last set: as many reps as you can. Double the target and it jumps twice.';

  @override
  String get progStep => 'Weight jump';

  @override
  String get progRange => 'Rep range';

  @override
  String get progSets => 'Sets';

  @override
  String get progDeload => 'Lighter after';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n misses', one: '1 miss');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Lighten by';

  @override
  String get progApply => 'Fill in the next workout';

  @override
  String get progApplyHint => 'Off, it only shows as a suggestion.';

  @override
  String get nextMoreReps => 'same weight, one more rep';

  @override
  String get nextAddSet => 'one more set';

  @override
  String get nextAmrap => 'last set: as many as you can';

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
  String get byZone => 'By area';

  @override
  String get importAlreadyHave => 'You already have these routines. You can add them again as a copy.';

  @override
  String get importAsCopy => 'Add as a copy';

  @override
  String get importOwned => 'Already yours';

  @override
  String get setDuplicated => 'Set duplicated';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'One set split into small blocks with 15–30 seconds between them. Log the total reps.';

  @override
  String timesBodyweight(String value) {
    return '$value× your bodyweight';
  }

  @override
  String get archiveRoutine => 'Archive routine';

  @override
  String get routineArchived => 'Routine archived';

  @override
  String get archivedRoutines => 'Archived';

  @override
  String get autoBackup => 'Auto backup';

  @override
  String get autoBackupHint =>
      'Saves a ZIP with all your data to a folder you choose. Point Nextcloud, Syncthing or any sync app at that folder to keep a copy off your phone.';

  @override
  String get autoBackupFolder => 'Choose folder';

  @override
  String get autoBackupNoFolder => 'No folder yet';

  @override
  String get autoBackupOff => 'Off';

  @override
  String get autoBackupWorkout => 'After each workout';

  @override
  String get autoBackupDaily => 'Once a day';

  @override
  String get autoBackupWeekly => 'Once a week';

  @override
  String get autoBackupOnLeave => 'When you leave the app';

  @override
  String get autoBackupKeep => 'Copies to keep';

  @override
  String get autoBackupNow => 'Back up now';

  @override
  String autoBackupLast(String when) {
    return 'Last backup $when';
  }

  @override
  String get autoBackupNever => 'No backup yet';

  @override
  String get autoBackupLost => 'Couldn\'t save the last backup. Choose the folder again.';

  @override
  String get autoBackupSaved => 'Backup saved';

  @override
  String get prepPortions => 'Portions';

  @override
  String get rotationAddRest => 'Add a rest day';

  @override
  String get rotationRestHint => 'Moves on by itself the next day';

  @override
  String get rotationRestToday => 'Today';

  @override
  String get rotationSkipRest => 'Skip this rest day';

  @override
  String rotationRestUpNext(String name) {
    return 'Next: $name';
  }

  @override
  String get trainAnyway => 'Train anyway';

  @override
  String get healthTitle => 'Health';

  @override
  String get healthSetting => 'Health data';

  @override
  String get healthSettingHint => 'Health Connect data in Progress';

  @override
  String get healthPickTitle => 'Health data';

  @override
  String get healthPickHint =>
      'Pick what to bring from Health Connect. Android asks once for each one. It\'s only read, and it never leaves your phone.';

  @override
  String get healthGroupHeart => 'Heart';

  @override
  String get healthGroupVitals => 'Vitals';

  @override
  String get healthGroupActivity => 'Activity';

  @override
  String get healthRestingHr => 'Resting heart rate';

  @override
  String get healthHeartRate => 'Average heart rate';

  @override
  String get healthHrv => 'Heart rate variability';

  @override
  String get healthSpo2 => 'Blood oxygen';

  @override
  String get healthRespiration => 'Breathing rate';

  @override
  String get healthBloodPressure => 'Blood pressure';

  @override
  String get healthTemperature => 'Body temperature';

  @override
  String get healthSleep => 'Sleep';

  @override
  String get healthDistance => 'Distance';

  @override
  String get healthFloors => 'Floors climbed';

  @override
  String get healthElevation => 'Elevation gained';

  @override
  String get healthActiveKcal => 'Active calories';

  @override
  String get healthNoData => 'No data yet';

  @override
  String get healthReadFailed => 'Couldn\'t read it';

  @override
  String get healthAllow => 'Tap to allow';

  @override
  String get healthLast7 => 'Last 7 days';

  @override
  String get healthAvg30 => '30-day avg';

  @override
  String get healthLow => 'Lowest';

  @override
  String get healthHigh => 'Highest';

  @override
  String get healthFrom => 'From Health Connect · last 30 days';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'br/min';

  @override
  String get weekTab => 'Week';

  @override
  String get muscleSetsList => 'Sets per muscle';

  @override
  String get fatTrans => 'Trans';

  @override
  String get fatTypesHint => 'Optional. Leave blank what the label doesn\'t say.';

  @override
  String get sessionPhotos => 'Workout photos';

  @override
  String get sessionPhotosAdd => 'Add photos';

  @override
  String get sessionPhotosHint => 'They\'re also kept in Your photos.';

  @override
  String get ladderTitle => 'Progression';

  @override
  String get ladderHint =>
      'Order the steps from easiest to hardest. When you do 3 sets of 8 two sessions in a row (5 on slow ones), GymMane offers the next step.';

  @override
  String get ladderBuiltIn =>
      'Starts from the app\'s progression. Add, remove or reorder steps and it becomes this routine\'s own.';

  @override
  String get ladderNone => 'None yet. Tap to build one.';

  @override
  String ladderStep(int n, int total) {
    return 'Step $n of $total';
  }

  @override
  String get ladderAdd => 'Add step';

  @override
  String get ladderInRoutine => 'In the routine';

  @override
  String get ladderClear => 'Use the app\'s progression';

  @override
  String get ladderPick => 'Pick a step';

  @override
  String get periodWeek => 'this week';

  @override
  String get periodMonth => 'this month';

  @override
  String get periodYear => 'this year';

  @override
  String get periodAll => 'all time';

  @override
  String get settingsSearch => 'Search settings';

  @override
  String get settingsNoResults => 'No setting with that name';

  @override
  String get settingsGroupApp => 'Your app';

  @override
  String get settingsGroupHome => 'Home and extras';

  @override
  String get settingsGroupData => 'Data and help';

  @override
  String get healthAllowAll => 'Turn all on';

  @override
  String get healthSeeAll => 'See all';

  @override
  String get healthPinTitle => 'On the card';

  @override
  String get healthPinHint => 'Pick up to 3 for the Progress card.';

  @override
  String get blurSetting => 'Blur effects';

  @override
  String get blurSettingHint => 'Turn off if your phone feels slow';

  @override
  String get lowEndTitle => 'Your phone is short on memory';

  @override
  String get lowEndBody =>
      'Turning blur off makes everything smoother on it. You can bring it back in Settings → General.';

  @override
  String get lowEndOff => 'Turn blur off';

  @override
  String get lowEndKeep => 'Keep it';

  @override
  String get momentsThisMonth => 'This month';

  @override
  String get momentsDays => 'Days with a photo';

  @override
  String get awardsPick => 'Choose for your profile';

  @override
  String get awardsPickHint => 'Tap the ones you want on your profile';

  @override
  String get gymPassPicture => 'Save a picture of the code';

  @override
  String get gymPassPictureHint => 'For codes the app can\'t read: it shows your photo at full brightness';

  @override
  String get gymPassPictureFormat => 'Photo';

  @override
  String get gymPassUsePicture => 'Save the photo';

  @override
  String get gymPassChangePicture => 'Change the photo';

  @override
  String get cropTitle => 'Crop the code';

  @override
  String get cropHint => 'Drag the corners so only the code is inside';

  @override
  String get rotatePhoto => 'Rotate';

  @override
  String get cardioNoSets => 'Cardio doesn\'t add to your weekly sets per muscle';

  @override
  String get countsAsWater => 'Counts toward water';

  @override
  String get countsAsWaterHint => 'For shakes made with water: logging it adds to your water too';

  @override
  String get waterPerServing => 'Water per serving';

  @override
  String get estOneRm => 'est. 1RM';

  @override
  String get newInWorkout => 'New in this workout';

  @override
  String newInWorkoutHint(String routine) {
    return 'Add it to $routine with the sets you just did. The rest of the routine stays as it is.';
  }

  @override
  String get addedToRoutine => 'Added';

  @override
  String get addShort => 'Add';

  @override
  String get allTimeLifted => 'LIFTED';

  @override
  String get pctBodyweight => '% bodyweight';

  @override
  String get ofBodyweight => 'of your bodyweight';

  @override
  String get recoveryStateMid => 'Recovering';

  @override
  String get recoveryStateReady => 'Ready';

  @override
  String recoveringIn(String time) {
    return 'Recovering in $time';
  }

  @override
  String readyIn(String time) {
    return 'Ready in $time';
  }

  @override
  String get recoveryReadyNow => 'Ready to train it again';

  @override
  String get restAfterThisSet => 'Rest after this set';

  @override
  String restUsual(String time) {
    return 'Usual: $time';
  }

  @override
  String get restJustToday => 'Only for this set, today';

  @override
  String get restUseUsual => 'Back to the usual rest';

  @override
  String get restChange => 'Change';

  @override
  String get noRestTimer => 'No timer';

  @override
  String get sessionMuscles => 'Muscles in this workout';

  @override
  String get sessionMusclesHint =>
      'Faint is still to come, bright is done. Sets per muscle, secondary ones count half.';

  @override
  String get miniBodySetting => 'Small body map on routines';

  @override
  String get miniBodySettingHint => 'Muscles each routine works';

  @override
  String get balanceTitle => 'Strength balance';

  @override
  String get balanceWhy => 'How it works';

  @override
  String get balanceGood => 'Your main lifts are in balance';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift is lagging: about $gap to catch up';
  }

  @override
  String get balanceHint =>
      'Compares your estimated 1RMs from the last 4 months against classic proportions: squat 100%, deadlift 120%, bench 75%, row 52%, overhead press 45%. A lift far below the rest is usually a weak spot worth more work.';

  @override
  String get balanceEven => 'In balance';

  @override
  String get balanceBehindShort => 'Behind';

  @override
  String get balanceAheadShort => 'Ahead';

  @override
  String get holdProgress => 'Progress by time';

  @override
  String get holdProgressHint => 'Adds seconds when you hold every set';

  @override
  String holdProgressOn(int s) {
    return '+$s s each time you hold every set';
  }

  @override
  String get paceTitle => 'Weekly rate';

  @override
  String get paceOn => 'On pace';

  @override
  String get paceTooFast => 'Faster than the range you set';

  @override
  String get paceTooSlow => 'Slower than the range you set';

  @override
  String get paceWrongWay => 'Going the other way';

  @override
  String get paceDrifting => 'Moving more than a hold allows';

  @override
  String get paceSetAim => 'Tap to set what you aim for';

  @override
  String get paceBasis =>
      'Trend of your weigh-ins from the last 3 weeks, so one salty dinner can\'t fool it.';

  @override
  String get paceAimTitle => 'What are you aiming for?';

  @override
  String get paceAimHint => 'The card tells you if your weekly rate fits it';

  @override
  String get paceLose => 'Lose';

  @override
  String get paceHold => 'Hold';

  @override
  String get paceGain => 'Gain';

  @override
  String get paceAuto => 'Automatic';

  @override
  String get paceLoseRange => '0.5 to 1% of your weight a week';

  @override
  String get paceHoldRange => 'Within 0.25% a week';

  @override
  String get paceGainRange => '0.25 to 0.5% of your weight a week';

  @override
  String get paceAutoHint => 'From your weight goal';

  @override
  String get weekShort => 'wk';

  @override
  String get weightStack => 'Weight stack';

  @override
  String get weightStackHint =>
      'The weights this machine really has. The + and − buttons, progression and deloads land only on them.';

  @override
  String get weightStackOff => 'Off: normal weight steps';

  @override
  String get stackFrom => 'From';

  @override
  String get stackTo => 'To';

  @override
  String get stackEvery => 'Every';

  @override
  String get stackFill => 'Fill the stack';

  @override
  String get stackTapToFix => 'Tap a weight to fix an odd one or remove it.';

  @override
  String get stackAddWeight => 'Add a weight';

  @override
  String get stackEditWeight => 'Weight on the pin';

  @override
  String get stackClear => 'Remove the stack';

  @override
  String stackCount(int n) {
    return '$n weights';
  }

  @override
  String get healthLinksTitle => 'With your workouts';

  @override
  String get healthLinkHeart => 'Heart rate from your watch';

  @override
  String get healthLinkHeartHint =>
      'Average and peak heart rate of each workout, from whatever watch recorded it';

  @override
  String get healthLinkWeight => 'Weigh-ins from other apps';

  @override
  String get healthLinkWeightHint =>
      'Your scale\'s weigh-ins from the last 30 days. Never overwrites one you typed.';

  @override
  String get healthLinkDenied => 'Health Connect did not give permission';

  @override
  String get healthOpenSettings => 'Open';

  @override
  String hrMaxShort(int bpm) {
    return 'max $bpm';
  }

  @override
  String get setNote => 'Note for this set';

  @override
  String get setNoteHint => 'Grip, pain, a cue that worked…';

  @override
  String setNoteLast(String note) {
    return 'Last time: $note';
  }

  @override
  String get lastTimeNotes => 'Last time';

  @override
  String setNoteLine(int n, String note) {
    return 'Set $n · $note';
  }

  @override
  String get newMeasure => 'New measurement';

  @override
  String get newMeasureHint => 'Anything you want to follow: wrist, resting pulse, body water…';

  @override
  String get measureKindLength => 'Length';

  @override
  String get measureKindLengthHint => 'In cm or inches, like the rest';

  @override
  String get measureKindOther => 'Other';

  @override
  String get measureKindOtherHint => 'With your own unit';

  @override
  String get measureUnit => 'Unit';

  @override
  String get measureUnitHint => 'mm, bpm, kg…';

  @override
  String get measureNameHint => 'Wrist, resting pulse…';

  @override
  String get measureRename => 'Rename';

  @override
  String measureDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get measureDeleteBody => 'Every value you logged for it goes too.';

  @override
  String get measureDelete => 'Delete this measurement';

  @override
  String get measureEvery => 'Remind me to measure';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'In $n days',
      one: 'Tomorrow',
      zero: 'Today',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'Time to measure';

  @override
  String get notifMeasureChannel => 'Body measurements';

  @override
  String get notifMeasureChannelWhy => 'A nudge when it is time to measure again.';

  @override
  String get notifMeasureTitle => 'Time to measure';

  @override
  String notifMeasureBody(int n) {
    return '$n days since the last time. Same spot, same time of day.';
  }

  @override
  String get healthLinkWrite => 'Save your workouts';

  @override
  String get healthLinkWriteHint =>
      'Each finished workout goes to Health Connect with its time and type, so other apps count it too. Also sends the last 30 days.';

  @override
  String get healthWorkoutTitle => 'Workout';

  @override
  String get circuits => 'Timed circuits';

  @override
  String get circuitsHint => 'Work and rest by the clock, round after round';

  @override
  String get newCircuit => 'New circuit';

  @override
  String get editCircuit => 'Edit circuit';

  @override
  String get circuitDefaultName => 'Circuit';

  @override
  String get circuitNameHint => 'Name, like Core finisher';

  @override
  String get circuitRounds => 'Rounds';

  @override
  String get circuitRoundRest => 'Rest between rounds';

  @override
  String get circuitWork => 'Work';

  @override
  String get circuitRest => 'Rest';

  @override
  String get circuitAdd => 'Add exercise';

  @override
  String get circuitEmpty =>
      'Add the exercises in the order you\'ll do them. One can go twice, like a side plank for each side.';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      steps,
      locale: localeName,
      other: '$steps exercises',
      one: '1 exercise',
    );
    String _temp1 = intl.Intl.pluralLogic(
      rounds,
      locale: localeName,
      other: '$rounds rounds',
      one: '1 round',
    );
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'Start';

  @override
  String get circuitGetReady => 'Get ready';

  @override
  String circuitRoundOf(int n, int total) {
    return 'Round $n of $total';
  }

  @override
  String circuitNext(String name) {
    return 'Next: $name';
  }

  @override
  String get circuitFinishLine => 'Last one, then done';

  @override
  String get circuitDone => 'Circuit done';

  @override
  String circuitDoneBody(String time) {
    return '$time · saved to your history';
  }

  @override
  String get circuitStopTitle => 'Stop the circuit?';

  @override
  String get circuitStopBody => 'What you\'ve done so far is saved to your history.';

  @override
  String get circuitStop => 'Stop';

  @override
  String get circuitKeepGoing => 'Keep going';

  @override
  String circuitDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get circuitDeleteBody => 'Workouts you already did with it stay in your history.';

  @override
  String get circuitPickExercise => 'Pick an exercise';

  @override
  String get circuitNoSteps => 'Add at least one exercise';

  @override
  String get circuitPrevious => 'Previous';

  @override
  String get circuitUpNext => 'Up next';

  @override
  String get foodGroupNew => 'New category';

  @override
  String get foodGroupHint => 'Ready meals, frozen…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n foods',
      one: '1 food',
      zero: 'No foods yet',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get foodGroupDeleteBody => 'Your foods stay, just without this category.';

  @override
  String onbHello(String name) {
    return 'Hi, $name';
  }

  @override
  String get onbPlaceHero => 'exercises you can do';

  @override
  String get settingsRests => 'Rest';

  @override
  String get settingsDuring => 'While you train';

  @override
  String get settingsLook => 'How it looks';

  @override
  String get importCardTitle => 'Bring your workouts here';

  @override
  String get importCardBody => 'From Hevy, Strong, FitNotes and more';

  @override
  String get checkInTitle => 'How did you show up?';

  @override
  String get checkInSleep => 'Sleep';

  @override
  String get checkInEnergy => 'Energy';

  @override
  String get checkInSkip => 'Optional';

  @override
  String get checkInLevel1 => 'Awful';

  @override
  String get checkInLevel2 => 'Poor';

  @override
  String get checkInLevel3 => 'Okay';

  @override
  String get checkInLevel4 => 'Good';

  @override
  String get checkInLevel5 => 'Great';

  @override
  String get checkInSetting => 'Sleep and energy';

  @override
  String get checkInSettingHint => 'Ask when you finish a workout';

  @override
  String get readinessTitle => 'Sleep and energy';

  @override
  String get readinessWaiting => 'Keep rating your workouts';

  @override
  String get readinessWaitingHint => 'After a few good and bad days you\'ll see how they change your lifts.';

  @override
  String readinessSleepLess(int n) {
    return 'On short-sleep days you lift $n% less';
  }

  @override
  String readinessSleepMore(int n) {
    return 'Funny: on short-sleep days you lift $n% more';
  }

  @override
  String get readinessSleepNone => 'Sleep barely changes your lifts';

  @override
  String readinessEnergyLess(int n) {
    return 'On low-energy days you lift $n% less';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'On low-energy days you still lift $n% more';
  }

  @override
  String get readinessEnergyNone => 'Your energy barely changes your lifts';

  @override
  String get readinessHint => 'Compares each estimated 1RM with your best of the previous 90 days.';

  @override
  String get readinessLast30 => 'Average of the last 30 days';

  @override
  String get kindSport => 'Sport';

  @override
  String get clearWorkouts => 'Delete workouts only';

  @override
  String get clearWorkoutsNone => 'There are no workouts to delete';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Delete $n workouts?',
      one: 'Delete 1 workout?',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'Your history, records and medals go. Routines, exercises, photos, measurements, nutrition and settings stay. Export a backup first if you might want them back.';

  @override
  String get clearWorkoutsConfirm => 'Delete workouts';

  @override
  String get clearWorkoutsDone => 'Workouts deleted';

  @override
  String get reportTitle => 'Report';

  @override
  String get reportHint => 'Pick the dates and share it as a PDF or CSV';

  @override
  String get reportCustom => 'Other';

  @override
  String get reportPickRange => 'Choose dates';

  @override
  String get reportEmpty => 'Nothing logged between these dates.';

  @override
  String get reportKicker => 'TRAINING REPORT';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n days', one: '1 day');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'WORKOUTS';

  @override
  String get reportPerWeek => 'PER WEEK';

  @override
  String get reportHours => 'HOURS';

  @override
  String get reportVsPrev => 'Percentages compare with the same number of days just before.';

  @override
  String get reportRecords => 'New records';

  @override
  String get reportLifts => 'Exercises';

  @override
  String get reportSessionsCol => 'DAYS';

  @override
  String get reportBestCol => 'BEST 1RM';

  @override
  String get reportChangeCol => 'CHANGE';

  @override
  String get reportBestHint =>
      'Best 1RM is estimated from your sets. Change compares the first and last day of the exercise in this report.';

  @override
  String get reportMuscles => 'Sets per muscle';

  @override
  String get reportBody => 'Body and recovery';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Nutrition · average of $n days',
      one: 'Nutrition · average of 1 day',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n new records',
      one: '1 new record',
    );
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n exercises', one: '1 exercise');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '$kcal and $protein g protein a day · $days days logged';
  }

  @override
  String get reportSharePdf => 'Share PDF';

  @override
  String get reportShareCsv => 'Export CSV';

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
  String get reportShareCsvBoth => 'Export CSV (workouts and nutrition)';

  @override
  String fastMinutes(int n) {
    return '$n min';
  }

  @override
  String fastHours(int n) {
    return '$n h';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get fastTracker => 'Intermittent fasting';

  @override
  String fastTitle(int fast, int eat) {
    return 'Fasting $fast:$eat';
  }

  @override
  String get fastOptions => 'Fasting options';

  @override
  String get fastWindowOpen => 'Eating window open';

  @override
  String get fastLeft => 'Left';

  @override
  String get fastDoneLabel => 'Goal reached';

  @override
  String get fastIdle => 'Start it after your last meal';

  @override
  String fastLast(String time) {
    return 'Last fast: $time';
  }

  @override
  String fastStreak(int n) {
    return '$n in a row';
  }

  @override
  String fastReached(String time) {
    return '$time past your goal';
  }

  @override
  String fastEndsAt(String time) {
    return 'Ends at $time';
  }

  @override
  String fastSince(String time) {
    return 'Since $time';
  }

  @override
  String get fastStartedAt => 'When did you start fasting?';

  @override
  String get fastStart => 'Start fast';

  @override
  String fastFromMeal(String time) {
    return 'From $time';
  }

  @override
  String get fastEnd => 'End fast';

  @override
  String get fastCancel => 'Cancel this fast';

  @override
  String get fastPlan => 'Fasting plan';

  @override
  String get fastPlanHint => 'Hours fasting : hours to eat';

  @override
  String get fastThisWeek => 'Last 7 days';

  @override
  String get fastCount => 'Fasts';

  @override
  String get fastReachedCount => 'Reached';

  @override
  String get fastAverage => 'Average';

  @override
  String get fastHistory => 'Recent fasts';

  @override
  String get notifFastLiveChannel => 'Fasting in progress';

  @override
  String get notifFastLiveChannelWhy => 'A quiet countdown while you fast.';

  @override
  String get notifFastChannel => 'Fasting';

  @override
  String get notifFastChannelWhy => 'Tells you when your fast is done.';

  @override
  String get notifFastLiveTitle => 'Fasting';

  @override
  String notifFastLiveBody(String time) {
    return 'Your eating window opens at $time';
  }

  @override
  String get notifFastDoneTitle => 'Fast done';

  @override
  String notifFastDoneBody(int n) {
    return '$n hours. Your eating window is open.';
  }

  @override
  String get newExerciseHint => 'Only the name is required. The rest helps, but you can add it later.';

  @override
  String get supportThanksTitle => 'Thanks for being here 🤍';

  @override
  String get supportThanksBody =>
      'GymMane is free and always will be, with no ads and nothing hidden.\n\nIf it helps you train, buying me a coffee makes my day ☕\nAnd if you can\'t, no worries: a star on GitHub does too ⭐';

  @override
  String get perfSetting => 'Performance';

  @override
  String get perfSheetHint => 'How much of your phone GymMane uses. You can change each part below.';

  @override
  String get perfLite => 'Saver';

  @override
  String get perfLiteHint => 'No blur and calmer motion. For phones that struggle.';

  @override
  String get perfBalanced => 'Balanced';

  @override
  String get perfBalancedHint => 'Blur and animations without draining the battery.';

  @override
  String get perfMax => 'Maximum';

  @override
  String perfMaxHint(int hz) {
    return 'Finer blur and the screen at $hz Hz. For high-end phones.';
  }

  @override
  String get perfMaxHintNoHz => 'Finer blur everywhere. For high-end phones.';

  @override
  String get perfCustom => 'Custom';

  @override
  String get perfTweak => 'Fine-tuning';

  @override
  String get perfFine => 'Fine blur';

  @override
  String get perfFineHint => 'Softer edges and a sharper backdrop behind sheets';

  @override
  String perfHz(int hz) {
    return 'Screen at $hz Hz';
  }

  @override
  String get perfHzHint => 'Everything scrolls smoother, at a little more battery';

  @override
  String get lowEndLiteBody =>
      'Saver mode (no blur, calmer motion) will run smoother on it. You can change it in Settings → General → Performance.';

  @override
  String get lowEndLiteOn => 'Turn on Saver';

  @override
  String get dayOffHint => 'Your streak and the reminder leave this day alone';

  @override
  String get dayOffTrained => 'I trained, just didn\'t log it';

  @override
  String get dayOffSick => 'Illness';

  @override
  String get dayOffTravel => 'Travel';

  @override
  String get dayOffInjury => 'Injury';

  @override
  String get dayOffRest => 'Rest';

  @override
  String get altsTitle => 'Backups';

  @override
  String get altsHint => 'In case the machine is taken';

  @override
  String altsPickHint(int count) {
    return 'Pick up to $count. If the machine is taken, swap in one tap.';
  }

  @override
  String get placeDumbbells => 'Dumbbells';

  @override
  String get dumbbellsHint =>
      'The weight of one dumbbell. Progression and the + and − buttons will only land on these here.';

  @override
  String get dumbbellOther => 'Another weight';

  @override
  String get tuneTitle => 'Today\'s volume';

  @override
  String get tuneHint => 'Tell me how each muscle felt and I\'ll adjust the sets for next time.';

  @override
  String get tuneLess => 'Too little';

  @override
  String get tuneRight => 'Right';

  @override
  String get tuneMore => 'Too much';

  @override
  String tuneNext(String sets, String name) {
    return 'Next time: $sets of $name';
  }

  @override
  String get tuneSame => 'Stays the same next time';

  @override
  String get tuneSetting => 'Tune sets per muscle';

  @override
  String get tuneSettingHint => 'After a routine, rate each muscle and the sets adjust';

  @override
  String insightLoad(int pct) {
    return '$pct % more sets than your usual week. Watch your recovery.';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: $days days untouched.';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'You push more than you pull: $a sets against $b in four weeks.';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'You pull more than you push: $a sets against $b in four weeks.';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: $pct % stronger than last month.';
  }

  @override
  String recapPull(String month) {
    return 'Keep pulling to see your $month';
  }

  @override
  String get recapRelease => 'Let go';

  @override
  String recapHi(String name) {
    return 'Hi, $name';
  }

  @override
  String recapReady(String month) {
    return 'Shall we see what you did in $month?';
  }

  @override
  String get recapGo => 'Let\'s go';

  @override
  String recapEmpty(String month) {
    return 'No workouts in $month yet. Your first one opens this up.';
  }

  @override
  String get recapClose => 'Close';

  @override
  String get recapShare => 'Share';

  @override
  String get recapWorkoutsKicker => 'This month you trained';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'workouts', one: 'workout');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'On $n different days',
      one: 'On one day',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'Time under the bar';

  @override
  String recapLongest(String time, String date) {
    return 'Longest session: $time, on $date';
  }

  @override
  String get recapVolumeKicker => 'You moved';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Like lifting $count cars',
      one: 'Like lifting a car',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'Most of it: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'Muscle of the month';

  @override
  String get recapRecordsKicker => 'New records';

  @override
  String recapNoRecords(int n) {
    return 'No records this time, but $n sets went in the bank.';
  }

  @override
  String get recapHabitKicker => 'Your moment';

  @override
  String recapHabitStart(String time) {
    return 'You usually start at $time';
  }

  @override
  String get recapShareKicker => 'Your month, ready to share';

  @override
  String get recapTickWorkouts => 'Workouts';

  @override
  String get recapTickTime => 'Time';

  @override
  String get recapTickVolume => 'Load';

  @override
  String get recapTickRecords => 'Records';

  @override
  String recapAvg(int n) {
    return '$n min per workout on average';
  }

  @override
  String get recapLiftKicker => 'Exercise of the month';

  @override
  String get recapBest => 'Best';

  @override
  String get recapTimes => 'Days';

  @override
  String get recapDaysLabel => 'Days';

  @override
  String get recapAvgLabel => 'Average';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$workouts workouts on $days days';
  }

  @override
  String get recapFavLabel => 'Your day';

  @override
  String get recapWatermark => 'free gym log';

  @override
  String get recapTickSteps => 'Steps';

  @override
  String get recapTickFood => 'Food';

  @override
  String get recapCardioKicker => 'Cardio';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n workouts', one: 'one workout');
    return '$minutes min across $_temp0';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n cardio workouts',
      one: 'One cardio workout',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'Your go-to: $name';
  }

  @override
  String get recapStepsKicker => 'You walked';

  @override
  String get recapStepsWord => 'steps';

  @override
  String recapStepsAvg(String value) {
    return '$value a day on average';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'Best day: $value, $date';
  }

  @override
  String get recapFoodKicker => 'On your plate';

  @override
  String get recapLiftRest => 'Right behind it';

  @override
  String recapSameAs(String month) {
    return 'Same as in $month';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$value more than in $month';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$value less than in $month';
  }

  @override
  String get recapTickMedals => 'Medals';

  @override
  String get recapTickSleep => 'Sleep';

  @override
  String get recapMedalsKicker => 'Medals you won';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'And $n more', one: 'And one more');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'You slept';

  @override
  String get recapSleepAvg => 'a night on average';

  @override
  String recapSleepBest(String value, String date) {
    return 'Best night: $value, $date';
  }

  @override
  String get recapCardSummary => 'Summary';

  @override
  String get recapCardCalendar => 'Calendar';

  @override
  String get recapCardLift => 'Exercise';

  @override
  String get recapPeakKicker => 'Your toughest session';

  @override
  String get recapTickPeak => 'Session';

  @override
  String get recapFreshKicker => 'First time this month';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'new exercises', one: 'new exercise');
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'New';

  @override
  String recapStreak(int n) {
    return '$n days in a row, your longest streak';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n workouts', one: '1 workout');
    return 'A year ago: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'Left out this month: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'protein a day · goal $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'On your plate $n days',
      one: 'On your plate 1 day',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'Protein · g/day';

  @override
  String get recapFoodGoalDays => 'Goal met';

  @override
  String get recapFoodWaterLabel => 'Water/day';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n days', one: '1 day');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'Your food of the month';

  @override
  String get onbSpeedTitle => 'Make it run smooth';

  @override
  String get onbSpeedWhy =>
      'Your phone seems to be working hard. Turn these off and everything will flow better: try them and watch the preview.';

  @override
  String get onbSpeedMotion => 'Animations';

  @override
  String get onbSpeedBlurHint => 'Frosted glass behind sheets and bars';

  @override
  String get onbSpeedMotionHint => 'Screens and sheets that slide in';

  @override
  String get onbSpeedLater => 'You can change it anytime in Settings › General › Performance.';

  @override
  String get notifSoundSetting => 'Notification sounds';

  @override
  String get notifSoundRowHint => 'How each kind of reminder sounds';

  @override
  String get notifSoundHint =>
      'Pick a sound for each kind of reminder. From phone opens your phone sounds, and on most phones you can add your own song there.';

  @override
  String get notifSoundTrain => 'Workouts';

  @override
  String get notifSoundFood => 'Food, supplements and fasting';

  @override
  String get notifSoundOther => 'Photos and measurements';

  @override
  String get notifSoundNormal => 'Normal';

  @override
  String get notifSoundPhone => 'From phone';

  @override
  String get notifSoundSilent => 'Silent';

  @override
  String get notifSoundPhoneHint => 'Tap one to hear it. It saves right away.';

  @override
  String get notifSoundMore => 'Another file…';

  @override
  String get notifSoundChange => 'Change';

  @override
  String get workoutNoteAdd => 'Pinned note: seat, grip, machine…';

  @override
  String get autoProgressSetting => 'Auto progression';

  @override
  String get autoProgressRowHint => 'What it suggests for next time';

  @override
  String get autoProgressOff => 'Off';

  @override
  String get autoProgressWeight => 'Add weight';

  @override
  String get autoProgressReps => 'Add reps';

  @override
  String get autoProgressHint =>
      'When you start a workout, GymMane fills in the next step for each exercise. With Add reps you add one rep per set up to 12, then the weight goes up and you start again at 8. You can still tune each exercise on its page.';

  @override
  String get noteFolders => 'Folders';

  @override
  String get noteFolderNew => 'New folder';

  @override
  String get noteFolderEdit => 'Edit folder';

  @override
  String get noteFolderName => 'Folder name';

  @override
  String get noteFolderLabel => 'Folder';

  @override
  String get noteFolderNone => 'No folder';

  @override
  String get noteFolderDelete => 'Delete the folder?';

  @override
  String get noteFolderDeleteBody => 'Notes are kept: they just leave the folder.';

  @override
  String get foodArchivedToast => 'Food archived';

  @override
  String get planArchivedToast => 'Plan archived';

  @override
  String get suppArchivedToast => 'Supplement archived';

  @override
  String get voiceSetting => 'Workout voice';

  @override
  String get voiceSettingHint =>
      'Says your next set and counts down the end of the rest, with the phone voice';

  @override
  String get voiceHello => 'Voice on';

  @override
  String voiceRest(String time) {
    return 'Rest $time.';
  }

  @override
  String voiceNext(String name, String load) {
    return 'Next: $name, $load.';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$reps reps at $weight';
  }

  @override
  String voiceReps(int reps) {
    return '$reps reps';
  }

  @override
  String get voiceGo => 'Let\'s go!';

  @override
  String get deloadSetting => 'Deload week';

  @override
  String get deloadOff => 'Never';

  @override
  String deloadEvery(int weeks) {
    return 'Every $weeks weeks';
  }

  @override
  String get deloadHint =>
      'Every few weeks, an easier one to recover: half the sets and 10 % less weight. That week does not count for progression.';

  @override
  String get deloadRowHint => 'An easy week every few weeks';

  @override
  String get deloadNow => 'Deload week';

  @override
  String get deloadNowHint => 'Today, half the sets and 10 % less weight';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'In $weeks weeks',
      one: 'Next week',
      zero: 'This week',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'Train as usual';

  @override
  String get voiceSheetTitle => 'How the voice works';

  @override
  String get voicePointRest => 'When you tick a set, it tells you the rest time and what comes next.';

  @override
  String get voicePointCount => 'It counts 3, 2, 1 at the end of the rest and calls you back.';

  @override
  String get voicePointPhone => 'It uses your phone\'s voice and plays over your music.';

  @override
  String get voiceTry => 'Try the voice';

  @override
  String get voiceNoEngine => 'Your phone has no voice engine turned on.';

  @override
  String get voiceNoLang => 'Your language\'s voice is missing. Download it in your phone\'s voice settings.';

  @override
  String get voiceOpenSettings => 'Voice settings';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seconds',
      one: '1 second',
    );
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'and';

  @override
  String get repRecordsTitle => 'Best weight by reps';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'capsules', one: 'capsule');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'pills', one: 'pill');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'scoops', one: 'scoop');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'drops', one: 'drop');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'servings', one: 'serving');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IU';

  @override
  String get suppLeft => 'Left';

  @override
  String get suppLeftHint => 'Optional';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Left for $n days',
      one: 'Left for 1 day',
    );
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n days', one: '1 day');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'Ran out';

  @override
  String get lightSession => 'Light session';

  @override
  String get lightSessionHint => 'Saved in your history and stats, but it won\'t change your next targets.';

  @override
  String get lightSessionNote => 'Doesn\'t count for progression';

  @override
  String get lightSessionOff => 'Turn off';

  @override
  String get eachSideRepsHint =>
      'Log the left and right reps separately. Progression follows the weaker side.';

  @override
  String get repsLeftCol => 'REPS L';

  @override
  String get repsRightCol => 'REPS R';

  @override
  String get repsLeftTitle => 'LEFT REPS';

  @override
  String get repsRightTitle => 'RIGHT REPS';

  @override
  String sidesReps(int l, int r) {
    return 'L$l R$r';
  }

  @override
  String get progSchemeTitle => 'Weight progression';

  @override
  String get groupMoveUp => 'Move group up';

  @override
  String get groupMoveDown => 'Move group down';

  @override
  String get mealAiRow => 'Ask an AI';

  @override
  String get mealAiRowHint => 'Copy a request, paste the answer';

  @override
  String get mealAiTitle => 'Meals with AI';

  @override
  String get mealAiSubtitle => 'Works with any chatbot. The app stays offline.';

  @override
  String get mealAiStepAsk => 'Ask';

  @override
  String get mealAiStepPaste => 'Paste';

  @override
  String get mealAiWholeDay => 'Whole day';

  @override
  String get mealAiTarget => 'Target';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'You have $kcal and $protein g of protein left today';
  }

  @override
  String get mealAiStyle => 'Your taste';

  @override
  String get mealAiTagProtein => 'High protein';

  @override
  String get mealAiTagVeggie => 'Vegetarian';

  @override
  String get mealAiTagVegan => 'Vegan';

  @override
  String get mealAiTagNoGluten => 'Gluten free';

  @override
  String get mealAiTagNoLactose => 'Lactose free';

  @override
  String get mealAiTagQuick => 'Quick';

  @override
  String get mealAiTagNoCook => 'No cooking';

  @override
  String get mealAiTagCheap => 'Budget';

  @override
  String get mealAiNotesHint => 'I have at home… I don’t like… allergies…';

  @override
  String get mealAiOptions => 'Options';

  @override
  String get mealAiCopy => 'Copy request';

  @override
  String get mealAiCopied => 'Request copied';

  @override
  String get mealAiCopiedHint => 'Paste it into your AI and come back here with the answer';

  @override
  String get mealAiShowText => 'See the request';

  @override
  String get mealAiHideText => 'Hide the request';

  @override
  String get mealAiPasteHint => 'Paste the AI’s answer here';

  @override
  String get mealAiReview => 'Review answer';

  @override
  String get mealAiUnreadable => 'I couldn’t find any food in that text';

  @override
  String get mealAiUnreadableHint =>
      'Ask the AI to send only the JSON, in one code block, with the format of the request.';

  @override
  String get mealAiCopyFix => 'Copy that sentence';

  @override
  String mealAiOption(int n) {
    return 'Option $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return 'Add to $meal';
  }

  @override
  String get mealAiAddDay => 'Add to today';

  @override
  String get mealAiAddPick => 'Add';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n foods added',
      one: '1 food added',
    );
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'Save as a recipe';

  @override
  String get mealAiSavePlan => 'Save as a plan';

  @override
  String get mealAiRecipeSaved => 'Recipe saved';

  @override
  String get mealAiPlanSaved => 'Plan saved';

  @override
  String get mealAiFlagEstimated => 'Estimated by the AI';

  @override
  String get mealAiFlagAdjusted => 'Calories fixed to match the macros';

  @override
  String get mealAiFlagDoubtful => 'Doesn’t add up, check it';

  @override
  String get mealAiFlagNoValues => 'No nutrition values';

  @override
  String get mealAiFlagNoAmount => 'No amount given';

  @override
  String get mealAiTruncated => 'The answer looks cut off. I kept the complete foods.';

  @override
  String get mealAiAmount => 'Amount';

  @override
  String mealAiTargetLine(String kcal) {
    return 'Target $kcal';
  }

  @override
  String get mealAiNothingChosen => 'Turn on at least one food';

  @override
  String get cholesterolLabel => 'Cholesterol';

  @override
  String get mealAiFlagMatched => 'Same as a food you saved';

  @override
  String get mealAiNotSame => 'Not the same';

  @override
  String get homeOrderRow => 'Order of sections';

  @override
  String get homeOrderHint => 'Hold and drag to change the order of Home.';

  @override
  String get homeOrderFolders => 'Shortcuts';

  @override
  String get equipNew => 'New';

  @override
  String get equipNewTitle => 'New equipment';

  @override
  String get equipNewHint => 'e.g. Weight belt';

  @override
  String get homeOrderWeekdays => 'Week checks';

  @override
  String get repsMaxTitle => 'Reps up to';

  @override
  String get repsRangeHint => 'Long press the reps to set a range like 8-12.';

  @override
  String get repsRangeClear => 'Remove range';

  @override
  String get noteLinksLabel => 'LINKS';

  @override
  String get noteLinkAdd => 'Add link';

  @override
  String get noteLinkEdit => 'Edit link';

  @override
  String get noteLinkNameHint => 'Name';

  @override
  String get noteLinkUrlHint => 'Web address';

  @override
  String get noteLinkInvalid => 'That address doesn\'t look right';

  @override
  String get changeRest => 'Rest between exercises';

  @override
  String get changeRestHint => 'After the last set, before the next exercise';

  @override
  String get notifSuppTake => 'Taken';

  @override
  String get sideRest => 'Rest between sides';

  @override
  String get sideRestHint => 'Per-side exercises: the first ✓ ends one side';

  @override
  String get gfxCompat => 'Compatible graphics';

  @override
  String get gfxCompatHint => 'For phones where letters look broken. Blur stays, a few effects get simpler';

  @override
  String get gfxRestartTitle => 'Restart GymMane?';

  @override
  String get gfxRestartBody =>
      'It closes and opens again to change how it draws the screen. Nothing you saved is lost.';

  @override
  String get gfxRestart => 'Restart';

  @override
  String get webSynced => 'Updated with changes from another device';

  @override
  String get webSyncedPhone => 'Your phone\'s changes are in';

  @override
  String get webWelcomeBlurb => 'Everything stays on your own server. No account, no cloud, nothing to pay.';

  @override
  String get webOwnServer => 'Your server, your rules';

  @override
  String get webOwnServerWhy => 'No accounts and no third-party cloud. Your data lives where you run it.';

  @override
  String get webServerSaved => 'Saved on your server';

  @override
  String get webServerOffline => 'Can\'t reach your server';

  @override
  String get webServerLocal => 'Saved in this browser';

  @override
  String get webServerTitle => 'Your server';

  @override
  String webPhoneLast(String date) {
    return 'Last copy from your phone: $date';
  }

  @override
  String get webPhoneNone => 'No copy from your phone yet';

  @override
  String get webPhoneScan => 'Get from phone';

  @override
  String get webPhoneExport => 'Send to phone';

  @override
  String get webPhoneExportDone => 'Left in the shared folder. Your phone brings it in when it syncs';

  @override
  String get webPhoneImported => 'Your phone\'s changes are in';

  @override
  String get webPhoneNothing => 'Nothing new from your phone';

  @override
  String get webPhoneHow =>
      'Turn on automatic backups on your phone into a folder you sync with Syncthing. The server and the phone bring in each other\'s changes on their own, and merging never deletes anything.';

  @override
  String get webPhoneGuide => 'How to set it up';

  @override
  String get webPhoneOff => 'Phone sync is off on this server';

  @override
  String get toolGroupBody => 'Body';

  @override
  String get toolNameProtein => 'Protein';

  @override
  String get toolTitleProtein => 'Daily protein';

  @override
  String get toolDescProtein => 'How much protein a day';

  @override
  String get toolHintProtein => 'Grams a day, spread over your meals';

  @override
  String get proteinGoalLabel => 'Goal';

  @override
  String get proteinExplain =>
      'Based on the range most studies agree on for people who train: more when you are losing weight, to keep your muscle. Going over it is safe, it just adds little.';

  @override
  String get toolNameWater => 'Water';

  @override
  String get toolTitleWater => 'Daily water';

  @override
  String get toolDescWater => 'How much to drink a day';

  @override
  String get toolHintWater => 'Litres a day, food included';

  @override
  String get waterTrainingLabel => 'Training a day';

  @override
  String get waterExplain =>
      'About 35 ml per kilo of body weight, plus some extra for each minute you train. Drink more on hot days.';

  @override
  String get autoBackupSync => 'Sync now';

  @override
  String get autoBackupMerged => 'Changes from your other devices are in';

  @override
  String get autoBackupSyncHint =>
      'Share this folder with Syncthing and each device brings in what the others leave here. Merging never deletes anything.';

  @override
  String get webPhoneFolder => 'Shared folder';

  @override
  String get webPhoneFolderHow =>
      'Chosen when you install the server. To change it, set GYMMANE_SYNC in the server\'s .env file and restart it.';

  @override
  String get webPhoneOffHow =>
      'To turn it on, remove GYMMANE_SYNC=off from the server\'s .env file and restart it.';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n phones synced',
      one: '1 phone synced',
      zero: 'No phone has synced yet',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'Couldn\'t read the folder: $error';
  }

  @override
  String get duplicateExercise => 'Duplicate';

  @override
  String exerciseCopyName(String name) {
    return '$name (copy)';
  }
}
