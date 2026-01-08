import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sales Reports")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sales').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          double totalRevenue = 0;
          double totalProfit = 0;
          for (var doc in snapshot.data!.docs) {
            totalRevenue += (doc['total'] as num).toDouble();
            List items = doc['items'];
            for (var item in items) {
              totalProfit += (item['price'] - item['purchasePrice']) * item['sellQty'];
            }
          }

          return Column(
            children: [
              _buildCard("Total Revenue", "Rs. $totalRevenue", Colors.blue),
              _buildCard("Total Profit", "Rs. $totalProfit", Colors.green),
              const Expanded(child: Center(child: Text("Detailed Logs Below")))
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, String value, Color col) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: .withValues(alpha: 0.1), borderRadius: BorderRadius.circular(15)),
      child: Column(children: [Text(title), Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]),
    );
  }
}