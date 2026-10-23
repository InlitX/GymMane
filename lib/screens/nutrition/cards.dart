part of '../nutrition_screen.dart';

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final day = fit.nutritionDay;
    final total = fit.totalOn(day);
    final goals = fit.goalsFor(day);
    final burned = fit.burnedOn(day);
    final budget = fit.kcalBudgetOn(day);
    final left = fit.energyOf(budget) - fit.energyOf(total.kcal);
    Widget side(IconData icon, Color color, String value, String label) => Expanded(
          child: Column(children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RollingText(value, style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text, height: 1.2)),
            ),
            const SizedBox(height: 4),
            Text(label, maxLines: 1, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
          ]),
        );
    Widget macro(IconData icon, String label, double value, int goal, Color color) => Expanded(
          child: Column(children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: '${value.round()}', style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text)),
              TextSpan(text: '/${goal}g', style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
            ])),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MacroTrack(pct: goal <= 0 ? 0 : value / goal, color: color),
            ),
            const SizedBox(height: 7),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, size: 13, color: color),
              const SizedBox(width: 4),
              Flexible(
                child: FitText(sentenceCase(label), style: AppTheme.f(13.5, weight: FontWeight.w800, color: gc.text)),
              ),
            ]),
          ]),
        );
    final training = fit.isTrainingDay(day);
    final macros = [
      if (fit.trackerOn(Tracker.carbs))
        macro(PhosphorIconsFill.grains, t.macroCarbs, total.carbs, goals.carbs, gc.carbs),
      if (fit.trackerOn(Tracker.protein))
        macro(PhosphorIconsFill.egg, t.macroProtein, total.protein, goals.protein, gc.protein),
      if (fit.trackerOn(Tracker.fat)) macro(PhosphorIconsFill.drop, t.macroFat, total.fat, goals.fat, gc.fat),
    ];
    return SoftCard(
      radius: 26,
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 18),
      child: Column(children: [
        if (fit.restGoals != null) ...[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(training ? PhosphorIconsFill.barbell : PhosphorIconsFill.bed,
                size: 13, color: training ? gc.accent : gc.sage),
            const SizedBox(width: 6),
            Text(training ? t.trainingDay : t.restDay,
                style: AppTheme.f(12, weight: FontWeight.w700, color: training ? gc.accent : gc.sage)),
          ]),
          const SizedBox(height: 10),
        ],
        if (fit.trackerOn(Tracker.calories))
          Row(children: [
            side(PhosphorIconsFill.forkKnife, gc.accent, '${fit.energyOf(total.kcal)}', t.kcalEaten),
            CalorieRing(
              pct: budget <= 0 ? 0 : total.kcal / budget,
              size: 148,
              stroke: 12,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(left >= 0 ? t.kcalRemaining : t.kcalOver,
                    style: AppTheme.f(12, weight: FontWeight.w600, color: left >= 0 ? gc.textSecondary : gc.danger)),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: RollingText('${left.abs()}', style: AppTheme.f(34, weight: FontWeight.w800, color: gc.text, height: 1.15)),
                ),
                Text(t.ofGoal(fit.energyOf(budget), fit.energyUnit),
                    style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
              ]),
            ),
            side(PhosphorIconsFill.fire, gc.warn, '${fit.energyOf(burned)}', t.kcalBurned),
          ]),
        if (macros.isNotEmpty) ...[
          if (fit.trackerOn(Tracker.calories)) const SizedBox(height: 20),
          Row(children: macros),
        ],
      ]),
    );
  }
}

String _extrasLine(Macros m) => [
      if (m.fiber > 0) '${t.fiberLabel} ${_g(m.fiber)} g',
      if (m.sugar > 0) '${t.sugarLabel} ${_g(m.sugar)} g',
      if (m.sodium > 0) '${t.sodiumLabel} ${m.sodium.round()} mg',
    ].join('  ·  ');

class _RingCard extends StatelessWidget {
  const _RingCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.sub,
    required this.pct,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String sub;
  final double pct;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SoftCard(
      radius: 22,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Row(children: [
        CalorieRing(
          pct: pct,
          size: 56,
          stroke: 6,
          color: color,
          child: Icon(icon, size: 17, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FitText(label.toUpperCase(),
                style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.8)),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text.rich(TextSpan(children: [
                TextSpan(text: value, style: AppTheme.f(21, weight: FontWeight.w800, color: gc.text, height: 1.05)),
                TextSpan(text: ' g', style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary)),
              ])),
            ),
            const SizedBox(height: 2),
            Text(sub, maxLines: 1, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary)),
          ]),
        ),
      ]),
    );
  }
}

class _DetailGrid extends StatelessWidget {
  const _DetailGrid();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final day = fit.nutritionDay;
    final total = fit.totalOn(day);
    final goals = fit.goalsFor(day);
    final cards = <Widget>[
      if (fit.trackerOn(Tracker.animal))
        _RingCard(
          icon: PhosphorIconsFill.lightning,
          color: gc.warn,
          label: t.animalProtein,
          value: _g(total.animal),
          sub: total.protein <= 0 ? 'g' : '${(total.animal / total.protein * 100).round()} %',
          pct: total.protein <= 0 ? 0 : total.animal / total.protein,
        ),
      if (fit.trackerOn(Tracker.fiber))
        _RingCard(
          icon: PhosphorIconsFill.leaf,
          color: gc.sage,
          label: t.fiberLabel,
          value: _g(total.fiber),
          sub: '/ ${goals.fiber} g',
          pct: goals.fiber <= 0 ? 0 : total.fiber / goals.fiber,
        ),
      if (fit.trackerOn(Tracker.sugarSodium)) ...[
        _RingCard(
          icon: PhosphorIconsFill.cube,
          color: total.sugar > goals.sugar ? gc.danger : gc.carbs,
          label: t.sugarLabel,
          value: _g(total.sugar),
          sub: '/ ${goals.sugar} g',
          pct: total.sugar / goals.sugar,
        ),
        _RingCard(
          icon: PhosphorIconsFill.grains,
          color: total.sodium > goals.sodium ? gc.danger : gc.info,
          label: t.sodiumLabel,
          value: fmt((total.sodium / 100).round() / 10),
          sub: '/ ${fmt(goals.sodium / 1000)} g',
          pct: total.sodium / goals.sodium,
        ),
      ],
    ];
    if (cards.isEmpty) return const SizedBox.shrink();
    const perRow = 2;
    return Column(children: [
      for (var i = 0; i < cards.length; i += perRow) ...[
        if (i > 0) const SizedBox(height: 10),
        IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            for (var k = i; k < math.min(i + perRow, cards.length); k++) ...[
              if (k > i) const SizedBox(width: 10),
              Expanded(child: cards[k]),
            ],
            if (cards.length > perRow && cards.length - i < perRow)
              for (var k = 0; k < perRow - (cards.length - i); k++) ...[
                const SizedBox(width: 10),
                const Expanded(child: SizedBox()),
              ],
          ]),
        ),
      ],
    ]);
  }
}

