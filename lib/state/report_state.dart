part of 'fit_state.dart';

typedef ReportLift = ({String id, String name, int sessions, int sets, double volume, double best, double? change});
typedef ReportRecord = ({String id, String name, double kg, DateTime date});
typedef ReportFood = ({int days, double kcal, double protein, double carbs, double fat, int waterMl});

enum ReportSection { workouts, nutrition, steps, supplements, weighIns, sleep, sessions }

class RangeReport {
  RangeReport({
    required this.from,
    required this.to,
    required this.sessions,
    required this.sets,
    required this.volume,
    required this.minutes,
    required this.activeDays,
    required this.lifts,
    required this.records,
    required this.muscles,
    this.weightFrom,
    this.weightTo,
    this.food,
    this.sleep,
    this.energy,
    this.prev,
  });

  final DateTime from;
  final DateTime to;
  final int sessions;
  final int sets;
  final double volume;
  final int minutes;
  final int activeDays;
  final List<ReportLift> lifts;
  final List<ReportRecord> records;
  final List<({String muscle, double sets})> muscles;
  final double? weightFrom;
  final double? weightTo;
  final ReportFood? food;
  final double? sleep;
  final double? energy;
  final ({int sessions, int sets, double volume})? prev;

  int get days => to.difference(from).inDays + 1;
  double get perWeek => sessions / math.max(1, days) * 7;
  bool get empty => sessions == 0 && food == null && weightFrom == null;
}

