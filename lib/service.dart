import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'model.dart';

class SocketService {
  final _streamController = StreamController<List<Client>>.broadcast();
  late IO.Socket _socket;

  Stream<List<Client>> get clientStream => _streamController.stream;

  Future<void> connectToSocket() async {
    _socket = IO.io('http://192.168.1.238:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();

    _socket.on('update', (data) {
      final clients = (data as List).map((json) => Client.fromJson(json)).toList();
      _streamController.add(clients);
    });

    _socket.on('disconnect', (_) {
      print('Disconnected from server');
    });

    _socket.on('error', (error) {
      print('Error: $error');
    });
  }

  void dispose() {
    _socket.disconnect();
    _streamController.close();
  }
}