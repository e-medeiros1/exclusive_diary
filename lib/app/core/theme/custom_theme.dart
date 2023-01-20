import 'package:flutter/material.dart';

ThemeData customTheme() {
  return ThemeData(
    primaryIconTheme: const IconThemeData(color: Color(0xFF87575C)),
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Color(0xFF87575C)),
    primaryColor: const Color(0xFF87575C),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF0EBE5),
      titleTextStyle: TextStyle(
          fontSize: 18, color: Color(0xFF87575C), fontWeight: FontWeight.bold),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF87575C)),
    ),
    fontFamily: 'Roboto-Regular',
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF87575C),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: -.9,
      ),
      headline6: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.normal,
        letterSpacing: -.9,
      ),
    ),
  );
}
