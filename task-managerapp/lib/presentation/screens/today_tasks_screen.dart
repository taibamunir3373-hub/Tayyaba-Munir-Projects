import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/task_provider.dart';
import '../screens/add_edit_task_screen.dart';
import '../widgets/task_card.dart';

class TodayTasksScreen extends StatefulWidget {
  const TodayTasksScreen({Key? key}) : super(key: key);

  @override
  State<TodayTasksScreen> createState() => _TodayTasksScreenState();
}

class _TodayTasksScreenState extends State<TodayTasksScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).loadAll());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Today's Tasks"),
          ),
          body: taskProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : taskProvider.todayTasks.isEmpty
                  ? const Center(child: Text('No tasks for today'))
                  : ListView.builder(
                      itemCount: taskProvider.todayTasks.length,
                      itemBuilder: (context, index) {
                        final task = taskProvider.todayTasks[index];
                        return TaskCard(task: task);
                      },
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddEditTaskScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
