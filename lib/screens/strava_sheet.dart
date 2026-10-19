import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../services/fit_export.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/glass.dart';
import '../widgets/ui_kit.dart';

void showStravaSheet(BuildContext context) => showAppSheet<void>(
  context: context,
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  builder: (_) => const _StravaSheet(),
);

const _brand = 'Strava';

class _StravaSheet extends StatefulWidget {
  const _StravaSheet();

  @override
  State<_StravaSheet> createState() => _StravaSheetState();
}

class _StravaSheetState extends State<_StravaSheet> {
  final Map<DateTime, List<LoggedSession>> _byDay = {};
  late DateTime _month;
  DateTime? _day;

  static DateTime _key(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  void initState() {
    super.initState();
    final list = [...fit.sessions]..sort((a, b) => b.date.compareTo(a.date));
    for (final s in list) {
      (_byDay[_key(s.day)] ??= []).add(s);
    }
    _day = list.isEmpty ? null : _key(list.first.day);
    final base = _day ?? DateTime.now();
    _month = DateTime(base.year, base.month);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final picked = _byDay[_day] ?? const <LoggedSession>[];
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.88),
      padding: sheetPad(context),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  _brand,
                  style: AppTheme.f(21, weight: FontWeight.w700, color: gc.text),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    t.stravaBeta,
                    style: AppTheme.f(10.5, weight: FontWeight.w800, color: gc.accent, letterSpacing: 1.2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              t.stravaIntro,
              style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45),
            ),
            const SizedBox(height: 16),
            if (_byDay.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  t.stravaEmpty,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.textTertiary),
                ),
              )
            else ...[
              _calendar(gc),
              const SizedBox(height: 14),
              for (final s in picked) ...[_row(context, gc, s), const SizedBox(height: 8)],
            ],
          ],
        ),
      ),
    );
  }

  Widget _calendar(GymColors gc) {
    final today = _key(DateTime.now());
    final days = DateTime(_month.year, _month.month + 1, 0).day;
    final lead = (_month.weekday - fit.weekStartDay + 7) % 7;
    return Column(
      children: [
        Row(
          children: [
            _arrow(gc, PhosphorIconsBold.caretLeft, t.notePrevMonth, -1),
            Expanded(
              child: Text(
                t.monthYear(_month),
                textAlign: TextAlign.center,
                style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text),
              ),
            ),
            _arrow(gc, PhosphorIconsBold.caretRight, t.noteNextMonth, 1),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (int i = 0; i < 7; i++)
              Expanded(
                child: Text(
                  t.weekdayInitial(fit.weekdayAt(i)).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppTheme.f(10.5, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        for (int row = 0; row * 7 < lead + days; row++)
          Row(
            children: [
              for (int col = 0; col < 7; col++)
                Expanded(
                  child: () {
                    final n = row * 7 + col - lead + 1;
                    if (n < 1 || n > days) return const SizedBox(height: 48);
                    return _cell(gc, DateTime(_month.year, _month.month, n), today);
                  }(),
                ),
            ],
          ),
      ],
    );
  }

  Widget _arrow(GymColors gc, IconData icon, String label, int step) => Semantics(
    button: true,
    label: label,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _month = DateTime(_month.year, _month.month + step)),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
        child: Icon(icon, size: 13, color: gc.text),
      ),
    ),
  );

  Widget _cell(GymColors gc, DateTime day, DateTime today) {
    final has = _byDay.containsKey(day);
    final on = has && day == _day;
    return Semantics(
      button: has,
      selected: on,
      label: t.fullDate(day),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: has ? () => setState(() => _day = day) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 44,
          margin: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on
                ? gc.ember
                : has
                ? gc.accentSoft
                : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: day == today && !on ? gc.border : Colors.transparent),
          ),
          child: Text(
            '${day.day}',
            style: AppTheme.f(
              14,
              weight: has ? FontWeight.w800 : FontWeight.w500,
              color: on
                  ? gc.onEmber
                  : has
                  ? gc.accent
                  : gc.textTertiary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(BuildContext context, GymColors gc, LoggedSession s) {
    final minutes = s.durationSec ~/ 60;
    return Pressable(
      onTap: () => shareWorkoutFit(s),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.longDate(s.day),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${t.setCount(s.setCount)}${minutes > 0 ? ' · $minutes min' : ''}',
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
              child: Icon(PhosphorIconsRegular.export, size: 17, color: gc.accent),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> shareWorkoutFit(LoggedSession s) async {
  try {
    final dir = await getTemporaryDirectory();
    final d = s.date;
    final stamp = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    final file = File('${dir.path}/GymMane $stamp.fit');
    await file.writeAsBytes(workoutFit(s, pounds: fit.isLb));
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: t.exportForStravaHint));
  } catch (_) {}
}
