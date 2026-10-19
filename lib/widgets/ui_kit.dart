import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'rolling_text.dart';
import 'svg_icon.dart';

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 20,
    this.borderColor,
    this.color,
    this.clip = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? borderColor;
  final Color? color;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: padding,
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      decoration: BoxDecoration(
        color: color ?? gc.bgRaised,
        border: Border.all(color: borderColor ?? gc.border),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}

EdgeInsets sheetPad(BuildContext context, {double bottom = 28}) =>
    EdgeInsets.fromLTRB(20, 12, 20, bottom + MediaQuery.paddingOf(context).bottom);

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.color,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 16, right: 6),
      decoration: BoxDecoration(color: color ?? gc.bgRaised, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          SvgPathIcon(Ic.search, size: 16, color: gc.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTheme.f(14, weight: FontWeight.w500, color: gc.text),
              cursorColor: gc.accent,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTheme.f(14, weight: FontWeight.w500, color: gc.textSecondary),
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) => value.text.isEmpty
                ? const SizedBox(width: 10)
                : Semantics(
                    button: true,
                    label: MaterialLocalizations.of(context).deleteButtonTooltip,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        controller.clear();
                        onChanged('');
                      },
                      child: SizedBox(
                        width: 40,
                        height: 48,
                        child: Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
                            child: Center(child: SvgPathIcon(Ic.close, size: 10, color: gc.textSecondary)),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class TinySwitch extends StatelessWidget {
  const TinySwitch({super.key, required this.on});

  final bool on;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      width: 44,
      height: 26,
      padding: const EdgeInsets.all(3),
      alignment: on ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: on ? gc.ember : gc.bgRaised2,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: on ? gc.ember : gc.border),
      ),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(color: on ? gc.onEmber : gc.textTertiary, shape: BoxShape.circle),
      ),
    );
  }
}

class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.child,
    required this.onTap,
    this.scale = 0.965,
    this.onLongPress,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scale;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;

  void _set(bool v) {
    if (_down != v && mounted) setState(() => _down = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: widget.onTap == null ? null : (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      child: AnimatedScale(
        scale: _down ? widget.scale : 1,
        duration: Duration(milliseconds: _down ? 90 : 260),
        curve: _down ? Curves.easeOut : Curves.easeOutBack,
        child: widget.child,
      ),
    );
  }
}

class GhostButton extends StatelessWidget {
  const GhostButton({super.key, required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: onTap,
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: context.gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: gc.ember),
            const SizedBox(width: 8),
            Text(
              titleCase(label),
              style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text),
            ),
          ],
        ),
      ),
    );
  }
}

class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key, this.color, this.margin});

  final Color? color;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 40,
      height: 4,
      margin: margin,
      decoration: BoxDecoration(color: color ?? context.gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
    ),
  );
}

class SheetTitle extends StatelessWidget {
  const SheetTitle(this.text, {super.key, this.subtitle});

  final String text;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: AppTheme.f(17, weight: FontWeight.w700, color: gc.text),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35),
          ),
        ],
      ],
    );
  }
}

