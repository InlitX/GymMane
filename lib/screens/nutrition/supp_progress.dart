part of '../nutrition_screen.dart';

Future<void> showSuppProgress(BuildContext context, {String? id}) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SuppProgressSheet(initial: id),
    );

class _SuppProgressSheet extends StatefulWidget {
  const _SuppProgressSheet({this.initial});

  final String? initial;

  @override
  State<_SuppProgressSheet> createState() => _SuppProgressSheetState();
}

class _SuppProgressSheetState extends State<_SuppProgressSheet> {
  late String? _id = widget.initial;
  late DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  void _pick(String? id) {
    if (id == _id) return;
    HapticFeedback.selectionClick();
    setState(() => _id = id);
  }

  void _shift(int by) {
    HapticFeedback.selectionClick();
    setState(() => _month = DateTime(_month.year, _month.month + by));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: fit, builder: (context, _) => _body(context));
  }

  Widget _body(BuildContext context) {
    final gc = context.gc;
    final all = fit.supplements.where((s) => !fit.archivedSupps.contains(s.id) || s.id == _id).toList();
    final one = all.where((s) => s.id == _id).firstOrNull;
    final streak = fit.suppStreak(id: _id);
    final month = fit.suppMonth(_month, id: _id);
    final pct = month.due == 0 ? null : (month.taken * 100 / month.due).round();
    final now = DateTime.now();
    final thisMonth = _month.year == now.year && _month.month == now.month;
    return _sheetFrame(context, [
      SheetTitle(t.suppProgressTitle, subtitle: one?.name ?? t.suppProgressAll),
      const SizedBox(height: 16),
      if (all.length > 1) ...[
        SizedBox(
          height: 34,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _chip(gc, t.suppProgressAll, _id == null, () => _pick(null)),
              for (final s in all) _chip(gc, s.name, _id == s.id, () => _pick(s.id)),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
      Row(children: [
        Expanded(child: _stat(gc, t.suppStreakNow, t.suppDaysN(streak.current))),
        const SizedBox(width: 8),
        Expanded(child: _stat(gc, t.suppStreakBest, t.suppDaysN(streak.best))),
        const SizedBox(width: 8),
        Expanded(child: _stat(gc, thisMonth ? t.suppThisMonth : t.monthName(_month.month), pct == null ? '–' : '$pct %')),
      ]),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(22)),
        child: Column(children: [
          Row(children: [
            _arrow(gc, PhosphorIconsBold.caretLeft, () => _shift(-1)),
            Expanded(
              child: Text(t.monthYear(_month),
                  textAlign: TextAlign.center, style: AppTheme.f(14.5, weight: FontWeight.w800, color: gc.text)),
            ),
            _arrow(gc, PhosphorIconsBold.caretRight, thisMonth ? null : () => _shift(1)),
          ]),
          const SizedBox(height: 6),
          _calendar(gc),
          const SizedBox(height: 10),
          _legend(gc),
        ]),
      ),
      if (one != null) ...[
        const SizedBox(height: 14),
        _cycle(gc, one),
      ],
      if (_id == null && all.isNotEmpty) ...[
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, bottom: 10),
          child: Text(t.suppEachOne, style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text)),
        ),
        for (final s in all) _suppRow(gc, s),
      ],
    ]);
  }

  Widget _chip(GymColors gc, String label, bool on, VoidCallback tap) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 8),
        child: Pill(
          label: label,
          bg: on ? gc.ember : gc.bgRaised2,
          fg: on ? gc.onEmber : gc.textSecondary,
          hPad: 13,
          vPad: 6,
          fontSize: 12.5,
          onTap: tap,
        ),
      );

  Widget _stat(GymColors gc, String label, String value) => Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FitText(label.toUpperCase(),
              style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.9)),
          const SizedBox(height: 4),
          FitText(value, style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
        ]),
      );

  Widget _arrow(GymColors gc, IconData icon, VoidCallback? onTap) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 15, color: onTap == null ? gc.border : gc.textSecondary),
        ),
      );

  Widget _calendar(GymColors gc) {
    final days = fit.suppMonthDays(_month, id: _id);
    final start = fit.weekStartDay;
    final lead = (DateTime(_month.year, _month.month, 1).weekday - start + 7) % 7;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final cells = <Widget>[
      for (var i = 0; i < 7; i++)
        Center(
          child: Text(t.weekdayShort((start - 1 + i) % 7 + 1).characters.first.toUpperCase(),
              style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary)),
        ),
      for (var i = 0; i < lead; i++) const SizedBox.shrink(),
      for (var i = 0; i < days.length; i++) _day(gc, DateTime(_month.year, _month.month, i + 1), days[i], today),
    ];
    return LayoutBuilder(builder: (context, box) {
      final w = box.maxWidth / 7;
      return Wrap(children: [for (final c in cells) SizedBox(width: w, height: math.min(w, 42), child: c)]);
    });
  }

  Widget _day(GymColors gc, DateTime d, ({int due, int taken}) c, DateTime today) {
    final future = d.isAfter(today);
    final isToday = d == today;
    final done = c.due > 0 && c.taken >= c.due;
    final partial = c.due > 0 && c.taken > 0 && !done;
    final missed = c.due > 0 && c.taken == 0 && !future && !isToday;
    final label = Text('${d.day}',
        style: AppTheme.f(12, weight: FontWeight.w700, color: done ? gc.bg : (c.due == 0 || future ? gc.textTertiary : gc.text)));
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? gc.sage : (partial ? gc.sage.withValues(alpha: 0.18) : Colors.transparent),
              border: Border.all(
                color: isToday
                    ? gc.text
                    : partial
                        ? gc.sage
                        : missed
                            ? gc.textTertiary.withValues(alpha: 0.6)
                            : Colors.transparent,
                width: isToday ? 1.6 : 1.2,
              ),
            ),
            child: Center(child: label),
          ),
        ),
      ),
    );
  }

  Widget _legend(GymColors gc) {
    Widget dot(Color fill, Color border, String text) => Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: fill, border: Border.all(color: border, width: 1.2)),
          ),
          const SizedBox(width: 5),
          Text(text, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
        ]);
    return Wrap(alignment: WrapAlignment.center, spacing: 14, runSpacing: 6, children: [
      dot(gc.sage, gc.sage, t.suppLegendAll),
      dot(gc.sage.withValues(alpha: 0.18), gc.sage, t.suppLegendSome),
      dot(Colors.transparent, gc.textTertiary.withValues(alpha: 0.6), t.suppLegendNone),
    ]);
  }

  Widget _cycle(GymColors gc, Supplement s) {
    final since = fit.suppStart(s);
    final total = fit.suppTakenTotal(s.id);
    final last30 = fit.suppAdherence(id: s.id);
    final rows = [
      if (since != null) (t.suppSince, since.year == DateTime.now().year ? t.shortDate(since) : t.shortDateYear(since)),
      (t.suppTotalTakes, groupedInt(total)),
      if (last30.due > 0) (t.suppLast30, t.suppTakenOf(last30.taken, last30.due)),
      if (s.until != null) (t.suppEnds, t.shortDate(s.until!)),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
      child: Column(children: [
        for (final (i, r) in rows.indexed) ...[
          if (i > 0) Divider(height: 1, thickness: 1, color: gc.border.withValues(alpha: 0.6)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(children: [
              Expanded(child: Text(r.$1, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary))),
              Text(r.$2, style: AppTheme.f(13.5, weight: FontWeight.w800, color: gc.text)),
            ]),
          ),
        ],
      ]),
    );
  }

  Widget _suppRow(GymColors gc, Supplement s) {
    final a = fit.suppAdherence(id: s.id);
    final share = a.due == 0 ? null : a.taken / a.due;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Pressable(
        scale: 0.98,
        onTap: () => _pick(s.id),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 14, 10),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
          child: Row(children: [
            FoodSticker(photo: _suppPhoto(s), name: s.name, size: 40, tilt: false, shadow: false),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Row(children: [
                  Expanded(
                    child: Text(s.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text)),
                  ),
                  const SizedBox(width: 8),
                  Text(share == null ? '–' : '${(share * 100).round()} %',
                      style: AppTheme.f(13.5, weight: FontWeight.w800, color: gc.text)),
                ]),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: SizedBox(
                    height: 5,
                    child: Stack(children: [
                      Positioned.fill(child: ColoredBox(color: gc.border.withValues(alpha: 0.6))),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: FractionallySizedBox(
                          widthFactor: (share ?? 0).clamp(0.0, 1.0),
                          heightFactor: 1,
                          child: ColoredBox(color: gc.text),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 5),
                Text(a.due == 0 ? t.suppNotDueYet : '${t.suppTakenOf(a.taken, a.due)} · ${t.days30}',
                    style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