String aminoName(Amino a) => switch (a) {
      Amino.his => t.aminoHis,
      Amino.ile => t.aminoIle,
      Amino.leu => t.aminoLeu,
      Amino.lys => t.aminoLys,
      Amino.saa => t.aminoSaa,
      Amino.aaa => t.aminoAaa,
      Amino.thr => t.aminoThr,
      Amino.trp => t.aminoTrp,
      Amino.val => t.aminoVal,
    };

const _aminoShort = ['His', 'Ile', 'Leu', 'Lys', 'Met', 'Phe', 'Thr', 'Trp', 'Val'];

class _QualityCard extends StatelessWidget {
  const _QualityCard({this.of});

  final Macros? of;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final total = of ?? fit.totalOn(fit.nutritionDay);
    final scores = total.aminoScores;
    final q = total.proteinQuality;
    final limiting = total.limitingAmino;
    final color = scores.isEmpty
        ? gc.textTertiary
        : q >= 1
            ? gc.sage
            : q >= 0.8
                ? gc.warn
                : gc.danger;
    final verdict = scores.isEmpty
        ? t.qualityNoData
        : q >= 1
            ? t.qualityComplete
            : q >= 0.8
                ? t.qualityAlmost
                : t.qualityIncomplete;
    final coverage = total.protein <= 0 ? 1.0 : total.aminoProtein / total.protein;
    Widget source(IconData icon, Color c, String label, double grams) => Row(children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: c.withValues(alpha: 0.16), shape: BoxShape.circle),
            child: Icon(icon, size: 12, color: c),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
          ),
          Text('${_g(grams)} g', style: AppTheme.f(13, weight: FontWeight.w800, color: gc.text)),
        ]);
    return SoftCard(
      radius: 24,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(PhosphorIconsFill.dna, size: 14, color: color),
          const SizedBox(width: 7),
          Expanded(child: _kicker(gc, t.proteinQuality.toUpperCase())),
        ]),
        const SizedBox(height: 10),
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: 168,
            height: 168,
            child: scores.isEmpty
                ? Center(child: Icon(PhosphorIconsRegular.dna, size: 48, color: gc.textTertiary.withValues(alpha: 0.4)))
                : RepaintBoundary(
                    child: TweenAnimationBuilder<double>(
                      key: ValueKey(Object.hashAll(scores)),
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOutCubic,
                      builder: (context, p, _) => CustomPaint(
                        painter: _AminoRadar(
                          scores: scores,
                          limiting: limiting == null ? -1 : Amino.values.indexOf(limiting),
                          progress: p,
                          gc: gc,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: scores.isEmpty ? '—' : '${(q * 100).round()}',
                  style: AppTheme.f(40, weight: FontWeight.w800, color: gc.text, height: 1),
                ),
                if (scores.isNotEmpty)
                  TextSpan(text: ' /100', style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textTertiary)),
              ])),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(20)),
                child: Text(verdict, style: AppTheme.f(12, weight: FontWeight.w800, color: color)),
              ),
              const SizedBox(height: 8),
              Text(
                scores.isEmpty
                    ? t.qualityNoDataHint
                    : limiting == null
                        ? t.qualityAllCovered
                        : t.qualityLimiting(aminoName(limiting)),
                style: AppTheme.s(11.5, color: gc.textSecondary, height: 1.35),
              ),
            ]),
          ),
        ]),
        if (total.protein > 0) ...[
          const SizedBox(height: 12),
          _SplitBar(parts: [(total.animal, gc.warn), (total.plant, gc.sage)], height: 6),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: source(PhosphorIconsFill.cow, gc.warn, t.proteinAnimalShort, total.animal)),
            const SizedBox(width: 16),
            Expanded(child: source(PhosphorIconsFill.leaf, gc.sage, t.proteinPlantShort, total.plant)),
          ]),
        ],
        if (scores.isNotEmpty && coverage < 0.9) ...[
          const SizedBox(height: 10),
          Text(t.qualityCoverage((coverage * 100).round()),
              style: AppTheme.s(11, color: gc.textTertiary, height: 1.35)),
        ],
      ]),
    );
  }
}

class _AminoRadar extends CustomPainter {
  _AminoRadar({required this.scores, required this.limiting, required this.progress, required this.gc});

  final List<double> scores;
  final int limiting;
  final double progress;
  final GymColors gc;

  static const _max = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final n = scores.length;
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 - 24;
    Offset at(int i, double f) {
      final a = -math.pi / 2 + 2 * math.pi * i / n;
      return c + Offset(math.cos(a), math.sin(a)) * r * f;
    }

    Path ring(double f) {
      final p = Path()..moveTo(at(0, f).dx, at(0, f).dy);
      for (var i = 1; i < n; i++) {
        p.lineTo(at(i, f).dx, at(i, f).dy);
      }
      return p..close();
    }

    final grid = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = gc.border.withValues(alpha: 0.7);
    canvas.drawPath(ring(1), grid);
    canvas.drawPath(ring(0.5 / _max), grid);
    for (var i = 0; i < n; i++) {
      canvas.drawLine(c, at(i, 1), grid);
    }
    canvas.drawPath(
      ring(1 / _max),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = gc.textTertiary.withValues(alpha: 0.75),
    );

