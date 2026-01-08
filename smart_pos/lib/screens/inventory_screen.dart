import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final nameCtrl = TextEditingController();
  final batchCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final salePriceCtrl = TextEditingController();
  final purchasePriceCtrl = TextEditingController(); // Naya field

  Future<void> _saveToFirebase() async {
    if (nameCtrl.text.isEmpty || qtyCtrl.text.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('inventory').add({
        'name': nameCtrl.text.trim(),
        'batch': batchCtrl.text.trim(),
        'expiry': expCtrl.text.trim(),
        'quantity': int.parse(qtyCtrl.text.trim()),
        'price': double.parse(salePriceCtrl.text.trim()),
        'purchasePrice': double.parse(purchasePriceCtrl.text.trim()), // Save purchase price
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.pop(context);
      _clearInputs();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _clearInputs() {
    nameCtrl.clear(); batchCtrl.clear(); expCtrl.clear();
    qtyCtrl.clear(); salePriceCtrl.clear(); purchasePriceCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E16),
      appBar: AppBar(title: const Text("Stock Management"), backgroundColor: Colors.transparent),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('inventory').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return ListTile(
                title: Text(doc['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text("Batch: ${doc['batch']} | Exp: ${doc['expiry']}", style: const TextStyle(color: Colors.white38)),
                trailing: Text("Qty: ${doc['quantity']}", style: const TextStyle(color: Color(0xFFFFD700))),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        onPressed: () => _showAddDialog(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showAddDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF2D2D24),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Add Medicine", style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 15),
              _field(nameCtrl, "Medicine Name"),
              _field(batchCtrl, "Batch No"),
              _field(expCtrl, "Expiry (MM/YY)"),
              _field(qtyCtrl, "Quantity", isNum: true),
              _field(purchasePriceCtrl, "Purchase Price (Aapne kitne ki li)", isNum: true),
              _field(salePriceCtrl, "Sale Price (Mareez ko kitne ki di)", isNum: true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700], minimumSize: const Size(double.infinity, 50)),
                onPressed: _saveToFirebase,
                child: const Text("SAVE TO STOCK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String hint, {bool isNum = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        keyboardType: isNum ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(hintText: hint, filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}