import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      );

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      );
}
