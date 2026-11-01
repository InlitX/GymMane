part of '../nutrition_screen.dart';

String _span(Duration d) {
  final m = d.inMinutes.abs();
  final h = m ~/ 60, rest = m % 60;
  if (h == 0) return t.fastMinutes(rest);
  if (rest == 0) return t.fastHours(h);
  return t.fastHoursMinutes(h, rest);
}

Future<DateTime?> _pickFastStart(BuildContext context, DateTime initial) async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initial),
    initialEntryMode: TimePickerEntryMode.inputOnly,
    helpText: t.fastStartedAt,
  );
  if (picked == null) return null;
  final now = DateTime.now();
  var at = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
  if (at.isAfter(now)) at = at.subtract(const Duration(days: 1));
  return at;
}

class _FastingCard extends StatefulWidget {
  const _FastingCard();

  @override
  State<_FastingCard> createState() => _FastingCardState();
}

class _FastingCardState extends State<_FastingCard> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 20), (_) {
      if (mounted && fit.fasting) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  Future<void> _editStart(BuildContext context) async {
    final at = await _pickFastStart(context, fit.fastStart ?? DateTime.now());
    if (at != null) fit.moveFastStart(at);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final start = fit.fastStart;
    final goal = Duration(hours: fit.fastGoalHours);
    final now = DateTime.now();
    final elapsed = start == null ? Duration.zero : now.difference(start);
    final progress = start == null ? 0.0 : (elapsed.inSeconds / goal.inSeconds).clamp(0.0, 1.0);
    final reached = start != null && elapsed >= goal;
    final color = reached ? gc.sage : gc.brass;
    final last = fit.fasts.isEmpty ? null : fit.fasts.last;
    final meal = fit.lastMealAt;
    final streak = fit.fastStreak;

    final String big;
    final String line;
    if (start == null) {
      big = '${fit.fastGoalHours}:${24 - fit.fastGoalHours}';
      line = last == null
          ? t.fastIdle
          : [t.fastLast(_span(last.length)), if (streak >= 2) t.fastStreak(streak)].join(' · ');
    } else if (reached) {
      big = _span(elapsed);
      line = t.fastReached(_span(elapsed - goal));
    } else {
      big = _span(goal - elapsed);
      line = t.fastEndsAt(t.clockTime(start.add(goal)));
    }

    return SoftCard(
      radius: 26,
      padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Icon(PhosphorIconsRegular.hourglassMedium, size: 16, color: start == null ? gc.textSecondary : color),
          const SizedBox(width: 8),
          Expanded(child: _kicker(gc, t.fastTitle(fit.fastGoalHours, 24 - fit.fastGoalHours).toUpperCase())),
          _roundIcon(PhosphorIconsBold.dotsThree, gc.textSecondary, () => showFastingSheet(context), label: t.fastOptions),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          SizedBox(
            width: 74,
            height: 74,
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: progress),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => CustomPaint(
                painter: _FastRing(v, track: gc.bgRaised2, color: color),
                child: Center(
                  child: Icon(
                    start == null
                        ? PhosphorIconsRegular.forkKnife
                        : reached
                            ? PhosphorIconsBold.check
                            : PhosphorIconsRegular.moonStars,
                    size: 22,
                    color: start == null ? gc.textTertiary : color,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(start == null ? t.fastWindowOpen : (reached ? t.fastDoneLabel : t.fastLeft),
                  style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
              const SizedBox(height: 2),
              FitText(big, style: AppTheme.d(26, weight: FontWeight.w800, color: gc.text, height: 1.15)),
              const SizedBox(height: 2),
              Text(line,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.s(12, color: reached ? gc.sage : gc.textSecondary, height: 1.3)),
            ]),
          ),
        ]),
        const SizedBox(height: 14),
        if (start == null)
          Row(children: [
            Expanded(
              child: PrimaryButton(
                label: t.fastStart,
                height: 44,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  fit.startFast();
                },
              ),
            ),
            if (meal != null && now.difference(meal).inMinutes >= 15) ...[
              const SizedBox(width: 8),
              _Chip(
                label: t.fastFromMeal(t.clockTime(meal)),
                icon: PhosphorIconsBold.clockCounterClockwise,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  fit.startFast(at: meal);
                },
              ),
            ],
          ])
        else
          Row(children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _editStart(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(children: [
                    Flexible(
                      child: Text(t.fastSince(t.clockTime(start)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
                    ),
                    const SizedBox(width: 6),
                    Icon(PhosphorIconsRegular.pencilSimple, size: 13, color: gc.textTertiary),
                  ]),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 132,
              child: PrimaryButton(
                label: t.fastEnd,
                height: 44,
                bg: reached ? null : gc.bgRaised2,
                fg: reached ? null : gc.text,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  fit.endFast();
                },
              ),
            ),
          ]),
      ]),
    );
  }
}

