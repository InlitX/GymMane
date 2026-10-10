part of 'fit_state.dart';

const String kBgPhotoId = 'bg';

mixin SettingsState on FitCore, ToolsState, LibraryState {
  String themePref = 'dark';

  bool get dark => themePref == 'system'
      ? PlatformDispatcher.instance.platformBrightness == Brightness.dark
      : themePref == 'dark' || themePref == 'amoled';

  set dark(bool on) => themePref = on ? 'dark' : 'light';

  ThemeMode get themeMode => switch (themePref) {
        'system' => ThemeMode.system,
        'light' => ThemeMode.light,
        _ => ThemeMode.dark,
      };

  String demoSize = 'large';
  String demoLoop = 'always';
  String alarmStyle = 'quiet';
  int restSeconds = 90;
  String? alarmSound;
  String? alarmSoundName;

  String? get alarmSoundPath => AlarmStore.pathFor(alarmSound);

  String bgPattern = 'dots';
  double bgDim = 0.55;
  bool showFocus = true;
  bool showRecommended = true;
  bool showWeekStats = true;
  bool showRoutineRow = true;
  bool levelHints = true;
  bool toastSound = true;
  bool heatmapLabels = true;
  bool autoAdvance = true;
  bool keepScreenOn = true;
  bool startCountdown = true;
  bool gamification = true;
  bool logRpe = false;
  String effortScale = 'rpe';
  int? trainReminderMin;
  bool smartReminder = false;
  bool onboarded = false;
  bool alarmAllowed = true;
  int? alarmAskedAt;
  String language = 'en';

  Locale get locale => localeOf(language);

  void _adoptDeviceLanguage() =>
      _applyLanguage(PlatformDispatcher.instance.locale.toLanguageTag());

  void _applyLanguage(String code) {
    setAppLanguage(code);
    language = appLanguage;
  }

  void setThemePref(String pref) {
    if (!const ['system', 'dark', 'amoled', 'light'].contains(pref)) return;
    themePref = pref;
    _persist();
    _refreshWidgets();
    notifyListeners();
  }

  void setThemeDark() => setThemePref('dark');

  void setThemeLight() => setThemePref('light');

  void systemBrightnessChanged() {
    if (themePref != 'system') return;
    _refreshWidgets();
    notifyListeners();
  }

  void setDemoSize(String size) {
    if (!const ['large', 'small', 'off'].contains(size)) return;
    demoSize = size;
    _persist();
    notifyListeners();
  }

  void setDemoLoop(String loop) {
    if (!const ['always', 'short'].contains(loop)) return;
    demoLoop = loop;
    _persist();
    notifyListeners();
  }

  void setAlarmStyle(String style) {
    if (!const ['loud', 'quiet', 'vibrate'].contains(style)) return;
    alarmStyle = style;
    RestAlarm.instance.style = style;
    Beeper.instance.loud = style == 'loud';
    _persist();
    notifyListeners();
  }

  void setLanguage(String code) {
    _applyLanguage(code);
    _persist();
    _refreshWidgets();
    notifyListeners();
  }

  void updateProfile({
    String? name,
    String? sex,
    int? ageDelta,
    double? heightDelta,
    double? weightDelta,
    double? activity,
    int? weeklyGoalDelta,
  }) {
    if (name != null) profile.name = name.trim();
    if (sex != null) profile.sex = sex;
    if (ageDelta != null) profile.age = (profile.age + ageDelta).clamp(10, 90);
    if (heightDelta != null) profile.heightCm = _clamp(profile.heightCm + heightDelta, 100, 250);
    if (weightDelta != null) profile.weightKg = _clamp(profile.weightKg + weightDelta, 30, 250);
    if (activity != null) profile.activity = activity;
    if (weeklyGoalDelta != null) profile.weeklyGoal = (profile.weeklyGoal + weeklyGoalDelta).clamp(1, 14);
    _seedCalculatorsFromProfile();
    _persist();
    notifyListeners();
  }

  Uint8List? _photoBytes;
  String? _photoCacheKey;

  Uint8List? get profilePhoto {
    final raw = profile.photo;
    if (raw.isEmpty) return null;
    if (_photoCacheKey != raw) {
      try {
        _photoBytes = base64Decode(raw);
      } catch (_) {
        _photoBytes = null;
      }
      _photoCacheKey = raw;
    }
    return _photoBytes;
  }

  void setProfilePhoto(Uint8List bytes) {
    profile.photo = base64Encode(bytes);
    _persist();
    notifyListeners();
  }

  void clearProfilePhoto() {
    profile.photo = '';
    _persist();
    notifyListeners();
  }

  Uint8List? _bannerBytes;
  String? _bannerCacheKey;

  Uint8List? get profileBanner {
    final raw = profile.banner;
    if (raw.isEmpty) return null;
    if (_bannerCacheKey != raw) {
      try {
        _bannerBytes = base64Decode(raw);
      } catch (_) {
        _bannerBytes = null;
      }
      _bannerCacheKey = raw;
    }
    return _bannerBytes;
  }

  void setProfileBanner(Uint8List bytes) {
    profile.banner = base64Encode(bytes);
    _persist();
    notifyListeners();
  }

  void clearProfileBanner() {
    profile.banner = '';
    _persist();
    notifyListeners();
  }

  String heatTone = 'ember';

  void setHeatTone(String tone) {
    heatTone = tone;
    _persist();
    notifyListeners();
  }

  void setProfileBadge(String badge) {
    profile.badge = profile.badge == badge ? '' : badge;
    _persist();
    notifyListeners();
  }

  void setProfileHandle(String handle) {
    profile.handle = handle.trim().replaceAll(RegExp(r'[^A-Za-z0-9_.]'), '');
    _persist();
    notifyListeners();
  }

  bool get hasOwnIdentity =>
      profile.handle.isNotEmpty || (profile.name.isNotEmpty && profile.name != kDefaultName);

  String get displayName => profile.name.isEmpty ? kDefaultName : profile.name;

  String get profileHandle {
    final own = profile.handle;
    if (own.isNotEmpty) return own;
    final from = displayName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return from.isEmpty ? kDefaultHandle : from;
  }

  DateTime get memberSince => profile.since ?? DateTime.now();

  void completeOnboarding() {
    onboarded = true;
    refreshAwards();
    persistNow();
    notifyListeners();
  }

  void setRestSeconds(int v) {
    restSeconds = v <= 0 ? 0 : v.clamp(15, 600);
    _persist();
    notifyListeners();
  }

  int restFor(String exerciseId) =>
      exerciseRest[exerciseId] ?? (modeOf(exerciseId) == 'cardio' ? 0 : restSeconds);

  bool hasCustomRest(String exerciseId) => exerciseRest.containsKey(exerciseId);

  void setExerciseRest(String exerciseId, int? seconds) {
    if (seconds == null) {
      exerciseRest.remove(exerciseId);
    } else {
      exerciseRest[exerciseId] = seconds <= 0 ? 0 : seconds.clamp(15, 600);
    }
    _persist();
    notifyListeners();
  }

  void setAlarmSound(String basename, String displayName) {
    alarmSound = basename;
    alarmSoundName = displayName;
    RestAlarm.instance.customSoundPath = alarmSoundPath;
    _persist();
    notifyListeners();
  }

  Future<void> clearAlarmSound() async {
    alarmSound = null;
    alarmSoundName = null;
    RestAlarm.instance.customSoundPath = null;
    await AlarmStore.clear();
    _persist();
    notifyListeners();
  }

  bool warmsUp(String exerciseId) => autoWarmup.contains(exerciseId);

  void toggleAutoWarmup(String exerciseId) {
    if (!autoWarmup.remove(exerciseId)) autoWarmup.add(exerciseId);
    _persist();
    notifyListeners();
  }

  void setTrainReminder(int? minuteOfDay) {
    trainReminderMin = minuteOfDay?.clamp(0, 24 * 60 - 1);
    _persist();
    syncTrainReminder();
    notifyListeners();
  }

  void setSmartReminder(bool on) {
    smartReminder = on;
    _persist();
    syncTrainReminder();
    notifyListeners();
  }

  void toggleLogRpe() {
    logRpe = !logRpe;
    _persist();
    notifyListeners();
  }

  String get effortMode => logRpe ? effortScale : '';

  void setEffortMode(String mode) {
    logRpe = mode.isNotEmpty;
    if (logRpe) effortScale = mode;
    _persist();
    notifyListeners();
  }

  bool get usesRir => effortScale == 'rir';

  String effortLabel(double rpe) => usesRir ? 'RIR ${fmt(10 - rpe)}' : 'RPE ${fmt(rpe)}';

  String effortTag(double rpe) => usesRir ? 'R${fmt(10 - rpe)}' : '@${fmt(rpe)}';

  void toggleAutoAdvance() {
    autoAdvance = !autoAdvance;
    _persist();
    notifyListeners();
  }

  void toggleStartCountdown() {
    startCountdown = !startCountdown;
    _persist();
    notifyListeners();
  }

  void toggleKeepScreenOn() {
    keepScreenOn = !keepScreenOn;
    _persist();
    notifyListeners();
  }

  double? progressFor(String exerciseId) => progressStep[exerciseId];

  bool hasProgress(String exerciseId) => (progressStep[exerciseId] ?? 0) > 0;

  void toggleProgress(String exerciseId) {
    if (hasProgress(exerciseId)) {
      progressStep.remove(exerciseId);
    } else {
      progressStep[exerciseId] = fromDisplayWeight(weightStep);
    }
    _persist();
    notifyListeners();
  }

  void bumpProgressStep(String exerciseId, int dir) {
    final current = toDisplayWeight(progressStep[exerciseId] ?? 0);
    final next = (current + dir * weightStep / 2).clamp(weightStep / 2, weightStep * 8);
    progressStep[exerciseId] = fromDisplayWeight(next);
    _persist();
    notifyListeners();
  }

  void toggleFocusCard() {
    showFocus = !showFocus;
    _persist();
    notifyListeners();
  }

  void toggleRecommended() {
    showRecommended = !showRecommended;
    _persist();
    notifyListeners();
  }

  void toggleWeekStats() {
    showWeekStats = !showWeekStats;
    _persist();
    notifyListeners();
  }

  void toggleRoutineRow() {
    showRoutineRow = !showRoutineRow;
    _persist();
    notifyListeners();
  }

  void toggleHeatmapLabels() {
    heatmapLabels = !heatmapLabels;
    _persist();
    notifyListeners();
  }

  void toggleToastSound() {
    toastSound = !toastSound;
    Beeper.instance.chimeOn = toastSound;
    _persist();
    notifyListeners();
  }

  void toggleLevelHints() {
    levelHints = !levelHints;
    _persist();
    notifyListeners();
  }

  static const weekStarts = [DateTime.monday, DateTime.saturday, DateTime.sunday];

  static const kgSteps = [0.5, 1.0, 1.25, 2.0, 2.5, 5.0];
  static const lbSteps = [1.0, 2.5, 5.0, 10.0];

  List<double> get weightSteps => isLb ? lbSteps : kgSteps;

  void setWeightStep(double step) {
    if (!weightSteps.contains(step)) return;
    if (isLb) {
      stepLb = step;
    } else {
      stepKg = step;
    }
    _persist();
    notifyListeners();
  }

  void setWeekStart(int weekday) {
    if (!weekStarts.contains(weekday)) return;
    weekStartDay = weekday;
    _persist();
    _refreshWidgets();
    notifyListeners();
  }

  static const bgPatterns = ['none', 'dots', 'grid', 'photo'];

  void setBgPattern(String v) {
    if (!bgPatterns.contains(v)) return;
    if (v == 'photo' && bgPhoto == null) return;
    bgPattern = v;
    _persist();
    notifyListeners();
  }

  String? get bgPhoto => exerciseMedia[kBgPhotoId];

  String? get bgPhotoPath => MediaStore.pathFor(bgPhoto ?? '');

  Future<void> setBgPhoto(String srcPath) async {
    await attachExerciseMedia(kBgPhotoId, srcPath);
    if (bgPhoto != null) bgPattern = 'photo';
    _persist();
    notifyListeners();
  }

  void clearBgPhoto() {
    clearExerciseMedia(kBgPhotoId);
    if (bgPattern == 'photo') bgPattern = 'dots';
    _persist();
    notifyListeners();
  }

  void setBgDim(double v) {
    bgDim = v.clamp(0.3, 0.85);
    _persist();
    notifyListeners();
  }

  static const _askAgainAfter = Duration(days: 3);

  Future<void> refreshAlarmPermission() async {
    final allowed = await RestAlarm.instance.notificationsAllowed();
    if (allowed == alarmAllowed) return;
    alarmAllowed = allowed;
    notifyListeners();
  }

  Future<void> askAlarmPermission({bool force = false}) async {
    if (await RestAlarm.instance.notificationsAllowed()) {
      if (!alarmAllowed) {
        alarmAllowed = true;
        notifyListeners();
      }
      return;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    final last = alarmAskedAt;
    if (!force && last != null && now - last < _askAgainAfter.inMilliseconds) {
      alarmAllowed = false;
      notifyListeners();
      return;
    }
    alarmAskedAt = now;
    _persist();
    alarmAllowed = await RestAlarm.instance.requestPermission();
    notifyListeners();
  }

  Future<void> openNotificationSettings() =>
      AppSettings.openAppSettings(type: AppSettingsType.notification);
}
