import 'package:flutter/material.dart';
import 'package:petpal_health/provider/event_provider.dart';
import 'package:petpal_health/widgets/add_event_bottomSheet.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    final filteredEvents = events
        .where(
          (event) => isSameDay(
            DateTime(event.date.year, event.date.month, event.date.day),
            _selectedDate,
          ),
        )
        .toList();

    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return AddEventBottomsheet();
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
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
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFFFDB056),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: const BoxDecoration(
                    color: Color(0xFFFBCB79),
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                  weekendTextStyle: const TextStyle(color: Colors.redAccent),
                  defaultTextStyle: const TextStyle(color: Colors.black),
                  holidayTextStyle: const TextStyle(color: Colors.redAccent),
                  disabledTextStyle: TextStyle(color: Colors.grey.shade400),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: filteredEvents.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_busy, size: 48, color: Colors.white),
                          SizedBox(height: 16),
                          Text(
                            'No events scheduled for this date',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                          itemCount: filteredEvents.length,
                          itemBuilder: (context, index) {
                            final event = filteredEvents[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  event.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                subtitle: Text(
                                  '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}\n${event.description}',
                                ),
                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar().getFooterMenu(context, 1),
      ),
    );
  }
}
