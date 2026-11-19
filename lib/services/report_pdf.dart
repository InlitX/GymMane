part of 'plan_pdf.dart';

Future<Uint8List> buildReportPdf(RangeReport r, {ReportKind kind = ReportKind.summary, DateTime? now}) async {
  final at = now ?? DateTime.now();
  final runner = await _loadImage('assets/img/runner.png');
  final doc = _ReportDoc(runner, rtl: kRtlLanguages.contains(appLanguage));
  doc.layBlocks(reportBlocks(r, kind, now: at));
  final pages = await _rasterize(doc);
  runner.dispose();
  final kicker = reportKicker(kind);
  return _writePdf(pages, '${sentenceCase(kicker)} · ${reportRangeLabel(r)}', at, kicker: kicker);
}

String reportFileStem(RangeReport r, ReportKind kind) {
  final stamp = '${_isoDay(r.from)}_${_isoDay(r.to)}';
  return switch (kind) {
    ReportKind.summary => 'gymmane-report-$stamp',
    ReportKind.training => 'gymmane-training-$stamp',
    ReportKind.nutrition => 'gymmane-nutrition-$stamp',
    ReportKind.full => 'gymmane-full-report-$stamp',
  };
}

Future<void> shareReport(RangeReport r,
    {ReportKind kind = ReportKind.summary, bool pdf = false, Set<ReportSection> csv = const {}}) async {
  try {
    final stamp = '${_isoDay(r.from)}_${_isoDay(r.to)}';
    final files = <ShareItem>[
      if (pdf) ShareItem('${reportFileStem(r, kind)}.pdf', await buildReportPdf(r, kind: kind), mime: 'application/pdf'),
      for (final section in csv)
        ShareItem(
          'gymmane-${section == ReportSection.weighIns ? 'weigh-ins' : section.name}-$stamp.csv',
          utf8Bytes(fit.reportSectionCsv(r, section)),
          mime: 'text/csv',
        ),
    ];
    await shareFiles(files, subject: '${sentenceCase(reportKicker(kind))} · ${reportRangeLabel(r)}');
  } catch (_) {}
}

