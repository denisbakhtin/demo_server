import 'dart:io';
import 'package:demo_server/src/models/db.dart';
import 'package:demo_server/src/handlers/router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:injector/injector.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Use DI to keep single DB instance
  var db = DB('debug.db');
  final injector = Injector.appInstance;
  injector.registerSingleton<DB>(() => db);
  db.seed();

  // Configure a pipeline that logs requests.
  final _handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(cookieParser("mypassword"))
      .addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}
