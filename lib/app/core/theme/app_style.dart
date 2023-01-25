import 'package:flutter/material.dart';

class AppStyle {
  static const backgroundColor = Color(0xFFF0EBE5);
  static const primaryColor = Color(0xFF87575C);
  static const secondaryColor = Color(0xFFD1DFBB);

  static List<Color> notesColor = [
    const Color(0xFFfabfb7),
    const Color(0xFFfdf9c4),
    const Color(0xFFffda9e),
    const Color(0xFFb2e2f2),
    const Color(0xFFcce5ff),
    const Color(0xFFeaffc2),
    const Color(0xFFb8e4ff),
    const Color(0xFFffe180),
    const Color(0xFFfdcae1),
  ];

  static AppBarTheme themeAppBar = AppBarTheme(
      elevation: 0,
      backgroundColor: backgroundColor,
      iconTheme: const IconThemeData(color: primaryColor),
      titleTextStyle: mainText.copyWith(fontSize: 20),
      centerTitle: true);

  static TextStyle regularText = const TextStyle(
    color: primaryColor,
    fontFamily: 'Roboto',
    fontSize: 17,
    letterSpacing: -.9,
  );

  static TextStyle mainText = const TextStyle(
    color: primaryColor,
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: -.9,
  );
}
