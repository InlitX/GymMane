import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../app/desktop.dart';
import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../services/file_share.dart';
import '../services/workout_history_xlsx.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/sheet_page.dart';
import '../widgets/set_kind.dart';
import '../widgets/ui_kit.dart';
import 'progress_screen.dart';

GymColors _minimalHistoryColors(GymColors base) => base.copyWith(
      pageBg: const Color(0xFF0E0E0D),
      bg: const Color(0xFF141413),
      bgRaised: const Color(0xFF1B1B1A),
      bgRaised2: const Color(0xFF222221),
      border: const Color(0xFF2C2C2A),
      navBg: const Color(0xEE141413),
      text: const Color(0xFFE9E7E2),
      textSecondary: const Color(0xFF8D8A84),
      textTertiary: const Color(0xFF5F5D58),
      ember: const Color(0xFFC8A45F),
      emberDeep: const Color(0xFFA88647),
      onEmber: const Color(0xFF141413),
      emberSoft: const Color(0x35C8A45F),
      accent: const Color(0xFFC8A45F),
      accentSoft: const Color(0x35C8A45F),
      brass: const Color(0xFFC8A45F),
      sage: const Color(0xFFC8A45F),
      sageSoft: const Color(0x35C8A45F),
      mutedFill: const Color(0xFF222221),
      heatEmpty: const Color(0xFF222221),
    );

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final base = context.gc;
    final compact = fit.minimalMode;
    final gc = compact ? _minimalHistoryColors(base) : base;
    final month = fit.historyMonth;
    final list = fit.sessionsInMonth(month);
    final records = fit.recordsBySession();
    if (compact) return _minimalHistory(context, gc, month, list, records, fit.sessions);
    return RiseScope(
      id: 'history',
      once: false,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (d) {
          final v = d.primaryVelocity ?? 0;
          if (v.abs() < 300) return;
          final rtl = Directionality.of(context).name == 'rtl';
          final older = rtl ? v < 0 : v > 0;
          if (!older && fit.historyAtLatest) return;
          HapticFeedback.selectionClick();
          fit.shiftHistoryMonth(older ? -1 : 1);
        },
        child: SheetPage(
          title: sentenceCase(t.historyTitle),
          eyebrow: t.profile,
          onBack: fit.popRoute,
          children: DesktopScope.of(context)
              ? [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(width: 420, child: Rise(index: 0, child: _MonthCard(key: ValueKey(month), month: month))),
                    const SizedBox(width: 24),
                    Expanded(
                      child: list.isEmpty
                          ? _empty(gc)
                          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                              Text(t.historyWorkouts(list.length),
                                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                              const SizedBox(height: 10),
                              CardFlow(minColumn: 300, maxColumns: 2, gap: 12, children: [
                                for (var i = 0; i < list.length; i++)
                                  Rise(index: i + 1, child: WorkoutHistoryCard(session: list[i], records: records[list[i]] ?? 0)),
                              ]),
                            ]),
                    ),
                  ]),
                ]
              : [
            Rise(index: 0, child: _MonthCard(key: ValueKey(month), month: month)),
            const SizedBox(height: 22),
            if (list.isEmpty)
              _empty(gc)
            else ...[
              Text(t.historyWorkouts(list.length),
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
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

  Widget _minimalHistory(
    BuildContext context,
    GymColors gc,
    DateTime month,
    List<LoggedSession> list,
    Map<LoggedSession, int> records,
    List<LoggedSession> allSessions,
  ) {
    final theme = Theme.of(context).copyWith(extensions: [gc]);
    return Theme(
      data: theme,
      child: ColoredBox(
        color: gc.bg,
        child: SafeArea(
          bottom: false,
          child: _MinimalHistoryContent(
            month: month,
            monthSessions: list,
            allSessions: allSessions,
            records: records,
          ),
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

enum _MinimalHistoryView { list, table }

enum _MinimalHistorySort { date, exercise, set, weight, reps, volume, oneRm, muscle }

class _MinimalHistoryContent extends StatefulWidget {
  const _MinimalHistoryContent({
    required this.month,
    required this.monthSessions,
    required this.allSessions,
    required this.records,
  });

  final DateTime month;
  final List<LoggedSession> monthSessions;
  final List<LoggedSession> allSessions;
  final Map<LoggedSession, int> records;

  @override
  State<_MinimalHistoryContent> createState() => _MinimalHistoryContentState();
}

class _MinimalHistoryContentState extends State<_MinimalHistoryContent> {
  final _searchController = TextEditingController();
  _MinimalHistoryView _view = _MinimalHistoryView.list;
  _MinimalHistorySort _sort = _MinimalHistorySort.date;
  bool _descending = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _exportHistory() async {
    if (widget.allSessions.isEmpty) return;
    final stamp = DateTime.now().toIso8601String().split('T').first;
    try {
      await shareFile(
        'gymmane-history-$stamp.xlsx',
        workoutHistoryXlsx(widget.allSessions),
        mime: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        subject: 'GymMane workout history',
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Could not export workout history.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                tooltip: t.back,
                visualDensity: VisualDensity.compact,
                onPressed: fit.popRoute,
                icon: Icon(PhosphorIconsRegular.arrowLeft, size: 18, color: gc.textSecondary),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  sentenceCase(t.historyTitle),
                  style: AppTheme.f(20, weight: FontWeight.w800, color: gc.text),
                ),
              ),
              TextButton(
                onPressed: widget.allSessions.isEmpty ? null : _exportHistory,
                style: TextButton.styleFrom(
                  foregroundColor: gc.accent,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Export Excel'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _MonthCard(key: ValueKey(widget.month), month: widget.month, minimal: true),
          const SizedBox(height: 12),
          _viewSwitcher(gc),
          const SizedBox(height: 8),
          if (_view == _MinimalHistoryView.list) _listView(gc) else _tableView(gc),
        ],
      ),
    );
  }

  Widget _viewSwitcher(GymColors gc) {
    Widget option(String label, _MinimalHistoryView value) {
      final selected = _view == value;
      return InkWell(
        onTap: () => setState(() => _view = value),
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: selected ? gc.bgRaised2 : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            label,
            style: AppTheme.f(11, weight: selected ? FontWeight.w800 : FontWeight.w600,
                color: selected ? gc.text : gc.textTertiary),
          ),
        ),
      );
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: gc.border),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            option('List', _MinimalHistoryView.list),
            option('Table', _MinimalHistoryView.table),
          ]),
        ),
        const Spacer(),
        if (_view == _MinimalHistoryView.list)
          Text(
            t.historyWorkouts(widget.monthSessions.length),
            style: AppTheme.f(10.5, weight: FontWeight.w600, color: gc.textTertiary),
          )
        else
          Text(
            '${widget.allSessions.length} workouts',
            style: AppTheme.f(10.5, weight: FontWeight.w600, color: gc.textTertiary),
          ),
      ],
    );
  }

  Widget _listView(GymColors gc) {
    if (widget.monthSessions.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(children: [
          Icon(PhosphorIconsRegular.calendarBlank, size: 27, color: gc.textTertiary),
          const SizedBox(height: 9),
          Text(t.historyEmpty,
              textAlign: TextAlign.center,
              style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
          const SizedBox(height: 4),
          Text(t.historyEmptyHint,
              textAlign: TextAlign.center,
              style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
        ]),
      );
    }
    return Column(
      children: [
        for (final session in widget.monthSessions)
          WorkoutHistoryCard(
            session: session,
            records: widget.records[session] ?? 0,
            minimal: true,
          ),
      ],
    );
  }

  List<_MinimalHistorySetRow> _filteredRows() {
    final query = _searchController.text.trim().toLowerCase();
    final rows = <_MinimalHistorySetRow>[];
    for (final session in widget.allSessions) {
      for (final exercise in session.exercises) {
        for (var i = 0; i < exercise.sets.length; i++) {
          final row = _MinimalHistorySetRow(
            session: session,
            exercise: exercise,
            set: exercise.sets[i],
            setNumber: i + 1,
          );
          if (query.isEmpty) {
            rows.add(row);
            continue;
          }
          final date = row.session.day;
          final searchable = [
            row.session.name ?? '',
            row.exercise.name,
            row.exercise.primary,
            intl.DateFormat('yyyy-MM-dd').format(date),
            intl.DateFormat('dd MMM yyyy').format(date),
            t.fullDate(date),
          ].join(' ').toLowerCase();
          if (searchable.contains(query)) rows.add(row);
        }
      }
    }
    rows.sort((a, b) {
      final comparison = switch (_sort) {
        _MinimalHistorySort.date => a.session.day.compareTo(b.session.day),
        _MinimalHistorySort.exercise => a.exercise.name.toLowerCase().compareTo(b.exercise.name.toLowerCase()),
        _MinimalHistorySort.set => a.setNumber.compareTo(b.setNumber),
        _MinimalHistorySort.weight => a.set.weight.compareTo(b.set.weight),
        _MinimalHistorySort.reps => a.set.reps.compareTo(b.set.reps),
        _MinimalHistorySort.volume => a.set.volume.compareTo(b.set.volume),
        _MinimalHistorySort.oneRm => a.set.oneRm.compareTo(b.set.oneRm),
        _MinimalHistorySort.muscle => a.exercise.primary.toLowerCase().compareTo(b.exercise.primary.toLowerCase()),
      };
      return _descending ? -comparison : comparison;
    });
    return rows;
  }

  Widget _tableView(GymColors gc) {
    final rows = _filteredRows();
    final visible = rows.take(200).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 38,
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.text),
            cursorColor: gc.accent,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Filter by exercise, muscle or date',
              hintStyle: AppTheme.f(11, weight: FontWeight.w500, color: gc.textTertiary),
              prefixIcon: Icon(PhosphorIconsRegular.magnifyingGlass, size: 15, color: gc.textTertiary),
              prefixIconConstraints: const BoxConstraints(minWidth: 34),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: Icon(PhosphorIconsRegular.x, size: 14, color: gc.textTertiary),
                    ),
              suffixIconConstraints: const BoxConstraints(minWidth: 30),
              filled: true,
              fillColor: gc.bgRaised,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: gc.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: gc.accent),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Text('${rows.length} sets',
              style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textSecondary)),
          const Spacer(),
          Text('Tap a heading to sort',
              style: AppTheme.f(9.5, weight: FontWeight.w500, color: gc.textTertiary)),
        ]),
        const SizedBox(height: 5),
        if (visible.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Text(
              _searchController.text.isEmpty ? 'No sets logged yet.' : 'No sets match that search.',
              textAlign: TextAlign.center,
              style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary),
            ),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 611,
              child: Column(
                children: [
                  Container(
                    height: 31,
                    decoration: BoxDecoration(
                      color: gc.bgRaised,
                      border: Border(bottom: BorderSide(color: gc.border)),
                    ),
                    child: Row(children: [
                      _sortHeader(_MinimalHistorySort.date, 'Date', 80, gc),
                      _sortHeader(_MinimalHistorySort.exercise, 'Exercise', 178, gc),
                      _sortHeader(_MinimalHistorySort.set, 'Set', 38, gc, right: true),
                      _sortHeader(_MinimalHistorySort.weight, 'kg', 54, gc, right: true),
                      _sortHeader(_MinimalHistorySort.reps, 'Reps', 47, gc, right: true),
                      _sortHeader(_MinimalHistorySort.volume, 'Vol', 65, gc, right: true),
                      _sortHeader(_MinimalHistorySort.oneRm, '1RM', 65, gc, right: true),
                      _sortHeader(_MinimalHistorySort.muscle, 'Muscle', 84, gc),
                    ]),
                  ),
                  for (final row in visible) _historyTableRow(row, gc),
                ],
              ),
            ),
          ),
        if (rows.length > visible.length)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'Showing ${visible.length} of ${rows.length} sets. Search to narrow the results.',
              style: AppTheme.f(9.5, weight: FontWeight.w500, color: gc.textTertiary),
            ),
          ),
      ],
    );
  }

  Widget _sortHeader(_MinimalHistorySort column, String label, double width, GymColors gc, {bool right = false}) {
    final active = _sort == column;
    return InkWell(
      onTap: () => setState(() {
        if (_sort == column) {
          _descending = !_descending;
        } else {
          _sort = column;
          _descending = column == _MinimalHistorySort.date;
        }
      }),
      child: SizedBox(
        width: width,
        height: 31,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: right ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(9.5, weight: FontWeight.w800,
                      color: active ? gc.accent : gc.textTertiary),
                ),
              ),
              if (active)
                Icon(_descending ? PhosphorIconsBold.caretDown : PhosphorIconsBold.caretUp,
                    size: 9, color: gc.accent),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyTableRow(_MinimalHistorySetRow row, GymColors gc) {
    final date = intl.DateFormat('dd MMM yy').format(row.session.day);
    final type = switch (row.set.kind) {
      SetKind.normal => '',
      SetKind.warmup => 'W',
      SetKind.drop => 'D',
      SetKind.failure => 'F',
      SetKind.restPause => 'RP',
      SetKind.cluster => 'C',
    };
    final weight = row.set.weight > 0 ? _metric(row.set.weight) : '—';
    final reps = row.set.reps > 0 ? '${row.set.reps}' : '—';
    final volume = row.set.volume > 0 ? _metric(row.set.volume) : '—';
    final oneRm = row.set.counts && row.set.oneRm > 0 ? _metric(row.set.oneRm) : '—';
    return Container(
      height: 34,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.65)))),
      child: Row(children: [
        _tableCell(date, 80, gc),
        _tableCell(t.catalogName(row.exercise.id, row.exercise.name), 178, gc),
        _tableCell('${row.setNumber}$type', 38, gc, right: true),
        _tableCell(weight, 54, gc, right: true, muted: weight == '—'),
        _tableCell(reps, 47, gc, right: true, muted: reps == '—'),
        _tableCell(volume, 65, gc, right: true, muted: volume == '—'),
        _tableCell(oneRm, 65, gc, right: true, muted: oneRm == '—'),
        _tableCell(sentenceCase(row.exercise.primary), 84, gc, muted: true),
      ]),
    );
  }

  Widget _tableCell(String value, double width, GymColors gc, {bool right = false, bool muted = false}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Align(
          alignment: right ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(10, weight: FontWeight.w600,
                color: muted ? gc.textTertiary : gc.textSecondary),
          ),
        ),
      ),
    );
  }

  String _metric(double value) =>
      value == value.roundToDouble() ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
}

