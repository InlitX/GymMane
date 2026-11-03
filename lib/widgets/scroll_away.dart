import 'package:flutter/material.dart';

double _smooth(double from, double to, double x) {
  final t = ((x - from) / (to - from)).clamp(0.0, 1.0);
  return t * t * (3 - 2 * t);
}

class ScrollAway extends StatefulWidget {
  const ScrollAway({
    super.key,
    required this.child,
    this.radius = 0,
    this.depth = 0.08,
    this.follow = 0.18,
    this.dim = 0.45,
    this.lead = 64,
  });

  final Widget child;
  final double radius;
  final double depth;
  final double follow;
  final double dim;
  final double lead;

  @override
  State<ScrollAway> createState() => ScrollAwayState();
}

class ScrollAwayState extends State<ScrollAway> {
  final progress = ValueNotifier<double>(0);
  ScrollPosition? _pos;
  double _height = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pos = Scrollable.maybeOf(context)?.position;
    if (pos == _pos) return;
    _pos?.removeListener(_update);
    _pos = pos?..addListener(_update);
    WidgetsBinding.instance.addPostFrameCallback((_) => _update());
  }

  void _update() {
    if (!mounted) return;
    final pos = _pos;
    final box = context.findRenderObject();
    final view = Scrollable.maybeOf(context)?.context.findRenderObject();
    if (pos == null || box is! RenderBox || view is! RenderBox) return;
    if (!box.attached || !box.hasSize || !pos.hasPixels) return;
    final top = box.localToGlobal(Offset.zero, ancestor: view).dy + pos.pixels;
    _height = box.size.height;
    final start = (top - widget.lead).clamp(0.0, double.infinity);
    final span = top + _height - start;
    final p = span <= 0 ? 0.0 : ((pos.pixels - start) / span).clamp(0.0, 1.0);
    progress.value = (p * 200).roundToDouble() / 200;
  }

  @override
  void dispose() {
    _pos?.removeListener(_update);
    progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;
    final card = RepaintBoundary(child: widget.child);
    return ValueListenableBuilder<double>(
      valueListenable: progress,
      child: card,
      builder: (context, p, child) {
        final scale = 1 - widget.depth * p;
        return Transform(
          alignment: const Alignment(0, -0.3),
          transform: Matrix4.identity()
            ..translateByDouble(0, p * widget.follow * _height, 0, 1)
            ..scaleByDouble(scale, scale, 1, 1),
          child: Opacity(
            opacity: 1 - _smooth(0.2, 0.95, p),
            child: widget.dim <= 0
                ? child
                : DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: widget.dim * p),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    child: child,
                  ),
          ),
        );
      },
    );
  }
}
