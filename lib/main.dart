import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import 'widgets/time_date.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/mesial.dart';

import 'models/favorite_apps.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavorateApps()),
      ],
      child: Launcher()));
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
        scaffoldBackgroundColor: Colors.black,
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
    return Column(
      children: const <Widget>[
        Align(alignment: Alignment.topLeft, child: TimeDate()),
        Expanded(child: MesialWidget()),
        Align(alignment: Alignment.bottomRight, child: BottomBar())
      ],
    );
  }
}
