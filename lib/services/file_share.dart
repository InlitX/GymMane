import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'server/transport_stub.dart' if (dart.library.js_interop) 'server/transport_web.dart' as net;

class ShareItem {
  const ShareItem(this.name, this.bytes, {this.mime});

  final String name;
  final Uint8List bytes;
  final String? mime;
}

Future<void> shareFiles(List<ShareItem> items, {String? subject, String? text}) async {
  if (items.isEmpty) return;
  if (kIsWeb) {
    for (final f in items) {
      net.download(f.name, f.bytes, f.mime ?? 'application/octet-stream');
    }
    return;
  }
  final dir = await getTemporaryDirectory();
  final files = <XFile>[];
  for (final f in items) {
    final file = File('${dir.path}/${f.name}');
    await file.writeAsBytes(f.bytes, flush: true);
    files.add(XFile(file.path, mimeType: f.mime));
  }
  await SharePlus.instance.share(ShareParams(files: files, subject: subject, text: text));
}

Future<void> shareFile(String name, Uint8List bytes, {String? mime, String? subject, String? text}) =>
    shareFiles([ShareItem(name, bytes, mime: mime)], subject: subject, text: text);

Uint8List utf8Bytes(String text) => Uint8List.fromList(utf8.encode(text));
