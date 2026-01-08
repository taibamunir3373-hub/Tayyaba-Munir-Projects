import 'package:flutter/material.dart';

class SyncSettingsScreen extends StatefulWidget {
  const SyncSettingsScreen({super.key});

  @override
  State<SyncSettingsScreen> createState() => _SyncSettingsScreenState();
}

class _SyncSettingsScreenState extends State<SyncSettingsScreen> {
  bool offlineMode = false;
  bool allowOfflineSales = true;
  bool syncWifiOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark Navy Theme
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
                 // Line 38-44 fix
const Row( // Add 'const' here
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
                    child: Text("Last successful sync: Today, 10:42 AM", style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSyncStat("Pending", "0 Items"),
                      _buildSyncStat("Upload Speed", "45ms"),
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
                onPressed: () {},
                child: const Text("Sync Data Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),

            // Offline Preferences Section
            _sectionTitle("OFFLINE PREFERENCES"),
            _buildSwitchTile(Icons.wifi_off, "Force Offline Mode", "Work without internet", offlineMode, (val) => setState(() => offlineMode = val)),
            _buildSwitchTile(Icons.shopping_basket_outlined, "Allow Offline Sales", "Queue transactions when offline", allowOfflineSales, (val) => setState(() => allowOfflineSales = val)),
            _buildSwitchTile(Icons.cloud_sync_outlined, "Sync Images on Wi-Fi Only", "Save mobile data", syncWifiOnly, (val) => setState(() => syncWifiOnly = val)),

            const SizedBox(height: 30),
            _sectionTitle("DATA MANAGEMENT"),
            _buildDataTile("Pending Transactions", "All Clear"),
            _buildDataTile("Inventory Database", "v2.41"),
            
            const SizedBox(height: 30),
            _sectionTitle("ADVANCED"),
            _buildActionTile("View Sync Conflict Log", Colors.white),
            _buildActionTile("Clear Local Cache", Colors.redAccent),
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
      activeThumbColor: Colors.blue,
      onChanged: (bool newValue) {
        onChanged(newValue);
      },
    ), // Switch ka bracket yahan band ho raha hai
  ); // ListTile ka bracket aur semicolon yahan hai
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

  Widget _buildActionTile(String title, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(color: color, fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
    );
  }
}