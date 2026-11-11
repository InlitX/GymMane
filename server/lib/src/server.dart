import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'config.dart';
import 'media_store.dart';
import 'phone_sync.dart';
import 'state_store.dart';

const serverVersion = '1.0.0';

class GymManeServer {
  GymManeServer(this.config)
      : store = StateStore(config.dataDir, keepDays: config.keepDays),
        media = MediaFiles('${config.dataDir}/media');

  final Config config;
  final StateStore store;
  final MediaFiles media;
  PhoneSync? sync;
  HttpServer? _http;

  static const _maxState = 64 * 1024 * 1024;
  static const _maxMedia = 80 * 1024 * 1024;

  int get port => _http?.port ?? config.port;

  Future<void> start() async {
    await store.open();
    await media.open();
    final dir = config.syncDir;
    if (dir != null) {
      sync = PhoneSync(syncDir: dir, dataDir: config.dataDir, store: store, media: media);
      await sync!.start();
    }
    final http = await HttpServer.bind(config.host, config.port, shared: true);
    http.autoCompress = true;
    http.idleTimeout = const Duration(seconds: 30);
    _http = http;
    http.listen((req) => unawaited(_handle(req)));
  }

  Future<void> stop() async {
    sync?.stop();
    await _http?.close(force: true);
  }

  Future<void> _handle(HttpRequest req) async {
    final res = req.response;
    res.headers
      ..set('x-content-type-options', 'nosniff')
      ..set('referrer-policy', 'no-referrer');
    try {
      if (!_authorized(req)) {
        res.statusCode = HttpStatus.unauthorized;
        res.headers.set('www-authenticate', 'Basic realm="GymMane", charset="UTF-8"');
        res.write('Sign in to open GymMane.');
        return;
      }
      final path = req.uri.path;
      if (path.startsWith('/api/')) {
        res.headers.set('cache-control', 'no-store');
        await _api(req, path.substring(5));
      } else {
        await _static(req, path);
      }
    } catch (e) {
      try {
        res.statusCode = HttpStatus.internalServerError;
        res.write('error');
      } catch (_) {}
    } finally {
      try {
        await res.close();
      } catch (_) {}
    }
  }

  bool _authorized(HttpRequest req) {
    final password = config.password;
    if (password == null) return true;
    final header = req.headers.value(HttpHeaders.authorizationHeader) ?? '';
    if (!header.toLowerCase().startsWith('basic ')) return false;
    try {
      final decoded = utf8.decode(base64.decode(header.substring(6).trim()));
      final given = decoded.contains(':') ? decoded.substring(decoded.indexOf(':') + 1) : decoded;
      return _same(given, password);
    } catch (_) {
      return false;
    }
  }

  static bool _same(String a, String b) {
    final x = utf8.encode(a);
    final y = utf8.encode(b);
    var diff = x.length ^ y.length;
    for (var i = 0; i < x.length && i < y.length; i++) {
      diff |= x[i] ^ y[i];
    }
    return diff == 0;
  }

  void _json(HttpResponse res, Object body, {int status = HttpStatus.ok}) {
    res.statusCode = status;
    res.headers.contentType = ContentType.json;
    res.write(jsonEncode(body));
  }

  Future<List<int>?> _body(HttpRequest req, int max) async {
    final out = BytesBuilder(copy: false);
    await for (final chunk in req) {
      out.add(chunk);
      if (out.length > max) return null;
    }
    return out.takeBytes();
  }

  Future<void> _api(HttpRequest req, String route) async {
    final res = req.response;
    final method = req.method;
    if (route == 'health') return _json(res, {'ok': true});
    if (route == 'info' && method == 'GET') {
      final now = store.current;
      return _json(res, {
        'app': 'gymmane',
        'version': serverVersion,
        'rev': now.rev,
        if (now.savedAt != null) 'savedAt': now.savedAt!.toIso8601String(),
        'source': now.source,
        'auth': config.password != null,
        'sync': sync?.info ?? {'enabled': false},
      });
    }
    if (route == 'rev' && method == 'GET') return _json(res, {'rev': store.current.rev});
    if (route == 'state') {
      if (method == 'GET') {
        final now = store.current;
        res.headers
          ..set('x-gymmane-rev', '${now.rev}')
          ..set('x-gymmane-source', now.source);
        if (now.text == null) {
          res.statusCode = HttpStatus.noContent;
          return;
        }
        res.headers.contentType = ContentType.json;
        res.write(now.text);
        return;
      }
      if (method == 'PUT') {
        final bytes = await _body(req, _maxState);
        if (bytes == null) return _json(res, {'error': 'too large'}, status: HttpStatus.requestEntityTooLarge);
        final text = utf8.decode(bytes, allowMalformed: false);
        if (!StateStore.isValid(text)) return _json(res, {'error': 'invalid'}, status: HttpStatus.badRequest);
        final base = int.tryParse(req.headers.value('x-gymmane-base-rev') ?? '');
        final result = await store.write(text, baseRev: base);
        if (result.conflict) return _json(res, {'rev': result.rev}, status: HttpStatus.conflict);
        sync?.changed();
        return _json(res, {'rev': result.rev});
      }
    }
    if (route.startsWith('media/')) {
      final name = Uri.decodeComponent(route.substring(6));
      if (!MediaFiles.validName(name)) return _json(res, {'error': 'name'}, status: HttpStatus.badRequest);
      switch (method) {
        case 'GET' || 'HEAD':
          final bytes = await media.read(name);
          if (bytes == null) return _json(res, {'error': 'missing'}, status: HttpStatus.notFound);
          res.headers
            ..contentType = ContentType.parse(MediaFiles.typeOf(name))
            ..set('cache-control', 'private, max-age=31536000, immutable');
          if (method == 'GET') res.add(bytes);
          return;
        case 'PUT':
          final bytes = await _body(req, _maxMedia);
          if (bytes == null) return _json(res, {'error': 'too large'}, status: HttpStatus.requestEntityTooLarge);
          await media.write(name, bytes);
          sync?.changed();
          return _json(res, {'ok': true});
        case 'DELETE':
          await media.delete(name);
          return _json(res, {'ok': true});
      }
    }
    if (route == 'sync/scan' && method == 'POST') {
      final s = sync;
      if (s == null) return _json(res, {'enabled': false});
      final imported = await s.scan();
      return _json(res, {'imported': imported, 'rev': store.current.rev, ...s.info});
    }
    if (route == 'sync/export' && method == 'POST') {
      final s = sync;
      if (s == null) return _json(res, {'enabled': false});
      return _json(res, {'exported': await s.exportZip(), ...s.info});
    }
    _json(res, {'error': 'not found'}, status: HttpStatus.notFound);
  }

