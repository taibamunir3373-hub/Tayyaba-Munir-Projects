import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_themes.dart';
import 'state/theme_provider.dart';
import 'presentation/screens/home_screen.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      themeMode: themeProvider.mode,
      home: const HomeScreen(),
    );
  }
}
