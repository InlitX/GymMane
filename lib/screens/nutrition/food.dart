part of '../nutrition_screen.dart';

Future<void> showAddFoodSheet(
  BuildContext context,
  Meal meal, {
  ValueChanged<FoodEntry>? onPick,
  bool focus = false,
}) => _sheet<void>(context, (_) => _AddFoodSheet(meal: meal, onPick: onPick, focus: focus));

String catName(FoodCat c) => switch (c) {
  FoodCat.fruit => t.catFruit,
  FoodCat.veg => t.catVeg,
  FoodCat.meat => t.catMeat,
  FoodCat.fish => t.catFish,
  FoodCat.egg => t.catEgg,
  FoodCat.dairy => t.catDairy,
  FoodCat.grain => t.catGrain,
  FoodCat.bakery => t.catBakery,
  FoodCat.legume => t.catLegume,
  FoodCat.nut => t.catNut,
  FoodCat.oil => t.catOil,
  FoodCat.pantry => t.catPantry,
  FoodCat.drink => t.catDrink,
  FoodCat.sauce => t.catSauce,
  FoodCat.spice => t.catSpice,
};

const _catSlug = {
  FoodCat.fruit: 'banana',
  FoodCat.veg: 'broccoli',
  FoodCat.meat: 'chicken-breast',
  FoodCat.fish: 'salmon',
  FoodCat.egg: 'egg',
  FoodCat.dairy: 'greek-yogurt',
  FoodCat.grain: 'rolled-oats',
  FoodCat.bakery: 'bread',
  FoodCat.legume: 'lentils',
  FoodCat.nut: 'almonds',
  FoodCat.oil: 'olive-oil',
  FoodCat.pantry: 'honey',
  FoodCat.drink: 'orange-juice',
  FoodCat.sauce: 'ketchup',
  FoodCat.spice: 'cinnamon',
};

String catPhoto(FoodCat c) => 'asset:assets/food/${_catSlug[c]}.webp';

class _AddFoodSheet extends StatefulWidget {
  const _AddFoodSheet({required this.meal, this.onPick, this.focus = false});

  final Meal meal;
  final ValueChanged<FoodEntry>? onPick;
  final bool focus;

  @override
  State<_AddFoodSheet> createState() => _AddFoodSheetState();
}

class _AddFoodSheetState extends State<_AddFoodSheet> {
  final _query = TextEditingController();
  final _focus = FocusNode();
  FoodCat? _cat;
  bool _dishes = false;

