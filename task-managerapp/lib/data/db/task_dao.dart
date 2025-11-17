import 'package:sqflite/sqflite.dart';

import 'package:task_app/data/models/task.dart';


import '../models/subtask.dart';
import 'app_database.dart';

class TaskDao {
  Future<Database> get _db async => AppDatabase.instance.database;

  Future<int> insertTask(Task task) async {
    final db = await _db;
    final taskId = await db.insert('tasks', task.toMap());
    // store subtasks if provided
    for (final subtask in task.subtasks) {
      final s = subtask.copyWith(taskId: taskId);
      await db.insert('subtasks', s.toMap());
    }
    return taskId;
  }

  Future<int> updateTask(Task task) async {
    final db = await _db;
    if (task.id == null) throw ArgumentError('Task id is required for update');

    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );

    // simple approach: delete existing subtasks and reinsert
    await db.delete('subtasks', where: 'task_id = ?', whereArgs: [task.id]);
    for (final subtask in task.subtasks) {
      final s = subtask.copyWith(taskId: task.id);
      await db.insert('subtasks', s.toMap());
    }

    return task.id!;
  }

  Future<int> deleteTask(int id) async {
    final db = await _db;
    await db.delete('subtasks', where: 'task_id = ?', whereArgs: [id]);
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Task>> getTodayTasks(DateTime today) async {
    final db = await _db;
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(const Duration(days: 1));

    final rows = await db.query(
      'tasks',
      where: 'due_date >= ? AND due_date < ? AND is_completed = 0',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'due_date ASC',
    );

    return _attachSubtasks(rows);
  }

  Future<List<Task>> getCompletedTasks() async {
    final db = await _db;
    final rows = await db.query(
      'tasks',
      where: 'is_completed = 1',
      orderBy: 'due_date DESC',
    );
    return _attachSubtasks(rows);
  }

  Future<List<Task>> getRepeatedTasks() async {
    final db = await _db;
    final rows = await db.query(
      'tasks',
      where: 'repeat_type IS NOT NULL',
      orderBy: 'due_date ASC',
    );
    return _attachSubtasks(rows);
  }

  Future<List<Task>> _attachSubtasks(List<Map<String, dynamic>> rows) async {
    final db = await _db;
    final List<Task> tasks = [];

    for (final row in rows) {
      final id = row['id'] as int;
      final subtasksRows = await db.query(
        'subtasks',
        where: 'task_id = ?',
        whereArgs: [id],
      );
      final subtasks = subtasksRows.map((s) => Subtask.fromMap(s)).toList();
      tasks.add(Task.fromMap(row, subtasks: subtasks));
    }

    return tasks;
  }
}
