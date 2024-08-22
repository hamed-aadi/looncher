import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:looncher/data/apps.dart' as apps;
import 'package:looncher/data/settings.dart';
import 'package:looncher/data/alarms.dart';

class TimeTile extends StatefulWidget {
  const TimeTile({super.key});

  @override
  State<TimeTile> createState() => _TimeTileState();
}

class _TimeTileState extends State<TimeTile> {
  Timer? timer;
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
        Provider.of<AlarmsModel>(context, listen: false).getAlarm();
        setState(() {
            currentTime = DateTime.now();
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 300,
      height: 400,
      decoration: Provider.of<SettingsProvider>(context, listen: false)
      .theme.timeTileDecoration(context),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Clock(currentTime),
          _Alarms(),
      ]),
    );
  }
}

class _Alarms extends StatelessWidget {
  const _Alarms();

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsModel>(
      builder: (_, alarms, __) {
        if (alarms.remainingTime == null) {
          return Container();
        } else {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              alarms.remainingTime!,
              style: TextStyle(
                // color: Theme.of(context).disabledColor,
                fontSize: 12,
              ),
            )
          );
        }
      }
    );
  }
}
                                     
class _Clock extends StatelessWidget {
  final DateTime dateTime;           
  const _Clock(this.dateTime);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) => apps.openApp("com.android.deskclock"),
      child: Container(
      width: 250,
      height: 250,
      decoration: ShapeDecoration(
        color: Theme.of(context).cardColor,
        shape: Provider.of<SettingsProvider>(
          context, listen: false).clockShape,
        shadows: [
          BoxShadow(
            offset: Offset(0,0),
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
            spreadRadius: -5,
          )
        ]
      ),
      child: CustomPaint(
        painter: _ClockPainter(dateTime))
    ));
  }
}

class _ClockPainter extends CustomPainter {
  DateTime dateTime;
  _ClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final hourHandLength = radius * 0.5;
    final minuteHandLength = radius * 0.75;
    final hourAngle =
    (dateTime.hour % 12 + dateTime.minute / 60) * 30 * pi / 180;
    final minuteAngle = dateTime.minute * 6 * pi / 180;
    
    canvas.drawLine(
      center,
      center +
      Offset(cos(hourAngle - pi / 2), sin(hourAngle - pi / 2)) *
      hourHandLength,
      Paint()
      ..color = Colors.brown
      ..strokeWidth = 18.0
      ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      center,
      center +
      Offset(cos(minuteAngle - pi / 2), sin(minuteAngle - pi / 2)) *
      minuteHandLength,
      Paint()
      ..color = Colors.deepOrangeAccent
      ..strokeWidth = 18.0
      ..strokeCap = StrokeCap.round,
    );
    
  }

  @override
  bool shouldRepaint(_ClockPainter oldDelegate) {
    return (oldDelegate.dateTime != dateTime);
  }
}

