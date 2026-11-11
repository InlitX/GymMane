import 'dart:typed_data';

class Reply {
  const Reply(this.status, this.bytes, this.headers);

  const Reply.failed() : status = 0, bytes = null, headers = const {};

  final int status;
  final Uint8List? bytes;
  final Map<String, String> headers;

  bool get ok => status >= 200 && status < 300;
}
