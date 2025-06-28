import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme({
    double fontSize = 16.0,
    String fontFamily = 'Roboto',
  }) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black87, fontSize: fontSize),
        bodyMedium: TextStyle(color: Colors.black87, fontSize: fontSize - 2),
      ),
    );
  }

  static ThemeData darkTheme({
    double fontSize = 16.0,
    String fontFamily = 'Roboto',
  }) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey[900],
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white70, fontSize: fontSize),
        bodyMedium: TextStyle(color: Colors.white70, fontSize: fontSize - 2),
      ),
    );
  }
}
