import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_app/data/models/task.dart';




import '../../state/task_provider.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? existingTask;
  const AddEditTaskScreen({super.key, this.existingTask});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.existingTask?.title ?? '');
    _descCtrl =
        TextEditingController(text: widget.existingTask?.description ?? '');
    _dueDate = widget.existingTask?.dueDate;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTask != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Task' : 'Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Required' : null,
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    _dueDate == null
                        ? 'No due date'
                        : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}',
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Pick Date'),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final newTask = Task(
                    id: widget.existingTask?.id,
                    title: _titleCtrl.text,
                    description: _descCtrl.text,
                    dueDate: _dueDate,
                    isCompleted: widget.existingTask?.isCompleted ?? false,
                    repeatRule: widget.existingTask?.repeatRule,
                    subtasks: widget.existingTask?.subtasks ?? const [],
                  );

                  final provider = context.read<TaskProvider>();
                  if (isEditing) {
                    await provider.updateTask(newTask);
                  } else {
                    await provider.addTask(newTask);
                  }
                  if (mounted) Navigator.pop(context);
                },
                child: Text(isEditing ? 'Save Changes' : 'Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
