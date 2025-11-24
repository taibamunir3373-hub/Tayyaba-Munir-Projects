import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

import 'constants.dart'; // Import colors and sizes
import 'reusable_card.dart'; // Import the RepeatContainerCode widget

// Enum to manage the state of which gender is selected
enum Gender { male, female }

// 2. INPUT PAGE WIDGET
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

// 3. STATE CLASS: Builds the UI and manages state
class _InputPageState extends State<InputPage> {
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
          const Expanded(
            flex: 2, 
            child: RepeatContainerCode(
              color: kActiveCardColor,
            ),
          ),
          
          // 3. CALCULATE BUTTON (Bottom Bar)
          GestureDetector(
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

// Widget to display the icon and text vertically (used for gender cards)
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