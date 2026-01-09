📱 Project Documentation: Smart POS & Full Inventory System1. Executive SummarySmart POS ek enterprise-level mobile application hai jo retail businesses ke liye banayi gayi hai. Yeh app Offline-First Architecture par base karti hai, jo internet na hone par bhi business operations (sales, stock tracking) ko rukne nahi deti.2. Technical StackFrontend: Flutter Framework (Dart)Online Database: Firebase Firestore (Real-time Cloud Sync)Offline Database: SQLite (Local Persistent Storage - Mandatory)Authentication: Firebase AuthStorage: Google Drive API (for Cloud Backup & Restore)3. Core Modules & FunctionalitiesA. Authentication & Setup (Commit 1)Login/Signup: Firebase secure authentication system.Project Initialization: GitHub repository setup with clean MVC-inspired folder structure.B. Product & Inventory Management (Commit 2)Inventory Control: SKU tracking, category-wise listing, and real-time price management.Low Stock Alerts: Automated visual indicators when product quantity falls below a threshold.Stock History: Tracking every "Stock In" and "Stock Out" activity.C. POS - Billing System (Commit 3)Dynamic Cart: Add/Remove items with real-time total calculation.Advanced Billing: Features like runtime price adjustment, tax calculation, and discounts per item or total bill.D. Customer & Ledger System (Phase 4)Customer Profiles: Management of walk-in and regular registered customers.Credit/Debit Ledger: A full accounting system to track outstanding balances, payments, and purchase history.E. Offline, Sync & Backup (Commit 6)Offline Mode: Internet disconnect hone par data automatically SQLite (pos.db) mein save hota hai.Auto-Sync: Internet restore hote hi system SQLite aur Firebase ke darmiyan conflicts handle karke data sync karta hai.Google Drive Backup: Users apna data (Products, Sales, Ledgers) Google Drive par backup aur wahan se restore kar sakte hain.4. Application ArchitectureApp Layered Architecture follow karti hai:Presentation Layer: Flutter UI Widgets (Themes, Screens).Logic Layer: State management to handle data flow.Data Layer: * DatabaseHelper for SQLite.FirebaseService for Cloud Firestore.SyncManager for Auto-sync logic.5. Learning Outcomes (CLO 4 & 5)Advanced UI: Multiple screens aur complex navigation handling.Data Persistence: SQLite aur Firebase ka concurrent use.API Integration: Google Drive aur Firebase APIs ka production-level use.Conflict Handling: Offline sales aur online data merge karne ka logic.6. How to Run the ProjectRepository: GitHub se code clone karein.Dependencies: flutter pub get terminal mein run karein.Build: Android device connect karke flutter run karein.APK: Release folder mein mojud APK install karein.7. Compliance ChecklistRequirementStatusVerificationOnline Database✅ CompleteFirebase Cloud StorageOffline SQLite✅ CompleteLocal pos.db integrationSync Logic✅ CompleteSync Settings Screen functionalityBackup/Restore✅ CompleteGoogle Drive & Local backup optionsLedger System✅ CompleteDebit/Credit customer management




# smart_pos

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Smart POS & Full Inventory Management System 🚀
A Production-Ready, Offline-First Flutter Application.

## 📋 Project Overview
This project is a comprehensive Point of Sale (POS) and Inventory solution designed for retailers. It features a robust **Offline-First architecture**, ensuring business continuity even without internet connectivity.

## ✨ Key Features
- **🔐 Secure Authentication:** Firebase-powered Login and Signup.
- **📦 Inventory Management:** Add, edit, and track stock levels with Low Stock Alerts.
- **🛒 POS System:** Dynamic cart system with real-time tax and discount calculations.
- **📒 Customer Ledger:** Complete Debit/Credit system to manage regular customers and outstanding balances.
- **🔄 Sync & Offline Mode:** Uses **SQLite** for local storage and automatically syncs data to **Firebase** when the internet is restored.
- **📊 Reports:** Daily and monthly sales analytics with profit/loss tracking.
- **☁️ Backup & Restore:** Manual and cloud-based backup options.

## 🛠 Technology Stack
- **Frontend:** Flutter (v3.x)
- **Database (Online):** Firebase Firestore
- **Database (Offline):** SQLite (sqflite)
- **State Management:** Provider/setState
- **Architecture:** Offline-Sync Architecture

## 🚀 Installation & Setup
1. **Clone the Repo:**
   ```bash
   git clone [https://github.com/your-username/smart_pos.git](https://github.com/your-username/smart_pos.git)
