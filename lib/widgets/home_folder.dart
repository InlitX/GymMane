import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'routine_folder.dart';
import 'ui_kit.dart';

class HomeFolder extends StatelessWidget {
  const HomeFolder({
    super.key,
    required this.title,
    required this.detail,
    required this.peek,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String detail;
  final Widget peek;
  final VoidCallback onTap;
  final Widget? badge;

  static const height = 150.0;
  static const _front = 60.0;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final dark = gc.bg.computeLuminance() < 0.5;
    return Semantics(
      button: true,
      label: '$title, $detail',
      child: Pressable(
        onTap: onTap,
        scale: 0.96,
        child: SizedBox(
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                top: 26,
                child: CustomPaint(
                  painter: _BackPainter(Color.lerp(gc.bgRaised, gc.bg, dark ? 0.45 : 0.6)!),
                ),
              ),
              Positioned(left: 10, right: 10, top: 22, height: _front + 6, child: peek),
              Positioned.fill(
                top: _front,
                child: CustomPaint(
                  painter: _FrontPainter(
                    top: Color.lerp(gc.bgRaised, dark ? Colors.white : gc.bgRaised, dark ? 0.1 : 0)!,
                    bottom: Color.lerp(gc.bgRaised, dark ? Colors.white : gc.bg, dark ? 0.02 : 0.35)!,
                    edge: dark ? Colors.white.withValues(alpha: 0.08) : gc.border,
                    shadow: Colors.black.withValues(alpha: dark ? 0.5 : 0.12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 24, 10, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(title,
                                  maxLines: 1,
                                  style: AppTheme.f(15.5, weight: FontWeight.w800, color: gc.text)),
                            ),
                          ),
                          if (badge != null) ...[const SizedBox(width: 7), badge!],
                        ]),
                        const Spacer(),
                        Text(detail,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textSecondary)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Path _folderPath(Size s, {required bool tabLeft, double tab = 12}) {
  const r = 16.0;
  final w = s.width, h = s.height;
  final split = w * 0.48;
  final p = Path();
  if (tabLeft) {
    p
      ..moveTo(0, r)
      ..quadraticBezierTo(0, 0, r, 0)
      ..lineTo(split - 10, 0)
      ..cubicTo(split + 2, 0, split + 4, tab, split + 18, tab)
      ..lineTo(w - r, tab)
      ..quadraticBezierTo(w, tab, w, tab + r);
  } else {
    p
      ..moveTo(0, tab + r)
      ..quadraticBezierTo(0, tab, r, tab)
      ..lineTo(w - split - 18, tab)
      ..cubicTo(w - split - 4, tab, w - split - 2, 0, w - split + 10, 0)
      ..lineTo(w - r, 0)
      ..quadraticBezierTo(w, 0, w, r);
  }
  return p
    ..lineTo(w, h - r - 2)
    ..quadraticBezierTo(w, h, w - r - 2, h)
    ..lineTo(r + 2, h)
    ..quadraticBezierTo(0, h, 0, h - r - 2)
    ..close();
}

class _BackPainter extends CustomPainter {
  _BackPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(_folderPath(size, tabLeft: false, tab: 10), Paint()..color = color);
  }

  @override
  bool shouldRepaint(_BackPainter o) => o.color != color;
}

class _FrontPainter extends CustomPainter {
  _FrontPainter({required this.top, required this.bottom, required this.edge, required this.shadow});
  final Color top;
  final Color bottom;
  final Color edge;
  final Color shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _folderPath(size, tabLeft: true);
    canvas.drawShadow(path.shift(const Offset(0, -6)), shadow, 10, true);
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, bottom],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [edge, edge.withValues(alpha: 0)],
          stops: const [0, 0.6],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(_FrontPainter o) =>
      o.top != top || o.bottom != bottom || o.edge != edge || o.shadow != shadow;
}

class _Fan extends StatelessWidget {
  const _Fan({required this.children, required this.width, required this.height, this.spread = 1});

  final List<Widget> children;
  final double width;
  final double height;
  final double spread;

  static const _turns = [-0.12, 0.09, -0.02];
  static const _dx = [-0.2, 0.2, 0.0];
  static const _dy = [10.0, 7.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final n = math.min(children.length, 3);
        final order = n == 3 ? [0, 1, 2] : n == 2 ? [0, 1] : [2];
        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (var k = 0; k < n; k++)
              Positioned(
                left: (box.maxWidth - width) / 2 + _dx[order[k]] * spread * box.maxWidth,
                top: _dy[order[k]],
                width: width,
                height: height,
                child: Transform.rotate(angle: _turns[order[k]], child: children[k]),
              ),
          ],
        );
      },
    );
  }
}

