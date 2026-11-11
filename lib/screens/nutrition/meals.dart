part of '../nutrition_screen.dart';

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Row(children: [
      Expanded(
        child: Pressable(
          onTap: () => showAddFoodSheet(context, fit.defaultMeal, focus: true),
          scale: 0.98,
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: gc.bgRaised,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: gc.border),
            ),
            child: Row(children: [
              Icon(PhosphorIconsBold.magnifyingGlass, size: 17, color: gc.textSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(t.searchFoodsPrompt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.textTertiary)),
              ),
            ]),
          ),
        ),
      ),
      const SizedBox(width: 10),
      RoundAction(
        label: t.newFood,
        size: 52,
        onTap: () => showFoodEditor(context),
        child: Icon(PhosphorIconsBold.plus, size: 20, color: gc.text),
      ),
    ]);
  }
}

class _FoodShelf extends StatelessWidget {
  const _FoodShelf();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final seen = <String>{};
    final foods = [
      for (final f in [...fit.foodsByUse.take(8), ...fit.recentLibraryFoods])
        if (seen.add(f.id)) f,
    ];
    if (foods.isEmpty) {
      return Pressable(
        onTap: () => showAddFoodSheet(context, fit.defaultMeal),
        scale: 0.98,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: gc.border),
          ),
          child: Row(children: [
            SizedBox(
              width: 112,
              height: 56,
              child: Stack(children: [
                for (final (i, c) in [FoodCat.fruit, FoodCat.meat, FoodCat.grain].indexed)
                  Positioned(left: i * 30.0, child: FoodSticker(photo: catPhoto(c), name: catName(c), size: 54)),
              ]),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(t.shelfEmpty, style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.4))),
          ]),
        ),
      );
    }
    return SizedBox(
      height: 112,
      child: ListView.separated(
        key: const PageStorageKey('h-meals-86'),
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: foods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, i) => _ShelfItem(food: foods[i]),
      ),
    );
  }
}

class _Folders extends StatelessWidget {
  const _Folders();

  @override
  Widget build(BuildContext context) {
    final favs = fit.favoriteFoodItems;
    final meals = fit.activeRecipes;
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
        child: HomeFolder(
          title: t.favouritesOnly,
          detail: favs.isEmpty ? t.favFoodsHint : t.recipeItems(favs.length),
          peek: _StickerPeek(
            photos: [for (final f in favs.take(3)) (f.photo, f.name)],
            empty: PhosphorIconsFill.star,
          ),
          onTap: () => showFavoritesSheet(context),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: HomeFolder(
          title: t.savedMeals,
          detail: meals.isEmpty ? t.dishNew : t.savedMealsCount(meals.length),
          peek: _StickerPeek(
            photos: [
              for (final r in meals.take(3))
                for (final p in _plateOf(r.items).take(meals.length == 1 ? 3 : meals.length == 2 ? 2 : 1)) p,
            ].take(3).toList(),
            empty: PhosphorIconsFill.cookingPot,
          ),
          onTap: () => showSavedMealsSheet(context),
        ),
      ),
    ]);
  }
}

Future<void> showFavoritesSheet(BuildContext context) => _sheet<void>(context, (context) {
      final gc = context.gc;
      return AnimatedBuilder(
        animation: fit,
        builder: (context, _) {
          final favs = fit.favoriteFoodItems;
          return _sheetFrame(context, [
            SheetTitle(t.favouritesOnly),
            const SizedBox(height: 16),
            if (favs.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Column(children: [
                  Icon(PhosphorIconsRegular.star, size: 30, color: gc.textTertiary),
                  const SizedBox(height: 10),
                  Text(t.favFoodsEmpty,
                      textAlign: TextAlign.center, style: AppTheme.s(13, color: gc.textSecondary, height: 1.45)),
                ]),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.66,
                ),
                itemCount: favs.length,
                itemBuilder: (_, i) => _FoodTile(
                  food: favs[i],
                  onTap: () async {
                    final done = await showLogFoodSheet(context, favs[i], fit.defaultMeal);
                    if (done == true && context.mounted) Navigator.of(context).pop();
                  },
                  onLongPress: () async {
                    final done = await showFoodInfoSheet(context, favs[i], fit.defaultMeal);
                    if (done == true && context.mounted) Navigator.of(context).pop();
                  },
                ),
              ),
            const SizedBox(height: 14),
            GhostButton(
              label: t.searchFoodsPrompt,
              icon: PhosphorIconsBold.magnifyingGlass,
              onTap: () {
                Navigator.of(context).pop();
                showAddFoodSheet(context, fit.defaultMeal);
              },
            ),
          ]);
        },
      );
    });

