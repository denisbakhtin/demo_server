// Configure routes.
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'echo_handler.dart';
import 'root_handler.dart';

final router = Router()
  ..mount('/public/', createStaticHandler('lib/public'))
  ..get('/', rootHandler)
  ..get('/echo/<message>', echoHandler);
