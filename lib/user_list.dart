// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'app/json.dart';
import 'app/config.dart';
import 'app/dialog.dart';
import 'app/ihttpclient.dart';

import 'widgets/navdrawer.dart';

const Color primaryColor = Colors.orange;
const String judulMenu = "Daftar User";

int totalpage = 1;
int currentpage = 1;

var ih = new IHttpClient();
var appConfig = new AppConfig();
var dialogAlert = new DialogAlert();

final List dataUser = [];
var dataDetail = {};
var username = "";

final ctrTxtKataKunci = TextEditingController();

class UserList extends StatefulWidget {
  @override
  UserListState createState() => UserListState();
}

class UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {

    // });
    new Future.delayed(Duration.zero, () async {
      await _loadData();
    });
  }

  _nextPage() async {
    if (currentpage == totalpage) return;
    setState(() {
      currentpage = currentpage + 1;
    });

    await _loadData();
  }

  _prevPage() async {
    if (currentpage == 1) return;
    setState(() {
      currentpage = currentpage - 1;
    });

    await _loadData();
  }

  _loadDataDetail(data) {
    dataDetail.clear();
    dataDetail['kodeuser'] = data['kodeuser'];
    dataDetail['username'] = data['username'];
    dataDetail['nama'] = data['nama'];
  }

  _hapusData(data) async {
    try {
      var msg = "apakah anda ingin mengapus data " + data['nama'];
      var isdelete =
          await dialogAlert.confirmAlertDialog(context, 'KONFIRMASI', msg);
      if (isdelete) {
        final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
        await pr.show();

        var ijson = new IJson();
        ijson.newTable("DataHeader");
        ijson.addRow("kode", data['kodeuser']);
        ijson.endRow();
        ijson.createTable();

        var reqData = ijson.generateJson();
        var res = await ih.sendDataAsync(
            appConfig.APP_URL, "user/delete", reqData, "", "");

        await pr.hide();

        var resData = jsonDecode(res);
        bool status = resData['status'];

        if (!status) {
          dialogAlert.alertCustom(resData['pesan'], context);
          return;
        }

        setState(() {
          currentpage = 1;
        });

        await _loadData();
      }
    } catch (e) {
      print(e);
    }
  }

  _loadData() async {
    FocusScope.of(context).unfocus();
    try {
      setState(() {
        dataUser.clear();
      });

      final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
      await pr.show();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("katakunci", ctrTxtKataKunci.text);
      ijson.addRow("page", currentpage);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(
          appConfig.APP_URL, "user/list", reqData, "", "");

      var resData = jsonDecode(res);
      var resDataUser = resData['DataUser'];
      var resDataPaging = resData['DataPaging'];

      var arrTemp = [];
      for (var row in resDataUser) {
        arrTemp.add({
          'kodeuser': row['kodeuser'],
          'username': row['username'],
          'nama': row['nama'],
          'telepon': row['telepon']
        });
      }

      setState(() {
        dataUser.addAll(arrTemp);
        totalpage = resDataPaging['totalpage'];
      });

      await pr.hide();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    currentpage = 1;
                  });
                  await _loadData();
                },
                child: Icon(
                  Icons.refresh,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/user/add');
                  Navigator.of(context).pushReplacementNamed('/user/add');
                },
                child: Icon(Icons.add),
              )),
        ],
        title: Text(judulMenu),
      ),
      body: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: ctrTxtKataKunci,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _loadData();
                        },
                        icon: Icon(Icons.search),
                      ),
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: 'masukkan katakunci',
                      labelText: 'Katakunci'),
                )
              ])),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: dataUser.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      await _loadDataDetail(dataUser[index]);
                      await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 15, left: 15, bottom: 10),
                                    child: Text(
                                        'Data : ' + dataDetail['username'],
                                        style: TextStyle(fontSize: 17))),
                                ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  title: Text('Hapus',
                                      style: TextStyle(color: Colors.red)),
                                  onTap: () async {
                                    await _hapusData(dataUser[index]);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/user/add',
                                        arguments: {
                                          'id': dataDetail['kodeuser']
                                        });
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.close),
                                  title: Text('Cancel'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          // ListTile(
                          //   contentPadding: EdgeInsets.all(10),
                          //   leading: Icon(Icons.people),
                          //   title: Text(dataUser[index]['username']),
                          //   subtitle: Text(dataUser[index]['nama'] +
                          //       '\n' +
                          //       dataUser[index]['telepon']),
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: <Widget>[
                          //     TextButton(
                          //       child: const Text('EDIT'),
                          //       onPressed: () {/* ... */},
                          //     ),
                          //     const SizedBox(width: 8),
                          //     TextButton(
                          //       child: const Text('HAPUS'),
                          //       style: TextButton.styleFrom(
                          //         primary: Colors.red,
                          //       ),
                          //       onPressed: () {/* ... */},
                          //     ),
                          //     const SizedBox(width: 8),
                          //   ],
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 15, bottom: 10),
                            child: Text(dataUser[index]['username'],
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 3)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 15, bottom: 5),
                            child: Text(dataUser[index]['nama'],
                                style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 15, bottom: 15),
                            child: Text(dataUser[index]['telepon'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ])));
              },
            ),
          ),
          Container(
              decoration: new BoxDecoration(color: Colors.grey[300]),
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: TextButton.icon(
                        icon: Icon(Icons.arrow_left),
                        label: Text('PREV'),
                        onPressed: () {
                          _prevPage();
                        }),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                        currentpage.toString() + '/' + totalpage.toString()),
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                          icon: Icon(Icons.arrow_left),
                          label: Text('NEXT'),
                          onPressed: () {
                            _nextPage();
                          }))
                ],
              )),
        ],
      ),
    );
  }
}
