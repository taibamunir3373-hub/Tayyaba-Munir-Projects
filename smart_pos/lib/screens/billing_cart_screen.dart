import 'package:flutter/material.dart';

class BillingCartScreen extends StatefulWidget {
  const BillingCartScreen({super.key});

  @override
  State<BillingCartScreen> createState() => _BillingCartScreenState();
}

class _BillingCartScreenState extends State<BillingCartScreen> {
  bool isTaxEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E16), // Image wala dark theme
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Billing Cart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.person_add_alt, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Order Info Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
        // Line 37 se 43 tak ka fix
// Order Info Header (Line 38-44 fix)
const Column( // Yahan 'const' lagaya gaya hai
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("ORDER #1023", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    Text("Oct 24, 2023 • 10:45 AM", style: TextStyle(color: Colors.white38, fontSize: 12)),
  ],
),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFFFFD700).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                  child: const Text("DINE-IN", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 10)),
                ),
              ],
            ),
          ),

          // Items List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildCartItem("Wireless Mouse", "Matte Black • Logitech", "\$50.00", "2", "https://via.placeholder.com/50"),
                _buildCartItem("USB-C Cable", "2m Braided • White", "\$10.00", "1", "https://via.placeholder.com/50"),
                _buildCartItem("Caramel Latte", "Large • Oat Milk", "\$6.50", "1", "https://via.placeholder.com/50"),
                
                const SizedBox(height: 20),
                // Discount Row
                _buildAddonRow(Icons.percent, "Discount", "Apply % or fixed", "Add", Colors.orange),
                const SizedBox(height: 10),
                // Tax Row
                _buildTaxRow(),
              ],
            ),
          ),

          // Bottom Checkout Section
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                _buildPriceSummary("Subtotal (4 items)", "\$66.50"),
                _buildPriceSummary("Discount", "-\$0.00"),
                _buildPriceSummary("Tax (10%)", "\$6.65"),
                const Divider(color: Colors.white10, height: 30),
              // Line 87 ke qareeb ye tabdeeli karein
const Row( // 'const' keyword yahan add kiya gaya hai
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("Subtotal (4 items)", style: TextStyle(color: Colors.white54)),
    Text("\$66.50", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  ],
),
                const SizedBox(height: 20),
                // Premium Charge Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      shadowColor: const Color(0xFFFFD700).withValues(alpha: 0.3),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("CHARGE \$73.15", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(String name, String desc, String price, String qty, String imgUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imgUrl, width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                const Text("Edit Price", style: TextStyle(color: Color(0xFFFFD700), fontSize: 12, decoration: TextDecoration.underline)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(5)),
                child: Text(qty, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddonRow(IconData icon, String title, String sub, String btnText, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.03), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 12)),
            ]),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), minimumSize: const Size(60, 30)),
            child: Text(btnText, style: const TextStyle(color: Colors.black, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxRow() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.03), borderRadius: BorderRadius.circular(15)),
    child: Row(
      children: [
        const Icon(Icons.account_balance, color: Colors.blue),
        const SizedBox(width: 15),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text("Tax (VAT)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text("10% Standard Rate", style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
        Switch(
          value: isTaxEnabled,
          activeThumbColor: const Color(0xFFFFD700),
          onChanged: (bool val) {
            setState(() {
              isTaxEnabled = val;
            });
          },
        ),
      ],
    ),
  );
}

  Widget _buildPriceSummary(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54)),
          Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}