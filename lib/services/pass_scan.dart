import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:zxing2/qrcode.dart';

Future<String?> readQrFromFile(String path) async {
  ui.ImmutableBuffer? buffer;
  ui.ImageDescriptor? descriptor;
  try {
    final bytes = await File(path).readAsBytes();
    buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    descriptor = await ui.ImageDescriptor.encoded(buffer);
    final long = descriptor.width > descriptor.height ? descriptor.width : descriptor.height;
    final sides = <int>{for (final s in const [1200, 1800, 2600, 800]) s < long ? s : long};
    for (final side in sides) {
      final scale = side / long;
      final codec = await descriptor.instantiateCodec(
        targetWidth: (descriptor.width * scale).round(),
        targetHeight: (descriptor.height * scale).round(),
      );
      final frame = await codec.getNextFrame();
      final image = frame.image;
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      final w = image.width, h = image.height;
      image.dispose();
      codec.dispose();
      if (data == null) continue;
      final found = await Isolate.run(() => decodeQr(w, h, data.buffer.asUint8List()));
      if (found != null) return found;
    }
  } catch (_) {
  } finally {
    descriptor?.dispose();
    buffer?.dispose();
  }
  return null;
}

String? decodeQr(int width, int height, Uint8List rgba) {
  final pixels = Int32List(width * height);
  for (var i = 0, p = 0; i < pixels.length; i++, p += 4) {
    pixels[i] = 0xff000000 | (rgba[p] << 16) | (rgba[p + 1] << 8) | rgba[p + 2];
  }
  final whole = RGBLuminanceSource(width, height, pixels);
  final views = <LuminanceSource>[whole];
  for (final f in const [0.6, 0.4]) {
    final cw = (width * f).round(), ch = (height * f).round();
    views.add(whole.crop((width - cw) ~/ 2, (height - ch) ~/ 2, cw, ch));
  }
  final hints = DecodeHints()..put(DecodeHintType.tryHarder);
  for (final view in views) {
    for (final lum in [view, InvertedLuminanceSource(view)]) {
      for (final bitmap in [BinaryBitmap(HybridBinarizer(lum)), BinaryBitmap(GlobalHistogramBinarizer(lum))]) {
        try {
          final text = QRCodeReader().decode(bitmap, hints: hints).text;
          if (text.isNotEmpty) return text;
        } catch (_) {}
      }
    }
  }
  return null;
}
