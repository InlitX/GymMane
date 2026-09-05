part of 'fit_state.dart';

mixin ToolsState on FitCore {
  String? activeToolId;
  double rmWeight = 100;
  int rmReps = 5;
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
  }

  void goTools() => pushRoute('tools');

  void openTool(String id) {
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

  List<double> get _plateSteps =>
      isLb ? const [45, 35, 25, 10, 5, 2.5] : const [25, 20, 15, 10, 5, 2.5, 1.25];

  List<({double weight, int count})> get plateBreakdown {
    final target = toDisplayWeight(plateTarget);
    final bar = toDisplayWeight(plateBar);
    double perSide = math.max(0, (target - bar) / 2);
    final out = <({double weight, int count})>[];
    for (final p in _plateSteps) {
      final count = (perSide / p + 1e-6).floor();
      if (count > 0) {
        out.add((weight: p, count: count));
        perSide = _round1(perSide - count * p);
      }
    }
    return out;
  }

  double get defaultBar => isLb ? 45 : 20;

  List<({double weight, int count})> platesPerSide(double displayTarget, double displayBar) {
    double perSide = math.max(0, (displayTarget - displayBar) / 2);
    final out = <({double weight, int count})>[];
    for (final p in _plateSteps) {
      final count = (perSide / p + 1e-6).floor();
      if (count > 0) {
        out.add((weight: p, count: count));
        perSide = _round1(perSide - count * p);
      }
    }
    return out;
  }

  String? plateHint(String equipment, double weightKg) {
    if (equipment != 'Barbell') return null;
    final target = _round1(toDisplayWeight(weightKg));
    if (target <= defaultBar) return null;
    final parts = platesPerSide(target, defaultBar);
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

  void bumpWarmupTarget(double d) { warmupTarget = _clamp(warmupTarget + d, 0, null); notifyListeners(); }
}
