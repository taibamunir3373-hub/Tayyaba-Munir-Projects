import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E16),
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text("Settings & Profile Coming Soon", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}