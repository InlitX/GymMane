import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/sheet_page.dart';
import '../widgets/set_kind.dart';
import '../widgets/ui_kit.dart';
import 'progress_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final month = fit.historyMonth;
    final list = fit.sessionsInMonth(month);
    final records = fit.recordsBySession();
    return RiseScope(
      id: 'history',
      once: false,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (d) {
          final v = d.primaryVelocity ?? 0;
          if (v.abs() < 300) return;
          final rtl = Directionality.of(context) == TextDirection.rtl;
          final older = rtl ? v < 0 : v > 0;
          if (!older && fit.historyAtLatest) return;
          HapticFeedback.selectionClick();
          fit.shiftHistoryMonth(older ? -1 : 1);
        },
        child: SheetPage(
          title: sentenceCase(t.historyTitle),
          eyebrow: t.profile,
          onBack: fit.popRoute,
          children: [
            Rise(index: 0, child: _MonthCard(key: ValueKey(month), month: month)),
            const SizedBox(height: 22),
            if (list.isEmpty)
              _empty(gc)
            else ...[
              Text(t.historyWorkouts(list.length),
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3)),
              const SizedBox(height: 10),
              for (var i = 0; i < list.length; i++) ...[
                Rise(index: i + 1, child: WorkoutHistoryCard(session: list[i], records: records[list[i]] ?? 0)),
                const SizedBox(height: 10),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _empty(GymColors gc) => Container(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 24),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
        child: Column(children: [
          Icon(PhosphorIconsRegular.calendarBlank, size: 30, color: gc.textTertiary),
          const SizedBox(height: 12),
          Text(t.historyEmpty,
              textAlign: TextAlign.center, style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
          const SizedBox(height: 4),
          Text(t.historyEmptyHint,
              textAlign: TextAlign.center,
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
        ]),
      );
}

class _MonthCard extends StatelessWidget {
  const _MonthCard({super.key, required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final now = fit.monthSummary(month);
    final before = fit.monthSummary(DateTime(month.year, month.month - 1));
    final trained = {for (final s in fit.sessionsInMonth(month)) s.day.day};
    final hours = now.seconds ~/ 3600;
    final minutes = (now.seconds % 3600) ~/ 60;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
      child: Column(children: [
        Row(children: [
          _arrow(gc, PhosphorIconsBold.caretLeft, t.notePrevMonth, () => fit.shiftHistoryMonth(-1)),
          Expanded(
            child: Text(t.monthYear(month),
                textAlign: TextAlign.center, style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
          ),
          _arrow(gc, PhosphorIconsBold.caretRight, t.noteNextMonth,
              fit.historyAtLatest ? null : () => fit.shiftHistoryMonth(1)),
        ]),
        const SizedBox(height: 16),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _stat(gc, '${now.workouts}', t.statWorkouts.toUpperCase(), now.workouts - before.workouts),
          _stat(gc, hours > 0 ? '${hours}h ${minutes.toString().padLeft(2, '0')}' : '${minutes}m', t.timeCaps, null),
          _stat(gc, '${now.sets}', t.setsCaps, null),
          _stat(gc, fit.volumeLabel(now.volume), t.volume, null),
        ]),
        const SizedBox(height: 16),
        Container(height: 1, color: gc.border),
        const SizedBox(height: 12),
        _calendar(context, gc, trained),
      ]),
    );
  }

  Widget _arrow(GymColors gc, IconData icon, String label, VoidCallback? onTap) => Semantics(
        button: true,
        enabled: onTap != null,
        label: label,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap == null
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  onTap();
                },
          child: Opacity(
            opacity: onTap == null ? 0.3 : 1,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
              child: Icon(icon, size: 13, color: gc.text),
            ),
          ),
        ),
      );

  Widget _stat(GymColors gc, String value, String label, int? delta) => Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: RollIn(value, style: AppTheme.f(21, weight: FontWeight.w800, color: gc.text, height: 1.1)),
          ),
          const SizedBox(height: 3),
          FitText(label, style: AppTheme.f(9, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1)),
          if (delta != null && delta != 0) ...[
            const SizedBox(height: 3),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(delta > 0 ? PhosphorIconsBold.arrowUp : PhosphorIconsBold.arrowDown,
                  size: 10, color: delta > 0 ? gc.sage : gc.textTertiary),
              const SizedBox(width: 2),
              Text('${delta.abs()}',
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: delta > 0 ? gc.sage : gc.textTertiary)),
            ]),
          ],
        ]),
      );

  Widget _calendar(BuildContext context, GymColors gc, Set<int> trained) {
    final today = DateTime.now();
    final first = DateTime(month.year, month.month);
    final days = DateTime(month.year, month.month + 1, 0).day;
    final lead = (first.weekday - fit.weekStartDay + 7) % 7;
    return Column(children: [
      Row(children: [
        for (var i = 0; i < 7; i++)
          Expanded(
            child: Text(t.weekdayInitial(fit.weekdayAt(i)).toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1)),
          ),
      ]),
      const SizedBox(height: 6),
      for (var row = 0; row * 7 < lead + days; row++)
        Row(children: [
          for (var col = 0; col < 7; col++)
            Expanded(child: () {
              final n = row * 7 + col - lead + 1;
              if (n < 1 || n > days) return const SizedBox(height: 40);
              final day = DateTime(month.year, month.month, n);
              final on = trained.contains(n);
              final isToday = DateUtils.isSameDay(day, today);
              final future = day.isAfter(today);
              return Semantics(
                button: on,
                label: t.fullDate(day),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: future ? null : () => showDaySheet(context, day),
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: on ? gc.accent : Colors.transparent,
                          shape: BoxShape.circle,
                          border: isToday && !on ? Border.all(color: gc.ember, width: 1.4) : null,
                        ),
                        child: Text('$n',
                            style: AppTheme.f(13,
                                weight: on || isToday ? FontWeight.w800 : FontWeight.w500,
                                color: on
                                    ? gc.onEmber
                                    : future
                                        ? gc.textTertiary.withValues(alpha: 0.5)
                                        : gc.textSecondary)),
                      ),
                    ),
                  ),
                ),
              );
            }()),
        ]),
    ]);
  }
}

