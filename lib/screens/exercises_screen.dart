import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_map.dart';
import '../widgets/dialogs.dart';
import '../widgets/exercise_media.dart';
import '../widgets/glass.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});
  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late final TextEditingController _c = TextEditingController(text: fit.exSearch);
  final ScrollController _scroll = ScrollController();
  final ValueNotifier<bool> _deep = ValueNotifier(false);
  final _searchFocus = FocusNode();

  static const _span = 110.0;
  static const _btn = 40.0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_track);
    WidgetsBinding.instance.addPostFrameCallback((_) => _track());
  }

  void _track() {
    if (_scroll.hasClients) _deep.value = _scroll.offset > 900;
  }

  @override
  void dispose() {
    _c.dispose();
    _searchFocus.dispose();
    _scroll.dispose();
    _deep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final list = fit.exercisesFiltered;

    final pad = MediaQuery.paddingOf(context).top;
    final searchTop = pad + 12 + 50 + 14;
    final chipsTop = searchTop + 48 + 10;
    final contentTop = chipsTop + 34 + 12;

    return Stack(children: [
              Positioned.fill(
                child: ListView.builder(
              key: const PageStorageKey('exercises'),
              controller: _scroll,
              padding: EdgeInsets.fromLTRB(20, contentTop, 20, 110),
              itemCount: list.isEmpty ? 1 : list.length,
              itemBuilder: (context, i) {
                if (list.isEmpty) return _empty(gc);
                final ex = list[i];
                final first = i == 0 || list[i - 1].primary != ex.primary;
                final last = i == list.length - 1 || list[i + 1].primary != ex.primary;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (first) ...[
                      SizedBox(height: i == 0 ? 2 : 22),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 8),
                        child: Row(children: [
                          Text(muscleLabel(ex.primary).toUpperCase(),
                              style: AppTheme.f(10.5,
                                  weight: FontWeight.w700,
                                  color: gc.textTertiary,
                                  letterSpacing: 1.3)),
                          const SizedBox(width: 7),
                          Text('${_groupSize(list, i)}',
                              style: AppTheme.f(10.5,
                                  weight: FontWeight.w700,
                                  color: gc.textSecondary,
                                  letterSpacing: 1.3)),
                        ]),
                      ),
                    ],
                    _row(gc, ex, first: first, last: last),
                  ],
                );
              },
                ),
              ),
              Positioned.fill(child: _header(context, gc, list.length, pad, searchTop, chipsTop)),
              Positioned(
                right: 20,
                bottom: 112,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _deep,
                  builder: (context, deep, _) => IgnorePointer(
                    ignoring: !deep,
                    child: AnimatedScale(
                      scale: deep ? 1 : 0.6,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      child: AnimatedOpacity(
                        opacity: deep ? 1 : 0,
                        duration: const Duration(milliseconds: 220),
                        child: RoundAction(
                          size: 44,
                          filled: true,
                          label: t.backToTop,
                          onTap: () => _scroll.animateTo(0,
                              duration: const Duration(milliseconds: 520), curve: Curves.easeOutCubic),
                          child: Icon(PhosphorIconsBold.arrowUp, size: 18, color: gc.onEmber),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]);
  }

  double get _fold {
    if (!_scroll.hasClients) return 0;
    return Curves.easeInOut.transform((_scroll.offset / _span).clamp(0.0, 1.0));
  }

  Future<void> _openSearch() async {
    HapticFeedback.selectionClick();
    if (_scroll.hasClients && _scroll.offset > 0) {
      await _scroll.animateTo(0, duration: const Duration(milliseconds: 420), curve: Curves.easeOutCubic);
    }
    if (mounted) _searchFocus.requestFocus();
  }

  int get _activeFilters =>
      _sheetFilters + (fit.exMuscleFilter == null && fit.exZoneFilter == null ? 0 : 1);

  void _clearAll() {
    _c.clear();
    fit.clearExFilters();
  }

  Widget _header(BuildContext context, GymColors gc, int count, double pad, double searchTop, double chipsTop) {
    final blur = EdgeBlur(height: pad + 70, sigma: 14);
    return LayoutBuilder(builder: (context, box) {
      final w = box.maxWidth;
      return AnimatedBuilder(
        animation: _scroll,
        builder: (context, _) {
          final p = _fold;
          final y = _scroll.hasClients ? _scroll.offset : 0.0;
          final plusX = w - 20 - _btn;
          final searchX = 20 + (plusX - 8 - _btn - 20) * p;
          final searchY = searchTop + (pad + 12 - searchTop) * p;
          final searchW = (w - 40) + (_btn - (w - 40)) * p;
          final searchH = 48 + (_btn - 48) * p;
          final filterX = plusX - 2 * (_btn + 8);
          final active = _activeFilters;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              if (p > 0.001) IgnorePointer(child: Opacity(opacity: p, child: blur)),
              Positioned(
                left: 0,
                right: 0,
                top: chipsTop - y.clamp(0.0, chipsTop),
                child: IgnorePointer(
                  ignoring: p > 0.3,
                  child: Opacity(
                    opacity: (1 - p * 1.6).clamp(0.0, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _quickChips(context, gc),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20 + _btn + 12 + (_btn + 8) * 2 * p,
                top: pad + 12 + 6 * p,
                child: IgnorePointer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 1 - 0.2 * p,
                        alignment: Alignment.topLeft,
                        child: ScreenTitle(t.exercises),
                      ),
                      Opacity(
                        opacity: (1 - p * 2).clamp(0.0, 1.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(t.libraryCount(count),
                              style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: plusX,
                top: pad + 12,
                child: RoundAction(
                  size: _btn,
                  label: t.newExercise,
                  onTap: () => showCreateExerciseSheet(context, initialName: _c.text),
                  child: Icon(PhosphorIconsRegular.plus, size: 17, color: gc.text),
                ),
              ),
              if (p > 0.4)
                Positioned(
                  left: filterX,
                  top: pad + 12,
                  child: Opacity(
                    opacity: ((p - 0.4) / 0.6).clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: 0.8 + 0.2 * ((p - 0.4) / 0.6).clamp(0.0, 1.0),
                      child: Stack(clipBehavior: Clip.none, children: [
                        RoundAction(
                          size: _btn,
                          label: t.filters,
                          onTap: () => showExerciseFilters(context, onClear: _c.clear),
                          child: Icon(PhosphorIconsRegular.slidersHorizontal, size: 17, color: gc.text),
                        ),
                        if (active > 0)
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              width: 17,
                              height: 17,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
                              child: Text('$active',
                                  style: AppTheme.f(10, weight: FontWeight.w800, color: gc.onEmber)),
                            ),
                          ),
                      ]),
                    ),
                  ),
                ),
              Positioned(
                left: searchX,
                top: searchY,
                width: searchW,
                height: searchH,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(searchH / 2),
                  child: ColoredBox(
                    color: gc.bgRaised,
                    child: Stack(children: [
                      IgnorePointer(
                        ignoring: p > 0.5,
                        child: Opacity(
                          opacity: (1 - p / 0.6).clamp(0.0, 1.0),
                          child: OverflowBox(
                            alignment: Alignment.centerLeft,
                            minWidth: w - 40,
                            maxWidth: w - 40,
                            child: SearchField(
                              controller: _c,
                              focusNode: _searchFocus,
                              hint: t.searchExercises,
                              onChanged: fit.setExSearch,
                            ),
                          ),
                        ),
                      ),
                      if (p > 0.45)
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _openSearch,
                            child: Opacity(
                              opacity: ((p - 0.45) / 0.55).clamp(0.0, 1.0),
                              child: Center(child: SvgPathIcon(Ic.search, size: 16, color: gc.text)),
                            ),
                          ),
                        ),
                    ]),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _quickChips(BuildContext context, GymColors gc) {
    final sheetOn = _sheetFilters;
    final zoneOn = fit.exZoneFilter != null || fit.exMuscleFilter != null;
    final anyOn = sheetOn > 0 || zoneOn || fit.exFavouritesOnly;
    Widget pill(String label, bool on, VoidCallback onTap) => Pill(
          label: label,
          bg: on ? gc.ember : gc.bgRaised2,
          fg: on ? gc.onEmber : gc.textSecondary,
          onTap: onTap,
          hPad: 14,
          vPad: 7,
          fontSize: 12.5,
        );
    final active = <(String, VoidCallback)>[
      if (fit.exKindFilter != null) (t.exerciseKind(fit.exKindFilter!), () => fit.setKindFilter(fit.exKindFilter!)),
      if (fit.exNoGearOnly) (t.noGearOnly, fit.toggleNoGearFilter),
      if (fit.exEquipmentFilter != null)
        (t.equipment(fit.exEquipmentFilter!), () => fit.setEquipmentFilter(fit.exEquipmentFilter!)),
      if (fit.exDifficultyFilter != null)
        (t.difficulty(fit.exDifficultyFilter!), () => fit.setDifficultyFilter(fit.exDifficultyFilter!)),
      if (fit.exMineOnly) (t.mineOnly, fit.toggleMineFilter),
      if (fit.exArchivedOnly) (t.archivedFilter, fit.toggleArchivedFilter),
      for (final place in fit.places)
        if (place.id == fit.activePlaceId) (place.name, () => fit.setActivePlace('')),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(children: [
        pill(
          fit.exZoneFilter != null
              ? t.muscleGroupName(fit.exZoneFilter!)
              : fit.exMuscleFilter != null
                  ? muscleLabel(fit.exMuscleFilter!)
                  : t.byZone,
          zoneOn,
          () => showBodyZones(context),
        ),
        const SizedBox(width: 8),
        pill(sheetOn > 0 ? '${t.filters} · $sheetOn' : t.filters, false,
            () => showExerciseFilters(context, onClear: _c.clear)),
        for (final (label, off) in active) ...[
          const SizedBox(width: 8),
          _ActiveFilter(label: label, onTap: off),
        ],
        const SizedBox(width: 8),
        pill(fit.favouriteCount > 0 ? '${t.favouritesOnly} · ${fit.favouriteCount}' : t.favouritesOnly,
            fit.exFavouritesOnly, fit.toggleFavouritesFilter),
        if (anyOn) ...[
          const SizedBox(width: 8),
          Pill(
            label: t.clearFilters,
            bg: Colors.transparent,
            fg: gc.accent,
            onTap: _clearAll,
            hPad: 10,
            vPad: 7,
            fontSize: 12.5,
          ),
        ],
      ]),
    );
  }

  Widget _empty(GymColors gc) {
    final noFavs = fit.exFavouritesOnly && fit.favouriteCount == 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          if (noFavs)
            _star(gc, false)
          else
            SvgPathIcon(const [IconPath('M11 11m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0', strokeWidth: 1.5), IconPath('M21 21l-4.35-4.35', strokeWidth: 1.5)], size: 40, color: gc.textTertiary),
          const SizedBox(height: 10),
          Text(noFavs ? t.noFavouritesYet : t.noExercisesFound,
              style: AppTheme.f(15.5, weight: FontWeight.w700, color: gc.text)),
          const SizedBox(height: 4),
          Text(noFavs ? t.noFavouritesHint : t.noExercisesHint,
              textAlign: TextAlign.center,
              style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
          const SizedBox(height: 16),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _clearAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(t.clearFilters,
                  style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
            ),
          ),
        ],
      ),
    );
  }

  static int _groupSize(List<Exercise> list, int from) {
    var n = 0;
    while (from + n < list.length && list[from + n].primary == list[from].primary) {
      n++;
    }
    return n;
  }

  Widget _row(GymColors gc, Exercise ex, {required bool first, required bool last}) {
    final fav = fit.favorites[ex.id] ?? false;
    return Container(
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(first ? 24 : 0),
          bottom: Radius.circular(last ? 24 : 0),
        ),
      ),
      child: Column(
        children: [
          Pressable(
            onTap: () => fit.openExercise(ex.id),
            scale: 0.985,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 9, 6, 9),
              child: Row(
                children: [
                  SizedBox(
                    width: 52,
                    child: ExerciseMedia(ex: ex, height: 52, radius: 15, bordered: false),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exerciseName(ex),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                        const SizedBox(height: 4),
                        Text('${t.equipment(ex.equipment)} · ${t.difficulty(ex.difficulty)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(12,
                                weight: FontWeight.w500, color: gc.textSecondary)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => fit.toggleFavorite(ex.id),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: _star(gc, fav),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!last)
            Container(
              margin: const EdgeInsets.only(left: 77, right: 14),
              height: 1,
              color: gc.text.withValues(alpha: 0.06),
            ),
        ],
      ),
    );
  }

  Widget _star(GymColors gc, bool fav) => _StarPop(on: fav, child: _starIcon(gc, fav));

  Widget _starIcon(GymColors gc, bool fav) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Stack(children: [
        if (fav) SvgPathIcon(const [IconPath('M12 2l3.09 6.26L22 9.27l-5 4.87L18.18 21 12 17.77 5.82 21 7 14.14l-5-4.87 6.91-1.01z', fill: true)], size: 18, color: gc.accent),
        SvgPathIcon(Ic.star, size: 18, color: fav ? gc.accent : gc.textTertiary),
      ]),
    );
  }
}

class _ActiveFilter extends StatelessWidget {
  const _ActiveFilter({required this.label, required this.onTap});

  final String label;
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
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 7, 10, 7),
        decoration: BoxDecoration(color: gc.ember, borderRadius: BorderRadius.circular(100)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(titleCase(label), style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.onEmber)),
          const SizedBox(width: 6),
          Icon(PhosphorIconsBold.x, size: 11, color: gc.onEmber.withValues(alpha: 0.8)),
        ]),
      ),
    );
  }
}

