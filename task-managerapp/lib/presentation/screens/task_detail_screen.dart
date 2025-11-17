import 'package:flutter/material.dart';

import 'package:task_app/data/models/task.dart';





class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            if (task.description.isNotEmpty)
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 12),
            if (task.dueDate != null)
              Text(
                'Due: ${task.dueDate}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text('Completed'),
                const SizedBox(width: 8),
                Icon(
                  task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
