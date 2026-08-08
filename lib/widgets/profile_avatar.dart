import 'package:flutter/material.dart';

import '../state/fit_state.dart';
import '../theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.size = 52});

  static const defaultPhoto = AssetImage('assets/img/profile_default.jpg');

  final double size;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final bytes = fit.profilePhoto;
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: gc.border),
      ),
      child: Image(
        image: bytes != null ? MemoryImage(bytes) : defaultPhoto,
        fit: BoxFit.cover,
        gaplessPlayback: true,
      ),
    );
  }
}
