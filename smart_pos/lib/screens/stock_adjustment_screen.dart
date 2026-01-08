import 'package:flutter/material.dart';

class StockAdjustmentScreen extends StatefulWidget {
  const StockAdjustmentScreen({super.key});

  @override
  State<StockAdjustmentScreen> createState() => _StockAdjustmentScreenState();
}

class _StockAdjustmentScreenState extends State<StockAdjustmentScreen> {
  int quantity = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E16),
      appBar: AppBar(
        title: const Text("Stock Adjustment", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.history, color: Colors.white), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                // Error Fixed: withValues used instead of withOpacity
                color: Colors.white.withValues(alpha: 0.05), 
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.headphones, color: Colors.white, size: 40)),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Wireless Headphones", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("SKU: WH-001-BLK", style: TextStyle(color: Colors.white54, fontSize: 12)),
                        SizedBox(height: 5),
                        Text("Current: 142", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                _toggleButton("Stock In", true),
                const SizedBox(width: 10),
                _toggleButton("Stock Out", false),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _counterBtn(Icons.remove, () => setState(() => quantity--)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text("$quantity", style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                ),
                _counterBtn(Icons.add, () => setState(() => quantity++)),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                onPressed: () {},
                child: const Text("Confirm Adjustment", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String title, bool isSelected) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFD700) : Colors.white.withValues(alpha: 0.05), // Error Fixed
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyle(color: isSelected ? Colors.black : Colors.white38, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _counterBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle), // Error Fixed
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}