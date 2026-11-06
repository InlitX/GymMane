import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/progression.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

String progressKindName(ProgressKind k) => switch (k) {
      ProgressKind.manual => t.progManual,
      ProgressKind.linear => t.progLinear,
      ProgressKind.double => t.progDouble,
      ProgressKind.volume => t.progVolume,
      ProgressKind.amrap => t.progAmrap,
    };

String progressKindHint(ProgressKind k) => switch (k) {
      ProgressKind.manual => t.progManualHint,
      ProgressKind.linear => t.progLinearHint,
      ProgressKind.double => t.progDoubleHint,
      ProgressKind.volume => t.progVolumeHint,
      ProgressKind.amrap => t.progAmrapHint,
    };

void showProgressionSheet(BuildContext context, String id) {
  showAppSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheet) => AnimatedBuilder(
      animation: fit,
      builder: (sheet, _) {
        final gc = sheet.gc;
        final rule = fit.progressRule(id);
        final on = fit.hasProgress(id);
        void set(ProgressRule r) => fit.setProgressRule(id, r);
        Widget stepper(String value, VoidCallback dec, VoidCallback inc, {bool tight = false}) => StepperControl(
              value: value,
              minWidth: tight ? 28 : 44,
              btnSize: tight ? 28 : 30,
              gap: tight ? 2 : 4,
              fontSize: 14,
              btnRadius: 10,
              onDec: dec,
              onInc: inc,
            );
        Widget line(String label, List<Widget> controls) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(children: [
                Expanded(child: FitText(label, style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.text))),
                const SizedBox(width: 10),
                for (var i = 0; i < controls.length; i++) ...[
                  if (i > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text('–', style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textTertiary)),
                    ),
                  controls[i],
                ],
              ]),
            );
        final params = <Widget>[
          Semantics(
            button: true,
            toggled: on,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => fit.toggleProgress(id),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(t.progApply, style: AppTheme.f(14, weight: FontWeight.w500, color: gc.text)),
                      if (!on) ...[
                        const SizedBox(height: 3),
                        Text(t.progApplyHint,
                            style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                      ],
                    ]),
                  ),
                  const SizedBox(width: 12),
                  TinySwitch(on: on),
                ]),
              ),
            ),
          ),
          if (on)
            line(t.progStep, [
              stepper(fit.weightLabel(fit.progressFor(id) ?? 0), () => fit.bumpProgressStep(id, -1),
                  () => fit.bumpProgressStep(id, 1)),
            ]),
          if (rule.usesRange)
            line(t.progRange, [
              stepper('${rule.low}', () => set(rule.copyWith(low: rule.low - 1)),
                  () => set(rule.copyWith(low: rule.low + 1, high: math.max(rule.high, rule.low + 2))), tight: true),
              stepper('${rule.high}', () => set(rule.copyWith(high: rule.high - 1)),
                  () => set(rule.copyWith(high: rule.high + 1)), tight: true),
            ]),
          if (rule.kind == ProgressKind.volume)
            line(t.progSets, [
              stepper('${rule.sets}', () => set(rule.copyWith(sets: rule.sets - 1)),
                  () => set(rule.copyWith(sets: rule.sets + 1, maxSets: math.max(rule.maxSets, rule.sets + 2))), tight: true),
              stepper('${rule.maxSets}', () => set(rule.copyWith(maxSets: rule.maxSets - 1)),
                  () => set(rule.copyWith(maxSets: rule.maxSets + 1)), tight: true),
            ]),
          if (on) ...[
            line(t.progDeload, [
              stepper(t.progFails(rule.fails), () => set(rule.copyWith(fails: rule.fails - 1)),
                  () => set(rule.copyWith(fails: rule.fails + 1))),
            ]),
            line(t.progDeloadPct, [
              stepper('${rule.deloadPct} %', () => set(rule.copyWith(deloadPct: rule.deloadPct - 5)),
                  () => set(rule.copyWith(deloadPct: rule.deloadPct + 5))),
            ]),
          ],
        ];
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.9),
          child: Container(
            decoration: sheetDecoration(gc),
            child: SingleChildScrollView(
              padding: sheetPad(sheet),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SheetHandle(),
                  const SizedBox(height: 16),
                  SheetTitle(t.progression),
                  const SizedBox(height: 14),
                  OptionGroup([
                    for (final k in ProgressKind.values)
                      OptionItem(
                        progressKindName(k),
                        detail: k == rule.kind ? progressKindHint(k) : null,
                        selected: k == rule.kind,
                        onTap: () => set(rule.copyWith(kind: k)),
                      ),
                  ]),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: rule.kind == ProgressKind.manual
                        ? const SizedBox(width: double.infinity)
                        : Container(
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: gc.border),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(children: [
                              for (var i = 0; i < params.length; i++) ...[
                                if (i > 0) Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: gc.border),
                                params[i],
                              ],
                            ]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
