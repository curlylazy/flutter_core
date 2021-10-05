// import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/json.dart';
import '../../app/config.dart';
import '../../app/stringfunction.dart';
import '../../app/dialog.dart';
import '../../app/ihttpclient.dart';
import '../../app/returndata.dart';

const Color primaryColor = Colors.orange;

var ih = new IHttpClient();
var appConfig = new AppConfig();
var dialogAlert = new DialogAlert();
var stringFunction = new StringFunction();

final ctrTxtUserPelanggan = TextEditingController();
final ctrTxtPassword = TextEditingController();
final ctrTxtNama = TextEditingController();
final ctrTxtJK = TextEditingController();
final ctrTxtEmail = TextEditingController();
final ctrTxtAlamat = TextEditingController();
final ctrTxtTelepon = TextEditingController();

String userpelanggan_old = "";
String kodepelanggan = "";
String jk = "";
String act = "**new";
String id = "";
String judulMenu = "";
String actPage = "";

class PelangganAE extends StatefulWidget {
  @override
  PelangganAEState createState() => PelangganAEState();

  // void initState() {
  //   print("helo");
  // }
}

class PelangganAEState extends State<PelangganAE> {
  File gambar_pelanggan_file;
  String gambar_pelanggan = appConfig.APP_URL + "/gambar/noimage.jpg";

  void onLoad() {
    // jk = 'L';
    setState(() {
      jk = 'P';
      gambar_pelanggan = appConfig.APP_URL + "/gambar/noimage.jpg";
    });

    print(gambar_pelanggan);

    ctrTxtUserPelanggan.text = "iwans_spsp";
    ctrTxtPassword.text = "12345";
    ctrTxtNama.text = "Test User";
    ctrTxtAlamat.text = "Jalan Gang Bubibi";
    ctrTxtEmail.text = "reyah@gmail.com";
    ctrTxtTelepon.text = "08563735581";
  }