class _FilterChipData {
  _FilterChipData(this.label, this.active, this.onTap);
  final String label;
  final bool active;
  final VoidCallback onTap;
}

void showCreateExerciseSheet(BuildContext context,
    {void Function(String id)? onCreated, Exercise? editing, String initialName = ''}) {
  final gc = context.gc;
  final nameCtrl = TextEditingController(text: editing?.name ?? initialName.trim());
  final stepsCtrl = TextEditingController(text: editing?.steps.join('\n') ?? '');
  final aliasCtrl = TextEditingController(text: editing?.aliases.join(', ') ?? '');
  final nameFocus = FocusNode();
  final scroll = ScrollController();
  bool nameMissing = false;
  int shakes = 0;
  String muscle = editing?.primary ?? kMuscles.first.id;
  final secondary = <String>{...?editing?.secondary};
  String equipment = editing?.equipment ?? kEquipment.first;
  String difficulty = editing?.difficulty ?? kDifficulties.first;
  String mode = editing?.mode ?? '';
  String kind = editing?.kind ?? '';
  bool advanced = false;
  bool allEquipment = false;
  String? openZone = kBodyZones.entries.firstWhere((z) => z.value.contains(muscle), orElse: () => kBodyZones.entries.first).key;
  String? mediaPath;
  bool busy = false;
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: gc.bgRaised,
    shape: sheetShape(gc),
    builder: (sheetCtx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(sheetCtx).viewInsets.bottom),
      child: StatefulBuilder(
        builder: (sheetCtx, setSheet) {
          final mediaIsVideo = mediaPath != null && MediaStore.isVideo(mediaPath!);
          Future<void> pickMedia() async {
            try {
              final res = await FilePicker.platform.pickFiles(type: FileType.media);
              final path = res?.files.single.path;
              if (path != null) setSheet(() => mediaPath = path);
            } catch (_) {}
          }

          void flagName() {
            HapticFeedback.heavyImpact();
            Future.delayed(const Duration(milliseconds: 120), HapticFeedback.mediumImpact);
            setSheet(() {
              nameMissing = true;
              shakes++;
            });
            nameFocus.requestFocus();
            if (scroll.hasClients) {
              scroll.animateTo(0, duration: const Duration(milliseconds: 380), curve: Curves.easeOutCubic);
            }
          }

          final nameLine = BorderSide(color: nameMissing ? gc.danger : gc.border, width: nameMissing ? 1.5 : 1);
          final nameFocusLine = BorderSide(color: nameMissing ? gc.danger : gc.accent, width: nameMissing ? 1.5 : 1);
          return SafeArea(
            child: SingleChildScrollView(
              controller: scroll,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SheetTitle(titleCase(editing == null ? t.newExercise : t.editExercise),
                      subtitle: editing == null ? t.newExerciseHint : null),
                  const SizedBox(height: 18),
                  _Shake(
                    count: shakes,
                    child: TextField(
                      controller: nameCtrl,
                      focusNode: nameFocus,
                      autofocus: editing == null,
                      style: AppTheme.f(15, weight: FontWeight.w500, color: gc.text),
                      cursorColor: nameMissing ? gc.danger : gc.accent,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (v) {
                        if (nameMissing && v.trim().isNotEmpty) setSheet(() => nameMissing = false);
                      },
                      decoration: InputDecoration(
                        hintText: t.exerciseName,
                        hintStyle: AppTheme.f(15, weight: FontWeight.w500, color: gc.textTertiary),
                        filled: true,
                        fillColor: nameMissing ? gc.danger.withValues(alpha: 0.08) : gc.bgRaised2,
                        contentPadding: const EdgeInsets.all(14),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: nameLine),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: nameFocusLine),
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topLeft,
                    child: nameMissing
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8, left: 4),
                            child: Row(children: [
                              Icon(PhosphorIconsFill.warningCircle, size: 15, color: gc.danger),
                              const SizedBox(width: 6),
                              Text(t.exerciseNameMissing,
                                  style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.danger)),
                            ]),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                  const SizedBox(height: 22),
                  _filterLabel(gc, t.exerciseTypeLabel),
                  const SizedBox(height: 10),
                  Row(children: [
                    for (final (i, (id, label, icon)) in [
                      ('', t.typeReps, PhosphorIconsRegular.barbell),
                      ('time', t.typeTime, PhosphorIconsRegular.timer),
                      ('cardio', t.typeCardio, PhosphorIconsRegular.personSimpleRun),
                    ].indexed) ...[
                      if (i > 0) const SizedBox(width: 8),
                      Expanded(
                        child: Pressable(
                          scale: 0.96,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setSheet(() => mode = id);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOutCubic,
                            constraints: const BoxConstraints(minHeight: 88),
                            padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                            decoration: BoxDecoration(
                              color: mode == id ? gc.text : gc.bgRaised2,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Icon(icon, size: 22, color: mode == id ? gc.bg : gc.textSecondary),
                              const SizedBox(height: 10),
                              Text(label,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.f(12.5,
                                      weight: FontWeight.w700, color: mode == id ? gc.bg : gc.text, height: 1.2)),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ]),
                  const SizedBox(height: 22),
                  _filterLabel(gc, t.muscleFilter),
                  const SizedBox(height: 10),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    for (final zone in kBodyZones.entries)
                      Pill(
                        label: zone.value.length == 1 ? t.muscle(zone.value.single) : t.muscleGroupName(zone.key),
                        bg: zone.value.contains(muscle) ? gc.ember : gc.bgRaised2,
                        fg: zone.value.contains(muscle) ? gc.onEmber : gc.textSecondary,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setSheet(() {
                            openZone = zone.key;
                            if (!zone.value.contains(muscle)) {
                              muscle = zone.value.first;
                              secondary.remove(muscle);
                            }
                          });
                        },
                        hPad: 16,
                        vPad: 9,
                        fontSize: 13.5,
                      ),
                  ]),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: (kBodyZones[openZone]?.length ?? 0) > 1
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
                            child: Wrap(spacing: 8, runSpacing: 8, children: [
                              for (final id in kBodyZones[openZone]!)
                                Pill(
                                  label: t.muscle(id),
                                  bg: muscle == id ? gc.text : gc.bgRaised,
                                  fg: muscle == id ? gc.bg : gc.textSecondary,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setSheet(() {
                                      muscle = id;
                                      secondary.remove(id);
                                    });
                                  },
                                  vPad: 7,
                                  fontSize: 12.5,
                                ),
                            ]),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                  const SizedBox(height: 22),
                  _filterLabel(gc, t.equipmentLabel),
                  const SizedBox(height: 10),
                  Builder(builder: (_) {
                    const common = ['Bodyweight', 'Dumbbell', 'Barbell', 'Machine', 'Cable', 'Band'];
                    final rest = [for (final e in [...kEquipment, ...fit.customGear]) if (!common.contains(e)) e];
                    final all = allEquipment || rest.contains(equipment);
                    return Wrap(spacing: 8, runSpacing: 8, children: [
                      for (final e in [...common, if (all) ...rest])
                        Pill(
                          label: t.equipment(e),
                          bg: equipment == e ? gc.ember : gc.bgRaised2,
                          fg: equipment == e ? gc.onEmber : gc.textSecondary,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setSheet(() => equipment = e);
                          },
                          hPad: 14,
                          vPad: 8,
                          fontSize: 13,
                        ),
                      Pill(
                        label: t.equipNew,
                        bg: Colors.transparent,
                        fg: gc.accent,
                        onTap: () async {
                          final name = await askText(context, title: t.equipNewTitle, hint: t.equipNewHint);
                          if (name == null || name.trim().isEmpty) return;
                          final added = fit.addCustomGear(name);
                          setSheet(() {
                            equipment = added;
                            allEquipment = true;
                          });
                        },
                        hPad: 12,
                        vPad: 8,
                        fontSize: 13,
                      ),
                      if (!all)
                        Pill(
                          label: '+${rest.length}',
                          bg: Colors.transparent,
                          fg: gc.accent,
                          onTap: () => setSheet(() => allEquipment = true),
                          hPad: 12,
                          vPad: 8,
                          fontSize: 13,
                        ),
                    ]);
                  }),
                  const SizedBox(height: 22),
                  Pressable(
                    scale: 0.98,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setSheet(() => advanced = !advanced);
                    },
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                      child: Row(children: [
                        Icon(PhosphorIconsRegular.slidersHorizontal, size: 18, color: gc.textSecondary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(titleCase(t.advanced),
                              style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
                        ),
                        AnimatedRotation(
                          turns: advanced ? 0.5 : 0,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          child: Icon(PhosphorIconsBold.caretDown, size: 14, color: gc.textTertiary),
                        ),
                      ]),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: !advanced
                        ? const SizedBox(width: double.infinity)
                        : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                            const SizedBox(height: 18),
                            _filterLabel(gc, t.secondaryLabel),
                            const SizedBox(height: 8),
                            Wrap(spacing: 8, runSpacing: 8, children: [
                              for (final m in kMuscles)
                                if (m.id != muscle)
                                  Pill(
                                    label: t.muscle(m.id),
                                    bg: secondary.contains(m.id) ? gc.ember : gc.bgRaised2,
                                    fg: secondary.contains(m.id) ? gc.onEmber : gc.textSecondary,
                                    onTap: () => setSheet(() {
                                      if (!secondary.remove(m.id)) secondary.add(m.id);
                                    }),
                                    vPad: 7,
                                    fontSize: 12,
                                  ),
                            ]),
                            const SizedBox(height: 18),
                            _filterLabel(gc, t.levelFilter),
                            const SizedBox(height: 8),
                            SegToggle([
                              for (final d in kDifficulties)
                                SegOption(t.difficulty(d), difficulty == d, () => setSheet(() => difficulty = d)),
                            ], vPad: 8, fontSize: 12.5),
                            const SizedBox(height: 18),
                            _filterLabel(gc, t.kindLabel),
                            const SizedBox(height: 8),
                            Builder(builder: (_) {
                              final shown = kind.isNotEmpty
                                  ? kind
                                  : mode == 'cardio'
                                      ? 'cardio'
                                      : (kCalisthenicsEquipment.contains(equipment) ? 'calisthenics' : 'strength');
                              return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                Wrap(spacing: 8, runSpacing: 8, children: [
                                  for (final k in kExerciseKinds)
                                    Pill(
                                      label: t.exerciseKind(k),
                                      bg: shown == k ? gc.ember : gc.bgRaised2,
                                      fg: shown == k ? gc.onEmber : gc.textSecondary,
                                      onTap: () => setSheet(() => kind = k),
                                      vPad: 7,
                                      fontSize: 12,
                                    ),
                                ]),
                                if (shown == 'cardio')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 4),
                                    child: Row(children: [
                                      Icon(PhosphorIconsRegular.info, size: 14, color: gc.textTertiary),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(t.cardioNoSets,
                                            style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
                                      ),
                                    ]),
                                  ),
                              ]);
                            }),
                            const SizedBox(height: 18),
                            _filterLabel(gc, t.howToLabel),
                            const SizedBox(height: 8),
                            TextField(
                              controller: stepsCtrl,
                              minLines: 3,
                              maxLines: 8,
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
                              style: AppTheme.f(14, weight: FontWeight.w500, color: gc.text, height: 1.45),
                              cursorColor: gc.accent,
                              decoration: InputDecoration(
                                hintText: t.howToHint,
                                hintStyle: AppTheme.f(14, weight: FontWeight.w500, color: gc.textTertiary),
                                filled: true,
                                fillColor: gc.bgRaised2,
                                contentPadding: const EdgeInsets.all(14),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.border)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.accent)),
                              ),
                            ),
                            const SizedBox(height: 18),
                            _filterLabel(gc, t.aliasesLabel),
                            const SizedBox(height: 8),
                            TextField(
                              controller: aliasCtrl,
                              style: AppTheme.f(14, weight: FontWeight.w500, color: gc.text),
                              cursorColor: gc.accent,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: t.aliasesHint,
                                hintStyle: AppTheme.f(14, weight: FontWeight.w500, color: gc.textTertiary),
                                filled: true,
                                fillColor: gc.bgRaised2,
                                contentPadding: const EdgeInsets.all(14),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.border)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: gc.accent)),
                              ),
                            ),
                            if (editing == null) ...[
                              const SizedBox(height: 18),
                              _filterLabel(gc, t.demoMedia),
                              const SizedBox(height: 8),
                    if (mediaPath == null)
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: pickMedia,
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: gc.bgRaised2,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: gc.border),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(PhosphorIconsRegular.uploadSimple, size: 26, color: gc.textSecondary),
                                        const SizedBox(height: 8),
                                        Text(t.addMedia, style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.textSecondary)),
                                        const SizedBox(height: 2),
                                        Text(t.mediaHint, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Stack(
                                  children: [
                                    Container(
                                      height: 160,
                                      decoration: BoxDecoration(
                                        color: gc.bgRaised2,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: gc.border),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: mediaIsVideo
                                          ? Center(
                                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                                Icon(PhosphorIconsFill.playCircle, size: 40, color: gc.textSecondary),
                                                const SizedBox(height: 6),
                                                Text(t.videoSelected,
                                                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                                              ]),
                                            )
                                          : Center(child: Image.file(File(mediaPath!), fit: BoxFit.contain, alignment: Alignment.center)),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () => setSheet(() => mediaPath = null),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(color: gc.bg.withValues(alpha: 0.8), shape: BoxShape.circle),
                                          child: Icon(PhosphorIconsRegular.x, size: 14, color: gc.text),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: pickMedia,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(color: gc.bg.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(100)),
                                          child: Text(t.changeMedia, style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.text)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ]),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: editing == null ? t.addExercise : t.saveChanges,
                    onTap: () async {
                      if (busy) return;
                      if (nameCtrl.text.trim().isEmpty) return flagName();
                      busy = true;
                      final steps = stepsCtrl.text.split('\n');
                      final aliases = aliasCtrl.text.split(RegExp(r'[,;\n]'));
                      if (editing != null) {
                        fit.updateCustomExercise(editing.id,
                            name: nameCtrl.text,
                            primary: muscle,
                            equipment: equipment,
                            difficulty: difficulty,
                            steps: steps,
                            mode: mode,
                            secondary: secondary.toList(),
                            aliases: aliases,
                            kind: kind);
                        Navigator.pop(sheetCtx);
                        return;
                      }
                      final id = fit.addCustomExercise(
                          name: nameCtrl.text,
                          primary: muscle,
                          equipment: equipment,
                          difficulty: difficulty,
                          steps: steps,
                          mode: mode,
                          secondary: secondary.toList(),
                          aliases: aliases,
                          kind: kind);
                      if (mediaPath != null) {
                        await fit.attachExerciseMedia(id, mediaPath!);
                      }
                      if (!sheetCtx.mounted) return;
                      Navigator.pop(sheetCtx);
                      if (onCreated != null) {
                        onCreated(id);
                      } else {
                        fit.openExercise(id);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}


class _Shake extends StatelessWidget {
  const _Shake({required this.count, required this.child});
  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: count.toDouble()),
        duration: const Duration(milliseconds: 460),
        builder: (_, v, child) {
          final p = v - v.floorToDouble();
          return Transform.translate(offset: Offset(math.sin(p * math.pi * 6) * 8 * (1 - p), 0), child: child);
        },
        child: child,
      );
}