class RoutinesPeek extends StatelessWidget {
  const RoutinesPeek({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final dark = gc.bg.computeLuminance() < 0.5;
    final hues = [for (final r in fit.activeRoutines.take(3)) folderHue(r)];
    final colors = hues.isEmpty ? kFolderHues.take(3).toList() : hues;
    return _Fan(
      width: 60,
      height: 50,
      children: [
        for (final c in colors.reversed)
          _Sheet(color: Color.lerp(c, Colors.black, dark ? 0.12 : 0)!, ink: Color.lerp(c, Colors.black, 0.45)!),
      ],
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({required this.color, required this.ink});

  final Color color;
  final Color ink;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 9, 12, 0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final f in const [1.0, 0.7, 0.45]) ...[
            FractionallySizedBox(
              widthFactor: f,
              child: Container(
                height: 3,
                decoration: BoxDecoration(color: ink.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ],
      ),
    );
  }
}

class ToolsPeek extends StatelessWidget {
  const ToolsPeek({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final dark = gc.bg.computeLuminance() < 0.5;
    final base = Color.lerp(gc.bgRaised2, Colors.white, dark ? 0.1 : 0)!;
    return _Fan(
      width: 46,
      height: 50,
      spread: 1.4,
      children: [
        for (final (icon, tint) in [
          (PhosphorIconsBold.fire, gc.accent),
          (PhosphorIconsBold.circlesThree, gc.brass),
          (PhosphorIconsBold.barbell, gc.text),
        ])
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 9),
            decoration: BoxDecoration(
              color: Color.lerp(base, tint, dark ? 0.16 : 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: dark ? 0.06 : 0)),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: dark ? 0.35 : 0.1), blurRadius: 6, offset: const Offset(0, 2)),
              ],
            ),
            child: Icon(icon, size: 19, color: tint),
          ),
      ],
    );
  }
}

class NotesPeek extends StatelessWidget {
  const NotesPeek({super.key});

  static const _paper = [Color(0xFFF2D680), Color(0xFFF3C7B1), Color(0xFFA8C99E)];

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final dark = gc.bg.computeLuminance() < 0.5;
    return _Fan(
      width: 48,
      height: 48,
      children: [
        for (final c in _paper)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 13, 9, 0),
                  decoration: BoxDecoration(
                    color: Color.lerp(c, Colors.black, dark ? 0.08 : 0),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3),
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 5, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final f in const [1.0, 0.8, 0.5]) ...[
                        FractionallySizedBox(
                          widthFactor: f,
                          child: Container(
                            height: 2.5,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -5,
                left: 14,
                right: 14,
                height: 10,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class NutritionPeek extends StatelessWidget {
  const NutritionPeek({super.key});

  static const _items = [
    ('assets/img/peek-yogurt.webp', -138.0, 50.0, -0.16, 1.03, 0.0),
    ('assets/img/peek-protein.webp', -92.0, 62.0, -0.05, 0.68, 8.0),
    ('assets/img/peek-water.webp', -48.0, 76.0, 0.06, 0.42, 12.0),
    ('assets/img/peek-pan.webp', 4.0, 50.0, -0.1, 1.17, 2.0),
    ('assets/img/peek-shake.webp', 56.0, 72.0, 0.08, 0.54, 6.0),
    ('assets/img/peek-can.webp', 104.0, 62.0, -0.18, 0.71, 0.0),
    ('assets/img/peek-choco.webp', 146.0, 56.0, 0.22, 0.84, -2.0),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) => Stack(
        clipBehavior: Clip.none,
        children: [
          for (final (asset, dx, h, turn, aspect, lift) in _items)
            Positioned(
              left: box.maxWidth / 2 + dx - h * aspect / 2,
              width: h * aspect,
              top: 38 - h * 0.55 - lift,
              height: h,
              child: Transform.rotate(
                angle: turn,
                child: Image.asset(asset, fit: BoxFit.contain, cacheHeight: (h * 3).round()),
              ),
            ),
        ],
      ),
    );
  }
}
