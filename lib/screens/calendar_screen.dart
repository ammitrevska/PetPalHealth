import 'package:flutter/material.dart';
import 'package:petpal_health/models/event.dart';
import 'package:petpal_health/widgets/add_event_bottomSheet.dart';
import 'package:petpal_health/widgets/gradient_background.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<Event> _events = [];

  @override
  Widget build(BuildContext context) {
    final filteredEvents =
        _events.where((event) => isSameDay(event.date, _selectedDate)).toList();
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
          actions: [
            IconButton.filled(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AddEventBottomsheet();
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime.utc(2010),
              lastDay: DateTime.utc(2030),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
            ),
            Expanded(
              child: filteredEvents.isEmpty
                  ? const Center(
                      child: Text('No events scheduled for this date'),
                    )
                  : ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = filteredEvents[index];
                        return Card(
                          child: ListTile(
                            title: Text(event.title),
                            subtitle: Text(
                                '${event.time.hour}:${event.time.minute},'),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
