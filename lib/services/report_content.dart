import '../l10n/l10n.dart';
import '../models/measure.dart';
import '../models/nutrition.dart';
import '../models/report_doc.dart';
import '../models/workout.dart';
import '../services/health_metrics.dart';
import '../state/fit_state.dart';
import '../widgets/health_cards.dart';
import '../widgets/ui_kit.dart';

const kReportDetailDays = 92;

String reportRangeLabel(RangeReport r) => r.from.year == r.to.year
    ? '${t.shortDate(r.from)} – ${t.shortDateYear(r.to)}'
    : '${t.shortDateYear(r.from)} – ${t.shortDateYear(r.to)}';

String reportKicker(ReportKind kind) => switch (kind) {
      ReportKind.summary => t.reportKicker,
      ReportKind.training => t.reportKickerTraining,
      ReportKind.nutrition => t.reportKickerNutrition,
      ReportKind.full => t.reportKickerFull,
    };

bool reportHasNutrition(DateTime from, DateTime to) {
  if (!fit.nutritionBeta) return false;
  for (var d = from; !d.isAfter(to); d = shiftDays(d, 1)) {
    if (fit.entriesOn(d).isNotEmpty || fit.waterOn(d) > 0) return true;
  }
  return false;
}

List<ReportBlock> reportBlocks(RangeReport r, ReportKind kind, {DateTime? now}) {
  final at = now ?? DateTime.now();
  final b = <ReportBlock>[_header(r, kind, at)];
  final training = kind != ReportKind.nutrition;
  final food = kind != ReportKind.training && kind != ReportKind.summary;
  if (training) b.addAll(_trainingSummary(r));
  if (kind == ReportKind.summary) {
    b.addAll(_bodySummary(r, measures: false));
    if (r.food case final f?) {
      b
        ..add(RepSection(t.reportFood(f.days)))
        ..add(RepPairs(_foodAverages(f)));
    }
    return b;
  }
  if (food) b.addAll(_nutritionSummary(r));
  b.addAll(_bodySummary(r, measures: true));
  if (kind == ReportKind.full) b.addAll(_healthSummary(r));
  switch (kind) {
    case ReportKind.training:
      final picked = _sessionsIn(r.from, r.to);
      if (picked.isNotEmpty) {
        b.add(RepSection(t.reportWorkoutLog));
        for (final s in picked) {
          b
            ..add(RepDay(t.longDate(s.day), _sessionLine(s)))
            ..addAll(_sessionGroups(s));
        }
      }
    case ReportKind.nutrition:
      final days = [for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1)) if (_hasFood(d)) d];
      if (days.isNotEmpty) {
        b.add(RepSection(t.reportFoodLog));
        for (final d in days) {
          b
            ..add(RepDay(t.longDate(d), _foodLine(d)))
            ..addAll(_mealGroups(d));
        }
      }
    case ReportKind.full:
      final days = [
        for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1))
          if (_dayBlocks(d, full: true).isNotEmpty) d,
      ];
      if (days.isNotEmpty) {
        b.add(RepSection(t.reportDayByDay));
        for (final d in days) {
          b
            ..add(RepDay(t.longDate(d)))
            ..addAll(_dayBlocks(d, full: true));
        }
      }
    case ReportKind.summary:
      break;
  }
  return b;
}

String dayMarkdown(DateTime day, {required bool full}) {
  final day0 = DateTime(day.year, day.month, day.day);
  final blocks = <ReportBlock>[
    RepDay(t.longDate(day0), full ? '' : _foodLine(day0)),
    ...full ? _dayBlocks(day0, full: true) : _mealGroups(day0),
  ];
  return reportMarkdown(blocks);
}

bool dayHasMore(DateTime day) {
  final d = DateTime(day.year, day.month, day.day);
  return _sessionsIn(d, d).isNotEmpty || _healthLines(d).isNotEmpty;
}

RepHeader _header(RangeReport r, ReportKind kind, DateTime now) {
  final p = fit.profile;
  final kg = fit.bodyweightKgOn(now);
  return RepHeader(
    kicker: reportKicker(kind),
    title: reportRangeLabel(r),
    subtitle: t.reportDays(r.days),
    who: [if (p.name.trim().isNotEmpty) p.name.trim(), t.shortDateYear(now)].join(' · '),
    about: kind == ReportKind.summary
        ? ''
        : t.planBody(p.sex == 'female' ? t.female : t.male, p.age, fit.heightLabel(p.heightCm),
            fit.weightLabel(kg > 0 ? kg : p.weightKg)),
  );
}

String _pct(num now, num before) {
  if (before <= 0) return '';
  final p = ((now / before - 1) * 100).round();
  return '${p >= 0 ? '+' : ''}$p %';
}

String _one(double v) => decimalText(v.toStringAsFixed(1));

