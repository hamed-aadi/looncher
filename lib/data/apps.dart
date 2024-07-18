import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:typed_data';

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

  static List<App> genApps(List<dynamic> appslist) {
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
  
}

class DeviceApps {
  static const platform = MethodChannel('com.hamedaadi.looncher/apps');

  Future<List<App>> getApps() async {
    return App.genApps(
      await platform.invokeMethod('getApps')
    );
  }

  Future<void> openApp(String package) async {
    await platform.invokeMethod("openApp", {"package_name": package});
  }

  Future<void> uninstallApp(String package) async {
    await platform.invokeMethod("uninstallApp", {"package_name": package});
  }

  Future<void> forceUninstallApp(String package) async {
    await platform.invokeMethod("forceUninstallApp", {"package_name": package});
  }

  Future<void> openAppSettings(String package) async {
    await platform.invokeMethod("openAppSettings", {"package_name": package});
  }
  
}