void _clearFilters(VoidCallback? onClear) {
  fit.clearExFilters();
  onClear?.call();
}

void showExerciseFilters(BuildContext context, {VoidCallback? onClear}) => showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _FilterSheet(onClear: onClear),
    );

bool get _showGroupOn =>
    fit.customExercises.isNotEmpty || fit.archived.isNotEmpty || fit.exMineOnly || fit.exArchivedOnly;

int get _sheetFilters =>
    (fit.activePlaceId.isEmpty ? 0 : 1) +
    (fit.exEquipmentFilter == null && !fit.exNoGearOnly ? 0 : 1) +
    (fit.exDifficultyFilter == null ? 0 : 1) +
    (fit.exKindFilter == null ? 0 : 1) +
    (fit.exMineOnly ? 1 : 0) +
    (fit.exArchivedOnly ? 1 : 0);

class _FilterSheet extends StatelessWidget {
  const _FilterSheet({this.onClear});

  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    void tap(VoidCallback apply) {
      HapticFeedback.selectionClick();
      apply();
    }

    Widget group(String label, List<_FilterChipData> chips) => Padding(
          padding: const EdgeInsets.only(bottom: 22),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsetsDirectional.only(start: 2), child: SectionLabel(label)),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final c in chips)
                Pill(
                  label: c.label,
                  bg: c.active ? gc.ember : gc.bgRaised2,
                  fg: c.active ? gc.onEmber : gc.textSecondary,
                  onTap: () => tap(c.onTap),
                  hPad: 14,
                  vPad: 8,
                  fontSize: 13,
                ),
            ]),
          ]),
        );

    return ListenableBuilder(
      listenable: fit,
      builder: (sheet, _) => AppSheet(children: [
        SheetTitle(titleCase(t.filters)),
        const SizedBox(height: 22),
        group(t.kindLabel, [
          for (final k in kExerciseKinds)
            _FilterChipData(t.exerciseKind(k), fit.exKindFilter == k, () => fit.setKindFilter(k)),
        ]),
        group(t.equipmentLabel, [
          _FilterChipData(t.noGearOnly, fit.exNoGearOnly, fit.toggleNoGearFilter),
          for (final e in kFilterEquipment)
            _FilterChipData(t.equipment(e), fit.exEquipmentFilter == e, () => fit.setEquipmentFilter(e)),
        ]),
        group(t.levelFilter, [
          for (final d in kDifficulties)
            _FilterChipData(t.difficulty(d), fit.exDifficultyFilter == d, () => fit.setDifficultyFilter(d)),
        ]),
        if (_showGroupOn)
          group(t.filterShowLabel, [
            if (fit.customExercises.isNotEmpty || fit.exMineOnly)
              _FilterChipData(t.mineOnly, fit.exMineOnly, fit.toggleMineFilter),
            if (fit.archived.isNotEmpty || fit.exArchivedOnly)
              _FilterChipData('${t.archivedFilter} · ${fit.archived.length}', fit.exArchivedOnly,
                  fit.toggleArchivedFilter),
          ]),
        group(t.placeFilterLabel, [
          if (fit.places.isNotEmpty)
            _FilterChipData(t.placeAll, fit.activePlaceId.isEmpty, () => fit.setActivePlace('')),
          for (final place in fit.places)
            _FilterChipData(place.name, fit.activePlaceId == place.id, () => fit.setActivePlace(place.id)),
          _FilterChipData(fit.places.isEmpty ? t.placeNew : '+', false, () {
            Navigator.pop(sheet);
            fit.goPlaces();
          }),
        ]),
        PrimaryButton(label: t.libraryCount(fit.exercisesFiltered.length), onTap: () => Navigator.pop(sheet)),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: _sheetFilters == 0
              ? const SizedBox(width: double.infinity)
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => tap(() => _clearFilters(onClear)),
                  child: Container(
                    height: 44,
                    margin: const EdgeInsets.only(top: 6),
                    alignment: Alignment.center,
                    child: Text(t.clearFilters, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
                  ),
                ),
        ),
      ]),
    );
  }
}

