// import 'dart:convert';
import 'package:http/http.dart' as http;

class IHttpClient {
  sendDataAsync(url, action, data, token, deviceinfo) async {
    try {
      var response = await http
          .post(Uri.parse(url + "/" + action), body: {"postdata": data});

      // print(response.body);
      return response.body;
    } catch (e) {
      print("KESALAHAN :: " + e);
    }
  }
}