  static const _types = {
    'html': 'text/html; charset=utf-8',
    'js': 'text/javascript; charset=utf-8',
    'mjs': 'text/javascript; charset=utf-8',
    'json': 'application/json; charset=utf-8',
    'css': 'text/css; charset=utf-8',
    'wasm': 'application/wasm',
    'png': 'image/png',
    'jpg': 'image/jpeg',
    'webp': 'image/webp',
    'svg': 'image/svg+xml',
    'ico': 'image/x-icon',
    'ttf': 'font/ttf',
    'otf': 'font/otf',
    'woff2': 'font/woff2',
    'txt': 'text/plain; charset=utf-8',
    'wav': 'audio/wav',
    'mp3': 'audio/mpeg',
    'bin': 'application/octet-stream',
    'frag': 'application/octet-stream',
  };

  Future<void> _static(HttpRequest req, String path) async {
    final res = req.response;
    if (req.method != 'GET' && req.method != 'HEAD') {
      res.statusCode = HttpStatus.methodNotAllowed;
      return;
    }
    final root = Directory(config.webDir).absolute.path;
    var rel = Uri.decodeComponent(path);
    if (rel.isEmpty || rel.endsWith('/')) rel = '${rel}index.html';
    final parts = rel.split('/').where((p) => p.isNotEmpty).toList();
    if (parts.any((p) => p == '..' || p.startsWith('.'))) {
      res.statusCode = HttpStatus.notFound;
      return;
    }
    var file = File([root, ...parts].join(Platform.pathSeparator));
    if (!await file.exists()) {
      final last = parts.isEmpty ? '' : parts.last;
      if (last.contains('.')) {
        res.statusCode = HttpStatus.notFound;
        return;
      }
      file = File('$root${Platform.pathSeparator}index.html');
      if (!await file.exists()) {
        res.statusCode = HttpStatus.serviceUnavailable;
        res.headers.contentType = ContentType.text;
        res.write('The GymMane web files are missing. Set GYMMANE_WEB to the folder with index.html.');
        return;
      }
    }
    final name = file.uri.pathSegments.last;
    final ext = name.contains('.') ? name.substring(name.lastIndexOf('.') + 1).toLowerCase() : '';
    final stat = await file.stat();
    final modified = stat.modified.toUtc();
    final since = req.headers.ifModifiedSince;
    final entry = name == 'index.html' || name == 'flutter_bootstrap.js' || name == 'flutter_service_worker.js';
    res.headers
      ..set('content-type', _types[ext] ?? 'application/octet-stream')
      ..set('cache-control', entry ? 'no-cache' : 'public, max-age=3600')
      ..set('cross-origin-opener-policy', 'same-origin')
      ..set('cross-origin-embedder-policy', 'require-corp')
      ..set('cross-origin-resource-policy', 'same-origin')
      ..set(HttpHeaders.varyHeader, 'accept-encoding')
      ..set(HttpHeaders.lastModifiedHeader, HttpDate.format(modified));
    if (since != null && !modified.isAfter(since.add(const Duration(seconds: 1)))) {
      res.statusCode = HttpStatus.notModified;
      return;
    }
    final accepts = req.headers[HttpHeaders.acceptEncodingHeader]?.join(',').contains('gzip') ?? false;
    if (accepts && _packable.contains(ext) && stat.size > 1024) {
      final packed = await _packed(file, modified);
      res.headers.set(HttpHeaders.contentEncodingHeader, 'gzip');
      res.contentLength = packed.length;
      if (req.method == 'HEAD') return;
      res.add(packed);
      return;
    }
    res.contentLength = stat.size;
    if (req.method == 'HEAD') return;
    await res.addStream(file.openRead());
  }

  static const _packable = {'html', 'js', 'mjs', 'json', 'css', 'wasm', 'svg', 'txt', 'ttf', 'otf', 'frag', 'bin'};
  final Map<String, (DateTime, List<int>)> _gz = {};

  Future<List<int>> _packed(File file, DateTime modified) async {
    final hit = _gz[file.path];
    if (hit != null && hit.$1 == modified) return hit.$2;
    final bytes = gzip.encode(await file.readAsBytes());
    _gz[file.path] = (modified, bytes);
    return bytes;
  }
}
