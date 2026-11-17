import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'config.dart';
import 'media_store.dart';
import 'phone_sync.dart';
import 'pages.dart';
import 'state_store.dart';

const serverVersion = '1.1.0';

class Space {
  Space({required this.person, required this.dataDir, required this.syncDir, required this.password, required int keepDays})
      : store = StateStore(dataDir, keepDays: keepDays),
        media = MediaFiles('$dataDir/media');

  final Person? person;
  final String dataDir;
  final String? syncDir;
  final String? password;
  final StateStore store;
  final MediaFiles media;
  PhoneSync? sync;
  String? _token;

  String get base => person == null ? '/' : '/${person!.name}/';

  String get cookie => person == null ? 'gymmane' : 'gymmane-${person!.name}';

  String? get token => _token;

  static const maxFails = 20;
  static const failWindow = Duration(minutes: 10);
  final List<DateTime> _fails = [];

  bool get locked {
    final since = DateTime.now().subtract(failWindow);
    _fails.removeWhere((at) => at.isBefore(since));
    return _fails.length >= maxFails;
  }

  void failed() => _fails.add(DateTime.now());

  Future<void> start() async {
    await store.open();
    await media.open();
    final pass = password;
    if (pass != null) {
      final file = File('$dataDir/login.key');
      List<int> key;
      try {
        key = base64.decode((await file.readAsString()).trim());
      } catch (_) {
        final random = Random.secure();
        key = List<int>.generate(32, (_) => random.nextInt(256));
        await file.writeAsString(base64.encode(key), flush: true);
      }
      _token = base64Url.encode(Hmac(sha256, key).convert(utf8.encode(pass)).bytes).replaceAll('=', '');
    }
    final dir = syncDir;
    if (dir != null) {
      sync = PhoneSync(syncDir: dir, dataDir: dataDir, store: store, media: media);
      await sync!.start();
    }
  }
}

class GymManeServer {
  GymManeServer(this.config);

  final Config config;
  final List<Space> spaces = [];
  HttpServer? _http;

  static const _maxState = 64 * 1024 * 1024;
  static const _maxMedia = 80 * 1024 * 1024;

  int get port => _http?.port ?? config.port;

  bool get shared => config.people.isNotEmpty;

  Space? spaceOf(String name) {
    for (final s in spaces) {
      if (s.person?.name == name) return s;
    }
    return null;
  }

  Future<void> start() async {
    spaces
      ..clear()
      ..addAll(await _layout());
    for (final s in spaces) {
      await s.start();
    }
    final http = await HttpServer.bind(config.host, config.port, shared: true);
    http.autoCompress = true;
    http.idleTimeout = const Duration(seconds: 30);
    _http = http;
    http.listen((req) => unawaited(_handle(req)));
  }

  Future<void> stop() async {
    for (final s in spaces) {
      s.sync?.stop();
    }
    await _http?.close(force: true);
  }

  Future<List<Space>> _layout() async {
    if (!shared) {
      return [
        Space(
            person: null,
            dataDir: config.dataDir,
            syncDir: config.syncDir,
            password: config.password,
            keepDays: config.keepDays),
      ];
    }
    final taken = {'api', 'index.html'};
    final web = Directory(config.webDir);
    if (await web.exists()) {
      await for (final e in web.list()) {
        taken.add(e.uri.pathSegments.lastWhere((p) => p.isNotEmpty).toLowerCase());
      }
    }
    for (final p in config.people) {
      if (taken.contains(p.name)) {
        throw FormatException('"${p.label}" cannot be a name in GYMMANE_PEOPLE, pick another one.');
      }
    }
    await Directory(config.dataDir).create(recursive: true);
    final mark = File('${config.dataDir}/owner.txt');
    var owner = await mark.exists() ? (await mark.readAsString()).trim() : '';
    if (owner.isEmpty) {
      owner = config.people.first.name;
      await mark.writeAsString(owner, flush: true);
    }
    Space at(Person p, String dir, String? sync) => Space(
        person: p, dataDir: dir, syncDir: sync, password: p.password ?? config.password, keepDays: config.keepDays);
    return [
      for (final p in config.people)
        if (p.name == owner)
          at(p, config.dataDir, config.syncDir)
        else
          at(p, '${config.dataDir}/people/${p.name}',
              config.syncDir == null ? null : '${config.dataDir}/people/${p.name}/sync'),
    ];
  }

