import 'package:flutter/material.dart';

void main() => runApp(BMICalculator());

// 1. ROOT WIDGET: Sets up the main app structure and theme
class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The application title
      title: 'BMI CALCULATOR', 
      
      // The first screen of the app
      home: InputPage(),
      
      // Theme Data for a dark-themed app
      theme: ThemeData(
        // Primary Color (0xFF0A0B21 - very dark grey/black)
        primaryColor: Color(0xFF0A0B21), 
        
        // Background Color for Scaffolds
        scaffoldBackgroundColor: Color(0xFF0A0B21),

        // Text Theme: Sets default text color to white for visibility
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),

        // Modern way to set up a dark color scheme
        colorScheme: ColorScheme.dark().copyWith(
          primary: Color(0xFF0A0B21),
        ),
      ),
    );
  }
}

// 2. INPUT PAGE WIDGET: A StatefulWidget for the main screen UI
// (This would typically be in 'input_page.dart')
class InputPage extends StatefulWidget {
  @override
  // Creates the mutable state for the widget
  _InputPageState createState() => _InputPageState();
}

// 3. STATE CLASS: Builds the UI for the InputPage
class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the screen structure
    return Scaffold(
      appBar: AppBar(
        // Use the defined primary color for the AppBar background
        backgroundColor: Theme.of(context).primaryColor, 
        title: Text('BMI CALCULATOR'),
      ),
      body: Center(
        child: Text(
          'Body Text', // Placeholder text matching the emulator image
          style: TextStyle(fontSize: 24.0), // Example style
        ),
      ),
    );
  }
}