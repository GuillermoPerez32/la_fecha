import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:la_fecha/core/utils/date.dart';
import 'package:la_fecha/data/models/event.dart';
import 'package:la_fecha/data/services/events.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> events = [];

  @override
  void initState() {
    fetchEvents().then((value) {
      setState(() {
        events = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Eventos'),
        ),
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            Event event = events[index];
            return Card(
              child: ListTile(
                title: Text(dateFormatter(event.date)),
                subtitle: Text(event.event),
                onTap: () => context.go('/${event.date}', extra: event),
              ),
            );
          },
        ));
  }
}
