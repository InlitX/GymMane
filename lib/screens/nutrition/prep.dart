part of '../nutrition_screen.dart';

class _PrepShelf extends StatelessWidget {
  const _PrepShelf();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final list = fit.activeBatches;
    if (list.isEmpty) {
      return Pressable(
        onTap: () => showBatchEditor(context),
        scale: 0.98,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: gc.border),
          ),
          child: Row(children: [
            FoodPlate(
              items: [
                for (final slug in const ['rice', 'chicken-breast', 'broccoli']) ('asset:assets/food/$slug.webp', slug),
              ],
              size: 64,
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(t.prepEmpty, style: AppTheme.s(12.5, color: gc.textSecondary, height: 1.4))),
          ]),
        ),
      );
    }
    if (list.length == 1) return SizedBox(height: 150, child: _BatchCard(batch: list.single, width: double.infinity));
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: list.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, i) => _BatchCard(batch: list[i]),
      ),
    );
  }
}

class _BatchCard extends StatelessWidget {
  const _BatchCard({required this.batch, this.width = 200});

  final Batch batch;
  final double width;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final b = batch;
    return Pressable(
      onTap: () => showBatchLogSheet(context, b, fit.defaultMeal),
      onLongPress: () => showBatchEditor(context, batch: b),
      scale: 0.96,
      child: Container(
        width: width,
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            FoodPlate(items: _plateOf(b.items), size: 46),
            const SizedBox(width: 10),
            Expanded(
              child: Text(b.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text, height: 1.15)),
            ),
          ]),
          const Spacer(),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: _amount(b.leftGrams, false).split(' ').first,
                style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text, height: 1)),
            TextSpan(
                text: ' / ${_amount(b.totalGrams, false)}',
                style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
          ])),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: b.leftShare,
              minHeight: 6,
              backgroundColor: gc.bgRaised2,
              color: gc.warn,
            ),
          ),
          const SizedBox(height: 7),
          Text('${_energy(b.per100.kcal)} · ${t.per100('g')}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
        ]),
      ),
    );
  }
}

Future<void> showBatchEditor(BuildContext context, {Batch? batch}) =>
    _sheet<void>(context, (_) => _BatchEditor(batch: batch));

class _BatchEditor extends StatefulWidget {
  const _BatchEditor({this.batch});

  final Batch? batch;

  @override
  State<_BatchEditor> createState() => _BatchEditorState();
}

class _BatchEditorState extends State<_BatchEditor> {
  late final _name = TextEditingController(text: widget.batch?.name ?? '');
  late final _cooked = TextEditingController(text: _seed((widget.batch?.cookedGrams ?? 0) / _k));

  double get _k => fit.isLb ? _ozOf(false) : 1;
  late final List<FoodEntry> _items = [...?widget.batch?.items];
  bool _missingWeight = false;

  @override
  void dispose() {
    _name.dispose();
    _cooked.dispose();
    super.dispose();
  }

  double get _raw => _items.fold(0.0, (s, e) => s + e.totalGrams);

  void _add() => showAddFoodSheet(context, fit.defaultMeal, onPick: (e) => setState(() => _items.add(e)));

  void _save() {
    final saved = fit.saveBatch(
      id: widget.batch?.id,
      name: _name.text.trim().isEmpty ? t.prepDefaultName : _name.text,
      items: _items,
      cookedGrams: (_read(_cooked) * _k).clamp(0, 50000).toDouble(),
    );
    if (saved == null) {
      HapticFeedback.heavyImpact();
      setState(() => _missingWeight = _items.isNotEmpty);
      return;
    }
    Navigator.of(context).pop();
    HapticFeedback.lightImpact();
  }

