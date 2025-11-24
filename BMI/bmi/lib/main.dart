import 'package:flutter/material.dart';

// --- CONSTANTS ---
// Hex color for the input cards
const Color kActiveCardColor = Color(0xFF1D1E33); 
// Hex color for the bottom calculation button
const Color kBottomContainerColor = Color(0xFFEB1555); 
const Color kPrimaryColor = Color(0xFF0A0B21); 

const double kBottomContainerHeight = 80.0;
const double kCardMargin = 15.0;
const double kCardBorderRadius = 10.0;

void main() => runApp(const BMICalculator());

// 1. ROOT WIDGET: Sets up the main app structure and dark theme
class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI CALCULATOR',
      debugShowCheckedModeBanner: false, 
      home: const InputPage(),
      
      // Theme Data for a dark-themed app
      theme: ThemeData.dark().copyWith(
        // Set the primary background color for Scaffolds
        scaffoldBackgroundColor: kPrimaryColor, 
        
        // Use colorScheme for modern Flutter theming
        colorScheme: const ColorScheme.dark().copyWith(
          primary: kPrimaryColor,
        ),
        
        // Define text styles globally
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        
        // Apply theme to the AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
        )
      ),
    );
  }
}

// 2. INPUT PAGE WIDGET: A StatefulWidget for the main screen UI
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

// 3. STATE CLASS: Builds the UI and layout shown in the emulator images
class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      // The main vertical layout container
      body: Column(
        // Makes children fill the full horizontal space
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: <Widget>[
          // 1. GENDER CARDS (Row of 2)
          const Expanded(
            child: Row(
              children: <Widget>[
                // Male Card
                Expanded(
                  child: RepeatContainerCode(color: kActiveCardColor),
                ), 
                // Female Card
                Expanded(
                  child: RepeatContainerCode(color: kActiveCardColor),
                ),
              ],
            ),
          ), 
          
          // 2. HEIGHT SLIDER CARD (Single Large Card)
          const Expanded(
            child: RepeatContainerCode(color: kActiveCardColor),
          ),
          
          // 3. WEIGHT & AGE CARDS (Row of 2)
          const Expanded(
            child: Row(
              children: <Widget>[
                // Weight Card
                Expanded(
                  child: RepeatContainerCode(color: Color.fromARGB(255, 182, 184, 224)),
                ),
                // Age Card
                Expanded(
                  child: RepeatContainerCode(color: kActiveCardColor),
                ),
              ],
            ),
          ), 
          
          // 4. CALCULATE BUTTON (Bottom Bar)
          Container(
            color: kBottomContainerColor, 
            margin: const EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: kBottomContainerHeight,
            // Example of content for the button:
            // child: const Center(child: Text('CALCULATE', style: TextStyle(fontSize: 25.0))),
          )
        ],
      ), 
    ); 
  }
}

// --- REUSABLE WIDGET ---
// This class name matches the one visible in your uploaded image (image_54f5d5.png).
class RepeatContainerCode extends StatelessWidget {
  const RepeatContainerCode({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kCardMargin),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(kCardBorderRadius),
      ),
    );
  }
}