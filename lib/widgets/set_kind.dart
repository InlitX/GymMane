import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

Color setKindColor(GymColors gc, SetKind kind) => switch (kind) {
  SetKind.warmup => gc.warn,
  SetKind.drop => gc.info,
  SetKind.failure => gc.danger,
  SetKind.restPause => gc.brass,
  SetKind.normal => gc.text,
};

String setKindLabel(SetKind kind) => switch (kind) {
  SetKind.warmup => t.setTypeWarmup,
  SetKind.drop => t.setTypeDrop,
  SetKind.failure => t.setTypeFailure,
  SetKind.restPause => t.setTypeRestPause,
  SetKind.normal => t.setTypeNormal,
};

String setKindTag(SetKind kind) => switch (kind) {
  SetKind.warmup => 'W',
  SetKind.drop => 'D',
  SetKind.failure => 'F',
  SetKind.restPause => 'RP',
  SetKind.normal => '',
};

String setKindInfo(SetKind kind) => switch (kind) {
  SetKind.warmup => t.setTypeWarmupInfo,
  SetKind.drop => t.setTypeDropInfo,
  SetKind.failure => t.setTypeFailureInfo,
  SetKind.restPause => t.setTypeRestPauseInfo,
  SetKind.normal => t.setTypeNormalInfo,
};

class SetKindOptions extends StatelessWidget {
  const SetKindOptions({super.key, required this.current, required this.onPick});

  final SetKind current;
  final void Function(SetKind) onPick;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final kind in SetKind.values) ...[
          if (kind != SetKind.values.first) const SizedBox(height: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onPick(kind),
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
              decoration: BoxDecoration(
                color: kind == current ? gc.bgRaised2 : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: kind == current ? setKindColor(gc, kind) : gc.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: setKindColor(gc, kind), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          setKindLabel(kind),
                          style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          setKindInfo(kind),
                          style: AppTheme.f(
                            12,
                            weight: FontWeight.w500,
                            color: gc.textSecondary,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    PhosphorIconsBold.check,
                    size: 14,
                    color: kind == current ? setKindColor(gc, kind) : Colors.transparent,
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

Future<SetKind?> askSetKind(BuildContext context, SetKind current) {
  final gc = context.gc;
  return showAppSheet<SetKind>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheet) => Container(
      padding: sheetPad(sheet),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 18),
            Text(
              t.setType,
              style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 0.4),
            ),
            const SizedBox(height: 12),
            SetKindOptions(current: current, onPick: (k) => Navigator.of(sheet).pop(k)),
          ],
        ),
      ),
    ),
  );
}
