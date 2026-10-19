part of '../nutrition_screen.dart';

String _planSummary(MealPlan p) {
  final lines = <String>['${p.name} · ${_energy(p.total.kcal)}'];
  for (final slot in fit.mealSlots) {
    final items = p.itemsOf(slot.meal);
    if (items.isEmpty) continue;
    lines.add(
      '${mealName(slot.meal)}: ${[for (final e in items) '${e.name} ${_amount(e.shownGrams, e.liquid)}'].join(', ')}',
    );
  }
  return lines.join('\n');
}

Future<void> shareMealPlans(List<MealPlan> plans) async {
  if (plans.isEmpty) return;
  final name = plans.length == 1 ? plans.first.name : t.mealPlansTitle;
  try {
    final dir = await getTemporaryDirectory();
    final slug = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');
    final file = File('${dir.path}/gymmane-${slug.isEmpty ? 'plan' : slug}.json');
    await file.writeAsString(fit.exportMealPlansJson(plans));
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/json')],
        text: [for (final p in plans) _planSummary(p)].join('\n\n'),
        subject: name,
      ),
    );
  } catch (_) {}
}

Future<void> importMealPlanFile(BuildContext context) async {
  final text = await pickTextFile();
  if (text == null || !context.mounted) return;
  showMealPlanImportResult(context, fit.importMealPlans(text));
}

void showMealPlanImportResult(BuildContext context, int n) {
  final gc = context.gc;
  if (n > 0) {
    HapticFeedback.lightImpact();
    showNotchToast(context, t.planImported(n), icon: PhosphorIconsFill.calendarCheck, accent: gc.sage);
  } else {
    HapticFeedback.heavyImpact();
    showNotchToast(context, t.planImportNone, icon: PhosphorIconsFill.warningCircle, accent: gc.warn);
  }
}

String _planDetail(MealPlan p) => '${_energy(p.total.kcal)} · ${t.recipeItems(p.items.length)}';

class _PlansSection extends StatelessWidget {
  const _PlansSection();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final plans = fit.mealPlans;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PlanWeek(),
        const SizedBox(height: 12),
        if (plans.isEmpty)
          Pressable(
            onTap: () => showNewPlanSheet(context),
            scale: 0.97,
            child: SoftCard(
              radius: 24,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: gc.accent.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(PhosphorIconsBold.plus, size: 18, color: gc.accent),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(t.planNewHint, style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.4)),
                  ),
                ],
              ),
            ),
          )
        else
          for (var i = 0; i < plans.length; i += 2) ...[
            if (i > 0) const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _planFolder(context, plans[i])),
                const SizedBox(width: 12),
                Expanded(
                  child: i + 1 < plans.length ? _planFolder(context, plans[i + 1]) : const SizedBox.shrink(),
                ),
              ],
            ),
          ],
      ],
    );
  }

  Widget _planFolder(BuildContext context, MealPlan p) => HomeFolder(
    title: p.name,
    detail: _planDetail(p),
    peek: _PlanPeek(plan: p),
    onTap: () => showMealPlanSheet(context, p.id),
  );
}

class _PlanPeek extends StatelessWidget {
  const _PlanPeek({required this.plan});

  final MealPlan plan;

  @override
  Widget build(BuildContext context) => _StickerPeek(photos: _plateOf(plan.items).take(3).toList());
}

class _StickerPeek extends StatelessWidget {
  const _StickerPeek({required this.photos, this.empty = PhosphorIconsFill.forkKnife});

  final List<(String, String)> photos;
  final IconData empty;