Future<void> showSavedMealsSheet(BuildContext context) => _sheet<void>(context, (context) {
      final gc = context.gc;
      Widget recipeRow(Recipe r) => _FoodRow(
            leading: FoodPlate(items: _plateOf(r.items), size: 40, photo: r.photo),
            title: r.name,
            detail: '${_energy(r.total.kcal)} · ${t.recipeItems(r.items.length)}',
            onTap: () async {
              final done = await showRecipeSheet(context, r, fit.defaultMeal);
              if (done == true && context.mounted) Navigator.of(context).pop();
            },
          );
      return AnimatedBuilder(
        animation: fit,
        builder: (context, _) => _sheetFrame(context, [
          SheetTitle(t.savedMeals),
          const SizedBox(height: 16),
          _FoodRow(
            leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: gc.accent.withValues(alpha: 0.14), shape: BoxShape.circle),
              child: Icon(PhosphorIconsBold.cookingPot, size: 17, color: gc.accent),
            ),
            title: t.dishNew,
            detail: t.dishNewHint,
            onTap: () {
              Navigator.of(context).pop();
              showDishEditor(context, meal: fit.defaultMeal);
            },
          ),
          for (final r in fit.activeRecipes) recipeRow(r),
          if (fit.archivedRecipes.isNotEmpty)
            _ArchivedFold(
              count: fit.archivedRecipes.length,
              open: fit.showArchivedRecipes,
              onToggle: fit.toggleArchivedRecipes,
              child: Column(children: [for (final r in fit.archivedRecipeList) recipeRow(r)]),
            ),
          if (fit.recipes.isEmpty) ...[
            const SizedBox(height: 10),
            Text(t.savedMealsEmpty,
                textAlign: TextAlign.center, style: AppTheme.s(12.5, color: gc.textTertiary, height: 1.45)),
          ],
        ]),
      );
    });

class _ShelfItem extends StatelessWidget {
  const _ShelfItem({required this.food});

  final FoodItem food;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: () => showLogFoodSheet(context, food, fit.defaultMeal),
      onLongPress: () => showFoodInfoSheet(context, food, fit.defaultMeal),
      scale: 0.93,
      child: SizedBox(
        width: 80,
        child: Column(children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
            alignment: Alignment.center,
            child: FoodSticker(photo: food.photo, name: food.name, size: 62),
          ),
          const SizedBox(height: 7),
          Text(food.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary)),
        ]),
      ),
    );
  }
}

class _MealTabs extends StatefulWidget {
  const _MealTabs();

  @override
  State<_MealTabs> createState() => _MealTabsState();
}

class _MealTabsState extends State<_MealTabs> {
  Meal? _visible;
  final _keys = <Meal, GlobalKey>{};

  final _scroll = ScrollController();

  @override
  void dispose() {
    fit.pickedMeal = null;
    _scroll.dispose();
    super.dispose();
  }

  void _reveal(Meal meal) {
    if (_visible == meal) return;
    final first = _visible == null;
    _visible = meal;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _keys[meal]?.currentContext?.findRenderObject() as RenderBox?;
      final bar = context.findRenderObject() as RenderBox?;
      if (!mounted || box == null || bar == null || !_scroll.hasClients) return;
      final x = box.localToGlobal(Offset.zero, ancestor: bar).dx + _scroll.offset;
      final target = (x + box.size.width / 2 - bar.size.width / 2).clamp(0.0, _scroll.position.maxScrollExtent);
      if (first) {
        _scroll.jumpTo(target);
      } else {
        _scroll.animateTo(target, duration: const Duration(milliseconds: 260), curve: Curves.easeOutCubic);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final entries = fit.entriesOn(fit.nutritionDay);
    final meals = fit.mealsShown;
    final meal = fit.openMeal;
    _reveal(meal);
    int count(Meal m) => entries.where((e) => e.meal == m).length;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SingleChildScrollView(
        controller: _scroll,
        key: const PageStorageKey('h-meals-322'),
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          for (final m in meals) ...[
            GestureDetector(
              key: _keys.putIfAbsent(m, GlobalKey.new),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.selectionClick();
                fit.pickMeal(m);
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: m == meal
                      ? AppTheme.f(21, weight: FontWeight.w800, color: gc.text)
                      : AppTheme.f(16, weight: FontWeight.w700, color: gc.textTertiary),
                  child: Text(mealName(m)),
                ),
                if (count(m) > 0 && m != meal)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 3),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: gc.accent, shape: BoxShape.circle),
                    ),
                  ),
              ]),
            ),
            const SizedBox(width: 18),
          ],
        ]),
      ),
      const SizedBox(height: 14),
      _MealCard(meal: meal),
    ]);
  }
}

class _MealCard extends StatelessWidget {
  const _MealCard({required this.meal, this.compact = false});