class WorkoutHistoryCard extends StatelessWidget {
  const WorkoutHistoryCard({super.key, required this.session, this.records = 0});

  final LoggedSession session;
  final int records;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final s = session;
    final start = TimeOfDay.fromDateTime(s.day);
    final clock = MaterialLocalizations.of(context)
        .formatTimeOfDay(start, alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context));
    final meta = [clock, if (s.durationSec >= 60) '${(s.durationSec / 60).round()} min'].join(' · ');
    final shown = s.exercises.take(4).toList();
    return Pressable(
      scale: 0.98,
      onTap: () => showDaySheet(context, s.day),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 46,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                Text(t.weekdayShort(s.day.weekday).toUpperCase(),
                    style: AppTheme.f(9, weight: FontWeight.w800, color: gc.accent, letterSpacing: 0.8)),
                Text('${s.day.day}', style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text, height: 1.15)),
              ]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(fit.sessionHeading(s),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
                const SizedBox(height: 2),
                Text(meta, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
                const SizedBox(height: 6),
                Text(
                    [t.exerciseCount(s.exercises.length), t.setCount(s.setCount), if (s.volume > 0) fit.volumeLabel(s.volume)]
                        .join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
              ]),
            ),
            if (records > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(100)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(PhosphorIconsFill.trophy, size: 11, color: gc.accent),
                  const SizedBox(width: 4),
                  Text('$records', style: AppTheme.f(11.5, weight: FontWeight.w800, color: gc.accent)),
                ]),
              ),
            ],
          ]),
          const SizedBox(height: 12),
          Container(height: 1, color: gc.border),
          const SizedBox(height: 10),
          for (final e in shown) _line(gc, e),
          if (s.exercises.length > shown.length)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(t.historyMore(s.exercises.length - shown.length),
                  style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
            ),
        ]),
      ),
    );
  }

  Widget _line(GymColors gc, LoggedExercise e) {
    final top = fit.topSetOf(e);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        SizedBox(
          width: 30,
          child: Text('${e.workingSets.length}×',
              style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textTertiary)),
        ),
        Expanded(
          child: Text(t.catalogName(e.id, e.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text)),
        ),
        if (e.workingSets.any(fit.recordSets.contains)) ...[
          const SizedBox(width: 8),
          RecordBadge(label: sentenceCase(t.personalRecord), size: 16),
        ],
        if (top != null) ...[
          const SizedBox(width: 8),
          Text(fit.loggedSetLabel(top), style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textSecondary)),
        ],
      ]),
    );
  }
}
