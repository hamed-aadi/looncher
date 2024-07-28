import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      margin: EdgeInsets.all(20),
      decoration: Provider.of<GlobalSettingsProvider>(context, listen: false)
      .theme
      .timeTileDecoration,
      child: InkWell(
        // TODO: change settings default apps
        onTapDown: (_) => apps.openApp("com.android.deskclock"),
        child: Row(children: [
            _Clock(currentTime),
            _Alarms(),
      ])),
    );
  }
}

class _Alarms extends StatelessWidget {
  const _Alarms();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Consumer<AlarmsModel>(
        builder: (_, alarms, __) => Text(
          alarms.remainingTime ?? "No Alarm is set",
      )),
    );
  }
}
                                     
class _Clock extends StatelessWidget {
  final DateTime dateTime;           
  const _Clock(this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: ShapeDecoration(
        shape: Provider.of<GlobalSettingsProvider>(
          context, listen: false).clockShape,
      ),
      child: CustomPaint(
        painter: _ClockPainter(dateTime),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            color: Colors.brown,
            child: Text(
              " ${dateTime.day}/${dateTime.month} ",
              style: const TextStyle(fontSize: 10, color: Colors.white),
    )))));
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
      ..strokeWidth = 11.0
      ..strokeCap = StrokeCap.round,
    );
    
    canvas.drawLine(
      center,
      center +
      Offset(cos(minuteAngle - pi / 2), sin(minuteAngle - pi / 2)) *
      minuteHandLength,
      Paint()
      ..color = Colors.deepOrangeAccent
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round,
    );
    
    canvas.drawCircle(
      center, radius * 0.04, Paint()..color = Color(0xFFba8349)
    );
    
  }

  @override
  bool shouldRepaint(_ClockPainter oldDelegate) {
    return (oldDelegate.dateTime != dateTime);
  }
}

