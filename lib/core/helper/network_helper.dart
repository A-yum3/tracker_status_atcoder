import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  // return Decoded Json Data
  Future getJsonData() async {

    var data = await getData();
    return jsonDecode(data);
  }

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}