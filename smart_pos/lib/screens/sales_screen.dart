import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  String searchQuery = "";
  List<Map<String, dynamic>> cart = [];
  double totalAmount = 0;

  Future<void> _processSale() async {
    if (cart.isEmpty) return;
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      
      // Save Sale for Reports
      DocumentReference saleRef = FirebaseFirestore.instance.collection('sales').doc();
      batch.set(saleRef, {
        'total': totalAmount,
        'items': cart,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update Inventory Stock
      for (var item in cart) {
        DocumentReference docRef = FirebaseFirestore.instance.collection('inventory').doc(item['id']);
        batch.update(docRef, {'quantity': FieldValue.increment(-item['sellQty'])});
      }

      await batch.commit();
      if (!mounted) return;

      setState(() { cart.clear(); totalAmount = 0; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sale Success! Stock Updated.")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _addToCart(String id, String name, double price, double purchasePrice, int qty) {
    if (qty <= 0) return;
    setState(() {
      cart.add({'id': id, 'name': name, 'price': price, 'purchasePrice': purchasePrice, 'sellQty': 1});
      totalAmount += price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Billing & Sales")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              onChanged: (val) => setState(() => searchQuery = val.toLowerCase()),
              decoration: const InputDecoration(hintText: "Search Medicine...", prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('inventory').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                var docs = snapshot.data!.docs.where((d) => d['name'].toString().toLowerCase().contains(searchQuery)).toList();
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var doc = docs[index];
                    return ListTile(
                      title: Text(doc['name']),
                      subtitle: Text("Price: ${doc['price']} | Stock: ${doc['quantity']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_circle, color: Color(0xFFFFD700)),
                        onPressed: () => _addToCart(doc.id, doc['name'], doc['price'].toDouble(), doc['purchasePrice'].toDouble(), doc['quantity']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), minimumSize: const Size(double.infinity, 50)),
              onPressed: cart.isEmpty ? null : _processSale,
              child: Text("CHARGE RS. $totalAmount", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}