import 'dart:convert';
import 'dart:io';

import 'package:gymmane_server/gymmane_server.dart';

Future<void> main(List<String> args) async {
  if (args.contains('--help') || args.contains('-h')) {
    stdout.writeln('''GymMane server $serverVersion

Environment:
  GYMMANE_PORT       port to listen on (default 8080)
  GYMMANE_HOST       address to bind (default 0.0.0.0)
  GYMMANE_DATA       folder for your data (default ./data next to the server)
  GYMMANE_WEB        folder with the web app (default ./web next to the server)
  GYMMANE_PASSWORD   ask for this password in the browser (optional)
  GYMMANE_SYNC       folder shared with your phone through Syncthing (default DATA/sync, "off" to disable)
  GYMMANE_KEEP_DAYS  daily copies of your data to keep (default 30)

  --health           exit 0 if the server answers, 1 if not''');
    return;
  }
  if (args.contains('--health')) {
    exit(await _healthy(Config.fromEnvironment()) ? 0 : 1);
  }
  final config = Config.fromEnvironment();
  final server = GymManeServer(config);
  try {
    await server.start();
  } on FileSystemException catch (e) {
    stderr.writeln('GymMane cannot write to ${e.path ?? config.dataDir}.');
    stderr.writeln('Give the user that runs GymMane write access to that folder, or set GYMMANE_DATA to another one.');
    exit(1);
  } on SocketException catch (e) {
    stderr.writeln('GymMane cannot listen on port ${config.port}: ${e.osError?.message ?? e.message}');
    stderr.writeln('Another program may be using it. Set GYMMANE_PORT to another port.');
    exit(1);
  }
  stdout.writeln('GymMane $serverVersion is running.');
  stdout.writeln('  Open:  http://localhost:${server.port}');
  for (final ip in await _lanAddresses()) {
    stdout.writeln('         http://$ip:${server.port}');
  }
  stdout.writeln('  Data:  ${Directory(config.dataDir).absolute.path}');
  if (config.syncDir != null) stdout.writeln('  Phone: ${Directory(config.syncDir!).absolute.path}');
  if (config.password != null) stdout.writeln('  Password required.');

  for (final signal in [ProcessSignal.sigint, if (!Platform.isWindows) ProcessSignal.sigterm]) {
    signal.watch().listen((_) async {
      await server.stop();
      exit(0);
    });
  }
}

Future<List<String>> _lanAddresses() async {
  try {
    final list = await NetworkInterface.list(type: InternetAddressType.IPv4);
    return [
      for (final i in list)
        for (final a in i.addresses)
          if (!a.isLoopback && !a.isLinkLocal) a.address,
    ];
  } catch (_) {
    return const [];
  }
}

Future<bool> _healthy(Config config) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 3);
  try {
    final req = await client.getUrl(Uri.parse('http://127.0.0.1:${config.port}/api/health'));
    final password = config.password;
    if (password != null) {
      req.headers.set(HttpHeaders.authorizationHeader, 'Basic ${base64.encode(utf8.encode('gymmane:$password'))}');
    }
    final res = await req.close();
    await res.drain<void>();
    return res.statusCode == 200;
  } catch (_) {
    return false;
  } finally {
    client.close(force: true);
  }
}
