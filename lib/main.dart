import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:looncher/data/settings.dart';
import 'package:looncher/data/alarms.dart';
import 'package:looncher/data/apps.dart';
import 'package:looncher/page_home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => AlarmsModel()),
        ChangeNotifierProvider(create: (context) => InstalledAppsModel()),
      ],
      child: const Launcher()
  ));
}

class Launcher extends StatelessWidget {
  const Launcher({super.key});
  
  @override
  Widget build(BuildContext context) {
    initReceivers(context);
    return MaterialApp(
      theme: Provider.of<SettingsProvider>(context).theme.lightTheme,
      darkTheme: Provider.of<SettingsProvider>(context).theme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: PopScope(
        canPop: false,
        child: HomePage()),
    );
  }
}

void initReceivers(BuildContext context) {
  const appChannel = MethodChannel('com.hamedaadi.looncher/appReceivers');
  appChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onAppAdded':
        var app = call.arguments;
        Provider.of<InstalledAppsModel>(context, listen: false).addApp(app);
        break;
        case 'onAppRemoved':
        String packageName = call.arguments;
        Provider.of<InstalledAppsModel>(context, listen: false).removeApp(packageName);
        break;
        default:
        throw MissingPluginException('Not implemented: ${call.method}');
      } 
  });
  const genChannel = MethodChannel('com.hamedaadi.looncher/genReceivers');
  genChannel.setMethodCallHandler((_) async {
      Provider.of<AlarmsModel>(context, listen: false).getAlarm();
  });
}
