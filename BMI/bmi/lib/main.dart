import 'package:flutter/material.dart';

// --- CONSTANTS ---
// Hex color for the input cards
const Color activeCardColor = Color(0xFF1D1E33); 
// Hex color for the bottom calculation button
const Color bottomContainerColor = Color(0xFFEB1555); 
const double bottomContainerHeight = 80.0;

void main() => runApp(const BMICalculator());

// 1. ROOT WIDGET: Sets up the main app structure and dark theme
class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI CALCULATOR',
      // Removes the "DEBUG" banner in the corner
      debugShowCheckedModeBanner: false, 
      
      // The first screen of the app
      home: const InputPage(),
      
      // Theme Data for a dark-themed app
      theme: ThemeData(
        // Primary Color (0xFF0A0B21 - very dark grey/black)
        primaryColor: const Color(0xFF0A0B21), 
        
        // Background Color for Scaffolds
        scaffoldBackgroundColor: const Color(0xFF0A0B21),

        // Text Theme: Sets default text color to white for visibility
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),

        // Modern way to set up a dark color scheme
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFF0A0B21),
        ),
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
        // Use the defined primary color for the AppBar background
        backgroundColor: Theme.of(context).primaryColor, 
        title: const Text('BMI CALCULATOR'),
      ),
      // The main vertical layout container
      body: Column(
        // Makes children fill the full horizontal space
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: <Widget>[
          // 1. GENDER CARDS (Row of 2)
          Expanded(
            child: Row(
              children: const <Widget>[
                // Male Card
                Expanded(
                  child: CardContainer(color: activeCardColor),
                ), 
                // Female Card
                Expanded(
                  child: CardContainer(color: activeCardColor),
                ),
              ],
            ),
          ), 
          
          // 2. HEIGHT SLIDER CARD (Single Large Card)
          const Expanded(
            child: CardContainer(color: activeCardColor),
          ),
          
          // 3. WEIGHT & AGE CARDS (Row of 2)
          Expanded(
            child: Row(
              children: const <Widget>[
                // Weight Card
                Expanded(
                  child: CardContainer(color: activeCardColor),
                ),
                // Age Card
                Expanded(
                  child: CardContainer(color: activeCardColor),
                ),
              ],
            ),
          ), 
          
          // 4. CALCULATE BUTTON (Bottom Bar)
          Container(
            color: bottomContainerColor, 
            margin: const EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: bottomContainerHeight,
            // You would typically add a Text widget here:
            // child: const Center(child: Text('CALCULATE', style: TextStyle(fontSize: 25.0))),
          )
        ],
      ), 
    ); 
  }
}

// --- REUSABLE WIDGET ---
// A custom StatelessWidget to represent the reusable card containers
class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}