mixin ReportState
    on
        FitCore,
        ToolsState,
        LibraryState,
        SettingsState,
        TimelineState,
        StatsState,
        StepsState,
        HealthState,
        NutritionState {
  RangeReport rangeReport(DateTime from, DateTime to) {
    final a = _dayKey(from), b = _dayKey(to);
    final end = shiftDays(b, 1);
    bool inside(DateTime d) => !d.isBefore(a) && d.isBefore(end);
    final picked = [for (final s in sessions) if (inside(s.day)) s];

    var sets = 0, seconds = 0;
    var volume = 0.0;
    final days = <DateTime>{};
    final perLift = <String, List<(DateTime, LoggedExercise)>>{};
    for (final s in picked) {
      sets += s.setCount;
      volume += s.volume;
      seconds += s.durationSec;
      days.add(_dayKey(s.day));
      for (final e in s.exercises) {
        if (e.workingSets.isEmpty) continue;
        (perLift[e.id] ??= []).add((s.date, e));
      }
    }

    final lifts = <ReportLift>[];
    final records = <ReportRecord>[];
    for (final MapEntry(key: id, value: list) in perLift.entries) {
      final ex = exerciseById(id);
      final name = ex == null ? list.first.$2.name : t.catalogName(ex.id, ex.name);
      final best = list.map((x) => x.$2.bestOneRm).fold(0.0, math.max);
      final first = list.first.$2.bestOneRm, last = list.last.$2.bestOneRm;
      lifts.add((
        id: id,
        name: name,
        sessions: list.length,
        sets: list.fold(0, (n, x) => n + x.$2.workingSets.length),
        volume: list.fold(0.0, (v, x) => v + x.$2.volume),
        best: best,
        change: list.length >= 2 && first > 0 && last > 0 ? (last / first - 1) * 100 : null,
      ));
      var before = 0.0;
      var seen = false;
      for (final s in sessions) {
        if (!s.day.isBefore(a)) break;
        for (final e in s.exercises) {
          if (e.id != id) continue;
          seen = true;
          before = math.max(before, e.topWeight);
        }
      }
      if (!seen) continue;
      (DateTime, double)? top;
      for (final (date, e) in list) {
        final w = e.topWeight;
        if (w > before && (top == null || w > top.$2)) top = (date, w);
      }
      if (top != null) records.add((id: id, name: name, kg: top.$2, date: top.$1));
    }
    lifts.sort((x, y) => y.sets.compareTo(x.sets));
    records.sort((x, y) => x.date.compareTo(y.date));

    final muscles = [
      for (final MapEntry(key: m, value: v) in muscleSetsBetween(a, b).entries)
        if (v > 0) (muscle: m, sets: v),
    ]..sort((x, y) => y.sets.compareTo(x.sets));

    final weights = [for (final w in bodyweight) if (inside(w.date)) w]..sort((x, y) => x.date.compareTo(y.date));

    ReportFood? food;
    if (nutritionBeta) {
      var n = 0;
      var water = 0;
      var total = Macros.zero;
      for (var d = a; !d.isAfter(b); d = shiftDays(d, 1)) {
        final list = entriesOn(d);
        if (list.isEmpty) continue;
        n++;
        total = total + totalOn(d);
        water += waterOn(d);
      }
      if (n > 0) {
        food = (
          days: n,
          kcal: total.kcal / n,
          protein: total.protein / n,
          carbs: total.carbs / n,
          fat: total.fat / n,
          waterMl: water ~/ n,
        );
      }
    }

    double? avg(Iterable<int?> v) {
      final l = v.nonNulls.toList();
      return l.isEmpty ? null : l.reduce((x, y) => x + y) / l.length;
    }

    final span = b.difference(a).inDays + 1;
    final pa = shiftDays(a, -span);
    final previous = [for (final s in sessions) if (!s.day.isBefore(pa) && s.day.isBefore(a)) s];

    return RangeReport(
      from: a,
      to: b,
      sessions: picked.length,
      sets: sets,
      volume: volume,
      minutes: seconds ~/ 60,
      activeDays: days.length,
      lifts: lifts,
      records: records,
      muscles: muscles,
      weightFrom: weights.isEmpty ? null : weights.first.kg,
      weightTo: weights.length < 2 ? null : weights.last.kg,
      food: food,
      sleep: avg(picked.map((s) => s.sleep)),
      energy: avg(picked.map((s) => s.energy)),
      prev: previous.isEmpty
          ? null
          : (
              sessions: previous.length,
              sets: previous.fold(0, (n, s) => n + s.setCount),
              volume: previous.fold(0.0, (v, s) => v + s.volume),
            ),
    );
  }

  String reportWorkoutsCsv(RangeReport r) {
    return Store.instance.exportCsv(_reportSessions(r).toList());
  }

  bool _inReport(RangeReport r, DateTime date) {
    final day = _dayKey(date);
    return !day.isBefore(r.from) && !day.isAfter(r.to);
  }

  Iterable<LoggedSession> _reportSessions(RangeReport r) {
    final end = shiftDays(r.to, 1);
    return sessions.where((s) => !s.day.isBefore(r.from) && s.day.isBefore(end));
  }

  Iterable<DateTime> _reportDates(RangeReport r) sync* {
    for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1)) {
      yield d;
    }
  }

  String reportSectionCsv(RangeReport r, ReportSection section) => switch (section) {
    ReportSection.workouts => reportWorkoutsCsv(r),
    ReportSection.nutrition => reportNutritionCsv(r),
    ReportSection.steps => _reportCsv('date,steps', [
      for (final day in _reportDates(r)) [HealthMetrics.dayKey(day), stepsByDay[HealthMetrics.dayKey(day)]],
    ]),
    ReportSection.supplements => _reportSupplementsCsv(r),
    ReportSection.weighIns => _reportWeighInsCsv(r),
    ReportSection.sleep => _reportCsv('date,sleep_minutes', [
      for (final day in _reportDates(r))
        [HealthMetrics.dayKey(day), healthOnDay(HealthMetric.sleep, day)?.firstOrNull],
    ]),
    ReportSection.sessions => _reportSessionsCsv(r),
  };

  String _reportSupplementsCsv(RangeReport r) {
    final names = {for (final s in supplements) s.id: s.name};
    return _reportCsv('date,supplement', [
      for (final day in _reportDates(r))
        for (final id in takenOn(day))
          if (names[id] case final name?) [HealthMetrics.dayKey(day), name],
    ]);
  }

  String _reportWeighInsCsv(RangeReport r) {
    final weights = bodyweight.where((w) => _inReport(r, w.date)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return _reportCsv('date,recorded_at,weight_kg', [
      for (final w in weights) [HealthMetrics.dayKey(w.date), w.date.toIso8601String(), w.kg],
    ]);
  }

  String _reportSessionsCsv(RangeReport r) {
    final picked = _reportSessions(r).toList()..sort((a, b) => a.date.compareTo(b.date));
    return _reportCsv(
      'date,started_at,ended_at,name,duration_s,exercises,working_sets,volume_kg,'
      'hr_avg_bpm,hr_max_bpm,sleep_rating_1_5,energy_rating_1_5,deload',
      [
        for (final s in picked)
          [
            HealthMetrics.dayKey(s.day),
            s.day.toIso8601String(),
            s.date.toIso8601String(),
            sessionTitle(s),
            s.durationSec,
            s.exercises.length,
            s.setCount,
            s.volume,
            s.hrAvg,
            s.hrMax,
            s.sleep,
            s.energy,
            s.deload,
          ],
      ],
    );
  }

  static final _csvFormula = RegExp(r'^\s*[=+@-]|^[\t\r\n]');
  static final _csvQuoted = RegExp(r'[",\r\n]');

  static String _reportCsv(String header, Iterable<List<Object?>> rows) {
    String cell(Object? value) {
      var text = value?.toString() ?? '';
      if (value is String && _csvFormula.hasMatch(text)) text = "'$text";
      return _csvQuoted.hasMatch(text) ? '"${text.replaceAll('"', '""')}"' : text;
    }

    final csv = StringBuffer()..writeln(header);
    for (final row in rows) {
      csv.writeln(row.map(cell).join(','));
    }
    return csv.toString();
  }

  String reportNutritionCsv(RangeReport r) {
    final rows = StringBuffer('date,kcal,protein_g,carbs_g,fat_g,fiber_g,water_ml,foods\n');
    for (final d in _reportDates(r)) {
      final list = entriesOn(d);
      final water = waterOn(d);
      if (list.isEmpty && water == 0) continue;
      final m = totalOn(d);
      String n(double v) => v.toStringAsFixed(1).replaceFirst(RegExp(r'\.0$'), '');
      rows.writeln([
        NutritionState._dk(d),
        m.kcal.round(),
        n(m.protein),
        n(m.carbs),
        n(m.fat),
        n(m.fiber),
        water,
        list.length,
      ].join(','));
    }
    return rows.toString();
  }
}