  final Meal meal;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final entries = fit.entriesOn(fit.nutritionDay);
    final shown = [
      for (final e in entries)
        if (e.meal == meal) e,
    ];
    final total = shown.fold(Macros.zero, (s, e) => s + e.total);
    final plate = compact ? 76.0 : 112.0;
    return SoftCard(
      radius: 26,
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (compact)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 2, bottom: 8),
            child: Row(children: [
              Expanded(child: Text(mealName(meal), style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text))),
              _roundIcon(PhosphorIconsBold.dotsThree, gc.textSecondary, () => showMealMenu(context, meal, shown), label: t.mealOptions),
            ]),
          ),
        Row(children: [
          Pressable(
            onTap: () => showAddFoodSheet(context, meal),
            scale: 0.96,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: shown.isEmpty
                  ? SizedBox(
                      key: const ValueKey('empty'),
                      width: plate,
                      height: plate,
                      child: Stack(alignment: Alignment.center, children: [
                        FoodPlate(items: const [], size: plate),
                        Icon(PhosphorIconsBold.plus, size: 24, color: gc.textTertiary),
                      ]),
                    )
                  : FoodPlate(
                      key: ValueKey(shown.length),
                      items: [for (final e in shown.reversed) (fit.photoForEntry(e), e.name)],
                      size: plate,
                    ),
            ),
          ),
          SizedBox(width: compact ? 12 : 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Ltr(child: Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                RollingText('${fit.energyOf(total.kcal)}',
                    style: AppTheme.f(compact ? 24 : 30, weight: FontWeight.w800, color: gc.text, height: 1.2)),
                const SizedBox(width: 5),
                Text(fit.energyUnit, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
              ])),
              const SizedBox(height: 4),
              Text(
                shown.isEmpty ? t.nothingLogged : t.recipeItems(shown.length),
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary),
              ),
              const SizedBox(height: 10),
              Wrap(spacing: 6, runSpacing: 6, children: [
                _MacroPill(t.proteinLetter, total.protein, gc.protein),
                _MacroPill(t.carbsLetter, total.carbs, gc.carbs),
                _MacroPill(t.fatLetter, total.fat, gc.fat),
              ]),
            ]),
          ),
          if (!compact)
          Align(
            alignment: Alignment.topRight,
            child: _roundIcon(PhosphorIconsBold.dotsThree, gc.textSecondary, () => showMealMenu(context, meal, shown),
                label: t.mealOptions),
          ),
        ]),
        if (shown.isEmpty && fit.trackerOn(Tracker.plans) && (fit.planOn(fit.nutritionDay)?.itemsOf(meal).isNotEmpty ?? false))
          _PlannedMeal(plan: fit.planOn(fit.nutritionDay)!, meal: meal),
        if (shown.isNotEmpty) ...[
          const SizedBox(height: 14),
          _EntryList(entries: shown),
          const SizedBox(height: 8),
        ],
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: PrimaryButton(
              label: compact ? t.addShort : t.addToMeal(mealInSentence(meal)),
              height: compact ? 46 : 52,
              onTap: () => showAddFoodSheet(context, meal),
            ),
          ),
          const SizedBox(width: 10),
          RoundAction(
            label: t.quickAdd,
            size: compact ? 44 : 50,
            onTap: () => showQuickAddSheet(context, meal),
            child: Icon(PhosphorIconsBold.lightning, size: 19, color: gc.warn),
          ),
        ]),
      ]),
    );
  }
}

class _MealGrid extends StatelessWidget {
  const _MealGrid();

  @override
  Widget build(BuildContext context) {
    final meals = fit.mealsShown;
    return LayoutBuilder(builder: (context, box) {
      final n = (box.maxWidth / 250).floor().clamp(1, meals.length);
      final rows = <Widget>[];
      for (var i = 0; i < meals.length; i += n) {
        if (i > 0) rows.add(const SizedBox(height: 16));
        rows.add(IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            for (var k = 0; k < n; k++) ...[
              if (k > 0) const SizedBox(width: 16),
              Expanded(child: i + k < meals.length ? _MealCard(meal: meals[i + k], compact: true) : const SizedBox.shrink()),
            ],
          ]),
        ));
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
    });
  }
}

