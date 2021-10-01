import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content:
        Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class MyApp extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        child: Column(children: [
          _panelHeader(),
          _panelLogin(),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () {
                    print('hei ini masuk : ' + myController.text);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('hai anjing'),
                            content: Text('ini content anjing'),
                          );
                        });
                  },
                  child: Text('LOGIN', style: TextStyle(color: Colors.white)),
                )),
          )
        ]),
      )),
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

  Widget _panelLogin() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(children: [
        TextFormField(
          controller: myController,
          autofocus: true,
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
      ]),
    );
  }
}
