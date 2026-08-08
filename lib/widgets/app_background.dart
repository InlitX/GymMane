import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.pattern});

  final String pattern;

  @override
  Widget build(BuildContext context) {
    if (pattern != 'dots' && pattern != 'grid') return const SizedBox.shrink();
    final gc = context.gc;
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _BgPainter(pattern: pattern, color: gc.border),
        ),
      ),
    );
  }
}

class _BgPainter extends CustomPainter {
  _BgPainter({required this.pattern, required this.color});

  final String pattern;
  final Color color;
  static const _gap = 26.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (pattern == 'dots') {
      final p = Paint()..color = color.withValues(alpha: 0.5);
      for (double y = _gap; y < size.height; y += _gap) {
        for (double x = _gap; x < size.width; x += _gap) {
          canvas.drawCircle(Offset(x, y), 1.1, p);
        }
      }
    } else {
      final p = Paint()
        ..color = color.withValues(alpha: 0.35)
        ..strokeWidth = 1;
      for (double x = _gap; x < size.width; x += _gap) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
      }
      for (double y = _gap; y < size.height; y += _gap) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
      }
    }
  }

  @override
  bool shouldRepaint(_BgPainter old) => old.pattern != pattern || old.color != color;
}
