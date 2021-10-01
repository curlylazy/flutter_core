import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

var username = "";
var nama = "";

class DashboardPage extends StatefulWidget {
  // const DashboardPage({ Key? key }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.of(context).pushNamed('/');
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "KONFIRMASI",
      style: TextStyle(fontSize: 12, letterSpacing: 2),
    ),
    content: Text("Log out dari sistem ?"),
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

class _DashboardPageState extends State<DashboardPage> {
  final LocalStorage storage = new LocalStorage('session_user');
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {

    // });
    new Future.delayed(Duration.zero, () async {
      var res = jsonDecode(storage.getItem('sessiondata'));
      print(res['username']);

      setState(() {
        username = res['username'];
        nama = res['nama'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        bannerHeader(),
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          menuData(context, 'Data User',
              'assets/images/014-customer service.png', '/user/list'),
          menuData(
              context, 'Data Item', 'assets/images/002-french fries.png', ''),
          menuData(
              context, 'Data Pelanggan', 'assets/images/009-courier.png', ''),
        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [menuLogOut()])
      ]),
    ));
  }

  Widget menuData(
      BuildContext context, String judulmenu, String iconmenu, String url) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: new MaterialButton(
          height: 100.0,
          minWidth: 120.0,
          color: Colors.brown[300],
          textColor: Colors.yellow[200],
          child: Column(children: [
            Image.asset(
              iconmenu,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              judulmenu,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ]),
          onPressed: () => {Navigator.of(context).pushNamed(url)},
          splashColor: Colors.redAccent,
        ));
  }

  Widget menuLogOut() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: new MaterialButton(
          height: 100.0,
          minWidth: 120.0,
          // color: Theme.of(context).primaryColor,
          color: Colors.grey,
          textColor: Colors.white,
          child: Column(children: [
            Image.asset(
              'assets/images/logout.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              'Log Out',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]),
          onPressed: () => {showAlertDialog(context)},
          splashColor: Colors.redAccent,
        ));
  }

  Widget bannerHeader() {
    return Container(
      alignment: Alignment.center,
      height: 200,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.people_alt, size: 14, color: Colors.white),
                ),
                TextSpan(
                  text: "   ",
                ),
                TextSpan(text: nama, style: TextStyle(letterSpacing: 2))
              ],
            ),
          ),
          Text('Aplikasi Resto',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                  color: Colors.white70,
                  fontSize: 35)),
          Text(
            'by inspirasi',
            style: TextStyle(color: Colors.white),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/dashboard.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
