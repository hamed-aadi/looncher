import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:launcher0/theme.dart';
import 'package:launcher0/home/home.dart';

void main() => runApp(const Launcher());

class Launcher extends StatelessWidget {
  const Launcher({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF1d2124),
        systemNavigationBarIconBrightness: Brightness.dark));
    return MaterialApp(
      title: 'Launcher',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: const SafeArea(child: Scaffold(body: HomePage()))));
  }
}
