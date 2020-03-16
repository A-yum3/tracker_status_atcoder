import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  // return Decoded Json Data
  Future getJsonData() async {

    final data = await getData();
    return jsonDecode(data);
  }

  Future<String> getData() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = response.body;
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
