import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// This language, written in itself. Shown in the language picker.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @vsLastMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'{pct}% vs last month'**
  String vsLastMonthLabel(String pct);

  /// No description provided for @levelStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level} · {streak}'**
  String levelStreakLabel(int level, String streak);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelCaps.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancelCaps;

  /// No description provided for @deleteCaps.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get deleteCaps;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get done;

  /// No description provided for @set.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get set;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get home;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'PROGRESS'**
  String get progress;

  /// No description provided for @exercises.
  ///
  /// In en, this message translates to:
  /// **'EXERCISES'**
  String get exercises;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'THIS WEEK'**
  String get thisWeek;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED'**
  String get recommended;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'GOAL'**
  String get goal;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'VOLUME'**
  String get volume;

  /// No description provided for @setsToday.
  ///
  /// In en, this message translates to:
  /// **'SETS TODAY'**
  String get setsToday;

  /// No description provided for @prs.
  ///
  /// In en, this message translates to:
  /// **'PRs'**
  String get prs;

  /// No description provided for @todaysFocus.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S FOCUS'**
  String get todaysFocus;

  /// No description provided for @todaysRoutine.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S ROUTINE'**
  String get todaysRoutine;

  /// No description provided for @startWorkout.
  ///
  /// In en, this message translates to:
  /// **'START WORKOUT'**
  String get startWorkout;

  /// No description provided for @routines.
  ///
  /// In en, this message translates to:
  /// **'ROUTINES'**
  String get routines;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'TOOLS'**
  String get tools;

  /// No description provided for @firstSessionHint.
  ///
  /// In en, this message translates to:
  /// **'Pick your muscles and log your first session'**
  String get firstSessionHint;

  /// No description provided for @exerciseCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} exercise} other{{n} exercises}}'**
  String exerciseCount(int n);

  /// No description provided for @pushDay.
  ///
  /// In en, this message translates to:
  /// **'PUSH DAY'**
  String get pushDay;

  /// No description provided for @pullDay.
  ///
  /// In en, this message translates to:
  /// **'PULL DAY'**
  String get pullDay;

  /// No description provided for @legDay.
  ///
  /// In en, this message translates to:
  /// **'LEG DAY'**
  String get legDay;

  /// No description provided for @pushFocus.
  ///
  /// In en, this message translates to:
  /// **'Chest · Shoulders · Triceps'**
  String get pushFocus;

  /// No description provided for @pullFocus.
  ///
  /// In en, this message translates to:
  /// **'Back · Biceps · Traps'**
  String get pullFocus;

  /// No description provided for @legFocus.
  ///
  /// In en, this message translates to:
  /// **'Quads · Hamstrings · Glutes'**
  String get legFocus;

  /// No description provided for @train.
  ///
  /// In en, this message translates to:
  /// **'TRAIN'**
  String get train;

  /// No description provided for @step1.
  ///
  /// In en, this message translates to:
  /// **'STEP 1 OF 2'**
  String get step1;

  /// No description provided for @step2.
  ///
  /// In en, this message translates to:
  /// **'STEP 2 OF 2'**
  String get step2;

  /// No description provided for @chooseFocus.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE YOUR FOCUS'**
  String get chooseFocus;

  /// No description provided for @buildSession.
  ///
  /// In en, this message translates to:
  /// **'BUILD YOUR SESSION'**
  String get buildSession;

  /// No description provided for @tapMuscles.
  ///
  /// In en, this message translates to:
  /// **'Tap the muscles you want to train — front and back.'**
  String get tapMuscles;

  /// No description provided for @noMusclesYet.
  ///
  /// In en, this message translates to:
  /// **'No muscles selected yet — tap the body to begin.'**
  String get noMusclesYet;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueBtn;

  /// No description provided for @nothingForFocus.
  ///
  /// In en, this message translates to:
  /// **'Nothing for this focus yet'**
  String get nothingForFocus;

  /// No description provided for @goBackPick.
  ///
  /// In en, this message translates to:
  /// **'Go back and pick a muscle with exercises in your library.'**
  String get goBackPick;

  /// No description provided for @pickedHint.
  ///
  /// In en, this message translates to:
  /// **'We picked a session for you — tap to add or drop any of the {n}.'**
  String pickedHint(int n);

  /// No description provided for @pickAnExercise.
  ///
  /// In en, this message translates to:
  /// **'PICK AN EXERCISE'**
  String get pickAnExercise;

  /// No description provided for @searchAllExercises.
  ///
  /// In en, this message translates to:
  /// **'Search any exercise…'**
  String get searchAllExercises;

  /// No description provided for @noExercisesMatch.
  ///
  /// In en, this message translates to:
  /// **'No exercises match'**
  String get noExercisesMatch;

  /// No description provided for @createItInstead.
  ///
  /// In en, this message translates to:
  /// **'Create it as your own instead'**
  String get createItInstead;

  /// No description provided for @startCount.
  ///
  /// In en, this message translates to:
  /// **'START · {n, plural, =1{{n} EXERCISE} other{{n} EXERCISES}}'**
  String startCount(int n);

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'IN PROGRESS'**
  String get inProgress;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get paused;

  /// No description provided for @last.
  ///
  /// In en, this message translates to:
  /// **'LAST'**
  String get last;

  /// No description provided for @rest.
  ///
  /// In en, this message translates to:
  /// **'REST'**
  String get rest;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @addSet.
  ///
  /// In en, this message translates to:
  /// **'+ ADD SET'**
  String get addSet;

  /// No description provided for @finishSession.
  ///
  /// In en, this message translates to:
  /// **'FINISH SESSION'**
  String get finishSession;

  /// No description provided for @setCol.
  ///
  /// In en, this message translates to:
  /// **'#'**
  String get setCol;

  /// No description provided for @repsCol.
  ///
  /// In en, this message translates to:
  /// **'REPS'**
  String get repsCol;

  /// No description provided for @weightCol.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT ({unit})'**
  String weightCol(String unit);

  /// No description provided for @repsTitle.
  ///
  /// In en, this message translates to:
  /// **'REPS'**
  String get repsTitle;

  /// No description provided for @weightTitle.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT ({unit})'**
  String weightTitle(String unit);

  /// No description provided for @sessionComplete.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT LOGGED'**
  String get sessionComplete;

  /// No description provided for @finishHeadlinePr.
  ///
  /// In en, this message translates to:
  /// **'New personal record'**
  String get finishHeadlinePr;

  /// No description provided for @finishHeadlineGoal.
  ///
  /// In en, this message translates to:
  /// **'Weekly goal reached'**
  String get finishHeadlineGoal;

  /// No description provided for @finishHeadlineStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak alive'**
  String get finishHeadlineStreak;

  /// No description provided for @finishHeadlineDefault.
  ///
  /// In en, this message translates to:
  /// **'Another one in the bank'**
  String get finishHeadlineDefault;

  /// No description provided for @finishBodyPr.
  ///
  /// In en, this message translates to:
  /// **'You lifted more than ever on {prs, plural, =1{an exercise} other{{prs} exercises}}. It is in your records now.'**
  String finishBodyPr(int prs);

  /// No description provided for @finishBodyGoal.
  ///
  /// In en, this message translates to:
  /// **'You hit the sessions you set out to do this week.'**
  String get finishBodyGoal;

  /// No description provided for @finishBodyStreak.
  ///
  /// In en, this message translates to:
  /// **'{streak} days in a row. The hard part is not stopping.'**
  String finishBodyStreak(int streak);

  /// No description provided for @finishBodyDefault.
  ///
  /// In en, this message translates to:
  /// **'Logged and counted. Consistency is what moves the numbers.'**
  String get finishBodyDefault;

  /// No description provided for @vsLastTime.
  ///
  /// In en, this message translates to:
  /// **'VS LAST TIME'**
  String get vsLastTime;

  /// No description provided for @firstTime.
  ///
  /// In en, this message translates to:
  /// **'First time logged'**
  String get firstTime;

  /// No description provided for @prCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} new record} other{{n} new records}}'**
  String prCount(int n);

  /// No description provided for @saveAndExit.
  ///
  /// In en, this message translates to:
  /// **'SAVE AND EXIT'**
  String get saveAndExit;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'DURATION'**
  String get duration;

  /// No description provided for @setsCaps.
  ///
  /// In en, this message translates to:
  /// **'SETS'**
  String get setsCaps;

  /// No description provided for @exerciseXofY.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE {i} OF {n}'**
  String exerciseXofY(int i, int n);

  /// No description provided for @decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @markSet.
  ///
  /// In en, this message translates to:
  /// **'Mark set {n} as done'**
  String markSet(int n);

  /// No description provided for @pauseWorkout.
  ///
  /// In en, this message translates to:
  /// **'Pause workout'**
  String get pauseWorkout;

  /// No description provided for @resumeWorkout.
  ///
  /// In en, this message translates to:
  /// **'Resume workout'**
  String get resumeWorkout;

  /// No description provided for @discardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard workout?'**
  String get discardTitle;

  /// No description provided for @discardBody.
  ///
  /// In en, this message translates to:
  /// **'Your sets from this session will be lost.'**
  String get discardBody;

  /// No description provided for @keepTraining.
  ///
  /// In en, this message translates to:
  /// **'Keep training'**
  String get keepTraining;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @notifRestChannel.
  ///
  /// In en, this message translates to:
  /// **'Rest timer'**
  String get notifRestChannel;

  /// No description provided for @notifRestChannelWhy.
  ///
  /// In en, this message translates to:
  /// **'Tells you when your rest between sets is over'**
  String get notifRestChannelWhy;

  /// No description provided for @notifAlertChannel.
  ///
  /// In en, this message translates to:
  /// **'Rest timer (alert)'**
  String get notifAlertChannel;

  /// No description provided for @notifAlertChannelWhy.
  ///
  /// In en, this message translates to:
  /// **'Shows a banner the moment your rest is over'**
  String get notifAlertChannelWhy;

  /// No description provided for @restOverTitle.
  ///
  /// In en, this message translates to:
  /// **'Rest over'**
  String get restOverTitle;

  /// No description provided for @restOverBody.
  ///
  /// In en, this message translates to:
  /// **'Back to it — next set is waiting.'**
  String get restOverBody;

  /// No description provided for @totalVolume30d.
  ///
  /// In en, this message translates to:
  /// **'TOTAL VOLUME · 30 DAYS'**
  String get totalVolume30d;

  /// No description provided for @volumeCumulative.
  ///
  /// In en, this message translates to:
  /// **'Running total of every kilo you moved'**
  String get volumeCumulative;

  /// No description provided for @volumeChartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Log a session and the curve starts here'**
  String get volumeChartEmpty;

  /// No description provided for @weekRhythm.
  ///
  /// In en, this message translates to:
  /// **'WEEK RHYTHM'**
  String get weekRhythm;

  /// No description provided for @weekRhythmHint.
  ///
  /// In en, this message translates to:
  /// **'Which days you actually show up.'**
  String get weekRhythmHint;

  /// No description provided for @weekRhythmBest.
  ///
  /// In en, this message translates to:
  /// **'{day} is your day'**
  String weekRhythmBest(String day);

  /// No description provided for @weekRhythmEmpty.
  ///
  /// In en, this message translates to:
  /// **'Log a session and your week takes shape here.'**
  String get weekRhythmEmpty;

  /// No description provided for @allTime.
  ///
  /// In en, this message translates to:
  /// **'ALL TIME'**
  String get allTime;

  /// No description provided for @allTimeSessions.
  ///
  /// In en, this message translates to:
  /// **'SESSIONS'**
  String get allTimeSessions;

  /// No description provided for @allTimeTime.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get allTimeTime;

  /// No description provided for @allTimeVolume.
  ///
  /// In en, this message translates to:
  /// **'LIFTED'**
  String get allTimeVolume;

  /// No description provided for @allTimeSets.
  ///
  /// In en, this message translates to:
  /// **'SETS'**
  String get allTimeSets;

  /// No description provided for @allTimeAvg.
  ///
  /// In en, this message translates to:
  /// **'{time} a session on average'**
  String allTimeAvg(String time);

  /// No description provided for @hoursShort.
  ///
  /// In en, this message translates to:
  /// **'{n}h'**
  String hoursShort(int n);

  /// No description provided for @consistency.
  ///
  /// In en, this message translates to:
  /// **'CONSISTENCY'**
  String get consistency;

  /// No description provided for @sessionsLogged.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} session logged} other{{n} sessions logged}}'**
  String sessionsLogged(int n);

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{n}-day streak'**
  String streakDays(int n);

  /// No description provided for @bodyweight.
  ///
  /// In en, this message translates to:
  /// **'BODYWEIGHT'**
  String get bodyweight;

  /// No description provided for @notLoggedYet.
  ///
  /// In en, this message translates to:
  /// **'Not logged yet'**
  String get notLoggedYet;

  /// No description provided for @logShort.
  ///
  /// In en, this message translates to:
  /// **'+ LOG'**
  String get logShort;

  /// No description provided for @logBodyweight.
  ///
  /// In en, this message translates to:
  /// **'LOG BODYWEIGHT'**
  String get logBodyweight;

  /// No description provided for @trackWeight.
  ///
  /// In en, this message translates to:
  /// **'Track your weight over time'**
  String get trackWeight;

  /// No description provided for @muscleMap.
  ///
  /// In en, this message translates to:
  /// **'MUSCLE MAP'**
  String get muscleMap;

  /// No description provided for @days7.
  ///
  /// In en, this message translates to:
  /// **'7D'**
  String get days7;

  /// No description provided for @days30.
  ///
  /// In en, this message translates to:
  /// **'30D'**
  String get days30;

  /// No description provided for @heatLow.
  ///
  /// In en, this message translates to:
  /// **'Untouched'**
  String get heatLow;

  /// No description provided for @heatHigh.
  ///
  /// In en, this message translates to:
  /// **'Full volume'**
  String get heatHigh;

  /// No description provided for @muscleMapEmpty.
  ///
  /// In en, this message translates to:
  /// **'Log a session and your body starts lighting up here.'**
  String get muscleMapEmpty;

  /// No description provided for @muscleMapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a muscle to see what it got.'**
  String get muscleMapHint;

  /// No description provided for @muscleMapBehind.
  ///
  /// In en, this message translates to:
  /// **'Falling behind: {names}'**
  String muscleMapBehind(String names);

  /// No description provided for @ofTarget.
  ///
  /// In en, this message translates to:
  /// **'{pct}% of target'**
  String ofTarget(int pct);

  /// No description provided for @muscleSplit.
  ///
  /// In en, this message translates to:
  /// **'MUSCLE SPLIT'**
  String get muscleSplit;

  /// No description provided for @splitEmpty.
  ///
  /// In en, this message translates to:
  /// **'Train to see how your volume splits across muscle groups.'**
  String get splitEmpty;

  /// No description provided for @personalRecords.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL RECORDS'**
  String get personalRecords;

  /// No description provided for @prEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your records will appear here as you log sets.'**
  String get prEmpty;

  /// No description provided for @strength1rm.
  ///
  /// In en, this message translates to:
  /// **'STRENGTH · EST. 1RM'**
  String get strength1rm;

  /// No description provided for @strengthEmpty.
  ///
  /// In en, this message translates to:
  /// **'Log an exercise twice and its strength curve shows up here.'**
  String get strengthEmpty;

  /// No description provided for @oneRmEst.
  ///
  /// In en, this message translates to:
  /// **'1RM est. {w}'**
  String oneRmEst(String w);

  /// No description provided for @restDayShort.
  ///
  /// In en, this message translates to:
  /// **'Rest day'**
  String get restDayShort;

  /// No description provided for @restDay.
  ///
  /// In en, this message translates to:
  /// **'Rest day — nothing logged.'**
  String get restDay;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteEntry.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get deleteEntry;

  /// No description provided for @deleteEntryBody.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" will be removed from this day, and from your records and charts.'**
  String deleteEntryBody(String name);

  /// No description provided for @bodyweightHistory.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get bodyweightHistory;

  /// No description provided for @noBodyweightYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged yet.'**
  String get noBodyweightYet;

  /// No description provided for @exercisesCaps.
  ///
  /// In en, this message translates to:
  /// **'EXERCISES'**
  String get exercisesCaps;

  /// No description provided for @timeCaps.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get timeCaps;

  /// No description provided for @libraryCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} exercise in your library} other{{n} exercises in your library}}'**
  String libraryCount(int n);

  /// No description provided for @searchExercises.
  ///
  /// In en, this message translates to:
  /// **'Search exercises'**
  String get searchExercises;

  /// No description provided for @muscleFilter.
  ///
  /// In en, this message translates to:
  /// **'MUSCLE'**
  String get muscleFilter;

  /// No description provided for @levelFilter.
  ///
  /// In en, this message translates to:
  /// **'LEVEL'**
  String get levelFilter;

  /// No description provided for @newExercise.
  ///
  /// In en, this message translates to:
  /// **'NEW EXERCISE'**
  String get newExercise;

  /// No description provided for @exerciseName.
  ///
  /// In en, this message translates to:
  /// **'Exercise name'**
  String get exerciseName;

  /// No description provided for @equipmentLabel.
  ///
  /// In en, this message translates to:
  /// **'EQUIPMENT'**
  String get equipmentLabel;

  /// No description provided for @addExercise.
  ///
  /// In en, this message translates to:
  /// **'ADD EXERCISE'**
  String get addExercise;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'ADVANCED'**
  String get advanced;

  /// No description provided for @demoMedia.
  ///
  /// In en, this message translates to:
  /// **'DEMO'**
  String get demoMedia;

  /// No description provided for @addMedia.
  ///
  /// In en, this message translates to:
  /// **'Add media'**
  String get addMedia;

  /// No description provided for @mediaHint.
  ///
  /// In en, this message translates to:
  /// **'Image, GIF or video'**
  String get mediaHint;

  /// No description provided for @changeMedia.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeMedia;

  /// No description provided for @videoSelected.
  ///
  /// In en, this message translates to:
  /// **'Video selected'**
  String get videoSelected;

  /// No description provided for @favouritesOnly.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favouritesOnly;

  /// No description provided for @noFavouritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favourites yet'**
  String get noFavouritesYet;

  /// No description provided for @noFavouritesHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the star on an exercise to keep it here.'**
  String get noFavouritesHint;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @noExercisesFound.
  ///
  /// In en, this message translates to:
  /// **'No exercises found'**
  String get noExercisesFound;

  /// No description provided for @noExercisesHint.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or clear your filters.'**
  String get noExercisesHint;

  /// No description provided for @personalRecord.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL RECORD'**
  String get personalRecord;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get history;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No sessions logged yet. Train this exercise to build history.'**
  String get noHistory;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'NOTES'**
  String get notes;

  /// No description provided for @notePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Cues, setup, how it felt…'**
  String get notePlaceholder;

  /// No description provided for @showAllNotes.
  ///
  /// In en, this message translates to:
  /// **'Show all {n} notes'**
  String showAllNotes(int n);

  /// No description provided for @notHere.
  ///
  /// In en, this message translates to:
  /// **'No {gear} at {place}'**
  String notHere(String gear, String place);

  /// No description provided for @notHereWhy.
  ///
  /// In en, this message translates to:
  /// **'Swap it for something you can actually load today.'**
  String get notHereWhy;

  /// No description provided for @altHere.
  ///
  /// In en, this message translates to:
  /// **'WHAT YOU CAN DO HERE'**
  String get altHere;

  /// No description provided for @places.
  ///
  /// In en, this message translates to:
  /// **'MY PLACES'**
  String get places;

  /// No description provided for @placesShort.
  ///
  /// In en, this message translates to:
  /// **'Places'**
  String get placesShort;

  /// No description provided for @placesHint.
  ///
  /// In en, this message translates to:
  /// **'Say what you have in each place and the library only shows what you can actually do there.'**
  String get placesHint;

  /// No description provided for @placeAll.
  ///
  /// In en, this message translates to:
  /// **'Anywhere'**
  String get placeAll;

  /// No description provided for @placeNew.
  ///
  /// In en, this message translates to:
  /// **'New place'**
  String get placeNew;

  /// No description provided for @placeNameLabel.
  ///
  /// In en, this message translates to:
  /// **'NAME'**
  String get placeNameLabel;

  /// No description provided for @placeNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Home, gym, the park…'**
  String get placeNamePlaceholder;

  /// No description provided for @placeGearLabel.
  ///
  /// In en, this message translates to:
  /// **'WHAT IS THERE'**
  String get placeGearLabel;

  /// No description provided for @placeGearCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{Nothing ticked} =1{1 kind of kit} other{{n} kinds of kit}}'**
  String placeGearCount(int n);

  /// No description provided for @placeExercises.
  ///
  /// In en, this message translates to:
  /// **'{n} exercises here'**
  String placeExercises(int n);

  /// No description provided for @placeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Train wherever you are'**
  String get placeEmptyTitle;

  /// No description provided for @placeEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'A place is a list of the kit you have there. Pick one to start and edit it later.'**
  String get placeEmptyBody;

  /// No description provided for @placeDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete place'**
  String get placeDeleteTitle;

  /// No description provided for @placeDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Only the place goes — your exercises and sessions stay.'**
  String get placeDeleteBody;

  /// No description provided for @placeGym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get placeGym;

  /// No description provided for @placeHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get placeHome;

  /// No description provided for @placeOutdoors.
  ///
  /// In en, this message translates to:
  /// **'Outdoors'**
  String get placeOutdoors;

  /// No description provided for @placeFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'PLACE'**
  String get placeFilterLabel;

  /// No description provided for @noGearOnly.
  ///
  /// In en, this message translates to:
  /// **'No kit'**
  String get noGearOnly;

  /// No description provided for @placeActive.
  ///
  /// In en, this message translates to:
  /// **'Training at {name}'**
  String placeActive(String name);

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'JOURNAL'**
  String get journal;

  /// No description provided for @noteCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{No notes} =1{1 note} other{{n} notes}}'**
  String noteCount(int n);

  /// No description provided for @noteKindNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteKindNote;

  /// No description provided for @noteKindPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get noteKindPlan;

  /// No description provided for @noteKindDone.
  ///
  /// In en, this message translates to:
  /// **'Win'**
  String get noteKindDone;

  /// No description provided for @noteKindPain.
  ///
  /// In en, this message translates to:
  /// **'Niggle'**
  String get noteKindPain;

  /// No description provided for @noteFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get noteFilterAll;

  /// No description provided for @newNote.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get newNote;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit note'**
  String get editNote;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'ADD NOTE'**
  String get addNote;

  /// No description provided for @noteEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing written down yet'**
  String get noteEmptyTitle;

  /// No description provided for @noteEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Cues, plans for next time, how a session felt — with photos or video if you want.'**
  String get noteEmptyBody;

  /// No description provided for @noteNoneForExercise.
  ///
  /// In en, this message translates to:
  /// **'No notes on this exercise yet.'**
  String get noteNoneForExercise;

  /// No description provided for @noteKindLabel.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get noteKindLabel;

  /// No description provided for @noteTextLabel.
  ///
  /// In en, this message translates to:
  /// **'NOTE'**
  String get noteTextLabel;

  /// No description provided for @noteDateLabel.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get noteDateLabel;

  /// No description provided for @noteExerciseLabel.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE'**
  String get noteExerciseLabel;

  /// No description provided for @noteMediaLabel.
  ///
  /// In en, this message translates to:
  /// **'PHOTOS & VIDEO'**
  String get noteMediaLabel;

  /// No description provided for @noteGeneral.
  ///
  /// In en, this message translates to:
  /// **'No exercise'**
  String get noteGeneral;

  /// No description provided for @noteAttach.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get noteAttach;

  /// No description provided for @noteRemoveMedia.
  ///
  /// In en, this message translates to:
  /// **'Remove attachment'**
  String get noteRemoveMedia;

  /// No description provided for @deleteNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete note'**
  String get deleteNoteTitle;

  /// No description provided for @deleteNoteBody.
  ///
  /// In en, this message translates to:
  /// **'The note and anything attached to it go for good.'**
  String get deleteNoteBody;

  /// No description provided for @noteToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get noteToday;

  /// No description provided for @noteYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get noteYesterday;

  /// No description provided for @noteAllNotes.
  ///
  /// In en, this message translates to:
  /// **'All notes'**
  String get noteAllNotes;

  /// No description provided for @noteCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get noteCalendar;

  /// No description provided for @noteNoneOnDay.
  ///
  /// In en, this message translates to:
  /// **'Nothing written on this day'**
  String get noteNoneOnDay;

  /// No description provided for @noteAddOnDay.
  ///
  /// In en, this message translates to:
  /// **'Note on this day'**
  String get noteAddOnDay;

  /// No description provided for @notePrevMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get notePrevMonth;

  /// No description provided for @noteNextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get noteNextMonth;

  /// No description provided for @noteMonthCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{No notes this month} =1{1 note this month} other{{n} notes this month}}'**
  String noteMonthCount(int n);

  /// No description provided for @measures.
  ///
  /// In en, this message translates to:
  /// **'MEASUREMENTS'**
  String get measures;

  /// No description provided for @measuresHint.
  ///
  /// In en, this message translates to:
  /// **'Neck to calf — watch your body change, not just the bar.'**
  String get measuresHint;

  /// No description provided for @measureCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{Nothing logged} =1{1 reading} other{{n} readings}}'**
  String measureCount(int n);

  /// No description provided for @measureNoneYet.
  ///
  /// In en, this message translates to:
  /// **'Not logged yet'**
  String get measureNoneYet;

  /// No description provided for @measureHistory.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get measureHistory;

  /// No description provided for @measureNeck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get measureNeck;

  /// No description provided for @measureShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get measureShoulders;

  /// No description provided for @measureChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get measureChest;

  /// No description provided for @measureArm.
  ///
  /// In en, this message translates to:
  /// **'Arm'**
  String get measureArm;

  /// No description provided for @measureForearm.
  ///
  /// In en, this message translates to:
  /// **'Forearm'**
  String get measureForearm;

  /// No description provided for @measureWaist.
  ///
  /// In en, this message translates to:
  /// **'Waist'**
  String get measureWaist;

  /// No description provided for @measureHips.
  ///
  /// In en, this message translates to:
  /// **'Hips'**
  String get measureHips;

  /// No description provided for @measureThigh.
  ///
  /// In en, this message translates to:
  /// **'Thigh'**
  String get measureThigh;

  /// No description provided for @measureCalf.
  ///
  /// In en, this message translates to:
  /// **'Calf'**
  String get measureCalf;

  /// No description provided for @measureBodyfat.
  ///
  /// In en, this message translates to:
  /// **'Body fat'**
  String get measureBodyfat;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'TIMELINE'**
  String get timeline;

  /// No description provided for @timelineHint.
  ///
  /// In en, this message translates to:
  /// **'Same pose, same spot, same light. In a year you will not believe it.'**
  String get timelineHint;

  /// No description provided for @timelineEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your first photo starts the clock'**
  String get timelineEmptyTitle;

  /// No description provided for @photoCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{No photos} =1{1 photo} other{{n} photos}}'**
  String photoCount(int n);

  /// No description provided for @poseFront.
  ///
  /// In en, this message translates to:
  /// **'Front'**
  String get poseFront;

  /// No description provided for @poseSide.
  ///
  /// In en, this message translates to:
  /// **'Side'**
  String get poseSide;

  /// No description provided for @poseBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get poseBack;

  /// No description provided for @photoEvery.
  ///
  /// In en, this message translates to:
  /// **'REMIND ME'**
  String get photoEvery;

  /// No description provided for @photoEveryDays.
  ///
  /// In en, this message translates to:
  /// **'Every {n} days'**
  String photoEveryDays(int n);

  /// No description provided for @photoEveryOff.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get photoEveryOff;

  /// No description provided for @photoNextIn.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{Next photo tomorrow} other{Next photo in {n} days}}'**
  String photoNextIn(int n);

  /// No description provided for @photoDueNow.
  ///
  /// In en, this message translates to:
  /// **'Photo due — grab it today'**
  String get photoDueNow;

  /// No description provided for @addTodayPhotos.
  ///
  /// In en, this message translates to:
  /// **'ADD TODAY\'S PHOTOS'**
  String get addTodayPhotos;

  /// No description provided for @posePhoto.
  ///
  /// In en, this message translates to:
  /// **'{pose} photo'**
  String posePhoto(String pose);

  /// No description provided for @compare.
  ///
  /// In en, this message translates to:
  /// **'COMPARE'**
  String get compare;

  /// No description provided for @compareNeedTwo.
  ///
  /// In en, this message translates to:
  /// **'Shoot the same pose on two different days and you can compare them here.'**
  String get compareNeedTwo;

  /// No description provided for @dayNumber.
  ///
  /// In en, this message translates to:
  /// **'Day {n}'**
  String dayNumber(int n);

  /// No description provided for @daysApart.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{Same day} =1{1 day apart} other{{n} days apart}}'**
  String daysApart(int n);

  /// No description provided for @deleteEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this day'**
  String get deleteEntryTitle;

  /// No description provided for @deleteDayBody.
  ///
  /// In en, this message translates to:
  /// **'Its photos go with it, for good.'**
  String get deleteDayBody;

  /// No description provided for @timelinePhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get timelinePhotos;

  /// No description provided for @timelineBody.
  ///
  /// In en, this message translates to:
  /// **'Muscle map'**
  String get timelineBody;

  /// No description provided for @timelineBodyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Log a session and your muscle map starts filling in here, no photos needed.'**
  String get timelineBodyEmpty;

  /// No description provided for @timelineBodyHint.
  ///
  /// In en, this message translates to:
  /// **'Built from your own sets — nothing to upload.'**
  String get timelineBodyHint;

  /// No description provided for @timelineWindow.
  ///
  /// In en, this message translates to:
  /// **'{from} – {to}'**
  String timelineWindow(String from, String to);

  /// No description provided for @sessionCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{No sessions} =1{1 session} other{{n} sessions}}'**
  String sessionCount(int n);

  /// No description provided for @notifPhotoChannel.
  ///
  /// In en, this message translates to:
  /// **'Progress photos'**
  String get notifPhotoChannel;

  /// No description provided for @notifPhotoChannelWhy.
  ///
  /// In en, this message translates to:
  /// **'A nudge when your next progress photo is due.'**
  String get notifPhotoChannelWhy;

  /// No description provided for @notifPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Time for your progress photo'**
  String get notifPhotoTitle;

  /// No description provided for @notifPhotoBody.
  ///
  /// In en, this message translates to:
  /// **'{n} days since the last one. Same pose, same light.'**
  String notifPhotoBody(int n);

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'SHARE'**
  String get share;

  /// No description provided for @sharePick.
  ///
  /// In en, this message translates to:
  /// **'What do you want to show?'**
  String get sharePick;

  /// No description provided for @shareSession.
  ///
  /// In en, this message translates to:
  /// **'Last session'**
  String get shareSession;

  /// No description provided for @shareStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak and consistency'**
  String get shareStreak;

  /// No description provided for @shareBody.
  ///
  /// In en, this message translates to:
  /// **'Muscles worked'**
  String get shareBody;

  /// No description provided for @shareCompare.
  ///
  /// In en, this message translates to:
  /// **'Before and after'**
  String get shareCompare;

  /// No description provided for @shareHint.
  ///
  /// In en, this message translates to:
  /// **'The card is built on your phone. Nothing leaves until you pick where it goes.'**
  String get shareHint;

  /// No description provided for @shareFailed.
  ///
  /// In en, this message translates to:
  /// **'The card could not be built'**
  String get shareFailed;

  /// No description provided for @shareWeekOf.
  ///
  /// In en, this message translates to:
  /// **'LAST 7 DAYS'**
  String get shareWeekOf;

  /// No description provided for @shareStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'DAY STREAK'**
  String get shareStreakLabel;

  /// No description provided for @shareSessionsLabel.
  ///
  /// In en, this message translates to:
  /// **'SESSIONS'**
  String get shareSessionsLabel;

  /// No description provided for @shareVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'VOLUME'**
  String get shareVolumeLabel;

  /// No description provided for @shareSetsLabel.
  ///
  /// In en, this message translates to:
  /// **'SETS'**
  String get shareSetsLabel;

  /// No description provided for @shareNothing.
  ///
  /// In en, this message translates to:
  /// **'Log a session first — there is nothing to show yet'**
  String get shareNothing;

  /// No description provided for @restForExercise.
  ///
  /// In en, this message translates to:
  /// **'REST FOR THIS EXERCISE'**
  String get restForExercise;

  /// No description provided for @restUsingDefault.
  ///
  /// In en, this message translates to:
  /// **'Using your default'**
  String get restUsingDefault;

  /// No description provided for @restCustom.
  ///
  /// In en, this message translates to:
  /// **'Only for this one'**
  String get restCustom;

  /// No description provided for @setType.
  ///
  /// In en, this message translates to:
  /// **'SET TYPE'**
  String get setType;

  /// No description provided for @setTypeNormal.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get setTypeNormal;

  /// No description provided for @setTypeWarmup.
  ///
  /// In en, this message translates to:
  /// **'Warm-up'**
  String get setTypeWarmup;

  /// No description provided for @setTypeDrop.
  ///
  /// In en, this message translates to:
  /// **'Drop set'**
  String get setTypeDrop;

  /// No description provided for @setTypeFailure.
  ///
  /// In en, this message translates to:
  /// **'To failure'**
  String get setTypeFailure;

  /// No description provided for @setTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Warm-ups stay out of your volume and your records.'**
  String get setTypeHint;

  /// No description provided for @addWarmup.
  ///
  /// In en, this message translates to:
  /// **'WARM-UP'**
  String get addWarmup;

  /// No description provided for @platesPerSide.
  ///
  /// In en, this message translates to:
  /// **'Per side: {plates}'**
  String platesPerSide(String plates);

  /// No description provided for @howTo.
  ///
  /// In en, this message translates to:
  /// **'HOW TO'**
  String get howTo;

  /// No description provided for @similar.
  ///
  /// In en, this message translates to:
  /// **'SIMILAR'**
  String get similar;

  /// No description provided for @primaryLabel.
  ///
  /// In en, this message translates to:
  /// **'PRIMARY'**
  String get primaryLabel;

  /// No description provided for @secondaryLabel.
  ///
  /// In en, this message translates to:
  /// **'SECONDARY'**
  String get secondaryLabel;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @setCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} set} other{{n} sets}}'**
  String setCount(int n);

  /// No description provided for @volumeSuffix.
  ///
  /// In en, this message translates to:
  /// **'{v} volume'**
  String volumeSuffix(String v);

  /// No description provided for @weeklyPlan.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY PLAN'**
  String get weeklyPlan;

  /// No description provided for @yourRoutines.
  ///
  /// In en, this message translates to:
  /// **'YOUR ROUTINES'**
  String get yourRoutines;

  /// No description provided for @noRoutines.
  ///
  /// In en, this message translates to:
  /// **'No routines yet. Create one and add your exercises.'**
  String get noRoutines;

  /// No description provided for @newRoutine.
  ///
  /// In en, this message translates to:
  /// **'NEW ROUTINE'**
  String get newRoutine;

  /// No description provided for @routineName.
  ///
  /// In en, this message translates to:
  /// **'Routine name'**
  String get routineName;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE'**
  String get schedule;

  /// No description provided for @addFromList.
  ///
  /// In en, this message translates to:
  /// **'Add exercises from the list below.'**
  String get addFromList;

  /// No description provided for @addExercises.
  ///
  /// In en, this message translates to:
  /// **'Add exercises'**
  String get addExercises;

  /// No description provided for @deleteRoutine.
  ///
  /// In en, this message translates to:
  /// **'Delete this routine?'**
  String get deleteRoutine;

  /// No description provided for @exercisesWithCount.
  ///
  /// In en, this message translates to:
  /// **'EXERCISES · {n}'**
  String exercisesWithCount(int n);

  /// No description provided for @setDay.
  ///
  /// In en, this message translates to:
  /// **'SET {day}'**
  String setDay(String day);

  /// No description provided for @newRoutineName.
  ///
  /// In en, this message translates to:
  /// **'New routine'**
  String get newRoutineName;

  /// No description provided for @dragToReorder.
  ///
  /// In en, this message translates to:
  /// **'Hold and drag to reorder — this is the order you train in.'**
  String get dragToReorder;

  /// No description provided for @reorderHandle.
  ///
  /// In en, this message translates to:
  /// **'Reorder {name}'**
  String reorderHandle(String name);

  /// No description provided for @removeFromRoutine.
  ///
  /// In en, this message translates to:
  /// **'Remove from routine'**
  String get removeFromRoutine;

  /// No description provided for @dropExercise.
  ///
  /// In en, this message translates to:
  /// **'Drop this exercise?'**
  String get dropExercise;

  /// No description provided for @dropExerciseBody.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" leaves this workout. Nothing logged is lost.'**
  String dropExerciseBody(String name);

  /// No description provided for @drop.
  ///
  /// In en, this message translates to:
  /// **'Drop'**
  String get drop;

  /// No description provided for @addToWorkout.
  ///
  /// In en, this message translates to:
  /// **'ADD AN EXERCISE'**
  String get addToWorkout;

  /// No description provided for @resetData.
  ///
  /// In en, this message translates to:
  /// **'Delete all my data'**
  String get resetData;

  /// No description provided for @resetTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete everything?'**
  String get resetTitle;

  /// No description provided for @resetBody.
  ///
  /// In en, this message translates to:
  /// **'Sessions, records, routines, notes and profile. This cannot be undone — export a backup first if you might want it.'**
  String get resetBody;

  /// No description provided for @resetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete everything'**
  String get resetConfirm;

  /// No description provided for @resetDone.
  ///
  /// In en, this message translates to:
  /// **'All data deleted'**
  String get resetDone;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get support;

  /// No description provided for @reportBug.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get reportBug;

  /// No description provided for @requestFeature.
  ///
  /// In en, this message translates to:
  /// **'Request a feature'**
  String get requestFeature;

  /// No description provided for @starOnGithub.
  ///
  /// In en, this message translates to:
  /// **'Star on GitHub'**
  String get starOnGithub;

  /// No description provided for @buyCoffee.
  ///
  /// In en, this message translates to:
  /// **'Buy me a coffee'**
  String get buyCoffee;

  /// No description provided for @cantOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link'**
  String get cantOpenLink;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @unitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitsLabel;

  /// No description provided for @restTimer.
  ///
  /// In en, this message translates to:
  /// **'Rest timer'**
  String get restTimer;

  /// No description provided for @alarmBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications are off'**
  String get alarmBlockedTitle;

  /// No description provided for @alarmBlockedBody.
  ///
  /// In en, this message translates to:
  /// **'The rest alarm won\'t go off with the screen locked'**
  String get alarmBlockedBody;

  /// No description provided for @alarmBlockedAction.
  ///
  /// In en, this message translates to:
  /// **'TURN ON'**
  String get alarmBlockedAction;

  /// No description provided for @alarmSound.
  ///
  /// In en, this message translates to:
  /// **'Alarm sound'**
  String get alarmSound;

  /// No description provided for @alarmDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get alarmDefaultName;

  /// No description provided for @alarmSoundHint.
  ///
  /// In en, this message translates to:
  /// **'Use your own — up to 15 seconds'**
  String get alarmSoundHint;

  /// No description provided for @alarmChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose a sound…'**
  String get alarmChoose;

  /// No description provided for @alarmPreview.
  ///
  /// In en, this message translates to:
  /// **'Play current sound'**
  String get alarmPreview;

  /// No description provided for @alarmReset.
  ///
  /// In en, this message translates to:
  /// **'Reset to default'**
  String get alarmReset;

  /// No description provided for @alarmTooLong.
  ///
  /// In en, this message translates to:
  /// **'That sound is longer than 15 seconds'**
  String get alarmTooLong;

  /// No description provided for @alarmInvalid.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read that audio file'**
  String get alarmInvalid;

  /// No description provided for @alarmChanged.
  ///
  /// In en, this message translates to:
  /// **'Alarm sound set to \"{name}\"'**
  String alarmChanged(String name);

  /// No description provided for @alarmChangedDefault.
  ///
  /// In en, this message translates to:
  /// **'Back to the default sound'**
  String get alarmChangedDefault;

  /// No description provided for @homeWidgets.
  ///
  /// In en, this message translates to:
  /// **'HOME SCREEN'**
  String get homeWidgets;

  /// No description provided for @addActivityWidget.
  ///
  /// In en, this message translates to:
  /// **'Add activity widget'**
  String get addActivityWidget;

  /// No description provided for @addStatsWidget.
  ///
  /// In en, this message translates to:
  /// **'Add stats widget'**
  String get addStatsWidget;

  /// No description provided for @pinUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Add it from your launcher\'s widget menu'**
  String get pinUnsupported;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @bgNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get bgNone;

  /// No description provided for @bgDots.
  ///
  /// In en, this message translates to:
  /// **'Dots'**
  String get bgDots;

  /// No description provided for @bgGrid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get bgGrid;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'DATA'**
  String get data;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export workouts (CSV)'**
  String get exportCsv;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export backup (ZIP)'**
  String get exportBackup;

  /// No description provided for @importBackup.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get importBackup;

  /// No description provided for @importHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a .zip (or older .json) backup exported from GymMane. This replaces your current data, media included.'**
  String get importHint;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get chooseFile;

  /// No description provided for @importFromApp.
  ///
  /// In en, this message translates to:
  /// **'Import from another app'**
  String get importFromApp;

  /// No description provided for @importUnknownFormat.
  ///
  /// In en, this message translates to:
  /// **'That file isn\'t an export from Hevy, Strong or FitNotes'**
  String get importUnknownFormat;

  /// No description provided for @importZipNoWeights.
  ///
  /// In en, this message translates to:
  /// **'That zip has no weight file in it'**
  String get importZipNoWeights;

  /// No description provided for @importWeights.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{Imported {n} weigh-in} other{Imported {n} weigh-ins}}'**
  String importWeights(int n);

  /// No description provided for @importReadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read that file'**
  String get importReadFailed;

  /// No description provided for @importUnitTitle.
  ///
  /// In en, this message translates to:
  /// **'Which unit is that file in?'**
  String get importUnitTitle;

  /// No description provided for @importUnitBody.
  ///
  /// In en, this message translates to:
  /// **'This export doesn\'t say which unit the weights are in.'**
  String get importUnitBody;

  /// No description provided for @importNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing new to import'**
  String get importNothing;

  /// No description provided for @importDone.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{Imported {n} session} other{Imported {n} sessions}}'**
  String importDone(int n);

  /// No description provided for @aboutGymmane.
  ///
  /// In en, this message translates to:
  /// **'About GymMane'**
  String get aboutGymmane;

  /// No description provided for @yourProfile.
  ///
  /// In en, this message translates to:
  /// **'YOUR PROFILE'**
  String get yourProfile;

  /// No description provided for @autofills.
  ///
  /// In en, this message translates to:
  /// **'Autofills the calculators'**
  String get autofills;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'NAME'**
  String get nameLabel;

  /// No description provided for @sexLabel.
  ///
  /// In en, this message translates to:
  /// **'SEX'**
  String get sexLabel;

  /// No description provided for @macroProtein.
  ///
  /// In en, this message translates to:
  /// **'PROTEIN'**
  String get macroProtein;

  /// No description provided for @macroCarbs.
  ///
  /// In en, this message translates to:
  /// **'CARBS'**
  String get macroCarbs;

  /// No description provided for @macroFat.
  ///
  /// In en, this message translates to:
  /// **'FAT'**
  String get macroFat;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @ageLabel.
  ///
  /// In en, this message translates to:
  /// **'AGE'**
  String get ageLabel;

  /// No description provided for @heightLabel.
  ///
  /// In en, this message translates to:
  /// **'HEIGHT'**
  String get heightLabel;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT'**
  String get weightLabel;

  /// No description provided for @weeklyGoal.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY GOAL'**
  String get weeklyGoal;

  /// No description provided for @activityLabel.
  ///
  /// In en, this message translates to:
  /// **'ACTIVITY'**
  String get activityLabel;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get addPhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseGallery;

  /// No description provided for @backupCopied.
  ///
  /// In en, this message translates to:
  /// **'Backup copied to clipboard'**
  String get backupCopied;

  /// No description provided for @backupImported.
  ///
  /// In en, this message translates to:
  /// **'Backup imported'**
  String get backupImported;

  /// No description provided for @backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read that backup'**
  String get backupFailed;

  /// No description provided for @nothingToExport.
  ///
  /// In en, this message translates to:
  /// **'Nothing to export yet — log a session first'**
  String get nothingToExport;

  /// No description provided for @athlete.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get athlete;

  /// No description provided for @calculatorsCount.
  ///
  /// In en, this message translates to:
  /// **'{n} calculators for your training'**
  String calculatorsCount(int n);

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'RESULT'**
  String get result;

  /// No description provided for @weightLifted.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT LIFTED'**
  String get weightLifted;

  /// No description provided for @repsPerformed.
  ///
  /// In en, this message translates to:
  /// **'REPS PERFORMED'**
  String get repsPerformed;

  /// No description provided for @neck.
  ///
  /// In en, this message translates to:
  /// **'NECK'**
  String get neck;

  /// No description provided for @waist.
  ///
  /// In en, this message translates to:
  /// **'WAIST'**
  String get waist;

  /// No description provided for @hip.
  ///
  /// In en, this message translates to:
  /// **'HIP (for women)'**
  String get hip;

  /// No description provided for @targetWeight.
  ///
  /// In en, this message translates to:
  /// **'TARGET WEIGHT'**
  String get targetWeight;

  /// No description provided for @workingWeight.
  ///
  /// In en, this message translates to:
  /// **'WORKING WEIGHT'**
  String get workingWeight;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'ACTIVITY LEVEL'**
  String get activityLevel;

  /// No description provided for @barWeight.
  ///
  /// In en, this message translates to:
  /// **'BAR WEIGHT'**
  String get barWeight;

  /// No description provided for @perSide.
  ///
  /// In en, this message translates to:
  /// **'PER SIDE'**
  String get perSide;

  /// No description provided for @justTheBar.
  ///
  /// In en, this message translates to:
  /// **'Just the bar.'**
  String get justTheBar;

  /// No description provided for @perSideCount.
  ///
  /// In en, this message translates to:
  /// **'× {n} per side'**
  String perSideCount(int n);

  /// No description provided for @rampSet.
  ///
  /// In en, this message translates to:
  /// **'{pct} · {reps} reps'**
  String rampSet(String pct, int reps);

  /// No description provided for @toolNameRm.
  ///
  /// In en, this message translates to:
  /// **'1RM'**
  String get toolNameRm;

  /// No description provided for @toolNameBmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get toolNameBmi;

  /// No description provided for @toolNameCal.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get toolNameCal;

  /// No description provided for @toolNameBf.
  ///
  /// In en, this message translates to:
  /// **'Body Fat'**
  String get toolNameBf;

  /// No description provided for @toolNamePlate.
  ///
  /// In en, this message translates to:
  /// **'Plates'**
  String get toolNamePlate;

  /// No description provided for @toolNameWarmup.
  ///
  /// In en, this message translates to:
  /// **'Warm-up'**
  String get toolNameWarmup;

  /// No description provided for @toolTitleRm.
  ///
  /// In en, this message translates to:
  /// **'1RM Calculator'**
  String get toolTitleRm;

  /// No description provided for @toolTitleBmi.
  ///
  /// In en, this message translates to:
  /// **'BMI Calculator'**
  String get toolTitleBmi;

  /// No description provided for @toolTitleCal.
  ///
  /// In en, this message translates to:
  /// **'Calories & Macros'**
  String get toolTitleCal;

  /// No description provided for @toolTitleBf.
  ///
  /// In en, this message translates to:
  /// **'Body Fat %'**
  String get toolTitleBf;

  /// No description provided for @toolTitlePlate.
  ///
  /// In en, this message translates to:
  /// **'Plate Calculator'**
  String get toolTitlePlate;

  /// No description provided for @toolTitleWarmup.
  ///
  /// In en, this message translates to:
  /// **'Warm-up Sets'**
  String get toolTitleWarmup;

  /// No description provided for @toolHintRm.
  ///
  /// In en, this message translates to:
  /// **'Estimated 1-rep max (Epley formula)'**
  String get toolHintRm;

  /// No description provided for @toolHintCal.
  ///
  /// In en, this message translates to:
  /// **'Estimated daily maintenance'**
  String get toolHintCal;

  /// No description provided for @toolHintBf.
  ///
  /// In en, this message translates to:
  /// **'US Navy method estimate'**
  String get toolHintBf;

  /// No description provided for @toolHintPlate.
  ///
  /// In en, this message translates to:
  /// **'Total barbell weight'**
  String get toolHintPlate;

  /// No description provided for @toolHintWarmup.
  ///
  /// In en, this message translates to:
  /// **'Working weight target'**
  String get toolHintWarmup;

  /// No description provided for @toolDescRm.
  ///
  /// In en, this message translates to:
  /// **'Estimated one-rep max'**
  String get toolDescRm;

  /// No description provided for @toolDescBmi.
  ///
  /// In en, this message translates to:
  /// **'Body mass index'**
  String get toolDescBmi;

  /// No description provided for @toolDescCal.
  ///
  /// In en, this message translates to:
  /// **'Calories & macros'**
  String get toolDescCal;

  /// No description provided for @toolDescBf.
  ///
  /// In en, this message translates to:
  /// **'Body fat percentage'**
  String get toolDescBf;

  /// No description provided for @toolDescPlate.
  ///
  /// In en, this message translates to:
  /// **'Barbell plate calculator'**
  String get toolDescPlate;

  /// No description provided for @toolDescWarmup.
  ///
  /// In en, this message translates to:
  /// **'Ramp-up sets'**
  String get toolDescWarmup;

  /// No description provided for @bmiUnderweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiUnderweight;

  /// No description provided for @bmiNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get bmiNormal;

  /// No description provided for @bmiOverweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiOverweight;

  /// No description provided for @bmiObese.
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get bmiObese;

  /// No description provided for @actSedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get actSedentary;

  /// No description provided for @actLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get actLight;

  /// No description provided for @actActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get actActive;

  /// No description provided for @actModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get actModerate;

  /// No description provided for @muscleChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get muscleChest;

  /// No description provided for @muscleBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get muscleBack;

  /// No description provided for @muscleShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get muscleShoulders;

  /// No description provided for @muscleBiceps.
  ///
  /// In en, this message translates to:
  /// **'Biceps'**
  String get muscleBiceps;

  /// No description provided for @muscleTriceps.
  ///
  /// In en, this message translates to:
  /// **'Triceps'**
  String get muscleTriceps;

  /// No description provided for @muscleForearm.
  ///
  /// In en, this message translates to:
  /// **'Forearm'**
  String get muscleForearm;

  /// No description provided for @muscleTrapezius.
  ///
  /// In en, this message translates to:
  /// **'Trapezius'**
  String get muscleTrapezius;

  /// No description provided for @muscleAbdomen.
  ///
  /// In en, this message translates to:
  /// **'Abdomen'**
  String get muscleAbdomen;

  /// No description provided for @muscleObliques.
  ///
  /// In en, this message translates to:
  /// **'Obliques'**
  String get muscleObliques;

  /// No description provided for @muscleQuads.
  ///
  /// In en, this message translates to:
  /// **'Quads'**
  String get muscleQuads;

  /// No description provided for @muscleHamstrings.
  ///
  /// In en, this message translates to:
  /// **'Hamstrings'**
  String get muscleHamstrings;

  /// No description provided for @muscleGlutes.
  ///
  /// In en, this message translates to:
  /// **'Glutes'**
  String get muscleGlutes;

  /// No description provided for @muscleCalves.
  ///
  /// In en, this message translates to:
  /// **'Calves'**
  String get muscleCalves;

  /// No description provided for @mgChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get mgChest;

  /// No description provided for @mgBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get mgBack;

  /// No description provided for @mgLegs.
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get mgLegs;

  /// No description provided for @mgShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get mgShoulders;

  /// No description provided for @mgArms.
  ///
  /// In en, this message translates to:
  /// **'Arms'**
  String get mgArms;

  /// No description provided for @mgCore.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get mgCore;

  /// No description provided for @equipBarbell.
  ///
  /// In en, this message translates to:
  /// **'Barbell'**
  String get equipBarbell;

  /// No description provided for @equipDumbbell.
  ///
  /// In en, this message translates to:
  /// **'Dumbbell'**
  String get equipDumbbell;

  /// No description provided for @equipCable.
  ///
  /// In en, this message translates to:
  /// **'Cable'**
  String get equipCable;

  /// No description provided for @equipMachine.
  ///
  /// In en, this message translates to:
  /// **'Machine'**
  String get equipMachine;

  /// No description provided for @equipBodyweight.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight'**
  String get equipBodyweight;

  /// No description provided for @equipWeighted.
  ///
  /// In en, this message translates to:
  /// **'Weighted'**
  String get equipWeighted;

  /// No description provided for @equipBand.
  ///
  /// In en, this message translates to:
  /// **'Band'**
  String get equipBand;

  /// No description provided for @equipKettlebell.
  ///
  /// In en, this message translates to:
  /// **'Kettlebell'**
  String get equipKettlebell;

  /// No description provided for @equipOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get equipOther;

  /// No description provided for @diffBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get diffBeginner;

  /// No description provided for @diffAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get diffAdvanced;

  /// No description provided for @diffIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get diffIntermediate;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {v}'**
  String version(String v);

  /// No description provided for @aboutBlurb.
  ///
  /// In en, this message translates to:
  /// **'Built by lifters, for lifters.'**
  String get aboutBlurb;

  /// No description provided for @freeForever.
  ///
  /// In en, this message translates to:
  /// **'Free forever'**
  String get freeForever;

  /// No description provided for @freeForeverWhy.
  ///
  /// In en, this message translates to:
  /// **'No subscription, no ads, nothing locked behind a paywall.'**
  String get freeForeverWhy;

  /// No description provided for @fullyOffline.
  ///
  /// In en, this message translates to:
  /// **'Fully offline'**
  String get fullyOffline;

  /// No description provided for @fullyOfflineWhy.
  ///
  /// In en, this message translates to:
  /// **'No account, no servers. Your training never leaves this phone.'**
  String get fullyOfflineWhy;

  /// No description provided for @yoursToTake.
  ///
  /// In en, this message translates to:
  /// **'Your data is yours'**
  String get yoursToTake;

  /// No description provided for @yoursToTakeWhy.
  ///
  /// In en, this message translates to:
  /// **'Export it to CSV whenever you like, and delete it all in one tap.'**
  String get yoursToTakeWhy;

  /// No description provided for @whatsInside.
  ///
  /// In en, this message translates to:
  /// **'WHAT\'S INSIDE'**
  String get whatsInside;

  /// No description provided for @exercisesInside.
  ///
  /// In en, this message translates to:
  /// **'{n} exercises'**
  String exercisesInside(int n);

  /// No description provided for @exercisesInsideWhy.
  ///
  /// In en, this message translates to:
  /// **'Every one with an animation and step-by-step instructions.'**
  String get exercisesInsideWhy;

  /// No description provided for @calculatorsInside.
  ///
  /// In en, this message translates to:
  /// **'6 calculators'**
  String get calculatorsInside;

  /// No description provided for @calculatorsInsideWhy.
  ///
  /// In en, this message translates to:
  /// **'1RM, plates, BMI, calories, body fat and warm-up — all with published formulas.'**
  String get calculatorsInsideWhy;

  /// No description provided for @mathInside.
  ///
  /// In en, this message translates to:
  /// **'Honest maths'**
  String get mathInside;

  /// No description provided for @mathInsideWhy.
  ///
  /// In en, this message translates to:
  /// **'Volume, records and streaks come from your own sets. Nothing here is decoration.'**
  String get mathInsideWhy;

  /// No description provided for @yourNumbers.
  ///
  /// In en, this message translates to:
  /// **'YOUR NUMBERS'**
  String get yourNumbers;

  /// No description provided for @sessionsCaps.
  ///
  /// In en, this message translates to:
  /// **'SESSIONS'**
  String get sessionsCaps;

  /// No description provided for @liftedCaps.
  ///
  /// In en, this message translates to:
  /// **'LIFTED'**
  String get liftedCaps;

  /// No description provided for @streakCaps.
  ///
  /// In en, this message translates to:
  /// **'STREAK'**
  String get streakCaps;

  /// No description provided for @daysUnit.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{day} other{days}}'**
  String daysUnit(int n);

  /// No description provided for @restDefaultLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest timer'**
  String get restDefaultLabel;

  /// No description provided for @restDefault.
  ///
  /// In en, this message translates to:
  /// **'Default is {s}s — change it in Settings'**
  String restDefault(int s);

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'RESET'**
  String get reset;

  /// No description provided for @welcomeKicker.
  ///
  /// In en, this message translates to:
  /// **'WELCOME TO'**
  String get welcomeKicker;

  /// No description provided for @welcomeBlurb.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on your phone. No account, no internet, nothing to pay.'**
  String get welcomeBlurb;

  /// No description provided for @welcomeStart.
  ///
  /// In en, this message translates to:
  /// **'GET STARTED'**
  String get welcomeStart;

  /// No description provided for @onbStep.
  ///
  /// In en, this message translates to:
  /// **'STEP {i} OF {n}'**
  String onbStep(int i, int n);

  /// No description provided for @onbNameTitle.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get onbNameTitle;

  /// No description provided for @onbNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get onbNameHint;

  /// No description provided for @onbNameWhy.
  ///
  /// In en, this message translates to:
  /// **'Only used to greet you. It never leaves the phone.'**
  String get onbNameWhy;

  /// No description provided for @onbBodyTitle.
  ///
  /// In en, this message translates to:
  /// **'A few numbers'**
  String get onbBodyTitle;

  /// No description provided for @onbBodyWhy.
  ///
  /// In en, this message translates to:
  /// **'They feed the calculators. You can change them any time in Settings.'**
  String get onbBodyWhy;

  /// No description provided for @onbGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'How often do you train?'**
  String get onbGoalTitle;

  /// No description provided for @onbGoalWhy.
  ///
  /// In en, this message translates to:
  /// **'Sets your weekly goal ring. Be honest, not ambitious.'**
  String get onbGoalWhy;

  /// No description provided for @perWeek.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} session a week} other{{n} sessions a week}}'**
  String perWeek(int n);

  /// No description provided for @onbUnitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Kilos or pounds?'**
  String get onbUnitsTitle;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get back;

  /// No description provided for @skip2.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip2;

  /// No description provided for @madeWithLoveBy.
  ///
  /// In en, this message translates to:
  /// **'MADE WITH LOVE BY'**
  String get madeWithLoveBy;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'SOURCE CODE'**
  String get sourceCode;

  /// No description provided for @suggested.
  ///
  /// In en, this message translates to:
  /// **'SUGGESTED'**
  String get suggested;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'RESULTS'**
  String get results;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No exercise matches that search.'**
  String get noMatches;

  /// No description provided for @tapToEdit.
  ///
  /// In en, this message translates to:
  /// **'Tap the pencil to fix an entry, or the bin to remove it.'**
  String get tapToEdit;

  /// No description provided for @editEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editEntry;

  /// No description provided for @editEntryHint.
  ///
  /// In en, this message translates to:
  /// **'Fix the reps or the weight of any set.'**
  String get editEntryHint;

  /// No description provided for @removeSet.
  ///
  /// In en, this message translates to:
  /// **'Remove set'**
  String get removeSet;

  /// No description provided for @continueWorkout.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueWorkout;

  /// No description provided for @continueWorkoutBody.
  ///
  /// In en, this message translates to:
  /// **'The workout goes back to being in progress, with its sets already ticked. Finishing it again saves it on its original day.'**
  String get continueWorkoutBody;

  /// No description provided for @addBodyWidget.
  ///
  /// In en, this message translates to:
  /// **'Add muscle map widget'**
  String get addBodyWidget;

  /// No description provided for @repsOnly.
  ///
  /// In en, this message translates to:
  /// **'Reps only'**
  String get repsOnly;

  /// No description provided for @repsOnlyHint.
  ///
  /// In en, this message translates to:
  /// **'Log this exercise without weight.'**
  String get repsOnlyHint;

  /// No description provided for @useDefaultArt.
  ///
  /// In en, this message translates to:
  /// **'Back to the default art'**
  String get useDefaultArt;

  /// No description provided for @daysShort.
  ///
  /// In en, this message translates to:
  /// **'{n}d'**
  String daysShort(int n);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
