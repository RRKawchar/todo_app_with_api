import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static const String API_KEY = "tryout";
  static const String API_URL = "https://api.ipregistry.co/";

  static Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse("$API_URL?key=$API_KEY"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
