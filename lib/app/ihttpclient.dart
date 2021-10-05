import 'dart:convert';
import 'package:http/http.dart' as http;

class IHttpClient {
  // var rowMapBody = new Map<String, dynamic>();
  var rowMapBody = {};
  var rowArrBody = [];
  var rowArrTempBody = [];

  addFile(rowname, value) async {
    // this.rowMapBody.addAll({"rowname": rowname, "value": value});
    this.rowMapBody['rowname'] = rowname;
    this.rowMapBody['value'] = value;
    // this.rowArrBody.add({"rowname": rowname, "value": value});
  }

  generateFile() {
    this.rowArrBody.add(this.rowMapBody);
    this.rowMapBody = {};
  }

  generateBody() {
    print(this.rowArrBody);
    // this.rowArrFile = {};
  }

  sendDataAsync(url, action, data, token, deviceinfo) async {
    try {
      http.Response response = await http
          .post(Uri.parse(url + "/" + action), body: {"postdata": data});

      // print(response.body);
      return response.body;
    } catch (e) {
      print("KESALAHAN :: " + e);
    }
  }

  sendDataFile(url, action, data, token, deviceinfo) async {
    try {
      // this.rowArrBody.addAll({"postdata": data});
      // print(this.rowArrBody);
      // http.Response response = await http.post(
      //   Uri.parse(url + "/" + action),
      //   body: this.rowArrBody,
      // );

      // this.rowArrBody.clear();
      // return response.body;

      //create multipart using filepath, string or bytes
      // var pic = await http.MultipartFile.fromPath(
      //     "gambar_pelanggan", gambar_pelanggan);
      // request.files.add(pic);

      var request =
          http.MultipartRequest("POST", Uri.parse(url + "/" + action));
      //add text fields
      request.fields["postdata"] = data;

      // read data file
      var dataFile = jsonDecode(data);
      var dataFileUpload = dataFile['DataFileUpload'];
      print(dataFileUpload.length);
      if (dataFileUpload.length > 0) {
        for (var i = 0; i < dataFileUpload.length; i++) {
          var rowname = dataFileUpload[i]['rowname'];
          var value = dataFileUpload[i]['value'];
          if (value != null) {
            var file = await http.MultipartFile.fromPath(rowname, value);
            request.files.add(file);
          }
        }
      }

      // this.rowArrBody.clear();

      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      return responseString;

      // var resData = {};
      // resData['isBerhasil'] = true;
      // resData['resBody'] = responseString;
      // return resData;
    } catch (e) {
      // var resData = {};
      // resData['isBerhasil'] = false;
      // resData['msgError'] = "KESALAHAN :: " + e;
      print("KESALAHAN :: " + e);
    }
  }
}
