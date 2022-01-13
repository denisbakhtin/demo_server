import 'package:demo_server/src/models/db.dart';
import 'package:injector/injector.dart';
import 'package:shelf/shelf.dart';

Response productsHandler(Request request) {
  final db = Injector.appInstance.get<DB>();
  final products = db.products();
  var result = '''<html>
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
              <li class="breadcrumb-item active" aria-current="page">Products</li>
            </ol>
          </nav>
          <h1>Каталог продукции</h1>
          <table class="table table-hover">
            <thead>
              <tr>
                <th>#</th>
                <th>Название</th>
                <th>Описание</th>
              </tr>
            </thead>
            <tbody>
          ''';
  for (final p in products) {
    result += '''
        <tr>
          <td>${p.id}</td>
          <td>${p.title}</td>
          <td>${p.description}</td>
        </tr>''';
  }
  result += '''
            </tbody>
          </table>
        </div>
      </body>
      </html>''';
  return Response.ok(result,
      headers: {'content-type': 'text/html; charset=utf-8'});
}
