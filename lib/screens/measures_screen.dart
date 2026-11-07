import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            const SizedBox(height: 18),
            const _MeasureReminder(),
            const SizedBox(height: 20),
            for (final key in fit.allMeasureKeys) _MeasureRow(key: ValueKey(key), measureKey: key),
            const SizedBox(height: 4),
            GhostButton(
              label: t.newMeasure,
              icon: PhosphorIconsBold.plus,
              onTap: () => showNewMeasureSheet(context),
            ),
          ],
        ),
      ),
    );
  }
}

const List<int> _kMeasureEvery = [0, 7, 14, 30];

class _MeasureReminder extends StatelessWidget {
  const _MeasureReminder();

  Future<void> _custom(BuildContext context) async {
    final current = fit.measureEveryDays;
    final days = await askNumber(context,
        title: t.measureEvery, initial: '${current > 0 ? current : 21}', decimal: false);
    if (days != null) fit.setMeasureEvery(days.round());
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final current = fit.measureEveryDays;
    final custom = current > 0 && !_kMeasureEvery.contains(current);
    final left = fit.daysUntilMeasure;
    final due = left != null && left <= 0;
    Widget tab(String label, bool on, VoidCallback onTap) => Expanded(
          child: Semantics(
            button: true,
            selected: on,
            label: label,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.selectionClick();
                onTap();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: on ? gc.ember : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(label,
                        maxLines: 1,
                        style: AppTheme.f(13, weight: FontWeight.w600, color: on ? gc.onEmber : gc.textSecondary)),
                  ),
                ),
              ),
            ),
          ),
        );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(
          child: Text('${t.measureEvery} · ${t.intervalDays}'.toUpperCase(),
              style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
        ),
        if (left != null)
          Text(due ? t.measureDueNow : t.measureNextIn(left),
              style: AppTheme.f(12, weight: FontWeight.w600, color: due ? gc.accent : gc.textTertiary)),
      ]),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
        child: Row(children: [
          for (final days in _kMeasureEvery)
            tab(days <= 0 ? t.photoEveryOff : '$days', current == days, () => fit.setMeasureEvery(days)),
          tab(custom ? '$current' : t.custom, custom, () => _custom(context)),
        ]),
      ),
    ]);
  }
}

class _MeasureRow extends StatelessWidget {
  const _MeasureRow({super.key, required this.measureKey});

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
          radius: 16,
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fit.measureTitle(measureKey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
    'neck': (15.0, 80.0, 38.0),
    'shoulders': (25.0, 200.0, 115.0),
    'chest': (40.0, 200.0, 100.0),
    'arm': (10.0, 80.0, 34.0),
    'forearm': (10.0, 60.0, 28.0),
    'waist': (30.0, 200.0, 84.0),
    'hips': (40.0, 200.0, 98.0),
    'thigh': (20.0, 120.0, 56.0),
    'calf': (15.0, 80.0, 38.0),
  };

  String get _key => widget.measureKey;
  bool get _pct => fit.isPercent(_key);
  bool get _free => fit.isFreeMeasure(_key);
  double get _step => _free ? _freeStep : (_pct ? 0.5 : (fit.isInches ? 0.25 : 0.5));
  int get _major => _free ? 10 : (_pct ? 10 : (fit.isInches ? 4 : 10));

  late final double _freeStep = () {
    final latest = fit.latestMeasure(_key)?.value ?? 0;
    return latest > 0 && latest < 20 ? 0.1 : 0.5;
  }();

  (double, double) get _baseRange {
    if (_free) return (0, 100);
    if (_pct) return (3, 60);
    final r = _rangesCm[_key] ?? (10.0, 200.0, 50.0);
    return (_snap(fit.toDisplayCm(r.$1)), _snap(fit.toDisplayCm(r.$2)));
  }

  late (double, double) _range = _around(_value);

  double get _typedMax => _free ? 99999 : (_pct ? 100 : _snap(fit.toDisplayCm(400)));

  double _snap(double v) => (v / _step).round() * _step;

  late double _value = () {
    final latest = fit.latestMeasure(_key);
    if (latest != null) return _snap(fit.toDisplayMeasure(_key, latest.value));
    if (_free) return 50.0;
    if (_pct) return 20.0;
    return _snap(fit.toDisplayCm((_rangesCm[_key] ?? (10.0, 200.0, 50.0)).$3));
  }();

  String _show(double v) => decimalText(v.toStringAsFixed(_step < 0.25 ? 1 : (_step < 0.5 ? 2 : 1)));

  (double, double) _around(double v) {
    final (lo, hi) = _baseRange;
    if (_free) {
      final top = math.max(hi, (v * 1.6 / 10).ceil() * 10.0);
      return (0, top);
    }
    return (math.min(lo, v), math.max(hi, v));
  }

  Future<void> _rename() async {
    final c = fit.customMeasure(_key);
    if (c == null) return;
    final name = await askText(context, title: t.measureRename, initial: c.name, hint: t.measureNameHint);
    if (name == null || name.trim().isEmpty || !mounted) return;
    fit.editCustomMeasure(_key, name: name);
    setState(() {});
  }