  @override
  void initState() {
    super.initState();
    if (widget.focus) WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _closeIf(bool? done) {
    if (done == true && mounted) Navigator.of(context).pop();
  }

  Future<void> _open(FoodItem f) async =>
      _closeIf(await showLogFoodSheet(context, f, widget.meal, onPick: widget.onPick));

  Future<void> _info(FoodItem f) async =>
      _closeIf(await showFoodInfoSheet(context, f, widget.meal, onPick: widget.onPick));

  Future<void> _openRecipe(Recipe r) async {
    final pick = widget.onPick;
    if (pick == null) {
      _closeIf(await showRecipeSheet(context, r, widget.meal));
      return;
    }
    Navigator.of(context).pop();
    HapticFeedback.lightImpact();
    for (final e in r.items) {
      pick(e.copyWith(meal: widget.meal));
    }
  }

  Widget _section(GymColors gc, String title, {String? trailing}) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10, left: 2),
    child: Row(
      children: [
        Expanded(child: _kicker(gc, title.toUpperCase())),
        if (trailing != null)
          Text(
            trailing,
            style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textTertiary),
          ),
      ],
    ),
  );

  Widget _grid(List<FoodItem> foods, {bool quick = false}) => SliverGrid.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 10,
      childAspectRatio: 0.66,
    ),
    itemCount: foods.length,
    itemBuilder: (context, i) => _FoodTile(
      food: foods[i],
      onTap: () => quick ? _open(foods[i]) : _info(foods[i]),
      onLongPress: () => quick ? _info(foods[i]) : _open(foods[i]),
    ),
  );

  Widget _cats(GymColors gc) => SizedBox(
    height: 92,
    child: ListView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      children: [
        _catChip(
          gc,
          selected: _dishes,
          label: t.readyDishes,
          art: FoodPlate(
            items: [
              for (final s in const ['rice', 'chicken-breast', 'broccoli']) ('asset:assets/food/$s.webp', s),
            ],
            size: 50,
          ),
          onTap: () => setState(() {
            _dishes = !_dishes;
            _cat = null;
          }),
        ),
        const SizedBox(width: 6),
        for (final c in FoodCat.values) ...[
          Pressable(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _cat = _cat == c ? null : c;
                _dishes = false;
              });
            },
            scale: 0.93,
            child: SizedBox(
              width: 70,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: _cat == c ? gc.accentSoft : gc.bgRaised2,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _cat == c ? gc.accent.withValues(alpha: 0.75) : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: FoodSticker(
                      photo: catPhoto(c),
                      name: catName(c),
                      size: 46,
                      tilt: false,
                      shadow: false,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    catName(c),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(
                      11,
                      weight: FontWeight.w700,
                      color: _cat == c ? gc.accent : gc.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ],
    ),
  );

  Widget _catChip(
    GymColors gc, {
    required bool selected,
    required String label,
    required Widget art,
    required VoidCallback onTap,
  }) => Pressable(
    onTap: () {
      HapticFeedback.selectionClick();
      onTap();
    },
    scale: 0.93,
    child: SizedBox(
      width: 70,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: selected ? gc.accentSoft : gc.bgRaised2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? gc.accent.withValues(alpha: 0.75) : Colors.transparent,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: art,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(11, weight: FontWeight.w700, color: selected ? gc.accent : gc.textSecondary),
          ),
        ],
      ),
    ),
  );

  Widget _recipeRow(Recipe r) => _FoodRow(
    leading: FoodPlate(items: _plateOf(r.items), size: 40),
    title: r.name,
    detail: '${_energy(r.total.kcal)} · ${t.recipeItems(r.items.length)}',
    onTap: () => _openRecipe(r),
  );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final q = _query.text.trim();
    final picking = widget.onPick != null;
    final browsing = q.isNotEmpty || _cat != null || _dishes;
    final recipes = _cat != null ? const <Recipe>[] : fit.searchRecipes(q);
    final dishes = _cat != null || (q.isEmpty && !_dishes) ? const <Recipe>[] : fit.searchDishes(q);
    final mine = _cat != null || _dishes ? const <FoodItem>[] : fit.searchFoods(q);
    final library = [
      if (!_dishes)
        for (final f in FoodLibrary.search(
          q,
          appLanguage,
          cat: _cat,
          limit: _cat != null && q.isEmpty ? 200 : 60,
        ))
          f.item(appLanguage),
    ];
    final recents = browsing ? const <FoodItem>[] : fit.recentLibraryFoods;
    final nothing = browsing && recipes.isEmpty && dishes.isEmpty && mine.isEmpty && library.isEmpty;
    return _sheetSlivers(heightFactor: 0.92, context, [
      SheetTitle(picking ? t.prepAddIngredient : t.addToMeal(mealInSentence(widget.meal))),
      const SizedBox(height: 14),
      Row(
        children: [
          Expanded(
            child: _SearchInput(
              controller: _query,
              focus: _focus,
              hint: t.searchFoodsHint,
              onChanged: (_) => setState(() {}),
            ),
          ),
          if (!picking) ...[
            const SizedBox(width: 8),
            RoundAction(
              label: t.newFood,
              size: 48,
              onTap: () {
                Navigator.of(context).pop();
                showFoodEditor(context, name: q);
              },
              child: Icon(PhosphorIconsRegular.camera, size: 19, color: gc.text),
            ),
          ],
        ],
      ),
      const SizedBox(height: 14),
      _cats(gc),
      if (recipes.isNotEmpty || (!picking && _cat == null && q.isEmpty)) ...[
        _section(gc, t.savedMeals),
        if (!picking && _cat == null && q.isEmpty)
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
              showDishEditor(context, meal: widget.meal);
            },
          ),
        for (final r in recipes) _recipeRow(r),
      ],
      if (dishes.isNotEmpty) ...[
        _section(gc, t.readyDishes, trailing: _dishes && q.isEmpty ? '${dishes.length}' : null),
        for (final r in dishes) _recipeRow(r),
      ],
      if (mine.isNotEmpty) ...[_section(gc, t.myFoods), _grid(mine)],
      if (recents.isNotEmpty) ...[_section(gc, t.recentFoods), _grid(recents, quick: true)],
      if (library.isNotEmpty) ...[
        _section(gc, _cat == null ? t.foodDatabase : catName(_cat!), trailing: '${library.length}'),
        _grid(library),
      ],
      if (!browsing && recipes.isEmpty && mine.isEmpty && recents.isEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: Text(
            t.searchFoodsEmpty,
            textAlign: TextAlign.center,
            style: AppTheme.s(13, color: gc.textSecondary, height: 1.45),
          ),
        ),
      if (nothing)
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Column(
            children: [
              Text(
                t.searchFoodsNone(q),
                textAlign: TextAlign.center,
                style: AppTheme.s(13, color: gc.textSecondary, height: 1.45),
              ),
              if (!picking && q.isNotEmpty) ...[
                const SizedBox(height: 14),
                PrimaryButton(
                  label: t.createFoodNamed(q),
                  height: 50,
                  onTap: () {
                    Navigator.of(context).pop();
                    showFoodEditor(context, name: q);
                  },
                ),
              ],
            ],
          ),
        ),
      const SizedBox(height: 18),
      if (!picking)
        GhostButton(
          label: t.quickAdd,
          icon: PhosphorIconsBold.lightning,
          onTap: () {
            Navigator.of(context).pop();
            showQuickAddSheet(context, widget.meal);
          },
        ),
    ]);
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput({
    required this.controller,
    required this.focus,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focus;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 16, right: 6),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          Icon(PhosphorIconsBold.magnifyingGlass, size: 16, color: gc.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focus,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text),
              cursorColor: gc.accent,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.textTertiary),
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, v, _) => v.text.isEmpty
                ? const SizedBox(width: 10)
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.clear();
                      onChanged('');
                    },
                    child: SizedBox(
                      width: 38,
                      height: 48,
                      child: Icon(PhosphorIconsBold.xCircle, size: 18, color: gc.textTertiary),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FoodTile extends StatelessWidget {
  const _FoodTile({required this.food, required this.onTap, this.onLongPress});

  final FoodItem food;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final f = food;
    return Pressable(
      onTap: onTap,
      onLongPress: onLongPress,
      scale: 0.94,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.all(9),
              child: LayoutBuilder(
                builder: (context, c) =>
                    FoodSticker(photo: f.photo, name: f.name, size: c.maxWidth, tilt: false, shadow: false),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            f.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.text, height: 1.2),
          ),
          const SizedBox(height: 2),
          Text(
            '${f.approx ? '≈ ' : ''}${_energy(f.macros.kcal)}${f.isLibrary ? ' · 100 ${_unitOf(f.liquid)}' : ''}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textTertiary),
          ),
        ],
      ),
    );
  }
}

class _FoodRow extends StatelessWidget {
  const _FoodRow({required this.leading, required this.title, required this.detail, required this.onTap});

  final Widget leading;
  final String title;
  final String detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: onTap,
      scale: 0.98,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.fromLTRB(10, 9, 12, 9),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            SizedBox(width: 38, height: 38, child: Center(child: leading)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(PhosphorIconsBold.plus, size: 15, color: gc.accent),
          ],
        ),
      ),
    );
  }
}

Future<bool?> showFoodInfoSheet(
  BuildContext context,
  FoodItem food,
  Meal meal, {
  ValueChanged<FoodEntry>? onPick,
}) => _sheet<bool>(context, (_) => _FoodInfoSheet(food: food, meal: meal, onPick: onPick));

class _FoodInfoSheet extends StatelessWidget {
  const _FoodInfoSheet({required this.food, required this.meal, this.onPick});