Widget _filterLabel(GymColors gc, String label) => Text(label.toUpperCase(),
    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4));

Future<void> showBodyZones(BuildContext context) => showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) {
        final gc = sheet.gc;
        void pick(VoidCallback apply) {
          HapticFeedback.selectionClick();
          apply();
          Navigator.of(sheet).pop();
        }

        return Container(
          padding: sheetPad(sheet),
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.9),
          decoration: sheetDecoration(gc),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 18),
              Text(t.byZone, style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
              const SizedBox(height: 6),
              Flexible(
                child: SingleChildScrollView(
                  child: LayoutBuilder(builder: (context, box) {
                    final w = (box.maxWidth - 16) / 3;
                    final singles = [for (final z in kBodyZones.values) if (z.length == 1) z.single];
                    Widget card(String m) => SizedBox(
                          width: w,
                          child: _ZoneCard(
                            muscles: [m],
                            label: muscleLabel(m),
                            selected: fit.exMuscleFilter == m,
                            onTap: () => pick(() => fit.setMuscleFilter(m)),
                          ),
                        );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        Wrap(spacing: 8, runSpacing: 8, children: [for (final m in singles) card(m)]),
                        for (final zone in kBodyZones.entries)
                          if (zone.value.length > 1) ...[
                          _ZoneHeader(
                            zone: zone.key,
                            selected: fit.exZoneFilter == zone.key,
                            onTap: () => pick(() => fit.setZoneFilter(fit.exZoneFilter == zone.key ? null : zone.key)),
                          ),
                          Wrap(spacing: 8, runSpacing: 8, children: [for (final m in zone.value) card(m)]),
                        ],
                        const SizedBox(height: 6),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );

class _ZoneHeader extends StatelessWidget {
  const _ZoneHeader({required this.zone, required this.selected, this.onTap});

  final String zone;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 18, 2, 10),
        child: Row(children: [
          Expanded(
            child: Text(t.muscleGroupName(zone).toUpperCase(),
                style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textSecondary, letterSpacing: 1.3)),
          ),
          if (onTap != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: selected ? gc.ember : gc.bgRaised2,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text('${t.allExercisesShort} · ${fit.zoneCount(zone)}',
                  style: AppTheme.f(11.5, weight: FontWeight.w700, color: selected ? gc.onEmber : gc.textSecondary)),
            ),
        ]),
      ),
    );
  }
}

