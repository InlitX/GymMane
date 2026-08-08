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
  String get noMusclesYet => 'No muscles selected yet — tap the body to begin.';

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
  String get saveAndExit => 'SAVE AND EXIT';

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
  String get totalVolume30d => 'TOTAL VOLUME · 30 DAYS';

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
  String get notLoggedYet => 'Not logged yet';

  @override
  String get logShort => '+ LOG';

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
  String get splitEmpty => 'Train to see how your volume splits across muscle groups.';

  @override
  String get personalRecords => 'PERSONAL RECORDS';

  @override
  String get prEmpty => 'Your records will appear here as you log sets.';

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
  String get tapToDelete => 'Tap the bin to remove a mis-logged entry.';

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
  String get noBodyweightYet => 'Nothing logged yet.';

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
  String showAllNotes(int n) {
    return 'Show all $n notes';
  }

  @override
  String get showFewerNotes => 'Show fewer';

  @override
  String moreNotes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n more notes', one: '$n more note');
    return '$_temp0';
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
  String get dragToReorder => 'Hold and drag to reorder — this is the order you train in.';

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
  String get addToWorkout => 'ADD AN EXERCISE';

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
  String get preferences => 'PREFERENCES';

  @override
  String get theme => 'Theme';

  @override
  String get darkTheme => 'Dark';

  @override
  String get lightTheme => 'Light';

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
  String get homeWidgets => 'HOME SCREEN';

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
  String get data => 'DATA';

  @override
  String get exportCsv => 'Export workouts (CSV)';

  @override
  String get exportBackup => 'Export backup (JSON)';

  @override
  String get importBackup => 'Import backup';

  @override
  String get importHint => 'Choose a .json backup exported from GymMane. This replaces your current data.';

  @override
  String get import => 'Import';

  @override
  String get chooseFile => 'Choose file';

  @override
  String get importFromApp => 'Import from another app';

  @override
  String get importUnknownFormat => 'That file isn\'t an export from Hevy, Strong or FitNotes';

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
  String get backupCopied => 'Backup copied to clipboard';

  @override
  String get backupImported => 'Backup imported';

  @override
  String get backupFailed => 'Couldn\'t read that backup';

  @override
  String get nothingToExport => 'Nothing to export yet — log a session first';

  @override
  String get athlete => 'Athlete';

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
  String rampSet(String pct, int reps) {
    return '$pct · $reps reps';
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
  String get calculatorsInside => '6 calculators';

  @override
  String get calculatorsInsideWhy =>
      '1RM, plates, BMI, calories, body fat and warm-up — all with published formulas.';

  @override
  String get mathInside => 'Honest maths';

  @override
  String get mathInsideWhy =>
      'Volume, records and streaks come from your own sets. Nothing here is decoration.';

  @override
  String get yourNumbers => 'YOUR NUMBERS';

  @override
  String get sessionsCaps => 'SESSIONS';

  @override
  String get liftedCaps => 'LIFTED';

  @override
  String get streakCaps => 'STREAK';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'days', one: 'day');
    return '$_temp0';
  }

  @override
  String get restDefaultLabel => 'Rest timer';

  @override
  String restDefault(int s) {
    return 'Default is ${s}s — change it in Settings';
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
}