class OptionItem {
  const OptionItem(
    this.label, {
    required this.onTap,
    this.icon,
    this.leading,
    this.detail,
    this.selected = false,
    this.danger = false,
    this.trailing,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? leading;
  final String? detail;
  final bool selected;
  final bool danger;
  final Widget? trailing;
}

class OptionGroup extends StatelessWidget {
  const OptionGroup(this.items, {super.key, this.scroll = false});

  final List<OptionItem> items;
  final bool scroll;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final divider = Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: gc.border);
    final Widget body = scroll
        ? ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: items.length,
            separatorBuilder: (_, _) => divider,
            itemBuilder: (_, i) => _OptionRow(items[i]),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < items.length; i++) ...[if (i > 0) divider, _OptionRow(items[i])],
            ],
          );
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: ColoredBox(color: gc.bgRaised2, child: body),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow(this.o);

  final OptionItem o;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final tone = o.danger ? gc.danger : (o.selected ? gc.ember : gc.text);
    return Semantics(
      button: true,
      selected: o.selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: o.onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: o.detail == null ? 0 : 11),
            child: Row(
              children: [
                if (o.leading != null) ...[
                  o.leading!,
                  const SizedBox(width: 12),
                ] else if (o.icon != null) ...[
                  Icon(
                    o.icon,
                    size: 19,
                    color: o.danger ? gc.danger : (o.selected ? gc.ember : gc.textSecondary),
                  ),
                  const SizedBox(width: 14),
                ],
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o.label,
                        style: AppTheme.f(
                          14.5,
                          weight: o.selected ? FontWeight.w800 : FontWeight.w600,
                          color: tone,
                        ),
                      ),
                      if (o.detail != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          o.detail!,
                          style: AppTheme.f(
                            12,
                            weight: FontWeight.w500,
                            color: gc.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (o.selected) ...[
                  const SizedBox(width: 10),
                  Icon(PhosphorIconsFill.checkCircle, size: 18, color: gc.ember),
                ],
                if (o.trailing != null) ...[const SizedBox(width: 6), o.trailing!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundAction extends StatelessWidget {
  const RoundAction({
    super.key,
    required this.child,
    required this.onTap,
    this.label,
    this.size = 36,
    this.filled = false,
  });

  final Widget child;
  final VoidCallback onTap;
  final String? label;
  final double size;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final button = Pressable(
      onTap: onTap,
      scale: 0.9,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: filled ? gc.ember : gc.bgRaised,
          shape: BoxShape.circle,
          border: Border.all(color: filled ? gc.ember : gc.border),
        ),
        child: Center(child: child),
      ),
    );
    return label == null ? button : Semantics(button: true, label: label, child: button);
  }
}

class RoundBtn extends StatelessWidget {
  const RoundBtn({super.key, required this.icon, required this.onTap, this.iconColor});
  final List<IconPath> icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => RoundAction(
    onTap: onTap,
    child: SvgPathIcon(icon, size: 16, color: iconColor ?? context.gc.text),
  );
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.subtitle,
    this.titleSize = 20,
    this.titleSpacing = 2,
    this.actions = const [],
    this.badge,
  });

  final String title;
  final VoidCallback onBack;
  final Widget? badge;
  final String? subtitle;
  final double titleSize;
  final double titleSpacing;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Row(
      children: [
        RoundBtn(icon: Ic.chevronLeft, onTap: onBack),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (badge == null)
                ScreenTitle(title, size: titleSize, spacing: titleSpacing)
              else
                Row(
                  children: [
                    Flexible(
                      child: ScreenTitle(title, size: titleSize, spacing: titleSpacing),
                    ),
                    const SizedBox(width: 8),
                    badge!,
                  ],
                ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary),
                ),
              ],
            ],
          ),
        ),
        ...actions,
      ],
    );
  }
}

class BetaTag extends StatelessWidget {
  const BetaTag(this.label, {super.key, this.small = false});

  final String label;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: EdgeInsets.fromLTRB(small ? 5 : 6, small ? 2 : 3, small ? 6 : 7, small ? 2 : 3),
      decoration: BoxDecoration(
        color: gc.accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: gc.accent.withValues(alpha: 0.4), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PhosphorIconsFill.flask, size: small ? 9 : 10.5, color: gc.accent),
          const SizedBox(width: 3),
          Text(
            label.toUpperCase(),
            style: AppTheme.f(
              small ? 8.5 : 9.5,
              weight: FontWeight.w800,
              color: gc.accent,
              letterSpacing: 1.1,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

String sentenceCase(String s) {
  if (s.isEmpty || s != s.toUpperCase() || s == s.toLowerCase()) return s;
  return s[0] + s.substring(1).toLowerCase();
}

ReorderItemProxyDecorator liftedRow(double radius) =>
    (child, _, animation) => AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, kid) {
        final t = Curves.easeOutCubic.transform(animation.value);
        return Transform.scale(
          scale: 1 + 0.03 * t,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35 * t),
                  blurRadius: 18 * t,
                  offset: Offset(0, 8 * t),
                ),
              ],
            ),
            child: Material(type: MaterialType.transparency, child: kid),
          ),
        );
      },
    );

