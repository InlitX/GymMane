part of '../nutrition_screen.dart';

Future<void> showTrackersSheet(BuildContext context) => _sheet<void>(context, (context) {
  final gc = context.gc;
  ToolRow toggle(Tracker tr, IconData icon, Color color, String label) => ToolRow(
    label: label,
    control: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.selectionClick();
        fit.setTracker(tr, !fit.trackerOn(tr));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: fit.trackerOn(tr) ? color : gc.textTertiary),
          const SizedBox(width: 12),
          TinySwitch(on: fit.trackerOn(tr)),
        ],
      ),
    ),
  );
  Widget label(String text) => Padding(
    padding: const EdgeInsets.only(left: 4, top: 18, bottom: 8),
    child: _kicker(gc, text.toUpperCase()),
  );
  Future<void> rename(MealSlot s) async {
    final name = await askText(context, title: t.renameLabel, initial: mealName(s.meal));
    if (name != null && name.trim().isNotEmpty) fit.renameMealSlot(s.meal, name);
  }

  Future<void> add() async {
    final name = await askText(context, title: t.mealAdd, hint: t.mealAddHint);
    if (name != null) fit.addMealSlot(name);
  }

  final slots = fit.mealSlots;
  return _sheetFrame(context, [
    SheetTitle(t.trackersTitle, subtitle: t.trackersHint),
    label(t.trackersDaily),
    ToolGroup([
      toggle(Tracker.calories, PhosphorIconsFill.fire, gc.warn, sentenceCase(t.kcalLabel)),
      toggle(Tracker.protein, PhosphorIconsFill.egg, gc.protein, sentenceCase(t.macroProtein)),
      toggle(Tracker.carbs, PhosphorIconsFill.grains, gc.carbs, sentenceCase(t.macroCarbs)),
      toggle(Tracker.fat, PhosphorIconsFill.drop, gc.fat, sentenceCase(t.macroFat)),
    ]),
    label(t.trackersDetail),
    ToolGroup([
      toggle(Tracker.animal, PhosphorIconsFill.lightning, gc.warn, t.animalProtein),
      toggle(Tracker.quality, PhosphorIconsFill.dna, gc.sage, t.proteinQuality),
      toggle(Tracker.fats, PhosphorIconsFill.drop, gc.fat, t.fatTypes),
      toggle(Tracker.fiber, PhosphorIconsFill.leaf, gc.sage, t.fiberLabel),
      toggle(Tracker.sugarSodium, PhosphorIconsFill.cube, gc.carbs, t.sugarSodium),
    ]),
    label(t.trackersCards),
    ToolGroup([
      toggle(Tracker.water, PhosphorIconsFill.drop, gc.water, t.waterLabel),
      toggle(Tracker.shake, PhosphorIconsFill.egg, gc.protein, t.shakeCard),
      toggle(Tracker.supplements, PhosphorIconsFill.pill, gc.sage, t.supplementsLabel),
      toggle(Tracker.weight, PhosphorIconsFill.scales, gc.water, t.bodyweightLabel),
      toggle(Tracker.week, PhosphorIconsFill.chartLineUp, gc.sage, t.weekAverage),
      toggle(Tracker.prep, PhosphorIconsFill.cookingPot, gc.warn, t.prepTitle),
      toggle(Tracker.plans, PhosphorIconsFill.calendarBlank, gc.accent, t.mealPlansTitle),
      toggle(Tracker.foods, PhosphorIconsFill.bookmarkSimple, gc.accent, t.myFoods),
    ]),
    label(t.trackersScreen),
    ToolGroup([
      ToolRow(
        label: t.vesselMotion,
        control: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.selectionClick();
            fit.setVesselMotion(!fit.vesselMotion);
          },
          child: TinySwitch(on: fit.vesselMotion),
        ),
      ),
    ]),
    const SizedBox(height: 6),
    Text(
      t.vesselMotionHint,
      textAlign: TextAlign.center,
      style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4),
    ),
    label(t.mealsOfDay),
    ToolGroup([
      for (var i = 0; i < slots.length; i++)
        ToolRow(
          label: mealName(slots[i].meal),
          control: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _miniBtn(
                gc,
                PhosphorIconsBold.arrowUp,
                i == 0 ? null : () => fit.moveMealSlot(slots[i].meal, -1),
              ),
              _miniBtn(gc, PhosphorIconsBold.pencilSimple, () => rename(slots[i])),
              _miniBtn(
                gc,
                PhosphorIconsBold.trash,
                slots.length <= 1 ? null : () => fit.removeMealSlot(slots[i].meal),
                danger: true,
              ),
            ],
          ),
        ),
    ]),
    const SizedBox(height: 10),
    GhostButton(label: t.mealAdd, icon: PhosphorIconsBold.plus, onTap: add),
    const SizedBox(height: 6),
    Text(
      t.mealsHint,
      textAlign: TextAlign.center,
      style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4),
    ),
  ]);
});

