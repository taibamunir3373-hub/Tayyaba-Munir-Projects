import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/database_helper.dart'; // SQLite helper import karein

class SyncSettingsScreen extends StatefulWidget {
  const SyncSettingsScreen({super.key});

  @override
  State<SyncSettingsScreen> createState() => _SyncSettingsScreenState();
}

class _SyncSettingsScreenState extends State<SyncSettingsScreen> {
  bool offlineMode = false;
  bool allowOfflineSales = true;
  bool syncWifiOnly = false;
  int pendingCount = 0;
  bool isSyncing = false;

  @override
  void initState() {
    super.initState();
    _loadPendingCount();
  }

  // SQLite se check karein kitni sales sync honay wali hain
  Future<void> _loadPendingCount() async {
    final unsynced = await DatabaseHelper.instance.getUnsyncedSales();
    setState(() {
      pendingCount = unsynced.length;
    });
  }

  // Lab Task Commit 6: Sync Logic
  Future<void> _handleSync() async {
    setState(() => isSyncing = true);
    
    final dbHelper = DatabaseHelper.instance;
    final unsyncedSales = await dbHelper.getUnsyncedSales();

    if (unsyncedSales.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No data to sync!")),
        );
      }
    } else {
      for (var sale in unsyncedSales) {
        try {
          // Firebase par upload
          await FirebaseFirestore.instance.collection('sales').add({
            'total': sale['total'],
            'items': sale['items'],
            'timestamp': sale['timestamp'],
          });
          
          // Local DB mein update karein ke sync ho gaya
          final db = await dbHelper.database;
          await db.update('sales', {'isSynced': 1}, where: 'id = ?', whereArgs: [sale['id']]);
        } catch (e) {
          debugPrint("Sync Error: $e");
        }
      }
      _loadPendingCount();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sync Completed Successfully!")),
        );
      }
    }
    setState(() => isSyncing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Sync & Network", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Connection Status Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: const Border(left: BorderSide(color: Colors.green, width: 4)),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.green, radius: 5),
                      SizedBox(width: 10),
                      Text("ONLINE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("System is Connected", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Last successful sync: Today, Just now", style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSyncStat("Pending", "$pendingCount Items"),
                      _buildSyncStat("Status", isSyncing ? "Syncing..." : "Ready"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sync Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: isSyncing ? null : _handleSync,
                child: isSyncing 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Sync Data Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),

            _sectionTitle("OFFLINE PREFERENCES"),
            _buildSwitchTile(Icons.wifi_off, "Force Offline Mode", "Work without internet", offlineMode, (val) => setState(() => offlineMode = val)),
            _buildSwitchTile(Icons.shopping_basket_outlined, "Allow Offline Sales", "Queue transactions when offline", allowOfflineSales, (val) => setState(() => allowOfflineSales = val)),
            _buildSwitchTile(Icons.cloud_sync_outlined, "Sync Images on Wi-Fi Only", "Save mobile data", syncWifiOnly, (val) => setState(() => syncWifiOnly = val)),

            const SizedBox(height: 30),
            _sectionTitle("DATA MANAGEMENT"),
            _buildDataTile("Database Version", "v2.41"),
            _buildDataTile("Local Storage Used", "1.2 MB"),
            
            const SizedBox(height: 30),
            _sectionTitle("BACKUP & RESTORE (LAB TASK)"),
            _buildActionTile("Manual Cloud Backup", Colors.greenAccent, Icons.cloud_upload),
            _buildActionTile("Restore from Google Drive", Colors.orangeAccent, Icons.settings_backup_restore),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5),
        child: Text(title, style: const TextStyle(color: Colors.white24, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String sub, bool val, Function(bool) onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11)),
      trailing: Switch(
        value: val,
        activeTrackColor: Colors.blue.withValues(alpha: 0.5),
        activeColor: Colors.blue,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDataTile(String title, String trailing) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(trailing, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildActionTile(String title, Color color, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color, size: 20),
      title: Text(title, style: TextStyle(color: color, fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: () {
        // Yahan Google Drive Backup ka logic aayega
      },
    );
  }
}