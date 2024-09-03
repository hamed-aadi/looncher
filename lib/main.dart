import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:looncher/data/theme.dart';
import 'package:looncher/data/settings.dart';
import 'package:looncher/data/alarms.dart';
import 'package:looncher/data/apps.dart';
import 'package:looncher/page_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final light = await loadTheme(Brightness.light);
  final dark = await loadTheme(Brightness.dark);
  final apps = await getApps();
  initializeDateFormatting().then((_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider(light, dark)),
          ChangeNotifierProvider<InstalledAppsModel>(create: (_) => InstalledAppsModel(apps)),
          ChangeNotifierProvider<SettingsProvider>(create: (context) => SettingsProvider()..loadSettings(context)),
          ChangeNotifierProvider<AlarmsModel>(create: (_) => AlarmsModel()),
        ],
        child: Launcher(),
      )
    )
  );
}

class Launcher extends StatefulWidget {
  const Launcher({super.key});

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {

  @override
  void initState() {
    super.initState();
    initReceivers(context);
  }

  @override
  Widget build(BuildContext context) {
    final main = Provider.of<MainProvider>(context);
    return MaterialApp(
      theme: main.lightTheme,
      darkTheme: main.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
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
