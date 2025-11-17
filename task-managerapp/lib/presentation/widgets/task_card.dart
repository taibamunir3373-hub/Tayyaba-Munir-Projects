import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_app/data/models/task.dart';


import '../../state/task_provider.dart';
import '../screens/task_detail_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TaskDetailScreen(task: task),
            ),
          );
        },
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: task.dueDate != null
            ? Text('Due: ${task.dueDate}')
            : null,
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => provider.toggleCompleted(task),
        ),
      ),
    );
  }
}
