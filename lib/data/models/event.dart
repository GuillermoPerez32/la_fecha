import 'dart:convert';

List<Event> eventFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  final String date;
  final String event;
  final String details;

  Event({
    required this.date,
    required this.event,
    required this.details,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        date: json["date"],
        event: json["event"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "event": event,
        "details": details,
      };
}
