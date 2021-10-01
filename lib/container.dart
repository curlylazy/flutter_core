import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ini Contoh Run"),
        ),
        body: Container(
          child: Text('Lanang Anjing'),
          decoration: BoxDecoration(color: Colors.blue),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          width: 200,
          height: 100,
        ),
      ),
    );
  }
}