Widget _miniBtn(GymColors gc, IconData icon, VoidCallback? onTap, {bool danger = false}) => GestureDetector(
  behavior: HitTestBehavior.opaque,
  onTap: onTap,
  child: SizedBox(
    width: 36,
    height: 36,
    child: Icon(
      icon,
      size: 15,
      color: onTap == null
          ? gc.textTertiary.withValues(alpha: 0.35)
          : danger
          ? gc.danger
          : gc.textSecondary,
    ),
  ),
);

Future<void> showWeekSheet(BuildContext context) => _sheet<void>(context, (context) {
  final gc = context.gc;
  final w = fit.weekNutrition();
  final days = fit.nutritionWeek;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final hot = days.indexOf(fit.nutritionDay);
  final labels = [for (final d in days) t.weekdayInitial(d.weekday)];
  bool open(DateTime d) => d.isAfter(today) || fit.entriesOn(d).isEmpty;
  final kcalGoal = fit.energyOf(fit.kcalBudgetOn(fit.nutritionDay)).toDouble();
  final proteinGoal = fit.goalsFor(fit.nutritionDay).protein.toDouble();
  Widget chartBox(String title, Color color, Widget chart) => SoftCard(
    radius: 22,
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 7),
            _kicker(gc, title.toUpperCase()),
          ],
        ),
        const SizedBox(height: 4),
        chart,
      ],
    ),
  );
  return _sheetFrame(context, [
    SheetTitle(t.weekAverage, subtitle: w == null ? t.weekNoData : t.weekLoggedDays(w.days)),
    const SizedBox(height: 18),
    chartBox(
      sentenceCase(t.kcalLabel),
      gc.accent,
      ValueLineChart(
        values: [for (final d in days) open(d) ? null : fit.energyOf(fit.totalOn(d).kcal).toDouble()],
        labels: labels,
        format: (v) => '${v.round()}',
        color: gc.accent,
        goal: kcalGoal > 0 ? kcalGoal : null,
        goalLabel: kcalGoal > 0 ? '${kcalGoal.round()}' : null,
        highlight: hot,
        tone: (v) => _dayTone(gc, v, kcalGoal),
      ),
    ),
    const SizedBox(height: 10),
    chartBox(
      sentenceCase(t.macroProtein),
      gc.protein,
      ValueLineChart(
        values: [for (final d in days) open(d) ? null : fit.totalOn(d).protein.roundToDouble()],
        labels: labels,
        format: (v) => '${v.round()}',
        color: gc.protein,
        goal: proteinGoal > 0 ? proteinGoal : null,
        goalLabel: proteinGoal > 0 ? '${proteinGoal.round()} g' : null,
        highlight: hot,
      ),
    ),
    const SizedBox(height: 18),
    if (w != null)
      ToolGroup([
        ToolRow(label: t.weekAvgEnergy, control: _value(gc, _energy(w.kcal))),
        ToolRow(label: t.weekAvgProtein, control: _value(gc, '${w.protein} g')),
        ToolRow(label: t.weekEnergyOnTarget, control: _value(gc, '${w.kcalMet}/${w.days}')),
        ToolRow(label: t.weekProteinOnTarget, control: _value(gc, '${w.proteinMet}/${w.days}')),
      ]),
    const SizedBox(height: 10),
    Text(
      t.weekOnTargetHint,
      textAlign: TextAlign.center,
      style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4),
    ),
  ]);
});

Widget _value(GymColors gc, String text) => Text(
  text,
  style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text),
);

