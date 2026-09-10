/// Goal lifecycle status, stored as TEXT in SQLite.
enum GoalStatus {
  active,
  completed,
  abandoned;

  String toDb() => name;

  static GoalStatus fromDb(String value) {
    return GoalStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => throw FormatException('Unknown GoalStatus value: $value'),
    );
  }
}
