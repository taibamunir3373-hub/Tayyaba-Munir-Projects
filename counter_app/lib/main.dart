import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Counter App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterHome(),
    );
  }
}

class CounterHome extends StatefulWidget {
  const CounterHome({super.key});

  @override
  State<CounterHome> createState() => _CounterHomeState();
}

class _CounterHomeState extends State<CounterHome> {
  final TextEditingController _controller = TextEditingController();
  double _number = 0;

  // Set number from input
  void _setNumber() {
    setState(() {
      _number = double.tryParse(_controller.text) ?? 0;
    });
  }

  // Increment
  void _increment() {
    setState(() {
      _number++;
    });
  }

  // Decrement
  void _decrement() {
    setState(() {
      _number--;
    });
  }

  // Clear
  void _clear() {
    setState(() {
      _number = 0;
      _controller.clear();
    });
  }

  // Double
  void _doubleNumber() {
    setState(() {
      _number *= 2;
    });
  }

  // Square Root
  void _squareRoot() {
    setState(() {
      if (_number >= 0) {
        _number = sqrt(_number);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Counter App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Field
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter a number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _setNumber(),
            ),
            const SizedBox(height: 20),

            // Display number
            Text(
              "Current Number: $_number",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Buttons
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _setNumber,
                  child: const Text("Set"),
                ),
                ElevatedButton(
                  onPressed: _increment,
                  child: const Text("Increment"),
                ),
                ElevatedButton(
                  onPressed: _decrement,
                  child: const Text("Decrement"),
                ),
                ElevatedButton(
                  onPressed: _clear,
                  child: const Text("Clear"),
                ),
                ElevatedButton(
                  onPressed: _doubleNumber,
                  child: const Text("Double"),
                ),
                ElevatedButton(
                  onPressed: _squareRoot,
                  child: const Text("Square Root"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
