import 'package:shelf/shelf.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';

Response rootHandler(Request req) {
  CookieParser cookies = req.context['cookies'] as CookieParser;
  final cookie = cookies.get('counter');
  //read cookie value if set
  final counter = cookie != null ? int.parse(cookie.value) + 1 : 1;

  //update/create cookie
  cookies.set('counter', counter.toString(), httpOnly: true);
  final result = '''<html><body>
      <p>You have viewed this page $counter time(s).</p>
      <p>
        <form method="post">
          <button type="submit">Clear counter</button>
        </form>
      </p>
      </body></html>''';
  return Response.ok(result,
      headers: {'content-type': 'text/html; charset=utf-8'});
}

//will handle clear cookie request
Response postRootHandler(Request req) {
  CookieParser cookies = req.context['cookies'] as CookieParser;

  //delete cookie
  cookies.set(
    "counter",
    "",
    expires: DateTime.now().add(-Duration(days: 30)),
  );
  return Response.found('/');
}