  Future<void> _delete() async {
    final b = widget.batch!;
    final ok = await askConfirm(context,
        title: t.deleteFoodTitle(b.name), body: t.deleteSavedMealBody, confirmLabel: t.delete, danger: true);
    if (!ok || !mounted) return;
    fit.deleteBatch(b.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final total = _items.fold(Macros.zero, (s, e) => s + e.total);
    return _sheetFrame(context, [
      SheetTitle(widget.batch == null ? t.prepNew : t.prepEdit, subtitle: t.prepHint),
      const SizedBox(height: 16),
      _TextInput(controller: _name, hint: t.prepNameHint, label: t.nameLabel),
      const SizedBox(height: 16),
      _kicker(gc, t.prepIngredients.toUpperCase()),
      const SizedBox(height: 8),
      for (var i = 0; i < _items.length; i++)
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            FoodSticker(photo: fit.photoForEntry(_items[i]), name: _items[i].name, size: 40, tilt: false, shadow: false),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_items[i].name.isEmpty ? t.quickAdd : _items[i].name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
                Text(
                  [
                    _servingLine(_items[i], fit.foodById(_items[i].foodId)),
                    _energy(_items[i].total.kcal),
                  ].where((x) => x.isNotEmpty).join(' · '),
                  style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
                ),
              ]),
            ),
            IconButton(
              onPressed: () => setState(() => _items.removeAt(i)),
              icon: Icon(PhosphorIconsBold.x, size: 15, color: gc.textTertiary),
            ),
          ]),
        ),
      GhostButton(label: t.prepAddIngredient, icon: PhosphorIconsBold.plus, onTap: _add),
      const SizedBox(height: 16),
      _NumberField(label: t.prepCookedWeight, controller: _cooked, color: gc.warn, suffix: _amtUnit(false)),
      const SizedBox(height: 6),
      Text(
        _missingWeight ? t.prepNeedWeight : t.prepCookedHint(fmt(_raw.roundToDouble())),
        style: AppTheme.s(11.5, color: _missingWeight ? gc.danger : gc.textTertiary, height: 1.4),
      ),
      if (_items.isNotEmpty) ...[
        const SizedBox(height: 14),
        _macroSummary(context, total),
      ],
      const SizedBox(height: 18),
      PrimaryButton(label: t.save, onTap: _save),
      if (widget.batch != null) ...[
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: _delete,
            child: Text(t.delete, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger)),
          ),
        ),
      ],
    ]);
  }
}

Future<void> showBatchLogSheet(BuildContext context, Batch batch, Meal meal) =>
    _sheet<void>(context, (_) => _BatchLogSheet(batch: batch, meal: meal));

class _BatchLogSheet extends StatefulWidget {
  const _BatchLogSheet({required this.batch, required this.meal});

  final Batch batch;
  final Meal meal;

  @override
  State<_BatchLogSheet> createState() => _BatchLogSheetState();
}

class _BatchLogSheetState extends State<_BatchLogSheet> {
  late Meal _meal = widget.meal;
  int _mode = 0;
  double _share = 0.25;
  double _grams = 300;

  Batch get _b => fit.batchById(widget.batch.id) ?? widget.batch;

  double get _gramStep => fit.isLb ? _ozOf(false) : 25;

  double get _portion {
    final b = _b;
    final one = b.totalGrams / b.portions;
    return b.leftGrams - one < one * 0.15 ? b.leftGrams : math.min(one, b.leftGrams);
  }

  double get _take => switch (_mode) {
        0 => _portion,
        1 => _b.leftGrams * _share,
        _ => math.min(_grams, _b.leftGrams),
      };

