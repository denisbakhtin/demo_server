import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Response echoHandler(Request request) {
  final message = request.params['message'];
  final bold = request.url.queryParameters['bold'];
  final formattedMessage =
      (bold == 'true') ? '<strong>$message</strong>' : '$message';
  final result = '''<html>
      <head>
        <link rel="stylesheet" href="/public/bootstrap.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="/public/bootstrap.bundle.js"></script>
      </head>
      <body>
        <nav class="navbar navbar-dark bg-dark">
          <div class="container">
            <a class="navbar-brand" href="/">Демо сайт</a>
          </div>
        </nav>
        <div class="container my-4">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/">Главная</a></li>
              <li class="breadcrumb-item active" aria-current="page">Echo</li>
            </ol>
          </nav>
          <h1>Echo handler</h1>
          <div class="alert alert-info">$formattedMessage</div>
          <button class="btn btn-primary">Button 1</button>
          <button class="btn btn-success">Button 2</button>
          <br/>
          <br/>
          <img src="/public/images/first.jpg" class="img-fluid" />
        </div>
      </body>
      </html>''';
  return Response.ok(result,
      headers: {'content-type': 'text/html; charset=utf-8'});
}
