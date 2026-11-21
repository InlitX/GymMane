import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/exercise_history_sheet.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/set_kind.dart';
import '../widgets/sheet_page.dart';
import '../widgets/ui_kit.dart';
import 'progress_screen.dart';
import 'sticker_screen.dart';

class WorkoutViewScreen extends StatelessWidget {
  const WorkoutViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final s = fit.viewedSession;
    if (s == null || !fit.sessions.contains(s)) {
      return SheetPage(title: sentenceCase(t.historyTitle), onBack: fit.popRoute);
    }
    final records = fit.recordSets;
    final broke = fit.recordsIn(s);
    return RiseScope(
      id: 'workout-view',
      once: false,
      child: SheetPage(
        title: fit.sessionHeading(s),
        eyebrow: t.longDate(s.day),
        onBack: fit.popRoute,
        actions: [
          RoundAction(
            label: t.copyWorkout,
            onTap: () {
              Clipboard.setData(ClipboardData(text: fit.workoutText(s)));
              showNotchToast(context, t.copiedDone, icon: PhosphorIconsRegular.copy, accent: gc.accent);
            },
            child: Icon(PhosphorIconsRegular.copy, size: 17, color: gc.text),
          ),
          RoundAction(
            label: t.stickerOpen,
            onTap: () => showStickerEditor(context, s, prs: broke),
            child: Icon(PhosphorIconsRegular.imageSquare, size: 17, color: gc.text),
          ),
          RoundAction(
            label: t.editEntry,
            onTap: () => showDaySheet(context, s.day),
            child: Icon(PhosphorIconsRegular.pencilSimple, size: 17, color: gc.text),
          ),
        ],
        children: [
          Rise(index: 0, child: _Totals(session: s, records: broke)),
          for (final (i, e) in s.exercises.indexed) ...[
            const SizedBox(height: 12),
            Rise(index: i + 1, child: _ExerciseCard(session: s, exercise: e, records: records)),
          ],
        ],
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals({required this.session, required this.records});

  final LoggedSession session;
  final int records;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final s = session;
    final big = s.volume > 0 ? fit.volumeLabel(s.volume) : '${(s.durationSec / 60).round()} min';
    final meta = [
      if (s.volume > 0 && s.durationSec >= 60) '${(s.durationSec / 60).round()} min',
      t.exerciseCount(s.exercises.length),
      t.setCount(s.setCount),
      if (s.hrAvg != null) '♥ ${s.hrAvg}',
    ].join(' · ');
    return SoftCard(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s.volume > 0 ? t.volume : t.timeCaps,
                style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
            const SizedBox(height: 6),
            FitText(big, style: AppTheme.f(34, weight: FontWeight.w800, color: gc.text, letterSpacing: -1, height: 1)),
            const SizedBox(height: 8),
            Text(meta,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
          ]),
        ),
        if (records > 0) ...[
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(100)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(PhosphorIconsFill.trophy, size: 12, color: gc.accent),
              const SizedBox(width: 5),
              Text('$records', style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.accent)),
            ]),
          ),
        ],
      ]),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.session, required this.exercise, required this.records});

  final LoggedSession session;
  final LoggedExercise exercise;
  final Set<LoggedSet> records;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final e = exercise;
    final kcal = fit.cardioKcal(session, e);
    var n = 0;
    return SoftCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Pressable(
          scale: 0.98,
          onTap: () => showExerciseHistorySheet(context, e.id),
          child: Row(children: [
            Expanded(
              child: Text(t.catalogName(e.id, e.name),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
            ),
            const SizedBox(width: 8),
            Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
          ]),
        ),
        if (kcal != null) ...[
          const SizedBox(height: 2),
          Text('${kcal.own ? '' : '≈ '}${fit.energyOf(kcal.active)} ${fit.energyUnit} ${t.kcalActive}',
              style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
        ],
        const SizedBox(height: 8),
        for (final x in e.sets) _setRow(gc, x, x.counts ? ++n : null),
      ]),
    );
  }

  Widget _setRow(GymColors gc, LoggedSet x, int? number) {
    final tag = setKindTag(x.kind);
    final record = records.contains(x);
    final lead = number == null || tag.isNotEmpty ? (tag.isEmpty ? '·' : tag) : '$number';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          SizedBox(
            width: 30,
            child: Text(lead,
                style: AppTheme.f(13, weight: FontWeight.w800, color: tag.isEmpty ? gc.textTertiary : setKindColor(gc, x.kind))),
          ),
          Expanded(
            child: Text(fit.loggedSetLabel(x, id: exercise.id).replaceAll('×', ' × '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14.5, weight: FontWeight.w700, color: x.counts ? gc.text : gc.textSecondary)),
          ),
          if (x.rpe != null) ...[
            const SizedBox(width: 8),
            Text(fit.effortTag(x.rpe!), style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
          ],
          if (record) ...[
            const SizedBox(width: 8),
            RecordBadge(label: sentenceCase(t.personalRecord), size: 16),
          ],
        ]),
        if (x.note.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 30, top: 3),
            child: Text(x.note, style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
          ),
      ]),
    );
  }
}
