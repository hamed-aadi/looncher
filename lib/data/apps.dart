import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App {
  String name;
  String packageName;
  int category;
  String version;
  Uint8List? icon;

  App({
      required this.name,
      required this.packageName,
      required this.category,
      required this.version,
      required this.icon,
  });
}

class InstalledAppsModel extends ChangeNotifier {
  
  List<App> deviceApps = [];
  
  Future<void> getApps() async {
    deviceApps = _genApps(
      await appsChannel.invokeMethod('getApps')
    );
    notifyListeners();
  }
  
  void removeApp(String package) {
    deviceApps.removeWhere((app) => app.packageName == package);
    notifyListeners();
  }

  void addApp(Map app) {
    deviceApps
    ..add(App(
        name: app["name"],
        packageName: app["package_name"],
        category: app["category"],
        version: app["version"] ?? "nil",
        icon: app["icon"],
    ))
    ..sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }
}

const appsChannel =  MethodChannel('com.hamedaadi.looncher/apps');

List<App> _genApps(List<dynamic> appslist) {
  return appslist.map((app) => App(
      name: app["name"],
      packageName: app["package_name"],
      category: app["category"],
      version: app["version"] ?? "nil",
      icon: app["icon"],
  ))
  .toList()
  ..sort((a, b) => a.name.compareTo(b.name));
}

Future<void> uninstallApp(String package) async {
  await appsChannel.invokeMethod("uninstallApp", {"package_name": package});
}

Future<void> openApp(String package) async {
  await appsChannel.invokeMethod("openApp", {"package_name": package});
}

Future<void> openAppSettings(String package) async {
  await appsChannel.invokeMethod("openAppSettings", {"package_name": package});
}
