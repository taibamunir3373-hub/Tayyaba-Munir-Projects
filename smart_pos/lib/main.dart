import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens imports
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/stock_adjustment_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/ledger_screen.dart'; // Ledger Screen lazmi add karein

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // 1. FIX: Duplicate App Error handle karne ke liye check
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    // 2. FUTURE ADDITION: SQLite database init yahan hoga (Offline Mode ke liye)
    // await DatabaseHelper.instance.database; 

    runApp(const MyApp());
  } catch (e) {
    debugPrint("Initialization Error: $e");
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF1E1E16),
          body: Center(
            child: Text(
              "System Error: $e\n\nPlease restart the app.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart POS',
      
      // Global Theme Settings
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFFFD700), // Gold
        scaffoldBackgroundColor: const Color(0xFF1E1E16), // Premium Dark
        useMaterial3: true,
        // Card aur Button ki styling
        cardTheme: CardThemeData(
          color: Colors.white.withValues(alpha: 0.05),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),

      initialRoute: '/splash', 

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/product_list': (context) => const ProductListScreen(),
        '/inventory': (context) => const InventoryScreen(),
        '/adjustment': (context) => const StockAdjustmentScreen(),
        '/sales': (context) => const SalesScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/ledger': (context) => const LedgerScreen(), // Lab Task Requirement
      },
    );
  }
}