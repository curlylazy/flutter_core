import 'package:flutter/material.dart';

class NestedApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NestedApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Column Widget'),
        ),
        body: Container(
          height: 1000,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 50,
                width: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.green,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.orange,
                    height: 50,
                    width: 50,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
