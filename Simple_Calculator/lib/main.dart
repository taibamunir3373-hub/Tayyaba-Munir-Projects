import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String output = "0";
  String input = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        input = "";
        output = "0";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (text == "+" || text == "-" || text == "×" || text == "÷") {
        num1 = double.tryParse(input) ?? 0;
        operand = text;
        input = "";
      } else if (text == "=") {
        num2 = double.tryParse(input) ?? 0;
        if (operand == "+") {
          output = (num1 + num2).toString();
        } else if (operand == "-") {
          output = (num1 - num2).toString();
        } else if (operand == "×") {
          output = (num1 * num2).toString();
        } else if (operand == "÷") {
          if (num2 != 0) {
            output = (num1 / num2).toString();
          } else {
            output = "Error";
          }
        }
        input = output;
      } else {
        input += text;
        output = input;
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                output,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("÷"),
            ],
          ),
          Row(
            children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("×"),
            ],
          ),
          Row(
            children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ],
          ),
          Row(
            children: [
              buildButton("0"),
              buildButton("C"),
              buildButton("="),
              buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }
}
