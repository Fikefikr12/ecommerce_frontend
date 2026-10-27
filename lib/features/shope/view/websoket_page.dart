import 'dart:async';

import 'package:ecommerce_frontend/core/service/websocket_service.dart';
import 'package:flutter/material.dart';

class WebsoketPage extends StatefulWidget {
  const WebsoketPage({super.key});

  @override
  State<WebsoketPage> createState() => _WebsoketPageState();
}

class _WebsoketPageState extends State<WebsoketPage> {
  late final Websocket _websocket;
  StreamSubscription<String>? _messageSubscription;
  StreamSubscription<ConnectionStatus>? _statusSubscription;

  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  ConnectionStatus _status = ConnectionStatus.disconnected;

  @override
  void initState() {
    super.initState();
    _websocket = Websocket();
    _statusSubscription = _websocket.status.listen((status) {
      if (!mounted) return;

      setState(() {
        _status = status;
      });
    });

    _messageSubscription = _websocket.messages.listen((message) {
      if (!mounted) return;
      setState(() {
        _messages.add('Receivd :$message');
      });
    });
  }

  Future<void> _connect() async {
    await _websocket.connect();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();

    if (message.isEmpty || _status != ConnectionStatus.connected) {
      return;
    }

    _websocket.sendMessage(message);

    setState(() {
      _messages.add('Sent: $message');
    });

    _messageController.clear();
  }

  Future<void> _disconnect() async {
    await _websocket.disconnect();
  }

  String get _statusText {
    switch (_status) {
      case ConnectionStatus.disconnected:
        return 'Disconnected';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.error:
        return 'Connection error';
    }
  }

  Color get _statusColor {
    switch (_status) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.connecting:
        return Colors.orange;
      case ConnectionStatus.error:
        return Colors.red;
      case ConnectionStatus.disconnected:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _statusSubscription?.cancel();
    _messageController.dispose();
    _websocket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Websocket Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _statusText,
                  style: TextStyle(
                    color: _statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        _status == ConnectionStatus.connecting ||
                            _status == ConnectionStatus.connected
                        ? null
                        : _connect,
                    child: Text('Connect'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _status == ConnectionStatus.disconnected
                        ? null
                        : _disconnect,
                    child: const Text('Disconnect'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Enter a message',
                hintText: 'Hello websocket',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _status == ConnectionStatus.connected
                    ? _sendMessage
                    : null,
                icon: Icon(Icons.send),
                label: Text('Send Message'),
              ),
            ),
            const Divider(height: 32),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Messages',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: _messages.isEmpty
                  ? const Center(child: Text('No messages yet'))
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.message),
                            title: Text(_messages[index]),
                          ),
                        );
                      }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// yane neber egziabhiern yayehut
