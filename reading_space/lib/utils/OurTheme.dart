import 'package:flutter/material.dart';

class OurTheme {
  Color lightGreen = Color.fromARGB(255, 213, 235, 220);
  Color lightGrey = Color.fromARGB(255, 164, 164, 164);
  Color darkerGrey = Color.fromARGB(255, 119, 124, 135);
  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: lightGreen,
      primaryColor: lightGreen,
      accentColor: lightGrey,
      secondaryHeaderColor: darkerGrey,
      hintColor: lightGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: lightGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: lightGreen,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          side: BorderSide(width: 2.0, color: Colors.black26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
  }
}