void reorderPicked(int _) => HapticFeedback.selectionClick();

void reorderDropped(int _) => HapticFeedback.lightImpact();

class FitText extends StatelessWidget {
  const FitText(this.text, {super.key, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => FittedBox(
    fit: BoxFit.scaleDown,
    alignment: AlignmentDirectional.centerStart,
    child: Text(text, maxLines: 1, style: style),
  );
}

String titleCase(String s) {
  if (s.isEmpty || s != s.toUpperCase()) return s;
  if (s.length <= 4 && !s.contains(' ')) return s;
  if (RegExp(r'[0-9]').hasMatch(s)) return s;
  return s[0] + s.substring(1).toLowerCase();
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle(this.text, {super.key, this.size = 22, this.spacing = 2});
  final String text;
  final double size;
  final double spacing;
  @override
  Widget build(BuildContext context) => MarqueeText(
    titleCase(text),
    style: AppTheme.f(size, weight: FontWeight.w800, color: context.gc.text),
  );
}

class MarqueeText extends StatefulWidget {
  const MarqueeText(this.text, {super.key, required this.style});
  final String text;
  final TextStyle style;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> with SingleTickerProviderStateMixin {
  static const _gap = 48.0;
  static const _speed = 38.0;
  static const _holdMs = 1600;

  late final AnimationController _c;
  double _run = 0;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this);
  }

  int get _scrollMs => (_run / _speed * 1000).round();

  void _sync(double run, bool still) {
    if (run == _run) return;
    _run = run;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _run != run) return;
      if (run == 0) {
        _c.stop();
        _c.value = 0;
        return;
      }
      _c.duration = Duration(milliseconds: _holdMs + _scrollMs);
      _c.value = 0;
      if (!_paused && !still) _c.repeat();
    });
  }

  void _toggle() {
    setState(() => _paused = !_paused);
    if (_paused) {
      _c.stop();
    } else {
      _c.repeat();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final tp = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
          maxLines: 1,
        )..layout();
        final fits = tp.width <= box.maxWidth;
        _sync(fits ? 0 : tp.width + _gap, MediaQuery.disableAnimationsOf(context));
        final plain = Text(widget.text, maxLines: 1, overflow: TextOverflow.ellipsis, style: widget.style);
        if (fits) return plain;
        final rtl = Directionality.of(context) == TextDirection.rtl;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: SizedBox(
            width: box.maxWidth,
            height: tp.height,
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _c,
                builder: (context, child) {
                  final total = _holdMs + _scrollMs;
                  final ms = _c.value * total;
                  final dx = ms <= _holdMs ? 0.0 : (ms - _holdMs) / _scrollMs * _run;
                  return Transform.translate(offset: Offset(rtl ? dx : -dx, 0), child: child);
                },
                child: OverflowBox(
                  alignment: rtl ? Alignment.centerRight : Alignment.centerLeft,
                  maxWidth: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.text, maxLines: 1, softWrap: false, style: widget.style),
                      const SizedBox(width: _gap),
                      Text(widget.text, maxLines: 1, softWrap: false, style: widget.style),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Kicker extends StatelessWidget {
  const Kicker(this.text, {super.key, required this.color, this.size = 12, this.spacing = 3});
  final String text;
  final Color color;
  final double size;
  final double spacing;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: AppTheme.f(size, weight: FontWeight.w600, color: color, letterSpacing: spacing),
  );
}

class StepperControl extends StatelessWidget {
  const StepperControl({
    super.key,
    required this.value,
    required this.onDec,
    required this.onInc,
    this.onEdit,
    this.minWidth = 70,
    this.btnSize = 30,
    this.gap = 14,
    this.fontSize = 16,
    this.btnRadius = 8,
  });

  final String value;
  final VoidCallback onDec;
  final VoidCallback onInc;
  final VoidCallback? onEdit;
  final double minWidth;
  final double btnSize;
  final double gap;
  final double fontSize;
  final double btnRadius;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget btn(String glyph, VoidCallback onTap) => GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnSize,
        height: btnSize,
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(btnRadius)),
        alignment: Alignment.center,
        child: Text(
          glyph,
          style: TextStyle(color: gc.text, fontSize: fontSize + 2, height: 1, fontWeight: FontWeight.w500),
        ),
      ),
    );
    Widget label = Container(
      constraints: BoxConstraints(minWidth: minWidth),
      alignment: Alignment.center,
      child: RollingText(
        value,
        style: AppTheme.f(fontSize, weight: FontWeight.w700, color: gc.text),
      ),
    );
    if (onEdit != null) {
      label = GestureDetector(behavior: HitTestBehavior.opaque, onTap: onEdit, child: label);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        btn('–', onDec),
        SizedBox(width: gap),
        label,
        SizedBox(width: gap),
        btn('+', onInc),
      ],
    );
  }
}