  _pickImage() async {
    // Pick an image
    final ImagePicker _picker = ImagePicker();
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      gambar_pelanggan_file = File(image.path);
      gambar_pelanggan = image.path;
    });
    // XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // XFile image = await picker.pickImage(source: ImageSource.gallery);
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
          appConfig.APP_URL, "pelanggan/read", reqData, "", "");

      print(res);

      await pr.hide();

      var resData = jsonDecode(res);
      var resDataPelanggan = resData['DataPelanggan'];
      bool status = resData['status'];

      if (!status) {
        dialogAlert.alertCustom(resData['pesan'], context);
        return;
      }

      ctrTxtUserPelanggan.text = resDataPelanggan['userpelanggan'];
      ctrTxtPassword.text = resDataPelanggan['password_dec'];
      ctrTxtNama.text = resDataPelanggan['nama_pelanggan'];
      ctrTxtEmail.text = resDataPelanggan['email_pelanggan'];
      ctrTxtAlamat.text = resDataPelanggan['alamat_pelanggan'];
      ctrTxtTelepon.text = resDataPelanggan['telepon_pelanggan'];

      String gambar_pelanggan_url = "";
      if (stringFunction.isNullOrEmpty(resDataPelanggan['gambar_pelanggan'])) {
        gambar_pelanggan_url = appConfig.APP_URL + "/gambar/noimage.jpg";
      } else {
        gambar_pelanggan_url = appConfig.APP_URL +
            "/gambar/" +
            resDataPelanggan['gambar_pelanggan'];
      }

      setState(() {
        userpelanggan_old = resDataPelanggan['username'];
        kodepelanggan = resDataPelanggan['kodepelanggan'];
        jk = resDataPelanggan['jk_pelanggan'];
        gambar_pelanggan = gambar_pelanggan_url;
      });

      print(gambar_pelanggan);
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
      ijson.addRow("userpelanggan_old", userpelanggan_old);
      ijson.addRow("kodepelanggan", kodepelanggan);
      ijson.addRow("userpelanggan", ctrTxtUserPelanggan.text);
      ijson.addRow("password", ctrTxtPassword.text);
      ijson.addRow("nama_pelanggan", ctrTxtNama.text);
      ijson.addRow("alamat_pelanggan", ctrTxtAlamat.text);
      ijson.addRow("email_pelanggan", ctrTxtEmail.text);
      ijson.addRow("telepon_pelanggan", ctrTxtTelepon.text);
      ijson.addRow("jk_pelanggan", jk);
      ijson.endRow();
      ijson.createTable();

      ijson.newFile();
      ijson.addFile("gambar_pelanggan", gambar_pelanggan);
      ijson.createFile();

      var reqData = ijson.generateJson();

      var res =
          await ih.sendDataFile(appConfig.APP_URL, actPage, reqData, "", "");

      await pr.hide();

      var resData = jsonDecode(res);
      bool status = resData['status'];

      if (!status) {
        dialogAlert.alertCustom(resData['pesan'], context);
        return;
      }
      dialogAlert.alertCustom(resData['pesan'], context);

      // final uri = 'https://na57.salesforce.com/services/oauth2/token';
      // var map = new Map<String, dynamic>();
      // map['grant_type'] = 'password';
      // map['client_id'] =
      //     '3MVG9dZJodJWITSviqdj3EnW.LrZ81MbuGBqgIxxxdD6u7Mru2NOEs8bHFoFyNw_nVKPhlF2EzDbNYI0rphQL';
      // map['client_secret'] =
      //     '42E131F37E4E05313646E1ED1D3788D76192EBECA7486D15BDDB8408B9726B42';
      // map['username'] = 'example@mail.com.us';
      // map['password'] = 'ABC1234563Af88jesKxPLVirJRW8wXvj3D';

      // http.Response response = await http.post(
      //   Uri.parse(uri),
      //   body: map,
      // );

      // print(response.body);
      // FormData formData = new FormData.from({"name": "wendux"});

    } catch (e) {
      final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
      await pr.hide();
      dialogAlert.alertCustom(e.toString(), context);
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () async {
      var jdlPage = "";
      var arguments = ModalRoute.of(context).settings.arguments as Map;
      print(arguments);
      if (arguments == null) {
        appConfig.APP_SAVE_MODE = appConfig.APP_SAVE_MODE_ADD;
        jdlPage = "Tambah Pelanggan";
        actPage = "pelanggan/tambah";
        onLoad();
      } else {
        appConfig.APP_SAVE_MODE = appConfig.APP_SAVE_MODE_UPD;
        jdlPage = "Edit Pelanggan";
        actPage = "pelanggan/update";
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
              // Navigator.of(context).pushReplacementNamed('/pelanggan/list');
              Navigator.pushNamed(
                context,
                '/pelanggan/list',
              );
            },
          ),
          title: Text(judulMenu),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[mainPanel()]),
        ));
  }

  Widget _imageContainer() {
    Widget child;
    if (gambar_pelanggan_file == null) {
      child =
          Container(child: Image.network(gambar_pelanggan, fit: BoxFit.cover));
    } else {
      child = Container(
          child: Image.file(
        gambar_pelanggan_file,
        fit: BoxFit.cover,
      ));
    }

    return child;
  }

  Widget mainPanel() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        SizedBox(
          height: 15.0,
        ),
        TextField(
          controller: ctrTxtUserPelanggan,
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
            child:
                Align(child: _imageContainer(), alignment: Alignment.topLeft)),
        SizedBox(
          height: 15.0,
        ),
        Container(
          padding: EdgeInsets.all(0),
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              height: 30,
              width: 150,
              child: ElevatedButton.icon(
                onPressed: () {
                  _pickImage();
                },
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                label: Text('Pilih Gambar', style: TextStyle(fontSize: 12)),
                icon: Icon(Icons.image),
              )),
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