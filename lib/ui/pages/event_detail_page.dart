import 'package:flutter/material.dart';
import 'package:la_fecha/core/utils/date.dart';
import 'package:la_fecha/data/models/event.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dateFormatter(event.date)),
      ),
      body: ListView(
        children: [
          Text(
            event.event,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FadeInImage(
              image: AssetImage('assets/images/${event.imagen}.jpg'),
              height: 150,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/loading.webp'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Text(
              event.details,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
