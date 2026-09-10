import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../models/goal.dart';
import '../models/goal_status.dart';
import '../models/priority.dart';

class GoalRepository {
  GoalRepository(this._db);

  final Database _db;
  static const _uuid = Uuid();

  Future<Goal> create({
    required String title,
    String? description,
    String? category,
    Priority priority = Priority.medium,
    DateTime? deadline,
    GoalStatus status = GoalStatus.active,
  }) async {
    final now = DateTime.now();
    final goal = Goal(
      id: _uuid.v4(),
      title: title,
      description: description,
      category: category,
      priority: priority,
      deadline: deadline,
      status: status,
      createdAt: now,
      updatedAt: now,
    );
    await _db.insert('goals', goal.toRow());
    return goal;
  }

  Future<Goal?> getById(String id) async {
    final rows = await _db.query('goals', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Goal.fromRow(rows.first);
  }

  Future<List<Goal>> getAll() async {
    final rows = await _db.query('goals', orderBy: 'created_at DESC');
    return rows.map(Goal.fromRow).toList();
  }

  Future<void> update(Goal goal) async {
    final updated = goal.copyWith(updatedAt: DateTime.now());
    await _db.update(
      'goals',
      updated.toRow(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }

  /// Deletes the goal. Tasks pointing at it are not deleted — the
  /// `ON DELETE SET NULL` foreign key (set up in AppDatabase) nulls their
  /// `goal_id` instead, provided `PRAGMA foreign_keys = ON` is active on
  /// this connection.
  Future<void> delete(String id) async {
    await _db.delete('goals', where: 'id = ?', whereArgs: [id]);
  }
}