Future<void> showMealMenu(BuildContext context, Meal meal, List<FoodEntry> shown) => _sheet<void>(context, (context) {
      final gc = context.gc;
      final days = fit.daysWithMeal(meal);
      final dayList = fit.entriesOn(fit.nutritionDay).isEmpty ? fit.daysWithMeal(null, max: 3) : const <DateTime>[];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = shiftDays(today, -1);
      String dayName(DateTime d) => d == today
          ? t.nutritionToday
          : d == yesterday
              ? t.nutritionYesterday
              : t.longDate(d);
      return _sheetFrame(context, [
        SheetTitle(mealName(meal)),
        const SizedBox(height: 16),
        if (shown.isNotEmpty) ...[
          GhostButton(
            label: t.saveAsMeal,
            icon: PhosphorIconsBold.bookmarkSimple,
            onTap: () async {
              final name = await askText(context, title: t.saveAsMeal, hint: t.savedMealNameHint);
              if (name == null || !context.mounted) return;
              final r = fit.saveRecipe(name, shown);
              if (r == null) return;
              Navigator.of(context).pop();
              showNotchToast(context, t.savedMealToast,
                  subtitle: r.name, icon: PhosphorIconsFill.cookingPot, accent: gc.warn);
            },
          ),
          const SizedBox(height: 18),
          _kicker(gc, t.mealMoveTo.toUpperCase()),
          const SizedBox(height: 8),
          _MealPicker(
            value: meal,
            onPick: (to) {
              final moved = fit.moveMeal(meal, to);
              Navigator.of(context).pop();
              if (moved.isEmpty) return;
              HapticFeedback.lightImpact();
              showNotchToast(
                context,
                t.movedMealToast(moved.length),
                subtitle: mealName(to),
                icon: PhosphorIconsFill.arrowsLeftRight,
                accent: gc.accent,
                action: t.undo,
                onTap: () => fit.moveEntries(moved, meal),
              );
            },
          ),
          const SizedBox(height: 18),
        ],
        _kicker(gc, t.repeatFrom.toUpperCase()),
        const SizedBox(height: 8),
        if (days.isEmpty)
          Text(t.repeatNone, style: AppTheme.s(13, color: gc.textTertiary))
        else
          OptionGroup([
            for (final d in days)
              OptionItem(
                dayName(d),
                icon: PhosphorIconsRegular.copy,
                detail: _energy(fit.entriesOn(d).where((e) => e.meal == meal).fold(0.0, (s, e) => s + e.total.kcal)),
                onTap: () {
                  final added = fit.copyMeal(d, meal);
                  Navigator.of(context).pop();
                  if (added.isEmpty) return;
                  HapticFeedback.lightImpact();
                  showNotchToast(
                    context,
                    t.copiedMealToast(added.length),
                    subtitle: mealName(meal),
                    icon: PhosphorIconsFill.copy,
                    accent: gc.accent,
                    action: t.undo,
                    onTap: () {
                      for (final e in added) {
                        fit.removeEntry(e.id);
                      }
                    },
                  );
                },
              ),
          ]),
        if (dayList.isNotEmpty) ...[
          const SizedBox(height: 18),
          _kicker(gc, t.repeatWholeDay.toUpperCase()),
          const SizedBox(height: 8),
          OptionGroup([
            for (final d in dayList)
              OptionItem(
                dayName(d),
                icon: PhosphorIconsRegular.calendarDots,
                detail: _energy(fit.totalOn(d).kcal),
                onTap: () {
                  final added = fit.copyDay(d);
                  Navigator.of(context).pop();
                  if (added.isEmpty) return;
                  HapticFeedback.lightImpact();
                  showNotchToast(
                    context,
                    t.copiedMealToast(added.length),
                    subtitle: dayName(d),
                    icon: PhosphorIconsFill.copy,
                    accent: gc.accent,
                    action: t.undo,
                    onTap: () {
                      for (final e in added) {
                        fit.removeEntry(e.id);
                      }
                    },
                  );
                },
              ),
          ]),
        ],
        if (shown.isNotEmpty) ...[
          const SizedBox(height: 14),
          Center(
            child: TextButton(
              onPressed: () {
                final gone = fit.clearMeal(meal);
                Navigator.of(context).pop();
                if (gone.isEmpty) return;
                showNotchToast(
                  context,
                  t.mealCleared,
                  subtitle: mealName(meal),
                  icon: PhosphorIconsRegular.trash,
                  accent: gc.danger,
                  action: t.undo,
                  onTap: () => fit.restoreEntries(gone),
                );
              },
              child: Text(t.mealClear, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger)),
            ),
          ),
        ],
      ]);
    });

Future<bool?> showRecipeSheet(BuildContext context, Recipe recipe, Meal meal) =>
    _sheet<bool>(context, (_) => _RecipeSheet(recipe: recipe, meal: meal));

class _RecipeSheet extends StatefulWidget {
  const _RecipeSheet({required this.recipe, required this.meal});

  final Recipe recipe;
  final Meal meal;

  @override
  State<_RecipeSheet> createState() => _RecipeSheetState();
}

