import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void celebrate(BuildContext context, {required List<Color> colors}) {
  HapticFeedback.heavyImpact();
  Timer(const Duration(milliseconds: 110), HapticFeedback.lightImpact);
  Timer(const Duration(milliseconds: 220), HapticFeedback.lightImpact);
  if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return;
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => IgnorePointer(
      child: Confetti(colors: colors, onDone: () => entry.remove()),
    ),
  );
  overlay.insert(entry);
}

class Confetti extends StatefulWidget {
  const Confetti({super.key, required this.colors, required this.onDone});

  final List<Color> colors;
  final VoidCallback onDone;

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 3400))
        ..addStatusListener((s) {
          if (s == AnimationStatus.completed) widget.onDone();
        })
        ..forward();

  late final List<_Bit> _bits = _spawn();

  List<_Bit> _spawn() {
    final r = math.Random();
    final out = <_Bit>[];
    for (var side = 0; side < 2; side++) {
      for (var i = 0; i < 34; i++) {
        final angle = (62 + r.nextDouble() * 24) * math.pi / 180;
        final speed = 1250 + r.nextDouble() * 650;
        out.add(
          _Bit(
            left: side == 0,
            vx: math.cos(angle) * speed * (side == 0 ? 1 : -1),
            vy: -math.sin(angle) * speed,
            delay: r.nextDouble() * 0.12,
            color: widget.colors[r.nextInt(widget.colors.length)],
            shape: r.nextInt(3),
            size: 0.8 + r.nextDouble() * 0.5,
            spin: (r.nextDouble() - 0.5) * 9,
            flip: 5 + r.nextDouble() * 7,
            phase: r.nextDouble() * math.pi * 2,
            sway: 10 + r.nextDouble() * 22,
          ),
        );
      }
    }
    return out;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(size: Size.infinite, painter: _ConfettiPainter(_bits, _c)),
    );
  }
}

class _Bit {
  _Bit({
    required this.left,
    required this.vx,
    required this.vy,
    required this.delay,
    required this.color,
    required this.shape,
    required this.size,
    required this.spin,
    required this.flip,
    required this.phase,
    required this.sway,
  });

  final bool left;
  final double vx, vy, delay, size, spin, flip, phase, sway;
  final Color color;
  final int shape;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.bits, this.anim) : super(repaint: anim);

  final List<_Bit> bits;
  final Animation<double> anim;

  static const _k = 2.7;
  static const _g = 760.0;

  @override
  void paint(Canvas canvas, Size size) {
    final total = anim.value * 3.4;
    final paint = Paint();
    for (final b in bits) {
      final t = total - b.delay;
      if (t <= 0) continue;
      final decay = (1 - math.exp(-_k * t)) / _k;
      final x0 = b.left ? -6.0 : size.width + 6;
      final y0 = size.height * 0.92;
      final settle = (t * 1.4).clamp(0.0, 1.0);
      final x = x0 + b.vx * decay + math.sin(t * 3.2 + b.phase) * b.sway * settle;
      final y = y0 + (_g / _k) * t + (b.vy - _g / _k) * decay;
      if (y > size.height + 30) continue;
      final fade = ((3.4 - total) / 0.9).clamp(0.0, 1.0);
      paint.color = b.color.withValues(alpha: b.color.a * 0.92 * fade);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(b.spin * t + b.phase);
      canvas.scale(1, math.cos(b.flip * t + b.phase));
      switch (b.shape) {
        case 0:
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(center: Offset.zero, width: 8 * b.size, height: 5 * b.size),
              const Radius.circular(1.4),
            ),
            paint,
          );
        case 1:
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(center: Offset.zero, width: 12 * b.size, height: 2.6 * b.size),
              const Radius.circular(1.3),
            ),
            paint,
          );
        default:
          canvas.drawCircle(Offset.zero, 2.8 * b.size, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => false;
}