  final FoodItem food;
  final Meal meal;
  final ValueChanged<FoodEntry>? onPick;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final f = food;
    final m = f.macros;
    final unit = _unitOf(f.liquid);
    final picking = onPick != null;
    final per100 = f.isLibrary || f.grams == 100;
    final split = [
      (m.protein * 4, gc.protein, t.macroProtein),
      (m.carbs * 4, gc.carbs, t.macroCarbs),
      (m.fat * 9, gc.fat, t.macroFat),
    ];
    final sum = split.fold(0.0, (s, p) => s + p.$1);
    Widget legend((double, Color, String) p) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: p.$2, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  sentenceCase(p.$3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            sum <= 0 ? '—' : '${(p.$1 / sum * 100).round()} %',
            style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text),
          ),
        ],
      ),
    );
    Widget fact(IconData icon, String label, String value) => Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.fromLTRB(14, 12, 16, 12),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: gc.textSecondary),
          const SizedBox(width: 10),
          Text(
            label,
            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTheme.f(13.5, weight: FontWeight.w800, color: gc.text),
            ),
          ),
        ],
      ),
    );
    return _sheetFrame(context, [
      _FoodHero(photo: f.photo, name: f.name, favId: f.id),
      const SizedBox(height: 6),
      SheetTitle(
        f.name,
        subtitle: [
          if (f.cat != null) catName(f.cat!),
          if (per100) t.per100Line(_energy(m.kcal), unit) else if (f.serving.isNotEmpty) f.serving,
        ].join(' · '),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kicker(gc, t.energySplit.toUpperCase()),
            const SizedBox(height: 12),
            _SplitBar(parts: [for (final p in split) (p.$1, p.$2)]),
            const SizedBox(height: 12),
            Row(children: [for (final p in split) legend(p)]),
          ],
        ),
      ),
      if (f.isLibrary && f.portion != null && f.portionGrams > 0)
        fact(
          PhosphorIconsBold.forkKnife,
          t.typicalServing,
          '${portionName(f.portion!)} · ${f.portionGrams.round()} $unit · ${_energy(m.kcal * f.portionGrams / f.grams)}',
        ),
      if (f.canCook) fact(PhosphorIconsBold.cookingPot, t.cookedLabel, t.cookedYieldLine(fmt(f.cookedYield))),
      const SizedBox(height: 12),
      _ValueRows(
        per: m,
        title: per100 ? t.per100(unit) : t.perServingShort,
        approx: f.approx,
        onEdit: picking
            ? null
            : () {
                Navigator.of(context).pop();
                showFoodEditor(
                  context,
                  food: f.isLibrary ? null : f,
                  from: f.isLibrary ? f : null,
                  meal: meal,
                );
              },
      ),
      if (m.fat >= 1 && m.sat + m.mono + m.poly > 0) ...[const SizedBox(height: 12), _FatTypesCard(of: m)],
      if (m.protein >= 5 && m.aminoScores.isNotEmpty) ...[const SizedBox(height: 12), _QualityCard(of: m)],
      const SizedBox(height: 18),
      PrimaryButton(
        label: picking ? t.prepAddIngredient : t.addToMeal(mealInSentence(meal)),
        onTap: () async {
          final done = await showLogFoodSheet(context, f, meal, onPick: onPick);
          if (done == true && context.mounted) Navigator.of(context).pop(true);
        },
      ),
    ]);
  }
}

Future<bool?> showLogFoodSheet(
  BuildContext context,
  FoodItem food,
  Meal meal, {
  ValueChanged<FoodEntry>? onPick,
  FoodEntry? initial,
}) => _sheet<bool>(context, (_) => _LogFoodSheet(food: food, meal: meal, onPick: onPick, initial: initial));

class _AmountDial extends StatelessWidget {
  const _AmountDial({
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
    this.decimals = false,
    this.liquid,
  });

  final double value;
  final String unit;
  final double min;
  final double max;
  final double step;
  final bool decimals;
  final bool? liquid;
  final ValueChanged<double> onChanged;

  double get _k => liquid != null && fit.isLb ? _ozOf(liquid!) : 1;

  bool get _oz => _k != 1;

  double get _step => !_oz
      ? step
      : step <= 1
      ? 0.1
      : liquid!
      ? 0.5
      : 0.25;

  String get _unit => liquid == null ? unit : _amtUnit(liquid!);

  Future<void> _type(BuildContext context) async {
    final k = _k;
    final v = await askNumber(
      context,
      title: t.amountIn(_unit),
      initial: fmt(_round(value / k)),
      decimal: true,
    );
    if (v != null && v > 0) onChanged((v * k).clamp(min <= 0 ? step : min, max * 4).toDouble());
  }

  double _round(double v) => _oz || decimals ? (v * 10).round() / 10 : v.roundToDouble();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final k = _k;
    final dec = decimals || _oz;
    final shown = dec ? fmt(_round(value / k)) : '${value.round()}';
    final lo = min / k, hi = max / k;
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _type(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              RollingText(
                decimalText(shown),
                style: AppTheme.f(54, weight: FontWeight.w800, color: gc.text, height: 1.05),
              ),
              const SizedBox(width: 8),
              Text(
                _unit,
                style: AppTheme.f(19, weight: FontWeight.w700, color: gc.textSecondary),
              ),
              const SizedBox(width: 6),
              Icon(PhosphorIconsBold.pencilSimple, size: 13, color: gc.textTertiary),
            ],
          ),
        ),
        const SizedBox(height: 6),
        RulerPicker(
          value: (value / k).clamp(lo, hi).toDouble(),
          min: lo,
          max: hi,
          step: _step,
          majorEvery: 10,
          height: 72,
          label: (v) => dec ? fmt(_round(v)) : '${v.round()}',
          onChanged: (v) => onChanged(v * k),
        ),
      ],
    );
  }
}

class _QuickChip extends StatelessWidget {
  const _QuickChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      scale: 0.94,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? gc.accentSoft : gc.bgRaised2,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: selected ? gc.accent.withValues(alpha: 0.7) : Colors.transparent),
        ),
        child: Text(
          label,
          style: AppTheme.f(12.5, weight: FontWeight.w700, color: selected ? gc.accent : gc.textSecondary),
        ),
      ),
    );
  }
}

class _ValueRows extends StatelessWidget {
  const _ValueRows({required this.per, required this.title, this.onEdit, this.approx = false});

  final Macros per;
  final String title;
  final VoidCallback? onEdit;
  final bool approx;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget row(String label, String value, Color dot) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.textSecondary),
            ),
          ),
          Text(
            value,
            style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text),
          ),
        ],
      ),
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: _kicker(gc, title.toUpperCase())),
              if (approx) ...[
                Icon(PhosphorIconsBold.approximateEquals, size: 12, color: gc.warn),
                const SizedBox(width: 4),
                Text(
                  t.approxValues,
                  style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.warn),
                ),
                const SizedBox(width: 10),
              ],
              if (onEdit != null)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onEdit,
                  child: Row(
                    children: [
                      Icon(PhosphorIconsBold.pencilSimple, size: 13, color: gc.accent),
                      const SizedBox(width: 5),
                      Text(
                        t.editValues,
                        style: AppTheme.f(12, weight: FontWeight.w800, color: gc.accent),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          row(sentenceCase(t.kcalLabel), _energy(per.kcal), gc.text),
          row(sentenceCase(t.macroProtein), '${_g(per.protein)} g', gc.protein),
          row(sentenceCase(t.macroCarbs), '${_g(per.carbs)} g', gc.carbs),
          row(sentenceCase(t.macroFat), '${_g(per.fat)} g', gc.fat),
          if (per.fiber > 0) row(t.fiberLabel, '${_g(per.fiber)} g', gc.sage),
          if (per.sugar > 0) row(t.sugarLabel, '${_g(per.sugar)} g', gc.warn),
          if (per.sodium > 0) row(t.sodiumLabel, '${per.sodium.round()} mg', gc.info),
        ],
      ),
    );
  }
}

