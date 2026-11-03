import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'ui_kit.dart';

class SpeedPanel extends StatelessWidget {
  const SpeedPanel({super.key, required this.rows, this.footer});

  final List<(String label, String hint, bool on, VoidCallback onTap)> rows;
  final String? footer;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final blur = rows.isNotEmpty && rows.first.$3;
    final motion = rows.length > 1 && rows[1].$3;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(28)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 11,
          child: Column(children: [
            for (final (i, (label, hint, on, tap)) in rows.indexed) ...[
              if (i > 0) const SizedBox(height: 8),
              Pressable(
                scale: 0.97,
                onTap: () {
                  HapticFeedback.selectionClick();
                  tap();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(14, 12, 12, 14),
                  decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(
                        child: Text(label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(13.5, weight: FontWeight.w700, color: on ? gc.text : gc.textSecondary)),
                      ),
                      const SizedBox(width: 6),
                      TinySwitch(on: on),
                    ]),
                    const SizedBox(height: 6),
                    Text(hint, style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.35)),
                  ]),
                ),
              ),
            ],
            if (footer != null) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(footer!,
                    style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.35)),
              ),
            ],
          ]),
        ),
        const SizedBox(width: 12),
        Expanded(flex: 9, child: AspectRatio(aspectRatio: 0.56, child: _SpeedSketch(blur: blur, motion: motion))),
      ]),
    );
  }
}

class _SpeedSketch extends StatefulWidget {
  const _SpeedSketch({required this.blur, required this.motion});

  final bool blur;
  final bool motion;

  @override
  State<_SpeedSketch> createState() => _SpeedSketchState();
}

class _SpeedSketchState extends State<_SpeedSketch> with SingleTickerProviderStateMixin {
  late final AnimationController _open = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
    value: 1,
  );

  @override
  void didUpdateWidget(_SpeedSketch old) {
    super.didUpdateWidget(old);
    if (old.blur == widget.blur && old.motion == widget.motion) return;
    if (widget.motion) {
      _open.forward(from: 0);
    } else {
      _open.value = 1;
    }
  }

  @override
  void dispose() {
    _open.dispose();
    super.dispose();
  }

  Widget _bar(double w, double h, Color color) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(h)),
      );

  Widget _home(GymColors gc) {
    final soft = gc.text.withValues(alpha: 0.22);
    Widget box(double h, Widget child, {Color? color}) => Container(
          height: h,
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(color: color ?? gc.bgRaised, borderRadius: BorderRadius.circular(10)),
          child: child,
        );
    return Container(
      color: gc.bg,
      padding: const EdgeInsets.fromLTRB(9, 12, 9, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Align(alignment: Alignment.centerLeft, child: _bar(40, 5, soft)),
        const SizedBox(height: 9),
        box(
          58,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _bar(46, 6, gc.text.withValues(alpha: 0.7)),
            const SizedBox(height: 5),
            _bar(30, 4, soft),
            const Spacer(),
            _bar(double.infinity, 11, gc.text),
          ]),
          color: gc.bgRaised2,
        ),
        box(
          26,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            for (var i = 0; i < 7; i++)
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(shape: BoxShape.circle, color: i > 2 && i < 6 ? gc.text : gc.bgRaised2),
              ),
          ]),
        ),
        Row(children: [
          for (final c in [gc.accent, gc.sage]) ...[
            if (c == gc.sage) const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(color: c.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ]),
        const SizedBox(height: 6),
        Row(children: [
          for (var i = 0; i < 3; i++) ...[
            if (i > 0) const SizedBox(width: 5),
            Expanded(child: box(30, const SizedBox.shrink())),
          ],
        ]),
      ]),
    );
  }

  Widget _sheet(GymColors gc) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 7, 10, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: _bar(18, 3, gc.text.withValues(alpha: 0.3))),
          const SizedBox(height: 10),
          _bar(54, 6, gc.text.withValues(alpha: 0.8)),
          const SizedBox(height: 6),
          _bar(36, 4, gc.text.withValues(alpha: 0.3)),
          const Spacer(),
          _bar(double.infinity, 13, gc.text),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final blur = widget.blur;
    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: Colors.black,
          child: AnimatedBuilder(
            animation: _open,
            builder: (context, _) {
              final v = Curves.easeOutCubic.transform(_open.value);
              return LayoutBuilder(builder: (context, box) {
                final sheetH = box.maxHeight * 0.48;
                final page = Transform.scale(
                  scale: 1 - (blur ? 0.06 : 0.03) * v,
                  child: ClipRRect(borderRadius: BorderRadius.circular(16 * v), child: _home(gc)),
                );
                return Stack(children: [
                  Positioned.fill(
                    child: blur
                        ? ImageFiltered(imageFilter: ui.ImageFilter.blur(sigmaX: 2.5 * v, sigmaY: 2.5 * v), child: page)
                        : Opacity(opacity: 1 - 0.35 * v, child: page),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -sheetH * (1 - v),
                    height: sheetH,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: blur
                          ? BackdropFilter(
                              filter: ui.ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                              child: ColoredBox(color: gc.bgRaised.withValues(alpha: 0.55), child: _sheet(gc)),
                            )
                          : ColoredBox(color: gc.bgRaised2, child: _sheet(gc)),
                    ),
                  ),
                ]);
              });
            },
          ),
        ),
      ),
    );
  }
}
