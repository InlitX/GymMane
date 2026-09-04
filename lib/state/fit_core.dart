part of 'fit_state.dart';

String fmt(num n) {
  if (n == n.round()) return n.round().toString();
  return n.toString();
}

double _round1(double n) => (n * 10).round() / 10;
double _round3(double n) => (n * 1000).round() / 1000;
double _roundTo(double n, double step) => (n / step).round() * step;
DateTime _dayKey(DateTime d) => DateTime(d.year, d.month, d.day);

/// Sumar días con Duration se queda corto en el cambio de hora; el calendario no.
DateTime shiftDays(DateTime d, int n) => DateTime(d.year, d.month, d.day + n);

/// Con horario de verano por medio, restar dos DateTime locales se queda corto.
int daysBetween(DateTime from, DateTime to) =>
    DateTime.utc(to.year, to.month, to.day)
        .difference(DateTime.utc(from.year, from.month, from.day))
        .inDays;

const int kHeatmapDays = 84;

const int heatLevels = 4;

/// 0 = untouched, 4 = at or over the target for the period.
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
  final List<Exercise> customExercises = [];
  final List<GymPlace> places = [];

  /// Media propio del usuario por ejercicio: id -> fichero en MediaStore.
  final Map<String, String> exerciseMedia = {};

  /// Ejercicios que el usuario marca como "solo repeticiones", sin peso.
  final Map<String, int> exerciseRest = {};

  final Set<String> repsOnly = {};

  /// Los que ha desmarcado a mano, para no volver a deducirlo por el material.
  final Set<String> repsOnlyOff = {};
  VoidCallback? onWidgetsShouldUpdate;

  void _refreshWidgets() {
    try {
      onWidgetsShouldUpdate?.call();
    } catch (_) {}
  }

  String units = 'kg';
  bool _loading = false;
  Timer? _saveDebounce;

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

  double get weightStep => isLb ? 5 : 2.5;
  String get volumeUnit => isLb ? 'k lb' : 't';

  String volumeValue(double kg) => fmt(_round1(toDisplayWeight(kg) / 1000));

  String volumeLabel(double kg) => '${volumeValue(kg)} $volumeUnit';
}
