import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:installed_apps/installed_apps.dart';

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
      padding: EdgeInsets.all(30),
      child: SizedBox(
        width: 200,
        // color: Colors.grey,
        // padding: EdgeInsets.fromLTRB(, 10, 1, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => InstalledApps.startApp("com.android.deskclock"),
              child: Text(
                DateFormat.jm().format(_currentTime),
                style: const TextStyle(fontSize: 40),
            )),
            Text(
              DateFormat('EEEE, dd MMMM').format(_currentTime),
              style: const TextStyle(fontSize: 18),
            )
    ])));
  }
}
