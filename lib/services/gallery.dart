import 'package:flutter/services.dart';

const _channel = MethodChannel('gymmane/gallery');

Future<bool> saveImageToGallery(Uint8List png, String name) async {
  try {
    final ok = await _channel.invokeMethod<bool>('savePng', {'bytes': png, 'name': name});
    return ok ?? false;
  } catch (_) {
    return false;
  }
}