class _FoodHero extends StatelessWidget {
  const _FoodHero({required this.photo, required this.name, this.size = 132, this.favId});

  final String photo;
  final String name;
  final double size;
  final String? favId;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      height: size + 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 1.7,
            height: size * 1.25,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [gc.accent.withValues(alpha: 0.16), gc.accent.withValues(alpha: 0)],
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.82, end: 1),
            duration: const Duration(milliseconds: 520),
            curve: Curves.easeOutBack,
            builder: (context, s, child) => Transform.scale(scale: s, child: child),
            child: FoodSticker(photo: photo, name: name, size: size),
          ),
          if (favId != null && favId!.isNotEmpty)
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: fit,
                builder: (context, _) {
                  final on = fit.isFavoriteFood(favId!);
                  return RoundAction(
                    label: t.favouritesOnly,
                    size: 42,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      fit.toggleFavoriteFood(favId!);
                    },
                    child: Icon(
                      on ? PhosphorIconsFill.star : PhosphorIconsRegular.star,
                      size: 19,
                      color: on ? gc.accent : gc.textSecondary,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _LogFoodSheet extends StatefulWidget {
  const _LogFoodSheet({required this.food, required this.meal, this.onPick, this.initial});

  final ValueChanged<FoodEntry>? onPick;
  final FoodEntry? initial;

  final FoodItem food;
  final Meal meal;

  @override
  State<_LogFoodSheet> createState() => _LogFoodSheetState();
}

List<double> _gramSteps(FoodItem f) => switch (f.cat) {
  FoodCat.spice => [1, 2, 5],
  FoodCat.oil || FoodCat.sauce => [5, 10, 15],
  FoodCat.nut => [15, 30, 50],
  FoodCat.grain || FoodCat.legume => [40, 60, 80],
  FoodCat.meat || FoodCat.fish => [100, 150, 200],
  _ when f.liquid => [200, 330, 500],
  _ => [50, 100, 200],
};

bool _fineGrams(FoodItem f) => f.cat == FoodCat.spice || f.cat == FoodCat.oil || f.cat == FoodCat.sauce;

class _LogFoodSheetState extends State<_LogFoodSheet> {
  late Meal _meal = widget.meal;
  late final FoodItem _food = widget.food;
  late bool _cooked = widget.initial != null
      ? widget.initial!.cooked > 0 && _food.canCook
      : _food.canCook && (_food.cat == FoodCat.grain || _food.cat == FoodCat.legume);
  late double _grams = _initialGrams;
  late double _count = widget.initial?.servings ?? 1;

  double get _initialGrams {
    final f = _food;
    if (!f.byWeight) return 0;
    final e = widget.initial;
    if (e != null) return (_cooked ? e.shownGrams : e.totalGrams).roundToDouble();
    if (f.isLibrary) {
      if (_cooked) return _snapAmt(150, f.liquid);
      if (f.portion != null && f.portionGrams > 0) return f.portionGrams.roundToDouble();
      return _snapAmt(_gramSteps(f)[1], f.liquid);
    }
    return f.grams.roundToDouble();
  }

  double get _rawGrams => _cooked ? _grams / _food.cookedYield : _grams;

  double get _servings => _food.byWeight ? _rawGrams / _food.grams : _count;

  List<(String, double)> get _presets {
    final f = _food;
    final out = <(String, double)>[];
    if (_cooked) {
      return [
        for (final g in [100.0, 150.0, 200.0, 250.0, 300.0])
          (_amount(_snapAmt(g, f.liquid), f.liquid), _snapAmt(g, f.liquid)),
      ];
    }
    if (f.isLibrary && f.portion != null && f.portionGrams > 0) {
      for (final n in [1, 2]) {
        out.add((
          '${portionName(f.portion!, n)} · ${_amount(f.portionGrams * n, f.liquid)}',
          (f.portionGrams * n).roundToDouble(),
        ));
      }
    } else if (!f.isLibrary && f.grams > 0) {
      out.add((
        '${f.serving.isEmpty ? t.servingsLabel : f.serving} · ${_amount(f.grams, f.liquid)}',
        f.grams.roundToDouble(),
      ));
    }
    for (final raw in _gramSteps(f)) {
      final g = _fineGrams(f) ? raw : _snapAmt(raw, f.liquid);
      if (out.every((o) => o.$2 != g)) out.add((_amount(g, f.liquid), g));
    }
    return out;
  }

  void _editValues() {
    Navigator.of(context).pop();
    showFoodEditor(
      context,
      food: _food.isLibrary ? null : _food,
      from: _food.isLibrary ? _food : null,
      meal: _meal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final food = _food;
    final unit = _unitOf(food.liquid);
    final total = food.macros * _servings;
    final picking = widget.onPick != null;
    final shownPer = _cooked ? food.macros * (1 / food.cookedYield) : food.macros;
    final perTitle = _cooked ? '${t.per100(unit)} · ${t.cookedLabel.toLowerCase()}' : t.per100(unit);
    return _sheetFrame(context, [
      _FoodHero(photo: food.photo, name: food.name, favId: food.id),
      const SizedBox(height: 6),
      SheetTitle(
        food.name,
        subtitle: food.isLibrary
            ? '${t.per100Line(_energy(shownPer.kcal), unit)}${_cooked ? ' · ${t.cookedLabel.toLowerCase()}' : ''}'
            : (food.serving.isEmpty ? null : food.serving),
      ),
      const SizedBox(height: 16),
      if (food.canCook) ...[
        Center(
          child: SegToggle([
            SegOption(
              t.rawLabel,
              !_cooked,
              () => setState(() {
                if (_cooked) _grams = (_grams / _food.cookedYield / 5).round() * 5.0;
                _cooked = false;
              }),
            ),
            SegOption(
              t.cookedLabel,
              _cooked,
              () => setState(() {
                if (!_cooked) _grams = (_grams * _food.cookedYield / 5).round() * 5.0;
                _cooked = true;
              }),
            ),
          ]),
        ),
        const SizedBox(height: 4),
        Text(
          _cooked ? t.cookedHint(fmt(food.cookedYield)) : t.rawHint,
          textAlign: TextAlign.center,
          style: AppTheme.s(11.5, color: gc.textTertiary),
        ),
        const SizedBox(height: 8),
      ],
      if (food.byWeight)
        _AmountDial(
          value: _grams,
          unit: unit,
          liquid: food.liquid,
          min: 0,
          max: _fineGrams(food)
              ? 200
              : food.liquid
              ? 2000
              : 1000,
          step: _fineGrams(food)
              ? 1
              : food.liquid
              ? 10
              : 5,
          onChanged: (v) => setState(() => _grams = v),
        )
      else
        _AmountDial(
          value: _count,
          unit: t.servingsUnit,
          min: 0,
          max: 10,
          step: 0.5,
          decimals: true,
          onChanged: (v) => setState(() => _count = v),
        ),
      if (food.byWeight) ...[
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final p in _presets) ...[
                _QuickChip(
                  label: p.$1,
                  selected: (p.$2 - _grams).abs() < 0.5,
                  onTap: () => setState(() => _grams = p.$2),
                ),
                const SizedBox(width: 7),
              ],
            ],
          ),
        ),
      ],
      const SizedBox(height: 16),
      _macroSummary(context, total),
      const SizedBox(height: 12),
      _ValueRows(
        per: shownPer,
        title: food.byWeight ? perTitle : t.perServingShort,
        approx: food.approx,
        onEdit: picking ? null : _editValues,
      ),
      if (!picking) ...[
        const SizedBox(height: 14),
        _MealPicker(value: _meal, onPick: (m) => setState(() => _meal = m)),
      ],
      const SizedBox(height: 18),
      PrimaryButton(
        label: widget.initial != null
            ? t.save
            : picking
            ? t.prepAddIngredient
            : t.logAmount(_energy(total.kcal)),
        onTap: () {
          if (_servings <= 0) {
            HapticFeedback.heavyImpact();
            return;
          }
          final pick = widget.onPick;
          if (pick != null) {
            pick(fit.entryFor(food, servings: _servings, meal: _meal, cooked: _cooked));
            Navigator.of(context).pop(true);
            return;
          }
          final e = fit.logFood(food, servings: _servings, meal: _meal, cooked: _cooked);
          Navigator.of(context).pop(true);
          _loggedToast(context, e);
        },
      ),
      if (!picking && !food.isLibrary) ...[
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showFoodEditor(context, food: food);
            },
            child: Text(
              t.editFood,
              style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary),
            ),
          ),
        ),
      ],
    ]);
  }
}

