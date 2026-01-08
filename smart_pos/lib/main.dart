import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Saari Screens ko import karein
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/stock_adjustment_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Check karein ke Firebase initialize ho raha hai ya nahi
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    runApp(const MyApp());
  } catch (e) {
    // Agar error aaye toh ye console par dikha dega
    // print ki jagah debugPrint use karein
debugPrint("Firebase Error: $e");
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text("Error: $e")))));
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
      ),

      // Splash Screen se start hoga
      initialRoute: '/splash', 

      // Saaray Pages (Routes) ki list
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
      },
    );
  }
}