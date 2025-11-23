# Sp23-BSE-025-Tayyaba-Munir
Flutter Practise
## 📥 Download APK
[![Download APK](https://img.shields.io/badge/Download-APK-green.svg)](/mnt/data/app-release.apk)
## 📽️ Demo Video
[Click here to watch the demo video](https://drive.google.com/file/d/1GJJCh9oBFUW2-ruwHwXEyCapRKVfVcbc/view?usp=sharing)


# Task Manager App — Professional Documentation

## 1. Introduction

The **Task Manager App** is a Flutter-based mobile application designed to help users efficiently manage their daily tasks through an intuitive and user-friendly interface. It provides task creation, editing, deletion, subtask management, scheduling, reminders, and categorization features.

This documentation provides a complete overview of the application architecture, features, UI flow, project structure, and technical implementation.

---

## 2. Core Features

### ✔ Task Management

* Add new tasks
* Edit existing tasks
* Delete tasks
* Mark tasks as completed/pending

### ✔ Subtask Support

* Add multiple subtasks under a main task
* Toggle completion of subtasks

### ✔ Schedule & Reminders

* Assign due date and time
* Local notification reminders (Flutter Local Notifications)

### ✔ Categorization

* Tasks grouped by status (Pending / Completed)
* Color‑coded categories

### ✔ Local Storage

* Data stored using **Hive / SharedPreferences** (depending on implementation)
* Works offline with persistence

### ✔ Modern UI/UX

* Clean Material3 design
* Responsive layout
* Smooth animations

---

## 3. Technology Stack

| Component        | Technology                                  |
| ---------------- | ------------------------------------------- |
| Framework        | Flutter 3.35.3                              |
| Language         | Dart                                        |
| State Management | Provider / SetState (depending on codebase) |
| Local DB         | Hive (Recommended) or SharedPreferences     |
| Notifications    | flutter_local_notifications                 |
| UI               | Material Design 3                           |

---

## 4. Project Structure

```
lib/
│
├── main.dart
├── models/
│   └── task_model.dart
├── providers/
│   └── task_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├── add_edit_task.dart
│   └── task_details_screen.dart
├── widgets/
│   ├── task_tile.dart
│   ├── subtask_tile.dart
│   └── empty_state.dart
└── utils/
    ├── notification_service.dart
    └── validators.dart
```

---

## 5. Application Flow

### **Home Screen**

* Displays list of tasks
* Floating Action Button to create a new task
* Swipe-to-delete gesture

### **Add/Edit Task Screen**

* Input fields:

  * Title
  * Description
  * Due date & time
  * Subtasks (Add/Remove)
* Save button updates the local storage

### **Task Details Screen**

* Shows full description
* All subtasks with toggle
* Edit/Delete options

---

## 6. UI Design Overview

### **Color Palette**

* Primary: #6750A4 (Material Purple)
* Secondary: #EADDFF
* Background: #FDF7FF

### **Typography**

* HeadlineSmall → Task titles
* BodyMedium → Descriptions
* LabelMedium → Subtask labels

### **UX Principles**

* Minimalistic layout
* Consistent spacing
* Clearly visible CTAs
* Accessible fonts & colors

---

## 7. Data Model

### **Task Model**

```
class Task {
  String id;
  String title;
  String description;
  DateTime? dueDate;
  List<SubTask> subtasks;
  bool isCompleted;
}
```

### **SubTask Model**

```
class SubTask {
  String title;
  bool isDone;
}
```

---

## 8. Notification System

* Uses **flutter_local_notifications** plugin
* Creates scheduled reminders for tasks with set due dates
* Displays push notifications even when app is closed

### Notification Workflow

1. User selects date & time
2. App generates unique notification ID
3. Schedules notification using plugin

---

## 9. Error Handling

* Form validation for empty fields
* Snackbar feedback for actions (Saved / Deleted / Invalid Input)
* Try/catch during DB read/write

---

## 10. Performance Optimizations

* Lazy list loading with ListView.builder
* Minimal rebuilds with Provider
* Efficient Hive storage

---

## 11. Testing

### Recommended Tests

* UI widget tests
* TaskProvider unit tests
* Notification scheduling tests
* Form validation tests

---

## 12. Future Improvements

* Cloud sync (Firebase)
* User accounts
* Dark mode
* Drag‑and‑drop task reordering
* Repeating tasks
* Priority levels (High/Medium/Low)

---

## 13. Conclusion

The **Task Manager App** is a complete and professional Flutter application suitable for academic projects as well as real‑world usage. It demonstrates proper architecture, clean UI, state management, persistent storage, and local notification scheduling.

If you need additional sections such as **UML diagrams, API documentation, database schema, or screenshots**, I can add them as well.