String _isoDay(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

class _ReportDoc extends _PlanDoc {
  _ReportDoc(ui.Image runner, {required bool rtl}) : super(runner, const {}, rtl: rtl);

  void layBlocks(List<ReportBlock> blocks) {
    _newPage();
    for (final b in blocks) {
      switch (b) {
        case RepHeader():
          _head(b);
        case RepStats():
          _stats(b.stats);
        case RepNote():
          _flow(b.text, _st(8.5, color: _faint), _margin, _contentW, maxLines: 3);
          _y += 10;
        case RepSection():
          _section(b.title);
        case RepPairs():
          _pairs(b.rows);
        case RepTable():
          _table(b);
        case RepBars():
          _bars(b.bars);
        case RepDay():
          _day(b);
        case RepSub():
          _subhead(b);
        case RepGroup():
          _group(b);
      }
    }
  }

  double _flow(String text, TextStyle style, double left, double width, {int maxLines = 1, double after = 0}) {
    final h = _measure(text, style, width, maxLines: maxLines).height;
    _room(h + after);
    _text(text, style, left, _y, width, maxLines: maxLines);
    _y += h + after;
    return h;
  }

  void _head(RepHeader h) {
    final logo = Rect.fromLTWH(_x(_margin, 26), _y, 26, 26);
    _add((c) => _logo(c, logo));
    _text('GymMane', _st(14, weight: FontWeight.w900), _margin + 34, _y + 4, 140);
    _text(h.who, _st(9, color: _faint), _pageW - _margin - 220, _y + 8, 220, align: TextAlign.end);
    _y += 50;
    _y += _text(h.kicker, _st(8.5, weight: FontWeight.w800, color: _accent, spacing: 1.8), _margin, _y, _contentW);
    _y += 4;
    _y += _text(h.title, _st(28, weight: FontWeight.w900, height: 1.1), _margin, _y, _contentW, maxLines: 2);
    _y += 2;
    _y += _text(h.subtitle, _st(11, color: _sub), _margin, _y, _contentW);
    if (h.about.isNotEmpty) {
      _y += 2;
      _y += _text(h.about, _st(9.5, color: _faint), _margin, _y, _contentW, maxLines: 2);
    }
    _y += 16;
  }

  void _stats(List<RepStat> stats) {
    const gap = 8.0, h = 60.0;
    _room(h + 10);
    final w = (_contentW - gap * (stats.length - 1)) / stats.length;
    for (var i = 0; i < stats.length; i++) {
      final s = stats[i];
      final left = _margin + i * (w + gap);
      _rect(left, _y, w, h, _soft, radius: 12);
      _text(s.value, _st(17, weight: FontWeight.w900), left + 10, _y + 9, w - 20,
          ltr: true, align: rtl ? TextAlign.right : TextAlign.left);
      _text(s.label, _st(7, weight: FontWeight.w800, color: _faint, spacing: 1), left + 10, _y + 32, w - 20);
      if (s.delta.isNotEmpty) {
        _text(s.delta, _st(8, weight: FontWeight.w800, color: s.delta.startsWith('-') ? _sub : _accent),
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
    const key = 220.0;
    for (final (k, v) in rows) {
      final h = math.max(18.0, _measure(k, _st(10.5, color: _sub), key - 8, maxLines: 2).height + 4);
      _room(h + 2);
      _text(k, _st(10.5, color: _sub), _margin, _y, key - 8, maxLines: 2);
      _text(v, _st(11, weight: FontWeight.w800), _margin + key, _y, _contentW - key, align: TextAlign.end);
      _y += h;
      _rect(_margin, _y - 3, _contentW, 0.6, _line);
    }
    _y += 12;
  }

  void _table(RepTable tb) {
    final total = tb.widths.fold(0.0, (s, w) => s + w);
    final widths = [for (final w in tb.widths) w / total * _contentW];
    final lefts = <double>[];
    var at = _margin;
    for (final w in widths) {
      lefts.add(at);
      at += w;
    }
    TextAlign alignOf(int i) => i == 0 ? TextAlign.start : (tb.head == null ? TextAlign.end : TextAlign.center);
    Color colorOf(int i, String v) {
      if (i == tb.accentCol) return _accent;
      if (i != tb.signCol) return _ink;
      if (v == '–') return _faint;
      return v.startsWith('-') || v.startsWith('−') ? _sub : _accent;
    }

    final head = tb.head;
    void tableHead() {
      if (head == null) return;
      final st = _st(7.5, weight: FontWeight.w800, color: _faint, spacing: 0.8);
      for (var i = 0; i < head.length; i++) {
        _text(head[i], st, lefts[i] + (i == 0 ? 0 : 2), _y, widths[i] - (i == 0 ? 8 : 4), align: alignOf(i));
      }
      _y += 14;
      _rect(_margin, _y, _contentW, 0.8, _line);
      _y += 5;
    }

    _room(head == null ? 20 : 44);
    tableHead();
    for (final (n, row) in tb.rows.indexed) {
      if (head == null) {
        _room(20);
        for (var i = 0; i < row.length && i < widths.length; i++) {
          final st = i == 0
              ? _st(11, weight: FontWeight.w800)
              : i == tb.accentCol
                  ? _st(11, weight: FontWeight.w900, color: _accent)
                  : _st(9.5, color: _sub);
          _text(row[i], st, lefts[i], _y + (i == 0 || i == tb.accentCol ? 0 : 1), widths[i] - 8,
              align: alignOf(i), ltr: i > 0);
        }
        _y += 18;
        _rect(_margin, _y - 3, _contentW, 0.6, _line);
        continue;
      }
      _room(22, onBreak: tableHead);
      if (n.isOdd) _rect(_margin, _y - 4, _contentW, 22, _zebra, radius: 4);
      for (var i = 0; i < row.length && i < widths.length; i++) {
        final st = _st(10.5, weight: i == 0 || i == tb.signCol ? FontWeight.w800 : FontWeight.w700, color: colorOf(i, row[i]));
        _text(row[i], st, lefts[i] + (i == 0 ? 4 : 2), _y, widths[i] - (i == 0 ? 12 : 4), align: alignOf(i), ltr: i > 0);
      }
      _y += 22;
    }
    _y += head == null ? 10 : 6;
  }

  void _bars(List<(String, double, String)> bars) {
    if (bars.isEmpty) return;
    final max = bars.map((b) => b.$2).reduce(math.max);
    for (final (label, value, shown) in bars) {
      _room(18);
      _text(label, _st(10.5, weight: FontWeight.w700), _margin, _y, 140);
      final barW = _contentW - 200;
      _rect(_margin + 150, _y + 4, barW, 6, _soft, radius: 3);
      _rect(_margin + 150, _y + 4, math.max(6, max <= 0 ? 6 : barW * value / max), 6, _accent, radius: 3);
      _text(shown, _st(10, weight: FontWeight.w800), _pageW - _margin - 40, _y, 40, align: TextAlign.end, ltr: true);
      _y += 18;
    }
    _y += 10;
  }

  void _day(RepDay d) {
    _room(132);
    _y += 12;
    _rect(_margin, _y, _contentW, 0.8, _line);
    _y += 10;
    _y += _text(d.title, _st(13.5, weight: FontWeight.w900), _margin, _y, _contentW);
    if (d.subtitle.isNotEmpty) {
      _y += 2;
      _y += _text(d.subtitle, _st(9.5, color: _sub), _margin, _y, _contentW, maxLines: 2);
    }
    _y += 8;
  }

  void _subhead(RepSub s) {
    _room(84);
    _y += 4;
    _y += _text(s.title.toUpperCase(), _st(8, weight: FontWeight.w800, color: _accent, spacing: 1.2), _margin, _y, _contentW);
    if (s.trailing.isNotEmpty) {
      _y += 1;
      _y += _text(s.trailing, _st(9, color: _sub), _margin, _y, _contentW, maxLines: 2);
    }
    _y += 6;
  }

  void _group(RepGroup g) {
    if (g.title.isNotEmpty) {
      _room(32);
      _text(g.title, _st(10.5, weight: FontWeight.w800), _margin, _y, _contentW - 130);
      if (g.trailing.isNotEmpty) {
        _text(g.trailing, _st(9.5, weight: FontWeight.w700, color: _sub), _pageW - _margin - 124, _y + 1, 124,
            align: TextAlign.end);
      }
      _y += 16;
    }
    for (final line in g.lines) {
      _flow(line, _st(9.5, weight: FontWeight.w600), _margin + 12, _contentW - 12, maxLines: 3, after: 3);
    }
    _y += 7;
  }
}
