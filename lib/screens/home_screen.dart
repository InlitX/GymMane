import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
import '../widgets/exercise_media.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final now = DateTime.now();
    final dateLabel = t.longDate(now);
    final recommended = fit.recommendedExercises(6);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.today,
                        style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1.5)),
                    const SizedBox(height: 2),
                    Text(dateLabel, style: AppTheme.d(20, weight: FontWeight.w600, color: gc.text)),
                  ],
                ),
                GestureDetector(
                  onTap: fit.goProgress,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: gc.emberSoft, borderRadius: BorderRadius.circular(100)),
                    child: Row(children: [
                      SvgPathIcon(Ic.flame, size: 16, color: gc.accent),
                      const SizedBox(width: 6),
                      Text('${fit.currentStreak}', style: AppTheme.d(14, weight: FontWeight.w600, color: gc.accent)),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            _FocusHero(),
            const SizedBox(height: 22),
            if (fit.todayRoutine != null) ...[
              _todayRoutine(gc),
              const SizedBox(height: 22),
            ],
            if (fit.photoDue) ...[
              _photoNudge(gc),
              const SizedBox(height: 22),
            ],
            SoftCard(
              radius: 20,
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [for (int i = 0; i < 7; i++) _weekDay(gc, i)],
              ),
            ),
            const SizedBox(height: 22),
            Text(t.thisWeek,
                style: AppTheme.d(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 3)),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _stat(gc, t.volume, fit.volumeValue(fit.volumeThisWeekKg), unit: ' ${fit.volumeUnit}')),
              const SizedBox(width: 12),
              Expanded(child: _stat(gc, t.setsToday, '${fit.setsToday}')),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _stat(gc, t.prs, '${fit.prsThisWeek}', valueColor: gc.ember)),
              const SizedBox(width: 12),
              Expanded(child: _goalCard(gc)),
            ]),
            const SizedBox(height: 22),
            _activityCard(gc),
            const SizedBox(height: 22),
            Text(t.recommended,
                style: AppTheme.d(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 3)),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommended.length,
                itemBuilder: (context, i) => _recCard(gc, recommended[i]),
              ),
            ),
            const SizedBox(height: 22),
            Row(children: [
              Expanded(child: _quick(gc, Icon(PhosphorIconsRegular.listChecks, size: 22, color: gc.ember), t.routines, fit.goRoutines)),
              const SizedBox(width: 12),
              Expanded(child: _quick(gc, Icon(PhosphorIconsRegular.barbell, size: 22, color: gc.ember), t.exercises, fit.goExercises)),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _quick(gc, SvgPathIcon(Ic.wrench, size: 20, color: gc.ember), t.tools, fit.goTools)),
              const SizedBox(width: 12),
              Expanded(
                  child: _quick(gc, Icon(PhosphorIconsRegular.notebook, size: 22, color: gc.ember),
                      t.journal, fit.goNotes, badge: fit.notes.length)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _weekDay(GymColors gc, int i) {
    final done = fit.isDayDone(i);
    final isToday = i == fit.todayIndex;
    final isFuture = i > fit.todayIndex;
    Color fill = gc.bgRaised2;
    Border? border;
    double opacity = 1;
    if (done) {
      fill = gc.ember;
    } else if (isToday) {
      border = Border.all(color: gc.ember, width: 2);
    } else if (isFuture) {
      fill = gc.bgRaised2;
      opacity = 0.7;
    } else {
      border = Border.all(color: gc.textTertiary, width: 1.5);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isFuture ? null : () => fit.toggleCheckin(i),
      child: Opacity(
        opacity: opacity,
        child: Column(
          children: [
            Text(t.weekdayInitial(i + 1),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isToday ? gc.ember : gc.textTertiary)),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: fill,
                shape: BoxShape.circle,
                border: border,
              ),
              child: done ? Center(child: SvgPathIcon(Ic.checkBold, size: 14, color: gc.onEmber)) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(GymColors gc, String label, String value, {String? unit, Color? valueColor}) {
    return SoftCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: value,
              style: AppTheme.d(28, weight: FontWeight.w700, color: valueColor ?? gc.text),
              children: [
                if (unit != null)
                  TextSpan(text: unit, style: AppTheme.d(16, weight: FontWeight.w700, color: gc.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityCard(GymColors gc) {
    return GestureDetector(
      onTap: fit.goProgress,
      child: SoftCard(
        radius: 20,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(t.activityLabel,
                    style: AppTheme.d(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 3)),
                const Spacer(),
                SvgPathIcon(Ic.flame, size: 15, color: gc.accent),
                const SizedBox(width: 5),
                Text('${fit.currentStreak}',
                    style: AppTheme.d(14, weight: FontWeight.w700, color: gc.accent)),
                const SizedBox(width: 8),
                Icon(PhosphorIconsRegular.caretRight, size: 14, color: gc.textTertiary),
              ],
            ),
            const SizedBox(height: 14),
            Heatmap(levels: fit.heatmapLevels),
          ],
        ),
      ),
    );
  }

  Widget _goalCard(GymColors gc) {
    return SoftCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GoalRing(pct: fit.goalPct.toDouble()),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.goal, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
              const SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  text: '${fit.goalPct}',
                  style: AppTheme.d(22, weight: FontWeight.w700, color: gc.text),
                  children: [
                    TextSpan(text: '%', style: AppTheme.d(14, weight: FontWeight.w700, color: gc.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quick(GymColors gc, Widget iconWidget, String label, VoidCallback onTap, {int badge = 0}) {
    return GestureDetector(
      onTap: onTap,
      child: SoftCard(
        radius: 18,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: 22, child: iconWidget),
                const Spacer(),
                if (badge > 0)
                  Text('$badge',
                      style: AppTheme.d(13, weight: FontWeight.w600, color: gc.textTertiary)),
              ],
            ),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(label,
                  maxLines: 1, style: AppTheme.d(14, weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoNudge(GymColors gc) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: fit.goTimeline,
      child: SoftCard(
        radius: 20,
        padding: const EdgeInsets.all(18),
        borderColor: gc.accent,
        child: Row(
          children: [
            Icon(PhosphorIconsRegular.camera, size: 20, color: gc.accent),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.photoDueNow,
                      style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(t.photoInterval(fit.photoIntervalDays),
                      style: AppTheme.s(12, color: gc.textSecondary)),
                ],
              ),
            ),
            Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _todayRoutine(GymColors gc) {
    final r = fit.todayRoutine!;
    final n = r.exerciseIds.length;
    return SoftCard(
      radius: 20,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.todaysRoutine,
                    style: AppTheme.d(11, weight: FontWeight.w600, color: gc.brass, letterSpacing: 2)),
                const SizedBox(height: 4),
                Text(fit.routineTitle(r), style: AppTheme.d(22, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(height: 2),
                Text(t.exerciseCount(n), style: AppTheme.s(13, color: gc.textSecondary)),
              ],
            ),
          ),
          if (n > 0)
            GestureDetector(
              onTap: () => fit.startRoutine(r),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
                child: Icon(PhosphorIconsFill.play, size: 22, color: gc.onEmber),
              ),
            ),
        ],
      ),
    );
  }

  Widget _recCard(GymColors gc, Exercise ex) {
    return GestureDetector(
      onTap: () => fit.openExercise(ex.id),
      child: Container(
        width: 128,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExerciseMedia(ex: ex, height: 84, radius: 10),
            const SizedBox(height: 8),
            Expanded(
              child: Text(exerciseName(ex),
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: AppTheme.s(12, weight: FontWeight.w600, color: gc.text, height: 1.2)),
            ),
          ],
        ),
      ),
    );
  }
}

class _FocusHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final focus = fit.suggestedFocus;
    final count = fit.getFilteredExercises(focus.muscles).length;
    final subtitle = fit.hasData
        ? '${focus.subtitle} · ${t.exerciseCount(count)}'
        : t.firstSessionHint;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -45,
              bottom: -45,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              right: -14,
              top: -6,
              bottom: -6,
              child: Opacity(
                opacity: 0.55,
                child: Image.asset('assets/img/runner.png', fit: BoxFit.fitHeight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.todaysFocus,
                      style: AppTheme.d(12, weight: FontWeight.w600, color: gc.brass, letterSpacing: 3)),
                  const SizedBox(height: 8),
                  Text(focus.title, style: AppTheme.d(48, weight: FontWeight.w700, color: gc.text, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Text(subtitle, style: AppTheme.s(14, color: gc.textSecondary)),
                  const SizedBox(height: 20),
                  PrimaryButton(label: t.startWorkout, icon: Ic.play, onTap: fit.startWorkout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
