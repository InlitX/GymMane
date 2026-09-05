import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/exercise_media.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});
  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late final TextEditingController _c = TextEditingController(text: fit.exSearch);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final list = fit.exercisesFiltered;

    return SafeArea(
      bottom: false,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
        itemCount: (list.isEmpty ? 1 : list.length) + 1,
        itemBuilder: (context, i) {
          if (i == 0) return _header(gc, list.length);
          if (list.isEmpty) return _empty(gc);
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _card(gc, list[i - 1]),
          );
        },
      ),
    );
  }

  Widget _header(GymColors gc, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScreenTitle(t.exercises),
        const SizedBox(height: 4),
        Text(t.libraryCount(count), style: AppTheme.s(13, color: gc.textSecondary)),
        const SizedBox(height: 14),
        SearchField(controller: _c, hint: t.searchExercises, onChanged: fit.setExSearch),
        const SizedBox(height: 14),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: fit.toggleFavouritesFilter,
          child: Semantics(
            button: true,
            selected: fit.exFavouritesOnly,
            child: Container(
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fit.exFavouritesOnly ? gc.accentSoft : Colors.transparent,
                border: Border.all(color: fit.exFavouritesOnly ? gc.accent : gc.border),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _star(gc, fit.exFavouritesOnly),
                  const SizedBox(width: 8),
                  Text(
                    fit.favouriteCount > 0
                        ? '${t.favouritesOnly.toUpperCase()} · ${fit.favouriteCount}'
                        : t.favouritesOnly.toUpperCase(),
                    style: AppTheme.d(13,
                        weight: FontWeight.w600,
                        color: fit.exFavouritesOnly ? gc.accent : gc.text,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        _filterLabel(gc, t.placeFilterLabel),
        const SizedBox(height: 8),
        _chipRow([
          _FilterChipData(t.placeAll, fit.activePlaceId.isEmpty,
              () => fit.setActivePlace('')),
          for (final place in fit.places)
            _FilterChipData(place.name, fit.activePlaceId == place.id,
                () => fit.setActivePlace(place.id)),
          _FilterChipData(fit.places.isEmpty ? t.placeNew : '+', false, fit.goPlaces),
        ], gc, hPad: 14, vPad: 8, fontSize: 13),
        const SizedBox(height: 14),
        _filterLabel(gc, t.muscleFilter),
        const SizedBox(height: 8),
        _chipRow([
          for (final id in kFilterMuscles)
            _FilterChipData(muscleLabel(id), fit.exMuscleFilter == id, () => fit.setMuscleFilter(id)),
        ], gc, hPad: 14, vPad: 8, fontSize: 13),
        const SizedBox(height: 14),
        _filterLabel(gc, t.equipmentLabel),
        const SizedBox(height: 8),
        _chipRow([
          _FilterChipData(t.noGearOnly, fit.exNoGearOnly, fit.toggleNoGearFilter),
          for (final e in kFilterEquipment)
            _FilterChipData(
                t.equipment(e), fit.exEquipmentFilter == e, () => fit.setEquipmentFilter(e)),
        ], gc, hPad: 12, vPad: 6, fontSize: 12),
        const SizedBox(height: 14),
        _filterLabel(gc, t.levelFilter),
        const SizedBox(height: 8),
        _chipRow([
          for (final d in kDifficulties)
            _FilterChipData(t.difficulty(d), fit.exDifficultyFilter == d, () => fit.setDifficultyFilter(d)),
        ], gc, hPad: 12, vPad: 6, fontSize: 12),
        const SizedBox(height: 14),
        GhostButton(
          label: t.newExercise,
          icon: PhosphorIconsRegular.plus,
          onTap: () => showCreateExerciseSheet(context),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _filterLabel(GymColors gc, String t) =>
      Text(t, style: AppTheme.s(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5));

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
              style: AppTheme.s(15, weight: FontWeight.w600, color: gc.text)),
          const SizedBox(height: 4),
          Text(noFavs ? t.noFavouritesHint : t.noExercisesHint,
              textAlign: TextAlign.center, style: AppTheme.s(13, color: gc.textSecondary)),
          const SizedBox(height: 16),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: fit.clearExFilters,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(t.clearFilters,
                  style: AppTheme.s(13, weight: FontWeight.w600, color: gc.accent)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(GymColors gc, Exercise ex) {
    final fav = fit.favorites[ex.id] ?? false;
    final diffColor = ex.difficulty == 'Beginner'
        ? gc.sage
        : ex.difficulty == 'Advanced'
            ? gc.accent
            : gc.textSecondary;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => fit.openExercise(ex.id),
                child: SizedBox(width: 64, child: ExerciseMedia(ex: ex, height: 64, radius: 14)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: GestureDetector(
                  onTap: () => fit.openExercise(ex.id),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text(exerciseName(ex), style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
                      ),
                      const SizedBox(height: 6),
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(100)),
                          child: Text(muscleLabel(ex.primary),
                              style: AppTheme.s(11, weight: FontWeight.w600, color: gc.accent)),
                        ),
                        const SizedBox(width: 6),
                        Text(t.equipment(ex.equipment), style: AppTheme.s(12, color: gc.textSecondary)),
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        Container(width: 6, height: 6, decoration: BoxDecoration(color: diffColor, shape: BoxShape.circle)),
                        const SizedBox(width: 5),
                        Text(t.difficulty(ex.difficulty), style: AppTheme.s(11, color: gc.textTertiary)),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => fit.toggleFavorite(ex.id),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: _star(gc, fav),
              ),
            ),
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

void showCreateExerciseSheet(BuildContext context, {void Function(String id)? onCreated}) {
  final gc = context.gc;
  final nameCtrl = TextEditingController();
  String muscle = kMuscles.first.id;
  String equipment = kEquipment.first;
  String difficulty = kDifficulties.first;
  bool advanced = false;
  String? mediaPath;
  bool busy = false;
  showModalBottomSheet<void>(
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

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(t.newExercise,
                      style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameCtrl,
                    autofocus: true,
                    style: AppTheme.s(15, color: gc.text),
                    cursorColor: gc.accent,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: t.exerciseName,
                      hintStyle: AppTheme.s(15, color: gc.textTertiary),
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
                  Text(t.muscleFilter, style: AppTheme.s(11, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    for (final m in kMuscles)
                      Pill(
                        label: t.muscle(m.id),
                        bg: muscle == m.id ? gc.ember : gc.bgRaised2,
                        fg: muscle == m.id ? gc.onEmber : gc.textSecondary,
                        onTap: () => setSheet(() => muscle = m.id),
                        vPad: 7,
                        fontSize: 12,
                      ),
                  ]),
                  const SizedBox(height: 16),
                  Text(t.equipmentLabel, style: AppTheme.s(11, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
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
                  Text(t.levelFilter, style: AppTheme.s(11, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setSheet(() => advanced = !advanced),
                    child: Row(
                      children: [
                        Icon(advanced ? PhosphorIconsRegular.caretDown : PhosphorIconsRegular.caretRight,
                            size: 16, color: gc.textSecondary),
                        const SizedBox(width: 8),
                        Text(t.advanced,
                            style: AppTheme.s(11, weight: FontWeight.w700, color: gc.textSecondary, letterSpacing: 1.5)),
                      ],
                    ),
                  ),
                  if (advanced) ...[
                    const SizedBox(height: 12),
                    Text(t.demoMedia, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1.5)),
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
                              Text(t.addMedia, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary)),
                              const SizedBox(height: 2),
                              Text(t.mediaHint, style: AppTheme.s(11, color: gc.textTertiary)),
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
                                      Text(t.videoSelected, style: AppTheme.s(12, color: gc.textSecondary)),
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
                                child: Text(t.changeMedia, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.text)),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: t.addExercise,
                    onTap: () async {
                      if (busy || nameCtrl.text.trim().isEmpty) return;
                      busy = true;
                      final id = fit.addCustomExercise(
                          name: nameCtrl.text, primary: muscle, equipment: equipment, difficulty: difficulty);
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
