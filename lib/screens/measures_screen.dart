import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/measure.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
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
                  width: 84,
                  child: Sparkline(values: series, height: 34, color: gc.accent),
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

Future<void> showMeasureSheet(BuildContext context, String key) => showModalBottomSheet<void>(
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
  late final TextEditingController _value = TextEditingController(
    text: () {
      final latest = fit.latestMeasure(widget.measureKey);
      return latest == null ? '' : fit.measureValue(widget.measureKey, latest.value);
    }(),
  );

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  void _save() {
    final parsed = double.tryParse(_value.text.trim().replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) return;
    fit.addMeasure(widget.measureKey, parsed);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final history = fit.measureHistory(widget.measureKey);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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
                    Text(t.measureName(widget.measureKey).toUpperCase(),
                        style: AppTheme.d(18,
                            weight: FontWeight.w700, color: gc.text, letterSpacing: 1)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _value,
                            autofocus: true,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                            ],
                            onSubmitted: (_) => _save(),
                            cursorColor: gc.accent,
                            style: AppTheme.d(22, weight: FontWeight.w700, color: gc.text),
                            decoration: InputDecoration(
                              hintText: '0',
                              hintStyle: AppTheme.d(22, weight: FontWeight.w700, color: gc.textTertiary),
                              suffixText: fit.measureUnit(widget.measureKey),
                              suffixStyle: AppTheme.d(14, weight: FontWeight.w600, color: gc.textSecondary),
                              filled: true,
                              fillColor: gc.bgRaised,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: gc.border)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: gc.accent)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 120,
                          child: PrimaryButton(label: t.save, onTap: _save, height: 52),
                        ),
                      ],
                    ),
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
