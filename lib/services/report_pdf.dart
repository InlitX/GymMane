part of 'plan_pdf.dart';

String reportRangeLabel(RangeReport r) => r.from.year == r.to.year
    ? '${t.shortDate(r.from)} – ${t.shortDateYear(r.to)}'
    : '${t.shortDateYear(r.from)} – ${t.shortDateYear(r.to)}';

Future<Uint8List> buildReportPdf(RangeReport r, {DateTime? now}) async {
  final runner = await _loadImage('assets/img/runner.png');
  final doc = _ReportDoc(runner, rtl: kRtlLanguages.contains(appLanguage));
  doc.layReport(r, now ?? DateTime.now());
  final pages = await _rasterize(doc);
  runner.dispose();
  return _writePdf(pages, '${sentenceCase(t.reportKicker)} · ${reportRangeLabel(r)}', now ?? DateTime.now(),
      kicker: t.reportKicker);
}

Future<void> shareReport(RangeReport r, {bool pdf = false, Set<ReportSection> csv = const {}}) async {
  try {
    final stamp = '${_isoDay(r.from)}_${_isoDay(r.to)}';
    final files = <ShareItem>[
      if (pdf) ShareItem('gymmane-report-$stamp.pdf', await buildReportPdf(r), mime: 'application/pdf'),
      for (final section in csv)
        ShareItem(
          'gymmane-${section == ReportSection.weighIns ? 'weigh-ins' : section.name}-$stamp.csv',
          utf8Bytes(fit.reportSectionCsv(r, section)),
          mime: 'text/csv',
        ),
    ];
    await shareFiles(files, subject: '${sentenceCase(t.reportKicker)} · ${reportRangeLabel(r)}');
  } catch (_) {}
}