class _RecipeSheetState extends State<_RecipeSheet> {
  late Meal _meal = widget.meal;
  double _factor = 1;
  late final bool _own = fit.isOwnRecipe(widget.recipe.id);
  late List<FoodEntry> _items = [...widget.recipe.items];

  Recipe get _recipe => fit.recipes.firstWhere((x) => x.id == widget.recipe.id, orElse: () => widget.recipe);

  void _set(List<FoodEntry> items) {
    setState(() => _items = items);
    if (_own) fit.updateRecipe(widget.recipe.id, items);
  }

  void _edit(int i) {
    final e = _items[i];
    final food = fit.foodById(e.foodId);
    if (food == null) return;
    showLogFoodSheet(context, food, _meal, initial: e, onPick: (n) {
      if (!mounted) return;
      _set([..._items]..[i] = n.copyWith(id: e.id));
    });
  }

  void _add() => showAddFoodSheet(context, _meal, onPick: (n) {
        if (mounted) _set([..._items, n]);
      });

  Future<void> _saveCopy() async {
    final name = await askText(context, title: t.saveAsMeal, hint: t.savedMealNameHint, initial: _recipe.name);
    if (name == null || !mounted) return;
    final r = fit.saveRecipe(name, _items);
    if (r == null) return;
    Navigator.of(context).pop();
    showNotchToast(context, t.savedMealToast, subtitle: r.name, icon: PhosphorIconsFill.cookingPot, accent: context.gc.warn);
  }

  Future<void> _pickPhoto() async {
    final id = widget.recipe.id;
    final saved = await _pickRecipePhoto(context, _recipe.photo.isEmpty
            ? null
            : () {
                fit.setRecipePhoto(id, '');
                if (mounted) setState(() {});
              });
    if (saved == null) return;
    if (!mounted || !fit.isOwnRecipe(id)) {
      MediaStore.delete(saved);
      return;
    }
    fit.setRecipePhoto(id, saved);
    setState(() {});
  }

  Future<void> _delete() async {
    final r = _recipe;
    final ok = await askConfirm(context,
        title: t.deleteFoodTitle(r.name), body: t.deleteSavedMealBody, confirmLabel: t.delete, danger: true);
    if (!ok || !mounted) return;
    fit.deleteRecipe(r.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final r = _recipe;
    final items = _items;
    final total = items.fold(Macros.zero, (s, e) => s + e.total);
    return _sheetFrame(context, [
      Center(
        child: _own
            ? _PhotoPlate(items: items, photo: r.photo, size: 128, onTap: _pickPhoto)
            : FoodPlate(items: _plateOf(items), size: 128, photo: r.photo),
      ),
      const SizedBox(height: 14),
      SheetTitle(r.name, subtitle: t.recipeItems(items.length)),
      const SizedBox(height: 18),
      _macroSummary(context, total * _factor),
      const SizedBox(height: 12),
      for (var i = 0; i < items.length; i++)
        Pressable(
          onTap: () => _edit(i),
          scale: 0.98,
          child: Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              FoodSticker(photo: fit.photoForEntry(items[i]), name: items[i].name, size: 36, tilt: false, shadow: false),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(items[i].name.isEmpty ? t.quickAdd : items[i].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
                  Text(
                    [
                      _servingLine(items[i].copyWith(servings: items[i].servings * _factor), fit.foodById(items[i].foodId)),
                      _energy(items[i].total.kcal * _factor),
                    ].where((x) => x.isNotEmpty).join(' · '),
                    style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
                  ),
                ]),
              ),
              if (items.length > 1)
                IconButton(
                  onPressed: () => _set([...items]..removeAt(i)),
                  icon: Icon(PhosphorIconsBold.x, size: 15, color: gc.textTertiary),
                )
              else
                const SizedBox(width: 12),
            ]),
          ),
        ),
      GhostButton(label: t.prepAddIngredient, icon: PhosphorIconsBold.plus, onTap: _add),
      const SizedBox(height: 12),
      ToolRow(
        label: t.servingsLabel,
        control: StepperControl(
          value: fmt(_factor),
          onDec: () => setState(() => _factor = (_factor - 0.5).clamp(0.25, 10)),
          onInc: () => setState(() => _factor = (_factor + 0.5).clamp(0.25, 10)),
          onEdit: () async {
            final v = await askNumber(context, title: t.servingsLabel, initial: fmt(_factor), decimal: true);
            if (v != null && v > 0 && mounted) setState(() => _factor = v.clamp(0.1, 20).toDouble());
          },
        ),
      ),
      const SizedBox(height: 12),
      _MealPicker(value: _meal, onPick: (m) => setState(() => _meal = m)),
      const SizedBox(height: 18),
      PrimaryButton(
        label: t.logFood,
        onTap: () {
          final added = fit.logRecipe(Recipe(id: r.id, name: r.name, items: items), meal: _meal, factor: _factor);
          Navigator.of(context).pop(true);
          if (added.isEmpty) return;
          HapticFeedback.lightImpact();
          showNotchToast(
            context,
            t.loggedToast(mealInSentence(_meal)),
            subtitle: r.name,
            icon: PhosphorIconsFill.forkKnife,
            accent: context.gc.accent,
            action: t.undo,
            onTap: () {
              for (final e in added) {
                fit.removeEntry(e.id);
              }
            },
          );
        },
      ),
      const SizedBox(height: 8),
      if (!_own)
        Center(
          child: TextButton(
            onPressed: _saveCopy,
            child: Text(t.saveAsMeal, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
          ),
        )
      else
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showDishEditor(context, recipe: _recipe, meal: _meal);
            },
            child: Text(t.dishEdit, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              final on = !fit.isRecipeArchived(r.id);
              fit.setRecipeArchived(r.id, on);
              Navigator.of(context).pop();
              if (on) {
                showNotchToast(context, t.dishArchivedToast,
                    subtitle: r.name,
                    icon: PhosphorIconsFill.archive,
                    accent: gc.textSecondary,
                    action: t.undo,
                    onTap: () => fit.setRecipeArchived(r.id, false));
              }
            },
            child: Text(fit.isRecipeArchived(r.id) ? t.dishUnarchive : t.dishArchive,
                style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: _delete,
            child: Text(t.delete, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger)),
          ),
        ]),
    ]);
  }
}

