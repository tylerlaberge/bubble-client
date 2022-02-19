import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData get light => ThemeData.light().copyWith(
      colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.white,
        secondary: Colors.blueGrey
      ),
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
        backgroundColor: Colors.white
      ),
      textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.blueGrey,
          displayColor: Colors.blueGrey,
          fontFamily: "FuzzyBubbles"
      )
  );
}