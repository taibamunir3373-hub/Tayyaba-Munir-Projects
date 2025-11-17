import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/task_provider.dart';
import '../widgets/task_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<TaskProvider>();
    provider.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.completedTasks.isEmpty
              ? const Center(child: Text('No completed tasks yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.completedTasks[index];
                    return TaskCard(task: task);
                  },
                ),
    );
  }
}
