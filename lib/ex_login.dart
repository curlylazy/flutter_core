import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final ctrTxtUsername = TextEditingController();
final ctrTxtPassword = TextEditingController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: TestPage(),
    );
  }
}

void testAlert(BuildContext context) {
  var alert = AlertDialog(
    title: Text("Test"),
    content: Text("Done..!"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Test")),
      body: Container(
        child: Column(children: [_panelHeader(), _panelLogin(context)]),
      ),
    );
  }

  Widget _panelHeader() {
    return Center(
        child: Column(children: [
      SizedBox(
        height: 20.0,
      ),
      Image.asset(
        "assets/images/store.png",
        width: 150,
        height: 150,
      ),
      Text('Aplikasi Keresto',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 2))
    ]));
  }

  Widget _panelLogin(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(children: [
        TextFormField(
          controller: ctrTxtUsername,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan username',
              labelText: 'Username'),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan password',
              labelText: 'Password'),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: ctrTxtPassword,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan password',
              labelText: 'Password'),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              width: double.infinity,
              child: FlatButton(
                color: Colors.blueAccent,
                onPressed: () {
                  print('username : ' + ctrTxtUsername.text);
                  print('password : ' + ctrTxtPassword.text);
                  testAlert(context);
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text('hai anjing'),
                  //         content: Text('ini content anjing'),
                  //       );
                  //     });
                },
                child: Text('LOGIN', style: TextStyle(color: Colors.white)),
              )),
        )
      ]),
    );
  }
}
