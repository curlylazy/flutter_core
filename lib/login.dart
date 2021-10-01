import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'app/json.dart';
import 'app/config.dart';
import 'app/dialog.dart';
import 'app/ihttpclient.dart';

var ih = new IHttpClient();
var appConfig = new AppConfig();
var dialogAlert = new DialogAlert();

final ctrTxtUsername = TextEditingController();
final ctrTxtPassword = TextEditingController();

// void btnLoginClick(BuildContext context) {
//   Navigator.pushNamed(
//     context,
//     '/dashboard',
//   );
// }

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalStorage storage = new LocalStorage('session_user');
  _onLogin() async {
    try {
      FocusScope.of(context).unfocus();
      if (ctrTxtUsername.text == "") {
        dialogAlert.toastCustom("username kosong");
        return;
      }

      final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
      await pr.show();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("username", ctrTxtUsername.text);
      ijson.addRow("password", ctrTxtPassword.text);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();
      var res = await ih.sendDataAsync(
          appConfig.APP_URL, "auth/loginadmin", reqData, "", "");

      await pr.hide();

      var resData = jsonDecode(res);
      bool status = resData['status'];

      if (!status) {
        dialogAlert.alertCustom(resData['pesan'], context);
        return;
      }

      dialogAlert.toastCustom("berhasil login..");
      var resDataUser = resData['DataUser'];
      var resDataToken = resData['DataToken'];

      var sessionObject = {
        'usertoken': resDataToken,
        'username': resDataUser['username'],
        'nama': resDataUser['nama'],
      };

      storage.setItem('sessiondata', jsonEncode(sessionObject));

      Navigator.pushNamed(context, '/dashboard');
    } catch (e) {
      dialogAlert.toastCustom(e);
    }
  }

  _onGetData() {
    var kodeuser = storage.getItem('sessiondata');
    print(kodeuser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bglogin_2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
            child: Column(children: [
          _panelHeader(),
          SizedBox(height: 20),
          _panelLogin(context)
        ])),
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
        "assets/images/resto_2.png",
        width: 250,
        height: 250,
      ),
      Text('Aplikasi Keresto',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 27, letterSpacing: 3))
    ]));
  }

  Widget _panelLogin(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.8),
      ),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(10.0),
      child: Column(children: [
        TextField(
          controller: ctrTxtUsername,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan username',
              labelText: 'Username'),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          controller: ctrTxtPassword,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan password',
              labelText: 'Password'),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {
                  _onLogin();
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
