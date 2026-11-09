part of '../nutrition_screen.dart';

Future<void> showMealAiSheet(BuildContext context, Meal meal, {ValueChanged<FoodEntry>? onPick}) =>
    _sheet<void>(context, (_) => _MealAiSheet(meal: meal, onPick: onPick));

const _aiTags = <(String, String)>[
  ('protein', 'high protein'),
  ('veggie', 'vegetarian'),
  ('vegan', 'vegan'),
  ('nogluten', 'gluten free'),
  ('nolactose', 'lactose free'),
  ('quick', 'quick to make, under 10 minutes'),
  ('nocook', 'no cooking needed'),
  ('cheap', 'cheap everyday ingredients'),
];

String _aiTagLabel(String id) => switch (id) {
      'protein' => t.mealAiTagProtein,
      'veggie' => t.mealAiTagVeggie,
      'vegan' => t.mealAiTagVegan,
      'nogluten' => t.mealAiTagNoGluten,
      'nolactose' => t.mealAiTagNoLactose,
      'quick' => t.mealAiTagQuick,
      'nocook' => t.mealAiTagNoCook,
      _ => t.mealAiTagCheap,
    };

class _MealAiSheet extends StatefulWidget {
  const _MealAiSheet({required this.meal, this.onPick});

  final Meal meal;
  final ValueChanged<FoodEntry>? onPick;

  @override
  State<_MealAiSheet> createState() => _MealAiSheetState();
}

class _MealAiSheetState extends State<_MealAiSheet> {
  static String _lastNotes = '';
  static final Set<String> _lastTags = {};

  late final TextEditingController _notes = TextEditingController(text: _lastNotes);
  final _answer = TextEditingController();
  bool _day = false;
  int _step = 0;
  int _options = 3;
  int _kcal = 300;
  int _protein = 25;
  int _carbs = 30;
  int _fat = 10;
  int _left = 0;
  int _leftProtein = 0;
  bool _showText = false;
  bool _reviewed = false;
  bool _truncated = false;
  int _pick = 0;
  List<AiDraftOption> _drafts = const [];

  @override
  void initState() {
    super.initState();
    _retarget();
  }

  @override
  void dispose() {
    _notes.dispose();
    _answer.dispose();
    super.dispose();
  }

  void _retarget() {
    final g = fit.mealAiTargets(widget.meal, day: _day);
    _kcal = g.kcal;
    _protein = g.protein;
    _carbs = g.carbs;
    _fat = g.fat;
    _left = g.leftKcal;
    _leftProtein = g.leftProtein;
  }

  String get _prompt {
    final today = fit.entriesOn(fit.nutritionDay);
    final eaten = <String>[];
    for (final e in today) {
      if (!eaten.contains(e.name)) eaten.add(e.name);
    }
    return buildMealAiPrompt(MealAiBrief(
      language: languageNameOf(appLanguage),
      day: _day,
      mealId: widget.meal.id,
      mealLabel: mealName(widget.meal),
      slots: [for (final s in fit.mealSlots) (s.meal.id, mealName(s.meal))],
      kcal: _kcal,
      protein: _protein,
      carbs: _carbs,
      fat: _fat,
      options: _options,
      tags: [for (final tag in _aiTags) if (_lastTags.contains(tag.$1)) tag.$2],
      notes: _notes.text,
      eaten: eaten.take(10).toList(),
    ));
  }