Future<void> showEntrySheet(BuildContext context, FoodEntry entry) =>
    _sheet<void>(context, (_) => _EntrySheet(entry: entry));

class _EntrySheet extends StatefulWidget {
  const _EntrySheet({required this.entry});

  final FoodEntry entry;

  @override
  State<_EntrySheet> createState() => _EntrySheetState();
}

class _EntrySheetState extends State<_EntrySheet> {
  late double _servings = widget.entry.servings;
  late Meal _meal = widget.entry.meal;
  late DateTime _day = DateTime(widget.entry.at.year, widget.entry.at.month, widget.entry.at.day);

  String _dayName(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (d == today) return t.nutritionToday;
    if (d == shiftDays(today, -1)) return t.nutritionYesterday;
    return t.longDate(d);
  }

  Future<void> _pickDay() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (picked != null && mounted) setState(() => _day = DateTime(picked.year, picked.month, picked.day));
  }

  FoodEntry get _live {
    for (final e in fit.foodLog) {
      if (e.id == widget.entry.id) return e;
    }
    return widget.entry;
  }

  double get _scale => _live.cooked > 0 ? _live.cooked : 1;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final e = _live;
    final name = e.name.isEmpty ? t.quickAdd : e.name;
    final unit = _unitOf(e.liquid);
    return _sheetFrame(context, [
      if (e.foodId.isNotEmpty)
        _FoodHero(
          photo: fit.photoForEntry(e),
          name: e.name,
          size: 112,
          favId: fit.foodById(e.foodId) == null ? null : e.foodId,
        )
      else
        Center(
          child: Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: gc.warn.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(PhosphorIconsFill.lightning, size: 30, color: gc.warn),
          ),
        ),
      const SizedBox(height: 6),
      SheetTitle(name, subtitle: e.cooked > 0 ? t.cookedLabel : null),
      const SizedBox(height: 14),
      if (e.grams > 0)
        _AmountDial(
          value: (_servings * e.grams * _scale).roundToDouble(),
          unit: unit,
          liquid: e.liquid,
          min: 0,
          max: e.liquid ? 2000 : 1000,
          step: e.liquid ? 10 : 5,
          onChanged: (v) => setState(() => _servings = v / _scale / e.grams),
        )
      else
        _AmountDial(
          value: _servings,
          unit: t.servingsUnit,
          min: 0,
          max: 10,
          step: 0.5,
          decimals: true,
          onChanged: (v) => setState(() => _servings = v),
        ),
      const SizedBox(height: 14),
      _macroSummary(context, e.per * _servings),
      const SizedBox(height: 12),
      _ValueRows(
        per: e.per,
        title: e.grams > 0 ? t.per100(unit) : t.perServingShort,
        onEdit: () => showEntryValuesSheet(context, e),
      ),
      const SizedBox(height: 14),
      _MealPicker(value: _meal, onPick: (m) => setState(() => _meal = m)),
      const SizedBox(height: 10),
      ToolRow(
        label: t.entryDay,
        control: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _pickDay,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _dayName(_day),
                style: AppTheme.f(14, weight: FontWeight.w800, color: gc.accent),
              ),
              const SizedBox(width: 6),
              Icon(PhosphorIconsBold.calendarBlank, size: 15, color: gc.accent),
            ],
          ),
        ),
      ),
      const SizedBox(height: 18),
      PrimaryButton(
        label: t.save,
        onTap: () {
          if (_servings <= 0) {
            HapticFeedback.heavyImpact();
            return;
          }
          final was = DateTime(e.at.year, e.at.month, e.at.day);
          fit.updateEntry(e.id, servings: _servings, meal: _meal);
          if (_day != was) fit.moveEntryToDay(e.id, _day);
          Navigator.of(context).pop();
          if (_day != was) {
            showNotchToast(
              context,
              t.movedToDay,
              subtitle: _dayName(_day),
              icon: PhosphorIconsFill.calendarCheck,
              accent: gc.accent,
              action: t.undo,
              onTap: () => fit.moveEntryToDay(e.id, was),
            );
          }
        },
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              final copy = fit.repeatEntry(e.copyWith(servings: _servings));
              Navigator.of(context).pop();
              if (copy != null) _loggedToast(context, copy);
            },
            child: Text(
              t.repeatEntry,
              style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              final gone = fit.removeEntry(e.id);
              Navigator.of(context).pop();
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
            child: Text(
              t.delete,
              style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger),
            ),
          ),
        ],
      ),
    ]);
  }
}

Future<void> showEntryValuesSheet(BuildContext context, FoodEntry entry) =>
    _sheet<void>(context, (_) => _EntryValuesSheet(entry: entry));

