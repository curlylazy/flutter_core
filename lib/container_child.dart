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
          child: Column(
            children: [
              Container(
                child: Text('Lanang Anjing'),
                color: Colors.blue,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(20.0),
              ),
              Container(
                child: Text('Lanang Anjing'),
                color: Colors.blue,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
