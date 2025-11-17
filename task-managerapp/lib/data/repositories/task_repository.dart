import '../db/task_dao.dart';
import 'package:task_app/data/models/task.dart';



class TaskRepository {
  final TaskDao _dao;

  TaskRepository({TaskDao? dao}) : _dao = dao ?? TaskDao();

  Future<List<Task>> todayTasks(DateTime today) => _dao.getTodayTasks(today);
  Future<List<Task>> completedTasks() => _dao.getCompletedTasks();
  Future<List<Task>> repeatedTasks() => _dao.getRepeatedTasks();

  Future<int> addTask(Task task) => _dao.insertTask(task);
  Future<int> updateTask(Task task) => _dao.updateTask(task);
  Future<int> deleteTask(int id) => _dao.deleteTask(id);
}