  Widget _chip(GymColors gc, bool on, String label, String sub, VoidCallback onTap) => Pressable(
        onTap: onTap,
        scale: 0.94,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: on ? gc.accentSoft : gc.bgRaised2,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: on ? gc.accent.withValues(alpha: 0.6) : Colors.transparent),
          ),
          child: Column(children: [
            Text(label, style: AppTheme.f(13, weight: FontWeight.w800, color: on ? gc.accent : gc.text)),
            Text(sub, style: AppTheme.f(10, weight: FontWeight.w600, color: gc.textTertiary)),
          ]),
        ),
      );

  Future<void> _weigh() async {
    final k = fit.isLb ? _ozOf(false) : 1.0;
    final v = await askNumber(context,
        title: '${t.prepWeighLeft} (${_amtUnit(false)})', initial: fmt((_b.leftGrams / k * 10).round() / 10), decimal: true);
    if (v != null && v >= 0) fit.setBatchLeft(_b.id, v * k);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final b = _b;
    const shares = [0.1, 0.25, 1 / 3, 0.5, 1.0];
    return _sheetFrame(context, [
      Center(child: FoodPlate(items: _plateOf(b.items), size: 128)),
      const SizedBox(height: 14),
      SheetTitle(b.name, subtitle: t.prepLeftOf(_amount(b.leftGrams, false), _amount(b.totalGrams, false))),
      const SizedBox(height: 12),
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: LinearProgressIndicator(value: b.leftShare, minHeight: 8, backgroundColor: gc.bgRaised2, color: gc.warn),
      ),
      const SizedBox(height: 18),
      if (b.finished)
        Text(t.prepFinished, textAlign: TextAlign.center, style: AppTheme.s(13, color: gc.textSecondary))
      else ...[
        _macroSummary(context, b.per100 * (_take / 100)),
        const SizedBox(height: 14),
        Center(
          child: SegToggle([
            SegOption(t.prepPortions, _mode == 0, () => setState(() => _mode = 0)),
            SegOption(t.prepOfWhatsLeft, _mode == 1, () => setState(() => _mode = 1)),
            SegOption(_amtUnit(false), _mode == 2, () => setState(() {
                  _grams = _take.roundToDouble();
                  _mode = 2;
                })),
          ]),
        ),
        const SizedBox(height: 12),
        if (_mode == 0)
          Row(children: [
            for (final n in const [2, 3, 4, 5, 6])
              Expanded(
                child: _chip(gc, n == b.portions, '1/$n', _amount(b.totalGrams / n, false),
                    () => fit.setBatchPortions(b.id, n)),
              ),
          ])
        else if (_mode == 1)
          Row(children: [
            for (final s in shares)
              Expanded(
                child: _chip(gc, (s - _share).abs() < 0.001, s == 1 ? t.prepAll : '${(s * 100).round()} %',
                    _amount(b.leftGrams * s, false), () => setState(() => _share = s)),
              ),
          ])
        else
          ToolRow(
            label: t.amountLabel,
            control: StepperControl(
              value: _amount(_grams, false),
              minWidth: 86,
              onDec: () => setState(() => _grams = (_grams - _gramStep).clamp(5, b.leftGrams).toDouble()),
              onInc: () => setState(() => _grams = (_grams + _gramStep).clamp(5, b.leftGrams).toDouble()),
              onEdit: () async {
                final k = fit.isLb ? _ozOf(false) : 1.0;
                final v = await askNumber(context,
                    title: t.amountIn(_amtUnit(false)), initial: fmt((_grams / k * 10).round() / 10), decimal: true);
                if (v != null && v > 0 && mounted) setState(() => _grams = (v * k).clamp(1, b.leftGrams).toDouble());
              },
            ),
          ),
        const SizedBox(height: 12),
        _MealPicker(value: _meal, onPick: (m) => setState(() => _meal = m)),
        const SizedBox(height: 18),
        PrimaryButton(
          label: t.prepLogAmount(_amount(_take, false)),
          onTap: () {
            final e = fit.logFromBatch(b, _take, meal: _meal);
            if (e == null) {
              HapticFeedback.heavyImpact();
              return;
            }
            Navigator.of(context).pop();
            _loggedToast(context, e);
          },
        ),
      ],
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
          onPressed: _weigh,
          child: Text(t.prepWeighLeft, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showBatchEditor(context, batch: b);
          },
          child: Text(t.prepEdit, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
        ),
      ]),
    ]);
  }
}
