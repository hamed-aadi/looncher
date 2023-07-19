import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:installed_apps/installed_apps.dart';

import '../theme.dart';


class TimeDate extends StatefulWidget {
  const TimeDate({super.key});
  @override
  State<TimeDate> createState() => _TimeDateState();
}

class _TimeDateState extends State<TimeDate> {
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(
          () {
            _currentTime = DateTime.now();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: box,
        width: double.infinity,
        // color: Colors.grey,
        // padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () => InstalledApps.startApp("com.android.deskclock"),
                child: Text(
                  DateFormat.jm().format(_currentTime),
                  style: const TextStyle(fontSize: 40),
            ))),
            Divider(color: Color(0xFF3F4449), height: 1),
            Divider(color: Color(0xFF000000), height: 2),
            Padding(
              padding: EdgeInsets.all(10),              
              child: Text(
                " ${DateFormat('EEEE, dd MMMM').format(_currentTime)}",
              style: const TextStyle(fontSize: 18),
          ))
  ])));
  }
}
