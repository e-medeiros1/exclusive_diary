import 'package:flutter/material.dart';

ThemeData customTheme() {
  return ThemeData(
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 18,
          color: Color(0xFF000000),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: const Color(0xFF000000),
      ));
}
