import 'dart:io' show HttpRequest, HttpServer, WebSocket, WebSocketTransformer;
import 'dart:convert' show json;

void main() {
  HttpServer.bind('localhost', 8000).then((HttpServer server) {
    print('WebSocket listening on ws://localhost:8000/');
    server.listen((HttpRequest request) {
      WebSocketTransformer.upgrade(request).then((WebSocket ws) {
        ws.listen(
          (data) {
            if (ws.readyState == WebSocket.open) {
              print('Recieved from client: ${json.decode(data)}');
              ws.add(data);
            }
          },
          onDone: () => print('Done'),
          onError: (err) => print(err),
          cancelOnError: true,
        );
      }, onError: (err) => print(err));
    }, onError: (err) => print(err));
  }, onError: (err) => print(err));
}
