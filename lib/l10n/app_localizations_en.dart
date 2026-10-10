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
  String get tapMuscles => 'Tap the muscles you want to train — front and back.';

  @override
  String get continueBtn => 'CONTINUE';

  @override
  String get nothingForFocus => 'Nothing for this focus yet';

  @override
  String get goBackPick => 'Go back and pick a muscle with exercises in your library.';

  @override
  String pickedHint(int n) {
    return 'We picked a session for you — tap to add or drop any of the $n.';
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
  String get restOverBody => 'Back to it — next set is waiting.';

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
  String get restDay => 'Rest day — nothing logged.';

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
  String get placeDeleteBody => 'Only the place goes — your exercises and sessions stay.';

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
      'Cues, plans for next time, how a session felt — with photos or video if you want.';

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
  String get measuresHint => 'Neck to calf — watch your body change, not just the bar.';

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
  String get photoDueNow => 'Photo due — grab it today';

  @override
  String get addTodayPhotos => 'ADD TODAY\'S PHOTOS';

  @override
  String posePhoto(String pose) {
    return '$pose photo';
  }

  @override
  String get compare => 'COMPARE';

  @override
  String get compareNeedTwo => 'Shoot the same pose on two different days and you can compare them here.';

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
  String get timelineBodyHint => 'Built from your own sets — nothing to upload.';

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
  String get dragToReorder => 'Drag the dotted handle to reorder — this is the order you train in.';

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
      'Sessions, records, routines, notes and profile. This cannot be undone — export a backup first if you might want it.';

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
  String get alarmSoundHint => 'Use your own — up to 15 seconds';

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
  String get nothingToExport => 'Nothing to export yet — log a session first';

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
      '1RM, plates, BMI, calories, body fat, FFMI, warm-up, RPE load, and DOTS and Wilks strength scores — all with published formulas.';

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
  String get reminderExactTime => 'Exact time';

  @override
  String get toastSoundSetting => 'Notice sound';

  @override
  String get toastSoundHint => 'A soft chime when a notice pops up at the top.';

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
  String get supersetHint => 'No rest between chained exercises — you go straight to the next one.';

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
      'Snap the gym, the whiteboard, a plate setup — anything you want to remember. They stay on the phone and only you see them.';

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
  String get logHint => 'No timer — just fill in what you did.';

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
      'Use the exercise names exactly as they appear in the list. \"sets\", \"reps\", \"weight\" (in the unit given), \"rest\" in seconds and \"days\" are optional. \"superset\": true links an exercise with the next one. For several weeks, group the routines inside \"weeks\" like the second example.';

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
    return '$name — open the file with GymMane to add it.';
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
  String get tapToSkip => 'Tap to skip';

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
  String get homeRoutinesHint => 'Your routines, last done first. Tap one to start it.';

  @override
  String get homeWeekStats => 'This week on home';

  @override
  String get homeWeekStatsHint => 'Volume, sets and PRs of the week.';

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
  String get multiPlanSettingHint => 'More than one routine on the same weekday.';

  @override
  String get levelHintsHint => 'When an exercise gets easy, it offers you the harder version.';

  @override
  String get focusCardHint => 'Today’s routine, at the top of Home.';

  @override
  String get gamificationHint => 'Medals, your level and the celebration when you finish.';

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
  String get restRowHint => 'Between sets, unless the exercise has its own.';

  @override
  String get effortRowHint => 'Log RPE or RIR on each set.';

  @override
  String get countdownHint => '3, 2, 1 before the first set.';

  @override
  String get keepScreenOnHint => 'The screen stays on while you train.';

  @override
  String get demoSizeRowHint => 'The exercise drawing during the workout.';

  @override
  String get demoLoopRowHint => 'Whether the animation repeats or stops.';

  @override
  String get trainReminderRowHint => 'A nudge on the days you train.';

  @override
  String get alarmSoundRowHint => 'What plays when the rest ends.';

  @override
  String get alarmStyleRowHint => 'Whether it rings in silent mode.';

  @override
  String get recommendedRowHint => 'Exercises we suggest on Home.';

  @override
  String get weightStepSetting => 'Weight step';

  @override
  String get weightStepHint => 'What the − and + buttons add.';

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
}
