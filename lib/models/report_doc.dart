enum ReportKind { summary, training, nutrition, full }

sealed class ReportBlock {
  const ReportBlock();
}

class RepHeader extends ReportBlock {
  const RepHeader({required this.kicker, required this.title, required this.subtitle, this.who = '', this.about = ''});

  final String kicker;
  final String title;
  final String subtitle;
  final String who;
  final String about;
}

class RepStat {
  const RepStat(this.value, this.label, [this.delta = '']);

  final String value;
  final String label;
  final String delta;
}

class RepStats extends ReportBlock {
  const RepStats(this.stats);

  final List<RepStat> stats;
}

class RepSection extends ReportBlock {
  const RepSection(this.title);

  final String title;
}

class RepPairs extends ReportBlock {
  const RepPairs(this.rows);

  final List<(String, String)> rows;
}

class RepTable extends ReportBlock {
  const RepTable({this.head, required this.rows, required this.widths, this.signCol, this.accentCol});

  final List<String>? head;
  final List<List<String>> rows;
  final List<double> widths;
  final int? signCol;
  final int? accentCol;
}

class RepBars extends ReportBlock {
  const RepBars(this.bars);

  final List<(String, double, String)> bars;
}

class RepDay extends ReportBlock {
  const RepDay(this.title, [this.subtitle = '']);

  final String title;
  final String subtitle;
}

class RepSub extends ReportBlock {
  const RepSub(this.title, [this.trailing = '']);

  final String title;
  final String trailing;
}

class RepGroup extends ReportBlock {
  const RepGroup(this.title, {this.trailing = '', this.lines = const []});

  final String title;
  final String trailing;
  final List<String> lines;
}

class RepNote extends ReportBlock {
  const RepNote(this.text);

  final String text;
}

String reportMarkdown(List<ReportBlock> blocks) {
  final out = <String>[];
  void gap() {
    if (out.isNotEmpty && out.last.isNotEmpty) out.add('');
  }

  String cell(String s) => s.replaceAll('|', r'\|').replaceAll('\n', ' ');

  for (final b in blocks) {
    switch (b) {
      case RepHeader():
        out.add('# ${b.title}');
        out.add('');
        out.add([b.kicker, if (b.subtitle.isNotEmpty) b.subtitle].join(' · '));
        if (b.who.isNotEmpty) out.add('${b.who}  ');
        if (b.about.isNotEmpty) out.add(b.about);
      case RepStats():
        gap();
        for (final s in b.stats) {
          out.add('- **${s.value}** ${s.label.toLowerCase()}${s.delta.isEmpty ? '' : ' (${s.delta})'}');
        }
      case RepSection():
        gap();
        out.add('## ${b.title}');
        out.add('');
      case RepPairs():
        gap();
        for (final (k, v) in b.rows) {
          out.add('- $k: **$v**');
        }
      case RepTable():
        gap();
        final cols = b.widths.length;
        final head = b.head ?? List.filled(cols, '');
        out.add('| ${head.map(cell).join(' | ')} |');
        out.add('|${List.generate(cols, (i) => i == 0 ? ' --- ' : ' ---: ').join('|')}|');
        for (final r in b.rows) {
          out.add('| ${r.map(cell).join(' | ')} |');
        }
      case RepBars():
        gap();
        for (final (label, _, shown) in b.bars) {
          out.add('- $label: $shown');
        }
      case RepDay():
        gap();
        out.add('### ${b.title}');
        if (b.subtitle.isNotEmpty) {
          out.add('');
          out.add('_${b.subtitle}_');
        }
      case RepSub():
        gap();
        out.add('#### ${[b.title, if (b.trailing.isNotEmpty) b.trailing].join(' · ')}');
      case RepGroup():
        gap();
        if (b.title.isNotEmpty) out.add('**${b.title}**${b.trailing.isEmpty ? '' : ' · ${b.trailing}'}');
        for (final l in b.lines) {
          out.add('- $l');
        }
      case RepNote():
        gap();
        out.add('_${b.text}_');
    }
  }
  while (out.isNotEmpty && out.last.isEmpty) {
    out.removeLast();
  }
  return '${out.join('\n')}\n';
}
