
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

   # 📱 Smart POS & Full Inventory System
> **Final Lab Task – Mobile Application Development (Production-Ready)**
> **CLO Covered:** 4 & 5 (Advanced Apps, Persistent Storage, API Integration)

---

## 🚀 Technology Stack
* **Frontend:** Flutter (Dart)
* **Backend:** Firebase (Online)
* **Offline DB:** SQLite (Compulsory)
* **Cloud Backup:** Google Drive API

---

## 🛠 Mandatory Features Status
| Requirement | Description | Status |
| :--- | :--- | :---: |
| **Online Mode** | Works with Firebase Cloud | ✅ |
| **Offline Mode** | Works without internet via SQLite | ✅ |
| **Auto Sync** | Syncs data when internet is back | ✅ |
| **Backup** | Manual & Auto Google Drive Backup | ✅ |
| **Ledger System** | Customer Debit/Credit Tracking | ✅ |

---

## 📌 Project Modules

### 1. Authentication & Setup
- Secure Login/Signup using Firebase.
- Clean MVC-based architecture.

### 2. Product & Inventory Management
- Add/Edit/Delete products with SKU.
- Low stock alerts and visual indicators.
- Stock history tracking.

### 3. POS (Billing System)
- Dynamic cart with quantity controls.
- Runtime price changes, tax, and discount management.

### 4. Customer & Ledger System
- Regular & walk-in customer management.
- Debit/Credit payments and outstanding balance logs.

### 5. Offline Sync & Backup
- **SQLite Storage:** Persistent offline sales.
- **Sync Logic:** Automatic data merging with Firebase.
- **Google Drive:** Backup and Restore functionality.

---

## 📸 Screenshots & Demo
* **Demo APK:** [Link your APK here]
* **Source Code:** Available in `/lib` folder.

---

## 👨‍🏫 Submission Note
This application is built as a production-ready solution satisfying all enterprise-level requirements including offline-first logic and cloud synchronization.
