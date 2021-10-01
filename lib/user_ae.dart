// import 'dart:convert';

import 'dart:convert';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app/json.dart';
import 'app/config.dart';
import 'app/dialog.dart';
import 'app/ihttpclient.dart';
import 'app/returndata.dart';

const Color primaryColor = Colors.orange;

var ih = new IHttpClient();
var appConfig = new AppConfig();
var dialogAlert = new DialogAlert();

final ctrTxtUsername = TextEditingController();
final ctrTxtPassword = TextEditingController();
final ctrTxtNama = TextEditingController();
final ctrTxtJK = TextEditingController();
final ctrTxtEmail = TextEditingController();
final ctrTxtAlamat = TextEditingController();
final ctrTxtTelepon = TextEditingController();

String username_old = "";
String kodeuser = "";
String jk = "";
String act = "**new";
String id = "";
String judulMenu = "";
String actPage = "";

class UserData {
  String username;
  String password;
  String nama;

  UserData({this.username, this.password, this.nama});

  @override
  String toString() {
    return '{ ${this.username}, ${this.password}, ${this.nama} }';
  }

  factory UserData.createPostResult(Map<String, dynamic> object) {
    return UserData(
        username: object['username'],
        password: object['password'],
        nama: object['nama']);
  }

  // static Future<UserData> connectToAPI(String name, String job) async {
  //   Uri apiURL = https://reqres.in/api/users;

  //   var apiResult = await http.post(apiURL, body: {"name": name, "job": job});
  //   var jsonObject = json.decode(apiResult.body);

  //   return UserData.createPostResult(jsonObject);
  // }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        username: json['username'],
        password: json['password'],
        nama: json['nama']);
  }
}

// Future<UserData> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return UserData.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class UserAE extends StatefulWidget {
  @override
  UserAEState createState() => UserAEState();

  // void initState() {
  //   print("helo");
  // }
}

class UserAEState extends State<UserAE> {
  void onLoad() {
    // jk = 'L';
    setState(() {
      jk = 'P';
    });

    ctrTxtUsername.text = "iwans_spsp";
    ctrTxtPassword.text = "12345";
    ctrTxtNama.text = "Test User";
    ctrTxtAlamat.text = "Jalan Gang Bubibi";
    ctrTxtEmail.text = "reyah@gmail.com";
    ctrTxtTelepon.text = "08563735581";
  }

  postData() async {
    try {
      var response = await http
          .post(Uri.parse("https://jsonplaceholder.typicode.com/posts"), body: {
        "id": 1.toString(),
        "name": "iwan",
        "email": "curlylazy@gmail.com"
      });

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  postDataLumen() async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.102.50/lumen_2021/public/flutter/postdata"),
          body: {
            "id": 1.toString(),
            "name": "iwan",
            "email": "curlylazy@gmail.com"
          });

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  getData() async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.102.50/lumen_2021/public/user/getlist"),
          body: {
            "id": 1.toString(),
            "name": "iwan",
            "email": "curlylazy@gmail.com"
          });

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  _loadData() async {
    try {
      final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
      await pr.show();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("id", id);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(
          appConfig.APP_URL, "user/read", reqData, "", "");

      print(res);

      await pr.hide();

      var resData = jsonDecode(res);
      var resDataUser = resData['DataUser'];
      bool status = resData['status'];

      if (!status) {
        dialogAlert.alertCustom(resData['pesan'], context);
        return;
      }

      ctrTxtUsername.text = resDataUser['username'];
      ctrTxtPassword.text = resDataUser['password_dec'];
      ctrTxtNama.text = resDataUser['nama'];
      ctrTxtEmail.text = resDataUser['email'];
      ctrTxtAlamat.text = resDataUser['alamat'];
      ctrTxtTelepon.text = resDataUser['telepon'];

      setState(() {
        username_old = resDataUser['username'];
        kodeuser = resDataUser['kodeuser'];
        jk = resDataUser['jk'];
      });
    } catch (e) {
      print(e);
      dialogAlert.alertCustom(e, context);
    }
  }

  _saveData() async {
    try {
      FocusScope.of(context).unfocus();
      final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
      await pr.show();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("username_old", username_old);
      ijson.addRow("kodeuser", kodeuser);
      ijson.addRow("username", ctrTxtUsername.text);
      ijson.addRow("password", ctrTxtPassword.text);
      ijson.addRow("nama", ctrTxtNama.text);
      ijson.addRow("alamat", ctrTxtAlamat.text);
      ijson.addRow("email", ctrTxtEmail.text);
      ijson.addRow("telepon", ctrTxtTelepon.text);
      ijson.addRow("jk", jk);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res =
          await ih.sendDataAsync(appConfig.APP_URL, actPage, reqData, "", "");

      await pr.hide();

      print(res);
      var resData = jsonDecode(res);
      bool status = resData['status'];

      if (!status) {
        dialogAlert.alertCustom(resData['pesan'], context);
        return;
      }
      dialogAlert.alertCustom(resData['pesan'], context);
    } catch (e) {
      print(e);
    }

    // var rest = new ReturnData(resData);
    // print(rest);

    // try {
    //   var response = await http.post(
    //       Uri.parse("http://192.168.102.50/lumen_2021/public/user/tambah"),
    //       body: {"postdata": reqData});

    //   print(response.body);
    // } catch (e) {
    //   print(e);
    // }

    // try {
    //   var response = await http.post(
    //       Uri.parse("http://192.168.102.50/lumen_2021/public/user/tambah"),
    //       body: {"postdata": reqData});

    //   print(response);
    // } catch (e) {
    //   print("KESALAHAN :: " + e);
    // }
  }

