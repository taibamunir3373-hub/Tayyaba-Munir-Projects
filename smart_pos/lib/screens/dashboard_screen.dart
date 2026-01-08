import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E16),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
        ),
        title: const Column( // Added const here
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dispensary Dashboard", 
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text("● System Synced", 
                style: TextStyle(color: Colors.green, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white), 
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Stats Section
            Row(
              children: [
                _buildStatCard("Stock Value", "Rs. 142k", Icons.account_balance_wallet, Colors.yellow[700]!),
                const SizedBox(width: 15),
                _buildStatCard("Total Items", "1,240", Icons.inventory_2, Colors.blueAccent),
              ],
            ),
            const SizedBox(height: 25),

            // 2. Urgent Alerts Section
            const Text("Urgent Alerts", 
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildExpiryAlert("Panadol CF", "5"),
            _buildExpiryAlert("Arinac Forte", "12"),

            const SizedBox(height: 25),
            
            // 3. Quick Actions Section
            const Text("Quick Actions", 
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildActionButton(context, "New Sale", Icons.add_shopping_cart, const Color(0xFFFFD700), '/sales'),
                const SizedBox(width: 15),
                _buildActionButton(context, "Add Stock", Icons.library_add, Colors.white10, '/inventory'),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // 4. Low Stock Warning Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Low Stock Warning", 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("View All", 
                    style: TextStyle(color: Colors.yellow, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 15),
            _buildLowStockItem("Insulin Pen", "Batch: IN-99", "2 left", Colors.red),
            _buildLowStockItem("Augmentin 625mg", "Batch: AU-10", "8 left", Colors.orange),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // --- Helper Widgets ---

  Widget _buildExpiryAlert(String medicineName, String daysLeft) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$medicineName is Expiring Soon!", 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Only $daysLeft days left", 
                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05), 
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 15),
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String title, IconData icon, Color bgColor, String route) {
    bool isYellow = bgColor == const Color(0xFFFFD700);
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isYellow ? Colors.black : Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(title, 
                  style: TextStyle(
                    color: isYellow ? Colors.black : Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 12,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLowStockItem(String name, String sku, String left, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05), 
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 40, 
            height: 40, 
            decoration: BoxDecoration(
              color: Colors.white10, 
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.medication, color: Colors.white24, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(sku, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          Text(left, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1E1E16),
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) Navigator.pushNamed(context, '/inventory');
        if (index == 2) Navigator.pushNamed(context, '/sales');
        if (index == 3) Navigator.pushNamed(context, '/reports'); // Added Reports route
        if (index == 4) Navigator.pushNamed(context, '/settings');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Overview"),
        BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Stock"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 35, color: Colors.yellow), label: "Sale"),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}