List<ReportBlock> _trainingSummary(RangeReport r) {
  if (r.sessions == 0) return const [];
  final prev = r.prev;
  return [
    RepStats([
      RepStat('${r.sessions}', t.reportWorkouts, prev == null ? '' : _pct(r.sessions, prev.sessions)),
      RepStat('${r.sets}', t.setsCaps, prev == null ? '' : _pct(r.sets, prev.sets)),
      RepStat(fit.volumeLabel(r.volume), t.volume, prev == null ? '' : _pct(r.volume, prev.volume)),
      RepStat(_one(r.perWeek), t.reportPerWeek),
      if (r.minutes > 0) RepStat(decimalText((r.minutes / 60).toStringAsFixed(r.minutes < 600 ? 1 : 0)), t.reportHours),
    ]),
    if (prev != null) RepNote(t.reportVsPrev),
    if (r.records.isNotEmpty) ...[
      RepSection(t.reportRecords),
      RepTable(
        rows: [for (final x in r.records.take(12)) [x.name, fit.weightLabel(x.kg), t.shortDate(x.date)]],
        widths: const [325, 100, 90],
        accentCol: 1,
      ),
    ],
    if (r.lifts.isNotEmpty) ...[
      RepSection(t.reportLifts),
      RepTable(
        head: [t.exercisesCaps, t.reportSessionsCol, t.setsCaps, t.reportBestCol, t.reportChangeCol],
        rows: [
          for (final l in r.lifts.take(25))
            [
              l.name,
              '${l.sessions}',
              '${l.sets}',
              l.best > 0 ? fit.weightLabel(l.best) : '–',
              l.change == null ? '–' : '${l.change! >= 0 ? '+' : ''}${l.change!.round()} %',
            ],
        ],
        widths: const [250, 60, 60, 80, 65],
        signCol: 4,
      ),
      RepNote(t.reportBestHint),
    ],
    if (r.muscles.isNotEmpty) ...[
      RepSection(t.reportMuscles),
      RepBars([
        for (final m in r.muscles.take(10))
          (t.muscle(m.muscle), m.sets, decimalText(m.sets.toStringAsFixed(m.sets % 1 == 0 ? 0 : 1))),
      ]),
    ],
  ];
}

List<(String, String)> _foodAverages(ReportFood f) => [
      (sentenceCase(t.kcalLabel), '${fit.energyOf(f.kcal)} ${fit.energyUnit}'),
      (sentenceCase(t.macroProtein), '${f.protein.round()} g'),
      (sentenceCase(t.macroCarbs), '${f.carbs.round()} g'),
      (sentenceCase(t.macroFat), '${f.fat.round()} g'),
      if (f.waterMl > 0) (sentenceCase(t.waterLabel), fit.waterLabel(f.waterMl)),
    ];

String _goalLine(NutritionGoals g) =>
    '${fit.energyOf(g.kcal)} ${fit.energyUnit} · ${t.proteinLetter} ${g.protein} · ${t.carbsLetter} ${g.carbs} · ${t.fatLetter} ${g.fat} g';

List<ReportBlock> _nutritionSummary(RangeReport r) {
  final f = r.food;
  if (f == null) return const [];
  final days = [for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1)) if (fit.entriesOn(d).isNotEmpty) d];
  var onTarget = 0, protein = 0;
  var fiber = 0.0;
  for (final d in days) {
    final total = fit.totalOn(d);
    final budget = fit.kcalBudgetOn(d);
    if (budget > 0 && (total.kcal - budget).abs() <= budget * 0.1) onTarget++;
    if (total.protein >= fit.goalsFor(d).protein) protein++;
    fiber += total.fiber;
  }
  final rest = fit.restGoals;
  final out = <ReportBlock>[
    RepSection(t.reportFood(f.days)),
    RepStats([
      RepStat('${f.days}/${r.days}', t.reportSessionsCol),
      RepStat('${fit.energyOf(f.kcal)}', fit.energyUnit.toUpperCase()),
      RepStat('${f.protein.round()} g', t.macroProtein.toUpperCase()),
      RepStat('${f.carbs.round()} g', t.macroCarbs.toUpperCase()),
      RepStat('${f.fat.round()} g', t.macroFat.toUpperCase()),
    ]),
    RepPairs([
      (t.reportGoalsLabel, _goalLine(fit.activeGoals)),
      if (rest != null) (t.reportGoalsRest, _goalLine(rest)),
      (t.reportKcalOnTarget, '$onTarget / ${days.length}'),
      (t.reportProteinMet, '$protein / ${days.length}'),
      if (fiber > 0) (t.fiberLabel, '${(fiber / days.length).round()} g'),
      if (f.waterMl > 0) (sentenceCase(t.waterLabel), fit.waterLabel(f.waterMl)),
    ]),
    RepSection(t.reportDailyTotals),
    RepTable(
      head: [t.reportDateCol, fit.energyUnit.toUpperCase(), t.proteinLetter, t.carbsLetter, t.fatLetter, t.waterLabel],
      rows: [
        for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1))
          if (_hasFood(d))
            () {
              final m = fit.totalOn(d);
              final water = fit.waterOn(d);
              return [
                t.shortDate(d),
                '${fit.energyOf(m.kcal)}',
                '${m.protein.round()}',
                '${m.carbs.round()}',
                '${m.fat.round()}',
                water > 0 ? fit.waterLabel(water) : '–',
              ];
            }(),
      ],
      widths: const [155, 80, 60, 60, 60, 100],
    ),
  ];
  final names = {for (final s in fit.supplements) s.id: s.name};
  final taken = <String, int>{};
  for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1)) {
    for (final id in fit.takenOn(d)) {
      if (names.containsKey(id)) taken[id] = (taken[id] ?? 0) + 1;
    }
  }
  if (taken.isNotEmpty) {
    out
      ..add(RepSection(titleCase(t.supplementsLabel)))
      ..add(RepTable(
        rows: [
          for (final e in taken.entries.toList()..sort((a, b) => b.value.compareTo(a.value))) [names[e.key]!, t.reportDays(e.value)],
        ],
        widths: const [385, 130],
      ));
  }
  return out;
}

