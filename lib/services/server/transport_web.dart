import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'transport.dart';

bool get transportAvailable => true;

String _url(String path) => Uri.base.resolve(path).toString();

String mediaUrl(String name) => _url('api/media/${Uri.encodeComponent(name)}');

Future<Reply> send(String method, String path, {Uint8List? body, Map<String, String> headers = const {}}) async {
  try {
    final h = web.Headers();
    headers.forEach((k, v) => h.append(k, v));
    final res = await web.window
        .fetch(
          _url(path).toJS,
          web.RequestInit(
            method: method,
            headers: h,
            body: body?.toJS,
            credentials: 'same-origin',
            cache: 'no-store',
          ),
        )
        .toDart;
    final buffer = await res.arrayBuffer().toDart;
    return Reply(res.status, buffer.toDart.asUint8List(), {
      'x-gymmane-rev': res.headers.get('x-gymmane-rev') ?? '',
      'x-gymmane-source': res.headers.get('x-gymmane-source') ?? '',
      'content-type': res.headers.get('content-type') ?? '',
    });
  } catch (_) {
    return const Reply.failed();
  }
}

void onPageVisible(void Function() callback) {
  web.document.addEventListener(
    'visibilitychange',
    ((web.Event _) {
      if (web.document.visibilityState == 'visible') callback();
    }).toJS,
  );
}

void beforeLeave(void Function() callback) {
  web.window.addEventListener('pagehide', ((web.Event _) => callback()).toJS);
}

void download(String name, Uint8List bytes, String mime) {
  final blob = web.Blob([bytes.toJS].toJS, web.BlobPropertyBag(type: mime));
  final url = web.URL.createObjectURL(blob);
  final a = web.HTMLAnchorElement()
    ..href = url
    ..download = name
    ..style.display = 'none';
  web.document.body?.append(a);
  a.click();
  a.remove();
  Future<void>.delayed(const Duration(seconds: 30), () => web.URL.revokeObjectURL(url));
}
