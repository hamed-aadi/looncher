import 'package:flutter/material.dart';

import 'package:installed_apps/installed_apps.dart';

import '../settings_page.dart';
import 'swiping_widget.dart';

class MesialArea extends StatelessWidget {
  const MesialArea({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity!.toInt() > 10) {
          InstalledApps.startApp("com.whatsapp");
        }
      },
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder:
            (context) => const SettingsPage()));
      },
      child: Container(
        color: Colors.transparent,
        // child: Center(child: SwipingWidget())
      ),
    );
  }
}
