import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E16),
      appBar: AppBar(
        title: const Text("Products", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
      ),
      body: const Center(child: Text("Product List Coming Soon", style: TextStyle(color: Colors.white))),
    );
  }
}