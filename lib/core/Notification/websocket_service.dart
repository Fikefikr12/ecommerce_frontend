import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class NotificationSocketService {
  late WebSocketChannel channel;

  Function(Map<String, dynamic>)? onMessage;

  void connect(String userId) {
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.100:8080'));

    channel.sink.add(jsonEncode({"type": "register", "userId": userId}));

    channel.stream.listen(
      (event) {
        final data = jsonDecode(event);

        if (onMessage != null) {
          onMessage!(data);
        }
      },
      onError: (error) {
        print(error);
      },
    );

    void disconnect() {
      channel.sink.close();
    }
  }
}