class ToolRow extends StatelessWidget {
  const ToolRow({super.key, required this.label, required this.control});
  final String label;
  final Widget control;
  @override
  Widget build(BuildContext context) {
    return SoftCard(
      radius: 20,
      borderColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: _line(context),
    );
  }

  Widget _line(BuildContext context) {
    final gc = context.gc;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                sentenceCase(label),
                style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text),
              ),
            ),
            const SizedBox(width: 12),
            control,
          ],
        ),
      ),
    );
  }
}

class ToolGroup extends StatelessWidget {
  const ToolGroup(this.rows, {super.key});

  final List<ToolRow> rows;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ColoredBox(
        color: gc.bgRaised,
        child: Column(
          children: [
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: gc.border),
              rows[i]._line(context),
            ],
          ],
        ),
      ),
    );
  }
}

class SegOption {
  const SegOption(this.label, this.selected, this.onTap);
  final String label;
  final bool selected;
  final VoidCallback onTap;
}

class SegToggle extends StatelessWidget {
  const SegToggle(this.options, {super.key, this.hPad = 14, this.vPad = 7, this.fontSize = 12});
  final List<SegOption> options;
  final double hPad;
  final double vPad;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final o in options)
            GestureDetector(
              onTap: o.onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
                decoration: BoxDecoration(
                  color: o.selected ? gc.ember : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  o.label,
                  style: AppTheme.f(
                    fontSize,
                    weight: FontWeight.w600,
                    color: o.selected ? gc.onEmber : gc.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DashedRail extends StatelessWidget {
  const DashedRail({super.key, required this.color, this.dash = 4, this.gap = 5, this.thickness = 1.6});

  final Color color;
  final double dash;
  final double gap;
  final double thickness;

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: thickness,
      child: CustomPaint(size: Size.infinite, painter: _DashPainter(color, dash, gap, thickness)),
    ),
  );
}

class _DashPainter extends CustomPainter {
  _DashPainter(this.color, this.dash, this.gap, this.thickness);
  final Color color;
  final double dash, gap, thickness;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
    for (double y = 0; y < size.height; y += dash + gap) {
      canvas.drawLine(Offset(size.width / 2, y), Offset(size.width / 2, math.min(y + dash, size.height)), p);
    }
  }

  @override
  bool shouldRepaint(_DashPainter o) => o.color != color || o.dash != dash || o.gap != gap;
}

class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    required this.bg,
    required this.fg,
    required this.onTap,
    this.hPad = 14,
    this.vPad = 8,
    this.fontSize = 13,
  });
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  final double hPad;
  final double vPad;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      scale: 0.94,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(100)),
        child: Text(
          titleCase(label),
          style: AppTheme.f(fontSize, weight: FontWeight.w600, color: fg),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.bg,
    this.fg,
    this.height = 56,
    this.icon,
  });
  final String label;
  final VoidCallback onTap;
  final Color? bg;
  final Color? fg;
  final double height;
  final List<IconPath>? icon;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final f = fg ?? gc.onEmber;
    return Pressable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(color: bg ?? gc.ember, borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[SvgPathIcon(icon!, size: 15, color: f), const SizedBox(width: 9)],
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  titleCase(label),
                  maxLines: 1,
                  style: AppTheme.f(15.5, weight: FontWeight.w700, color: f, letterSpacing: 0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