    final shape = Path();
    for (var i = 0; i < n; i++) {
      final p = at(i, (scores[i] / _max).clamp(0.04, 1.0) * progress);
      i == 0 ? shape.moveTo(p.dx, p.dy) : shape.lineTo(p.dx, p.dy);
    }
    shape.close();
    final worst = limiting >= 0 ? scores[limiting] : 1.0;
    final tone = worst < 0.8 ? gc.danger : (worst < 1 ? gc.warn : gc.sage);
    canvas.drawPath(
      shape,
      Paint()
        ..shader = RadialGradient(
          colors: [tone.withValues(alpha: 0.12), tone.withValues(alpha: 0.38)],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
    canvas.drawPath(
      shape,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round
        ..color = tone,
    );

    for (var i = 0; i < n; i++) {
      final low = i == limiting && scores[i] < 1;
      final p = at(i, (scores[i] / _max).clamp(0.04, 1.0) * progress);
      final dotR = low ? 4.0 : 2.8;
      canvas.drawCircle(p, dotR, Paint()..color = gc.bgRaised);
      canvas.drawCircle(
        p,
        dotR,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8
          ..color = low ? gc.danger : tone,
      );
      final label = TextPainter(
        text: TextSpan(children: [
          TextSpan(
            text: '${_aminoShort[i]}\n',
            style: AppTheme.f(9, weight: FontWeight.w700, color: low ? gc.danger : gc.textTertiary, height: 1.1),
          ),
          TextSpan(
            text: '${(scores[i] * 100).round()}',
            style: AppTheme.f(9.5, weight: FontWeight.w800, color: low ? gc.danger : gc.textSecondary, height: 1.1),
          ),
        ]),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
      final l = at(i, 1 + 15 / r);
      label.paint(canvas, l - Offset(label.width / 2, label.height / 2));
    }
  }

  @override
  bool shouldRepaint(_AminoRadar o) => o.progress != progress || o.scores != scores || o.limiting != limiting;
}

class _SplitBar extends StatelessWidget {
  const _SplitBar({required this.parts, this.height = 10});

  final List<(double, Color)> parts;
  final double height;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final sum = parts.fold(0.0, (s, p) => s + p.$1);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: SizedBox(
        height: height,
        child: sum <= 0
            ? ColoredBox(color: gc.bgRaised2)
            : Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                for (final p in parts)
                  if (p.$1 > 0) Expanded(flex: math.max(1, (p.$1 / sum * 1000).round()), child: ColoredBox(color: p.$2)),
              ]),
      ),
    );
  }
}

class _FatTypesCard extends StatelessWidget {
  const _FatTypesCard({this.of});

  final Macros? of;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final day = fit.nutritionDay;
    final total = of ?? fit.totalOn(day);
    final limit = fit.goalsFor(day).satLimit;
    final over = total.sat > limit;
    Widget legend(Color c, String name, double g) => Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Flexible(
                child: Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary)),
              ),
            ]),
            const SizedBox(height: 3),
            Text('${_g(g)} g', style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
          ]),
        );
    return SoftCard(
      radius: 24,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(PhosphorIconsFill.drop, size: 14, color: gc.fat),
          const SizedBox(width: 7),
          Expanded(child: _kicker(gc, t.fatTypes.toUpperCase())),
          Text('${_g(total.fat)} g', style: AppTheme.f(13, weight: FontWeight.w800, color: gc.text)),
        ]),
        const SizedBox(height: 14),
        _SplitBar(parts: [(total.sat, gc.warn), (total.mono, gc.sage), (total.poly, gc.info)]),
        const SizedBox(height: 14),
        Row(children: [
          legend(gc.warn, t.fatSaturated, total.sat),
          legend(gc.sage, t.fatMono, total.mono),
          legend(gc.info, t.fatPoly, total.poly),
        ]),
        if (of == null) ...[
          const SizedBox(height: 12),
          Text(t.satLimitLine(_g(total.sat), limit),
              style: AppTheme.f(11.5, weight: FontWeight.w600, color: over ? gc.danger : gc.textTertiary)),
        ],
      ]),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.action,
    required this.vessel,
    required this.value,
    required this.unit,
    required this.hint,
    required this.hintColor,
    this.glow,
  });

  final String title;
  final Widget action;
  final Widget vessel;
  final String value;
  final String unit;
  final String hint;
  final Color hintColor;
  final Color? glow;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final glow = this.glow;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: gc.border),
        color: gc.bgRaised,
        gradient: glow == null
            ? null
            : RadialGradient(
                center: const Alignment(0, -0.42),
                radius: 0.78,
                colors: [
                  Color.alphaBlend(glow.withValues(alpha: 0.2), gc.bgRaised),
                  Color.alphaBlend(glow.withValues(alpha: 0.07), gc.bgRaised),
                  gc.bgRaised,
                ],
                stops: const [0, 0.45, 1],
              ),
      ),
      child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 10, 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: _kicker(gc, title)),
                action,
              ]),
              const SizedBox(height: 6),
              Center(child: vessel),
              const Spacer(),
              const SizedBox(height: 12),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                RollingText(value, style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text, height: 1.2)),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(unit,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
                ),
              ]),
              const SizedBox(height: 4),
              FitText(hint, style: AppTheme.f(11.5, weight: FontWeight.w700, color: hintColor)),
            ]),
          ),
    );
  }
}

Widget _roundIcon(IconData icon, Color color, VoidCallback onTap, {String? label}) => RoundAction(
      label: label,
      size: 34,
      onTap: onTap,
      child: Icon(icon, size: 15, color: color),
    );

class _WaterTile extends StatelessWidget {
  const _WaterTile();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final ml = fit.waterOn(fit.nutritionDay);
    final goals = fit.activeGoals;
    final level = goals.waterMl <= 0 ? 0.0 : ml / goals.waterMl;
    final done = ml >= goals.waterMl;
    return _Tile(
      title: t.waterLabel,
      glow: gc.water,
      action: _roundIcon(PhosphorIconsBold.dotsThree, gc.textSecondary, () => showWaterSheet(context),
          label: t.waterOptions),
      vessel: Pressable(
        onTap: () {
          HapticFeedback.lightImpact();
          fit.addWater();
        },
        onLongPress: () => _customWater(context),
        scale: 0.94,
        child: PhotoVessel(
          animate: fit.vesselMotion,
          asset: 'assets/img/vessel-water.webp',
          level: level,
          height: 158,
          top: 0.269,
          bottom: 0.989,
          curve: 0.08,
          liquid: const Color(0xFF4FB4F2),
        ),
      ),
      value: decimalText(fit.waterValue(ml)),
      unit: '/ ${fit.waterLabel(goals.waterMl)}',
      hint: done ? t.waterDone : t.waterTapHint(fit.waterLabel(goals.glassMl)),
      hintColor: done ? gc.sage : gc.water,
    );
  }

}

Future<void> _customWater(BuildContext context) async {
  HapticFeedback.mediumImpact();
  final v = await askNumber(context, title: '${t.waterCustom} (${fit.isLb ? 'fl oz' : 'ml'})', initial: '', decimal: true);
  if (v == null || v <= 0) return;
  fit.addWater((fit.isLb ? v * 29.5735 : v).round());
}