class _EntryValuesSheet extends StatefulWidget {
  const _EntryValuesSheet({required this.entry});

  final FoodEntry entry;

  @override
  State<_EntryValuesSheet> createState() => _EntryValuesSheetState();
}

class _EntryValuesSheetState extends State<_EntryValuesSheet> {
  late final _name = TextEditingController(text: widget.entry.name);
  late final _kcal = TextEditingController(text: _seed(fit.energyOf(widget.entry.per.kcal).toDouble()));
  late final _p = TextEditingController(text: _seed(widget.entry.per.protein));
  late final _c = TextEditingController(text: _seed(widget.entry.per.carbs));
  late final _f = TextEditingController(text: _seed(widget.entry.per.fat));

  @override
  void dispose() {
    for (final c in [_name, _kcal, _p, _c, _f]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;
    final old = e.per;
    return _sheetFrame(context, [
      SheetTitle(t.editValues, subtitle: e.grams > 0 ? t.per100(_unitOf(e.liquid)) : t.perServingShort),
      const SizedBox(height: 16),
      _TextInput(controller: _name, hint: t.foodNameHint, label: t.nameLabel),
      const SizedBox(height: 10),
      _MacroInputs(kcal: _kcal, protein: _p, carbs: _c, fat: _f),
      const SizedBox(height: 10),
      Text(
        t.editValuesHint,
        textAlign: TextAlign.center,
        style: AppTheme.s(11.5, color: context.gc.textTertiary, height: 1.4),
      ),
      const SizedBox(height: 18),
      PrimaryButton(
        label: t.save,
        onTap: () {
          final m = _macrosOf(_kcal, _p, _c, _f);
          final next = Macros(
            kcal: m.kcal,
            protein: m.protein,
            carbs: m.carbs,
            fat: m.fat,
            fiber: old.fiber,
            sugar: old.sugar,
            sodium: old.sodium,
            animal: old.protein <= 0 ? 0 : old.animal / old.protein * m.protein,
            sat: old.sat,
            mono: old.mono,
            poly: old.poly,
            aminoProtein: old.protein <= 0 ? 0 : old.aminoProtein / old.protein * m.protein,
            amino: old.protein <= 0 ? const [] : [for (final a in old.amino) a / old.protein * m.protein],
          );
          if (next.isEmpty) {
            HapticFeedback.heavyImpact();
            return;
          }
          fit.editEntryValues(e.id, name: _name.text, per: next);
          Navigator.of(context).pop();
        },
      ),
    ]);
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.label, required this.controller, required this.color, this.suffix = 'g'});

