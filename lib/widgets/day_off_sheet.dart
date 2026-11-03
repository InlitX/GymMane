import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import 'glass.dart';
import 'ui_kit.dart';

IconData dayOffIcon(String reason) => switch (reason) {
      'sick' => PhosphorIconsRegular.thermometerSimple,
      'travel' => PhosphorIconsRegular.airplaneTilt,
      'injury' => PhosphorIconsRegular.bandaids,
      _ => PhosphorIconsRegular.bed,
    };

String dayOffLabel(String reason) => switch (reason) {
      'sick' => t.dayOffSick,
      'travel' => t.dayOffTravel,
      'injury' => t.dayOffInjury,
      _ => t.dayOffRest,
    };

void showDayOffSheet(BuildContext context, DateTime day) {
  final today = DateTime.now();
  final future = DateTime(day.year, day.month, day.day).isAfter(DateTime(today.year, today.month, today.day));
  showAppSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheet) {
      final now = fit.dayOffOn(day);
      final checked = fit.isCheckedIn(day);
      void pick(VoidCallback act) {
        HapticFeedback.selectionClick();
        act();
        Navigator.of(sheet).pop();
      }

      return AppSheet(children: [
        SheetTitle(t.longDate(day), subtitle: t.dayOffHint),
        const SizedBox(height: 16),
        OptionGroup([
          if (!future)
            OptionItem(
              t.dayOffTrained,
              icon: PhosphorIconsRegular.checkCircle,
              selected: checked,
              onTap: () => pick(() => fit.setCheckedIn(day, !checked)),
            ),
          for (final r in StatsState.dayOffReasons)
            OptionItem(
              dayOffLabel(r),
              icon: dayOffIcon(r),
              selected: now == r,
              onTap: () => pick(() => fit.setDayOff(day, now == r ? null : r)),
            ),
        ]),
      ]);
    },
  );
}
