import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://127.0.0.1:8000 '; // Sesuaikan dengan URL FastAPI Anda

  static Future<List<dynamic>> fetchMusicEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/acara/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load music events');
    }
  }

  static Future<dynamic> createMusicEvent(
      Map<String, dynamic> musicEvent) async {
    final response = await http.post(
      Uri.parse('$baseUrl/acara/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(musicEvent),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create music event');
    }
  }
}
