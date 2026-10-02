import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/measure.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
import '../widgets/dialogs.dart';
import '../widgets/glass.dart';
import '../widgets/rolling_text.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class MeasuresScreen extends StatelessWidget {
  const MeasuresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: t.measures,
              subtitle: t.measureCount(fit.measures.length),
              onBack: fit.backFromMeasures,
            ),
            const SizedBox(height: 14),
            Text(t.measuresHint, style: AppTheme.s(13, color: gc.textSecondary, height: 1.5)),
            const SizedBox(height: 20),
            for (final key in kMeasureKeys) _MeasureRow(measureKey: key),
          ],
        ),
      ),
    );
  }
}

class _MeasureRow extends StatelessWidget {
  const _MeasureRow({required this.measureKey});

  final String measureKey;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final latest = fit.latestMeasure(measureKey);
    final change = fit.measureChange(measureKey);
    final series = fit.measureSeries(measureKey);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => showMeasureSheet(context, measureKey),
        child: SoftCard(
          radius: 18,
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.measureName(measureKey),
                        style: AppTheme.s(12,
                            weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
                    const SizedBox(height: 6),
                    if (latest == null)
                      Text(t.measureNoneYet, style: AppTheme.s(14, color: gc.textTertiary))
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(fit.measureValue(measureKey, latest.value),
                              style: AppTheme.d(26, weight: FontWeight.w700, color: gc.text)),
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Text(fit.measureUnit(measureKey),
                                style: AppTheme.d(13,
                                    weight: FontWeight.w600, color: gc.textSecondary)),
                          ),
                          if (change != null && change != 0) ...[
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                '${change > 0 ? '+' : ''}${fmt(change)}',
                                style: AppTheme.s(12.5,
                                    weight: FontWeight.w600,
                                    color: change > 0 ? gc.sage : gc.accent),
                              ),
                            ),
                          ],
                        ],
                      ),
                  ],
                ),
              ),
              if (series.length > 1)
                SizedBox(
                  width: 108,
                  child: Sparkline(
                    values: [for (final v in series) fit.toDisplayMeasure(measureKey, v)],
                    height: 38,
                    color: gc.accent,
                    scale: fmt,
                  ),
                )
              else
                Icon(PhosphorIconsRegular.plusCircle, size: 20, color: gc.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showMeasureSheet(BuildContext context, String key) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MeasureSheet(measureKey: key),
    );

class _MeasureSheet extends StatefulWidget {
  const _MeasureSheet({required this.measureKey});

  final String measureKey;

  @override
  State<_MeasureSheet> createState() => _MeasureSheetState();
}

class _MeasureSheetState extends State<_MeasureSheet> {
  static const _rangesCm = {
    'neck': (20.0, 70.0, 38.0),
    'shoulders': (70.0, 180.0, 115.0),
    'chest': (60.0, 180.0, 100.0),
    'arm': (15.0, 70.0, 34.0),
    'forearm': (15.0, 50.0, 28.0),
    'waist': (40.0, 180.0, 84.0),
    'hips': (50.0, 180.0, 98.0),
    'thigh': (30.0, 100.0, 56.0),
    'calf': (20.0, 70.0, 38.0),
  };

  String get _key => widget.measureKey;
  bool get _pct => fit.isPercent(_key);
  double get _step => _pct ? 0.5 : (fit.isInches ? 0.25 : 0.5);
  int get _major => _pct ? 10 : (fit.isInches ? 4 : 10);

  (double, double) get _range {
    if (_pct) return (3, 60);
    final r = _rangesCm[_key] ?? (10.0, 200.0, 50.0);
    return (_snap(fit.toDisplayCm(r.$1)), _snap(fit.toDisplayCm(r.$2)));
  }

  double _snap(double v) => (v / _step).round() * _step;

  late double _value = () {
    final latest = fit.latestMeasure(_key);
    if (latest != null) return _snap(fit.toDisplayMeasure(_key, latest.value));
    if (_pct) return 20.0;
    return _snap(fit.toDisplayCm((_rangesCm[_key] ?? (10.0, 200.0, 50.0)).$3));
  }();

  String _show(double v) => decimalText(v.toStringAsFixed(_step < 0.5 ? 2 : 1));

  void _save() {
    if (_value <= 0) return;
    fit.addMeasure(_key, _value);
    Navigator.of(context).pop();
  }

  Future<void> _type() async {
    final typed = await askNumber(context, title: t.measureName(_key), initial: _show(_value), decimal: true);
    if (typed == null || !mounted) return;
    final (lo, hi) = _range;
    setState(() => _value = _snap(typed.clamp(lo, hi)));
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final history = fit.measureHistory(_key);
    final (lo, hi) = _range;

    return Container(
      decoration: BoxDecoration(
        color: gc.bg,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetHandle(color: gc.border, margin: const EdgeInsets.symmetric(vertical: 12)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(t.measureName(_key),
                          style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
                    ),
                    Semantics(
                      button: true,
                      label: t.measureName(_key),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _type,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(PhosphorIconsRegular.keyboard, size: 20, color: gc.textSecondary),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 6),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        RollingText(_show(_value),
                            style: AppTheme.f(54, weight: FontWeight.w800, color: gc.text, height: 1.1)),
                        const SizedBox(width: 6),
                        Text(fit.measureUnit(_key),
                            style: AppTheme.f(18, weight: FontWeight.w700, color: gc.textSecondary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  RulerPicker(
                    value: _value.clamp(lo, hi),
                    min: lo,
                    max: hi,
                    step: _step,
                    majorEvery: _major,
                    label: (v) => '${v.round()}',
                    onChanged: (v) => setState(() => _value = v),
                  ),
                  const SizedBox(height: 18),
                  PrimaryButton(label: t.save, onTap: _save, height: 54),
                  if (history.isNotEmpty) ...[
                    const SizedBox(height: 22),
                    Text(t.measureHistory,
                        style: AppTheme.d(12,
                            weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 2)),
                    const SizedBox(height: 10),
                    for (final m in history.take(6)) _historyRow(gc, m),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyRow(GymColors gc, BodyMeasure m) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Expanded(
              child: Text(t.shortDateYear(m.date), style: AppTheme.s(12.5, color: gc.textSecondary)),
            ),
            Text(fit.measureLabel(m.key, m.value),
                style: AppTheme.s(13.5, weight: FontWeight.w600, color: gc.text)),
            const SizedBox(width: 8),
            Semantics(
              button: true,
              label: t.delete,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  fit.deleteMeasure(m);
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPathIcon(Ic.close, size: 12, color: gc.textTertiary),
                ),
              ),
            ),
          ],
        ),
      );
}
