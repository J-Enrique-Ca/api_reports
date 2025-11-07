import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';

void main() async {
  final app = Router();

  app.get('/', (Request request) {
    return Response.ok('Hola Mundo');
  });

  app.get('/reportes', (Request request) {
    final reportes = [
      {'id': 1, 'titulo': 'Reporte de daños', 'fecha': '2025-11-06'},
      {'id': 2, 'titulo': 'Basura en la calle', 'fecha': '2025-11-05'},
      {'id': 3, 'titulo': 'Luz pública apagada', 'fecha': '2025-11-04'},
    ];

    return Response.ok(
      jsonEncode(reportes),
      headers: {'Content-Type': 'application/json'},
    );
  });


  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware((innerHandler) {
    return (request) async {
      
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: _corsHeaders);
      }

      final response = await innerHandler(request);
      return response.change(headers: _corsHeaders);
    };
  }).addHandler(app);

 
  final server = await io.serve(handler, 'localhost', 8081);
  print('✅ API Reports corriendo en http://${server.address.host}:${server.port}');
}

const Map<String, String> _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Origin, Content-Type',
};