List<ToolRow> _waterRows(BuildContext context) {
  final g = fit.activeGoals;
  final waterStep = fit.isLb ? 237 : 250;
  final glassStep = fit.isLb ? 30 : 50;
  final flOz = fit.isLb ? 29.5735 : 1.0;
  Future<void> edit(String title, int ml, void Function(int) apply) async {
    final v = await askNumber(
      context,
      title: '$title (${fit.isLb ? 'fl oz' : 'ml'})',
      initial: fmt((ml / flOz * 10).round() / 10),
      decimal: true,
    );
    if (v != null && v > 0) apply((v * flOz).round());
  }

  ToolRow row(String label, int ml, int step, int min, int max, void Function(int) set) => ToolRow(
    label: label,
    control: StepperControl(
      value: fit.waterLabel(ml),
      minWidth: 74,
      onDec: () => set((ml - step).clamp(min, max)),
      onInc: () => set((ml + step).clamp(min, max)),
      onEdit: () => edit(label, ml, (v) => set(v.clamp(min, max))),
    ),
  );
  return [
    row(
      t.waterDailyGoal,
      g.waterMl,
      waterStep,
      500,
      8000,
      (v) => fit.setNutritionGoals(g.copyWith(waterMl: v)),
    ),
    row(t.glassSize, g.glassMl, glassStep, 30, 1500, (v) => fit.setNutritionGoals(g.copyWith(glassMl: v))),
  ];
}

Future<void> showGoalsSheet(BuildContext context) => _sheet<void>(context, (context) {
  final gc = context.gc;
  final g = fit.activeGoals;
  final rest = fit.restGoals;

  final unit = fit.energyUnit;
  Future<void> edit(String title, int current, void Function(int) apply) async {
    final v = await askNumber(context, title: title, initial: '$current', decimal: false);
    if (v != null && v > 0) apply(v.round());
  }

  ToolRow row(String label, String value, VoidCallback dec, VoidCallback inc, VoidCallback onEdit) => ToolRow(
    label: label,
    control: StepperControl(value: value, minWidth: 74, onDec: dec, onInc: inc, onEdit: onEdit),
  );
  ToolRow toggle(String label, bool on, ValueChanged<bool> set) => ToolRow(
    label: label,
    control: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.selectionClick();
        set(!on);
      },
      child: TinySwitch(on: on),
    ),
  );
  List<ToolRow> macroRows(NutritionGoals g, void Function(NutritionGoals) set) => [
    row(
      sentenceCase(t.kcalLabel),
      '${fit.energyOf(g.kcal)} $unit',
      () => set(g.copyWith(kcal: (g.kcal - 50).clamp(800, 9000))),
      () => set(g.copyWith(kcal: (g.kcal + 50).clamp(800, 9000))),
      () => edit(
        '${sentenceCase(t.kcalLabel)} ($unit)',
        fit.energyOf(g.kcal),
        (v) => set(g.copyWith(kcal: fit.kcalFromShown(v.toDouble()).round().clamp(800, 9000))),
      ),
    ),
    row(
      sentenceCase(t.macroProtein),
      '${g.protein} g',
      () => set(g.copyWith(protein: (g.protein - 5).clamp(10, 600))),
      () => set(g.copyWith(protein: (g.protein + 5).clamp(10, 600))),
      () => edit(sentenceCase(t.macroProtein), g.protein, (v) => set(g.copyWith(protein: v.clamp(10, 600)))),
    ),
    row(
      sentenceCase(t.macroCarbs),
      '${g.carbs} g',
      () => set(g.copyWith(carbs: (g.carbs - 10).clamp(10, 1500))),
      () => set(g.copyWith(carbs: (g.carbs + 10).clamp(10, 1500))),
      () => edit(sentenceCase(t.macroCarbs), g.carbs, (v) => set(g.copyWith(carbs: v.clamp(10, 1500)))),
    ),
    row(
      sentenceCase(t.macroFat),
      '${g.fat} g',
      () => set(g.copyWith(fat: (g.fat - 5).clamp(10, 500))),
      () => set(g.copyWith(fat: (g.fat + 5).clamp(10, 500))),
      () => edit(sentenceCase(t.macroFat), g.fat, (v) => set(g.copyWith(fat: v.clamp(10, 500)))),
    ),
  ];
  Widget label(String text) =>
      Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: _kicker(gc, text.toUpperCase()));
  return _sheetFrame(context, [
    SheetTitle(t.nutritionGoals),
    const SizedBox(height: 14),
    Center(
      child: SegToggle([
        SegOption('kcal', !fit.useKj, () => fit.setUseKj(false)),
        SegOption('kJ', fit.useKj, () => fit.setUseKj(true)),
      ]),
    ),
    const SizedBox(height: 16),
    if (rest != null) label(t.trainingDays),
    ToolGroup(macroRows(g, fit.setNutritionGoals)),
    const SizedBox(height: 12),
    ToolGroup([toggle(t.restDayGoals, rest != null, fit.splitRestGoals)]),
    if (rest != null) ...[
      const SizedBox(height: 16),
      label(t.restDays),
      ToolGroup(macroRows(rest, fit.setRestGoals)),
    ],
    const SizedBox(height: 12),
    ToolGroup([
      toggle(t.addBurnedLabel, fit.addBurned, fit.setAddBurned),
      ToolRow(
        label: t.weightGoalLabel,
        control: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _editWeightGoal(context),
          child: _value(gc, fit.weightGoalKg > 0 ? fit.weightLabel(fit.weightGoalKg) : '—'),
        ),
      ),
    ]),
    const SizedBox(height: 10),
    Text(
      t.addBurnedHint,
      textAlign: TextAlign.center,
      style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4),
    ),
    const SizedBox(height: 12),
    ToolGroup(_waterRows(context)),
    if (fit.trackerOn(Tracker.fiber) || fit.trackerOn(Tracker.sugarSodium)) ...[
      const SizedBox(height: 12),
      ToolGroup([
        if (fit.trackerOn(Tracker.fiber))
          row(
            t.fiberLabel,
            '${g.fiber} g',
            () => fit.setNutritionGoals(g.copyWith(fiber: (g.fiber - 5).clamp(5, 200))),
            () => fit.setNutritionGoals(g.copyWith(fiber: (g.fiber + 5).clamp(5, 200))),
            () =>
                edit(t.fiberLabel, g.fiber, (v) => fit.setNutritionGoals(g.copyWith(fiber: v.clamp(5, 200)))),
          ),
        if (fit.trackerOn(Tracker.sugarSodium)) ...[
          row(
            t.sugarLimitLabel,
            '${g.sugar} g',
            () => fit.setNutritionGoals(g.copyWith(sugar: (g.sugar - 5).clamp(5, 500))),
            () => fit.setNutritionGoals(g.copyWith(sugar: (g.sugar + 5).clamp(5, 500))),
            () => edit(
              t.sugarLimitLabel,
              g.sugar,
              (v) => fit.setNutritionGoals(g.copyWith(sugar: v.clamp(5, 500))),
            ),
          ),
          row(
            t.sodiumLimitLabel,
            '${fmt(g.sodium / 1000)} g',
            () => fit.setNutritionGoals(g.copyWith(sodium: (g.sodium - 100).clamp(200, 20000))),
            () => fit.setNutritionGoals(g.copyWith(sodium: (g.sodium + 100).clamp(200, 20000))),
            () => edit(
              '${t.sodiumLimitLabel} (mg)',
              g.sodium,
              (v) => fit.setNutritionGoals(g.copyWith(sodium: v.clamp(200, 20000))),
            ),
          ),
        ],
      ]),
    ],
    const SizedBox(height: 16),
    GhostButton(label: t.goalsFromProfile, icon: PhosphorIconsBold.sparkle, onTap: fit.useSuggestedGoals),
    const SizedBox(height: 10),
    Text(
      t.goalsFromProfileHint,
      textAlign: TextAlign.center,
      style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4),
    ),
  ]);
});