  Future<void> _handle(HttpRequest req) async {
    final res = req.response;
    res.headers
      ..set('x-content-type-options', 'nosniff')
      ..set('referrer-policy', 'no-referrer');
    try {
      final path = req.uri.path;
      if (shared) {
        await _route(req, path);
        return;
      }
      await _serve(req, spaces.first, path);
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

  Future<void> _route(HttpRequest req, String path) async {
    final res = req.response;
    final parts = path.split('/').where((p) => p.isNotEmpty).toList();
    final space = parts.isEmpty ? null : spaceOf(parts.first.toLowerCase());
    if (space == null) {
      if (path == '/api/health') return _json(res, {'ok': true});
      if (parts.isNotEmpty && parts.first != 'api' && parts.last.contains('.') && parts.last != 'index.html') {
        return _static(req, path, null);
      }
      if (parts.isNotEmpty) {
        res.statusCode = HttpStatus.found;
        res.headers.set(HttpHeaders.locationHeader, '/');
        return;
      }
      if (req.method != 'GET' && req.method != 'HEAD') {
        res.statusCode = HttpStatus.methodNotAllowed;
        return;
      }
      res.headers
        ..contentType = ContentType.html
        ..set('cache-control', 'no-cache');
      if (req.method == 'GET') res.write(pickerPage([for (final s in spaces) s.person!]));
      return;
    }
    final cut = path.indexOf('/', 1);
    final rest = cut < 0 ? '' : path.substring(cut);
    if (rest.isEmpty) {
      res.statusCode = HttpStatus.movedPermanently;
      res.headers.set(HttpHeaders.locationHeader, '${space.base}${req.uri.hasQuery ? '?${req.uri.query}' : ''}');
      return;
    }
    await _serve(req, space, rest);
  }

  Future<void> _serve(HttpRequest req, Space space, String rest) async {
    final res = req.response;
    if (rest == '/api/health') return _json(res, {'ok': true});
    if (rest == '/login' && req.method == 'POST') return _login(req, space);
    if (rest == '/logout') {
      _setCookie(req, space, '', 0);
      res.statusCode = HttpStatus.seeOther;
      res.headers
        ..set('cache-control', 'no-store')
        ..set(HttpHeaders.locationHeader, shared ? '/' : space.base);
      return;
    }
    if (!_authorized(req, space)) {
      if (rest.startsWith('/api/')) return _json(res, {'error': 'sign in'}, status: HttpStatus.unauthorized);
      final last = rest.substring(rest.lastIndexOf('/') + 1);
      if (last.contains('.') && last != 'index.html') return _static(req, rest, space);
      if (req.method != 'GET' && req.method != 'HEAD') {
        res.statusCode = HttpStatus.unauthorized;
        return;
      }
      return _loginPage(res, space);
    }
    if (rest.startsWith('/api/')) {
      res.headers.set('cache-control', 'no-store');
      return _api(req, space, rest.substring(5));
    }
    await _static(req, rest, space);
  }

  void _loginPage(HttpResponse res, Space space, {bool wrong = false}) {
    final wait = space.locked;
    res.statusCode = wait ? HttpStatus.tooManyRequests : (wrong ? HttpStatus.unauthorized : HttpStatus.ok);
    res.headers
      ..contentType = ContentType.html
      ..set('cache-control', 'no-store');
    res.write(loginPage(
        action: '${space.base}login', person: space.person, wrong: wrong && !wait, wait: wait, shared: shared));
  }

  Future<void> _login(HttpRequest req, Space space) async {
    final res = req.response;
    final bytes = await _body(req, 8192);
    var given = '';
    try {
      given = Uri.splitQueryString(utf8.decode(bytes ?? const []))['password'] ?? '';
    } catch (_) {}
    final pass = space.password;
    if (pass != null && space.locked) return _loginPage(res, space);
    if (pass != null && !_same(given, pass)) {
      space.failed();
      await Future<void>.delayed(const Duration(milliseconds: 800));
      return _loginPage(res, space, wrong: true);
    }
    if (pass != null) _setCookie(req, space, space.token!, 400 * 24 * 3600);
    res.statusCode = HttpStatus.seeOther;
    res.headers
      ..set('cache-control', 'no-store')
      ..set(HttpHeaders.locationHeader, space.base);
  }

  void _setCookie(HttpRequest req, Space space, String value, int maxAge) {
    final secure = req.requestedUri.scheme == 'https' ||
        (req.headers.value('x-forwarded-proto') ?? '').toLowerCase().startsWith('https');
    req.response.headers.add(
        'set-cookie',
        '${space.cookie}=$value; Path=${space.base}; Max-Age=$maxAge; HttpOnly; SameSite=Lax'
            '${secure ? '; Secure' : ''}');
  }

  bool _authorized(HttpRequest req, Space space) {
    final password = space.password;
    if (password == null) return true;
    final token = space.token;
    for (final line in req.headers[HttpHeaders.cookieHeader] ?? const <String>[]) {
      for (final part in line.split(';')) {
        final eq = part.indexOf('=');
        if (eq < 0 || part.substring(0, eq).trim() != space.cookie) continue;
        if (token != null && _same(part.substring(eq + 1).trim(), token)) return true;
      }
    }
    final header = req.headers.value(HttpHeaders.authorizationHeader) ?? '';
    if (!header.toLowerCase().startsWith('basic ')) return false;
    try {
      final decoded = utf8.decode(base64.decode(header.substring(6).trim()));
      final given = decoded.contains(':') ? decoded.substring(decoded.indexOf(':') + 1) : decoded;
      if (space.locked) return false;
      if (_same(given, password)) return true;
      space.failed();
      return false;
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

  Future<void> _api(HttpRequest req, Space space, String route) async {
    final res = req.response;
    final method = req.method;
    final store = space.store;
    final media = space.media;
    final sync = space.sync;
    if (route == 'health') return _json(res, {'ok': true});
    if (route == 'info' && method == 'GET') {
      final now = store.current;
      return _json(res, {
        'app': 'gymmane',
        'version': serverVersion,
        'rev': now.rev,
        if (now.savedAt != null) 'savedAt': now.savedAt!.toIso8601String(),
        'source': now.source,
        'auth': space.password != null,
        if (space.person != null) 'person': space.person!.display,
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

  Future<void> _static(HttpRequest req, String path, Space? space) async {
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
    final person = space?.person;
    final own = person != null &&
        (name == 'index.html' || name == 'manifest.json') &&
        file.path == '$root${Platform.pathSeparator}$name';
    res.headers
      ..set('content-type', _types[ext] ?? 'application/octet-stream')
      ..set('cache-control', entry || own ? 'no-cache' : 'public, max-age=3600')
      ..set('cross-origin-opener-policy', 'same-origin')
      ..set('cross-origin-embedder-policy', 'require-corp')
      ..set('cross-origin-resource-policy', 'same-origin')
      ..set(HttpHeaders.varyHeader, 'accept-encoding');
    final accepts = req.headers[HttpHeaders.acceptEncodingHeader]?.join(',').contains('gzip') ?? false;
    if (own) {
      final text = await file.readAsString();
      var bytes = utf8.encode(name == 'index.html' ? personalPage(text, person) : personalManifest(text, person));
      if (accepts) {
        bytes = Uint8List.fromList(gzip.encode(bytes));
        res.headers.set(HttpHeaders.contentEncodingHeader, 'gzip');
      }
      res.contentLength = bytes.length;
      if (req.method == 'GET') res.add(bytes);
      return;
    }
    res.headers.set(HttpHeaders.lastModifiedHeader, HttpDate.format(modified));
    if (since != null && !modified.isAfter(since.add(const Duration(seconds: 1)))) {
      res.statusCode = HttpStatus.notModified;
      return;
    }
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
