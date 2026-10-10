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
    _scroll.dispose();
    _deep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final list = fit.exercisesFiltered;

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: _header(context, gc, list.length),
          ),
          Expanded(
            child: Stack(children: [
              Positioned.fill(
                child: ListView.builder(
              key: const PageStorageKey('exercises'),
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
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
                        child: Text(muscleLabel(ex.primary).toUpperCase(),
                            style: AppTheme.f(10.5,
                                weight: FontWeight.w700,
                                color: gc.textTertiary,
                                letterSpacing: 1.3)),
                      ),
                    ],
                    _row(gc, ex, first: first, last: last),
                  ],
                );
              },
                ),
              ),
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
            ]),
          ),
        ],
      ),
    );
  }

  int get _activeFilters =>
      (fit.activePlaceId.isEmpty ? 0 : 1) +
      (fit.exMuscleFilter == null ? 0 : 1) +
      (fit.exEquipmentFilter == null ? 0 : 1) +
      (fit.exDifficultyFilter == null ? 0 : 1) +
      (fit.exKindFilter == null || fit.exKindFilter == 'cardio' ? 0 : 1);

  void _clearAll() {
    _c.clear();
    fit.clearExFilters();
  }

  Widget _header(BuildContext context, GymColors gc, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenTitle(t.exercises),
                  const SizedBox(height: 4),
                  Text(t.libraryCount(count),
                      style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
                ],
              ),
            ),
            RoundAction(
              size: 40,
              label: t.newExercise,
              onTap: () => showCreateExerciseSheet(context, initialName: _c.text),
              child: Icon(PhosphorIconsRegular.plus, size: 17, color: gc.text),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SearchField(controller: _c, hint: t.searchExercises, onChanged: fit.setExSearch),
        const SizedBox(height: 10),
        _quickChips(context, gc),
      ],
    );
  }

  Widget _quickChips(BuildContext context, GymColors gc) {
    final active = _activeFilters;
    final anyOn = active > 0 ||
        fit.exKindFilter != null ||
        fit.exNoGearOnly ||
        fit.exFavouritesOnly ||
        fit.exMineOnly ||
        fit.exArchivedOnly;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(children: [
        Pill(
          label: active > 0 ? '${t.filters} · $active' : t.filters,
          bg: active > 0 ? gc.ember : gc.bgRaised2,
          fg: active > 0 ? gc.onEmber : gc.textSecondary,
          onTap: () => showExerciseFilters(context, onClear: _c.clear),
          hPad: 14,
          vPad: 7,
          fontSize: 12.5,
        ),
        const SizedBox(width: 8),
        Pill(
          label: fit.favouriteCount > 0
              ? '${t.favouritesOnly} · ${fit.favouriteCount}'
              : t.favouritesOnly,
          bg: fit.exFavouritesOnly ? gc.ember : gc.bgRaised2,
          fg: fit.exFavouritesOnly ? gc.onEmber : gc.textSecondary,
          onTap: fit.toggleFavouritesFilter,
          hPad: 14,
          vPad: 7,
          fontSize: 12.5,
        ),
        const SizedBox(width: 8),
        Pill(
          label: t.noGearOnly,
          bg: fit.exNoGearOnly ? gc.ember : gc.bgRaised2,
          fg: fit.exNoGearOnly ? gc.onEmber : gc.textSecondary,
          onTap: fit.toggleNoGearFilter,
          hPad: 14,
          vPad: 7,
          fontSize: 12.5,
        ),
        const SizedBox(width: 8),
        Pill(
          label: t.kindCardio,
          bg: fit.exKindFilter == 'cardio' ? gc.ember : gc.bgRaised2,
          fg: fit.exKindFilter == 'cardio' ? gc.onEmber : gc.textSecondary,
          onTap: () => fit.setKindFilter('cardio'),
          hPad: 14,
          vPad: 7,
          fontSize: 12.5,
        ),
        if (fit.customExercises.isNotEmpty || fit.exMineOnly) ...[
          const SizedBox(width: 8),
          Pill(
            label: t.mineOnly,
            bg: fit.exMineOnly ? gc.ember : gc.bgRaised2,
            fg: fit.exMineOnly ? gc.onEmber : gc.textSecondary,
            onTap: fit.toggleMineFilter,
            hPad: 14,
            vPad: 7,
            fontSize: 12.5,
          ),
        ],
        if (fit.archived.isNotEmpty) ...[
          const SizedBox(width: 8),
          Pill(
            label: '${t.archivedFilter} · ${fit.archived.length}',
            bg: fit.exArchivedOnly ? gc.ember : gc.bgRaised2,
            fg: fit.exArchivedOnly ? gc.onEmber : gc.textSecondary,
            onTap: fit.toggleArchivedFilter,
            hPad: 14,
            vPad: 7,
            fontSize: 12.5,
          ),
        ],
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

  Widget _row(GymColors gc, Exercise ex, {required bool first, required bool last}) {
    final fav = fit.favorites[ex.id] ?? false;
    return Container(
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(first ? 20 : 0),
          bottom: Radius.circular(last ? 20 : 0),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => fit.openExercise(ex.id),
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
              margin: const EdgeInsets.only(left: 77),
              height: 1,
              color: gc.border.withValues(alpha: 0.55),
            ),
        ],
      ),
    );
  }

  Widget _star(GymColors gc, bool fav) {
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
  String? mediaPath;
  bool busy = false;
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: gc.bgRaised,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
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
                  Text(titleCase(editing == null ? t.newExercise : t.editExercise),
                      style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  _filterLabel(gc, t.muscleFilter),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    for (final m in kMuscles)
                      Pill(
                        label: t.muscle(m.id),
                        bg: muscle == m.id ? gc.ember : gc.bgRaised2,
                        fg: muscle == m.id ? gc.onEmber : gc.textSecondary,
                        onTap: () => setSheet(() {
                          muscle = m.id;
                          secondary.remove(m.id);
                        }),
                        vPad: 7,
                        fontSize: 12,
                      ),
                  ]),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  _filterLabel(gc, t.equipmentLabel),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    for (final e in kEquipment)
                      Pill(
                        label: t.equipment(e),
                        bg: equipment == e ? gc.ember : gc.bgRaised2,
                        fg: equipment == e ? gc.onEmber : gc.textSecondary,
                        onTap: () => setSheet(() => equipment = e),
                        vPad: 7,
                        fontSize: 12,
                      ),
                  ]),
                  const SizedBox(height: 16),
                  _filterLabel(gc, t.levelFilter),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    for (final d in kDifficulties)
                      Pill(
                        label: t.difficulty(d),
                        bg: difficulty == d ? gc.ember : gc.bgRaised2,
                        fg: difficulty == d ? gc.onEmber : gc.textSecondary,
                        onTap: () => setSheet(() => difficulty = d),
                        vPad: 7,
                        fontSize: 12,
                      ),
                  ]),
                  const SizedBox(height: 16),
                  _filterLabel(gc, t.exerciseTypeLabel),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    for (final (id, label) in [
                      ('', t.typeReps),
                      ('time', t.typeTime),
                      ('cardio', t.typeCardio),
                    ])
                      Pill(
                        label: label,
                        bg: mode == id ? gc.ember : gc.bgRaised2,
                        fg: mode == id ? gc.onEmber : gc.textSecondary,
                        onTap: () => setSheet(() => mode = id),
                        vPad: 7,
                        fontSize: 12,
                      ),
                  ]),
                  const SizedBox(height: 16),
                  _filterLabel(gc, t.kindLabel),
                  const SizedBox(height: 8),
                  Builder(builder: (_) {
                    final shown = kind.isNotEmpty
                        ? kind
                        : mode == 'cardio'
                            ? 'cardio'
                            : (kCalisthenicsEquipment.contains(equipment) ? 'calisthenics' : 'strength');
                    return Wrap(spacing: 8, runSpacing: 8, children: [
                      for (final k in kExerciseKinds)
                        Pill(
                          label: t.exerciseKind(k),
                          bg: shown == k ? gc.ember : gc.bgRaised2,
                          fg: shown == k ? gc.onEmber : gc.textSecondary,
                          onTap: () => setSheet(() => kind = k),
                          vPad: 7,
                          fontSize: 12,
                        ),
                    ]);
                  }),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  if (editing == null)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setSheet(() => advanced = !advanced),
                    child: Row(
                      children: [
                        Icon(advanced ? PhosphorIconsRegular.caretDown : PhosphorIconsRegular.caretRight,
                            size: 16, color: gc.textSecondary),
                        const SizedBox(width: 8),
                        Text(t.advanced,
                            style: AppTheme.f(11, weight: FontWeight.w700, color: gc.textSecondary, letterSpacing: 1.3)),
                      ],
                    ),
                  ),
                  if (advanced) ...[
                    const SizedBox(height: 12),
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

void showExerciseFilters(BuildContext context, {VoidCallback? onClear}) {
  final gc = context.gc;
  showAppSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheet) => StatefulBuilder(
      builder: (sheet, setSheet) => Container(
        padding: sheetPad(sheet),
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.85),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 18),
              Text(titleCase(t.filters),
                  textAlign: TextAlign.center,
                  style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
              const SizedBox(height: 18),
              _filterLabel(gc, t.placeFilterLabel),
              const SizedBox(height: 8),
              _chipRow([
                _FilterChipData(t.placeAll, fit.activePlaceId.isEmpty,
                    () => setSheet(() => fit.setActivePlace(''))),
                for (final place in fit.places)
                  _FilterChipData(place.name, fit.activePlaceId == place.id,
                      () => setSheet(() => fit.setActivePlace(place.id))),
                _FilterChipData(fit.places.isEmpty ? t.placeNew : '+', false, () {
                  Navigator.pop(sheet);
                  fit.goPlaces();
                }),
              ], gc, hPad: 14, vPad: 8, fontSize: 13),
              const SizedBox(height: 16),
              _filterLabel(gc, t.kindLabel),
              const SizedBox(height: 8),
              _chipRow([
                for (final k in kExerciseKinds)
                  _FilterChipData(t.exerciseKind(k), fit.exKindFilter == k,
                      () => setSheet(() => fit.setKindFilter(k))),
              ], gc, hPad: 12, vPad: 6, fontSize: 12),
              const SizedBox(height: 16),
              _filterLabel(gc, t.muscleFilter),
              const SizedBox(height: 8),
              _chipRow([
                for (final id in kFilterMuscles)
                  _FilterChipData(muscleLabel(id), fit.exMuscleFilter == id,
                      () => setSheet(() => fit.setMuscleFilter(id))),
              ], gc, hPad: 14, vPad: 8, fontSize: 13),
              const SizedBox(height: 16),
              _filterLabel(gc, t.equipmentLabel),
              const SizedBox(height: 8),
              _chipRow([
                _FilterChipData(
                    t.noGearOnly, fit.exNoGearOnly, () => setSheet(fit.toggleNoGearFilter)),
                for (final e in kFilterEquipment)
                  _FilterChipData(t.equipment(e), fit.exEquipmentFilter == e,
                      () => setSheet(() => fit.setEquipmentFilter(e))),
              ], gc, hPad: 12, vPad: 6, fontSize: 12),
              const SizedBox(height: 16),
              _filterLabel(gc, t.levelFilter),
              const SizedBox(height: 8),
              _chipRow([
                for (final d in kDifficulties)
                  _FilterChipData(t.difficulty(d), fit.exDifficultyFilter == d,
                      () => setSheet(() => fit.setDifficultyFilter(d))),
              ], gc, hPad: 12, vPad: 6, fontSize: 12),
              const SizedBox(height: 22),
              PrimaryButton(
                  label: t.libraryCount(fit.exercisesFiltered.length),
                  onTap: () => Navigator.pop(sheet)),
              const SizedBox(height: 6),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setSheet(() => _clearFilters(onClear)),
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  child: Text(t.clearFilters,
                      style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _filterLabel(GymColors gc, String label) => Text(label.toUpperCase(),
    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3));

Widget _chipRow(List<_FilterChipData> chips, GymColors gc,
    {required double hPad, required double vPad, required double fontSize}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(children: [
      for (int i = 0; i < chips.length; i++) ...[
        Pill(
          label: chips[i].label,
          bg: chips[i].active ? gc.ember : gc.bgRaised2,
          fg: chips[i].active ? gc.onEmber : gc.textSecondary,
          onTap: chips[i].onTap,
          hPad: hPad,
          vPad: vPad,
          fontSize: fontSize,
        ),
        if (i < chips.length - 1) const SizedBox(width: 8),
      ],
    ]),
  );
}
