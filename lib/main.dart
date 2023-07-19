import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:provider/provider.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import 'widgets/time_date.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/mesial.dart';

void main() {
  runApp(Launcher());
  // MultiProvider(
  // providers: [],
  // child: Launcher()));
}



class Launcher extends StatelessWidget {
  const Launcher({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark));
    return MaterialApp(
      title: 'Launcher',
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2E3236),
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
        )
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: const SafeArea(child: Scaffold(
            body: HomePage())))
    );
  }
}

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
    return Container(
      // decoration: const BoxDecoration(
      //   gradient:  LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: <Color>[
      //       Color(0xFF1c1d20),
      //       Color(0xFF1f2124),
      //       Color(0xFF232528),
      //       Color(0xFF26292d),
      //       Color(0xFF2a2d31),
      //       Color(0xFF2d3135),
      //       Color(0xFF31353a),
      //       Color(0xFF34393e),
      //     ],
      //     tileMode: TileMode.mirror,
      // )),
      child: Column(
        children: const [
          Align(alignment: Alignment.topLeft, child: TimeDate()),
          Expanded(child: MesialArea()),
          Align(alignment: Alignment.bottomRight, child: BottomBar())
        ],
    ));
  }
}