  static const _spots = [(-0.24, 12.0, -0.14, 42.0), (0.24, 10.0, 0.12, 42.0), (0.0, 4.0, 0.0, 48.0)];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) => Stack(
        clipBehavior: Clip.none,
        children: [
          if (photos.isEmpty)
            Center(child: Icon(empty, size: 26, color: context.gc.textTertiary.withValues(alpha: 0.6)))
          else
            for (var i = 0; i < photos.length; i++)
              Positioned(
                left: box.maxWidth / 2 + _spots[i].$1 * box.maxWidth - _spots[i].$4 / 2,
                top: _spots[i].$2,
                child: Transform.rotate(
                  angle: _spots[i].$3,
                  child: FoodSticker(
                    photo: photos[i].$1,
                    name: photos[i].$2,
                    size: _spots[i].$4,
                    tilt: false,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _PlanWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final days = fit.nutritionWeek;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return SoftCard(
      radius: 22,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              for (final d in days)
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final plan = fit.mealPlans.isEmpty ? null : fit.planOn(d);
                      final isToday = d == today;
                      final photo = plan == null ? null : _plateOf(plan.items).firstOrNull;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _pickPlanForDay(context, d.weekday),
                        child: Column(
                          children: [
                            Text(
                              t.weekdayInitial(d.weekday),
                              style: AppTheme.f(
                                10.5,
                                weight: FontWeight.w700,
                                color: isToday ? gc.text : gc.textTertiary,
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 7),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: plan == null ? Colors.transparent : gc.bgRaised2,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isToday
                                      ? gc.accent
                                      : (plan == null ? gc.border : Colors.transparent),
                                  width: isToday ? 2 : 1,
                                ),
                              ),
                              child: Center(
                                child: plan == null
                                    ? Icon(PhosphorIconsBold.plus, size: 11, color: gc.textTertiary)
                                    : photo == null
                                    ? Icon(PhosphorIconsFill.forkKnife, size: 13, color: gc.textSecondary)
                                    : FoodSticker(
                                        photo: photo.$1,
                                        name: photo.$2,
                                        size: 26,
                                        tilt: false,
                                        shadow: false,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 13,
                              child: plan == null
                                  ? null
                                  : Text(
                                      plan.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTheme.f(9, weight: FontWeight.w700, color: gc.textSecondary),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          if (fit.mealWeek.isEmpty) ...[
            const SizedBox(height: 6),
            Text(
              t.planWeekHint,
              style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary),
            ),
          ],
        ],
      ),
    );
  }
}

Future<void> _pickPlanForDay(BuildContext context, int weekday) {
  if (fit.mealPlans.isEmpty) return showMealPlanEditor(context, days: {weekday});
  return _sheet<void>(context, (sheet) {
    final current = fit.mealWeek[weekday];
    return _sheetFrame(sheet, [
      SheetTitle(t.weekday(weekday), subtitle: t.planPickHint),
      const SizedBox(height: 16),
      OptionGroup([
        for (final p in fit.mealPlans)
          OptionItem(
            p.name,
            leading: FoodPlate(items: _plateOf(p.items), size: 34),
            detail: _energy(p.total.kcal),
            selected: p.id == current,
            onTap: () {
              HapticFeedback.selectionClick();
              fit.setPlanDay(weekday, p.id);
              Navigator.of(sheet).pop();
              showNotchToast(
                context,
                t.planSetForDay(t.weekday(weekday).toLowerCase()),
                subtitle: p.name,
                icon: PhosphorIconsFill.calendarCheck,
                accent: context.gc.sage,
              );
            },
          ),
        OptionItem(
          t.planNoPlan,
          icon: PhosphorIconsRegular.prohibit,
          selected: current == null,
          onTap: () {
            if (current != null) fit.setPlanDay(weekday, null);
            Navigator.of(sheet).pop();
          },
        ),
      ]),
      const SizedBox(height: 12),
      GhostButton(
        label: t.mealPlanNew,
        icon: PhosphorIconsBold.plus,
        onTap: () {
          Navigator.of(sheet).pop();
          showMealPlanEditor(context, days: {weekday});
        },
      ),
    ]);
  });
}

Future<void> showNewPlanSheet(BuildContext context) => showMealPlanEditor(context);

Future<void> showMealPlanSheet(BuildContext context, String id) {
  final plan = fit.mealPlanById(id);
  if (plan == null) return Future.value();
  return showMealPlanEditor(context, plan: plan);
}

Future<void> showMealPlanEditor(BuildContext context, {MealPlan? plan, Set<int> days = const {}}) =>
    showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _PlanEditor(plan: plan, days: days),
    );

class _PlanEditor extends StatefulWidget {
  const _PlanEditor({this.plan, this.days = const {}});

  final MealPlan? plan;
  final Set<int> days;

  @override
  State<_PlanEditor> createState() => _PlanEditorState();
}

class _PlanEditorState extends State<_PlanEditor> {
  late MealPlan _plan = widget.plan ?? fit.draftMealPlan();
  late final _name = TextEditingController(text: _plan.name);
  late Set<int> _days = widget.plan == null ? {...widget.days} : {...fit.planDays(_plan.id)};
  bool _dirty = false;

  bool get _isNew => widget.plan == null;

  @override
  void initState() {
    super.initState();
    _dirty = _isNew && widget.days.isNotEmpty;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _setItems(List<FoodEntry> items) => setState(() {
    _plan = _plan.copyWith(items: items);
    _dirty = true;
  });

  void _add(Meal meal) => showAddFoodSheet(
    context,
    meal,
    onPick: (e) {
      if (!mounted) return;
      _setItems([..._plan.items, e.copyWith(id: fit.newPlanItemId(), meal: meal)]);
    },
  );

  void _edit(FoodEntry e) {
    final food = fit.foodById(e.foodId);
    if (food == null) return;
    showLogFoodSheet(
      context,
      food,
      e.meal,
      initial: e,
      onPick: (n) {
        if (!mounted) return;
        _setItems([for (final x in _plan.items) x.id == e.id ? n.copyWith(id: e.id, meal: e.meal) : x]);
      },
    );
  }

  void _remove(FoodEntry e) {
    HapticFeedback.selectionClick();
    _setItems([
      for (final x in _plan.items)
        if (x.id != e.id) x,
    ]);
  }

  void _save() {
    HapticFeedback.lightImpact();
    final saved = fit.saveMealPlan(_plan.copyWith(name: _name.text), _days);
    _dirty = false;
    Navigator.of(context).pop();
    showNotchToast(
      context,
      t.planSaved,
      subtitle: _days.isEmpty ? saved.name : '${saved.name} · ${_daysLine(_days)}',
      icon: PhosphorIconsFill.calendarCheck,
      accent: context.gc.sage,
    );
  }

  Future<void> _close() async {
    if (!_dirty) {
      Navigator.of(context).pop();
      return;
    }
    final ok = await askConfirm(
      context,
      title: t.planDiscardTitle,
      body: t.planDiscardBody,
      confirmLabel: t.planDiscard,
      danger: true,
    );
    if (ok && mounted) {
      _dirty = false;
      Navigator.of(context).pop();
    }
  }

  Future<void> _more() => _sheet<void>(context, (sheet) {
    final plan = fit.mealPlanById(_plan.id) ?? _plan;
    return _sheetFrame(sheet, [
      SheetTitle(plan.name),
      const SizedBox(height: 16),
      OptionGroup([
        OptionItem(
          t.planShare,
          icon: PhosphorIconsRegular.shareNetwork,
          onTap: () {
            Navigator.of(sheet).pop();
            shareMealPlans([plan]);
          },
        ),
        OptionItem(
          t.planDuplicate,
          icon: PhosphorIconsRegular.copy,
          onTap: () {
            final copy = fit.duplicateMealPlan(plan.id);
            Navigator.of(sheet).pop();
            Navigator.of(context).pop();
            if (copy != null) showMealPlanEditor(context, plan: copy);
          },
        ),
        if (fit.mealPlans.length > 1 && fit.mealPlans.first.id != plan.id)
          OptionItem(
            t.planMoveUp,
            icon: PhosphorIconsRegular.arrowUp,
            onTap: () {
              fit.moveMealPlan(plan.id, -1);
              Navigator.of(sheet).pop();
            },
          ),
        if (fit.mealPlans.length > 1 && fit.mealPlans.last.id != plan.id)
          OptionItem(
            t.planMoveDown,
            icon: PhosphorIconsRegular.arrowDown,
            onTap: () {
              fit.moveMealPlan(plan.id, 1);
              Navigator.of(sheet).pop();
            },
          ),
        OptionItem(
          t.delete,
          icon: PhosphorIconsRegular.trash,
          danger: true,
          onTap: () async {
            final ok = await askConfirm(
              sheet,
              title: t.planDeleteTitle(plan.name),
              body: t.planDeleteBody,
              confirmLabel: t.delete,
              danger: true,
            );
            if (!ok || !sheet.mounted) return;
            Navigator.of(sheet).pop();
            fit.deleteMealPlan(plan.id);
            _dirty = false;
            if (mounted) Navigator.of(context).pop();
          },
        ),
      ]),
    ]);
  });

  void _logToday() {
    final n = fit.logPlanDay(_plan);
    HapticFeedback.lightImpact();
    showNotchToast(
      context,
      n > 0 ? t.planLogged(n) : t.planNothingToLog,
      icon: PhosphorIconsFill.checkCircle,
      accent: context.gc.sage,
    );
  }

  Widget _item(GymColors gc, FoodEntry e) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Pressable(
      scale: 0.98,
      onTap: () => _edit(e),
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 6, 4, 6),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            FoodSticker(photo: fit.photoForEntry(e), name: e.name, size: 36, tilt: false, shadow: false),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text),
                  ),
                  Text(
                    _servingLine(e, fit.foodById(e.foodId)),
                    maxLines: 1,
                    style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary),
                  ),
                ],
              ),
            ),
            Text(
              _energy(e.total.kcal),
              style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.text),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _remove(e),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(PhosphorIconsBold.x, size: 13, color: gc.textTertiary),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final media = MediaQuery.of(context);
    final plan = _plan;
    final total = plan.total;
    final logged = fit.entriesOn(fit.nutritionDay).isNotEmpty;
    final start = fit.weekStartDay;
    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _close();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
        child: Container(
          height: media.size.height * 0.92,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 14 + media.padding.bottom),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 10),
              Row(
                children: [
                  RoundAction(
                    label: t.cancel,
                    onTap: _close,
                    child: Icon(PhosphorIconsBold.x, size: 15, color: gc.textSecondary),
                  ),
                  Expanded(
                    child: Text(
                      _isNew ? t.mealPlanNew : t.planEdit,
                      textAlign: TextAlign.center,
                      style: AppTheme.f(16, weight: FontWeight.w700, color: gc.text),
                    ),
                  ),
                  if (_isNew)
                    const SizedBox(width: 36)
                  else
                    RoundAction(
                      label: t.mealOptions,
                      onTap: _more,
                      child: Icon(PhosphorIconsBold.dotsThree, size: 17, color: gc.textSecondary),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.zero,
                  children: [
                    Row(
                      children: [
                        FoodPlate(items: _plateOf(plan.items), size: 76),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _name,
                                onChanged: (_) => _dirty = true,
                                textCapitalization: TextCapitalization.sentences,
                                style: AppTheme.f(21, weight: FontWeight.w800, color: gc.text),
                                cursorColor: gc.accent,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: t.planNameHint,
                                  hintStyle: AppTheme.f(21, weight: FontWeight.w700, color: gc.textTertiary),
                                  contentPadding: EdgeInsets.zero,
                                  suffixIcon: Icon(
                                    PhosphorIconsRegular.pencilSimple,
                                    size: 15,
                                    color: gc.textTertiary,
                                  ),
                                  suffixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _planDetail(plan),
                                style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _macroSummary(context, total),
                    const SizedBox(height: 18),
                    _kicker(gc, t.planDaysQuestion.toUpperCase()),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        for (var i = 0; i < 7; i++)
                          Builder(
                            builder: (context) {
                              final d = (start - 1 + i) % 7 + 1;
                              final on = _days.contains(d);
                              final other = fit.mealWeek[d];
                              final taken = !on && other != null && other != plan.id;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: Pressable(
                                    scale: 0.92,
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      setState(() {
                                        _days = {..._days};
                                        if (!_days.remove(d)) _days.add(d);
                                        _dirty = true;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 180),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: on ? gc.accent : gc.bgRaised2,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            t.weekdayInitial(d),
                                            style: AppTheme.f(
                                              13,
                                              weight: FontWeight.w800,
                                              color: on ? gc.onEmber : gc.textSecondary,
                                            ),
                                          ),
                                          if (taken)
                                            Container(
                                              width: 4,
                                              height: 4,
                                              margin: const EdgeInsets.only(top: 2),
                                              decoration: BoxDecoration(
                                                color: gc.textTertiary,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _days.isEmpty ? t.planDaysNone : t.planDaysHint,
                      style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4),
                    ),
                    if (plan.items.isEmpty) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          if (logged)
                            _Chip(
                              label: t.planFromDay,
                              icon: PhosphorIconsBold.copy,
                              onTap: () => _setItems(fit.draftMealPlan(fromDay: true).items),
                            ),
                          if (_isNew)
                            _Chip(
                              label: t.planImport,
                              icon: PhosphorIconsBold.downloadSimple,
                              onTap: () async {
                                _dirty = false;
                                final nav = Navigator.of(context)..pop();
                                await importMealPlanFile(nav.context);
                              },
                            ),
                        ],
                      ),
                    ],
                    for (final slot in fit.mealSlots) ...[
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Icon(_mealIcon(slot.meal), size: 14, color: gc.textSecondary),
                          const SizedBox(width: 6),
                          Expanded(child: _kicker(gc, mealName(slot.meal).toUpperCase())),
                          if (plan.itemsOf(slot.meal).isNotEmpty)
                            Text(
                              _energy(plan.itemsOf(slot.meal).fold(Macros.zero, (s, e) => s + e.total).kcal),
                              style: AppTheme.f(12, weight: FontWeight.w800, color: gc.textSecondary),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      for (final e in plan.itemsOf(slot.meal)) _item(gc, e),
                      Pressable(
                        scale: 0.98,
                        onTap: () => _add(slot.meal),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: gc.border),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(PhosphorIconsBold.plus, size: 13, color: gc.accent),
                              const SizedBox(width: 6),
                              Text(
                                t.addToMeal(mealInSentence(slot.meal)),
                                style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.accent),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (!_isNew && plan.items.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      GhostButton(label: t.planLogDay, icon: PhosphorIconsBold.checkCircle, onTap: _logToday),
                    ],
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              PrimaryButton(label: _isNew ? t.planSave : t.save, onTap: _save),
            ],
          ),
        ),
      ),
    );
  }
}

String _daysLine(Set<int> days) {
  final start = fit.weekStartDay;
  if (days.length == 7) return t.suppDaily;
  return [
    for (var i = 0; i < 7; i++)
      if (days.contains((start - 1 + i) % 7 + 1)) t.weekdayShort((start - 1 + i) % 7 + 1),
  ].join(' · ');
}

class _TodayPlanCard extends StatelessWidget {
  const _TodayPlanCard({required this.plan});

  final MealPlan plan;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final p = fit.planProgress(plan, fit.nutritionDay);
    final left = p.total - p.done;
    return Pressable(
      scale: 0.98,
      onTap: () => showMealPlanEditor(context, plan: plan),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
        decoration: BoxDecoration(
          color: gc.accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: gc.accent.withValues(alpha: 0.28)),
        ),
        child: Row(
          children: [
            FoodPlate(items: _plateOf(plan.items), size: 52),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.planToday.toUpperCase(),
                    style: AppTheme.f(9.5, weight: FontWeight.w800, color: gc.accent, letterSpacing: 1),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    plan.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      for (var i = 0; i < p.total; i++)
                        Container(
                          width: 14,
                          height: 4,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: i < p.done ? gc.sage : gc.border,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${p.done}/${p.total}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (left > 0)
              Pressable(
                scale: 0.94,
                onTap: () {
                  final n = fit.logPlanDay(plan);
                  HapticFeedback.lightImpact();
                  showNotchToast(
                    context,
                    t.planLogged(n),
                    icon: PhosphorIconsFill.checkCircle,
                    accent: gc.sage,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
                  decoration: BoxDecoration(color: gc.accent, borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    t.planLogRest,
                    style: AppTheme.f(12, weight: FontWeight.w800, color: gc.onEmber),
                  ),
                ),
              )
            else
              Icon(PhosphorIconsFill.checkCircle, size: 22, color: gc.sage),
          ],
        ),
      ),
    );
  }
}

class _PlannedMeal extends StatelessWidget {
  const _PlannedMeal({required this.plan, required this.meal});

  final MealPlan plan;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final items = plan.itemsOf(meal);
    final kcal = items.fold(Macros.zero, (s, e) => s + e.total).kcal;
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: gc.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: gc.accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          FoodPlate(items: _plateOf(items), size: 44),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.fromPlan(plan.name),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(13, weight: FontWeight.w800, color: gc.text),
                ),
                Text(
                  '${t.recipeItems(items.length)} · ${_energy(kcal)}',
                  style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
                ),
              ],
            ),
          ),
          Pressable(
            scale: 0.94,
            onTap: () {
              HapticFeedback.lightImpact();
              fit.logPlanMeal(plan, meal);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(color: gc.accent, borderRadius: BorderRadius.circular(100)),
              child: Text(
                t.logPlan,
                style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.onEmber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
