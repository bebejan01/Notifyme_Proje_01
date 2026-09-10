import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../models/priority.dart';
import '../models/task_entity.dart';
import '../models/task_status.dart';

class TaskRepository {
  TaskRepository(this._db);

  final Database _db;
  static const _uuid = Uuid();

  Future<TaskEntity> create({
    String? goalId,
    required String title,
    String? description,
    DateTime? scheduledAt,
    int? plannedDuration,
    double? plannedAmount,
    String? unit,
    double? actualAmount,
    Priority priority = Priority.medium,
    TaskStatus status = TaskStatus.pending,
  }) async {
    final task = TaskEntity(
      id: _uuid.v4(),
      goalId: goalId,
      title: title,
      description: description,
      scheduledAt: scheduledAt,
      plannedDuration: plannedDuration,
      plannedAmount: plannedAmount,
      unit: unit,
      actualAmount: actualAmount,
      priority: priority,
      status: status,
      createdAt: DateTime.now(),
    );
    await _db.insert('tasks', task.toRow());
    return task;
  }

  Future<TaskEntity?> getById(String id) async {
    final rows = await _db.query('tasks', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return TaskEntity.fromRow(rows.first);
  }

  Future<List<TaskEntity>> getAll() async {
    final rows = await _db.query('tasks', orderBy: 'created_at DESC');
    return rows.map(TaskEntity.fromRow).toList();
  }

  Future<List<TaskEntity>> getByGoalId(String goalId) async {
    final rows = await _db.query(
      'tasks',
      where: 'goal_id = ?',
      whereArgs: [goalId],
      orderBy: 'created_at DESC',
    );
    return rows.map(TaskEntity.fromRow).toList();
  }

  Future<void> update(TaskEntity task) async {
    await _db.update(
      'tasks',
      task.toRow(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> delete(String id) async {
    await _db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
