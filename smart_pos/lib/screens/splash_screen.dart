import 'package:flutter/material.dart';
import 'dart:async'; // For Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  // Error Fixed: Missing type annotation added
  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {}); 
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon (Replace with your actual icon)
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.storefront, size: 70, color: Colors.blueAccent), // Example Icon
            ),
            const SizedBox(height: 30),
            const Text(
              "Smart POS",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E), // Dark text color
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Manage. Sell. Grow.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 50),
            // Loading Bar (Visual effect)
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 150),
            const Text(
              "Full Inventory Management",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}