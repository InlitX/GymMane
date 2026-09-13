import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/place.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/ui_kit.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final places = fit.places;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: ScreenHeader(
              title: t.places,
              subtitle: fit.activePlace == null ? t.placeAll : t.placeActive(fit.activePlace!.name),
              onBack: fit.backFromPlaces,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              children: [
                Text(t.placesHint, style: AppTheme.s(13, color: gc.textSecondary, height: 1.5)),
                const SizedBox(height: 18),
                if (places.isEmpty) _empty(context, gc),
                for (final place in places) ...[
                  _card(context, gc, place),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 4),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _rename(context, null),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: gc.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(PhosphorIconsRegular.plus, size: 16, color: gc.ember),
                        const SizedBox(width: 8),
                        Text(t.placeNew,
                            style: AppTheme.d(13,
                                weight: FontWeight.w600, color: gc.text, letterSpacing: 1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _empty(BuildContext context, GymColors gc) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.placeEmptyTitle,
                style: AppTheme.d(17, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 6),
            Text(t.placeEmptyBody,
                style: AppTheme.s(13, color: gc.textSecondary, height: 1.5)),
            const SizedBox(height: 16),
            Row(
              children: [
                for (final preset in kPlacePresets) ...[
                  if (preset != kPlacePresets.first) const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => fit.setActivePlace(fit.addPresetPlace(preset)),
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: gc.bgRaised2,
                          border: Border.all(color: gc.border),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(t.placePresetName(preset),
                                maxLines: 1,
                                style: AppTheme.s(13,
                                    weight: FontWeight.w600, color: gc.text)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      );

  Widget _card(BuildContext context, GymColors gc, GymPlace place) {
    final on = fit.activePlaceId == place.id;

    return Container(
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: on ? gc.ember : gc.border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
            child: Row(
              children: [
                Semantics(
                  button: true,
                  selected: on,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => fit.setActivePlace(place.id),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: on ? gc.ember : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: on ? gc.ember : gc.textTertiary, width: 1.5),
                      ),
                      child: on
                          ? Icon(PhosphorIconsBold.check, size: 14, color: gc.onEmber)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => fit.setActivePlace(place.id),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(place.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.d(17, weight: FontWeight.w700, color: gc.text)),
                        const SizedBox(height: 2),
                        Text(t.placeExercises(fit.placeExerciseCount(place)),
                            style: AppTheme.s(12, color: gc.textTertiary)),
                      ],
                    ),
                  ),
                ),
                Semantics(
                  button: true,
                  label: t.editEntry,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _rename(context, place),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(PhosphorIconsRegular.pencilSimple, size: 16, color: gc.textSecondary),
                    ),
                  ),
                ),
                Semantics(
                  button: true,
                  label: t.delete,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _confirmDelete(context, place),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(PhosphorIconsRegular.trash, size: 16, color: gc.textTertiary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.placeGearLabel,
                    style: AppTheme.s(10,
                        weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final gear in kEquipment)
                      _gearChip(gc, place, gear),
                  ],
                ),
                if (place.equipment.contains('Barbell')) ...[
                  const SizedBox(height: 14),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _editPlates(context, place),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: gc.bgRaised2,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Icon(PhosphorIconsRegular.circlesThree, size: 17, color: gc.textSecondary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(t.placePlates,
                                style: AppTheme.s(13, weight: FontWeight.w600, color: gc.text)),
                          ),
                          Text(
                            place.plates.isEmpty ? t.platesAll : t.platesOwned(place.plates.length),
                            style: AppTheme.s(12, color: gc.textSecondary),
                          ),
                          const SizedBox(width: 6),
                          Icon(PhosphorIconsRegular.caretRight, size: 14, color: gc.textTertiary),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gearChip(GymColors gc, GymPlace place, String gear) {
    final on = place.equipment.contains(gear) || gear == 'Bodyweight';
    final locked = gear == 'Bodyweight';

    return Semantics(
      button: !locked,
      selected: on,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: locked ? null : () => fit.togglePlaceGear(place.id, gear),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: on ? gc.emberSoft : gc.bgRaised2,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: on ? gc.ember : gc.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(on ? PhosphorIconsBold.check : PhosphorIconsBold.plus,
                  size: 10, color: on ? gc.ember : gc.textTertiary),
              const SizedBox(width: 6),
              Text(t.equipment(gear),
                  style: AppTheme.s(12.5,
                      weight: FontWeight.w600, color: on ? gc.text : gc.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }

  void _editPlates(BuildContext context, GymPlace place) {
    final gc = context.gc;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheet) => StatefulBuilder(
        builder: (sheet, setSheet) {
          final current = fit.places.firstWhere((p) => p.id == place.id, orElse: () => place);
          final bar = current.bar == null ? fit.defaultBar : fit.toDisplayWeight(current.bar!);
          return Container(
            padding: sheetPad(sheet),
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
                  Text(t.placePlates,
                      textAlign: TextAlign.center,
                      style: AppTheme.d(14, weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
                  const SizedBox(height: 4),
                  Text(current.name,
                      textAlign: TextAlign.center,
                      style: AppTheme.s(12.5, color: gc.textSecondary)),
                  const SizedBox(height: 20),
                  ToolRow(
                    label: t.barWeight,
                    control: StepperControl(
                      value: '${fmt(bar)} ${fit.units}',
                      minWidth: 66,
                      btnSize: 28,
                      gap: 8,
                      fontSize: 14,
                      onDec: () => setSheet(() =>
                          fit.setPlaceBar(place.id, fit.fromDisplayWeight(bar - fit.weightStep))),
                      onInc: () => setSheet(() =>
                          fit.setPlaceBar(place.id, fit.fromDisplayWeight(bar + fit.weightStep))),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t.platePairs,
                          style: AppTheme.s(10,
                              weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.5)),
                      if (current.plates.isNotEmpty)
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => setSheet(() => fit.clearPlates(place.id)),
                          child: Text(t.platesAll,
                              style: AppTheme.s(12, weight: FontWeight.w600, color: gc.accent)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  for (final size in fit.plateSizes) ...[
                    _plateRow(gc, place.id, current, size, setSheet),
                    const SizedBox(height: 8),
                  ],
                  const SizedBox(height: 12),
                  PrimaryButton(label: t.done, onTap: () => Navigator.of(sheet).pop()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _plateRow(GymColors gc, String placeId, GymPlace place, double size,
      void Function(VoidCallback) setSheet) {
    final kg = fit.fromDisplayWeight(size);
    final pairs = fit.platePairs(place, kg);
    return ToolRow(
      label: '${fmt(size)} ${fit.units}',
      control: StepperControl(
        value: '$pairs',
        minWidth: 34,
        btnSize: 28,
        gap: 10,
        fontSize: 14,
        onDec: () => setSheet(() => fit.setPlatePairs(placeId, kg, pairs - 1)),
        onInc: () => setSheet(() => fit.setPlatePairs(placeId, kg, pairs + 1)),
      ),
    );
  }

  Future<void> _rename(BuildContext context, GymPlace? place) async {
    final gc = context.gc;
    final controller = TextEditingController(text: place?.name ?? '');
    final name = await showDialog<String>(
      context: context,
      builder: (dctx) => appDialog(
        gc,
        title: Text(place == null ? t.placeNew : t.editEntry,
            style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          style: AppTheme.s(15, color: gc.text),
          cursorColor: gc.accent,
          decoration: InputDecoration(
            hintText: t.placeNamePlaceholder,
            hintStyle: AppTheme.s(15, color: gc.textTertiary),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.border)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.accent)),
          ),
          onSubmitted: (v) => Navigator.of(dctx).pop(v),
        ),
        actions: [
          dialogAction(t.cancel, gc.textSecondary, () => Navigator.of(dctx).pop(), strong: false),
          dialogAction(t.save, gc.accent, () => Navigator.of(dctx).pop(controller.text)),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.trim().isEmpty) return;
    if (place == null) {
      fit.setActivePlace(fit.addPlace(name));
    } else {
      fit.renamePlace(place.id, name);
    }
  }

  Future<void> _confirmDelete(BuildContext context, GymPlace place) async {
    final ok = await askConfirm(
      context,
      title: t.placeDeleteTitle,
      body: t.placeDeleteBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (ok) fit.deletePlace(place.id);
  }
}
