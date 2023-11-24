import 'package:flutter/material.dart';

import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../widgets/time_date.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/mesial.dart';

class Apps {
  static List<AppInfo> appsList = [];
  static void getApps() async {
    appsList = await InstalledApps.getInstalledApps(true, true);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Apps.getApps();
    return const Column(
      children: [
        Align(alignment: Alignment.topLeft, child: TimeDate()),
        Expanded(child: MesialArea()),
        Align(alignment: Alignment.bottomRight, child: BottomBar())
      ],
    );
  }
}
