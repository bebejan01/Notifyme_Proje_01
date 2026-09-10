import 'priority.dart';
import 'task_status.dart';

/// Persistence-layer task record backed by the `tasks` table.
///
/// Named `TaskEntity` (not `Task`) to avoid colliding with the existing
/// mock-facing `Task` in lib/models/task.dart, which `TaskService` and the
/// current screens still use unchanged in this step.
class TaskEntity {
  final String id;
  final String? goalId;
  final String title;
  final String? description;
  final DateTime? scheduledAt;
  final int? plannedDuration;
  final double? plannedAmount;
  final String? unit;
  final double? actualAmount;
  final Priority priority;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;

  const TaskEntity({
    required this.id,
    this.goalId,
    required this.title,
    this.description,
    this.scheduledAt,
    this.plannedDuration,
    this.plannedAmount,
    this.unit,
    this.actualAmount,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });

  TaskEntity copyWith({
    String? goalId,
    bool clearGoalId = false,
    String? title,
    String? description,
    DateTime? scheduledAt,
    int? plannedDuration,
    double? plannedAmount,
    String? unit,
    double? actualAmount,
    Priority? priority,
    TaskStatus? status,
    DateTime? completedAt,
    bool clearCompletedAt = false,
  }) {
    return TaskEntity(
      id: id,
      goalId: clearGoalId ? null : (goalId ?? this.goalId),
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      plannedDuration: plannedDuration ?? this.plannedDuration,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      unit: unit ?? this.unit,
      actualAmount: actualAmount ?? this.actualAmount,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt,
      completedAt: clearCompletedAt ? null : (completedAt ?? this.completedAt),
    );
  }

  factory TaskEntity.fromRow(Map<String, Object?> row) {
    return TaskEntity(
      id: row['id'] as String,
      goalId: row['goal_id'] as String?,
      title: row['title'] as String,
      description: row['description'] as String?,
      scheduledAt: row['scheduled_at'] != null
          ? DateTime.parse(row['scheduled_at'] as String)
          : null,
      plannedDuration: row['planned_duration'] as int?,
      plannedAmount: row['planned_amount'] as double?,
      unit: row['unit'] as String?,
      actualAmount: row['actual_amount'] as double?,
      priority: Priority.fromDb(row['priority'] as String),
      status: TaskStatus.fromDb(row['status'] as String),
      createdAt: DateTime.parse(row['created_at'] as String),
      completedAt: row['completed_at'] != null
          ? DateTime.parse(row['completed_at'] as String)
          : null,
    );
  }

  Map<String, Object?> toRow() {
    return {
      'id': id,
      'goal_id': goalId,
      'title': title,
      'description': description,
      'scheduled_at': scheduledAt?.toIso8601String(),
      'planned_duration': plannedDuration,
      'planned_amount': plannedAmount,
      'unit': unit,
      'actual_amount': actualAmount,
      'priority': priority.toDb(),
      'status': status.toDb(),
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }
}
