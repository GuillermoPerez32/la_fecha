import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:la_fecha/data/models/event.dart';

Future<List<Event>> fetchEvents() async {
  String jsonString = await rootBundle.loadString('assets/dates.json');
  List<dynamic> jsonList = json.decode(jsonString);

  List<Event> events = jsonList.map((json) => Event.fromJson(json)).toList();

  return events;
}