class _MacroPill extends StatelessWidget {
  const _MacroPill(this.letter, this.value, this.color);

  final String letter;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 3, 8, 3),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 15,
          height: 15,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.22), shape: BoxShape.circle),
          child: Text(letter, style: AppTheme.f(8.5, weight: FontWeight.w900, color: color)),
        ),
        const SizedBox(width: 4),
        Text('${value.round()}g', style: AppTheme.f(11, weight: FontWeight.w700, color: gc.text)),
      ]),
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry});

  final FoodEntry entry;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final food = fit.foodById(entry.foodId);
    final total = entry.total;
    final line = _servingLine(entry, food);
    final name = entry.name.isEmpty ? t.quickAdd : entry.name;
    return Dismissible(
      key: ValueKey('entry-${entry.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsetsDirectional.only(end: 22),
        decoration: BoxDecoration(color: gc.danger.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(20)),
        child: Icon(PhosphorIconsBold.trash, size: 18, color: gc.danger),
      ),
      onDismissed: (_) {
        HapticFeedback.mediumImpact();
        final gone = fit.removeEntry(entry.id);
        if (gone == null) return;
        showNotchToast(
          context,
          t.entryRemoved,
          subtitle: name,
          icon: PhosphorIconsRegular.trash,
          accent: gc.danger,
          action: t.undo,
          onTap: () => fit.restoreEntry(gone),
        );
      },
      child: Pressable(
        onTap: () => showEntrySheet(context, entry),
        scale: 0.98,
        child: Container(
          height: _EntryList.rowHeight,
          padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
          child: Row(children: [
            SizedBox(
              width: 50,
              child: Center(
                child: entry.foodId.isEmpty
                    ? Icon(PhosphorIconsBold.lightning, size: 18, color: gc.warn)
                    : fit.batchOfEntry(entry) != null
                        ? FoodPlate(items: _plateOf(fit.batchOfEntry(entry)!.items), size: 46)
                        : FoodSticker(photo: fit.photoForEntry(entry), name: entry.name, size: 46, tilt: false),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(children: [
                    if (line.isNotEmpty) TextSpan(text: '$line  '),
                    for (final (letter, value, color) in [
                      (t.proteinLetter, total.protein, gc.protein),
                      (t.carbsLetter, total.carbs, gc.carbs),
                      (t.fatLetter, total.fat, gc.fat),
                    ]) ...[
                      TextSpan(text: '$letter ', style: TextStyle(color: color, fontWeight: FontWeight.w800)),
                      TextSpan(text: '${value.round()}  '),
                    ],
                  ]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary),
                ),
              ]),
            ),
            const SizedBox(width: 8),
            Text(_energy(total.kcal), style: AppTheme.f(13, weight: FontWeight.w800, color: gc.text)),
          ]),
        ),
      ),
    );
  }
}

class _EntryList extends StatelessWidget {
  const _EntryList({required this.entries});

  final List<FoodEntry> entries;

  static const rowHeight = 62.0;
  static const gap = 6.0;
  static const maxRows = 8;

  @override
  Widget build(BuildContext context) => _CappedList(
        count: entries.length,
        itemBuilder: (_, i) => _EntryRow(entry: entries[i]),
        rowHeight: rowHeight,
        gap: gap,
        maxRows: maxRows,
        fade: context.gc.bgRaised,
      );
}