  Future<void> _delete() async {
    final c = fit.customMeasure(_key);
    if (c == null) return;
    final ok = await askConfirm(context,
        title: t.measureDeleteTitle(c.name), body: t.measureDeleteBody, confirmLabel: t.delete, danger: true);
    if (!ok || !mounted) return;
    Navigator.of(context).pop();
    fit.deleteCustomMeasure(_key);
  }

  void _save() {
    if (_value <= 0) return;
    fit.addMeasure(_key, _value);
    Navigator.of(context).pop();
  }

  Future<void> _type() async {
    final typed = await askNumber(context, title: fit.measureTitle(_key), initial: _show(_value), decimal: true);
    if (typed == null || !mounted) return;
    if (typed <= 0) return;
    final v = math.max(_step, _snap(typed.clamp(_step, _typedMax)));
    setState(() {
      _value = v;
      _range = _around(v);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final history = fit.measureHistory(_key);
    final (lo, hi) = _range;

    return Container(
      decoration: sheetDecoration(gc),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetHandle(margin: const EdgeInsets.symmetric(vertical: 12)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(fit.measureTitle(_key),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
                    ),
                    if (fit.isCustomMeasure(_key))
                      Semantics(
                        button: true,
                        label: t.measureRename,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _rename,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(PhosphorIconsRegular.pencilSimple, size: 19, color: gc.textSecondary),
                          ),
                        ),
                      ),
                    Semantics(
                      button: true,
                      label: fit.measureTitle(_key),
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
                    child: Ltr(child: Row(
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
                    )),
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
                  PrimaryButton(label: t.save, onTap: _save, height: 52),
                  if (history.isNotEmpty) ...[
                    const SizedBox(height: 22),
                    Text(t.measureHistory,
                        style: AppTheme.d(12,
                            weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 2)),
                    const SizedBox(height: 10),
                    for (final m in history.take(6)) _historyRow(gc, m),
                  ],
                  if (fit.isCustomMeasure(_key)) ...[
                    const SizedBox(height: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _delete,
                      child: SizedBox(
                        height: 44,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(PhosphorIconsRegular.trash, size: 16, color: gc.danger),
                          const SizedBox(width: 8),
                          Text(t.measureDelete, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.danger)),
                        ]),
                      ),
                    ),
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

Future<void> showNewMeasureSheet(BuildContext context) async {
  final id = await showAppSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _NewMeasureSheet(),
  );
  if (id != null && id.isNotEmpty && context.mounted) showMeasureSheet(context, id);
}

class _NewMeasureSheet extends StatefulWidget {
  const _NewMeasureSheet();

  @override
  State<_NewMeasureSheet> createState() => _NewMeasureSheetState();
}

class _NewMeasureSheetState extends State<_NewMeasureSheet> {
  final _name = TextEditingController();
  final _unit = TextEditingController();
  bool _length = true;

  @override
  void dispose() {
    _name.dispose();
    _unit.dispose();
    super.dispose();
  }

  void _save() {
    if (_name.text.trim().isEmpty) {
      HapticFeedback.heavyImpact();
      return;
    }
    final id = fit.addCustomMeasure(_name.text, unit: _unit.text, length: _length);
    Navigator.of(context).pop(id);
  }

  Widget _field(GymColors gc, TextEditingController c, String hint, {bool autofocus = false, int max = 40}) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: TextField(
          controller: c,
          autofocus: autofocus,
          maxLength: max,
          textCapitalization: TextCapitalization.sentences,
          cursorColor: gc.accent,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _save(),
          style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: AppTheme.f(15, weight: FontWeight.w500, color: gc.textTertiary),
            counterText: '',
          ),
        ),
      );

  Widget _kind(GymColors gc, bool length, String title, String hint) {
    final on = _length == length;
    return Expanded(
      child: Semantics(
        button: true,
        selected: on,
        label: title,
        child: Pressable(
          scale: 0.97,
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _length = length);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: on ? gc.accent.withValues(alpha: 0.12) : gc.bgRaised2,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: on ? gc.accent : Colors.transparent, width: 1.5),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(height: 3),
              Text(hint, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final ready = _name.text.trim().isNotEmpty;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        padding: sheetPad(context),
        decoration: sheetDecoration(gc),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 16),
              SheetTitle(t.newMeasure, subtitle: t.newMeasureHint),
              const SizedBox(height: 18),
              _field(gc, _name, t.measureNameHint, autofocus: true),
              const SizedBox(height: 12),
              IntrinsicHeight(
                child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  _kind(gc, true, t.measureKindLength, t.measureKindLengthHint),
                  const SizedBox(width: 8),
                  _kind(gc, false, t.measureKindOther, t.measureKindOtherHint),
                ]),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: _length
                    ? const SizedBox(width: double.infinity)
                    : Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _field(gc, _unit, '${t.measureUnit} · ${t.measureUnitHint}', max: 8),
                      ),
              ),
              const SizedBox(height: 18),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 160),
                opacity: ready ? 1 : 0.45,
                child: PrimaryButton(label: t.save, onTap: _save, height: 52),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
