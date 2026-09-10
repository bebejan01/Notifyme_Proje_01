import 'package:flutter/foundation.dart';

import '../data/app_database.dart';
import '../data/models/goal.dart';
import '../data/models/goal_status.dart';
import '../data/models/priority.dart';
import '../data/repositories/goal_repository.dart';

/// Thin application-layer API over [GoalRepository]. No UI depends on this
/// yet (FAZ 1 step 4) — this class only orchestrates/filters/validates, it
/// does not re-implement any SQL/CRUD logic that already lives in the
/// repository.
class GoalService {
  GoalService._internal();

  static final GoalService _instance = GoalService._internal();
  factory GoalService() => _instance;

  /// Test-only: inject a repository directly (e.g. an in-memory ffi DB)
  /// instead of going through the production [AppDatabase] singleton.
  @visibleForTesting
  GoalService.withRepository(GoalRepository repository)
      : _repository = repository;

  GoalRepository? _repository;

  Future<GoalRepository> _repo() async {
    return _repository ??= GoalRepository(await AppDatabase.instance.database);
  }

  Future<List<Goal>> getAllGoals() async {
    final repo = await _repo();
    return repo.getAll();
  }

  Future<Goal?> getGoalById(String id) async {
    final repo = await _repo();
    return repo.getById(id);
  }

  Future<List<Goal>> getActiveGoals() async {
    final all = await getAllGoals();
    return all.where((goal) => goal.status == GoalStatus.active).toList();
  }

  Future<List<Goal>> getCompletedGoals() async {
    final all = await getAllGoals();
    return all.where((goal) => goal.status == GoalStatus.completed).toList();
  }

  Future<Goal> createGoal({
    required String title,
    String? description,
    String? category,
    Priority priority = Priority.medium,
    DateTime? deadline,
  }) async {
    _requireNonBlankTitle(title);
    final repo = await _repo();
    return repo.create(
      title: title,
      description: description,
      category: category,
      priority: priority,
      deadline: deadline,
    );
  }

  Future<void> updateGoal(Goal goal) async {
    _requireNonBlankTitle(goal.title);
    final repo = await _repo();
    await repo.update(goal);
  }

  /// Deletes the goal. Tasks linked to it are not touched here — the
  /// `ON DELETE SET NULL` foreign key in AppDatabase already nulls their
  /// `goal_id`; this service does not add cleanup logic on top of it.
  Future<void> deleteGoal(String id) async {
    final repo = await _repo();
    await repo.delete(id);
  }

  /// Rejects an empty or whitespace-only title with a clear exception
  /// instead of silently writing bad data. Does not trim/normalize the
  /// title otherwise — validation only, no implicit data transformation.
  void _requireNonBlankTitle(String title) {
    if (title.trim().isEmpty) {
      throw ArgumentError.value(
        title,
        'title',
        'Goal title must not be empty or whitespace-only',
      );
    }
  }
}

final goalService = GoalService();