List<BodyMeasure> _measuresIn(String key, DateTime from, DateTime to) {
  final end = shiftDays(to, 1);
  return [
    for (final m in fit.measureHistory(key).reversed)
      if (!m.date.isBefore(from) && m.date.isBefore(end)) m,
  ];
}

List<ReportBlock> _bodySummary(RangeReport r, {required bool measures}) {
  final rows = <(String, String)>[
    if (r.weightFrom != null)
      (
        t.bodyweightLabel,
        r.weightTo == null
            ? fit.weightLabel(r.weightFrom!)
            : '${fit.weightLabel(r.weightFrom!)} → ${fit.weightLabel(r.weightTo!)}'
                '  (${r.weightTo! >= r.weightFrom! ? '+' : '−'}${fit.weightLabel((r.weightTo! - r.weightFrom!).abs())})',
      ),
    if (measures)
      for (final key in fit.trackedMeasures)
        if (_measuresIn(key, r.from, r.to) case final list when list.isNotEmpty)
          (
            fit.measureTitle(key),
            fit.isPressure(key)
                ? () {
                    final hi = list.fold(0.0, (s, m) => s + m.value) / list.length;
                    final lo = list.fold(0.0, (s, m) => s + (m.low ?? 0)) / list.length;
                    return '${hi.round()}/${lo.round()} mmHg · ${t.reportReadings(list.length)}';
                  }()
                : list.length == 1
                    ? fit.measureEntryLabel(list.single)
                    : '${fit.measureEntryLabel(list.first)} → ${fit.measureEntryLabel(list.last)}',
          ),
    if (r.sleep != null) (t.checkInSleep, '${_one(r.sleep!)} / 5'),
    if (r.energy != null) (t.checkInEnergy, '${_one(r.energy!)} / 5'),
  ];
  if (rows.isEmpty) return const [];
  return [RepSection(t.reportBody), RepPairs(rows)];
}

List<ReportBlock> _healthSummary(RangeReport r) {
  final rows = <(String, String)>[];
  final steps = [
    for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1))
      if (fit.stepsOnDay(d) > 0) fit.stepsOnDay(d),
  ];
  if (fit.stepsOn && steps.isNotEmpty) {
    rows.add((t.homeCardSteps, '${(steps.reduce((a, b) => a + b) / steps.length).round()}'));
  }
  for (final m in fit.healthMetrics) {
    final vals = [
      for (var d = r.from; !d.isAfter(r.to); d = shiftDays(d, 1)) ?fit.healthOnDay(m, d),
    ];
    if (vals.isEmpty) continue;
    final avg = [
      for (var i = 0; i < vals.first.length; i++)
        vals.fold(0.0, (s, v) => s + (i < v.length ? v[i] : 0)) / vals.length,
    ];
    final unit = healthUnit(m);
    rows.add((healthName(m), unit.isEmpty ? healthValue(m, avg) : '${healthValue(m, avg)} $unit'));
  }
  if (rows.isEmpty) return const [];
  return [RepSection(t.reportHealthAvg), RepPairs(rows)];
}

List<LoggedSession> _sessionsIn(DateTime from, DateTime to) {
  final end = shiftDays(to, 1);
  return [for (final s in fit.sessions) if (!s.day.isBefore(from) && s.day.isBefore(end)) s]
    ..sort((a, b) => a.date.compareTo(b.date));
}