  Future<void> _copy() async {
    _lastNotes = _notes.text;
    FocusScope.of(context).unfocus();
    await Clipboard.setData(ClipboardData(text: _prompt));
    if (!mounted) return;
    HapticFeedback.lightImpact();
    showNotchToast(context, t.mealAiCopied,
        subtitle: t.mealAiCopiedHint, icon: PhosphorIconsFill.copy, accent: context.gc.sage);
    setState(() => _step = 1);
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null || text.trim().isEmpty || !mounted) return;
    _answer.text = text;
    await _review();
  }

  Future<void> _file() async {
    final text = await pickTextFile();
    if (text == null || !mounted) return;
    _answer.text = text;
    await _review();
  }

  Future<void> _review() async {
    final raw = _answer.text;
    if (raw.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    if (!FoodLibrary.ready) await FoodLibrary.load();
    if (!mounted) return;
    final reply = parseMealAi(raw);
    final drafts = reply.isEmpty
        ? const <AiDraftOption>[]
        : resolveMealAi(reply,
            lang: appLanguage, meal: widget.meal, slots: fit.mealSlots, day: _day, own: fit.foods);
    HapticFeedback.selectionClick();
    setState(() {
      _reviewed = true;
      _drafts = drafts;
      _truncated = reply.truncated;
      _pick = 0;
    });
  }

  Future<void> _copyFix() async {
    await Clipboard.setData(const ClipboardData(text: mealAiRetrySentence));
    if (!mounted) return;
    showNotchToast(context, t.copiedDone, icon: PhosphorIconsFill.copy, accent: context.gc.sage);
  }

  void _useAsNew(AiDraft d) {
    final fresh = d.asNew;
    if (fresh == null) return;
    HapticFeedback.selectionClick();
    setState(() {
      for (final o in _drafts) {
        final i = o.items.indexOf(d);
        if (i >= 0) o.items[i] = fresh..on = d.on;
      }
    });
  }

  Future<void> _editAmount(AiDraft d) async {
    final unit = _amtUnit(d.entry.liquid);
    final shown = d.shownGrams;
    if (shown <= 0) return;
    final display = fit.isLb ? shown / _ozOf(d.entry.liquid) : shown;
    final v = await askNumber(
      context,
      title: '${t.mealAiAmount} ($unit)',
      initial: fmt(fit.isLb ? (display * 10).round() / 10 : display.round().toDouble()),
      decimal: fit.isLb,
    );
    if (v == null || v <= 0 || !mounted) return;
    setState(() => d.scaleTo(fit.isLb ? v * _ozOf(d.entry.liquid) : v));
  }

  Future<void> _add(AiDraftOption o) async {
    final chosen = o.chosen;
    if (chosen.isEmpty) return;
    HapticFeedback.lightImpact();
    final host = Navigator.of(context, rootNavigator: true).context;
    final sage = context.gc.sage;
    final pick = widget.onPick;
    var n = 0;
    if (pick != null) {
      for (final d in chosen) {
        pick(d.entry.copyWith(meal: widget.meal));
        n++;
      }
    } else {
      final groups = <Meal, List<FoodEntry>>{};
      for (final d in chosen) {
        groups.putIfAbsent(d.entry.meal, () => []).add(d.entry);
      }
      for (final g in groups.entries) {
        n += fit.logEntries(g.value, g.key).length;
      }
    }
    Navigator.of(context).pop();
    if (host.mounted) showNotchToast(host, t.mealAiAdded(n), icon: PhosphorIconsFill.checkCircle, accent: sage);
  }

  Future<void> _save(AiDraftOption o) async {
    final chosen = o.chosen;
    if (chosen.isEmpty) return;
    final title = _day ? t.mealAiSavePlan : t.mealAiSaveRecipe;
    final name = await askText(context, title: title, initial: o.name);
    if (name == null || name.trim().isEmpty || !mounted) return;
    final host = Navigator.of(context, rootNavigator: true).context;
    final sage = context.gc.sage;
    if (_day) {
      fit.saveMealPlan(
        MealPlan(
          id: '',
          name: name,
          color: fit.mealPlans.length,
          items: [for (final d in chosen) d.entry.copyWith(id: fit.newPlanItemId())],
        ),
        const {},
      );
    } else {
      fit.saveRecipe(name, [for (final d in chosen) d.entry]);
    }
    HapticFeedback.lightImpact();
    Navigator.of(context).pop();
    if (host.mounted) {
      showNotchToast(host, _day ? t.mealAiPlanSaved : t.mealAiRecipeSaved,
          icon: PhosphorIconsFill.checkCircle, accent: sage);
    }
  }

  Widget _stepper(GymColors gc, String label, Widget control) => Row(children: [
        Expanded(child: Text(label, style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text))),
        control,
      ]);

  Widget _askPage(GymColors gc) {
    final steppers = !_day;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _kicker(gc, t.mealAiTarget.toUpperCase()),
      const SizedBox(height: 10),
      Center(
        child: SegToggle([
          SegOption(titleCase(mealName(widget.meal)), !_day, () {
            if (!_day) return;
            setState(() {
              _day = false;
              _options = 3;
              _retarget();
            });
          }),
          SegOption(t.mealAiWholeDay, _day, () {
            if (_day) return;
            setState(() {
              _day = true;
              _options = 1;
              _retarget();
            });
          }),
        ], hPad: 18, vPad: 9, fontSize: 13),
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (steppers) ...[
            _stepper(
              gc,
              sentenceCase(t.kcalLabel),
              StepperControl(
                value: _energy(_kcal),
                minWidth: 86,
                fontSize: 15,
                onDec: () => setState(() => _kcal = (_kcal - 50).clamp(100, 3000)),
                onInc: () => setState(() => _kcal = (_kcal + 50).clamp(100, 3000)),
              ),
            ),
            const SizedBox(height: 8),
            _stepper(
              gc,
              sentenceCase(t.macroProtein),
              StepperControl(
                value: ltr('$_protein g'),
                minWidth: 86,
                fontSize: 15,
                onDec: () => setState(() => _protein = (_protein - 5).clamp(5, 250)),
                onInc: () => setState(() => _protein = (_protein + 5).clamp(5, 250)),
              ),
            ),
            const SizedBox(height: 10),
            Text(t.mealAiLeft(_energy(_left), _leftProtein),
                style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary, height: 1.35)),
          ] else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                  '${_energy(_kcal)} · ${ltr('$_protein g')} ${t.macroProtein.toLowerCase()} · ${ltr('$_carbs g')} ${t.macroCarbs.toLowerCase()} · ${ltr('$_fat g')} ${t.macroFat.toLowerCase()}',
                  style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text, height: 1.4)),
            ),
        ]),
      ),
      const SizedBox(height: 22),
      _kicker(gc, t.mealAiStyle.toUpperCase()),
      const SizedBox(height: 10),
      Wrap(spacing: 7, runSpacing: 7, children: [
        for (final tag in _aiTags)
          _Chip(
            label: _aiTagLabel(tag.$1),
            selected: _lastTags.contains(tag.$1),
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _lastTags.contains(tag.$1) ? _lastTags.remove(tag.$1) : _lastTags.add(tag.$1));
            },
          ),
      ]),
      const SizedBox(height: 12),
      TextField(
        controller: _notes,
        minLines: 2,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.multiline,
        onChanged: (v) => _lastNotes = v,
        style: AppTheme.f(14, weight: FontWeight.w500, color: gc.text, height: 1.35),
        cursorColor: gc.accent,
        decoration: InputDecoration(
          hintText: t.mealAiNotesHint,
          hintStyle: AppTheme.f(14, weight: FontWeight.w500, color: gc.textTertiary),
          filled: true,
          fillColor: gc.bgRaised2,
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 16),
      _stepper(
        gc,
        t.mealAiOptions,
        StepperControl(
          value: '$_options',
          minWidth: 40,
          fontSize: 15,
          onDec: () => setState(() => _options = (_options - 1).clamp(1, _day ? 3 : 4)),
          onInc: () => setState(() => _options = (_options + 1).clamp(1, _day ? 3 : 4)),
        ),
      ),
      const SizedBox(height: 20),
      PrimaryButton(label: t.mealAiCopy, onTap: _copy),
      const SizedBox(height: 4),
      Pressable(
        onTap: () => setState(() => _showText = !_showText),
        scale: 0.97,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(_showText ? t.mealAiHideText : t.mealAiShowText,
                style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.accent)),
          ),
        ),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: _showText
            ? Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                child: Ltr(
                  child: SelectableText(_prompt,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: gc.textSecondary, height: 1.4)),
                ),
              )
            : const SizedBox(width: double.infinity),
      ),
    ]);
  }

  Widget _chipButton(GymColors gc, IconData icon, String label, VoidCallback onTap, {Color? bg}) => Pressable(
        onTap: onTap,
        scale: 0.95,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(color: bg ?? gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 15, color: gc.text),
            const SizedBox(width: 7),
            Text(label, style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
          ]),
        ),
      );

  Widget _pastePage(GymColors gc) {
    final empty = _answer.text.trim().isEmpty;
    final done = _reviewed && _drafts.isNotEmpty;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(
        controller: _answer,
        minLines: done ? 2 : 5,
        maxLines: done ? 2 : 9,
        keyboardType: TextInputType.multiline,
        onChanged: (_) => setState(() {}),
        style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.text, height: 1.35),
        cursorColor: gc.accent,
        decoration: InputDecoration(
          hintText: t.mealAiPasteHint,
          hintStyle: AppTheme.f(14, weight: FontWeight.w500, color: gc.textTertiary),
          filled: true,
          fillColor: gc.bgRaised2,
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 10),
      Row(children: [
        _chipButton(gc, PhosphorIconsRegular.clipboardText, t.pasteAction, _paste),
        const SizedBox(width: 8),
        _chipButton(gc, PhosphorIconsRegular.fileArrowUp, t.chooseFile, _file),
      ]),
      const SizedBox(height: 16),
      PrimaryButton(
        label: t.mealAiReview,
        bg: empty ? gc.bgRaised2 : gc.ember,
        fg: empty ? gc.textTertiary : gc.onEmber,
        onTap: _review,
      ),
      if (_reviewed) ...[const SizedBox(height: 22), _result(gc)],
    ]);
  }

  Widget _result(GymColors gc) {
    if (_drafts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: gc.bgRaised2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: gc.warn.withValues(alpha: 0.55)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.mealAiUnreadable, style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
          const SizedBox(height: 6),
          Text(t.mealAiUnreadableHint,
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
          const SizedBox(height: 12),
          _chipButton(gc, PhosphorIconsRegular.copy, t.mealAiCopyFix, _copyFix, bg: gc.bgRaised),
        ]),
      );
    }
    final o = _drafts[_pick.clamp(0, _drafts.length - 1)];
    final total = o.total;
    final chosen = o.chosen;
    final near = _kcal > 0 && (total.kcal - _kcal).abs() <= _kcal * 0.15;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (_drafts.length > 1) ...[
        Center(
          child: SegToggle([
            for (var i = 0; i < _drafts.length; i++) SegOption(t.mealAiOption(i + 1), i == _pick, () => setState(() => _pick = i)),
          ], hPad: 14, vPad: 8, fontSize: 12.5),
        ),
        const SizedBox(height: 14),
      ],
      if (o.name.isNotEmpty) ...[
        Text(o.name, style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text, height: 1.25)),
        const SizedBox(height: 10),
      ],
      Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Ltr(
            child: Row(children: [
              Expanded(child: _total(gc, '${fit.energyOf(total.kcal)}', fit.energyUnit.toUpperCase(), big: true)),
              Expanded(child: _total(gc, '${total.protein.round()}', t.macroProtein)),
              Expanded(child: _total(gc, '${total.carbs.round()}', t.macroCarbs)),
              Expanded(child: _total(gc, '${total.fat.round()}', t.macroFat)),
            ]),
          ),
          if (!_day || _kcal > 0) ...[
            const SizedBox(height: 10),
            Text(t.mealAiTargetLine(_energy(_kcal)),
                style: AppTheme.f(11.5, weight: FontWeight.w700, color: near ? gc.sage : gc.textTertiary)),
          ],
        ]),
      ),
      const SizedBox(height: 10),
      for (final d in o.items) _itemRow(gc, d),
      if (_truncated) ...[
        const SizedBox(height: 6),
        Text(t.mealAiTruncated, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.warn, height: 1.4)),
      ],
      const SizedBox(height: 16),
      if (chosen.isEmpty)
        PrimaryButton(label: t.mealAiNothingChosen, bg: gc.bgRaised2, fg: gc.textTertiary, onTap: () {})
      else
        PrimaryButton(
          label: widget.onPick != null
              ? '${t.mealAiAddPick} · ${_energy(total.kcal)}'
              : _day
                  ? '${t.mealAiAddDay} · ${_energy(total.kcal)}'
                  : '${t.mealAiAddTo(mealInSentence(widget.meal))} · ${_energy(total.kcal)}',
          onTap: () => _add(o),
        ),
      if (widget.onPick == null && chosen.isNotEmpty) ...[
        const SizedBox(height: 10),
        GhostButton(
          label: _day ? t.mealAiSavePlan : t.mealAiSaveRecipe,
          icon: _day ? PhosphorIconsRegular.calendarPlus : PhosphorIconsRegular.cookingPot,
          onTap: () => _save(o),
        ),
      ],
    ]);
  }

  Widget _total(GymColors gc, String value, String label, {bool big = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: RollingText(value, style: AppTheme.f(big ? 26 : 19, weight: FontWeight.w800, color: gc.text, height: 1.1)),
          ),
          const SizedBox(height: 3),
          Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.1)),
        ],
      );

  String? _flagText(AiDraft d) {
    if (d.flags.contains(AiFlag.noValues)) return t.mealAiFlagNoValues;
    if (d.flags.contains(AiFlag.doubtful)) return t.mealAiFlagDoubtful;
    if (d.flags.contains(AiFlag.adjusted)) return t.mealAiFlagAdjusted;
    if (d.flags.contains(AiFlag.noAmount)) return t.mealAiFlagNoAmount;
    if (d.flags.contains(AiFlag.matched)) return t.mealAiFlagMatched;
    if (d.source == AiSource.ai) return t.mealAiFlagEstimated;
    return null;
  }

  Widget _leading(GymColors gc, AiDraft d) {
    final photo = fit.photoForEntry(d.entry);
    if (photo.isNotEmpty) return FoodSticker(photo: photo, name: d.name, size: 38, tilt: false, shadow: false);
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
      child: Icon(PhosphorIconsRegular.forkKnife, size: 16, color: gc.textTertiary),
    );
  }

  Widget _itemRow(GymColors gc, AiDraft d) {
    final flag = _flagText(d);
    final bad = d.flags.contains(AiFlag.doubtful) || d.flags.contains(AiFlag.noValues);
    final tone = bad ? gc.warn : (d.source == AiSource.ai ? gc.textTertiary : gc.textSecondary);
    final active = d.on && d.usable;
    final grams = d.shownGrams;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: active ? 1 : 0.5,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Expanded(
            child: Pressable(
              onTap: d.usable && grams > 0 ? () => _editAmount(d) : () {},
              scale: 0.985,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 9, 0, 9),
                child: Row(children: [
                  SizedBox(width: 38, height: 38, child: Center(child: _leading(gc, d))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(d.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                      const SizedBox(height: 2),
                      Text(
                          [
                            if (grams > 0) _amount(grams, d.entry.liquid),
                            if (d.usable) _energy(d.total.kcal),
                          ].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
                      if (flag != null) ...[
                        const SizedBox(height: 2),
                        Text(flag,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(11, weight: FontWeight.w600, color: tone, height: 1.25)),
                      ],
                      if (d.asNew != null && d.flags.contains(AiFlag.matched)) ...[
                        const SizedBox(height: 2),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _useAsNew(d),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(t.mealAiNotSame,
                                style: AppTheme.f(11.5, weight: FontWeight.w800, color: gc.accent)),
                          ),
                        ),
                      ],
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          Semantics(
            button: true,
            checked: active,
            label: d.name,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: d.usable
                  ? () {
                      HapticFeedback.selectionClick();
                      setState(() => d.on = !d.on);
                    }
                  : null,
              child: SizedBox(
                width: 52,
                height: 52,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? gc.accent : Colors.transparent,
                      border: Border.all(color: active ? gc.accent : gc.textTertiary, width: 1.5),
                    ),
                    child: active ? Icon(PhosphorIconsBold.check, size: 13, color: gc.onEmber) : null,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return _sheetFrame(context, [
      SheetTitle(t.mealAiTitle, subtitle: t.mealAiSubtitle),
      const SizedBox(height: 10),
      Center(child: BetaTag(t.sectionBeta, small: true)),
      const SizedBox(height: 16),
      Center(
        child: SegToggle([
          SegOption('1 · ${t.mealAiStepAsk}', _step == 0, () => setState(() => _step = 0)),
          SegOption('2 · ${t.mealAiStepPaste}', _step == 1, () => setState(() => _step = 1)),
        ], hPad: 18, vPad: 9, fontSize: 13),
      ),
      const SizedBox(height: 20),
      AnimatedSize(
        duration: const Duration(milliseconds: 340),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          layoutBuilder: (current, previous) => Stack(
            alignment: Alignment.topCenter,
            children: [
              for (final p in previous) Positioned(top: 0, left: 0, right: 0, child: p),
              ?current,
            ],
          ),
          transitionBuilder: (child, a) => FadeTransition(opacity: a, child: child),
          child: KeyedSubtree(
            key: ValueKey(_step),
            child: _step == 0 ? _askPage(gc) : _pastePage(gc),
          ),
        ),
      ),
    ]);
  }
}
