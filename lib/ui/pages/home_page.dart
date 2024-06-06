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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentYear, 1, 1),
      lastDate: DateTime(currentYear, 12, 31),
    );
    if (picked != null) {
      final formattedSelectedDate = '${picked.day}-${picked.month}';
      if (events.isEmpty) {
        return;
      }
      final event =
          events.where((element) => element.date == formattedSelectedDate);
      if (event.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay eventos para esta fecha'),
          ),
        );
        return;
      }
      context.go('/$formattedSelectedDate', extra: event.first);
    }
  }

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
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () => _selectDate(context),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            Event event = events[index];
            final component = Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(dateFormatter(event.date),
                    style: const TextStyle(fontSize: 18)),
                subtitle:
                    Text(event.event, style: const TextStyle(fontSize: 16)),
                onTap: () => context.go('/${event.date}', extra: event),
              ),
            );
            if (index != 0 &&
                event.date.split('-')[1] !=
                    events[index - 1].date.split('-')[1]) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      months[int.parse(event.date.split('-')[1]) - 1],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  component,
                ],
              );
            }

            if (index == 0) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      months[int.parse(event.date.split('-')[1]) - 1],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  component,
                ],
              );
            }

            return component;
          },
        ));
  }
}
