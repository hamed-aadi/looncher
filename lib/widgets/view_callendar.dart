import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:looncher/widgets/view.dart';
import 'package:looncher/data/settings.dart';

class CalendarSlice extends StatelessWidget {
  const CalendarSlice({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSlice(
      Axis.horizontal,
      Container(
        // padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0,1),
              color: Theme.of(context).shadowColor,
              blurRadius: 5,
              spreadRadius: -2,
            )
          ]
        ),
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
            weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            weekendStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(4),
            )
          ),
        )
    ));
  }
}

class CalendarPage extends StatelessWidget {
  final Axis reverseAxis;
  const CalendarPage(this.reverseAxis, {super.key});

  final CalendarFormat _calendarFormat = CalendarFormat.month;
    
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
    return BasePage(
      reverseAxis: reverseAxis,
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Flex(
            direction:
               (orientation == Orientation.portrait) ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                flex: 3,
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
                  ]
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: TableCalendar(
                  shouldFillViewport: true,
                  firstDay: DateTime(DateTime.now().year - 5),
                  lastDay: DateTime(DateTime.now().year + 5),
                  focusedDay: DateTime.now(),
                  calendarFormat: _calendarFormat,
                  weekendDays : const [DateTime.friday, DateTime.saturday],
                  // locale: 'ar_OM',
                  headerVisible: true,
                  weekNumbersVisible: true,
                  daysOfWeekHeight: 20,
                  holidayPredicate: getSalary,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    weekendStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
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
                      color: Theme.of(context).colorScheme.primary),
                    holidayDecoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.primary),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
              ))),
              Expanded(
                flex: 2,
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
          );
        },
      )
    );
  }
}
