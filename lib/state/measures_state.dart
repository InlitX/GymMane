part of 'fit_state.dart';

const double _cmPerInch = 2.54;

mixin MeasuresState on FitCore {
  final List<CustomMeasure> customMeasures = [];
  final Set<String> sidedMeasures = {};
  int measureEveryDays = 0;

  bool isPressure(String key) => key == 'bp';

  bool canSide(String key) => kSidedMeasureKeys.contains(key);

  bool isSidedMeasure(String key) => canSide(key) && sidedMeasures.contains(key);

  void toggleSidedMeasure(String key) {
    if (!canSide(key)) return;
    if (!sidedMeasures.remove(key)) sidedMeasures.add(key);
    _persist();
    notifyListeners();
  }

  bool get isInches => lengthUnits.isEmpty ? units == 'lb' : lengthUnits == 'in';

  String get lengthUnit => isInches ? 'in' : 'cm';

  List<String> get allMeasureKeys => [...kMeasureKeys, for (final c in customMeasures) c.id];

  CustomMeasure? customMeasure(String key) {
    for (final c in customMeasures) {
      if (c.id == key) return c;
    }
    return null;
  }

  bool isCustomMeasure(String key) => customMeasure(key) != null;

  bool isFreeMeasure(String key) => customMeasure(key)?.length == false;

  String measureTitle(String key) => customMeasure(key)?.name ?? t.measureName(key);

  bool isPercent(String key) => key == 'bodyfat';

  bool _plain(String key) => isPercent(key) || isPressure(key) || isFreeMeasure(key) || !isInches;

  double toDisplayMeasure(String key, double raw) => _plain(key) ? raw : raw / _cmPerInch;

  double fromDisplayMeasure(String key, double shown) => _plain(key) ? shown : shown * _cmPerInch;

  double toDisplayCm(double cm) => isInches ? cm / _cmPerInch : cm;

  double fromDisplayCm(double shown) => isInches ? shown * _cmPerInch : shown;

  String cmLabel(double cm) => '${fmt(_round1(toDisplayCm(cm)))} $lengthUnit';

  String heightLabel(double cm) {
    if (!isInches) return '${fmt(cm.round())} cm';
    final inches = (cm / _cmPerInch).round();
    return '${inches ~/ 12}′ ${inches % 12}″';
  }

  double get heightStep => isInches ? _cmPerInch : 1;

  double get cmStep => isInches ? _cmPerInch / 2 : 1;

  double get girthStep => isInches ? _cmPerInch / 4 : 0.5;

  String measureUnit(String key) {
    if (isPercent(key)) return '%';
    if (isPressure(key)) return 'mmHg';
    final c = customMeasure(key);
    if (c != null && !c.length) return c.unit;
    return lengthUnit;
  }

  String measureValue(String key, double raw) => fmt(_round1(toDisplayMeasure(key, raw)));

  String measureLabel(String key, double raw) {
    final unit = measureUnit(key);
    return unit.isEmpty ? measureValue(key, raw) : '${measureValue(key, raw)} $unit';
  }

  String measureHeadline(BodyMeasure m) =>
      isPressure(m.key) && m.low != null ? '${m.value.round()}/${m.low!.round()}' : measureValue(m.key, m.value);

  String measureEntryLabel(BodyMeasure m) {
    final unit = measureUnit(m.key);
    if (isPressure(m.key)) {
      final bp = '${measureHeadline(m)} $unit';
      return m.pulse == null ? bp : '$bp · ${m.pulse} ${t.healthBpm}';
    }
    if (m.sided) {
      return '${t.measureLeftShort} ${measureValue(m.key, m.left!)} · ${t.measureRightShort} ${measureValue(m.key, m.right!)} $unit';
    }
    return measureLabel(m.key, m.value);
  }

  List<BodyMeasure> measureHistory(String key) {
    final out = measures.where((m) => m.key == key).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return out;
  }

  double lastGirth(String key) => latestMeasure(key)?.value ?? 0;

  BodyMeasure? latestMeasure(String key) {
    final h = measureHistory(key);
    return h.isEmpty ? null : h.first;
  }

  double? measureChange(String key) {
    if (isPressure(key)) return null;
    final h = measureHistory(key);
    if (h.length < 2) return null;
    return _round1(toDisplayMeasure(key, h.first.value) - toDisplayMeasure(key, h[1].value));
  }

  List<double> measureSeries(String key) =>
      measureHistory(key).reversed.map((m) => toDisplayMeasure(key, m.value)).toList();

  List<String> get trackedMeasures =>
      allMeasureKeys.where((k) => latestMeasure(k) != null).toList();

  bool get hasMeasures => measures.isNotEmpty;

  void addMeasure(String key, double shown, {DateTime? date, String note = '', double? left, double? right}) {
    if (!allMeasureKeys.contains(key) || isPressure(key)) return;
    final both = left != null && right != null && left > 0 && right > 0;
    if (!both && shown <= 0) return;
    final when = date ?? DateTime.now();
    double raw(double v) => isFreeMeasure(key) ? (v * 100).round() / 100 : _round1(fromDisplayMeasure(key, v));
    final l = both ? raw(left) : null;
    final r = both ? raw(right) : null;
    final value = both ? _round1((l! + r!) / 2) : raw(shown);
    measures.removeWhere((m) => m.key == key && _dayKey(m.date) == _dayKey(when));
    measures.add(BodyMeasure(when, key, value, note: _cut(note.trim(), 200), left: l, right: r));
    _syncMeasureReminder();
    _persist();
    notifyListeners();
  }

  void addPressure(int high, int low, {int? pulse, String note = '', DateTime? date}) {
    if (high <= 0 || low <= 0) return;
    final when = date ?? DateTime.now();
    measures.removeWhere((m) => m.key == 'bp' && m.date.difference(when).inMinutes.abs() < 1);
    measures.add(BodyMeasure(when, 'bp', high.toDouble(),
        low: low.toDouble(), pulse: pulse != null && pulse > 0 ? pulse : null, note: _cut(note.trim(), 200)));
    _syncMeasureReminder();
    _persist();
    notifyListeners();
  }

  void deleteMeasure(BodyMeasure m) {
    measures.remove(m);
    _syncMeasureReminder();
    _persist();
    notifyListeners();
  }

  String addCustomMeasure(String name, {String unit = '', bool length = true}) {
    final clean = name.trim();
    if (clean.isEmpty) return '';
    var id = 'c${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';
    while (customMeasure(id) != null) {
      id = '${id}x';
    }
    customMeasures.add(CustomMeasure(id, _cut(clean, 40), unit: _cut(unit.trim(), 8), length: length));
    _persist();
    notifyListeners();
    return id;
  }

  void editCustomMeasure(String id, {String? name, String? unit}) {
    final c = customMeasure(id);
    if (c == null) return;
    if (name != null && name.trim().isNotEmpty) c.name = _cut(name.trim(), 40);
    if (unit != null && !c.length) c.unit = _cut(unit.trim(), 8);
    _persist();
    notifyListeners();
  }

  void deleteCustomMeasure(String id) {
    customMeasures.removeWhere((c) => c.id == id);
    measures.removeWhere((m) => m.key == id);
    _syncMeasureReminder();
    _persist();
    notifyListeners();
  }

  String _cut(String v, int max) => v.length > max ? v.substring(0, max) : v;

  DateTime? get lastMeasureDay {
    DateTime? last;
    for (final m in measures) {
      if (last == null || m.date.isAfter(last)) last = m.date;
    }
    return last == null ? null : DateTime(last.year, last.month, last.day);
  }

  DateTime? get nextMeasureDue {
    if (measureEveryDays <= 0) return null;
    final last = lastMeasureDay;
    if (last == null) return null;
    return DateTime(last.year, last.month, last.day + measureEveryDays);
  }

  int? get daysUntilMeasure {
    final due = nextMeasureDue;
    if (due == null) return null;
    final now = DateTime.now();
    return due.difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  void setMeasureEvery(int days) {
    measureEveryDays = days <= 0 ? 0 : days.clamp(1, 365);
    _syncMeasureReminder();
    _persist();
    notifyListeners();
  }

  void syncMeasureReminder() => _syncMeasureReminder();

  void _syncMeasureReminder() {
    final due = nextMeasureDue;
    if (due == null) {
      ProgressReminder.instance.cancelMeasure();
      return;
    }
    ProgressReminder.instance.scheduleMeasure(due, measureEveryDays);
  }

  void loadCustomMeasures(Map<String, dynamic> data) {
    customMeasures
      ..clear()
      ..addAll([
        for (final e in (data['customMeasures'] as List?) ?? const [])
          if (e is Map) ?CustomMeasure.fromJson(e.cast<String, dynamic>()),
      ]);
    measureEveryDays = ((data['measureEvery'] as num?)?.toInt() ?? 0).clamp(0, 365);
    sidedMeasures
      ..clear()
      ..addAll([for (final k in (data['measureSides'] as List?) ?? const []) if (k is String && canSide(k)) k]);
  }

  Map<String, dynamic> customMeasuresJson() => {
        if (customMeasures.isNotEmpty) 'customMeasures': customMeasures.map((c) => c.toJson()).toList(),
        if (measureEveryDays > 0) 'measureEvery': measureEveryDays,
        if (sidedMeasures.isNotEmpty) 'measureSides': sidedMeasures.toList(),
      };

  void goMeasures() => pushRoute('measures');

  void backFromMeasures() => popRoute(fallback: 'progress');
}
