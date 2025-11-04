import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  
  final app = Router();

 
  app.get('/', (Request request) {
    return Response.ok('Hola Mundo');
  });

  
  final server = await io.serve(app, 'localhost', 8080);

  print(' API Reports ejecutándose en http://${server.address.host}:${server.port}');
  print(' Ruta principal: http://localhost:8080/');
}