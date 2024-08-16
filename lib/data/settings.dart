import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:looncher/themes/you.dart';
import 'package:looncher/data/apps.dart';
import 'package:looncher/widgets/view_apps.dart';

class SettingsProvider extends ChangeNotifier {
  
  var theme = You();
  StarBorder clockShape = scallopBorder;
  
  // void setTheme(dynamic theme) {
  //   theme = theme;
  //   notifyListeners();
  // }

  void setClockShape({required bool scallop}) {
    clockShape = (scallop ? scallopBorder : octagonBorder);
    // presist
    notifyListeners();
  }

  Widget upSlice = const AppsSlice(Axis.horizontal);
  Widget downSlice = const AppsSlice(Axis.horizontal);
  Widget leftSlice = const AppsSlice(Axis.vertical);
  Widget rightSlice = const AppsSlice(Axis.vertical);

  Widget upPage   = const AppsPage(MainAxisAlignment.start);
  Widget downPage = const AppsPage(MainAxisAlignment.end);
  Widget leftPage = const AppsPage(MainAxisAlignment.start);
  Widget rightPage= const AppsPage(MainAxisAlignment.end);
  
  List<App> mainApps = [];

  void addApp(App app) {
    mainApps.add(app);
    notifyListeners();
  }

  void removeApp(App app) {
    mainApps.remove(app);
    notifyListeners();
  }
  
}

StarBorder scallopBorder = const StarBorder(
  points: 12.00          , rotation: 0,
  innerRadiusRatio: 0.90 , pointRounding: 0.50,
  valleyRounding: 0.50   , squash: 0.00,
);

StarBorder octagonBorder = const StarBorder.polygon(
  sides: 8.00         , rotation: 0.00,
  pointRounding: 0.32 , squash: 0.00,
);

