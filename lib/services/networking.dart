import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String? url;
  NetworkHelper (String, {this.url});

  Future getData() async {
    http.Response response = await http.get(
      Uri.parse(
        url!,
      ),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(
        response.statusCode,
      ); // need to check before response.body in order not to crash the app
    }
  }
}