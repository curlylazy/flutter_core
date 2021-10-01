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
          body: Wrap(
            children: [
              TeksUtama(teks1: 'Lanang', teks2: 'Anjing'),
              TeksUtama(teks1: 'Lanang', teks2: 'Monyet'),
              TeksUtama(teks1: 'Lanang', teks2: 'Babi'),
              TeksUtama(teks1: 'Lanang', teks2: 'Ular'),
              TeksUtama(teks1: 'Lanang', teks2: 'Kecoa'),
            ],
          )),
    );
  }
}

class TeksUtama extends StatelessWidget {
  final String teks1;
  final String teks2;

  TeksUtama({this.teks1, this.teks2});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(teks1 + " " + teks2),
      decoration: BoxDecoration(color: Colors.blue),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
    );
  }
}
