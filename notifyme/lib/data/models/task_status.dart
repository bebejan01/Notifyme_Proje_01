/// Task lifecycle status, stored as TEXT in SQLite.
enum TaskStatus {
  pending,
  partiallyCompleted,
  completed;

  String toDb() => name;

  static TaskStatus fromDb(String value) {
    return TaskStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => throw FormatException('Unknown TaskStatus value: $value'),
    );
  }
}
