import 'package:flutter/material.dart';


import 'model.dart';

class DetailScreen extends StatelessWidget {
  final Client client;

  DetailScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Client ID: ${client.id}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Temperature: ${client.temperature.toStringAsFixed(2)} °C',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Humidity: ${client.humidity.toStringAsFixed(2)} %',
              style: TextStyle(fontSize: 18),
            ),
            // Add graph widgets for temperature and humidity here if needed
          ],
        ),
      ),
    );
  }
}
