import 'package:flutter/foundation.dart';
import '../data/models/task.dart';
import '../data/db/task_dao.dart';

class TaskProvider extends ChangeNotifier {
  final TaskDao _taskDao = TaskDao();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Task> _tasks = [];

  List<Task> get allTasks => List.unmodifiable(_tasks);

  List<Task> get completedTasks =>
      _tasks.where((t) => t.isCompleted == true).toList();

  List<Task> get todayTasks => _tasks.where((t) {
        if (t.dueDate == null) return false;
        final now = DateTime.now();
        return t.dueDate!.year == now.year &&
            t.dueDate!.month == now.month &&
            t.dueDate!.day == now.day;
      }).toList();

  Future<void> loadAll() async {
    _isLoading = true;
    notifyListeners();

    final tasksFromDb = await _taskDao.getAllTasks();
    _tasks
      ..clear()
      ..addAll(tasksFromDb);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final id = await _taskDao.insertTask(task);
    _tasks.add(task.copyWith(id: id));
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _taskDao.updateTask(task);
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  Future<void> deleteTask(int id) async {
    await _taskDao.deleteTask(id);
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  Future<void> toggleComplete(Task task) async {
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updated);
  }
}
