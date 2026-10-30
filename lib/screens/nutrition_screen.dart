import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../models/nutrition.dart';
import '../services/food_library.dart';
import '../services/media_store.dart';
import '../services/sticker_cutout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/charts.dart';
import '../widgets/dialogs.dart';
import '../widgets/glass.dart';
import '../widgets/home_folder.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/nutrition_art.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/rolling_text.dart';
import '../widgets/cutout_editor.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/ui_kit.dart';
import 'plan_import_sheet.dart' show pickTextFile;
import 'progress_screen.dart' show showBodyweightSheet;

part 'nutrition/cards.dart';
part 'nutrition/prep.dart';
part 'nutrition/settings.dart';
part 'nutrition/meals.dart';
part 'nutrition/food.dart';
part 'nutrition/plans.dart';

String mealInSentence(Meal m) {
  final name = mealName(m);
  if ((fit.slotOf(m)?.name ?? '').isNotEmpty || appLanguage == 'de') return name;
  return name.toLowerCase();
}

String mealName(Meal m) {
  final custom = fit.slotOf(m)?.name ?? '';
  if (custom.isNotEmpty) return custom;
  return switch (m) {
    Meal.breakfast => t.mealBreakfast,
    Meal.lunch => t.mealLunch,
    Meal.dinner => t.mealDinner,
    Meal.snacks => t.mealSnacks,
    _ => t.mealOther,
  };
}

IconData _mealIcon(Meal m) => switch (m) {
      Meal.breakfast => PhosphorIconsRegular.coffee,
      Meal.lunch => PhosphorIconsRegular.forkKnife,
      Meal.dinner => PhosphorIconsRegular.bowlFood,
      Meal.snacks => PhosphorIconsRegular.cookie,
      _ => PhosphorIconsRegular.bowlSteam,
    };

String _g(double v) => fmt((v * 10).round() / 10);

String _unitOf(bool liquid) => liquid ? 'ml' : 'g';

double _ozOf(bool liquid) => liquid ? 29.5735 : 28.3495;

double _snapAmt(double grams, bool liquid) =>
    fit.isLb ? (grams / _ozOf(liquid) * 2).round() / 2 * _ozOf(liquid) : grams;

String _amtUnit(bool liquid) => fit.isLb ? (liquid ? 'fl oz' : 'oz') : _unitOf(liquid);

String _amount(double grams, bool liquid) => fit.isLb
    ? '${fmt((grams / _ozOf(liquid) * 10).round() / 10)} ${_amtUnit(liquid)}'
    : '${fmt(grams.round().toDouble())} ${_unitOf(liquid)}';

String _energy(num kcal) => '${fit.energyOf(kcal)} ${fit.energyUnit}';

String portionName(PortionKind k, [int n = 1]) => switch (k) {
      PortionKind.unit => t.portionUnit(n),
      PortionKind.slice => t.portionSlice(n),
      PortionKind.scoop => t.portionScoop(n),
      PortionKind.tbsp => t.portionTbsp(n),
      PortionKind.tsp => t.portionTsp(n),
      PortionKind.cup => t.portionCup(n),
      PortionKind.glass => t.portionGlass(n),
    };

