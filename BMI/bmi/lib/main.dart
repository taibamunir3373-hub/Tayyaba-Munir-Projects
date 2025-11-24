import 'package:flutter/material.dart';
import 'input_page.dart'; // Imports the main screen structure
import 'constants.dart'; // Imports all color and sizing constants

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI CALCULATOR',
      debugShowCheckedModeBanner: false, 
      home: const InputPage(),
      
      // Theme Data uses constants and dark theme setup
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryColor, 
        colorScheme: const ColorScheme.dark().copyWith(
          primary: kPrimaryColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
        )
      ),
    );
  }
}