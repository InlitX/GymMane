import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
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
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
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

  /// No description provided for @setDone.
  ///
  /// In en, this message translates to:
  /// **'SET DONE'**
  String get setDone;

  /// No description provided for @nextExercise.
  ///
  /// In en, this message translates to:
  /// **'NEXT EXERCISE'**
  String get nextExercise;

  /// No description provided for @dropExerciseAction.
  ///
  /// In en, this message translates to:
  /// **'Drop exercise'**
  String get dropExerciseAction;

  /// No description provided for @restOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get restOff;

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

  /// No description provided for @allTimeSets.
  ///
  /// In en, this message translates to:
  /// **'SETS'**
  String get allTimeSets;

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

  /// No description provided for @personalRecords.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL RECORDS'**
  String get personalRecords;

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

  /// No description provided for @kindLabel.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get kindLabel;

  /// No description provided for @kindStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get kindStrength;

  /// No description provided for @kindCalisthenics.
  ///
  /// In en, this message translates to:
  /// **'Calisthenics'**
  String get kindCalisthenics;

  /// No description provided for @kindCardio.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get kindCardio;

  /// No description provided for @kindStretch.
  ///
  /// In en, this message translates to:
  /// **'Stretching'**
  String get kindStretch;

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

  /// No description provided for @timelineEvery.
  ///
  /// In en, this message translates to:
  /// **'GROUP EVERY'**
  String get timelineEvery;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

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
  /// **'Drag the dotted handle to reorder — this is the order you train in.'**
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
  /// **'That file needs date, exercise, reps and weight columns'**
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

  /// No description provided for @muscleLowerBack.
  ///
  /// In en, this message translates to:
  /// **'Lower back'**
  String get muscleLowerBack;

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

  /// No description provided for @equipRings.
  ///
  /// In en, this message translates to:
  /// **'Rings'**
  String get equipRings;

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
  /// **'10 calculators'**
  String get calculatorsInside;

  /// No description provided for @calculatorsInsideWhy.
  ///
  /// In en, this message translates to:
  /// **'1RM, plates, BMI, calories, body fat, FFMI, warm-up, RPE load, and DOTS and Wilks strength scores — all with published formulas.'**
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

  /// No description provided for @focusCard.
  ///
  /// In en, this message translates to:
  /// **'Today’s focus'**
  String get focusCard;

  /// No description provided for @autoAdvance.
  ///
  /// In en, this message translates to:
  /// **'Move on automatically'**
  String get autoAdvance;

  /// No description provided for @keepScreenOn.
  ///
  /// In en, this message translates to:
  /// **'Keep the screen on while training'**
  String get keepScreenOn;

  /// No description provided for @lockWorkout.
  ///
  /// In en, this message translates to:
  /// **'Lock the screen'**
  String get lockWorkout;

  /// No description provided for @unlockWorkout.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlockWorkout;

  /// No description provided for @holdToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Hold to unlock'**
  String get holdToUnlock;

  /// No description provided for @liveChannel.
  ///
  /// In en, this message translates to:
  /// **'Ongoing workout'**
  String get liveChannel;

  /// No description provided for @liveChannelWhy.
  ///
  /// In en, this message translates to:
  /// **'Shows the current exercise, set and rest timer while you train'**
  String get liveChannelWhy;

  /// No description provided for @liveSet.
  ///
  /// In en, this message translates to:
  /// **'Set {n} of {total}'**
  String liveSet(int n, int total);

  /// No description provided for @liveResting.
  ///
  /// In en, this message translates to:
  /// **'Resting'**
  String get liveResting;

  /// No description provided for @liveAllDone.
  ///
  /// In en, this message translates to:
  /// **'All sets done'**
  String get liveAllDone;

  /// No description provided for @autoAdvanceHint.
  ///
  /// In en, this message translates to:
  /// **'When the last set of an exercise is ticked, the workout moves on.'**
  String get autoAdvanceHint;

  /// No description provided for @autoProgress.
  ///
  /// In en, this message translates to:
  /// **'Add weight next time'**
  String get autoProgress;

  /// No description provided for @autoProgressHint.
  ///
  /// In en, this message translates to:
  /// **'Hit every rep and the next session starts {w} heavier.'**
  String autoProgressHint(String w);

  /// No description provided for @placePlates.
  ///
  /// In en, this message translates to:
  /// **'Plates and bar'**
  String get placePlates;

  /// No description provided for @platesAll.
  ///
  /// In en, this message translates to:
  /// **'Everything available'**
  String get platesAll;

  /// No description provided for @platesOwned.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} size} other{{n} sizes}}'**
  String platesOwned(int n);

  /// No description provided for @platePairs.
  ///
  /// In en, this message translates to:
  /// **'PAIRS'**
  String get platePairs;

  /// No description provided for @plateAchievable.
  ///
  /// In en, this message translates to:
  /// **'Closest you can load: {w}'**
  String plateAchievable(String w);

  /// No description provided for @autoWarmup.
  ///
  /// In en, this message translates to:
  /// **'Start with warm-up sets'**
  String get autoWarmup;

  /// No description provided for @autoWarmupHint.
  ///
  /// In en, this message translates to:
  /// **'Adds the ramp-up sets when the workout opens.'**
  String get autoWarmupHint;

  /// No description provided for @trainReminder.
  ///
  /// In en, this message translates to:
  /// **'Training reminder'**
  String get trainReminder;

  /// No description provided for @trainReminderHint.
  ///
  /// In en, this message translates to:
  /// **'A nudge at this time, only on the days your routine is planned.'**
  String get trainReminderHint;

  /// No description provided for @reminderExactTime.
  ///
  /// In en, this message translates to:
  /// **'Exact time'**
  String get reminderExactTime;

  /// No description provided for @toastSoundSetting.
  ///
  /// In en, this message translates to:
  /// **'Notice sound'**
  String get toastSoundSetting;

  /// No description provided for @toastSoundHint.
  ///
  /// In en, this message translates to:
  /// **'A soft chime when a notice pops up at the top.'**
  String get toastSoundHint;

  /// No description provided for @notifTrainChannel.
  ///
  /// In en, this message translates to:
  /// **'Training reminder'**
  String get notifTrainChannel;

  /// No description provided for @notifTrainChannelWhy.
  ///
  /// In en, this message translates to:
  /// **'A nudge to train on the days you planned.'**
  String get notifTrainChannelWhy;

  /// No description provided for @notifTrainTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to train'**
  String get notifTrainTitle;

  /// No description provided for @notifTrainBody.
  ///
  /// In en, this message translates to:
  /// **'Your routine is waiting.'**
  String get notifTrainBody;

  /// No description provided for @planIntro.
  ///
  /// In en, this message translates to:
  /// **'Build me a training routine using only the exercises in this list.'**
  String get planIntro;

  /// No description provided for @planFormat.
  ///
  /// In en, this message translates to:
  /// **'Answer with JSON only, in this shape:'**
  String get planFormat;

  /// No description provided for @planNothing.
  ///
  /// In en, this message translates to:
  /// **'No exercise in that file matched your library'**
  String get planNothing;

  /// No description provided for @planFailed.
  ///
  /// In en, this message translates to:
  /// **'That file is not a routine we can read'**
  String get planFailed;

  /// No description provided for @routineGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get routineGroup;

  /// No description provided for @newGroup.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get newGroup;

  /// No description provided for @noGroup.
  ///
  /// In en, this message translates to:
  /// **'No group'**
  String get noGroup;

  /// No description provided for @groupNameHint.
  ///
  /// In en, this message translates to:
  /// **'Push / Pull / Legs, 5×5…'**
  String get groupNameHint;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @setsPlannedHint.
  ///
  /// In en, this message translates to:
  /// **'Pick how many sets you want of each one. The workout opens with them ready.'**
  String get setsPlannedHint;

  /// No description provided for @nextTime.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get nextTime;

  /// No description provided for @nextHold.
  ///
  /// In en, this message translates to:
  /// **'same weight until you hit every rep'**
  String get nextHold;

  /// No description provided for @bgPhoto.
  ///
  /// In en, this message translates to:
  /// **'Your photo'**
  String get bgPhoto;

  /// No description provided for @bgPhotoPick.
  ///
  /// In en, this message translates to:
  /// **'Choose a photo'**
  String get bgPhotoPick;

  /// No description provided for @bgPhotoChange.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get bgPhotoChange;

  /// No description provided for @bgPhotoRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get bgPhotoRemove;

  /// No description provided for @bgDim.
  ///
  /// In en, this message translates to:
  /// **'HOW DARK'**
  String get bgDim;

  /// No description provided for @dimSoft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get dimSoft;

  /// No description provided for @dimMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get dimMedium;

  /// No description provided for @dimStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get dimStrong;

  /// No description provided for @bgPhotoHint.
  ///
  /// In en, this message translates to:
  /// **'It sits behind everything, dimmed so the app stays readable.'**
  String get bgPhotoHint;

  /// No description provided for @reminderSmart.
  ///
  /// In en, this message translates to:
  /// **'Smart'**
  String get reminderSmart;

  /// No description provided for @reminderFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed time'**
  String get reminderFixed;

  /// No description provided for @reminderSmartHint.
  ///
  /// In en, this message translates to:
  /// **'It uses the days and the time you actually train, and stays quiet on a day you already trained.'**
  String get reminderSmartHint;

  /// No description provided for @reminderSmartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Log a few more sessions and it will learn your days.'**
  String get reminderSmartEmpty;

  /// No description provided for @habitFocus.
  ///
  /// In en, this message translates to:
  /// **'what you usually train on {day}'**
  String habitFocus(String day);

  /// No description provided for @duplicateRoutine.
  ///
  /// In en, this message translates to:
  /// **'Duplicate routine'**
  String get duplicateRoutine;

  /// No description provided for @copySuffix.
  ///
  /// In en, this message translates to:
  /// **'{name} (copy)'**
  String copySuffix(String name);

  /// No description provided for @saveAsRoutine.
  ///
  /// In en, this message translates to:
  /// **'SAVE AS A ROUTINE'**
  String get saveAsRoutine;

  /// No description provided for @savedAsRoutine.
  ///
  /// In en, this message translates to:
  /// **'Saved as a routine'**
  String get savedAsRoutine;

  /// No description provided for @templates.
  ///
  /// In en, this message translates to:
  /// **'Ready-made plans'**
  String get templates;

  /// No description provided for @templatesHint.
  ///
  /// In en, this message translates to:
  /// **'Classic programmes, built from your own library. You can change anything afterwards.'**
  String get templatesHint;

  /// No description provided for @templateAdded.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} routine added} other{{n} routines added}}'**
  String templateAdded(int n);

  /// No description provided for @tplFullbody.
  ///
  /// In en, this message translates to:
  /// **'Three full-body days a week. The one to start with.'**
  String get tplFullbody;

  /// No description provided for @tplPpl.
  ///
  /// In en, this message translates to:
  /// **'Push, pull and legs. Three or six days a week.'**
  String get tplPpl;

  /// No description provided for @tplUpperlower.
  ///
  /// In en, this message translates to:
  /// **'Upper and lower body, four days a week.'**
  String get tplUpperlower;

  /// No description provided for @tplStronglifts.
  ///
  /// In en, this message translates to:
  /// **'Two workouts, five sets of five, alternating.'**
  String get tplStronglifts;

  /// No description provided for @tplStartingstrength.
  ///
  /// In en, this message translates to:
  /// **'Squat every session, two alternating workouts.'**
  String get tplStartingstrength;

  /// No description provided for @tplHome.
  ///
  /// In en, this message translates to:
  /// **'Nothing but a bar to hang from and the floor.'**
  String get tplHome;

  /// No description provided for @dayCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} day} other{{n} days}}'**
  String dayCount(int n);

  /// No description provided for @logRpe.
  ///
  /// In en, this message translates to:
  /// **'Log effort (RPE)'**
  String get logRpe;

  /// No description provided for @rpeHint.
  ///
  /// In en, this message translates to:
  /// **'10 is nothing left in the tank, 8 is two reps to spare.'**
  String get rpeHint;

  /// No description provided for @superset.
  ///
  /// In en, this message translates to:
  /// **'Superset'**
  String get superset;

  /// No description provided for @supersetLink.
  ///
  /// In en, this message translates to:
  /// **'Chain with the next one'**
  String get supersetLink;

  /// No description provided for @supersetHint.
  ///
  /// In en, this message translates to:
  /// **'No rest between chained exercises — you go straight to the next one.'**
  String get supersetHint;

  /// No description provided for @aiRoutine.
  ///
  /// In en, this message translates to:
  /// **'Routine with AI'**
  String get aiRoutine;

  /// No description provided for @aiIntro.
  ///
  /// In en, this message translates to:
  /// **'GymMane never talks to an AI. You take your exercise list out, you paste it into whatever assistant you already use, and you bring its answer back in. Nothing leaves the phone on its own.'**
  String get aiIntro;

  /// No description provided for @aiMissing.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 name was not in your library} other{{n} names were not in your library}}'**
  String aiMissing(int n);

  /// No description provided for @importApps.
  ///
  /// In en, this message translates to:
  /// **'Which apps it reads'**
  String get importApps;

  /// No description provided for @importOtherCsv.
  ///
  /// In en, this message translates to:
  /// **'Any other CSV with date, exercise, reps and weight'**
  String get importOtherCsv;

  /// No description provided for @importAskApp.
  ///
  /// In en, this message translates to:
  /// **'Need another app? Ask for it'**
  String get importAskApp;

  /// No description provided for @awardFirstStepName.
  ///
  /// In en, this message translates to:
  /// **'First step'**
  String get awardFirstStepName;

  /// No description provided for @awardFirstStepLine.
  ///
  /// In en, this message translates to:
  /// **'Welcome to GymMane. This one is on the house.'**
  String get awardFirstStepLine;

  /// No description provided for @awardFirstWorkoutName.
  ///
  /// In en, this message translates to:
  /// **'First workout'**
  String get awardFirstWorkoutName;

  /// No description provided for @awardFirstWorkoutLine.
  ///
  /// In en, this message translates to:
  /// **'The first one is logged. That is the hard one.'**
  String get awardFirstWorkoutLine;

  /// No description provided for @awardFirstRoutineName.
  ///
  /// In en, this message translates to:
  /// **'First routine'**
  String get awardFirstRoutineName;

  /// No description provided for @awardFirstRoutineLine.
  ///
  /// In en, this message translates to:
  /// **'You have a plan to come back to.'**
  String get awardFirstRoutineLine;

  /// No description provided for @awardFirstRecordName.
  ///
  /// In en, this message translates to:
  /// **'First record'**
  String get awardFirstRecordName;

  /// No description provided for @awardFirstRecordLine.
  ///
  /// In en, this message translates to:
  /// **'You beat your best lift on an exercise.'**
  String get awardFirstRecordLine;

  /// No description provided for @awardStreak3Name.
  ///
  /// In en, this message translates to:
  /// **'Three in a row'**
  String get awardStreak3Name;

  /// No description provided for @awardStreak3Line.
  ///
  /// In en, this message translates to:
  /// **'Three days straight. This is how it starts.'**
  String get awardStreak3Line;

  /// No description provided for @awardTonne1Name.
  ///
  /// In en, this message translates to:
  /// **'One tonne'**
  String get awardTonne1Name;

  /// No description provided for @awardTonne1Line.
  ///
  /// In en, this message translates to:
  /// **'A thousand kilos lifted across your sets.'**
  String get awardTonne1Line;

  /// No description provided for @awardSets100Name.
  ///
  /// In en, this message translates to:
  /// **'One hundred sets'**
  String get awardSets100Name;

  /// No description provided for @awardSets100Line.
  ///
  /// In en, this message translates to:
  /// **'A hundred sets finished, one at a time.'**
  String get awardSets100Line;

  /// No description provided for @awardHours10Name.
  ///
  /// In en, this message translates to:
  /// **'Ten hours'**
  String get awardHours10Name;

  /// No description provided for @awardHours10Line.
  ///
  /// In en, this message translates to:
  /// **'Ten hours of training on the clock.'**
  String get awardHours10Line;

  /// No description provided for @awardWorkouts50Name.
  ///
  /// In en, this message translates to:
  /// **'Fifty workouts'**
  String get awardWorkouts50Name;

  /// No description provided for @awardWorkouts50Line.
  ///
  /// In en, this message translates to:
  /// **'Fifty sessions behind you.'**
  String get awardWorkouts50Line;

  /// No description provided for @awardHours50Name.
  ///
  /// In en, this message translates to:
  /// **'Fifty hours'**
  String get awardHours50Name;

  /// No description provided for @awardHours50Line.
  ///
  /// In en, this message translates to:
  /// **'Fifty hours inside the gym.'**
  String get awardHours50Line;

  /// No description provided for @awardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medals'**
  String get awardsTitle;

  /// No description provided for @yearTitle.
  ///
  /// In en, this message translates to:
  /// **'Your year'**
  String get yearTitle;

  /// No description provided for @yearBestMonth.
  ///
  /// In en, this message translates to:
  /// **'Best month'**
  String get yearBestMonth;

  /// No description provided for @yearMonths.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get yearMonths;

  /// No description provided for @awardSpinHint.
  ///
  /// In en, this message translates to:
  /// **'Drag the medal to spin it'**
  String get awardSpinHint;

  /// No description provided for @awardUnlocked.
  ///
  /// In en, this message translates to:
  /// **'New achievement unlocked'**
  String get awardUnlocked;

  /// No description provided for @awardNice.
  ///
  /// In en, this message translates to:
  /// **'Awesome!'**
  String get awardNice;

  /// No description provided for @awardSaveImage.
  ///
  /// In en, this message translates to:
  /// **'Save image'**
  String get awardSaveImage;

  /// No description provided for @awardSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to your gallery'**
  String get awardSaved;

  /// No description provided for @awardStreak7Name.
  ///
  /// In en, this message translates to:
  /// **'Seven days'**
  String get awardStreak7Name;

  /// No description provided for @awardStreak7Line.
  ///
  /// In en, this message translates to:
  /// **'A full week without missing a day.'**
  String get awardStreak7Line;

  /// No description provided for @awardStreak30Name.
  ///
  /// In en, this message translates to:
  /// **'Thirty days'**
  String get awardStreak30Name;

  /// No description provided for @awardStreak30Line.
  ///
  /// In en, this message translates to:
  /// **'A month straight. This is a habit now.'**
  String get awardStreak30Line;

  /// No description provided for @awardWorkouts100Name.
  ///
  /// In en, this message translates to:
  /// **'One hundred workouts'**
  String get awardWorkouts100Name;

  /// No description provided for @awardWorkouts100Line.
  ///
  /// In en, this message translates to:
  /// **'A hundred sessions logged, start to finish.'**
  String get awardWorkouts100Line;

  /// No description provided for @awardTonnes100Name.
  ///
  /// In en, this message translates to:
  /// **'One hundred tonnes'**
  String get awardTonnes100Name;

  /// No description provided for @awardTonnes100Line.
  ///
  /// In en, this message translates to:
  /// **'Everything you have lifted adds up to 100,000 kg.'**
  String get awardTonnes100Line;

  /// No description provided for @awardSets1000Name.
  ///
  /// In en, this message translates to:
  /// **'A thousand sets'**
  String get awardSets1000Name;

  /// No description provided for @awardSets1000Line.
  ///
  /// In en, this message translates to:
  /// **'One set at a time, a thousand of them.'**
  String get awardSets1000Line;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @pickBadge.
  ///
  /// In en, this message translates to:
  /// **'Badge'**
  String get pickBadge;

  /// No description provided for @statWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get statWorkouts;

  /// No description provided for @statTrained.
  ///
  /// In en, this message translates to:
  /// **'Trained'**
  String get statTrained;

  /// No description provided for @statSets.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get statSets;

  /// No description provided for @statLifted.
  ///
  /// In en, this message translates to:
  /// **'Lifted'**
  String get statLifted;

  /// No description provided for @statStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get statStreak;

  /// No description provided for @statDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get statDays;

  /// No description provided for @unitHours.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get unitHours;

  /// No description provided for @unitDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get unitDays;

  /// No description provided for @snapshots.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get snapshots;

  /// No description provided for @snapNow.
  ///
  /// In en, this message translates to:
  /// **'Take one'**
  String get snapNow;

  /// No description provided for @addCover.
  ///
  /// In en, this message translates to:
  /// **'Add a cover'**
  String get addCover;

  /// No description provided for @addTodayWidget.
  ///
  /// In en, this message translates to:
  /// **'Today done or not'**
  String get addTodayWidget;

  /// No description provided for @photosCard.
  ///
  /// In en, this message translates to:
  /// **'Your photos'**
  String get photosCard;

  /// No description provided for @handleLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get handleLabel;

  /// No description provided for @setupTitle.
  ///
  /// In en, this message translates to:
  /// **'Fill these in and the rest of the page fills itself'**
  String get setupTitle;

  /// No description provided for @setupHint.
  ///
  /// In en, this message translates to:
  /// **'Every number here comes from what you log. Nothing is sent anywhere.'**
  String get setupHint;

  /// No description provided for @setupWorkout.
  ///
  /// In en, this message translates to:
  /// **'Log your first workout'**
  String get setupWorkout;

  /// No description provided for @setupWeight.
  ///
  /// In en, this message translates to:
  /// **'Write down your body weight'**
  String get setupWeight;

  /// No description provided for @setupMeasures.
  ///
  /// In en, this message translates to:
  /// **'Take your measurements'**
  String get setupMeasures;

  /// No description provided for @setupPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take your first progress photo'**
  String get setupPhoto;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// No description provided for @tileVolume30.
  ///
  /// In en, this message translates to:
  /// **'Volume · 30d'**
  String get tileVolume30;

  /// No description provided for @tileAddWeight.
  ///
  /// In en, this message translates to:
  /// **'Add yours'**
  String get tileAddWeight;

  /// No description provided for @heatToneTitle.
  ///
  /// In en, this message translates to:
  /// **'Heat colour'**
  String get heatToneTitle;

  /// No description provided for @heatToneHint.
  ///
  /// In en, this message translates to:
  /// **'Only changes how the grid and the body are painted.'**
  String get heatToneHint;

  /// No description provided for @thisWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeekTitle;

  /// No description provided for @momentsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get momentsEmptyTitle;

  /// No description provided for @deletePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this photo?'**
  String get deletePhotoTitle;

  /// No description provided for @deletePhotoBody.
  ///
  /// In en, this message translates to:
  /// **'It goes for good.'**
  String get deletePhotoBody;

  /// No description provided for @awardsEarned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get awardsEarned;

  /// No description provided for @awardsLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get awardsLocked;

  /// No description provided for @awardStreak100Name.
  ///
  /// In en, this message translates to:
  /// **'One hundred days'**
  String get awardStreak100Name;

  /// No description provided for @awardWorkouts10Name.
  ///
  /// In en, this message translates to:
  /// **'Ten workouts'**
  String get awardWorkouts10Name;

  /// No description provided for @awardWorkouts10Line.
  ///
  /// In en, this message translates to:
  /// **'The first ten are the ones that decide it.'**
  String get awardWorkouts10Line;

  /// No description provided for @awardWorkouts365Name.
  ///
  /// In en, this message translates to:
  /// **'Three hundred and sixty-five'**
  String get awardWorkouts365Name;

  /// No description provided for @awardWorkouts365Line.
  ///
  /// In en, this message translates to:
  /// **'A workout for every day of a year, logged one by one.'**
  String get awardWorkouts365Line;

  /// No description provided for @awardTonnes10Name.
  ///
  /// In en, this message translates to:
  /// **'Ten tonnes'**
  String get awardTonnes10Name;

  /// No description provided for @awardTonnes10Line.
  ///
  /// In en, this message translates to:
  /// **'Ten thousand kilos have gone through your hands.'**
  String get awardTonnes10Line;

  /// No description provided for @awardHours100Name.
  ///
  /// In en, this message translates to:
  /// **'One hundred hours'**
  String get awardHours100Name;

  /// No description provided for @awardHours100Line.
  ///
  /// In en, this message translates to:
  /// **'A hundred hours under the bar, stopwatch in hand.'**
  String get awardHours100Line;

  /// No description provided for @awardWonOn.
  ///
  /// In en, this message translates to:
  /// **'Earned on {date}'**
  String awardWonOn(String date);

  /// No description provided for @badgeName.
  ///
  /// In en, this message translates to:
  /// **'{id, select, gold{Gold} blue{Blue} green{Green} other{Badge}}'**
  String badgeName(String id);

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Since {date}'**
  String memberSince(String date);

  /// No description provided for @levelShort.
  ///
  /// In en, this message translates to:
  /// **'Level {n}'**
  String levelShort(int n);

  /// No description provided for @levelToNext.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 workout to level {next}} other{{n} workouts to level {next}}}'**
  String levelToNext(int n, int next);

  /// No description provided for @heightCm.
  ///
  /// In en, this message translates to:
  /// **'{n} cm'**
  String heightCm(int n);

  /// No description provided for @heatToneName.
  ///
  /// In en, this message translates to:
  /// **'{id, select, ember{Ember} green{Green} blue{Blue} mono{Grey} other{Colour}}'**
  String heatToneName(String id);

  /// No description provided for @setsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'{n} sets'**
  String setsThisWeek(int n);

  /// No description provided for @weekOfGoal.
  ///
  /// In en, this message translates to:
  /// **'{n} of {goal} this week'**
  String weekOfGoal(int n, int goal);

  /// No description provided for @momentCount.
  ///
  /// In en, this message translates to:
  /// **'{n} photos'**
  String momentCount(int n);

  /// No description provided for @photosSelected.
  ///
  /// In en, this message translates to:
  /// **'{n} selected'**
  String photosSelected(int n);

  /// No description provided for @deletePhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {n} photos?'**
  String deletePhotosTitle(int n);

  /// No description provided for @momentsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Snap the gym, the whiteboard, a plate setup — anything you want to remember. They stay on the phone and only you see them.'**
  String get momentsEmptyHint;

  /// No description provided for @awardStreak100Line.
  ///
  /// In en, this message translates to:
  /// **'A hundred days in a row. That is not motivation any more, that is who you are.'**
  String get awardStreak100Line;

  /// No description provided for @coverLabel.
  ///
  /// In en, this message translates to:
  /// **'COVER'**
  String get coverLabel;

  /// No description provided for @removeCover.
  ///
  /// In en, this message translates to:
  /// **'Remove cover'**
  String get removeCover;

  /// No description provided for @startTitle.
  ///
  /// In en, this message translates to:
  /// **'Start workout'**
  String get startTitle;

  /// No description provided for @logTitle.
  ///
  /// In en, this message translates to:
  /// **'Log a workout'**
  String get logTitle;

  /// No description provided for @logHint.
  ///
  /// In en, this message translates to:
  /// **'No timer — just fill in what you did.'**
  String get logHint;

  /// No description provided for @orStartFrom.
  ///
  /// In en, this message translates to:
  /// **'Or start from'**
  String get orStartFrom;

  /// No description provided for @pickExercisesOption.
  ///
  /// In en, this message translates to:
  /// **'Pick exercises'**
  String get pickExercisesOption;

  /// No description provided for @chooseFocusOption.
  ///
  /// In en, this message translates to:
  /// **'Choose a focus'**
  String get chooseFocusOption;

  /// No description provided for @plannedRoutine.
  ///
  /// In en, this message translates to:
  /// **'PLANNED'**
  String get plannedRoutine;

  /// No description provided for @logWorkoutAction.
  ///
  /// In en, this message translates to:
  /// **'LOG A WORKOUT'**
  String get logWorkoutAction;

  /// No description provided for @logging.
  ///
  /// In en, this message translates to:
  /// **'LOGGING'**
  String get logging;

  /// No description provided for @placesLabel.
  ///
  /// In en, this message translates to:
  /// **'My places'**
  String get placesLabel;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @deleteSet.
  ///
  /// In en, this message translates to:
  /// **'Delete set'**
  String get deleteSet;

  /// No description provided for @setDeleted.
  ///
  /// In en, this message translates to:
  /// **'Set deleted'**
  String get setDeleted;

  /// No description provided for @removeWarmup.
  ///
  /// In en, this message translates to:
  /// **'Remove warm-up'**
  String get removeWarmup;

  /// No description provided for @addWeightAction.
  ///
  /// In en, this message translates to:
  /// **'Add weight'**
  String get addWeightAction;

  /// No description provided for @workoutOverview.
  ///
  /// In en, this message translates to:
  /// **'This workout'**
  String get workoutOverview;

  /// No description provided for @allExercisesShort.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allExercisesShort;

  /// No description provided for @setsDoneOf.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} sets'**
  String setsDoneOf(int done, int total);

  /// No description provided for @nowLabel.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get nowLabel;

  /// No description provided for @deleteWorkout.
  ///
  /// In en, this message translates to:
  /// **'Delete workout'**
  String get deleteWorkout;

  /// No description provided for @deleteWorkoutBody.
  ///
  /// In en, this message translates to:
  /// **'This workout and all its sets will be removed from your history.'**
  String get deleteWorkoutBody;

  /// No description provided for @themeAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get themeAuto;

  /// No description provided for @themeAutoHint.
  ///
  /// In en, this message translates to:
  /// **'Follows your phone'**
  String get themeAutoHint;

  /// No description provided for @demoSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise demo while training'**
  String get demoSizeTitle;

  /// No description provided for @demoLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get demoLarge;

  /// No description provided for @demoSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get demoSmall;

  /// No description provided for @demoOff.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get demoOff;

  /// No description provided for @demoLoopTitle.
  ///
  /// In en, this message translates to:
  /// **'Demo animation'**
  String get demoLoopTitle;

  /// No description provided for @demoLoopAlways.
  ///
  /// In en, this message translates to:
  /// **'Loop'**
  String get demoLoopAlways;

  /// No description provided for @demoLoopShort.
  ///
  /// In en, this message translates to:
  /// **'10 seconds'**
  String get demoLoopShort;

  /// No description provided for @demoLoopHint.
  ///
  /// In en, this message translates to:
  /// **'Plays for about 10 seconds and stops on the starting pose. Tap the demo to watch it again.'**
  String get demoLoopHint;

  /// No description provided for @alarmStyleTitle.
  ///
  /// In en, this message translates to:
  /// **'When rest ends'**
  String get alarmStyleTitle;

  /// No description provided for @alarmStyleLoud.
  ///
  /// In en, this message translates to:
  /// **'Always ring'**
  String get alarmStyleLoud;

  /// No description provided for @alarmStyleQuiet.
  ///
  /// In en, this message translates to:
  /// **'Follow silent mode'**
  String get alarmStyleQuiet;

  /// No description provided for @alarmStyleVibrate.
  ///
  /// In en, this message translates to:
  /// **'Vibrate only'**
  String get alarmStyleVibrate;

  /// No description provided for @alarmStyleHint.
  ///
  /// In en, this message translates to:
  /// **'Always ring uses the alarm volume, even on silent. Follow silent mode uses the notification volume and just vibrates when your phone is muted.'**
  String get alarmStyleHint;

  /// No description provided for @suggestedPicks.
  ///
  /// In en, this message translates to:
  /// **'Suggested for you'**
  String get suggestedPicks;

  /// No description provided for @moreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get moreOptions;

  /// No description provided for @suggestInWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Suggest in quick workouts'**
  String get suggestInWorkouts;

  /// No description provided for @suggestInWorkoutsHint.
  ///
  /// In en, this message translates to:
  /// **'Off keeps it out of the picks made for you. You can still add it by hand.'**
  String get suggestInWorkoutsHint;

  /// No description provided for @onbPlaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Where do you train?'**
  String get onbPlaceTitle;

  /// No description provided for @onbPlaceWhy.
  ///
  /// In en, this message translates to:
  /// **'Pick every place you train. We\'ll only suggest what you can do in each one.'**
  String get onbPlaceWhy;

  /// No description provided for @onbPlaceGear.
  ///
  /// In en, this message translates to:
  /// **'What do you have there?'**
  String get onbPlaceGear;

  /// No description provided for @distanceCol.
  ///
  /// In en, this message translates to:
  /// **'DISTANCE ({unit})'**
  String distanceCol(String unit);

  /// No description provided for @timeCol.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get timeCol;

  /// No description provided for @timeMinutesTitle.
  ///
  /// In en, this message translates to:
  /// **'Time (minutes)'**
  String get timeMinutesTitle;

  /// No description provided for @timeSecondsTitle.
  ///
  /// In en, this message translates to:
  /// **'Time (seconds)'**
  String get timeSecondsTitle;

  /// No description provided for @distanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Distance ({unit})'**
  String distanceTitle(String unit);

  /// No description provided for @holdLabel.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get holdLabel;

  /// No description provided for @stopLabel.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopLabel;

  /// No description provided for @startHold.
  ///
  /// In en, this message translates to:
  /// **'Start · {time}'**
  String startHold(String time);

  /// No description provided for @exerciseTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Log by'**
  String get exerciseTypeLabel;

  /// No description provided for @typeReps.
  ///
  /// In en, this message translates to:
  /// **'Reps & weight'**
  String get typeReps;

  /// No description provided for @typeTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get typeTime;

  /// No description provided for @typeCardio.
  ///
  /// In en, this message translates to:
  /// **'Distance & time'**
  String get typeCardio;

  /// No description provided for @exerciseTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Cardio like running or swimming logs distance and time. Holds like a plank log time.'**
  String get exerciseTypeHint;

  /// No description provided for @howToLabel.
  ///
  /// In en, this message translates to:
  /// **'How to (optional)'**
  String get howToLabel;

  /// No description provided for @howToHint.
  ///
  /// In en, this message translates to:
  /// **'One step per line'**
  String get howToHint;

  /// No description provided for @editExercise.
  ///
  /// In en, this message translates to:
  /// **'Edit exercise'**
  String get editExercise;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @noStepsYet.
  ///
  /// In en, this message translates to:
  /// **'No steps yet. Write your own so you remember how you do it.'**
  String get noStepsYet;

  /// No description provided for @addSteps.
  ///
  /// In en, this message translates to:
  /// **'Write the steps'**
  String get addSteps;

  /// No description provided for @setTypeRestPause.
  ///
  /// In en, this message translates to:
  /// **'Rest-pause'**
  String get setTypeRestPause;

  /// No description provided for @setTypeNormalInfo.
  ///
  /// In en, this message translates to:
  /// **'A regular set. It counts toward your volume and records.'**
  String get setTypeNormalInfo;

  /// No description provided for @setTypeWarmupInfo.
  ///
  /// In en, this message translates to:
  /// **'Light sets to get ready. They don\'t count toward volume or records.'**
  String get setTypeWarmupInfo;

  /// No description provided for @setTypeDropInfo.
  ///
  /// In en, this message translates to:
  /// **'Straight after a set, lower the weight and keep going without resting.'**
  String get setTypeDropInfo;

  /// No description provided for @setTypeFailureInfo.
  ///
  /// In en, this message translates to:
  /// **'Keep going until you can\'t do another clean rep. Log the reps you actually did.'**
  String get setTypeFailureInfo;

  /// No description provided for @setTypeRestPauseInfo.
  ///
  /// In en, this message translates to:
  /// **'Rest 10 to 20 seconds after the set, then squeeze out a few more reps.'**
  String get setTypeRestPauseInfo;

  /// No description provided for @planFormatNotes.
  ///
  /// In en, this message translates to:
  /// **'Use the exercise names exactly as they appear in the list. \"sets\", \"reps\", \"weight\" (in the unit given), \"rest\" in seconds and \"days\" are optional. \"superset\": true links an exercise with the next one. For several weeks, group the routines inside \"weeks\" like the second example.'**
  String get planFormatNotes;

  /// No description provided for @planSets.
  ///
  /// In en, this message translates to:
  /// **'Plan sets'**
  String get planSets;

  /// No description provided for @planSetsHint.
  ///
  /// In en, this message translates to:
  /// **'Choose the type, reps and weight of each set. Leave the weight on Auto to start from your last session.'**
  String get planSetsHint;

  /// No description provided for @planHintReps.
  ///
  /// In en, this message translates to:
  /// **'Choose the type and reps of each set. Auto starts from your last session.'**
  String get planHintReps;

  /// No description provided for @planHintTime.
  ///
  /// In en, this message translates to:
  /// **'Choose the type and time of each set. Auto starts from your last session.'**
  String get planHintTime;

  /// No description provided for @planHintTimeWeight.
  ///
  /// In en, this message translates to:
  /// **'Choose the type, time and weight of each set. Auto starts from your last session.'**
  String get planHintTimeWeight;

  /// No description provided for @planHintCardio.
  ///
  /// In en, this message translates to:
  /// **'Choose the distance and time of each set. Auto starts from your last session.'**
  String get planHintCardio;

  /// No description provided for @timeOnly.
  ///
  /// In en, this message translates to:
  /// **'Time only'**
  String get timeOnly;

  /// No description provided for @autoValue.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get autoValue;

  /// No description provided for @clearPlan.
  ///
  /// In en, this message translates to:
  /// **'Clear plan'**
  String get clearPlan;

  /// No description provided for @shareRoutine.
  ///
  /// In en, this message translates to:
  /// **'Share routine'**
  String get shareRoutine;

  /// No description provided for @shareWeek.
  ///
  /// In en, this message translates to:
  /// **'Share my week'**
  String get shareWeek;

  /// No description provided for @shareWeekHint.
  ///
  /// In en, this message translates to:
  /// **'All your routines and the day each one is on.'**
  String get shareWeekHint;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} — open the file with GymMane to add it.'**
  String shareMessage(String name);

  /// No description provided for @importRoutines.
  ///
  /// In en, this message translates to:
  /// **'Import routines'**
  String get importRoutines;

  /// No description provided for @importPasteHint.
  ///
  /// In en, this message translates to:
  /// **'Paste a routine here: one shared from GymMane, an AI answer, JSON or CSV.'**
  String get importPasteHint;

  /// No description provided for @pasteAction.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get pasteAction;

  /// No description provided for @routineCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 routine} other{{n} routines}}'**
  String routineCount(int n);

  /// No description provided for @useTheirSchedule.
  ///
  /// In en, this message translates to:
  /// **'Also use its weekly schedule'**
  String get useTheirSchedule;

  /// No description provided for @useTheirScheduleHint.
  ///
  /// In en, this message translates to:
  /// **'The days it brings replace what you have planned on them.'**
  String get useTheirScheduleHint;

  /// No description provided for @addToMyRoutines.
  ///
  /// In en, this message translates to:
  /// **'Add to my routines'**
  String get addToMyRoutines;

  /// No description provided for @routinesAdded.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 routine added} other{{n} routines added}}'**
  String routinesAdded(int n);

  /// No description provided for @nothingToImport.
  ///
  /// In en, this message translates to:
  /// **'Nothing here GymMane can import'**
  String get nothingToImport;

  /// No description provided for @aiStepCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy the request. It carries your exercise list and the format GymMane reads.'**
  String get aiStepCopy;

  /// No description provided for @aiStepAsk.
  ///
  /// In en, this message translates to:
  /// **'Paste it into any AI and say what you want: days per week, goal, how many weeks.'**
  String get aiStepAsk;

  /// No description provided for @aiStepPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste its answer below and import it. No file needed.'**
  String get aiStepPaste;

  /// No description provided for @copyForAi.
  ///
  /// In en, this message translates to:
  /// **'Copy for the AI'**
  String get copyForAi;

  /// No description provided for @copiedDone.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copiedDone;

  /// No description provided for @aiPasteHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the AI\'s answer here'**
  String get aiPasteHint;

  /// No description provided for @importAction.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importAction;

  /// No description provided for @showFormat.
  ///
  /// In en, this message translates to:
  /// **'See the format'**
  String get showFormat;

  /// No description provided for @shareAsFile.
  ///
  /// In en, this message translates to:
  /// **'Share as a file'**
  String get shareAsFile;

  /// No description provided for @recoveryTab.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get recoveryTab;

  /// No description provided for @recoveryOverall.
  ///
  /// In en, this message translates to:
  /// **'Body {pct}% recovered'**
  String recoveryOverall(int pct);

  /// No description provided for @recoveryAllFresh.
  ///
  /// In en, this message translates to:
  /// **'Everything is recovered. Good day to train anything.'**
  String get recoveryAllFresh;

  /// No description provided for @recoveryStill.
  ///
  /// In en, this message translates to:
  /// **'Still recovering: {muscles}'**
  String recoveryStill(String muscles);

  /// No description provided for @recoveryTired.
  ///
  /// In en, this message translates to:
  /// **'Fatigued'**
  String get recoveryTired;

  /// No description provided for @recoveryFresh.
  ///
  /// In en, this message translates to:
  /// **'Fresh'**
  String get recoveryFresh;

  /// No description provided for @recoveryHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a muscle to see how recovered it is. Recent sets weigh more, and harder ones (by RPE) more still.'**
  String get recoveryHint;

  /// No description provided for @recoveryPct.
  ///
  /// In en, this message translates to:
  /// **'{pct}% recovered'**
  String recoveryPct(int pct);

  /// No description provided for @readyInHours.
  ///
  /// In en, this message translates to:
  /// **'ready in ~{h} h'**
  String readyInHours(int h);

  /// No description provided for @tplAbcd.
  ///
  /// In en, this message translates to:
  /// **'Four days: chest and triceps, back and biceps, legs, shoulders and abs.'**
  String get tplAbcd;

  /// No description provided for @tplAbcde.
  ///
  /// In en, this message translates to:
  /// **'Five days, one muscle group each: chest, back, legs, shoulders, arms.'**
  String get tplAbcde;

  /// No description provided for @elapsedCaps.
  ///
  /// In en, this message translates to:
  /// **'ELAPSED'**
  String get elapsedCaps;

  /// No description provided for @tapToSkip.
  ///
  /// In en, this message translates to:
  /// **'Tap to skip'**
  String get tapToSkip;

  /// No description provided for @screenLocked.
  ///
  /// In en, this message translates to:
  /// **'Screen locked'**
  String get screenLocked;

  /// No description provided for @lockedHint.
  ///
  /// In en, this message translates to:
  /// **'Press and hold the fingerprint at the top to unlock'**
  String get lockedHint;

  /// No description provided for @liveDoneSet.
  ///
  /// In en, this message translates to:
  /// **'Set done'**
  String get liveDoneSet;

  /// No description provided for @liveSkipRest.
  ///
  /// In en, this message translates to:
  /// **'Skip rest'**
  String get liveSkipRest;

  /// No description provided for @livePause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get livePause;

  /// No description provided for @liveResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get liveResume;

  /// No description provided for @liveNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get liveNext;

  /// No description provided for @liveUpNext.
  ///
  /// In en, this message translates to:
  /// **'Up next: {name}'**
  String liveUpNext(String name);

  /// No description provided for @stickerOpen.
  ///
  /// In en, this message translates to:
  /// **'Share on a photo'**
  String get stickerOpen;

  /// No description provided for @stickerNoPhoto.
  ///
  /// In en, this message translates to:
  /// **'No photo'**
  String get stickerNoPhoto;

  /// No description provided for @stickerWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get stickerWorkout;

  /// No description provided for @stickerStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get stickerStreak;

  /// No description provided for @stickerDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get stickerDate;

  /// No description provided for @stickerHint.
  ///
  /// In en, this message translates to:
  /// **'Drag to move it, pinch to resize or turn it'**
  String get stickerHint;

  /// No description provided for @stickerSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to your gallery'**
  String get stickerSaved;

  /// No description provided for @stickerWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get stickerWeek;

  /// No description provided for @getReady.
  ///
  /// In en, this message translates to:
  /// **'Get ready'**
  String get getReady;

  /// No description provided for @stickerGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get stickerGallery;

  /// No description provided for @stickerCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get stickerCamera;

  /// No description provided for @shareIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Share this routine'**
  String get shareIntroTitle;

  /// No description provided for @shareIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Send it to your partner, a friend or your family. They get a small file that opens in GymMane and adds it in one tap, with its sets and weights.'**
  String get shareIntroBody;

  /// No description provided for @removedFromRoutine.
  ///
  /// In en, this message translates to:
  /// **'Removed from the routine'**
  String get removedFromRoutine;

  /// No description provided for @radarTitle.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get radarTitle;

  /// No description provided for @radarHint.
  ///
  /// In en, this message translates to:
  /// **'See which areas need more work'**
  String get radarHint;

  /// No description provided for @radarEmpty.
  ///
  /// In en, this message translates to:
  /// **'Train a few days to see your balance'**
  String get radarEmpty;

  /// No description provided for @radarBalanced.
  ///
  /// In en, this message translates to:
  /// **'Good balance so far'**
  String get radarBalanced;

  /// No description provided for @radarFocus.
  ///
  /// In en, this message translates to:
  /// **'Needs more: {list}'**
  String radarFocus(String list);

  /// No description provided for @countdownReady.
  ///
  /// In en, this message translates to:
  /// **'Get ready'**
  String get countdownReady;

  /// No description provided for @countdownSkip.
  ///
  /// In en, this message translates to:
  /// **'Tap to start now'**
  String get countdownSkip;

  /// No description provided for @countdownSetting.
  ///
  /// In en, this message translates to:
  /// **'Countdown before starting'**
  String get countdownSetting;

  /// No description provided for @effortSetting.
  ///
  /// In en, this message translates to:
  /// **'Log effort per set'**
  String get effortSetting;

  /// No description provided for @effortHint.
  ///
  /// In en, this message translates to:
  /// **'RPE: 10 means nothing left, 8 means two reps to spare. RIR counts the reps you had left. When a set has it, the estimated 1RM uses the RPE chart.'**
  String get effortHint;

  /// No description provided for @rirHint.
  ///
  /// In en, this message translates to:
  /// **'0 is nothing left in the tank, 2 is two reps to spare.'**
  String get rirHint;

  /// No description provided for @addWeekWidget.
  ///
  /// In en, this message translates to:
  /// **'Add week widget'**
  String get addWeekWidget;

  /// No description provided for @gamificationSetting.
  ///
  /// In en, this message translates to:
  /// **'Medals and levels'**
  String get gamificationSetting;

  /// No description provided for @repCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{{n} rep} other{{n} reps}}'**
  String repCount(int n);

  /// No description provided for @prBestSet.
  ///
  /// In en, this message translates to:
  /// **'Best set'**
  String get prBestSet;

  /// No description provided for @weekStartSetting.
  ///
  /// In en, this message translates to:
  /// **'Week starts on'**
  String get weekStartSetting;

  /// No description provided for @stepOutOfWorkout.
  ///
  /// In en, this message translates to:
  /// **'Pause and leave'**
  String get stepOutOfWorkout;

  /// No description provided for @saveToRoutine.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES TO ROUTINE'**
  String get saveToRoutine;

  /// No description provided for @routineUpdated.
  ///
  /// In en, this message translates to:
  /// **'Routine updated'**
  String get routineUpdated;

  /// No description provided for @saveChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Save changes to {name}?'**
  String saveChangesTitle(String name);

  /// No description provided for @saveChangesBody.
  ///
  /// In en, this message translates to:
  /// **'Next time you start it, the routine will have these changes.'**
  String get saveChangesBody;

  /// No description provided for @routineOrderChanged.
  ///
  /// In en, this message translates to:
  /// **'New exercise order'**
  String get routineOrderChanged;

  /// No description provided for @mineOnly.
  ///
  /// In en, this message translates to:
  /// **'Created by you'**
  String get mineOnly;

  /// No description provided for @createNamed.
  ///
  /// In en, this message translates to:
  /// **'Not here? Create “{name}”'**
  String createNamed(String name);

  /// No description provided for @orStartWith.
  ///
  /// In en, this message translates to:
  /// **'Or start with'**
  String get orStartWith;

  /// No description provided for @warmupFocus.
  ///
  /// In en, this message translates to:
  /// **'Warm-up'**
  String get warmupFocus;

  /// No description provided for @warmupFocusHint.
  ///
  /// In en, this message translates to:
  /// **'Mobility and activation, with or without kit'**
  String get warmupFocusHint;

  /// No description provided for @cardioFocus.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get cardioFocus;

  /// No description provided for @cardioFocusHint.
  ///
  /// In en, this message translates to:
  /// **'Run, bike, row or skip, by distance and time'**
  String get cardioFocusHint;

  /// No description provided for @homeRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended on home'**
  String get homeRecommended;

  /// No description provided for @archivedFilter.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archivedFilter;

  /// No description provided for @archiveExercise.
  ///
  /// In en, this message translates to:
  /// **'Archive exercise'**
  String get archiveExercise;

  /// No description provided for @restoreExercise.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreExercise;

  /// No description provided for @archivedToast.
  ///
  /// In en, this message translates to:
  /// **'Exercise archived'**
  String get archivedToast;

  /// No description provided for @archivedToastHint.
  ///
  /// In en, this message translates to:
  /// **'Find it under Exercises › Archived'**
  String get archivedToastHint;

  /// No description provided for @archivedBanner.
  ///
  /// In en, this message translates to:
  /// **'Archived. It stays out of lists and suggestions; your history is kept.'**
  String get archivedBanner;

  /// No description provided for @videoMarksHint.
  ///
  /// In en, this message translates to:
  /// **'Pause on a step and tap the pin to jump there next time.'**
  String get videoMarksHint;

  /// No description provided for @videoMarkHere.
  ///
  /// In en, this message translates to:
  /// **'Mark this step here'**
  String get videoMarkHere;

  /// No description provided for @sectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get sectionGeneral;

  /// No description provided for @sectionTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get sectionTraining;

  /// No description provided for @sectionAlerts.
  ///
  /// In en, this message translates to:
  /// **'Reminders & alarm'**
  String get sectionAlerts;

  /// No description provided for @sectionHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get sectionHome;

  /// No description provided for @sectionWidgets.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get sectionWidgets;

  /// No description provided for @sectionData.
  ///
  /// In en, this message translates to:
  /// **'Data & backup'**
  String get sectionData;

  /// No description provided for @multiPlanSetting.
  ///
  /// In en, this message translates to:
  /// **'Several routines a day'**
  String get multiPlanSetting;

  /// No description provided for @multiPlanHint.
  ///
  /// In en, this message translates to:
  /// **'Tap every routine for this day. They go in the order you add them.'**
  String get multiPlanHint;

  /// No description provided for @routineOfDay.
  ///
  /// In en, this message translates to:
  /// **'{n} of {total} today'**
  String routineOfDay(int n, int total);

  /// No description provided for @nextToday.
  ///
  /// In en, this message translates to:
  /// **'Next today'**
  String get nextToday;

  /// No description provided for @planAboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me:'**
  String get planAboutMe;

  /// No description provided for @planBody.
  ///
  /// In en, this message translates to:
  /// **'{sex}, {age} years old, {height} tall, {weight}.'**
  String planBody(String sex, int age, String height, String weight);

  /// No description provided for @planDays.
  ///
  /// In en, this message translates to:
  /// **'I want to train {n} days a week.'**
  String planDays(int n);

  /// No description provided for @planNoHistory.
  ///
  /// In en, this message translates to:
  /// **'No workouts logged yet: treat me as a beginner and keep volume and weights conservative.'**
  String get planNoHistory;

  /// No description provided for @planHistory.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 workout logged in the last 30 days.} other{{n} workouts logged in the last 30 days.}}'**
  String planHistory(int n);

  /// No description provided for @planBestLifts.
  ///
  /// In en, this message translates to:
  /// **'Best recent sets'**
  String get planBestLifts;

  /// No description provided for @planAskFirst.
  ///
  /// In en, this message translates to:
  /// **'If you don’t know my goal (strength, muscle, fat loss or general fitness) or how long each session can last, ask me first in one short message. Once you have it, answer with JSON only.'**
  String get planAskFirst;

  /// No description provided for @backToTop.
  ///
  /// In en, this message translates to:
  /// **'Back to top'**
  String get backToTop;

  /// No description provided for @deleteExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this exercise?'**
  String get deleteExerciseTitle;

  /// No description provided for @deleteExerciseBody.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" will be removed from your library and routines. Your past sets are kept.'**
  String deleteExerciseBody(String name);

  /// No description provided for @exportForStravaHint.
  ///
  /// In en, this message translates to:
  /// **'Upload it in a browser at strava.com/upload/select (the Strava app can\'t import files). It shows up as a Weight Training with your sets.'**
  String get exportForStravaHint;

  /// No description provided for @manualStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get manualStartTime;

  /// No description provided for @manualDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get manualDuration;

  /// No description provided for @manualDurationUnset.
  ///
  /// In en, this message translates to:
  /// **'Add duration'**
  String get manualDurationUnset;

  /// No description provided for @stravaRow.
  ///
  /// In en, this message translates to:
  /// **'Export to Strava (beta)'**
  String get stravaRow;

  /// No description provided for @stravaBeta.
  ///
  /// In en, this message translates to:
  /// **'BETA'**
  String get stravaBeta;

  /// No description provided for @stravaIntro.
  ///
  /// In en, this message translates to:
  /// **'Pick a workout to take it to Strava. You get a .fit file: upload it in a browser at strava.com/upload/select and it shows up as a Weight Training with your sets.'**
  String get stravaIntro;

  /// No description provided for @stravaEmpty.
  ///
  /// In en, this message translates to:
  /// **'No workouts to export yet.'**
  String get stravaEmpty;

  /// No description provided for @tapToPause.
  ///
  /// In en, this message translates to:
  /// **'Tap to pause'**
  String get tapToPause;

  /// No description provided for @holdPausedHint.
  ///
  /// In en, this message translates to:
  /// **'Paused · tap to resume'**
  String get holdPausedHint;

  /// No description provided for @finishHoldNow.
  ///
  /// In en, this message translates to:
  /// **'Finish set now'**
  String get finishHoldNow;

  /// No description provided for @barWeightExercise.
  ///
  /// In en, this message translates to:
  /// **'Bar or sled weight'**
  String get barWeightExercise;

  /// No description provided for @barWeightHint.
  ///
  /// In en, this message translates to:
  /// **'Used by the plate calculator'**
  String get barWeightHint;

  /// No description provided for @barWeightCustom.
  ///
  /// In en, this message translates to:
  /// **'Your own · tap to reset'**
  String get barWeightCustom;

  /// No description provided for @groupRename.
  ///
  /// In en, this message translates to:
  /// **'Rename group'**
  String get groupRename;

  /// No description provided for @groupUngroup.
  ///
  /// In en, this message translates to:
  /// **'Remove group, keep routines'**
  String get groupUngroup;

  /// No description provided for @groupDeleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete group and routines'**
  String get groupDeleteAll;

  /// No description provided for @groupDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete “{name}”?'**
  String groupDeleteTitle(String name);

  /// No description provided for @groupDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'{count} will be deleted. Your workout history is kept.'**
  String groupDeleteBody(String count);

  /// No description provided for @tplRr.
  ///
  /// In en, this message translates to:
  /// **'The r/bodyweightfitness classic: full body three days a week. Move up a step when it gets easy.'**
  String get tplRr;

  /// No description provided for @levelUpKicker.
  ///
  /// In en, this message translates to:
  /// **'NEXT STEP'**
  String get levelUpKicker;

  /// No description provided for @levelUpBody.
  ///
  /// In en, this message translates to:
  /// **'3×{reps} on {name} two workouts in a row. Ready for the next step?'**
  String levelUpBody(int reps, String name);

  /// No description provided for @levelUpSwap.
  ///
  /// In en, this message translates to:
  /// **'Swap it in {routine}'**
  String levelUpSwap(String routine);

  /// No description provided for @levelUpSee.
  ///
  /// In en, this message translates to:
  /// **'See how it\'s done'**
  String get levelUpSee;

  /// No description provided for @levelUpLater.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get levelUpLater;

  /// No description provided for @levelUpStay.
  ///
  /// In en, this message translates to:
  /// **'Keep this one'**
  String get levelUpStay;

  /// No description provided for @levelUpSwapped.
  ///
  /// In en, this message translates to:
  /// **'{name} is now in {routine}'**
  String levelUpSwapped(String name, String routine);

  /// No description provided for @levelUpStayed.
  ///
  /// In en, this message translates to:
  /// **'No more step-up tips for this one'**
  String get levelUpStayed;

  /// No description provided for @levelHintsSetting.
  ///
  /// In en, this message translates to:
  /// **'Suggest the next step'**
  String get levelHintsSetting;

  /// No description provided for @heatmapLabelsSetting.
  ///
  /// In en, this message translates to:
  /// **'Days and months on the activity map'**
  String get heatmapLabelsSetting;

  /// No description provided for @rmPercent.
  ///
  /// In en, this message translates to:
  /// **'PERCENTAGE'**
  String get rmPercent;

  /// No description provided for @rmAtPercent.
  ///
  /// In en, this message translates to:
  /// **'{pct} of your max'**
  String rmAtPercent(String pct);

  /// No description provided for @copyWorkout.
  ///
  /// In en, this message translates to:
  /// **'Copy as text'**
  String get copyWorkout;

  /// No description provided for @goalSet.
  ///
  /// In en, this message translates to:
  /// **'Set a goal'**
  String get goalSet;

  /// No description provided for @goalTargetReps.
  ///
  /// In en, this message translates to:
  /// **'TARGET REPS'**
  String get goalTargetReps;

  /// No description provided for @goalToGo.
  ///
  /// In en, this message translates to:
  /// **'{value} to go'**
  String goalToGo(String value);

  /// No description provided for @goalReached.
  ///
  /// In en, this message translates to:
  /// **'Goal reached'**
  String get goalReached;

  /// No description provided for @goalDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 day left} other{{n} days left}}'**
  String goalDaysLeft(int n);

  /// No description provided for @goalOverdue.
  ///
  /// In en, this message translates to:
  /// **'Past the date'**
  String get goalOverdue;

  /// No description provided for @goalDeadline.
  ///
  /// In en, this message translates to:
  /// **'DEADLINE'**
  String get goalDeadline;

  /// No description provided for @goalNoDeadline.
  ///
  /// In en, this message translates to:
  /// **'No deadline'**
  String get goalNoDeadline;

  /// No description provided for @goalRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove goal'**
  String get goalRemove;

  /// No description provided for @exerciseNameMissing.
  ///
  /// In en, this message translates to:
  /// **'Give it a name'**
  String get exerciseNameMissing;

  /// No description provided for @aliasesLabel.
  ///
  /// In en, this message translates to:
  /// **'Also called (optional)'**
  String get aliasesLabel;

  /// No description provided for @aliasesHint.
  ///
  /// In en, this message translates to:
  /// **'Other names, separated by commas'**
  String get aliasesHint;

  /// No description provided for @alsoCalled.
  ///
  /// In en, this message translates to:
  /// **'Also: {names}'**
  String alsoCalled(String names);

  /// No description provided for @addToRoutine.
  ///
  /// In en, this message translates to:
  /// **'Add to routine'**
  String get addToRoutine;

  /// No description provided for @inRoutines.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{Not in any routine yet} =1{In 1 routine} other{In {n} routines}}'**
  String inRoutines(int n);

  /// No description provided for @alreadyInRoutine.
  ///
  /// In en, this message translates to:
  /// **'Already in it'**
  String get alreadyInRoutine;

  /// No description provided for @restInRoutine.
  ///
  /// In en, this message translates to:
  /// **'Rest in this routine'**
  String get restInRoutine;

  /// No description provided for @restInRoutineHint.
  ///
  /// In en, this message translates to:
  /// **'Same as the exercise'**
  String get restInRoutineHint;

  /// No description provided for @restInRoutineReset.
  ///
  /// In en, this message translates to:
  /// **'Only here · tap to undo'**
  String get restInRoutineReset;

  /// No description provided for @swapExercise.
  ///
  /// In en, this message translates to:
  /// **'Swap exercise'**
  String get swapExercise;

  /// No description provided for @swapShort.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swapShort;

  /// No description provided for @swapHint.
  ///
  /// In en, this message translates to:
  /// **'Instead of {name}, only for today. When you finish, you can keep it in the routine.'**
  String swapHint(String name);

  /// No description provided for @swapKeepsDone.
  ///
  /// In en, this message translates to:
  /// **'The sets you already did stay logged; the new one picks up the rest.'**
  String get swapKeepsDone;

  /// No description provided for @swapSameMuscle.
  ///
  /// In en, this message translates to:
  /// **'Same muscle · {muscle}'**
  String swapSameMuscle(String muscle);

  /// No description provided for @swapDoneBefore.
  ///
  /// In en, this message translates to:
  /// **'Done before'**
  String get swapDoneBefore;

  /// No description provided for @multiPlanSettingHint.
  ///
  /// In en, this message translates to:
  /// **'More than one routine on the same weekday.'**
  String get multiPlanSettingHint;

  /// No description provided for @levelHintsHint.
  ///
  /// In en, this message translates to:
  /// **'When an exercise gets easy, it offers you the harder version.'**
  String get levelHintsHint;

  /// No description provided for @focusCardHint.
  ///
  /// In en, this message translates to:
  /// **'Today’s routine, at the top of Home.'**
  String get focusCardHint;

  /// No description provided for @gamificationHint.
  ///
  /// In en, this message translates to:
  /// **'Medals, your level and the celebration when you finish.'**
  String get gamificationHint;

  /// No description provided for @exerciseSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings for this exercise'**
  String get exerciseSettings;

  /// No description provided for @placeActiveNow.
  ///
  /// In en, this message translates to:
  /// **'You’re here'**
  String get placeActiveNow;

  /// No description provided for @placeTapToUse.
  ///
  /// In en, this message translates to:
  /// **'tap to train here'**
  String get placeTapToUse;

  /// No description provided for @intervalDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get intervalDays;

  /// No description provided for @goalDaysShort.
  ///
  /// In en, this message translates to:
  /// **'{done}/{target} days'**
  String goalDaysShort(int done, int target);

  /// No description provided for @toolNameRpe.
  ///
  /// In en, this message translates to:
  /// **'RPE load'**
  String get toolNameRpe;

  /// No description provided for @toolTitleRpe.
  ///
  /// In en, this message translates to:
  /// **'Load by RPE'**
  String get toolTitleRpe;

  /// No description provided for @toolDescRpe.
  ///
  /// In en, this message translates to:
  /// **'Weight for the effort you want'**
  String get toolDescRpe;

  /// No description provided for @toolNameDots.
  ///
  /// In en, this message translates to:
  /// **'Strength level'**
  String get toolNameDots;

  /// No description provided for @toolTitleDots.
  ///
  /// In en, this message translates to:
  /// **'Strength level (DOTS)'**
  String get toolTitleDots;

  /// No description provided for @toolDescDots.
  ///
  /// In en, this message translates to:
  /// **'Your strength for your bodyweight'**
  String get toolDescDots;

  /// No description provided for @rpeResultHint.
  ///
  /// In en, this message translates to:
  /// **'For {reps} reps at RPE {rpe}'**
  String rpeResultHint(int reps, String rpe);

  /// No description provided for @rpeYourSet.
  ///
  /// In en, this message translates to:
  /// **'A set you just did'**
  String get rpeYourSet;

  /// No description provided for @rpeGoal.
  ///
  /// In en, this message translates to:
  /// **'What you want to do'**
  String get rpeGoal;

  /// No description provided for @rpeOneRmLine.
  ///
  /// In en, this message translates to:
  /// **'Estimated 1RM: {value}'**
  String rpeOneRmLine(String value);

  /// No description provided for @rpeExplain.
  ///
  /// In en, this message translates to:
  /// **'RPE 10 means you couldn’t do one more; 8 means you had two left.'**
  String get rpeExplain;

  /// No description provided for @dotsBestLifts.
  ///
  /// In en, this message translates to:
  /// **'Your best lifts'**
  String get dotsBestLifts;

  /// No description provided for @dotsSquat.
  ///
  /// In en, this message translates to:
  /// **'SQUAT'**
  String get dotsSquat;

  /// No description provided for @dotsBench.
  ///
  /// In en, this message translates to:
  /// **'BENCH PRESS'**
  String get dotsBench;

  /// No description provided for @dotsDeadlift.
  ///
  /// In en, this message translates to:
  /// **'DEADLIFT'**
  String get dotsDeadlift;

  /// No description provided for @dotsTotalLine.
  ///
  /// In en, this message translates to:
  /// **'Total: {value}'**
  String dotsTotalLine(String value);

  /// No description provided for @dotsExplain.
  ///
  /// In en, this message translates to:
  /// **'Compares your strength with anyone’s, whatever they weigh. Use your best single rep, or your estimated 1RM.'**
  String get dotsExplain;

  /// No description provided for @dotsLevel0.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get dotsLevel0;

  /// No description provided for @dotsLevel1.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get dotsLevel1;

  /// No description provided for @dotsLevel2.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get dotsLevel2;

  /// No description provided for @dotsLevel3.
  ///
  /// In en, this message translates to:
  /// **'Very advanced'**
  String get dotsLevel3;

  /// No description provided for @dotsLevel4.
  ///
  /// In en, this message translates to:
  /// **'Elite'**
  String get dotsLevel4;

  /// No description provided for @toolNameWilks.
  ///
  /// In en, this message translates to:
  /// **'Wilks'**
  String get toolNameWilks;

  /// No description provided for @toolTitleWilks.
  ///
  /// In en, this message translates to:
  /// **'Wilks score'**
  String get toolTitleWilks;

  /// No description provided for @toolDescWilks.
  ///
  /// In en, this message translates to:
  /// **'The classic powerlifting score'**
  String get toolDescWilks;

  /// No description provided for @wilksExplain.
  ///
  /// In en, this message translates to:
  /// **'The classic powerlifting formula. DOTS replaced it in 2020, but many meets and rankings still use it.'**
  String get wilksExplain;

  /// No description provided for @toolNameFfmi.
  ///
  /// In en, this message translates to:
  /// **'FFMI'**
  String get toolNameFfmi;

  /// No description provided for @toolTitleFfmi.
  ///
  /// In en, this message translates to:
  /// **'Fat-free mass index'**
  String get toolTitleFfmi;

  /// No description provided for @toolDescFfmi.
  ///
  /// In en, this message translates to:
  /// **'How much muscle for your height'**
  String get toolDescFfmi;

  /// No description provided for @ffmiBodyFat.
  ///
  /// In en, this message translates to:
  /// **'BODY FAT'**
  String get ffmiBodyFat;

  /// No description provided for @ffmiLeanLine.
  ///
  /// In en, this message translates to:
  /// **'Lean mass: {value}'**
  String ffmiLeanLine(String value);

  /// No description provided for @ffmiExplain.
  ///
  /// In en, this message translates to:
  /// **'Like BMI, but without the fat: it only counts your lean mass. Adjusted to your height so tall and short people compare fairly.'**
  String get ffmiExplain;

  /// No description provided for @ffmiLevel0.
  ///
  /// In en, this message translates to:
  /// **'Below average'**
  String get ffmiLevel0;

  /// No description provided for @ffmiLevel1.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get ffmiLevel1;

  /// No description provided for @ffmiLevel2.
  ///
  /// In en, this message translates to:
  /// **'Above average'**
  String get ffmiLevel2;

  /// No description provided for @ffmiLevel3.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get ffmiLevel3;

  /// No description provided for @ffmiLevel4.
  ///
  /// In en, this message translates to:
  /// **'Exceptional'**
  String get ffmiLevel4;

  /// No description provided for @rpeEffortLabel.
  ///
  /// In en, this message translates to:
  /// **'Effort (RPE)'**
  String get rpeEffortLabel;

  /// No description provided for @restRowHint.
  ///
  /// In en, this message translates to:
  /// **'Between sets, unless the exercise has its own.'**
  String get restRowHint;

  /// No description provided for @effortRowHint.
  ///
  /// In en, this message translates to:
  /// **'Log RPE or RIR on each set.'**
  String get effortRowHint;

  /// No description provided for @countdownHint.
  ///
  /// In en, this message translates to:
  /// **'3, 2, 1 before the first set.'**
  String get countdownHint;

  /// No description provided for @keepScreenOnHint.
  ///
  /// In en, this message translates to:
  /// **'The screen stays on while you train.'**
  String get keepScreenOnHint;

  /// No description provided for @demoSizeRowHint.
  ///
  /// In en, this message translates to:
  /// **'The exercise drawing during the workout.'**
  String get demoSizeRowHint;

  /// No description provided for @demoLoopRowHint.
  ///
  /// In en, this message translates to:
  /// **'Whether the animation repeats or stops.'**
  String get demoLoopRowHint;

  /// No description provided for @trainReminderRowHint.
  ///
  /// In en, this message translates to:
  /// **'A nudge on the days you train.'**
  String get trainReminderRowHint;

  /// No description provided for @alarmSoundRowHint.
  ///
  /// In en, this message translates to:
  /// **'What plays when the rest ends.'**
  String get alarmSoundRowHint;

  /// No description provided for @alarmStyleRowHint.
  ///
  /// In en, this message translates to:
  /// **'Whether it rings in silent mode.'**
  String get alarmStyleRowHint;

  /// No description provided for @recommendedRowHint.
  ///
  /// In en, this message translates to:
  /// **'Exercises we suggest on Home.'**
  String get recommendedRowHint;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'it',
    'ja',
    'ko',
    'nl',
    'pl',
    'pt',
    'ru',
    'tr',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
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
