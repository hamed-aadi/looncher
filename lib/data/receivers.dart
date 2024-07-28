import 'dart:async';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:looncher/data/settings.dart';
import 'package:looncher/data/apps.dart';
import 'package:looncher/data/alarms.dart';

void initializeChangeChannel(context) {
  const channel = MethodChannel('com.hamedaadi.looncher/change');
  
  channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onAppInstalled':
        Map<String, dynamic> app = call.arguments;
        Provider.of<InstalledAppsModel>(context, listen: false).addApp(app);
        break;
        case 'onAppRemoved':
        String packageName = call.arguments;
        Provider.of<InstalledAppsModel>(context, listen: false).removeApp(packageName);
        break;
        case 'airplane':
        Provider.of<GlobalSettingsProvider>(context, listen: false).changeBackground();
        break;
        case "alarmChange":
        Provider.of<AlarmsModel>(context, listen: false).getAlarm();
        break;
        default:
        throw MissingPluginException('Not implemented: ${call.method}');
      } 
  });
}
