import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class FileThumb extends StatelessWidget {
  const FileThumb(
    this.path, {
    super.key,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.errorBuilder,
    this.frameBuilder,
  });

  final String path;
  final BoxFit fit;
  final Alignment alignment;
  final double? width;
  final double? height;
  final ImageErrorWidgetBuilder? errorBuilder;
  final ImageFrameBuilder? frameBuilder;

  static int _side(BuildContext context, double w, double h) =>
      (math.max(w, h) * MediaQuery.devicePixelRatioOf(context) * 1.6).clamp(64.0, 2400.0).round();

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, box) {
        final screen = MediaQuery.sizeOf(context);
        final w = width != null && width!.isFinite ? width! : (box.maxWidth.isFinite ? box.maxWidth : screen.width);
        final h = height != null && height!.isFinite ? height! : (box.maxHeight.isFinite ? box.maxHeight : screen.height);
        final side = _side(context, w, h);
        return Image(
          image: ResizeImage(FileImage(File(path)), width: side, height: side, policy: ResizeImagePolicy.fit),
          fit: fit,
          alignment: alignment,
          width: width,
          height: height,
          gaplessPlayback: true,
          errorBuilder: errorBuilder,
          frameBuilder: frameBuilder,
        );
      });
}
