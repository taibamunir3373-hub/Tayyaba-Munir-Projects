import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/task_provider.dart';
import '../widgets/task_card.dart';

class RepeatedTasksScreen extends StatelessWidget {
  const RepeatedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().repeatedTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repeated Tasks'),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text('No repeated tasks yet.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskCard(task: task);
              },
            ),
    );
  }
}