String _servingLine(FoodEntry e, FoodItem? food) {
  if (e.grams > 0) return e.cooked > 0 ? '${_amount(e.shownGrams, e.liquid)} · ${t.cookedLabel.toLowerCase()}' : _amount(e.totalGrams, e.liquid);
  final serving = food?.serving ?? '';
  final x = e.servings == 1 ? '' : '${fmt(e.servings)} × ';
  if (serving.isEmpty) return e.servings == 1 ? '' : '${fmt(e.servings)} ×';
  return '$x$serving';
}

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  void initState() {
    super.initState();
    FoodLibrary.load().then((_) {
      if (!mounted) return;
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) => _warm());
    });
  }

  void _warm() {
    if (!mounted) return;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final photos = <(String, double)>[
      for (final c in FoodCat.values) (catPhoto(c), 46),
      for (final f in fit.foodsByUse.take(8)) (f.photo, 62),
      for (final f in fit.recentLibraryFoods.take(8)) (f.photo, 62),
    ];
    for (final (photo, size) in photos) {
      if (!isAssetPhoto(photo)) continue;
      precacheImage(ResizeImage(AssetImage(assetOfPhoto(photo)), width: (size * dpr).round()), context);
    }
  }

  String get _dayLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = fit.nutritionDay;
    if (day == today) return t.nutritionToday;
    if (day == shiftDays(today, -1)) return t.nutritionYesterday;
    return t.longDate(day);
  }

  Widget _pair(Widget? a, Widget? b) {
    if (a == null || b == null) return a ?? b ?? const SizedBox.shrink();
    return IntrinsicHeight(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(child: a),
        const SizedBox(width: 12),
        Expanded(child: b),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    bool on(Tracker x) => fit.trackerOn(x);
    final cards = <Widget>[
      if (on(Tracker.water) || on(Tracker.shake))
        _pair(on(Tracker.water) ? _WaterTile() : null, on(Tracker.shake) ? _ShakeTile() : null),
      if (on(Tracker.supplements)) _SupplementsCard(),
    ];
    final planned = on(Tracker.plans) ? fit.planOn(fit.nutritionDay) : null;
    final todayPlan = planned != null && planned.items.isNotEmpty ? planned : null;
    final detail = <Widget>[
      if (on(Tracker.animal) || on(Tracker.fiber) || on(Tracker.sugarSodium)) _DetailGrid(),
      if (on(Tracker.quality)) _QualityCard(),
      if (on(Tracker.fats)) _FatTypesCard(),
      if (on(Tracker.week)) _WeekTile(),
      if (on(Tracker.weight)) _WeightTile(),
    ];
    var order = 0;
    return RiseScope(
      id: 'nutrition',
      child: SafeArea(
      bottom: false,
      child: ListView(
        clipBehavior: Clip.none,
        cacheExtent: 600,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          for (final w in <Widget>[
            ScreenHeader(
              title: t.nutrition,
              subtitle: _dayLabel,
              onBack: fit.backFromNutrition,
              badge: BetaTag(t.sectionBeta),
              actions: [
                RoundAction(
                  label: t.trackersTitle,
                  onTap: () => showTrackersSheet(context),
                  child: Icon(PhosphorIconsRegular.slidersHorizontal, size: 17, color: gc.textSecondary),
                ),
                const SizedBox(width: 8),
                RoundAction(
                  label: t.nutritionGoals,
                  onTap: () => showGoalsSheet(context),
                  child: Icon(PhosphorIconsRegular.target, size: 17, color: gc.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _WeekStrip(),
            if (on(Tracker.calories) || on(Tracker.protein) || on(Tracker.carbs) || on(Tracker.fat)) ...[
              const SizedBox(height: 12),
              _HeroCard(),
            ],
            const SizedBox(height: 12),
            const _SearchBar(),
            if (on(Tracker.foods)) ...[
              const SizedBox(height: 14),
              _FoodShelf(),
              const SizedBox(height: 16),
              _Folders(),
            ],
            if (todayPlan != null) ...[
              const SizedBox(height: 22),
              _TodayPlanCard(plan: todayPlan),
            ],
            const SizedBox(height: 22),
            _MealTabs(),
            for (final c in cards) ...[const SizedBox(height: 12), c],
            if (on(Tracker.prep)) ...[
              const SizedBox(height: 26),
              _Heading(t.prepTitle, action: t.prepNewShort, onAction: () => showBatchEditor(context)),
              const SizedBox(height: 12),
              _PrepShelf(),
            ],
            if (on(Tracker.plans)) ...[
              const SizedBox(height: 26),
              _Heading(t.mealPlansTitle, action: t.mealPlanNew, onAction: () => showNewPlanSheet(context)),
              const SizedBox(height: 12),
              const _PlansSection(),
            ],
            if (detail.isNotEmpty) ...[
              const SizedBox(height: 26),
              _Heading(t.trackersDetail),
              for (final d in detail) ...[const SizedBox(height: 12), d],
            ],
          ])
            w is SizedBox ? w : _Keep(child: Rise(index: order++, child: w)),
        ],
      ),
      ),
    );
  }
}

class _Keep extends StatefulWidget {
  const _Keep({required this.child});

  final Widget child;

  @override
  State<_Keep> createState() => _KeepState();
}

class _KeepState extends State<_Keep> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.title, {this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(title.toUpperCase(),
                style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
          ),
          if (action != null)
            Pressable(
              onTap: onAction!,
              scale: 0.94,
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(15)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(PhosphorIconsBold.plus, size: 12, color: gc.text),
                  const SizedBox(width: 5),
                  Text(action!, style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}

List<(String, String)> _plateOf(Iterable<FoodEntry> items) => [
      for (final e in [...items]..sort((a, b) => b.shownGrams.compareTo(a.shownGrams))) (fit.photoForEntry(e), e.name),
    ];

Widget _kicker(GymColors gc, String text) =>
    Text(text, style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.1));

class _WeekStrip extends StatelessWidget {
  const _WeekStrip();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final days = fit.nutritionWeek;
    final last = shiftDays(today, NutritionState.kNutritionDaysAhead);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity ?? 0;
        if (v > 200) fit.setNutritionDay(shiftDays(fit.nutritionDay, -7));
        if (v < -200 && days.last.isBefore(last)) fit.setNutritionDay(shiftDays(fit.nutritionDay, 7));
      },
      child: Row(
        children: [
          for (final d in days)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: d.isAfter(last) ? null : () => fit.setNutritionDay(d),
                child: Column(children: [
                  SizedBox(
                    height: 17,
                    child: Text(
                      d == today ? t.nutritionToday : t.weekdayInitial(d.weekday),
                      maxLines: 1,
                      style: d == today
                          ? AppTheme.f(12.5, weight: FontWeight.w800, color: gc.text)
                          : AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.6),
                    ),
                  ),
                  const SizedBox(height: 7),
                  _DayDot(day: d, selected: d == fit.nutritionDay, future: d.isAfter(today)),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.day, required this.selected, required this.future});

  final DateTime day;
  final bool selected;
  final bool future;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    const size = 38.0;
    final pct = fit.kcalPctOn(day);
    final ringColor = pct > 1.1
        ? gc.danger
        : pct >= 0.9
            ? gc.sage
            : gc.accent;
    final label = Text('${day.day}',
        style: AppTheme.f(13,
            weight: FontWeight.w800, color: selected ? gc.onEmber : (future ? gc.textTertiary : gc.text)));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: selected ? gc.ember : Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: selected ? [BoxShadow(color: gc.emberShadow, blurRadius: 10, offset: const Offset(0, 3))] : null,
      ),
      child: selected || future
          ? Center(child: label)
          : Stack(alignment: Alignment.center, children: [
              GoalRing(pct: (pct * 100).clamp(0, 100).toDouble(), size: size, color: ringColor),
              label,
            ]),
    );
  }
}

Widget _sheetFrame(BuildContext context, List<Widget> children, {double heightFactor = 0}) {
  final gc = context.gc;
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
      height: heightFactor > 0 ? MediaQuery.of(context).size.height * heightFactor : null,
      padding: sheetPad(context, bottom: 18),
      decoration: BoxDecoration(
        color: fit.dark ? Color.lerp(gc.bg, gc.bgRaised, 0.55) : gc.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [const SheetHandle(), const SizedBox(height: 16), ...children],
        ),
      ),
    ),
  );
}