Future<void> showWaterSheet(BuildContext context) => _sheet<void>(context, (context) {
      final gc = context.gc;
      return AnimatedBuilder(
        animation: fit,
        builder: (context, _) {
          final day = fit.nutritionDay;
          final g = fit.activeGoals;
          final sips = fit.waterSipsOn(day).reversed.toList();
          final big = fit.isLb ? 473 : 500;
          String time(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
          return _sheetFrame(context, [
            SheetTitle(sentenceCase(t.waterLabel), subtitle: '${fit.waterLabel(fit.waterOn(day))} / ${fit.waterLabel(g.waterMl)}'),
            const SizedBox(height: 16),
            Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
              for (final ml in {g.glassMl, big})
                _QuickChip(
                  label: '+ ${fit.waterLabel(ml)}',
                  selected: false,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    fit.addWater(ml);
                  },
                ),
              _QuickChip(label: t.waterCustom, selected: false, onTap: () => _customWater(context)),
            ]),
            const SizedBox(height: 18),
            _kicker(gc, (fit.nutritionOnToday ? t.nutritionToday : t.longDate(day)).toUpperCase()),
            const SizedBox(height: 8),
            if (sips.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(t.waterNone, style: AppTheme.s(13, color: gc.textTertiary)),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 220),
                child: SoftCard(
                  radius: 20,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: [
                    for (final w in sips)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 6, 6, 6),
                        child: Row(children: [
                          Icon(PhosphorIconsFill.drop, size: 15, color: gc.water),
                          const SizedBox(width: 10),
                          Text(fit.waterLabel(w.ml), style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                          const Spacer(),
                          Text(time(w.at), style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
                          const SizedBox(width: 4),
                          IconButton(
                            tooltip: t.delete,
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              fit.removeWaterSip(w);
                            },
                            icon: Icon(PhosphorIconsBold.x, size: 14, color: gc.textSecondary),
                          ),
                        ]),
                      ),
                  ]),
                ),
              ),
            const SizedBox(height: 16),
            ToolGroup(_waterRows(context)),
          ]);
        },
      );
    });

class _ShakeTile extends StatelessWidget {
  const _ShakeTile();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final protein = fit.totalOn(fit.nutritionDay).protein;
    final goal = fit.goalsFor(fit.nutritionDay).protein;
    final level = goal <= 0 ? 0.0 : protein / goal;
    final shake = fit.shakeFood;
    return _Tile(
      title: t.macroProtein,
      glow: gc.protein,
      action: _roundIcon(PhosphorIconsBold.dotsThree, gc.textSecondary, () => showShakePicker(context),
          label: t.shakePick),
      vessel: Pressable(
        onTap: () {
          if (shake == null) {
            showShakePicker(context);
            return;
          }
          final e = fit.logFood(shake);
          _loggedToast(context, e);
        },
        onLongPress: () => showShakePicker(context),
        scale: 0.94,
        child: PhotoVessel(
          animate: fit.vesselMotion,
          asset: 'assets/img/vessel-shake.webp',
          level: level,
          height: 158,
          top: 0.407,
          bottom: 0.975,
          curve: 0.066,
          liquid: shakeColor(shake),
          texture: 'assets/img/shake-texture.webp',
        ),
      ),
      value: '${protein.round()}',
      unit: '/ $goal g',
      hint: shake == null ? t.shakeEmpty : t.shakeTapHint(shake.name),
      hintColor: gc.protein,
    );
  }
}

Future<void> showShakePicker(BuildContext context) => _sheet<void>(context, (context) {
      final gc = context.gc;
      final shakes = fit.shakeFoodItems;
      final others = [for (final f in fit.foodsByUse) if (!fit.isShakeFood(f.id)) f];
      return _sheetFrame(context, [
        SheetTitle(t.shakePick, subtitle: t.shakePickHint),
        const SizedBox(height: 16),
        if (shakes.isNotEmpty)
          OptionGroup([
            for (final f in shakes)
              OptionItem(
                f.name,
                leading: FoodSticker(photo: f.photo, name: f.name, size: 32, tilt: false),
                detail: '${_g(f.macros.protein)} g',
                selected: f.id == fit.shakeFoodId,
                trailing: Semantics(
                  button: true,
                  label: t.shakeUntag,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      fit.setShakeTag(f.id, false);
                    },
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: Icon(PhosphorIconsBold.x, size: 14, color: gc.textTertiary),
                    ),
                  ),
                ),
                onTap: () {
                  fit.setShakeFood(f.id);
                  Navigator.of(context).pop();
                },
              ),
          ])
        else
          Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
            child: Row(children: [
              Image.asset('assets/img/peek-shake.webp', width: 34, height: 40, fit: BoxFit.contain),
              const SizedBox(width: 12),
              Expanded(
                child: Text(t.shakeNone, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary, height: 1.35)),
              ),
            ]),
          ),
        if (others.isNotEmpty) ...[
          const SizedBox(height: 18),
          Text(t.shakeMarkLabel,
              style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.1)),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: others.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) => _ShakeChip(others[i]),
            ),
          ),
        ],
        const SizedBox(height: 16),
        GhostButton(
          label: t.shakeNew,
          icon: PhosphorIconsBold.plus,
          onTap: () {
            Navigator.of(context).pop();
            showFoodEditor(context, asShake: true);
          },
        ),
      ]);
    });

class _ShakeChip extends StatelessWidget {
  const _ShakeChip(this.food);

  final FoodItem food;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: () {
        HapticFeedback.selectionClick();
        fit.setShakeTag(food.id, true);
      },
      scale: 0.95,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
        decoration: BoxDecoration(
          color: gc.bgRaised2,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: gc.border),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          FoodSticker(photo: food.photo, name: food.name, size: 30, tilt: false, shadow: false),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(food.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)),
          ),
          const SizedBox(width: 6),
          Icon(PhosphorIconsBold.plus, size: 13, color: gc.protein),
        ]),
      ),
    );
  }
}

const _suppPresets = [
  'asset:assets/img/peek-protein.webp',
  'asset:assets/img/peek-shake.webp',
  'asset:assets/img/supp-bar.webp',
];

String _suppPhoto(Supplement s) =>
    s.photo.isEmpty || s.photo.endsWith('vessel-pills.webp') ? _suppPresets.first : s.photo;

class _SupplementsCard extends StatelessWidget {
  const _SupplementsCard();