class _MealPicker extends StatelessWidget {
  const _MealPicker({required this.value, required this.onPick});

  final Meal value;
  final ValueChanged<Meal> onPick;

  @override
  Widget build(BuildContext context) {
    final meals = fit.mealsShown;
    if (!meals.contains(value)) meals.add(value);
    if (meals.length <= 4) {
      return Row(children: [
        for (final m in meals) Expanded(child: _chip(context, m)),
      ]);
    }
    return SingleChildScrollView(
      key: const PageStorageKey('h-meals-1000'),
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(children: [
        for (final m in meals) SizedBox(width: 82, child: _chip(context, m)),
      ]),
    );
  }

  Widget _chip(BuildContext context, Meal m) {
    final gc = context.gc;
    return Pressable(
      onTap: () => onPick(m),
      scale: 0.94,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: m == value ? gc.accentSoft : gc.bgRaised2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: m == value ? gc.accent.withValues(alpha: 0.6) : Colors.transparent),
        ),
        child: Column(children: [
          Icon(_mealIcon(m), size: 16, color: m == value ? gc.accent : gc.textSecondary),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(mealName(m),
                style: AppTheme.f(11, weight: FontWeight.w700, color: m == value ? gc.accent : gc.textSecondary)),
          ),
        ]),
      ),
    );
  }
}

Future<void> showDishEditor(BuildContext context, {Recipe? recipe, Meal? meal}) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _DishEditor(recipe: recipe, meal: meal ?? fit.defaultMeal),
    );

Future<String?> _pickRecipePhoto(BuildContext context, VoidCallback? onRemove) async {
  final source = await pickPhotoSource(context, onRemove: onRemove);
  if (source == null || !context.mounted) return null;
  final shot = await ImagePicker().pickImage(source: source, maxWidth: 1200, maxHeight: 1200, imageQuality: 86);
  if (shot == null) return null;
  return MediaStore.importFor('recipe', shot.path);
}

class _PhotoPlate extends StatelessWidget {
  const _PhotoPlate({required this.items, required this.photo, required this.size, required this.onTap, this.empty});

  final List<FoodEntry> items;
  final String photo;
  final double size;
  final VoidCallback onTap;
  final IconData? empty;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      label: t.addPhoto,
      child: Pressable(
        onTap: onTap,
        scale: 0.96,
        child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          FoodPlate(items: _plateOf(items), size: size, photo: photo),
          if (empty != null && photo.isEmpty) Icon(empty, size: 26, color: gc.textTertiary),
          PositionedDirectional(
            end: -4,
            bottom: 2,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: gc.bgRaised,
                shape: BoxShape.circle,
                border: Border.all(color: gc.border),
              ),
              child: Icon(PhosphorIconsRegular.camera, size: 16, color: gc.text),
            ),
          ),
        ]),
      ),
    );
  }
}

class _DishEditor extends StatefulWidget {
  const _DishEditor({this.recipe, required this.meal});

  final Recipe? recipe;
  final Meal meal;

  @override
  State<_DishEditor> createState() => _DishEditorState();
}

class _DishEditorState extends State<_DishEditor> {
  late final _name = TextEditingController(text: widget.recipe?.name ?? '');
  late List<FoodEntry> _items = [...?widget.recipe?.items];
  late String _photo = widget.recipe?.photo ?? '';
  late String _kept = _photo;
  final _fresh = <String>{};
  bool _dirty = false;

  bool get _own => widget.recipe != null && fit.isOwnRecipe(widget.recipe!.id);

  @override
  void dispose() {
    _name.dispose();
    for (final p in _fresh) {
      if (p != _kept) MediaStore.delete(p);
    }
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final saved = await _pickRecipePhoto(
        context,
        _photo.isEmpty
            ? null
            : () => setState(() {
                  _photo = '';
                  _dirty = true;
                }));
    if (saved == null) return;
    if (!mounted) {
      MediaStore.delete(saved);
      return;
    }
    setState(() {
      _photo = saved;
      _fresh.add(saved);
      _dirty = true;
    });
  }

  void _set(List<FoodEntry> items) => setState(() {
        _items = items;
        _dirty = true;
      });

  void _add() => showAddFoodSheet(context, widget.meal, onPick: (n) {
        if (mounted) _set([..._items, n.copyWith(id: fit.newPlanItemId())]);
      });

