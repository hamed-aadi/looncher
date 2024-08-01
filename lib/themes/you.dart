import 'package:flutter/material.dart';

class You {

  ThemeData darkTheme = ThemeData(
    cardColor: Color(0xff3e3e3e),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark()
  );

  ThemeData lightTheme = ThemeData(
    cardColor: Color(0xfffffbeb),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light()
  );

  BoxDecoration timeTileDecoration(context) => BoxDecoration(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(30)
  );

  final appRowDecoration = BoxDecoration(
    color: Color(0xff3e3e3e),
    borderRadius: BorderRadius.circular(10)
  );
  
  final buttonDecoration = BoxDecoration(
    color: Colors.orange,
    borderRadius: BorderRadius.circular(10)
  );

  final settingsItemDecoration = const BoxDecoration(
    
  );
  
}