  static List<String> get _suggested =>
      [t.suppCreatine, t.suppVitaminD, t.suppOmega3, t.suppMagnesium, t.suppMultivitamin, t.suppCaffeine];

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final day = fit.nutritionDay;
    final taken = fit.takenOn(day);
    final list = fit.supplements;
    final due = [for (final s in list) if (s.dueOn(day)) s];
    final later = [for (final s in list) if (!s.dueOn(day)) s];
    final done = due.where((s) => taken.contains(s.id)).length;
    return SoftCard(
      radius: 26,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Image.asset('assets/img/peek-protein.webp', height: 22, cacheHeight: 66),
          const SizedBox(width: 8),
          Expanded(child: _kicker(gc, t.supplementsLabel)),
          if (due.isNotEmpty)
            Text('$done/${due.length}',
                style: AppTheme.f(13, weight: FontWeight.w800, color: done == due.length ? gc.sage : gc.textSecondary)),
        ]),
        const SizedBox(height: 10),
        if (list.isEmpty) ...[
          Wrap(spacing: 7, runSpacing: 7, children: [
            for (final name in _suggested)
              _Chip(label: name, icon: PhosphorIconsBold.plus, onTap: () => showSupplementEditor(context, name: name)),
          ]),
          const SizedBox(height: 10),
          Text(t.supplementsEmpty, style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.35)),
        ] else ...[
          if (due.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(t.suppNoneToday, style: AppTheme.s(12.5, color: gc.textSecondary)),
            ),
          _CappedList(
            count: due.length,
            itemBuilder: (_, i) => _SupplementRow(supp: due[i], taken: taken.contains(due[i].id)),
            rowHeight: _SupplementRow.height,
            gap: 8,
            maxRows: 4,
            fade: gc.bgRaised,
          ),
          if (due.isNotEmpty) const SizedBox(height: 8),
          if (later.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 4, 0, 8),
              child: _kicker(gc, t.suppOtherDays.toUpperCase()),
            ),
            _CappedList(
              count: later.length,
              itemBuilder: (_, i) => _SupplementRow(supp: later[i], taken: false, off: true),
              rowHeight: _SupplementRow.height,
              gap: 8,
              maxRows: 3,
              fade: gc.bgRaised,
            ),
            const SizedBox(height: 8),
          ],
        ],
        const SizedBox(height: 2),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => showSupplementEditor(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(children: [
              Icon(PhosphorIconsBold.plus, size: 13, color: gc.accent),
              const SizedBox(width: 6),
              Text(t.addSupplement, style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.accent)),
              const Spacer(),
              if (due.isNotEmpty && done == 0)
                Text(t.suppRowHint, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
            ]),
          ),
        ),
      ]),
    );
  }
}

String _suppDays(Supplement s) {
  if (s.every > 1) return t.suppEveryN(s.every);
  if (s.days == 0) return t.suppDaily;
  final start = fit.weekStartDay;
  return [
    for (var i = 0; i < 7; i++)
      if (s.onWeekday((start - 1 + i) % 7 + 1)) t.weekdayShort((start - 1 + i) % 7 + 1),
  ].join(' · ');
}

String _suppSchedule(BuildContext context, Supplement s, {bool daily = true}) {
  final at = fit.supplementTime(s);
  final today = DateTime.now();
  final from = s.from;
  return [
    if (daily || !s.everyDay) _suppDays(s),
    if (at != null) _clock(context, at),
    if (from != null && from.isAfter(DateTime(today.year, today.month, today.day))) t.suppFromDate(t.shortDate(from)),
    if (s.until != null) t.suppUntilDate(t.shortDate(s.until!)),
  ].join(' · ');
}

class _SupplementRow extends StatelessWidget {
  const _SupplementRow({required this.supp, required this.taken, this.off = false});

  final Supplement supp;
  final bool taken;
  final bool off;

  static const height = 60.0;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final at = fit.supplementTime(supp);
    final detail = [
      if (supp.dose.isNotEmpty) supp.dose,
      _suppSchedule(context, supp, daily: false),
    ].where((x) => x.isNotEmpty).join(' · ');
    return SizedBox(
      height: height,
      child: Pressable(
        scale: 0.97,
        onTap: () {
          if (off) {
            showSupplementInfo(context, supp);
            return;
          }
          HapticFeedback.selectionClick();
          fit.toggleSupplement(supp.id);
        },
        onLongPress: () {
          HapticFeedback.mediumImpact();
          showSupplementInfo(context, supp);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
          decoration: BoxDecoration(
            color: taken ? gc.sage.withValues(alpha: 0.14) : gc.bgRaised2,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: taken ? gc.sage.withValues(alpha: 0.45) : Colors.transparent),
          ),
          child: Row(children: [
            SizedBox(
              width: 46,
              height: 46,
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: taken ? 1 : 0),
                  duration: const Duration(milliseconds: 520),
                  curve: Curves.easeOut,
                  builder: (context, p, child) {
                    final bump = math.sin(p * math.pi);
                    return Transform.rotate(
                      angle: bump * 0.16,
                      child: Transform.scale(scale: 1 + bump * 0.2, child: child),
                    );
                  },
                  child: FoodSticker(
                      photo: _suppPhoto(supp), name: supp.name, size: 40, tilt: false, shadow: false, dim: off),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(supp.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14.5, weight: FontWeight.w800, color: off ? gc.textSecondary : gc.text)),
                if (detail.isNotEmpty) ...[
                const SizedBox(height: 2),
                Row(children: [
                  Icon(at != null ? PhosphorIconsFill.bellSimpleRinging : PhosphorIconsFill.calendarBlank,
                      size: 11, color: gc.textTertiary),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(detail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
                  ),
                ]),
                ],
              ]),
            ),
            if (off)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(PhosphorIconsBold.pencilSimple, size: 15, color: gc.textTertiary),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutBack,
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: taken ? gc.sage : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: taken ? gc.sage : gc.border, width: 2),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 320),
                    switchInCurve: Curves.elasticOut,
                    transitionBuilder: (child, a) => ScaleTransition(scale: a, child: child),
                    child: taken
                        ? Icon(PhosphorIconsBold.check, key: const ValueKey(1), size: 14, color: gc.bg)
                        : const SizedBox(key: ValueKey(0)),
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}

String _clock(BuildContext context, int minuteOfDay) =>
    TimeOfDay(hour: minuteOfDay ~/ 60, minute: minuteOfDay % 60).format(context);

