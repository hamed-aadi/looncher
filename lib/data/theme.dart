import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<ThemeData> loadTheme(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? wallpaperPath;

  wallpaperPath = prefs.getString('wallpaperPath');
  if (wallpaperPath != null) {
    return ThemeData.from(
      colorScheme: await colorsFromImage(FileImage(File(wallpaperPath!)), brightness),
    );
  } else {
    return themeFromColor(
      Color(prefs.getInt('Maincolor') ?? Colors.blue.value),
      brightness
    );
  }
}

ThemeData themeFromColor(Color color, Brightness brightness) {
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(seedColor: color, brightness: brightness),
    useMaterial3: true,
  );
}

Future<ColorScheme> colorsFromImage(ImageProvider image, Brightness brightness) async {
  return ColorScheme.fromImageProvider(
    provider: image,
    brightness: brightness,
  );
}

