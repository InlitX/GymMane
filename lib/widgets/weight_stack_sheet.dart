import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'dialogs.dart';
import 'glass.dart';
import 'ui_kit.dart';

Future<void> showWeightStackSheet(BuildContext context, String exerciseId) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WeightStackSheet(id: exerciseId),
    );

class _WeightStackSheet extends StatefulWidget {
  const _WeightStackSheet({required this.id});

  final String id;

  @override
  State<_WeightStackSheet> createState() => _WeightStackSheetState();
}

class _WeightStackSheetState extends State<_WeightStackSheet> {
  late List<double> _kg = [...?fit.stackFor(widget.id)];
  late final _from = TextEditingController(text: _kg.isEmpty ? _seed(5) : _shown(_kg.first));
  late final _to = TextEditingController(text: _kg.isEmpty ? _seed(100) : _shown(_kg.last));
  late final _step = TextEditingController(text: _kg.length < 2 ? _seed(5) : _shown(_kg[1] - _kg[0]));

  String get _unit => fit.unitsFor(widget.id);

  String _seed(double kg) => fit.isLbFor(widget.id) ? fmt((kg * 2.2).roundToDouble()) : fmt(kg);

  String _shown(double kg) => fit.weightValueFor(widget.id, kg);

  double? _read(TextEditingController c) {
    final v = double.tryParse(c.text.trim().replaceAll(',', '.'));
    return v == null || v <= 0 ? null : fit.fromShownFor(widget.id, v);
  }

  @override
  void dispose() {
    _from.dispose();
    _to.dispose();
    _step.dispose();
    super.dispose();
  }

  void _save(List<double> next) {
    fit.setWeightStack(widget.id, next);
    setState(() => _kg = [...?fit.stackFor(widget.id)]);
  }

  void _fill() {
    final a = _read(_from), b = _read(_to), step = _read(_step);
    if (a == null || b == null || step == null || b <= a || (b - a) / step > 59) {
      HapticFeedback.heavyImpact();
      return;
    }
    HapticFeedback.mediumImpact();
    _save([for (var v = a; v <= b + 0.001; v += step) v]);
  }

  Future<void> _add() async {
    final v = await askNumber(context, title: '${t.stackAddWeight} ($_unit)', initial: '', decimal: true);
    if (v == null || v <= 0) return;
    _save([..._kg, fit.fromShownFor(widget.id, v)]);
  }

  Future<void> _edit(int i) async {
    final v = await askNumber(context, title: '${t.stackEditWeight} ($_unit)', initial: _shown(_kg[i]), decimal: true);
    if (v == null) return;
    final next = [..._kg]..removeAt(i);
    if (v > 0) next.add(fit.fromShownFor(widget.id, v));
    _save(next);
  }

  Widget _field(GymColors gc, String label, TextEditingController c) => Expanded(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label.toUpperCase(),
                style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.1)),
            TextField(
              controller: c,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              cursorColor: gc.accent,
              style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                suffixText: _unit,
                suffixStyle: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary),
              ),
            ),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      decoration: sheetDecoration(gc),
      child: SingleChildScrollView(
        padding: sheetPad(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            SheetTitle(t.weightStack, subtitle: t.weightStackHint),
            const SizedBox(height: 18),
            Row(children: [
              _field(gc, t.stackFrom, _from),
              const SizedBox(width: 8),
              _field(gc, t.stackTo, _to),
              const SizedBox(width: 8),
              _field(gc, t.stackEvery, _step),
            ]),
            const SizedBox(height: 10),
            GhostButton(label: t.stackFill, icon: PhosphorIconsRegular.stack, onTap: _fill),
            const SizedBox(height: 18),
            if (_kg.isNotEmpty) ...[
              Text(t.stackTapToFix,
                  style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
              const SizedBox(height: 10),
            ],
            AnimatedSize(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: Wrap(spacing: 8, runSpacing: 8, children: [
                for (var i = 0; i < _kg.length; i++)
                  Pressable(
                    scale: 0.92,
                    onTap: () => _edit(i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
                      child: Text(_shown(_kg[i]),
                          style: AppTheme.f(13, weight: FontWeight.w700, color: gc.text)
                              .copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
                    ),
                  ),
                Pressable(
                  scale: 0.92,
                  onTap: _add,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: gc.accentSoft,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(PhosphorIconsBold.plus, size: 12, color: gc.accent),
                      const SizedBox(width: 4),
                      Text(t.addShort, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.accent)),
                    ]),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 22),
            PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
            if (_kg.isNotEmpty)
              Center(
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    _save(const []);
                  },
                  child: Text(t.stackClear, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.danger)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
