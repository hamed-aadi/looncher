import 'package:flutter/material.dart';

class You {

  ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Color(0xff111111),
    cardColor: Color(0xff2d2d34),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      onPrimary: Colors.white,
    )
  );

  ThemeData lightTheme = ThemeData(
    cardColor: Color(0xfffffbeb),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      onPrimary: Colors.black,
    )
  );

  BoxDecoration timeTileDecoration(context) => BoxDecoration(
    // color: Theme.of(context).disabledColor,
    borderRadius: BorderRadius.circular(30),
    
  );

  BoxDecoration sliceDecoration(context) => BoxDecoration(
    color: Theme.of(context).canvasColor,
    borderRadius: BorderRadius.circular(5),
    boxShadow: <BoxShadow>[
      BoxShadow(
        offset: Offset(0,1),
        color: Theme.of(context).shadowColor,
        blurRadius: 5,
        spreadRadius: -2,
      )
    ]
  );
  
  final settingsItemDecoration = const BoxDecoration(
  );
  
}
