import 'package:flutter/material.dart';

import 'color_palettes.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: ColorPalettes.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorPalettes.lightAccent),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: ColorPalettes.blackTextColor,
        fontSize: 20.0,
      ),
      bodyMedium: TextStyle(
        color: ColorPalettes.secondaryColor,
        fontSize: 18.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorPalettes.lightAccent),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: ColorPalettes.white,
        fontSize: 20.0,
      ),
      bodyMedium: TextStyle(
        color: ColorPalettes.secondaryColor,
        fontSize: 18.0,
      ),
    ),
  );
}
