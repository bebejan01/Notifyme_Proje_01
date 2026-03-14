import 'dart:async';

import '../models/task.dart';

class TaskStats {
  final int totalTasks;
  final int completedTasks;

  const TaskStats({
    required this.totalTasks,
    required this.completedTasks,
  });
}

class TaskService {
  TaskService._internal() {
    final now = DateTime.now();
    _tasks = [
      Task(
        id: 'task-1',
        title: 'Haftalik raporu hazirla',
        description: 'Pazartesi sabahi teslim edilecek raporu guncelle',
        dueDate: now.add(const Duration(hours: 4)),
        isCompleted: false,
        priority: 'high',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      Task(
        id: 'task-2',
        title: 'Toplanti hazirligi',
        description: 'Sunum slaytlarini gozden gecir',
        dueDate: now.add(const Duration(days: 1)),
        isCompleted: false,
        priority: 'medium',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      Task(
        id: 'task-3',
        title: 'Spor salonu',
        description: 'Aksam 19:00da antrenman',
        dueDate: DateTime(now.year, now.month, now.day, 19),
        isCompleted: true,
        priority: 'low',
        createdAt: now.subtract(const Duration(days: 3)),
        completedAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;

  late List<Task> _tasks;

  Future<List<Task>> fetchPendingTasks() async {
    await _simulateDelay();
    final pendingTasks = _tasks.where((task) => !task.isCompleted).toList();
    pendingTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return pendingTasks;
  }

  Future<List<Task>> fetchTasksForDate(DateTime date) async {
    await _simulateDelay();
    final tasksForDay = _tasks.where((task) {
      return _isSameDay(task.dueDate, date);
    }).toList();

    tasksForDay.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return tasksForDay;
  }

  Future<List<Task>> fetchCompletedTasks() async {
    await _simulateDelay();
    final completed = _tasks.where((task) => task.isCompleted).toList();
    completed.sort((a, b) {
      final aDate = a.completedAt ?? a.dueDate;
      final bDate = b.completedAt ?? b.dueDate;
      return bDate.compareTo(aDate);
    });
    return completed;
  }

  Future<TaskStats> fetchStats() async {
    await _simulateDelay();
    final completedCount = _tasks.where((task) => task.isCompleted).length;
    return TaskStats(
      totalTasks: _tasks.length,
      completedTasks: completedCount,
    );
  }

  Future<void> addTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required String priority,
  }) async {
    await _simulateDelay();
    final now = DateTime.now();
    final newTask = Task(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      dueDate: dueDate,
      isCompleted: false,
      priority: priority,
      createdAt: now,
    );
    _tasks.add(newTask);
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    await _simulateDelay();
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index == -1) return;

    final existing = _tasks[index];
    _tasks[index] = Task(
      id: existing.id,
      userId: existing.userId,
      title: existing.title,
      description: existing.description,
      dueDate: existing.dueDate,
      isCompleted: !existing.isCompleted,
      priority: existing.priority,
      createdAt: existing.createdAt,
      completedAt: existing.isCompleted ? null : DateTime.now(),
    );
  }

  Future<void> deleteTask(String taskId) async {
    await _simulateDelay();
    _tasks.removeWhere((task) => task.id == taskId);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> _simulateDelay() {
    return Future<void>.delayed(const Duration(milliseconds: 150));
  }
}

final taskService = TaskService();