Future<void> showSupplementInfo(BuildContext context, Supplement supp) => _sheet<void>(context, (sheet) {
      final gc = sheet.gc;
      final s = fit.supplements.where((x) => x.id == supp.id).firstOrNull;
      if (s == null) return const SizedBox.shrink();
      final day = fit.nutritionDay;
      final dueToday = s.dueOn(day);
      final taken = fit.takenOn(day).contains(s.id);
      final at = fit.supplementTime(s);
      final days = [for (var i = 13; i >= 0; i--) shiftDays(day, -i)];
      final due = days.where(s.dueOn).toList();
      final done = due.where((d) => fit.takenOn(d).contains(s.id)).length;
      Widget line(IconData icon, String label, String value) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(children: [
              Icon(icon, size: 16, color: gc.textTertiary),
              const SizedBox(width: 10),
              Text(label, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(value,
                    textAlign: TextAlign.right,
                    style: AppTheme.f(13.5, weight: FontWeight.w800, color: gc.text)),
              ),
            ]),
          );
      return _sheetFrame(sheet, [
        Center(child: FoodSticker(photo: _suppPhoto(s), name: s.name, size: 104, tilt: false)),
        const SizedBox(height: 12),
        SheetTitle(s.name, subtitle: s.dose.isEmpty ? null : s.dose),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
          child: Column(children: [
            line(PhosphorIconsRegular.calendarBlank, t.suppWhen, _suppDays(s)),
            line(PhosphorIconsRegular.bellSimpleRinging, t.suppRemind, at == null ? t.suppNoReminder : _clock(sheet, at)),
            if (s.from != null && s.from!.isAfter(day)) line(PhosphorIconsRegular.flagBanner, t.suppStarts, t.shortDate(s.from!)),
            if (s.until != null) line(PhosphorIconsRegular.flagCheckered, t.suppEnds, t.shortDate(s.until!)),
          ]),
        ),
        const SizedBox(height: 18),
        Row(children: [
          Expanded(child: _kicker(gc, t.suppHistory.toUpperCase())),
          if (due.isNotEmpty)
            Text(t.suppTakenOf(done, due.length), style: AppTheme.f(12, weight: FontWeight.w800, color: gc.textSecondary)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          for (final d in days)
            Expanded(
              child: Center(
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: fit.takenOn(d).contains(s.id) ? gc.sage : Colors.transparent,
                    border: Border.all(
                      color: fit.takenOn(d).contains(s.id)
                          ? gc.sage
                          : s.dueOn(d)
                              ? gc.textTertiary
                              : gc.border.withValues(alpha: 0.5),
                      width: d == day ? 2 : 1.4,
                    ),
                  ),
                ),
              ),
            ),
        ]),
        const SizedBox(height: 22),
        if (dueToday)
          PrimaryButton(
            label: taken ? t.suppUnmark : t.suppMarkTaken,
            bg: taken ? gc.bgRaised2 : null,
            fg: taken ? gc.text : null,
            onTap: () {
              HapticFeedback.selectionClick();
              fit.toggleSupplement(s.id);
              Navigator.of(sheet).pop();
            },
          ),
        const SizedBox(height: 10),
        GhostButton(
          label: t.suppEdit,
          icon: PhosphorIconsBold.pencilSimple,
          onTap: () {
            Navigator.of(sheet).pop();
            showSupplementEditor(context, supp: s);
          },
        ),
      ]);
    });

Future<void> showSupplementEditor(BuildContext context, {Supplement? supp, String name = ''}) =>
    showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SupplementEditor(supp: supp, name: name),
    );

class _SupplementEditor extends StatefulWidget {
  const _SupplementEditor({this.supp, this.name = ''});

  final Supplement? supp;
  final String name;

  @override
  State<_SupplementEditor> createState() => _SupplementEditorState();
}

enum _Repeat { daily, days, every }

class _SupplementEditorState extends State<_SupplementEditor> with _StickerDrafts {
  late final _name = TextEditingController(text: widget.supp?.name ?? widget.name);
  late final _dose = TextEditingController(text: widget.supp?.dose ?? '');
  @override
  late String _photo = widget.supp == null ? _suppPresets.first : _suppPhoto(widget.supp!);
  late int? _at = widget.supp == null ? 9 * 60 : fit.supplementTime(widget.supp!);
  late _Repeat _repeat = switch (widget.supp) {
    final s? when s.every > 1 => _Repeat.every,
    final s? when s.days != 0 => _Repeat.days,
    _ => _Repeat.daily,
  };
  late int _days = widget.supp?.days ?? 0;
  late int _every = math.max(2, widget.supp?.every ?? 2);
  late DateTime _from = widget.supp?.from ?? _today;
  late DateTime? _until = widget.supp?.until;

