import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/app_colors.dart';

class ExerciseGif extends StatelessWidget {
  const ExerciseGif({super.key, required this.asset, this.height = 210, this.radius = 20});

  final String asset;
  final double height;
  final double radius;

  static const _surface = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final empty = asset.isEmpty;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: empty ? gc.bgRaised2 : _surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: gc.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: empty
          ? Center(child: Icon(PhosphorIconsRegular.barbell, size: height * 0.32, color: gc.textTertiary))
          : Image.asset(
              asset,
              fit: BoxFit.contain,
              gaplessPlayback: true,
              errorBuilder: (_, _, _) => Center(
                  child: Icon(PhosphorIconsRegular.barbell, size: 56, color: gc.textTertiary.withValues(alpha: 0.5))),
            ),
    );
  }
}
