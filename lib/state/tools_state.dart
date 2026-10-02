part of 'fit_state.dart';

mixin ToolsState on FitCore {
  String? activeToolId;
  double rmWeight = 100;
  int rmReps = 5;
  int rmPct = 75;
  double bmiHeight = 175;
  double bmiWeight = 75;
  int calAge = 28;
  double calHeight = 175;
  double calWeight = 75;
  String calSex = 'male';
  double calActivity = 1.55;
  String bfSex = 'male';
  double bfHeight = 175;
  double bfNeck = 38;
  double bfWaist = 84;
  double bfHip = 95;
  double plateTarget = 100;
  double plateBar = 20;
  double warmupTarget = 100;
  double rpeWeight = 100;
  int rpeReps = 5;
  double rpeRpe = 8;
  int rpeTargetReps = 3;
  double rpeTargetRpe = 9;
  String dotsSex = 'male';
  double dotsBody = 80;
  double dotsSquat = 140;
  double dotsBench = 100;
  double dotsDeadlift = 180;
  bool _dotsSeeded = false;

  static const dotsLifts = ['qXTaZnJ', 'EIeI8Vf', 'ila4NZS'];

  void _seedCalculatorsFromProfile() {
    calAge = profile.age;
    calHeight = profile.heightCm;
    calWeight = profile.weightKg;
    calSex = profile.sex;
    calActivity = profile.activity;
    bmiHeight = profile.heightCm;
    bmiWeight = profile.weightKg;
    bfHeight = profile.heightCm;
    bfSex = profile.sex;
    dotsBody = profile.weightKg;
    dotsSex = profile.sex;
  }

  double bestLift(String id) => 0;

  void _seedDots() {
    if (_dotsSeeded) return;
    _dotsSeeded = true;
    final best = [for (final id in dotsLifts) bestLift(id)];
    if (best[0] > 0) dotsSquat = _round1(best[0]);
    if (best[1] > 0) dotsBench = _round1(best[1]);
    if (best[2] > 0) dotsDeadlift = _round1(best[2]);
  }

  void goTools() => pushRoute('tools');

  void openTool(String id) {
    if (id == 'dots') _seedDots();
    activeToolId = id;
    pushRoute('tools-detail');
  }

  void closeTool() => popRoute(fallback: 'tools');

  void backFromTools() => popRoute();

  double get rmResult => _round1(rmWeight * (1 + rmReps / 30));

  double get bmiVal => _round1(bmiWeight / math.pow(bmiHeight / 100, 2));

  String get bmiCat {
    final v = bmiVal;
    if (v < 18.5) return 'Underweight';
    if (v < 25) return 'Normal';
    if (v < 30) return 'Overweight';
    return 'Obese';
  }

  double get _bmr => calSex == 'male'
      ? 10 * calWeight + 6.25 * calHeight - 5 * calAge + 5
      : 10 * calWeight + 6.25 * calHeight - 5 * calAge - 161;

  int get tdee => (_bmr * calActivity).round();

  int get calProtein => (tdee * 0.3 / 4).round();

  int get calCarbs => (tdee * 0.4 / 4).round();

  int get calFat => (tdee * 0.3 / 9).round();

  String get activityLabel {
    if (calActivity == 1.2) return 'Sedentary';
    if (calActivity == 1.375) return 'Light';
    if (calActivity == 1.725) return 'Active';
    return 'Moderate';
  }

  double _log10(double x) => math.log(x) / math.ln10;

  double get bfVal {
    double v;

    if (bfSex == 'male') {
      final girth = math.max(1.0, bfWaist - bfNeck);
      v = 495 / (1.0324 - 0.19077 * _log10(girth) + 0.15456 * _log10(bfHeight)) - 450;
    } else {
      final girth = math.max(1.0, bfWaist + bfHip - bfNeck);
      v = 495 / (1.29579 - 0.35004 * _log10(girth) + 0.221 * _log10(bfHeight)) - 450;
    }
    return _round1(math.max(3, math.min(50, v)));
  }

  List<double> get barOptions => isLb ? const [45, 35, 15] : const [20, 15, 10];

  List<double> get plateSizes => _plateSteps;

  List<double> get _plateSteps =>
      isLb ? const [45, 35, 25, 10, 5, 2.5] : const [25, 20, 15, 10, 5, 2.5, 1.25];

  List<({double weight, int count})> get plateBreakdown =>
      platesPerSide(toDisplayWeight(plateTarget), toDisplayWeight(plateBar));

  double get defaultBar {
    final placeBar = placeBarKg;
    if (placeBar != null) return _round1(toDisplayWeight(placeBar));
    return isLb ? 45 : 20;
  }

  Map<double, int>? get plateStockDisplay {
    final stock = plateStockKg;
    if (stock == null) return null;
    return {for (final e in stock.entries) _round1(toDisplayWeight(e.key)): e.value};
  }

  List<({double weight, int count})> platesPerSide(double displayTarget, double displayBar) {
    final stock = plateStockDisplay;
    final steps = stock == null
        ? _plateSteps
        : (stock.keys.toList()..sort((a, b) => b.compareTo(a)));
    double perSide = math.max(0, (displayTarget - displayBar) / 2);
    final out = <({double weight, int count})>[];
    for (final p in steps) {
      var count = (perSide / p + 1e-6).floor();
      if (stock != null) count = math.min(count, stock[p] ?? 0);
      if (count > 0) {
        out.add((weight: p, count: count));
        perSide = _round1(perSide - count * p);
      }
    }
    return out;
  }

  double loadableTotal(double displayTarget, double displayBar) {
    final parts = platesPerSide(displayTarget, displayBar);
    return _round1(displayBar + parts.fold<double>(0, (a, p) => a + p.weight * p.count) * 2);
  }

  bool hasOwnBar(String id) => exerciseBar.containsKey(id);

  double barFor(String id, {String equipment = 'Barbell'}) {
    final kg = exerciseBar[id];
    if (kg != null) return _round1(toDisplayWeight(kg));
    return equipment == 'Barbell' ? defaultBar : 0;
  }

  void setExerciseBar(String id, double? displayKg) {
    if (displayKg == null) {
      exerciseBar.remove(id);
    } else {
      exerciseBar[id] = fromDisplayWeight(displayKg.clamp(0, isLb ? 1100 : 500).toDouble());
    }
    _persist();
    notifyListeners();
  }

  String? plateHint(String equipment, double weightKg, {String id = ''}) {
    if (equipment != 'Barbell' && !hasOwnBar(id)) return null;
    final bar = barFor(id, equipment: equipment);
    final target = _round1(toDisplayWeight(weightKg));
    if (target <= bar) return null;
    final parts = platesPerSide(target, bar);
    if (parts.isEmpty) return null;
    return parts
        .map((p) => p.count == 1 ? fmt(p.weight) : '${fmt(p.weight)}×${p.count}')
        .join(' · ');
  }

  List<({String pct, int reps, double weight})> get warmupSets {
    const spec = [(40, 10), (60, 5), (80, 3), (90, 1)];
    final step = isLb ? 5.0 : 2.5;
    final target = toDisplayWeight(warmupTarget);
    return spec
        .map((s) => (
              pct: '${s.$1}%',
              reps: s.$2,
              weight: _roundTo(target * s.$1 / 100, step),
            ))
        .toList();
  }

  void bumpTool(void Function() apply) {
    apply();
    notifyListeners();
  }

  double _clamp(double v, double? min, double? max) {
    if (min != null) v = math.max(min, v);
    if (max != null) v = math.min(max, v);
    return (v * 100).round() / 100;
  }

  void bumpRmWeight(double d) { rmWeight = _clamp(rmWeight + d, 0, null); notifyListeners(); }

  void bumpRmPct(int d) { rmPct = (rmPct + d).clamp(30, 100); notifyListeners(); }

  double get rmAtPct {
    final target = toDisplayWeight(rmResult * rmPct / 100);
    final bar = defaultBar;
    return target <= bar ? _roundTo(target, isLb ? 5.0 : 2.5) : loadableTotal(target, bar);
  }

  void bumpRmReps(int d) { rmReps = _clamp(rmReps + d.toDouble(), 1, 20).round(); notifyListeners(); }

  void bumpBmiHeight(double d) { bmiHeight = _clamp(bmiHeight + d, 100, 250); notifyListeners(); }

  void bumpBmiWeight(double d) { bmiWeight = _clamp(bmiWeight + d, 30, 250); notifyListeners(); }

  void bumpCalAge(int d) { calAge = _clamp(calAge + d.toDouble(), 10, 90).round(); notifyListeners(); }

  void bumpCalHeight(double d) { calHeight = _clamp(calHeight + d, 100, 250); notifyListeners(); }

  void bumpCalWeight(double d) { calWeight = _clamp(calWeight + d, 30, 250); notifyListeners(); }

  void setCalSex(String s) { calSex = s; notifyListeners(); }

  void setCalActivity(double a) { calActivity = a; notifyListeners(); }

  void bumpBfHeight(double d) { bfHeight = _clamp(bfHeight + d, 100, 250); notifyListeners(); }

  void bumpBfNeck(double d) { bfNeck = _clamp(bfNeck + d, 20, 60); notifyListeners(); }

  void bumpBfWaist(double d) { bfWaist = _clamp(bfWaist + d, 40, 200); notifyListeners(); }

  void bumpBfHip(double d) { bfHip = _clamp(bfHip + d, 40, 200); notifyListeners(); }

  void setBfSex(String s) { bfSex = s; notifyListeners(); }

  void bumpPlateTarget(double d) { plateTarget = _clamp(plateTarget + d, 0, null); notifyListeners(); }

  void setPlateBar(double b) { plateBar = fromDisplayWeight(b); notifyListeners(); }

  double get plateBarDisplay => _round1(toDisplayWeight(plateBar));

  static double _effortShare(int reps, double rpe) => rpePercent(reps, rpe) ?? 1 / (1 + reps / 30);

  double get rpeOneRm => _round1(rpeWeight / _effortShare(rpeReps, rpeRpe));

  double get rpeResult {
    final kg = rpeOneRm * _effortShare(rpeTargetReps, rpeTargetRpe);
    return fromDisplayWeight(_roundTo(toDisplayWeight(kg), isLb ? 5.0 : 2.5));
  }

  void bumpRpeWeight(double d) { rpeWeight = _clamp(rpeWeight + d, 0, null); notifyListeners(); }

  void bumpRpeReps(int d) { rpeReps = (rpeReps + d).clamp(1, 12); notifyListeners(); }

  void bumpRpe(double d) { rpeRpe = (rpeRpe + d).clamp(6, 10).toDouble(); notifyListeners(); }

  void bumpRpeTargetReps(int d) { rpeTargetReps = (rpeTargetReps + d).clamp(1, 12); notifyListeners(); }

  void bumpRpeTarget(double d) { rpeTargetRpe = (rpeTargetRpe + d).clamp(6, 10).toDouble(); notifyListeners(); }

  double get dotsTotal => dotsSquat + dotsBench + dotsDeadlift;

  double get dotsScore {
    final male = dotsSex == 'male';
    final bw = dotsBody.clamp(40, male ? 210 : 150).toDouble();
    final c = male
        ? const [-307.75076, 24.0900756, -0.1918759221, 0.0007391293, -0.000001093]
        : const [-57.96288, 13.6175032, -0.1126655495, 0.0005158568, -0.0000010706];
    final den = c[0] + c[1] * bw + c[2] * bw * bw + c[3] * math.pow(bw, 3) + c[4] * math.pow(bw, 4);
    return _round1(dotsTotal * 500 / den);
  }

  int get dotsLevel {
    final s = dotsScore;
    if (s < 250) return 0;
    if (s < 325) return 1;
    if (s < 400) return 2;
    if (s < 475) return 3;
    return 4;
  }

  void setDotsSex(String s) { dotsSex = s; notifyListeners(); }

  void bumpDotsBody(double d) { dotsBody = _clamp(dotsBody + d, 30, 250); notifyListeners(); }

  void bumpDotsSquat(double d) { dotsSquat = _clamp(dotsSquat + d, 0, null); notifyListeners(); }

  void bumpDotsBench(double d) { dotsBench = _clamp(dotsBench + d, 0, null); notifyListeners(); }

  void bumpDotsDeadlift(double d) { dotsDeadlift = _clamp(dotsDeadlift + d, 0, null); notifyListeners(); }

  void bumpWarmupTarget(double d) { warmupTarget = _clamp(warmupTarget + d, 0, null); notifyListeners(); }
}
