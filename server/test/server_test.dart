import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:gymmane_server/gymmane_server.dart';
import 'package:test/test.dart';

void main() {
  late Directory tmp;
  late GymManeServer server;
  late HttpClient client;

  Future<GymManeServer> boot({String? password, String? people}) async {
    final web = Directory('${tmp.path}/web')..createSync(recursive: true);
    File('${web.path}/index.html')
        .writeAsStringSync('<html><head><base href="/"><title>GymMane</title></head>gymmane</html>');
    File('${web.path}/main.dart.js').writeAsStringSync('console.log(1)');
    File('${web.path}/manifest.json').writeAsStringSync('{"name":"GymMane","short_name":"GymMane","start_url":"."}');
    final s = GymManeServer(Config(
      port: 0,
      host: '127.0.0.1',
      dataDir: '${tmp.path}/data',
      webDir: web.path,
      syncDir: '${tmp.path}/sync',
      password: password,
      keepDays: 3,
      people: Config.parsePeople(people),
    ));
    await s.start();
    return s;
  }

  Future<(int, String, HttpHeaders)> call(String method, String path,
      {String? body, List<int>? bytes, Map<String, String> headers = const {}}) async {
    final req = await client.openUrl(method, Uri.parse('http://127.0.0.1:${server.port}$path'))
      ..followRedirects = false;
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

  test('con contraseña enseña su propia pantalla de entrar y recuerda la sesión', () async {
    await server.stop();
    server = await boot(password: 'pesas');
    final (closed, _, h) = await call('GET', '/api/info');
    expect(closed, 401);
    expect(h.value('www-authenticate'), isNull);
    final (page, html, _) = await call('GET', '/progress');
    expect(page, 200);
    expect(html, contains('type="password"'));
    expect(html, contains('action="/login"'));
    expect(html, isNot(contains('gymmane</html>')));
    final (asset, _, _) = await call('GET', '/main.dart.js');
    expect(asset, 200);
    final form = {'content-type': 'application/x-www-form-urlencoded'};
    final (bad, badHtml, badH) = await call('POST', '/login', body: 'password=otra', headers: form);
    expect(bad, 401);
    expect(badHtml, contains('class="bad"'));
    expect(badH.value('set-cookie'), isNull);
    final (good, _, goodH) = await call('POST', '/login', body: 'password=pesas', headers: form);
    expect(good, 303);
    expect(goodH.value('location'), '/');
    final cookie = goodH.value('set-cookie')!;
    expect(cookie, contains('HttpOnly'));
    expect(cookie, contains('Path=/;'));
    final session = {'cookie': cookie.split(';').first};
    final (inside, _, _) = await call('GET', '/api/info', headers: session);
    expect(inside, 200);
    final (app, appHtml, _) = await call('GET', '/', headers: session);
    expect(app, 200);
    expect(appHtml, contains('gymmane</html>'));
    final (out, _, outH) = await call('GET', '/logout', headers: session);
    expect(out, 303);
    expect(outH.value('set-cookie'), contains('Max-Age=0'));
    final (forged, _, _) = await call('GET', '/api/info', headers: {'cookie': 'gymmane=pesas'});
    expect(forged, 401);
    final wrong = base64.encode(utf8.encode('yo:otra'));
    final (no, _, _) = await call('GET', '/api/info', headers: {'authorization': 'Basic $wrong'});
    expect(no, 401);
    final right = base64.encode(utf8.encode('yo:pesas'));
    final (ok, _, _) = await call('GET', '/api/info', headers: {'authorization': 'Basic $right'});
    expect(ok, 200);
  });

  test('tras muchos intentos fallidos deja de aceptar contraseñas un rato', () async {
    await server.stop();
    server = await boot(password: 'pesas');
    final space = server.spaces.single;
    for (var i = 0; i < Space.maxFails; i++) {
      space.failed();
    }
    final form = {'content-type': 'application/x-www-form-urlencoded'};
    final (status, html, h) = await call('POST', '/login', body: 'password=pesas', headers: form);
    expect(status, 429);
    expect(html, contains('data-wait'));
    expect(h.value('set-cookie'), isNull);
    final right = base64.encode(utf8.encode('yo:pesas'));
    final (basic, _, _) = await call('GET', '/api/info', headers: {'authorization': 'Basic $right'});
    expect(basic, 401);
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

  group('varias personas', () {
    String basic(String pass) => 'Basic ${base64.encode(utf8.encode('x:$pass'))}';

    test('lee GYMMANE_PEOPLE con y sin contraseña y rechaza nombres raros', () {
      final people = Config.parsePeople('"Ana María José:uno:1 ,  pablo"');
      expect(people.map((p) => p.name), ['ana-maria-jose', 'pablo']);
      expect(people.first.label, 'Ana María José');
      expect(people.first.password, 'uno:1');
      expect(people.last.password, isNull);
      expect(() => Config.parsePeople('ana, Ana'), throwsFormatException);
      expect(() => Config.parsePeople('ana, ???'), throwsFormatException);
      expect(Config.parsePeople(null), isEmpty);
    });

    test('la portada lista a cada uno y cada uno tiene su dirección', () async {
      await server.stop();
      server = await boot(people: 'Ana, Pablo');
      final (status, html, _) = await call('GET', '/');
      expect(status, 200);
      expect(html, contains('href="/ana/"'));
      expect(html, contains('href="/pablo/"'));
      final (moved, _, h) = await call('GET', '/ana');
      expect(moved, 301);
      expect(h.value('location'), '/ana/');
      final (ok, page, _) = await call('GET', '/ana/');
      expect(ok, 200);
      expect(page, contains('<base href="/ana/">'));
      expect(page, contains('<meta name="gymmane-person" content="ana">'));
      expect(page, contains('GymMane · Ana'));
      final (deep, page2, _) = await call('GET', '/pablo/progress');
      expect(deep, 200);
      expect(page2, contains('<base href="/pablo/">'));
      final (js, code, _) = await call('GET', '/pablo/main.dart.js');
      expect(js, 200);
      expect(code, 'console.log(1)');
      final (_, manifest, _) = await call('GET', '/pablo/manifest.json');
      expect(jsonDecode(manifest)['short_name'], 'Pablo');
      final (unknown, _, h2) = await call('GET', '/carla/');
      expect(unknown, 302);
      expect(h2.value('location'), '/');
      final (rootApi, _, _) = await call('GET', '/api/state');
      expect(rootApi, 302);
      final (health, _, _) = await call('GET', '/api/health');
      expect(health, 200);
    });

    test('los datos de cada persona no se mezclan y el primero se queda con lo que había', () async {
      await call('PUT', '/api/state', body: '{"mine":"before"}');
      await server.stop();
      server = await boot(people: 'ana, Pablo');
      final (_, ana, _) = await call('GET', '/ana/api/state');
      expect(jsonDecode(ana)['mine'], 'before');
      final (empty, _, _) = await call('GET', '/pablo/api/state');
      expect(empty, 204);
      await call('PUT', '/pablo/api/state', body: '{"mine":"pablo"}');
      await call('PUT', '/pablo/api/media/p-1.jpg', bytes: [7]);
      final (_, again, _) = await call('GET', '/ana/api/state');
      expect(jsonDecode(again)['mine'], 'before');
      final (noPhoto, _, _) = await call('GET', '/ana/api/media/p-1.jpg');
      expect(noPhoto, 404);
      expect(File('${tmp.path}/data/people/pablo/state.json').readAsStringSync(), '{"mine":"pablo"}');
      expect(Directory('${tmp.path}/data/people/pablo/sync').existsSync(), isTrue);

      await server.stop();
      server = await boot(people: 'Pablo, ana');
      final (_, swapped, _) = await call('GET', '/ana/api/state');
      expect(jsonDecode(swapped)['mine'], 'before');
      final (_, info, _) = await call('GET', '/pablo/api/info');
      expect(jsonDecode(info)['person'], 'Pablo');
    });

    test('cada persona entra con su contraseña', () async {
      await server.stop();
      server = await boot(password: 'casa-1234', people: 'Ana:ana-1234, pablo');
      final (picker, _, _) = await call('GET', '/');
      expect(picker, 200);
      final (closed, _, _) = await call('GET', '/ana/api/info');
      expect(closed, 401);
      final (page, html, _) = await call('GET', '/ana/');
      expect(page, 200);
      expect(html, contains('<h1>Ana</h1>'));
      expect(html, contains('action="/ana/login"'));
      expect(html, contains('href="/"'));
      final form = {'content-type': 'application/x-www-form-urlencoded'};
      final (_, _, other) = await call('POST', '/ana/login', body: 'password=casa-1234', headers: form);
      expect(other.value('set-cookie'), isNull);
      final (_, _, mine) = await call('POST', '/ana/login', body: 'password=ana-1234', headers: form);
      expect(mine.value('set-cookie'), contains('gymmane-ana='));
      expect(mine.value('set-cookie'), contains('Path=/ana/;'));
      final session = {'cookie': mine.value('set-cookie')!.split(';').first};
      final (inside, _, _) = await call('GET', '/ana/api/info', headers: session);
      expect(inside, 200);
      final (notPablo, _, _) = await call('GET', '/pablo/api/info', headers: session);
      expect(notPablo, 401);
      final (wrong, _, _) = await call('GET', '/ana/api/info', headers: {'authorization': basic('casa-1234')});
      expect(wrong, 401);
      final (ok, _, _) = await call('GET', '/ana/api/info', headers: {'authorization': basic('ana-1234')});
      expect(ok, 200);
      final (shared, _, _) = await call('GET', '/pablo/api/info', headers: {'authorization': basic('casa-1234')});
      expect(shared, 200);
    });

    test('no deja usar un nombre que choca con la web', () async {
      await server.stop();
      await expectLater(boot(people: 'ana, api'), throwsFormatException);
      server = await boot();
    });
  });
}
