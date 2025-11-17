import 'subtask.dart';
import 'repeat_rule.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;
  final RepeatRule? repeatRule;
  final List<Subtask> subtasks;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.dueDate,
    this.isCompleted = false,
    this.repeatRule,
    this.subtasks = const [],
  });

  double get progress {
    if (subtasks.isEmpty) {
      return isCompleted ? 1.0 : 0.0;
    }
    final completed = subtasks.where((s) => s.isCompleted).length;
    return completed / subtasks.length;
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    RepeatRule? repeatRule,
    List<Subtask>? subtasks,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      repeatRule: repeatRule ?? this.repeatRule,
      subtasks: subtasks ?? this.subtasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate?.millisecondsSinceEpoch,
      'is_completed': isCompleted ? 1 : 0,
      'repeat_type': repeatRule?.type.index,
      'repeat_days': repeatRule?.daysJson,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, {List<Subtask> subtasks = const []}) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: (map['description'] as String?) ?? '',
      dueDate: map['due_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['due_date'] as int)
          : null,
      isCompleted: (map['is_completed'] as int? ?? 0) == 1,
      repeatRule: RepeatRule.fromDb(map),
      subtasks: subtasks,
    );
  }
}