String _isoDay(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

class _ReportDoc extends _PlanDoc {
  _ReportDoc(ui.Image runner, {required bool rtl}) : super(runner, const {}, rtl: rtl);

  void layReport(RangeReport r, DateTime now) {
    _newPage();
    final logo = Rect.fromLTWH(_x(_margin, 26), _y, 26, 26);
    _add((c) => _logo(c, logo));
    _text('GymMane', _st(14, weight: FontWeight.w900), _margin + 34, _y + 4, 140);
    final who = [if (fit.profile.name.trim().isNotEmpty) fit.profile.name.trim(), t.shortDateYear(now)].join(' · ');
    _text(who, _st(9, color: _faint), _pageW - _margin - 220, _y + 8, 220, align: TextAlign.end);
    _y += 50;
    _y += _text(t.reportKicker, _st(8.5, weight: FontWeight.w800, color: _accent, spacing: 1.8), _margin, _y, _contentW);
    _y += 4;
    _y += _text(reportRangeLabel(r), _st(28, weight: FontWeight.w900, height: 1.1), _margin, _y, _contentW, maxLines: 2);
    _y += 2;
    _y += _text(t.reportDays(r.days), _st(11, color: _sub), _margin, _y, _contentW);
    _y += 16;

    String pct(num now, num before) {
      if (before <= 0) return '';
      final p = ((now / before - 1) * 100).round();
      return '${p >= 0 ? '+' : ''}$p %';
    }

    final prev = r.prev;
    _stats([
      ('${r.sessions}', t.reportWorkouts, prev == null ? '' : pct(r.sessions, prev.sessions)),
      ('${r.sets}', t.setsCaps, prev == null ? '' : pct(r.sets, prev.sets)),
      (fit.volumeLabel(r.volume), t.volume, prev == null ? '' : pct(r.volume, prev.volume)),
      (decimalText(r.perWeek.toStringAsFixed(1)), t.reportPerWeek, ''),
      if (r.minutes > 0) (decimalText((r.minutes / 60).toStringAsFixed(r.minutes < 600 ? 1 : 0)), t.reportHours, ''),
    ]);
    if (prev != null) {
      _y += _text(t.reportVsPrev, _st(8.5, color: _faint), _margin, _y, _contentW);
      _y += 10;
    }

    if (r.records.isNotEmpty) {
      _section(t.reportRecords);
      for (final rec in r.records.take(12)) {
        _room(20);
        _text(rec.name, _st(11, weight: FontWeight.w800), _margin, _y, _contentW - 200);
        _text(fit.weightLabel(rec.kg), _st(11, weight: FontWeight.w900, color: _accent), _pageW - _margin - 190, _y, 90,
            align: TextAlign.end, ltr: true);
        _text(t.shortDate(rec.date), _st(9.5, color: _sub), _pageW - _margin - 90, _y + 1, 90, align: TextAlign.end);
        _y += 18;
        _rect(_margin, _y - 3, _contentW, 0.6, _line);
      }
      _y += 10;
    }

    if (r.lifts.isNotEmpty) {
      _section(t.reportLifts);
      const cS = 250.0, cT = 310.0, cB = 370.0, cC = 450.0;
      final head = _st(7.5, weight: FontWeight.w800, color: _faint, spacing: 0.8);
      void tableHead() {
        _text(t.exercisesCaps, head, _margin, _y, cS - 8);
        _text(t.reportSessionsCol, head, _margin + cS, _y, 56, align: TextAlign.center);
        _text(t.setsCaps, head, _margin + cT, _y, 56, align: TextAlign.center);
        _text(t.reportBestCol, head, _margin + cB, _y, 76, align: TextAlign.center);
        _text(t.reportChangeCol, head, _margin + cC, _y, _contentW - cC, align: TextAlign.center);
        _y += 14;
        _rect(_margin, _y, _contentW, 0.8, _line);
        _y += 5;
      }

      tableHead();
      var i = 0;
      for (final l in r.lifts.take(25)) {
        _room(22, onBreak: tableHead);
        if (i.isOdd) _rect(_margin, _y - 4, _contentW, 22, _zebra, radius: 4);
        final body = _st(10.5, weight: FontWeight.w700);
        _text(l.name, _st(10.5, weight: FontWeight.w800), _margin + 4, _y, cS - 12);
        _text('${l.sessions}', body, _margin + cS, _y, 56, align: TextAlign.center, ltr: true);
        _text('${l.sets}', body, _margin + cT, _y, 56, align: TextAlign.center, ltr: true);
        _text(l.best > 0 ? fit.weightLabel(l.best) : '–', body, _margin + cB, _y, 76, align: TextAlign.center, ltr: true);
        final ch = l.change;
        _text(
          ch == null ? '–' : '${ch >= 0 ? '+' : ''}${ch.round()} %',
          _st(10.5, weight: FontWeight.w800, color: ch == null ? _faint : (ch >= 0 ? _accent : _sub)),
          _margin + cC,
          _y,
          _contentW - cC,
          align: TextAlign.center,
          ltr: true,
        );
        _y += 22;
        i++;
      }
      _y += 6;
      _y += _text(t.reportBestHint, _st(8.5, color: _faint), _margin, _y, _contentW, maxLines: 2);
      _y += 12;
    }

    if (r.muscles.isNotEmpty) {
      _section(t.reportMuscles);
      final top = r.muscles.take(10).toList();
      final max = top.first.sets;
      for (final m in top) {
        _room(18);
        _text(t.muscle(m.muscle), _st(10.5, weight: FontWeight.w700), _margin, _y, 140);
        final barW = _contentW - 200;
        _rect(_margin + 150, _y + 4, barW, 6, _soft, radius: 3);
        _rect(_margin + 150, _y + 4, math.max(6, barW * m.sets / max), 6, _accent, radius: 3);
        _text(decimalText(m.sets.toStringAsFixed(m.sets % 1 == 0 ? 0 : 1)), _st(10, weight: FontWeight.w800),
            _pageW - _margin - 40, _y, 40, align: TextAlign.end, ltr: true);
        _y += 18;
      }
      _y += 10;
    }

    final body = <(String, String)>[
      if (r.weightFrom != null)
        (
          t.bodyweightLabel,
          r.weightTo == null
              ? fit.weightLabel(r.weightFrom!)
              : '${fit.weightLabel(r.weightFrom!)} → ${fit.weightLabel(r.weightTo!)}'
                  '  (${r.weightTo! >= r.weightFrom! ? '+' : '−'}${fit.weightLabel((r.weightTo! - r.weightFrom!).abs())})',
        ),
      if (r.sleep != null) (t.checkInSleep, '${decimalText(r.sleep!.toStringAsFixed(1))} / 5'),
      if (r.energy != null) (t.checkInEnergy, '${decimalText(r.energy!.toStringAsFixed(1))} / 5'),
    ];
    if (body.isNotEmpty) {
      _section(t.reportBody);
      _pairs(body);
    }

    final food = r.food;
    if (food != null) {
      _section(t.reportFood(food.days));
      _pairs([
        (sentenceCase(t.kcalLabel), '${fit.energyOf(food.kcal)} ${fit.energyUnit}'),
        (sentenceCase(t.macroProtein), '${food.protein.round()} g'),
        (sentenceCase(t.macroCarbs), '${food.carbs.round()} g'),
        (sentenceCase(t.macroFat), '${food.fat.round()} g'),
        if (food.waterMl > 0) (sentenceCase(t.waterLabel), fit.waterLabel(food.waterMl)),
      ]);
    }
  }

  void _stats(List<(String, String, String)> stats) {
    const gap = 8.0, h = 60.0;
    _room(h + 10);
    final w = (_contentW - gap * (stats.length - 1)) / stats.length;
    for (var i = 0; i < stats.length; i++) {
      final left = _margin + i * (w + gap);
      _rect(left, _y, w, h, _soft, radius: 12);
      _text(stats[i].$1, _st(17, weight: FontWeight.w900), left + 10, _y + 9, w - 20,
          ltr: true, align: rtl ? TextAlign.right : TextAlign.left);
      _text(stats[i].$2, _st(7, weight: FontWeight.w800, color: _faint, spacing: 1), left + 10, _y + 32, w - 20);
      if (stats[i].$3.isNotEmpty) {
        _text(stats[i].$3, _st(8, weight: FontWeight.w800, color: stats[i].$3.startsWith('-') ? _sub : _accent),
            left + 10, _y + 44, w - 20, ltr: true, align: rtl ? TextAlign.right : TextAlign.left);
      }
    }
    _y += h + 8;
  }

  void _section(String title) {
    _room(60);
    _y += 8;
    _y += _text(title.toUpperCase(), _st(8.5, weight: FontWeight.w800, color: _accent, spacing: 1.6), _margin, _y, _contentW);
    _y += 8;
  }

  void _pairs(List<(String, String)> rows) {
    for (final (k, v) in rows) {
      _room(20);
      _text(k, _st(10.5, color: _sub), _margin, _y, 180);
      _text(v, _st(11, weight: FontWeight.w800), _margin + 180, _y, _contentW - 180, align: TextAlign.end);
      _y += 18;
      _rect(_margin, _y - 3, _contentW, 0.6, _line);
    }
    _y += 12;
  }
}
