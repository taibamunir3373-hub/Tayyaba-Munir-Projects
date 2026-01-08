import 'package:flutter/material.dart';

class ReportsDashboard extends StatelessWidget {
  const ReportsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E16),
      appBar: AppBar(
        title: const Text("Reports Dashboard", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today, color: Colors.yellow), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Tabs (Today, Yesterday, etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterChip("Today", true),
                _buildFilterChip("Yesterday", false),
                _buildFilterChip("This Week", false),
              ],
            ),
            const SizedBox(height: 25),

            // Main Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Sales Today", style: TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 10),
                  const Text("\$1,450.50", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.trending_up, color: Colors.green, size: 20),
                      const SizedBox(width: 5),
                      Text("+12.5% vs yesterday", style: TextStyle(color: Colors.green[400], fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Stats Grid
            Row(
              children: [
                _buildSmallStatCard("42", "Transactions", Icons.receipt_long, Colors.blue),
                const SizedBox(width: 15),
                _buildSmallStatCard("5", "New Customers", Icons.people, Colors.orange),
              ],
            ),
            const SizedBox(height: 30),

            const Text("Detailed Reports", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // Report Categories
            _buildReportLink("Daily Sales", "Hourly breakdown & heatmap", Icons.analytics, Colors.yellow),
            _buildReportLink("Monthly Sales", "Trends & forecasting", Icons.show_chart, Colors.purple),
            _buildReportLink("Stock Report", "Low stock & valuation", Icons.inventory_2, Colors.blue),
            _buildReportLink("Customer Insights", "Top spenders & loyalty", Icons.auto_graph, Colors.pink),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFD700) : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.white60, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSmallStatCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildReportLink(String title, String subtitle, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white24),
        onTap: () {},
      ),
    );
  }
}