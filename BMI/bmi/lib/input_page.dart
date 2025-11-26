import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

import 'constants.dart'; 
import 'reusable_card.dart'; 

// Enum for state management
enum Gender { male, female }

// 2. INPUT PAGE WIDGET
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

// 3. STATE CLASS: Builds the UI and manages state
class _InputPageState extends State<InputPage> {
  // State variables
  Gender? selectedGender; 
  int height = 180; // Default height in cm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      // FIX: SingleChildScrollView handles overflow
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: <Widget>[
            // 1. GENDER CARDS (Row of 2)
            SizedBox(
              height: 200, 
              child: Row(
                children: <Widget>[
                  // Male Card
                  Expanded(
                    child: RepeatContainerCode(
                      // Ternary Operator for color
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
                      // Ternary Operator for color
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
            
            // 2. HEIGHT CARD (Single Large Card with Slider)
            SizedBox(
              height: 250, 
              child: RepeatContainerCode(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic, 
                      children: <Widget>[
                        Text(
                          height.toString(), 
                          style: kNumberTextStyle, 
                        ),
                        const Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: const Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: const Color(0xFFEB1555), 
                        overlayColor: const Color(0x29EB1555), 
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0, 
                        max: 220.0, 
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round(); 
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // 3. WEIGHT & AGE CARDS (Row of 2)
            SizedBox(
              height: 200, 
              child: Row(
                children: <Widget>[
                  // Weight Card
                  Expanded(
                    child: RepeatContainerCode(
                      color: kActiveCardColor,
                      // === ADDED WEIGHT CONTENT HERE ===
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          const Text(
                            '60', // Placeholder weight value
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Age Card
                  Expanded(
                    child: RepeatContainerCode(
                      color: kActiveCardColor,
                      // === ADDED AGE CONTENT HERE ===
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'AGE',
                            style: kLabelTextStyle,
                          ),
                          const Text(
                            '19', // Placeholder age value
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Add a small spacer at the bottom
            const SizedBox(height: 10.0), 
          ],
        ),
      ), 
    ); 
  }
}

// IconContent widget (Remains the same)
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