import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'svg_icon.dart';
import 'ui_kit.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({
    super.key,
    required this.title,
    required this.onBack,
    required this.children,
    this.eyebrow,
    this.actions = const [],
  });

  final String title;
  final String? eyebrow;
  final List<Widget> actions;
  final VoidCallback onBack;
  final List<Widget> children;

  @override
  State<SheetPage> createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage> {
  final _scroll = ScrollController();

  static const _side = 20.0;
  static const _corner = 32.0;
  static const _backTop = 12.0;
  static const _backSize = 40.0;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  double get _y => _scroll.hasClients ? _scroll.offset : 0.0;

  TextStyle _titleStyle(GymColors gc, double size) =>
      AppTheme.f(size, weight: FontWeight.w800, color: gc.text, letterSpacing: -size * 0.03, height: 1.0);

  (double, double) _fitTitle(GymColors gc, double maxWidth) {
    final words = widget.title.split(' ');
    TextPainter lay(double size) => TextPainter(
          text: TextSpan(text: widget.title, style: _titleStyle(gc, size)),
          textDirection: TextDirection.ltr,
          maxLines: 2,
        )..layout(maxWidth: maxWidth);
    var size = 42.0;
    while (size > 28) {
      final style = _titleStyle(gc, size);
      final widest = words
          .map((w) => (TextPainter(text: TextSpan(text: w, style: style), textDirection: TextDirection.ltr)..layout())
              .width)
          .fold(0.0, math.max);
      final all = lay(size);
      if (widest <= maxWidth && !all.didExceedMaxLines) return (size, all.height);
      size -= 2;
    }
    return (size, lay(size).height);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final pad = MediaQuery.paddingOf(context);
    final sheet = fit.dark ? Color.lerp(gc.bg, gc.bgRaised, 0.42)! : gc.bgRaised2;
    final eyebrow = widget.eyebrow;

    return LayoutBuilder(builder: (context, box) {
      final (size, titleH) = _fitTitle(gc, box.maxWidth - _side * 2);
      final bar = pad.top + _backTop + _backSize + 12;
      final titleTop = pad.top + _backTop + _backSize + (eyebrow == null ? 24 : 20);
      final header = titleTop + (eyebrow == null ? 0 : 24) + titleH + 34;
      final dockFrom = header - bar;

      return Stack(
        children: [
          Positioned(
            left: _side,
            right: _side,
            top: titleTop,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _scroll,
                builder: (context, child) {
                  final p = (_y / header).clamp(0.0, 1.0);
                  Widget layer = child!;
                  if (p > 0.01 && fit.blurOn) {
                    layer = ImageFiltered(
                      imageFilter: ui.ImageFilter.blur(sigmaX: 6 * p, sigmaY: 6 * p),
                      child: layer,
                    );
                  }
                  return Transform.translate(
                    offset: Offset(0, -_y * 0.45),
                    child: Opacity(opacity: (1 - p * 1.4).clamp(0.0, 1.0), child: layer),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (eyebrow != null) ...[
                      Text(eyebrow.toUpperCase(),
                          style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                      const SizedBox(height: 10),
                    ],
                    Text(widget.title, maxLines: 2, style: _titleStyle(gc, size)),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: header),
                AnimatedBuilder(
                  animation: _scroll,
                  builder: (context, child) {
                    final d = ((_y - dockFrom) / 18).clamp(0.0, 1.0);
                    final r = Radius.circular(_corner * (1 - d));
                    return ConstrainedBox(
                      constraints: BoxConstraints(minHeight: box.maxHeight - bar),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: sheet,
                          borderRadius: BorderRadius.vertical(top: r),
                          border: Border.all(color: gc.text.withValues(alpha: 0.06 * (1 - d))),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Opacity(
                              opacity: 1 - d,
                              child: SheetHandle(
                                color: gc.text.withValues(alpha: 0.14),
                                margin: const EdgeInsets.only(top: 10),
                              ),
                            ),
                            child!,
                          ],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(_side, 20, _side, pad.bottom + 40),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: widget.children),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: bar + 24,
            child: AnimatedBuilder(
              animation: _scroll,
              builder: (context, _) {
                final d = ((_y - dockFrom + 6) / 24).clamp(0.0, 1.0);
                return Stack(
                  children: [
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Opacity(
                          opacity: d,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0, bar / (bar + 24), 1],
                                colors: [sheet, sheet, sheet.withValues(alpha: 0)],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: _side,
                      top: pad.top + _backTop,
                      child: RoundBtn(icon: Ic.chevronLeft, onTap: widget.onBack),
                    ),
                    Positioned(
                      left: _side + _backSize + 14,
                      right: _side + widget.actions.length * 44,
                      top: pad.top + _backTop,
                      height: _backSize,
                      child: IgnorePointer(
                        child: Opacity(
                          opacity: d,
                          child: Transform.translate(
                            offset: Offset(0, 8 * (1 - d)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.3)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.actions.isNotEmpty)
                      Positioned(
                        right: _side,
                        top: pad.top + _backTop + 2,
                        child: Row(children: [
                          for (var i = 0; i < widget.actions.length; i++) ...[
                            if (i > 0) const SizedBox(width: 8),
                            widget.actions[i],
                          ],
                        ]),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
