/// Shared priority level for Goal and Task, stored as TEXT in SQLite.
enum Priority {
  low,
  medium,
  high;

  String toDb() => name;

  /// Throws [FormatException] on an unknown value instead of silently
  /// defaulting, so a corrupt/unexpected DB row surfaces immediately.
  static Priority fromDb(String value) {
    return Priority.values.firstWhere(
      (p) => p.name == value,
      orElse: () => throw FormatException('Unknown Priority value: $value'),
    );
  }
}
