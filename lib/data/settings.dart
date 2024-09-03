import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:looncher/data/apps.dart';
import 'package:looncher/data/theme.dart';
import 'package:looncher/widgets/view.dart';
import 'package:looncher/widgets/view_apps.dart';
import 'package:looncher/widgets/view_callendar.dart';

class MainProvider with ChangeNotifier {
  
  ThemeData lightTheme;
  ThemeData darkTheme;

  MainProvider(this.lightTheme, this.darkTheme);
  
  void setcolorScheme(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lightTheme = themeFromColor(color, Brightness.light);
    darkTheme = themeFromColor(color, Brightness.dark);
    notifyListeners();
    prefs.setInt('Maincolor', color.value);
    prefs.setBool("isWallpaperScheme", false);
  }

  void setWallpaperColorScheme(String wallPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lightTheme = ThemeData.from(
      colorScheme: await colorsFromImage(FileImage(File(wallPath)), Brightness.light),
    );
    darkTheme = ThemeData.from(
      colorScheme: await colorsFromImage(FileImage(File(wallPath)), Brightness.dark),
    );
    notifyListeners();
    prefs.setString("wallpaperPath", wallPath);
  }
}

class SettingsProvider extends ChangeNotifier {

  StarBorder clockShape = scallopBorder;
  double iconSize = 90;  //90 to 140
  
  void setClockShape(StarBorder shape, String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clockShape = shape;
    notifyListeners();
    prefs.setString('clockShape', s);
  }

  void setIconSize(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    iconSize = size;
    notifyListeners();
    prefs.setDouble("iconSize", size);
  }

  Widget upSlice = const CalendarSlice();
  Widget downSlice = const AppsSlice(Axis.horizontal);
  Widget leftSlice = emptySlice;
  Widget rightSlice = emptySlice;

  Widget upPage = const CalendarPage(Axis.horizontal);
  Widget downPage = AppsPage(Axis.horizontal);
  Widget leftPage = emptyPage;
  Widget rightPage = emptyPage;

  void assignView(Widget slice, Widget page, String view, Axis axis) async {
    setView(slice, page, view, axis);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    prefs.setString(view, slice.toString());
  }
  
  List<App> mainApps = [];

  void setMainApps(int oldIndex, int newIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final App item = mainApps.removeAt(oldIndex);
    mainApps.insert(newIndex, item);
    notifyListeners();
    prefs.setStringList(
      'mainApps',
      List<String>.generate(
        mainApps.length,
        (int index) => mainApps[index].packageName)
    );
  }

  void addApp(App app) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mainApps.contains(app)) return;
    mainApps.add(app);
    notifyListeners();
    prefs.setStringList(
      'mainApps',
      List<String>.generate(
        mainApps.length,
        (int index) => mainApps[index].packageName)
    );
  }

  void removeApp(App app) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mainApps.remove(app);
    notifyListeners();
    prefs.setStringList(
      'mainApps',
      List<String>.generate(
        mainApps.length,
        (int index) => mainApps[index].packageName)
    );
  }
  
  Future<void> loadSettings(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    iconSize = prefs.getDouble('iconSize') ?? 90;
    clockShape = parseBorder(prefs.getString('clockShape'));

    List<String> _mainApps = prefs.getStringList('mainApps') ?? [];
    mainApps = List<App>.generate(
      _mainApps.length,
      (int index) {
        return Provider.of<InstalledAppsModel>(context, listen: false).appFromDevice(_mainApps[index]);
      },
    );
    
    setView(leftSlice , leftPage , prefs.getString('leftView') , Axis.vertical);
    setView(rightSlice, rightPage, prefs.getString('rightView'), Axis.vertical);
    setView(upSlice   , upPage   , prefs.getString('upView')   , Axis.horizontal);
    setView(downSlice , downPage , prefs.getString('downView') , Axis.horizontal);

    notifyListeners();
  }

  void setView(Widget slice, Widget page, String? view, Axis axis) {
    switch (view) {
      case 'apps':
      slice = AppsSlice(axis);
      page = AppsPage(axis);
      break;
      case 'calendar':
      slice = CalendarSlice();
      page = CalendarPage(axis);
      default:
      slice = emptySlice;
      page = emptyPage;
    }
  }
  
}

StarBorder parseBorder(String? border) {
  switch (border) {
    case 'octagon':
    return octagonBorder;
    case 'scallop':
    return scallopBorder;
    case 'circle':
    return circleBorder;
    case 'square':
    return squareBorder;
    default:
    return octagonBorder;
  }
}
  
BaseSlice emptySlice = const BaseSlice(Axis.vertical, Text("empty"));
BasePage emptyPage = const BasePage(
  reverseAxis: Axis.horizontal,
  child: Center(child: Text("empty"))
);

StarBorder octagonBorder = const StarBorder.polygon(
  sides: 8.00            , rotation: 0.00,
  pointRounding: 0.32    , squash: 0.00,
);

StarBorder scallopBorder = const StarBorder(
  points: 12.00          , rotation: 0,
  innerRadiusRatio: 0.90 , pointRounding: 0.50,
  valleyRounding: 0.50   , squash: 0.00,
);

StarBorder circleBorder = const StarBorder(
  points: 5.00           , rotation: 0.00,
  innerRadiusRatio: 1.00 , pointRounding: 0.50,
  valleyRounding: 0.50   , squash: 0.00,
);

StarBorder squareBorder = const StarBorder(
  points: 4.0            , rotation: 45.0,
  innerRadiusRatio: 0.75 , pointRounding: 0.50,
  valleyRounding: 0.50   , squash: 0.00,
);
