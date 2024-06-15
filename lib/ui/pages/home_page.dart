import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<Event> filteredEvents = [];
  final TextEditingController _searchController = TextEditingController();
  final String expandedMonth = 'Enero';

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
      if (event.length > 1) {
        showMoreEventsDialog(event);
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
        title: Text('Días Internacionales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => _selectDate(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  filteredEvents = events
                      .where((element) => element.event
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Buscar evento',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0), // Espacio entre el TextField y la lista
            Expanded(
              child: ListView(
                children: eventsByMonth().entries.map((entry) {
                  final month = entry.key;
                  final events = entry.value;
                  return ExpansionTile(
                    title: Text(
                      months[int.parse(month) - 1],
                      style: const TextStyle(fontSize: 24),
                    ),
                    children: [
                      Text(
                        months[int.parse(month) - 1],
                        style: const TextStyle(fontSize: 24),
                      ),
                      ...events.map(
                        (event) => Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: ListTile(
                            title: Text(dateFormatter(event.date),
                                style: const TextStyle(fontSize: 18)),
                            subtitle: Text(event.event,
                                style: const TextStyle(fontSize: 16)),
                            onTap: () =>
                                context.go('/${event.date}', extra: event),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<Event>> eventsByMonth() {
    List<Event> rawEvents =
        _searchController.text.isNotEmpty ? filteredEvents : events;
    final Map<String, List<Event>> eventsByMonth = {};
    for (final event in rawEvents) {
      final month = event.date.split('-')[1];
      if (eventsByMonth.containsKey(month)) {
        eventsByMonth[month]!.add(event);
      } else {
        eventsByMonth[month] = [event];
      }
    }
    return eventsByMonth;
  }

  void showMoreEventsDialog(Iterable<Event> events) {
    final eventTiles = events
        .map(
          (e) => Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(e.event),
              onTap: () {
                final formattedDate = e.date.split('-');
                final day = formattedDate[0];
                final month = formattedDate[1];
                context.go('/$day-$month', extra: e);
              },
            ),
          ),
        )
        .toList();
    AlertDialog alert = AlertDialog(
      title: Text("Escoja el evento"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: eventTiles,
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
