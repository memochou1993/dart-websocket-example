import 'dart:io' show WebSocket;
import 'dart:convert' show json;
import 'dart:async' show Timer;

main() {
  WebSocket.connect('ws://localhost:8000').then((WebSocket ws) {
    if (ws.readyState == WebSocket.open) {
      ws.add(json.encode({
        'data': 'Hello',
      }));
    }
    ws.listen(
      (data) {
        if (ws.readyState == WebSocket.open) {
          print('Recieved from server: ${json.decode(data)}');
          Timer(Duration(seconds: 1), () {
            ws.add(data);
          });
        }
      },
      onDone: () => print('Done'),
      onError: (err) => print(err),
      cancelOnError: true,
    );
  }, onError: (err) => print(err));
}