  void msgInfo(String msg) {
    AlertDialog alert = AlertDialog(
      title:
          Text("PERINGATAN", style: TextStyle(fontSize: 12, letterSpacing: 2)),
      content: Text(msg),
      actions: [
        TextButton(
            child: Text("OK"), onPressed: () => Navigator.of(context).pop()),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () async {
      var jdlPage = "";
      var arguments = ModalRoute.of(context).settings.arguments as Map;
      print(arguments);
      if (arguments == null) {
        jdlPage = "Tambah User";
        actPage = "user/tambah";
        onLoad();
      } else {
        jdlPage = "Edit User";
        actPage = "user/update";
        id = arguments['id'];
        await _loadData();
      }

      setState(() {
        id = id;
        judulMenu = jdlPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/user/list');
              // Navigator.pushNamed(
              //   context,
              //   '/user/list',
              // );
            },
          ),
          title: Text(judulMenu),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[mainPanel()]),
        )
        // body: SingleChildScrollView(
        //     child: Column(
        //         children: <Widget>[mainPanel(), radioJK(), btnSimpan()])),
        );
  }

  Widget mainPanel() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        SizedBox(
          height: 15.0,
        ),
        TextField(
          controller: ctrTxtUsername,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan username',
              labelText: 'Username'),
        ),
        SizedBox(
          height: 15.0,
        ),
        TextField(
          controller: ctrTxtPassword,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan password',
              labelText: 'Password'),
        ),
        SizedBox(
          height: 15.0,
        ),
        TextField(
          controller: ctrTxtNama,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan nama',
              labelText: 'Nama'),
        ),
        SizedBox(
          height: 15.0,
        ),
        TextField(
          controller: ctrTxtAlamat,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan alamat',
              labelText: 'Alamat'),
        ),
        SizedBox(
          height: 15.0,
        ),
        TextField(
          controller: ctrTxtEmail,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan email',
              labelText: 'Email'),
        ),
        SizedBox(
          height: 15.0,
        ),
        TextField(
          controller: ctrTxtTelepon,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'masukkan telepon',
              labelText: 'No Telepon'),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(3)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Jenis Kelamin"),
              ),
              RadioListTile(
                value: "L",
                dense: true,
                groupValue: jk,
                title: Text("Laki-laki"),
                activeColor: Colors.blue,
                onChanged: (String value) {
                  setState(() {
                    jk = value;
                  });
                },
              ),
              RadioListTile(
                value: "P",
                dense: true,
                groupValue: jk,
                title: Text("Perempuan"),
                activeColor: Colors.blue,
                onChanged: (String value) {
                  setState(() {
                    jk = value;
                  });
                },
              ),
            ])),
        SizedBox(
          height: 15.0,
        ),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.orange,
                // ),
                onPressed: () {
                  _saveData();
                },
                child: Text('SIMPAN', style: TextStyle(color: Colors.white)),
              )),
        )
      ]),
    );
  }
}

// RadioListTile(
//                 value: "L",
//                 dense: true,
//                 groupValue: jk,
//                 title: Text("Laki-laki"),
//                 activeColor: Colors.blue,
//                 onChanged: (String value) {
//                   setState(() {
//                     jk = value;
//                   });
//                 },
//               ),
//               RadioListTile(
//                 value: "P",
//                 dense: true,
//                 groupValue: jk,
//                 title: Text("Perempuan"),
//                 activeColor: Colors.blue,
//                 onChanged: (String value) {
//                   setState(() {
//                     jk = value;
//                   });
//                 },
//               ),

// Row(
//           children: <Widget>[
//             Container(
//               child: Row(
//                 children: [
//                   Radio(
//                     value: 'L',
//                     groupValue: jk,
//                     onChanged: (value) {
//                       setState(() {
//                         jk = value;
//                       });
//                     },
//                     activeColor: Colors.orange,
//                   ),
//                   Text('Laki Laki')
//                 ],
//               ),
//             ),
//             Container(
//               child: Row(
//                 children: [
//                   Radio(
//                     value: 'P',
//                     groupValue: jk,
//                     onChanged: (value) {
//                       setState(() {
//                         jk = value;
//                       });
//                     },
//                     activeColor: Colors.orange,
//                   ),
//                   Text('Perempuan')
//                 ],
//               ),
//             )
//           ],
//         )