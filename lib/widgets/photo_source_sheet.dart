import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import 'glass.dart';
import 'ui_kit.dart';

Future<ImageSource?> pickPhotoSource(BuildContext context) => showAppSheet<ImageSource>(
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
      padding: sheetPad(context),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 18),
          OptionGroup([
            OptionItem(
              t.takePhoto,
              icon: PhosphorIconsRegular.camera,
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            OptionItem(
              t.chooseGallery,
              icon: PhosphorIconsRegular.image,
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ]),
        ],
      ),
    );
  }
}
