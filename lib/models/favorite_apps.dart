import 'dart:typed_data';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../main.dart';

class FavorateApps extends ChangeNotifier {
  Map<String, bool> _apps = {};
  Map<String, bool> get apps => _apps;

  List<Uint8List?> icons = [];

  void update() {
    _apps.clear();
    Apps.getApps();
    for (var i = Apps.appsList.length - 1; i > 0; i--) {
      icons.add(Apps.appsList[i].icon);
      if (_apps[Apps.appsList[i].name!] == true) {
        continue;
      } else {
        _apps[Apps.appsList[i].name!] = false;
      }
    }
  }

  List<String> chosenApps = [];

  void setapps(int index, bool value) async {
    _apps[_apps.keys.elementAt(index)] = value;
    _apps.forEach((key, value) {
      if (value) {
        chosenApps.add(key);
      }
    });
    makeChosenAppsInfo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('chosenApps', chosenApps);
    notifyListeners();
  }

  List _chosenAppsInfo = [];
  List get chosenAppsInfo => _chosenAppsInfo;

  Future<void> makeChosenAppsInfo() async {
    _chosenAppsInfo = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final chosenApps = prefs.getStringList("chosenApps");

    for (var i = chosenApps!.length - 1; i >= 0; i--) {
      for (var j = Apps.appsList.length - 1; j >= 0; j--) {
        if (Apps.appsList[j].name! == chosenApps[i]) {
          _chosenAppsInfo.add(Apps.appsList[j]);
        }
      }
    }
  }
}
