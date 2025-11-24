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
 // Assumes this code is inside the build method of the _InputPageState class:
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('BMI CALCULATOR'),
    ),
    // The main vertical layout container
    body: Column(
      children: <Widget>[
        // First Expanded Widget (takes up proportional vertical space)
        Expanded(
          child: Row(
            // The row divides this vertical space horizontally
            children: <Widget>[
              // First Expanded Widget in the Row (takes up half the horizontal space)
              Expanded(
                child: Container( // Using Container instead of null to hold UI
                  // In the full app, this will likely hold the Male gender card
                  // The image code showed 'child: null', but we use a Container
                  // to demonstrate where the content goes.
                ),
              ), // // Expanded

              // Second Expanded Widget in the Row (takes up the other half)
              Expanded(
                child: Container( // Using Container instead of null to hold UI
                  // In the full app, this will likely hold the Female gender card
                ),
              ), // // Expanded
            ],
          ), // // Row
        ), // // Expanded

        // The image snippet implies there are more Expanded widgets below 
        // to take up the rest of the vertical space (e.g., for Height, Weight, Age).

        // Placeholder for the remaining Expanded sections (not fully visible):
        // Expanded(
        //   child: Container(), // For the height slider card
        // ),
        // Expanded(
        //   child: Row(
        //     children: <Widget>[
        //       Expanded(child: Container()), // For the weight card
        //       Expanded(child: Container()), // For the age card
        //     ],
        //   ),
        // ),
        // Container(
        //   height: 80.0, // For the bottom calculate button
        // )
      ],
    ), // // Column
  ); // // Scaffold
}
  }