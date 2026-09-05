import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class ToolDetailScreen extends StatelessWidget {
  const ToolDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final id = fit.activeToolId;
    final meta = _meta(id);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              RoundBtn(icon: Ic.chevronLeft, onTap: fit.closeTool),
              const SizedBox(width: 12),
              Text(meta.$1, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text, letterSpacing: 1)),
            ]),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: gc.bgRaised,
                border: Border.all(color: gc.ember),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: [
                Text(t.result, style: AppTheme.s(11, weight: FontWeight.w600, color: gc.brass, letterSpacing: 2)),
                const SizedBox(height: 8),
                Text(meta.$2, style: AppTheme.d(36, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(height: 8),
                Text(meta.$3, style: AppTheme.s(13, color: gc.textSecondary), textAlign: TextAlign.center),
              ]),
            ),
            const SizedBox(height: 14),
            ..._inputs(context, gc, id),
          ],
        ),
      ),
    );
  }

  (String, String, String) _meta(String? id) {
    switch (id) {
      case 'rm':
        return (t.toolTitle('rm'), '${fit.weightValue(fit.rmResult)} ${fit.units}', t.toolResultHint('rm'));
      case 'bmi':

        return (t.toolTitle('bmi'), fmt(fit.bmiVal), t.bmiCategory(fit.bmiCat));
      case 'cal':
        return (t.toolTitle('cal'), '${fit.tdee} kcal', t.toolResultHint('cal'));
      case 'bf':
        return (t.toolTitle('bf'), '${fmt(fit.bfVal)}%', t.toolResultHint('bf'));
      case 'plate':
        return (t.toolTitle('plate'), '${fit.weightValue(fit.plateTarget)} ${fit.units}', t.toolResultHint('plate'));
      case 'warmup':
        return (t.toolTitle('warmup'), '${fit.weightValue(fit.warmupTarget)} ${fit.units}', t.toolResultHint('warmup'));
      default:
        return ('', '', '');
    }
  }

  List<Widget> _inputs(BuildContext context, GymColors gc, String? id) {
    switch (id) {
      case 'rm':
        return [
          ToolRow(label: t.weightLifted, control: StepperControl(value: '${fit.weightValue(fit.rmWeight)} ${fit.units}', onDec: () => fit.bumpRmWeight(-fit.fromDisplayWeight(fit.weightStep)), onInc: () => fit.bumpRmWeight(fit.fromDisplayWeight(fit.weightStep)), onEdit: () => _editNumber(context, title: t.weightLifted, current: fit.toDisplayWeight(fit.rmWeight), decimal: true, apply: (v) => fit.bumpRmWeight(fit.fromDisplayWeight(v) - fit.rmWeight)))),
          const SizedBox(height: 10),
          ToolRow(label: t.repsPerformed, control: StepperControl(value: '${fit.rmReps}', minWidth: 40, onDec: () => fit.bumpRmReps(-1), onInc: () => fit.bumpRmReps(1), onEdit: () => _editNumber(context, title: t.repsPerformed, current: fit.rmReps.toDouble(), decimal: false, apply: (v) => fit.bumpRmReps(v.round() - fit.rmReps)))),
        ];
      case 'bmi':
        return [
          ToolRow(label: t.heightLabel, control: StepperControl(value: fit.cmLabel(fit.bmiHeight), onDec: () => fit.bumpBmiHeight(-fit.cmStep), onInc: () => fit.bumpBmiHeight(fit.cmStep), onEdit: () => _editNumber(context, title: t.heightLabel, current: fit.toDisplayCm(fit.bmiHeight), decimal: true, apply: (v) => fit.bumpBmiHeight(fit.fromDisplayCm(v) - fit.bmiHeight)))),
          const SizedBox(height: 10),
          ToolRow(label: t.weightLabel, control: StepperControl(value: '${fit.weightValue(fit.bmiWeight)} ${fit.units}', onDec: () => fit.bumpBmiWeight(-fit.fromDisplayWeight(fit.isLb ? 1 : 0.5)), onInc: () => fit.bumpBmiWeight(fit.fromDisplayWeight(fit.isLb ? 1 : 0.5)), onEdit: () => _editNumber(context, title: t.weightLabel, current: fit.toDisplayWeight(fit.bmiWeight), decimal: true, apply: (v) => fit.bumpBmiWeight(fit.fromDisplayWeight(v) - fit.bmiWeight)))),
        ];
      case 'cal':
        return [
          ToolRow(
            label: t.sexLabel,
            control: SegToggle([
              SegOption(t.male, fit.calSex == 'male', () => fit.setCalSex('male')),
              SegOption(t.female, fit.calSex == 'female', () => fit.setCalSex('female')),
            ]),
          ),
          const SizedBox(height: 10),
          ToolRow(label: t.ageLabel, control: StepperControl(value: '${fit.calAge}', minWidth: 40, onDec: () => fit.bumpCalAge(-1), onInc: () => fit.bumpCalAge(1), onEdit: () => _editNumber(context, title: t.ageLabel, current: fit.calAge.toDouble(), decimal: false, apply: (v) => fit.bumpCalAge(v.round() - fit.calAge)))),
          const SizedBox(height: 10),
          ToolRow(label: t.heightLabel, control: StepperControl(value: fit.cmLabel(fit.calHeight), onDec: () => fit.bumpCalHeight(-fit.cmStep), onInc: () => fit.bumpCalHeight(fit.cmStep), onEdit: () => _editNumber(context, title: t.heightLabel, current: fit.toDisplayCm(fit.calHeight), decimal: true, apply: (v) => fit.bumpCalHeight(fit.fromDisplayCm(v) - fit.calHeight)))),
          const SizedBox(height: 10),
          ToolRow(label: t.weightLabel, control: StepperControl(value: '${fit.weightValue(fit.calWeight)} ${fit.units}', onDec: () => fit.bumpCalWeight(-fit.fromDisplayWeight(fit.isLb ? 1 : 0.5)), onInc: () => fit.bumpCalWeight(fit.fromDisplayWeight(fit.isLb ? 1 : 0.5)), onEdit: () => _editNumber(context, title: t.weightLabel, current: fit.toDisplayWeight(fit.calWeight), decimal: true, apply: (v) => fit.bumpCalWeight(fit.fromDisplayWeight(v) - fit.calWeight)))),
          const SizedBox(height: 10),
          _activityCard(gc),
          const SizedBox(height: 10),
          _macros(gc),
        ];
      case 'bf':
        return [
          ToolRow(label: t.heightLabel, control: StepperControl(value: fit.cmLabel(fit.bfHeight), onDec: () => fit.bumpBfHeight(-fit.cmStep), onInc: () => fit.bumpBfHeight(fit.cmStep), onEdit: () => _editNumber(context, title: t.heightLabel, current: fit.toDisplayCm(fit.bfHeight), decimal: true, apply: (v) => fit.bumpBfHeight(fit.fromDisplayCm(v) - fit.bfHeight)))),
          const SizedBox(height: 10),
          ToolRow(label: t.neck, control: StepperControl(value: fit.cmLabel(fit.bfNeck), onDec: () => fit.bumpBfNeck(-fit.girthStep), onInc: () => fit.bumpBfNeck(fit.girthStep), onEdit: () => _editNumber(context, title: t.neck, current: fit.toDisplayCm(fit.bfNeck), decimal: true, apply: (v) => fit.bumpBfNeck(fit.fromDisplayCm(v) - fit.bfNeck)))),
          const SizedBox(height: 10),
          ToolRow(label: t.waist, control: StepperControl(value: fit.cmLabel(fit.bfWaist), onDec: () => fit.bumpBfWaist(-fit.girthStep), onInc: () => fit.bumpBfWaist(fit.girthStep), onEdit: () => _editNumber(context, title: t.waist, current: fit.toDisplayCm(fit.bfWaist), decimal: true, apply: (v) => fit.bumpBfWaist(fit.fromDisplayCm(v) - fit.bfWaist)))),
          const SizedBox(height: 10),
          ToolRow(label: t.hip, control: StepperControl(value: fit.cmLabel(fit.bfHip), onDec: () => fit.bumpBfHip(-fit.girthStep), onInc: () => fit.bumpBfHip(fit.girthStep), onEdit: () => _editNumber(context, title: t.hip, current: fit.toDisplayCm(fit.bfHip), decimal: true, apply: (v) => fit.bumpBfHip(fit.fromDisplayCm(v) - fit.bfHip)))),
        ];
      case 'plate':
        return [
          ToolRow(label: t.targetWeight, control: StepperControl(value: '${fit.weightValue(fit.plateTarget)} ${fit.units}', onDec: () => fit.bumpPlateTarget(-fit.fromDisplayWeight(fit.weightStep)), onInc: () => fit.bumpPlateTarget(fit.fromDisplayWeight(fit.weightStep)), onEdit: () => _editNumber(context, title: t.targetWeight, current: fit.toDisplayWeight(fit.plateTarget), decimal: true, apply: (v) => fit.bumpPlateTarget(fit.fromDisplayWeight(v) - fit.plateTarget)))),
          const SizedBox(height: 10),
          _barWeightCard(gc),
          const SizedBox(height: 10),
          _perSideCard(gc),
        ];
      case 'warmup':
        return [
          ToolRow(label: t.workingWeight, control: StepperControl(value: '${fit.weightValue(fit.warmupTarget)} ${fit.units}', onDec: () => fit.bumpWarmupTarget(-fit.fromDisplayWeight(fit.weightStep)), onInc: () => fit.bumpWarmupTarget(fit.fromDisplayWeight(fit.weightStep)), onEdit: () => _editNumber(context, title: t.workingWeight, current: fit.toDisplayWeight(fit.warmupTarget), decimal: true, apply: (v) => fit.bumpWarmupTarget(fit.fromDisplayWeight(v) - fit.warmupTarget)))),
          const SizedBox(height: 10),
          _warmupCard(gc),
        ];
      default:
        return const [];
    }
  }

  Future<void> _editNumber(
    BuildContext context, {
    required String title,
    required double current,
    required bool decimal,
    required void Function(double) apply,
  }) async {
    final parsed = await askNumber(context, title: title, initial: fmt(current), decimal: decimal);
    if (parsed != null) apply(parsed);
  }

  Widget _activityCard(GymColors gc) {
    Widget pill(String label, double v) {
      final active = fit.calActivity == v;
      return Pill(
        label: label,
        bg: active ? gc.ember : gc.bgRaised2,
        fg: active ? gc.onEmber : gc.textSecondary,
        onTap: () => fit.setCalActivity(v),
        hPad: 12,
        vPad: 7,
        fontSize: 12,
      );
    }

    return SoftCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.activityLevel, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary)),
          const SizedBox(height: 10),
          Wrap(spacing: 6, runSpacing: 6, children: [
            pill(t.activityName('Sedentary'), 1.2),
            pill(t.activityName('Light'), 1.375),
            pill(t.activityName('Moderate'), 1.55),
            pill(t.activityName('Active'), 1.725),
          ]),
        ],
      ),
    );
  }

  Widget _macros(GymColors gc) {
    Widget card(String label, String value) => Expanded(
          child: SoftCard(
            radius: 14,
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              Text(label, style: AppTheme.s(10, weight: FontWeight.w600, color: gc.textSecondary)),
              const SizedBox(height: 4),
              Text(value, style: AppTheme.d(16, weight: FontWeight.w700, color: gc.text)),
            ]),
          ),
        );
    return Row(children: [
      card(t.macroProtein, '${fit.calProtein}g'),
      const SizedBox(width: 10),
      card(t.macroCarbs, '${fit.calCarbs}g'),
      const SizedBox(width: 10),
      card(t.macroFat, '${fit.calFat}g'),
    ]);
  }

  Widget _barWeightCard(GymColors gc) {
    Widget opt(double v) {
      final active = fit.plateBarDisplay == v;
      return Expanded(
        child: GestureDetector(
          onTap: () => fit.setPlateBar(v),
          child: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: active ? gc.ember : gc.bgRaised2, borderRadius: BorderRadius.circular(10)),
            child: Text('${fmt(v)} ${fit.units}',
                style: AppTheme.s(13, weight: FontWeight.w600, color: active ? gc.onEmber : gc.textSecondary)),
          ),
        ),
      );
    }

    final bars = fit.barOptions;
    return SoftCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.barWeight, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary)),
          const SizedBox(height: 10),
          Row(children: [
            for (int i = 0; i < bars.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              opt(bars[i]),
            ],
          ]),
        ],
      ),
    );
  }

  Widget _perSideCard(GymColors gc) {
    final rows = fit.plateBreakdown;
    return SoftCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.perSide, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary)),
          const SizedBox(height: 10),
          if (rows.isEmpty)
            Text(t.justTheBar, style: AppTheme.s(13, color: gc.textSecondary))
          else
            for (final p in rows)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${fmt(p.weight)} ${fit.units}', style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
                    Text(t.perSideCount(p.count), style: AppTheme.s(13, color: gc.textSecondary)),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  Widget _warmupCard(GymColors gc) {
    final sets = fit.warmupSets;
    return SoftCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          for (int i = 0; i < sets.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: i < sets.length - 1 ? Border(bottom: BorderSide(color: gc.border)) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.rampSet(sets[i].pct, sets[i].reps), style: AppTheme.s(13, color: gc.textSecondary)),
                  Text('${fmt(sets[i].weight)} ${fit.units}', style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
