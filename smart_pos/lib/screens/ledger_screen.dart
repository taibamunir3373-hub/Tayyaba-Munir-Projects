import 'package:flutter/material.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  // Dummy Data: Asal mein ye SQLite ya Firebase se aayega
  final List<Map<String, dynamic>> customers = [
    {"name": "Ali Khan", "balance": -500.0, "lastUpdate": "10 Jan 2024"},
    {"name": "Sajid Ahmed", "balance": 1200.0, "lastUpdate": "08 Jan 2024"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Ledger"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_add_alt_1))
        ],
      ),
      body: Column(
        children: [
          // Summary Header
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blueAccent.withValues(alpha: 0.1),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatTile(label: "Receivable", value: "Rs. 15,000", color: Colors.green),
                _StatTile(label: "Payable", value: "Rs. 2,500", color: Colors.red),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                final bool isDebit = customer['balance'] < 0;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: Text(customer['name'][0]),
                  ),
                  title: Text(customer['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Last Transaction: ${customer['lastUpdate']}"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Rs. ${customer['balance'].abs()}",
                        style: TextStyle(
                          color: isDebit ? Colors.redAccent : Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(isDebit ? "You Owe" : "Owes You", style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                  onTap: () {
                    // Yahan detail ledger khulega
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatTile({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}