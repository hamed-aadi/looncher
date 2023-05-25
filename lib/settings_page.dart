import 'package:flutter/material.dart';

import 'widgets/setting_item';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // minimum: EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text("Settings", style: TextStyle(fontSize: 32))),
          ],
      )),
    );
  }
}
