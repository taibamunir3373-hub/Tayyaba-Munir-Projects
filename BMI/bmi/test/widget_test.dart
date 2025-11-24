import 'package:flutter/material.dart';

void main() => runApp(const BMICalculator());

// 1. Root Widget: Added the named 'key' parameter
class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key}); // FIX: Added key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI CALCULATOR', 
      home: const InputPage(),
      theme: ThemeData(
        primaryColor: const Color(0xFF0A0B21), 
        scaffoldBackgroundColor: const Color(0xFF0A0B21),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Color(0xFF0A0B21),
        ),
      ),
    );
  }
}

// 2. Input Page Widget: Added the named 'key' parameter
class InputPage extends StatefulWidget {
  const InputPage({super.key}); // FIX: Added key parameter

  @override
  // FIX: Explicitly defined the public return type as State<InputPage>
  State<InputPage> createState() => _InputPageState(); 
}

// 3. State Class: Remains private (correctly prefixed with _)
class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor, 
        title: const Text('BMI CALCULATOR'),
      ),
      body: const Center(
        child: Text(
          'Body Text', 
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}