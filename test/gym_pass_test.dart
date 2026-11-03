import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';

import 'package:barcode/barcode.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/gym_pass.dart';
import 'package:gymmane/services/backup_zip.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/services/media_store.dart';
import 'package:gymmane/services/pass_scan.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/gym_pass_card.dart';
import 'package:gymmane/widgets/photo_crop.dart';
import 'package:shared_preferences/shared_preferences.dart';

Uint8List _qrPixels(String data, int side) {
  final rgba = Uint8List(side * side * 4)..fillRange(0, side * side * 4, 255);
  final quiet = side * 0.1;
  for (final e in Barcode.qrCode().make(data, width: side - quiet * 2, height: side - quiet * 2)) {
    if (e is! BarcodeBar || !e.black) continue;
    for (var y = (e.top + quiet).round(); y < (e.top + e.height + quiet).round(); y++) {
      for (var x = (e.left + quiet).round(); x < (e.left + e.width + quiet).round(); x++) {
        final p = (y * side + x) * 4;
        rgba[p] = rgba[p + 1] = rgba[p + 2] = 0;
      }
    }
  }
  return rgba;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
  });

  test('lee el QR de una imagen', () {
    expect(decodeQr(400, 400, _qrPixels('BF-2210-883415-ES', 400)), 'BF-2210-883415-ES');
  });

  test('lee un QR pequeño dentro de una foto grande', () {
    const w = 1600, h = 1200, side = 260;
    final rgba = Uint8List(w * h * 4);
    for (var i = 0; i < w * h; i++) {
      final v = 150 + (i * 7919 % 60);
      rgba[i * 4] = rgba[i * 4 + 1] = rgba[i * 4 + 2] = v;
      rgba[i * 4 + 3] = 255;
    }
    final qr = _qrPixels('PASS-77-ABC', side);
    const ox = 900, oy = 500;
    for (var y = 0; y < side; y++) {
      for (var x = 0; x < side; x++) {
        final from = (y * side + x) * 4, to = ((oy + y) * w + ox + x) * 4;
        rgba[to] = qr[from];
        rgba[to + 1] = qr[from + 1];
        rgba[to + 2] = qr[from + 2];
      }
    }
    expect(decodeQr(w, h, rgba), 'PASS-77-ABC');
  });

  test('una imagen sin código no devuelve nada', () {
    expect(decodeQr(50, 50, Uint8List(50 * 50 * 4)..fillRange(0, 50 * 50 * 4, 255)), isNull);
  });

  test('solo acepta números que caben en el tipo de código', () {
    expect(passCodeValid(PassFormat.ean13, '4006381333931'), isTrue);
    expect(passCodeValid(PassFormat.ean13, '4006381333932'), isFalse, reason: 'dígito de control mal');
    expect(passCodeValid(PassFormat.code128, 'GYM-0042'), isTrue);
    expect(passCodeValid(PassFormat.qr, ''), isFalse);
  });

  test('añadir, ordenar, borrar con deshacer y guardar', () {
    final a = fit.addGymPass(name: 'Basic-Fit', code: 'AAA');
    fit.addGymPass(name: 'Holmes', code: '4006381333931', format: PassFormat.ean13, hue: 2);
    expect(fit.lastPass!.name, 'Holmes', reason: 'el último añadido es el que se enseña');
    fit.useGymPass(a);
    expect(fit.lastPass!.name, 'Basic-Fit');
    fit.moveGymPass(1, 0);
    expect(fit.gymPasses.first.name, 'Holmes');
    final undo = fit.removeGymPass(a)!;
    expect(fit.gymPasses.length, 1);
    undo();
    expect(fit.gymPasses.length, 2);

    final saved = fit.toJson();
    fit.resetAllData();
    expect(fit.gymPasses, isEmpty);
    fit.applyBackup(saved);
    expect(fit.gymPasses.map((p) => p.name), ['Holmes', 'Basic-Fit']);
    expect(fit.gymPasses.first.format, PassFormat.ean13);
    expect(fit.gymPasses.first.hue, 2);
    expect(fit.lastPass!.name, 'Basic-Fit');
  });

  test('un pase con foto vale sin número y su foto viaja en la copia', () async {
    final tmp = await Directory.systemTemp.createTemp('gymmane_pass');
    MediaStore.directory = tmp.path;
    addTearDown(() async {
      MediaStore.directory = null;
      if (tmp.existsSync()) await tmp.delete(recursive: true);
    });
    final png = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 9, 8, 7]);
    final name = (await MediaStore.saveBytes('pass', 'png', png))!;
    expect(passCodeValid(PassFormat.photo, name), isTrue);
    expect(passCodeValid(PassFormat.photo, ''), isFalse);
    fit.addGymPass(name: 'Studio', code: name, format: PassFormat.photo);
    expect(fit.gymPasses.single.photo, isTrue);
    expect(fit.gymPasses.single.square, isFalse);

    final zip = await buildBackupZip();
    expect(ZipDecoder().decodeBytes(zip).files.map((f) => f.name), contains('passes/studio.png'));
    fit.resetAllData();
    await MediaStore.delete(name);
    expect(await restoreBackupZip(zip), isTrue);
    final back = fit.gymPasses.single;
    expect(back.format, PassFormat.photo);
    expect(await MediaStore.readBytes(back.code), png);
  });

  test('el recorte se queda con la zona marcada y girar cambia el lado largo', () async {
    final recorder = ui.PictureRecorder();
    Canvas(recorder).drawRect(const Rect.fromLTWH(0, 0, 400, 200), Paint()..color = const Color(0xFFFFFFFF));
    final image = await recorder.endRecording().toImage(400, 200);
    final png = (await cropToPng(image, const Rect.fromLTRB(0.25, 0, 0.75, 0.5)))!;
    final codec = await ui.instantiateImageCodec(png);
    final out = (await codec.getNextFrame()).image;
    expect((out.width, out.height), (200, 100));
    final turned = rotateQuarter(image);
    expect((turned.width, turned.height), (200, 400));
    expect(await cropToPng(image, const Rect.fromLTRB(0.5, 0.5, 0.5, 0.5)), isNull);
  });
}