  final String label;
  final TextEditingController controller;
  final Color color;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitText(
            label,
            style: AppTheme.f(9.5, weight: FontWeight.w700, color: color, letterSpacing: 0.9),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                  style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text),
                  cursorColor: color,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: AppTheme.f(19, weight: FontWeight.w800, color: gc.textTertiary),
                    contentPadding: const EdgeInsets.only(top: 4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  suffix,
                  style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

double _read(TextEditingController c) => double.tryParse(c.text.trim().replaceAll(',', '.')) ?? 0;

String _seed(double v) => v <= 0 ? '' : fmt((v * 10).round() / 10);

class _MacroInputs extends StatelessWidget {
  const _MacroInputs({required this.kcal, required this.protein, required this.carbs, required this.fat});

  final TextEditingController kcal, protein, carbs, fat;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _NumberField(
                label: fit.energyUnit.toUpperCase(),
                controller: kcal,
                color: gc.text,
                suffix: fit.energyUnit,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(label: t.macroProtein, controller: protein, color: gc.protein),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _NumberField(label: t.macroCarbs, controller: carbs, color: gc.carbs),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(label: t.macroFat, controller: fat, color: gc.fat),
            ),
          ],
        ),
        ListenableBuilder(
          listenable: Listenable.merge([kcal, protein, carbs, fat]),
          builder: (context, _) {
            final est = fit.energyOf(_read(protein) * 4 + _read(carbs) * 4 + _read(fat) * 9);
            final typed = _read(kcal);
            final off =
                est > 0 && (typed <= 0 || ((est - typed).abs() > 40 && (est - typed).abs() / est > 0.25));
            return AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: !off
                  ? const SizedBox(width: double.infinity)
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.calculator,
                            size: 14,
                            color: typed > 0 ? gc.warn : gc.textTertiary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              t.kcalFromMacros('$est ${fit.energyUnit}'),
                              style: AppTheme.f(
                                12,
                                weight: FontWeight.w600,
                                color: typed > 0 ? gc.warn : gc.textSecondary,
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              HapticFeedback.selectionClick();
                              kcal.text = '$est';
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                t.useValue,
                                style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.accent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}

Macros _macrosOf(
  TextEditingController k,
  TextEditingController p,
  TextEditingController c,
  TextEditingController f, {
  TextEditingController? fiber,
  TextEditingController? sugar,
  TextEditingController? sodium,
}) {
  final protein = _read(p), carbs = _read(c), fat = _read(f);
  var kcal = fit.kcalFromShown(_read(k));
  if (kcal <= 0) kcal = protein * 4 + carbs * 4 + fat * 9;
  return Macros(
    kcal: kcal,
    protein: protein,
    carbs: carbs,
    fat: fat,
    fiber: fiber == null ? 0 : _read(fiber),
    sugar: sugar == null ? 0 : _read(sugar),
    sodium: sodium == null ? 0 : _read(sodium),
  );
}

Future<void> showQuickAddSheet(BuildContext context, Meal meal) =>
    _sheet<void>(context, (_) => _QuickAddSheet(meal: meal));

class _QuickAddSheet extends StatefulWidget {
  const _QuickAddSheet({required this.meal});

  final Meal meal;

  @override
  State<_QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends State<_QuickAddSheet> {
  final _name = TextEditingController();
  final _kcal = TextEditingController();
  final _p = TextEditingController();
  final _c = TextEditingController();
  final _f = TextEditingController();
  late Meal _meal = widget.meal;

  @override
  void dispose() {
    for (final c in [_name, _kcal, _p, _c, _f]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _sheetFrame(context, [
      SheetTitle(t.quickAdd, subtitle: t.quickAddHint),
      const SizedBox(height: 18),
      _TextInput(controller: _name, hint: t.quickAddName),
      const SizedBox(height: 10),
      _MacroInputs(kcal: _kcal, protein: _p, carbs: _c, fat: _f),
      const SizedBox(height: 12),
      _MealPicker(value: _meal, onPick: (m) => setState(() => _meal = m)),
      const SizedBox(height: 18),
      PrimaryButton(
        label: t.logFood,
        onTap: () {
          final e = fit.logQuick(_name.text, _macrosOf(_kcal, _p, _c, _f), meal: _meal);
          if (e == null) {
            HapticFeedback.heavyImpact();
            return;
          }
          Navigator.of(context).pop();
          _loggedToast(context, e);
        },
      ),
    ]);
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({required this.controller, required this.hint, this.label});

  final TextEditingController controller;
  final String hint;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.9),
            ),
          TextField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            style: AppTheme.f(15.5, weight: FontWeight.w700, color: gc.text),
            cursorColor: gc.accent,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: AppTheme.f(15.5, weight: FontWeight.w600, color: gc.textTertiary),
              contentPadding: const EdgeInsets.only(top: 4),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showFoodEditor(
  BuildContext context, {
  FoodItem? food,
  FoodItem? from,
  Meal? meal,
  bool asShake = false,
  String name = '',
}) => _sheet<void>(
  context,
  (_) => _FoodEditor(food: food, from: from, meal: meal, asShake: asShake, name: name),
);

class _PhotoChoice extends StatelessWidget {
  const _PhotoChoice({
    required this.photo,
    required this.name,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String? photo;
  final String name;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final ready = photo != null;
    return Opacity(
      opacity: ready ? 1 : 0.4,
      child: Pressable(
        onTap: ready ? onTap : () {},
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 74,
              height: 74,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: gc.bgRaised2,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: selected ? gc.accent : gc.border, width: selected ? 2 : 1),
              ),
              child: ready
                  ? FoodSticker(photo: photo!, name: name, size: 60, tilt: false, shadow: false)
                  : Icon(PhosphorIconsRegular.scissors, size: 22, color: gc.textTertiary),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTheme.f(
                12,
                weight: selected ? FontWeight.w800 : FontWeight.w600,
                color: selected ? gc.text : gc.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodEditor extends StatefulWidget {
  const _FoodEditor({this.food, this.from, this.meal, this.asShake = false, this.name = ''});

  final FoodItem? food;
  final FoodItem? from;
  final Meal? meal;
  final bool asShake;
  final String name;

  @override
  State<_FoodEditor> createState() => _FoodEditorState();
}

mixin _StickerDrafts<T extends StatefulWidget> on State<T> {
  bool _working = false;
  String? _cutPhoto;
  String? _plainPhoto;
  CutoutDraft? _draft;

  String get _photoKind;
  String get _photo;
  set _photo(String v);
  bool _owned(String? p);

  void _dropDrafts({String? keep}) {
    for (final p in [_cutPhoto, _plainPhoto]) {
      if (p != null && p != keep && _owned(p)) MediaStore.delete(p);
    }
    _cutPhoto = null;
    _plainPhoto = null;
  }

  Future<void> _pick() async {
    final source = await pickPhotoSource(context);
    if (source == null) return;
    final shot = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1400,
      maxHeight: 1400,
      imageQuality: 92,
    );
    if (shot == null || !mounted) return;
    final bytes = await File(shot.path).readAsBytes();
    setState(() => _working = true);
    final draftFuture = prepareCutout(bytes);
    final plain = await makeSticker(bytes, cutout: false);
    final draft = await draftFuture;
    final cut = draft != null && draft.found ? await renderSticker(draft, draft.mask) : null;
    final cutSaved = cut == null ? null : await MediaStore.saveBytes(_photoKind, 'png', cut);
    final plainSaved = plain == null ? null : await MediaStore.saveBytes(_photoKind, 'png', plain.png);
    if (!mounted) {
      for (final p in [cutSaved, plainSaved]) {
        if (p != null) MediaStore.delete(p);
      }
      return;
    }
    _dropDrafts();
    setState(() {
      _draft = draft;
      _cutPhoto = cutSaved;
      _plainPhoto = plainSaved;
      _photo = cutSaved ?? plainSaved ?? _photo;
      _working = false;
    });
  }

  Future<void> _retouch() async {
    final draft = _draft;
    if (draft == null || _working) return;
    final out = await showCutoutEditor(context, draft);
    if (out == null || !mounted) return;
    final saved = await MediaStore.saveBytes(_photoKind, 'png', out.png);
    if (saved == null) return;
    if (!mounted) {
      MediaStore.delete(saved);
      return;
    }
    final old = _cutPhoto;
    setState(() {
      _draft = draft.withMask(out.mask);
      _cutPhoto = saved;
      _photo = saved;
    });
    if (old != null && _owned(old)) MediaStore.delete(old);
  }

  void _choose(String? photo) {
    if (photo == null || photo == _photo) return;
    HapticFeedback.selectionClick();
    setState(() => _photo = photo);
  }

  Widget _photoChoices(String name) {
    final gc = context.gc;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PhotoChoice(
              photo: _cutPhoto,
              name: name,
              label: t.cutoutTry,
              selected: _cutPhoto != null && _photo == _cutPhoto,
              onTap: () => _choose(_cutPhoto),
            ),
            const SizedBox(width: 14),
            _PhotoChoice(
              photo: _plainPhoto,
              name: name,
              label: t.cutoutKeep,
              selected: _photo == _plainPhoto,
              onTap: () => _choose(_plainPhoto),
            ),
          ],
        ),
        if (_draft != null) ...[
          const SizedBox(height: 12),
          Pressable(
            onTap: _retouch,
            scale: 0.95,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: gc.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(PhosphorIconsBold.paintBrush, size: 14, color: gc.accent),
                  const SizedBox(width: 7),
                  Text(
                    _draft!.found ? t.cutoutEdit : t.cutoutByHand,
                    style: AppTheme.f(12.5, weight: FontWeight.w800, color: gc.accent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _FoodEditorState extends State<_FoodEditor> with _StickerDrafts {
  late final FoodItem? _base = widget.food ?? widget.from;
  late final _name = TextEditingController(text: _base?.name ?? widget.name.trim());
  late final _serving = TextEditingController(text: _base?.serving ?? '');
  late final _grams = TextEditingController(text: _seed((_base?.grams ?? 0) / _k));

  double get _k => fit.isLb ? _ozOf(_base?.liquid ?? false) : 1;
  late final _kcal = TextEditingController(text: _seed(fit.energyOf(_base?.macros.kcal ?? 0).toDouble()));
  late final _fi = TextEditingController(text: _seed(_base?.macros.fiber ?? 0));
  late final _su = TextEditingController(text: _seed(_base?.macros.sugar ?? 0));
  late final _na = TextEditingController(text: _seed(_base?.macros.sodium ?? 0));
  late bool _extras = _base?.macros.hasExtras ?? false;
  late bool _shake = widget.asShake || (widget.food != null && fit.isShakeFood(widget.food!.id));
  late final _p = TextEditingController(text: _seed(_base?.macros.protein ?? 0));
  late final _c = TextEditingController(text: _seed(_base?.macros.carbs ?? 0));
  late final _f = TextEditingController(text: _seed(_base?.macros.fat ?? 0));
  @override
  late String _photo = _base?.photo ?? '';

  @override
  String get _photoKind => 'food';

  @override
  bool _owned(String? photo) =>
      photo != null && photo.isNotEmpty && !isAssetPhoto(photo) && photo != widget.food?.photo;

  @override
  void dispose() {
    for (final c in [_name, _serving, _grams, _kcal, _p, _c, _f, _fi, _su, _na]) {
      c.dispose();
    }
    _dropDrafts();
    super.dispose();
  }

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      HapticFeedback.heavyImpact();
      return;
    }
    final saved = fit.saveFood(
      id: widget.food?.id,
      name: name,
      photo: _photo,
      serving: _serving.text,
      grams: (_read(_grams) * _k).clamp(0, 5000).toDouble(),
      liquid: _base?.liquid ?? false,
      cookedYield: _base?.cookedYield ?? 0,
      macros: _keepDetail(_macrosOf(_kcal, _p, _c, _f, fiber: _fi, sugar: _su, sodium: _na)),
    );
    fit.setShakeTag(saved.id, _shake);
    if (widget.asShake) fit.setShakeFood(saved.id);
    _dropDrafts(keep: _photo);
    _photo = widget.food?.photo ?? '';
    final created = widget.food == null;
    Navigator.of(context).pop();
    if (created) HapticFeedback.lightImpact();
    final meal = widget.meal;
    if (meal != null) showLogFoodSheet(context, saved, meal);
  }

  Macros _keepDetail(Macros m) {
    final old = _base?.macros;
    if (old == null || old.protein <= 0) return m;
    final k = m.protein / old.protein;
    return Macros(
      kcal: m.kcal,
      protein: m.protein,
      carbs: m.carbs,
      fat: m.fat,
      fiber: m.fiber,
      sugar: m.sugar,
      sodium: m.sodium,
      animal: old.animal * k,
      sat: old.fat <= 0 ? 0 : old.sat * m.fat / old.fat,
      mono: old.fat <= 0 ? 0 : old.mono * m.fat / old.fat,
      poly: old.fat <= 0 ? 0 : old.poly * m.fat / old.fat,
      aminoProtein: old.aminoProtein * k,
      amino: [for (final a in old.amino) a * k],
    );
  }

  Future<void> _delete() async {
    final food = widget.food!;
    final ok = await askConfirm(
      context,
      title: t.deleteFoodTitle(food.name),
      body: t.deleteFoodBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (!ok || !mounted) return;
    _dropDrafts();
    fit.deleteFood(food.id);
    _photo = '';
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return _sheetFrame(context, [
      SheetTitle(
        widget.food != null
            ? t.editFood
            : widget.from != null
            ? t.editValues
            : t.newFood,
        subtitle: widget.from != null ? t.editLibraryHint : null,
      ),
      const SizedBox(height: 16),
      Center(
        child: Pressable(
          onTap: _working ? () {} : _pick,
          child: SizedBox(
            width: 136,
            height: 136,
            child: _working
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(strokeWidth: 2.4, color: gc.accent),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.cutoutWorking,
                        style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary),
                      ),
                    ],
                  )
                : _photo.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: gc.bgRaised2,
                      borderRadius: BorderRadius.circular(34),
                      border: Border.all(color: gc.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(PhosphorIconsRegular.camera, size: 30, color: gc.accent),
                        const SizedBox(height: 8),
                        Text(
                          t.addPhoto,
                          style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text),
                        ),
                      ],
                    ),
                  )
                : FoodSticker(photo: _photo, name: _name.text, size: 136, tilt: false),
          ),
        ),
      ),
      const SizedBox(height: 10),
      if (_plainPhoto != null && !_working)
        _photoChoices(_name.text)
      else
        Text(
          t.foodPhotoHint,
          textAlign: TextAlign.center,
          style: AppTheme.s(12, color: gc.textTertiary),
        ),
      const SizedBox(height: 16),
      _TextInput(controller: _name, hint: t.foodNameHint, label: t.nameLabel),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            flex: 3,
            child: _TextInput(controller: _serving, hint: t.servingHint, label: t.servingLabel),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: _NumberField(
              label: t.servingWeight,
              controller: _grams,
              color: gc.textTertiary,
              suffix: _amtUnit(_base?.liquid ?? false),
            ),
          ),
        ],
      ),
      const SizedBox(height: 14),
      Text(
        t.perServing,
        style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.1),
      ),
      const SizedBox(height: 8),
      _MacroInputs(kcal: _kcal, protein: _p, carbs: _c, fat: _f),
      const SizedBox(height: 8),
      if (_extras)
        Row(
          children: [
            Expanded(
              child: _NumberField(label: t.fiberLabel.toUpperCase(), controller: _fi, color: gc.sage),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(label: t.sugarLabel.toUpperCase(), controller: _su, color: gc.warn),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(
                label: t.sodiumLabel.toUpperCase(),
                controller: _na,
                color: gc.textSecondary,
                suffix: 'mg',
              ),
            ),
          ],
        )
      else
        Center(
          child: TextButton(
            onPressed: () => setState(() => _extras = true),
            child: Text(
              t.moreNutrients,
              style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.accent),
            ),
          ),
        ),
      const SizedBox(height: 10),
      _ShakeToggle(on: _shake, onTap: () => setState(() => _shake = !_shake)),
      const SizedBox(height: 18),
      PrimaryButton(label: t.save, onTap: _working ? () {} : _save),
      if (widget.food != null) ...[
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: _delete,
            child: Text(
              t.delete,
              style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger),
            ),
          ),
        ),
      ],
    ]);
  }
}

class _ShakeToggle extends StatelessWidget {
  const _ShakeToggle({required this.on, required this.onTap});

  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      toggled: on,
      button: true,
      child: Pressable(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        scale: 0.98,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.fromLTRB(12, 10, 14, 10),
          decoration: BoxDecoration(
            color: on ? gc.protein.withValues(alpha: 0.1) : gc.bgRaised2,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: on ? gc.protein.withValues(alpha: 0.45) : gc.border),
          ),
          child: Row(
            children: [
              Image.asset('assets/img/peek-shake.webp', width: 30, height: 36, fit: BoxFit.contain),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.shakeTag,
                      style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.shakeTagHint,
                      style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              TinySwitch(on: on),
            ],
          ),
        ),
      ),
    );
  }
}
