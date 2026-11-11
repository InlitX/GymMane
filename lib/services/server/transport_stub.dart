import 'dart:typed_data';

import 'transport.dart';

bool get transportAvailable => false;

Future<Reply> send(String method, String path, {Uint8List? body, Map<String, String> headers = const {}}) async =>
    const Reply.failed();

String mediaUrl(String name) => '';

void onPageVisible(void Function() callback) {}

void beforeLeave(void Function() callback) {}

void download(String name, Uint8List bytes, String mime) {}
