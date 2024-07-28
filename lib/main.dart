import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:looncher/data/settings.dart';
import 'package:looncher/data/alarms.dart';
import 'package:looncher/data/receivers.dart';
import 'package:looncher/page_home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalSettingsProvider()),
        ChangeNotifierProvider(create: (context) => AlarmsModel()),
      ],
      child: const Launcher()
  ));
}

class Launcher extends StatelessWidget {
  const Launcher({super.key});
  
  @override
  Widget build(BuildContext context) {
    initializeChangeChannel(context);
    return Consumer<GlobalSettingsProvider>(
      builder: (context, looncherTheme, _) {
        return MaterialApp(
          theme: looncherTheme.theme.lightTheme,
          darkTheme: looncherTheme.theme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: const PopScope(
            canPop: false,
            child: HomePage())
        );
      }
    );
  }
}
