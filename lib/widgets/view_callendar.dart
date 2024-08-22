import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:looncher/data/settings.dart';

class CalendarSlice extends StatelessWidget {
  const CalendarSlice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(2),
      decoration: Provider.of<SettingsProvider>(context).theme.sliceDecoration(context),
      child: TableCalendar(
        firstDay: DateTime(DateTime.now().year, DateTime.now().month),
        lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.week,
        // locale: 'ar_OM',
        weekendDays : const [DateTime.friday, DateTime.saturday],
        headerVisible: false,
        rowHeight: 40,
        daysOfWeekHeight: 20,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          weekendStyle: TextStyle(color: Theme.of(context).disabledColor),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(4),
          )
        ),
      )
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
    
  bool getSalary(DateTime time) {
    if (time.weekday == DateTime.thursday) {
      if (time.day == 21 || time.day == 22)
      {return true;} else {return false;}
    } else if (
      time.day == 23 &&
      time.weekday != DateTime.friday &&
      time.weekday != DateTime.saturday)
    {return true;} else {return false;}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Flex(
      direction: Axis.vertical,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                offset: Offset(0,0),
                blurRadius: 4,
                spreadRadius: 0, 
              )
            ]
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height / 1.6,
          child: TableCalendar(
            shouldFillViewport: true,
            firstDay: DateTime(DateTime.now().year - 5),
            lastDay: DateTime(DateTime.now().year + 5),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            weekendDays : const [DateTime.friday, DateTime.saturday],
            // locale: 'ar_OM',
            headerVisible: true,
            weekNumbersVisible: true,
            daysOfWeekHeight: 20,
            holidayPredicate: getSalary,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              weekendStyle: TextStyle(color: Theme.of(context).disabledColor),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0,0),
                    color: Theme.of(context).shadowColor,
                    blurRadius: 4,
                  )
                ]
              ),
              holidayTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary),
              holidayDecoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                    _calendarFormat = format;
                });
              }
            },
        )),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(0,0),
                  blurRadius: 4,
                  spreadRadius: 0, 
                )
              ],
            ),
            margin: const EdgeInsets.all(10),
          )
        )
      ]
    ));
  }
}