String _sessionLine(LoggedSession s, {bool title = true}) => [
      if (title) ?fit.sessionTitle(s),
      if (s.durationSec > 0) '${s.durationSec ~/ 60} min',
      t.setCount(s.setCount),
      if (s.volume > 0) fit.volumeLabel(s.volume),
      if (s.hrAvg != null) '${s.hrAvg} ${t.healthBpm}',
      if (s.sleep != null) '${t.checkInSleep} ${s.sleep}/5',
      if (s.energy != null) '${t.checkInEnergy} ${s.energy}/5',
      if (s.deload) t.deloadNow,
    ].join(' · ');

List<ReportBlock> _sessionGroups(LoggedSession s) => [
      for (final e in s.exercises)
        if (e.sets.isNotEmpty)
          RepGroup(
            t.catalogName(e.id, e.name),
            trailing: t.setCount(e.workingSets.length),
            lines: [
              for (final (i, x) in e.sets.indexed)
                '${i + 1}. ${fit.setText(x)}${x.note.isEmpty ? '' : ' — ${x.note.replaceAll('\n', ' ')}'}',
            ],
          ),
    ];

bool _hasFood(DateTime d) => fit.entriesOn(d).isNotEmpty || fit.waterOn(d) > 0;

String _macros(Macros m) =>
    '${t.proteinLetter} ${m.protein.round()} · ${t.carbsLetter} ${m.carbs.round()} · ${t.fatLetter} ${m.fat.round()} g';

String _foodLine(DateTime d) {
  final m = fit.totalOn(d);
  final budget = fit.kcalBudgetOn(d);
  final water = fit.waterOn(d);
  return [
    budget > 0
        ? '${fit.energyOf(m.kcal)} / ${fit.energyOf(budget)} ${fit.energyUnit}'
        : '${fit.energyOf(m.kcal)} ${fit.energyUnit}',
    _macros(m),
    if (water > 0) '${sentenceCase(t.waterLabel)} ${fit.waterLabel(water)}',
  ].join(' · ');
}

List<ReportBlock> _mealGroups(DateTime d) {
  final entries = fit.entriesOn(d);
  final order = [for (final s in fit.mealSlots) s.meal];
  for (final e in entries) {
    if (!order.contains(e.meal)) order.add(e.meal);
  }
  return [
    for (final meal in order)
      if (entries.where((e) => e.meal == meal).toList() case final list when list.isNotEmpty)
        RepGroup(
          fit.mealLabel(meal),
          trailing: '${fit.energyOf(list.fold(0.0, (s, e) => s + e.total.kcal))} ${fit.energyUnit}',
          lines: [
            for (final e in list)
              [
                e.name.isEmpty ? t.quickAdd : e.name,
                if (fit.servingLabel(e) case final s when s.isNotEmpty) s,
                '${fit.energyOf(e.total.kcal)} ${fit.energyUnit}',
                _macros(e.total),
              ].join(' · '),
          ],
        ),
  ];
}

List<String> _healthLines(DateTime d) {
  final out = <String>[];
  final weights = [for (final w in fit.bodyweight) if (w.date.year == d.year && w.date.month == d.month && w.date.day == d.day) w];
  if (weights.isNotEmpty) out.add('${t.bodyweightLabel} ${fit.weightLabel(weights.last.kg)}');
  if (fit.stepsOn && fit.stepsOnDay(d) > 0) out.add('${t.homeCardSteps} ${fit.stepsOnDay(d)}');
  final shown = fit.healthMetrics;
  for (final m in shown) {
    final v = fit.healthOnDay(m, d);
    if (v == null) continue;
    final unit = healthUnit(m);
    out.add('${healthName(m)} ${healthValue(m, v)}${unit.isEmpty ? '' : ' $unit'}');
  }
  if (!shown.contains(HealthMetric.bloodPressure)) {
    for (final m in _measuresIn('bp', d, d)) {
      out.add('${fit.measureTitle('bp')} ${fit.measureEntryLabel(m)}');
    }
  }
  return out;
}

List<ReportBlock> _dayBlocks(DateTime d, {required bool full}) {
  final out = <ReportBlock>[];
  for (final s in _sessionsIn(d, d)) {
    out
      ..add(RepSub(fit.sessionTitle(s) ?? t.healthWorkoutTitle, _sessionLine(s, title: false)))
      ..addAll(_sessionGroups(s));
  }
  if (fit.nutritionBeta && _hasFood(d)) {
    out
      ..add(RepSub(t.nutrition, _foodLine(d)))
      ..addAll(_mealGroups(d));
  }
  if (full) {
    final health = _healthLines(d);
    if (health.isNotEmpty) {
      out
        ..add(RepSub(t.reportBodyHealth))
        ..add(RepGroup('', lines: [
          for (var i = 0; i < health.length; i += 3) health.sublist(i, i + 3 > health.length ? health.length : i + 3).join(' · '),
        ]));
    }
  }
  return out;
}