  void _edit(int i) {
    final e = _items[i];
    final food = fit.foodById(e.foodId);
    if (food == null) return;
    showLogFoodSheet(context, food, widget.meal, initial: e, onPick: (n) {
      if (mounted) _set([..._items]..[i] = n.copyWith(id: e.id));
    });
  }

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty || _items.isEmpty) {
      HapticFeedback.heavyImpact();
      showNotchToast(context, name.isEmpty ? t.dishNeedsName : t.dishNeedsItems,
          icon: PhosphorIconsFill.warningCircle, accent: context.gc.warn);
      return;
    }
    final r = widget.recipe;
    if (_own) {
      fit.updateRecipe(r!.id, _items);
      fit.renameRecipe(r.id, name);
      fit.setRecipePhoto(r.id, _photo);
    } else {
      fit.saveRecipe(name, _items, photo: _photo);
    }
    _kept = _photo;
    _dirty = false;
    HapticFeedback.lightImpact();
    Navigator.of(context).pop();
    showNotchToast(context, t.savedMealToast, subtitle: name, icon: PhosphorIconsFill.cookingPot, accent: context.gc.warn);
  }

  Future<void> _close() async {
    if (!_dirty) {
      Navigator.of(context).pop();
      return;
    }
    final ok = await askConfirm(context,
        title: t.planDiscardTitle, body: t.planDiscardBody, confirmLabel: t.planDiscard, danger: true);
    if (ok && mounted) {
      _dirty = false;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final media = MediaQuery.of(context);
    final total = _items.fold(Macros.zero, (s, e) => s + e.total);
    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _close();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
        child: Container(
          height: media.size.height * 0.88,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 14 + media.padding.bottom),
          decoration: sheetDecoration(gc),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SheetHandle(),
            const SizedBox(height: 10),
            Row(children: [
              RoundAction(
                label: t.cancel,
                onTap: _close,
                child: Icon(PhosphorIconsBold.x, size: 15, color: gc.textSecondary),
              ),
              Expanded(
                child: Text(_own ? t.dishEdit : t.dishNew,
                    textAlign: TextAlign.center, style: AppTheme.f(16, weight: FontWeight.w700, color: gc.text)),
              ),
              const SizedBox(width: 36),
            ]),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(padding: EdgeInsets.zero, children: [
                Center(
                  child: _PhotoPlate(
                    items: _items,
                    photo: _photo,
                    size: 120,
                    onTap: _pickPhoto,
                    empty: _items.isEmpty ? PhosphorIconsBold.cookingPot : null,
                  ),
                ),
                const SizedBox(height: 14),
                _TextInput(controller: _name, hint: t.dishNameHint, label: t.nameLabel),
                const SizedBox(height: 12),
                _macroSummary(context, total),
                const SizedBox(height: 16),
                _kicker(gc, t.dishIngredients.toUpperCase()),
                const SizedBox(height: 8),
                if (_items.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(t.dishEmptyHint, style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.4)),
                  ),
                for (var i = 0; i < _items.length; i++)
                  Pressable(
                    onTap: () => _edit(i),
                    scale: 0.98,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.fromLTRB(8, 6, 4, 6),
                      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                      child: Row(children: [
                        FoodSticker(
                            photo: fit.photoForEntry(_items[i]), name: _items[i].name, size: 36, tilt: false, shadow: false),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(_items[i].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
                            Text(
                              [_servingLine(_items[i], fit.foodById(_items[i].foodId)), _energy(_items[i].total.kcal)]
                                  .where((x) => x.isNotEmpty)
                                  .join(' · '),
                              style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
                            ),
                          ]),
                        ),
                        IconButton(
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            _set([..._items]..removeAt(i));
                          },
                          icon: Icon(PhosphorIconsBold.x, size: 15, color: gc.textTertiary),
                        ),
                      ]),
                    ),
                  ),
                Pressable(
                  scale: 0.98,
                  onTap: _add,
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: gc.border),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(PhosphorIconsBold.plus, size: 13, color: gc.accent),
                      const SizedBox(width: 6),
                      Text(t.prepAddIngredient, style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.accent)),
                    ]),
                  ),
                ),
                const SizedBox(height: 16),
              ]),
            ),
            const SizedBox(height: 10),
            PrimaryButton(label: t.dishSave, onTap: _save),
          ]),
        ),
      ),
    );
  }
}

class _ArchivedFold extends StatelessWidget {
  const _ArchivedFold({required this.count, required this.open, required this.onToggle, required this.child});

  final int count;
  final bool open;
  final VoidCallback onToggle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          onToggle();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 14, 4, 10),
          child: Row(children: [
            Expanded(child: SectionLabel('${t.archivedFilter} · $count')),
            AnimatedRotation(
              turns: open ? 0.5 : 0,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              child: Icon(PhosphorIconsBold.caretDown, size: 13, color: gc.textTertiary),
            ),
          ]),
        ),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: open ? Opacity(opacity: 0.6, child: child) : const SizedBox(width: double.infinity),
      ),
    ]);
  }
}
