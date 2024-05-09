import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class EventService {
  Future<List<Event>> getEvents() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/acara/'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Event.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}