  static DateTime get _today {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  @override
  String get _photoKind => 'supp';

  @override
  bool _owned(String? p) => p != null && p.isNotEmpty && !isAssetPhoto(p) && p != widget.supp?.photo;

  @override
  void dispose() {
    _name.dispose();
    _dose.dispose();
    _dropDrafts();
    super.dispose();
  }

  int get _savedDays => _repeat == _Repeat.days ? _days : 0;
  int get _savedEvery => _repeat == _Repeat.every ? _every : 1;

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      HapticFeedback.heavyImpact();
      return;
    }
    if (_repeat == _Repeat.days && _days == 0) _repeat = _Repeat.daily;
    _dropDrafts(keep: _photo);
    final supp = widget.supp;
    final from = _from.isAfter(_today) || _repeat == _Repeat.every ? _from : null;
    final until = _until;
    if (supp == null) {
      fit.addSupplement(name,
          dose: _dose.text, photo: _photo, at: _at, days: _savedDays, every: _savedEvery, from: from, until: until);
    } else {
      fit.updateSupplement(
        supp.id,
        name: name,
        dose: _dose.text,
        photo: _photo,
        at: _at,
        clearAt: _at == null,
        days: _savedDays,
        every: _savedEvery,
        from: from ?? supp.from,
        until: until,
        clearUntil: until == null,
      );
    }
    if (_at != null) fit.askAlarmPermission(force: true);
    Navigator.of(context).pop();
  }

  Future<void> _remove() async {
    final supp = widget.supp!;
    final ok = await askConfirm(
      context,
      title: t.removeSupplementTitle(supp.name),
      body: t.removeSupplementBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (!ok || !mounted) return;
    fit.removeSupplement(supp.id);
    Navigator.of(context).pop();
  }

  Future<DateTime?> _date(DateTime initial, DateTime first) => showDatePicker(
        context: context,
        initialDate: initial.isBefore(first) ? first : initial,
        firstDate: first,
        lastDate: _today.add(const Duration(days: 730)),
      );

  Supplement get _preview => Supplement(
        id: '',
        name: _name.text,
        at: _at,
        days: _savedDays,
        every: _savedEvery,
        from: _from,
        until: _until,
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget option(String photo) {
      final selected = photo == _photo;
      return Pressable(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _photo = photo);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: gc.bgRaised2,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: selected ? gc.accent : gc.border, width: selected ? 2 : 1),
          ),
          child: FoodSticker(photo: photo, name: '', size: 50, tilt: false, shadow: false),
        ),
      );
    }

    Widget part(String value, VoidCallback dec, VoidCallback inc) => StepperControl(
          value: value,
          minWidth: 40,
          btnSize: 34,
          gap: 10,
          fontSize: 24,
          onDec: dec,
          onInc: inc,
        );
    Widget section(String title) => Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: _kicker(gc, title.toUpperCase()),
        );
    final at = _at;
    final start = fit.weekStartDay;
    final tomorrow = _today.add(const Duration(days: 1));
    final fromCustom = _from != _today && _from != tomorrow;
    DateTime plus(int days) => _from.add(Duration(days: days));
    final untilWeek = plus(6), untilMonth = plus(29);
    final untilCustom = _until != null && _until != untilWeek && _until != untilMonth;
    return _sheetFrame(context, [
      SheetTitle(widget.supp == null ? t.addSupplement : widget.supp!.name),
      const SizedBox(height: 16),
      _kicker(gc, t.suppPhoto.toUpperCase()),
      const SizedBox(height: 10),
      SizedBox(
        height: 64,
        child: ListView(scrollDirection: Axis.horizontal, clipBehavior: Clip.none, children: [
          for (final p in _suppPresets) ...[option(p), const SizedBox(width: 10)],
          for (final p in [_cutPhoto, _plainPhoto])
            if (p != null) ...[option(p), const SizedBox(width: 10)],
          if (widget.supp != null && !isAssetPhoto(widget.supp!.photo) && widget.supp!.photo.isNotEmpty) ...[
            option(widget.supp!.photo),
            const SizedBox(width: 10),
          ],
          Pressable(
            onTap: _working ? () {} : _pick,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: gc.border),
              ),
              child: _working
                  ? Center(
                      child: SizedBox(
                          width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.2, color: gc.accent)))
                  : Icon(PhosphorIconsRegular.camera, size: 22, color: gc.accent),
            ),
          ),
        ]),
      ),
      if (_draft != null) ...[
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: _Chip(
            label: _draft!.found ? t.cutoutEdit : t.cutoutByHand,
            icon: PhosphorIconsBold.paintBrush,
            onTap: _retouch,
          ),
        ),
      ],
      const SizedBox(height: 16),
      _TextInput(controller: _name, hint: t.supplementNameHint, label: t.nameLabel),
      const SizedBox(height: 8),
      _TextInput(controller: _dose, hint: t.suppDoseHint, label: t.suppDose),
      section(t.suppWhen),
      Center(
        child: SegToggle([
          SegOption(t.suppDaily, _repeat == _Repeat.daily, () => setState(() => _repeat = _Repeat.daily)),
          SegOption(t.suppSomeDays, _repeat == _Repeat.days, () => setState(() => _repeat = _Repeat.days)),
          SegOption(t.suppEveryShort, _repeat == _Repeat.every, () => setState(() => _repeat = _Repeat.every)),
        ], fontSize: 12.5, hPad: 12),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: switch (_repeat) {
          _Repeat.daily => const SizedBox(width: double.infinity),
          _Repeat.days => Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(children: [
                for (var i = 0; i < 7; i++)
                  Builder(builder: (context) {
                    final d = (start - 1 + i) % 7 + 1;
                    final on = _days & (1 << d) != 0;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Pressable(
                          scale: 0.92,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() => _days ^= 1 << d);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: on ? gc.accent : gc.bgRaised2,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Text(t.weekdayInitial(d),
                                style: AppTheme.f(13.5, weight: FontWeight.w800, color: on ? gc.onEmber : gc.textSecondary)),
                          ),
                        ),
                      ),
                    );
                  }),
              ]),
            ),
          _Repeat.every => Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(t.suppEveryLead, style: AppTheme.f(15, weight: FontWeight.w700, color: gc.textSecondary)),
                const SizedBox(width: 10),
                part('$_every', () => setState(() => _every = math.max(2, _every - 1)),
                    () => setState(() => _every = math.min(60, _every + 1))),
                const SizedBox(width: 10),
                Text(t.suppEveryTail(_every), style: AppTheme.f(15, weight: FontWeight.w700, color: gc.textSecondary)),
              ]),
            ),
        },
      ),
      const SizedBox(height: 16),
      ToolGroup([
        ToolRow(
          label: t.suppRemind,
          control: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _at = at == null ? 9 * 60 : null);
            },
            child: TinySwitch(on: at != null),
          ),
        ),
      ]),
      AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: at == null
            ? const SizedBox(width: double.infinity)
            : Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  part((at ~/ 60).toString().padLeft(2, '0'), () => setState(() => _at = (at - 60 + 1440) % 1440),
                      () => setState(() => _at = (at + 60) % 1440)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(':', style: AppTheme.f(24, weight: FontWeight.w700, color: gc.textTertiary)),
                  ),
                  part((at % 60).toString().padLeft(2, '0'), () => setState(() => _at = (at - 5 + 1440) % 1440),
                      () => setState(() => _at = (at + 5) % 1440)),
                ]),
              ),
      ),
      section(t.suppStarts),
      Wrap(spacing: 7, runSpacing: 7, children: [
        _Chip(label: t.nutritionToday, selected: _from == _today, onTap: () => setState(() => _from = _today)),
        _Chip(label: t.suppTomorrow, selected: _from == tomorrow, onTap: () => setState(() => _from = tomorrow)),
        _Chip(
          label: fromCustom ? t.shortDate(_from) : t.suppPickDate,
          icon: PhosphorIconsBold.calendarBlank,
          selected: fromCustom,
          onTap: () async {
            final d = await _date(_from, _today);
            if (d == null || !mounted) return;
            setState(() {
              _from = d;
              final u = _until;
              if (u != null && u.isBefore(d)) _until = null;
            });
          },
        ),
      ]),
      section(t.suppEnds),
      Wrap(spacing: 7, runSpacing: 7, children: [
        _Chip(label: t.suppNever, selected: _until == null, onTap: () => setState(() => _until = null)),
        _Chip(label: t.suppOneWeek, selected: _until == untilWeek, onTap: () => setState(() => _until = untilWeek)),
        _Chip(label: t.suppOneMonth, selected: _until == untilMonth, onTap: () => setState(() => _until = untilMonth)),
        _Chip(
          label: untilCustom ? t.shortDate(_until!) : t.suppPickDate,
          icon: PhosphorIconsBold.calendarBlank,
          selected: untilCustom,
          onTap: () async {
            final d = await _date(_until ?? plus(13), _from);
            if (d != null && mounted) setState(() => _until = d);
          },
        ),
      ]),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(color: gc.accent.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Icon(at == null ? PhosphorIconsFill.calendarCheck : PhosphorIconsFill.bellSimpleRinging,
              size: 15, color: gc.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(_suppSchedule(context, _preview),
                style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text, height: 1.35)),
          ),
        ]),
      ),
      const SizedBox(height: 14),
      PrimaryButton(label: t.save, onTap: _save),
      if (widget.supp != null) ...[
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: _remove,
            child: Text(t.delete, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger)),
          ),
        ),
      ],
    ]);
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.unit,
    required this.lines,
    required this.chart,
    this.onTap,
    this.onLongPress,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final String unit;
  final List<String> lines;
  final Widget? chart;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: onTap ?? () {},
      onLongPress: onLongPress,
      scale: 0.98,
      child: SoftCard(
        radius: 24,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 7),
            Expanded(child: _kicker(gc, title.toUpperCase())),
            Icon(PhosphorIconsBold.caretRight, size: 12, color: gc.textTertiary),
          ]),
          const SizedBox(height: 10),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: value, style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text, height: 1)),
              if (unit.isNotEmpty)
                TextSpan(text: ' $unit', style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
            ])),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                for (final l in lines)
                  Text(l,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary, height: 1.4)),
              ]),
            ),
          ]),
          if (chart != null) ...[
            const SizedBox(height: 8),
            chart!,
          ],
        ]),
      ),
    );
  }
}

