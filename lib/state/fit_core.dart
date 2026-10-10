part of 'fit_state.dart';

String fmt(num n) {
  if (n == n.round()) return n.round().toString();
  return decimalText(n.toString());
}

double _round1(double n) => (n * 10).round() / 10;
double _round3(double n) => (n * 1000).round() / 1000;
double _roundTo(double n, double step) => (n / step).round() * step;
DateTime _dayKey(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime shiftDays(DateTime d, int n) => DateTime(d.year, d.month, d.day + n);

int daysBetween(DateTime from, DateTime to) =>
    DateTime.utc(to.year, to.month, to.day)
        .difference(DateTime.utc(from.year, from.month, from.day))
        .inDays;

const int kHeatmapDays = 84;

const int heatLevels = 4;

int heatLevel(double v) {
  if (v <= 0) return 0;
  if (v < 0.25) return 1;
  if (v < 0.5) return 2;
  if (v < 0.75) return 3;
  return 4;
}

abstract class FitCore extends ChangeNotifier {
  Map<String, dynamic> toJson();

  String route = 'home';
  final List<String> _routeStack = [];
  final Map<String, bool> favorites = {};

  Profile profile = Profile();

  final List<LoggedSession> sessions = [];
  final List<BodyweightEntry> bodyweight = [];
  final List<GymNote> notes = [];
  final List<BodyMeasure> measures = [];
  final List<ProgressEntry> shots = [];
  final Set<String> checkins = {};
  final List<Routine> routines = [];
  final Map<int, String> weeklyPlan = {};
  final Map<int, List<String>> planExtras = {};
  bool multiPlan = false;
  final List<Exercise> customExercises = [];
  final List<GymPlace> places = [];

  final Map<String, String> exerciseMedia = {};

  final Map<String, int> exerciseRest = {};

  final Map<String, double> progressStep = {};

  final Set<String> autoWarmup = {};

  final Set<String> repsOnly = {};

  final Set<String> repsOnlyOff = {};

  final Set<String> noSuggest = {};

  final Set<String> archived = {};

  final Set<String> levelStay = {};

  final Map<String, int> levelSeen = {};

  final Map<String, List<int>> levelShown = {};

  final Map<String, ({double target, DateTime? due})> exerciseGoals = {};

  final Map<String, Map<int, int>> videoMarks = {};

  final Map<String, double> exerciseBar = {};

  final Map<String, String> modeOverride = {};
  VoidCallback? onWidgetsShouldUpdate;

  void refreshWidgets() => _refreshWidgets();

  void _refreshWidgets() {
    try {
      onWidgetsShouldUpdate?.call();
    } catch (_) {}
  }

  void syncTrainReminder() {}

  Map<double, int>? get plateStockKg => null;

  double? get placeBarKg => null;

  String units = 'kg';
  double stepKg = 2.5;
  double stepLb = 5;
  int weekStartDay = DateTime.monday;
  bool _loading = false;
  Timer? _saveDebounce;

  void refreshAwards({bool silent = false}) {}

  void _persist() {
    if (_loading) return;
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 400), persistNow);
  }

  void persistNow() {
    _saveDebounce?.cancel();
    _saveDebounce = null;
    if (_loading) return;
    Store.instance.save(toJson());
  }

  void goHome() => _setRoute('home', reset: true);

  void goProgress() => _setRoute('progress', reset: true);

  void goExercises() => _setRoute('exercises', reset: true);

  void goSettings() => _setRoute('settings', reset: true);

  void goPreferences() => pushRoute('preferences');

  void backFromPreferences() => popRoute(fallback: 'settings');

  void _setRoute(String r, {bool reset = false}) {
    if (reset) _routeStack.clear();
    route = r;
    notifyListeners();
  }

  void pushRoute(String r) {
    if (route != r) _routeStack.add(route);
    route = r;
    notifyListeners();
  }

  void resetRoute(String r) {
    _routeStack.clear();
    route = r;
  }

  void popRoute({String fallback = 'home'}) {
    while (_routeStack.isNotEmpty) {
      final r = _routeStack.removeLast();
      if (r != route) {
        route = r;
        notifyListeners();
        return;
      }
    }
    route = fallback == route ? 'home' : fallback;
    notifyListeners();
  }

  int get routeDepth => _routeStack.length;

  bool get showNav => const ['home', 'progress', 'exercises', 'settings'].contains(route);

  void setUnits(String u) {
    units = u;
    _persist();
    notifyListeners();
  }

  static const _lbPerKg = 2.20462;
  bool get isLb => units == 'lb';

  double toDisplayWeight(double kg) => isLb ? kg * _lbPerKg : kg;

  double fromDisplayWeight(double shown) => isLb ? shown / _lbPerKg : shown;

  String weightLabel(double kg) => '${fmt(_round1(toDisplayWeight(kg)))} $units';

  String weightValue(double kg) => fmt(_round1(toDisplayWeight(kg)));

  double get weightStep => isLb ? stepLb : stepKg;
  double get plateStep => isLb ? 5 : 2.5;
  String get volumeUnit => isLb ? 'k lb' : 't';

  String volumeValue(double kg) => fmt(_round1(toDisplayWeight(kg) / 1000));

  String volumeLabel(double kg) => '${volumeValue(kg)} $volumeUnit';

  static const _kmPerMile = 1.609344;

  String get distanceUnit => isLb ? 'mi' : 'km';

  double toDisplayKm(double km) => isLb ? km / _kmPerMile : km;

  double fromDisplayKm(double shown) => isLb ? shown * _kmPerMile : shown;

  String distanceValue(double km) => fmt((toDisplayKm(km) * 100).round() / 100);

  String distanceLabel(double km) => '${distanceValue(km)} $distanceUnit';

  double get distanceStep => 0.1;
}

String durationLabel(int sec) {
  final s = sec < 0 ? 0 : sec;
  final h = s ~/ 3600;
  final m = (s % 3600) ~/ 60;
  final r = (s % 60).toString().padLeft(2, '0');
  return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$r' : '$m:$r';
}
