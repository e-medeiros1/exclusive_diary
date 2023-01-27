import 'package:flutter/material.dart';

class AppStyle {
  static const backgroundColor = Color(0xFFF0EBE5);
  static const primaryColor = Color(0xFF87575C);
  static const secondaryColor = Color(0xFFD1DFBB);

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
