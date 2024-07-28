import 'package:flutter/material.dart';

import 'package:looncher/themes/you.dart';

class GlobalSettingsProvider extends ChangeNotifier {

  var theme = You();
  StarBorder clockShape = scallopBorder;
  Color background = Colors.black;

  void changeBackground() {
    if (background == Colors.black) {
      background == Colors.green;
    } else {
      background == Colors.black;
    }
    notifyListeners();
  }
  
  void setTheme(dynamic theme) {
    theme = theme;
    notifyListeners();
  }

  void setClockShape({required bool scallop}) {
    clockShape = (scallop ? scallopBorder : octagonBorder);
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

