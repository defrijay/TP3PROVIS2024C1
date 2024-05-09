import 'package:flutter/material.dart';
import 'event_service.dart';
import 'model.dart';

class EventProvider extends ChangeNotifier {
  List<Event> events = [];

  Future<void> fetchEvents() async {
    try {
      EventService eventService = EventService();
      events = await eventService.getEvents();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch events: $e');
    }
  }
}