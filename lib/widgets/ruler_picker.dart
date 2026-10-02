import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'dialogs.dart';
import 'glass.dart';
import 'rolling_text.dart';
import 'ui_kit.dart';

class RulerPicker extends StatefulWidget {
  const RulerPicker({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
    this.majorEvery = 10,
    this.label,
    this.height = 86,
    this.axis = Axis.horizontal,
  });

  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double> onChanged;
  final int majorEvery;
  final String Function(double value)? label;
  final double height;
  final Axis axis;

  @override
  State<RulerPicker> createState() => _RulerPickerState();
}

class _RulerPickerState extends State<RulerPicker> {
  static const _gap = 11.0;
  late final ScrollController _scroll = ScrollController(initialScrollOffset: _offsetOf(widget.value));
  late int _index = _indexOf(widget.value);

  int get _count => ((widget.max - widget.min) / widget.step).round() + 1;

  int _indexOf(double v) => ((v.clamp(widget.min, widget.max) - widget.min) / widget.step).round();

  double _offsetOf(double v) => _indexOf(v) * _gap;

  double _valueAt(int i) {
    final raw = widget.min + i * widget.step;
    return (raw * 1000).round() / 1000;
  }

  @override
  void didUpdateWidget(RulerPicker old) {
    super.didUpdateWidget(old);
    final wanted = _indexOf(widget.value);
    if (wanted != _index && _scroll.hasClients && !_scroll.position.isScrollingNotifier.value) {
      _index = wanted;
      _scroll.animateTo(wanted * _gap, duration: const Duration(milliseconds: 260), curve: Curves.easeOutCubic);
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification n) {
    if (n is ScrollUpdateNotification || n is ScrollEndNotification) {
      final i = (_scroll.offset / _gap).round().clamp(0, _count - 1);
      if (i != _index) {
        _index = i;
        HapticFeedback.selectionClick();
        widget.onChanged(_valueAt(i));
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final vertical = widget.axis == Axis.vertical;
    return LayoutBuilder(builder: (context, box) {
      final side = (vertical ? widget.height : box.maxWidth) / 2 - _gap / 2;
      return SizedBox(
        height: widget.height,
        child: Stack(
          alignment: vertical ? Alignment.centerRight : Alignment.topCenter,
          children: [
            ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (r) => LinearGradient(
                begin: vertical ? Alignment.topCenter : Alignment.centerLeft,
                end: vertical ? Alignment.bottomCenter : Alignment.centerRight,
                colors: const [Color(0x00000000), Color(0xFF000000), Color(0xFF000000), Color(0x00000000)],
                stops: const [0, 0.18, 0.82, 1],
              ).createShader(r),
              child: NotificationListener<ScrollNotification>(
                onNotification: _onScroll,
                child: ListView.builder(
                  controller: _scroll,
                  scrollDirection: widget.axis,
                  reverse: vertical,
                  physics: const _SnapPhysics(_gap),
                  padding: vertical ? EdgeInsets.symmetric(vertical: side) : EdgeInsets.symmetric(horizontal: side),
                  itemExtent: _gap,
                  itemCount: _count,
                  itemBuilder: (context, i) {
                    final major = i % widget.majorEvery == 0;
                    final half = !major && widget.majorEvery % 2 == 0 && i % (widget.majorEvery ~/ 2) == 0;
                    return _Tick(
                      major: major,
                      half: half,
                      vertical: vertical,
                      label: major ? (widget.label ?? _plain)(_valueAt(i)) : null,
                      color: gc.textTertiary,
                      labelColor: gc.textSecondary,
                    );
                  },
                ),
              ),
            ),
            IgnorePointer(
              child: Container(
                width: vertical ? 44 : 3,
                height: vertical ? 3 : 44,
                decoration: BoxDecoration(color: gc.accent, borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ],
        ),
      );
    });
  }

  static String _plain(double v) => v == v.roundToDouble() ? '${v.round()}' : '$v';
}

class _Tick extends StatelessWidget {
  const _Tick({
    required this.major,
    required this.half,
    required this.label,
    required this.color,
    required this.labelColor,
    this.vertical = false,
  });

  final bool major;
  final bool half;
  final String? label;
  final Color color;
  final Color labelColor;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return OverflowBox(
        maxHeight: 40,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (label != null) ...[
              Text(label!, maxLines: 1, style: AppTheme.f(12, weight: FontWeight.w700, color: labelColor)),
              const SizedBox(width: 10),
            ],
            Container(
              width: major ? 34 : (half ? 24 : 16),
              height: major ? 2 : 1.4,
              decoration: BoxDecoration(
                color: major ? labelColor : color.withValues(alpha: half ? 0.9 : 0.6),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      );
    }
    return OverflowBox(
      maxWidth: 60,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: major ? 2 : 1.4,
            height: major ? 34 : (half ? 24 : 16),
            decoration: BoxDecoration(
              color: major ? labelColor : color.withValues(alpha: half ? 0.9 : 0.6),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 10),
            Text(label!, maxLines: 1, style: AppTheme.f(12, weight: FontWeight.w700, color: labelColor)),
          ],
        ],
      ),
    );
  }
}

class _SnapPhysics extends ScrollPhysics {
  const _SnapPhysics(this.extent, {super.parent});

  final double extent;

  @override
  _SnapPhysics applyTo(ScrollPhysics? ancestor) => _SnapPhysics(extent, parent: buildParent(ancestor));

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final tolerance = toleranceFor(position);
    final base = super.createBallisticSimulation(position, velocity);
    var target = position.pixels;
    if (base != null) target = base.x(double.infinity);
    target = ((target / extent).round() * extent).clamp(position.minScrollExtent, position.maxScrollExtent);
    if ((target - position.pixels).abs() < tolerance.distance && velocity.abs() < tolerance.velocity) {
      return null;
    }
    return ScrollSpringSimulation(
      SpringDescription.withDampingRatio(mass: 0.6, stiffness: 180, ratio: 1),
      position.pixels,
      target,
      velocity,
      tolerance: tolerance,
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}

const rulerCleared = double.nan;

Future<double?> askRuler(
  BuildContext context, {
  required String title,
  required double value,
  required double min,
  required double max,
  required double step,
  String unit = '',
  int majorEvery = 10,
  String Function(double value)? format,
  String Function(double value)? tickLabel,
  bool vertical = false,
  String? hint,
  String? clearLabel,
}) {
  var current = value.clamp(min, max).toDouble();
  final decimals = step == step.roundToDouble() ? 0 : (step < 0.1 || step * 10 != (step * 10).roundToDouble() ? 2 : 1);
  String show(double v) => format != null ? format(v) : decimalText(v.toStringAsFixed(decimals));
  return showAppSheet<double>(
    context: context,
    isScrollControlled: true,
    builder: (sheet) => StatefulBuilder(
      builder: (sheet, setSheet) {
        final gc = sheet.gc;
        final reading = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            RollingText(show(current), style: AppTheme.f(54, weight: FontWeight.w800, color: gc.text, height: 1.1)),
            if (unit.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(unit, style: AppTheme.f(18, weight: FontWeight.w700, color: gc.textSecondary)),
            ],
          ],
        );
        final ruler = RulerPicker(
          value: current,
          min: min,
          max: max,
          step: step,
          majorEvery: majorEvery,
          label: tickLabel,
          axis: vertical ? Axis.vertical : Axis.horizontal,
          height: vertical ? 300 : 86,
          onChanged: (v) => setSheet(() => current = v),
        );
        return Container(
          padding: sheetPad(sheet),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(
                  child: Text(titleCase(title),
                      style: AppTheme.f(15, weight: FontWeight.w700, color: gc.textSecondary)),
                ),
                Semantics(
                  button: true,
                  label: title,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      final typed = await askNumber(sheet,
                          title: title, initial: show(current), decimal: step != step.roundToDouble());
                      if (typed == null) return;
                      setSheet(() => current = ((typed.clamp(min, max) / step).round() * step).toDouble());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(PhosphorIconsRegular.keyboard, size: 20, color: gc.textSecondary),
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              if (vertical)
                Row(children: [
                  Expanded(child: Center(child: reading)),
                  SizedBox(width: 130, child: ruler),
                ])
              else ...[
                Center(child: reading),
                const SizedBox(height: 18),
                ruler,
              ],
              if (hint != null) ...[
                const SizedBox(height: 14),
                Text(hint,
                    textAlign: TextAlign.center,
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
              ],
              const SizedBox(height: 18),
              PrimaryButton(label: t.set, onTap: () => Navigator.of(sheet).pop(current)),
              if (clearLabel != null)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(sheet).pop(rulerCleared),
                  child: SizedBox(
                    height: 48,
                    child: Center(
                      child: Text(clearLabel,
                          style: AppTheme.f(14, weight: FontWeight.w600, color: gc.textSecondary)),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    ),
  );
}
