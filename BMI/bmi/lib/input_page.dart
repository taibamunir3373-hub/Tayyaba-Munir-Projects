import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

import 'constants.dart'; 
import 'reusable_card.dart'; 

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
            flex: 2, 
            child: Row(
              children: <Widget>[
                // Male Card
                Expanded(
                  child: RepeatContainerCode(
                    color: kActiveCardColor,
                    // Note: Interaction logic is omitted here to match the static screenshot visual, 
                    // but the structure is correct. We'll leave the color logic for now.
                    // To re-enable color change, use the selectedGender state check here.
                    cardChild: const IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ), 
                // Female Card
                Expanded(
                  child: RepeatContainerCode(
                    color: kActiveCardColor,
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
          
          // --- CALCULATE BUTTON REMOVED FROM HERE ---
          // The GestureDetector and Container that formed the button are gone.
          
        ],
      ), 
    ); 
  }
}

// IconContent widget (Remains unchanged)
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