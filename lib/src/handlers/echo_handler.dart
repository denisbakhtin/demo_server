import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Response echoHandler(Request request) {
  final message = request.params['message'];
  final bold = request.url.queryParameters['bold'];
  final formattedMessage =
      (bold == 'true') ? '<strong>$message</strong>' : '$message';
  final result = '''<html>
      <head></head>
      <body>
        <h1>Echo handler</h1>
        <p>$formattedMessage</p>
      </body>
      </html>''';
  return Response.ok(result,
      headers: {'content-type': 'text/html; charset=utf-8'});
}
