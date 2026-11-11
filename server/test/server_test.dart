import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:gymmane_server/gymmane_server.dart';
import 'package:test/test.dart';

void main() {
  late Directory tmp;
  late GymManeServer server;
  late HttpClient client;

  Future<GymManeServer> boot({String? password}) async {
    final web = Directory('${tmp.path}/web')..createSync(recursive: true);
    File('${web.path}/index.html').writeAsStringSync('<html>gymmane</html>');
    File('${web.path}/main.dart.js').writeAsStringSync('console.log(1)');
    final s = GymManeServer(Config(
      port: 0,
      host: '127.0.0.1',
      dataDir: '${tmp.path}/data',
      webDir: web.path,
      syncDir: '${tmp.path}/sync',
      password: password,
      keepDays: 3,
    ));
    await s.start();
    return s;
  }

  Future<(int, String, HttpHeaders)> call(String method, String path,
      {String? body, List<int>? bytes, Map<String, String> headers = const {}}) async {
    final req = await client.openUrl(method, Uri.parse('http://127.0.0.1:${server.port}$path'));
    headers.forEach(req.headers.set);
    if (body != null) req.write(body);
    if (bytes != null) req.add(bytes);
    final res = await req.close();
    final text = await utf8.decoder.bind(res).join();
    return (res.statusCode, text, res.headers);
  }

  setUp(() async {
    tmp = Directory.systemTemp.createTempSync('gymmane-server');
    client = HttpClient();
    server = await boot();
  });

  tearDown(() async {
    client.close(force: true);
    await server.stop();
    tmp.deleteSync(recursive: true);
  });

  test('empieza vacío y guarda el estado con su revisión', () async {
    var (status, _, headers) = await call('GET', '/api/state');
    expect(status, 204);
    expect(headers.value('x-gymmane-rev'), '0');
    final (put, putBody, _) = await call('PUT', '/api/state', body: '{"onboarded":true}');
    expect(put, 200);
    expect(jsonDecode(putBody)['rev'], 1);
    final (get, text, h2) = await call('GET', '/api/state');
    expect(get, 200);
    expect(text, '{"onboarded":true}');
    expect(h2.value('x-gymmane-rev'), '1');
  });

  test('rechaza un guardado hecho sobre una revisión vieja', () async {
    await call('PUT', '/api/state', body: '{"a":1}');
    await call('PUT', '/api/state', body: '{"a":2}', headers: {'x-gymmane-base-rev': '1'});
    final (status, body, _) = await call('PUT', '/api/state', body: '{"a":3}', headers: {'x-gymmane-base-rev': '1'});
    expect(status, 409);
    expect(jsonDecode(body)['rev'], 2);
    final (_, text, _) = await call('GET', '/api/state');
    expect(text, '{"a":2}');
  });

  test('no acepta algo que no sea un objeto JSON', () async {
    final (status, _, _) = await call('PUT', '/api/state', body: 'hola');
    expect(status, 400);
  });

  test('guarda, sirve y borra fotos, y rechaza nombres raros', () async {
    final (put, _, _) = await call('PUT', '/api/media/food-1-2.jpg', bytes: [1, 2, 3]);
    expect(put, 200);
    final req = await client.getUrl(Uri.parse('http://127.0.0.1:${server.port}/api/media/food-1-2.jpg'));
    final res = await req.close();
    expect(res.headers.contentType?.mimeType, 'image/jpeg');
    expect(await res.fold<List<int>>([], (a, b) => a..addAll(b)), [1, 2, 3]);
    final (bad, _, _) = await call('PUT', '/api/media/..%2Fsecret', bytes: [1]);
    expect(bad, 400);
    await call('DELETE', '/api/media/food-1-2.jpg');
    final (gone, _, _) = await call('GET', '/api/media/food-1-2.jpg');
    expect(gone, 404);
  });

  test('sirve la web y vuelve a index.html en rutas de la app', () async {
    final (root, html, _) = await call('GET', '/');
    expect(root, 200);
    expect(html, contains('gymmane'));
    final (deep, html2, _) = await call('GET', '/progress');
    expect(deep, 200);
    expect(html2, contains('gymmane'));
    final (missing, _, _) = await call('GET', '/nope.js');
    expect(missing, 404);
    final (escape, _, _) = await call('GET', '/../data/state.json');
    expect(escape, isNot(200));
  });

  test('con contraseña pide entrar y deja pasar con la correcta', () async {
    await server.stop();
    server = await boot(password: 'pesas');
    final (closed, _, h) = await call('GET', '/api/info');
    expect(closed, 401);
    expect(h.value('www-authenticate'), contains('Basic'));
    final wrong = base64.encode(utf8.encode('yo:otra'));
    final (no, _, _) = await call('GET', '/api/info', headers: {'authorization': 'Basic $wrong'});
    expect(no, 401);
    final right = base64.encode(utf8.encode('yo:pesas'));
    final (ok, _, _) = await call('GET', '/api/info', headers: {'authorization': 'Basic $right'});
    expect(ok, 200);
  });

  test('junta la copia del móvil con lo de la web, con sus fotos, y deja la suya', () async {
    await call('PUT', '/api/state', body: jsonEncode({
      'notes': [
        {'id': 'w1', 't': 'web'},
      ],
    }));
    final archive = Archive()
      ..addFile(ArchiveFile.string(
          'gymmane.json',
          jsonEncode({
            'onboarded': true,
            'media': {'EIeI8Vf': 'media/images/bench.jpg'},
            'notes': [
              {'id': 'n1', 'm': ['note-1-0.jpg']},
            ],
            'noteMedia': {'note-1-0.jpg': 'media/notes/first.jpg'},
            'nutrition': {
              'foods': [
                {'id': 'f1', 'ph': 'food-9-1.png'},
              ],
            },
            'foodMedia': {'food-9-1.png': 'foods/oats.png'},
          })))
      ..addFile(ArchiveFile.noCompress('media/images/bench.jpg', 3, [9, 9, 9]))
      ..addFile(ArchiveFile.noCompress('media/notes/first.jpg', 2, [7, 7]))
      ..addFile(ArchiveFile.noCompress('foods/oats.png', 1, [5]));
    File('${tmp.path}/sync/gymmane-auto-phone-2026-11-10-120000.zip').writeAsBytesSync(ZipEncoder().encodeBytes(archive));
    final (status, body, _) = await call('POST', '/api/sync/scan');
    expect(status, 200);
    expect(jsonDecode(body)['imported'], isTrue);

    final (_, text, _) = await call('GET', '/api/state');
    final state = jsonDecode(text) as Map<String, dynamic>;
    expect(state.containsKey('noteMedia'), isFalse);
    expect([for (final n in state['notes'] as List) (n as Map)['id']], containsAll(['w1', 'n1']));
    final exName = (state['media'] as Map)['EIeI8Vf'] as String;
    expect(File('${tmp.path}/data/media/$exName').readAsBytesSync(), [9, 9, 9]);
    expect(File('${tmp.path}/data/media/note-1-0.jpg').readAsBytesSync(), [7, 7]);
    expect(File('${tmp.path}/data/media/food-9-1.png').readAsBytesSync(), [5]);

    final (again, body2, _) = await call('POST', '/api/sync/scan');
    expect(again, 200);
    expect(jsonDecode(body2)['imported'], isFalse);

    final (ex, _, _) = await call('POST', '/api/sync/export');
    expect(ex, 200);
    final mine = Directory('${tmp.path}/sync')
        .listSync()
        .whereType<File>()
        .where((f) => f.uri.pathSegments.last.startsWith('gymmane-auto-server-'))
        .toList();
    expect(mine, hasLength(1));
    final out = ZipDecoder().decodeBytes(mine.single.readAsBytesSync());
    final back = jsonDecode(utf8.decode(out.findFile('gymmane.json')!.readBytes()!)) as Map<String, dynamic>;
    expect((back['noteMedia'] as Map).keys, ['note-1-0.jpg']);
    expect((back['foodMedia'] as Map).keys, ['food-9-1.png']);
    expect(out.findFile((back['media'] as Map)['EIeI8Vf'] as String)!.readBytes(), [9, 9, 9]);
  });

  test('guarda una copia diaria del estado anterior', () async {
    await call('PUT', '/api/state', body: '{"a":1}');
    await call('PUT', '/api/state', body: '{"a":2}');
    final history = Directory('${tmp.path}/data/history').listSync().whereType<File>().toList();
    expect(history, hasLength(1));
    expect(history.single.readAsStringSync(), '{"a":1}');
  });
}
