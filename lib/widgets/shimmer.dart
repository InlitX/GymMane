import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({super.key, this.radius = 16});

  final double radius;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat(count: 1);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final base = gc.bgRaised2;
    final shine = Color.lerp(gc.bgRaised2, gc.text, 0.07)!;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final x = -1.6 + 3.2 * Curves.easeInOutSine.transform(_c.value);
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(x - 0.8, -0.3),
              end: Alignment(x + 0.8, 0.3),
              colors: [base, shine, base],
              stops: const [0.2, 0.5, 0.8],
            ),
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}
