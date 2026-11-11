import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'local_image.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.pattern, this.photo, this.dim = 0.55});

  final String pattern;
  final String? photo;
  final double dim;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    if (pattern == 'photo') {
      final path = photo;
      if (path == null) return const SizedBox.shrink();
      final media = MediaQuery.of(context);
      final cacheWidth = (media.size.width * media.devicePixelRatio).round();
      return IgnorePointer(
        child: RepaintBoundary(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: ResizeImage.resizeIfNeeded(cacheWidth, null, localImage(path)),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      gc.bg.withValues(alpha: dim),
                      gc.bg.withValues(alpha: (dim + 0.18).clamp(0.0, 1.0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (pattern != 'dots' && pattern != 'grid') return const SizedBox.shrink();
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
      canvas.drawPoints(
        ui.PointMode.points,
        [
          for (double y = _gap; y < size.height; y += _gap)
            for (double x = _gap; x < size.width; x += _gap) Offset(x, y),
        ],
        Paint()
          ..color = color.withValues(alpha: 0.5)
          ..strokeWidth = 2.2
          ..strokeCap = StrokeCap.round,
      );
    } else {
      canvas.drawPoints(
        ui.PointMode.lines,
        [
          for (double x = _gap; x < size.width; x += _gap) ...[Offset(x, 0), Offset(x, size.height)],
          for (double y = _gap; y < size.height; y += _gap) ...[Offset(0, y), Offset(size.width, y)],
        ],
        Paint()
          ..color = color.withValues(alpha: 0.35)
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(_BgPainter old) => old.pattern != pattern || old.color != color;
}