Future<void> showNutritionAbout(BuildContext context) => _sheet<void>(context, (sheet) {
  final gc = sheet.gc;
  Widget point(IconData icon, Color color, String title, String body) => Padding(
    padding: const EdgeInsets.only(top: 18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  return _sheetFrame(sheet, [
    SheetTitle(t.nutritionAboutTitle, subtitle: t.nutritionAboutSub),
    const SizedBox(height: 4),
    point(PhosphorIconsFill.barbell, gc.accent, t.nutritionAboutWhatTitle, t.nutritionAboutWhat),
    point(PhosphorIconsFill.shieldCheck, gc.sage, t.nutritionAboutScanTitle, t.nutritionAboutScan),
    point(PhosphorIconsFill.deviceMobile, gc.protein, t.nutritionAboutLocalTitle, t.nutritionAboutLocal),
    point(PhosphorIconsFill.flask, gc.warn, t.nutritionAboutBetaTitle, t.nutritionAboutBeta),
    const SizedBox(height: 24),
    PrimaryButton(label: t.nutritionAboutOk, onTap: () => Navigator.of(sheet).pop()),
    const SizedBox(height: 10),
    GhostButton(
      label: t.nutritionAboutSuggest,
      icon: PhosphorIconsBold.githubLogo,
      onTap: () async {
        try {
          await launchUrl(
            Uri.parse('https://github.com/InlitX/GymMane/issues'),
            mode: LaunchMode.externalApplication,
          );
        } catch (_) {}
      },
    ),
  ]);
});
