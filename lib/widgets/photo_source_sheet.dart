import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import 'glass.dart';
import 'ui_kit.dart';

Future<ImageSource?> pickPhotoSource(BuildContext context, {VoidCallback? onRemove}) => showAppSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => PhotoSourceSheet(onRemove: onRemove),
    );

class PhotoSourceSheet extends StatelessWidget {
  const PhotoSourceSheet({super.key, this.onRemove});

  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: sheetPad(context),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 18),
          OptionGroup([
            OptionItem(t.takePhoto,
                icon: PhosphorIconsRegular.camera, onTap: () => Navigator.of(context).pop(ImageSource.camera)),
            OptionItem(t.chooseGallery,
                icon: PhosphorIconsRegular.image, onTap: () => Navigator.of(context).pop(ImageSource.gallery)),
            if (onRemove case final remove?)
              OptionItem(t.removePhoto, icon: PhosphorIconsRegular.trash, danger: true, onTap: () {
                Navigator.of(context).pop();
                remove();
              }),
          ]),
        ],
      ),
    );
  }
}