class _WeightTile extends StatelessWidget {
  const _WeightTile();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final latest = fit.latestBodyweight;
    final trend = fit.bodyweightTrend;
    final kg = trend.isNotEmpty ? trend.last.kg : fit.profile.weightKg;
    final goal = fit.weightGoalKg;
    final diff = goal > 0 && kg > 0 ? goal - kg : 0.0;
    final recent = trend.reversed.take(7).toList().reversed.toList();
    final lines = <String>[
      if (latest != null && trend.length > 1) t.weightLastLine(fit.weightLabel(latest.kg)),
      if (goal > 0) t.weightGoalLine(fit.weightLabel(goal)) else t.weightGoalNone,
      if (goal > 0)
        diff.abs() < 0.05
            ? t.weightGoalReached
            : diff < 0
                ? t.weightToLose(fit.weightLabel(-diff))
                : t.weightToGain(fit.weightLabel(diff)),
    ];
    return _ChartCard(
      icon: PhosphorIconsFill.scales,
      color: gc.water,
      title: t.bodyweightLabel,
      value: kg > 0 ? fit.weightValue(kg) : '—',
      unit: kg > 0 ? fit.units : '',
      lines: lines,
      chart: recent.length < 2
          ? null
          : ValueLineChart(
              values: [for (final b in recent) fit.toDisplayWeight(b.kg)],
              labels: [for (final b in recent) '${b.date.day}/${b.date.month}'],
              format: (v) => fmt((v * 10).round() / 10),
              color: gc.water,
              goal: goal > 0 ? fit.toDisplayWeight(goal) : null,
              goalLabel: goal > 0 ? fit.weightValue(goal) : null,
              highlight: recent.length - 1,
              fromZero: false,
              height: 150,
            ),
      onTap: () => showBodyweightSheet(context),
      onLongPress: () => _editWeightGoal(context),
    );
  }
}

Future<void> _editWeightGoal(BuildContext context) async {
  HapticFeedback.mediumImpact();
  final goal = fit.weightGoalKg;
  final v = await askNumber(
    context,
    title: t.weightGoalTitle(fit.units),
    initial: goal > 0 ? fit.weightValue(goal) : '',
    decimal: true,
  );
  if (v == null) return;
  fit.setWeightGoal(v <= 0 ? 0 : fit.fromDisplayWeight(v));
}

Color _dayTone(GymColors gc, double value, double goal) {
  final r = goal <= 0 ? 0 : value / goal;
  if (r > 1.1) return gc.danger;
  if (r >= 0.9) return gc.sage;
  return gc.accent;
}

class _WeekTile extends StatelessWidget {
  const _WeekTile();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final w = fit.weekNutrition();
    final days = fit.nutritionWeek;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final goal = fit.energyOf(fit.kcalBudgetOn(fit.nutritionDay)).toDouble();
    return _ChartCard(
      icon: PhosphorIconsFill.chartLineUp,
      color: gc.accent,
      title: t.weekAverage,
      value: w == null ? '—' : '${fit.energyOf(w.kcal)}',
      unit: w == null ? '' : t.perDayUnit(fit.energyUnit),
      lines: w == null ? [t.weekNoData] : [t.weekProteinAvg(w.protein), t.weekDaysOnTarget(w.kcalMet, w.days)],
      chart: w == null
          ? null
          : ValueLineChart(
              values: [
                for (final d in days)
                  d.isAfter(today) || fit.entriesOn(d).isEmpty ? null : fit.energyOf(fit.totalOn(d).kcal).toDouble(),
              ],
              labels: [for (final d in days) t.weekdayInitial(d.weekday)],
              format: (v) => '${v.round()}',
              color: gc.accent,
              goal: goal > 0 ? goal : null,
              goalLabel: goal > 0 ? '${goal.round()}' : null,
              highlight: days.indexOf(fit.nutritionDay),
              tone: (v) => _dayTone(gc, v, goal),
              height: 150,
            ),
      onTap: () => showWeekSheet(context),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.onTap, this.icon, this.selected = false});

  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: onTap,
      scale: 0.94,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(color: selected ? gc.accent : gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: selected ? gc.onEmber : gc.textSecondary),
            const SizedBox(width: 6),
          ],
          Text(label, style: AppTheme.f(12.5, weight: FontWeight.w700, color: selected ? gc.onEmber : gc.text)),
        ]),
      ),
    );
  }
}
