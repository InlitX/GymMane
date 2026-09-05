import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'ui_kit.dart';

Future<ImageSource?> pickPhotoSource(BuildContext context) => showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const PhotoSourceSheet(),
    );

class PhotoSourceSheet extends StatelessWidget {
  const PhotoSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHandle(),
          const SizedBox(height: 18),
          _option(context, PhosphorIconsRegular.camera, t.takePhoto, ImageSource.camera),
          const SizedBox(height: 10),
          _option(context, PhosphorIconsRegular.image, t.chooseGallery, ImageSource.gallery),
        ],
      ),
    );
  }

  Widget _option(BuildContext context, IconData icon, String label, ImageSource source) {
    final gc = context.gc;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(source),
      child: SoftCard(
        radius: 16,
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(icon, size: 20, color: gc.textSecondary),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text))),
        ]),
      ),
    );
  }
}
