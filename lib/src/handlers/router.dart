// Configure routes.
import 'package:shelf_router/shelf_router.dart';

import 'echo_handler.dart';
import 'root_handler.dart';

final router = Router()
  ..get('/', rootHandler)
  ..get('/echo/<message>', echoHandler);
