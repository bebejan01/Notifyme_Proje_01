import 'priority.dart';
import 'goal_status.dart';

class Goal {
  final String id;
  final String title;
  final String? description;
  final String? category;
  final Priority priority;
  final DateTime? deadline;
  final GoalStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Goal({
    required this.id,
    required this.title,
    this.description,
    this.category,
    required this.priority,
    this.deadline,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Goal copyWith({
    String? title,
    String? description,
    String? category,
    Priority? priority,
    DateTime? deadline,
    GoalStatus? status,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Goal.fromRow(Map<String, Object?> row) {
    return Goal(
      id: row['id'] as String,
      title: row['title'] as String,
      description: row['description'] as String?,
      category: row['category'] as String?,
      priority: Priority.fromDb(row['priority'] as String),
      deadline: row['deadline'] != null
          ? DateTime.parse(row['deadline'] as String)
          : null,
      status: GoalStatus.fromDb(row['status'] as String),
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  Map<String, Object?> toRow() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority.toDb(),
      'deadline': deadline?.toIso8601String(),
      'status': status.toDb(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