class _MinimalHistorySetRow {
  const _MinimalHistorySetRow({
    required this.session,
    required this.exercise,
    required this.set,
    required this.setNumber,
  });

  final LoggedSession session;
  final LoggedExercise exercise;
  final LoggedSet set;
  final int setNumber;
}

class _MonthCard extends StatelessWidget {
  const _MonthCard({super.key, required this.month, this.minimal = false});

  final DateTime month;
  final bool minimal;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final now = fit.monthSummary(month);
    final before = fit.monthSummary(DateTime(month.year, month.month - 1));
    final trained = {for (final s in fit.sessionsInMonth(month)) s.day.day};
    final hours = now.seconds ~/ 3600;
    final minutes = (now.seconds % 3600) ~/ 60;
    return Container(
      padding: EdgeInsets.fromLTRB(minimal ? 10 : 16, minimal ? 9 : 14, minimal ? 10 : 16, minimal ? 10 : 16),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(minimal ? 10 : 22)),
      child: Column(children: [
        Row(children: [
          _arrow(gc, PhosphorIconsBold.caretLeft, t.notePrevMonth, () => fit.shiftHistoryMonth(-1)),
          Expanded(
            child: Text(t.monthYear(month),
                textAlign: TextAlign.center, style: AppTheme.f(minimal ? 13.5 : 16, weight: FontWeight.w800, color: gc.text)),
          ),
          _arrow(gc, PhosphorIconsBold.caretRight, t.noteNextMonth,
              fit.historyAtLatest ? null : () => fit.shiftHistoryMonth(1)),
        ]),
        SizedBox(height: minimal ? 9 : 16),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _stat(gc, '${now.workouts}', t.statWorkouts.toUpperCase(), now.workouts - before.workouts, minimal: minimal),
          _stat(gc, hours > 0 ? '${hours}h ${minutes.toString().padLeft(2, '0')}' : '${minutes}m', t.timeCaps, null, minimal: minimal),
          _stat(gc, '${now.sets}', t.setsCaps, null, minimal: minimal),
          _stat(gc, fit.volumeLabel(now.volume), t.volume, null, minimal: minimal),
        ]),
        SizedBox(height: minimal ? 9 : 16),
        Container(height: 1, color: gc.border),
        SizedBox(height: minimal ? 8 : 12),
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
              width: minimal ? 28 : 34,
              height: minimal ? 28 : 34,
              decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
              child: Icon(icon, size: 13, color: gc.text),
            ),
          ),
        ),
      );

  Widget _stat(GymColors gc, String value, String label, int? delta, {bool minimal = false}) => Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: RollIn(value, style: AppTheme.f(minimal ? 16 : 21, weight: FontWeight.w800, color: gc.text, height: 1.1)),
          ),
          const SizedBox(height: 3),
          FitText(label, style: AppTheme.f(minimal ? 8 : 9, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1)),
          if (delta != null && delta != 0) ...[
            const SizedBox(height: 3),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(delta > 0 ? PhosphorIconsBold.arrowUp : PhosphorIconsBold.arrowDown,
                  size: 10, color: delta > 0 ? gc.sage : gc.textTertiary),
              const SizedBox(width: 2),
              Text('${delta.abs()}',
                  style: AppTheme.f(minimal ? 9 : 10.5, weight: FontWeight.w700, color: delta > 0 ? gc.sage : gc.textTertiary)),
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
                style: AppTheme.f(minimal ? 8.5 : 10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1)),
          ),
      ]),
      SizedBox(height: minimal ? 4 : 6),
      for (var row = 0; row * 7 < lead + days; row++)
        Row(children: [
          for (var col = 0; col < 7; col++)
            Expanded(child: () {
              final n = row * 7 + col - lead + 1;
              if (n < 1 || n > days) return SizedBox(height: minimal ? 30 : 40);
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
                    height: minimal ? 30 : 40,
                    child: Center(
                      child: Container(
                        width: minimal ? 24 : 32,
                        height: minimal ? 24 : 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: on ? gc.accent : Colors.transparent,
                          shape: BoxShape.circle,
                          border: isToday && !on ? Border.all(color: gc.ember, width: 1.4) : null,
                        ),
                        child: Text('$n',
                            style: AppTheme.f(minimal ? 11 : 13,
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
  const WorkoutHistoryCard({super.key, required this.session, this.records = 0, this.minimal = false});

  final LoggedSession session;
  final int records;
  final bool minimal;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final s = session;
    final start = TimeOfDay.fromDateTime(s.day);
    final clock = MaterialLocalizations.of(context)
        .formatTimeOfDay(start, alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context));
    final meta = [
      clock,
      if (s.durationSec >= 60) '${(s.durationSec / 60).round()} min',
      if (s.hrAvg != null) '\u2665 ${s.hrAvg} · ${t.hrMaxShort(s.hrMax ?? s.hrAvg!)}',
    ].join(' · ');
    final shown = s.exercises.take(4).toList();
    return Pressable(
      scale: 0.98,
      onTap: () => showDaySheet(context, s.day),
      child: Container(
        padding: EdgeInsets.fromLTRB(minimal ? 10 : 14, minimal ? 10 : 14, minimal ? 12 : 16, minimal ? 10 : 14),
        decoration: BoxDecoration(
          color: minimal ? gc.bg : gc.bgRaised,
          borderRadius: BorderRadius.circular(minimal ? 0 : 20),
          border: minimal ? Border(bottom: BorderSide(color: gc.border)) : null,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: minimal ? 40 : 46,
              padding: EdgeInsets.symmetric(vertical: minimal ? 4 : 6),
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(minimal ? 9 : 12)),
              child: Column(children: [
                Text(t.weekdayShort(s.day.weekday).toUpperCase(),
                    style: AppTheme.f(9, weight: FontWeight.w800, color: gc.accent, letterSpacing: 0.8)),
                Text('${s.day.day}', style: AppTheme.f(minimal ? 17 : 19, weight: FontWeight.w800, color: gc.text, height: 1.15)),
              ]),
            ),
            SizedBox(width: minimal ? 9 : 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(fit.sessionHeading(s),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(minimal ? 14 : 16, weight: FontWeight.w800, color: gc.text)),
                const SizedBox(height: 2),
                Text(meta, style: AppTheme.f(minimal ? 11 : 12, weight: FontWeight.w600, color: gc.textSecondary)),
                SizedBox(height: minimal ? 4 : 6),
                Text(
                    [t.exerciseCount(s.exercises.length), t.setCount(s.setCount), if (s.volume > 0) fit.volumeLabel(s.volume)]
                        .join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(minimal ? 10.5 : 11.5, weight: FontWeight.w600, color: gc.textTertiary)),
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
          SizedBox(height: minimal ? 8 : 12),
          Container(height: 1, color: gc.border),
          SizedBox(height: minimal ? 7 : 10),
          for (final e in shown) _line(gc, e, compact: minimal),
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

  Widget _line(GymColors gc, LoggedExercise e, {bool compact = false}) {
    final top = fit.topSetOf(e);
    return Padding(
      padding: EdgeInsets.only(bottom: compact ? 4 : 6),
      child: Row(children: [
        SizedBox(
          width: 30,
          child: Text('${e.workingSets.length}×',
              style: AppTheme.f(compact ? 11 : 12.5, weight: FontWeight.w700, color: gc.textTertiary)),
        ),
        Expanded(
          child: Text(t.catalogName(e.id, e.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(compact ? 11.5 : 13, weight: FontWeight.w600, color: gc.text)),
        ),
        if (e.workingSets.any(fit.recordSets.contains)) ...[
          const SizedBox(width: 8),
          RecordBadge(label: sentenceCase(t.personalRecord), size: 16),
        ],
        if (top != null) ...[
          const SizedBox(width: 8),
          Text(fit.loggedSetLabel(top), style: AppTheme.f(compact ? 11 : 12.5, weight: FontWeight.w700, color: gc.textSecondary)),
        ],
      ]),
    );
  }
}
