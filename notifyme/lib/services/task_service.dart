import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/app_database.dart';
import '../data/models/priority.dart';
import '../data/models/task_entity.dart';
import '../data/models/task_status.dart';
import '../data/repositories/task_repository.dart';
import '../models/task.dart';

class TaskStats {
  final int totalTasks;
  final int completedTasks;

  const TaskStats({
    required this.totalTasks,
    required this.completedTasks,
  });
}

/// Temporary adapter between the UI's old [Task] model and the SQLite-backed
/// [TaskEntity]. UI/[TaskService] callers still speak [Task]; SQLite is the
/// real source of truth via [TaskRepository]. This class is a transitional
/// shim, not a permanent architecture — it should shrink/disappear once
/// screens are migrated to [TaskEntity] directly (later FAZ 1 step).
class TaskService {
  TaskService._internal();

  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;

  /// Test-only: inject a repository directly (e.g. an in-memory ffi DB)
  /// instead of going through the production [AppDatabase] singleton.
  @visibleForTesting
  TaskService.withRepository(TaskRepository repository)
      : _repository = repository;

  TaskRepository? _repository;

  Future<TaskRepository> _repo() async {
    return _repository ??= TaskRepository(await AppDatabase.instance.database);
  }

  Future<List<Task>> fetchPendingTasks() async {
    final repo = await _repo();
    final all = await repo.getAll();
    final pending = all
        .where((entity) => entity.status != TaskStatus.completed)
        .map(_toUiTask)
        .toList();
    pending.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return pending;
  }

  Future<List<Task>> fetchTasksForDate(DateTime date) async {
    final repo = await _repo();
    final all = await repo.getAll();
    final tasksForDay =
        all.map(_toUiTask).where((task) => _isSameDay(task.dueDate, date)).toList();
    tasksForDay.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return tasksForDay;
  }

  Future<List<Task>> fetchCompletedTasks() async {
    final repo = await _repo();
    final all = await repo.getAll();
    final completed = all
        .where((entity) => entity.status == TaskStatus.completed)
        .map(_toUiTask)
        .toList();
    completed.sort((a, b) {
      final aDate = a.completedAt ?? a.dueDate;
      final bDate = b.completedAt ?? b.dueDate;
      return bDate.compareTo(aDate);
    });
    return completed;
  }

  Future<TaskStats> fetchStats() async {
    final repo = await _repo();
    final all = await repo.getAll();
    final completedCount =
        all.where((entity) => entity.status == TaskStatus.completed).length;
    return TaskStats(
      totalTasks: all.length,
      completedTasks: completedCount,
    );
  }

  /// Creates a task with no goal link (`goalId = null`). This is a
  /// conscious product decision for this step: there is no goal selector in
  /// the UI yet, and we do not create a hidden default goal.
  Future<void> addTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required String priority,
  }) async {
    final repo = await _repo();
    await repo.create(
      title: title,
      description: description,
      scheduledAt: dueDate,
      priority: Priority.fromDb(priority),
    );
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    final repo = await _repo();
    final existing = await repo.getById(taskId);
    if (existing == null) return;

    final isCurrentlyCompleted = existing.status == TaskStatus.completed;
    final updated = existing.copyWith(
      status: isCurrentlyCompleted ? TaskStatus.pending : TaskStatus.completed,
      completedAt: isCurrentlyCompleted ? null : DateTime.now(),
      clearCompletedAt: isCurrentlyCompleted,
    );
    await repo.update(updated);
  }

  Future<void> deleteTask(String taskId) async {
    final repo = await _repo();
    await repo.delete(taskId);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// TaskStatus.completed -> isCompleted = true; both `pending` and
  /// `partiallyCompleted` -> isCompleted = false, since the current UI has
  /// no way to display partial completion yet. This loses the
  /// pending/partiallyCompleted distinction for display purposes only — the
  /// real status is preserved in SQLite, nothing is lost there.
  ///
  /// `scheduledAt` is nullable in TaskEntity but old Task.dueDate is
  /// required; every task created through this service always sets
  /// scheduledAt, so this only falls back to createdAt defensively for a
  /// theoretical row with no scheduledAt.
  Task _toUiTask(TaskEntity entity) {
    return Task(
      id: entity.id,
      title: entity.title,
      description: entity.description ?? '',
      dueDate: entity.scheduledAt ?? entity.createdAt,
      isCompleted: entity.status == TaskStatus.completed,
      priority: entity.priority.toDb(),
      createdAt: entity.createdAt,
      completedAt: entity.completedAt,
    );
  }
}

final taskService = TaskService();
