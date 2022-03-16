import 'package:effio/core/styles/palette.dart';
import 'package:flutter/material.dart';

class EffioTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      primary: generateMaterialColor(Palette.primary),
      onPrimary: Colors.white,
      primaryContainer: Colors.white,
      background: generateMaterialColor(Palette.primary),
      onBackground: Colors.white,
      secondary: generateMaterialColor(Palette.accentColor),
      onSecondary: Colors.black,
      secondaryContainer: generateMaterialColor(Palette.accentColor),
      error: Colors.black,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(elevation: 0),
    scaffoldBackgroundColor: Palette.primary,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.blue),
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            style: BorderStyle.solid,
            color: generateMaterialColor(Palette.accentColor)),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.white,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      floatingLabelStyle: const TextStyle(color: Colors.white),
      // border: const OutlineInputBorder(
      //   borderSide: BorderSide(color: Colors.white, width: 0.0),
      // ),
      // enabledBorder: const OutlineInputBorder(
      //   borderSide: BorderSide(color: Colors.white, width: 0.0),
      // ),
    ),
  );
}
