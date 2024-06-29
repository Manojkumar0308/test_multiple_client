

import 'package:flutter/material.dart';
import 'package:test_multiple_client/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socket.IO Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      //  routes: {
      //   '/clientDetail': (context) => ClientDetailScreen(clientId: '',isLdr: true,), // Register detail screen route
      // },
    );
  }
}

