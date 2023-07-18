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


BoxDecoration neuRec = BoxDecoration(
  color: const Color(0xFF1d2124),
  borderRadius: BorderRadius.circular(20),
  shape:BoxShape.rectangle,
  border: Border.all(
    width: 0 ,
    color: Colors.black
  ),
  boxShadow: const [
    BoxShadow(                  //bottomRight
      color: Color(0xFF151515),
      offset:  Offset(2, 2),
      blurRadius: 1,
      spreadRadius: 1),
    BoxShadow(                  //topLeft
      color: Color(0xFF414141),
      offset: Offset(-2, -2),
      blurRadius: 1,
      spreadRadius: 1),
  ],
  gradient: const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: <Color>[
      Color(0xFF1a1c20),
      Color(0xFF1e2024),
      Color(0xFF212428),
      Color(0xFF25282c),
      Color(0xFF292c30),
      Color(0xFF2c3034),
      Color(0xFF303438),
      Color(0xFF34383c),
      Color(0xFF383c40),
      Color(0xFF3c4044),
      Color(0xFF404549),
      Color(0xFF44494d)
    ],
  )
);

BoxDecoration neuRecEmboss = BoxDecoration(
  color: const Color(0xFF1d2124),
  borderRadius: BorderRadius.circular(10),
  shape:BoxShape.rectangle,
  border: Border.all(
    width: 0,
    color: Colors.black
  ),
  boxShadow: const [
    // BoxShadow(
    // color: Color(0xFF414141),
      // offset: Offset(-2, -2),
      // blurRadius: 1,
      // spreadRadius: 1),
      BoxShadow(
        color: Color(0xFF151515),
        offset:  Offset(-2, -2),
        blurRadius: 1,
        spreadRadius: 1),
    ]
);



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
        scaffoldBackgroundColor: const Color(0xFF1d2124),
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
        Expanded(child: MesialArea()),
        Align(alignment: Alignment.bottomRight, child: BottomBar())
      ],
    );
  }
}