class _FastRing extends CustomPainter {
  _FastRing(this.value, {required this.track, required this.color});
  final double value;
  final Color track;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 7.0;
    final rect = Offset.zero & size;
    final arc = rect.deflate(stroke / 2);
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = track;
    canvas.drawArc(arc, 0, math.pi * 2, false, base);
    if (value <= 0) return;
    final fill = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;
    canvas.drawArc(arc, -math.pi / 2, math.pi * 2 * value, false, fill);
  }

  @override
  bool shouldRepaint(_FastRing old) => old.value != value || old.color != color || old.track != track;
}

Future<void> showFastingSheet(BuildContext context) => _sheet<void>(context, (context) {
      final gc = context.gc;
      return AnimatedBuilder(
        animation: fit,
        builder: (context, _) {
          final week = fit.fastWeek;
          final recent = fit.fasts.reversed.take(10).toList();
          return _sheetFrame(context, [
            SheetTitle(t.fastPlan, subtitle: t.fastPlanHint),
            const SizedBox(height: 16),
            Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
              for (final h in NutritionState.fastPresets)
                _QuickChip(
                  label: '$h:${24 - h}',
                  selected: fit.fastGoalHours == h,
                  onTap: () => fit.setFastGoal(h),
                ),
            ]),
            if (week != null) ...[
              const SizedBox(height: 22),
              Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: _kicker(gc, t.fastThisWeek.toUpperCase())),
              Row(children: [
                Expanded(child: _fastStat(gc, t.fastCount, '${week.count}')),
                const SizedBox(width: 8),
                Expanded(child: _fastStat(gc, t.fastReachedCount, '${week.reached}')),
                const SizedBox(width: 8),
                Expanded(child: _fastStat(gc, t.fastAverage, _span(week.avg))),
              ]),
            ],
            if (recent.isNotEmpty) ...[
              const SizedBox(height: 22),
              Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: _kicker(gc, t.fastHistory.toUpperCase())),
              for (final r in recent)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
                    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                    child: Row(children: [
                      Icon(r.reached ? PhosphorIconsBold.check : PhosphorIconsRegular.hourglassMedium,
                          size: 14, color: r.reached ? gc.sage : gc.textTertiary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(_span(r.length), style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
                          Text('${t.shortDate(r.start)} · ${t.clockTime(r.start)} – ${t.clockTime(r.end)}',
                              style: AppTheme.s(11.5, color: gc.textSecondary)),
                        ]),
                      ),
                      RoundAction(
                        label: t.delete,
                        onTap: () => fit.removeFast(r),
                        child: Icon(PhosphorIconsRegular.trash, size: 15, color: gc.textTertiary),
                      ),
                    ]),
                  ),
                ),
            ],
            if (fit.fasting) ...[
              const SizedBox(height: 14),
              GhostButton(
                label: t.fastCancel,
                icon: PhosphorIconsRegular.x,
                onTap: () {
                  fit.cancelFast();
                  Navigator.of(context).pop();
                },
              ),
            ],
            const SizedBox(height: 6),
          ]);
        },
      );
    });

Widget _fastStat(GymColors gc, String label, String value) => Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FitText(label, style: AppTheme.f(10.5, weight: FontWeight.w600, color: gc.textSecondary)),
        const SizedBox(height: 2),
        FitText(value, style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
      ]),
    );
