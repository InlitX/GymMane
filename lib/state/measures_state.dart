part of 'fit_state.dart';

const double _cmPerInch = 2.54;

mixin MeasuresState on FitCore {
  bool get isInches => units == 'lb';

  String get lengthUnit => isInches ? 'in' : 'cm';

  bool isPercent(String key) => key == 'bodyfat';

  double toDisplayMeasure(String key, double raw) =>
      isPercent(key) || !isInches ? raw : raw / _cmPerInch;

  double fromDisplayMeasure(String key, double shown) =>
      isPercent(key) || !isInches ? shown : shown * _cmPerInch;

  double toDisplayCm(double cm) => isInches ? cm / _cmPerInch : cm;

  double fromDisplayCm(double shown) => isInches ? shown * _cmPerInch : shown;

  String cmLabel(double cm) => '${fmt(_round1(toDisplayCm(cm)))} $lengthUnit';

  double get cmStep => isInches ? _cmPerInch / 2 : 1;

  double get girthStep => isInches ? _cmPerInch / 4 : 0.5;

  String measureUnit(String key) => isPercent(key) ? '%' : lengthUnit;

  String measureValue(String key, double raw) => fmt(_round1(toDisplayMeasure(key, raw)));

  String measureLabel(String key, double raw) => '${measureValue(key, raw)} ${measureUnit(key)}';

  List<BodyMeasure> measureHistory(String key) {
    final out = measures.where((m) => m.key == key).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return out;
  }

  BodyMeasure? latestMeasure(String key) {
    final h = measureHistory(key);
    return h.isEmpty ? null : h.first;
  }

  double? measureChange(String key) {
    final h = measureHistory(key);
    if (h.length < 2) return null;
    return _round1(toDisplayMeasure(key, h.first.value) - toDisplayMeasure(key, h[1].value));
  }

  List<double> measureSeries(String key) =>
      measureHistory(key).reversed.map((m) => toDisplayMeasure(key, m.value)).toList();

  List<String> get trackedMeasures =>
      kMeasureKeys.where((k) => latestMeasure(k) != null).toList();

  bool get hasMeasures => measures.isNotEmpty;

  void addMeasure(String key, double shown, {DateTime? date}) {
    if (!kMeasureKeys.contains(key) || shown <= 0) return;
    final when = date ?? DateTime.now();
    final raw = _round1(fromDisplayMeasure(key, shown));
    measures.removeWhere((m) => m.key == key && _dayKey(m.date) == _dayKey(when));
    measures.add(BodyMeasure(when, key, raw));
    _persist();
    notifyListeners();
  }

  void deleteMeasure(BodyMeasure m) {
    measures.remove(m);
    _persist();
    notifyListeners();
  }

  void goMeasures() => pushRoute('measures');

  void backFromMeasures() => popRoute(fallback: 'progress');
}
