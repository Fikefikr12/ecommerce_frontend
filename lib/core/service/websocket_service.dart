import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

enum ConnectionStatus { disconnected, connecting, connected, error }

class Websocket {
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;

  final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  final StreamController<ConnectionStatus> _statusController =
      StreamController<ConnectionStatus>.broadcast();

  ConnectionStatus _status = ConnectionStatus.disconnected;

  // Streams that the UI can listen to.

  Stream<String> get messages => _messageController.stream;

  Stream<ConnectionStatus> get status => _statusController.stream;

  ConnectionStatus get currentStatus => _status;

  void _updateStatus(ConnectionStatus newStatus) {
    _status = newStatus;

    if (!_statusController.isClosed) {
      _statusController.add(newStatus);
    }
  }

  Future<void> connect() async {
    if (_status == ConnectionStatus.connecting ||
        _status == ConnectionStatus.connected) {
      return;
    }

    _updateStatus(ConnectionStatus.connecting);

    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('wss://echo.websocket.org'),
      );

      _channel = channel;

      await channel.ready;

      _updateStatus(ConnectionStatus.connected);
      // for reciving message.. start listning to incoming
      _subscription = channel.stream.listen(
        (message) {
          if (!_messageController.isClosed) {
            _messageController.add(message.toString());
          }
        },
        onError: (Object error) {
          _updateStatus(ConnectionStatus.error);
        },
        onDone: () {
          _updateStatus(ConnectionStatus.disconnected);
        },
      );
    } catch (error) {
      _updateStatus(ConnectionStatus.error);
    }
  }

  void sendMessage(String message) {
    if (_status != ConnectionStatus.connected || _channel == null) {
      return;
    }

    _channel!.sink.add(message);
  }

  Future<void> disconnect() async {
    final channel = _channel;
    _channel = null;

    await _subscription?.cancel();
    _subscription = null;

    if (channel != null) {
      await channel.sink.close();
    }

    _updateStatus(ConnectionStatus.disconnected);
  }

  Future<void> dispose() async {
    await disconnect();
    await _messageController.close();
    await _statusController.close();
  }
}
