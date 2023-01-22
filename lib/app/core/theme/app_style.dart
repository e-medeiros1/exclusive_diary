import 'package:flutter/material.dart';

class AppStyle {
  static const backgroundColor = Color(0xFFF0EBE5);
  static const primaryColor = Color(0xFF87575C);
  static const secondaryColor = Color(0xFFD1DFBB);

  static List<Color> notesColor = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.yellow.shade100,
    Colors.blueGrey.shade100,
    Colors.orange.shade100,
  ];

  static AppBarTheme themeAppBar = AppBarTheme(
    elevation: 0,
    backgroundColor: backgroundColor,
    iconTheme: const IconThemeData(color: primaryColor),
    titleTextStyle: mainText.copyWith(fontSize: 20),
  );

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
