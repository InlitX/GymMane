part of 'fit_state.dart';

mixin SettingsState on FitCore, ToolsState {
  bool dark = true;
  ThemeMode get themeMode => dark ? ThemeMode.dark : ThemeMode.light;
  int restSeconds = 90;
  String? alarmSound;
  String? alarmSoundName;

  String? get alarmSoundPath => AlarmStore.pathFor(alarmSound);

  String bgPattern = 'dots';
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
    if (name != null) profile.name = name.trim().isEmpty ? 'InlitX' : name.trim();
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

  void completeOnboarding() {
    onboarded = true;
    persistNow();
    notifyListeners();
  }

  void setRestSeconds(int v) {
    restSeconds = v.clamp(15, 600);
    _persist();
    notifyListeners();
  }

  int restFor(String exerciseId) => exerciseRest[exerciseId] ?? restSeconds;

  bool hasCustomRest(String exerciseId) => exerciseRest.containsKey(exerciseId);

  void setExerciseRest(String exerciseId, int? seconds) {
    if (seconds == null) {
      exerciseRest.remove(exerciseId);
    } else {
      exerciseRest[exerciseId] = seconds.clamp(15, 600);
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

  void setBgPattern(String v) {
    if (v != 'none' && v != 'dots' && v != 'grid') return;
    bgPattern = v;
    _persist();
    notifyListeners();
  }

  /// Si dice que no, no se insiste en el momento: se vuelve a preguntar en
  /// otra sesión, pasados unos días. Mientras tanto se avisa en Ajustes.
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
