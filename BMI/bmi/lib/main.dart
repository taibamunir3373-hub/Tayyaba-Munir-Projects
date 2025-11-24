import 'package:flutter/material.dart';
// Note: This package must be included in your pubspec.yaml file
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

// --- CONSTANTS & STYLING ---
// Theme Colors
const Color kPrimaryColor = Color(0xFF0A0B21);        // Main background color (very dark)
const Color kActiveCardColor = Color(0xFF1D1E33);     // Color for selected/active cards
const Color kInactiveCardColor = Color(0xFF111328);   // Color for unselected cards
const Color kBottomContainerColor = Color(0xFFEB1555); // Pink color for the button

// Sizing Constants
const double kBottomContainerHeight = 80.0;
const double kCardMargin = 15.0;
const double kCardBorderRadius = 10.0;
const double kIconSize = 80.0;

const SizedBox kHeightSpacer = SizedBox(height: 15.0);

// Text Styles
const TextStyle kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98), 
);
// ----------------------------

// Enum to manage the state of which gender is selected
enum Gender { male, female }

void main() => runApp(const BMICalculator());

// 1. ROOT WIDGET: Sets up the main app structure and theme
class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI CALCULATOR',
      debugShowCheckedModeBanner: false, 
      home: const InputPage(),
      
      // Theme Data for the entire application (Dark Theme)
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

// 2. INPUT PAGE WIDGET (Stateful for managing selections)
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

// 3. STATE CLASS: Builds the UI and manages state
class _InputPageState extends State<InputPage> {
  // Tracks the currently selected gender
  Gender? selectedGender; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: <Widget>[
          // 1. GENDER CARDS (Row of 2)
          Expanded(
            child: Row(
              children: <Widget>[
                // Male Card
                Expanded(
                  child: RepeatContainerCode(
                    // Color changes based on whether 'male' is selected
                    color: selectedGender == Gender.male ? kActiveCardColor : kInactiveCardColor,
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    cardChild: const IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ), 
                // Female Card
                Expanded(
                  child: RepeatContainerCode(
                    // Color changes based on whether 'female' is selected
                    color: selectedGender == Gender.female ? kActiveCardColor : kInactiveCardColor,
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    cardChild: const IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
          ), 
          
          // 2. Placeholder for the rest of the inputs (Height/Weight/Age)
          // Occupies the rest of the available vertical space
          const Expanded(
            flex: 2, 
            child: RepeatContainerCode(
              color: kActiveCardColor,
              // cardChild: Placeholder for Height/Weight/Age content
            ),
          ),
          
          // 3. CALCULATE BUTTON (Bottom Bar)
          GestureDetector(
            // Placeholder for navigation/calculation logic
            child: Container(
              color: kBottomContainerColor, 
              margin: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: kBottomContainerHeight,
              child: const Center(
                child: Text(
                  'CALCULATE YOUR BMI', 
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ), 
    ); 
  }
}

// --- REUSABLE WIDGETS ---

// Widget to display the icon and text vertically in the gender cards
class IconContent extends StatelessWidget {
  const IconContent({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FaIcon(
          icon,
          size: kIconSize,
          color: Colors.white,
        ),
        kHeightSpacer, 
        Text(
          label,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}

// Reusable card container (The dark boxes for all inputs)
class RepeatContainerCode extends StatelessWidget {
  const RepeatContainerCode({super.key, required this.color, this.cardChild, this.onPress});

  final Color color;
  final Widget? cardChild;
  final VoidCallback? onPress; // Used for tap detection on the gender cards

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress, 
      child: Container(
        margin: const EdgeInsets.all(kCardMargin),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kCardBorderRadius),
        ),
        child: cardChild,
      ),
    );
  }
}