import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../model/client_detail_humidity.dart';
import '../model/client_detail_temp_model.dart';
import '../model/ldr_model.dart';

class SocketProvider with ChangeNotifier {
  Map<String, dynamic> clientData = {};
  late IO.Socket socket;
  List<TempData> temperatureData = [];
  List<HumidityData> humidityData = [];
  List<LDRData> ldrDataList = [];

  void connectToSocket(String clientId) {
    socket = IO.io('http://192.168.0.137:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('Connected: ${socket.id}');
    });

    socket.on('clientDataUpdate_$clientId', (data) {
      _handleSocketData(data);
    });

    socket.emit('getClientData', clientId);
  }

  void _handleSocketData(data) {
    clientData = {};
    if (data is Map<String, dynamic>) {
      clientData = data;
      DateTime now = DateTime.now();
      if (clientData.containsKey('temperature') && clientData.containsKey('humidity')) {
        temperatureData.add(TempData(now, clientData['temperature']));
        humidityData.add(HumidityData(now, clientData['humidity']));
      } else {
        ldrDataList.add(LDRData(now, clientData['lightState']));
      }
      notifyListeners();
    } else {
      print('Data is not in Map format');
    }
  }

  void disconnect() {
    socket.disconnect();
  }
}





