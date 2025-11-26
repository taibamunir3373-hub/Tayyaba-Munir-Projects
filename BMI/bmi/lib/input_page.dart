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
  // State variable using the Gender enum
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
            flex: 2, 
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
          
          // 2. HEIGHT CARD (Single Large Card)
          const Expanded(
            flex: 2, 
            child: RepeatContainerCode(
              color: kActiveCardColor,
            ),
          ),
          
          // 3. WEIGHT & AGE CARDS (Row of 2)
          const Expanded(
            flex: 2, 
            child: Row(
              children: <Widget>[
                // Weight Card
                Expanded(
                  child: RepeatContainerCode(color: kActiveCardColor),
                ),
                // Age Card
                Expanded(
                  child: RepeatContainerCode(color: kActiveCardColor),
                ),
              ],
            ),
          ),
          
          // The CALCULATE BUTTON is intentionally excluded here.
        ],
      ), 
    ); 
  }
}

// IconContent widget
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