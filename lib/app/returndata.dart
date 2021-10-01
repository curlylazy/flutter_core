import 'dart:convert';
import 'json.dart';

class ReturnData {
  ReturnData(data) {
    var number = 0;
    var message = '';

    if (data == null) {
      number = 601;
      message = "Permintaan data ke server gagal.";
      data = null;
      return;
    }

    try {
      var jobj = IJson.jsontodata(data, 'ret');
      jobj.forEach((k, v) => {
            number = v['num'],
            message = v['message'],
            data = v['data'],
          });
    } catch (e) {
      print(e);
    }

    print('hei' + data.toString());
    return;
  }
}
