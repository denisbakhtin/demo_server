// Configure routes.
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'echo_handler.dart';
import 'products_handler.dart';
import 'root_handler.dart';

final router = Router()
  ..mount('/public/', createStaticHandler('lib/public'))
  ..get('/', rootHandler)
  ..post('/', postRootHandler)
  ..get('/echo/<message>', echoHandler)
  ..get('/products', productsHandler);