class _ZoneCard extends StatelessWidget {
  const _ZoneCard({required this.muscles, required this.label, required this.selected, required this.onTap});

  final List<String> muscles;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
          decoration: BoxDecoration(
            color: gc.bgRaised2,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: selected ? gc.text : Colors.transparent, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 92,
                width: double.infinity,
                child: FittedBox(child: BodyZoneArt(muscles: muscles, height: 92)),
              ),
              const SizedBox(height: 10),
              Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(height: 1),
              Text(t.exerciseCount(fit.musclesCount(muscles)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(11, weight: FontWeight.w500, color: gc.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarPop extends StatefulWidget {
  const _StarPop({required this.on, required this.child});

  final bool on;
  final Widget child;

  @override
  State<_StarPop> createState() => _StarPopState();
}

class _StarPopState extends State<_StarPop> with SingleTickerProviderStateMixin {
  late final _pop = AnimationController(vsync: this, duration: const Duration(milliseconds: 620), value: 1);

  @override
  void didUpdateWidget(_StarPop old) {
    super.didUpdateWidget(old);
    if (widget.on && !old.on) {
      HapticFeedback.lightImpact();
      _pop.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return AnimatedBuilder(
      animation: _pop,
      child: widget.child,
      builder: (context, child) {
        final v = _pop.value;
        final scale = v >= 1 ? 1.0 : 1 + 0.5 * math.sin(v * math.pi) * (1 - v * 0.4);
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (v < 1)
              Container(
                width: 18 + 22 * v,
                height: 18 + 22 * v,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: gc.accent.withValues(alpha: (1 - v) * 0.7), width: 2 * (1 - v) + 0.4),
                ),
              ),
            Transform.scale(scale: scale, child: child),
          ],
        );
      },
    );
  }
}
