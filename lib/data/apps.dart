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
  
  @override
  bool operator ==(covariant App other) {
    if (identical(this, other)) return true;
    return name == other.name &&
           packageName == other.packageName;
  }
}

Future<List<App>> getApps() async {
  return _genApps(
    await appsChannel.invokeMethod('getApps')
  );
}

class InstalledAppsModel extends ChangeNotifier {

  List<App> deviceApps;
  
  InstalledAppsModel(this.deviceApps);
  
  void removeApp(String package) {
    uninstallApp(package);
    deviceApps.removeWhere((app) => app.packageName == package);
    notifyListeners();
  }

  App appFromDevice(String package) {
    return deviceApps.singleWhere((element) => element.packageName == package);
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

Future<App> appFromPackage(String package) async {
  return await appsChannel.invokeMethod("appFromPackage", {"package_name": package});
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
