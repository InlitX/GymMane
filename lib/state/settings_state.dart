part of 'fit_state.dart';

const String kBgPhotoId = 'bg';

mixin SettingsState on FitCore, ToolsState, LibraryState {
  bool dark = true;
  ThemeMode get themeMode => dark ? ThemeMode.dark : ThemeMode.light;
  int restSeconds = 90;
  String? alarmSound;
  String? alarmSoundName;

  String? get alarmSoundPath => AlarmStore.pathFor(alarmSound);

  String bgPattern = 'dots';
  double bgDim = 0.55;
  bool showFocus = true;
  bool autoAdvance = true;
  bool logRpe = false;
  int? trainReminderMin;
  bool smartReminder = false;
  bool onboarded = false;
  bool alarmAllowed = true;
  int? alarmAskedAt;
  String language = 'en';

  Locale get locale => Locale(language);

  void _adoptDeviceLanguage() =>
      _applyLanguage(PlatformDispatcher.instance.locale.languageCode);

  void _applyLanguage(String code) {
    setAppLanguage(code);
    language = appLanguage;
  }

  void toggleTheme() {
    dark = !dark;
    _persist();
    _refreshWidgets();
    notifyListeners();
  }

  void setThemeDark() {
    dark = true;
    _persist();
    _refreshWidgets();
    notifyListeners();
  }

  void setThemeLight() {
    dark = false;
    _persist();
    _refreshWidgets();
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

  int restFor(String exerciseId) => exerciseRest[exerciseId] ?? restSeconds;

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

  void toggleAutoAdvance() {
    autoAdvance = !autoAdvance;
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
