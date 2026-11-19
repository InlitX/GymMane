import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../state/fit_state.dart';
import '../theme/app_colors.dart';

class RestGlow extends StatefulWidget {
  const RestGlow({super.key, required this.tick});

  final int tick;

  @override
  State<RestGlow> createState() => _RestGlowState();
}

class _RestGlowState extends State<RestGlow> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1700));

  @override
  void didUpdateWidget(RestGlow old) {
    super.didUpdateWidget(old);
    if (old.tick != widget.tick) _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.gc.sage;
    final pulses = fit.calmMotion ? 1 : 2;
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          if (!_c.isAnimating) return const SizedBox.expand();
          final s = math.sin(math.pi * pulses * _c.value);
          return CustomPaint(
            size: Size.infinite,
            painter: _GlowPainter(color, s * s, MediaQuery.paddingOf(context).top > 30 ? 44 : 28),
          );
        },
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  _GlowPainter(this.color, this.level, this.radius);

  final Color color;
  final double level;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    if (level <= 0.01) return;
    final rect = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius));
    canvas.save();
    canvas.clipRRect(rect);
    for (final (width, blur, alpha) in const [(34.0, 26.0, 0.55), (10.0, 6.0, 0.85)]) {
      canvas.drawRRect(
        rect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = width
          ..color = color.withValues(alpha: alpha * level)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur),
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_GlowPainter old) => old.level != level || old.color != color || old.radius != radius;
}
