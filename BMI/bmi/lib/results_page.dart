import 'package:flutter/material.dart';
import 'constants.dart';
import 'reusable_card.dart';

class ResultsPage extends StatelessWidget {
  // Define final properties to hold the received data
  final String bmiResult;
  final String resultText;
  final String interpretation;

  // Update the constructor to require the data
  const ResultsPage({
    super.key, 
    required this.bmiResult, 
    required this.resultText, 
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        // MainAxisAlignment.spaceEvenly gives nice spacing as per design
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1. YOUR RESULT Header
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Your Result',
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          
          // 2. MAIN RESULT CARD
          Expanded(
            flex: 5,
            child: RepeatContainerCode(
              color: kActiveCardColor, // Should be defined in constants.dart
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Result Status Text (NORMAL, OVERWEIGHT, etc.)
                  Text(
                    resultText.toUpperCase(), // Use received result text
                    style: const TextStyle(
                      // Green color for 'NORMAL' or a general status color
                      color: Color(0xFF24D876), 
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  // BMI Score Number
                  Text(
                    bmiResult, // Use received BMI number (e.g., '18.3')
                    style: kNumberTextStyle.copyWith(fontSize: 100.0), // Large font size
                  ),
                  
                  // Interpretation Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      interpretation, // Use received interpretation
                      textAlign: TextAlign.center,
                      style: kLabelTextStyle, // Should be defined in constants.dart
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 3. RE-CALCULATE Button
          GestureDetector(
            onTap: () {
              // Navigator.pop returns the user to the InputPage
              Navigator.pop(context); 
            },
            child: Container(
              color: kBottomContainerColor, // Should be defined in constants.dart
              width: double.infinity,
              height: kBottomContainerHeight, // Should be defined in constants.dart
              margin: const EdgeInsets.only(top: 10.0),
              child: const Center(
                child: Text(
                  'RE-CALCULATE',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}