Widget _sheetSlivers(BuildContext context, List<Widget> slivers, {double heightFactor = 0}) {
  final gc = context.gc;
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
      height: heightFactor > 0 ? MediaQuery.of(context).size.height * heightFactor : null,
      padding: sheetPad(context, bottom: 18),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: CustomScrollView(
        shrinkWrap: heightFactor <= 0,
        slivers: [
          const SliverToBoxAdapter(child: Column(children: [SheetHandle(), SizedBox(height: 16)])),
          for (final s in slivers) s is SliverGrid || s is SliverList ? s : SliverToBoxAdapter(child: s),
        ],
      ),
    ),
  );
}

Future<T?> _sheet<T>(BuildContext context, WidgetBuilder builder) => showAppSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheet) => AnimatedBuilder(animation: fit, builder: (c, _) => builder(c)),
    );

Widget _macroSummary(BuildContext context, Macros m) {
  final gc = context.gc;
  Widget cell(String label, String value, Color color) => Expanded(
        child: Column(children: [
          Text(value, style: AppTheme.f(17, weight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: FitText(label, style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.9)),
          ),
        ]),
      );
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
    child: Column(children: [
      Row(children: [
        cell(fit.energyUnit.toUpperCase(), '${fit.energyOf(m.kcal)}', gc.text),
        cell(t.macroProtein, '${_g(m.protein)} g', gc.protein),
        cell(t.macroCarbs, '${_g(m.carbs)} g', gc.carbs),
        cell(t.macroFat, '${_g(m.fat)} g', gc.fat),
      ]),
      if (m.hasExtras) ...[
        const SizedBox(height: 10),
        Text(_extrasLine(m), style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
      ],
    ]),
  );
}

void _loggedToast(BuildContext context, FoodEntry e) {
  HapticFeedback.lightImpact();
  showNotchToast(
    context,
    t.loggedToast(mealInSentence(e.meal)),
    subtitle: e.name.isEmpty ? null : e.name,
    icon: PhosphorIconsFill.forkKnife,
    accent: context.gc.accent,
    action: t.undo,
    onTap: () => fit.removeEntry(e.id),
  );
}

class _CappedList extends StatelessWidget {
  const _CappedList({
    required this.count,
    required this.itemBuilder,
    required this.rowHeight,
    required this.gap,
    required this.maxRows,
    required this.fade,
  });

  final int count;
  final IndexedWidgetBuilder itemBuilder;
  final double rowHeight;
  final double gap;
  final int maxRows;
  final Color fade;

  @override
  Widget build(BuildContext context) {
    if (count <= maxRows) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) SizedBox(height: gap),
          itemBuilder(context, i),
        ],
      ]);
    }
    return SizedBox(
      height: (maxRows - 0.5) * (rowHeight + gap),
      child: Stack(children: [
        Positioned.fill(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: rowHeight / 2),
            physics: const ClampingScrollPhysics(),
            itemCount: count,
            separatorBuilder: (_, _) => SizedBox(height: gap),
            itemBuilder: itemBuilder,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: rowHeight * 0.7,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [fade.withValues(alpha: 0), fade],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
